Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7B37F46218E
	for <lists+kvmarm@lfdr.de>; Mon, 29 Nov 2021 21:07:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2B8AD4B195;
	Mon, 29 Nov 2021 15:07:03 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, T_DKIM_INVALID=0.01]
	autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UaChQaXouSBI; Mon, 29 Nov 2021 15:07:01 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E18C64B1DB;
	Mon, 29 Nov 2021 15:06:57 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E77FB4B173
 for <kvmarm@lists.cs.columbia.edu>; Mon, 29 Nov 2021 15:06:56 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Kps5B7HmTbzi for <kvmarm@lists.cs.columbia.edu>;
 Mon, 29 Nov 2021 15:06:55 -0500 (EST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 03E014B10E
 for <kvmarm@lists.cs.columbia.edu>; Mon, 29 Nov 2021 15:06:55 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id BD085B815D4;
 Mon, 29 Nov 2021 20:06:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54438C53FAD;
 Mon, 29 Nov 2021 20:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638216413;
 bh=TdVLgnojYlVMKndPn3E1EWu7ajgwz9M5a0Jdi+5Uhro=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ehRNwG8EPSQfVYvzi48WUD68iKqa4AZJEAa3lV7VnC4+ssTT2lpgagcdLdaN9Qr0i
 Wt+FID92aRVEdPzUE2CQmrkU0y4CZc7fs0IaZ5UCtRasg6wCauYb/UtzxMYzLvgAnY
 SMO8+M3NA3UHZspAK2dEPNqJMRm/BS179j79q6EoC0EuAHc3gMX9azczP69frfnIRm
 wH+fQkFPB+F7JmwQCMjGkGfPUWVymKz0Soxo/hCG1L1JXXHd3h50jL8t3YOk3fFV1+
 M/Zygp5QtVmp/DZR093cfp3XoOB6wxMstpwp0AiL85QDVzP/SwecRB+LBCzE/nQkZL
 rT/7EbwWdhUFg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1mrmr0-008gvR-8D; Mon, 29 Nov 2021 20:02:22 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: [PATCH v5 40/69] KVM: arm64: nv: Handle shadow stage 2 page faults
Date: Mon, 29 Nov 2021 20:01:21 +0000
Message-Id: <20211129200150.351436-41-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211129200150.351436-1-maz@kernel.org>
References: <20211129200150.351436-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, andre.przywara@arm.com,
 christoffer.dall@arm.com, jintack@cs.columbia.edu, haibo.xu@linaro.org,
 gankulkarni@os.amperecomputing.com, james.morse@arm.com,
 suzuki.poulose@arm.com, alexandru.elisei@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, Andre Przywara <andre.przywara@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
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

If we are faulting on a shadow stage 2 translation, we first walk the
guest hypervisor's stage 2 page table to see if it has a mapping. If
not, we inject a stage 2 page fault to the virtual EL2. Otherwise, we
create a mapping in the shadow stage 2 page table.

Note that we have to deal with two IPAs when we got a shadow stage 2
page fault. One is the address we faulted on, and is in the L2 guest
phys space. The other is from the guest stage-2 page table walk, and is
in the L1 guest phys space.  To differentiate them, we rename variables
so that fault_ipa is used for the former and ipa is used for the latter.

Co-developed-by: Christoffer Dall <christoffer.dall@linaro.org>
Co-developed-by: Jintack Lim <jintack.lim@linaro.org>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Jintack Lim <jintack.lim@linaro.org>
[maz: rewrote this multiple times...]
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/kvm_emulate.h |   6 ++
 arch/arm64/include/asm/kvm_nested.h  |  18 +++++
 arch/arm64/kvm/mmu.c                 | 102 +++++++++++++++++++++++----
 arch/arm64/kvm/nested.c              |  48 +++++++++++++
 4 files changed, 159 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 105fb0d4a366..94d8814b7c8b 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -602,4 +602,10 @@ static inline bool vcpu_has_feature(struct kvm_vcpu *vcpu, int feature)
 	return test_bit(feature, vcpu->arch.features);
 }
 
+static inline bool kvm_is_shadow_s2_fault(struct kvm_vcpu *vcpu)
+{
+	return (vcpu->arch.hw_mmu != &vcpu->kvm->arch.mmu &&
+		vcpu->arch.hw_mmu->nested_stage2_enabled);
+}
+
 #endif /* __ARM64_KVM_EMULATE_H__ */
