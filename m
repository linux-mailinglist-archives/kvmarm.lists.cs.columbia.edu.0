Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id DBDB03F72D1
	for <lists+kvmarm@lfdr.de>; Wed, 25 Aug 2021 12:20:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 638504B284;
	Wed, 25 Aug 2021 06:20:10 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@chromium.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AbcTIoT44lQ7; Wed, 25 Aug 2021 06:20:10 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 517554B253;
	Wed, 25 Aug 2021 06:20:02 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 154DA4B279
 for <kvmarm@lists.cs.columbia.edu>; Tue, 24 Aug 2021 22:50:59 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dkKoqqFhUnyi for <kvmarm@lists.cs.columbia.edu>;
 Tue, 24 Aug 2021 22:50:55 -0400 (EDT)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D9AD54B28B
 for <kvmarm@lists.cs.columbia.edu>; Tue, 24 Aug 2021 22:50:54 -0400 (EDT)
Received: by mail-pf1-f171.google.com with SMTP id y190so20068978pfg.7
 for <kvmarm@lists.cs.columbia.edu>; Tue, 24 Aug 2021 19:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wHYXV8qtMvQ95TbNHaLJAvfpPFI8wMtjNpkCHSvZmMU=;
 b=FG0prys5/3LHU8NVk5eTCjMMAuPnRUW4O60GsiLY6MWNmD8FdNdIOovIKBBFV4iglU
 +WvnvZgVq7dYqSoMSN3cOOIF4pEthNbxqa411hvBecOd/aeGjtkFSChL27M4QGaev+7h
 AgwzERoWgUIRbBqg38Fo5QNFxF52dRtaMgz7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wHYXV8qtMvQ95TbNHaLJAvfpPFI8wMtjNpkCHSvZmMU=;
 b=nHscxmKmYdUM2xCBHVsUuHjiZvDBSYkhdvuQspTquzdmDO2Sh/YomcJ6/yhWRVhNDM
 9jnrCdYk55gvEvZXp/xAJmQeSIcA63gWAJ11nl5MknOWY6B1AFgF0N0Tp4i757DcUarH
 1VE0xmXID0ZVA4mEMOA6mQaDv2H3TmRtv/ZjVgUQAMklaVjhd2EXQkUq6sk00IKJtFPu
 V0fRKZarSz7DIjJ9jD77ioLrWKbKG5xjoiFFSJ+sojjNg62bugPN6JLRZg6uulAfVZbt
 UqmUFN2UxbRde03g/wDum6XHgZGvm5uJDGL+ro1TWkJmmAexA+fnlCY2u4NmsRsZ/frm
 E6aw==
X-Gm-Message-State: AOAM532e1amXNFSVVh1RQ64j1SUn2ngREyDIv9ZrJdZH1FFH76gOIm10
 2W32yGmSo8WVPH4nKcyoK+j2NBJbTGYYfw==
X-Google-Smtp-Source: ABdhPJzT2HgMzq0ToUHeWNfK2PULHqNolH9gzKGTSF89wiHNrhF0C5vs7gvNt4HN368FpJVW86y/6Q==
X-Received: by 2002:aa7:84c5:0:b0:3e1:16bb:6e22 with SMTP id
 x5-20020aa784c5000000b003e116bb6e22mr42631831pfn.32.1629859854084; 
 Tue, 24 Aug 2021 19:50:54 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:d273:c78c:fce8:a0e2])
 by smtp.gmail.com with UTF8SMTPSA id pc11sm3556412pjb.17.2021.08.24.19.50.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Aug 2021 19:50:53 -0700 (PDT)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: Marc Zyngier <maz@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 2/4] KVM: x86/mmu: use gfn_to_pfn_page
Date: Wed, 25 Aug 2021 11:50:07 +0900
Message-Id: <20210825025009.2081060-3-stevensd@google.com>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
In-Reply-To: <20210825025009.2081060-1-stevensd@google.com>
References: <20210825025009.2081060-1-stevensd@google.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 25 Aug 2021 06:20:00 -0400
Cc: Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
 Will Deacon <will@kernel.org>, Sean Christopherson <seanjc@google.com>,
 Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
 David Stevens <stevensd@chromium.org>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, Jim Mattson <jmattson@google.com>
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

Covert usages of the deprecated gfn_to_pfn functions to the new
gfn_to_pfn_page functions.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 arch/x86/kvm/mmu/mmu.c          | 43 ++++++++++++++++++++-------------
 arch/x86/kvm/mmu/mmu_internal.h |  3 ++-
 arch/x86/kvm/mmu/paging_tmpl.h  | 23 +++++++++++-------
 arch/x86/kvm/mmu/tdp_mmu.c      |  6 ++---
 arch/x86/kvm/mmu/tdp_mmu.h      |  4 +--
 arch/x86/kvm/x86.c              |  6 +++--
 6 files changed, 51 insertions(+), 34 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index c04e30f6e0db..d2b99c2f7dfa 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2789,8 +2789,9 @@ static int mmu_set_spte(struct kvm_vcpu *vcpu, u64 *sptep,
 	return ret;
 }
 
