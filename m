Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 945ED53FFC3
	for <lists+kvmarm@lfdr.de>; Tue,  7 Jun 2022 15:14:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A71CE4B30A;
	Tue,  7 Jun 2022 09:14:39 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f24I2qb3l28o; Tue,  7 Jun 2022 09:14:37 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 29B9F4B32E;
	Tue,  7 Jun 2022 09:14:37 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 02A244B334
 for <kvmarm@lists.cs.columbia.edu>; Tue,  7 Jun 2022 09:14:36 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KNsEc8BQIZ8L for <kvmarm@lists.cs.columbia.edu>;
 Tue,  7 Jun 2022 09:14:34 -0400 (EDT)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 916E64B30A
 for <kvmarm@lists.cs.columbia.edu>; Tue,  7 Jun 2022 09:14:34 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id F38ED613F5;
 Tue,  7 Jun 2022 13:14:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64881C34119;
 Tue,  7 Jun 2022 13:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1654607673;
 bh=TTE/lFsUWXZm8bsrdr8eA3j90NFk9vlsa4mEv7DpU/s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=L6rGwJJgLu7ndf2E6JWX/VpfexTtFr68njiTklItKMx+7VMwfEj+AXIRCJ7Y3IDGf
 Y8G2IVIgv0fIogwruxjgoLZrqXuRs7KDMNxF4BVg695UN+WsvOVAse5HQlxr6xTjv8
 BdsTOfaEj0l/ekRsWlGbfEXBnjqAT4WZYCh8phjROvp7LUtaVOjpA6dkt3lOVdA7qf
 M/R6S2Ml6ouBx90Jbot4dKfftLr77ZZwPSWUzXah+tmcEt1HJRZm1nFSIhQQqE4tB6
 nBMh0VhUL9AHkys9g2HUjwSy2zmToWFNGXj6I5H++odXD0H0JQDntkeMmmJa21ZHhF
 12uH4f5pG8Zkg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1nyZ2V-00GBUI-3N; Tue, 07 Jun 2022 14:14:31 +0100
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 kvm@vger.kernel.org
Subject: [PATCH v2 2/3] KVM: arm64: Replace vgic_v3_uaccess_read_pending with
 vgic_uaccess_read_pending
Date: Tue,  7 Jun 2022 14:14:26 +0100
Message-Id: <20220607131427.1164881-3-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220607131427.1164881-1-maz@kernel.org>
References: <20220607131427.1164881-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
 eric.auger@redhat.com, ricarkol@google.com, james.morse@arm.com,
 suzuki.poulose@arm.com, alexandru.elisei@arm.com, oupton@google.com,
 kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com
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

Now that GICv2 has a proper userspace accessor for the pending state,
switch GICv3 over to it, dropping the local version, moving over the
specific behaviours that CGIv3 requires (such as the distinction
between pending latch and line level which were never enforced
with GICv2).

We also gain extra locking that isn't really necessary for userspace,
but that's a small price to pay for getting rid of superfluous code.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kvm/vgic/vgic-mmio-v3.c | 40 ++----------------------------
 arch/arm64/kvm/vgic/vgic-mmio.c    | 21 +++++++++++++++-
 2 files changed, 22 insertions(+), 39 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