diff --git a/arch/arm64/include/asm/kvm_nested.h b/arch/arm64/include/asm/kvm_nested.h
index b784d7891851..4f93a5dab183 100644
--- a/arch/arm64/include/asm/kvm_nested.h
+++ b/arch/arm64/include/asm/kvm_nested.h
@@ -78,9 +78,27 @@ struct kvm_s2_trans {
 	u64 upper_attr;
 };
 
+static inline phys_addr_t kvm_s2_trans_output(struct kvm_s2_trans *trans)
+{
+	return trans->output;
+}
+
+static inline unsigned long kvm_s2_trans_size(struct kvm_s2_trans *trans)
+{
+	return trans->block_size;
+}
+
+static inline u32 kvm_s2_trans_esr(struct kvm_s2_trans *trans)
+{
+	return trans->esr;
+}
+
 extern int kvm_walk_nested_s2(struct kvm_vcpu *vcpu, phys_addr_t gipa,
 			      struct kvm_s2_trans *result);
 
+extern int kvm_s2_handle_perm_fault(struct kvm_vcpu *vcpu,
+				    struct kvm_s2_trans *trans);
+extern int kvm_inject_s2_fault(struct kvm_vcpu *vcpu, u64 esr_el2);
 int handle_wfx_nested(struct kvm_vcpu *vcpu, bool is_wfe);
 extern bool __forward_traps(struct kvm_vcpu *vcpu, unsigned int reg,
 			    u64 control_bit);
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index ab1653b8e601..fc3613d3f503 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -845,7 +845,7 @@ static bool fault_supports_stage2_huge_mapping(struct kvm_memory_slot *memslot,
 static unsigned long
 transparent_hugepage_adjust(struct kvm *kvm, struct kvm_memory_slot *memslot,
 			    unsigned long hva, kvm_pfn_t *pfnp,
-			    phys_addr_t *ipap)
+			    phys_addr_t *ipap, phys_addr_t *fault_ipap)
 {
 	kvm_pfn_t pfn = *pfnp;
 
@@ -874,6 +874,7 @@ transparent_hugepage_adjust(struct kvm *kvm, struct kvm_memory_slot *memslot,
 		 * to PG_head and switch the pfn from a tail page to the head
 		 * page accordingly.
 		 */
+		*fault_ipap &= PMD_MASK;
 		*ipap &= PMD_MASK;
 		kvm_release_pfn_clean(pfn);
 		pfn &= ~(PTRS_PER_PMD - 1);
@@ -956,15 +957,17 @@ static int sanitise_mte_tags(struct kvm *kvm, kvm_pfn_t pfn,
 }
 
 static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
-			  struct kvm_memory_slot *memslot, unsigned long hva,
-			  unsigned long fault_status)
+			  struct kvm_s2_trans *nested,
+			  struct kvm_memory_slot *memslot,
+			  unsigned long hva, unsigned long fault_status)
 {
 	int ret = 0;
-	bool write_fault, writable, force_pte = false;
+	bool write_fault, writable;
 	bool exec_fault;
 	bool device = false;
 	bool shared;
 	unsigned long mmu_seq;
+	phys_addr_t ipa = fault_ipa;
 	struct kvm *kvm = vcpu->kvm;
 	struct kvm_mmu_memory_cache *memcache = &vcpu->arch.mmu_page_cache;
 	struct vm_area_struct *vma;
@@ -976,6 +979,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	unsigned long vma_pagesize, fault_granule;
 	enum kvm_pgtable_prot prot = KVM_PGTABLE_PROT_R;
 	struct kvm_pgtable *pgt;
+	unsigned long max_map_size = PUD_SIZE;
 
 	fault_granule = 1UL << ARM64_HW_PGTABLE_LEVEL_SHIFT(fault_level);
 	write_fault = kvm_is_write_fault(vcpu);
@@ -1004,7 +1008,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	 * memslots.
 	 */
 	if (logging_active) {
-		force_pte = true;
+		max_map_size = vma_pagesize = PAGE_SIZE;
 		vma_shift = PAGE_SHIFT;
 	} else {
 		vma_shift = get_vma_page_shift(vma, hva);
@@ -1028,7 +1032,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		fallthrough;
 	case CONT_PTE_SHIFT:
 		vma_shift = PAGE_SHIFT;
-		force_pte = true;
+		max_map_size = PAGE_SIZE;
 		fallthrough;
 	case PAGE_SHIFT:
 		break;
@@ -1037,10 +1041,25 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	}
 
 	vma_pagesize = 1UL << vma_shift;
+
+	if (kvm_is_shadow_s2_fault(vcpu)) {
+		ipa = kvm_s2_trans_output(nested);
+
+		/*
+		 * If we're about to create a shadow stage 2 entry, then we
+		 * can only create a block mapping if the guest stage 2 page
+		 * table uses at least as big a mapping.
+		 */
+		max_map_size = min(kvm_s2_trans_size(nested), max_map_size);
+	}
+
+	vma_pagesize = min(vma_pagesize, max_map_size);
+
 	if (vma_pagesize == PMD_SIZE || vma_pagesize == PUD_SIZE)
 		fault_ipa &= ~(vma_pagesize - 1);
 
-	gfn = fault_ipa >> PAGE_SHIFT;
+	gfn = ipa >> PAGE_SHIFT;
+
 	mmap_read_unlock(current->mm);
 
 	/*
@@ -1113,12 +1132,14 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	 * If we are not forced to use page mapping, check if we are
 	 * backed by a THP and thus use block mapping if possible.
 	 */
-	if (vma_pagesize == PAGE_SIZE && !(force_pte || device)) {
+	if (vma_pagesize == PAGE_SIZE &&
+	    !(max_map_size == PAGE_SIZE || device)) {
 		if (fault_status == FSC_PERM && fault_granule > PAGE_SIZE)
 			vma_pagesize = fault_granule;
 		else
 			vma_pagesize = transparent_hugepage_adjust(kvm, memslot,
 								   hva, &pfn,
+								   &ipa,
 								   &fault_ipa);
 	}
 
@@ -1202,8 +1223,10 @@ static void handle_access_fault(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa)
 int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
 {
 	unsigned long fault_status;
-	phys_addr_t fault_ipa;
+	phys_addr_t fault_ipa; /* The address we faulted on */
+	phys_addr_t ipa; /* Always the IPA in the L1 guest phys space */
 	struct kvm_memory_slot *memslot;
+	struct kvm_s2_trans nested_trans;
 	unsigned long hva;
 	bool is_iabt, write_fault, writable;
 	gfn_t gfn;
@@ -1211,7 +1234,7 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
 
 	fault_status = kvm_vcpu_trap_get_fault_type(vcpu);
 
-	fault_ipa = kvm_vcpu_get_fault_ipa(vcpu);
+	ipa = fault_ipa = kvm_vcpu_get_fault_ipa(vcpu);
 	is_iabt = kvm_vcpu_trap_is_iabt(vcpu);
 
 	/* Synchronous External Abort? */
@@ -1232,6 +1255,12 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
 	/* Check the stage-2 fault is trans. fault or write fault */
 	if (fault_status != FSC_FAULT && fault_status != FSC_PERM &&
 	    fault_status != FSC_ACCESS) {
+		/*
+		 * We must never see an address size fault on shadow stage 2
+		 * page table walk, because we would have injected an addr
+		 * size fault when we walked the nested s2 page and not
+		 * create the shadow entry.
+		 */
 		kvm_err("Unsupported FSC: EC=%#x xFSC=%#lx ESR_EL2=%#lx\n",
 			kvm_vcpu_trap_get_class(vcpu),
 			(unsigned long)kvm_vcpu_trap_get_fault(vcpu),
@@ -1241,7 +1270,49 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
 
 	idx = srcu_read_lock(&vcpu->kvm->srcu);
 
-	gfn = fault_ipa >> PAGE_SHIFT;
+	/*
+	 * We may have faulted on a shadow stage 2 page table if we are
+	 * running a nested guest.  In this case, we have to resolve the L2
+	 * IPA to the L1 IPA first, before knowing what kind of memory should
+	 * back the L1 IPA.
+	 *
+	 * If the shadow stage 2 page table walk faults, then we simply inject
+	 * this to the guest and carry on.
+	 */
+	if (kvm_is_shadow_s2_fault(vcpu)) {
+		u32 esr;
+
+		ret = kvm_walk_nested_s2(vcpu, fault_ipa, &nested_trans);
+		esr = kvm_s2_trans_esr(&nested_trans);
+		if (esr)
+			kvm_inject_s2_fault(vcpu, esr);
+		if (ret)
+			goto out_unlock;
+
+		ret = kvm_s2_handle_perm_fault(vcpu, &nested_trans);
+		esr = kvm_s2_trans_esr(&nested_trans);
+		if (esr)
+			kvm_inject_s2_fault(vcpu, esr);
+		if (ret)
+			goto out_unlock;
+
+		ipa = kvm_s2_trans_output(&nested_trans);
+	} else {
+		nested_trans = (struct kvm_s2_trans) {
+			/*
+			 * Default to RWX so that we don't filter
+			 * anything while evaluating the permissions.
+			 */
+			.writable	= true,
+			.readable	= true,
+			.upper_attr	= 0,
+			.output		= ipa,
+			.level		= kvm_vcpu_trap_get_fault_level(vcpu),
+			.esr		= kvm_vcpu_get_esr(vcpu),
+		};
+	}
+
+	gfn = ipa >> PAGE_SHIFT;
 	memslot = gfn_to_memslot(vcpu->kvm, gfn);
 	hva = gfn_to_hva_memslot_prot(memslot, gfn, &writable);
 	write_fault = kvm_is_write_fault(vcpu);
@@ -1285,13 +1356,13 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
 		 * faulting VA. This is always 12 bits, irrespective
 		 * of the page size.
 		 */
-		fault_ipa |= kvm_vcpu_get_hfar(vcpu) & ((1 << 12) - 1);
-		ret = io_mem_abort(vcpu, fault_ipa);
+		ipa |= kvm_vcpu_get_hfar(vcpu) & ((1 << 12) - 1);
+		ret = io_mem_abort(vcpu, ipa);
 		goto out_unlock;
 	}
 
 	/* Userspace should not be able to register out-of-bounds IPAs */
-	VM_BUG_ON(fault_ipa >= kvm_phys_size(vcpu->kvm));
+	VM_BUG_ON(ipa >= kvm_phys_size(vcpu->kvm));
 
 	if (fault_status == FSC_ACCESS) {
 		handle_access_fault(vcpu, fault_ipa);
@@ -1299,7 +1370,8 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
 		goto out_unlock;
 	}
 
-	ret = user_mem_abort(vcpu, fault_ipa, memslot, hva, fault_status);
+	ret = user_mem_abort(vcpu, fault_ipa, &nested_trans,
+			     memslot, hva, fault_status);
 	if (ret == 0)
 		ret = 1;
 out:
diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index 01c5ee5f3545..c34e96955e04 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -120,6 +120,15 @@ static u32 compute_fsc(int level, u32 fsc)
 	return fsc | (level & 0x3);
 }
 
+static int esr_s2_fault(struct kvm_vcpu *vcpu, int level, u32 fsc)
+{
+	u32 esr;
+
+	esr = kvm_vcpu_get_esr(vcpu) & ~ESR_ELx_FSC;
+	esr |= compute_fsc(level, fsc);
+	return esr;
+}
+
 static int check_base_s2_limits(struct s2_walk_info *wi,
 				int level, int input_size, int stride)
 {
@@ -469,6 +478,45 @@ void kvm_vcpu_put_hw_mmu(struct kvm_vcpu *vcpu)
 	}
 }
 
+/*
+ * Returns non-zero if permission fault is handled by injecting it to the next
+ * level hypervisor.
+ */
+int kvm_s2_handle_perm_fault(struct kvm_vcpu *vcpu, struct kvm_s2_trans *trans)
+{
+	unsigned long fault_status = kvm_vcpu_trap_get_fault_type(vcpu);
+	bool forward_fault = false;
+
+	trans->esr = 0;
+
+	if (fault_status != FSC_PERM)
+		return 0;
+
+	if (kvm_vcpu_trap_is_iabt(vcpu)) {
+		forward_fault = (trans->upper_attr & BIT(54));
+	} else {
+		bool write_fault = kvm_is_write_fault(vcpu);
+
+		forward_fault = ((write_fault && !trans->writable) ||
+				 (!write_fault && !trans->readable));
+	}
+
+	if (forward_fault) {
+		trans->esr = esr_s2_fault(vcpu, trans->level, ESR_ELx_FSC_PERM);
+		return 1;
+	}
+
+	return 0;
+}
+
+int kvm_inject_s2_fault(struct kvm_vcpu *vcpu, u64 esr_el2)
+{
+	vcpu_write_sys_reg(vcpu, vcpu->arch.fault.far_el2, FAR_EL2);
+	vcpu_write_sys_reg(vcpu, vcpu->arch.fault.hpfar_el2, HPFAR_EL2);
+
+	return kvm_inject_nested_sync(vcpu, esr_el2);
+}
+
 /*
  * Inject wfx to the virtual EL2 if this is not from the virtual EL2 and
  * the virtual HCR_EL2.TWX is set. Otherwise, let the host hypervisor
-- 
2.30.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
