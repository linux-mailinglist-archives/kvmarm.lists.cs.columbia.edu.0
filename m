Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 74780266034
	for <lists+kvmarm@lfdr.de>; Fri, 11 Sep 2020 15:26:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 298DA4B418;
	Fri, 11 Sep 2020 09:26:18 -0400 (EDT)
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
	with ESMTP id IFwzJ7xqtVob; Fri, 11 Sep 2020 09:26:17 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0C39B4B3FB;
	Fri, 11 Sep 2020 09:26:17 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7C86D4B3E9
 for <kvmarm@lists.cs.columbia.edu>; Fri, 11 Sep 2020 09:26:15 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XQWCrOT3sdRQ for <kvmarm@lists.cs.columbia.edu>;
 Fri, 11 Sep 2020 09:26:14 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 75FAC4B2D5
 for <kvmarm@lists.cs.columbia.edu>; Fri, 11 Sep 2020 09:26:14 -0400 (EDT)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C4A8822227;
 Fri, 11 Sep 2020 13:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599830773;
 bh=7IYY9uULuVe/MjylAj8GoTc47x5DxIsC9D0HqIcZNHI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qDLQQPza9rtYqYfFwkV/ORd7jKHkGxN1GtBwvlPEMhnns4rz4U3B1xZxXFAq3ceSR
 SnYwI7pxfjt93c0RMACf0rbmCLidkk3u7Nd9kccHuVZhqM7KDjwqlzRV00VgMkwoMv
 lejp2a8SpjKDflSJdTSRBJcVBjB8+2kksLKkhUqw=
From: Will Deacon <will@kernel.org>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v5 15/21] KVM: arm64: Convert memslot cache-flushing code to
 generic page-table API
Date: Fri, 11 Sep 2020 14:25:23 +0100
Message-Id: <20200911132529.19844-16-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200911132529.19844-1-will@kernel.org>
References: <20200911132529.19844-1-will@kernel.org>
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

From: Quentin Perret <qperret@google.com>

Convert stage2_flush_memslot() to call the kvm_pgtable_stage2_flush()
function of the generic page-table code instead of walking the page-table
directly.

Cc: Marc Zyngier <maz@kernel.org>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Signed-off-by: Quentin Perret <qperret@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kvm/mmu.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index a37da87eb7eb..d5813996c0e4 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -460,21 +460,10 @@ static void stage2_flush_p4ds(struct kvm_s2_mmu *mmu, pgd_t *pgd,
 static void stage2_flush_memslot(struct kvm *kvm,
 				 struct kvm_memory_slot *memslot)
 {
-	struct kvm_s2_mmu *mmu = &kvm->arch.mmu;
 	phys_addr_t addr = memslot->base_gfn << PAGE_SHIFT;
 	phys_addr_t end = addr + PAGE_SIZE * memslot->npages;
-	phys_addr_t next;
-	pgd_t *pgd;
 
-	pgd = mmu->pgd + stage2_pgd_index(kvm, addr);
-	do {
-		next = stage2_pgd_addr_end(kvm, addr, end);
-		if (!stage2_pgd_none(kvm, *pgd))
-			stage2_flush_p4ds(mmu, pgd, addr, next);
-
-		if (next != end)
-			cond_resched_lock(&kvm->mmu_lock);
-	} while (pgd++, addr = next, addr != end);
+	stage2_apply_range_resched(kvm, addr, end, kvm_pgtable_stage2_flush);
 }
 
 /**
-- 
2.28.0.618.gf4bc123cb7-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
