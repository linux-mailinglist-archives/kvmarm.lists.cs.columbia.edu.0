Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE0E11EA32
	for <lists+kvmarm@lfdr.de>; Fri, 13 Dec 2019 19:27:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 023204A535;
	Fri, 13 Dec 2019 13:27:59 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xBc-+ecC1SbL; Fri, 13 Dec 2019 13:27:58 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D6C614AEE0;
	Fri, 13 Dec 2019 13:27:55 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BF99B4A535
 for <kvmarm@lists.cs.columbia.edu>; Fri, 13 Dec 2019 13:27:52 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Dx--GfAsT5Wp for <kvmarm@lists.cs.columbia.edu>;
 Fri, 13 Dec 2019 13:27:51 -0500 (EST)
Received: from inca-roads.misterjones.org (inca-roads.misterjones.org
 [213.251.177.50])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id C1CDB4ACD6
 for <kvmarm@lists.cs.columbia.edu>; Fri, 13 Dec 2019 13:27:51 -0500 (EST)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by cheepnis.misterjones.org with esmtpsa
 (TLSv1.2:DHE-RSA-AES128-GCM-SHA256:128) (Exim 4.80)
 (envelope-from <maz@kernel.org>)
 id 1ifpdH-0001O7-7w; Fri, 13 Dec 2019 19:25:43 +0100
From: Marc Zyngier <maz@kernel.org>
To: 
Subject: [PATCH 4/7] KVM: arm/arm64: Condition TLB maintenance on unmap with a
 flag
Date: Fri, 13 Dec 2019 18:25:00 +0000
Message-Id: <20191213182503.14460-5-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191213182503.14460-1-maz@kernel.org>
References: <20191213182503.14460-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: james.morse@arm.com, julien.thierry.kdev@gmail.com,
 suzuki.poulose@arm.com, jhogan@kernel.org, paulus@ozlabs.org,
 pbonzini@redhat.com, rkrcmar@redhat.com, sean.j.christopherson@intel.com,
 vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
 joro@8bytes.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, linux-mips@vger.kernel.org,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm-ppc@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
 kvm@vger.kernel.org, James Hogan <jhogan@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, linux-mips@vger.kernel.org,
 Sean Christopherson <sean.j.christopherson@intel.com>,
 Paul Mackerras <paulus@ozlabs.org>, linux-arm-kernel@lists.infradead.org,
 Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 kvmarm@lists.cs.columbia.edu, Jim Mattson <jmattson@google.com>
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

In order to allow the elision of TLB maintenance operations
on unmap, add a new flag (KVM_UNMAP_ELIDE_TBLI) that a caller
can use to indicate that TLB invalidation is not required.

Nobody is passing this flag yet, hence no functional change.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 virt/kvm/arm/mmu.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index ebf8c87cc007..4399866842dc 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -37,6 +37,7 @@ static unsigned long io_map_base;
 
 /* Flags controlling S2 unmapping */
 #define KVM_UNMAP_ELIDE_CMO		(1UL << 0)
+#define KVM_UNMAP_ELIDE_TBLI		(1UL << 1)
 
 #define KVM_S2PTE_FLAG_IS_IOMAP		(1UL << 0)
 #define KVM_S2_FLAG_LOGGING_ACTIVE	(1UL << 1)
@@ -160,7 +161,8 @@ static void clear_stage2_pgd_entry(struct kvm *kvm, pgd_t *pgd, phys_addr_t addr
 {
 	pud_t *pud_table __maybe_unused = stage2_pud_offset(kvm, pgd, 0UL);
 	stage2_pgd_clear(kvm, pgd);
-	kvm_tlb_flush_vmid_ipa(kvm, addr);
+	if (!(flags & KVM_UNMAP_ELIDE_TBLI))
+		kvm_tlb_flush_vmid_ipa(kvm, addr);
 	stage2_pud_free(kvm, pud_table);
 	put_page(virt_to_page(pgd));
 }
@@ -171,7 +173,8 @@ static void clear_stage2_pud_entry(struct kvm *kvm, pud_t *pud, phys_addr_t addr
 	pmd_t *pmd_table __maybe_unused = stage2_pmd_offset(kvm, pud, 0);
 	VM_BUG_ON(stage2_pud_huge(kvm, *pud));
 	stage2_pud_clear(kvm, pud);
-	kvm_tlb_flush_vmid_ipa(kvm, addr);
+	if (!(flags & KVM_UNMAP_ELIDE_TBLI))
+		kvm_tlb_flush_vmid_ipa(kvm, addr);
 	stage2_pmd_free(kvm, pmd_table);
 	put_page(virt_to_page(pud));
 }
@@ -182,7 +185,8 @@ static void clear_stage2_pmd_entry(struct kvm *kvm, pmd_t *pmd, phys_addr_t addr
 	pte_t *pte_table = pte_offset_kernel(pmd, 0);
 	VM_BUG_ON(pmd_thp_or_huge(*pmd));
 	pmd_clear(pmd);
-	kvm_tlb_flush_vmid_ipa(kvm, addr);
+	if (!(flags & KVM_UNMAP_ELIDE_TBLI))
+		kvm_tlb_flush_vmid_ipa(kvm, addr);
 	free_page((unsigned long)pte_table);
 	put_page(virt_to_page(pmd));
 }
@@ -253,7 +257,8 @@ static void unmap_stage2_ptes(struct kvm *kvm, pmd_t *pmd,
 			pte_t old_pte = *pte;
 
 			kvm_set_pte(pte, __pte(0));
-			kvm_tlb_flush_vmid_ipa(kvm, addr);
+			if (!(flags & KVM_UNMAP_ELIDE_TBLI))
+				kvm_tlb_flush_vmid_ipa(kvm, addr);
 
 			/* No need to invalidate the cache for device mappings */
 			if (!kvm_is_device_pfn(pte_pfn(old_pte)) &&
@@ -283,7 +288,8 @@ static void unmap_stage2_pmds(struct kvm *kvm, pud_t *pud,
 				pmd_t old_pmd = *pmd;
 
 				pmd_clear(pmd);
-				kvm_tlb_flush_vmid_ipa(kvm, addr);
+				if (!(flags & KVM_UNMAP_ELIDE_TBLI))
+					kvm_tlb_flush_vmid_ipa(kvm, addr);
 
 				if (!(flags & KVM_UNMAP_ELIDE_CMO))
 					kvm_flush_dcache_pmd(old_pmd);
@@ -314,7 +320,8 @@ static void unmap_stage2_puds(struct kvm *kvm, pgd_t *pgd,
 				pud_t old_pud = *pud;
 
 				stage2_pud_clear(kvm, pud);
-				kvm_tlb_flush_vmid_ipa(kvm, addr);
+				if (!(flags & KVM_UNMAP_ELIDE_TBLI))
+					kvm_tlb_flush_vmid_ipa(kvm, addr);
 				if (!(flags & KVM_UNMAP_ELIDE_CMO))
 					kvm_flush_dcache_pud(old_pud);
 				put_page(virt_to_page(pud));
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
