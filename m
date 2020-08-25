Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id DC59625159A
	for <lists+kvmarm@lfdr.de>; Tue, 25 Aug 2020 11:40:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 90A874C05A;
	Tue, 25 Aug 2020 05:40:29 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r1W0i71cexGJ; Tue, 25 Aug 2020 05:40:27 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F42134C0A4;
	Tue, 25 Aug 2020 05:40:26 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1ADE34BE82
 for <kvmarm@lists.cs.columbia.edu>; Tue, 25 Aug 2020 05:40:26 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0JhjfJdFZ9Kp for <kvmarm@lists.cs.columbia.edu>;
 Tue, 25 Aug 2020 05:40:25 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id CA1184C095
 for <kvmarm@lists.cs.columbia.edu>; Tue, 25 Aug 2020 05:40:22 -0400 (EDT)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6CD1E20767;
 Tue, 25 Aug 2020 09:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598348422;
 bh=FTJHi5pXqo3iWTD/ns1efWm5XgPd8Ep4ZviMb9VtJEs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DMblZVX/eIn2fxNlObER+c0UtMtDgVpxyxbo6AH15y9ncAcMydSHs0TOyrJD4e+Gp
 lEz7aWtwNlD1cwEIEB+ZAc/hPiRg5EyQ/t/LyJPLFtKp/khZDKoZi68wlr4u06fzuB
 5mCDKJ/iyyQtUt9FttP+KDfHGO+AYKgshM4OmM3U=
From: Will Deacon <will@kernel.org>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v3 09/21] KVM: arm64: Convert unmap_stage2_range() to generic
 page-table API
Date: Tue, 25 Aug 2020 10:39:41 +0100
Message-Id: <20200825093953.26493-10-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200825093953.26493-1-will@kernel.org>
References: <20200825093953.26493-1-will@kernel.org>
MIME-Version: 1.0
Cc: kernel-team@android.com, Marc Zyngier <maz@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
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

Convert unmap_stage2_range() to use kvm_pgtable_stage2_unmap() instead
of walking the page-table directly.

Cc: Marc Zyngier <maz@kernel.org>
Cc: Quentin Perret <qperret@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kvm/mmu.c | 57 +++++++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 704b471a48ce..751ce2462765 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -39,6 +39,33 @@ static bool is_iomap(unsigned long flags)
 	return flags & KVM_S2PTE_FLAG_IS_IOMAP;
 }
 
+/*
+ * Release kvm_mmu_lock periodically if the memory region is large. Otherwise,
+ * we may see kernel panics with CONFIG_DETECT_HUNG_TASK,
+ * CONFIG_LOCKUP_DETECTOR, CONFIG_LOCKDEP. Additionally, holding the lock too
+ * long will also starve other vCPUs. We have to also make sure that the page
+ * tables are not freed while we released the lock.
+ */
+#define stage2_apply_range(kvm, addr, end, fn, resched)			\
+({									\
+	int ret;							\
+	struct kvm *__kvm = (kvm);					\
+	bool __resched = (resched);					\
+	u64 next, __addr = (addr), __end = (end);			\
+	do {								\
+		struct kvm_pgtable *pgt = __kvm->arch.mmu.pgt;		\
+		if (!pgt)						\
+			break;						\
+		next = stage2_pgd_addr_end(__kvm, __addr, __end);	\
+		ret = fn(pgt, __addr, next - __addr);			\
+		if (ret)						\
+			break;						\
+		if (__resched && next != __end)				\
+			cond_resched_lock(&__kvm->mmu_lock);		\
+	} while (__addr = next, __addr != __end);			\
+	ret;								\
+})
+
 static bool memslot_is_logging(struct kvm_memory_slot *memslot)
 {
 	return memslot->dirty_bitmap && !(memslot->flags & KVM_MEM_READONLY);
@@ -220,8 +247,8 @@ static inline void kvm_pgd_populate(pgd_t *pgdp, p4d_t *p4dp)
  * end up writing old data to disk.
  *
  * This is why right after unmapping a page/section and invalidating
- * the corresponding TLBs, we call kvm_flush_dcache_p*() to make sure
- * the IO subsystem will never hit in the cache.
+ * the corresponding TLBs, we flush to make sure the IO subsystem will
+ * never hit in the cache.
  *
  * This is all avoided on systems that have ARM64_HAS_STAGE2_FWB, as
  * we then fully enforce cacheability of RAM, no matter what the guest
@@ -344,32 +371,12 @@ static void __unmap_stage2_range(struct kvm_s2_mmu *mmu, phys_addr_t start, u64
 				 bool may_block)
 {
 	struct kvm *kvm = mmu->kvm;
-	pgd_t *pgd;
-	phys_addr_t addr = start, end = start + size;
-	phys_addr_t next;
+	phys_addr_t end = start + size;
 
 	assert_spin_locked(&kvm->mmu_lock);
 	WARN_ON(size & ~PAGE_MASK);
-
-	pgd = mmu->pgd + stage2_pgd_index(kvm, addr);
-	do {
-		/*
-		 * Make sure the page table is still active, as another thread
-		 * could have possibly freed the page table, while we released
-		 * the lock.
-		 */
-		if (!READ_ONCE(mmu->pgd))
-			break;
-		next = stage2_pgd_addr_end(kvm, addr, end);
-		if (!stage2_pgd_none(kvm, *pgd))
-			unmap_stage2_p4ds(mmu, pgd, addr, next);
-		/*
-		 * If the range is too large, release the kvm->mmu_lock
-		 * to prevent starvation and lockup detector warnings.
-		 */
-		if (may_block && next != end)
-			cond_resched_lock(&kvm->mmu_lock);
-	} while (pgd++, addr = next, addr != end);
+	WARN_ON(stage2_apply_range(kvm, start, end, kvm_pgtable_stage2_unmap,
+				   may_block));
 }
 
 static void unmap_stage2_range(struct kvm_s2_mmu *mmu, phys_addr_t start, u64 size)
-- 
2.28.0.297.g1956fa8f8d-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
