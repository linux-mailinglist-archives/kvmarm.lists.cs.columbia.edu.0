Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9874C6190E8
	for <lists+kvmarm@lfdr.de>; Fri,  4 Nov 2022 07:21:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 16B624B177;
	Fri,  4 Nov 2022 02:21:22 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered)
	header.i=@bytedance-com.20210112.gappssmtp.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zp1blvcaOhsh; Fri,  4 Nov 2022 02:21:21 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5EC704B1C6;
	Fri,  4 Nov 2022 02:21:20 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 667E949F37
 for <kvmarm@lists.cs.columbia.edu>; Fri,  4 Nov 2022 02:21:19 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UgGPIPxDNOv7 for <kvmarm@lists.cs.columbia.edu>;
 Fri,  4 Nov 2022 02:21:18 -0400 (EDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id EC0A149F49
 for <kvmarm@lists.cs.columbia.edu>; Fri,  4 Nov 2022 02:21:16 -0400 (EDT)
Received: by mail-wm1-f52.google.com with SMTP id o30so2442351wms.2
 for <kvmarm@lists.cs.columbia.edu>; Thu, 03 Nov 2022 23:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wHZXYM04ZGQ9OHStAmI9lRcnUZ9NDhKkDvLjK3ObtzA=;
 b=3QT/xQubuZA6Vs6jiqa3hZn6ke2IqrkTHOvS3SW8vKrHozzfWz2RWTYcl9LovuMVzf
 zUZwjtE7nopeNe7NxXgvxFs+wXt1De+8JglBXtAiXmAwa2juSMFo8NZ/jo1urMje7F1Q
 hKBei0wPdHOfcjOrjWQCpxuUhgxqS56yEmgRn6lhGbc3e2fXS2xx4O8TmBND/KlCCSx1
 m7k5TMN2KyldIPNKYNIF/j0i2c0GqO2AP2QJ1mDeRYnATIPFbPqUOqUQ2vHCH5nHdg1y
 r4ngnW8aFN+Eb6zi3VZF6/laEa9vMjBQZOhk/JL+3OEXJ5qCCkXBRL1j87waI/Z8qSJ6
 ogEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wHZXYM04ZGQ9OHStAmI9lRcnUZ9NDhKkDvLjK3ObtzA=;
 b=RhZfIYkP8Zo4LktntAroeY57E24G2OJlKYkds+uD0kxxNyaG2KSkDJyxc7CeMKuVas
 /sRVl8Rn3eZOVlEVfXV0yNcc5mGy9niXWtKFjs5Sxn7juDUNvDJC0vou23cU5b2P3G47
 4g9ZjS/qZJSVLD5qnIkOriZTE1IqRySEbQ8yZqr6FSir8vaaa++zSMYdhhq4tkknDkGw
 YVWmT+NkCNFR68V7MURTZlPEf+TfvGIT1IddNqGnYPVfuGVcoFXlWmH+2mo19fKe/59n
 bFjMTXc2M5hk2vi596hbDCH0NKZQWcdNjuCyL0klXTl55HdB/5hNl2DtY0TnVBElsxUo
 HS0Q==
X-Gm-Message-State: ACrzQf3KcNqm79ASI3nVB0vMNBE1Y54F/JV2adldK/dBDcuc8Gbj4T+P
 4CsQB7Me3JOQ0kyrrLA/GIGC5A==
X-Google-Smtp-Source: AMsMyM66zHsoqah5QZKHinY8z2yI7CQl+8Fd8BHeMGAuCqk1UfqGOwz9vo+XxRps/CcOtEqwTIu0eQ==
X-Received: by 2002:a05:600c:1f17:b0:3ce:1f81:d9fa with SMTP id
 bd23-20020a05600c1f1700b003ce1f81d9famr22643071wmb.138.1667542876655; 
 Thu, 03 Nov 2022 23:21:16 -0700 (PDT)
Received: from usaari01.cust.communityfibre.co.uk
 ([2a02:6b6a:b4d7:0:c7c:f931:dd4c:1ea6])
 by smtp.gmail.com with ESMTPSA id
 w11-20020a5d608b000000b002366f9bd717sm3099924wrt.45.2022.11.03.23.21.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Nov 2022 23:21:16 -0700 (PDT)
From: Usama Arif <usama.arif@bytedance.com>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 linux-doc@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux@armlinux.org.uk, yezengruan@huawei.com, catalin.marinas@arm.com,
 will@kernel.org, maz@kernel.org, steven.price@arm.com,
 mark.rutland@arm.com, bagasdotme@gmail.com
Subject: [v2 3/6] KVM: arm64: Support pvlock preempted via shared structure
Date: Fri,  4 Nov 2022 06:21:02 +0000
Message-Id: <20221104062105.4119003-4-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221104062105.4119003-1-usama.arif@bytedance.com>
References: <20221104062105.4119003-1-usama.arif@bytedance.com>
MIME-Version: 1.0
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
 arch/arm64/kvm/hypercalls.c               |  8 +++++
 arch/arm64/kvm/pvlock.c                   | 43 +++++++++++++++++++++++
 tools/arch/arm64/include/uapi/asm/kvm.h   |  1 +
 8 files changed, 83 insertions(+), 1 deletion(-)
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
index c9f401fa01a9..ec85b4b2a272 100644
--- a/arch/arm64/kvm/hypercalls.c
+++ b/arch/arm64/kvm/hypercalls.c
@@ -116,6 +116,9 @@ static bool kvm_hvc_call_allowed(struct kvm_vcpu *vcpu, u32 func_id)
 	case ARM_SMCCC_VENDOR_HYP_KVM_PTP_FUNC_ID:
 		return test_bit(KVM_REG_ARM_VENDOR_HYP_BIT_PTP,
 				&smccc_feat->vendor_hyp_bmap);
+	case ARM_SMCCC_VENDOR_HYP_KVM_PV_LOCK_FUNC_ID:
+		return test_bit(KVM_REG_ARM_VENDOR_HYP_BIT_PV_LOCK,
+				&smccc_feat->vendor_hyp_bmap);
 	default:
 		return kvm_hvc_call_default_allowed(func_id);
 	}
@@ -201,6 +204,11 @@ int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
 		if (gpa != GPA_INVALID)
 			val[0] = gpa;
 		break;
+	case ARM_SMCCC_VENDOR_HYP_KVM_PV_LOCK_FUNC_ID:
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
-- 
2.25.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
