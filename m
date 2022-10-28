Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 84AC06105AB
	for <lists+kvmarm@lfdr.de>; Fri, 28 Oct 2022 00:23:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 03E974B13D;
	Thu, 27 Oct 2022 18:23:26 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -2.49
X-Spam-Level: 
X-Spam-Status: No, score=-2.49 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
	T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@linux.dev
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VNAx9wvrXzNr; Thu, 27 Oct 2022 18:23:25 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A06794A105;
	Thu, 27 Oct 2022 18:23:24 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 836C649F38
 for <kvmarm@lists.cs.columbia.edu>; Thu, 27 Oct 2022 18:23:23 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 02mYhSUW4krX for <kvmarm@lists.cs.columbia.edu>;
 Thu, 27 Oct 2022 18:23:22 -0400 (EDT)
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 50DD249EED
 for <kvmarm@lists.cs.columbia.edu>; Thu, 27 Oct 2022 18:23:22 -0400 (EDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1666909401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QDsaPTkBMVoCvpIbixNEzKkPpLmJ5PGsxu8t4GywA5c=;
 b=wYHQqf+dD0czI4mBZkyslR+ThYtCpgPd3GvtdhSqUuA0toNUVFKlGxD7Dhk1on/QapVGoL
 PiK+8XDZOuRvPQFfkmD1mkJKZPMyRgyU/PvUT0UQzqQYj3Ovy3pgx9F3txPwU3KIThN6yP
 8AgDitEUCXh9tC9FoqFHQyfkX/rKmQ4=
From: Oliver Upton <oliver.upton@linux.dev>
To: Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>
Subject: [PATCH v3 13/15] KVM: arm64: Make leaf->leaf PTE changes
 parallel-aware
Date: Thu, 27 Oct 2022 22:23:11 +0000
Message-Id: <20221027222311.1685097-1-oliver.upton@linux.dev>
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

Convert stage2_map_walker_try_leaf() to use the new break-before-make
helpers, thereby making the handler parallel-aware. As before, avoid the
break-before-make if recreating the existing mapping. Additionally,
retry execution if another vCPU thread is modifying the same PTE.

Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 arch/arm64/kvm/hyp/pgtable.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 1df858c21b2e..581ba688c6f7 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -804,18 +804,17 @@ static int stage2_map_walker_try_leaf(const struct kvm_pgtable_visit_ctx *ctx,
 	else
 		new = kvm_init_invalid_leaf_owner(data->owner_id);
 
-	if (stage2_pte_is_counted(ctx->old)) {
-		/*
-		 * Skip updating the PTE if we are trying to recreate the exact
-		 * same mapping or only change the access permissions. Instead,
-		 * the vCPU will exit one more time from guest if still needed
-		 * and then go through the path of relaxing permissions.
-		 */
-		if (!stage2_pte_needs_update(ctx->old, new))
-			return -EAGAIN;
+	/*
+	 * Skip updating the PTE if we are trying to recreate the exact
+	 * same mapping or only change the access permissions. Instead,
+	 * the vCPU will exit one more time from guest if still needed
+	 * and then go through the path of relaxing permissions.
+	 */
+	if (!stage2_pte_needs_update(ctx->old, new))
+		return -EAGAIN;
 
-		stage2_put_pte(ctx, data->mmu, mm_ops);
-	}
+	if (!stage2_try_break_pte(ctx, data))
+		return -EAGAIN;
 
 	/* Perform CMOs before installation of the guest stage-2 PTE */
 	if (mm_ops->dcache_clean_inval_poc && stage2_pte_cacheable(pgt, new))
@@ -825,9 +824,8 @@ static int stage2_map_walker_try_leaf(const struct kvm_pgtable_visit_ctx *ctx,
 	if (mm_ops->icache_inval_pou && stage2_pte_executable(new))
 		mm_ops->icache_inval_pou(kvm_pte_follow(new, mm_ops), granule);
 
-	smp_store_release(ctx->ptep, new);
-	if (stage2_pte_is_counted(new))
-		mm_ops->get_page(ctx->ptep);
+	stage2_make_pte(ctx, new);
+
 	if (kvm_phys_is_valid(phys))
 		data->phys += granule;
 	return 0;
-- 
2.38.1.273.g43a17bfeac-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
