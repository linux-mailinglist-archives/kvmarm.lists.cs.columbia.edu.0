Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0760F16639F
	for <lists+kvmarm@lfdr.de>; Thu, 20 Feb 2020 17:59:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B08704AF80;
	Thu, 20 Feb 2020 11:59:07 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZfFVrRzKJKvz; Thu, 20 Feb 2020 11:59:07 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 18F374AF7C;
	Thu, 20 Feb 2020 11:59:06 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 00FBC4AEF6
 for <kvmarm@lists.cs.columbia.edu>; Thu, 20 Feb 2020 11:59:05 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bY9jj8ZF6Mwd for <kvmarm@lists.cs.columbia.edu>;
 Thu, 20 Feb 2020 11:59:03 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 75B5F4AEAF
 for <kvmarm@lists.cs.columbia.edu>; Thu, 20 Feb 2020 11:59:03 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33EF631B;
 Thu, 20 Feb 2020 08:59:03 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF3183F68F;
 Thu, 20 Feb 2020 08:59:01 -0800 (PST)
From: James Morse <james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.cs.columbia.edu
Subject: [PATCH 1/3] KVM: arm64: Ask the compiler to __always_inline functions
 used at HYP
Date: Thu, 20 Feb 2020 16:58:37 +0000
Message-Id: <20200220165839.256881-2-james.morse@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200220165839.256881-1-james.morse@arm.com>
References: <20200220165839.256881-1-james.morse@arm.com>
MIME-Version: 1.0
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Marc Zyngier <maz@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
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

On non VHE CPUs, KVM's __hyp_text contains code run at EL2 while the rest
of the kernel runs at EL1. This code lives in its own section with start
and end markers so we can map it to EL2.

The compiler may decide not to inline static-inline functions from the
header file. It may also decide not to put these out-of-line functions
in the same section, meaning they aren't mapped when called at EL2.

Clang-9 does exactly this with __kern_hyp_va() and a few others when
x18 is reserved for the shadow call stack. Add the additional __always_
hint to all the static-inlines that are called from a hyp file.

Signed-off-by: James Morse <james.morse@arm.com>

----
kvm_get_hyp_vector() pulls in all the regular per-cpu accessors
and this_cpu_has_cap(), fortunately its only called for VHE.
---
 arch/arm64/include/asm/arch_gicv3.h  |  2 +-
 arch/arm64/include/asm/cpufeature.h  |  2 +-
 arch/arm64/include/asm/kvm_emulate.h | 48 ++++++++++++++--------------
 arch/arm64/include/asm/kvm_mmu.h     |  3 +-
 arch/arm64/include/asm/virt.h        |  2 +-
 5 files changed, 29 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arch_gicv3.h
index 25fec4bde43a..a358e97572c1 100644
--- a/arch/arm64/include/asm/arch_gicv3.h
+++ b/arch/arm64/include/asm/arch_gicv3.h
@@ -32,7 +32,7 @@ static inline void gic_write_eoir(u32 irq)
 	isb();
 }
 
-static inline void gic_write_dir(u32 irq)
+static __always_inline void gic_write_dir(u32 irq)
 {
 	write_sysreg_s(irq, SYS_ICC_DIR_EL1);
 	isb();
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 92ef9539874a..42ce41eef274 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -581,7 +581,7 @@ static inline bool system_supports_sve(void)
 		cpus_have_const_cap(ARM64_SVE);
 }
 
-static inline bool system_supports_cnp(void)
+static __always_inline bool system_supports_cnp(void)
 {
 	return IS_ENABLED(CONFIG_ARM64_CNP) &&
 		cpus_have_const_cap(ARM64_HAS_CNP);
diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 688c63412cc2..f658dda12364 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -36,7 +36,7 @@ void kvm_inject_undef32(struct kvm_vcpu *vcpu);
 void kvm_inject_dabt32(struct kvm_vcpu *vcpu, unsigned long addr);
 void kvm_inject_pabt32(struct kvm_vcpu *vcpu, unsigned long addr);
 
-static inline bool vcpu_el1_is_32bit(struct kvm_vcpu *vcpu)
+static __always_inline bool vcpu_el1_is_32bit(struct kvm_vcpu *vcpu)
 {
 	return !(vcpu->arch.hcr_el2 & HCR_RW);
 }
@@ -127,7 +127,7 @@ static inline void vcpu_set_vsesr(struct kvm_vcpu *vcpu, u64 vsesr)
 	vcpu->arch.vsesr_el2 = vsesr;
 }
 
