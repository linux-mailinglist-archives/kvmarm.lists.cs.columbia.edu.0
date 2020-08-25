Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A1DC9251599
	for <lists+kvmarm@lfdr.de>; Tue, 25 Aug 2020 11:40:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 56CCF4BF4C;
	Tue, 25 Aug 2020 05:40:25 -0400 (EDT)
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
	with ESMTP id 2T9xVNpjBknj; Tue, 25 Aug 2020 05:40:24 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CC8034C06F;
	Tue, 25 Aug 2020 05:40:22 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CD34F4C079
 for <kvmarm@lists.cs.columbia.edu>; Tue, 25 Aug 2020 05:40:21 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 056rA6ZgZOl6 for <kvmarm@lists.cs.columbia.edu>;
 Tue, 25 Aug 2020 05:40:20 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id BC8494BE5E
 for <kvmarm@lists.cs.columbia.edu>; Tue, 25 Aug 2020 05:40:20 -0400 (EDT)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3684C2075F;
 Tue, 25 Aug 2020 09:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598348420;
 bh=PeyeUe4T2H+gI5n9wpk+/S+S1DJpqCy+aRJ/QMAkOrs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hfdsE2VckxWI9sDteREroqObnAkXk9WFLPfKqy3mQXaFOk8oLBpi7AlV9ScP5jECd
 JUqEV/Q3OVPD8otFqn/r7AdVezlzFkyLUSAS4nlCymuHbNDQ2UfsqQHISSoaC8SdPD
 znmvZ0BZZGe8N74tbFIda7lQ/Nwubk4ee/DrYtJc=
From: Will Deacon <will@kernel.org>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v3 08/21] KVM: arm64: Convert kvm_set_spte_hva() to generic
 page-table API
Date: Tue, 25 Aug 2020 10:39:40 +0100
Message-Id: <20200825093953.26493-9-will@kernel.org>
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

Convert kvm_set_spte_hva() to use kvm_pgtable_stage2_map() instead
of stage2_set_pte().

Cc: Marc Zyngier <maz@kernel.org>
Cc: Quentin Perret <qperret@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kvm/mmu.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 33146d3dc93a..704b471a48ce 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1911,28 +1911,27 @@ int kvm_unmap_hva_range(struct kvm *kvm,
 
 static int kvm_set_spte_handler(struct kvm *kvm, gpa_t gpa, u64 size, void *data)
 {
-	pte_t *pte = (pte_t *)data;
+	kvm_pfn_t *pfn = (kvm_pfn_t *)data;
 
 	WARN_ON(size != PAGE_SIZE);
+
 	/*
-	 * We can always call stage2_set_pte with KVM_S2PTE_FLAG_LOGGING_ACTIVE
-	 * flag clear because MMU notifiers will have unmapped a huge PMD before
-	 * calling ->change_pte() (which in turn calls kvm_set_spte_hva()) and
-	 * therefore stage2_set_pte() never needs to clear out a huge PMD
-	 * through this calling path.
+	 * The MMU notifiers will have unmapped a huge PMD before calling
+	 * ->change_pte() (which in turn calls kvm_set_spte_hva()) and
+	 * therefore we never need to clear out a huge PMD through this
+	 * calling path and a memcache is not required.
 	 */
-	stage2_set_pte(&kvm->arch.mmu, NULL, gpa, pte, 0);
+	kvm_pgtable_stage2_map(kvm->arch.mmu.pgt, gpa, PAGE_SIZE,
+			       __pfn_to_phys(*pfn), KVM_PGTABLE_PROT_R, NULL);
 	return 0;
 }
 
-
 int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte)
 {
 	unsigned long end = hva + PAGE_SIZE;
 	kvm_pfn_t pfn = pte_pfn(pte);
-	pte_t stage2_pte;
 
-	if (!kvm->arch.mmu.pgd)
+	if (!kvm->arch.mmu.pgt)
 		return 0;
 
 	trace_kvm_set_spte_hva(hva);
@@ -1942,9 +1941,7 @@ int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte)
 	 * just like a translation fault and clean the cache to the PoC.
 	 */
 	clean_dcache_guest_page(pfn, PAGE_SIZE);
-	stage2_pte = kvm_pfn_pte(pfn, PAGE_S2);
-	handle_hva_to_gpa(kvm, hva, end, &kvm_set_spte_handler, &stage2_pte);
-
+	handle_hva_to_gpa(kvm, hva, end, &kvm_set_spte_handler, &pfn);
 	return 0;
 }
 
-- 
2.28.0.297.g1956fa8f8d-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
