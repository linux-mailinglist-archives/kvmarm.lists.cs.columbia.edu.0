Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E331A362449
	for <lists+kvmarm@lfdr.de>; Fri, 16 Apr 2021 17:43:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8F8E34B477;
	Fri, 16 Apr 2021 11:43:33 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3TGGYev3V+NA; Fri, 16 Apr 2021 11:43:33 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6522C4B470;
	Fri, 16 Apr 2021 11:43:32 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 05F5F4B403
 for <kvmarm@lists.cs.columbia.edu>; Fri, 16 Apr 2021 11:43:31 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MPAv3sNjCWEo for <kvmarm@lists.cs.columbia.edu>;
 Fri, 16 Apr 2021 11:43:29 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C0B0B4B43F
 for <kvmarm@lists.cs.columbia.edu>; Fri, 16 Apr 2021 11:43:29 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D07B1396;
 Fri, 16 Apr 2021 08:43:28 -0700 (PDT)
Received: from e112269-lin.arm.com (autoplooker.cambridge.arm.com
 [10.1.194.57])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8BD813F99C;
 Fri, 16 Apr 2021 08:43:25 -0700 (PDT)
From: Steven Price <steven.price@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>
Subject: [PATCH v11 2/6] arm64: kvm: Introduce MTE VM feature
Date: Fri, 16 Apr 2021 16:43:05 +0100
Message-Id: <20210416154309.22129-3-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210416154309.22129-1-steven.price@arm.com>
References: <20210416154309.22129-1-steven.price@arm.com>
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
 arch/arm64/include/asm/kvm_emulate.h |  3 +++
 arch/arm64/include/asm/kvm_host.h    |  3 +++
 arch/arm64/kvm/hyp/exception.c       |  3 ++-
 arch/arm64/kvm/mmu.c                 | 20 ++++++++++++++++++++
 arch/arm64/kvm/sys_regs.c            |  3 +++
 include/uapi/linux/kvm.h             |  1 +
 6 files changed, 32 insertions(+), 1 deletion(-)

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
index 3d10e6527f7d..1170ee137096 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -132,6 +132,8 @@ struct kvm_arch {
 
 	u8 pfr0_csv2;
 	u8 pfr0_csv3;
+	/* Memory Tagging Extension enabled for the guest */
+	bool mte_enabled;
 };
 
 struct kvm_vcpu_fault_info {
@@ -767,6 +769,7 @@ bool kvm_arm_vcpu_is_finalized(struct kvm_vcpu *vcpu);
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
index 77cb2d28f2a4..5f8e165ea053 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -879,6 +879,26 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	if (vma_pagesize == PAGE_SIZE && !force_pte)
 		vma_pagesize = transparent_hugepage_adjust(memslot, hva,
 							   &pfn, &fault_ipa);
+
+	if (fault_status != FSC_PERM && kvm_has_mte(kvm) && !device &&
+	    pfn_valid(pfn)) {
+		/*
+		 * VM will be able to see the page's tags, so we must ensure
+		 * they have been initialised. if PG_mte_tagged is set, tags
+		 * have already been initialised.
+		 */
+		unsigned long i, nr_pages = vma_pagesize >> PAGE_SHIFT;
+		struct page *page = pfn_to_online_page(pfn);
+
+		if (!page)
+			return -EFAULT;
+
+		for (i = 0; i < nr_pages; i++, page++) {
+			if (!test_and_set_bit(PG_mte_tagged, &page->flags))
+				mte_clear_page_tags(page_address(page));
+		}
+	}
+
 	if (writable)
 		prot |= KVM_PGTABLE_PROT_W;
 
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 4f2f1e3145de..18c87500a7a8 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1047,6 +1047,9 @@ static u64 read_id_reg(const struct kvm_vcpu *vcpu,
 		break;
 	case SYS_ID_AA64PFR1_EL1:
 		val &= ~FEATURE(ID_AA64PFR1_MTE);
+		if (kvm_has_mte(vcpu->kvm))
+			val |= FIELD_PREP(FEATURE(ID_AA64PFR1_MTE),
+					  ID_AA64PFR1_MTE);
 		break;
 	case SYS_ID_AA64ISAR1_EL1:
 		if (!vcpu_has_ptrauth(vcpu))
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index f6afee209620..6dc16c09a2d1 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1078,6 +1078,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_DIRTY_LOG_RING 192
 #define KVM_CAP_X86_BUS_LOCK_EXIT 193
 #define KVM_CAP_PPC_DAWR1 194
+#define KVM_CAP_ARM_MTE 195
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
