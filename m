Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C2EFAFAFDA
	for <lists+kvmarm@lfdr.de>; Wed, 13 Nov 2019 12:41:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 74CEC4B18D;
	Wed, 13 Nov 2019 06:41:35 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KIfNxfKoKkXJ; Wed, 13 Nov 2019 06:41:35 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 043964B159;
	Wed, 13 Nov 2019 06:41:34 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E6BE54B161
 for <kvmarm@lists.cs.columbia.edu>; Wed, 13 Nov 2019 06:41:31 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZLsV6XyNLjD2 for <kvmarm@lists.cs.columbia.edu>;
 Wed, 13 Nov 2019 06:41:30 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4CF494AF67
 for <kvmarm@lists.cs.columbia.edu>; Wed, 13 Nov 2019 06:41:30 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EED46C8F;
 Wed, 13 Nov 2019 03:41:29 -0800 (PST)
Received: from e112269-lin.cambridge.arm.com (e112269-lin.cambridge.arm.com
 [10.1.194.43])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7507A3F534;
 Wed, 13 Nov 2019 03:41:28 -0800 (PST)
From: Steven Price <steven.price@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>
Subject: [PATCH v2 1/2] arm64: Combine workarounds for speculative AT errata
Date: Wed, 13 Nov 2019 11:41:17 +0000
Message-Id: <20191113114118.2427-2-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113114118.2427-1-steven.price@arm.com>
References: <20191113114118.2427-1-steven.price@arm.com>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, Steven Price <steven.price@arm.com>,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
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

Cortex-A57/A72 have a similar errata to Cortex-A76 regarding speculation
of the AT instruction. Since the workaround for A57/A72 doesn't require
VHE, the restriction enforcing VHE for A76 can be removed by combining
the workaround flag for both errata.

So combine WORKAROUND_1165522 and WORKAROUND_1319367 into
WORKAROUND_SPECULATIVE_AT. The majority of code is contained within VHE
or NVHE specific functions, for the cases where the code is shared extra
checks against has_vhe().

This also paves the way for adding a similar erratum for Cortex-A55.

Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/arm64/Kconfig                |  5 +++++
 arch/arm64/include/asm/cpucaps.h  |  5 ++---
 arch/arm64/include/asm/kvm_host.h |  4 ----
 arch/arm64/include/asm/kvm_hyp.h  |  3 ++-
 arch/arm64/kernel/cpu_errata.c    | 19 ++++++++++++++-----
 arch/arm64/kvm/hyp/switch.c       |  6 +++---
 arch/arm64/kvm/hyp/sysreg-sr.c    |  6 ++++--
 arch/arm64/kvm/hyp/tlb.c          |  8 ++++----
 8 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 3e53441ee067..5a235e724fbb 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -516,9 +516,13 @@ config ARM64_ERRATUM_1418040
 
 	  If unsure, say Y.
 
+config ARM64_WORKAROUND_SPECULATIVE_AT
+	bool
+
 config ARM64_ERRATUM_1165522
 	bool "Cortex-A76: Speculative AT instruction using out-of-context translation regime could cause subsequent request to generate an incorrect translation"
 	default y
+	select ARM64_WORKAROUND_SPECULATIVE_AT
 	help
 	  This option adds a workaround for ARM Cortex-A76 erratum 1165522.
 
@@ -547,6 +551,7 @@ config ARM64_ERRATUM_1286807
 config ARM64_ERRATUM_1319367
 	bool "Cortex-A57/A72: Speculative AT instruction using out-of-context translation regime could cause subsequent request to generate an incorrect translation"
 	default y
+	select ARM64_WORKAROUND_SPECULATIVE_AT
 	help
 	  This option adds work arounds for ARM Cortex-A57 erratum 1319537
 	  and A72 erratum 1319367
diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index b92683871119..b57821e10a8f 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -44,7 +44,7 @@
 #define ARM64_SSBS				34
 #define ARM64_WORKAROUND_1418040		35
 #define ARM64_HAS_SB				36
-#define ARM64_WORKAROUND_1165522		37
+#define ARM64_WORKAROUND_SPECULATIVE_AT		37
 #define ARM64_HAS_ADDRESS_AUTH_ARCH		38
 #define ARM64_HAS_ADDRESS_AUTH_IMP_DEF		39
 #define ARM64_HAS_GENERIC_AUTH_ARCH		40
@@ -55,8 +55,7 @@
 #define ARM64_WORKAROUND_CAVIUM_TX2_219_TVM	45
 #define ARM64_WORKAROUND_CAVIUM_TX2_219_PRFM	46
 #define ARM64_WORKAROUND_1542419		47
