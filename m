Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9269F3ACC2E
	for <lists+kvmarm@lfdr.de>; Fri, 18 Jun 2021 15:28:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4560B4B0DA;
	Fri, 18 Jun 2021 09:28:53 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KE56gh0xC619; Fri, 18 Jun 2021 09:28:53 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BD9F64B0BD;
	Fri, 18 Jun 2021 09:28:51 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id AB58B4A523
 for <kvmarm@lists.cs.columbia.edu>; Fri, 18 Jun 2021 09:28:49 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NAM0UhEUHhsU for <kvmarm@lists.cs.columbia.edu>;
 Fri, 18 Jun 2021 09:28:47 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DBEFE49E8C
 for <kvmarm@lists.cs.columbia.edu>; Fri, 18 Jun 2021 09:28:46 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84C27147A;
 Fri, 18 Jun 2021 06:28:46 -0700 (PDT)
Received: from e112269-lin.arm.com (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D999E3F719;
 Fri, 18 Jun 2021 06:28:43 -0700 (PDT)
From: Steven Price <steven.price@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>
Subject: [PATCH v16 3/7] KVM: arm64: Introduce MTE VM feature
Date: Fri, 18 Jun 2021 14:28:22 +0100
Message-Id: <20210618132826.54670-4-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210618132826.54670-1-steven.price@arm.com>
References: <20210618132826.54670-1-steven.price@arm.com>
MIME-Version: 1.0
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 Dave Martin <Dave.Martin@arm.com>, Juan Quintela <quintela@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, linux-kernel@vger.kernel.org,
 Steven Price <steven.price@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

Add a new VM feature 'KVM_ARM_CAP_MTE' which enables memory tagging
for a VM. This will expose the feature to the guest and automatically
tag memory pages touched by the VM as PG_mte_tagged (and clear the tag
storage) to ensure that the guest cannot see stale tags, and so that
the tags are correctly saved/restored across swap.

Actually exposing the new capability to user space happens in a later
patch.

Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/arm64/include/asm/kvm_emulate.h |  3 ++
 arch/arm64/include/asm/kvm_host.h    |  3 ++
 arch/arm64/kvm/hyp/exception.c       |  3 +-
 arch/arm64/kvm/mmu.c                 | 62 +++++++++++++++++++++++++++-
 arch/arm64/kvm/sys_regs.c            |  7 ++++
 include/uapi/linux/kvm.h             |  1 +
 6 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index f612c090f2e4..6bf776c2399c 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -84,6 +84,9 @@ static inline void vcpu_reset_hcr(struct kvm_vcpu *vcpu)
 	if (cpus_have_const_cap(ARM64_MISMATCHED_CACHE_TYPE) ||
 	    vcpu_el1_is_32bit(vcpu))
 		vcpu->arch.hcr_el2 |= HCR_TID2;
+
+	if (kvm_has_mte(vcpu->kvm))
+		vcpu->arch.hcr_el2 |= HCR_ATA;
 }
 
 static inline unsigned long *vcpu_hcr(struct kvm_vcpu *vcpu)
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 7cd7d5c8c4bc..afaa5333f0e4 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -132,6 +132,8 @@ struct kvm_arch {
 
 	u8 pfr0_csv2;
 	u8 pfr0_csv3;
+	/* Memory Tagging Extension enabled for the guest */
+	bool mte_enabled;
 };
 
 struct kvm_vcpu_fault_info {
@@ -769,6 +771,7 @@ bool kvm_arm_vcpu_is_finalized(struct kvm_vcpu *vcpu);
 #define kvm_arm_vcpu_sve_finalized(vcpu) \
 	((vcpu)->arch.flags & KVM_ARM64_VCPU_SVE_FINALIZED)
 
+#define kvm_has_mte(kvm) (system_supports_mte() && (kvm)->arch.mte_enabled)
 #define kvm_vcpu_has_pmu(vcpu)					\
 	(test_bit(KVM_ARM_VCPU_PMU_V3, (vcpu)->arch.features))
 
diff --git a/arch/arm64/kvm/hyp/exception.c b/arch/arm64/kvm/hyp/exception.c
index 73629094f903..56426565600c 100644
--- a/arch/arm64/kvm/hyp/exception.c
+++ b/arch/arm64/kvm/hyp/exception.c
@@ -112,7 +112,8 @@ static void enter_exception64(struct kvm_vcpu *vcpu, unsigned long target_mode,
 	new |= (old & PSR_C_BIT);
 	new |= (old & PSR_V_BIT);
 
-	// TODO: TCO (if/when ARMv8.5-MemTag is exposed to guests)
+	if (kvm_has_mte(vcpu->kvm))
+		new |= PSR_TCO_BIT;
 
 	new |= (old & PSR_DIT_BIT);
 
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index c5d1f3c87dbd..f5305b7561ad 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -822,6 +822,45 @@ transparent_hugepage_adjust(struct kvm_memory_slot *memslot,
 	return PAGE_SIZE;
 }
 
+/*
+ * The page will be mapped in stage 2 as Normal Cacheable, so the VM will be
+ * able to see the page's tags and therefore they must be initialised first. If
+ * PG_mte_tagged is set, tags have already been initialised.
+ *
+ * The race in the test/set of the PG_mte_tagged flag is handled by:
+ * - preventing VM_SHARED mappings in a memslot with MTE preventing two VMs
+ *   racing to santise the same page
+ * - mmap_lock protects between a VM faulting a page in and the VMM performing
+ *   an mprotect() to add VM_MTE
+ */
+static int sanitise_mte_tags(struct kvm *kvm, kvm_pfn_t pfn,
+			     unsigned long size)
+{
+	unsigned long i, nr_pages = size >> PAGE_SHIFT;
+	struct page *page;
+
+	if (!kvm_has_mte(kvm))
+		return 0;
+
+	/*
+	 * pfn_to_online_page() is used to reject ZONE_DEVICE pages
+	 * that may not support tags.
+	 */
+	page = pfn_to_online_page(pfn);
+
+	if (!page)
+		return -EFAULT;
+
+	for (i = 0; i < nr_pages; i++, page++) {
+		if (!test_bit(PG_mte_tagged, &page->flags)) {
+			mte_clear_page_tags(page_address(page));
+			set_bit(PG_mte_tagged, &page->flags);
+		}
+	}
+
+	return 0;
+}
+
 static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 			  struct kvm_memory_slot *memslot, unsigned long hva,
 			  unsigned long fault_status)
@@ -971,8 +1010,16 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	if (writable)
 		prot |= KVM_PGTABLE_PROT_W;
 
-	if (fault_status != FSC_PERM && !device)
+	if (fault_status != FSC_PERM && !device) {
+		/* Check the VMM hasn't introduced a new VM_SHARED VMA */
+		if (kvm_has_mte(kvm) && vma->vm_flags & VM_SHARED)
+			return -EINVAL;
+		ret = sanitise_mte_tags(kvm, pfn, vma_pagesize);
+		if (ret)
+			goto out_unlock;
+
 		clean_dcache_guest_page(pfn, vma_pagesize);
+	}
 
 	if (exec_fault) {
 		prot |= KVM_PGTABLE_PROT_X;
@@ -1168,12 +1215,17 @@ bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
 bool kvm_set_spte_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
 {
 	kvm_pfn_t pfn = pte_pfn(range->pte);
+	int ret;
 
 	if (!kvm->arch.mmu.pgt)
 		return 0;
 
 	WARN_ON(range->end - range->start != 1);
 
+	ret = sanitise_mte_tags(kvm, pfn, PAGE_SIZE);
+	if (ret)
+		return false;
+
 	/*
 	 * We've moved a page around, probably through CoW, so let's treat it
 	 * just like a translation fault and clean the cache to the PoC.
@@ -1381,6 +1433,14 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 		if (!vma)
 			break;
 
+		/*
+		 * VM_SHARED mappings are not allowed with MTE to avoid races
+		 * when updating the PG_mte_tagged page flag, see
+		 * sanitise_mte_tags for more details.
+		 */
+		if (kvm_has_mte(kvm) && vma->vm_flags & VM_SHARED)
+			return -EINVAL;
+
 		/*
 		 * Take the intersection of this VMA with the memory region
 		 */
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 76ea2800c33e..4a98902eaf1a 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1047,6 +1047,13 @@ static u64 read_id_reg(const struct kvm_vcpu *vcpu,
 		break;
 	case SYS_ID_AA64PFR1_EL1:
 		val &= ~FEATURE(ID_AA64PFR1_MTE);
+		if (kvm_has_mte(vcpu->kvm)) {
+			u64 pfr, mte;
+
+			pfr = read_sanitised_ftr_reg(SYS_ID_AA64PFR1_EL1);
+			mte = cpuid_feature_extract_unsigned_field(pfr, ID_AA64PFR1_MTE_SHIFT);
+			val |= FIELD_PREP(FEATURE(ID_AA64PFR1_MTE), mte);
+		}
 		break;
 	case SYS_ID_AA64ISAR1_EL1:
 		if (!vcpu_has_ptrauth(vcpu))
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 3fd9a7e9d90c..8c95ba0fadda 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1082,6 +1082,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_SGX_ATTRIBUTE 196
 #define KVM_CAP_VM_COPY_ENC_CONTEXT_FROM 197
 #define KVM_CAP_PTP_KVM 198
+#define KVM_CAP_ARM_MTE 199
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
