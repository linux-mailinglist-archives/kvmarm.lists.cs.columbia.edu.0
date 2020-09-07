Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 44ECF25FCF0
	for <lists+kvmarm@lfdr.de>; Mon,  7 Sep 2020 17:24:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id ED4674B531;
	Mon,  7 Sep 2020 11:24:33 -0400 (EDT)
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
	with ESMTP id ajLDuH7-32aB; Mon,  7 Sep 2020 11:24:33 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1E3C04B52A;
	Mon,  7 Sep 2020 11:24:32 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EA6D54B51F
 for <kvmarm@lists.cs.columbia.edu>; Mon,  7 Sep 2020 11:24:30 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BAayYWxP-EQO for <kvmarm@lists.cs.columbia.edu>;
 Mon,  7 Sep 2020 11:24:30 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 3EEF24B43E
 for <kvmarm@lists.cs.columbia.edu>; Mon,  7 Sep 2020 11:24:29 -0400 (EDT)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A2159215A4;
 Mon,  7 Sep 2020 15:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599492268;
 bh=CmBdzWi8VQDy2OO/dofl9mGtDeXQKuhvmZjlsB43lXQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=xIKXTMSDL9OdrSJIhht2bywRtKzkn/kdgl2eP1jBc/xjHm4AogwsOsx0NA/Ppsmhc
 X/hkpaxOYC2AiXuzOWrPR/y1hry6XB/VuYymUWQKjyR2iIEG5UNyDKUaXrUyoivtRa
 nstybgAh1kHeAPPNvvJ2aPDlFAxLkFa/uasi2qTE=
From: Will Deacon <will@kernel.org>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v4 15/21] KVM: arm64: Convert memslot cache-flushing code to
 generic page-table API
Date: Mon,  7 Sep 2020 16:23:38 +0100
Message-Id: <20200907152344.12978-16-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200907152344.12978-1-will@kernel.org>
References: <20200907152344.12978-1-will@kernel.org>
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
index bbcd632fc5b1..0af48f35c8dd 100644
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
2.28.0.526.ge36021eeef-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
