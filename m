Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 657754CE31
	for <lists+kvmarm@lfdr.de>; Thu, 20 Jun 2019 15:06:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0ACDC4A539;
	Thu, 20 Jun 2019 09:06:35 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zf9nysnbjLJZ; Thu, 20 Jun 2019 09:06:34 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D98834A52A;
	Thu, 20 Jun 2019 09:06:32 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0C9034A4D5
 for <kvmarm@lists.cs.columbia.edu>; Thu, 20 Jun 2019 09:06:32 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ggbAtxkaPqfb for <kvmarm@lists.cs.columbia.edu>;
 Thu, 20 Jun 2019 09:06:30 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7F5264A409
 for <kvmarm@lists.cs.columbia.edu>; Thu, 20 Jun 2019 09:06:29 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 317B7C0A;
 Thu, 20 Jun 2019 06:06:29 -0700 (PDT)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com
 [10.1.196.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D122C3F718;
 Thu, 20 Jun 2019 06:06:27 -0700 (PDT)
From: Julien Grall <julien.grall@arm.com>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu
Subject: [RFC v2 04/14] arm64/mm: Move the variable lock and tlb_flush_pending
 to asid_info
Date: Thu, 20 Jun 2019 14:05:58 +0100
Message-Id: <20190620130608.17230-5-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190620130608.17230-1-julien.grall@arm.com>
References: <20190620130608.17230-1-julien.grall@arm.com>
Cc: marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
 Julien Grall <julien.grall@arm.com>
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

The variables lock and tlb_flush_pending holds information for a given
ASID allocator. So move them to the asid_info structure.

Signed-off-by: Julien Grall <julien.grall@arm.com>
---
 arch/arm64/mm/context.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index 7883347ece52..6457a9310fe4 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -27,8 +27,6 @@
 #include <asm/smp.h>
 #include <asm/tlbflush.h>
 
-static DEFINE_RAW_SPINLOCK(cpu_asid_lock);
-
 static struct asid_info
 {
 	atomic64_t	generation;
@@ -36,6 +34,9 @@ static struct asid_info
 	atomic64_t __percpu	*active;
 	u64 __percpu		*reserved;
 	u32			bits;
+	raw_spinlock_t		lock;
+	/* Which CPU requires context flush on next call */
+	cpumask_t		flush_pending;
 } asid_info;
 
 #define active_asid(info, cpu)	*per_cpu_ptr((info)->active, cpu)
@@ -44,8 +45,6 @@ static struct asid_info
 static DEFINE_PER_CPU(atomic64_t, active_asids);
 static DEFINE_PER_CPU(u64, reserved_asids);
 
-static cpumask_t tlb_flush_pending;
-
 #define ASID_MASK(info)			(~GENMASK((info)->bits - 1, 0))
 #define ASID_FIRST_VERSION(info)	(1UL << ((info)->bits))
 
@@ -124,7 +123,7 @@ static void flush_context(struct asid_info *info)
 	 * Queue a TLB invalidation for each CPU to perform on next
 	 * context-switch
 	 */
-	cpumask_setall(&tlb_flush_pending);
+	cpumask_setall(&info->flush_pending);
 }
 
 static bool check_update_reserved_asid(struct asid_info *info, u64 asid,
@@ -233,7 +232,7 @@ void check_and_switch_context(struct mm_struct *mm, unsigned int cpu)
 				     old_active_asid, asid))
 		goto switch_mm_fastpath;
 
-	raw_spin_lock_irqsave(&cpu_asid_lock, flags);
+	raw_spin_lock_irqsave(&info->lock, flags);
 	/* Check that our ASID belongs to the current generation. */
 	asid = atomic64_read(&mm->context.id);
 	if ((asid ^ atomic64_read(&info->generation)) >> info->bits) {
@@ -241,11 +240,11 @@ void check_and_switch_context(struct mm_struct *mm, unsigned int cpu)
 		atomic64_set(&mm->context.id, asid);
 	}
 
-	if (cpumask_test_and_clear_cpu(cpu, &tlb_flush_pending))
+	if (cpumask_test_and_clear_cpu(cpu, &info->flush_pending))
 		local_flush_tlb_all();
 
 	atomic64_set(&active_asid(info, cpu), asid);
-	raw_spin_unlock_irqrestore(&cpu_asid_lock, flags);
+	raw_spin_unlock_irqrestore(&info->lock, flags);
 
 switch_mm_fastpath:
 
@@ -288,6 +287,8 @@ static int asids_init(void)
 	info->active = &active_asids;
 	info->reserved = &reserved_asids;
 
+	raw_spin_lock_init(&info->lock);
+
 	pr_info("ASID allocator initialised with %lu entries\n",
 		NUM_USER_ASIDS(info));
 	return 0;
-- 
2.11.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