-#define ARM64_WORKAROUND_1319367		48
 
-#define ARM64_NCAPS				49
+#define ARM64_NCAPS				48
 
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 5ecb091c8576..583ada60d5d9 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -533,10 +533,6 @@ static inline bool kvm_arch_requires_vhe(void)
 	if (system_supports_sve())
 		return true;
 
-	/* Some implementations have defects that confine them to VHE */
-	if (cpus_have_cap(ARM64_WORKAROUND_1165522))
-		return true;
-
 	return false;
 }
 
diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index 97f21cc66657..965a9b4e5454 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -95,7 +95,8 @@ static __always_inline void __hyp_text __load_guest_stage2(struct kvm *kvm)
 	 * before we can switch to the EL1/EL0 translation regime used by
 	 * the guest.
 	 */
-	asm(ALTERNATIVE("nop", "isb", ARM64_WORKAROUND_1165522));
+	if (!has_vhe())
+		asm(ALTERNATIVE("nop", "isb", ARM64_WORKAROUND_SPECULATIVE_AT));
 }
 
 #endif /* __ARM64_KVM_HYP_H__ */
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 4f8187a4fc46..b801f8e832aa 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -744,6 +744,16 @@ static const struct midr_range erratum_1418040_list[] = {
 };
 #endif
 
