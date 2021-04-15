Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 715F7360889
	for <lists+kvmarm@lfdr.de>; Thu, 15 Apr 2021 13:50:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 209B04B752;
	Thu, 15 Apr 2021 07:50:54 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 74V7v4AcbP14; Thu, 15 Apr 2021 07:50:52 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6CCC04B673;
	Thu, 15 Apr 2021 07:50:50 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id ADFB64B6C6
 for <kvmarm@lists.cs.columbia.edu>; Thu, 15 Apr 2021 07:50:48 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zquaPnQlruCM for <kvmarm@lists.cs.columbia.edu>;
 Thu, 15 Apr 2021 07:50:47 -0400 (EDT)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A1D0C4B6CB
 for <kvmarm@lists.cs.columbia.edu>; Thu, 15 Apr 2021 07:50:46 -0400 (EDT)
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FLcz76TfBzpYXf;
 Thu, 15 Apr 2021 19:47:47 +0800 (CST)
Received: from DESKTOP-TMVL5KK.china.huawei.com (10.174.187.128) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Thu, 15 Apr 2021 19:50:34 +0800
From: Yanan Wang <wangyanan55@huawei.com>
To: Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, "Quentin
 Perret" <qperret@google.com>, Alexandru Elisei <alexandru.elisei@arm.com>,
 <kvmarm@lists.cs.columbia.edu>, <linux-arm-kernel@lists.infradead.org>,
 <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 1/6] KVM: arm64: Introduce KVM_PGTABLE_S2_GUEST stage-2 flag
Date: Thu, 15 Apr 2021 19:50:27 +0800
Message-ID: <20210415115032.35760-2-wangyanan55@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
In-Reply-To: <20210415115032.35760-1-wangyanan55@huawei.com>
References: <20210415115032.35760-1-wangyanan55@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.187.128]
X-CFilter-Loop: Reflected
Cc: Catalin Marinas <catalin.marinas@arm.com>
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

The stage-2 page table code in pgtable.c now is generally used for
guest stage-2 and host stage-2. There may be some different issues
between guest S2 page-table and host S2 page-table that we should
consider, e.g., whether CMOs are needed when creating a new mapping.

