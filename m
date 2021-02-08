Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 863B03130A2
	for <lists+kvmarm@lfdr.de>; Mon,  8 Feb 2021 12:23:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 390B94B473;
	Mon,  8 Feb 2021 06:23:11 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id stlM65o9uMx2; Mon,  8 Feb 2021 06:23:10 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 23F024B47A;
	Mon,  8 Feb 2021 06:23:09 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1377C4B39F
 for <kvmarm@lists.cs.columbia.edu>; Mon,  8 Feb 2021 06:23:08 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k8RPbbfLyClo for <kvmarm@lists.cs.columbia.edu>;
 Mon,  8 Feb 2021 06:23:05 -0500 (EST)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 7A8004B3B2
 for <kvmarm@lists.cs.columbia.edu>; Mon,  8 Feb 2021 06:23:05 -0500 (EST)
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DZ3Wj6nB9zjK1c;
 Mon,  8 Feb 2021 19:21:53 +0800 (CST)
Received: from DESKTOP-TMVL5KK.china.huawei.com (10.174.187.128) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Mon, 8 Feb 2021 19:22:53 +0800
From: Yanan Wang <wangyanan55@huawei.com>
To: Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, "Catalin
 Marinas" <catalin.marinas@arm.com>, James Morse <james.morse@arm.com>,
 "Julien Thierry" <julien.thierry.kdev@gmail.com>, Suzuki K Poulose
 <suzuki.poulose@arm.com>, Gavin Shan <gshan@redhat.com>, Quentin Perret
 <qperret@google.com>, <kvmarm@lists.cs.columbia.edu>,
 <linux-arm-kernel@lists.infradead.org>, <kvm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 1/4] KVM: arm64: Move the clean of dcache to the map
 handler
Date: Mon, 8 Feb 2021 19:22:47 +0800
Message-ID: <20210208112250.163568-2-wangyanan55@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
In-Reply-To: <20210208112250.163568-1-wangyanan55@huawei.com>
References: <20210208112250.163568-1-wangyanan55@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.187.128]
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

We currently uniformly clean dcache in user_mem_abort() before calling the
fault handlers, if we take a translation fault and the pfn is cacheable.
But if there are concurrent translation faults on the same page or block,
clean of dcache for the first time is necessary while the others are not.

By moving clean of dcache to the map handler, we can easily identify the
conditions where CMOs are really needed and avoid the unnecessary ones.
As it's a time consuming process to perform CMOs especially when flushing
a block range, so this solution reduces much load of kvm and improve the
efficiency of creating mappings.

Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
---
 arch/arm64/include/asm/kvm_mmu.h | 16 --------------
 arch/arm64/kvm/hyp/pgtable.c     | 38 ++++++++++++++++++++------------
 arch/arm64/kvm/mmu.c             | 14 +++---------
 3 files changed, 27 insertions(+), 41 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index e52d82aeadca..4ec9879e82ed 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -204,22 +204,6 @@ static inline bool vcpu_has_cache_enabled(struct kvm_vcpu *vcpu)
 	return (vcpu_read_sys_reg(vcpu, SCTLR_EL1) & 0b101) == 0b101;
 }
 
