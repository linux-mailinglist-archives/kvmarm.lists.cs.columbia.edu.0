Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id EB3D7266036
	for <lists+kvmarm@lfdr.de>; Fri, 11 Sep 2020 15:26:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9F31B4B2B8;
	Fri, 11 Sep 2020 09:26:23 -0400 (EDT)
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
	with ESMTP id oxcnExFR-5kj; Fri, 11 Sep 2020 09:26:22 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 492F94B408;
	Fri, 11 Sep 2020 09:26:22 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A17DE4B33F
 for <kvmarm@lists.cs.columbia.edu>; Fri, 11 Sep 2020 09:26:20 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k1QiYD6kbRNi for <kvmarm@lists.cs.columbia.edu>;
 Fri, 11 Sep 2020 09:26:19 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 5C5694B3D5
 for <kvmarm@lists.cs.columbia.edu>; Fri, 11 Sep 2020 09:26:19 -0400 (EDT)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 997DA22208;
 Fri, 11 Sep 2020 13:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599830778;
 bh=/lEeNwEoPpZE4KGIi2ZZ8I5lGiiL3nsXkI3HiFzUZfo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fv2qAs6gAvP3W2wrkKnn0V5xUXbaiq0jhaCio/BNrHqDssTlkgTQkGsKw4/nYCC4c
 ahxkYaj/ILGlGzGT5irUeFMgs2pFg+Ii0K2oasPj1BRbacejDQqaX+KLNJ/fitJFdc
 XyhyMiVG1aHve865NOFnZ5+qI3vH79XMWl2HA2KI=
From: Will Deacon <will@kernel.org>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v5 17/21] KVM: arm64: Convert user_mem_abort() to generic
 page-table API
Date: Fri, 11 Sep 2020 14:25:25 +0100
Message-Id: <20200911132529.19844-18-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200911132529.19844-1-will@kernel.org>
References: <20200911132529.19844-1-will@kernel.org>
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

Convert user_mem_abort() to call kvm_pgtable_stage2_relax_perms() when
handling a stage-2 permission fault and kvm_pgtable_stage2_map() when
handling a stage-2 translation fault, rather than walking the page-table
manually.

Cc: Marc Zyngier <maz@kernel.org>
Cc: Quentin Perret <qperret@google.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Alexandru Elisei <alexandru.elisei@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kvm/mmu.c | 124 +++++++++++++++----------------------------
 1 file changed, 44 insertions(+), 80 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index d5813996c0e4..e980e614dd81 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1499,18 +1499,19 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 {
 	int ret;
 	bool write_fault, writable, force_pte = false;
-	bool exec_fault, needs_exec;
+	bool exec_fault;
+	bool device = false;
 	unsigned long mmu_seq;
-	gfn_t gfn = fault_ipa >> PAGE_SHIFT;
 	struct kvm *kvm = vcpu->kvm;
 	struct kvm_mmu_memory_cache *memcache = &vcpu->arch.mmu_page_cache;
 	struct vm_area_struct *vma;
 	short vma_shift;
+	gfn_t gfn;
 	kvm_pfn_t pfn;
-	pgprot_t mem_type = PAGE_S2;
 	bool logging_active = memslot_is_logging(memslot);
-	unsigned long vma_pagesize, flags = 0;
-	struct kvm_s2_mmu *mmu = vcpu->arch.hw_mmu;
+	unsigned long vma_pagesize;
+	enum kvm_pgtable_prot prot = KVM_PGTABLE_PROT_R;
+	struct kvm_pgtable *pgt;
 
 	write_fault = kvm_is_write_fault(vcpu);
 	exec_fault = kvm_vcpu_trap_is_iabt(vcpu);
@@ -1543,22 +1544,24 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		vma_pagesize = PAGE_SIZE;
 	}
 
-	/*
-	 * The stage2 has a minimum of 2 level table (For arm64 see
-	 * kvm_arm_setup_stage2()). Hence, we are guaranteed that we can
-	 * use PMD_SIZE huge mappings (even when the PMD is folded into PGD).
-	 * As for PUD huge maps, we must make sure that we have at least
-	 * 3 levels, i.e, PMD is not folded.
-	 */
-	if (vma_pagesize == PMD_SIZE ||
-	    (vma_pagesize == PUD_SIZE && kvm_stage2_has_pmd(kvm)))
-		gfn = (fault_ipa & huge_page_mask(hstate_vma(vma))) >> PAGE_SHIFT;
+	if (vma_pagesize == PMD_SIZE || vma_pagesize == PUD_SIZE)
+		fault_ipa &= huge_page_mask(hstate_vma(vma));
+
+	gfn = fault_ipa >> PAGE_SHIFT;
 	mmap_read_unlock(current->mm);
 
