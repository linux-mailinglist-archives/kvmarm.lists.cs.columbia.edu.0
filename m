Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 24BFE752DA
	for <lists+kvmarm@lfdr.de>; Thu, 25 Jul 2019 17:36:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C76AC4A600;
	Thu, 25 Jul 2019 11:36:45 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0rd4K-FIsety; Thu, 25 Jul 2019 11:36:44 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8CDD44A5C8;
	Thu, 25 Jul 2019 11:36:44 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 89B434A5A5
 for <kvmarm@lists.cs.columbia.edu>; Thu, 25 Jul 2019 11:36:43 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qMjldyHpQRWM for <kvmarm@lists.cs.columbia.edu>;
 Thu, 25 Jul 2019 11:36:42 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 08AE54A5F7
 for <kvmarm@lists.cs.columbia.edu>; Thu, 25 Jul 2019 11:36:41 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BCD12168F;
 Thu, 25 Jul 2019 08:36:40 -0700 (PDT)
Received: from filthy-habits.cambridge.arm.com
 (filthy-habits.cambridge.arm.com [10.1.197.61])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 17A513F71A;
 Thu, 25 Jul 2019 08:36:38 -0700 (PDT)
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: [PATCH v3 08/10] KVM: arm/arm64: vgic-its: Cache successful MSI->LPI
 translation
Date: Thu, 25 Jul 2019 16:35:41 +0100
Message-Id: <20190725153543.24386-9-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190725153543.24386-1-maz@kernel.org>
References: <20190725153543.24386-1-maz@kernel.org>
MIME-Version: 1.0
Cc: Marc Zyngier <marc.zyngier@arm.com>,
 Andre Przywara <Andre.Przywara@arm.com>, "Raslan,
 KarimAllah" <karahmed@amazon.de>, "Saidi, Ali" <alisaidi@amazon.com>
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
List-Id: Where KVM/ARM decisions are made <kvmarm.lists.cs.columbia.edu>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

From: Marc Zyngier <marc.zyngier@arm.com>

On a successful translation, preserve the parameters in the LPI
translation cache. Each translation is reusing the last slot
in the list, naturally evicting the least recently used entry.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/vgic/vgic-its.c | 86 ++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index d3e90a9d0a7a..e61d3ea0ab40 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -535,6 +535,90 @@ static unsigned long vgic_mmio_read_its_idregs(struct kvm *kvm,
 	return 0;
 }
 
+static struct vgic_irq *__vgic_its_check_cache(struct vgic_dist *dist,
+					       phys_addr_t db,
+					       u32 devid, u32 eventid)
+{
+	struct vgic_translation_cache_entry *cte;
+
+	list_for_each_entry(cte, &dist->lpi_translation_cache, entry) {
+		/*
+		 * If we hit a NULL entry, there is nothing after this
+		 * point.
+		 */
+		if (!cte->irq)
+			break;
+
+		if (cte->db != db || cte->devid != devid ||
+		    cte->eventid != eventid)
+			continue;
+
+		/*
+		 * Move this entry to the head, as it is the most
+		 * recently used.
+		 */
+		if (!list_is_first(&cte->entry, &dist->lpi_translation_cache))
+			list_move(&cte->entry, &dist->lpi_translation_cache);
+
+		return cte->irq;
+	}
+
+	return NULL;
+}
+
+static void vgic_its_cache_translation(struct kvm *kvm, struct vgic_its *its,
+				       u32 devid, u32 eventid,
+				       struct vgic_irq *irq)
+{
+	struct vgic_dist *dist = &kvm->arch.vgic;
+	struct vgic_translation_cache_entry *cte;
+	unsigned long flags;
+	phys_addr_t db;
+
+	/* Do not cache a directly injected interrupt */
+	if (irq->hw)
+		return;
+
+	raw_spin_lock_irqsave(&dist->lpi_list_lock, flags);
+
+	if (unlikely(list_empty(&dist->lpi_translation_cache)))
+		goto out;
+
+	/*
+	 * We could have raced with another CPU caching the same
+	 * translation behind our back, so let's check it is not in
+	 * already
+	 */
+	db = its->vgic_its_base + GITS_TRANSLATER;
+	if (__vgic_its_check_cache(dist, db, devid, eventid))
+		goto out;
+
+	/* Always reuse the last entry (LRU policy) */
+	cte = list_last_entry(&dist->lpi_translation_cache,
+			      typeof(*cte), entry);
+
+	/*
+	 * Caching the translation implies having an extra reference
+	 * to the interrupt, so drop the potential reference on what
+	 * was in the cache, and increment it on the new interrupt.
+	 */
+	if (cte->irq)
+		__vgic_put_lpi_locked(kvm, cte->irq);
+
+	vgic_get_irq_kref(irq);
+
+	cte->db		= db;
+	cte->devid	= devid;
+	cte->eventid	= eventid;
+	cte->irq	= irq;
+
+	/* Move the new translation to the head of the list */
+	list_move(&cte->entry, &dist->lpi_translation_cache);
+
+out:
+	raw_spin_unlock_irqrestore(&dist->lpi_list_lock, flags);
+}
+
 void vgic_its_invalidate_cache(struct kvm *kvm)
 {
 	struct vgic_dist *dist = &kvm->arch.vgic;
@@ -578,6 +662,8 @@ int vgic_its_resolve_lpi(struct kvm *kvm, struct vgic_its *its,
 	if (!vcpu->arch.vgic_cpu.lpis_enabled)
 		return -EBUSY;
 
+	vgic_its_cache_translation(kvm, its, devid, eventid, ite->irq);
+
 	*irq = ite->irq;
 	return 0;
 }
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
