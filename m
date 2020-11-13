Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E0FCF2B1A2E
	for <lists+kvmarm@lfdr.de>; Fri, 13 Nov 2020 12:39:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 933734BD8A;
	Fri, 13 Nov 2020 06:39:11 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OTC3Cu2Ab8SN; Fri, 13 Nov 2020 06:39:11 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A3E534BD68;
	Fri, 13 Nov 2020 06:39:09 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id AF8344BCC1
 for <kvmarm@lists.cs.columbia.edu>; Fri, 13 Nov 2020 06:39:08 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ow5CxFFmcZlf for <kvmarm@lists.cs.columbia.edu>;
 Fri, 13 Nov 2020 06:39:07 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 27A7C4BCF4
 for <kvmarm@lists.cs.columbia.edu>; Fri, 13 Nov 2020 06:39:07 -0500 (EST)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 179C02224F;
 Fri, 13 Nov 2020 11:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605267546;
 bh=Jkhwoi5/4C3VCjIsbBO4z1jtM4GQYxUJvEGztLvTMFg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZGR7SM+dfdDhUJ4nnORjzFnqHPXhYoXxnvdrATJDV3UR3ZFro6LDG1wr3ZedDp8GH
 ZMXOTRk0xELian59Cf+ygOIUTwUhgI1buq9+dGJU033ly5YgBmd6rk0Prxvxs6aoos
 PMQfABamyxwiGBhvbgzGzILSHsP51lvh9sMbmX2c=
From: Will Deacon <will@kernel.org>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v3 08/10] arm64: spectre: Rename ARM64_HARDEN_EL2_VECTORS to
 ARM64_SPECTRE_V3A
Date: Fri, 13 Nov 2020 11:38:45 +0000
Message-Id: <20201113113847.21619-9-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201113113847.21619-1-will@kernel.org>
References: <20201113113847.21619-1-will@kernel.org>
MIME-Version: 1.0
Cc: catalin.marinas@arm.com, kernel-team@android.com,
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>
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

Since ARM64_HARDEN_EL2_VECTORS is really a mitigation for Spectre-v3a,
rename it accordingly for consistency with the v2 and v4 mitigation.

Cc: Marc Zyngier <maz@kernel.org>
Cc: Quentin Perret <qperret@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 Documentation/arm64/memory.rst   |  2 +-
 arch/arm64/include/asm/cpucaps.h |  2 +-
 arch/arm64/include/asm/spectre.h |  2 +-
 arch/arm64/kernel/cpu_errata.c   |  6 +++---
 arch/arm64/kernel/proton-pack.c  | 13 ++++++++++---
 arch/arm64/kvm/arm.c             |  8 ++++----
 arch/arm64/kvm/hyp/hyp-entry.S   |  3 +--
 arch/arm64/kvm/va_layout.c       |  4 +---
 8 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/Documentation/arm64/memory.rst b/Documentation/arm64/memory.rst
index cf03b3290800..75df7fb30a7b 100644
--- a/Documentation/arm64/memory.rst
+++ b/Documentation/arm64/memory.rst
@@ -100,7 +100,7 @@ hypervisor maps kernel pages in EL2 at a fixed (and potentially
 random) offset from the linear mapping. See the kern_hyp_va macro and
 kvm_update_va_mask function for more details. MMIO devices such as
 GICv2 gets mapped next to the HYP idmap page, as do vectors when
-ARM64_HARDEN_EL2_VECTORS is selected for particular CPUs.
+ARM64_SPECTRE_V3A is enabled for particular CPUs.
 
 When using KVM with the Virtualization Host Extensions, no additional
 mappings are created, since the host kernel runs directly in EL2.
diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index e7d98997c09c..162539d4c8cd 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -21,7 +21,7 @@
 #define ARM64_HAS_VIRT_HOST_EXTN		11
 #define ARM64_WORKAROUND_CAVIUM_27456		12
 #define ARM64_HAS_32BIT_EL0			13
-#define ARM64_HARDEN_EL2_VECTORS		14
+#define ARM64_SPECTRE_V3A			14
 #define ARM64_HAS_CNP				15
 #define ARM64_HAS_NO_FPSIMD			16
 #define ARM64_WORKAROUND_REPEAT_TLBI		17
diff --git a/arch/arm64/include/asm/spectre.h b/arch/arm64/include/asm/spectre.h
index fa86b8f655b7..b4df683ed800 100644
--- a/arch/arm64/include/asm/spectre.h
+++ b/arch/arm64/include/asm/spectre.h
@@ -83,7 +83,7 @@ enum mitigation_state arm64_get_spectre_v2_state(void);
 bool has_spectre_v2(const struct arm64_cpu_capabilities *cap, int scope);
 void spectre_v2_enable_mitigation(const struct arm64_cpu_capabilities *__unused);
 
