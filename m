Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E97336169AF
	for <lists+kvmarm@lfdr.de>; Wed,  2 Nov 2022 17:49:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 672384B957;
	Wed,  2 Nov 2022 12:49:39 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered)
	header.i=@bytedance-com.20210112.gappssmtp.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bxeNyxbgtgOW; Wed,  2 Nov 2022 12:49:37 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C1A294B9B8;
	Wed,  2 Nov 2022 12:49:31 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C6BE74B93C
 for <kvmarm@lists.cs.columbia.edu>; Wed,  2 Nov 2022 12:14:23 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J0GbxaXJH2vJ for <kvmarm@lists.cs.columbia.edu>;
 Wed,  2 Nov 2022 12:14:22 -0400 (EDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 11A324B253
 for <kvmarm@lists.cs.columbia.edu>; Wed,  2 Nov 2022 12:14:22 -0400 (EDT)
Received: by mail-wr1-f53.google.com with SMTP id o4so25285453wrq.6
 for <kvmarm@lists.cs.columbia.edu>; Wed, 02 Nov 2022 09:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EaThpoMVaFl0QB0/xxue6bY+3/zanrsG0afAZvdjiZ0=;
 b=spTp/DlXnI60ni3Djan9ttwigvFYnBNSfSuXfvMpS5uAlTc9tdszyUI74P4PNgl5bS
 tVxI/GOuePoOBmVGcvqaLMPPRQsNlTUf/mSw+aLjiJNSPvuqeWKUP15NfiQ8GgILxiV9
 VR1JtGHqO3xJsrqzXdWVn+owfFlRNeqldEl2PCH9gCqTxPbM82FfhMfHp374TsnfVTjd
 9M2K9Epu8HY4lbLzDpp4bqvB6mo0hrHkZjQ5jRgTCMl7jSHV+MVxjXak31Ztp90rvWD4
 27sEEmqjtiuHwqOoTeUIPqVIEAh0QQTSZNpbhRjIXSUflBvOkptHsTp75Ae69qTOI1HP
 ap2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EaThpoMVaFl0QB0/xxue6bY+3/zanrsG0afAZvdjiZ0=;
 b=Fj4NkbiQ/lUhG53UeL83F1L8mYvFUXeJDrosgvINblP5qRmujkIrZ5zr7nGG6WtZrA
 Sc32v9LKUMfmyiz6yEnf/OWYBIYmbaxDam1IO02t84pPuWqHg6XWiJitlYfltQkeLuwC
 dF+AHziRuuftSRz+jFZlwOYox5CUNIeQWLYJ5si45IRZdkPqUaYy/jSCuSh/U9eEjO2w
 IY0htC9vu5vW+FIRBWGKYfR6Uvb5w+V0KjI1iBT9DAiLfaxx+Jc3YunedGtSq3k+BABU
 JBvdTbUsLebPFnwtnmBcZpjE2U3uN0dBN0nuHxNQQnsdsblJG3XKh1ke6g/B0LxLL8Ya
 Lryw==
X-Gm-Message-State: ACrzQf12vjF6nuZuKc0vk10VLJEQS5Bi8L6ly4sv6ocFt8gozmLNRX8B
 8AgffFXY10A09FSMo7Me4a8TCA==
X-Google-Smtp-Source: AMsMyM7NB7e3wjYJr4ceDBvjBR4Zfz+rOu9ecq8PU/bSrOZaFDhsKHYTmiwPGmvorqKtVWJYbo4M9Q==
X-Received: by 2002:a5d:6e0b:0:b0:236:f48d:e80b with SMTP id
 h11-20020a5d6e0b000000b00236f48de80bmr2249689wrz.116.1667405660987; 
 Wed, 02 Nov 2022 09:14:20 -0700 (PDT)
Received: from usaari01.cust.communityfibre.co.uk
 ([2a02:6b6a:b4d7:0:6a08:9b26:ab04:7065])
 by smtp.gmail.com with ESMTPSA id
 m17-20020a5d56d1000000b0022cc6b8df5esm13230923wrw.7.2022.11.02.09.14.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Nov 2022 09:14:20 -0700 (PDT)
From: Usama Arif <usama.arif@bytedance.com>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 linux-doc@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux@armlinux.org.uk, yezengruan@huawei.com, catalin.marinas@arm.com,
 will@kernel.org, maz@kernel.org, steven.price@arm.com, mark.rutland@arm.com
Subject: [RFC 3/6] KVM: arm64: Support pvlock preempted via shared structure
Date: Wed,  2 Nov 2022 16:13:37 +0000
Message-Id: <20221102161340.2982090-4-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221102161340.2982090-1-usama.arif@bytedance.com>
References: <20221102161340.2982090-1-usama.arif@bytedance.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 02 Nov 2022 12:49:29 -0400
Cc: punit.agrawal@bytedance.com, fam.zheng@bytedance.com, liangma@liangbit.com,
 Usama Arif <usama.arif@bytedance.com>
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

Implement the service call for configuring a shared structure between a
VCPU and the hypervisor in which the hypervisor can tell whether the
VCPU is running or not.

The preempted field is zero if the VCPU is not preempted.
Any other value means the VCPU has been preempted.

Signed-off-by: Zengruan Ye <yezengruan@huawei.com>
Signed-off-by: Usama Arif <usama.arif@bytedance.com>
---
 Documentation/virt/kvm/arm/hypercalls.rst |  3 ++
 arch/arm64/include/asm/kvm_host.h         | 18 ++++++++++
 arch/arm64/include/uapi/asm/kvm.h         |  1 +
 arch/arm64/kvm/Makefile                   |  2 +-
 arch/arm64/kvm/arm.c                      |  8 +++++
 arch/arm64/kvm/hypercalls.c               | 36 +++++++++++++++++++
 arch/arm64/kvm/pvlock.c                   | 43 +++++++++++++++++++++++
 arch/arm64/kvm/pvtime.c                   | 16 ---------
 tools/arch/arm64/include/uapi/asm/kvm.h   |  1 +
 tools/include/linux/arm-smccc.h           | 13 +++++++
 10 files changed, 124 insertions(+), 17 deletions(-)
 create mode 100644 arch/arm64/kvm/pvlock.c

diff --git a/Documentation/virt/kvm/arm/hypercalls.rst b/Documentation/virt/kvm/arm/hypercalls.rst
index 3e23084644ba..872a16226ace 100644
--- a/Documentation/virt/kvm/arm/hypercalls.rst
+++ b/Documentation/virt/kvm/arm/hypercalls.rst
@@ -127,6 +127,9 @@ The pseudo-firmware bitmap register are as follows:
     Bit-1: KVM_REG_ARM_VENDOR_HYP_BIT_PTP:
       The bit represents the Precision Time Protocol KVM service.
 
+    Bit-2: KVM_REG_ARM_VENDOR_HYP_BIT_PV_LOCK:
+      The bit represents the Paravirtualized lock service.
+
 Errors:
 
     =======  =============================================================
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 45e2136322ba..18303b30b7e9 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -417,6 +417,11 @@ struct kvm_vcpu_arch {
 		u64 last_steal;
 		gpa_t base;
 	} steal;
+
+	/* Guest PV lock state */
+	struct {
+		gpa_t base;
+	} pv;
 };
 
 /*
@@ -840,6 +845,19 @@ static inline bool kvm_arm_is_pvtime_enabled(struct kvm_vcpu_arch *vcpu_arch)
 	return (vcpu_arch->steal.base != GPA_INVALID);
 }
 
+static inline void kvm_arm_pvlock_preempted_init(struct kvm_vcpu_arch *vcpu_arch)
+{
+	vcpu_arch->pv.base = GPA_INVALID;
+}
+
+static inline bool kvm_arm_is_pvlock_preempted_ready(struct kvm_vcpu_arch *vcpu_arch)
+{
+	return (vcpu_arch->pv.base != GPA_INVALID);
+}
+
+gpa_t kvm_init_pvlock(struct kvm_vcpu *vcpu);
+void kvm_update_pvlock_preempted(struct kvm_vcpu *vcpu, u64 preempted);
+
 void kvm_set_sei_esr(struct kvm_vcpu *vcpu, u64 syndrome);
 
 struct kvm_vcpu *kvm_mpidr_to_vcpu(struct kvm *kvm, unsigned long mpidr);
diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index 316917b98707..bd05ece5c590 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -365,6 +365,7 @@ enum {
 enum {
 	KVM_REG_ARM_VENDOR_HYP_BIT_FUNC_FEAT	= 0,
 	KVM_REG_ARM_VENDOR_HYP_BIT_PTP		= 1,
+	KVM_REG_ARM_VENDOR_HYP_BIT_PV_LOCK	= 2,
 #ifdef __KERNEL__
 	KVM_REG_ARM_VENDOR_HYP_BMAP_BIT_COUNT,
 #endif
diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index 5e33c2d4645a..e1f711885916 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -10,7 +10,7 @@ include $(srctree)/virt/kvm/Makefile.kvm
 obj-$(CONFIG_KVM) += kvm.o
 obj-$(CONFIG_KVM) += hyp/
 
-kvm-y += arm.o mmu.o mmio.o psci.o hypercalls.o pvtime.o \
+kvm-y += arm.o mmu.o mmio.o psci.o hypercalls.o pvtime.o pvlock.o \
 	 inject_fault.o va_layout.o handle_exit.o \
 	 guest.o debug.o reset.o sys_regs.o stacktrace.o \
 	 vgic-sys-reg-v3.o fpsimd.o pkvm.o \
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 94d33e296e10..73da4ac859fd 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -345,6 +345,8 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 
 	kvm_arm_pvtime_vcpu_init(&vcpu->arch);
 
+	kvm_arm_pvlock_preempted_init(&vcpu->arch);
+
 	vcpu->arch.hw_mmu = &vcpu->kvm->arch.mmu;
 
 	err = kvm_vgic_vcpu_init(vcpu);
@@ -420,6 +422,10 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 
 	if (vcpu_has_ptrauth(vcpu))
 		vcpu_ptrauth_disable(vcpu);
+
+	if (kvm_arm_is_pvlock_preempted_ready(&vcpu->arch))
+		kvm_update_pvlock_preempted(vcpu, 0);
+
 	kvm_arch_vcpu_load_debug_state_flags(vcpu);
 
 	if (!cpumask_test_cpu(smp_processor_id(), vcpu->kvm->arch.supported_cpus))
@@ -433,6 +439,8 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 	if (has_vhe())
 		kvm_vcpu_put_sysregs_vhe(vcpu);
 	kvm_timer_vcpu_put(vcpu);
+	if (kvm_arm_is_pvlock_preempted_ready(&vcpu->arch))
+		kvm_update_pvlock_preempted(vcpu, 1);
 	kvm_vgic_put(vcpu);
 	kvm_vcpu_pmu_restore_host(vcpu);
 	kvm_arm_vmid_clear_active();
diff --git a/arch/arm64/kvm/hypercalls.c b/arch/arm64/kvm/hypercalls.c
index c9f401fa01a9..263500c4f20e 100644
--- a/arch/arm64/kvm/hypercalls.c
+++ b/arch/arm64/kvm/hypercalls.c
@@ -93,6 +93,27 @@ static bool kvm_hvc_call_default_allowed(u32 func_id)
 	}
 }
 
+long kvm_hypercall_pv_features(struct kvm_vcpu *vcpu)
+{
+	u32 feature = smccc_get_arg1(vcpu);
+	long val = SMCCC_RET_NOT_SUPPORTED;
+
+	switch (feature) {
+	case ARM_SMCCC_HV_PV_TIME_FEATURES:
+	case ARM_SMCCC_HV_PV_TIME_ST:
+		if (vcpu->arch.steal.base != GPA_INVALID)
+			val = SMCCC_RET_SUCCESS;
+		break;
+	case ARM_SMCCC_HV_PV_LOCK_FEATURES:
+	case ARM_SMCCC_HV_PV_LOCK_PREEMPTED:
+		if (vcpu->arch.pv.base != GPA_INVALID)
+			val = SMCCC_RET_SUCCESS;
+		break;
+	}
+
+	return val;
+}
+
 static bool kvm_hvc_call_allowed(struct kvm_vcpu *vcpu, u32 func_id)
 {
 	struct kvm_smccc_features *smccc_feat = &vcpu->kvm->arch.smccc_feat;
@@ -109,6 +130,10 @@ static bool kvm_hvc_call_allowed(struct kvm_vcpu *vcpu, u32 func_id)
 	case ARM_SMCCC_HV_PV_TIME_ST:
 		return test_bit(KVM_REG_ARM_STD_HYP_BIT_PV_TIME,
 				&smccc_feat->std_hyp_bmap);
+	case ARM_SMCCC_HV_PV_LOCK_FEATURES:
+	case ARM_SMCCC_HV_PV_LOCK_PREEMPTED:
+		return test_bit(KVM_REG_ARM_VENDOR_HYP_BIT_PV_LOCK,
+				&smccc_feat->vendor_hyp_bmap);
 	case ARM_SMCCC_VENDOR_HYP_KVM_FEATURES_FUNC_ID:
 	case ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID:
 		return test_bit(KVM_REG_ARM_VENDOR_HYP_BIT_FUNC_FEAT,
@@ -191,9 +216,15 @@ int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
 				     &smccc_feat->std_hyp_bmap))
 				val[0] = SMCCC_RET_SUCCESS;
 			break;
+		case ARM_SMCCC_HV_PV_LOCK_FEATURES:
+			if (test_bit(KVM_REG_ARM_VENDOR_HYP_BIT_PV_LOCK,
+				     &smccc_feat->vendor_hyp_bmap))
+				val[0] = SMCCC_RET_SUCCESS;
+			break;
 		}
 		break;
 	case ARM_SMCCC_HV_PV_TIME_FEATURES:
+	case ARM_SMCCC_HV_PV_LOCK_FEATURES:
 		val[0] = kvm_hypercall_pv_features(vcpu);
 		break;
 	case ARM_SMCCC_HV_PV_TIME_ST:
@@ -201,6 +232,11 @@ int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
 		if (gpa != GPA_INVALID)
 			val[0] = gpa;
 		break;
+	case ARM_SMCCC_HV_PV_LOCK_PREEMPTED:
+		gpa = kvm_init_pvlock(vcpu);
+		if (gpa != GPA_INVALID)
+			val[0] = gpa;
+		break;
 	case ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID:
 		val[0] = ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_0;
 		val[1] = ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_1;
diff --git a/arch/arm64/kvm/pvlock.c b/arch/arm64/kvm/pvlock.c
new file mode 100644
index 000000000000..3eb35ab31481
--- /dev/null
+++ b/arch/arm64/kvm/pvlock.c
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright(c) 2019 Huawei Technologies Co., Ltd
+ * Author: Zengruan Ye <yezengruan@huawei.com>
+ *         Usama Arif <usama.arif@bytedance.com>
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/kvm_host.h>
+
+#include <asm/pvlock-abi.h>
+
+#include <kvm/arm_hypercalls.h>
+
+gpa_t kvm_init_pvlock(struct kvm_vcpu *vcpu)
+{
+	struct pvlock_vcpu_state init_values = {};
+	struct kvm *kvm = vcpu->kvm;
+	u64 base = vcpu->arch.pv.base;
+	int idx;
+
+	if (base == GPA_INVALID)
+		return base;
+
+	idx = srcu_read_lock(&kvm->srcu);
+	kvm_write_guest(kvm, base, &init_values, sizeof(init_values));
+	srcu_read_unlock(&kvm->srcu, idx);
+
+	return base;
+}
+
+void kvm_update_pvlock_preempted(struct kvm_vcpu *vcpu, u64 preempted)
+{
+	int idx;
+	u64 offset;
+	struct kvm *kvm = vcpu->kvm;
+	u64 base = vcpu->arch.pv.base;
+
+	idx = srcu_read_lock(&kvm->srcu);
+	offset = offsetof(struct pvlock_vcpu_state, preempted);
+	kvm_put_guest(kvm, base + offset, cpu_to_le64(preempted));
+	srcu_read_unlock(&kvm->srcu, idx);
+}
diff --git a/arch/arm64/kvm/pvtime.c b/arch/arm64/kvm/pvtime.c
index 78a09f7a6637..ab130f02cdc6 100644
--- a/arch/arm64/kvm/pvtime.c
+++ b/arch/arm64/kvm/pvtime.c
@@ -32,22 +32,6 @@ void kvm_update_stolen_time(struct kvm_vcpu *vcpu)
 	srcu_read_unlock(&kvm->srcu, idx);
 }
 
-long kvm_hypercall_pv_features(struct kvm_vcpu *vcpu)
-{
-	u32 feature = smccc_get_arg1(vcpu);
-	long val = SMCCC_RET_NOT_SUPPORTED;
-
-	switch (feature) {
-	case ARM_SMCCC_HV_PV_TIME_FEATURES:
-	case ARM_SMCCC_HV_PV_TIME_ST:
-		if (vcpu->arch.steal.base != GPA_INVALID)
-			val = SMCCC_RET_SUCCESS;
-		break;
-	}
-
-	return val;
-}
-
 gpa_t kvm_init_stolen_time(struct kvm_vcpu *vcpu)
 {
 	struct pvclock_vcpu_stolen_time init_values = {};
diff --git a/tools/arch/arm64/include/uapi/asm/kvm.h b/tools/arch/arm64/include/uapi/asm/kvm.h
index 316917b98707..bd05ece5c590 100644
--- a/tools/arch/arm64/include/uapi/asm/kvm.h
+++ b/tools/arch/arm64/include/uapi/asm/kvm.h
@@ -365,6 +365,7 @@ enum {
 enum {
 	KVM_REG_ARM_VENDOR_HYP_BIT_FUNC_FEAT	= 0,
 	KVM_REG_ARM_VENDOR_HYP_BIT_PTP		= 1,
+	KVM_REG_ARM_VENDOR_HYP_BIT_PV_LOCK	= 2,
 #ifdef __KERNEL__
 	KVM_REG_ARM_VENDOR_HYP_BMAP_BIT_COUNT,
 #endif
diff --git a/tools/include/linux/arm-smccc.h b/tools/include/linux/arm-smccc.h
index 63ce9bebccd3..82b4fd050dd7 100644
--- a/tools/include/linux/arm-smccc.h
+++ b/tools/include/linux/arm-smccc.h
@@ -150,6 +150,19 @@
 			   ARM_SMCCC_OWNER_STANDARD_HYP,	\
 			   0x21)
 
+/* Paravirtualised lock calls */
+#define ARM_SMCCC_HV_PV_LOCK_FEATURES				\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,			\
+			   ARM_SMCCC_SMC_64,			\
+			   ARM_SMCCC_OWNER_VENDOR_HYP,		\
+			   0x20)
+
+#define ARM_SMCCC_HV_PV_LOCK_PREEMPTED				\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,			\
+			   ARM_SMCCC_SMC_64,			\
+			   ARM_SMCCC_OWNER_VENDOR_HYP,		\
+			   0x21)
+
 /* TRNG entropy source calls (defined by ARM DEN0098) */
 #define ARM_SMCCC_TRNG_VERSION					\
 	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,			\
-- 
2.25.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
