Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D118025C1FC
	for <lists+kvmarm@lfdr.de>; Thu,  3 Sep 2020 15:53:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 834644B334;
	Thu,  3 Sep 2020 09:53:55 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0+nNzzY6Ybpi; Thu,  3 Sep 2020 09:53:55 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0D4A14B301;
	Thu,  3 Sep 2020 09:53:54 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4636F4B276
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Sep 2020 09:53:52 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fSuTGxcfRArI for <kvmarm@lists.cs.columbia.edu>;
 Thu,  3 Sep 2020 09:53:50 -0400 (EDT)
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com
 [209.85.221.73])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id B0F984B26D
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Sep 2020 09:53:50 -0400 (EDT)
Received: by mail-wr1-f73.google.com with SMTP id r16so1095531wrm.18
 for <kvmarm@lists.cs.columbia.edu>; Thu, 03 Sep 2020 06:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:in-reply-to:message-id:mime-version:references:subject
 :from:to:cc; bh=w7qR/ZwPhJkGvNVbzx124G4PfwE/PqiKea7e+63Kw2M=;
 b=eeNv3WFaQwYRXPgLvt4rWgwujJiKQmjorXj30e85WidQZ+KbnKzK89KcoG1D1tHoz9
 C0v468uS3dcp7fat0eQUO0Oggrh1NbGBWYghFYxv1i9UixczIi3RnHKjiqZJFZoTD5x7
 hqnGbxjmqR/2b4aFWftELjnKrXO4IWBa2Fw+u5aMMfTFTJUTXQmm2gfmqPRHkvesn1dx
 +jMbIutjgCaMWl0nVeVppYEgti0bl5rSwSjjQjVfGNotYfhHlNXJYJqaESeK+P8IehIv
 xf7F0CWHbFQGuw3cD83t45kfQn6lI9eK279tCZyL5GsebouluT5cSWSdxmoPxc5qPh9H
 JhZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=w7qR/ZwPhJkGvNVbzx124G4PfwE/PqiKea7e+63Kw2M=;
 b=FDUawjzqdZgIDDiLrMxrFfGeIR1ZIBmiyLrIfK+oiu6dokB0wsCyKH3p7FqMuagkP2
 U3XtjC8+ezFVyyqwtd0yaLe9Lawnpl236EUUutQz/Q1xpxEjrsshNqkqDqxFySTjAZ0j
 n4eSQiSiqX0XJsAelsNeE6UjIkGJBwgDXf+P4a6rtscyrnxUWH4Tn65Q8ogN385eTIbO
 txrtRUfSkM/b3MOi1iYzYPi12GmHcbaBoGmNFLWgi6aVzJw82unXdFqnGCAtGqzdTwsx
 0VInpWTnkoJbuRQiH5rNAHXaGfKNWGVgn7EEqFQC+3P5+jL3RKaSYQ4Zei1kp6Eae5xN
 +0Bw==
X-Gm-Message-State: AOAM533X0ElMiIWNf2jMSspvI4c3n6ACNzU2TPar9zjny3dESIqJKi6g
 SyiZAAcgZlx1VE7SuA9TkCB1rJUWWqPjefjnIRV9XShul9NcLrzm0EcAs8/DdNbyvEVLvCm7tVn
 QqEceNTN/N/mzOD9SYr6gv0jvEbpcC+enRbW+gjdbqlJoa87b7O93Xu4E89x44i8cmTInIw==
X-Google-Smtp-Source: ABdhPJyJGYMxca0+az57oKdIKfgult2UFKJ8OjiPAZv/wlrNx3jV/X8yLI9ErMz51X8/N5ec5nWFPG5qJqw=
X-Received: from ascull.lon.corp.google.com
 ([2a00:79e0:d:109:4a0f:cfff:fe4a:6363])
 (user=ascull job=sendgmr) by 2002:a5d:4ccc:: with SMTP id
 c12mr2566100wrt.160.1599141229853; 
 Thu, 03 Sep 2020 06:53:49 -0700 (PDT)
Date: Thu,  3 Sep 2020 14:53:06 +0100
In-Reply-To: <20200903135307.251331-1-ascull@google.com>
Message-Id: <20200903135307.251331-18-ascull@google.com>
Mime-Version: 1.0
References: <20200903135307.251331-1-ascull@google.com>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [PATCH v3 17/18] KVM: arm64: nVHE: Migrate hyp-init to SMCCC
From: Andrew Scull <ascull@google.com>
To: kvmarm@lists.cs.columbia.edu
Cc: linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
 maz@kernel.org, Sudeep Holla <sudeep.holla@arm.com>, catalin.marinas@arm.com,
 will@kernel.org
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

To complete the transition to SMCCC, the hyp initialization is given a
function ID. This looks neater than comparing the hyp stub function IDs
to the page table physical address.