-void cpu_el2_vector_harden_enable(const struct arm64_cpu_capabilities *__unused);
+void spectre_v3a_enable_mitigation(const struct arm64_cpu_capabilities *__unused);
 
 enum mitigation_state arm64_get_spectre_v4_state(void);
 bool has_spectre_v4(const struct arm64_cpu_capabilities *cap, int scope);
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 7a040abaedea..949d5615a47e 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -460,10 +460,10 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 #ifdef CONFIG_RANDOMIZE_BASE
 	{
 	/* Must come after the Spectre-v2 entry */
-		.desc = "EL2 vector hardening",
-		.capability = ARM64_HARDEN_EL2_VECTORS,
+		.desc = "Spectre-v3a",
+		.capability = ARM64_SPECTRE_V3A,
 		ERRATA_MIDR_RANGE_LIST(ca57_a72),
-		.cpu_enable = cpu_el2_vector_harden_enable,
+		.cpu_enable = spectre_v3a_enable_mitigation,
 	},
 #endif
 	{
diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index a4ba94129750..cf9f8b885aea 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Handle detection, reporting and mitigation of Spectre v1, v2 and v4, as
+ * Handle detection, reporting and mitigation of Spectre v1, v2, v3a and v4, as
  * detailed at:
  *
  *   https://developer.arm.com/support/arm-security-updates/speculative-processor-vulnerability
@@ -270,11 +270,18 @@ void spectre_v2_enable_mitigation(const struct arm64_cpu_capabilities *__unused)
 	update_mitigation_state(&spectre_v2_state, state);
 }
 
-void cpu_el2_vector_harden_enable(const struct arm64_cpu_capabilities *__unused)
+/*
+ * Spectre-v3a.
+ *
+ * Phew, there's not an awful lot to do here! We just instruct EL2 to use
+ * an indirect trampoline for the hyp vectors so that guests can't read
+ * VBAR_EL2 to defeat randomisation of the hypervisor VA layout.
+ */
+void spectre_v3a_enable_mitigation(const struct arm64_cpu_capabilities *__unused)
 {
 	struct bp_hardening_data *data = this_cpu_ptr(&bp_hardening_data);
 
-	if (this_cpu_has_cap(ARM64_HARDEN_EL2_VECTORS))
+	if (this_cpu_has_cap(ARM64_SPECTRE_V3A))
 		data->slot += HYP_VECTOR_INDIRECT;
 }
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 80653fd67f66..d94b12376d62 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1314,7 +1314,7 @@ static int kvm_init_vector_slots(void)
 	base = kern_hyp_va(kvm_ksym_ref(__bp_harden_hyp_vecs));
 	kvm_init_vector_slot(base, HYP_VECTOR_SPECTRE_DIRECT);
 
-	if (!cpus_have_const_cap(ARM64_HARDEN_EL2_VECTORS))
+	if (!cpus_have_const_cap(ARM64_SPECTRE_V3A))
 		return 0;
 
 	if (!has_vhe()) {
@@ -1388,15 +1388,15 @@ static void cpu_hyp_reset(void)
  *   placed in one of the vector slots, which is executed before jumping
  *   to the real vectors.
  *
- * - If the CPU also has the ARM64_HARDEN_EL2_VECTORS cap, the slot
+ * - If the CPU also has the ARM64_SPECTRE_V3A cap, the slot
  *   containing the hardening sequence is mapped next to the idmap page,
  *   and executed before jumping to the real vectors.
  *
- * - If the CPU only has the ARM64_HARDEN_EL2_VECTORS cap, then an
+ * - If the CPU only has the ARM64_SPECTRE_V3A cap, then an
  *   empty slot is selected, mapped next to the idmap page, and
  *   executed before jumping to the real vectors.
  *
- * Note that ARM64_HARDEN_EL2_VECTORS is somewhat incompatible with
+ * Note that ARM64_SPECTRE_V3A is somewhat incompatible with
  * VHE, as we don't have hypervisor-specific mappings. If the system
  * is VHE and yet selects this capability, it will be ignored.
  */
diff --git a/arch/arm64/kvm/hyp/hyp-entry.S b/arch/arm64/kvm/hyp/hyp-entry.S
index d0a3660c7256..e3249e2dda09 100644
--- a/arch/arm64/kvm/hyp/hyp-entry.S
+++ b/arch/arm64/kvm/hyp/hyp-entry.S
@@ -209,8 +209,7 @@ SYM_CODE_END(__kvm_hyp_vector)
 	.if \indirect != 0
 	alternative_cb  kvm_patch_vector_branch
 	/*
-	 * For ARM64_HARDEN_EL2_VECTORS configurations, these NOPs get replaced
-	 * with:
+	 * For ARM64_SPECTRE_V3A configurations, these NOPs get replaced with:
 	 *
 	 * movz	x0, #(addr & 0xffff)
 	 * movk	x0, #((addr >> 16) & 0xffff), lsl #16
diff --git a/arch/arm64/kvm/va_layout.c b/arch/arm64/kvm/va_layout.c
index cc8e8756600f..02362fa27be4 100644
--- a/arch/arm64/kvm/va_layout.c
+++ b/arch/arm64/kvm/va_layout.c
@@ -139,10 +139,8 @@ void kvm_patch_vector_branch(struct alt_instr *alt,
 
 	BUG_ON(nr_inst != 4);
 
-	if (!cpus_have_const_cap(ARM64_HARDEN_EL2_VECTORS) ||
-	    WARN_ON_ONCE(has_vhe())) {
+	if (!cpus_have_const_cap(ARM64_SPECTRE_V3A) || WARN_ON_ONCE(has_vhe()))
 		return;
-	}
 
 	/*
 	 * Compute HYP VA by using the same computation as kern_hyp_va()
-- 
2.29.2.299.gdc1121823c-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
