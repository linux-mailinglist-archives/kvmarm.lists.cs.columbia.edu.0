Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 94E475B82F5
	for <lists+kvmarm@lfdr.de>; Wed, 14 Sep 2022 10:35:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 111594BC7F;
	Wed, 14 Sep 2022 04:35:29 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9Kl-gnw7kVhs; Wed, 14 Sep 2022 04:35:27 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C9BE44BC8D;
	Wed, 14 Sep 2022 04:35:27 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 408BD4BC74
 for <kvmarm@lists.cs.columbia.edu>; Wed, 14 Sep 2022 04:35:27 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Gm48dmJPoQGD for <kvmarm@lists.cs.columbia.edu>;
 Wed, 14 Sep 2022 04:35:26 -0400 (EDT)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id BB6C34BC72
 for <kvmarm@lists.cs.columbia.edu>; Wed, 14 Sep 2022 04:35:25 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id E3428B8119E;
 Wed, 14 Sep 2022 08:35:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3823C433D7;
 Wed, 14 Sep 2022 08:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1663144523;
 bh=HUAUuVq8YZYixepTCXAqJPT1+9QpujQsJvquSsGKD5Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iieEsEtZoslbJcY7qhXOST1Vb0lbSnTeeOm4vPwImd3pxJUa68bb+5nerspCUhf6F
 nufftViAXYX6ZqN51ParPIP77TFMZz9dxIMw+q1PitD1CwquV5TiqvphN4ZglYdrjA
 TaonDeM5sG4+H+J50c4bQkUQCOEORoKWzFDzuZtyJv4Q8r5ztMd8JPiU+8Tp2BMvx6
 njLVVFdPNOOVIOH1ZKSHYqqadIJzszJj5SKYTrGCYY48Kwa2LcJ+1t72qzPcrlxeUG
 KP+GjaocjMowAQAvjYFGgaYknN4/3b0ivPZGd9tayHx7ACpOZ04tmGQWV4z1R/bvQk
 SNt64oW4zbASw==
From: Will Deacon <will@kernel.org>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v3 04/25] KVM: arm64: Fix-up hyp stage-1 refcounts for all
 pages mapped at EL2
Date: Wed, 14 Sep 2022 09:34:39 +0100
Message-Id: <20220914083500.5118-5-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220914083500.5118-1-will@kernel.org>
References: <20220914083500.5118-1-will@kernel.org>
MIME-Version: 1.0
Cc: Marc Zyngier <maz@kernel.org>, kernel-team@android.com, kvm@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 Chao Peng <chao.p.peng@linux.intel.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org
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

In order to allow unmapping arbitrary memory pages from the hypervisor
stage-1 page-table, fix-up the initial refcount for pages that have been
mapped before the 'vmemmap' array was up and running so that it
accurately accounts for all existing hypervisor mappings.

This is achieved by traversing the entire hypervisor stage-1 page-table
during initialisation of EL2 and updating the corresponding
'struct hyp_page' for each valid mapping.

Signed-off-by: Quentin Perret <qperret@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kvm/hyp/nvhe/setup.c | 62 +++++++++++++++++++++++----------
 1 file changed, 43 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index 579eb4f73476..8f2726d7e201 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -185,12 +185,11 @@ static void hpool_put_page(void *addr)
 	hyp_put_page(&hpool, addr);
 }
 
-static int finalize_host_mappings_walker(u64 addr, u64 end, u32 level,
-					 kvm_pte_t *ptep,
-					 enum kvm_pgtable_walk_flags flag,
-					 void * const arg)
+static int fix_host_ownership_walker(u64 addr, u64 end, u32 level,
+				     kvm_pte_t *ptep,
+				     enum kvm_pgtable_walk_flags flag,
+				     void * const arg)
 {
-	struct kvm_pgtable_mm_ops *mm_ops = arg;
 	enum kvm_pgtable_prot prot;
 	enum pkvm_page_state state;
 	kvm_pte_t pte = *ptep;
@@ -199,15 +198,6 @@ static int finalize_host_mappings_walker(u64 addr, u64 end, u32 level,
 	if (!kvm_pte_valid(pte))
 		return 0;
 
-	/*
-	 * Fix-up the refcount for the page-table pages as the early allocator
-	 * was unable to access the hyp_vmemmap and so the buddy allocator has
-	 * initialised the refcount to '1'.
-	 */
-	mm_ops->get_page(ptep);
-	if (flag != KVM_PGTABLE_WALK_LEAF)
-		return 0;
-
 	if (level != (KVM_PGTABLE_MAX_LEVELS - 1))
 		return -EINVAL;
 
@@ -236,12 +226,30 @@ static int finalize_host_mappings_walker(u64 addr, u64 end, u32 level,
 	return host_stage2_idmap_locked(phys, PAGE_SIZE, prot);
 }
 
-static int finalize_host_mappings(void)
+static int fix_hyp_pgtable_refcnt_walker(u64 addr, u64 end, u32 level,
+					 kvm_pte_t *ptep,
+					 enum kvm_pgtable_walk_flags flag,
+					 void * const arg)
+{
+	struct kvm_pgtable_mm_ops *mm_ops = arg;
+	kvm_pte_t pte = *ptep;
+
+	/*
+	 * Fix-up the refcount for the page-table pages as the early allocator
+	 * was unable to access the hyp_vmemmap and so the buddy allocator has
+	 * initialised the refcount to '1'.
+	 */
+	if (kvm_pte_valid(pte))
+		mm_ops->get_page(ptep);
+
+	return 0;
+}
+
+static int fix_host_ownership(void)
 {
 	struct kvm_pgtable_walker walker = {
-		.cb	= finalize_host_mappings_walker,
-		.flags	= KVM_PGTABLE_WALK_LEAF | KVM_PGTABLE_WALK_TABLE_POST,
-		.arg	= pkvm_pgtable.mm_ops,
+		.cb	= fix_host_ownership_walker,
+		.flags	= KVM_PGTABLE_WALK_LEAF,
 	};
 	int i, ret;
 
@@ -257,6 +265,18 @@ static int finalize_host_mappings(void)
 	return 0;
 }
 
+static int fix_hyp_pgtable_refcnt(void)
+{
+	struct kvm_pgtable_walker walker = {
+		.cb	= fix_hyp_pgtable_refcnt_walker,
+		.flags	= KVM_PGTABLE_WALK_LEAF | KVM_PGTABLE_WALK_TABLE_POST,
+		.arg	= pkvm_pgtable.mm_ops,
+	};
+
+	return kvm_pgtable_walk(&pkvm_pgtable, 0, BIT(pkvm_pgtable.ia_bits),
+				&walker);
+}
+
 void __noreturn __pkvm_init_finalise(void)
 {
 	struct kvm_host_data *host_data = this_cpu_ptr(&kvm_host_data);
@@ -286,7 +306,11 @@ void __noreturn __pkvm_init_finalise(void)
 	};
 	pkvm_pgtable.mm_ops = &pkvm_pgtable_mm_ops;
 
-	ret = finalize_host_mappings();
+	ret = fix_host_ownership();
+	if (ret)
+		goto out;
+
+	ret = fix_hyp_pgtable_refcnt();
 	if (ret)
 		goto out;
 
-- 
2.37.2.789.g6183377224-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
