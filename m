Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7B79F1FAC97
	for <lists+kvmarm@lfdr.de>; Tue, 16 Jun 2020 11:36:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 274164B0E2;
	Tue, 16 Jun 2020 05:36:22 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id upKQGkCDkuNL; Tue, 16 Jun 2020 05:36:22 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E6EAC4B10C;
	Tue, 16 Jun 2020 05:36:20 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BDBFE4B0E9
 for <kvmarm@lists.cs.columbia.edu>; Tue, 16 Jun 2020 05:36:19 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TVRhnftiW16m for <kvmarm@lists.cs.columbia.edu>;
 Tue, 16 Jun 2020 05:36:17 -0400 (EDT)
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 6E10C4B0E6
 for <kvmarm@lists.cs.columbia.edu>; Tue, 16 Jun 2020 05:36:17 -0400 (EDT)
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 9F912D563F9CEB625A78;
 Tue, 16 Jun 2020 17:36:13 +0800 (CST)
Received: from DESKTOP-5IS4806.china.huawei.com (10.173.221.230) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Tue, 16 Jun 2020 17:36:06 +0800
From: Keqian Zhu <zhukeqian1@huawei.com>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <kvmarm@lists.cs.columbia.edu>, <kvm@vger.kernel.org>
Subject: [PATCH 03/12] KVM: arm64: Report hardware dirty status of stage2 PTE
 if coverred
Date: Tue, 16 Jun 2020 17:35:44 +0800
Message-ID: <20200616093553.27512-4-zhukeqian1@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
In-Reply-To: <20200616093553.27512-1-zhukeqian1@huawei.com>
References: <20200616093553.27512-1-zhukeqian1@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.173.221.230]
X-CFilter-Loop: Reflected
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Sean Christopherson <sean.j.christopherson@intel.com>, liangpeng10@huawei.com,
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

kvm_set_pte is called to replace a target PTE with a desired one.
We always do this without changing the desired one, but if dirty
status set by hardware is coverred, let caller know it.

Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
---
 arch/arm64/kvm/mmu.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 5ad87bce23c0..27407153121b 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -194,11 +194,45 @@ static void clear_stage2_pmd_entry(struct kvm *kvm, pmd_t *pmd, phys_addr_t addr
 	put_page(virt_to_page(pmd));
 }
 
-static inline void kvm_set_pte(pte_t *ptep, pte_t new_pte)
+#ifdef CONFIG_ARM64_HW_AFDBM
+/**
+ * @ret: true if dirty status set by hardware is coverred.
+ */
+static bool kvm_set_pte(pte_t *ptep, pte_t new_pte)
+{
+	pteval_t old_pteval, new_pteval, pteval;
+	bool old_logging, new_no_write;
+
+	old_logging = kvm_hw_dbm_enabled() && !pte_none(*ptep) &&
+		      kvm_s2pte_dbm(ptep);
+	new_no_write = pte_none(new_pte) || kvm_s2pte_readonly(&new_pte);
+
+	if (!old_logging || !new_no_write) {
+		WRITE_ONCE(*ptep, new_pte);
+		dsb(ishst);
+		return false;
+	}
+
+	new_pteval = pte_val(new_pte);
+	pteval = READ_ONCE(pte_val(*ptep));
+	do {
+		old_pteval = pteval;
+		pteval = cmpxchg_relaxed(&pte_val(*ptep), old_pteval, new_pteval);
+	} while (pteval != old_pteval);
+
+	return !kvm_s2pte_readonly(&__pte(pteval));
+}
+#else
+/**
+ * @ret: true if dirty status set by hardware is coverred.
+ */
+static inline bool kvm_set_pte(pte_t *ptep, pte_t new_pte)
 {
 	WRITE_ONCE(*ptep, new_pte);
 	dsb(ishst);
+	return false;
 }
+#endif /* CONFIG_ARM64_HW_AFDBM */
 
 static inline void kvm_set_pmd(pmd_t *pmdp, pmd_t new_pmd)
 {
-- 
2.19.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
