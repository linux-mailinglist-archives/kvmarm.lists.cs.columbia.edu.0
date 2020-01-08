Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 19E78134D52
	for <lists+kvmarm@lfdr.de>; Wed,  8 Jan 2020 21:27:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8F1514B138;
	Wed,  8 Jan 2020 15:27:21 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ak8BzmGQq9+h; Wed,  8 Jan 2020 15:27:20 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1B9284B145;
	Wed,  8 Jan 2020 15:27:12 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A59014B13C
 for <kvmarm@lists.cs.columbia.edu>; Wed,  8 Jan 2020 15:27:09 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o+SeWjhgJbcQ for <kvmarm@lists.cs.columbia.edu>;
 Wed,  8 Jan 2020 15:27:08 -0500 (EST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 0AA9C4B118
 for <kvmarm@lists.cs.columbia.edu>; Wed,  8 Jan 2020 15:27:07 -0500 (EST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 08 Jan 2020 12:27:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,411,1571727600"; d="scan'208";a="211658383"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
 by orsmga007.jf.intel.com with ESMTP; 08 Jan 2020 12:27:06 -0800
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 09/14] KVM: x86/mmu: Rely on host page tables to find HugeTLB
 mappings
Date: Wed,  8 Jan 2020 12:24:43 -0800
Message-Id: <20200108202448.9669-10-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200108202448.9669-1-sean.j.christopherson@intel.com>
References: <20200108202448.9669-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Cc: Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Paul Mackerras <paulus@ozlabs.org>,
 linux-mm@kvack.org, kvmarm@lists.cs.columbia.edu,
 Dave Jiang <dave.jiang@intel.com>, linux-nvdimm <linux-nvdimm@lists.01.org>,
 Marc Zyngier <maz@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 syzbot+c9d1fb51ac9d0d10c39d@syzkaller.appspotmail.com,
 Barret Rhoden <brho@google.com>, kvm-ppc@vger.kernel.org,
 Liran Alon <liran.alon@oracle.com>, Andy Lutomirski <luto@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, Jim Mattson <jmattson@google.com>,
 linux-kernel@vger.kernel.org,
 Sean Christopherson <sean.j.christopherson@intel.com>,
 Jason Zeng <jason.zeng@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
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

Remove KVM's HugeTLB specific logic and instead rely on walking the host
page tables (already done for THP) to identify HugeTLB mappings.
Eliminating the HugeTLB-only logic avoids taking mmap_sem and calling
find_vma() for all hugepage compatible page faults, and simplifies KVM's
page fault code by consolidating all hugepage adjustments into a common
helper.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/mmu/mmu.c         | 84 ++++++++++------------------------
 arch/x86/kvm/mmu/paging_tmpl.h | 15 +++---
 2 files changed, 29 insertions(+), 70 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 7d78d1d996ed..68aec984f953 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1286,23 +1286,6 @@ static bool mmu_gfn_lpage_is_disallowed(struct kvm_vcpu *vcpu, gfn_t gfn,
 	return __mmu_gfn_lpage_is_disallowed(gfn, level, slot);
 }
 
-static int host_mapping_level(struct kvm_vcpu *vcpu, gfn_t gfn)
-{
-	unsigned long page_size;
-	int i, ret = 0;
-
-	page_size = kvm_host_page_size(vcpu, gfn);
-
-	for (i = PT_PAGE_TABLE_LEVEL; i <= PT_MAX_HUGEPAGE_LEVEL; ++i) {
-		if (page_size >= KVM_HPAGE_SIZE(i))
-			ret = i;
-		else
-			break;
-	}
-
-	return ret;
-}
-
 static inline bool memslot_valid_for_gpte(struct kvm_memory_slot *slot,
 					  bool no_dirty_log)
 {
@@ -1327,43 +1310,25 @@ gfn_to_memslot_dirty_bitmap(struct kvm_vcpu *vcpu, gfn_t gfn,
 	return slot;
 }
 
-static int mapping_level(struct kvm_vcpu *vcpu, gfn_t large_gfn,
-			 int *max_levelp)
+static int max_mapping_level(struct kvm_vcpu *vcpu, gfn_t gfn,
+			     int max_level)
 {
-	int host_level, max_level = *max_levelp;
 	struct kvm_memory_slot *slot;
 
 	if (unlikely(max_level == PT_PAGE_TABLE_LEVEL))
 		return PT_PAGE_TABLE_LEVEL;
 
-	slot = kvm_vcpu_gfn_to_memslot(vcpu, large_gfn);
-	if (!memslot_valid_for_gpte(slot, true)) {
-		*max_levelp = PT_PAGE_TABLE_LEVEL;
+	slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
+	if (!memslot_valid_for_gpte(slot, true))
 		return PT_PAGE_TABLE_LEVEL;
-	}
 
 	max_level = min(max_level, kvm_x86_ops->get_lpage_level());
 	for ( ; max_level > PT_PAGE_TABLE_LEVEL; max_level--) {
-		if (!__mmu_gfn_lpage_is_disallowed(large_gfn, max_level, slot))
+		if (!__mmu_gfn_lpage_is_disallowed(gfn, max_level, slot))
 			break;
 	}
 
-	*max_levelp = max_level;
-
-	if (max_level == PT_PAGE_TABLE_LEVEL)
-		return PT_PAGE_TABLE_LEVEL;
-
-	/*
-	 * Note, host_mapping_level() does *not* handle transparent huge pages.
-	 * As suggested by "mapping", it reflects the page size established by
-	 * the associated vma, if there is one, i.e. host_mapping_level() will
-	 * return a huge page level if and only if a vma exists and the backing
-	 * implementation for the vma uses huge pages, e.g. hugetlbfs and dax.
-	 * So, do not propagate host_mapping_level() to max_level as KVM can
-	 * still promote the guest mapping to a huge page in the THP case.
-	 */
-	host_level = host_mapping_level(vcpu, large_gfn);
-	return min(host_level, max_level);
+	return max_level;
 }
 
 /*
@@ -3137,7 +3102,7 @@ static int set_spte(struct kvm_vcpu *vcpu, u64 *sptep,
 
 		/*
 		 * Other vcpu creates new sp in the window between
-		 * mapping_level() and acquiring mmu-lock. We can
+		 * max_mapping_level() and acquiring mmu-lock. We can
 		 * allow guest to retry the access, the mapping can
 		 * be fixed if guest refault.
 		 */
@@ -3364,24 +3329,23 @@ static int host_pfn_mapping_level(struct kvm_vcpu *vcpu, gfn_t gfn,
 	return level;
 }
 
-static void transparent_hugepage_adjust(struct kvm_vcpu *vcpu, gfn_t gfn,
-					int max_level, kvm_pfn_t *pfnp,
-					int *levelp)
+static int kvm_mmu_hugepage_adjust(struct kvm_vcpu *vcpu, gfn_t gfn,
+				   int max_level, kvm_pfn_t *pfnp)
 {
 	kvm_pfn_t pfn = *pfnp;
-	int level = *levelp;
 	kvm_pfn_t mask;
+	int level;
 
-	if (max_level == PT_PAGE_TABLE_LEVEL || level > PT_PAGE_TABLE_LEVEL)
-		return;
+	if (max_level == PT_PAGE_TABLE_LEVEL)
+		return PT_PAGE_TABLE_LEVEL;
 
 	if (is_error_noslot_pfn(pfn) || kvm_is_reserved_pfn(pfn) ||
 	    kvm_is_zone_device_pfn(pfn))
-		return;
+		return PT_PAGE_TABLE_LEVEL;
 
 	level = host_pfn_mapping_level(vcpu, gfn, pfn);
 	if (level == PT_PAGE_TABLE_LEVEL)
-		return;
+		return level;
 
 	level = min(level, max_level);
 
@@ -3389,10 +3353,11 @@ static void transparent_hugepage_adjust(struct kvm_vcpu *vcpu, gfn_t gfn,
 	 * mmu_notifier_retry() was successful and mmu_lock is held, so
 	 * the pmd can't be split from under us.
 	 */
-	*levelp = level;
 	mask = KVM_PAGES_PER_HPAGE(level) - 1;
 	VM_BUG_ON((gfn & mask) != (pfn & mask));
 	*pfnp = pfn & ~mask;
+
+	return level;
 }
 
 static void disallowed_hugepage_adjust(struct kvm_shadow_walk_iterator it,
@@ -3419,20 +3384,19 @@ static void disallowed_hugepage_adjust(struct kvm_shadow_walk_iterator it,
 }
 
 static int __direct_map(struct kvm_vcpu *vcpu, gpa_t gpa, int write,
-			int map_writable, int level, int max_level,
-			kvm_pfn_t pfn, bool prefault,
-			bool account_disallowed_nx_lpage)
+			int map_writable, int max_level, kvm_pfn_t pfn,
+			bool prefault, bool account_disallowed_nx_lpage)
 {
 	struct kvm_shadow_walk_iterator it;
 	struct kvm_mmu_page *sp;
-	int ret;
+	int level, ret;
 	gfn_t gfn = gpa >> PAGE_SHIFT;
 	gfn_t base_gfn = gfn;
 
 	if (WARN_ON(!VALID_PAGE(vcpu->arch.mmu->root_hpa)))
 		return RET_PF_RETRY;
 
-	transparent_hugepage_adjust(vcpu, gfn, max_level, &pfn, &level);
+	level = kvm_mmu_hugepage_adjust(vcpu, gfn, max_level, &pfn);
 
 	trace_kvm_mmu_spte_requested(gpa, level, pfn);
 	for_each_shadow_entry(vcpu, gpa, it) {
@@ -4206,7 +4170,7 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 	gfn_t gfn = gpa >> PAGE_SHIFT;
 	unsigned long mmu_seq;
 	kvm_pfn_t pfn;
-	int level, r;
+	int r;
 
 	if (page_fault_handle_page_track(vcpu, error_code, gfn))
 		return RET_PF_EMULATE;
@@ -4218,9 +4182,7 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 	if (lpage_disallowed)
 		max_level = PT_PAGE_TABLE_LEVEL;
 
-	level = mapping_level(vcpu, gfn, &max_level);
-	if (level > PT_PAGE_TABLE_LEVEL)
-		gfn &= ~(KVM_PAGES_PER_HPAGE(level) - 1);
+	max_level = max_mapping_level(vcpu, gfn, max_level);
 
 	if (fast_page_fault(vcpu, gpa, error_code))
 		return RET_PF_RETRY;
@@ -4240,7 +4202,7 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 		goto out_unlock;
 	if (make_mmu_pages_available(vcpu) < 0)
 		goto out_unlock;
-	r = __direct_map(vcpu, gpa, write, map_writable, level, max_level, pfn,
+	r = __direct_map(vcpu, gpa, write, map_writable, max_level, pfn,
 			 prefault, is_tdp && lpage_disallowed);
 
 out_unlock:
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 0029f7870865..841506a55815 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -613,14 +613,14 @@ static void FNAME(pte_prefetch)(struct kvm_vcpu *vcpu, struct guest_walker *gw,
  */
 static int FNAME(fetch)(struct kvm_vcpu *vcpu, gpa_t addr,
 			 struct guest_walker *gw,
-			 int write_fault, int hlevel, int max_level,
+			 int write_fault, int max_level,
 			 kvm_pfn_t pfn, bool map_writable, bool prefault,
 			 bool lpage_disallowed)
 {
 	struct kvm_mmu_page *sp = NULL;
 	struct kvm_shadow_walk_iterator it;
 	unsigned direct_access, access = gw->pt_access;
-	int top_level, ret;
+	int top_level, hlevel, ret;
 	gfn_t gfn, base_gfn;
 
 	direct_access = gw->pte_access;
@@ -673,7 +673,7 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, gpa_t addr,
 	gfn = gw->gfn | ((addr & PT_LVL_OFFSET_MASK(gw->level)) >> PAGE_SHIFT);
 	base_gfn = gfn;
 
-	transparent_hugepage_adjust(vcpu, gw->gfn, max_level, &pfn, &hlevel);
+	hlevel = kvm_mmu_hugepage_adjust(vcpu, gw->gfn, max_level, &pfn);
 
 	trace_kvm_mmu_spte_requested(addr, gw->level, pfn);
 
@@ -775,7 +775,6 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, gpa_t addr, u32 error_code,
 	struct guest_walker walker;
 	int r;
 	kvm_pfn_t pfn;
-	int level;
 	unsigned long mmu_seq;
 	bool map_writable, is_self_change_mapping;
 	bool lpage_disallowed = (error_code & PFERR_FETCH_MASK) &&
@@ -825,9 +824,7 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, gpa_t addr, u32 error_code,
 	else
 		max_level = walker.level;
 
-	level = mapping_level(vcpu, walker.gfn, &max_level);
-	if (level > PT_PAGE_TABLE_LEVEL)
-		walker.gfn = walker.gfn & ~(KVM_PAGES_PER_HPAGE(level) - 1);
+	max_level = max_mapping_level(vcpu, walker.gfn, max_level);
 
 	mmu_seq = vcpu->kvm->mmu_notifier_seq;
 	smp_rmb();
@@ -867,8 +864,8 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, gpa_t addr, u32 error_code,
 	kvm_mmu_audit(vcpu, AUDIT_PRE_PAGE_FAULT);
 	if (make_mmu_pages_available(vcpu) < 0)
 		goto out_unlock;
-	r = FNAME(fetch)(vcpu, addr, &walker, write_fault, level, max_level,
-			 pfn, map_writable, prefault, lpage_disallowed);
+	r = FNAME(fetch)(vcpu, addr, &walker, write_fault, max_level, pfn,
+			 map_writable, prefault, lpage_disallowed);
 	kvm_mmu_audit(vcpu, AUDIT_POST_PAGE_FAULT);
 
 out_unlock:
-- 
2.24.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
