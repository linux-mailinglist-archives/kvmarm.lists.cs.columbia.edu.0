Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BF5833A9694
	for <lists+kvmarm@lfdr.de>; Wed, 16 Jun 2021 11:52:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4EA2C4B0CA;
	Wed, 16 Jun 2021 05:52:57 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yCGwtPM3fz3v; Wed, 16 Jun 2021 05:52:57 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D89214B0C8;
	Wed, 16 Jun 2021 05:52:53 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 054474B08F
 for <kvmarm@lists.cs.columbia.edu>; Wed, 16 Jun 2021 05:52:53 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FL-cb5Av0S-Y for <kvmarm@lists.cs.columbia.edu>;
 Wed, 16 Jun 2021 05:52:52 -0400 (EDT)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 63C0E4B0A1
 for <kvmarm@lists.cs.columbia.edu>; Wed, 16 Jun 2021 05:52:51 -0400 (EDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G4gQC1tFdz6ywY;
 Wed, 16 Jun 2021 17:49:39 +0800 (CST)
Received: from dggpemm500023.china.huawei.com (7.185.36.83) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 17:52:48 +0800
Received: from DESKTOP-TMVL5KK.china.huawei.com (10.174.187.128) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 17:52:48 +0800
From: Yanan Wang <wangyanan55@huawei.com>
To: Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, "Quentin
 Perret" <qperret@google.com>, Alexandru Elisei <alexandru.elisei@arm.com>,
 <kvmarm@lists.cs.columbia.edu>, <linux-arm-kernel@lists.infradead.org>,
 <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 3/4] KVM: arm64: Tweak parameters of guest cache
 maintenance functions
Date: Wed, 16 Jun 2021 17:51:59 +0800
Message-ID: <20210616095200.38008-4-wangyanan55@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
In-Reply-To: <20210616095200.38008-1-wangyanan55@huawei.com>
References: <20210616095200.38008-1-wangyanan55@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.187.128]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500023.china.huawei.com (7.185.36.83)
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

Adjust the parameter "kvm_pfn_t pfn" of __clean_dcache_guest_page
and __invalidate_icache_guest_page to "void *va", which paves the
way for converting these two guest CMO functions into callbacks in
structure kvm_pgtable_mm_ops. No functional change.

Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
---
 arch/arm64/include/asm/kvm_mmu.h |  9 ++-------
 arch/arm64/kvm/mmu.c             | 28 +++++++++++++++-------------
 2 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 25ed956f9af1..6844a7550392 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -187,10 +187,8 @@ static inline bool vcpu_has_cache_enabled(struct kvm_vcpu *vcpu)
 	return (vcpu_read_sys_reg(vcpu, SCTLR_EL1) & 0b101) == 0b101;
 }
 
-static inline void __clean_dcache_guest_page(kvm_pfn_t pfn, unsigned long size)
+static inline void __clean_dcache_guest_page(void *va, size_t size)
 {
-	void *va = page_address(pfn_to_page(pfn));
-
 	/*
 	 * With FWB, we ensure that the guest always accesses memory using
 	 * cacheable attributes, and we don't have to clean to PoC when
@@ -203,16 +201,13 @@ static inline void __clean_dcache_guest_page(kvm_pfn_t pfn, unsigned long size)
 	kvm_flush_dcache_to_poc(va, size);
 }
 
-static inline void __invalidate_icache_guest_page(kvm_pfn_t pfn,
-						  unsigned long size)
+static inline void __invalidate_icache_guest_page(void *va, size_t size)
 {
 	if (icache_is_aliasing()) {
 		/* any kind of VIPT cache */
 		__flush_icache_all();
 	} else if (is_kernel_in_hyp_mode() || !icache_is_vpipt()) {
 		/* PIPT or VPIPT at EL2 (see comment in __kvm_tlb_flush_vmid_ipa) */
-		void *va = page_address(pfn_to_page(pfn));
-
 		invalidate_icache_range((unsigned long)va,
 					(unsigned long)va + size);
 	}
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 5742ba765ff9..b980f8a47cbb 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -126,6 +126,16 @@ static void *kvm_host_va(phys_addr_t phys)
 	return __va(phys);
 }
 
+static void clean_dcache_guest_page(void *va, size_t size)
+{
+	__clean_dcache_guest_page(va, size);
+}
+
+static void invalidate_icache_guest_page(void *va, size_t size)
+{
+	__invalidate_icache_guest_page(va, size);
+}
+
 /*
  * Unmapping vs dcache management:
  *
@@ -693,16 +703,6 @@ void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
 	kvm_mmu_write_protect_pt_masked(kvm, slot, gfn_offset, mask);
 }
 
-static void clean_dcache_guest_page(kvm_pfn_t pfn, unsigned long size)
-{
-	__clean_dcache_guest_page(pfn, size);
-}
-
-static void invalidate_icache_guest_page(kvm_pfn_t pfn, unsigned long size)
-{
-	__invalidate_icache_guest_page(pfn, size);
-}
-
 static void kvm_send_hwpoison_signal(unsigned long address, short lsb)
 {
 	send_sig_mceerr(BUS_MCEERR_AR, (void __user *)address, lsb, current);
@@ -1013,11 +1013,13 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		prot |= KVM_PGTABLE_PROT_W;
 
 	if (fault_status != FSC_PERM && !device)
-		clean_dcache_guest_page(pfn, vma_pagesize);
+		clean_dcache_guest_page(page_address(pfn_to_page(pfn)),
+					vma_pagesize);
 
 	if (exec_fault) {
 		prot |= KVM_PGTABLE_PROT_X;
-		invalidate_icache_guest_page(pfn, vma_pagesize);
+		invalidate_icache_guest_page(page_address(pfn_to_page(pfn)),
+					     vma_pagesize);
 	}
 
 	if (device)
@@ -1219,7 +1221,7 @@ bool kvm_set_spte_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
 	 * We've moved a page around, probably through CoW, so let's treat it
 	 * just like a translation fault and clean the cache to the PoC.
 	 */
-	clean_dcache_guest_page(pfn, PAGE_SIZE);
+	clean_dcache_guest_page(page_address(pfn_to_page(pfn), PAGE_SIZE);
 
 	/*
 	 * The MMU notifiers will have unmapped a huge PMD before calling
-- 
2.23.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
