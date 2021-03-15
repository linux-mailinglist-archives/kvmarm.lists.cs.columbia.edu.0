Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id AE77833B2E3
	for <lists+kvmarm@lfdr.de>; Mon, 15 Mar 2021 13:38:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 43C9F4B351;
	Mon, 15 Mar 2021 08:38:45 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@linuxfoundation.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E6xyKW1ftYAo; Mon, 15 Mar 2021 08:38:45 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F2E284B295;
	Mon, 15 Mar 2021 08:38:43 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A6F164B295
 for <kvmarm@lists.cs.columbia.edu>; Mon, 15 Mar 2021 08:38:42 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zwmCnsl1cCQC for <kvmarm@lists.cs.columbia.edu>;
 Mon, 15 Mar 2021 08:38:40 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 92F494B1F7
 for <kvmarm@lists.cs.columbia.edu>; Mon, 15 Mar 2021 08:38:40 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id E849964E10;
 Mon, 15 Mar 2021 12:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1615811919;
 bh=IDPr9BRa8AUBPvaQkhcQ8s2u24PdZSjqRJz9gzSpbQM=;
 h=Subject:To:Cc:From:Date:In-Reply-To:From;
 b=eWMo//FH4erjdEoYWS20UCyRv8QXS3Rld7LWNj6dDoxpG5QxsfWR3FV3nc6qadNWN
 IqGJMgh26ptbFV6WX/kUvXC01jT3OlkKIvZHebsjggP/zspeekSyPeflb3tc/liLML
 rulEQY0TzxAcqDKR0krJ3KszQx+f2GiSiYb8MviA=
Subject: Patch "KVM: arm64: Fix nVHE hyp panic host context restore" has been
 added to the 5.10-stable tree
To: ascull@google.com, gregkh@linuxfoundation.org, kernel-team@android.com,
 kvmarm@lists.cs.columbia.edu, maz@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Mar 2021 13:38:36 +0100
In-Reply-To: <20210315122210.1688894-1-ascull@google.com>
Message-ID: <1615811916236122@kroah.com>
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

    KVM: arm64: Fix nVHE hyp panic host context restore

to the 5.10-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     kvm-arm64-fix-nvhe-hyp-panic-host-context-restore.patch
and it can be found in the queue-5.10 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From foo@baz Mon Mar 15 01:38:17 PM CET 2021
From: Andrew Scull <ascull@google.com>
Date: Mon, 15 Mar 2021 12:22:10 +0000
Subject: KVM: arm64: Fix nVHE hyp panic host context restore
To: kvmarm@lists.cs.columbia.edu
Cc: maz@kernel.org, kernel-team@android.com, Andrew Scull <ascull@google.com>, stable@vger.kernel.org
Message-ID: <20210315122210.1688894-1-ascull@google.com>

From: Andrew Scull <ascull@google.com>

Commit c4b000c3928d4f20acef79dccf3a65ae3795e0b0 upstream.

When panicking from the nVHE hyp and restoring the host context, x29 is
expected to hold a pointer to the host context. This wasn't being done
so fix it to make sure there's a valid pointer the host context being
used.

Rather than passing a boolean indicating whether or not the host context
should be restored, instead pass the pointer to the host context. NULL
is passed to indicate that no context should be restored.

Fixes: a2e102e20fd6 ("KVM: arm64: nVHE: Handle hyp panics")
Cc: stable@vger.kernel.org # 5.10.y only
Signed-off-by: Andrew Scull <ascull@google.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210219122406.1337626-1-ascull@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/kvm_hyp.h |    3 ++-
 arch/arm64/kvm/hyp/nvhe/host.S   |   20 ++++++++++----------
 arch/arm64/kvm/hyp/nvhe/switch.c |    3 +--
 3 files changed, 13 insertions(+), 13 deletions(-)

--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -99,7 +99,8 @@ u64 __guest_enter(struct kvm_vcpu *vcpu)
 
 void __noreturn hyp_panic(void);
 #ifdef __KVM_NVHE_HYPERVISOR__
-void __noreturn __hyp_do_panic(bool restore_host, u64 spsr, u64 elr, u64 par);
+void __noreturn __hyp_do_panic(struct kvm_cpu_context *host_ctxt, u64 spsr,
+			       u64 elr, u64 par);
 #endif
 
 #endif /* __ARM64_KVM_HYP_H__ */
--- a/arch/arm64/kvm/hyp/nvhe/host.S
+++ b/arch/arm64/kvm/hyp/nvhe/host.S
@@ -64,10 +64,15 @@ __host_enter_without_restoring:
 SYM_FUNC_END(__host_exit)
 
 /*
- * void __noreturn __hyp_do_panic(bool restore_host, u64 spsr, u64 elr, u64 par);
+ * void __noreturn __hyp_do_panic(struct kvm_cpu_context *host_ctxt, u64 spsr,
+ * 				  u64 elr, u64 par);
  */
 SYM_FUNC_START(__hyp_do_panic)
-	/* Load the format arguments into x1-7 */
+	mov	x29, x0
+
+	/* Load the format string into x0 and arguments into x1-7 */
+	ldr	x0, =__hyp_panic_string
+
 	mov	x6, x3
 	get_vcpu_ptr x7, x3
 
@@ -82,13 +87,8 @@ SYM_FUNC_START(__hyp_do_panic)
 	ldr	lr, =panic
 	msr	elr_el2, lr
 
-	/*
-	 * Set the panic format string and enter the host, conditionally
-	 * restoring the host context.
-	 */
-	cmp	x0, xzr
-	ldr	x0, =__hyp_panic_string
-	b.eq	__host_enter_without_restoring
+	/* Enter the host, conditionally restoring the host context. */
+	cbz	x29, __host_enter_without_restoring
 	b	__host_enter_for_panic
 SYM_FUNC_END(__hyp_do_panic)
 
@@ -144,7 +144,7 @@ SYM_FUNC_END(__hyp_do_panic)
 
 .macro invalid_host_el1_vect
 	.align 7
-	mov	x0, xzr		/* restore_host = false */
+	mov	x0, xzr		/* host_ctxt = NULL */
 	mrs	x1, spsr_el2
 	mrs	x2, elr_el2
 	mrs	x3, par_el1
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -260,7 +260,6 @@ void __noreturn hyp_panic(void)
 	u64 spsr = read_sysreg_el2(SYS_SPSR);
 	u64 elr = read_sysreg_el2(SYS_ELR);
 	u64 par = read_sysreg_par();
-	bool restore_host = true;
 	struct kvm_cpu_context *host_ctxt;
 	struct kvm_vcpu *vcpu;
 
@@ -274,7 +273,7 @@ void __noreturn hyp_panic(void)
 		__sysreg_restore_state_nvhe(host_ctxt);
 	}
 
-	__hyp_do_panic(restore_host, spsr, elr, par);
+	__hyp_do_panic(host_ctxt, spsr, elr, par);
 	unreachable();
 }
 


Patches currently in stable-queue which might be from ascull@google.com are

queue-5.10/kvm-arm64-fix-nvhe-hyp-panic-host-context-restore.patch
queue-5.10/kvm-arm64-avoid-corrupting-vcpu-context-register-in-guest-exit.patch
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