-static kvm_pfn_t pte_prefetch_gfn_to_pfn(struct kvm_vcpu *vcpu, gfn_t gfn,
-				     bool no_dirty_log)
+static kvm_pfn_t pte_prefetch_gfn_to_pfn_page(struct kvm_vcpu *vcpu,
+					      gfn_t gfn, bool no_dirty_log,
+					      struct page **page)
 {
 	struct kvm_memory_slot *slot;
 
@@ -2798,7 +2799,7 @@ static kvm_pfn_t pte_prefetch_gfn_to_pfn(struct kvm_vcpu *vcpu, gfn_t gfn,
 	if (!slot)
 		return KVM_PFN_ERR_FAULT;
 
-	return gfn_to_pfn_memslot_atomic(slot, gfn);
+	return gfn_to_pfn_page_memslot_atomic(slot, gfn, page);
 }
 
 static int direct_pte_prefetch_many(struct kvm_vcpu *vcpu,
@@ -2929,7 +2930,8 @@ int kvm_mmu_max_mapping_level(struct kvm *kvm,
 
 int kvm_mmu_hugepage_adjust(struct kvm_vcpu *vcpu, gfn_t gfn,
 			    int max_level, kvm_pfn_t *pfnp,
-			    bool huge_page_disallowed, int *req_level)
+			    struct page *page, bool huge_page_disallowed,
+			    int *req_level)
 {
 	struct kvm_memory_slot *slot;
 	kvm_pfn_t pfn = *pfnp;
@@ -2941,6 +2943,9 @@ int kvm_mmu_hugepage_adjust(struct kvm_vcpu *vcpu, gfn_t gfn,
 	if (unlikely(max_level == PG_LEVEL_4K))
 		return PG_LEVEL_4K;
 
+	if (!page)
+		return PG_LEVEL_4K;
+
 	if (is_error_noslot_pfn(pfn) || kvm_is_reserved_pfn(pfn))
 		return PG_LEVEL_4K;
 
@@ -2990,7 +2995,8 @@ void disallowed_hugepage_adjust(u64 spte, gfn_t gfn, int cur_level,
 }
 
 static int __direct_map(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
-			int map_writable, int max_level, kvm_pfn_t pfn,
+			int map_writable, int max_level,
+			kvm_pfn_t pfn, struct page *page,
 			bool prefault, bool is_tdp)
 {
 	bool nx_huge_page_workaround_enabled = is_nx_huge_page_enabled();
@@ -3003,7 +3009,7 @@ static int __direct_map(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 	gfn_t gfn = gpa >> PAGE_SHIFT;
 	gfn_t base_gfn = gfn;
 
-	level = kvm_mmu_hugepage_adjust(vcpu, gfn, max_level, &pfn,
+	level = kvm_mmu_hugepage_adjust(vcpu, gfn, max_level, &pfn, page,
 					huge_page_disallowed, &req_level);
 
 	trace_kvm_mmu_spte_requested(gpa, level, pfn);
@@ -3899,8 +3905,9 @@ static bool kvm_arch_setup_async_pf(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 }
 
 static bool kvm_faultin_pfn(struct kvm_vcpu *vcpu, bool prefault, gfn_t gfn,
-			 gpa_t cr2_or_gpa, kvm_pfn_t *pfn, hva_t *hva,
-			 bool write, bool *writable, int *r)
+			 gpa_t cr2_or_gpa, kvm_pfn_t *pfn,
+			 hva_t *hva, bool write, bool *writable,
+			 struct page **page, int *r)
 {
 	struct kvm_memory_slot *slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
 	bool async;
@@ -3934,8 +3941,8 @@ static bool kvm_faultin_pfn(struct kvm_vcpu *vcpu, bool prefault, gfn_t gfn,
 	}
 
 	async = false;
-	*pfn = __gfn_to_pfn_memslot(slot, gfn, false, &async,
-				    write, writable, hva);
+	*pfn = __gfn_to_pfn_page_memslot(slot, gfn, false, &async,
+					 write, writable, hva, page);
 	if (!async)
 		return false; /* *pfn has correct page already */
 
@@ -3949,8 +3956,8 @@ static bool kvm_faultin_pfn(struct kvm_vcpu *vcpu, bool prefault, gfn_t gfn,
 			goto out_retry;
 	}
 
-	*pfn = __gfn_to_pfn_memslot(slot, gfn, false, NULL,
-				    write, writable, hva);
+	*pfn = __gfn_to_pfn_page_memslot(slot, gfn, false, NULL,
+					 write, writable, hva, page);
 
 out_retry:
 	*r = RET_PF_RETRY;
@@ -3967,6 +3974,7 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 	gfn_t gfn = gpa >> PAGE_SHIFT;
 	unsigned long mmu_seq;
 	kvm_pfn_t pfn;
+	struct page *page;
 	hva_t hva;
 	int r;
 
@@ -3985,7 +3993,7 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 	smp_rmb();
 
 	if (kvm_faultin_pfn(vcpu, prefault, gfn, gpa, &pfn, &hva,
-			 write, &map_writable, &r))
+			 write, &map_writable, &page, &r))
 		return r;
 
 	if (handle_abnormal_pfn(vcpu, is_tdp ? 0 : gpa, gfn, pfn, ACC_ALL, &r))
@@ -4006,17 +4014,18 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 
 	if (is_tdp_mmu_fault)
 		r = kvm_tdp_mmu_map(vcpu, gpa, error_code, map_writable, max_level,
-				    pfn, prefault);
+				    pfn, page, prefault);
 	else
-		r = __direct_map(vcpu, gpa, error_code, map_writable, max_level, pfn,
-				 prefault, is_tdp);
+		r = __direct_map(vcpu, gpa, error_code, map_writable, max_level,
+				 pfn, page, prefault, is_tdp);
 
 out_unlock:
 	if (is_tdp_mmu_fault)
 		read_unlock(&vcpu->kvm->mmu_lock);
 	else
 		write_unlock(&vcpu->kvm->mmu_lock);
-	kvm_release_pfn_clean(pfn);
+	if (page)
+		put_page(page);
 	return r;
 }
 
diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index 62bb8f758b3f..bd3cfeb6420f 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -163,7 +163,8 @@ int kvm_mmu_max_mapping_level(struct kvm *kvm,
 			      kvm_pfn_t pfn, int max_level);
 int kvm_mmu_hugepage_adjust(struct kvm_vcpu *vcpu, gfn_t gfn,
 			    int max_level, kvm_pfn_t *pfnp,
-			    bool huge_page_disallowed, int *req_level);
+			    struct page *page, bool huge_page_disallowed,
+			    int *req_level);
 void disallowed_hugepage_adjust(u64 spte, gfn_t gfn, int cur_level,
 				kvm_pfn_t *pfnp, int *goal_levelp);
 
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 7d03e9b7ccfa..4a61b96fcdef 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -564,6 +564,7 @@ FNAME(prefetch_gpte)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
 	unsigned pte_access;
 	gfn_t gfn;
 	kvm_pfn_t pfn;
+	struct page *page;
 
 	if (FNAME(prefetch_invalid_gpte)(vcpu, sp, spte, gpte))
 		return false;
@@ -573,8 +574,8 @@ FNAME(prefetch_gpte)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
 	gfn = gpte_to_gfn(gpte);
 	pte_access = sp->role.access & FNAME(gpte_access)(gpte);
 	FNAME(protect_clean_gpte)(vcpu->arch.mmu, &pte_access, gpte);
-	pfn = pte_prefetch_gfn_to_pfn(vcpu, gfn,
-			no_dirty_log && (pte_access & ACC_WRITE_MASK));
+	pfn = pte_prefetch_gfn_to_pfn_page(vcpu, gfn,
+			no_dirty_log && (pte_access & ACC_WRITE_MASK), &page);
 	if (is_error_pfn(pfn))
 		return false;
 
@@ -585,7 +586,8 @@ FNAME(prefetch_gpte)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
 	mmu_set_spte(vcpu, spte, pte_access, false, PG_LEVEL_4K, gfn, pfn,
 		     true, true);
 
-	kvm_release_pfn_clean(pfn);
+	if (page)
+		put_page(page);
 	return true;
 }
 
@@ -665,8 +667,8 @@ static void FNAME(pte_prefetch)(struct kvm_vcpu *vcpu, struct guest_walker *gw,
  */
 static int FNAME(fetch)(struct kvm_vcpu *vcpu, gpa_t addr,
 			 struct guest_walker *gw, u32 error_code,
-			 int max_level, kvm_pfn_t pfn, bool map_writable,
-			 bool prefault)
+			 int max_level, kvm_pfn_t pfn, struct page *page,
+			 bool map_writable, bool prefault)
 {
 	bool nx_huge_page_workaround_enabled = is_nx_huge_page_enabled();
 	bool write_fault = error_code & PFERR_WRITE_MASK;
@@ -723,7 +725,8 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, gpa_t addr,
 	}
 
 	level = kvm_mmu_hugepage_adjust(vcpu, gw->gfn, max_level, &pfn,
-					huge_page_disallowed, &req_level);
+					page, huge_page_disallowed,
+					&req_level);
 
 	trace_kvm_mmu_spte_requested(addr, gw->level, pfn);
 
