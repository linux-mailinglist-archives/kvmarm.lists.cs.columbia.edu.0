Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A5DEF2FF1E
	for <lists+kvmarm@lfdr.de>; Thu, 30 May 2019 17:14:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 514DE4A4E8;
	Thu, 30 May 2019 11:14:25 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M8wdYZZEYDVq; Thu, 30 May 2019 11:14:23 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8A1FE4A50B;
	Thu, 30 May 2019 11:14:23 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3B7EB4A4F3
 for <kvmarm@lists.cs.columbia.edu>; Thu, 30 May 2019 11:14:21 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c57sPSCNmipT for <kvmarm@lists.cs.columbia.edu>;
 Thu, 30 May 2019 11:14:19 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E32694A4FD
 for <kvmarm@lists.cs.columbia.edu>; Thu, 30 May 2019 11:14:18 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CAB5165C;
 Thu, 30 May 2019 08:14:18 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E2E493F59C;
 Thu, 30 May 2019 08:14:16 -0700 (PDT)
From: Dave Martin <Dave.Martin@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH kvmtool v3 8/9] arm64: Add SVE support
Date: Thu, 30 May 2019 16:13:13 +0100
Message-Id: <1559229194-3036-9-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1559229194-3036-1-git-send-email-Dave.Martin@arm.com>
References: <1559229194-3036-1-git-send-email-Dave.Martin@arm.com>
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

This patch adds --enable-sve/--disable-sve command line options to
allow the user to control whether the Scalable Vector Extension is
made available to the guest.

This requires use of the new KVM_ARM_VCPU_FINALIZE ioctl before the
vcpu is runnable, so a new hook kvm_cpu__configure_features() is
added to provide an appropriate place to do this work.

By default, SVE is enabled for the guest if the host supports it.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arm/aarch32/include/kvm/kvm-cpu-arch.h    |  4 +++
 arm/aarch64/include/kvm/kvm-config-arch.h |  6 ++++-
 arm/aarch64/include/kvm/kvm-cpu-arch.h    |  1 +
 arm/aarch64/kvm-cpu.c                     | 41 +++++++++++++++++++++++++++++++
 arm/include/arm-common/kvm-config-arch.h  |  2 ++
 arm/kvm-cpu.c                             |  3 +++
 6 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/arm/aarch32/include/kvm/kvm-cpu-arch.h b/arm/aarch32/include/kvm/kvm-cpu-arch.h
index 01983f0..780e0e2 100644
--- a/arm/aarch32/include/kvm/kvm-cpu-arch.h
+++ b/arm/aarch32/include/kvm/kvm-cpu-arch.h
@@ -15,5 +15,9 @@
 
 static inline void kvm_cpu__select_features(struct kvm *kvm,
 					    struct kvm_vcpu_init *init) { }
+static inline int kvm_cpu__configure_features(struct kvm_cpu *vcpu)
+{
+	return 0;
+}
 
 #endif /* KVM__KVM_CPU_ARCH_H */
diff --git a/arm/aarch64/include/kvm/kvm-config-arch.h b/arm/aarch64/include/kvm/kvm-config-arch.h
index fe1699d..41e9d05 100644
--- a/arm/aarch64/include/kvm/kvm-config-arch.h
+++ b/arm/aarch64/include/kvm/kvm-config-arch.h
@@ -12,7 +12,11 @@
 	OPT_BOOLEAN('\0', "enable-ptrauth", &(cfg)->enable_ptrauth,	\
 			"Enable pointer authentication for the guest"),	\
 	OPT_BOOLEAN('\0', "disable-ptrauth", &(cfg)->disable_ptrauth,	\
-			"Disable pointer authentication for the guest"),
+			"Disable pointer authentication for the guest"), \
+	OPT_BOOLEAN('\0', "enable-sve", &(cfg)->enable_sve,		\
+			"Enable SVE for the guest"),			\
+	OPT_BOOLEAN('\0', "disable-sve", &(cfg)->disable_sve,		\
+			"Disable SVE for the guest"),
 
 #include "arm-common/kvm-config-arch.h"
 
