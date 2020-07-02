Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C0D63212568
	for <lists+kvmarm@lfdr.de>; Thu,  2 Jul 2020 15:57:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6BD0A4B605;
	Thu,  2 Jul 2020 09:57:15 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V4Lu5wmkMdBm; Thu,  2 Jul 2020 09:57:14 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0677F4B5E3;
	Thu,  2 Jul 2020 09:57:13 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8F3134B48F
 for <kvmarm@lists.cs.columbia.edu>; Thu,  2 Jul 2020 09:57:11 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XtJSZRKm2rTB for <kvmarm@lists.cs.columbia.edu>;
 Thu,  2 Jul 2020 09:57:10 -0400 (EDT)
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 4D3D94B47D
 for <kvmarm@lists.cs.columbia.edu>; Thu,  2 Jul 2020 09:57:10 -0400 (EDT)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 887BE1F41B7E81547404;
 Thu,  2 Jul 2020 21:56:10 +0800 (CST)
Received: from DESKTOP-5IS4806.china.huawei.com (10.174.187.22) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Thu, 2 Jul 2020 21:56:04 +0800
From: Keqian Zhu <zhukeqian1@huawei.com>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <kvmarm@lists.cs.columbia.edu>, <kvm@vger.kernel.org>
Subject: [PATCH v2 3/8] KVM: arm64: Modify stage2 young mechanism to support
 hw DBM
Date: Thu, 2 Jul 2020 21:55:51 +0800
Message-ID: <20200702135556.36896-4-zhukeqian1@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
In-Reply-To: <20200702135556.36896-1-zhukeqian1@huawei.com>
References: <20200702135556.36896-1-zhukeqian1@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.187.22]
X-CFilter-Loop: Reflected
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Sean Christopherson <sean.j.christopherson@intel.com>,
 Steven Price <steven.price@arm.com>, liangpeng10@huawei.com,
 Alexios Zavras <alexios.zavras@intel.com>, Mark Brown <broonie@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
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

Marking PTs young (set AF bit) should be atomic to avoid cover
dirty status set by hardware.

Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Peng Liang <liangpeng10@huawei.com>
---
 arch/arm64/include/asm/kvm_mmu.h | 31 ++++++++++++++++++++++---------
 arch/arm64/kvm/mmu.c             | 15 ++++++++-------
 2 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 4c12b7ad8ae8..a1b6131d980c 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -219,6 +219,18 @@ static inline void kvm_set_s2pte_readonly(pte_t *ptep)
 	} while (pteval != old_pteval);
 }
 
+static inline void kvm_set_s2pte_young(pte_t *ptep)
+{
+	pteval_t old_pteval, pteval;
+
+	pteval = READ_ONCE(pte_val(*ptep));
+	do {
+		old_pteval = pteval;
+		pteval |= PTE_AF;
+		pteval = cmpxchg_relaxed(&pte_val(*ptep), old_pteval, pteval);
+	} while (pteval != old_pteval);
+}
+
 static inline bool kvm_s2pte_readonly(pte_t *ptep)
 {
 	return (READ_ONCE(pte_val(*ptep)) & PTE_S2_RDWR) == PTE_S2_RDONLY;
@@ -234,6 +246,11 @@ static inline void kvm_set_s2pmd_readonly(pmd_t *pmdp)
 	kvm_set_s2pte_readonly((pte_t *)pmdp);
 }
 
+static inline void kvm_set_s2pmd_young(pmd_t *pmdp)
+{
+	kvm_set_s2pte_young((pte_t *)pmdp);
+}
+
 static inline bool kvm_s2pmd_readonly(pmd_t *pmdp)
 {
 	return kvm_s2pte_readonly((pte_t *)pmdp);
@@ -249,6 +266,11 @@ static inline void kvm_set_s2pud_readonly(pud_t *pudp)
 	kvm_set_s2pte_readonly((pte_t *)pudp);
 }
 
+static inline void kvm_set_s2pud_young(pud_t *pudp)
+{
+	kvm_set_s2pte_young((pte_t *)pudp);
+}
+
 static inline bool kvm_s2pud_readonly(pud_t *pudp)
 {
 	return kvm_s2pte_readonly((pte_t *)pudp);
@@ -259,15 +281,6 @@ static inline bool kvm_s2pud_exec(pud_t *pudp)
 	return !(READ_ONCE(pud_val(*pudp)) & PUD_S2_XN);
 }
 
-static inline pud_t kvm_s2pud_mkyoung(pud_t pud)
-{
-	return pud_mkyoung(pud);
-}
-
-static inline bool kvm_s2pud_young(pud_t pud)
-{
-	return pud_young(pud);
-}
 
 static inline bool arm_mmu_hw_dbm_supported(void)
 {
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index b3cb8b6da4c2..ab8a6ceecbd8 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -2008,8 +2008,9 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
  * Resolve the access fault by making the page young again.
  * Note that because the faulting entry is guaranteed not to be
  * cached in the TLB, we don't need to invalidate anything.
- * Only the HW Access Flag updates are supported for Stage 2 (no DBM),
- * so there is no need for atomic (pte|pmd)_mkyoung operations.
+ *
+ * Note: Both DBM and HW AF updates are supported for Stage2, so
+ * young operations should be atomic.
  */
 static void handle_access_fault(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa)
 {
@@ -2027,15 +2028,15 @@ static void handle_access_fault(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa)
 		goto out;
 
 	if (pud) {		/* HugeTLB */
-		*pud = kvm_s2pud_mkyoung(*pud);
+		kvm_set_s2pud_young(pud);
 		pfn = kvm_pud_pfn(*pud);
 		pfn_valid = true;
 	} else	if (pmd) {	/* THP, HugeTLB */
-		*pmd = pmd_mkyoung(*pmd);
+		kvm_set_s2pmd_young(pmd);
 		pfn = pmd_pfn(*pmd);
 		pfn_valid = true;
-	} else {
-		*pte = pte_mkyoung(*pte);	/* Just a page... */
+	} else {		/* Just a page... */
+		kvm_set_s2pte_young(pte);
 		pfn = pte_pfn(*pte);
 		pfn_valid = true;
 	}
@@ -2280,7 +2281,7 @@ static int kvm_test_age_hva_handler(struct kvm *kvm, gpa_t gpa, u64 size, void *
 		return 0;
 
 	if (pud)
-		return kvm_s2pud_young(*pud);
+		return pud_young(*pud);
 	else if (pmd)
 		return pmd_young(*pmd);
 	else
-- 
2.19.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
