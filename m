Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D4B9C2419B1
	for <lists+kvmarm@lfdr.de>; Tue, 11 Aug 2020 12:27:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 87B804B4F6;
	Tue, 11 Aug 2020 06:27:38 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EThGFwwIOdKZ; Tue, 11 Aug 2020 06:27:38 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 426D34B4B1;
	Tue, 11 Aug 2020 06:27:37 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 033354B4B1
 for <kvmarm@lists.cs.columbia.edu>; Tue, 11 Aug 2020 06:27:36 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rjoWmSYN7Wip for <kvmarm@lists.cs.columbia.edu>;
 Tue, 11 Aug 2020 06:27:34 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 91B274B49F
 for <kvmarm@lists.cs.columbia.edu>; Tue, 11 Aug 2020 06:27:34 -0400 (EDT)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EBDA02076C;
 Tue, 11 Aug 2020 10:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597141653;
 bh=XE668iD9SY5/XC9Cg7O/2rDRshSZB0RRnCkW1VOO3lQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oHO37VV8kzVVBguWg3LiimrpRMAN6X4DdPsl5c5W2usH8CIxFIqenaE/rRcFPs1nY
 lYCVFen5VOzTrFFjUjplWadFNPPPZ+xSF1ycvG7HdCd7CuoOBs+EXhklt3rNySyg1/
 sWFEUNs8G6ShTHTd17qf588YzfAEEblSdjdg8xb8=
From: Will Deacon <will@kernel.org>
To: kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
Subject: [PATCH 1/2] KVM: Pass MMU notifier range flags to
 kvm_unmap_hva_range()
Date: Tue, 11 Aug 2020 11:27:24 +0100
Message-Id: <20200811102725.7121-2-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200811102725.7121-1-will@kernel.org>
References: <20200811102725.7121-1-will@kernel.org>
MIME-Version: 1.0
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Marc Zyngier <maz@kernel.org>,
 Sean Christopherson <sean.j.christopherson@intel.com>,
 Paul Mackerras <paulus@ozlabs.org>, stable@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Will Deacon <will@kernel.org>
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

The 'flags' field of 'struct mmu_notifier_range' is used to indicate
whether invalidate_range_{start,end}() are permitted to block. In the
case of kvm_mmu_notifier_invalidate_range_start(), this field is not
forwarded on to the architecture-specific implementation of
kvm_unmap_hva_range() and therefore the backend cannot sensibly decide
whether or not to block.

Add an extra 'flags' parameter to kvm_unmap_hva_range() so that
architectures are aware as to whether or not they are permitted to block.

Cc: <stable@vger.kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: James Morse <james.morse@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h   | 2 +-
 arch/arm64/kvm/mmu.c                | 2 +-
 arch/mips/include/asm/kvm_host.h    | 2 +-
 arch/mips/kvm/mmu.c                 | 3 ++-
 arch/powerpc/include/asm/kvm_host.h | 3 ++-
 arch/powerpc/kvm/book3s.c           | 3 ++-
 arch/powerpc/kvm/e500_mmu_host.c    | 3 ++-
 arch/x86/include/asm/kvm_host.h     | 3 ++-
 arch/x86/kvm/mmu/mmu.c              | 3 ++-
 virt/kvm/kvm_main.c                 | 3 ++-
 10 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index e21d4a01372f..759d62343e1d 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -443,7 +443,7 @@ int __kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
 
 #define KVM_ARCH_WANT_MMU_NOTIFIER
 int kvm_unmap_hva_range(struct kvm *kvm,
-			unsigned long start, unsigned long end);
+			unsigned long start, unsigned long end, unsigned flags);
 int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
 int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end);
 int kvm_test_age_hva(struct kvm *kvm, unsigned long hva);
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 31058e6e7c2a..5f6b35c33618 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -2203,7 +2203,7 @@ static int kvm_unmap_hva_handler(struct kvm *kvm, gpa_t gpa, u64 size, void *dat
 }
 
 int kvm_unmap_hva_range(struct kvm *kvm,
-			unsigned long start, unsigned long end)
+			unsigned long start, unsigned long end, unsigned flags)
 {
 	if (!kvm->arch.pgd)
 		return 0;
diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 363e7a89d173..ef1d25d49ec8 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -981,7 +981,7 @@ enum kvm_mips_fault_result kvm_trap_emul_gva_fault(struct kvm_vcpu *vcpu,
 
 #define KVM_ARCH_WANT_MMU_NOTIFIER
 int kvm_unmap_hva_range(struct kvm *kvm,
-			unsigned long start, unsigned long end);
+			unsigned long start, unsigned long end, unsigned flags);
 int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
 int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end);
 int kvm_test_age_hva(struct kvm *kvm, unsigned long hva);
diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index 49bd160f4d85..0783ac9b3240 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -518,7 +518,8 @@ static int kvm_unmap_hva_handler(struct kvm *kvm, gfn_t gfn, gfn_t gfn_end,
 	return 1;
 }
 
-int kvm_unmap_hva_range(struct kvm *kvm, unsigned long start, unsigned long end)
+int kvm_unmap_hva_range(struct kvm *kvm, unsigned long start, unsigned long end,
+			unsigned flags)
 {
 	handle_hva_to_gpa(kvm, start, end, &kvm_unmap_hva_handler, NULL);
 
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 7e2d061d0445..bccf0ba2da2e 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -58,7 +58,8 @@
 #define KVM_ARCH_WANT_MMU_NOTIFIER
 
 extern int kvm_unmap_hva_range(struct kvm *kvm,
-			       unsigned long start, unsigned long end);
+			       unsigned long start, unsigned long end,
+			       unsigned flags);
 extern int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end);
 extern int kvm_test_age_hva(struct kvm *kvm, unsigned long hva);
 extern int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 41fedec69ac3..49db50d1db04 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -834,7 +834,8 @@ void kvmppc_core_commit_memory_region(struct kvm *kvm,
 	kvm->arch.kvm_ops->commit_memory_region(kvm, mem, old, new, change);
 }
 
-int kvm_unmap_hva_range(struct kvm *kvm, unsigned long start, unsigned long end)
+int kvm_unmap_hva_range(struct kvm *kvm, unsigned long start, unsigned long end,
+			unsigned flags)
 {
 	return kvm->arch.kvm_ops->unmap_hva_range(kvm, start, end);
 }
diff --git a/arch/powerpc/kvm/e500_mmu_host.c b/arch/powerpc/kvm/e500_mmu_host.c
index d6c1069e9954..ed0c9c43d0cf 100644
--- a/arch/powerpc/kvm/e500_mmu_host.c
+++ b/arch/powerpc/kvm/e500_mmu_host.c
@@ -734,7 +734,8 @@ static int kvm_unmap_hva(struct kvm *kvm, unsigned long hva)
 	return 0;
 }
 
-int kvm_unmap_hva_range(struct kvm *kvm, unsigned long start, unsigned long end)
+int kvm_unmap_hva_range(struct kvm *kvm, unsigned long start, unsigned long end,
+			unsigned flags)
 {
 	/* kvm_unmap_hva flushes everything anyways */
 	kvm_unmap_hva(kvm, start);
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index be5363b21540..c6908a3d551e 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1641,7 +1641,8 @@ asmlinkage void kvm_spurious_fault(void);
 	_ASM_EXTABLE(666b, 667b)
 
 #define KVM_ARCH_WANT_MMU_NOTIFIER
-int kvm_unmap_hva_range(struct kvm *kvm, unsigned long start, unsigned long end);
+int kvm_unmap_hva_range(struct kvm *kvm, unsigned long start, unsigned long end,
+			unsigned flags);
 int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end);
 int kvm_test_age_hva(struct kvm *kvm, unsigned long hva);
 int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 6d6a0ae7800c..9516a958e780 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1971,7 +1971,8 @@ static int kvm_handle_hva(struct kvm *kvm, unsigned long hva,
 	return kvm_handle_hva_range(kvm, hva, hva + 1, data, handler);
 }
 
-int kvm_unmap_hva_range(struct kvm *kvm, unsigned long start, unsigned long end)
+int kvm_unmap_hva_range(struct kvm *kvm, unsigned long start, unsigned long end,
+			unsigned flags)
 {
 	return kvm_handle_hva_range(kvm, start, end, 0, kvm_unmap_rmapp);
 }
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 0a68c9d3d3ab..9e925675a886 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -427,7 +427,8 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
 	 * count is also read inside the mmu_lock critical section.
 	 */
 	kvm->mmu_notifier_count++;
-	need_tlb_flush = kvm_unmap_hva_range(kvm, range->start, range->end);
+	need_tlb_flush = kvm_unmap_hva_range(kvm, range->start, range->end,
+					     range->flags);
 	need_tlb_flush |= kvm->tlbs_dirty;
 	/* we've to flush the tlb before the pages can be freed */
 	if (need_tlb_flush)
-- 
2.28.0.236.gb10cc79966-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
