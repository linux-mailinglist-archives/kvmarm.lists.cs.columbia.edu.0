Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3077535F235
	for <lists+kvmarm@lfdr.de>; Wed, 14 Apr 2021 13:25:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D88684B66D;
	Wed, 14 Apr 2021 07:25:24 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 81hprb0ms3hA; Wed, 14 Apr 2021 07:25:23 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C99594B6E8;
	Wed, 14 Apr 2021 07:25:22 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 485B24B34F
 for <kvmarm@lists.cs.columbia.edu>; Wed, 14 Apr 2021 07:25:22 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZnL+tOJi-1M3 for <kvmarm@lists.cs.columbia.edu>;
 Wed, 14 Apr 2021 07:25:21 -0400 (EDT)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 3298C4B5AC
 for <kvmarm@lists.cs.columbia.edu>; Wed, 14 Apr 2021 07:25:21 -0400 (EDT)
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FL0T259cvztWGR;
 Wed, 14 Apr 2021 19:23:02 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.47.82.32) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Wed, 14 Apr 2021 19:25:08 +0800
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.cs.columbia.edu>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 11/16] arm64/mm: Introduce a callback to flush the local
 context
Date: Wed, 14 Apr 2021 12:23:07 +0100
Message-ID: <20210414112312.13704-12-shameerali.kolothum.thodi@huawei.com>
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

Flushing the local context will vary depending on the actual user
of the ASID allocator. Introduce a new callback to flush the local
context and move the call to flush local TLB in it.

Signed-off-by: Julien Grall <julien.grall@arm.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 arch/arm64/mm/context.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index 901472a57b5d..ee446f7535a3 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -32,6 +32,8 @@ static struct asid_info
 	unsigned long		*pinned_map;
 	unsigned long		max_pinned_asids;
 	unsigned long		nr_pinned_asids;
+	/* Callback to locally flush the context. */
+	void			(*flush_cpu_ctxt_cb)(void);
 } asid_info;
 
 #define active_asid(info, cpu)	 (*per_cpu_ptr((info)->active, cpu))
@@ -245,8 +247,9 @@ static void asid_new_context(struct asid_info *info, atomic64_t *pasid,
 		atomic64_set(pasid, asid);
 	}
 
-	if (cpumask_test_and_clear_cpu(cpu, &info->flush_pending))
-		local_flush_tlb_all();
+	if (cpumask_test_and_clear_cpu(cpu, &info->flush_pending) &&
+	    info->flush_cpu_ctxt_cb)
+		info->flush_cpu_ctxt_cb();
 
 	atomic64_set(&active_asid(info, cpu), asid);
 	raw_spin_unlock_irqrestore(&info->lock, flags);
@@ -427,6 +430,11 @@ void cpu_do_switch_mm(phys_addr_t pgd_phys, struct mm_struct *mm)
 	post_ttbr_update_workaround();
 }
 
+static void asid_flush_cpu_ctxt(void)
+{
+	local_flush_tlb_all();
+}
+
 static int asids_update_limit(void)
 {
 	struct asid_info *info = &asid_info;
@@ -499,6 +507,7 @@ static int asids_init(void)
 
 	info->active = &active_asids;
 	info->reserved = &reserved_asids;
+	info->flush_cpu_ctxt_cb = asid_flush_cpu_ctxt;
 
 	/*
 	 * We cannot call set_reserved_asid_bits() here because CPU
-- 
2.17.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
