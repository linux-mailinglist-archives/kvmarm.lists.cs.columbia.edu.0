Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF0C2E7E6F
	for <lists+kvmarm@lfdr.de>; Thu, 31 Dec 2020 07:28:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B28924B24D;
	Thu, 31 Dec 2020 01:28:58 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id abLxkx5tvpJg; Thu, 31 Dec 2020 01:28:58 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 75FFE4B282;
	Thu, 31 Dec 2020 01:28:57 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 71C314B24D
 for <kvmarm@lists.cs.columbia.edu>; Thu, 31 Dec 2020 01:28:56 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ExapXKOt-sGa for <kvmarm@lists.cs.columbia.edu>;
 Thu, 31 Dec 2020 01:28:54 -0500 (EST)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 024284B24B
 for <kvmarm@lists.cs.columbia.edu>; Thu, 31 Dec 2020 01:28:53 -0500 (EST)
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4D5yrK4GHWzkyWn;
 Thu, 31 Dec 2020 14:27:45 +0800 (CST)
Received: from DESKTOP-7FEPK9S.china.huawei.com (10.174.184.196) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Thu, 31 Dec 2020 14:28:38 +0800
From: Shenming Lu <lushenming@huawei.com>
To: Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, Eric Auger
 <eric.auger@redhat.com>, <linux-arm-kernel@lists.infradead.org>,
 <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>
Subject: [PATCH RFC] KVM: arm64: vgic: Decouple the check of the EnableLPIs
 bit from the ITS LPI translation
Date: Thu, 31 Dec 2020 14:28:13 +0800
Message-ID: <20201231062813.714-1-lushenming@huawei.com>
X-Mailer: git-send-email 2.27.0.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.174.184.196]
X-CFilter-Loop: Reflected
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

When the EnableLPIs bit is set to 0, any ITS LPI requests in the
Redistributor would be ignored. And this check is independent from
the ITS LPI translation. So it might be better to move the check
of the EnableLPIs bit out of the LPI resolving, and also add it
to the path that uses the translation cache. Besides it seems that
by this the invalidating of the translation cache caused by the LPI
disabling is unnecessary.

Not sure if I have missed something... Thanks.

Signed-off-by: Shenming Lu <lushenming@huawei.com>
---
 arch/arm64/kvm/vgic/vgic-its.c     | 9 +++++----
 arch/arm64/kvm/vgic/vgic-mmio-v3.c | 4 +---
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
index 40cbaca81333..f53446bc154e 100644
--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -683,9 +683,6 @@ int vgic_its_resolve_lpi(struct kvm *kvm, struct vgic_its *its,
 	if (!vcpu)
 		return E_ITS_INT_UNMAPPED_INTERRUPT;
 
-	if (!vcpu->arch.vgic_cpu.lpis_enabled)
-		return -EBUSY;
-
 	vgic_its_cache_translation(kvm, its, devid, eventid, ite->irq);
 
 	*irq = ite->irq;
@@ -738,6 +735,9 @@ static int vgic_its_trigger_msi(struct kvm *kvm, struct vgic_its *its,
 	if (err)
 		return err;
 
+	if (!irq->target_vcpu->arch.vgic_cpu.lpis_enabled)
+		return -EBUSY;
+
 	if (irq->hw)
 		return irq_set_irqchip_state(irq->host_irq,
 					     IRQCHIP_STATE_PENDING, true);
@@ -757,7 +757,8 @@ int vgic_its_inject_cached_translation(struct kvm *kvm, struct kvm_msi *msi)
 
 	db = (u64)msi->address_hi << 32 | msi->address_lo;
 	irq = vgic_its_check_cache(kvm, db, msi->devid, msi->data);
-	if (!irq)
+
+	if (!irq || !irq->target_vcpu->arch.vgic_cpu.lpis_enabled)
 		return -EWOULDBLOCK;
 
 	raw_spin_lock_irqsave(&irq->irq_lock, flags);
diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
index 15a6c98ee92f..7b0749f7660d 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
@@ -242,10 +242,8 @@ static void vgic_mmio_write_v3r_ctlr(struct kvm_vcpu *vcpu,
 
 	vgic_cpu->lpis_enabled = val & GICR_CTLR_ENABLE_LPIS;
 
-	if (was_enabled && !vgic_cpu->lpis_enabled) {
+	if (was_enabled && !vgic_cpu->lpis_enabled)
 		vgic_flush_pending_lpis(vcpu);
-		vgic_its_invalidate_cache(vcpu->kvm);
-	}
 
 	if (!was_enabled && vgic_cpu->lpis_enabled)
 		vgic_enable_lpis(vcpu);
-- 
2.19.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
