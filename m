Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BDAE43CC243
	for <lists+kvmarm@lfdr.de>; Sat, 17 Jul 2021 11:56:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 707C44B0E5;
	Sat, 17 Jul 2021 05:56:17 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fs9FD-te7g0n; Sat, 17 Jul 2021 05:56:16 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3E3134B0E2;
	Sat, 17 Jul 2021 05:56:14 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id F347D49D50
 for <kvmarm@lists.cs.columbia.edu>; Sat, 17 Jul 2021 05:56:12 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0y9HxzeyfuJf for <kvmarm@lists.cs.columbia.edu>;
 Sat, 17 Jul 2021 05:56:12 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id DAA234B0D5
 for <kvmarm@lists.cs.columbia.edu>; Sat, 17 Jul 2021 05:56:11 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E4CB7613D9;
 Sat, 17 Jul 2021 09:56:10 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1m4h3J-00DvkH-6F; Sat, 17 Jul 2021 10:56:09 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, linux-mm@kvack.org
Subject: [PATCH 1/5] KVM: arm64: Walk userspace page tables to compute the THP
 mapping size
Date: Sat, 17 Jul 2021 10:55:37 +0100
Message-Id: <20210717095541.1486210-2-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210717095541.1486210-1-maz@kernel.org>
References: <20210717095541.1486210-1-maz@kernel.org>
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

We currently rely on the kvm_is_transparent_hugepage() helper to
discover whether a given page has the potential to be mapped as
a block mapping.

However, this API doesn't really give un everything we want:
- we don't get the size: this is not crucial today as we only
  support PMD-sized THPs, but we'd like to have larger sizes
  in the future
- we're the only user left of the API, and there is a will
  to remove it altogether

To address the above, implement a simple walker using the existing
page table infrastructure, and plumb it into transparent_hugepage_adjust().
No new page sizes are supported in the process.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kvm/mmu.c | 46 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 3155c9e778f0..db6314b93e99 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -433,6 +433,44 @@ int create_hyp_exec_mappings(phys_addr_t phys_addr, size_t size,
 	return 0;
 }
 
+static struct kvm_pgtable_mm_ops kvm_user_mm_ops = {
+	/* We shouldn't need any other callback to walk the PT */
+	.phys_to_virt		= kvm_host_va,
+};
+
+struct user_walk_data {
+	u32	level;
+};
+
+static int user_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
+		       enum kvm_pgtable_walk_flags flag, void * const arg)
+{
+	struct user_walk_data *data = arg;
+
+	data->level = level;
+	return 0;
+}
+
+static int get_user_mapping_size(struct kvm *kvm, u64 addr)
+{
+	struct user_walk_data data;
+	struct kvm_pgtable pgt = {
+		.pgd		= (kvm_pte_t *)kvm->mm->pgd,
+		.ia_bits	= VA_BITS,
+		.start_level	= 4 - CONFIG_PGTABLE_LEVELS,
+		.mm_ops		= &kvm_user_mm_ops,
+	};
+	struct kvm_pgtable_walker walker = {
+		.cb		= user_walker,
+		.flags		= KVM_PGTABLE_WALK_LEAF,
+		.arg		= &data,
+	};
+
+	kvm_pgtable_walk(&pgt, ALIGN_DOWN(addr, PAGE_SIZE), PAGE_SIZE, &walker);
+
+	return BIT(ARM64_HW_PGTABLE_LEVEL_SHIFT(data.level));
+}
+
 static struct kvm_pgtable_mm_ops kvm_s2_mm_ops = {
 	.zalloc_page		= stage2_memcache_zalloc_page,
 	.zalloc_pages_exact	= kvm_host_zalloc_pages_exact,
@@ -780,7 +818,7 @@ static bool fault_supports_stage2_huge_mapping(struct kvm_memory_slot *memslot,
  * Returns the size of the mapping.
  */
 static unsigned long
-transparent_hugepage_adjust(struct kvm_memory_slot *memslot,
+transparent_hugepage_adjust(struct kvm *kvm, struct kvm_memory_slot *memslot,
 			    unsigned long hva, kvm_pfn_t *pfnp,
 			    phys_addr_t *ipap)
 {
@@ -791,8 +829,8 @@ transparent_hugepage_adjust(struct kvm_memory_slot *memslot,
 	 * sure that the HVA and IPA are sufficiently aligned and that the
 	 * block map is contained within the memslot.
 	 */
-	if (kvm_is_transparent_hugepage(pfn) &&
-	    fault_supports_stage2_huge_mapping(memslot, hva, PMD_SIZE)) {
+	if (fault_supports_stage2_huge_mapping(memslot, hva, PMD_SIZE) &&
+	    get_user_mapping_size(kvm, hva) >= PMD_SIZE) {
 		/*
 		 * The address we faulted on is backed by a transparent huge
 		 * page.  However, because we map the compound huge page and
@@ -1051,7 +1089,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	 * backed by a THP and thus use block mapping if possible.
 	 */
 	if (vma_pagesize == PAGE_SIZE && !(force_pte || device))
-		vma_pagesize = transparent_hugepage_adjust(memslot, hva,
+		vma_pagesize = transparent_hugepage_adjust(kvm, memslot, hva,
 							   &pfn, &fault_ipa);
 
 	if (fault_status != FSC_PERM && !device && kvm_has_mte(kvm)) {
-- 
2.30.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
