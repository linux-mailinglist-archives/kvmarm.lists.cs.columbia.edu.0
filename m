Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id CAD45462176
	for <lists+kvmarm@lfdr.de>; Mon, 29 Nov 2021 21:06:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7CF2B4B125;
	Mon, 29 Nov 2021 15:06:07 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, T_DKIM_INVALID=0.01]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Voa2mQM4uZfC; Mon, 29 Nov 2021 15:06:07 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 303874B129;
	Mon, 29 Nov 2021 15:06:04 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 426844083E
 for <kvmarm@lists.cs.columbia.edu>; Mon, 29 Nov 2021 15:06:03 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BeXly9ROe5TA for <kvmarm@lists.cs.columbia.edu>;
 Mon, 29 Nov 2021 15:06:02 -0500 (EST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 153074086D
 for <kvmarm@lists.cs.columbia.edu>; Mon, 29 Nov 2021 15:06:02 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 47093B815E9;
 Mon, 29 Nov 2021 20:06:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA29C53FAD;
 Mon, 29 Nov 2021 20:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638216361;
 bh=UTV2ggFVZ9pv6QLOOaB0bMKGFmSJDLhx2Wp4d28z1Mc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mwoPIrVDsqT1fAfQ9uRq5Zj6d+idcRpgMwWHcsx9AYoNWU8MgSv78OpMG4x8W1jWK
 o32kmYo710IKGgbWJMVPjzojycyQ6kUonoligWtHsVIrfDJgI6vDwGT4q4eWdVSpUK
 arzHhp6jblMtYs/BiKvL0q7UMv1f0OFd9U6BSP0vLCp8lOc1B3uWrgZW5X/oZePdhk
 va2iuxKkukp7szAXrdDwzvkB8MAuGBHCrRH/MjpVM6hdIK7fIl/qLtZ0ivoUh0kJAx
 0cGvK42NsuYtXvVx8+bJ0z5m3GXbmJXibb5oeD6SNKRmJvijpn++3QyUnxbpFlnHGS
 QPfBGUbX3k5kQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1mrmrC-008gvR-3E; Mon, 29 Nov 2021 20:02:35 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: [PATCH v5 55/69] KVM: arm64: nv: Implement maintenance interrupt
 forwarding
Date: Mon, 29 Nov 2021 20:01:36 +0000
Message-Id: <20211129200150.351436-56-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211129200150.351436-1-maz@kernel.org>
References: <20211129200150.351436-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, andre.przywara@arm.com,
 christoffer.dall@arm.com, jintack@cs.columbia.edu, haibo.xu@linaro.org,
 gankulkarni@os.amperecomputing.com, james.morse@arm.com,
 suzuki.poulose@arm.com, alexandru.elisei@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, Andre Przywara <andre.przywara@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
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

When we take a maintenance interrupt, we need to decide whether
it is generated on an action from the guest, or if it is something
that needs to be forwarded to the guest hypervisor.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kvm/vgic/vgic-init.c      | 30 ++++++++++++++++++++++++++++
 arch/arm64/kvm/vgic/vgic-v3-nested.c | 25 +++++++++++++++++++----
 2 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-init.c b/arch/arm64/kvm/vgic/vgic-init.c
index 0a06d0648970..1d49912af42d 100644
--- a/arch/arm64/kvm/vgic/vgic-init.c
+++ b/arch/arm64/kvm/vgic/vgic-init.c
@@ -6,10 +6,12 @@
 #include <linux/uaccess.h>
 #include <linux/interrupt.h>
 #include <linux/cpu.h>
+#include <linux/irq.h>
 #include <linux/kvm_host.h>
 #include <kvm/arm_vgic.h>
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_mmu.h>
+#include <asm/kvm_nested.h>
 #include "vgic.h"
 
 /*
@@ -221,6 +223,16 @@ int kvm_vgic_vcpu_init(struct kvm_vcpu *vcpu)
 	if (!irqchip_in_kernel(vcpu->kvm))
 		return 0;
 
+	if (nested_virt_in_use(vcpu)) {
+		/* FIXME: remove this hack */
+		if (vcpu->kvm->arch.vgic.maint_irq == 0)
+			vcpu->kvm->arch.vgic.maint_irq = kvm_vgic_global_state.maint_irq;
+		ret = kvm_vgic_set_owner(vcpu, vcpu->kvm->arch.vgic.maint_irq,
+					 vcpu);
+		if (ret)
+			return ret;
+	}
+
 	/*
 	 * If we are creating a VCPU with a GICv3 we must also register the
 	 * KVM io device for the redistributor that belongs to this VCPU.
@@ -473,12 +485,23 @@ static int vgic_init_cpu_dying(unsigned int cpu)
 
 static irqreturn_t vgic_maintenance_handler(int irq, void *data)
 {
+	struct kvm_vcpu *vcpu = *(struct kvm_vcpu **)data;
+
 	/*
 	 * We cannot rely on the vgic maintenance interrupt to be
 	 * delivered synchronously. This means we can only use it to
 	 * exit the VM, and we perform the handling of EOIed
 	 * interrupts on the exit path (see vgic_fold_lr_state).
 	 */
