Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BE7A22485FE
	for <lists+kvmarm@lfdr.de>; Tue, 18 Aug 2020 15:28:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 734C94BF33;
	Tue, 18 Aug 2020 09:28:52 -0400 (EDT)
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
	with ESMTP id VvVPj04kpIXq; Tue, 18 Aug 2020 09:28:51 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8AA7F4BBA9;
	Tue, 18 Aug 2020 09:28:51 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1DFC94BD62
 for <kvmarm@lists.cs.columbia.edu>; Tue, 18 Aug 2020 09:28:50 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n76FC1NhvYlr for <kvmarm@lists.cs.columbia.edu>;
 Tue, 18 Aug 2020 09:28:49 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 037784BDEE
 for <kvmarm@lists.cs.columbia.edu>; Tue, 18 Aug 2020 09:28:48 -0400 (EDT)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A8594207DE;
 Tue, 18 Aug 2020 13:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597757327;
 bh=m1/vN1yTG/89XJEkSTDm/o6eRTvWv7Br50IuyMKQmlI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lWsxAo1JnAF0nUcRpMSxIDg0kUV9OfUvQdb7mszU55GsWzobx1kfzwctoSEaLs8sD
 whVAmD7NAlgRezrPmyRKKWJErLcX8X1PKlJPlkfnPIl3znZKNXQ+wAVlsqFIAHw036
 wy9F6/jJLXiY8CgwnOloT6svVYjcU+Xg8Jr/+/Dk=
From: Will Deacon <will@kernel.org>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v2 09/22] KVM: arm64: Convert kvm_set_spte_hva() to generic
 page-table API
Date: Tue, 18 Aug 2020 14:28:05 +0100
Message-Id: <20200818132818.16065-10-will@kernel.org>
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

Convert kvm_set_spte_hva() to use kvm_pgtable_stage2_map() instead
of stage2_set_pte().

Cc: Marc Zyngier <maz@kernel.org>
Cc: Quentin Perret <qperret@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kvm/mmu.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index d0c440e2622d..eb1ba29fd4e7 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1910,28 +1910,27 @@ int kvm_unmap_hva_range(struct kvm *kvm,
 
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
@@ -1941,9 +1940,7 @@ int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte)
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
2.28.0.220.ged08abb693-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
