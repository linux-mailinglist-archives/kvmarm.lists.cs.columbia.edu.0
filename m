Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 338C241BFAC
	for <lists+kvmarm@lfdr.de>; Wed, 29 Sep 2021 09:12:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BDFFC4B0FB;
	Wed, 29 Sep 2021 03:12:54 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@chromium.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KrwQsW6hoREX; Wed, 29 Sep 2021 03:12:53 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7FDB14B130;
	Wed, 29 Sep 2021 03:12:42 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7DAA34A98B
 for <kvmarm@lists.cs.columbia.edu>; Wed, 29 Sep 2021 00:29:39 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FtWDEjMiYoBN for <kvmarm@lists.cs.columbia.edu>;
 Wed, 29 Sep 2021 00:29:37 -0400 (EDT)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 3D0C64B08E
 for <kvmarm@lists.cs.columbia.edu>; Wed, 29 Sep 2021 00:29:37 -0400 (EDT)
Received: by mail-pl1-f179.google.com with SMTP id j14so645842plx.4
 for <kvmarm@lists.cs.columbia.edu>; Tue, 28 Sep 2021 21:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FPfib+o8cTRlN9zcbHp8IieaFglFHi7UAsMMtOaFluc=;
 b=oAICq1Sx2FGzCTho27zFDe/fWaRyqTDawpsVMjOB4VUgPJn3pyFU82ExdBwfqQGiAq
 z/vFfw/Bp16eJnRITM2Ppe39/TcEgVt8X702X2urmWL4rpWwPNAfpRknKEdYIH9R9w+9
 MH6mkkbaf3RB3IEkXgEXeM3eM4grG474dwyjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FPfib+o8cTRlN9zcbHp8IieaFglFHi7UAsMMtOaFluc=;
 b=D5KxKrAa6MNjEB73KGUhLFv17w8glI+2dOMkJg1MoUcYL60QmIbybQBOfLgpUII2pd
 haup5CBkeVhIq9F9Ls//YLpnBxBjak2GowNoS6XwrPTt/NMH0x6PaYT79sYbccjhKyUO
 7n2I3N3nx9ar4APDpqNpNgbYIhOvm1kbmrZJv9oMctbkMdNz9XCb+xUNFNDdXXgCMy/5
 I0t+SVUfrFQEx9HJjsPenJuXpxKor5zoTnXEcwuSAWXHjVK+jbxrkcfsuxF7RM5seXfz
 /+JciCkbaEwSJA1riXTEuRxbSEdnJQNLMZN+ZlbVtkkLzeeF4VcibO0nKqsqzLBtBiDt
 Ik7A==
X-Gm-Message-State: AOAM531aAPX0lY6kPCek1pxC4DUwgvhDIhezOfahEvc8dj/kzy4vSq0S
 yEf+4uhZ86SaDLCPlokpQdyoFg==
X-Google-Smtp-Source: ABdhPJy+yKHw9Ei8MdmvjtRZ5l15oM4qdbpAhK8DSj/TAxyH5E9C5a/epGxKC4Tck8LtDJ3vg+aOQA==
X-Received: by 2002:a17:90b:2358:: with SMTP id
 ms24mr2597779pjb.1.1632889776330; 
 Tue, 28 Sep 2021 21:29:36 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:f818:368:93ef:fa36])
 by smtp.gmail.com with UTF8SMTPSA id k3sm637994pfi.6.2021.09.28.21.29.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Sep 2021 21:29:36 -0700 (PDT)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: Marc Zyngier <maz@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 1/4] KVM: mmu: introduce new gfn_to_pfn_page functions
Date: Wed, 29 Sep 2021 13:29:05 +0900
Message-Id: <20210929042908.1313874-2-stevensd@google.com>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
In-Reply-To: <20210929042908.1313874-1-stevensd@google.com>
References: <20210929042908.1313874-1-stevensd@google.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 29 Sep 2021 03:12:40 -0400
Cc: Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
 Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 linux-kernel@vger.kernel.org, David Stevens <stevensd@chromium.org>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 Jim Mattson <jmattson@google.com>
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

From: David Stevens <stevensd@chromium.org>

Introduce new gfn_to_pfn_page functions that parallel existing
gfn_to_pfn functions. The new functions are identical except they take
an additional out parameter that is used to return the struct page if
the hva was resolved by gup. This allows callers to differentiate the
gup and follow_pte cases, which in turn allows callers to only touch the
page refcount when necessitated by gup.

