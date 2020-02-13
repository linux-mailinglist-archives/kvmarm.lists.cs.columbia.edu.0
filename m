Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 46A6D15C2A4
	for <lists+kvmarm@lfdr.de>; Thu, 13 Feb 2020 16:38:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AD7EA4AC77;
	Thu, 13 Feb 2020 10:38:30 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8vQdJMhIUNqQ; Thu, 13 Feb 2020 10:38:30 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 491AC4A97D;
	Thu, 13 Feb 2020 10:38:29 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4A02E4A65C
 for <kvmarm@lists.cs.columbia.edu>; Thu, 13 Feb 2020 10:38:28 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ScVLYKUBpOgm for <kvmarm@lists.cs.columbia.edu>;
 Thu, 13 Feb 2020 10:38:27 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DEA734A5A3
 for <kvmarm@lists.cs.columbia.edu>; Thu, 13 Feb 2020 10:38:26 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7378A328;
 Thu, 13 Feb 2020 07:38:26 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E92323F68E;
 Thu, 13 Feb 2020 07:38:25 -0800 (PST)
From: Mark Brown <broonie@kernel.org>
To: Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
 Julien Thierry <julien.thierry.kdev@gmail.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH] arm64: kvm: Annotate assembly using modern annoations
Date: Thu, 13 Feb 2020 15:38:20 +0000
Message-Id: <20200213153820.32049-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
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

In an effort to clarify and simplify the annotation of assembly functions
in the kernel new macros have been introduced. These replace ENTRY and
ENDPROC with separate annotations for standard C callable functions,
data and code with different calling conventions.  Update the
annotations in the kvm code to the new macros.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kvm/hyp-init.S      |  8 ++++----
 arch/arm64/kvm/hyp.S           |  4 ++--
 arch/arm64/kvm/hyp/fpsimd.S    |  8 ++++----
 arch/arm64/kvm/hyp/hyp-entry.S | 27 ++++++++++++++++-----------
 4 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/kvm/hyp-init.S b/arch/arm64/kvm/hyp-init.S
index 160be2b4696d..84f32cf5abc7 100644
--- a/arch/arm64/kvm/hyp-init.S
+++ b/arch/arm64/kvm/hyp-init.S
@@ -18,7 +18,7 @@
 
 	.align	11
 
-ENTRY(__kvm_hyp_init)
+SYM_CODE_START(__kvm_hyp_init)
 	ventry	__invalid		// Synchronous EL2t
 	ventry	__invalid		// IRQ EL2t
 	ventry	__invalid		// FIQ EL2t
@@ -117,9 +117,9 @@ CPU_BE(	orr	x4, x4, #SCTLR_ELx_EE)
 
 	/* Hello, World! */
 	eret
-ENDPROC(__kvm_hyp_init)
+SYM_CODE_END(__kvm_hyp_init)
 
-ENTRY(__kvm_handle_stub_hvc)
+SYM_CODE_START(__kvm_handle_stub_hvc)
 	cmp	x0, #HVC_SOFT_RESTART
 	b.ne	1f
 
@@ -158,7 +158,7 @@ reset:
 	ldr	x0, =HVC_STUB_ERR
 	eret
 
-ENDPROC(__kvm_handle_stub_hvc)
+SYM_CODE_END(__kvm_handle_stub_hvc)
 
 	.ltorg
 
diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
index c0094d520dff..3c79a1124af2 100644
--- a/arch/arm64/kvm/hyp.S
+++ b/arch/arm64/kvm/hyp.S
@@ -28,7 +28,7 @@
  * and is used to implement hyp stubs in the same way as in
  * arch/arm64/kernel/hyp_stub.S.
  */
-ENTRY(__kvm_call_hyp)
+SYM_FUNC_START(__kvm_call_hyp)
 	hvc	#0
 	ret
-ENDPROC(__kvm_call_hyp)
+SYM_FUNC_END(__kvm_call_hyp)
diff --git a/arch/arm64/kvm/hyp/fpsimd.S b/arch/arm64/kvm/hyp/fpsimd.S
index 78ff53225691..5b8ff517ff10 100644
--- a/arch/arm64/kvm/hyp/fpsimd.S
+++ b/arch/arm64/kvm/hyp/fpsimd.S
@@ -11,12 +11,12 @@
 	.text
 	.pushsection	.hyp.text, "ax"
 
-ENTRY(__fpsimd_save_state)
+SYM_FUNC_START(__fpsimd_save_state)
 	fpsimd_save	x0, 1
 	ret
-ENDPROC(__fpsimd_save_state)
+SYM_FUNC_END(__fpsimd_save_state)
 
-ENTRY(__fpsimd_restore_state)
+SYM_FUNC_START(__fpsimd_restore_state)
 	fpsimd_restore	x0, 1
 	ret
-ENDPROC(__fpsimd_restore_state)
+SYM_FUNC_END(__fpsimd_restore_state)
diff --git a/arch/arm64/kvm/hyp/hyp-entry.S b/arch/arm64/kvm/hyp/hyp-entry.S
index ffa68d5713f1..f7b0cb189b77 100644
--- a/arch/arm64/kvm/hyp/hyp-entry.S
+++ b/arch/arm64/kvm/hyp/hyp-entry.S
@@ -180,7 +180,7 @@ el2_error:
 	eret
 	sb
 
-ENTRY(__hyp_do_panic)
+SYM_FUNC_START(__hyp_do_panic)
 	mov	lr, #(PSR_F_BIT | PSR_I_BIT | PSR_A_BIT | PSR_D_BIT |\
 		      PSR_MODE_EL1h)
 	msr	spsr_el2, lr
