Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5A647FC511
	for <lists+kvmarm@lfdr.de>; Thu, 14 Nov 2019 12:07:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0D1CD4ACB9;
	Thu, 14 Nov 2019 06:07:39 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7JXgIvcGgDlE; Thu, 14 Nov 2019 06:07:33 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 836444AFB7;
	Thu, 14 Nov 2019 06:07:33 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id ED2824AF79
 for <kvmarm@lists.cs.columbia.edu>; Thu, 14 Nov 2019 06:07:30 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 18+rsDM9AcPe for <kvmarm@lists.cs.columbia.edu>;
 Thu, 14 Nov 2019 06:07:29 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id AA0AB4AF74
 for <kvmarm@lists.cs.columbia.edu>; Thu, 14 Nov 2019 06:07:29 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4FC7131B;
 Thu, 14 Nov 2019 03:07:29 -0800 (PST)
Received: from e112269-lin.cambridge.arm.com (e112269-lin.cambridge.arm.com
 [10.1.194.43])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EDAB83F6C4;
 Thu, 14 Nov 2019 03:07:27 -0800 (PST)
From: Steven Price <steven.price@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>
Subject: [PATCH v4 2/3] arm64: Rename WORKAROUND_1319367 to SPECULATIVE_AT_NVHE
Date: Thu, 14 Nov 2019 11:06:57 +0000
Message-Id: <20191114110658.20560-3-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191114110658.20560-1-steven.price@arm.com>
References: <20191114110658.20560-1-steven.price@arm.com>
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

To match SPECULATIVE_AT_VHE let's also have a generic name for the NVHE
variant.

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/arm64/Kconfig               | 4 ++++
 arch/arm64/include/asm/cpucaps.h | 2 +-
 arch/arm64/kernel/cpu_errata.c   | 2 +-
 arch/arm64/kvm/hyp/switch.c      | 4 ++--
 arch/arm64/kvm/hyp/sysreg-sr.c   | 4 ++--
 arch/arm64/kvm/hyp/tlb.c         | 4 ++--
 6 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index ce976d69cd3c..defb68e45387 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -548,9 +548,13 @@ config ARM64_ERRATUM_1286807
 	  invalidated has been observed by other observers. The
 	  workaround repeats the TLBI+DSB operation.
 
+config ARM64_WORKAROUND_SPECULATIVE_AT_NVHE
+	bool
+
 config ARM64_ERRATUM_1319367
 	bool "Cortex-A57/A72: Speculative AT instruction using out-of-context translation regime could cause subsequent request to generate an incorrect translation"
 	default y
+	select ARM64_WORKAROUND_SPECULATIVE_AT_NVHE
 	help
 	  This option adds work arounds for ARM Cortex-A57 erratum 1319537
 	  and A72 erratum 1319367
diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index 327a38a5162f..3d1aa1b02093 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -55,7 +55,7 @@
 #define ARM64_WORKAROUND_CAVIUM_TX2_219_TVM	45
 #define ARM64_WORKAROUND_CAVIUM_TX2_219_PRFM	46
 #define ARM64_WORKAROUND_1542419		47
-#define ARM64_WORKAROUND_1319367		48
+#define ARM64_WORKAROUND_SPECULATIVE_AT_NVHE	48
 
 #define ARM64_NCAPS				49
 
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 6242bba1cfb9..c7f1f5398a44 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -919,7 +919,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 #ifdef CONFIG_ARM64_ERRATUM_1319367
 	{
 		.desc = "ARM erratum 1319367",
-		.capability = ARM64_WORKAROUND_1319367,
+		.capability = ARM64_WORKAROUND_SPECULATIVE_AT_NVHE,
 		ERRATA_MIDR_RANGE_LIST(ca57_a72),
 	},
 #endif
diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index eefcaa6d839f..0fc824bdf258 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -119,7 +119,7 @@ static void __hyp_text __activate_traps_nvhe(struct kvm_vcpu *vcpu)
 
 	write_sysreg(val, cptr_el2);
 
