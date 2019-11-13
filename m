Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB6AFB64F
	for <lists+kvmarm@lfdr.de>; Wed, 13 Nov 2019 18:23:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F3C764B10C;
	Wed, 13 Nov 2019 12:23:06 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lEkc45B3wV8M; Wed, 13 Nov 2019 12:23:06 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D02704B149;
	Wed, 13 Nov 2019 12:23:05 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 00FB84B10C
 for <kvmarm@lists.cs.columbia.edu>; Wed, 13 Nov 2019 12:23:05 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uF5p+Y9TVkHH for <kvmarm@lists.cs.columbia.edu>;
 Wed, 13 Nov 2019 12:23:03 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 887474B0ED
 for <kvmarm@lists.cs.columbia.edu>; Wed, 13 Nov 2019 12:23:03 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3802B7A7;
 Wed, 13 Nov 2019 09:23:03 -0800 (PST)
Received: from e112269-lin.cambridge.arm.com (e112269-lin.cambridge.arm.com
 [10.1.194.43])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D72613F534;
 Wed, 13 Nov 2019 09:23:01 -0800 (PST)
From: Steven Price <steven.price@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>
Subject: [PATCH v3 1/3] arm64: Rename WORKAROUND_1165522 to SPECULATIVE_AT_VHE
Date: Wed, 13 Nov 2019 17:22:50 +0000
Message-Id: <20191113172252.12610-2-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113172252.12610-1-steven.price@arm.com>
References: <20191113172252.12610-1-steven.price@arm.com>
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

Cortex-A55 is affected by a similar erratum, so rename the existing
workaround for errarum 1165522 so it can be used for both errata.

Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/arm64/Kconfig                |  4 ++++
 arch/arm64/include/asm/cpucaps.h  |  2 +-
 arch/arm64/include/asm/kvm_host.h |  2 +-
 arch/arm64/include/asm/kvm_hyp.h  |  2 +-
 arch/arm64/kernel/cpu_errata.c    | 17 +++++++++++++----
 arch/arm64/kvm/hyp/switch.c       |  2 +-
 arch/arm64/kvm/hyp/tlb.c          |  4 ++--
 7 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 3e53441ee067..ce976d69cd3c 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -516,9 +516,13 @@ config ARM64_ERRATUM_1418040
 
 	  If unsure, say Y.
 
+config ARM64_WORKAROUND_SPECULATIVE_AT_VHE
+	bool
+
 config ARM64_ERRATUM_1165522
 	bool "Cortex-A76: Speculative AT instruction using out-of-context translation regime could cause subsequent request to generate an incorrect translation"
 	default y
+	select ARM64_WORKAROUND_SPECULATIVE_AT_VHE
 	help
 	  This option adds a workaround for ARM Cortex-A76 erratum 1165522.
 
diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index b92683871119..327a38a5162f 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -44,7 +44,7 @@
 #define ARM64_SSBS				34
 #define ARM64_WORKAROUND_1418040		35
 #define ARM64_HAS_SB				36
-#define ARM64_WORKAROUND_1165522		37
+#define ARM64_WORKAROUND_SPECULATIVE_AT_VHE	37
 #define ARM64_HAS_ADDRESS_AUTH_ARCH		38
 #define ARM64_HAS_ADDRESS_AUTH_IMP_DEF		39
 #define ARM64_HAS_GENERIC_AUTH_ARCH		40
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 5ecb091c8576..8619e94e9e77 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -534,7 +534,7 @@ static inline bool kvm_arch_requires_vhe(void)
 		return true;
 
 	/* Some implementations have defects that confine them to VHE */
-	if (cpus_have_cap(ARM64_WORKAROUND_1165522))
+	if (cpus_have_cap(ARM64_WORKAROUND_SPECULATIVE_AT_VHE))
 		return true;
 
 	return false;
diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index 97f21cc66657..167a161dd596 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -95,7 +95,7 @@ static __always_inline void __hyp_text __load_guest_stage2(struct kvm *kvm)
 	 * before we can switch to the EL1/EL0 translation regime used by
 	 * the guest.
 	 */
-	asm(ALTERNATIVE("nop", "isb", ARM64_WORKAROUND_1165522));
+	asm(ALTERNATIVE("nop", "isb", ARM64_WORKAROUND_SPECULATIVE_AT_VHE));
 }
 
 #endif /* __ARM64_KVM_HYP_H__ */
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 4f8187a4fc46..6242bba1cfb9 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -744,6 +744,16 @@ static const struct midr_range erratum_1418040_list[] = {
 };
 #endif
 
+#ifdef CONFIG_ARM64_WORKAROUND_SPECULATIVE_AT_VHE
+static const struct midr_range erratum_speculative_at_vhe_list[] = {
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
+#ifdef CONFIG_ARM64_WORKAROUND_SPECULATIVE_AT_VHE
 	{
-		/* Cortex-A76 r0p0 to r2p0 */
 		.desc = "ARM erratum 1165522",
-		.capability = ARM64_WORKAROUND_1165522,
-		ERRATA_MIDR_RANGE(MIDR_CORTEX_A76, 0, 0, 2, 0),
+		.capability = ARM64_WORKAROUND_SPECULATIVE_AT_VHE,
+		ERRATA_MIDR_RANGE_LIST(erratum_speculative_at_vhe_list),
 	},
 #endif
 #ifdef CONFIG_ARM64_ERRATUM_1463225
diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index 72fbbd86eb5e..eefcaa6d839f 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -162,7 +162,7 @@ static void deactivate_traps_vhe(void)
 	 * before we can switch to the EL2/EL0 translation regime used by
 	 * the host.
 	 */
-	asm(ALTERNATIVE("nop", "isb", ARM64_WORKAROUND_1165522));
+	asm(ALTERNATIVE("nop", "isb", ARM64_WORKAROUND_SPECULATIVE_AT_VHE));
 
 	write_sysreg(CPACR_EL1_DEFAULT, cpacr_el1);
 	write_sysreg(vectors, vbar_el1);
diff --git a/arch/arm64/kvm/hyp/tlb.c b/arch/arm64/kvm/hyp/tlb.c
index c2bc17ca6430..c827f3e0ba8f 100644
--- a/arch/arm64/kvm/hyp/tlb.c
+++ b/arch/arm64/kvm/hyp/tlb.c
@@ -23,7 +23,7 @@ static void __hyp_text __tlb_switch_to_guest_vhe(struct kvm *kvm,
 
 	local_irq_save(cxt->flags);
 
-	if (cpus_have_const_cap(ARM64_WORKAROUND_1165522)) {
+	if (cpus_have_const_cap(ARM64_WORKAROUND_SPECULATIVE_AT_VHE)) {
 		/*
 		 * For CPUs that are affected by ARM erratum 1165522, we
 		 * cannot trust stage-1 to be in a correct state at that
@@ -103,7 +103,7 @@ static void __hyp_text __tlb_switch_to_host_vhe(struct kvm *kvm,
 	write_sysreg(HCR_HOST_VHE_FLAGS, hcr_el2);
 	isb();
 
-	if (cpus_have_const_cap(ARM64_WORKAROUND_1165522)) {
+	if (cpus_have_const_cap(ARM64_WORKAROUND_SPECULATIVE_AT_VHE)) {
 		/* Restore the registers to what they were */
 		write_sysreg_el1(cxt->tcr, SYS_TCR);
 		write_sysreg_el1(cxt->sctlr, SYS_SCTLR);
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