@@ -188,18 +188,19 @@ ENTRY(__hyp_do_panic)
 	msr	elr_el2, lr
 	eret
 	sb
-ENDPROC(__hyp_do_panic)
+SYM_FUNC_END(__hyp_do_panic)
 
-ENTRY(__hyp_panic)
+SYM_CODE_START(__hyp_panic)
 	get_host_ctxt x0, x1
 	b	hyp_panic
-ENDPROC(__hyp_panic)
+SYM_CODE_END(__hyp_panic)
 
 .macro invalid_vector	label, target = __hyp_panic
 	.align	2
+SYM_CODE_START(\label)
 \label:
 	b \target
-ENDPROC(\label)
+SYM_CODE_END(\label)
 .endm
 
 	/* None of these should ever happen */
@@ -246,7 +247,7 @@ check_preamble_length 661b, 662b
 check_preamble_length 661b, 662b
 .endm
 
-ENTRY(__kvm_hyp_vector)
+SYM_CODE_START(__kvm_hyp_vector)
 	invalid_vect	el2t_sync_invalid	// Synchronous EL2t
 	invalid_vect	el2t_irq_invalid	// IRQ EL2t
 	invalid_vect	el2t_fiq_invalid	// FIQ EL2t
@@ -266,7 +267,7 @@ ENTRY(__kvm_hyp_vector)
 	valid_vect	el1_irq			// IRQ 32-bit EL1
 	invalid_vect	el1_fiq_invalid		// FIQ 32-bit EL1
 	valid_vect	el1_error		// Error 32-bit EL1
-ENDPROC(__kvm_hyp_vector)
+SYM_CODE_END(__kvm_hyp_vector)
 
 #ifdef CONFIG_KVM_INDIRECT_VECTORS
 .macro hyp_ventry
@@ -311,15 +312,18 @@ alternative_cb_end
 .endm
 
 	.align	11
-ENTRY(__bp_harden_hyp_vecs_start)
+SYM_CODE_START_NOALIGN(__bp_harden_hyp_vecs)
+SYM_INNER_LABEL(__bp_harden_hyp_vecs_start, SYM_L_GLOBAL)
 	.rept BP_HARDEN_EL2_SLOTS
 	generate_vectors
 	.endr
-ENTRY(__bp_harden_hyp_vecs_end)
+SYM_INNER_LABEL(__bp_harden_hyp_vecs_end, SYM_L_GLOBAL)
+SYM_CODE_END(__bp_harden_hyp_vecs)
 
 	.popsection
 
-ENTRY(__smccc_workaround_1_smc_start)
+SYM_CODE_START(__smccc_workaround_1_smc)
+SYM_INNER_LABEL(__smccc_workaround_1_smc_start, SYM_L_GLOBAL)
 	esb
 	sub	sp, sp, #(8 * 4)
 	stp	x2, x3, [sp, #(8 * 0)]
@@ -329,5 +333,6 @@ ENTRY(__smccc_workaround_1_smc_start)
 	ldp	x2, x3, [sp, #(8 * 0)]
 	ldp	x0, x1, [sp, #(8 * 2)]
 	add	sp, sp, #(8 * 4)
-ENTRY(__smccc_workaround_1_smc_end)
+SYM_INNER_LABEL(__smccc_workaround_1_smc_end, SYM_L_GLOBAL)
+SYM_CODE_END(__smccc_workaround_1_smc)
 #endif
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
