Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C31245A6D89
	for <lists+kvmarm@lfdr.de>; Tue, 30 Aug 2022 21:42:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 372144B9A8;
	Tue, 30 Aug 2022 15:42:02 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.79
X-Spam-Level: 
X-Spam-Status: No, score=-1.79 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@linux.dev
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i+rqesyDYsEH; Tue, 30 Aug 2022 15:42:02 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 099BB4B995;
	Tue, 30 Aug 2022 15:42:00 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3E84A40A93
 for <kvmarm@lists.cs.columbia.edu>; Tue, 30 Aug 2022 15:41:59 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NuYJF7+Vm1SG for <kvmarm@lists.cs.columbia.edu>;
 Tue, 30 Aug 2022 15:41:57 -0400 (EDT)
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9BC984B98C
 for <kvmarm@lists.cs.columbia.edu>; Tue, 30 Aug 2022 15:41:57 -0400 (EDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1661888516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5sWbvmiQR0z049lVsjNnTPN0TZTiQqLExNGRDbkgz5I=;
 b=do6y73UztHCQleZRHs8w3lr1o3uVhCdrpHSBmIpJm8DfT8v1vNA8c4/CM9iztkvfL04B5T
 I4VK7tBQzNqgv+ySUzpKg/kwxO1M79nW5h6b8cU6Bjj8eOKlTq+c0FMtCeXDjSoFdXJC+d
 zyRLHQrz7Br1BT9BrRxRqhwtshSAhXE=
From: Oliver Upton <oliver.upton@linux.dev>
To: Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Quentin Perret <qperret@google.com>, Ricardo Koller <ricarkol@google.com>,
 Reiji Watanabe <reijiw@google.com>, David Matlack <dmatlack@google.com>,
 Ben Gardon <bgardon@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Gavin Shan <gshan@redhat.com>, Peter Xu <peterx@redhat.com>,
 Sean Christopherson <seanjc@google.com>,
 Oliver Upton <oliver.upton@linux.dev>
Subject: [PATCH 02/14] KVM: arm64: Tear down unlinked stage-2 subtree after
 break-before-make
Date: Tue, 30 Aug 2022 19:41:20 +0000
Message-Id: <20220830194132.962932-3-oliver.upton@linux.dev>
In-Reply-To: <20220830194132.962932-1-oliver.upton@linux.dev>
References: <20220830194132.962932-1-oliver.upton@linux.dev>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Cc: linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org
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

The break-before-make sequence is a bit annoying as it opens a window
wherein memory is unmapped from the guest. KVM should replace the PTE
as quickly as possible and avoid unnecessary work in between.

Presently, the stage-2 map walker tears down a removed table before
installing a block mapping when coalescing a table into a block. As the
removed table is no longer visible to hardware walkers after the
DSB+TLBI, it is possible to move the remaining cleanup to happen after
installing the new PTE.

Reshuffle the stage-2 map walker to install the new block entry in
the pre-order callback. Unwire all of the teardown logic and replace
it with a call to kvm_pgtable_stage2_free_removed() after fixing
the PTE. The post-order visitor is now completely unnecessary, so drop
it. Finally, touch up the comments to better represent the now
simplified map walker.

Note that the call to tear down the unlinked stage-2 is indirected
as a subsequent change will use an RCU callback to trigger tear down.
RCU is not available to pKVM, so there is a need to use different
implementations on pKVM and non-pKVM VMs.

Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 arch/arm64/include/asm/kvm_pgtable.h  |  3 +
 arch/arm64/kvm/hyp/nvhe/mem_protect.c |  1 +
 arch/arm64/kvm/hyp/pgtable.c          | 83 ++++++++-------------------
 arch/arm64/kvm/mmu.c                  |  1 +
 4 files changed, 28 insertions(+), 60 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index d71fb92dc913..c25633f53b2b 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -77,6 +77,8 @@ static inline bool kvm_level_supports_block_mapping(u32 level)
  *				allocation is physically contiguous.
  * @free_pages_exact:		Free an exact number of memory pages previously
  *				allocated by zalloc_pages_exact.
+ * @free_removed_table:		Free a removed paging structure by unlinking and
+ *				dropping references.
  * @get_page:			Increment the refcount on a page.
  * @put_page:			Decrement the refcount on a page. When the
  *				refcount reaches 0 the page is automatically
@@ -95,6 +97,7 @@ struct kvm_pgtable_mm_ops {
 	void*		(*zalloc_page)(void *arg);
 	void*		(*zalloc_pages_exact)(size_t size);
 	void		(*free_pages_exact)(void *addr, size_t size);
+	void		(*free_removed_table)(void *addr, u32 level, void *arg);
 	void		(*get_page)(void *addr);
 	void		(*put_page)(void *addr);
 	int		(*page_count)(void *addr);
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 1e78acf9662e..a930fdee6fce 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -93,6 +93,7 @@ static int prepare_s2_pool(void *pgt_pool_base)
 	host_kvm.mm_ops = (struct kvm_pgtable_mm_ops) {
 		.zalloc_pages_exact = host_s2_zalloc_pages_exact,
 		.zalloc_page = host_s2_zalloc_page,
+		.free_removed_table = kvm_pgtable_stage2_free_removed,
 		.phys_to_virt = hyp_phys_to_virt,
 		.virt_to_phys = hyp_virt_to_phys,
 		.page_count = hyp_page_count,
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index d8127c25424c..5c0c8028d71c 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -763,17 +763,21 @@ static int stage2_map_walker_try_leaf(u64 addr, u64 end, u32 level,
 	return 0;
 }
 
+static int stage2_map_walk_leaf(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
+				struct stage2_map_data *data);
+
 static int stage2_map_walk_table_pre(u64 addr, u64 end, u32 level,
 				     kvm_pte_t *ptep,
 				     struct stage2_map_data *data)
 {
-	if (data->anchor)
-		return 0;
+	struct kvm_pgtable_mm_ops *mm_ops = data->mm_ops;
+	kvm_pte_t *childp = kvm_pte_follow(*ptep, mm_ops);
+	struct kvm_pgtable *pgt = data->mmu->pgt;
+	int ret;
 
 	if (!stage2_leaf_mapping_allowed(addr, end, level, data))
 		return 0;
 
-	data->childp = kvm_pte_follow(*ptep, data->mm_ops);
 	kvm_clear_pte(ptep);
 
 	/*
@@ -782,8 +786,13 @@ static int stage2_map_walk_table_pre(u64 addr, u64 end, u32 level,
 	 * individually.
 	 */
 	kvm_call_hyp(__kvm_tlb_flush_vmid, data->mmu);
-	data->anchor = ptep;
-	return 0;
+
+	ret = stage2_map_walk_leaf(addr, end, level, ptep, data);
+
+	mm_ops->put_page(ptep);
+	mm_ops->free_removed_table(childp, level + 1, pgt);
+
+	return ret;
 }
 
 static int stage2_map_walk_leaf(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
@@ -793,13 +802,6 @@ static int stage2_map_walk_leaf(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
 	kvm_pte_t *childp, pte = *ptep;
 	int ret;
 
-	if (data->anchor) {
-		if (stage2_pte_is_counted(pte))
-			mm_ops->put_page(ptep);
-
-		return 0;
-	}
-
 	ret = stage2_map_walker_try_leaf(addr, end, level, ptep, data);
 	if (ret != -E2BIG)
 		return ret;
@@ -828,50 +830,14 @@ static int stage2_map_walk_leaf(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
 	return 0;
 }
 
-static int stage2_map_walk_table_post(u64 addr, u64 end, u32 level,
-				      kvm_pte_t *ptep,
-				      struct stage2_map_data *data)
-{
-	struct kvm_pgtable_mm_ops *mm_ops = data->mm_ops;
-	kvm_pte_t *childp;
-	int ret = 0;
-
-	if (!data->anchor)
-		return 0;
-
-	if (data->anchor == ptep) {
-		childp = data->childp;
-		data->anchor = NULL;
-		data->childp = NULL;
-		ret = stage2_map_walk_leaf(addr, end, level, ptep, data);
-	} else {
-		childp = kvm_pte_follow(*ptep, mm_ops);
-	}
-
-	mm_ops->put_page(childp);
-	mm_ops->put_page(ptep);
-
-	return ret;
-}
-
 /*
- * This is a little fiddly, as we use all three of the walk flags. The idea
- * is that the TABLE_PRE callback runs for table entries on the way down,
- * looking for table entries which we could conceivably replace with a
- * block entry for this mapping. If it finds one, then it sets the 'anchor'
- * field in 'struct stage2_map_data' to point at the table entry, before
- * clearing the entry to zero and descending into the now detached table.
- *
- * The behaviour of the LEAF callback then depends on whether or not the
- * anchor has been set. If not, then we're not using a block mapping higher
- * up the table and we perform the mapping at the existing leaves instead.
- * If, on the other hand, the anchor _is_ set, then we drop references to
- * all valid leaves so that the pages beneath the anchor can be freed.
+ * The TABLE_PRE callback runs for table entries on the way down, looking
+ * for table entries which we could conceivably replace with a block entry
+ * for this mapping. If it finds one it replaces the entry and calls
+ * kvm_pgtable_mm_ops::free_removed_table() to tear down the detached table.
  *
- * Finally, the TABLE_POST callback does nothing if the anchor has not
- * been set, but otherwise frees the page-table pages while walking back up
- * the page-table, installing the block entry when it revisits the anchor
- * pointer and clearing the anchor to NULL.
+ * Otherwise, the LEAF callback performs the mapping at the existing leaves
+ * instead.
  */
 static int stage2_map_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
 			     enum kvm_pgtable_walk_flags flag, void * const arg)
@@ -883,11 +849,9 @@ static int stage2_map_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
 		return stage2_map_walk_table_pre(addr, end, level, ptep, data);
 	case KVM_PGTABLE_WALK_LEAF:
 		return stage2_map_walk_leaf(addr, end, level, ptep, data);
-	case KVM_PGTABLE_WALK_TABLE_POST:
-		return stage2_map_walk_table_post(addr, end, level, ptep, data);
+	default:
+		return -EINVAL;
 	}
-
-	return -EINVAL;
 }
 
 int kvm_pgtable_stage2_map(struct kvm_pgtable *pgt, u64 addr, u64 size,
@@ -905,8 +869,7 @@ int kvm_pgtable_stage2_map(struct kvm_pgtable *pgt, u64 addr, u64 size,
 	struct kvm_pgtable_walker walker = {
 		.cb		= stage2_map_walker,
 		.flags		= KVM_PGTABLE_WALK_TABLE_PRE |
-				  KVM_PGTABLE_WALK_LEAF |
-				  KVM_PGTABLE_WALK_TABLE_POST,
+				  KVM_PGTABLE_WALK_LEAF,
 		.arg		= &map_data,
 	};
 
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index c9a13e487187..91521f4aab97 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -627,6 +627,7 @@ static struct kvm_pgtable_mm_ops kvm_s2_mm_ops = {
 	.zalloc_page		= stage2_memcache_zalloc_page,
 	.zalloc_pages_exact	= kvm_host_zalloc_pages_exact,
 	.free_pages_exact	= free_pages_exact,
+	.free_removed_table	= kvm_pgtable_stage2_free_removed,
 	.get_page		= kvm_host_get_page,
 	.put_page		= kvm_host_put_page,
 	.page_count		= kvm_host_page_count,
-- 
2.37.2.672.g94769d06f0-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
