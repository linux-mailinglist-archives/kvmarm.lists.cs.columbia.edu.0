Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B18325B8302
	for <lists+kvmarm@lfdr.de>; Wed, 14 Sep 2022 10:35:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5E70B4BC0D;
	Wed, 14 Sep 2022 04:35:55 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VHvZQpf8GOvO; Wed, 14 Sep 2022 04:35:53 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D58824BC5C;
	Wed, 14 Sep 2022 04:35:53 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 299FA4BB60
 for <kvmarm@lists.cs.columbia.edu>; Wed, 14 Sep 2022 04:35:52 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Sdt3n4Z2QmCv for <kvmarm@lists.cs.columbia.edu>;
 Wed, 14 Sep 2022 04:35:50 -0400 (EDT)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 8ACE54BC0D
 for <kvmarm@lists.cs.columbia.edu>; Wed, 14 Sep 2022 04:35:50 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id B78B2B8167E;
 Wed, 14 Sep 2022 08:35:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6437FC43470;
 Wed, 14 Sep 2022 08:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1663144548;
 bh=j8C4+LPGLEwEy80TNgK3DOnFtGcsCSzDNVrtvCeeWSI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KOQOPy+yDvPBxqxqixwfL4GGyoEQNtDvfzl1Zf7b4sdo0kqUDyWlIpTxt39H6/2NN
 YAtIPRjzE5E5p7g0eeBCINSOZZze+1WOh1lIVyDSYkGwT/V9mhjwF8nF1RLA28pPyz
 hvOsSq0sHhOcHQratNmw5qyDLF2dAGJeaK5WmFnJeoEZ13dSbPKZHy2CguIFc8SjSd
 R4qS3SSQQw2gGJHrgnvodocNig3cS7qIN4+rJDtg03+UZdw/Y4OUG/P/YBKaQ5Ocku
 zV65UzYe4VxyEteAHIWuBAWsEgJ6ZigUqhWlUQw8u2Yj3CVccDLMqO+TCrGG4SRZP3
 u0qDEg2DbnoGg==
From: Will Deacon <will@kernel.org>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v3 11/25] KVM: arm64: Rename 'host_kvm' to 'host_mmu'
Date: Wed, 14 Sep 2022 09:34:46 +0100
Message-Id: <20220914083500.5118-12-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220914083500.5118-1-will@kernel.org>
References: <20220914083500.5118-1-will@kernel.org>
MIME-Version: 1.0
Cc: Marc Zyngier <maz@kernel.org>, kernel-team@android.com, kvm@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 Chao Peng <chao.p.peng@linux.intel.com>, Will Deacon <will@kernel.org>,
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

In preparation for introducing VM and vCPU state at EL2, rename the
existing 'struct host_kvm' and its singleton 'host_kvm' instance to
'host_mmu' so as to avoid confusion between the structure tracking the
host stage-2 MMU state and the host instance of a 'struct kvm' for a
protected guest.

Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  6 +--
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 46 +++++++++----------
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
index 3bea816296dc..0a6d3e7f2a43 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -44,13 +44,13 @@ static inline enum pkvm_page_state pkvm_getstate(enum kvm_pgtable_prot prot)
 	return prot & PKVM_PAGE_STATE_PROT_MASK;
 }
 