+#ifdef CONFIG_ARM64_WORKAROUND_SPECULATIVE_AT
+static const struct midr_range erratum_speculative_at_list[] = {
+#ifdef CONFIG_ARM64_ERRATUM_1165522
+	/* Cortex A76 r0p0 to r2p0 */
+	MIDR_RANGE(MIDR_CORTEX_A76, 0, 0, 2, 0),
+#endif
+	{},
+};
+#endif
+
 const struct arm64_cpu_capabilities arm64_errata[] = {
 #ifdef CONFIG_ARM64_WORKAROUND_CLEAN_CACHE
 	{
@@ -868,12 +878,11 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		ERRATA_MIDR_RANGE_LIST(erratum_1418040_list),
 	},
 #endif
-#ifdef CONFIG_ARM64_ERRATUM_1165522
+#ifdef CONFIG_ARM64_WORKAROUND_SPECULATIVE_AT
 	{
-		/* Cortex-A76 r0p0 to r2p0 */
 		.desc = "ARM erratum 1165522",
-		.capability = ARM64_WORKAROUND_1165522,
-		ERRATA_MIDR_RANGE(MIDR_CORTEX_A76, 0, 0, 2, 0),
+		.capability = ARM64_WORKAROUND_SPECULATIVE_AT,
+		ERRATA_MIDR_RANGE_LIST(erratum_speculative_at_list),
 	},
 #endif
 #ifdef CONFIG_ARM64_ERRATUM_1463225
@@ -910,7 +919,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 #ifdef CONFIG_ARM64_ERRATUM_1319367
 	{
 		.desc = "ARM erratum 1319367",
-		.capability = ARM64_WORKAROUND_1319367,
+		.capability = ARM64_WORKAROUND_SPECULATIVE_AT,
 		ERRATA_MIDR_RANGE_LIST(ca57_a72),
 	},
 #endif
diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index 72fbbd86eb5e..140f467b1f16 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -119,7 +119,7 @@ static void __hyp_text __activate_traps_nvhe(struct kvm_vcpu *vcpu)
 
 	write_sysreg(val, cptr_el2);
 
-	if (cpus_have_const_cap(ARM64_WORKAROUND_1319367)) {
+	if (cpus_have_const_cap(ARM64_WORKAROUND_SPECULATIVE_AT)) {
 		struct kvm_cpu_context *ctxt = &vcpu->arch.ctxt;
 
 		isb();
@@ -162,7 +162,7 @@ static void deactivate_traps_vhe(void)
 	 * before we can switch to the EL2/EL0 translation regime used by
 	 * the host.
 	 */
-	asm(ALTERNATIVE("nop", "isb", ARM64_WORKAROUND_1165522));
+	asm(ALTERNATIVE("nop", "isb", ARM64_WORKAROUND_SPECULATIVE_AT));
 
 	write_sysreg(CPACR_EL1_DEFAULT, cpacr_el1);
 	write_sysreg(vectors, vbar_el1);
@@ -173,7 +173,7 @@ static void __hyp_text __deactivate_traps_nvhe(void)
 {
 	u64 mdcr_el2 = read_sysreg(mdcr_el2);
 
-	if (cpus_have_const_cap(ARM64_WORKAROUND_1319367)) {
+	if (cpus_have_const_cap(ARM64_WORKAROUND_SPECULATIVE_AT)) {
 		u64 val;
 
 		/*
diff --git a/arch/arm64/kvm/hyp/sysreg-sr.c b/arch/arm64/kvm/hyp/sysreg-sr.c
index 22b8128d19f6..f023f56397b3 100644
--- a/arch/arm64/kvm/hyp/sysreg-sr.c
+++ b/arch/arm64/kvm/hyp/sysreg-sr.c
@@ -118,7 +118,8 @@ static void __hyp_text __sysreg_restore_el1_state(struct kvm_cpu_context *ctxt)
 	write_sysreg(ctxt->sys_regs[MPIDR_EL1],		vmpidr_el2);
 	write_sysreg(ctxt->sys_regs[CSSELR_EL1],	csselr_el1);
 
-	if (!cpus_have_const_cap(ARM64_WORKAROUND_1319367)) {
+	if (!cpus_have_const_cap(ARM64_WORKAROUND_SPECULATIVE_AT) ||
+	    has_vhe()) {
 		write_sysreg_el1(ctxt->sys_regs[SCTLR_EL1],	SYS_SCTLR);
 		write_sysreg_el1(ctxt->sys_regs[TCR_EL1],	SYS_TCR);
 	} else	if (!ctxt->__hyp_running_vcpu) {
@@ -149,7 +150,8 @@ static void __hyp_text __sysreg_restore_el1_state(struct kvm_cpu_context *ctxt)
 	write_sysreg(ctxt->sys_regs[PAR_EL1],		par_el1);
 	write_sysreg(ctxt->sys_regs[TPIDR_EL1],		tpidr_el1);
 
-	if (cpus_have_const_cap(ARM64_WORKAROUND_1319367) &&
+	if (cpus_have_const_cap(ARM64_WORKAROUND_SPECULATIVE_AT) &&
+	    !has_vhe() &&
 	    ctxt->__hyp_running_vcpu) {
 		/*
 		 * Must only be done for host registers, hence the context
diff --git a/arch/arm64/kvm/hyp/tlb.c b/arch/arm64/kvm/hyp/tlb.c
index c2bc17ca6430..338df7f9149a 100644
--- a/arch/arm64/kvm/hyp/tlb.c
+++ b/arch/arm64/kvm/hyp/tlb.c
@@ -23,7 +23,7 @@ static void __hyp_text __tlb_switch_to_guest_vhe(struct kvm *kvm,
 
 	local_irq_save(cxt->flags);
 
-	if (cpus_have_const_cap(ARM64_WORKAROUND_1165522)) {
+	if (cpus_have_const_cap(ARM64_WORKAROUND_SPECULATIVE_AT)) {
 		/*
 		 * For CPUs that are affected by ARM erratum 1165522, we
 		 * cannot trust stage-1 to be in a correct state at that
@@ -63,7 +63,7 @@ static void __hyp_text __tlb_switch_to_guest_vhe(struct kvm *kvm,
 static void __hyp_text __tlb_switch_to_guest_nvhe(struct kvm *kvm,
 						  struct tlb_inv_context *cxt)
 {
-	if (cpus_have_const_cap(ARM64_WORKAROUND_1319367)) {
+	if (cpus_have_const_cap(ARM64_WORKAROUND_SPECULATIVE_AT)) {
 		u64 val;
 
 		/*
@@ -103,7 +103,7 @@ static void __hyp_text __tlb_switch_to_host_vhe(struct kvm *kvm,
 	write_sysreg(HCR_HOST_VHE_FLAGS, hcr_el2);
 	isb();
 
-	if (cpus_have_const_cap(ARM64_WORKAROUND_1165522)) {
+	if (cpus_have_const_cap(ARM64_WORKAROUND_SPECULATIVE_AT)) {
 		/* Restore the registers to what they were */
 		write_sysreg_el1(cxt->tcr, SYS_TCR);
 		write_sysreg_el1(cxt->sctlr, SYS_SCTLR);
@@ -117,7 +117,7 @@ static void __hyp_text __tlb_switch_to_host_nvhe(struct kvm *kvm,
 {
 	write_sysreg(0, vttbr_el2);
 
-	if (cpus_have_const_cap(ARM64_WORKAROUND_1319367)) {
+	if (cpus_have_const_cap(ARM64_WORKAROUND_SPECULATIVE_AT)) {
 		/* Ensure write of the host VMID */
 		isb();
 		/* Restore the host's TCR_EL1 */
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
