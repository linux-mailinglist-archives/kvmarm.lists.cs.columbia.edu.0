Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB72605AE2
	for <lists+kvmarm@lfdr.de>; Thu, 20 Oct 2022 11:16:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2CD754B952;
	Thu, 20 Oct 2022 05:16:40 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -6.789
X-Spam-Level: 
X-Spam-Status: No, score=-6.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, RCVD_IN_DNSWL_HI=-5, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YoBruOhD1sDs; Thu, 20 Oct 2022 05:16:40 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 909534B954;
	Thu, 20 Oct 2022 05:16:38 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 233E04B947
 for <kvmarm@lists.cs.columbia.edu>; Thu, 20 Oct 2022 05:16:37 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bgxQXdn-NwFj for <kvmarm@lists.cs.columbia.edu>;
 Thu, 20 Oct 2022 05:16:35 -0400 (EDT)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A72CA4B946
 for <kvmarm@lists.cs.columbia.edu>; Thu, 20 Oct 2022 05:16:35 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2A02661A77;
 Thu, 20 Oct 2022 09:16:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68BE6C433C1;
 Thu, 20 Oct 2022 09:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1666257394;
 bh=/X0JwYqFfNxkcVX6Op/r2SfFpx7oqrgtB2Jr2e6KEAU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AqVAFO/3NkcAzu7W2+7a4aWtJgjfD9GQiKl9bvFpFl7lMSlhC2Pnowp6DVJMqmNb2
 nzWPx5g4/bl2GxL3Wp75sJSexN2Bn14q8PrOy7T/SrXp19ppPWZ1g1GgG+YrQJH3Iw
 PHXXx19LdzZ8h0BP4Pl0IXn9gTyVoDeN56XQ7o7c5J8FOa91AyTrITlVF0SBbWgj4i
 24tVNPTzUfR6JdEIWB6tussBE8jYyGREmwqLuUxfjrK9SaJ2/M2CCGjQjWhJ7eIJgY
 9lN9CDlH/jNUgHI3toicHeY/Lg4ZxtChE2YI3QUehF072kFqPw1yorZgo9M5GjyBRJ
 dsBXUVN5Qw0Ow==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <maz@kernel.org>) id 1olRWc-000Buf-SS;
 Thu, 20 Oct 2022 10:07:38 +0100
From: Marc Zyngier <maz@kernel.org>
To: <kvmarm@lists.cs.columbia.edu>, <kvmarm@lists.linux.dev>,
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 17/17] KVM: arm64: Terrible timer hack for M1 with hVHE
Date: Thu, 20 Oct 2022 10:07:27 +0100
Message-Id: <20221020090727.3669908-18-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221020090727.3669908-1-maz@kernel.org>
References: <20221020090727.3669908-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, kvmarm@lists.linux.dev,
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, james.morse@arm.com,
 suzuki.poulose@arm.com, alexandru.elisei@arm.com, oliver.upton@linux.dev,
 qperret@google.com, will@kernel.org, tabba@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Will Deacon <will@kernel.org>
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

As our M1 friend doesn't have a GIC, it relies on a special hack
to deal with masking the guest timers, in the form of an IMPDEF
system register.

Unfortunately, this sysreg is EL2-only, which means that the kernel
cannot mask the interrupts itself, but has to kindly ask EL2 to do
it. Yes, this is terrible, but we should be used to it by now.

Add a M1-specific hypercall to deal with this. No, I'm not seriously
suggesting we merge this crap.

Not-seriously-suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/arch_timer.h |  8 +++++
 arch/arm64/include/asm/kvm_asm.h    |  1 +
 arch/arm64/kernel/image-vars.h      |  3 ++
 arch/arm64/kvm/arch_timer.c         |  5 +++
 arch/arm64/kvm/hyp/nvhe/hyp-main.c  | 11 +++++++
 arch/arm64/kvm/hyp/nvhe/timer-sr.c  |  9 ++++++
 drivers/irqchip/irq-apple-aic.c     | 50 +++++++++++++++++++++++++++--
 7 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
index af1fafbe7e1d..3817e923f52c 100644
--- a/arch/arm64/include/asm/arch_timer.h
+++ b/arch/arm64/include/asm/arch_timer.h
@@ -232,4 +232,12 @@ static inline bool arch_timer_have_evtstrm_feature(void)
 {
 	return cpu_have_named_feature(EVTSTRM);
 }
