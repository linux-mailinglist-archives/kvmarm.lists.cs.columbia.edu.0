Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C14933CA25D
	for <lists+kvmarm@lfdr.de>; Thu, 15 Jul 2021 18:32:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 695CE4B09F;
	Thu, 15 Jul 2021 12:32:25 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4-iLrrkQYYGM; Thu, 15 Jul 2021 12:32:24 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CCB064B088;
	Thu, 15 Jul 2021 12:32:21 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 377194B08B
 for <kvmarm@lists.cs.columbia.edu>; Thu, 15 Jul 2021 12:32:20 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D1OmEKP-f2Vy for <kvmarm@lists.cs.columbia.edu>;
 Thu, 15 Jul 2021 12:32:19 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 109A54B088
 for <kvmarm@lists.cs.columbia.edu>; Thu, 15 Jul 2021 12:32:19 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AC41B613F9;
 Thu, 15 Jul 2021 16:32:17 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1m44HY-00DYjr-32; Thu, 15 Jul 2021 17:32:16 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/16] KVM: arm64: Add MMIO checking infrastructure
Date: Thu, 15 Jul 2021 17:31:47 +0100
Message-Id: <20210715163159.1480168-5-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210715163159.1480168-1-maz@kernel.org>
References: <20210715163159.1480168-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, will@kernel.org, qperret@google.com,
 dbrazdil@google.com, vatsa@codeaurora.org, sdonthineni@nvidia.com,
 james.morse@arm.com, suzuki.poulose@arm.com, alexandru.elisei@arm.com,
 kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, Srivatsa Vaddagiri <vatsa@codeaurora.org>,
 Shanker R Donthineni <sdonthineni@nvidia.com>, will@kernel.org
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

Introduce the infrastructure required to identify an IPA region
that is expected to be used as an MMIO window.