index f7aa7bcd6fb8..f15e29cc63ce 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
@@ -353,42 +353,6 @@ static unsigned long vgic_mmio_read_v3_idregs(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
-static unsigned long vgic_v3_uaccess_read_pending(struct kvm_vcpu *vcpu,
-						  gpa_t addr, unsigned int len)
-{
-	u32 intid = VGIC_ADDR_TO_INTID(addr, 1);
-	u32 value = 0;
-	int i;
-
-	/*
-	 * pending state of interrupt is latched in pending_latch variable.
-	 * Userspace will save and restore pending state and line_level
-	 * separately.
-	 * Refer to Documentation/virt/kvm/devices/arm-vgic-v3.rst
-	 * for handling of ISPENDR and ICPENDR.
-	 */
-	for (i = 0; i < len * 8; i++) {
-		struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, vcpu, intid + i);
-		bool state = irq->pending_latch;
-
-		if (irq->hw && vgic_irq_is_sgi(irq->intid)) {
-			int err;
-
-			err = irq_get_irqchip_state(irq->host_irq,
-						    IRQCHIP_STATE_PENDING,
-						    &state);
-			WARN_ON(err);
-		}
-
-		if (state)
-			value |= (1U << i);
-
-		vgic_put_irq(vcpu->kvm, irq);
-	}
-
-	return value;
-}
-
 static int vgic_v3_uaccess_write_pending(struct kvm_vcpu *vcpu,
 					 gpa_t addr, unsigned int len,
 					 unsigned long val)
@@ -666,7 +630,7 @@ static const struct vgic_register_region vgic_v3_dist_registers[] = {
 		VGIC_ACCESS_32bit),
 	REGISTER_DESC_WITH_BITS_PER_IRQ_SHARED(GICD_ISPENDR,
 		vgic_mmio_read_pending, vgic_mmio_write_spending,
-		vgic_v3_uaccess_read_pending, vgic_v3_uaccess_write_pending, 1,
+		vgic_uaccess_read_pending, vgic_v3_uaccess_write_pending, 1,
 		VGIC_ACCESS_32bit),
 	REGISTER_DESC_WITH_BITS_PER_IRQ_SHARED(GICD_ICPENDR,
 		vgic_mmio_read_pending, vgic_mmio_write_cpending,
@@ -750,7 +714,7 @@ static const struct vgic_register_region vgic_v3_rd_registers[] = {
 		VGIC_ACCESS_32bit),
 	REGISTER_DESC_WITH_LENGTH_UACCESS(SZ_64K + GICR_ISPENDR0,
 		vgic_mmio_read_pending, vgic_mmio_write_spending,
-		vgic_v3_uaccess_read_pending, vgic_v3_uaccess_write_pending, 4,
+		vgic_uaccess_read_pending, vgic_v3_uaccess_write_pending, 4,
 		VGIC_ACCESS_32bit),
 	REGISTER_DESC_WITH_LENGTH_UACCESS(SZ_64K + GICR_ICPENDR0,
 		vgic_mmio_read_pending, vgic_mmio_write_cpending,
diff --git a/arch/arm64/kvm/vgic/vgic-mmio.c b/arch/arm64/kvm/vgic/vgic-mmio.c
index dc8c52487e47..997d0fce2088 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio.c
@@ -240,6 +240,15 @@ static unsigned long __read_pending(struct kvm_vcpu *vcpu,
 		unsigned long flags;
 		bool val;
 
+		/*
+		 * When used from userspace with a GICv3 model:
+		 *
+		 * Pending state of interrupt is latched in pending_latch
+		 * variable.  Userspace will save and restore pending state
+		 * and line_level separately.
+		 * Refer to Documentation/virt/kvm/devices/arm-vgic-v3.rst
+		 * for handling of ISPENDR and ICPENDR.
+		 */
 		raw_spin_lock_irqsave(&irq->irq_lock, flags);
 		if (irq->hw && vgic_irq_is_sgi(irq->intid)) {
 			int err;
@@ -252,7 +261,17 @@ static unsigned long __read_pending(struct kvm_vcpu *vcpu,
 		} else if (!is_user && vgic_irq_is_mapped_level(irq)) {
 			val = vgic_get_phys_line_level(irq);
 		} else {
-			val = irq_is_pending(irq);
+			switch (vcpu->kvm->arch.vgic.vgic_model) {
+			case KVM_DEV_TYPE_ARM_VGIC_V3:
+				if (is_user) {
+					val = irq->pending_latch;
+					break;
+				}
+				fallthrough;
+			default:
+				val = irq_is_pending(irq);
+				break;
+			}
 		}
 
 		value |= ((u32)val << i);
-- 
2.34.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