The old gfn_to_pfn functions are depreciated, and all callers should be
migrated to the new gfn_to_pfn_page functions. In the interim, the
gfn_to_pfn functions are reimplemented as wrappers of the corresponding
gfn_to_pfn_page functions. The wrappers take a reference to the pfn's
page that had previously been taken in hva_to_pfn_remapped.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 include/linux/kvm_host.h |  17 ++++
 virt/kvm/kvm_main.c      | 196 +++++++++++++++++++++++++++++----------
 2 files changed, 162 insertions(+), 51 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 041ca7f15ea4..5ee43afa7e27 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -868,6 +868,19 @@ kvm_pfn_t __gfn_to_pfn_memslot(struct kvm_memory_slot *slot, gfn_t gfn,
 			       bool atomic, bool *async, bool write_fault,
 			       bool *writable, hva_t *hva);
 
+kvm_pfn_t gfn_to_pfn_page(struct kvm *kvm, gfn_t gfn, struct page **page);
+kvm_pfn_t gfn_to_pfn_page_prot(struct kvm *kvm, gfn_t gfn,
+			       bool write_fault, bool *writable,
+			       struct page **page);
+kvm_pfn_t gfn_to_pfn_page_memslot(struct kvm_memory_slot *slot,
+				  gfn_t gfn, struct page **page);
+kvm_pfn_t gfn_to_pfn_page_memslot_atomic(struct kvm_memory_slot *slot,
+					 gfn_t gfn, struct page **page);
+kvm_pfn_t __gfn_to_pfn_page_memslot(struct kvm_memory_slot *slot,
+				    gfn_t gfn, bool atomic, bool *async,
+				    bool write_fault, bool *writable,
+				    hva_t *hva, struct page **page);
+
 void kvm_release_pfn_clean(kvm_pfn_t pfn);
 void kvm_release_pfn_dirty(kvm_pfn_t pfn);
 void kvm_set_pfn_dirty(kvm_pfn_t pfn);
@@ -948,6 +961,10 @@ struct kvm_memslots *kvm_vcpu_memslots(struct kvm_vcpu *vcpu);
 struct kvm_memory_slot *kvm_vcpu_gfn_to_memslot(struct kvm_vcpu *vcpu, gfn_t gfn);
 kvm_pfn_t kvm_vcpu_gfn_to_pfn_atomic(struct kvm_vcpu *vcpu, gfn_t gfn);
 kvm_pfn_t kvm_vcpu_gfn_to_pfn(struct kvm_vcpu *vcpu, gfn_t gfn);
+kvm_pfn_t kvm_vcpu_gfn_to_pfn_page_atomic(struct kvm_vcpu *vcpu, gfn_t gfn,
+					  struct page **page);
+kvm_pfn_t kvm_vcpu_gfn_to_pfn_page(struct kvm_vcpu *vcpu, gfn_t gfn,
+				   struct page **page);
 int kvm_vcpu_map(struct kvm_vcpu *vcpu, gpa_t gpa, struct kvm_host_map *map);
 int kvm_map_gfn(struct kvm_vcpu *vcpu, gfn_t gfn, struct kvm_host_map *map,
 		struct gfn_to_pfn_cache *cache, bool atomic);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 439d3b4cd1a9..421146bd1360 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2204,9 +2204,9 @@ static inline int check_user_page_hwpoison(unsigned long addr)
  * only part that runs if we can in atomic context.
  */
 static bool hva_to_pfn_fast(unsigned long addr, bool write_fault,
-			    bool *writable, kvm_pfn_t *pfn)
+			    bool *writable, kvm_pfn_t *pfn,
+			    struct page **page)
 {
-	struct page *page[1];
 
 	/*
 	 * Fast pin a writable pfn only if it is a write fault request
@@ -2217,7 +2217,7 @@ static bool hva_to_pfn_fast(unsigned long addr, bool write_fault,
 		return false;
 
 	if (get_user_page_fast_only(addr, FOLL_WRITE, page)) {
-		*pfn = page_to_pfn(page[0]);
+		*pfn = page_to_pfn(*page);
 
 		if (writable)
 			*writable = true;
@@ -2232,10 +2232,9 @@ static bool hva_to_pfn_fast(unsigned long addr, bool write_fault,
  * 1 indicates success, -errno is returned if error is detected.
  */
 static int hva_to_pfn_slow(unsigned long addr, bool *async, bool write_fault,
-			   bool *writable, kvm_pfn_t *pfn)
+			   bool *writable, kvm_pfn_t *pfn, struct page **page)
 {
 	unsigned int flags = FOLL_HWPOISON;
-	struct page *page;
 	int npages = 0;
 
 	might_sleep();
@@ -2248,7 +2247,7 @@ static int hva_to_pfn_slow(unsigned long addr, bool *async, bool write_fault,
 	if (async)
 		flags |= FOLL_NOWAIT;
 
-	npages = get_user_pages_unlocked(addr, 1, &page, flags);
+	npages = get_user_pages_unlocked(addr, 1, page, flags);
 	if (npages != 1)
 		return npages;
 
@@ -2258,11 +2257,11 @@ static int hva_to_pfn_slow(unsigned long addr, bool *async, bool write_fault,
 
 		if (get_user_page_fast_only(addr, FOLL_WRITE, &wpage)) {
 			*writable = true;
-			put_page(page);
-			page = wpage;
+			put_page(*page);
+			*page = wpage;
 		}
 	}
-	*pfn = page_to_pfn(page);
+	*pfn = page_to_pfn(*page);
 	return npages;
 }
 
@@ -2277,13 +2276,6 @@ static bool vma_is_valid(struct vm_area_struct *vma, bool write_fault)
 	return true;
 }
 