-static inline void __clean_dcache_guest_page(kvm_pfn_t pfn, unsigned long size)
-{
-	void *va = page_address(pfn_to_page(pfn));
-
-	/*
-	 * With FWB, we ensure that the guest always accesses memory using
-	 * cacheable attributes, and we don't have to clean to PoC when
-	 * faulting in pages. Furthermore, FWB implies IDC, so cleaning to
-	 * PoU is not required either in this case.
-	 */
-	if (cpus_have_const_cap(ARM64_HAS_STAGE2_FWB))
-		return;
-
-	kvm_flush_dcache_to_poc(va, size);
-}
-
 static inline void __invalidate_icache_guest_page(kvm_pfn_t pfn,
 						  unsigned long size)
 {
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 4d177ce1d536..2f4f87021980 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -464,6 +464,26 @@ static int stage2_map_set_prot_attr(enum kvm_pgtable_prot prot,
 	return 0;
 }
 
+static bool stage2_pte_cacheable(kvm_pte_t pte)
+{
+	u64 memattr = pte & KVM_PTE_LEAF_ATTR_LO_S2_MEMATTR;
+	return memattr == PAGE_S2_MEMATTR(NORMAL);
+}
+
+static void stage2_flush_dcache(void *addr, u64 size)
+{
+	/*
+	 * With FWB, we ensure that the guest always accesses memory using
+	 * cacheable attributes, and we don't have to clean to PoC when
+	 * faulting in pages. Furthermore, FWB implies IDC, so cleaning to
+	 * PoU is not required either in this case.
+	 */
+	if (cpus_have_const_cap(ARM64_HAS_STAGE2_FWB))
+		return;
+
+	__flush_dcache_area(addr, size);
+}
+
 static int stage2_map_walker_try_leaf(u64 addr, u64 end, u32 level,
 				      kvm_pte_t *ptep,
 				      struct stage2_map_data *data)
@@ -495,6 +515,10 @@ static int stage2_map_walker_try_leaf(u64 addr, u64 end, u32 level,
 		put_page(page);
 	}
 
+	/* Flush data cache before installation of the new PTE */
+	if (stage2_pte_cacheable(new))
+		stage2_flush_dcache(__va(phys), granule);
+
 	smp_store_release(ptep, new);
 	get_page(page);
 	data->phys += granule;
@@ -651,20 +675,6 @@ int kvm_pgtable_stage2_map(struct kvm_pgtable *pgt, u64 addr, u64 size,
 	return ret;
 }
 
-static void stage2_flush_dcache(void *addr, u64 size)
-{
-	if (cpus_have_const_cap(ARM64_HAS_STAGE2_FWB))
-		return;
-
-	__flush_dcache_area(addr, size);
-}
-
-static bool stage2_pte_cacheable(kvm_pte_t pte)
-{
-	u64 memattr = pte & KVM_PTE_LEAF_ATTR_LO_S2_MEMATTR;
-	return memattr == PAGE_S2_MEMATTR(NORMAL);
-}
-
 static int stage2_unmap_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
 			       enum kvm_pgtable_walk_flags flag,
 			       void * const arg)
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 77cb2d28f2a4..d151927a7d62 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -609,11 +609,6 @@ void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
 	kvm_mmu_write_protect_pt_masked(kvm, slot, gfn_offset, mask);
 }
 
-static void clean_dcache_guest_page(kvm_pfn_t pfn, unsigned long size)
-{
-	__clean_dcache_guest_page(pfn, size);
-}
-
 static void invalidate_icache_guest_page(kvm_pfn_t pfn, unsigned long size)
 {
 	__invalidate_icache_guest_page(pfn, size);
@@ -882,9 +877,6 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	if (writable)
 		prot |= KVM_PGTABLE_PROT_W;
 
-	if (fault_status != FSC_PERM && !device)
-		clean_dcache_guest_page(pfn, vma_pagesize);
-
 	if (exec_fault) {
 		prot |= KVM_PGTABLE_PROT_X;
 		invalidate_icache_guest_page(pfn, vma_pagesize);
@@ -1144,10 +1136,10 @@ int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte)
 	trace_kvm_set_spte_hva(hva);
 
 	/*
-	 * We've moved a page around, probably through CoW, so let's treat it
-	 * just like a translation fault and clean the cache to the PoC.
+	 * We've moved a page around, probably through CoW, so let's treat
+	 * it just like a translation fault and the map handler will clean
+	 * the cache to the PoC.
 	 */
-	clean_dcache_guest_page(pfn, PAGE_SIZE);
 	handle_hva_to_gpa(kvm, hva, end, &kvm_set_spte_handler, &pfn);
 	return 0;
 }
-- 
2.23.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
