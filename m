Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id AD8B453FFEC
	for <lists+kvmarm@lfdr.de>; Tue,  7 Jun 2022 15:23:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5BE8F4B345;
	Tue,  7 Jun 2022 09:23:45 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.788
X-Spam-Level: 
X-Spam-Status: No, score=-1.788 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, RCVD_IN_DNSWL_BLOCKED=0.001, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kJnLnB26vR1i; Tue,  7 Jun 2022 09:23:44 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 748344B32E;
	Tue,  7 Jun 2022 09:23:43 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 014D04B35C
 for <kvmarm@lists.cs.columbia.edu>; Tue,  7 Jun 2022 09:23:42 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IHX++U96l45n for <kvmarm@lists.cs.columbia.edu>;
 Tue,  7 Jun 2022 09:23:40 -0400 (EDT)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id CD4FA4B365
 for <kvmarm@lists.cs.columbia.edu>; Tue,  7 Jun 2022 09:23:40 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 59D24612D2;
 Tue,  7 Jun 2022 13:23:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14ED2C3411E;
 Tue,  7 Jun 2022 13:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1654608220;
 bh=iK+28OfoTgS5P7l37Hi272/v3k7C+dZGiXW3nNkiDPg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=l/ByQfYxNZk4q1/fvqp0hTMnJwL2roqNTFAGNsZEAcBpYzO/r0PExNBrI15XwEonf
 dohicsRhjz62gTh8FovcItwx1F3V15K1wLCgUNdN7U0nBsv4uVLuGKcs6gSmRe3ILk
 0z+HIx9oN0FFNQtAwljtzgomBe7Sv6mTJKopuPyqdAb2WMHZDQhZTopSoP3d7DuZJW
 SC4ua4LWQBjL4KEqwqxX54ZJA7IrOvpit2/03weKbM/SBtqXQTy49IbIcwmi+L9kiA
 JAPMWG9tJXMsksLzacqi1EXZggiHNLI+ljFpnLN52XY0lJa3CS+uDhBKVDp0B39Unx
 sILJ5/YJASLIQ==
From: Mark Brown <broonie@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH v1 6/7] arm64/sve: Leave SVE enabled on syscall if we don't
 context switch
Date: Tue,  7 Jun 2022 14:17:34 +0100
Message-Id: <20220607131735.1300726-7-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220607131735.1300726-1-broonie@kernel.org>
References: <20220607131735.1300726-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3722; h=from:subject;
 bh=iK+28OfoTgS5P7l37Hi272/v3k7C+dZGiXW3nNkiDPg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBin0/sa14t8F8z3XA/UVTZe/Et1p1+V0Dc2+U6+XjE
 QXr3RLaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYp9P7AAKCRAk1otyXVSH0KxxCA
 CBjnGvGHZHN52tPHSfJqMgH51XhSDtkPeD8h2EjNrxpP+thYlvuQ5de7tWK7cfrbWlJUiJI9neo8c0
 bk9dW7WPP50XKn9xN5NcdhX2bvQ/EDNEimmuzoa2CtBsqdx1l8iQhcMVI08QwFO2gSAxuUTityNHeV
 mx797AkkYbLctajshUi2W+5fQrQr38gS5bBx1+p5d4TornXQsqypMG2EvYKAkCtN3azT6XAAnXRzaz
 pkr0TM2D5OJ/vfk/TXOgFmhUFkEjuR1+mvwTsjakHY5yVFNOm71Etk5MzP2sdLmptnoNLmS4rv1qGl
 xyrPNo3K5KhbHXQOZftwAs6b4nR0S/
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Cc: Marc Zyngier <maz@kernel.org>, Zhang Lei <zhang.lei@jp.fujitsu.com>,
 Mark Brown <broonie@kernel.org>, Andre Przywara <andre.przywara@arm.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

The syscall ABI says that the SVE register state not shared with FPSIMD
may not be preserved on syscall, and this is the only mechanism we have
in the ABI to stop tracking the extra SVE state for a process. Currently
we do this unconditionally by means of disabling SVE for the process on
syscall, causing userspace to take a trap to EL1 if it uses SVE again.
These extra traps result in a noticeable overhead for using SVE instead
of FPSIMD in some workloads, especially for simple syscalls where we can
return directly to userspace and would not otherwise need to update the
floating point registers. Tests with fp-pidbench show an approximately
70% overhead on a range of implementations when SVE is in use - while
this is an extreme and entirely artificial benchmark it is clear that
there is some useful room for improvement here.

Now that we have the ability to track the decision about what to save
seprately to TIF_SVE we can improve things by leaving TIF_SVE enabled on
syscall but only saving the FPSIMD registers if we are in a syscall.
This means that if we need to restore the register state from memory
(eg, after a context switch or kernel mode NEON) we will drop TIF_SVE
and reenable traps for userspace but if we can just return to userspace
then traps will remain disabled.

Since our current implementation has the effect of zeroing all the SVE
register state not shared with FPSIMD on syscall we replace the
disabling of TIF_SVE with a flush of the non-shared register state, this
means that there is still some overhead for syscalls when SVE is in use
but it is much reduced.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/fpsimd.c  |  8 +++++++-
 arch/arm64/kernel/syscall.c | 19 +++++--------------
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index e7d5eea39e0c..72d7f42de39d 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -477,7 +477,13 @@ static void fpsimd_save(void)
 	if (test_thread_flag(TIF_FOREIGN_FPSTATE))
 		return;
 
-	if ((last->to_save == FP_STATE_TASK && test_thread_flag(TIF_SVE)) ||
+	/*
+	 * If a task is in a syscall the ABI allows us to only
+	 * preserve the state shared with FPSIMD so don't bother
+	 * saving the full SVE state in that case.
+	 */
+	if ((last->to_save == FP_STATE_TASK && test_thread_flag(TIF_SVE) &&
+	     !in_syscall(current_pt_regs())) ||
 	    last->to_save == FP_STATE_SVE) {
 		save_sve_regs = true;
 		save_ffr = true;
diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index 733451fe7e41..69b4c06f2e39 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -183,21 +183,12 @@ static inline void fp_user_discard(void)
 	if (!system_supports_sve())
 		return;
 
-	/*
-	 * If SME is not active then disable SVE, the registers will
-	 * be cleared when userspace next attempts to access them and
-	 * we do not need to track the SVE register state until then.
-	 */
-	clear_thread_flag(TIF_SVE);
+	if (test_thread_flag(TIF_SVE)) {
+		unsigned int sve_vq_minus_one;
 
-	/*
-	 * task_fpsimd_load() won't be called to update CPACR_EL1 in
-	 * ret_to_user unless TIF_FOREIGN_FPSTATE is still set, which only
-	 * happens if a context switch or kernel_neon_begin() or context
-	 * modification (sigreturn, ptrace) intervenes.
-	 * So, ensure that CPACR_EL1 is already correct for the fast-path case.
-	 */
-	sve_user_disable();
+		sve_vq_minus_one = sve_vq_from_vl(task_get_sve_vl(current)) - 1;
+		sve_flush_live(true, sve_vq_minus_one);
+	}
 }
 
 void do_el0_svc(struct pt_regs *regs)
-- 
2.30.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
