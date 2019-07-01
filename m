Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB5F3D346
	for <lists+kvmarm@lfdr.de>; Tue, 11 Jun 2019 19:03:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 28CF04A4D5;
	Tue, 11 Jun 2019 13:03:58 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R-TRYUYFhSVA; Tue, 11 Jun 2019 13:03:56 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B2E9F4A528;
	Tue, 11 Jun 2019 13:03:55 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EC7F54A51C
 for <kvmarm@lists.cs.columbia.edu>; Tue, 11 Jun 2019 13:03:53 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i0dLQGERE-Q5 for <kvmarm@lists.cs.columbia.edu>;
 Tue, 11 Jun 2019 13:03:53 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0F2A64A4D5
 for <kvmarm@lists.cs.columbia.edu>; Tue, 11 Jun 2019 13:03:53 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE236DA7;
 Tue, 11 Jun 2019 10:03:52 -0700 (PDT)
Received: from filthy-habits.cambridge.arm.com
 (filthy-habits.cambridge.arm.com [10.1.197.61])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4FB183F73C;
 Tue, 11 Jun 2019 10:03:51 -0700 (PDT)
From: Marc Zyngier <marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: [PATCH v2 3/9] KVM: arm/arm64: vgic-its: Add MSI-LPI translation
 cache invalidation
Date: Tue, 11 Jun 2019 18:03:30 +0100
Message-Id: <20190611170336.121706-4-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611170336.121706-1-marc.zyngier@arm.com>
References: <20190611170336.121706-1-marc.zyngier@arm.com>
MIME-Version: 1.0
Cc: "Raslan, KarimAllah" <karahmed@amazon.de>, "Saidi,
 Ali" <alisaidi@amazon.com>
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

There's a number of cases where we need to invalidate the caching
of translations, so let's add basic support for that.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/vgic/vgic-its.c | 23 +++++++++++++++++++++++
 virt/kvm/arm/vgic/vgic.h     |  1 +
 2 files changed, 24 insertions(+)

diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index ce9bcddeb7f1..9b6b66204b97 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -546,6 +546,29 @@ static unsigned long vgic_mmio_read_its_idregs(struct kvm *kvm,
 	return 0;
 }
 
+void vgic_its_invalidate_cache(struct kvm *kvm)
+{
+	struct vgic_dist *dist = &kvm->arch.vgic;
+	struct vgic_translation_cache_entry *cte;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&dist->lpi_list_lock, flags);
+
+	list_for_each_entry(cte, &dist->lpi_translation_cache, entry) {
+		/*
+		 * If we hit a NULL entry, there is nothing after this
+		 * point.
+		 */
+		if (!cte->irq)
+			break;
+
+		__vgic_put_lpi_locked(kvm, cte->irq);
+		cte->irq = NULL;
+	}
+
+	raw_spin_unlock_irqrestore(&dist->lpi_list_lock, flags);
+}
+
 int vgic_its_resolve_lpi(struct kvm *kvm, struct vgic_its *its,
 			 u32 devid, u32 eventid, struct vgic_irq **irq)
 {
diff --git a/virt/kvm/arm/vgic/vgic.h b/virt/kvm/arm/vgic/vgic.h
index afac2fed7df4..072f810dc441 100644
--- a/virt/kvm/arm/vgic/vgic.h
+++ b/virt/kvm/arm/vgic/vgic.h
@@ -319,6 +319,7 @@ int vgic_its_resolve_lpi(struct kvm *kvm, struct vgic_its *its,
 struct vgic_its *vgic_msi_to_its(struct kvm *kvm, struct kvm_msi *msi);
 void vgic_lpi_translation_cache_init(struct kvm *kvm);
 void vgic_lpi_translation_cache_destroy(struct kvm *kvm);
+void vgic_its_invalidate_cache(struct kvm *kvm);
 
 bool vgic_supports_direct_msis(struct kvm *kvm);
 int vgic_v4_init(struct kvm *kvm);
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
