Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 09F77C313E
	for <lists+kvmarm@lfdr.de>; Tue,  1 Oct 2019 12:24:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A71FA4A7EF;
	Tue,  1 Oct 2019 06:24:00 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Urh8J7TKw4uQ; Tue,  1 Oct 2019 06:24:00 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1F8A14A7DE;
	Tue,  1 Oct 2019 06:23:59 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D5E244A6A4
 for <kvmarm@lists.cs.columbia.edu>; Tue,  1 Oct 2019 06:23:56 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0OOpNZmBufIZ for <kvmarm@lists.cs.columbia.edu>;
 Tue,  1 Oct 2019 06:23:55 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E069B4A6ED
 for <kvmarm@lists.cs.columbia.edu>; Tue,  1 Oct 2019 06:23:55 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA7DD1000;
 Tue,  1 Oct 2019 03:23:55 -0700 (PDT)
Received: from e123195-lin.cambridge.arm.com (e123195-lin.cambridge.arm.com
 [10.1.196.63])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6F62D3F739;
 Tue,  1 Oct 2019 03:23:54 -0700 (PDT)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: kvm@vger.kernel.org,
	kvmarm@lists.cs.columbia.edu
Subject: [kvm-unit-tests RFC PATCH v2 12/19] arm/arm64: Invalidate TLB before
 enabling MMU
Date: Tue,  1 Oct 2019 11:23:16 +0100
Message-Id: <20191001102323.27628-13-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191001102323.27628-1-alexandru.elisei@arm.com>
References: <20191001102323.27628-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

Let's invalidate the TLB before enabling the MMU, not after, so we don't
accidently use a stale TLB mapping. For arm, we add a TLBIALL operation,
which applies only to the PE that executed the instruction [1]. For arm64,
we already do that in asm_mmu_enable.

We now find ourselves in a situation where we issue an extra invalidation
after asm_mmu_enable returns. Remove this redundant call to tlb_flush_all.

[1] ARM DDI 0406C.d, section B3.10.6

Reviewed-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
Changes:
* Reworded the commit message a bit, but I figured the changes are small and so
  I kept the Reviewed-by.

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
index c8bbb4f0a2a2..748548c3b516 100644
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
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
