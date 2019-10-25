Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B5F04E4CAD
	for <lists+kvmarm@lfdr.de>; Fri, 25 Oct 2019 15:51:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 496454A5D5;
	Fri, 25 Oct 2019 09:51:51 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kN53r8PbOejp; Fri, 25 Oct 2019 09:51:51 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2D4F84A5ED;
	Fri, 25 Oct 2019 09:51:50 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 20E6D4A5C8
 for <kvmarm@lists.cs.columbia.edu>; Fri, 25 Oct 2019 09:51:49 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m6xKGRKVz08Q for <kvmarm@lists.cs.columbia.edu>;
 Fri, 25 Oct 2019 09:51:48 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 10C304A50F
 for <kvmarm@lists.cs.columbia.edu>; Fri, 25 Oct 2019 09:51:48 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD06228;
 Fri, 25 Oct 2019 06:51:47 -0700 (PDT)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.145.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E7023F71A;
 Fri, 25 Oct 2019 06:51:47 -0700 (PDT)
From: Christoffer Dall <christoffer.dall@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH] KVM: arm64: Don't set HCR_EL2.TVM when S2FWB is supported
Date: Fri, 25 Oct 2019 15:51:44 +0200
Message-Id: <20191025135144.8805-1-christoffer.dall@arm.com>
X-Mailer: git-send-email 2.18.0
Cc: Marc Zyngier <marc.zyngier@arm.com>, linux-arm-kernel@lists.infradead.org
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

On CPUs that support S2FWB (Armv8.4+), KVM configures the stage 2 page
tables to override the memory attributes of memory accesses, regardless
of the stage 1 page table configurations, and also when the stage 1 MMU
is turned off.  This results in all memory accesses to RAM being
cacheable, including during early boot of the guest.

On CPUs without this feature, memory accesses were non-cacheable during
boot until the guest turned on the stage 1 MMU, and we had to detect
when the guest turned on the MMU, such that we could invalidate all cache
entries and ensure a consistent view of memory with the MMU turned on.
When the guest turned on the caches, we would call stage2_flush_vm()
from kvm_toggle_cache().

However, stage2_flush_vm() walks all the stage 2 tables, and calls
__kvm_flush-dcache_pte, which on a system with S2FWD does ... absolutely
nothing.

We can avoid that whole song and dance, and simply not set TVM when
creating a VM on a systme that has S2FWB.

Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexandru Elisei <alexandru.elisei@arm.com>
---
I was only able to test this on the model with cache modeling enabled,
but even removing TVM from HCR_EL2 without having FWB also worked with
that setup, so the testing of this has been light.  It seems like it
should obviously work, but it would be good if someone with access to
appropriate hardware could give this a spin.

 arch/arm64/include/asm/kvm_emulate.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index d69c1efc63e7..41820c3e70b8 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -53,8 +53,10 @@ static inline void vcpu_reset_hcr(struct kvm_vcpu *vcpu)
 		/* trap error record accesses */
 		vcpu->arch.hcr_el2 |= HCR_TERR;
 	}
-	if (cpus_have_const_cap(ARM64_HAS_STAGE2_FWB))
+	if (cpus_have_const_cap(ARM64_HAS_STAGE2_FWB)) {
+		vcpu->arch.hcr_el2 &= ~HCR_TVM;
 		vcpu->arch.hcr_el2 |= HCR_FWB;
+	}
 
 	if (test_bit(KVM_ARM_VCPU_EL1_32BIT, vcpu->arch.features))
 		vcpu->arch.hcr_el2 &= ~HCR_RW;
-- 
2.18.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
