Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E858E3D5686
	for <lists+kvmarm@lfdr.de>; Mon, 26 Jul 2021 11:29:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8C96E4A2E5;
	Mon, 26 Jul 2021 05:29:26 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cKmq8LpfxaRn; Mon, 26 Jul 2021 05:29:25 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E914749DE3;
	Mon, 26 Jul 2021 05:29:22 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 95BD04A2E5
 for <kvmarm@lists.cs.columbia.edu>; Mon, 26 Jul 2021 05:29:21 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X7524VO9Cnx4 for <kvmarm@lists.cs.columbia.edu>;
 Mon, 26 Jul 2021 05:29:20 -0400 (EDT)
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com
 [209.85.222.202])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 6FB9E49F5D
 for <kvmarm@lists.cs.columbia.edu>; Mon, 26 Jul 2021 05:29:20 -0400 (EDT)
Received: by mail-qk1-f202.google.com with SMTP id
 y3-20020ae9f4030000b02903b916ae903fso8482777qkl.6
 for <kvmarm@lists.cs.columbia.edu>; Mon, 26 Jul 2021 02:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=84HOeXnU0pbF9G+lxWpLi5LmB45NE4KeQQD7BXdPsl8=;
 b=cMHNjgNR6iYTCg9SnlXd5JprFEBC42R2JR6JBPVmKO5+6SCNE5EZLYh4v7UTkvUfN6
 t6wkyF9CKlEI5cXxhmXYMDFSOZYDO0AAckEXNLRWd6H6gEiNQPN6wMMeyDir/HKshs1+
 FCPT5va21Vb13pSxl8fS6/iXkR+tjTYdUEjbxVBdLTbShgstSgqjPL86AcHc+Ye+ue49
 VjuwZWfQB//83w9P76K/E4i6WCjZD9lZY9GImVnLwIRXaLmUJVjuwN/AlDId+x29ZZUg
 tCi2TqTjQ4JURKMRHBqh3A98VQyq/2IqxxOJQwm1erdvNictsIMzafbusfyAQSrOMvBm
 NPzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=84HOeXnU0pbF9G+lxWpLi5LmB45NE4KeQQD7BXdPsl8=;
 b=iskWWVxcDVx0bDCc/m1Qrwxx4RPjiLwip/xh/Kuf24fHj043FYuWkWR0X9UIbFTouS
 XrT/Yxa/jBXD6KAKJa4EBAhCdBN50qrqzMROxAUekIA1f9Z6eIa/kVf8GHuS+S7bTobY
 oktLkZs1mYM4ux4SFwzNuB4xcwEJ2kLGwmH+mKY5CbNRTSDVa3XmZyT9ezuiGsV1Tl0b
 o0DZQBqzOOS8kgAGgjxoskn5z01ME7zajpoTN+Ri4OcYkqonxw86NTHv/Yb0cuwdzEoS
 MUXBo/icbSKrhx2uCLOEI8G/sPkELNCkcToYy3RnvGurOPOfWwwazyBbK7a10c8yemyQ
 TkIg==
X-Gm-Message-State: AOAM533jRtPsB9jJ0FNaBmUvEZSbgxzGQjqlRgWE/ddSbNnIgrUqLtrl
 Fjh6FAomXd7HwSct5JPenDkWKggNMLLe
X-Google-Smtp-Source: ABdhPJyfe1AhRkOctDL7NrTZYRv4fXMomxCCFPgiSVK1+oOT3FvNCUPlQ7/f+TViZ8GyJREQgbWtnan1Sdjn
X-Received: from luke.lon.corp.google.com
 ([2a00:79e0:d:210:23a0:2f14:433:e6cb])
 (user=qperret job=sendgmr) by 2002:a05:6214:a62:: with SMTP id
 ef2mr868179qvb.56.1627291760042; Mon, 26 Jul 2021 02:29:20 -0700 (PDT)
Date: Mon, 26 Jul 2021 10:28:53 +0100
In-Reply-To: <20210726092905.2198501-1-qperret@google.com>
Message-Id: <20210726092905.2198501-5-qperret@google.com>
Mime-Version: 1.0
References: <20210726092905.2198501-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH v2 04/16] KVM: arm64: Optimize host memory aborts
From: Quentin Perret <qperret@google.com>
To: maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com, 
 suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org
