Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id ECC2935F232
	for <lists+kvmarm@lfdr.de>; Wed, 14 Apr 2021 13:25:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9E0664B66D;
	Wed, 14 Apr 2021 07:25:15 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jbFYaUAIgWLp; Wed, 14 Apr 2021 07:25:15 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6B7194B688;
	Wed, 14 Apr 2021 07:25:14 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 886E24B58E
 for <kvmarm@lists.cs.columbia.edu>; Wed, 14 Apr 2021 07:25:12 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NJv8oGF9bSH5 for <kvmarm@lists.cs.columbia.edu>;
 Wed, 14 Apr 2021 07:25:11 -0400 (EDT)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 0359D4B12D
 for <kvmarm@lists.cs.columbia.edu>; Wed, 14 Apr 2021 07:25:11 -0400 (EDT)
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FL0S74W29zNtWp;
 Wed, 14 Apr 2021 19:22:15 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.47.82.32) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Wed, 14 Apr 2021 19:25:00 +0800
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.cs.columbia.edu>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 09/16] arm64/mm: Split the function
 check_and_switch_context in 3 parts
Date: Wed, 14 Apr 2021 12:23:05 +0100
Message-ID: <20210414112312.13704-10-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20210414112312.13704-1-shameerali.kolothum.thodi@huawei.com>
References: <20210414112312.13704-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.47.82.32]
X-CFilter-Loop: Reflected
Cc: jean-philippe@linaro.org, julien@xen.org, maz@kernel.org,
 linuxarm@huawei.com, catalin.marinas@arm.com, will@kernel.org
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

From: Julien Grall <julien.grall@arm.com>

The function check_and_switch_context is used to:
    1) Check whether the ASID is still valid
    2) Generate a new one if it is not valid
    3) Switch the context

While the latter is specific to the MM subsystem, the rest could be part
of the generic ASID allocator.

After this patch, the function is now split in 3 parts which corresponds
to the use of the functions:
    1) asid_check_context: Check if the ASID is still valid
    2) asid_new_context: Generate a new ASID for the context
    3) check_and_switch_context: Call 1) and 2) and switch the context

1) and 2) have not been merged in a single function because we want to
avoid to add a branch in when the ASID is still valid. This will matter
when the code will be moved in separate file later on as 1) will reside
in the header as a static inline function.

Signed-off-by: Julien Grall <julien.grall@arm.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
v3 comment:
    Will wants to avoid to add a branch when the ASID is still valid. So
    1) and 2) are in separates function. The former will move to a new
    header and make static inline.
---
 arch/arm64/mm/context.c | 70 ++++++++++++++++++++++++++++-------------
 1 file changed, 48 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index 041c3c5e0216..40ef013c90c3 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -222,17 +222,49 @@ static u64 new_context(struct asid_info *info, atomic64_t *pasid,
 	return idx2asid(info, asid) | generation;
 }
 
-void check_and_switch_context(struct mm_struct *mm)
+/*
+ * Generate a new ASID for the context.
+ *
+ * @pasid: Pointer to the current ASID batch allocated. It will be updated
+ * with the new ASID batch.
+ * @pinned: refcount if asid is pinned.
+ * Caller needs to make sure preempt is disabled before calling this function.
+ */
+static void asid_new_context(struct asid_info *info, atomic64_t *pasid,
+			     refcount_t *pinned)
 {
 	unsigned long flags;
-	unsigned int cpu;
-	u64 asid, old_active_asid;
-	struct asid_info *info = &asid_info;
+	u64 asid;
+	unsigned int cpu = smp_processor_id();
 
-	if (system_supports_cnp())
-		cpu_set_reserved_ttbr0();
+	raw_spin_lock_irqsave(&info->lock, flags);
+	/* Check that our ASID belongs to the current generation. */
+	asid = atomic64_read(pasid);
+	if (!asid_gen_match(asid, info)) {
+		asid = new_context(info, pasid, pinned);
+		atomic64_set(pasid, asid);
+	}
 
-	asid = atomic64_read(&mm->context.id);
+	if (cpumask_test_and_clear_cpu(cpu, &info->flush_pending))
+		local_flush_tlb_all();
+
+	atomic64_set(&active_asid(info, cpu), asid);
+	raw_spin_unlock_irqrestore(&info->lock, flags);
+}
+
+/*
+ * Check the ASID is still valid for the context. If not generate a new ASID.
+ *
+ * @pasid: Pointer to the current ASID batch
+ * @pinned: refcount if asid is pinned
+ * Caller needs to make sure preempt is disabled before calling this function.
+ */
+static void asid_check_context(struct asid_info *info, atomic64_t *pasid,
+			       refcount_t *pinned)
+{
+	u64 asid, old_active_asid;
+
+	asid = atomic64_read(pasid);
 
 	/*
 	 * The memory ordering here is subtle.
@@ -252,24 +284,18 @@ void check_and_switch_context(struct mm_struct *mm)
 	if (old_active_asid && asid_gen_match(asid, info) &&
 	    atomic64_cmpxchg_relaxed(this_cpu_ptr(info->active),
 				     old_active_asid, asid))
-		goto switch_mm_fastpath;
-
-	raw_spin_lock_irqsave(&info->lock, flags);
-	/* Check that our ASID belongs to the current generation. */
-	asid = atomic64_read(&mm->context.id);
-	if (!asid_gen_match(asid, info)) {
-		asid = new_context(info, &mm->context.id, &mm->context.pinned);
-		atomic64_set(&mm->context.id, asid);
-	}
+		return;
 
-	cpu = smp_processor_id();
-	if (cpumask_test_and_clear_cpu(cpu, &info->flush_pending))
-		local_flush_tlb_all();
+	asid_new_context(info, pasid, pinned);
+}
 
-	atomic64_set(&active_asid(info, cpu), asid);
-	raw_spin_unlock_irqrestore(&info->lock, flags);
+void check_and_switch_context(struct mm_struct *mm)
+{
+	if (system_supports_cnp())
+		cpu_set_reserved_ttbr0();
 
-switch_mm_fastpath:
+	asid_check_context(&asid_info, &mm->context.id,
+			   &mm->context.pinned);
 
 	arm64_apply_bp_hardening();
 
-- 
2.17.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