So introduce the KVM_PGTABLE_S2_GUEST flag to determine if we are
doing something about guest stage-2. This flag will be used in a
coming patch, in which we will move CMOs for guest to pgtable.c.

Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
---
 arch/arm64/include/asm/kvm_pgtable.h | 38 ++++++++++++++++++----------
 arch/arm64/kvm/mmu.c                 |  3 ++-
 2 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index c3674c47d48c..a43cbe697b37 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -61,10 +61,12 @@ struct kvm_pgtable_mm_ops {
  * @KVM_PGTABLE_S2_NOFWB:	Don't enforce Normal-WB even if the CPUs have
  *				ARM64_HAS_STAGE2_FWB.
  * @KVM_PGTABLE_S2_IDMAP:	Only use identity mappings.
+ * @KVM_PGTABLE_S2_GUEST:	Whether the page-tables are guest stage-2.
  */
 enum kvm_pgtable_stage2_flags {
 	KVM_PGTABLE_S2_NOFWB			= BIT(0),
 	KVM_PGTABLE_S2_IDMAP			= BIT(1),
+	KVM_PGTABLE_S2_GUEST			= BIT(2),
 };
 
 /**
@@ -221,12 +223,10 @@ int kvm_pgtable_stage2_init_flags(struct kvm_pgtable *pgt, struct kvm_arch *arch
 				  struct kvm_pgtable_mm_ops *mm_ops,
 				  enum kvm_pgtable_stage2_flags flags);
 
-#define kvm_pgtable_stage2_init(pgt, arch, mm_ops) \
-	kvm_pgtable_stage2_init_flags(pgt, arch, mm_ops, 0)
-
 /**
  * kvm_pgtable_stage2_destroy() - Destroy an unused guest stage-2 page-table.
- * @pgt:	Page-table structure initialised by kvm_pgtable_stage2_init*().
+ * @pgt:	Page-table structure initialised by function
+ *		kvm_pgtable_stage2_init_flags().
  *
  * The page-table is assumed to be unreachable by any hardware walkers prior
  * to freeing and therefore no TLB invalidation is performed.
@@ -235,7 +235,8 @@ void kvm_pgtable_stage2_destroy(struct kvm_pgtable *pgt);
 
 /**
  * kvm_pgtable_stage2_map() - Install a mapping in a guest stage-2 page-table.
- * @pgt:	Page-table structure initialised by kvm_pgtable_stage2_init*().
+ * @pgt:	Page-table structure initialised by function
+ *		kvm_pgtable_stage2_init_flags().
  * @addr:	Intermediate physical address at which to place the mapping.
  * @size:	Size of the mapping.
  * @phys:	Physical address of the memory to map.
@@ -268,7 +269,8 @@ int kvm_pgtable_stage2_map(struct kvm_pgtable *pgt, u64 addr, u64 size,
 /**
  * kvm_pgtable_stage2_set_owner() - Unmap and annotate pages in the IPA space to
  *				    track ownership.
- * @pgt:	Page-table structure initialised by kvm_pgtable_stage2_init*().
+ * @pgt:	Page-table structure initialised by function
+ *		kvm_pgtable_stage2_init_flags().
  * @addr:	Base intermediate physical address to annotate.
  * @size:	Size of the annotated range.
  * @mc:		Cache of pre-allocated and zeroed memory from which to allocate
@@ -287,7 +289,8 @@ int kvm_pgtable_stage2_set_owner(struct kvm_pgtable *pgt, u64 addr, u64 size,
 
 /**
  * kvm_pgtable_stage2_unmap() - Remove a mapping from a guest stage-2 page-table.
- * @pgt:	Page-table structure initialised by kvm_pgtable_stage2_init*().
+ * @pgt:	Page-table structure initialised by function
+ *		kvm_pgtable_stage2_init_flags().
  * @addr:	Intermediate physical address from which to remove the mapping.
  * @size:	Size of the mapping.
  *
@@ -307,7 +310,8 @@ int kvm_pgtable_stage2_unmap(struct kvm_pgtable *pgt, u64 addr, u64 size);
 /**
  * kvm_pgtable_stage2_wrprotect() - Write-protect guest stage-2 address range
  *                                  without TLB invalidation.
- * @pgt:	Page-table structure initialised by kvm_pgtable_stage2_init*().
+ * @pgt:	Page-table structure initialised by function
+ *		kvm_pgtable_stage2_init_flags().
  * @addr:	Intermediate physical address from which to write-protect,
  * @size:	Size of the range.
  *
@@ -324,7 +328,8 @@ int kvm_pgtable_stage2_wrprotect(struct kvm_pgtable *pgt, u64 addr, u64 size);
 
 /**
  * kvm_pgtable_stage2_mkyoung() - Set the access flag in a page-table entry.
- * @pgt:	Page-table structure initialised by kvm_pgtable_stage2_init*().
+ * @pgt:	Page-table structure initialised by function
+ *		kvm_pgtable_stage2_init_flags().
  * @addr:	Intermediate physical address to identify the page-table entry.
  *
  * The offset of @addr within a page is ignored.
@@ -338,7 +343,8 @@ kvm_pte_t kvm_pgtable_stage2_mkyoung(struct kvm_pgtable *pgt, u64 addr);
 
 /**
  * kvm_pgtable_stage2_mkold() - Clear the access flag in a page-table entry.
- * @pgt:	Page-table structure initialised by kvm_pgtable_stage2_init*().
+ * @pgt:	Page-table structure initialised by function
+ *		kvm_pgtable_stage2_init_flags().
  * @addr:	Intermediate physical address to identify the page-table entry.
  *
  * The offset of @addr within a page is ignored.
@@ -357,7 +363,8 @@ kvm_pte_t kvm_pgtable_stage2_mkold(struct kvm_pgtable *pgt, u64 addr);
 /**
  * kvm_pgtable_stage2_relax_perms() - Relax the permissions enforced by a
  *				      page-table entry.
- * @pgt:	Page-table structure initialised by kvm_pgtable_stage2_init*().
+ * @pgt:	Page-table structure initialised by function
+ *		kvm_pgtable_stage2_init_flags().
  * @addr:	Intermediate physical address to identify the page-table entry.
  * @prot:	Additional permissions to grant for the mapping.
  *
@@ -376,7 +383,8 @@ int kvm_pgtable_stage2_relax_perms(struct kvm_pgtable *pgt, u64 addr,
 /**
  * kvm_pgtable_stage2_is_young() - Test whether a page-table entry has the
  *				   access flag set.
- * @pgt:	Page-table structure initialised by kvm_pgtable_stage2_init*().
+ * @pgt:	Page-table structure initialised by function
+ *		kvm_pgtable_stage2_init_flags().
  * @addr:	Intermediate physical address to identify the page-table entry.
  *
  * The offset of @addr within a page is ignored.
@@ -389,7 +397,8 @@ bool kvm_pgtable_stage2_is_young(struct kvm_pgtable *pgt, u64 addr);
  * kvm_pgtable_stage2_flush_range() - Clean and invalidate data cache to Point
  * 				      of Coherency for guest stage-2 address
  *				      range.
- * @pgt:	Page-table structure initialised by kvm_pgtable_stage2_init*().
+ * @pgt:	Page-table structure initialised by function
+ *		kvm_pgtable_stage2_init_flags().
  * @addr:	Intermediate physical address from which to flush.
  * @size:	Size of the range.
  *
@@ -428,7 +437,8 @@ int kvm_pgtable_walk(struct kvm_pgtable *pgt, u64 addr, u64 size,
  * kvm_pgtable_stage2_find_range() - Find a range of Intermediate Physical
  *				     Addresses with compatible permission
  *				     attributes.
- * @pgt:	Page-table structure initialised by kvm_pgtable_stage2_init*().
+ * @pgt:	Page-table structure initialised by function
+ *		kvm_pgtable_stage2_init_flags().
  * @addr:	Address that must be covered by the range.
  * @prot:	Protection attributes that the range must be compatible with.
  * @range:	Range structure used to limit the search space at call time and
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index cd4d51ae3d4a..2cfcfc5f4e4e 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -457,7 +457,8 @@ int kvm_init_stage2_mmu(struct kvm *kvm, struct kvm_s2_mmu *mmu)
 	if (!pgt)
 		return -ENOMEM;
 
-	err = kvm_pgtable_stage2_init(pgt, &kvm->arch, &kvm_s2_mm_ops);
+	err = kvm_pgtable_stage2_init_flags(pgt, &kvm->arch, &kvm_s2_mm_ops,
+					    KVM_PGTABLE_S2_GUEST);
 	if (err)
 		goto out_free_pgtable;
 
-- 
2.23.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
