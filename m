Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BFBFF4B21E4
	for <lists+kvmarm@lfdr.de>; Fri, 11 Feb 2022 10:28:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3FC524A0FE;
	Fri, 11 Feb 2022 04:28:18 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 1.932
X-Spam-Level: *
X-Spam-Status: No, score=1.932 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, MISSING_HEADERS=1.021, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5NO5iy+8u11U; Fri, 11 Feb 2022 04:28:16 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E6D944B08D;
	Fri, 11 Feb 2022 04:28:11 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1016C4017A
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Feb 2022 17:45:27 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SIEWh1uPudTT for <kvmarm@lists.cs.columbia.edu>;
 Thu, 10 Feb 2022 17:45:25 -0500 (EST)
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com
 [209.85.219.201])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 784BB400D5
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Feb 2022 17:45:25 -0500 (EST)
Received: by mail-yb1-f201.google.com with SMTP id
 t8-20020a259ac8000000b00619a3b5977fso15164596ybo.5
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Feb 2022 14:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
 bh=OagLRmMmzyQmGqXHU8QCfKrH7+tgm0iC+teioaMlxY8=;
 b=KZUDFgua6kTwrdY0rgWjsvVP3R/Era680jCgYQwjuK0iUjxXTEGhr1k5AU4ecCZI8w
 lGlhfM50n/PyOfFuEnRyrza/dCfR09l2qnRTramuth4IQ5kSJWx8IHEXrR6WGw+YWDLS
 Fcw37pMtSTu7lmTbNbpjWo/86asLiZ0qeY3n5xM9TuAmWeZiYQybxooNBeFcYXyFXw0+
 nw3MMrt2SnLYQkB9BXZaWEk/9+7BpUqlQ9/jkoMabBFdTAqgmPJRbDiXXuHwXpiKMGkR
 ABy9ETz+4Cv/q3YuBrAzVEL6xo4Z9nyp3TJ9LkgLV7VtKKpMguCHsIaLgm9iv9xO8mkw
 WU8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:cc;
 bh=OagLRmMmzyQmGqXHU8QCfKrH7+tgm0iC+teioaMlxY8=;
 b=QvT6VPRII17D90E9/9upJQinIvUOpaScrKxnwXxNWsaJboRBkheFJ3rnYDKV0ISnAe
 q81vSyzKjlvG88EW/NS/ahWqSEVL8BO8A8QQnFiwOkE2hIsinl7Dl+GYqlkTjc+sVROX
 WObq11kLGE9A9Nwnx2K9n+TiCNA3bzi1yRiRzaJFaULwta+mBowYAijbQOQmqEwOqzLB
 UvIZX/rbRdMaDNuf+pvwbd1DXf8ZPA/DnW4IzpEr4iZ5hvGtCGWar7I6TFIPA/HL1ij0
 AdxqqQmaLsWPh3xv3yuwfrUKbUkPm4G/jPtNvR34HoqKbeuk3JLiOzz2FjsMW+WlFxpx
 9BZQ==
X-Gm-Message-State: AOAM530+3ovP2rMht7XXraW/c9vhGihvK+8Hg2GMM+32lVslRr0sLwPx
 66TQ2W041X0uhNse6UzQ+YoQdRMfci8I1yCk+w==
X-Google-Smtp-Source: ABdhPJxzsMWs7cPxHcJVEK0MMmzcLZ3BX26xgEqJ+cjkAM67DycOE9xaVXyG4ooDAIXoCBwYiczs1AVvH+kAit3i8g==
X-Received: from kaleshsingh.mtv.corp.google.com
 ([2620:15c:211:200:8f02:232:ad86:2ab2])
 (user=kaleshsingh job=sendgmr) by 2002:a5b:804:: with SMTP id
 x4mr9503248ybp.673.1644533125008; Thu, 10 Feb 2022 14:45:25 -0800 (PST)
Date: Thu, 10 Feb 2022 14:41:45 -0800
In-Reply-To: <20220210224220.4076151-1-kaleshsingh@google.com>
Message-Id: <20220210224220.4076151-5-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220210224220.4076151-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH 4/7] KVM: arm64: Allocate guard pages near hyp stacks
From: Kalesh Singh <kaleshsingh@google.com>
X-Mailman-Approved-At: Fri, 11 Feb 2022 04:28:10 -0500
Cc: kernel-team@android.com, Catalin Marinas <catalin.marinas@arm.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, will@kernel.org,
 Peter Collingbourne <pcc@google.com>, maz@kernel.org,
 linux-kernel@vger.kernel.org, Joey Gouly <joey.gouly@arm.com>,
 kvmarm@lists.cs.columbia.edu, Kalesh Singh <kaleshsingh@google.com>,
 surenb@google.com, linux-arm-kernel@lists.infradead.org
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

