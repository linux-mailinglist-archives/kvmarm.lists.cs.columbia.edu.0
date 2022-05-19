Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 66CB952D485
	for <lists+kvmarm@lfdr.de>; Thu, 19 May 2022 15:46:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 120544B424;
	Thu, 19 May 2022 09:46:00 -0400 (EDT)
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
	with ESMTP id ghLdrc9B3BNF; Thu, 19 May 2022 09:45:57 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CA3AF4B43B;
	Thu, 19 May 2022 09:45:57 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5633E4B3CF
 for <kvmarm@lists.cs.columbia.edu>; Thu, 19 May 2022 09:45:56 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 94U29umNXcPv for <kvmarm@lists.cs.columbia.edu>;
 Thu, 19 May 2022 09:45:55 -0400 (EDT)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id CE4124B435
 for <kvmarm@lists.cs.columbia.edu>; Thu, 19 May 2022 09:45:53 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id D9279B824B0;
 Thu, 19 May 2022 13:45:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D25CC385AA;
 Thu, 19 May 2022 13:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652967951;
 bh=pov3q8IKhuOU79Xlh7AlW/TDQ/gM9bi5cB3v51OWCjo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AATwCPGiq1+J+rPiG6A7FyES69L0Ej4YLtExIOfyyqWCFke9ZmgeLiev8tm3YwoI8
 l8QSalTMPcjKZSTSp9f2ZgCWM5iUtc9/C3O9DnzE3wrCve4BUgzRTd92BWjgXFjDA8
 cL+zk73rTFBvLL6IADHjeaXWCxyieXq6r0qckPvuqyj3XhSkbJd6/uA77y65tqY2eT
 Y/vWBxUkKj+u4PoJvH2nbFeGU4s+kmxvD7WGG5r0jkLl6eatzxe+g1qcmRhyd/oSkW
 ChlRMt8W+yUDa1manDXJ5jcFsVJFn5eEu8aXII4DyvV3Jiouy5JSUnZBDrSTiC+VBV
 5uOVqxDHUxixw==
From: Will Deacon <will@kernel.org>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH 52/89] KVM: arm64: Introduce lazy-ish state sync for
 non-protected VMs
Date: Thu, 19 May 2022 14:41:27 +0100
Message-Id: <20220519134204.5379-53-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220519134204.5379-1-will@kernel.org>
References: <20220519134204.5379-1-will@kernel.org>
MIME-Version: 1.0
Cc: Marc Zyngier <maz@kernel.org>, kernel-team@android.com, kvm@vger.kernel.org,
 Andy Lutomirski <luto@amacapital.net>, linux-arm-kernel@lists.infradead.org,
 Michael Roth <michael.roth@amd.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Chao Peng <chao.p.peng@linux.intel.com>, Will Deacon <will@kernel.org>
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

From: Marc Zyngier <maz@kernel.org>

Rather than blindly copying the register state between the shadow and
host vCPU structures, abstract this code into some helpers which are
called only for non-protected VMs running under pKVM. To faciliate
host accesses to guest registers within a get/put sequence, introduce a
new 'sync_state' hypercall to provide access to the registers of a
non-protected VM when handling traps.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/kvm_asm.h   |  1 +
 arch/arm64/include/asm/kvm_host.h  |  1 +
 arch/arm64/kvm/arm.c               |  7 ++++
 arch/arm64/kvm/handle_exit.c       | 22 ++++++++++
 arch/arm64/kvm/hyp/nvhe/hyp-main.c | 65 +++++++++++++++++++++++++++++-
 5 files changed, 95 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 07ee95d0f97d..ea3b3a60bedb 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -80,6 +80,7 @@ enum __kvm_host_smccc_func {
 	__KVM_HOST_SMCCC_FUNC___pkvm_teardown_shadow,
 	__KVM_HOST_SMCCC_FUNC___pkvm_vcpu_load,
 	__KVM_HOST_SMCCC_FUNC___pkvm_vcpu_put,
+	__KVM_HOST_SMCCC_FUNC___pkvm_vcpu_sync_state,
 };
 
 #define DECLARE_KVM_VHE_SYM(sym)	extern char sym[]
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 066eb7234bdd..160cbf973bcb 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -512,6 +512,7 @@ struct kvm_vcpu_arch {
 #define KVM_ARM64_DEBUG_STATE_SAVE_TRBE	(1 << 13) /* Save TRBE context if active  */
 #define KVM_ARM64_FP_FOREIGN_FPSTATE	(1 << 14)
 #define KVM_ARM64_ON_UNSUPPORTED_CPU	(1 << 15) /* Physical CPU not in supported_cpus */
+#define KVM_ARM64_PKVM_STATE_DIRTY	(1 << 16)
 
 #define KVM_GUESTDBG_VALID_MASK (KVM_GUESTDBG_ENABLE | \
 				 KVM_GUESTDBG_USE_SW_BP | \
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 3bb379f15c07..7c57c14e173a 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -448,6 +448,10 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 		kvm_call_hyp(__vgic_v3_save_vmcr_aprs,
 			     &vcpu->arch.vgic_cpu.vgic_v3);
 		kvm_call_hyp_nvhe(__pkvm_vcpu_put);
+
+		/* __pkvm_vcpu_put implies a sync of the state */
+		if (!kvm_vm_is_protected(vcpu->kvm))
+			vcpu->arch.flags |= KVM_ARM64_PKVM_STATE_DIRTY;
 	}
 
 	kvm_arch_vcpu_put_debug_state_flags(vcpu);
