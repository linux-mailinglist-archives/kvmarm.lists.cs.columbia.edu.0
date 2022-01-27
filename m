Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BA45F49E74D
	for <lists+kvmarm@lfdr.de>; Thu, 27 Jan 2022 17:20:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 511074B0A0;
	Thu, 27 Jan 2022 11:20:38 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.8
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, URIBL_BLOCKED=0.001] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GdPBF95IM05G; Thu, 27 Jan 2022 11:20:37 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2781149F2F;
	Thu, 27 Jan 2022 11:20:37 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A5CB149F2F
 for <kvmarm@lists.cs.columbia.edu>; Thu, 27 Jan 2022 11:20:35 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nVY49ieczkRV for <kvmarm@lists.cs.columbia.edu>;
 Thu, 27 Jan 2022 11:20:34 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9E6424A49C
 for <kvmarm@lists.cs.columbia.edu>; Thu, 27 Jan 2022 11:20:34 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3519E1063;
 Thu, 27 Jan 2022 08:20:34 -0800 (PST)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22BAB3F766;
 Thu, 27 Jan 2022 08:20:31 -0800 (PST)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: will@kernel.org, julien.thierry.kdev@gmail.com,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
 mark.rutland@arm.com, andre.przywara@arm.com
Subject: [PATCH v2 kvmtool 04/10] arm: Get rid of the ARM_VCPU_FEATURE_FLAGS()
 macro
Date: Thu, 27 Jan 2022 16:20:27 +0000
Message-Id: <20220127162033.54290-5-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220127162033.54290-1-alexandru.elisei@arm.com>
References: <20220127162033.54290-1-alexandru.elisei@arm.com>
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

The ARM_VCPU_FEATURE_FLAGS() macro sets a feature bit in a rather
convoluted way: if cpu_id is 0, then bit KVM_ARM_VCPU_POWER_OFF is 0,
otherwise is set to 1. There's really no need for this indirection,
especially considering that the macro has been changed to return the same
value for both the arm and arm64 architectures. Replace it with a simple
conditional statement in kvm_cpu__arch_init(), which makes it clearer to
understand.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arm/aarch32/include/kvm/kvm-cpu-arch.h | 4 ----
 arm/aarch64/include/kvm/kvm-cpu-arch.h | 4 ----
 arm/kvm-cpu.c                          | 6 +++++-
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/arm/aarch32/include/kvm/kvm-cpu-arch.h b/arm/aarch32/include/kvm/kvm-cpu-arch.h
index 780e0e2f0934..fc9aef9f6320 100644
--- a/arm/aarch32/include/kvm/kvm-cpu-arch.h
+++ b/arm/aarch32/include/kvm/kvm-cpu-arch.h
@@ -5,10 +5,6 @@
 
 #include "arm-common/kvm-cpu-arch.h"
 
-#define ARM_VCPU_FEATURE_FLAGS(kvm, cpuid)	{			\
-	[0] = (!!(cpuid) << KVM_ARM_VCPU_POWER_OFF),			\
-}
-
 #define ARM_MPIDR_HWID_BITMASK	0xFFFFFF
 #define ARM_CPU_ID		0, 0, 0
 #define ARM_CPU_ID_MPIDR	5
diff --git a/arm/aarch64/include/kvm/kvm-cpu-arch.h b/arm/aarch64/include/kvm/kvm-cpu-arch.h
index 016cf5b2b9ea..17b80493e2c0 100644
--- a/arm/aarch64/include/kvm/kvm-cpu-arch.h
+++ b/arm/aarch64/include/kvm/kvm-cpu-arch.h
@@ -5,10 +5,6 @@
 
 #include "arm-common/kvm-cpu-arch.h"
 
-#define ARM_VCPU_FEATURE_FLAGS(kvm, cpuid)	{				\
-	[0] = (!!(cpuid) << KVM_ARM_VCPU_POWER_OFF),				\
-}
-
 #define ARM_MPIDR_HWID_BITMASK	0xFF00FFFFFFUL
 #define ARM_CPU_ID		3, 0, 0, 0
 #define ARM_CPU_ID_MPIDR	5
diff --git a/arm/kvm-cpu.c b/arm/kvm-cpu.c
index 554414f81b7a..62177ea73f82 100644
--- a/arm/kvm-cpu.c
+++ b/arm/kvm-cpu.c
@@ -43,7 +43,7 @@ struct kvm_cpu *kvm_cpu__arch_init(struct kvm *kvm, unsigned long cpu_id)
 	unsigned int i;
 	struct kvm_vcpu_init preferred_init;
 	struct kvm_vcpu_init vcpu_init = {
-		.features = ARM_VCPU_FEATURE_FLAGS(kvm, cpu_id)
+		.features = {},
 	};
 
 	vcpu = calloc(1, sizeof(struct kvm_cpu));
@@ -63,6 +63,10 @@ struct kvm_cpu *kvm_cpu__arch_init(struct kvm *kvm, unsigned long cpu_id)
 	if (vcpu->kvm_run == MAP_FAILED)
 		die("unable to mmap vcpu fd");
 
+	/* VCPU 0 is the boot CPU, the others start in a poweroff state. */
+	if (cpu_id > 0)
+		vcpu_init.features[0] |= (1UL << KVM_ARM_VCPU_POWER_OFF);
+
 	/* Set KVM_ARM_VCPU_PSCI_0_2 if available */
 	if (kvm__supports_extension(kvm, KVM_CAP_ARM_PSCI_0_2)) {
 		vcpu_init.features[0] |= (1UL << KVM_ARM_VCPU_PSCI_0_2);
-- 
2.31.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