diff --git a/arm/aarch64/include/kvm/kvm-cpu-arch.h b/arm/aarch64/include/kvm/kvm-cpu-arch.h
index e6875fc..8dfb82e 100644
--- a/arm/aarch64/include/kvm/kvm-cpu-arch.h
+++ b/arm/aarch64/include/kvm/kvm-cpu-arch.h
@@ -18,5 +18,6 @@
 #define ARM_CPU_CTRL_SCTLR_EL1	0
 
 void kvm_cpu__select_features(struct kvm *kvm, struct kvm_vcpu_init *init);
+int kvm_cpu__configure_features(struct kvm_cpu *vcpu);
 
 #endif /* KVM__KVM_CPU_ARCH_H */
diff --git a/arm/aarch64/kvm-cpu.c b/arm/aarch64/kvm-cpu.c
index 08e4fd5..cdfb22e 100644
--- a/arm/aarch64/kvm-cpu.c
+++ b/arm/aarch64/kvm-cpu.c
@@ -152,9 +152,50 @@ static void select_ptrauth_feature(struct kvm *kvm, struct kvm_vcpu_init *init)
 	}
 }
 
+static void select_sve_feature(struct kvm *kvm, struct kvm_vcpu_init *init)
+{
+	bool supported;
+
+	if (kvm->cfg.arch.enable_sve && kvm->cfg.arch.disable_sve)
+		die("--enable-sve conflicts with --disable-sve");
+
+	supported = kvm__supports_extension(kvm, KVM_CAP_ARM_SVE);
+
+	if (kvm->cfg.arch.enable_sve && !supported)
+		die("--enable-sve not supported on this host");
+
+	/* Default SVE to on if available and not explicitly disabled */
+	if (supported && !kvm->cfg.arch.disable_sve) {
+		kvm->cfg.arch.enable_sve = true;
+		init->features[0] |= 1UL << KVM_ARM_VCPU_SVE;
+	}
+}
+
 void kvm_cpu__select_features(struct kvm *kvm, struct kvm_vcpu_init *init)
 {
 	select_ptrauth_feature(kvm, init);
+	select_sve_feature(kvm, init);
+}
+
+static int configure_sve(struct kvm_cpu *vcpu)
+{
+	int feature = KVM_ARM_VCPU_SVE;
+
+	if (ioctl(vcpu->vcpu_fd, KVM_ARM_VCPU_FINALIZE, &feature)) {
+		pr_err("KVM_ARM_VCPU_FINALIZE: %s", strerror(errno));
+		return -1;
+	}
+
+	return 0;
+}
+
+int kvm_cpu__configure_features(struct kvm_cpu *vcpu)
+{
+	if (vcpu->kvm->cfg.arch.enable_sve)
+		if (configure_sve(vcpu))
+			return -1;
+
+	return 0;
 }
 
 void kvm_cpu__reset_vcpu(struct kvm_cpu *vcpu)
diff --git a/arm/include/arm-common/kvm-config-arch.h b/arm/include/arm-common/kvm-config-arch.h
index 1b4287d..40e3d1f 100644
--- a/arm/include/arm-common/kvm-config-arch.h
+++ b/arm/include/arm-common/kvm-config-arch.h
@@ -10,6 +10,8 @@ struct kvm_config_arch {
 	bool		aarch32_guest;
 	bool		has_pmuv3;
 	u64		kaslr_seed;
+	bool		enable_sve;
+	bool		disable_sve;
 	bool		enable_ptrauth;
 	bool		disable_ptrauth;
 	enum irqchip_type irqchip;
diff --git a/arm/kvm-cpu.c b/arm/kvm-cpu.c
index 1652f6f..554414f 100644
--- a/arm/kvm-cpu.c
+++ b/arm/kvm-cpu.c
@@ -124,6 +124,9 @@ struct kvm_cpu *kvm_cpu__arch_init(struct kvm *kvm, unsigned long cpu_id)
 	vcpu->cpu_compatible	= target->compatible;
 	vcpu->is_running	= true;
 
+	if (kvm_cpu__configure_features(vcpu))
+		die("Unable to configure requested vcpu features");
+
 	return vcpu;
 }
 
-- 
2.1.4

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
