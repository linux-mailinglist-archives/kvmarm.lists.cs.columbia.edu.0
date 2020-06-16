Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 731951FACA7
	for <lists+kvmarm@lfdr.de>; Tue, 16 Jun 2020 11:36:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 270B04B0E3;
	Tue, 16 Jun 2020 05:36:33 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ngZNUbiDA4nU; Tue, 16 Jun 2020 05:36:33 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E01D44A49C;
	Tue, 16 Jun 2020 05:36:29 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 018B44B0F3
 for <kvmarm@lists.cs.columbia.edu>; Tue, 16 Jun 2020 05:36:26 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g1UnYifQcGnD for <kvmarm@lists.cs.columbia.edu>;
 Tue, 16 Jun 2020 05:36:25 -0400 (EDT)
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 743A94B0F4
 for <kvmarm@lists.cs.columbia.edu>; Tue, 16 Jun 2020 05:36:21 -0400 (EDT)
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id AD27B10AC27B32B7709B;
 Tue, 16 Jun 2020 17:36:18 +0800 (CST)
Received: from DESKTOP-5IS4806.china.huawei.com (10.173.221.230) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Tue, 16 Jun 2020 17:36:08 +0800
From: Keqian Zhu <zhukeqian1@huawei.com>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <kvmarm@lists.cs.columbia.edu>, <kvm@vger.kernel.org>
Subject: [PATCH 06/12] KVM: arm64: Set DBM bit of PTEs during write protecting
Date: Tue, 16 Jun 2020 17:35:47 +0800
Message-ID: <20200616093553.27512-7-zhukeqian1@huawei.com>
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

During write protecting PTEs, if hardware dirty log is enabled,
set the DBM bit of PTEs when they are *already writable*. This
ensures some mechanisms that rely on "write fault", such as CoW,
are not broken.

Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Peng Liang <liangpeng10@huawei.com>
---
 arch/arm64/kvm/mmu.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index f08b0fbca0a0..742c7943176f 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1536,19 +1536,24 @@ int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
 
 /**
  * stage2_wp_ptes - write protect PMD range
+ * @kvm:	kvm instance for the VM
  * @pmd:	pointer to pmd entry
  * @addr:	range start address
  * @end:	range end address
  */
-static void stage2_wp_ptes(pmd_t *pmd, phys_addr_t addr, phys_addr_t end)
+static void stage2_wp_ptes(struct kvm *kvm, pmd_t *pmd,
+			   phys_addr_t addr, phys_addr_t end)
 {
 	pte_t *pte;
 
 	pte = pte_offset_kernel(pmd, addr);
 	do {
-		if (!pte_none(*pte)) {
-			if (!kvm_s2pte_readonly(pte))
-				kvm_set_s2pte_readonly(pte);
+		if (!pte_none(*pte) && !kvm_s2pte_readonly(pte)) {
+#ifdef CONFIG_ARM64_HW_AFDBM
+			if (kvm->arch.hw_dirty_log && !kvm_s2pte_dbm(pte))
+				kvm_set_s2pte_dbm(pte);
+#endif
+			kvm_set_s2pte_readonly(pte);
 		}
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 }
@@ -1575,7 +1580,7 @@ static void stage2_wp_pmds(struct kvm *kvm, pud_t *pud,
 				if (!kvm_s2pmd_readonly(pmd))
 					kvm_set_s2pmd_readonly(pmd);
 			} else {
-				stage2_wp_ptes(pmd, addr, next);
+				stage2_wp_ptes(kvm, pmd, addr, next);
 			}
 		}
 	} while (pmd++, addr = next, addr != end);
-- 
2.19.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
