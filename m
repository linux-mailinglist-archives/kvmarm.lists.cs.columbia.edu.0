Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 205773B957
	for <lists+kvmarm@lfdr.de>; Mon, 10 Jun 2019 18:24:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C1A754A4DF;
	Mon, 10 Jun 2019 12:24:50 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OGTAkeet4mr7; Mon, 10 Jun 2019 12:24:50 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0853A4A525;
	Mon, 10 Jun 2019 12:24:49 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 356214A52C
 for <kvmarm@lists.cs.columbia.edu>; Mon, 10 Jun 2019 12:24:47 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2wqjfJb9VHa5 for <kvmarm@lists.cs.columbia.edu>;
 Mon, 10 Jun 2019 12:24:46 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8216B4A512
 for <kvmarm@lists.cs.columbia.edu>; Mon, 10 Jun 2019 12:24:45 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30F73337;
 Mon, 10 Jun 2019 09:24:45 -0700 (PDT)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 131743F246;
 Mon, 10 Jun 2019 09:24:43 -0700 (PDT)
From: James Morse <james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.cs.columbia.edu
Subject: [PATCH v2 4/6] KVM: arm64: Consume pending SError as early as possible
Date: Mon, 10 Jun 2019 17:24:25 +0100
Message-Id: <20190610162427.115910-5-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190610162427.115910-1-james.morse@arm.com>
References: <20190610162427.115910-1-james.morse@arm.com>
MIME-Version: 1.0
Cc: Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
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

On systems with v8.2 we switch the 'vaxorcism' of guest SError with an
alternative sequence that uses the ESB-instruction, then reads DISR_EL1.
This saves the unmasking and remasking of asyncronous exceptions.

We do this after we've saved the guest registers and restored the
host's. Any SError that becomes pending due to this will be accounted
to the guest, when it actually occurred during host-execution.

Move the ESB-instruction as early as possible. Any guest SError
will become pending due to this ESB-instruction and then consumed to
DISR_EL1 before the host touches anything.

This lets us account for host/guest SError precisely on the guest
exit exception boundary.

Because the ESB-instruction now lands in the preamble section of
the vectors, we need to add it to the unpatched indirect vectors
too, and to any sequence that may be patched in over the top.

The ESB-instruction always lives in the head of the vectors,
to be before any memory write. Whereas the register-store always
lives in the tail.

Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v1:
 * nop in the invalid vector, now that we check its size
 * esb in the unpatched head for
   ARM64_HARDEN_EL2_VECTORS && !_HARDEN_BRANCH_PREDICTOR

 arch/arm64/include/asm/kvm_asm.h | 2 +-
 arch/arm64/kvm/hyp/entry.S       | 5 ++---
 arch/arm64/kvm/hyp/hyp-entry.S   | 6 +++++-
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 96c2d79063aa..38b46ce1dfee 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -45,7 +45,7 @@
  * Size of the HYP vectors preamble. kvm_patch_vector_branch() generates code
  * that jumps over this.
  */
-#define KVM_VECTOR_PREAMBLE	(1 * AARCH64_INSN_SIZE)
+#define KVM_VECTOR_PREAMBLE	(2 * AARCH64_INSN_SIZE)
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/arm64/kvm/hyp/entry.S b/arch/arm64/kvm/hyp/entry.S
index 93ba3d7ef027..7863ec5266e2 100644
--- a/arch/arm64/kvm/hyp/entry.S
+++ b/arch/arm64/kvm/hyp/entry.S
@@ -138,8 +138,8 @@ ENTRY(__guest_exit)
 
 alternative_if ARM64_HAS_RAS_EXTN
 	// If we have the RAS extensions we can consume a pending error
-	// without an unmask-SError and isb.
-	esb
+	// without an unmask-SError and isb. The ESB-instruction consumed any
+	// pending guest error when we took the exception from the guest.
 	mrs_s	x2, SYS_DISR_EL1
 	str	x2, [x1, #(VCPU_FAULT_DISR - VCPU_CONTEXT)]
 	cbz	x2, 1f
@@ -157,7 +157,6 @@ alternative_else
 	mov	x5, x0
 
 	dsb	sy		// Synchronize against in-flight ld/st
-	nop
 	msr	daifclr, #4	// Unmask aborts
 alternative_endif
 
diff --git a/arch/arm64/kvm/hyp/hyp-entry.S b/arch/arm64/kvm/hyp/hyp-entry.S
index 5f0412f124a3..8fbfac35f83f 100644
--- a/arch/arm64/kvm/hyp/hyp-entry.S
+++ b/arch/arm64/kvm/hyp/hyp-entry.S
@@ -237,6 +237,7 @@ ENDPROC(\label)
 .macro valid_vect target
 	.align 7
 661:
+	esb
 	stp	x0, x1, [sp, #-16]!
 662:
 	b	\target
@@ -248,6 +249,7 @@ check_preamble_length 661b, 662b
 	.align 7
 661:
 	b	\target
+	nop
 662:
 	ldp	x0, x1, [sp], #16
 	b	\target
@@ -280,7 +282,8 @@ ENDPROC(__kvm_hyp_vector)
 #ifdef CONFIG_KVM_INDIRECT_VECTORS
 .macro hyp_ventry
 	.align 7
-1:	.rept 27
+1:	esb
+	.rept 26
 	nop
 	.endr
 /*
@@ -328,6 +331,7 @@ ENTRY(__bp_harden_hyp_vecs_end)
 	.popsection
 
 ENTRY(__smccc_workaround_1_smc_start)
+	esb
 	sub	sp, sp, #(8 * 4)
 	stp	x2, x3, [sp, #(8 * 0)]
 	stp	x0, x1, [sp, #(8 * 2)]
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