From: Quentin Perret <qperret@google.com>

Allocate unbacked VA space underneath each stack page to ensure stack
overflows get trapped and don't corrupt memory silently.

The stack is aligned to twice its size (PAGE_SIZE), meaning that any
valid stack address has PAGE_SHIFT bit as 0. This allows us to easily
check for overflow in the exception entry without corrupting any GPRs.

Signed-off-by: Quentin Perret <qperret@google.com>
[ Kalesh - Update commit text and comments,
           refactor, add overflow handling ]
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 arch/arm64/kvm/hyp/nvhe/host.S   | 16 ++++++++++++++++
 arch/arm64/kvm/hyp/nvhe/setup.c  | 19 ++++++++++++++++++-
 arch/arm64/kvm/hyp/nvhe/switch.c |  5 +++++
 3 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/host.S b/arch/arm64/kvm/hyp/nvhe/host.S
index 3d613e721a75..78e4b612ac06 100644
--- a/arch/arm64/kvm/hyp/nvhe/host.S
+++ b/arch/arm64/kvm/hyp/nvhe/host.S
@@ -153,6 +153,10 @@ SYM_FUNC_END(__host_hvc)
 
 .macro invalid_host_el2_vect
 	.align 7
+
+	/* Test stack overflow without corrupting GPRs */
+	test_sp_overflow PAGE_SHIFT, .L__hyp_sp_overflow\@
+
 	/* If a guest is loaded, panic out of it. */
 	stp	x0, x1, [sp, #-16]!
 	get_loaded_vcpu x0, x1
@@ -165,6 +169,18 @@ SYM_FUNC_END(__host_hvc)
 	 * been partially clobbered by __host_enter.
 	 */
 	b	hyp_panic
+
+.L__hyp_sp_overflow\@:
+	/*
+	 * Reset SP to the top of the stack, to allow handling the hyp_panic.
+	 * This corrupts the stack but is ok, since we won't be attempting
+	 * any unwinding here.
+	 */
+	ldr_this_cpu	x0, kvm_init_params + NVHE_INIT_STACK_HYP_VA, x1
+	mov	sp, x0
+
+	bl	hyp_panic_bad_stack
+	ASM_BUG()
 .endm
 
 .macro invalid_host_el1_vect
diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index 99e178cf4249..114053dff228 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -105,7 +105,24 @@ static int recreate_hyp_mappings(phys_addr_t phys, unsigned long size,
 		if (ret)
 			return ret;
 
-		/* Map stack pages in the 'private' VA range */
+		/*
+		 * Allocate 'private' VA range for stack guard pages.
+		 *
+		 * The 'private' VA range grows upward and stacks downwards, so
+		 * allocate the guard page first. But make sure to align the
+		 * stack itself with PAGE_SIZE * 2 granularity to ease overflow
+		 * detection in the entry assembly code.
+		 */
+		do {
+			start = (void *)hyp_alloc_private_va_range(PAGE_SIZE);
+			if (IS_ERR(start))
+				return PTR_ERR(start);
+		} while (IS_ALIGNED((u64) start, PAGE_SIZE * 2));
+
+		/*
+		 * Map stack pages in the 'private' VA range above the allocated
+		 * guard pages.
+		 */
 		end = (void *)__hyp_pa(per_cpu_ptr(&kvm_init_params, i)->stack_hyp_va);
 		start = end - PAGE_SIZE;
 		start = (void *)__pkvm_create_private_mapping((phys_addr_t)start,
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index 6410d21d8695..5a2e1ab79913 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -369,6 +369,11 @@ void __noreturn hyp_panic(void)
 	unreachable();
 }
 
+void __noreturn hyp_panic_bad_stack(void)
+{
+	hyp_panic();
+}
+
 asmlinkage void kvm_unexpected_el2_exception(void)
 {
 	return __kvm_unexpected_el2_exception();
-- 
2.35.1.265.g69c8d7142f-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
