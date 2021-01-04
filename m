Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E21E32E9658
	for <lists+kvmarm@lfdr.de>; Mon,  4 Jan 2021 14:50:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 987E14B291;
	Mon,  4 Jan 2021 08:50:52 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Mb8xwkngfF3f; Mon,  4 Jan 2021 08:50:51 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6832D4B2EA;
	Mon,  4 Jan 2021 08:50:48 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2B94B4B26E
 for <kvmarm@lists.cs.columbia.edu>; Mon,  4 Jan 2021 08:50:47 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ou8N7YRNXccZ for <kvmarm@lists.cs.columbia.edu>;
 Mon,  4 Jan 2021 08:50:46 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id C94944B288
 for <kvmarm@lists.cs.columbia.edu>; Mon,  4 Jan 2021 08:50:43 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EC76C221F9;
 Mon,  4 Jan 2021 13:50:42 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1kwQFt-005E24-6q; Mon, 04 Jan 2021 13:50:41 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.cs.columbia.edu
Subject: [PATCH v2 05/17] arm64: Initialise as nVHE before switching to VHE
Date: Mon,  4 Jan 2021 13:49:59 +0000
Message-Id: <20210104135011.2063104-6-maz@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210104135011.2063104-1-maz@kernel.org>
References: <20210104135011.2063104-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, catalin.marinas@arm.com, will@kernel.org,
 mark.rutland@arm.com, dbrazdil@google.com, alexandru.elisei@arm.com,
 ardb@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com,
 suzuki.poulose@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>
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

As we are aiming to be able to control whether we enable VHE or
not, let's always drop down to EL1 first, and only then upgrade
to VHE if at all possible.

This means that if the kernel is booted at EL2, we always start
with a nVHE init, drop to EL1 to initialise the the kernel, and
only then upgrade the kernel EL to EL2 if possible (the process
is obviously shortened for secondary CPUs).

The resume path is handled similarly to a secondary CPU boot.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kernel/head.S     | 38 ++----------------------------------
 arch/arm64/kernel/hyp-stub.S | 24 +++++++++++++++++++++++
 arch/arm64/kernel/sleep.S    |  1 +
 3 files changed, 27 insertions(+), 36 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 28e9735302df..07445fd976ef 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -433,6 +433,7 @@ SYM_FUNC_START_LOCAL(__primary_switched)
 	bl	__pi_memset
 	dsb	ishst				// Make zero page visible to PTW
 
+	bl	switch_to_vhe
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 	bl	kasan_early_init
 #endif
@@ -493,42 +494,6 @@ SYM_INNER_LABEL(init_el1, SYM_L_LOCAL)
 	eret
 
 SYM_INNER_LABEL(init_el2, SYM_L_LOCAL)
-#ifdef CONFIG_ARM64_VHE
-	/*
-	 * Check for VHE being present. x2 being non-zero indicates that we
-	 * do have VHE, and that the kernel is intended to run at EL2.
-	 */
-	mrs	x2, id_aa64mmfr1_el1
-	ubfx	x2, x2, #ID_AA64MMFR1_VHE_SHIFT, #4
-#else
-	mov	x2, xzr
-#endif
-	cbz	x2, init_el2_nvhe
-
-	/*
-	 * When VHE _is_ in use, EL1 will not be used in the host and
-	 * requires no configuration, and all non-hyp-specific EL2 setup
-	 * will be done via the _EL1 system register aliases in __cpu_setup.
-	 */
-	mov_q	x0, HCR_HOST_VHE_FLAGS
-	msr	hcr_el2, x0
-	isb
-
-	init_el2_state vhe
-
-	isb
-
-	mov_q	x0, INIT_PSTATE_EL2
-	msr	spsr_el2, x0
-	msr	elr_el2, lr
-	mov	w0, #BOOT_CPU_MODE_EL2
-	eret
-
-SYM_INNER_LABEL(init_el2_nvhe, SYM_L_LOCAL)
-	/*
-	 * When VHE is not in use, early init of EL2 and EL1 needs to be
-	 * done here.
-	 */
 	mov_q	x0, INIT_SCTLR_EL1_MMU_OFF
 	msr	sctlr_el1, x0
 
@@ -623,6 +588,7 @@ SYM_FUNC_START_LOCAL(secondary_startup)
 	/*
 	 * Common entry point for secondary CPUs.
 	 */
+	bl	switch_to_vhe
 	bl	__cpu_secondary_check52bitva
 	bl	__cpu_setup			// initialise processor
 	adrp	x1, swapper_pg_dir
diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
index 6ffdc1f7778b..b727848bd0ec 100644
--- a/arch/arm64/kernel/hyp-stub.S
+++ b/arch/arm64/kernel/hyp-stub.S
@@ -184,3 +184,27 @@ SYM_FUNC_START(__hyp_reset_vectors)
 	hvc	#0
 	ret
 SYM_FUNC_END(__hyp_reset_vectors)
+
+/*
+ * Entry point to switch to VHE if deemed capable
+ */
+SYM_FUNC_START(switch_to_vhe)
+#ifdef CONFIG_ARM64_VHE
+	// Need to have booted at EL2
+	adr_l	x1, __boot_cpu_mode
+	ldr	w0, [x1]
+	cmp	w0, #BOOT_CPU_MODE_EL2
+	b.ne	1f
+
+	// and still be at EL1
+	mrs	x0, CurrentEL
+	cmp	x0, #CurrentEL_EL1
+	b.ne	1f
+
+	// Turn the world upside down
+	mov	x0, #HVC_VHE_RESTART
+	hvc	#0
+1:
+#endif
+	ret
+SYM_FUNC_END(switch_to_vhe)
diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
index 6bdef7362c0e..5bfd9b87f85d 100644
--- a/arch/arm64/kernel/sleep.S
+++ b/arch/arm64/kernel/sleep.S
@@ -100,6 +100,7 @@ SYM_FUNC_END(__cpu_suspend_enter)
 	.pushsection ".idmap.text", "awx"
 SYM_CODE_START(cpu_resume)
 	bl	init_kernel_el
+	bl	switch_to_vhe
 	bl	__cpu_setup
 	/* enable the MMU early - so we can access sleep_save_stash by va */
 	adrp	x1, swapper_pg_dir
-- 
2.29.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