-static inline unsigned long *vcpu_pc(const struct kvm_vcpu *vcpu)
+static __always_inline unsigned long *vcpu_pc(const struct kvm_vcpu *vcpu)
 {
 	return (unsigned long *)&vcpu_gp_regs(vcpu)->regs.pc;
 }
@@ -153,17 +153,17 @@ static inline void vcpu_write_elr_el1(const struct kvm_vcpu *vcpu, unsigned long
 		*__vcpu_elr_el1(vcpu) = v;
 }
 
-static inline unsigned long *vcpu_cpsr(const struct kvm_vcpu *vcpu)
+static __always_inline unsigned long *vcpu_cpsr(const struct kvm_vcpu *vcpu)
 {
 	return (unsigned long *)&vcpu_gp_regs(vcpu)->regs.pstate;
 }
 
-static inline bool vcpu_mode_is_32bit(const struct kvm_vcpu *vcpu)
+static __always_inline bool vcpu_mode_is_32bit(const struct kvm_vcpu *vcpu)
 {
 	return !!(*vcpu_cpsr(vcpu) & PSR_MODE32_BIT);
 }
 
-static inline bool kvm_condition_valid(const struct kvm_vcpu *vcpu)
+static __always_inline bool kvm_condition_valid(const struct kvm_vcpu *vcpu)
 {
 	if (vcpu_mode_is_32bit(vcpu))
 		return kvm_condition_valid32(vcpu);
@@ -181,13 +181,13 @@ static inline void vcpu_set_thumb(struct kvm_vcpu *vcpu)
  * coming from a read of ESR_EL2. Otherwise, it may give the wrong result on
  * AArch32 with banked registers.
  */
-static inline unsigned long vcpu_get_reg(const struct kvm_vcpu *vcpu,
+static __always_inline unsigned long vcpu_get_reg(const struct kvm_vcpu *vcpu,
 					 u8 reg_num)
 {
 	return (reg_num == 31) ? 0 : vcpu_gp_regs(vcpu)->regs.regs[reg_num];
 }
 
-static inline void vcpu_set_reg(struct kvm_vcpu *vcpu, u8 reg_num,
+static __always_inline void vcpu_set_reg(struct kvm_vcpu *vcpu, u8 reg_num,
 				unsigned long val)
 {
 	if (reg_num != 31)
@@ -264,12 +264,12 @@ static inline bool vcpu_mode_priv(const struct kvm_vcpu *vcpu)
 	return mode != PSR_MODE_EL0t;
 }
 
-static inline u32 kvm_vcpu_get_hsr(const struct kvm_vcpu *vcpu)
+static __always_inline u32 kvm_vcpu_get_hsr(const struct kvm_vcpu *vcpu)
 {
 	return vcpu->arch.fault.esr_el2;
 }
 
-static inline int kvm_vcpu_get_condition(const struct kvm_vcpu *vcpu)
+static __always_inline int kvm_vcpu_get_condition(const struct kvm_vcpu *vcpu)
 {
 	u32 esr = kvm_vcpu_get_hsr(vcpu);
 
@@ -279,12 +279,12 @@ static inline int kvm_vcpu_get_condition(const struct kvm_vcpu *vcpu)
 	return -1;
 }
 
-static inline unsigned long kvm_vcpu_get_hfar(const struct kvm_vcpu *vcpu)
+static __always_inline unsigned long kvm_vcpu_get_hfar(const struct kvm_vcpu *vcpu)
 {
 	return vcpu->arch.fault.far_el2;
 }
 
-static inline phys_addr_t kvm_vcpu_get_fault_ipa(const struct kvm_vcpu *vcpu)
+static __always_inline phys_addr_t kvm_vcpu_get_fault_ipa(const struct kvm_vcpu *vcpu)
 {
 	return ((phys_addr_t)vcpu->arch.fault.hpfar_el2 & HPFAR_MASK) << 8;
 }
@@ -299,7 +299,7 @@ static inline u32 kvm_vcpu_hvc_get_imm(const struct kvm_vcpu *vcpu)
 	return kvm_vcpu_get_hsr(vcpu) & ESR_ELx_xVC_IMM_MASK;
 }
 
-static inline bool kvm_vcpu_dabt_isvalid(const struct kvm_vcpu *vcpu)
+static __always_inline bool kvm_vcpu_dabt_isvalid(const struct kvm_vcpu *vcpu)
 {
 	return !!(kvm_vcpu_get_hsr(vcpu) & ESR_ELx_ISV);
 }
@@ -319,17 +319,17 @@ static inline bool kvm_vcpu_dabt_issf(const struct kvm_vcpu *vcpu)
 	return !!(kvm_vcpu_get_hsr(vcpu) & ESR_ELx_SF);
 }
 
-static inline int kvm_vcpu_dabt_get_rd(const struct kvm_vcpu *vcpu)
+static __always_inline int kvm_vcpu_dabt_get_rd(const struct kvm_vcpu *vcpu)
 {
 	return (kvm_vcpu_get_hsr(vcpu) & ESR_ELx_SRT_MASK) >> ESR_ELx_SRT_SHIFT;
 }
 
-static inline bool kvm_vcpu_dabt_iss1tw(const struct kvm_vcpu *vcpu)
+static __always_inline bool kvm_vcpu_dabt_iss1tw(const struct kvm_vcpu *vcpu)
 {
 	return !!(kvm_vcpu_get_hsr(vcpu) & ESR_ELx_S1PTW);
 }
 
-static inline bool kvm_vcpu_dabt_iswrite(const struct kvm_vcpu *vcpu)
+static __always_inline bool kvm_vcpu_dabt_iswrite(const struct kvm_vcpu *vcpu)
 {
 	return !!(kvm_vcpu_get_hsr(vcpu) & ESR_ELx_WNR) ||
 		kvm_vcpu_dabt_iss1tw(vcpu); /* AF/DBM update */
@@ -340,18 +340,18 @@ static inline bool kvm_vcpu_dabt_is_cm(const struct kvm_vcpu *vcpu)
 	return !!(kvm_vcpu_get_hsr(vcpu) & ESR_ELx_CM);
 }
 
-static inline unsigned int kvm_vcpu_dabt_get_as(const struct kvm_vcpu *vcpu)
+static __always_inline unsigned int kvm_vcpu_dabt_get_as(const struct kvm_vcpu *vcpu)
 {
 	return 1 << ((kvm_vcpu_get_hsr(vcpu) & ESR_ELx_SAS) >> ESR_ELx_SAS_SHIFT);
 }
 
 /* This one is not specific to Data Abort */
-static inline bool kvm_vcpu_trap_il_is32bit(const struct kvm_vcpu *vcpu)
+static __always_inline bool kvm_vcpu_trap_il_is32bit(const struct kvm_vcpu *vcpu)
 {
 	return !!(kvm_vcpu_get_hsr(vcpu) & ESR_ELx_IL);
 }
 
-static inline u8 kvm_vcpu_trap_get_class(const struct kvm_vcpu *vcpu)
+static __always_inline u8 kvm_vcpu_trap_get_class(const struct kvm_vcpu *vcpu)
 {
 	return ESR_ELx_EC(kvm_vcpu_get_hsr(vcpu));
 }
@@ -361,17 +361,17 @@ static inline bool kvm_vcpu_trap_is_iabt(const struct kvm_vcpu *vcpu)
 	return kvm_vcpu_trap_get_class(vcpu) == ESR_ELx_EC_IABT_LOW;
 }
 