@@ -830,6 +833,7 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, gpa_t addr, u32 error_code,
 	struct guest_walker walker;
 	int r;
 	kvm_pfn_t pfn;
+	struct page *page;
 	hva_t hva;
 	unsigned long mmu_seq;
 	bool map_writable, is_self_change_mapping;
@@ -882,7 +886,7 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, gpa_t addr, u32 error_code,
 	smp_rmb();
 
 	if (kvm_faultin_pfn(vcpu, prefault, walker.gfn, addr, &pfn, &hva,
-			 write_fault, &map_writable, &r))
+			 write_fault, &map_writable, &page, &r))
 		return r;
 
 	if (handle_abnormal_pfn(vcpu, addr, walker.gfn, pfn, walker.pte_access, &r))
@@ -916,13 +920,14 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, gpa_t addr, u32 error_code,
 	r = make_mmu_pages_available(vcpu);
 	if (r)
 		goto out_unlock;
-	r = FNAME(fetch)(vcpu, addr, &walker, error_code, max_level, pfn,
+	r = FNAME(fetch)(vcpu, addr, &walker, error_code, max_level, pfn, page,
 			 map_writable, prefault);
 	kvm_mmu_audit(vcpu, AUDIT_POST_PAGE_FAULT);
 
 out_unlock:
 	write_unlock(&vcpu->kvm->mmu_lock);
-	kvm_release_pfn_clean(pfn);
+	if (page)
+		put_page(page);
 	return r;
 }
 
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 64ccfc1fa553..dec735081c5e 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -987,8 +987,8 @@ static int tdp_mmu_map_handle_target_level(struct kvm_vcpu *vcpu, int write,
  * page tables and SPTEs to translate the faulting guest physical address.
  */
 int kvm_tdp_mmu_map(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
-		    int map_writable, int max_level, kvm_pfn_t pfn,
-		    bool prefault)
+		    int map_writable, int max_level,
+		    kvm_pfn_t pfn, struct page *page, bool prefault)
 {
 	bool nx_huge_page_workaround_enabled = is_nx_huge_page_enabled();
 	bool write = error_code & PFERR_WRITE_MASK;
@@ -1004,7 +1004,7 @@ int kvm_tdp_mmu_map(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 	int level;
 	int req_level;
 
-	level = kvm_mmu_hugepage_adjust(vcpu, gfn, max_level, &pfn,
+	level = kvm_mmu_hugepage_adjust(vcpu, gfn, max_level, &pfn, page,
 					huge_page_disallowed, &req_level);
 
 	trace_kvm_mmu_spte_requested(gpa, level, pfn);
diff --git a/arch/x86/kvm/mmu/tdp_mmu.h b/arch/x86/kvm/mmu/tdp_mmu.h
index 358f447d4012..75526618601a 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.h
+++ b/arch/x86/kvm/mmu/tdp_mmu.h
@@ -49,8 +49,8 @@ void kvm_tdp_mmu_invalidate_all_roots(struct kvm *kvm);
 void kvm_tdp_mmu_zap_invalidated_roots(struct kvm *kvm);
 
 int kvm_tdp_mmu_map(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
-		    int map_writable, int max_level, kvm_pfn_t pfn,
-		    bool prefault);
+		    int map_writable, int max_level,
+		    kvm_pfn_t pfn, struct page *page, bool prefault);
 
 bool kvm_tdp_mmu_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range,
 				 bool flush);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 1a00af1b076b..9b32ce593f1b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7523,6 +7523,7 @@ static bool reexecute_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 {
 	gpa_t gpa = cr2_or_gpa;
 	kvm_pfn_t pfn;
+	struct page *page;
 
 	if (!(emulation_type & EMULTYPE_ALLOW_RETRY_PF))
 		return false;
@@ -7552,7 +7553,7 @@ static bool reexecute_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 	 * retry instruction -> write #PF -> emulation fail -> retry
 	 * instruction -> ...
 	 */
-	pfn = gfn_to_pfn(vcpu->kvm, gpa_to_gfn(gpa));
+	pfn = gfn_to_pfn_page(vcpu->kvm, gpa_to_gfn(gpa), &page);
 
 	/*
 	 * If the instruction failed on the error pfn, it can not be fixed,
@@ -7561,7 +7562,8 @@ static bool reexecute_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 	if (is_error_noslot_pfn(pfn))
 		return false;
 
-	kvm_release_pfn_clean(pfn);
+	if (page)
+		put_page(page);
 
 	/* The instructions are well-emulated on direct mmu. */
 	if (vcpu->arch.mmu->direct_map) {
-- 
2.33.0.rc2.250.ged5fa647cd-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
