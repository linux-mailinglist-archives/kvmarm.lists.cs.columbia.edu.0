Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 00EC1134D3F
	for <lists+kvmarm@lfdr.de>; Wed,  8 Jan 2020 21:27:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A46A84B169;
	Wed,  8 Jan 2020 15:27:13 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 29hRxrg5zJBZ; Wed,  8 Jan 2020 15:27:12 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3AA654B13E;
	Wed,  8 Jan 2020 15:27:09 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D4D074B12B
 for <kvmarm@lists.cs.columbia.edu>; Wed,  8 Jan 2020 15:27:07 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YPuoA6-behND for <kvmarm@lists.cs.columbia.edu>;
 Wed,  8 Jan 2020 15:27:06 -0500 (EST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 87E744B127
 for <kvmarm@lists.cs.columbia.edu>; Wed,  8 Jan 2020 15:27:06 -0500 (EST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 08 Jan 2020 12:27:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,411,1571727600"; d="scan'208";a="211658359"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
 by orsmga007.jf.intel.com with ESMTP; 08 Jan 2020 12:27:05 -0800
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 02/14] mm: thp: KVM: Explicitly check for THP when populating
 secondary MMU
Date: Wed,  8 Jan 2020 12:24:36 -0800
Message-Id: <20200108202448.9669-3-sean.j.christopherson@intel.com>
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

Add a helper, is_transparent_hugepage(), to explicitly check whether a
compound page is a THP and use it when populating KVM's secondary MMU.
The explicit check fixes a bug where a remapped compound page, e.g. for
an XDP Rx socket, is mapped into a KVM guest and is mistaken for a THP,
which results in KVM incorrectly creating a huge page in its secondary
MMU.

Fixes: 936a5fe6e6148 ("thp: kvm mmu transparent hugepage support")
Reported-by: syzbot+c9d1fb51ac9d0d10c39d@syzkaller.appspotmail.com
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/mmu/mmu.c   |  4 ++--
 include/linux/huge_mm.h  |  6 ++++++
 include/linux/kvm_host.h |  1 +
 mm/huge_memory.c         | 11 +++++++++++
 virt/kvm/arm/mmu.c       |  8 +-------
 virt/kvm/kvm_main.c      | 10 ++++++++++
 6 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 8e822c09170d..ca14c84c4f4b 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3344,7 +3344,7 @@ static void transparent_hugepage_adjust(struct kvm_vcpu *vcpu,
 	 */
 	if (!is_error_noslot_pfn(pfn) && !kvm_is_reserved_pfn(pfn) &&
 	    !kvm_is_zone_device_pfn(pfn) && level == PT_PAGE_TABLE_LEVEL &&
-	    PageTransCompoundMap(pfn_to_page(pfn))) {
+	    kvm_is_transparent_hugepage(pfn)) {
 		unsigned long mask;
 
 		/*
@@ -5959,7 +5959,7 @@ static bool kvm_mmu_zap_collapsible_spte(struct kvm *kvm,
 		 */
 		if (sp->role.direct && !kvm_is_reserved_pfn(pfn) &&
 		    !kvm_is_zone_device_pfn(pfn) &&
-		    PageTransCompoundMap(pfn_to_page(pfn))) {
+		    kvm_is_transparent_hugepage(pfn)) {
 			pte_list_remove(rmap_head, sptep);
 
 			if (kvm_available_flush_tlb_with_range())
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 93d5cf0bc716..5e154fad2f98 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -160,6 +160,7 @@ extern unsigned long thp_get_unmapped_area(struct file *filp,
 
 extern void prep_transhuge_page(struct page *page);
 extern void free_transhuge_page(struct page *page);
+bool is_transparent_hugepage(struct page *page);
 
 bool can_split_huge_page(struct page *page, int *pextra_pins);
 int split_huge_page_to_list(struct page *page, struct list_head *list);
@@ -310,6 +311,11 @@ static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
 
 static inline void prep_transhuge_page(struct page *page) {}
 
+static inline bool is_transparent_hugepage(struct page *page)
+{
+	return false;
+}
+
 #define transparent_hugepage_flags 0UL
 
 #define thp_get_unmapped_area	NULL
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 339de08e5fa2..411b71a02f25 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -985,6 +985,7 @@ int kvm_cpu_has_pending_timer(struct kvm_vcpu *vcpu);
 
 bool kvm_is_reserved_pfn(kvm_pfn_t pfn);
 bool kvm_is_zone_device_pfn(kvm_pfn_t pfn);
+bool kvm_is_transparent_hugepage(kvm_pfn_t pfn);
 
 struct kvm_irq_ack_notifier {
 	struct hlist_node link;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 13cc93785006..94c85a5da041 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -527,6 +527,17 @@ void prep_transhuge_page(struct page *page)
 	set_compound_page_dtor(page, TRANSHUGE_PAGE_DTOR);
 }
 
+bool is_transparent_hugepage(struct page *page)
+{
+	if (!PageCompound(page))
+		return 0;
+
+	page = compound_head(page);
+	return is_huge_zero_page(page) ||
+	       page[1].compound_dtor == TRANSHUGE_PAGE_DTOR;
+}
+EXPORT_SYMBOL_GPL(is_transparent_hugepage);
+
 static unsigned long __thp_get_unmapped_area(struct file *filp, unsigned long len,
 		loff_t off, unsigned long flags, unsigned long size)
 {
diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index 38b4c910b6c3..6e29d0c5062c 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -1372,14 +1372,8 @@ static bool transparent_hugepage_adjust(kvm_pfn_t *pfnp, phys_addr_t *ipap)
 {
 	kvm_pfn_t pfn = *pfnp;
 	gfn_t gfn = *ipap >> PAGE_SHIFT;
-	struct page *page = pfn_to_page(pfn);
 
-	/*
-	 * PageTransCompoundMap() returns true for THP and
-	 * hugetlbfs. Make sure the adjustment is done only for THP
-	 * pages.
-	 */
-	if (!PageHuge(page) && PageTransCompoundMap(page)) {
+	if (kvm_is_transparent_hugepage(pfn)) {
 		unsigned long mask;
 		/*
 		 * The address we faulted on is backed by a transparent huge
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 3aa21bec028d..e8ca8bf12320 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -191,6 +191,16 @@ bool kvm_is_reserved_pfn(kvm_pfn_t pfn)
 	return true;
 }
 
+bool kvm_is_transparent_hugepage(kvm_pfn_t pfn)
+{
+	struct page *page = pfn_to_page(pfn);
+
+	if (!PageTransCompoundMap(page))
+		return false;
+
+	return is_transparent_hugepage(compound_head(page));
+}
+
 /*
  * Switches to specified vcpu, until a matching vcpu_put()
  */
-- 
2.24.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
