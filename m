Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 755BD61797A
	for <lists+kvmarm@lfdr.de>; Thu,  3 Nov 2022 10:12:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 222A34B7A7;
	Thu,  3 Nov 2022 05:12:31 -0400 (EDT)
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
	with ESMTP id Dt855vr-sMTj; Thu,  3 Nov 2022 05:12:31 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D537E4B6C8;
	Thu,  3 Nov 2022 05:12:29 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5C8714B6FA
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Nov 2022 05:12:29 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kYRhkUYa0s0o for <kvmarm@lists.cs.columbia.edu>;
 Thu,  3 Nov 2022 05:12:27 -0400 (EDT)
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 636194B641
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Nov 2022 05:12:27 -0400 (EDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1667466746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=snz2XgXIkyROwfeP7R4jzndcwBti7/Z4//RPYPLYzwM=;
 b=iljYu8Qzlra37QJFK9GRCJnE9oQubXLSUXeBozcFmgXIMEDvzv7NBS754UInzGpaqRqh9S
 mI24vsvgLjnmB9STcdm9lYtjWb8J15KN83QZCjXSzQ7mhAwSeYllJpFO5NBEDlbgrM7IkN
 GnFEexGb/s7Jv5YACWEJ36DkarA8BBQ=
From: Oliver Upton <oliver.upton@linux.dev>
To: Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>
Subject: [PATCH v4 09/14] KVM: arm64: Atomically update stage 2 leaf
 attributes in parallel walks
Date: Thu,  3 Nov 2022 09:11:35 +0000
Message-Id: <20221103091140.1040433-10-oliver.upton@linux.dev>
In-Reply-To: <20221103091140.1040433-1-oliver.upton@linux.dev>
References: <20221103091140.1040433-1-oliver.upton@linux.dev>
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

The stage2 attr walker is already used for parallel walks. Since commit
f783ef1c0e82 ("KVM: arm64: Add fast path to handle permission relaxation
during dirty logging"), KVM acquires the read lock when
write-unprotecting a PTE. However, the walker only uses a simple store
to update the PTE. This is safe as the only possible race is with
hardware updates to the access flag, which is benign.

However, a subsequent change to KVM will allow more changes to the stage
2 page tables to be done in parallel. Prepare the stage 2 attribute
walker by performing atomic updates to the PTE when walking in parallel.

Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 arch/arm64/kvm/hyp/pgtable.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 156754d87b2a..2950058a2069 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -185,7 +185,7 @@ static inline int __kvm_pgtable_visit(struct kvm_pgtable_walk_data *data,
 				      kvm_pteref_t pteref, u32 level)
 {
 	enum kvm_pgtable_walk_flags flags = data->walker->flags;
-	kvm_pte_t *ptep = kvm_dereference_pteref(pteref, false);
+	kvm_pte_t *ptep = kvm_dereference_pteref(pteref, flags & KVM_PGTABLE_WALK_SHARED);
 	struct kvm_pgtable_visit_ctx ctx = {
 		.ptep	= ptep,
 		.old	= READ_ONCE(*ptep),
@@ -675,6 +675,16 @@ static bool stage2_pte_is_counted(kvm_pte_t pte)
 	return !!pte;
 }
 
+static bool stage2_try_set_pte(const struct kvm_pgtable_visit_ctx *ctx, kvm_pte_t new)
+{
+	if (!kvm_pgtable_walk_shared(ctx)) {
+		WRITE_ONCE(*ctx->ptep, new);
+		return true;
+	}
+
+	return cmpxchg(ctx->ptep, ctx->old, new) == ctx->old;
+}
+
 static void stage2_put_pte(const struct kvm_pgtable_visit_ctx *ctx, struct kvm_s2_mmu *mmu,
 			   struct kvm_pgtable_mm_ops *mm_ops)
 {
@@ -986,7 +996,9 @@ static int stage2_attr_walker(const struct kvm_pgtable_visit_ctx *ctx,
 		    stage2_pte_executable(pte) && !stage2_pte_executable(ctx->old))
 			mm_ops->icache_inval_pou(kvm_pte_follow(pte, mm_ops),
 						  kvm_granule_size(ctx->level));
-		WRITE_ONCE(*ctx->ptep, pte);
+
+		if (!stage2_try_set_pte(ctx, pte))
+			return -EAGAIN;
 	}
 
 	return 0;
@@ -995,7 +1007,7 @@ static int stage2_attr_walker(const struct kvm_pgtable_visit_ctx *ctx,
 static int stage2_update_leaf_attrs(struct kvm_pgtable *pgt, u64 addr,
 				    u64 size, kvm_pte_t attr_set,
 				    kvm_pte_t attr_clr, kvm_pte_t *orig_pte,
-				    u32 *level)
+				    u32 *level, enum kvm_pgtable_walk_flags flags)
 {
 	int ret;
 	kvm_pte_t attr_mask = KVM_PTE_LEAF_ATTR_LO | KVM_PTE_LEAF_ATTR_HI;
@@ -1006,7 +1018,7 @@ static int stage2_update_leaf_attrs(struct kvm_pgtable *pgt, u64 addr,
 	struct kvm_pgtable_walker walker = {
 		.cb		= stage2_attr_walker,
 		.arg		= &data,
-		.flags		= KVM_PGTABLE_WALK_LEAF,
+		.flags		= flags | KVM_PGTABLE_WALK_LEAF,
 	};
 
 	ret = kvm_pgtable_walk(pgt, addr, size, &walker);
@@ -1025,14 +1037,14 @@ int kvm_pgtable_stage2_wrprotect(struct kvm_pgtable *pgt, u64 addr, u64 size)
 {
 	return stage2_update_leaf_attrs(pgt, addr, size, 0,
 					KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W,
-					NULL, NULL);
+					NULL, NULL, 0);
 }
 
 kvm_pte_t kvm_pgtable_stage2_mkyoung(struct kvm_pgtable *pgt, u64 addr)
 {
 	kvm_pte_t pte = 0;
 	stage2_update_leaf_attrs(pgt, addr, 1, KVM_PTE_LEAF_ATTR_LO_S2_AF, 0,
-				 &pte, NULL);
+				 &pte, NULL, 0);
 	dsb(ishst);
 	return pte;
 }
@@ -1041,7 +1053,7 @@ kvm_pte_t kvm_pgtable_stage2_mkold(struct kvm_pgtable *pgt, u64 addr)
 {
 	kvm_pte_t pte = 0;
 	stage2_update_leaf_attrs(pgt, addr, 1, 0, KVM_PTE_LEAF_ATTR_LO_S2_AF,
-				 &pte, NULL);
+				 &pte, NULL, 0);
 	/*
 	 * "But where's the TLBI?!", you scream.
 	 * "Over in the core code", I sigh.
@@ -1054,7 +1066,7 @@ kvm_pte_t kvm_pgtable_stage2_mkold(struct kvm_pgtable *pgt, u64 addr)
 bool kvm_pgtable_stage2_is_young(struct kvm_pgtable *pgt, u64 addr)
 {
 	kvm_pte_t pte = 0;
-	stage2_update_leaf_attrs(pgt, addr, 1, 0, 0, &pte, NULL);
+	stage2_update_leaf_attrs(pgt, addr, 1, 0, 0, &pte, NULL, 0);
 	return pte & KVM_PTE_LEAF_ATTR_LO_S2_AF;
 }
 
@@ -1077,7 +1089,8 @@ int kvm_pgtable_stage2_relax_perms(struct kvm_pgtable *pgt, u64 addr,
 	if (prot & KVM_PGTABLE_PROT_X)
 		clr |= KVM_PTE_LEAF_ATTR_HI_S2_XN;
 
-	ret = stage2_update_leaf_attrs(pgt, addr, 1, set, clr, NULL, &level);
+	ret = stage2_update_leaf_attrs(pgt, addr, 1, set, clr, NULL, &level,
+				       KVM_PGTABLE_WALK_SHARED);
 	if (!ret)
 		kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, pgt->mmu, addr, level);
 	return ret;
-- 
2.38.1.431.g37b22c650d-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
