Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A2A4C2E360E
	for <lists+kvmarm@lfdr.de>; Mon, 28 Dec 2020 11:50:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 582C54B20C;
	Mon, 28 Dec 2020 05:50:12 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CodFjdHeQKOh; Mon, 28 Dec 2020 05:50:11 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3866B4B223;
	Mon, 28 Dec 2020 05:50:11 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D62EC4B1F9
 for <kvmarm@lists.cs.columbia.edu>; Mon, 28 Dec 2020 05:50:07 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oyvLgP7dfn+6 for <kvmarm@lists.cs.columbia.edu>;
 Mon, 28 Dec 2020 05:50:06 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A50494B202
 for <kvmarm@lists.cs.columbia.edu>; Mon, 28 Dec 2020 05:50:06 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CD3E2229C6;
 Mon, 28 Dec 2020 10:50:05 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1ktq6G-0048wX-4m; Mon, 28 Dec 2020 10:50:04 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.cs.columbia.edu
Subject: [PATCH 03/17] arm64: Turn the MMU-on sequence into a macro
Date: Mon, 28 Dec 2020 10:49:44 +0000
Message-Id: <20201228104958.1848833-4-maz@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201228104958.1848833-1-maz@kernel.org>
References: <20201228104958.1848833-1-maz@kernel.org>
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

Turning the MMU on is a popular sport in the arm64 kernel, and
we do it more than once, or even twice. As we are about to add
even more, let's turn it into a macro.

No expected functional change.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/assembler.h | 17 +++++++++++++++++
 arch/arm64/kernel/head.S           | 19 ++++---------------
 arch/arm64/mm/proc.S               | 12 +-----------
 3 files changed, 22 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index bf125c591116..8cded93f99c3 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -675,6 +675,23 @@ USER(\label, ic	ivau, \tmp2)			// invalidate I line PoU
 	.endif
 	.endm
 
+/*
+ * Set SCTLR_EL1 to the passed value, and invalidate the local icache
+ * in the process. This is called when setting the MMU on.
+ */
+.macro set_sctlr_el1, reg
+	msr	sctlr_el1, \reg
+	isb
+	/*
+	 * Invalidate the local I-cache so that any instructions fetched
+	 * speculatively from the PoC are discarded, since they may have
+	 * been dynamically patched at the PoU.
+	 */
+	ic	iallu
+	dsb	nsh
+	isb
+.endm
+
 /*
  * Check whether to yield to another runnable task from kernel mode NEON code
  * (which runs with preemption disabled).
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index a0dc987724ed..28e9735302df 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -703,16 +703,9 @@ SYM_FUNC_START(__enable_mmu)
 	offset_ttbr1 x1, x3
 	msr	ttbr1_el1, x1			// load TTBR1
 	isb
-	msr	sctlr_el1, x0
-	isb
-	/*
-	 * Invalidate the local I-cache so that any instructions fetched
-	 * speculatively from the PoC are discarded, since they may have
-	 * been dynamically patched at the PoU.
-	 */
-	ic	iallu
-	dsb	nsh
-	isb
+
+	set_sctlr_el1	x0
+
 	ret
 SYM_FUNC_END(__enable_mmu)
 
@@ -883,11 +876,7 @@ SYM_FUNC_START_LOCAL(__primary_switch)
 	tlbi	vmalle1				// Remove any stale TLB entries
 	dsb	nsh
 
-	msr	sctlr_el1, x19			// re-enable the MMU
-	isb
-	ic	iallu				// flush instructions fetched
-	dsb	nsh				// via old mapping
-	isb
+	set_sctlr_el1	x19			// re-enable the MMU
 
 	bl	__relocate_kernel
 #endif
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 80832ba33ce7..09d40ec33a8c 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -291,17 +291,7 @@ skip_pgd:
 	/* We're done: fire up the MMU again */
 	mrs	x17, sctlr_el1
 	orr	x17, x17, #SCTLR_ELx_M
-	msr	sctlr_el1, x17
-	isb
-
-	/*
-	 * Invalidate the local I-cache so that any instructions fetched
-	 * speculatively from the PoC are discarded, since they may have
-	 * been dynamically patched at the PoU.
-	 */
-	ic	iallu
-	dsb	nsh
-	isb
+	set_sctlr_el1	x17
 
 	/* Set the flag to zero to indicate that we're all done */
 	str	wzr, [flag_ptr]
-- 
2.29.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
