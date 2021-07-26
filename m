Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C19233D5D25
	for <lists+kvmarm@lfdr.de>; Mon, 26 Jul 2021 17:36:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7128A4AEDC;
	Mon, 26 Jul 2021 11:36:08 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xVF5qVTzrZeC; Mon, 26 Jul 2021 11:36:07 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 63B814B086;
	Mon, 26 Jul 2021 11:36:03 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7ACAF40569
 for <kvmarm@lists.cs.columbia.edu>; Mon, 26 Jul 2021 11:36:01 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T73tbaSURK99 for <kvmarm@lists.cs.columbia.edu>;
 Mon, 26 Jul 2021 11:36:00 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 4CA634A1FA
 for <kvmarm@lists.cs.columbia.edu>; Mon, 26 Jul 2021 11:36:00 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8539660F38;
 Mon, 26 Jul 2021 15:35:58 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1m82e4-001511-TL; Mon, 26 Jul 2021 16:35:56 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, linux-mm@kvack.org
Subject: [PATCH v2 4/6] KVM: Remove kvm_is_transparent_hugepage() and
 PageTransCompoundMap()
Date: Mon, 26 Jul 2021 16:35:50 +0100
Message-Id: <20210726153552.1535838-5-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210726153552.1535838-1-maz@kernel.org>
References: <20210726153552.1535838-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, linux-mm@kvack.org, seanjc@google.com,
 willy@infradead.org, pbonzini@redhat.com, will@kernel.org, qperret@google.com,
 james.morse@arm.com, suzuki.poulose@arm.com, alexandru.elisei@arm.com,
 kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, Sean Christopherson <seanjc@google.com>,
 Matthew Wilcox <willy@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Will Deacon <will@kernel.org>
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

Now that arm64 has stopped using kvm_is_transparent_hugepage(),
we can remove it, as well as PageTransCompoundMap() which was
only used by the former.

Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/page-flags.h | 37 -------------------------------------
 virt/kvm/kvm_main.c        | 10 ----------
 2 files changed, 47 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 5922031ffab6..1ace27c4a8e0 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -632,43 +632,6 @@ static inline int PageTransCompound(struct page *page)
 	return PageCompound(page);
 }
 
-/*
- * PageTransCompoundMap is the same as PageTransCompound, but it also
- * guarantees the primary MMU has the entire compound page mapped
- * through pmd_trans_huge, which in turn guarantees the secondary MMUs
- * can also map the entire compound page. This allows the secondary
- * MMUs to call get_user_pages() only once for each compound page and
- * to immediately map the entire compound page with a single secondary
- * MMU fault. If there will be a pmd split later, the secondary MMUs
- * will get an update through the MMU notifier invalidation through
- * split_huge_pmd().
- *
- * Unlike PageTransCompound, this is safe to be called only while
- * split_huge_pmd() cannot run from under us, like if protected by the
- * MMU notifier, otherwise it may result in page->_mapcount check false
- * positives.
- *
- * We have to treat page cache THP differently since every subpage of it
- * would get _mapcount inc'ed once it is PMD mapped.  But, it may be PTE
- * mapped in the current process so comparing subpage's _mapcount to
- * compound_mapcount to filter out PTE mapped case.
- */
-static inline int PageTransCompoundMap(struct page *page)
-{
-	struct page *head;
-
-	if (!PageTransCompound(page))
-		return 0;
-
-	if (PageAnon(page))
-		return atomic_read(&page->_mapcount) < 0;
-
-	head = compound_head(page);
-	/* File THP is PMD mapped and not PTE mapped */
-	return atomic_read(&page->_mapcount) ==
-	       atomic_read(compound_mapcount_ptr(head));
-}
-
 /*
  * PageTransTail returns true for both transparent huge pages
  * and hugetlbfs pages, so it should only be called when it's known
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 986959833d70..956ef6ddce7f 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -189,16 +189,6 @@ bool kvm_is_reserved_pfn(kvm_pfn_t pfn)
 	return true;
 }
 
-bool kvm_is_transparent_hugepage(kvm_pfn_t pfn)
-{
-	struct page *page = pfn_to_page(pfn);
-
-	if (!PageTransCompoundMap(page))
-		return false;
-
-	return is_transparent_hugepage(compound_head(page));
-}
-
 /*
  * Switches to specified vcpu, until a matching vcpu_put()
  */
-- 
2.30.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
