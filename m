Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEAC360891
	for <lists+kvmarm@lfdr.de>; Thu, 15 Apr 2021 13:50:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B3B494B754;
	Thu, 15 Apr 2021 07:50:57 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UgJehQYebNM4; Thu, 15 Apr 2021 07:50:56 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C38014B77D;
	Thu, 15 Apr 2021 07:50:55 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1C1BD4B6CB
 for <kvmarm@lists.cs.columbia.edu>; Thu, 15 Apr 2021 07:50:55 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 235XcBx2Rysz for <kvmarm@lists.cs.columbia.edu>;
 Thu, 15 Apr 2021 07:50:54 -0400 (EDT)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 542F24B72B
 for <kvmarm@lists.cs.columbia.edu>; Thu, 15 Apr 2021 07:50:49 -0400 (EDT)
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FLczw6VZLzB13T;
 Thu, 15 Apr 2021 19:48:28 +0800 (CST)
Received: from DESKTOP-TMVL5KK.china.huawei.com (10.174.187.128) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Thu, 15 Apr 2021 19:50:40 +0800
From: Yanan Wang <wangyanan55@huawei.com>
To: Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, "Quentin
 Perret" <qperret@google.com>, Alexandru Elisei <alexandru.elisei@arm.com>,
 <kvmarm@lists.cs.columbia.edu>, <linux-arm-kernel@lists.infradead.org>,
 <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 5/6] KVM: arm64: Move I-cache flush to the fault handlers
Date: Thu, 15 Apr 2021 19:50:31 +0800
Message-ID: <20210415115032.35760-6-wangyanan55@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
In-Reply-To: <20210415115032.35760-1-wangyanan55@huawei.com>
References: <20210415115032.35760-1-wangyanan55@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.187.128]
X-CFilter-Loop: Reflected
Cc: Catalin Marinas <catalin.marinas@arm.com>
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

In this patch, we move invalidation of I-cache to the fault handlers to
avoid unnecessary I-cache maintenances. On the map path, invalidate the
I-cache if we are going to create an executable stage-2 mapping for guest.
And on the permission path, invalidate the I-cache if we are going to add
an executable permission to the existing guest stage-2 mapping.

Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
---
 arch/arm64/include/asm/kvm_mmu.h | 15 --------------
 arch/arm64/kvm/hyp/pgtable.c     | 35 +++++++++++++++++++++++++++++++-
 arch/arm64/kvm/mmu.c             |  9 +-------
 3 files changed, 35 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index e9b163c5f023..155492fe5b15 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -187,21 +187,6 @@ static inline bool vcpu_has_cache_enabled(struct kvm_vcpu *vcpu)
 	return (vcpu_read_sys_reg(vcpu, SCTLR_EL1) & 0b101) == 0b101;
 }
 
-static inline void __invalidate_icache_guest_page(kvm_pfn_t pfn,
-						  unsigned long size)
-{
-	if (icache_is_aliasing()) {
-		/* any kind of VIPT cache */
-		__flush_icache_all();
-	} else if (is_kernel_in_hyp_mode() || !icache_is_vpipt()) {
-		/* PIPT or VPIPT at EL2 (see comment in __kvm_tlb_flush_vmid_ipa) */
-		void *va = page_address(pfn_to_page(pfn));
-
-		invalidate_icache_range((unsigned long)va,
-					(unsigned long)va + size);
-	}
-}
-
 void kvm_set_way_flush(struct kvm_vcpu *vcpu);
 void kvm_toggle_cache(struct kvm_vcpu *vcpu, bool was_enabled);
 
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index b480f6d1171e..9f4429d80df0 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -568,6 +568,26 @@ static bool stage2_pte_cacheable(struct kvm_pgtable *pgt, kvm_pte_t pte)
 	return memattr == KVM_S2_MEMATTR(pgt, NORMAL);
 }
 
+static bool stage2_pte_executable(kvm_pte_t pte)
+{
+	return !(pte & KVM_PTE_LEAF_ATTR_HI_S2_XN);
+}
+
+static void stage2_invalidate_icache(void *addr, u64 size)
+{
+	if (icache_is_aliasing()) {
+		/* Any kind of VIPT cache */
+		__flush_icache_all();
+	} else if (is_kernel_in_hyp_mode() || !icache_is_vpipt()) {
+		/*
+		 * See comment in __kvm_tlb_flush_vmid_ipa().
+		 * Invalidate PIPT, or VPIPT at EL2.
+		 */
+		invalidate_icache_range((unsigned long)addr,
+					(unsigned long)addr + size);
+	}
+}
+
 static void stage2_put_pte(kvm_pte_t *ptep, struct kvm_s2_mmu *mmu, u64 addr,
 			   u32 level, struct kvm_pgtable_mm_ops *mm_ops)
 {
@@ -618,6 +638,10 @@ static int stage2_map_walker_try_leaf(u64 addr, u64 end, u32 level,
 		if (stage2_pte_cacheable(pgt, new) && !stage2_has_fwb(pgt))
 			__flush_dcache_area(mm_ops->phys_to_virt(phys),
 					    granule);
+
+		if (stage2_pte_executable(new))
+			stage2_invalidate_icache(mm_ops->phys_to_virt(phys),
+						 granule);
 	}
 
 	smp_store_release(ptep, new);
@@ -896,8 +920,17 @@ static int stage2_attr_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
 	 * but worst-case the access flag update gets lost and will be
 	 * set on the next access instead.
 	 */
-	if (data->pte != pte)
+	if (data->pte != pte) {
+		/*
+		 * Invalidate the instruction cache before updating
+		 * if we are going to add the executable permission
+		 * for the guest stage-2 PTE.
+		 */
+		if (!stage2_pte_executable(*ptep) && stage2_pte_executable(pte))
+			stage2_invalidate_icache(kvm_pte_follow(pte, data->mm_ops),
+						 kvm_granule_size(level));
 		WRITE_ONCE(*ptep, pte);
+	}
 
 	return 0;
 }
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 86f7dd1c234f..aa536392b308 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -694,11 +694,6 @@ void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
 	kvm_mmu_write_protect_pt_masked(kvm, slot, gfn_offset, mask);
 }
 
-static void invalidate_icache_guest_page(kvm_pfn_t pfn, unsigned long size)
-{
-	__invalidate_icache_guest_page(pfn, size);
-}
-
 static void kvm_send_hwpoison_signal(unsigned long address, short lsb)
 {
 	send_sig_mceerr(BUS_MCEERR_AR, (void __user *)address, lsb, current);
@@ -967,10 +962,8 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	if (writable)
 		prot |= KVM_PGTABLE_PROT_W;
 
-	if (exec_fault) {
+	if (exec_fault)
 		prot |= KVM_PGTABLE_PROT_X;
-		invalidate_icache_guest_page(pfn, vma_pagesize);
-	}
 
 	if (device)
 		prot |= KVM_PGTABLE_PROT_DEVICE;
-- 
2.23.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
