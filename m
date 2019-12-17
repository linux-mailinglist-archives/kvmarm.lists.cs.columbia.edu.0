Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 157E2122BCA
	for <lists+kvmarm@lfdr.de>; Tue, 17 Dec 2019 13:38:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 47D744A59B;
	Tue, 17 Dec 2019 07:38:20 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9pXIdBffcZmB; Tue, 17 Dec 2019 07:38:20 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1597A4A576;
	Tue, 17 Dec 2019 07:38:19 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 49D0F4A4C0
 for <kvmarm@lists.cs.columbia.edu>; Tue, 17 Dec 2019 07:38:18 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 52rMx9FFETOc for <kvmarm@lists.cs.columbia.edu>;
 Tue, 17 Dec 2019 07:38:17 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EDA9F4A4A9
 for <kvmarm@lists.cs.columbia.edu>; Tue, 17 Dec 2019 07:38:16 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75CAE31B;
 Tue, 17 Dec 2019 04:38:16 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 759903F718;
 Tue, 17 Dec 2019 04:38:15 -0800 (PST)
From: James Morse <james.morse@arm.com>
To: kvmarm@lists.cs.columbia.edu,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] KVM: arm/arm64: Re-check VMA on detecting a poisoned page
Date: Tue, 17 Dec 2019 12:38:09 +0000
Message-Id: <20191217123809.197392-1-james.morse@arm.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Cc: Marc Zyngier <maz@kernel.org>
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

When we check for a poisoned page, we use the VMA to tell userspace
about the looming disaster. But we pass a pointer to this VMA
after having released the mmap_sem, which isn't a good idea.

Instead, stash the shift value that goes with this pfn while
we are holding the mmap_sem.

Reported-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: James Morse <james.morse@arm.com>
---

Based on Marc's patch:
Link: lore.kernel.org/r/20191211165651.7889-3-maz@kernel.org

 virt/kvm/arm/mmu.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index 38b4c910b6c3..bb0f8d648678 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -1591,16 +1591,8 @@ static void invalidate_icache_guest_page(kvm_pfn_t pfn, unsigned long size)
 	__invalidate_icache_guest_page(pfn, size);
 }
 
-static void kvm_send_hwpoison_signal(unsigned long address,
-				     struct vm_area_struct *vma)
+static void kvm_send_hwpoison_signal(unsigned long address, short lsb)
 {
-	short lsb;
-
-	if (is_vm_hugetlb_page(vma))
-		lsb = huge_page_shift(hstate_vma(vma));
-	else
-		lsb = PAGE_SHIFT;
-
 	send_sig_mceerr(BUS_MCEERR_AR, (void __user *)address, lsb, current);
 }
 
@@ -1673,6 +1665,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	struct kvm *kvm = vcpu->kvm;
 	struct kvm_mmu_memory_cache *memcache = &vcpu->arch.mmu_page_cache;
 	struct vm_area_struct *vma;
+	short vma_shift;
 	kvm_pfn_t pfn;
 	pgprot_t mem_type = PAGE_S2;
 	bool logging_active = memslot_is_logging(memslot);
@@ -1696,7 +1689,12 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		return -EFAULT;
 	}
 
-	vma_pagesize = vma_kernel_pagesize(vma);
+	if (is_vm_hugetlb_page(vma))
+		vma_shift = huge_page_shift(hstate_vma(vma));
+	else
+		vma_shift = PAGE_SHIFT;
+
+	vma_pagesize = 1ULL << vma_shift;
 	if (logging_active ||
 	    !fault_supports_stage2_huge_mapping(memslot, hva, vma_pagesize)) {
 		force_pte = true;
@@ -1735,7 +1733,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 
 	pfn = gfn_to_pfn_prot(kvm, gfn, write_fault, &writable);
 	if (pfn == KVM_PFN_ERR_HWPOISON) {
-		kvm_send_hwpoison_signal(hva, vma);
+		kvm_send_hwpoison_signal(hva, vma_shift);
 		return 0;
 	}
 	if (is_error_noslot_pfn(pfn))
-- 
2.24.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
