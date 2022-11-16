Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BD64A62C592
	for <lists+kvmarm@lfdr.de>; Wed, 16 Nov 2022 17:57:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 49B014B8E5;
	Wed, 16 Nov 2022 11:57:17 -0500 (EST)
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
	with ESMTP id Nf5Woe8V-W6a; Wed, 16 Nov 2022 11:57:17 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C29654B8D4;
	Wed, 16 Nov 2022 11:57:15 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0F7294B8B3
 for <kvmarm@lists.cs.columbia.edu>; Wed, 16 Nov 2022 11:57:15 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iNPhr-MrH3GY for <kvmarm@lists.cs.columbia.edu>;
 Wed, 16 Nov 2022 11:57:13 -0500 (EST)
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D5E944B891
 for <kvmarm@lists.cs.columbia.edu>; Wed, 16 Nov 2022 11:57:12 -0500 (EST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1668617832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KOTqOJazrNlg6uf0of0H9oY+uUV+g1nfwPZCAYMKJ64=;
 b=WMRi/CC4iw4j1vxt5iLaz3Gbv/Sah9GKivsYmN6GjhPfPEiFyZT3R/jgn2Tr7YxQZCIaQZ
 liPtIscA4LFP8VtIPJU1zhUHW/x7aDXbd54UQmemFS3LV/fXXkrctOqmmYKF4dPZkI/OLf
 SDOZDpWi/LJ2juG4txA2WgrXC5V2/ZQ=
From: Oliver Upton <oliver.upton@linux.dev>
To: Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Oliver Upton <oliver.upton@linux.dev>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Subject: [PATCH v3 1/2] KVM: arm64: Take a pointer to walker data in
 kvm_dereference_pteref()
Date: Wed, 16 Nov 2022 16:56:54 +0000
Message-Id: <20221116165655.2649475-2-oliver.upton@linux.dev>
In-Reply-To: <20221116165655.2649475-1-oliver.upton@linux.dev>
References: <20221116165655.2649475-1-oliver.upton@linux.dev>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT
Cc: kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 kvm@vger.kernel.org
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

Rather than passing through the state of the KVM_PGTABLE_WALK_SHARED
flag, just take a pointer to the whole walker structure instead. Move
around struct kvm_pgtable and the RCU indirection such that the
associated ifdeffery remains in one place while ensuring the walker +
flags definitions precede their use.

No functional change intended.

Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 arch/arm64/include/asm/kvm_pgtable.h | 144 ++++++++++++++-------------
 arch/arm64/kvm/hyp/pgtable.c         |   6 +-
 2 files changed, 76 insertions(+), 74 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index a874ce0ce7b5..f23af693e3c5 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -37,54 +37,6 @@ static inline u64 kvm_get_parange(u64 mmfr0)
 
 typedef u64 kvm_pte_t;
 
-/*
- * RCU cannot be used in a non-kernel context such as the hyp. As such, page
- * table walkers used in hyp do not call into RCU and instead use other
- * synchronization mechanisms (such as a spinlock).
- */
-#if defined(__KVM_NVHE_HYPERVISOR__) || defined(__KVM_VHE_HYPERVISOR__)
-
-typedef kvm_pte_t *kvm_pteref_t;
-
-static inline kvm_pte_t *kvm_dereference_pteref(kvm_pteref_t pteref, bool shared)
-{
-	return pteref;
-}
-
-static inline void kvm_pgtable_walk_begin(void) {}
-static inline void kvm_pgtable_walk_end(void) {}
-
-static inline bool kvm_pgtable_walk_lock_held(void)
-{
-	return true;
-}
-
-#else
-
-typedef kvm_pte_t __rcu *kvm_pteref_t;
-
-static inline kvm_pte_t *kvm_dereference_pteref(kvm_pteref_t pteref, bool shared)
-{
-	return rcu_dereference_check(pteref, !shared);
-}
-
-static inline void kvm_pgtable_walk_begin(void)
-{
-	rcu_read_lock();
-}
-
-static inline void kvm_pgtable_walk_end(void)
-{
-	rcu_read_unlock();
-}
-
-static inline bool kvm_pgtable_walk_lock_held(void)
-{
-	return rcu_read_lock_held();
-}
-
-#endif
-
 #define KVM_PTE_VALID			BIT(0)
 
 #define KVM_PTE_ADDR_MASK		GENMASK(47, PAGE_SHIFT)
@@ -212,29 +164,6 @@ enum kvm_pgtable_prot {
 typedef bool (*kvm_pgtable_force_pte_cb_t)(u64 addr, u64 end,
 					   enum kvm_pgtable_prot prot);
 
-/**
- * struct kvm_pgtable - KVM page-table.
- * @ia_bits:		Maximum input address size, in bits.
- * @start_level:	Level at which the page-table walk starts.
- * @pgd:		Pointer to the first top-level entry of the page-table.
- * @mm_ops:		Memory management callbacks.
- * @mmu:		Stage-2 KVM MMU struct. Unused for stage-1 page-tables.
- * @flags:		Stage-2 page-table flags.
- * @force_pte_cb:	Function that returns true if page level mappings must
- *			be used instead of block mappings.
- */
-struct kvm_pgtable {
-	u32					ia_bits;
-	u32					start_level;
-	kvm_pteref_t				pgd;
-	struct kvm_pgtable_mm_ops		*mm_ops;
-
-	/* Stage-2 only */
-	struct kvm_s2_mmu			*mmu;
-	enum kvm_pgtable_stage2_flags		flags;
-	kvm_pgtable_force_pte_cb_t		force_pte_cb;
-};
-
 /**
  * enum kvm_pgtable_walk_flags - Flags to control a depth-first page-table walk.
  * @KVM_PGTABLE_WALK_LEAF:		Visit leaf entries, including invalid
@@ -285,6 +214,79 @@ struct kvm_pgtable_walker {
 	const enum kvm_pgtable_walk_flags	flags;
 };
 
+/*
+ * RCU cannot be used in a non-kernel context such as the hyp. As such, page
+ * table walkers used in hyp do not call into RCU and instead use other
+ * synchronization mechanisms (such as a spinlock).
+ */
+#if defined(__KVM_NVHE_HYPERVISOR__) || defined(__KVM_VHE_HYPERVISOR__)
+
+typedef kvm_pte_t *kvm_pteref_t;
+
+static inline kvm_pte_t *kvm_dereference_pteref(struct kvm_pgtable_walker *walker,
+						kvm_pteref_t pteref)
+{
+	return pteref;
+}
+
+static inline void kvm_pgtable_walk_begin(void) {}
+static inline void kvm_pgtable_walk_end(void) {}
+
+static inline bool kvm_pgtable_walk_lock_held(void)
+{
+	return true;
+}
+
+#else
+
+typedef kvm_pte_t __rcu *kvm_pteref_t;
+
+static inline kvm_pte_t *kvm_dereference_pteref(struct kvm_pgtable_walker *walker,
+						kvm_pteref_t pteref)
+{
+	return rcu_dereference_check(pteref, !(walker->flags & KVM_PGTABLE_WALK_SHARED));
+}
+
+static inline void kvm_pgtable_walk_begin(void)
+{
+	rcu_read_lock();
+}
+
+static inline void kvm_pgtable_walk_end(void)
+{
+	rcu_read_unlock();
+}
+
+static inline bool kvm_pgtable_walk_lock_held(void)
+{
+	return rcu_read_lock_held();
+}
+
+#endif
+
+/**
+ * struct kvm_pgtable - KVM page-table.
+ * @ia_bits:		Maximum input address size, in bits.
+ * @start_level:	Level at which the page-table walk starts.
+ * @pgd:		Pointer to the first top-level entry of the page-table.
+ * @mm_ops:		Memory management callbacks.
+ * @mmu:		Stage-2 KVM MMU struct. Unused for stage-1 page-tables.
+ * @flags:		Stage-2 page-table flags.
+ * @force_pte_cb:	Function that returns true if page level mappings must
+ *			be used instead of block mappings.
+ */
+struct kvm_pgtable {
+	u32					ia_bits;
+	u32					start_level;
+	kvm_pteref_t				pgd;
+	struct kvm_pgtable_mm_ops		*mm_ops;
+
+	/* Stage-2 only */
+	struct kvm_s2_mmu			*mmu;
+	enum kvm_pgtable_stage2_flags		flags;
+	kvm_pgtable_force_pte_cb_t		force_pte_cb;
+};
+
 /**
  * kvm_pgtable_hyp_init() - Initialise a hypervisor stage-1 page-table.
  * @pgt:	Uninitialised page-table structure to initialise.
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 5bca9610d040..b5b91a882836 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -188,7 +188,7 @@ static inline int __kvm_pgtable_visit(struct kvm_pgtable_walk_data *data,
 				      kvm_pteref_t pteref, u32 level)
 {
 	enum kvm_pgtable_walk_flags flags = data->walker->flags;
-	kvm_pte_t *ptep = kvm_dereference_pteref(pteref, flags & KVM_PGTABLE_WALK_SHARED);
+	kvm_pte_t *ptep = kvm_dereference_pteref(data->walker, pteref);
 	struct kvm_pgtable_visit_ctx ctx = {
 		.ptep	= ptep,
 		.old	= READ_ONCE(*ptep),
@@ -558,7 +558,7 @@ void kvm_pgtable_hyp_destroy(struct kvm_pgtable *pgt)
 	};
 
 	WARN_ON(kvm_pgtable_walk(pgt, 0, BIT(pgt->ia_bits), &walker));
-	pgt->mm_ops->put_page(kvm_dereference_pteref(pgt->pgd, false));
+	pgt->mm_ops->put_page(kvm_dereference_pteref(&walker, pgt->pgd));
 	pgt->pgd = NULL;
 }
 
@@ -1241,7 +1241,7 @@ void kvm_pgtable_stage2_destroy(struct kvm_pgtable *pgt)
 
 	WARN_ON(kvm_pgtable_walk(pgt, 0, BIT(pgt->ia_bits), &walker));
 	pgd_sz = kvm_pgd_pages(pgt->ia_bits, pgt->start_level) * PAGE_SIZE;
-	pgt->mm_ops->free_pages_exact(kvm_dereference_pteref(pgt->pgd, false), pgd_sz);
+	pgt->mm_ops->free_pages_exact(kvm_dereference_pteref(&walker, pgt->pgd), pgd_sz);
 	pgt->pgd = NULL;
 }
 
-- 
2.38.1.431.g37b22c650d-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
