Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9B13F7A25
	for <lists+kvmarm@lfdr.de>; Wed, 25 Aug 2021 18:18:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2B16C4025B;
	Wed, 25 Aug 2021 12:18:43 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jaIwg+wztdHZ; Wed, 25 Aug 2021 12:18:38 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 018AF4B2AF;
	Wed, 25 Aug 2021 12:17:58 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 77D254B236
 for <kvmarm@lists.cs.columbia.edu>; Wed, 25 Aug 2021 12:17:57 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FOlNj+6QEEeS for <kvmarm@lists.cs.columbia.edu>;
 Wed, 25 Aug 2021 12:17:53 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B9BD24B25A
 for <kvmarm@lists.cs.columbia.edu>; Wed, 25 Aug 2021 12:17:39 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 734691435;
 Wed, 25 Aug 2021 09:17:39 -0700 (PDT)
Received: from monolith.cable.virginm.net (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23D673F66F;
 Wed, 25 Aug 2021 09:17:38 -0700 (PDT)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 will@kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 17/39] KVM: arm64: Set the VCPU SPE feature bit when
 SPE is available
Date: Wed, 25 Aug 2021 17:17:53 +0100
Message-Id: <20210825161815.266051-18-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210825161815.266051-1-alexandru.elisei@arm.com>
References: <20210825161815.266051-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
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

Check that KVM SPE emulation is supported before allowing userspace to set
the KVM_ARM_VCPU_SPE feature.

According to ARM DDI 0487G.a, page D9-2946 the Profiling Buffer is disabled
if the owning Exception level is 32 bit, reject the SPE feature if the
VCPU's execution state at EL1 is aarch32.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/include/asm/kvm_host.h |  3 +++
 arch/arm64/kvm/reset.c            | 23 +++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 1f3b46a6df81..948adb152104 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -807,6 +807,9 @@ bool kvm_arm_vcpu_is_finalized(struct kvm_vcpu *vcpu);
 #define kvm_vcpu_has_pmu(vcpu)					\
 	(test_bit(KVM_ARM_VCPU_PMU_V3, (vcpu)->arch.features))
 
+#define kvm_vcpu_has_spe(vcpu)					\
+	(test_bit(KVM_ARM_VCPU_SPE, (vcpu)->arch.features))
+
 int kvm_trng_call(struct kvm_vcpu *vcpu);
 #ifdef CONFIG_KVM
 extern phys_addr_t hyp_mem_base;
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index cba7872d69a8..17b9f1b29c24 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -27,6 +27,7 @@
 #include <asm/kvm_asm.h>
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_mmu.h>
+#include <asm/kvm_spe.h>
 #include <asm/virt.h>
 
 /* Maximum phys_shift supported for any VM on this host */
@@ -189,6 +190,21 @@ static bool vcpu_allowed_register_width(struct kvm_vcpu *vcpu)
 	return true;
 }
 
+static int kvm_vcpu_enable_spe(struct kvm_vcpu *vcpu)
+{
+	if (!kvm_supports_spe())
+		return -EINVAL;
+
+	/*
+	 * The Profiling Buffer is disabled if the owning Exception level is
+	 * aarch32.
+	 */
+	if (vcpu_has_feature(vcpu, KVM_ARM_VCPU_EL1_32BIT))
+		return -EINVAL;
+
+	return 0;
+}
+
 /**
  * kvm_reset_vcpu - sets core registers and sys_regs to reset value
  * @vcpu: The VCPU pointer
@@ -245,6 +261,13 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 		goto out;
 	}
 
+	if (kvm_vcpu_has_spe(vcpu)) {
+		if (kvm_vcpu_enable_spe(vcpu)) {
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+
 	switch (vcpu->arch.target) {
 	default:
 		if (test_bit(KVM_ARM_VCPU_EL1_32BIT, vcpu->arch.features)) {
-- 
2.33.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
