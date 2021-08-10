Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 45D6A3E5410
	for <lists+kvmarm@lfdr.de>; Tue, 10 Aug 2021 09:02:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EEB194B105;
	Tue, 10 Aug 2021 03:02:36 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TejqiRCGNUbn; Tue, 10 Aug 2021 03:02:33 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F1DCD4B0B3;
	Tue, 10 Aug 2021 03:02:29 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 306DF4B098
 for <kvmarm@lists.cs.columbia.edu>; Tue, 10 Aug 2021 03:02:29 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8wJ745vqpkJX for <kvmarm@lists.cs.columbia.edu>;
 Tue, 10 Aug 2021 03:02:24 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C63CB4B0E4
 for <kvmarm@lists.cs.columbia.edu>; Tue, 10 Aug 2021 03:02:23 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A78BD6E;
 Tue, 10 Aug 2021 00:02:23 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.67.89])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EB8463F718;
 Tue, 10 Aug 2021 00:02:19 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 5/5] KVM: arm64: Define KVM_PHYS_SHIFT_MIN
Date: Tue, 10 Aug 2021 12:32:41 +0530
Message-Id: <1628578961-29097-6-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1628578961-29097-1-git-send-email-anshuman.khandual@arm.com>
References: <1628578961-29097-1-git-send-email-anshuman.khandual@arm.com>
Cc: Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>, linux-kernel@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, kvmarm@lists.cs.columbia.edu
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

Drop the hard coded value for the minimum IPA range i.e 32 bit. Instead
define a macro KVM_PHYS_SHIFT_MIN which improves the code readability.

Cc: Marc Zyngier <maz@kernel.org>
Cc: James Morse <james.morse@arm.com>
Cc: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: kvmarm@lists.cs.columbia.edu
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/kvm_mmu.h | 3 ++-
 arch/arm64/kvm/reset.c           | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index b52c5c4b9a3d..716f999818d9 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -141,7 +141,8 @@ static __always_inline unsigned long __kern_hyp_va(unsigned long v)
  * We currently support using a VM-specified IPA size. For backward
  * compatibility, the default IPA size is fixed to 40bits.
  */
-#define KVM_PHYS_SHIFT	(40)
+#define KVM_PHYS_SHIFT		(40)
+#define KVM_PHYS_SHIFT_MIN	(32)
 
 #define kvm_phys_shift(kvm)		VTCR_EL2_IPA(kvm->arch.vtcr)
 #define kvm_phys_size(kvm)		(_AC(1, ULL) << kvm_phys_shift(kvm))
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index cba7872d69a8..8dc8b4b9de37 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -369,7 +369,7 @@ int kvm_arm_setup_stage2(struct kvm *kvm, unsigned long type)
 	phys_shift = KVM_VM_TYPE_ARM_IPA_SIZE(type);
 	if (phys_shift) {
 		if (phys_shift > kvm_ipa_limit ||
-		    phys_shift < 32)
+		    phys_shift < KVM_PHYS_SHIFT_MIN)
 			return -EINVAL;
 	} else {
 		phys_shift = KVM_PHYS_SHIFT;
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