+
+	/* If not nested, deactivate */
+	if (!vcpu || !vgic_state_is_nested(vcpu)) {
+		irq_set_irqchip_state(irq, IRQCHIP_STATE_ACTIVE, false);
+		return IRQ_HANDLED;
+	}
+
+	/* Assume nested from now */
+	vgic_v3_handle_nested_maint_irq(vcpu);
 	return IRQ_HANDLED;
 }
 
@@ -577,6 +600,13 @@ int kvm_vgic_hyp_init(void)
 		return ret;
 	}
 
+	ret = irq_set_vcpu_affinity(kvm_vgic_global_state.maint_irq,
+				    kvm_get_running_vcpus());
+	if (ret) {
+		kvm_err("Error setting vcpu affinity\n");
+		goto out_free_irq;
+	}
+
 	ret = cpuhp_setup_state(CPUHP_AP_KVM_ARM_VGIC_INIT_STARTING,
 				"kvm/arm/vgic:starting",
 				vgic_init_cpu_starting, vgic_init_cpu_dying);
diff --git a/arch/arm64/kvm/vgic/vgic-v3-nested.c b/arch/arm64/kvm/vgic/vgic-v3-nested.c
index 3ee3438b5e22..4ba426e2324d 100644
--- a/arch/arm64/kvm/vgic/vgic-v3-nested.c
+++ b/arch/arm64/kvm/vgic/vgic-v3-nested.c
@@ -173,10 +173,20 @@ void vgic_v3_sync_nested(struct kvm_vcpu *vcpu)
 void vgic_v3_load_nested(struct kvm_vcpu *vcpu)
 {
 	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
+	struct vgic_irq *irq;
+	unsigned long flags;
 
 	vgic_cpu->shadow_vgic_v3 = vgic_cpu->nested_vgic_v3;
 	vgic_v3_create_shadow_lr(vcpu);
 	__vgic_v3_restore_state(vcpu_shadow_if(vcpu));
+
+	irq = vgic_get_irq(vcpu->kvm, vcpu, vcpu->kvm->arch.vgic.maint_irq);
+	raw_spin_lock_irqsave(&irq->irq_lock, flags);
+	if (irq->line_level || irq->active)
+		irq_set_irqchip_state(kvm_vgic_global_state.maint_irq,
+				      IRQCHIP_STATE_ACTIVE, true);
+	raw_spin_unlock_irqrestore(&irq->irq_lock, flags);
+	vgic_put_irq(vcpu->kvm, irq);
 }
 
 void vgic_v3_put_nested(struct kvm_vcpu *vcpu)
@@ -191,11 +201,14 @@ void vgic_v3_put_nested(struct kvm_vcpu *vcpu)
 	 */
 	vgic_v3_fixup_shadow_lr_state(vcpu);
 	vgic_cpu->nested_vgic_v3 = vgic_cpu->shadow_vgic_v3;
+	irq_set_irqchip_state(kvm_vgic_global_state.maint_irq,
+			      IRQCHIP_STATE_ACTIVE, false);
 }
 
 void vgic_v3_handle_nested_maint_irq(struct kvm_vcpu *vcpu)
 {
 	struct vgic_v3_cpu_if *cpu_if = vcpu_nested_if(vcpu);
+	bool state;
 
 	/*
 	 * If we exit a nested VM with a pending maintenance interrupt from the
@@ -203,8 +216,12 @@ void vgic_v3_handle_nested_maint_irq(struct kvm_vcpu *vcpu)
 	 * can re-sync the appropriate LRs and sample level triggered interrupts
 	 * again.
 	 */
-	if (vgic_state_is_nested(vcpu) &&
-	    (cpu_if->vgic_hcr & ICH_HCR_EN) &&
-	    vgic_v3_get_misr(vcpu))
-		kvm_inject_nested_irq(vcpu);
+	if (!vgic_state_is_nested(vcpu))
+		return;
+
+	state  = cpu_if->vgic_hcr & ICH_HCR_EN;
+	state &= vgic_v3_get_misr(vcpu);
+
+	kvm_vgic_inject_irq(vcpu->kvm, vcpu->vcpu_id,
+			    vcpu->kvm->arch.vgic.maint_irq, state, vcpu);
 }
-- 
2.30.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