+
+#ifdef CONFIG_APPLE_AIC
+#define SYS_IMP_APL_VM_TMR_FIQ_ENA_EL2	sys_reg(3, 5, 15, 1, 3)
+DECLARE_STATIC_KEY_FALSE(aic_impdef_timer_control);
+#endif
+
+void __aic_timer_fiq_clear_set(u64 clear, u64 set);
+
 #endif
diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 53035763e48e..d8855749920a 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -75,6 +75,7 @@ enum __kvm_host_smccc_func {
 	__KVM_HOST_SMCCC_FUNC___vgic_v3_write_vmcr,
 	__KVM_HOST_SMCCC_FUNC___vgic_v3_save_aprs,
 	__KVM_HOST_SMCCC_FUNC___vgic_v3_restore_aprs,
+	__KVM_HOST_SMCCC_FUNC___aic_timer_fiq_clear_set,
 	__KVM_HOST_SMCCC_FUNC___pkvm_vcpu_init_traps,
 };
 
diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index 8151412653de..11a2c0cd12cf 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -130,6 +130,9 @@ KVM_NVHE_ALIAS(__hyp_rodata_end);
 /* pKVM static key */
 KVM_NVHE_ALIAS(kvm_protected_mode_initialized);
 
+/* Hack for M1 timer control in hVHE mode */
+KVM_NVHE_ALIAS(aic_impdef_timer_control);
+
 #endif /* CONFIG_KVM */
 
 #endif /* __ARM64_KERNEL_IMAGE_VARS_H */
diff --git a/arch/arm64/kvm/arch_timer.c b/arch/arm64/kvm/arch_timer.c
index bb24a76b4224..b22a08597f2e 100644
--- a/arch/arm64/kvm/arch_timer.c
+++ b/arch/arm64/kvm/arch_timer.c
@@ -998,6 +998,11 @@ static int timer_irq_set_vcpu_affinity(struct irq_data *d, void *vcpu)
 	return 0;
 }
 
+void __aic_timer_fiq_clear_set(u64 clear, u64 set)
+{
+	kvm_call_hyp_nvhe(__aic_timer_fiq_clear_set, clear, set);
+}
+
 static int timer_irq_set_irqchip_state(struct irq_data *d,
 				       enum irqchip_irq_state which, bool val)
 {
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 14695e29a2be..8149635e5bc9 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -116,6 +116,16 @@ static void handle___vgic_v3_restore_aprs(struct kvm_cpu_context *host_ctxt)
 	__vgic_v3_restore_aprs(kern_hyp_va(cpu_if));
 }
 
+#define SYS_IMP_APL_VM_TMR_FIQ_ENA_EL2	sys_reg(3, 5, 15, 1, 3)
+
+static void handle___aic_timer_fiq_clear_set(struct kvm_cpu_context *host_ctxt)
+{
+	DECLARE_REG(u64, clear, host_ctxt, 1);
+	DECLARE_REG(u64, set, host_ctxt, 2);
+
+	__aic_timer_fiq_clear_set(clear, set);
+}
+
 static void handle___pkvm_init(struct kvm_cpu_context *host_ctxt)
 {
 	DECLARE_REG(phys_addr_t, phys, host_ctxt, 1);
@@ -219,6 +229,7 @@ static const hcall_t host_hcall[] = {
 	HANDLE_FUNC(__vgic_v3_write_vmcr),
 	HANDLE_FUNC(__vgic_v3_save_aprs),
 	HANDLE_FUNC(__vgic_v3_restore_aprs),
+	HANDLE_FUNC(__aic_timer_fiq_clear_set),
 	HANDLE_FUNC(__pkvm_vcpu_init_traps),
 };
 
diff --git a/arch/arm64/kvm/hyp/nvhe/timer-sr.c b/arch/arm64/kvm/hyp/nvhe/timer-sr.c
index 143cdc1d107f..a0266391e1b3 100644
--- a/arch/arm64/kvm/hyp/nvhe/timer-sr.c
+++ b/arch/arm64/kvm/hyp/nvhe/timer-sr.c
@@ -52,3 +52,12 @@ void __timer_enable_traps(struct kvm_vcpu *vcpu)
 	val |= CNTHCTL_EL1PCTEN << shift;
 	write_sysreg(val, cnthctl_el2);
 }
+
+
+void __aic_timer_fiq_clear_set(u64 clear, u64 set)
+{
+#ifdef CONFIG_APPLE_AIC
+	if (has_hvhe() && static_branch_likely(&aic_impdef_timer_control))
+		sysreg_clear_set_s(SYS_IMP_APL_VM_TMR_FIQ_ENA_EL2, clear, set);
+#endif
+}
diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index 1c2813ad8bbe..4e0442bedb2e 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -180,7 +180,6 @@
 #define IPI_SR_PENDING			BIT(0)
 
 /* Guest timer FIQ enable register */
