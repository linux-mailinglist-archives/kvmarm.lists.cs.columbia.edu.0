Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 42550610590
	for <lists+kvmarm@lfdr.de>; Fri, 28 Oct 2022 00:18:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E38E949EFA;
	Thu, 27 Oct 2022 18:18:55 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, RCVD_IN_DNSWL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
	T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@linux.dev
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sE2GK-s1YnPq; Thu, 27 Oct 2022 18:18:55 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 417C440E00;
	Thu, 27 Oct 2022 18:18:54 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A1D43402C4
 for <kvmarm@lists.cs.columbia.edu>; Thu, 27 Oct 2022 18:18:52 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zJ0Wa29MgKOF for <kvmarm@lists.cs.columbia.edu>;
 Thu, 27 Oct 2022 18:18:51 -0400 (EDT)
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 106624018D
 for <kvmarm@lists.cs.columbia.edu>; Thu, 27 Oct 2022 18:18:51 -0400 (EDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1666909130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ft5tc0Ff5Dg0Os2kaM+BqQySMxlbqS5IkvBiUdGtK+8=;
 b=j9MsoL886l4v5tT1AJz1PCcPA7ng7SOPNFK3Yg5rzFVB0jm/3qHXKZm5+BdIwMtKbpeN8y
 VskfNrASyWaZc7+Gc8hpcNopcp77VlomK3mY336ljI6mBkn7hVKTeAvOKIKprvyo4RQUjf
 0ikrzTT3WGTdpx5NtjJVtWHjIY+OGck=
From: Oliver Upton <oliver.upton@linux.dev>
To: Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>
Subject: [PATCH v3 06/15] KVM: arm64: Tear down unlinked stage-2 subtree after
 break-before-make
Date: Thu, 27 Oct 2022 22:17:43 +0000
Message-Id: <20221027221752.1683510-7-oliver.upton@linux.dev>
In-Reply-To: <20221027221752.1683510-1-oliver.upton@linux.dev>
References: <20221027221752.1683510-1-oliver.upton@linux.dev>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
 Ben Gardon <bgardon@google.com>, David Matlack <dmatlack@google.com>,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
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
 arch/arm64/kvm/hyp/nvhe/mem_protect.c |  6 ++
 arch/arm64/kvm/hyp/pgtable.c          | 81 +++++++--------------------
 arch/arm64/kvm/mmu.c                  |  8 +++
 4 files changed, 37 insertions(+), 61 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index 93b1feeaebab..7a8af3b686e8 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -85,6 +85,8 @@ static inline bool kvm_level_supports_block_mapping(u32 level)
  *				allocation is physically contiguous.
  * @free_pages_exact:		Free an exact number of memory pages previously
  *				allocated by zalloc_pages_exact.
+ * @free_removed_table:		Free a removed paging structure by unlinking and
+ *				dropping references.
  * @get_page:			Increment the refcount on a page.
  * @put_page:			Decrement the refcount on a page. When the
  *				refcount reaches 0 the page is automatically
@@ -103,6 +105,7 @@ struct kvm_pgtable_mm_ops {
 	void*		(*zalloc_page)(void *arg);
 	void*		(*zalloc_pages_exact)(size_t size);
 	void		(*free_pages_exact)(void *addr, size_t size);
+	void		(*free_removed_table)(void *addr, u32 level);
 	void		(*get_page)(void *addr);
 	void		(*put_page)(void *addr);
 	int		(*page_count)(void *addr);
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index d21d1b08a055..735769886b55 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -79,6 +79,11 @@ static void host_s2_put_page(void *addr)
 	hyp_put_page(&host_s2_pool, addr);
 }
 
+static void host_s2_free_removed_table(void *addr, u32 level)
+{
+	kvm_pgtable_stage2_free_removed(&host_kvm.mm_ops, addr, level);
+}
+
 static int prepare_s2_pool(void *pgt_pool_base)
 {
 	unsigned long nr_pages, pfn;
@@ -93,6 +98,7 @@ static int prepare_s2_pool(void *pgt_pool_base)
 	host_kvm.mm_ops = (struct kvm_pgtable_mm_ops) {
 		.zalloc_pages_exact = host_s2_zalloc_pages_exact,
 		.zalloc_page = host_s2_zalloc_page,
+		.free_removed_table = host_s2_free_removed_table,
 		.phys_to_virt = hyp_phys_to_virt,
 		.virt_to_phys = hyp_virt_to_phys,
 		.page_count = hyp_page_count,
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 363a5cce7e1a..167777b42890 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -749,13 +749,13 @@ static int stage2_map_walker_try_leaf(const struct kvm_pgtable_visit_ctx *ctx,
 static int stage2_map_walk_table_pre(const struct kvm_pgtable_visit_ctx *ctx,
 				     struct stage2_map_data *data)
 {
-	if (data->anchor)
-		return 0;
+	struct kvm_pgtable_mm_ops *mm_ops = ctx->mm_ops;
+	kvm_pte_t *childp = kvm_pte_follow(ctx->old, mm_ops);
+	int ret;
 
 	if (!stage2_leaf_mapping_allowed(ctx, data))
 		return 0;
 
-	data->childp = kvm_pte_follow(ctx->old, ctx->mm_ops);
 	kvm_clear_pte(ctx->ptep);
 
 	/*
@@ -764,8 +764,13 @@ static int stage2_map_walk_table_pre(const struct kvm_pgtable_visit_ctx *ctx,
 	 * individually.
 	 */
 	kvm_call_hyp(__kvm_tlb_flush_vmid, data->mmu);
-	data->anchor = ctx->ptep;
-	return 0;
+
+	ret = stage2_map_walker_try_leaf(ctx, data);
+
+	mm_ops->put_page(ctx->ptep);
+	mm_ops->free_removed_table(childp, ctx->level + 1);
+
+	return ret;
 }
 
 static int stage2_map_walk_leaf(const struct kvm_pgtable_visit_ctx *ctx,
@@ -775,13 +780,6 @@ static int stage2_map_walk_leaf(const struct kvm_pgtable_visit_ctx *ctx,
 	kvm_pte_t *childp;
 	int ret;
 
-	if (data->anchor) {
-		if (stage2_pte_is_counted(ctx->old))
-			mm_ops->put_page(ctx->ptep);
-
-		return 0;
-	}
-
 	ret = stage2_map_walker_try_leaf(ctx, data);
 	if (ret != -E2BIG)
 		return ret;
@@ -810,49 +808,14 @@ static int stage2_map_walk_leaf(const struct kvm_pgtable_visit_ctx *ctx,
 	return 0;
 }
 
-static int stage2_map_walk_table_post(const struct kvm_pgtable_visit_ctx *ctx,
-				      struct stage2_map_data *data)
-{
-	struct kvm_pgtable_mm_ops *mm_ops = ctx->mm_ops;
-	kvm_pte_t *childp;
-	int ret = 0;
-
-	if (!data->anchor)
-		return 0;
-
-	if (data->anchor == ctx->ptep) {
-		childp = data->childp;
-		data->anchor = NULL;
-		data->childp = NULL;
-		ret = stage2_map_walk_leaf(ctx, data);
-	} else {
-		childp = kvm_pte_follow(ctx->old, mm_ops);
-	}
-
-	mm_ops->put_page(childp);
-	mm_ops->put_page(ctx->ptep);
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
 static int stage2_map_walker(const struct kvm_pgtable_visit_ctx *ctx,
 			     enum kvm_pgtable_walk_flags visit)
@@ -864,11 +827,9 @@ static int stage2_map_walker(const struct kvm_pgtable_visit_ctx *ctx,
 		return stage2_map_walk_table_pre(ctx, data);
 	case KVM_PGTABLE_WALK_LEAF:
 		return stage2_map_walk_leaf(ctx, data);
-	case KVM_PGTABLE_WALK_TABLE_POST:
-		return stage2_map_walk_table_post(ctx, data);
+	default:
+		return -EINVAL;
 	}
-
-	return -EINVAL;
 }
 
 int kvm_pgtable_stage2_map(struct kvm_pgtable *pgt, u64 addr, u64 size,
@@ -885,8 +846,7 @@ int kvm_pgtable_stage2_map(struct kvm_pgtable *pgt, u64 addr, u64 size,
 	struct kvm_pgtable_walker walker = {
 		.cb		= stage2_map_walker,
 		.flags		= KVM_PGTABLE_WALK_TABLE_PRE |
-				  KVM_PGTABLE_WALK_LEAF |
-				  KVM_PGTABLE_WALK_TABLE_POST,
+				  KVM_PGTABLE_WALK_LEAF,
 		.arg		= &map_data,
 	};
 
@@ -916,8 +876,7 @@ int kvm_pgtable_stage2_set_owner(struct kvm_pgtable *pgt, u64 addr, u64 size,
 	struct kvm_pgtable_walker walker = {
 		.cb		= stage2_map_walker,
 		.flags		= KVM_PGTABLE_WALK_TABLE_PRE |
-				  KVM_PGTABLE_WALK_LEAF |
-				  KVM_PGTABLE_WALK_TABLE_POST,
+				  KVM_PGTABLE_WALK_LEAF,
 		.arg		= &map_data,
 	};
 
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 60ee3d9f01f8..175a0e9a04b6 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -128,6 +128,13 @@ static void kvm_s2_free_pages_exact(void *virt, size_t size)
 	free_pages_exact(virt, size);
 }
 
+static struct kvm_pgtable_mm_ops kvm_s2_mm_ops;
+
+static void stage2_free_removed_table(void *addr, u32 level)
+{
+	kvm_pgtable_stage2_free_removed(&kvm_s2_mm_ops, addr, level);
+}
+
 static void kvm_host_get_page(void *addr)
 {
 	get_page(virt_to_page(addr));
@@ -662,6 +669,7 @@ static struct kvm_pgtable_mm_ops kvm_s2_mm_ops = {
 	.zalloc_page		= stage2_memcache_zalloc_page,
 	.zalloc_pages_exact	= kvm_s2_zalloc_pages_exact,
 	.free_pages_exact	= kvm_s2_free_pages_exact,
+	.free_removed_table	= stage2_free_removed_table,
 	.get_page		= kvm_host_get_page,
 	.put_page		= kvm_s2_put_page,
 	.page_count		= kvm_host_page_count,
-- 
2.38.1.273.g43a17bfeac-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