Cc: qwandor@google.com, linux-kernel@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 kernel-team@android.com
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

The kvm_pgtable_stage2_find_range() function is used in the host memory
abort path to try and look for the largest block mapping that can be
used to map the faulting address. In order to do so, the function
currently walks the stage-2 page-table and looks for existing
incompatible mappings within the range of the largest possible block.
If incompatible mappings are found, it tries the same procedure again,
but using a smaller block range, and repeats until a matching range is
found (potentially up to page granularity). While this approach has
benefits (mostly in the fact that it proactively coalesces host stage-2
mappings), it can be slow if the ranges are fragmented, and it isn't
optimized to deal with CPUs faulting on the same IPA as all of them will
do all the work every time.

To avoid these issues, remove kvm_pgtable_stage2_find_range(), and walk
the page-table only once in the host_mem_abort() path to find the
closest leaf to the input address. With this, use the corresponding
range if it is invalid and not owned by another entity. If a valid leaf
is found, return -EAGAIN similar to what is done in the
kvm_pgtable_stage2_map() path to optimize concurrent faults.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_pgtable.h  | 30 -----------
 arch/arm64/kvm/hyp/nvhe/mem_protect.c | 39 +++++++++++++-
 arch/arm64/kvm/hyp/pgtable.c          | 74 ---------------------------
 3 files changed, 38 insertions(+), 105 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index 5a7a13bbd4a1..cec76a49f521 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -141,16 +141,6 @@ enum kvm_pgtable_prot {
 #define PAGE_HYP_RO		(KVM_PGTABLE_PROT_R)
 #define PAGE_HYP_DEVICE		(PAGE_HYP | KVM_PGTABLE_PROT_DEVICE)
 
-/**
- * struct kvm_mem_range - Range of Intermediate Physical Addresses
- * @start:	Start of the range.
- * @end:	End of the range.
- */
-struct kvm_mem_range {
-	u64 start;
-	u64 end;
-};
-
 /**
  * enum kvm_pgtable_walk_flags - Flags to control a depth-first page-table walk.
  * @KVM_PGTABLE_WALK_LEAF:		Visit leaf entries, including invalid
@@ -477,24 +467,4 @@ int kvm_pgtable_walk(struct kvm_pgtable *pgt, u64 addr, u64 size,
  */
 int kvm_pgtable_get_leaf(struct kvm_pgtable *pgt, u64 addr,
 			 kvm_pte_t *ptep, u32 *level);
-
-/**
- * kvm_pgtable_stage2_find_range() - Find a range of Intermediate Physical
- *				     Addresses with compatible permission
- *				     attributes.
- * @pgt:	Page-table structure initialised by kvm_pgtable_stage2_init*().
- * @addr:	Address that must be covered by the range.
- * @prot:	Protection attributes that the range must be compatible with.
- * @range:	Range structure used to limit the search space at call time and
- *		that will hold the result.
- *
- * The offset of @addr within a page is ignored. An IPA is compatible with @prot
- * iff its corresponding stage-2 page-table entry has default ownership and, if
- * valid, is mapped with protection attributes identical to @prot.
- *
- * Return: 0 on success, negative error code on failure.
- */
-int kvm_pgtable_stage2_find_range(struct kvm_pgtable *pgt, u64 addr,
-				  enum kvm_pgtable_prot prot,
-				  struct kvm_mem_range *range);
 #endif	/* __ARM64_KVM_PGTABLE_H__ */
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 871149246f5f..01700a908bb7 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -159,6 +159,11 @@ static int host_stage2_unmap_dev_all(void)
 	return kvm_pgtable_stage2_unmap(pgt, addr, BIT(pgt->ia_bits) - addr);
 }
 
+struct kvm_mem_range {
+	u64 start;
+	u64 end;
+};
+
 static bool find_mem_range(phys_addr_t addr, struct kvm_mem_range *range)
 {
 	int cur, left = 0, right = hyp_memblock_nr;
@@ -227,6 +232,38 @@ static inline int __host_stage2_idmap(u64 start, u64 end,
 		__ret;							\
 	 })
 
