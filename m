Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2790A4D6E5E
	for <lists+kvmarm@lfdr.de>; Sat, 12 Mar 2022 12:16:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B01F449F00;
	Sat, 12 Mar 2022 06:16:47 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@linuxfoundation.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4Duy3IouMsun; Sat, 12 Mar 2022 06:16:47 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6022B49EF0;
	Sat, 12 Mar 2022 06:16:46 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 434C040FB2
 for <kvmarm@lists.cs.columbia.edu>; Sat, 12 Mar 2022 06:16:45 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wQ4kD+wEwMbE for <kvmarm@lists.cs.columbia.edu>;
 Sat, 12 Mar 2022 06:16:43 -0500 (EST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id C547940FAB
 for <kvmarm@lists.cs.columbia.edu>; Sat, 12 Mar 2022 06:16:43 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 3F09860B2A;
 Sat, 12 Mar 2022 11:16:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04702C340ED;
 Sat, 12 Mar 2022 11:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1647083802;
 bh=YzawpeHEj83O3MHK1mt6N6MJbgfsmB6tLIfOzzkNzXo=;
 h=Subject:To:Cc:From:Date:In-Reply-To:From;
 b=Ipa7BExXZI4AoDyBs6KsgQOa7w4sNA0RSKGSSHAePYer+kRz82tws8OjGFLiT0BLE
 JRX9w4o1u78JAVAT/0qY4+mTgPc0cuorJX/JY5zUpQv0dzW5lmES0VOxHLLnJrnPr/
 1bDc5pJC1daZmr3yEcPGVM2nDFGJRovKomQ+XtcU=
Subject: Patch "KVM: arm64: Reset PMC_EL0 to avoid a panic() on systems with
 no PMU" has been added to the 4.19-stable tree
To: alexandru.elisei@arm.com, gregkh@linuxfoundation.org, james.morse@arm.com,
 kvmarm@lists.cs.columbia.edu, maz@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Sat, 12 Mar 2022 12:16:38 +0100
In-Reply-To: <20220308162939.603335-1-james.morse@arm.com>
Message-ID: <164708379811058@kroah.com>
MIME-Version: 1.0
X-stable: commit
X-Patchwork-Hint: ignore 
Cc: stable-commits@vger.kernel.org
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


This is a note to let you know that I've just added the patch titled

    KVM: arm64: Reset PMC_EL0 to avoid a panic() on systems with no PMU

to the 4.19-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     kvm-arm64-reset-pmc_el0-to-avoid-a-panic-on-systems-with-no-pmu.patch
and it can be found in the queue-4.19 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From james.morse@arm.com  Sat Mar 12 12:08:36 2022
From: James Morse <james.morse@arm.com>
Date: Tue,  8 Mar 2022 16:29:39 +0000
Subject: KVM: arm64: Reset PMC_EL0 to avoid a panic() on systems with no PMU
To: stable@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Cc: Marc Zyngier <maz@kernel.org>, Alexandru Elisei <alexandru.elisei@arm.com>, james.morse@arm.com
Message-ID: <20220308162939.603335-1-james.morse@arm.com>

From: James Morse <james.morse@arm.com>

The logic in commit 2a5f1b67ec57 "KVM: arm64: Don't access PMCR_EL0 when no
PMU is available" relies on an empty reset handler being benign.  This was
not the case in earlier kernel versions, so the stable backport of this
patch is causing problems.

KVMs behaviour in this area changed over time. In particular, prior to commit
03fdfb269009 ("KVM: arm64: Don't write junk to sysregs on reset"), an empty
reset handler will trigger a warning, as the guest registers have been
poisoned.
Prior to commit 20589c8cc47d ("arm/arm64: KVM: Don't panic on failure to
properly reset system registers"), this warning was a panic().

Instead of reverting the backport, make it write 0 to the sys_reg[] array.
This keeps the reset logic happy, and the dodgy value can't be seen by
the guest as it can't request the emulation.

The original bug was accessing the PMCR_EL0 register on CPUs that don't
implement that feature. There is no known silicon that does this, but
v4.9's ACPI support is unable to find the PMU, so triggers this code:

| Kernel panic - not syncing: Didn't reset vcpu_sys_reg(24)
| CPU: 1 PID: 3055 Comm: lkvm Not tainted 4.9.302-00032-g64e078a56789 #13476
| Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno Development Platform, BIOS EDK II Jul 30 2018
| Call trace:
| [<ffff00000808b4b0>] dump_backtrace+0x0/0x1a0
| [<ffff00000808b664>] show_stack+0x14/0x20
| [<ffff0000088f0e18>] dump_stack+0x98/0xb8
| [<ffff0000088eef08>] panic+0x118/0x274
| [<ffff0000080b50e0>] access_actlr+0x0/0x20
| [<ffff0000080b2620>] kvm_reset_vcpu+0x5c/0xac
| [<ffff0000080ac688>] kvm_arch_vcpu_ioctl+0x3e4/0x490
| [<ffff0000080a382c>] kvm_vcpu_ioctl+0x5b8/0x720
| [<ffff000008201e44>] do_vfs_ioctl+0x2f4/0x884
| [<ffff00000820244c>] SyS_ioctl+0x78/0x9c
| [<ffff000008083a9c>] __sys_trace_return+0x0/0x4

Cc: <stable@vger.kernel.org> # < v5.3 with 2a5f1b67ec57 backported
Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kvm/sys_regs.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -620,8 +620,10 @@ static void reset_pmcr(struct kvm_vcpu *
 	u64 pmcr, val;
 
 	/* No PMU available, PMCR_EL0 may UNDEF... */
-	if (!kvm_arm_support_pmu_v3())
+	if (!kvm_arm_support_pmu_v3()) {
+		vcpu_sys_reg(vcpu, PMCR_EL0) = 0;
 		return;
+	}
 
 	pmcr = read_sysreg(pmcr_el0);
 	/*


Patches currently in stable-queue which might be from james.morse@arm.com are

queue-4.19/kvm-arm64-reset-pmc_el0-to-avoid-a-panic-on-systems-with-no-pmu.patch
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
