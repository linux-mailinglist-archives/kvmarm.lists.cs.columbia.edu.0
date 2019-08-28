Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id F2C7DA036E
	for <lists+kvmarm@lfdr.de>; Wed, 28 Aug 2019 15:39:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A66604A5CE;
	Wed, 28 Aug 2019 09:39:07 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zrNXPOulxBEu; Wed, 28 Aug 2019 09:39:07 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3E2274A5F1;
	Wed, 28 Aug 2019 09:39:06 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 89D394A5A2
 for <kvmarm@lists.cs.columbia.edu>; Wed, 28 Aug 2019 09:39:03 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rxHplX2lcR2J for <kvmarm@lists.cs.columbia.edu>;
 Wed, 28 Aug 2019 09:39:02 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 941944A557
 for <kvmarm@lists.cs.columbia.edu>; Wed, 28 Aug 2019 09:39:02 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4770528;
 Wed, 28 Aug 2019 06:39:02 -0700 (PDT)
Received: from e121566-lin.cambridge.arm.com (e121566-lin.cambridge.arm.com
 [10.1.196.217])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2031E3F246;
 Wed, 28 Aug 2019 06:39:01 -0700 (PDT)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: kvm@vger.kernel.org,
	kvmarm@lists.cs.columbia.edu
Subject: [kvm-unit-tests RFC PATCH 09/16] lib: arm/arm64: Invalidate TLB
 before enabling MMU
Date: Wed, 28 Aug 2019 14:38:24 +0100
Message-Id: <1566999511-24916-10-git-send-email-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566999511-24916-1-git-send-email-alexandru.elisei@arm.com>
References: <1566999511-24916-1-git-send-email-alexandru.elisei@arm.com>
Cc: maz@kernel.org, andre.przywara@arm.com, pbonzini@redhat.com
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

Let's invalidate the TLB before enabling the MMU, not after, so we don't
accidently use a stale TLB mapping. For arm64, we already do that in
asm_mmu_enable, and we issue an extra invalidation after the function
returns. Invalidate the TLB in asm_mmu_enable for arm also, and remove the
redundant call to tlb_flush_all.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 lib/arm/mmu.c | 1 -
 arm/cstart.S  | 4 ++++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/arm/mmu.c b/lib/arm/mmu.c
index 161f7a8e607c..66a05d789386 100644
--- a/lib/arm/mmu.c
+++ b/lib/arm/mmu.c
@@ -57,7 +57,6 @@ void mmu_enable(pgd_t *pgtable)
 	struct thread_info *info = current_thread_info();
 
 	asm_mmu_enable(__pa(pgtable));
-	flush_tlb_all();
 
 	info->pgtable = pgtable;
 	mmu_mark_enabled(info->cpu);
diff --git a/arm/cstart.S b/arm/cstart.S
index 5d4fe4b1570b..316672545551 100644
--- a/arm/cstart.S
+++ b/arm/cstart.S
@@ -160,6 +160,10 @@ halt:
 .equ	NMRR,	0xff000004		@ MAIR1 (from Linux kernel)
 .globl asm_mmu_enable
 asm_mmu_enable:
+	/* TLBIALL */
+	mcr	p15, 0, r2, c8, c7, 0
+	dsb	ish
+
 	/* TTBCR */
 	mrc	p15, 0, r2, c2, c0, 2
 	orr	r2, #(1 << 31)		@ TTB_EAE
-- 
2.7.4

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
