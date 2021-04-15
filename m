Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 57D00360B5A
	for <lists+kvmarm@lfdr.de>; Thu, 15 Apr 2021 16:04:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0A2644B6A3;
	Thu, 15 Apr 2021 10:04:04 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J-o4oCSgm+wi; Thu, 15 Apr 2021 10:04:03 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D55754B632;
	Thu, 15 Apr 2021 10:04:02 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B7BAE4B43F
 for <kvmarm@lists.cs.columbia.edu>; Thu, 15 Apr 2021 10:04:00 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QqDpC6pB-Fck for <kvmarm@lists.cs.columbia.edu>;
 Thu, 15 Apr 2021 10:03:59 -0400 (EDT)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 1D5A34B4AC
 for <kvmarm@lists.cs.columbia.edu>; Thu, 15 Apr 2021 10:03:59 -0400 (EDT)
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FLgxq05rgzkjm9;
 Thu, 15 Apr 2021 22:01:51 +0800 (CST)
Received: from DESKTOP-5IS4806.china.huawei.com (10.174.187.224) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Thu, 15 Apr 2021 22:03:34 +0800
From: Keqian Zhu <zhukeqian1@huawei.com>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <kvm@vger.kernel.org>, <kvmarm@lists.cs.columbia.edu>, Marc Zyngier
 <maz@kernel.org>
Subject: [PATCH v4 2/2] kvm/arm64: Try stage2 block mapping for host device
 MMIO
Date: Thu, 15 Apr 2021 22:03:28 +0800
Message-ID: <20210415140328.24200-3-zhukeqian1@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
In-Reply-To: <20210415140328.24200-1-zhukeqian1@huawei.com>
References: <20210415140328.24200-1-zhukeqian1@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.187.224]
X-CFilter-Loop: Reflected
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

The MMIO region of a device maybe huge (GB level), try to use
block mapping in stage2 to speedup both map and unmap.

Compared to normal memory mapping, we should consider two more
points when try block mapping for MMIO region:

1. For normal memory mapping, the PA(host physical address) and
HVA have same alignment within PUD_SIZE or PMD_SIZE when we use
the HVA to request hugepage, so we don't need to consider PA
alignment when verifing block mapping. But for device memory
mapping, the PA and HVA may have different alignment.

2. For normal memory mapping, we are sure hugepage size properly
fit into vma, so we don't check whether the mapping size exceeds
the boundary of vma. But for device memory mapping, we should pay
attention to this.

This adds get_vma_page_shift() to get page shift for both normal
memory and device MMIO region, and check these two points when
selecting block mapping size for MMIO region.

Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
---
 arch/arm64/kvm/mmu.c | 61 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 51 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index c59af5ca01b0..5a1cc7751e6d 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -738,6 +738,35 @@ transparent_hugepage_adjust(struct kvm_memory_slot *memslot,
 	return PAGE_SIZE;
 }
 
+static int get_vma_page_shift(struct vm_area_struct *vma, unsigned long hva)
+{
+	unsigned long pa;
+
+	if (is_vm_hugetlb_page(vma) && !(vma->vm_flags & VM_PFNMAP))
+		return huge_page_shift(hstate_vma(vma));
+
+	if (!(vma->vm_flags & VM_PFNMAP))
+		return PAGE_SHIFT;
+
+	VM_BUG_ON(is_vm_hugetlb_page(vma));
+
+	pa = (vma->vm_pgoff << PAGE_SHIFT) + (hva - vma->vm_start);
+
+#ifndef __PAGETABLE_PMD_FOLDED
+	if ((hva & (PUD_SIZE - 1)) == (pa & (PUD_SIZE - 1)) &&
+	    ALIGN_DOWN(hva, PUD_SIZE) >= vma->vm_start &&
+	    ALIGN(hva, PUD_SIZE) <= vma->vm_end)
+		return PUD_SHIFT;
+#endif
+
+	if ((hva & (PMD_SIZE - 1)) == (pa & (PMD_SIZE - 1)) &&
+	    ALIGN_DOWN(hva, PMD_SIZE) >= vma->vm_start &&
+	    ALIGN(hva, PMD_SIZE) <= vma->vm_end)
+		return PMD_SHIFT;
+
+	return PAGE_SHIFT;
+}
+
 static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 			  struct kvm_memory_slot *memslot, unsigned long hva,
 			  unsigned long fault_status)
@@ -769,7 +798,10 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		return -EFAULT;
 	}
 
-	/* Let's check if we will get back a huge page backed by hugetlbfs */
+	/*
+	 * Let's check if we will get back a huge page backed by hugetlbfs, or
+	 * get block mapping for device MMIO region.
+	 */
 	mmap_read_lock(current->mm);
 	vma = find_vma_intersection(current->mm, hva, hva + 1);
 	if (unlikely(!vma)) {
@@ -778,15 +810,15 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		return -EFAULT;
 	}
 
-	if (is_vm_hugetlb_page(vma))
-		vma_shift = huge_page_shift(hstate_vma(vma));
-	else
-		vma_shift = PAGE_SHIFT;
-
-	if (logging_active ||
-	    (vma->vm_flags & VM_PFNMAP)) {
+	/*
+	 * logging_active is guaranteed to never be true for VM_PFNMAP
+	 * memslots.
+	 */
+	if (logging_active) {
 		force_pte = true;
 		vma_shift = PAGE_SHIFT;
+	} else {
+		vma_shift = get_vma_page_shift(vma, hva);
 	}
 
 	switch (vma_shift) {
@@ -854,8 +886,17 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		return -EFAULT;
 
 	if (kvm_is_device_pfn(pfn)) {
+		/*
+		 * If the page was identified as device early by looking at
+		 * the VMA flags, vma_pagesize is already representing the
+		 * largest quantity we can map.  If instead it was mapped
+		 * via gfn_to_pfn_prot(), vma_pagesize is set to PAGE_SIZE
+		 * and must not be upgraded.
+		 *
+		 * In both cases, we don't let transparent_hugepage_adjust()
+		 * change things at the last minute.
+		 */
 		device = true;
-		force_pte = true;
 	} else if (logging_active && !write_fault) {
 		/*
 		 * Only actually map the page as writable if this was a write
@@ -876,7 +917,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	 * If we are not forced to use page mapping, check if we are
 	 * backed by a THP and thus use block mapping if possible.
 	 */
-	if (vma_pagesize == PAGE_SIZE && !force_pte)
+	if (vma_pagesize == PAGE_SIZE && !(force_pte || device))
 		vma_pagesize = transparent_hugepage_adjust(memslot, hva,
 							   &pfn, &fault_ipa);
 	if (writable)
-- 
2.19.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