-#define SYS_IMP_APL_VM_TMR_FIQ_ENA_EL2	sys_reg(3, 5, 15, 1, 3)
 #define VM_TMR_FIQ_ENABLE_V		BIT(0)
 #define VM_TMR_FIQ_ENABLE_P		BIT(1)
 
@@ -230,6 +229,8 @@
 
 static DEFINE_STATIC_KEY_TRUE(use_fast_ipi);
 
+DEFINE_STATIC_KEY_FALSE(aic_impdef_timer_control);
+
 struct aic_info {
 	int version;
 
@@ -450,6 +451,40 @@ static unsigned long aic_fiq_get_idx(struct irq_data *d)
 	return AIC_HWIRQ_IRQ(irqd_to_hwirq(d));
 }
 
+void __weak __aic_timer_fiq_clear_set(u64 clear, u64 set) { }
+
+static bool aic_check_timer_enabled(int timer)
+{
+	if (IS_ENABLED(CONFIG_KVM) &&
+	    static_branch_unlikely(&aic_impdef_timer_control))
+		return __this_cpu_read(aic_fiq_unmasked) & BIT(timer);
+	return true;
+}
+
+static void aic_hvhe_timer_mask(int timer, bool mask)
+{
+	u64 clr, set, bit;
+
+	if (!(IS_ENABLED(CONFIG_KVM) &&
+	      static_branch_unlikely(&aic_impdef_timer_control)))
+		return;
+
+	if (timer == AIC_TMR_EL0_VIRT)
+		bit = VM_TMR_FIQ_ENABLE_V;
+	else
+	        bit = VM_TMR_FIQ_ENABLE_P;
+
+	if (mask) {
+		clr = bit;
+		set = 0;
+	} else {
+		clr = 0;
+		set = bit;
+	}
+
+	__aic_timer_fiq_clear_set(clr, set);
+}
+
 static void aic_fiq_set_mask(struct irq_data *d)
 {
 	/* Only the guest timers have real mask bits, unfortunately. */
@@ -462,6 +497,9 @@ static void aic_fiq_set_mask(struct irq_data *d)
 		sysreg_clear_set_s(SYS_IMP_APL_VM_TMR_FIQ_ENA_EL2, VM_TMR_FIQ_ENABLE_V, 0);
 		isb();
 		break;
+	case AIC_TMR_EL0_VIRT:
+		aic_hvhe_timer_mask(AIC_TMR_EL0_VIRT, true);
+		break;
 	default:
 		break;
 	}
@@ -478,6 +516,9 @@ static void aic_fiq_clear_mask(struct irq_data *d)
 		sysreg_clear_set_s(SYS_IMP_APL_VM_TMR_FIQ_ENA_EL2, 0, VM_TMR_FIQ_ENABLE_V);
 		isb();
 		break;
+	case AIC_TMR_EL0_VIRT:
+		aic_hvhe_timer_mask(AIC_TMR_EL0_VIRT, false);
+		break;
 	default:
 		break;
 	}
@@ -537,7 +578,8 @@ static void __exception_irq_entry aic_handle_fiq(struct pt_regs *regs)
 		generic_handle_domain_irq(aic_irqc->hw_domain,
 					  AIC_FIQ_HWIRQ(AIC_TMR_EL0_PHYS));
 
-	if (TIMER_FIRING(read_sysreg(cntv_ctl_el0)))
+	if (TIMER_FIRING(read_sysreg(cntv_ctl_el0)) &&
+	    aic_check_timer_enabled(AIC_TMR_EL0_VIRT))
 		generic_handle_domain_irq(aic_irqc->hw_domain,
 					  AIC_FIQ_HWIRQ(AIC_TMR_EL0_VIRT));
 
@@ -1174,6 +1216,10 @@ static int __init aic_of_ic_init(struct device_node *node, struct device_node *p
 	if (static_branch_likely(&use_fast_ipi))
 		pr_info("Using Fast IPIs");
 
+	/* Caps are not final at this stage :-/ */
+	if (cpus_have_cap(ARM64_KVM_HVHE))
+		static_branch_enable(&aic_impdef_timer_control);
+
 	cpuhp_setup_state(CPUHP_AP_IRQ_APPLE_AIC_STARTING,
 			  "irqchip/apple-aic/ipi:starting",
 			  aic_init_cpu, NULL);
-- 
2.34.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