Some care is taken to only clobber x0-3 before the host context is saved
as only those registers can be clobbered accoring to SMCCC. Fortunately,
only a few acrobatics are needed. The possible new tpidr_el2 is moved to
the argument in x2 so that it can be stashed in tpidr_el2 early to free
up a scratch register. The page table configuration then makes use of
x0-2.

Signed-off-by: Andrew Scull <ascull@google.com>
---
 arch/arm64/include/asm/kvm_host.h  |  5 ---
 arch/arm64/kvm/Makefile            |  2 +-
 arch/arm64/kvm/arm.c               |  5 ++-
 arch/arm64/kvm/hyp.S               | 22 ----------
 arch/arm64/kvm/hyp/nvhe/hyp-init.S | 66 +++++++++++++++++-------------
 5 files changed, 43 insertions(+), 57 deletions(-)
 delete mode 100644 arch/arm64/kvm/hyp.S

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 82c941cf8890..ef0325c42ca0 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -480,11 +480,6 @@ int kvm_test_age_hva(struct kvm *kvm, unsigned long hva);
 void kvm_arm_halt_guest(struct kvm *kvm);
 void kvm_arm_resume_guest(struct kvm *kvm);
 
-u64 __kvm_call_hyp_init(phys_addr_t pgd_ptr,
-			unsigned long hyp_stack_ptr,
-			unsigned long vector_ptr,
-			unsigned long tpidr_el2);
-
 #define kvm_call_hyp_nvhe(f, ...)						\
 	({								\
 		struct arm_smccc_res res;				\
diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index 99977c1972cc..1504c81fbf5d 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -13,7 +13,7 @@ obj-$(CONFIG_KVM) += hyp/
 kvm-y := $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o $(KVM)/eventfd.o \
 	 $(KVM)/vfio.o $(KVM)/irqchip.o \
 	 arm.o mmu.o mmio.o psci.o perf.o hypercalls.o pvtime.o \
-	 inject_fault.o regmap.o va_layout.o hyp.o handle_exit.o \
+	 inject_fault.o regmap.o va_layout.o handle_exit.o \
 	 guest.o debug.o reset.o sys_regs.o \
 	 vgic-sys-reg-v3.o fpsimd.o pmu.o \
 	 aarch32.o arch_timer.o \
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 49aa08bd26de..c074d9824d54 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1264,6 +1264,7 @@ static void cpu_init_hyp_mode(void)
 	unsigned long hyp_stack_ptr;
 	unsigned long vector_ptr;
 	unsigned long tpidr_el2;
+	struct arm_smccc_res res;
 
 	/* Switch from the HYP stub to our own HYP init vector */
 	__hyp_set_vectors(kvm_get_idmap_vector());
@@ -1288,7 +1289,9 @@ static void cpu_init_hyp_mode(void)
 	 * cpus_have_const_cap() wrapper.
 	 */
 	BUG_ON(!system_capabilities_finalized());
-	__kvm_call_hyp_init(pgd_ptr, hyp_stack_ptr, vector_ptr, tpidr_el2);
+	arm_smccc_1_1_hvc(KVM_HOST_SMCCC_FUNC(__kvm_hyp_init),
+			  pgd_ptr, tpidr_el2, hyp_stack_ptr, vector_ptr, &res);
+	WARN_ON(res.a0 != SMCCC_RET_SUCCESS);
 
 	/*
 	 * Disabling SSBD on a non-VHE system requires us to enable SSBS
diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
deleted file mode 100644
index 12aa426f7559..000000000000
--- a/arch/arm64/kvm/hyp.S
+++ /dev/null
@@ -1,22 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2012,2013 - ARM Ltd
- * Author: Marc Zyngier <marc.zyngier@arm.com>
- */
-
-#include <linux/linkage.h>
-
-#include <asm/alternative.h>
-#include <asm/assembler.h>
-#include <asm/cpufeature.h>
-
-/*
- * u64 __kvm_call_hyp_init(phys_addr_t pgd_ptr,
- * 			   unsigned long hyp_stack_ptr,
- * 			   unsigned long vector_ptr,
- * 			   unsigned long tpidr_el2);
- */
-SYM_FUNC_START(__kvm_call_hyp_init)
-	hvc	#0
-	ret
-SYM_FUNC_END(__kvm_call_hyp_init)
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-init.S b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
index abe885e26fe2..47224dc62c51 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-init.S
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
@@ -4,11 +4,13 @@
  * Author: Marc Zyngier <marc.zyngier@arm.com>
  */
 
+#include <linux/arm-smccc.h>
 #include <linux/linkage.h>
 
 #include <asm/alternative.h>
 #include <asm/assembler.h>
 #include <asm/kvm_arm.h>
+#include <asm/kvm_asm.h>
 #include <asm/kvm_mmu.h>
 #include <asm/pgtable-hwdef.h>
 #include <asm/sysreg.h>
@@ -44,27 +46,37 @@ __invalid:
 	b	.
 
 	/*
-	 * x0: HYP pgd
-	 * x1: HYP stack
-	 * x2: HYP vectors
-	 * x3: per-CPU offset
+	 * x0: SMCCC function ID
+	 * x1: HYP pgd
+	 * x2: per-CPU offset
+	 * x3: HYP stack
+	 * x4: HYP vectors
 	 */
 __do_hyp_init:
 	/* Check for a stub HVC call */
 	cmp	x0, #HVC_STUB_HCALL_NR
 	b.lo	__kvm_handle_stub_hvc
 
-	phys_to_ttbr x4, x0
+	/* Set tpidr_el2 for use by HYP to free a register */
+	msr	tpidr_el2, x2
+
+	mov	x2, #KVM_HOST_SMCCC_FUNC(__kvm_hyp_init)
+	cmp	x0, x2
+	b.eq	1f
+	mov	x0, #SMCCC_RET_NOT_SUPPORTED
+	eret
+
+1:	phys_to_ttbr x0, x1
 alternative_if ARM64_HAS_CNP
-	orr	x4, x4, #TTBR_CNP_BIT
+	orr	x0, x0, #TTBR_CNP_BIT
 alternative_else_nop_endif
-	msr	ttbr0_el2, x4
+	msr	ttbr0_el2, x0
 
-	mrs	x4, tcr_el1
-	mov_q	x5, TCR_EL2_MASK
-	and	x4, x4, x5
-	mov	x5, #TCR_EL2_RES1
-	orr	x4, x4, x5
+	mrs	x0, tcr_el1
+	mov_q	x1, TCR_EL2_MASK
+	and	x0, x0, x1
+	mov	x1, #TCR_EL2_RES1
+	orr	x0, x0, x1
 
 	/*
 	 * The ID map may be configured to use an extended virtual address
@@ -80,18 +92,18 @@ alternative_else_nop_endif
 	 *
 	 * So use the same T0SZ value we use for the ID map.
 	 */
-	ldr_l	x5, idmap_t0sz
-	bfi	x4, x5, TCR_T0SZ_OFFSET, TCR_TxSZ_WIDTH
+	ldr_l	x1, idmap_t0sz
+	bfi	x0, x1, TCR_T0SZ_OFFSET, TCR_TxSZ_WIDTH
 
 	/*
 	 * Set the PS bits in TCR_EL2.
 	 */
-	tcr_compute_pa_size x4, #TCR_EL2_PS_SHIFT, x5, x6
+	tcr_compute_pa_size x0, #TCR_EL2_PS_SHIFT, x1, x2
 
-	msr	tcr_el2, x4
+	msr	tcr_el2, x0
 
-	mrs	x4, mair_el1
-	msr	mair_el2, x4
+	mrs	x0, mair_el1
+	msr	mair_el2, x0
 	isb
 
 	/* Invalidate the stale TLBs from Bootloader */
@@ -103,24 +115,22 @@ alternative_else_nop_endif
 	 * as well as the EE bit on BE. Drop the A flag since the compiler
 	 * is allowed to generate unaligned accesses.
 	 */
-	mov_q	x4, (SCTLR_EL2_RES1 | (SCTLR_ELx_FLAGS & ~SCTLR_ELx_A))
-CPU_BE(	orr	x4, x4, #SCTLR_ELx_EE)
+	mov_q	x0, (SCTLR_EL2_RES1 | (SCTLR_ELx_FLAGS & ~SCTLR_ELx_A))
+CPU_BE(	orr	x0, x0, #SCTLR_ELx_EE)
 alternative_if ARM64_HAS_ADDRESS_AUTH
-	mov_q	x5, (SCTLR_ELx_ENIA | SCTLR_ELx_ENIB | \
+	mov_q	x1, (SCTLR_ELx_ENIA | SCTLR_ELx_ENIB | \
 		     SCTLR_ELx_ENDA | SCTLR_ELx_ENDB)
-	orr	x4, x4, x5
+	orr	x0, x0, x1
 alternative_else_nop_endif
-	msr	sctlr_el2, x4
+	msr	sctlr_el2, x0
 	isb
 
 	/* Set the stack and new vectors */
-	mov	sp, x1
-	msr	vbar_el2, x2
-
-	/* Set tpidr_el2 for use by HYP */
-	msr	tpidr_el2, x3
+	mov	sp, x3
+	msr	vbar_el2, x4
 
 	/* Hello, World! */
+	mov	x0, #SMCCC_RET_SUCCESS
 	eret
 SYM_CODE_END(__kvm_hyp_init)
 
-- 
2.28.0.402.g5ffc5be6b7-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
