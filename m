Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2AED8248603
	for <lists+kvmarm@lfdr.de>; Tue, 18 Aug 2020 15:29:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D24134BF86;
	Tue, 18 Aug 2020 09:29:01 -0400 (EDT)
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
	with ESMTP id aAncudgSdl1k; Tue, 18 Aug 2020 09:29:00 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3F1534BF07;
	Tue, 18 Aug 2020 09:29:00 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D57434B4DE
 for <kvmarm@lists.cs.columbia.edu>; Tue, 18 Aug 2020 09:28:58 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hzGe1jINV-0H for <kvmarm@lists.cs.columbia.edu>;
 Tue, 18 Aug 2020 09:28:57 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D1F6C4BD4F
 for <kvmarm@lists.cs.columbia.edu>; Tue, 18 Aug 2020 09:28:57 -0400 (EDT)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 98A25207D3;
 Tue, 18 Aug 2020 13:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597757337;
 bh=Bpbc28/zv8Ky5wgxNZEag8t6lkulUyz2oIB1kh5zqmk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RiaqtRs6Cu407+xrBHWq5j+edbB7KDj8p0nSLqc9FlTil+bxIGvQl3CjxIl5ab5MZ
 vLKCQYipVeAG9AItEAcVzXuojhLkexWI8PV/q5snrKYBy9HhiyHpz9Mc240HIi4hQ1
 FXL36b+CtFJfBUIioIEW1phpAL8hWedV43ftIn/k=
From: Will Deacon <will@kernel.org>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v2 14/22] KVM: arm64: Convert write-protect operation to
 generic page-table API
Date: Tue, 18 Aug 2020 14:28:10 +0100
Message-Id: <20200818132818.16065-15-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200818132818.16065-1-will@kernel.org>
References: <20200818132818.16065-1-will@kernel.org>
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

Convert stage2_wp_range() to call the kvm_pgtable_stage2_wrprotect()
function of the generic page-table code instead of walking the page-table
directly.

Cc: Marc Zyngier <maz@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kvm/mmu.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 98815f6b8471..60f021430fcc 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -66,6 +66,9 @@ static bool is_iomap(unsigned long flags)
 	ret;								\
 })
 
+#define stage2_apply_range_resched(kvm, addr, end, fn)			\
+	stage2_apply_range(kvm, addr, end, fn, true)
+
 static bool memslot_is_logging(struct kvm_memory_slot *memslot)
 {
 	return memslot->dirty_bitmap && !(memslot->flags & KVM_MEM_READONLY);
@@ -1293,27 +1296,7 @@ static void  stage2_wp_p4ds(struct kvm_s2_mmu *mmu, pgd_t *pgd,
 static void stage2_wp_range(struct kvm_s2_mmu *mmu, phys_addr_t addr, phys_addr_t end)
 {
 	struct kvm *kvm = mmu->kvm;
-	pgd_t *pgd;
-	phys_addr_t next;
-
-	pgd = mmu->pgd + stage2_pgd_index(kvm, addr);
-	do {
-		/*
-		 * Release kvm_mmu_lock periodically if the memory region is
-		 * large. Otherwise, we may see kernel panics with
-		 * CONFIG_DETECT_HUNG_TASK, CONFIG_LOCKUP_DETECTOR,
-		 * CONFIG_LOCKDEP. Additionally, holding the lock too long
-		 * will also starve other vCPUs. We have to also make sure
-		 * that the page tables are not freed while we released
-		 * the lock.
-		 */
-		cond_resched_lock(&kvm->mmu_lock);
-		if (!READ_ONCE(mmu->pgd))
-			break;
-		next = stage2_pgd_addr_end(kvm, addr, end);
-		if (stage2_pgd_present(kvm, *pgd))
-			stage2_wp_p4ds(mmu, pgd, addr, next);
-	} while (pgd++, addr = next, addr != end);
+	stage2_apply_range_resched(kvm, addr, end, kvm_pgtable_stage2_wrprotect);
 }
 
 /**
-- 
2.28.0.220.ged08abb693-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
