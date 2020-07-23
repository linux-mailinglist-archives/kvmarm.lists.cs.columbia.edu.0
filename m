Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5BE22AD25
	for <lists+kvmarm@lfdr.de>; Thu, 23 Jul 2020 13:02:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D0A5F4B336;
	Thu, 23 Jul 2020 07:02:53 -0400 (EDT)
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
	with ESMTP id 7cuSAKAcbQk9; Thu, 23 Jul 2020 07:02:53 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 927564B327;
	Thu, 23 Jul 2020 07:02:52 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id F2B1B4B2E6
 for <kvmarm@lists.cs.columbia.edu>; Thu, 23 Jul 2020 07:02:50 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2F7h5RBjXKgh for <kvmarm@lists.cs.columbia.edu>;
 Thu, 23 Jul 2020 07:02:49 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 510194B32B
 for <kvmarm@lists.cs.columbia.edu>; Thu, 23 Jul 2020 07:02:49 -0400 (EDT)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4037A22B47;
 Thu, 23 Jul 2020 11:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595502168;
 bh=jqcKXwCs4+bR/ZYDvVpNPCJYc6OYESncYiMpQXpiKFE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XpRtxF1xXLnHmsMrKGyN6zPTKY6sVY5CaP52ZjivB9Sq2RX4b2pXEbHFjwE40W1FM
 O4dPHFz98Rd0vjiwJUxEjDLKsJasg4yyicc3NKfm3cGJpdVeRlIVvSH+xNWiieAg2p
 JBymImnBGE0uaqLijYIz3+6o1PRvN+uizR4he7d4=
From: Will Deacon <will@kernel.org>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH 2/3] KVM: arm64: Simplify mmu_topup_memory_cache()
Date: Thu, 23 Jul 2020 12:02:26 +0100
Message-Id: <20200723110227.16001-3-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200723110227.16001-1-will@kernel.org>
References: <20200723110227.16001-1-will@kernel.org>
MIME-Version: 1.0
Cc: Will Deacon <will@kernel.org>, maz@kernel.org, kernel-team@android.com,
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

All callers of mmu_topup_memory_cache() pass the same min/max limits.
Simplify the code by just passing the 'struct kvm' instead.

Cc: Marc Zyngier <maz@kernel.org>
Cc: Quentin Perret <qperret@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kvm/mmu.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 9102373a9744..e55a28178164 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -124,20 +124,22 @@ static void stage2_dissolve_pud(struct kvm *kvm, phys_addr_t addr, pud_t *pudp)
 	put_page(virt_to_page(pudp));
 }
 
-static int mmu_topup_memory_cache(struct kvm_mmu_memory_cache *cache,
-				  int min, int max)
+static int mmu_topup_memory_cache(struct kvm *kvm,
+				  struct kvm_mmu_memory_cache *cache)
 {
 	void *page;
 
-	BUG_ON(max > KVM_NR_MEM_OBJS);
-	if (cache->nobjs >= min)
+	if (cache->nobjs >= kvm_mmu_cache_min_pages(kvm))
 		return 0;
-	while (cache->nobjs < max) {
+
+	while (cache->nobjs < KVM_NR_MEM_OBJS) {
 		page = (void *)__get_free_page(GFP_PGTABLE_USER);
 		if (!page)
 			return -ENOMEM;
+
 		cache->objects[cache->nobjs++] = page;
 	}
+
 	return 0;
 }
 
@@ -1480,9 +1482,7 @@ int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
 		if (writable)
 			pte = kvm_s2pte_mkwrite(pte);
 
-		ret = mmu_topup_memory_cache(&cache,
-					     kvm_mmu_cache_min_pages(kvm),
-					     KVM_NR_MEM_OBJS);
+		ret = mmu_topup_memory_cache(kvm, &cache);
 		if (ret)
 			break;
 		spin_lock(&kvm->mmu_lock);
@@ -1880,8 +1880,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	mmap_read_unlock(current->mm);
 
 	/* We need minimum second+third level pages */
-	ret = mmu_topup_memory_cache(memcache, kvm_mmu_cache_min_pages(kvm),
-				     KVM_NR_MEM_OBJS);
+	ret = mmu_topup_memory_cache(kvm, memcache);
 	if (ret)
 		return ret;
 
-- 
2.28.0.rc0.105.gf9edc3c819-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