-	if (cpus_have_const_cap(ARM64_WORKAROUND_1319367)) {
+	if (cpus_have_const_cap(ARM64_WORKAROUND_SPECULATIVE_AT_NVHE)) {
 		struct kvm_cpu_context *ctxt = &vcpu->arch.ctxt;
 
 		isb();
@@ -173,7 +173,7 @@ static void __hyp_text __deactivate_traps_nvhe(void)
 {
 	u64 mdcr_el2 = read_sysreg(mdcr_el2);
 
-	if (cpus_have_const_cap(ARM64_WORKAROUND_1319367)) {
+	if (cpus_have_const_cap(ARM64_WORKAROUND_SPECULATIVE_AT_NVHE)) {
 		u64 val;
 
 		/*
diff --git a/arch/arm64/kvm/hyp/sysreg-sr.c b/arch/arm64/kvm/hyp/sysreg-sr.c
index 22b8128d19f6..7672a978926c 100644
--- a/arch/arm64/kvm/hyp/sysreg-sr.c
+++ b/arch/arm64/kvm/hyp/sysreg-sr.c
@@ -118,7 +118,7 @@ static void __hyp_text __sysreg_restore_el1_state(struct kvm_cpu_context *ctxt)
 	write_sysreg(ctxt->sys_regs[MPIDR_EL1],		vmpidr_el2);
 	write_sysreg(ctxt->sys_regs[CSSELR_EL1],	csselr_el1);
 
-	if (!cpus_have_const_cap(ARM64_WORKAROUND_1319367)) {
+	if (!cpus_have_const_cap(ARM64_WORKAROUND_SPECULATIVE_AT_NVHE)) {
 		write_sysreg_el1(ctxt->sys_regs[SCTLR_EL1],	SYS_SCTLR);
 		write_sysreg_el1(ctxt->sys_regs[TCR_EL1],	SYS_TCR);
 	} else	if (!ctxt->__hyp_running_vcpu) {
@@ -149,7 +149,7 @@ static void __hyp_text __sysreg_restore_el1_state(struct kvm_cpu_context *ctxt)
 	write_sysreg(ctxt->sys_regs[PAR_EL1],		par_el1);
 	write_sysreg(ctxt->sys_regs[TPIDR_EL1],		tpidr_el1);
 
-	if (cpus_have_const_cap(ARM64_WORKAROUND_1319367) &&
+	if (cpus_have_const_cap(ARM64_WORKAROUND_SPECULATIVE_AT_NVHE) &&
 	    ctxt->__hyp_running_vcpu) {
 		/*
 		 * Must only be done for host registers, hence the context
diff --git a/arch/arm64/kvm/hyp/tlb.c b/arch/arm64/kvm/hyp/tlb.c
index c827f3e0ba8f..ff4e73c9bafc 100644
--- a/arch/arm64/kvm/hyp/tlb.c
+++ b/arch/arm64/kvm/hyp/tlb.c
@@ -63,7 +63,7 @@ static void __hyp_text __tlb_switch_to_guest_vhe(struct kvm *kvm,
 static void __hyp_text __tlb_switch_to_guest_nvhe(struct kvm *kvm,
 						  struct tlb_inv_context *cxt)
 {
-	if (cpus_have_const_cap(ARM64_WORKAROUND_1319367)) {
+	if (cpus_have_const_cap(ARM64_WORKAROUND_SPECULATIVE_AT_NVHE)) {
 		u64 val;
 
 		/*
@@ -117,7 +117,7 @@ static void __hyp_text __tlb_switch_to_host_nvhe(struct kvm *kvm,
 {
 	write_sysreg(0, vttbr_el2);
 
-	if (cpus_have_const_cap(ARM64_WORKAROUND_1319367)) {
+	if (cpus_have_const_cap(ARM64_WORKAROUND_SPECULATIVE_AT_NVHE)) {
 		/* Ensure write of the host VMID */
 		isb();
 		/* Restore the host's TCR_EL1 */
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