@@ -575,6 +579,9 @@ int kvm_arch_vcpu_run_pid_change(struct kvm_vcpu *vcpu)
 		return ret;
 
 	if (is_protected_kvm_enabled()) {
+		/* Start with the vcpu in a dirty state */
+		if (!kvm_vm_is_protected(vcpu->kvm))
+			vcpu->arch.flags |= KVM_ARM64_PKVM_STATE_DIRTY;
 		ret = kvm_shadow_create(kvm);
 		if (ret)
 			return ret;
diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index 97fe14aab1a3..9334c4a64007 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -203,6 +203,21 @@ static int handle_trap_exceptions(struct kvm_vcpu *vcpu)
 {
 	int handled;
 
+	/*
+	 * If we run a non-protected VM when protection is enabled
+	 * system-wide, resync the state from the hypervisor and mark
+	 * it as dirty on the host side if it wasn't dirty already
+	 * (which could happen if preemption has taken place).
+	 */
+	if (is_protected_kvm_enabled() && !kvm_vm_is_protected(vcpu->kvm)) {
+		preempt_disable();
+		if (!(vcpu->arch.flags & KVM_ARM64_PKVM_STATE_DIRTY)) {
+			kvm_call_hyp_nvhe(__pkvm_vcpu_sync_state);
+			vcpu->arch.flags |= KVM_ARM64_PKVM_STATE_DIRTY;
+		}
+		preempt_enable();
+	}
+
 	/*
 	 * See ARM ARM B1.14.1: "Hyp traps on instructions
 	 * that fail their condition code check"
@@ -270,6 +285,13 @@ int handle_exit(struct kvm_vcpu *vcpu, int exception_index)
 /* For exit types that need handling before we can be preempted */
 void handle_exit_early(struct kvm_vcpu *vcpu, int exception_index)
 {
+	/*
+	 * We just exited, so the state is clean from a hypervisor
+	 * perspective.
+	 */
+	if (is_protected_kvm_enabled())
+		vcpu->arch.flags &= ~KVM_ARM64_PKVM_STATE_DIRTY;
+
 	if (ARM_SERROR_PENDING(exception_index)) {
 		if (this_cpu_has_cap(ARM64_HAS_RAS_EXTN)) {
 			u64 disr = kvm_vcpu_get_disr(vcpu);
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index bbf2621f1862..2a12d6f710ef 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -140,6 +140,38 @@ static void sync_timer_state(struct kvm_shadow_vcpu_state *shadow_state)
 	__vcpu_sys_reg(shadow_vcpu, CNTV_CTL_EL0) = read_sysreg_el0(SYS_CNTV_CTL);
 }
 
+static void __copy_vcpu_state(const struct kvm_vcpu *from_vcpu,
+			      struct kvm_vcpu *to_vcpu)
+{
+	int i;
+
+	to_vcpu->arch.ctxt.regs		= from_vcpu->arch.ctxt.regs;
+	to_vcpu->arch.ctxt.spsr_abt	= from_vcpu->arch.ctxt.spsr_abt;
+	to_vcpu->arch.ctxt.spsr_und	= from_vcpu->arch.ctxt.spsr_und;
+	to_vcpu->arch.ctxt.spsr_irq	= from_vcpu->arch.ctxt.spsr_irq;
+	to_vcpu->arch.ctxt.spsr_fiq	= from_vcpu->arch.ctxt.spsr_fiq;
+
+	/*
+	 * Copy the sysregs, but don't mess with the timer state which
+	 * is directly handled by EL1 and is expected to be preserved.
+	 */
+	for (i = 1; i < NR_SYS_REGS; i++) {
+		if (i >= CNTVOFF_EL2 && i <= CNTP_CTL_EL0)
+			continue;
+		to_vcpu->arch.ctxt.sys_regs[i] = from_vcpu->arch.ctxt.sys_regs[i];
+	}
+}
+
+static void __sync_vcpu_state(struct kvm_shadow_vcpu_state *shadow_state)
+{
+	__copy_vcpu_state(&shadow_state->shadow_vcpu, shadow_state->host_vcpu);
+}
+
+static void __flush_vcpu_state(struct kvm_shadow_vcpu_state *shadow_state)
+{
+	__copy_vcpu_state(shadow_state->host_vcpu, &shadow_state->shadow_vcpu);
+}
+
 static void flush_shadow_state(struct kvm_shadow_vcpu_state *shadow_state)
 {
 	struct kvm_vcpu *shadow_vcpu = &shadow_state->shadow_vcpu;
@@ -147,7 +179,16 @@ static void flush_shadow_state(struct kvm_shadow_vcpu_state *shadow_state)
 	shadow_entry_exit_handler_fn ec_handler;
 	u8 esr_ec;
 
-	shadow_vcpu->arch.ctxt		= host_vcpu->arch.ctxt;
+	/*
+	 * If we deal with a non-protected guest and the state is potentially
+	 * dirty (from a host perspective), copy the state back into the shadow.
+	 */
+	if (!shadow_state_is_protected(shadow_state)) {
+		unsigned long host_flags = READ_ONCE(host_vcpu->arch.flags);
+
+		if (host_flags & KVM_ARM64_PKVM_STATE_DIRTY)
+			__flush_vcpu_state(shadow_state);
+	}
 
 	shadow_vcpu->arch.sve_state	= kern_hyp_va(host_vcpu->arch.sve_state);
 	shadow_vcpu->arch.sve_max_vl	= host_vcpu->arch.sve_max_vl;
@@ -268,10 +309,31 @@ static void handle___pkvm_vcpu_put(struct kvm_cpu_context *host_ctxt)
 	shadow_state = pkvm_loaded_shadow_vcpu_state();
 
 	if (shadow_state) {
+		struct kvm_vcpu *host_vcpu = shadow_state->host_vcpu;
+
+		if (!shadow_state_is_protected(shadow_state) &&
+			!(READ_ONCE(host_vcpu->arch.flags) & KVM_ARM64_PKVM_STATE_DIRTY))
+			__sync_vcpu_state(shadow_state);
+
 		pkvm_put_shadow_vcpu_state(shadow_state);
 	}
 }
 
+static void handle___pkvm_vcpu_sync_state(struct kvm_cpu_context *host_ctxt)
+{
+	struct kvm_shadow_vcpu_state *shadow_state;
+
+	if (!is_protected_kvm_enabled())
+		return;
+
+	shadow_state = pkvm_loaded_shadow_vcpu_state();
+
+	if (!shadow_state || shadow_state_is_protected(shadow_state))
+		return;
+
+	__sync_vcpu_state(shadow_state);
+}
+
 static struct kvm_vcpu *__get_current_vcpu(struct kvm_vcpu *vcpu,
 					   struct kvm_shadow_vcpu_state **state)
 {
@@ -579,6 +641,7 @@ static const hcall_t host_hcall[] = {
 	HANDLE_FUNC(__pkvm_teardown_shadow),
 	HANDLE_FUNC(__pkvm_vcpu_load),
 	HANDLE_FUNC(__pkvm_vcpu_put),
+	HANDLE_FUNC(__pkvm_vcpu_sync_state),
 };
 
 static void handle_host_hcall(struct kvm_cpu_context *host_ctxt)
-- 
2.36.1.124.g0e6072fb45-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
