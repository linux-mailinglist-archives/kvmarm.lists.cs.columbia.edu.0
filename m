Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D7505258F24
	for <lists+kvmarm@lfdr.de>; Tue,  1 Sep 2020 15:33:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8CB574B2AC;
	Tue,  1 Sep 2020 09:33:07 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ym4gZPe6AXze; Tue,  1 Sep 2020 09:33:06 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5BCB94B2A6;
	Tue,  1 Sep 2020 09:33:06 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 38F7E4B292
 for <kvmarm@lists.cs.columbia.edu>; Tue,  1 Sep 2020 09:33:05 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jj9Py2IvMceW for <kvmarm@lists.cs.columbia.edu>;
 Tue,  1 Sep 2020 09:33:04 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1D7D24B293
 for <kvmarm@lists.cs.columbia.edu>; Tue,  1 Sep 2020 09:33:03 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8254611D4;
 Tue,  1 Sep 2020 06:33:02 -0700 (PDT)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 995DA3F66F;
 Tue,  1 Sep 2020 06:33:01 -0700 (PDT)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.cs.columbia.edu
Subject: [PATCH 2/2] KVM: arm64: Try PMD block mappings if PUD mappings are
 not supported
Date: Tue,  1 Sep 2020 14:33:57 +0100
Message-Id: <20200901133357.52640-3-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901133357.52640-1-alexandru.elisei@arm.com>
References: <20200901133357.52640-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
Cc: maz@kernel.org
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

When userspace uses hugetlbfs for the VM memory, user_mem_abort() tries to
use the same block size to map the faulting IPA in stage 2. If stage 2
cannot use the same size mapping because the block size doesn't fit in the
memslot or the memslot is not properly aligned, user_mem_abort() will fall
back to a page mapping, regardless of the block size. We can do better for
PUD backed hugetlbfs by checking if a PMD block mapping is possible before
deciding to use a page.

vma_pagesize is an unsigned long, use 1UL instead of 1ULL when assigning
its value.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/kvm/mmu.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 25e7dc52c086..f590f7355cda 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1871,15 +1871,24 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	else
 		vma_shift = PAGE_SHIFT;
 
-	vma_pagesize = 1ULL << vma_shift;
 	if (logging_active ||
-	    (vma->vm_flags & VM_PFNMAP) ||
-	    !fault_supports_stage2_huge_mapping(memslot, hva, vma_pagesize)) {
+	    (vma->vm_flags & VM_PFNMAP)) {
 		force_pte = true;
-		vma_pagesize = PAGE_SIZE;
 		vma_shift = PAGE_SHIFT;
 	}
 
+	if (vma_shift == PUD_SHIFT &&
+	    !fault_supports_stage2_huge_mapping(memslot, hva, PUD_SIZE))
+		vma_shift = PMD_SHIFT;
+
+	if (vma_shift == PMD_SHIFT &&
+	    !fault_supports_stage2_huge_mapping(memslot, hva, PMD_SIZE)) {
+		force_pte = true;
+		vma_shift = PAGE_SHIFT;
+	}
+
+	vma_pagesize = 1UL << vma_shift;
+
 	/*
 	 * The stage2 has a minimum of 2 level table (For arm64 see
 	 * kvm_arm_setup_stage2()). Hence, we are guaranteed that we can
@@ -1889,7 +1898,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	 */
 	if (vma_pagesize == PMD_SIZE ||
 	    (vma_pagesize == PUD_SIZE && kvm_stage2_has_pmd(kvm)))
-		gfn = (fault_ipa & huge_page_mask(hstate_vma(vma))) >> PAGE_SHIFT;
+		gfn = (fault_ipa & ~(vma_pagesize - 1)) >> PAGE_SHIFT;
 	mmap_read_unlock(current->mm);
 
 	/* We need minimum second+third level pages */
-- 
2.28.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
