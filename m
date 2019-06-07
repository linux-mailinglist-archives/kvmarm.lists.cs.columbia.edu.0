Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B2608388FA
	for <lists+kvmarm@lfdr.de>; Fri,  7 Jun 2019 13:27:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 60D494A521;
	Fri,  7 Jun 2019 07:27:29 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6G-xR9r0pd4k; Fri,  7 Jun 2019 07:27:29 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 34B494A50C;
	Fri,  7 Jun 2019 07:27:28 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CC3094A504
 for <kvmarm@lists.cs.columbia.edu>; Fri,  7 Jun 2019 07:27:26 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n4XED2ylNgXx for <kvmarm@lists.cs.columbia.edu>;
 Fri,  7 Jun 2019 07:27:25 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 562C84A4F4
 for <kvmarm@lists.cs.columbia.edu>; Fri,  7 Jun 2019 07:27:25 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 185086CC;
 Fri,  7 Jun 2019 04:27:25 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3DCDA3F246;
 Fri,  7 Jun 2019 04:29:04 -0700 (PDT)
From: Dave Martin <Dave.Martin@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH kvmtool v4 7/8] arm/arm64: Factor out ptrauth vcpu feature
 setup
Date: Fri,  7 Jun 2019 12:26:28 +0100
Message-Id: <1559906789-20936-8-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1559906789-20936-1-git-send-email-Dave.Martin@arm.com>
References: <1559906789-20936-1-git-send-email-Dave.Martin@arm.com>
Cc: Christoffer Dall <cdall@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>,
 Andre Przywara <andre.przywara@arm.com>, Will Deacon <will.deacon@arm.com>,
 Kristina Martsenko <kristina.martsenko@arm.com>,
 Zhang Lei <zhang.lei@jp.fujitsu.com>,
 Amit Daniel Kachhap <amit.kachhap@arm.com>,
 linux-arm-kernel@lists.infradead.org
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

In the interest of readability, factor out the vcpu feature setup
for ptrauth into a separate function.

Also, because aarch32 doesn't have this feature or the related
command line options anyway, move the actual code into aarch64/.

Since ARM_VCPU_PTRAUTH_FEATURE is only there to make the ptrauth
feature setup code compile on arm, it is no longer needed: inline
and remove it.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arm/aarch32/include/kvm/kvm-cpu-arch.h |  3 ++-
 arm/aarch64/include/kvm/kvm-cpu-arch.h |  3 +--
 arm/aarch64/kvm-cpu.c                  | 10 ++++++++++
 arm/kvm-cpu.c                          |  5 +----
 4 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/arm/aarch32/include/kvm/kvm-cpu-arch.h b/arm/aarch32/include/kvm/kvm-cpu-arch.h
index 3ec6f03..01983f0 100644
--- a/arm/aarch32/include/kvm/kvm-cpu-arch.h
+++ b/arm/aarch32/include/kvm/kvm-cpu-arch.h
@@ -13,6 +13,7 @@
 #define ARM_CPU_ID		0, 0, 0
 #define ARM_CPU_ID_MPIDR	5
 
-#define ARM_VCPU_PTRAUTH_FEATURE	0
+static inline void kvm_cpu__select_features(struct kvm *kvm,
+					    struct kvm_vcpu_init *init) { }
 
 #endif /* KVM__KVM_CPU_ARCH_H */
diff --git a/arm/aarch64/include/kvm/kvm-cpu-arch.h b/arm/aarch64/include/kvm/kvm-cpu-arch.h
index 9fa99fb..e6875fc 100644
--- a/arm/aarch64/include/kvm/kvm-cpu-arch.h
+++ b/arm/aarch64/include/kvm/kvm-cpu-arch.h
@@ -17,7 +17,6 @@
 #define ARM_CPU_CTRL		3, 0, 1, 0
 #define ARM_CPU_CTRL_SCTLR_EL1	0
 
-#define ARM_VCPU_PTRAUTH_FEATURE	((1UL << KVM_ARM_VCPU_PTRAUTH_ADDRESS) \
-					| (1UL << KVM_ARM_VCPU_PTRAUTH_GENERIC))
+void kvm_cpu__select_features(struct kvm *kvm, struct kvm_vcpu_init *init);
 
 #endif /* KVM__KVM_CPU_ARCH_H */
diff --git a/arm/aarch64/kvm-cpu.c b/arm/aarch64/kvm-cpu.c
index 0aaefaf..8c29a21 100644
--- a/arm/aarch64/kvm-cpu.c
+++ b/arm/aarch64/kvm-cpu.c
@@ -128,6 +128,16 @@ static void reset_vcpu_aarch64(struct kvm_cpu *vcpu)
 	}
 }
 
+void kvm_cpu__select_features(struct kvm *kvm, struct kvm_vcpu_init *init)
+{
+	/* Enable pointer authentication if available */
+	if (kvm__supports_extension(kvm, KVM_CAP_ARM_PTRAUTH_ADDRESS) &&
+	    kvm__supports_extension(kvm, KVM_CAP_ARM_PTRAUTH_GENERIC)) {
+		init->features[0] |= 1UL << KVM_ARM_VCPU_PTRAUTH_ADDRESS;
+		init->features[0] |= 1UL << KVM_ARM_VCPU_PTRAUTH_GENERIC;
+	}
+}
+
 void kvm_cpu__reset_vcpu(struct kvm_cpu *vcpu)
 {
 	if (vcpu->kvm->cfg.arch.aarch32_guest)
diff --git a/arm/kvm-cpu.c b/arm/kvm-cpu.c
index fff8494..1652f6f 100644
--- a/arm/kvm-cpu.c
+++ b/arm/kvm-cpu.c
@@ -68,10 +68,7 @@ struct kvm_cpu *kvm_cpu__arch_init(struct kvm *kvm, unsigned long cpu_id)
 		vcpu_init.features[0] |= (1UL << KVM_ARM_VCPU_PSCI_0_2);
 	}
 
-	/* Enable pointer authentication if available */
-	if (kvm__supports_extension(kvm, KVM_CAP_ARM_PTRAUTH_ADDRESS) &&
-	    kvm__supports_extension(kvm, KVM_CAP_ARM_PTRAUTH_GENERIC))
-			vcpu_init.features[0] |= ARM_VCPU_PTRAUTH_FEATURE;
+	kvm_cpu__select_features(kvm, &vcpu_init);
 
 	/*
 	 * If the preferred target ioctl is successful then
-- 
2.1.4

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