+static int host_stage2_find_range(u64 addr, struct kvm_mem_range *range)
+{
+	u64 granule, start, end;
+	kvm_pte_t pte;
+	u32 level;
+	int ret;
+
+	ret = kvm_pgtable_get_leaf(&host_kvm.pgt, addr, &pte, &level);
+	if (ret)
+		return ret;
+
+	if (kvm_pte_valid(pte))
+		return -EAGAIN;
+
+	if (pte)
+		return -EPERM;
+
+	do {
+		granule = kvm_granule_size(level);
+		start = ALIGN_DOWN(addr, granule);
+		end = start + granule;
+		level++;
+	} while ((level < KVM_PGTABLE_MAX_LEVELS) &&
+			(!kvm_level_supports_block_mapping(level) ||
+			 start < range->start || range->end < end));
+
+	range->start = start;
+	range->end = end;
+
+	return 0;
+}
+
 static int host_stage2_idmap(u64 addr)
 {
 	enum kvm_pgtable_prot prot = KVM_PGTABLE_PROT_R | KVM_PGTABLE_PROT_W;
@@ -238,7 +275,7 @@ static int host_stage2_idmap(u64 addr)
 		prot |= KVM_PGTABLE_PROT_X;
 
 	hyp_spin_lock(&host_kvm.lock);
-	ret = kvm_pgtable_stage2_find_range(&host_kvm.pgt, addr, prot, &range);
+	ret = host_stage2_find_range(addr, &range);
 	if (ret)
 		goto unlock;
 
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 2c5d4d3e31cc..55199e579863 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -1115,77 +1115,3 @@ void kvm_pgtable_stage2_destroy(struct kvm_pgtable *pgt)
 	pgt->mm_ops->free_pages_exact(pgt->pgd, pgd_sz);
 	pgt->pgd = NULL;
 }
-
-#define KVM_PTE_LEAF_S2_COMPAT_MASK	(KVM_PTE_LEAF_ATTR_S2_PERMS | \
-					 KVM_PTE_LEAF_ATTR_LO_S2_MEMATTR | \
-					 KVM_PTE_LEAF_ATTR_S2_IGNORED)
-
-static int stage2_check_permission_walker(u64 addr, u64 end, u32 level,
-					  kvm_pte_t *ptep,
-					  enum kvm_pgtable_walk_flags flag,
-					  void * const arg)
-{
-	kvm_pte_t old_attr, pte = *ptep, *new_attr = arg;
-
-	/*
-	 * Compatible mappings are either invalid and owned by the page-table
-	 * owner (whose id is 0), or valid with matching permission attributes.
-	 */
-	if (kvm_pte_valid(pte)) {
-		old_attr = pte & KVM_PTE_LEAF_S2_COMPAT_MASK;
-		if (old_attr != *new_attr)
-			return -EEXIST;
-	} else if (pte) {
-		return -EEXIST;
-	}
-
-	return 0;
-}
-
-int kvm_pgtable_stage2_find_range(struct kvm_pgtable *pgt, u64 addr,
-				  enum kvm_pgtable_prot prot,
-				  struct kvm_mem_range *range)
-{
-	kvm_pte_t attr;
-	struct kvm_pgtable_walker check_perm_walker = {
-		.cb		= stage2_check_permission_walker,
-		.flags		= KVM_PGTABLE_WALK_LEAF,
-		.arg		= &attr,
-	};
-	u64 granule, start, end;
-	u32 level;
-	int ret;
-
-	ret = stage2_set_prot_attr(pgt, prot, &attr);
-	if (ret)
-		return ret;
-	attr &= KVM_PTE_LEAF_S2_COMPAT_MASK;
-
-	for (level = pgt->start_level; level < KVM_PGTABLE_MAX_LEVELS; level++) {
-		granule = kvm_granule_size(level);
-		start = ALIGN_DOWN(addr, granule);
-		end = start + granule;
-
-		if (!kvm_level_supports_block_mapping(level))
-			continue;
-
-		if (start < range->start || range->end < end)
-			continue;
-
-		/*
-		 * Check the presence of existing mappings with incompatible
-		 * permissions within the current block range, and try one level
-		 * deeper if one is found.
-		 */
-		ret = kvm_pgtable_walk(pgt, start, granule, &check_perm_walker);
-		if (ret != -EEXIST)
-			break;
-	}
-
-	if (!ret) {
-		range->start = start;
-		range->end = end;
-	}
-
-	return ret;
-}
-- 
2.32.0.432.gabb21c7263-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