-struct host_kvm {
+struct host_mmu {
 	struct kvm_arch arch;
 	struct kvm_pgtable pgt;
 	struct kvm_pgtable_mm_ops mm_ops;
 	hyp_spinlock_t lock;
 };
-extern struct host_kvm host_kvm;
+extern struct host_mmu host_mmu;
 
 /* This corresponds to page-table locking order */
 enum pkvm_component_id {
@@ -76,7 +76,7 @@ void hyp_unpin_shared_mem(void *from, void *to);
 static __always_inline void __load_host_stage2(void)
 {
 	if (static_branch_likely(&kvm_protected_mode_initialized))
-		__load_stage2(&host_kvm.arch.mmu, &host_kvm.arch);
+		__load_stage2(&host_mmu.arch.mmu, &host_mmu.arch);
 	else
 		write_sysreg(0, vttbr_el2);
 }
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 1262dbae7f06..bec8306c2392 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -22,18 +22,18 @@
 #define KVM_HOST_S2_FLAGS (KVM_PGTABLE_S2_NOFWB | KVM_PGTABLE_S2_IDMAP)
 
 extern unsigned long hyp_nr_cpus;
-struct host_kvm host_kvm;
+struct host_mmu host_mmu;
 
 static struct hyp_pool host_s2_pool;
 
 static void host_lock_component(void)
 {
-	hyp_spin_lock(&host_kvm.lock);
+	hyp_spin_lock(&host_mmu.lock);
 }
 
 static void host_unlock_component(void)
 {
-	hyp_spin_unlock(&host_kvm.lock);
+	hyp_spin_unlock(&host_mmu.lock);
 }
 
 static void hyp_lock_component(void)
@@ -88,7 +88,7 @@ static int prepare_s2_pool(void *pgt_pool_base)
 	if (ret)
 		return ret;
 
-	host_kvm.mm_ops = (struct kvm_pgtable_mm_ops) {
+	host_mmu.mm_ops = (struct kvm_pgtable_mm_ops) {
 		.zalloc_pages_exact = host_s2_zalloc_pages_exact,
 		.zalloc_page = host_s2_zalloc_page,
 		.phys_to_virt = hyp_phys_to_virt,
@@ -109,7 +109,7 @@ static void prepare_host_vtcr(void)
 	parange = kvm_get_parange(id_aa64mmfr0_el1_sys_val);
 	phys_shift = id_aa64mmfr0_parange_to_phys_shift(parange);
 
-	host_kvm.arch.vtcr = kvm_get_vtcr(id_aa64mmfr0_el1_sys_val,
+	host_mmu.arch.vtcr = kvm_get_vtcr(id_aa64mmfr0_el1_sys_val,
 					  id_aa64mmfr1_el1_sys_val, phys_shift);
 }
 
@@ -117,25 +117,25 @@ static bool host_stage2_force_pte_cb(u64 addr, u64 end, enum kvm_pgtable_prot pr
 
 int kvm_host_prepare_stage2(void *pgt_pool_base)
 {
-	struct kvm_s2_mmu *mmu = &host_kvm.arch.mmu;
+	struct kvm_s2_mmu *mmu = &host_mmu.arch.mmu;
 	int ret;
 
 	prepare_host_vtcr();
-	hyp_spin_lock_init(&host_kvm.lock);
-	mmu->arch = &host_kvm.arch;
+	hyp_spin_lock_init(&host_mmu.lock);
+	mmu->arch = &host_mmu.arch;
 
 	ret = prepare_s2_pool(pgt_pool_base);
 	if (ret)
 		return ret;
 
-	ret = __kvm_pgtable_stage2_init(&host_kvm.pgt, mmu,
-					&host_kvm.mm_ops, KVM_HOST_S2_FLAGS,
+	ret = __kvm_pgtable_stage2_init(&host_mmu.pgt, mmu,
+					&host_mmu.mm_ops, KVM_HOST_S2_FLAGS,
 					host_stage2_force_pte_cb);
 	if (ret)
 		return ret;
 
-	mmu->pgd_phys = __hyp_pa(host_kvm.pgt.pgd);
-	mmu->pgt = &host_kvm.pgt;
+	mmu->pgd_phys = __hyp_pa(host_mmu.pgt.pgd);
+	mmu->pgt = &host_mmu.pgt;
 	atomic64_set(&mmu->vmid.id, 0);
 
 	return 0;
@@ -143,19 +143,19 @@ int kvm_host_prepare_stage2(void *pgt_pool_base)
 
 int __pkvm_prot_finalize(void)
 {
-	struct kvm_s2_mmu *mmu = &host_kvm.arch.mmu;
+	struct kvm_s2_mmu *mmu = &host_mmu.arch.mmu;
 	struct kvm_nvhe_init_params *params = this_cpu_ptr(&kvm_init_params);
 
 	if (params->hcr_el2 & HCR_VM)
 		return -EPERM;
 
 	params->vttbr = kvm_get_vttbr(mmu);
-	params->vtcr = host_kvm.arch.vtcr;
+	params->vtcr = host_mmu.arch.vtcr;
 	params->hcr_el2 |= HCR_VM;
 	kvm_flush_dcache_to_poc(params, sizeof(*params));
 
 	write_sysreg(params->hcr_el2, hcr_el2);
-	__load_stage2(&host_kvm.arch.mmu, &host_kvm.arch);
+	__load_stage2(&host_mmu.arch.mmu, &host_mmu.arch);
 
 	/*
 	 * Make sure to have an ISB before the TLB maintenance below but only
@@ -173,7 +173,7 @@ int __pkvm_prot_finalize(void)
 
 static int host_stage2_unmap_dev_all(void)
 {
-	struct kvm_pgtable *pgt = &host_kvm.pgt;
+	struct kvm_pgtable *pgt = &host_mmu.pgt;
 	struct memblock_region *reg;
 	u64 addr = 0;
 	int i, ret;
@@ -258,7 +258,7 @@ static bool range_is_memory(u64 start, u64 end)
 static inline int __host_stage2_idmap(u64 start, u64 end,
 				      enum kvm_pgtable_prot prot)
 {
-	return kvm_pgtable_stage2_map(&host_kvm.pgt, start, end - start, start,
+	return kvm_pgtable_stage2_map(&host_mmu.pgt, start, end - start, start,
 				      prot, &host_s2_pool);
 }
 
@@ -271,7 +271,7 @@ static inline int __host_stage2_idmap(u64 start, u64 end,
 #define host_stage2_try(fn, ...)					\
 	({								\
 		int __ret;						\
-		hyp_assert_lock_held(&host_kvm.lock);			\
+		hyp_assert_lock_held(&host_mmu.lock);			\
 		__ret = fn(__VA_ARGS__);				\
 		if (__ret == -ENOMEM) {					\
 			__ret = host_stage2_unmap_dev_all();		\
@@ -294,8 +294,8 @@ static int host_stage2_adjust_range(u64 addr, struct kvm_mem_range *range)
 	u32 level;
 	int ret;
 
-	hyp_assert_lock_held(&host_kvm.lock);
-	ret = kvm_pgtable_get_leaf(&host_kvm.pgt, addr, &pte, &level);
+	hyp_assert_lock_held(&host_mmu.lock);
+	ret = kvm_pgtable_get_leaf(&host_mmu.pgt, addr, &pte, &level);
 	if (ret)
 		return ret;
 
@@ -327,7 +327,7 @@ int host_stage2_idmap_locked(phys_addr_t addr, u64 size,
 
 int host_stage2_set_owner_locked(phys_addr_t addr, u64 size, u8 owner_id)
 {
-	return host_stage2_try(kvm_pgtable_stage2_set_owner, &host_kvm.pgt,
+	return host_stage2_try(kvm_pgtable_stage2_set_owner, &host_mmu.pgt,
 			       addr, size, &host_s2_pool, owner_id);
 }
 
@@ -468,8 +468,8 @@ static int __host_check_page_state_range(u64 addr, u64 size,
 		.get_page_state	= host_get_page_state,
 	};
 
-	hyp_assert_lock_held(&host_kvm.lock);
-	return check_page_state_range(&host_kvm.pgt, addr, size, &d);
+	hyp_assert_lock_held(&host_mmu.lock);
+	return check_page_state_range(&host_mmu.pgt, addr, size, &d);
 }
 
 static int __host_set_page_state_range(u64 addr, u64 size,
-- 
2.37.2.789.g6183377224-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