-static inline u8 kvm_vcpu_trap_get_fault(const struct kvm_vcpu *vcpu)
+static __always_inline u8 kvm_vcpu_trap_get_fault(const struct kvm_vcpu *vcpu)
 {
 	return kvm_vcpu_get_hsr(vcpu) & ESR_ELx_FSC;
 }
 
-static inline u8 kvm_vcpu_trap_get_fault_type(const struct kvm_vcpu *vcpu)
+static __always_inline u8 kvm_vcpu_trap_get_fault_type(const struct kvm_vcpu *vcpu)
 {
 	return kvm_vcpu_get_hsr(vcpu) & ESR_ELx_FSC_TYPE;
 }
 
-static inline bool kvm_vcpu_dabt_isextabt(const struct kvm_vcpu *vcpu)
+static __always_inline bool kvm_vcpu_dabt_isextabt(const struct kvm_vcpu *vcpu)
 {
 	switch (kvm_vcpu_trap_get_fault(vcpu)) {
 	case FSC_SEA:
@@ -390,7 +390,7 @@ static inline bool kvm_vcpu_dabt_isextabt(const struct kvm_vcpu *vcpu)
 	}
 }
 
-static inline int kvm_vcpu_sys_get_rt(struct kvm_vcpu *vcpu)
+static __always_inline int kvm_vcpu_sys_get_rt(struct kvm_vcpu *vcpu)
 {
 	u32 esr = kvm_vcpu_get_hsr(vcpu);
 	return ESR_ELx_SYS64_ISS_RT(esr);
@@ -504,7 +504,7 @@ static inline unsigned long vcpu_data_host_to_guest(struct kvm_vcpu *vcpu,
 	return data;		/* Leave LE untouched */
 }
 
-static inline void kvm_skip_instr(struct kvm_vcpu *vcpu, bool is_wide_instr)
+static __always_inline void kvm_skip_instr(struct kvm_vcpu *vcpu, bool is_wide_instr)
 {
 	if (vcpu_mode_is_32bit(vcpu))
 		kvm_skip_instr32(vcpu, is_wide_instr);
@@ -519,7 +519,7 @@ static inline void kvm_skip_instr(struct kvm_vcpu *vcpu, bool is_wide_instr)
  * Skip an instruction which has been emulated at hyp while most guest sysregs
  * are live.
  */
-static inline void __hyp_text __kvm_skip_instr(struct kvm_vcpu *vcpu)
+static __always_inline void __hyp_text __kvm_skip_instr(struct kvm_vcpu *vcpu)
 {
 	*vcpu_pc(vcpu) = read_sysreg_el2(SYS_ELR);
 	vcpu->arch.ctxt.gp_regs.regs.pstate = read_sysreg_el2(SYS_SPSR);
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 53d846f1bfe7..785762860c63 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -93,7 +93,7 @@ void kvm_update_va_mask(struct alt_instr *alt,
 			__le32 *origptr, __le32 *updptr, int nr_inst);
 void kvm_compute_layout(void);
 
-static inline unsigned long __kern_hyp_va(unsigned long v)
+static __always_inline unsigned long __kern_hyp_va(unsigned long v)
 {
 	asm volatile(ALTERNATIVE_CB("and %0, %0, #1\n"
 				    "ror %0, %0, #1\n"
@@ -473,6 +473,7 @@ static inline int kvm_write_guest_lock(struct kvm *kvm, gpa_t gpa,
 extern void *__kvm_bp_vect_base;
 extern int __kvm_harden_el2_vector_slot;
 
+/*  This is only called on a VHE system */
 static inline void *kvm_get_hyp_vector(void)
 {
 	struct bp_hardening_data *data = arm64_get_bp_hardening_data();
diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
index 0958ed6191aa..61fd26752adc 100644
--- a/arch/arm64/include/asm/virt.h
+++ b/arch/arm64/include/asm/virt.h
@@ -83,7 +83,7 @@ static inline bool is_kernel_in_hyp_mode(void)
 	return read_sysreg(CurrentEL) == CurrentEL_EL2;
 }
 
-static inline bool has_vhe(void)
+static __always_inline bool has_vhe(void)
 {
 	if (cpus_have_const_cap(ARM64_HAS_VIRT_HOST_EXTN))
 		return true;
-- 
2.24.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
