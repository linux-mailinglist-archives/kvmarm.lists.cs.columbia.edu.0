Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id DF5033E8F49
	for <lists+kvmarm@lfdr.de>; Wed, 11 Aug 2021 13:10:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5150249FB7;
	Wed, 11 Aug 2021 07:10:45 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U1RfB-f3zgHo; Wed, 11 Aug 2021 07:10:45 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CDF0649E5F;
	Wed, 11 Aug 2021 07:10:40 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E313F4064F
 for <kvmarm@lists.cs.columbia.edu>; Wed, 11 Aug 2021 07:10:38 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h0yXEuURAATQ for <kvmarm@lists.cs.columbia.edu>;
 Wed, 11 Aug 2021 07:10:34 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 73EED40573
 for <kvmarm@lists.cs.columbia.edu>; Wed, 11 Aug 2021 07:10:34 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C950E106F;
 Wed, 11 Aug 2021 04:10:33 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.67.241])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0DC533F70D;
 Wed, 11 Aug 2021 04:10:29 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH V2] KVM: arm64: Restrict IPA size to maximum 48 bits on 4K and
 16K page size
Date: Wed, 11 Aug 2021 16:41:15 +0530
Message-Id: <1628680275-16578-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
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

Even though ID_AA64MMFR0.PARANGE reports 52 bit PA size support, it cannot
be enabled as guest IPA size on 4K or 16K page size configurations. Hence
kvm_ipa_limit must be restricted to 48 bits. This change achieves required
IPA capping.

Before the commit c9b69a0cf0b4 ("KVM: arm64: Don't constrain maximum IPA
size based on host configuration"), the problem here would have been just
latent via PHYS_MASK_SHIFT (which earlier in turn capped kvm_ipa_limit),
which remains capped at 48 bits on 4K and 16K configs.

Cc: Marc Zyngier <maz@kernel.org>
Cc: James Morse <james.morse@arm.com>
Cc: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: kvmarm@lists.cs.columbia.edu
Cc: linux-kernel@vger.kernel.org
Fixes: c9b69a0cf0b4 ("KVM: arm64: Don't constrain maximum IPA size based on host configuration")
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v5.14-rc5

Changes in V2:

- Replaced IS_ENABLED() based check with PAGE_SIZE based one per Marc
- Moved the conditional code block near parange assignment per Marc

Changes in V1:

https://lore.kernel.org/lkml/1628657549-27584-1-git-send-email-anshuman.khandual@arm.com/

 arch/arm64/kvm/reset.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index cba7872..78d4bd8 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -317,6 +317,14 @@ int kvm_set_ipa_limit(void)
 	mmfr0 = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
 	parange = cpuid_feature_extract_unsigned_field(mmfr0,
 				ID_AA64MMFR0_PARANGE_SHIFT);
+	/*
+	 * IPA size beyond 48 bits could not be supported
+	 * on either 4K or 16K page size. Hence let's cap
+	 * it to 48 bits, in case it's reported as larger
+	 * on the system.
+	 */
+	if (PAGE_SIZE != SZ_64K)
+		parange = min(parange, (unsigned int)ID_AA64MMFR0_PARANGE_48);
 
 	/*
 	 * Check with ARMv8.5-GTG that our PAGE_SIZE is supported at
-- 
2.7.4

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