-	/* We need minimum second+third level pages */
-	ret = kvm_mmu_topup_memory_cache(memcache, kvm_mmu_cache_min_pages(kvm));
-	if (ret)
-		return ret;
+	/*
+	 * Permission faults just need to update the existing leaf entry,
+	 * and so normally don't require allocations from the memcache. The
+	 * only exception to this is when dirty logging is enabled at runtime
+	 * and a write fault needs to collapse a block entry into a table.
+	 */
+	if (fault_status != FSC_PERM || (logging_active && write_fault)) {
+		ret = kvm_mmu_topup_memory_cache(memcache,
+						 kvm_mmu_cache_min_pages(kvm));
+		if (ret)
+			return ret;
+	}
 
 	mmu_seq = vcpu->kvm->mmu_notifier_seq;
 	/*
@@ -1581,28 +1584,20 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		return -EFAULT;
 
 	if (kvm_is_device_pfn(pfn)) {
-		mem_type = PAGE_S2_DEVICE;
-		flags |= KVM_S2PTE_FLAG_IS_IOMAP;
-	} else if (logging_active) {
-		/*
-		 * Faults on pages in a memslot with logging enabled
-		 * should not be mapped with huge pages (it introduces churn
-		 * and performance degradation), so force a pte mapping.
-		 */
-		flags |= KVM_S2_FLAG_LOGGING_ACTIVE;
-
+		device = true;
+	} else if (logging_active && !write_fault) {
 		/*
 		 * Only actually map the page as writable if this was a write
 		 * fault.
 		 */
-		if (!write_fault)
-			writable = false;
+		writable = false;
 	}
 
-	if (exec_fault && is_iomap(flags))
+	if (exec_fault && device)
 		return -ENOEXEC;
 
 	spin_lock(&kvm->mmu_lock);
+	pgt = vcpu->arch.hw_mmu->pgt;
 	if (mmu_notifier_retry(kvm, mmu_seq))
 		goto out_unlock;
 
@@ -1613,62 +1608,31 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	if (vma_pagesize == PAGE_SIZE && !force_pte)
 		vma_pagesize = transparent_hugepage_adjust(memslot, hva,
 							   &pfn, &fault_ipa);
-	if (writable)
+	if (writable) {
+		prot |= KVM_PGTABLE_PROT_W;
 		kvm_set_pfn_dirty(pfn);
+		mark_page_dirty(kvm, gfn);
+	}
 
-	if (fault_status != FSC_PERM && !is_iomap(flags))
+	if (fault_status != FSC_PERM && !device)
 		clean_dcache_guest_page(pfn, vma_pagesize);
 
-	if (exec_fault)
+	if (exec_fault) {
+		prot |= KVM_PGTABLE_PROT_X;
 		invalidate_icache_guest_page(pfn, vma_pagesize);
+	}
 
-	/*
-	 * If we took an execution fault we have made the
-	 * icache/dcache coherent above and should now let the s2
-	 * mapping be executable.
-	 *
-	 * Write faults (!exec_fault && FSC_PERM) are orthogonal to
-	 * execute permissions, and we preserve whatever we have.
-	 */
-	needs_exec = exec_fault ||
-		(fault_status == FSC_PERM &&
-		 stage2_is_exec(mmu, fault_ipa, vma_pagesize));
-
-	if (vma_pagesize == PUD_SIZE) {
-		pud_t new_pud = kvm_pfn_pud(pfn, mem_type);
-
-		new_pud = kvm_pud_mkhuge(new_pud);
-		if (writable)
-			new_pud = kvm_s2pud_mkwrite(new_pud);
-
-		if (needs_exec)
-			new_pud = kvm_s2pud_mkexec(new_pud);
-
-		ret = stage2_set_pud_huge(mmu, memcache, fault_ipa, &new_pud);
-	} else if (vma_pagesize == PMD_SIZE) {
-		pmd_t new_pmd = kvm_pfn_pmd(pfn, mem_type);
-
-		new_pmd = kvm_pmd_mkhuge(new_pmd);
-
-		if (writable)
-			new_pmd = kvm_s2pmd_mkwrite(new_pmd);
-
-		if (needs_exec)
-			new_pmd = kvm_s2pmd_mkexec(new_pmd);
+	if (device)
+		prot |= KVM_PGTABLE_PROT_DEVICE;
+	else if (cpus_have_const_cap(ARM64_HAS_CACHE_DIC))
+		prot |= KVM_PGTABLE_PROT_X;
 
-		ret = stage2_set_pmd_huge(mmu, memcache, fault_ipa, &new_pmd);
+	if (fault_status == FSC_PERM && !(logging_active && writable)) {
+		ret = kvm_pgtable_stage2_relax_perms(pgt, fault_ipa, prot);
 	} else {
-		pte_t new_pte = kvm_pfn_pte(pfn, mem_type);
-
-		if (writable) {
-			new_pte = kvm_s2pte_mkwrite(new_pte);
-			mark_page_dirty(kvm, gfn);
-		}
-
-		if (needs_exec)
-			new_pte = kvm_s2pte_mkexec(new_pte);
-
-		ret = stage2_set_pte(mmu, memcache, fault_ipa, &new_pte, flags);
+		ret = kvm_pgtable_stage2_map(pgt, fault_ipa, vma_pagesize,
+					     __pfn_to_phys(pfn), prot,
+					     memcache);
 	}
 
 out_unlock:
-- 
2.28.0.618.gf4bc123cb7-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