-static int kvm_try_get_pfn(kvm_pfn_t pfn)
-{
-	if (kvm_is_reserved_pfn(pfn))
-		return 1;
-	return get_page_unless_zero(pfn_to_page(pfn));
-}
-
 static int hva_to_pfn_remapped(struct vm_area_struct *vma,
 			       unsigned long addr, bool *async,
 			       bool write_fault, bool *writable,
@@ -2323,26 +2315,6 @@ static int hva_to_pfn_remapped(struct vm_area_struct *vma,
 		*writable = pte_write(*ptep);
 	pfn = pte_pfn(*ptep);
 
-	/*
-	 * Get a reference here because callers of *hva_to_pfn* and
-	 * *gfn_to_pfn* ultimately call kvm_release_pfn_clean on the
-	 * returned pfn.  This is only needed if the VMA has VM_MIXEDMAP
-	 * set, but the kvm_try_get_pfn/kvm_release_pfn_clean pair will
-	 * simply do nothing for reserved pfns.
-	 *
-	 * Whoever called remap_pfn_range is also going to call e.g.
-	 * unmap_mapping_range before the underlying pages are freed,
-	 * causing a call to our MMU notifier.
-	 *
-	 * Certain IO or PFNMAP mappings can be backed with valid
-	 * struct pages, but be allocated without refcounting e.g.,
-	 * tail pages of non-compound higher order allocations, which
-	 * would then underflow the refcount when the caller does the
-	 * required put_page. Don't allow those pages here.
-	 */ 
-	if (!kvm_try_get_pfn(pfn))
-		r = -EFAULT;
-
 out:
 	pte_unmap_unlock(ptep, ptl);
 	*p_pfn = pfn;
@@ -2364,8 +2336,9 @@ static int hva_to_pfn_remapped(struct vm_area_struct *vma,
  * 2): @write_fault = false && @writable, @writable will tell the caller
  *     whether the mapping is writable.
  */
-static kvm_pfn_t hva_to_pfn(unsigned long addr, bool atomic, bool *async,
-			bool write_fault, bool *writable)
+static kvm_pfn_t hva_to_pfn(unsigned long addr, bool atomic,
+			    bool *async, bool write_fault, bool *writable,
+			    struct page **page)
 {
 	struct vm_area_struct *vma;
 	kvm_pfn_t pfn = 0;
@@ -2374,13 +2347,14 @@ static kvm_pfn_t hva_to_pfn(unsigned long addr, bool atomic, bool *async,
 	/* we can do it either atomically or asynchronously, not both */
 	BUG_ON(atomic && async);
 
-	if (hva_to_pfn_fast(addr, write_fault, writable, &pfn))
+	if (hva_to_pfn_fast(addr, write_fault, writable, &pfn, page))
 		return pfn;
 
 	if (atomic)
 		return KVM_PFN_ERR_FAULT;
 
-	npages = hva_to_pfn_slow(addr, async, write_fault, writable, &pfn);
+	npages = hva_to_pfn_slow(addr, async, write_fault, writable,
+				 &pfn, page);
 	if (npages == 1)
 		return pfn;
 
@@ -2412,12 +2386,14 @@ static kvm_pfn_t hva_to_pfn(unsigned long addr, bool atomic, bool *async,
 	return pfn;
 }
 
-kvm_pfn_t __gfn_to_pfn_memslot(struct kvm_memory_slot *slot, gfn_t gfn,
-			       bool atomic, bool *async, bool write_fault,
-			       bool *writable, hva_t *hva)
+kvm_pfn_t __gfn_to_pfn_page_memslot(struct kvm_memory_slot *slot,
+				    gfn_t gfn, bool atomic, bool *async,
+				    bool write_fault, bool *writable,
+				    hva_t *hva, struct page **page)
 {
 	unsigned long addr = __gfn_to_hva_many(slot, gfn, NULL, write_fault);
 
+	*page = NULL;
 	if (hva)
 		*hva = addr;
 
@@ -2440,45 +2416,163 @@ kvm_pfn_t __gfn_to_pfn_memslot(struct kvm_memory_slot *slot, gfn_t gfn,
 	}
 
 	return hva_to_pfn(addr, atomic, async, write_fault,
-			  writable);
+			  writable, page);
+}
+EXPORT_SYMBOL_GPL(__gfn_to_pfn_page_memslot);
+
+kvm_pfn_t gfn_to_pfn_page_prot(struct kvm *kvm, gfn_t gfn, bool write_fault,
+			       bool *writable, struct page **page)
+{
+	return __gfn_to_pfn_page_memslot(gfn_to_memslot(kvm, gfn), gfn, false,
+					 NULL, write_fault, writable, NULL,
+					 page);
+}
+EXPORT_SYMBOL_GPL(gfn_to_pfn_page_prot);
+
+kvm_pfn_t gfn_to_pfn_page_memslot(struct kvm_memory_slot *slot, gfn_t gfn,
+				  struct page **page)
+{
+	return __gfn_to_pfn_page_memslot(slot, gfn, false, NULL, true,
+					 NULL, NULL, page);
+}
+EXPORT_SYMBOL_GPL(gfn_to_pfn_page_memslot);
+
+kvm_pfn_t gfn_to_pfn_page_memslot_atomic(struct kvm_memory_slot *slot,
+					 gfn_t gfn, struct page **page)
+{
+	return __gfn_to_pfn_page_memslot(slot, gfn, true, NULL, true, NULL,
+					 NULL, page);
+}
+EXPORT_SYMBOL_GPL(gfn_to_pfn_page_memslot_atomic);
+
+kvm_pfn_t kvm_vcpu_gfn_to_pfn_page_atomic(struct kvm_vcpu *vcpu, gfn_t gfn,
+					  struct page **page)
+{
+	return gfn_to_pfn_page_memslot_atomic(
+			kvm_vcpu_gfn_to_memslot(vcpu, gfn), gfn, page);
+}
+EXPORT_SYMBOL_GPL(kvm_vcpu_gfn_to_pfn_page_atomic);
+
+kvm_pfn_t gfn_to_pfn_page(struct kvm *kvm, gfn_t gfn, struct page **page)
+{
+	return gfn_to_pfn_page_memslot(gfn_to_memslot(kvm, gfn), gfn, page);
+}
+EXPORT_SYMBOL_GPL(gfn_to_pfn_page);
+
+kvm_pfn_t kvm_vcpu_gfn_to_pfn_page(struct kvm_vcpu *vcpu, gfn_t gfn,
+				   struct page **page)
+{
+	return gfn_to_pfn_page_memslot(kvm_vcpu_gfn_to_memslot(vcpu, gfn),
+				       gfn, page);
+}
+EXPORT_SYMBOL_GPL(kvm_vcpu_gfn_to_pfn_page);
+
+static kvm_pfn_t ensure_pfn_ref(struct page *page, kvm_pfn_t pfn)
+{
+	if (page || is_error_pfn(pfn))
+		return pfn;
+
+	/*
+	 * If we're here, a pfn resolved by hva_to_pfn_remapped is
+	 * going to be returned to something that ultimately calls
+	 * kvm_release_pfn_clean, so the refcount needs to be bumped if
+	 * the pfn isn't a reserved pfn.
+	 *
+	 * Whoever called remap_pfn_range is also going to call e.g.
+	 * unmap_mapping_range before the underlying pages are freed,
+	 * causing a call to our MMU notifier.
+	 *
+	 * Certain IO or PFNMAP mappings can be backed with valid
+	 * struct pages, but be allocated without refcounting e.g.,
+	 * tail pages of non-compound higher order allocations, which
+	 * would then underflow the refcount when the caller does the
+	 * required put_page. Don't allow those pages here.
+	 */
+	if (kvm_is_reserved_pfn(pfn) ||
+	    get_page_unless_zero(pfn_to_page(pfn)))
+		return pfn;
+
+	return KVM_PFN_ERR_FAULT;
+}
+
+kvm_pfn_t __gfn_to_pfn_memslot(struct kvm_memory_slot *slot, gfn_t gfn,
+			       bool atomic, bool *async, bool write_fault,
+			       bool *writable, hva_t *hva)
+{
+	struct page *page;
+	kvm_pfn_t pfn;
+
+	pfn = __gfn_to_pfn_page_memslot(slot, gfn, atomic, async,
+					write_fault, writable, hva, &page);
+
+	return ensure_pfn_ref(page, pfn);
 }
 EXPORT_SYMBOL_GPL(__gfn_to_pfn_memslot);
 
 kvm_pfn_t gfn_to_pfn_prot(struct kvm *kvm, gfn_t gfn, bool write_fault,
 		      bool *writable)
 {
-	return __gfn_to_pfn_memslot(gfn_to_memslot(kvm, gfn), gfn, false, NULL,
-				    write_fault, writable, NULL);
+	struct page *page;
+	kvm_pfn_t pfn;
+
+	pfn = gfn_to_pfn_page_prot(kvm, gfn, write_fault, writable, &page);
+
+	return ensure_pfn_ref(page, pfn);
 }
 EXPORT_SYMBOL_GPL(gfn_to_pfn_prot);
 
 kvm_pfn_t gfn_to_pfn_memslot(struct kvm_memory_slot *slot, gfn_t gfn)
 {
-	return __gfn_to_pfn_memslot(slot, gfn, false, NULL, true, NULL, NULL);
+	struct page *page;
+	kvm_pfn_t pfn;
+
+	pfn = gfn_to_pfn_page_memslot(slot, gfn, &page);
+
+	return ensure_pfn_ref(page, pfn);
 }
 EXPORT_SYMBOL_GPL(gfn_to_pfn_memslot);
 
 kvm_pfn_t gfn_to_pfn_memslot_atomic(struct kvm_memory_slot *slot, gfn_t gfn)
 {
-	return __gfn_to_pfn_memslot(slot, gfn, true, NULL, true, NULL, NULL);
+	struct page *page;
+	kvm_pfn_t pfn;
+
+	pfn = gfn_to_pfn_page_memslot_atomic(slot, gfn, &page);
+
+	return ensure_pfn_ref(page, pfn);
 }
 EXPORT_SYMBOL_GPL(gfn_to_pfn_memslot_atomic);
 
 kvm_pfn_t kvm_vcpu_gfn_to_pfn_atomic(struct kvm_vcpu *vcpu, gfn_t gfn)
 {
-	return gfn_to_pfn_memslot_atomic(kvm_vcpu_gfn_to_memslot(vcpu, gfn), gfn);
+	struct page *page;
+	kvm_pfn_t pfn;
+
+	pfn = kvm_vcpu_gfn_to_pfn_page_atomic(vcpu, gfn, &page);
+
+	return ensure_pfn_ref(page, pfn);
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_gfn_to_pfn_atomic);
 
 kvm_pfn_t gfn_to_pfn(struct kvm *kvm, gfn_t gfn)
 {
-	return gfn_to_pfn_memslot(gfn_to_memslot(kvm, gfn), gfn);
+	struct page *page;
+	kvm_pfn_t pfn;
+
+	pfn = gfn_to_pfn_page(kvm, gfn, &page);
+
+	return ensure_pfn_ref(page, pfn);
 }
 EXPORT_SYMBOL_GPL(gfn_to_pfn);
 
 kvm_pfn_t kvm_vcpu_gfn_to_pfn(struct kvm_vcpu *vcpu, gfn_t gfn)
 {
-	return gfn_to_pfn_memslot(kvm_vcpu_gfn_to_memslot(vcpu, gfn), gfn);
+	struct page *page;
+	kvm_pfn_t pfn;
+
+	pfn = kvm_vcpu_gfn_to_pfn_page(vcpu, gfn, &page);
+
+	return ensure_pfn_ref(page, pfn);
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_gfn_to_pfn);
 
-- 
2.33.0.685.g46640cef36-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