This include mapping, unmapping and checking the regions. Nothing
calls into it yet, so no expected functional change.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h |   2 +
 arch/arm64/include/asm/kvm_mmu.h  |   5 ++
 arch/arm64/kvm/mmu.c              | 115 ++++++++++++++++++++++++++++++
 3 files changed, 122 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 4add6c27251f..914c1b7bb3ad 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -125,6 +125,8 @@ struct kvm_arch {
 #define KVM_ARCH_FLAG_RETURN_NISV_IO_ABORT_TO_USER	0
 	/* Memory Tagging Extension enabled for the guest */
 #define KVM_ARCH_FLAG_MTE_ENABLED			1
+	/* Gues has bought into the MMIO guard extension */
+#define KVM_ARCH_FLAG_MMIO_GUARD			2
 	unsigned long flags;
 
 	/*
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index b52c5c4b9a3d..f6b8fc1671b3 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -170,6 +170,11 @@ phys_addr_t kvm_mmu_get_httbr(void);
 phys_addr_t kvm_get_idmap_vector(void);
 int kvm_mmu_init(u32 *hyp_va_bits);
 
+/* MMIO guard */
+bool kvm_install_ioguard_page(struct kvm_vcpu *vcpu, gpa_t ipa);
+bool kvm_remove_ioguard_page(struct kvm_vcpu *vcpu, gpa_t ipa);
+bool kvm_check_ioguard_page(struct kvm_vcpu *vcpu, gpa_t ipa);
+
 static inline void *__kvm_vector_slot2addr(void *base,
 					   enum arm64_hyp_spectre_vector slot)
 {
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 3155c9e778f0..638827c8842b 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1120,6 +1120,121 @@ static void handle_access_fault(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa)
 		kvm_set_pfn_accessed(pte_pfn(pte));
 }
 
+#define MMIO_NOTE	('M' << 24 | 'M' << 16 | 'I' << 8 | '0')
+
+bool kvm_install_ioguard_page(struct kvm_vcpu *vcpu, gpa_t ipa)
+{
+	struct kvm_mmu_memory_cache *memcache;
+	struct kvm_memory_slot *memslot;
+	int ret, idx;
+
+	if (!test_bit(KVM_ARCH_FLAG_MMIO_GUARD, &vcpu->kvm->arch.flags))
+		return false;
+
+	/* Must be page-aligned */
+	if (ipa & ~PAGE_MASK)
+		return false;
+
+	/*
+	 * The page cannot be in a memslot. At some point, this will
+	 * have to deal with device mappings though.
+	 */
+	idx = srcu_read_lock(&vcpu->kvm->srcu);
+	memslot = gfn_to_memslot(vcpu->kvm, ipa >> PAGE_SHIFT);
+	srcu_read_unlock(&vcpu->kvm->srcu, idx);
+
+	if (memslot)
+		return false;
+
+	/* Guest has direct access to the GICv2 virtual CPU interface */
+	if (irqchip_in_kernel(vcpu->kvm) &&
+	    vcpu->kvm->arch.vgic.vgic_model == KVM_DEV_TYPE_ARM_VGIC_V2 &&
+	    ipa == vcpu->kvm->arch.vgic.vgic_cpu_base)
+		return true;
+
+	memcache = &vcpu->arch.mmu_page_cache;
+	if (kvm_mmu_topup_memory_cache(memcache,
+				       kvm_mmu_cache_min_pages(vcpu->kvm)))
+		return false;
+
+	spin_lock(&vcpu->kvm->mmu_lock);
+	ret = kvm_pgtable_stage2_annotate(vcpu->arch.hw_mmu->pgt,
+					  ipa, PAGE_SIZE, memcache,
+					  MMIO_NOTE);
+	spin_unlock(&vcpu->kvm->mmu_lock);
+
+	return ret == 0;
+}
+
+struct s2_walk_data {
+	kvm_pte_t	pteval;
+	u32		level;
+};
+
+static int s2_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
+		     enum kvm_pgtable_walk_flags flag, void * const arg)
+{
+	struct s2_walk_data *data = arg;
+
+	data->level = level;
+	data->pteval = *ptep;
+	return 0;
+}
+
+/* Assumes mmu_lock taken */
+static bool __check_ioguard_page(struct kvm_vcpu *vcpu, gpa_t ipa)
+{
+	struct s2_walk_data data;
+	struct kvm_pgtable_walker walker = {
+		.cb             = s2_walker,
+		.flags          = KVM_PGTABLE_WALK_LEAF,
+		.arg            = &data,
+	};
+
+	kvm_pgtable_walk(vcpu->arch.hw_mmu->pgt, ALIGN_DOWN(ipa, PAGE_SIZE),
+			 PAGE_SIZE, &walker);
+
+	/* Must be a PAGE_SIZE mapping with our annotation */
+	return (BIT(ARM64_HW_PGTABLE_LEVEL_SHIFT(data.level)) == PAGE_SIZE &&
+		data.pteval == MMIO_NOTE);
+}
+
+bool kvm_remove_ioguard_page(struct kvm_vcpu *vcpu, gpa_t ipa)
+{
+	bool ret;
+
+	if (!test_bit(KVM_ARCH_FLAG_MMIO_GUARD, &vcpu->kvm->arch.flags))
+		return false;
+
+	/* Keep the PT locked across the two walks */
+	spin_lock(&vcpu->kvm->mmu_lock);
+
+	ret = __check_ioguard_page(vcpu, ipa);
+	if (ret)		/* Drop the annotation */
+		kvm_pgtable_stage2_unmap(vcpu->arch.hw_mmu->pgt,
+					 ALIGN_DOWN(ipa, PAGE_SIZE), PAGE_SIZE);
+
+	spin_unlock(&vcpu->kvm->mmu_lock);
+	return ret;
+}
+
+bool kvm_check_ioguard_page(struct kvm_vcpu *vcpu, gpa_t ipa)
+{
+	bool ret;
+
+	if (!test_bit(KVM_ARCH_FLAG_MMIO_GUARD, &vcpu->kvm->arch.flags))
+		return true;
+
+	spin_lock(&vcpu->kvm->mmu_lock);
+	ret = __check_ioguard_page(vcpu, ipa & PAGE_MASK);
+	spin_unlock(&vcpu->kvm->mmu_lock);
+
+	if (!ret)
+		kvm_inject_dabt(vcpu, kvm_vcpu_get_hfar(vcpu));
+
+	return ret;
+}
+
 /**
  * kvm_handle_guest_abort - handles all 2nd stage aborts
  * @vcpu:	the VCPU pointer
-- 
2.30.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
