Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0094D50C545
	for <lists+kvmarm@lfdr.de>; Sat, 23 Apr 2022 02:03:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 73C444B1D2;
	Fri, 22 Apr 2022 20:03:45 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.788
X-Spam-Level: 
X-Spam-Status: No, score=-1.788 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G0N2tY3ZKIn0; Fri, 22 Apr 2022 20:03:45 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C7A4F4B377;
	Fri, 22 Apr 2022 20:03:42 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 435C74B32A
 for <kvmarm@lists.cs.columbia.edu>; Fri, 22 Apr 2022 20:03:41 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rUaN5V3ZpTEb for <kvmarm@lists.cs.columbia.edu>;
 Fri, 22 Apr 2022 20:03:39 -0400 (EDT)
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com
 [209.85.214.202])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 55DB949EE3
 for <kvmarm@lists.cs.columbia.edu>; Fri, 22 Apr 2022 20:03:39 -0400 (EDT)
Received: by mail-pl1-f202.google.com with SMTP id
 q6-20020a170902eb8600b001588e49dcaaso5586640plg.9
 for <kvmarm@lists.cs.columbia.edu>; Fri, 22 Apr 2022 17:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=P/ZL2r8NWQTvX0bYy9sORfC4MQgkpXztcNZXjCyduhU=;
 b=R1EWqDSFydOImfDWedtKU3GRZpanWEGcHxK/9shuU/mwi9U52mHKvMZxvZEkdE2lwL
 io1eO6sLScvNks94FbDw+md88f3IerldcqGTg1v3vCry6Gs2a5ly5tdCBJ0S1zWj8I5x
 0PaJNF7AqzOEN3hztLcDm2fMVoLFDXPxDfQ7E4xOP7+h7/FIHRx+LdKw/7/RrNwpjKrA
 240Cl94jFiEMR8batoeW6YlQuZNAzDDJrsxPmOpVFIINEnxqm0L0+O+gvGR+7Gdh57xu
 AIZFZkSMiWAY/5WPOS7oCBFoWgU3hw+wHPfMssqjlOvuC0VWGkhRqpXvxkIi7AZbaStd
 yDnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=P/ZL2r8NWQTvX0bYy9sORfC4MQgkpXztcNZXjCyduhU=;
 b=yipbnTb1wnl+x0AqWOkXdR0ei+yEneBpNAdhhP4cs7M/fuzIQ4GRZSxOsNKyuVuvaV
 30IxFvMYbkO+bQH3K8CHRClJ/KkeQTaf2uFIb/wC7b3ayi2xWmp39ZxrrVZYqu3M0HoL
 g+1XIkeR6QjVMsKfPaJp9o4OZIMcWBC4XCpSnDizOFd+TZQSS1YmjBoboDkow+w0nZNd
 aDv+zXfoUyiQ3O5/Gm1zOYSi+s76jwfDH0cEoDHtJOoTDAi/a+nsS+eOXBA/EHg1FmsH
 nY13Bhq4zCr+AETFmjyzIL/kDBfVhWFxll4X8qxfn4jtu8fdQKvmw3t3fFhgaez1BD5/
 /qPg==
X-Gm-Message-State: AOAM5316aOPbE1xjuiHdpBdXyv7DNrhCcLuNAwc2MDkipLw4Vr3tx+p2
 kJwD9Zu3jbMG938W2frutAFcnmShgHOU
X-Google-Smtp-Source: ABdhPJwZRKRhjeb8mEs3XNQ/nx6tTTHRzRJarXMMeeTkuNqqBuKH7eSARG/1lFswPqdKw28Ofh1H6UJmy23f
X-Received: from rananta-virt.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:1bcc])
 (user=rananta job=sendgmr) by 2002:a05:6a00:10cc:b0:4fe:3f1c:2d1 with SMTP id
 d12-20020a056a0010cc00b004fe3f1c02d1mr7567246pfu.0.1650672218462; Fri, 22 Apr
 2022 17:03:38 -0700 (PDT)
Date: Sat, 23 Apr 2022 00:03:21 +0000
In-Reply-To: <20220423000328.2103733-1-rananta@google.com>
Message-Id: <20220423000328.2103733-3-rananta@google.com>
Mime-Version: 1.0
References: <20220423000328.2103733-1-rananta@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v6 2/9] KVM: arm64: Setup a framework for hypercall bitmap
 firmware registers
From: Raghavendra Rao Ananta <rananta@google.com>
To: Marc Zyngier <maz@kernel.org>, Andrew Jones <drjones@redhat.com>, 
 James Morse <james.morse@arm.com>, Alexandru Elisei <alexandru.elisei@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Peter Shier <pshier@google.com>, linux-kernel@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

KVM regularly introduces new hypercall services to the guests without
any consent from the userspace. This means, the guests can observe
hypercall services in and out as they migrate across various host
kernel versions. This could be a major problem if the guest
discovered a hypercall, started using it, and after getting migrated
to an older kernel realizes that it's no longer available. Depending
on how the guest handles the change, there's a potential chance that
the guest would just panic.

As a result, there's a need for the userspace to elect the services
that it wishes the guest to discover. It can elect these services
based on the kernels spread across its (migration) fleet. To remedy
this, extend the existing firmware pseudo-registers, such as
KVM_REG_ARM_PSCI_VERSION, but by creating a new COPROC register space
for all the hypercall services available.

These firmware registers are categorized based on the service call
owners, but unlike the existing firmware pseudo-registers, they hold
the features supported in the form of a bitmap.

During the VM initialization, the registers are set to upper-limit of
the features supported by the corresponding registers. It's expected
that the VMMs discover the features provided by each register via
GET_ONE_REG, and write back the desired values using SET_ONE_REG.
KVM allows this modification only until the VM has started.

Some of the standard features are not mapped to any bits of the
registers. But since they can recreate the original problem of
making it available without userspace's consent, they need to
be explicitly added to the case-list in
kvm_hvc_call_default_allowed(). Any function-id that's not enabled
via the bitmap, or not listed in kvm_hvc_call_default_allowed, will
be returned as SMCCC_RET_NOT_SUPPORTED to the guest.

Older userspace code can simply ignore the feature and the
hypercall services will be exposed unconditionally to the guests,
thus ensuring backward compatibility.

In this patch, the framework adds the register only for ARM's standard
secure services (owner value 4). Currently, this includes support only
for ARM True Random Number Generator (TRNG) service, with bit-0 of the
register representing mandatory features of v1.0. Other services are
momentarily added in the upcoming patches.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 arch/arm64/include/asm/kvm_host.h | 12 ++++
 arch/arm64/include/uapi/asm/kvm.h |  9 +++
 arch/arm64/kvm/arm.c              |  1 +
 arch/arm64/kvm/guest.c            |  8 ++-
 arch/arm64/kvm/hypercalls.c       | 94 +++++++++++++++++++++++++++++++
 arch/arm64/kvm/psci.c             | 13 +++++
 include/kvm/arm_hypercalls.h      |  6 ++
 include/kvm/arm_psci.h            |  2 +-
 8 files changed, 142 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 94a27a7520f4..df07f4c10197 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -101,6 +101,15 @@ struct kvm_s2_mmu {
 struct kvm_arch_memory_slot {
 };
 
+/**
+ * struct kvm_smccc_features: Descriptor the hypercall services exposed to the guests
+ *
+ * @std_bmap: Bitmap of standard secure service calls
+ */
+struct kvm_smccc_features {
+	unsigned long std_bmap;
+};
+
 struct kvm_arch {
 	struct kvm_s2_mmu mmu;
 
@@ -150,6 +159,9 @@ struct kvm_arch {
 
 	u8 pfr0_csv2;
 	u8 pfr0_csv3;
+
+	/* Hypercall features firmware registers' descriptor */
+	struct kvm_smccc_features smccc_feat;
 };
 
 struct kvm_vcpu_fault_info {
diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index c1b6ddc02d2f..0b79d2dc6ffd 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -332,6 +332,15 @@ struct kvm_arm_copy_mte_tags {
 #define KVM_ARM64_SVE_VLS_WORDS	\
 	((KVM_ARM64_SVE_VQ_MAX - KVM_ARM64_SVE_VQ_MIN) / 64 + 1)
 
+/* Bitmap feature firmware registers */
+#define KVM_REG_ARM_FW_FEAT_BMAP		(0x0016 << KVM_REG_ARM_COPROC_SHIFT)
+#define KVM_REG_ARM_FW_FEAT_BMAP_REG(r)		(KVM_REG_ARM64 | KVM_REG_SIZE_U64 | \
+						KVM_REG_ARM_FW_FEAT_BMAP |	\
+						((r) & 0xffff))
+
+#define KVM_REG_ARM_STD_BMAP			KVM_REG_ARM_FW_FEAT_BMAP_REG(0)
+#define KVM_REG_ARM_STD_BIT_TRNG_V1_0		0
+
 /* Device Control API: ARM VGIC */
 #define KVM_DEV_ARM_VGIC_GRP_ADDR	0
 #define KVM_DEV_ARM_VGIC_GRP_DIST_REGS	1
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 523bc934fe2f..a37fadbd617e 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -156,6 +156,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	kvm->arch.max_vcpus = kvm_arm_default_max_vcpus();
 
 	set_default_spectre(kvm);
+	kvm_arm_init_hypercalls(kvm);
 
 	return ret;
 out_free_stage2_pgd:
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 0d5cca56cbda..8c607199cad1 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -756,7 +756,9 @@ int kvm_arm_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 
 	switch (reg->id & KVM_REG_ARM_COPROC_MASK) {
 	case KVM_REG_ARM_CORE:	return get_core_reg(vcpu, reg);
-	case KVM_REG_ARM_FW:	return kvm_arm_get_fw_reg(vcpu, reg);
+	case KVM_REG_ARM_FW:
+	case KVM_REG_ARM_FW_FEAT_BMAP:
+		return kvm_arm_get_fw_reg(vcpu, reg);
 	case KVM_REG_ARM64_SVE:	return get_sve_reg(vcpu, reg);
 	}
 
@@ -774,7 +776,9 @@ int kvm_arm_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 
 	switch (reg->id & KVM_REG_ARM_COPROC_MASK) {
 	case KVM_REG_ARM_CORE:	return set_core_reg(vcpu, reg);
-	case KVM_REG_ARM_FW:	return kvm_arm_set_fw_reg(vcpu, reg);
+	case KVM_REG_ARM_FW:
+	case KVM_REG_ARM_FW_FEAT_BMAP:
+		return kvm_arm_set_fw_reg(vcpu, reg);
 	case KVM_REG_ARM64_SVE:	return set_sve_reg(vcpu, reg);
 	}
 
diff --git a/arch/arm64/kvm/hypercalls.c b/arch/arm64/kvm/hypercalls.c
index fa6d9378d8e7..df55a04d2fe8 100644
--- a/arch/arm64/kvm/hypercalls.c
+++ b/arch/arm64/kvm/hypercalls.c
@@ -58,6 +58,48 @@ static void kvm_ptp_get_time(struct kvm_vcpu *vcpu, u64 *val)
 	val[3] = lower_32_bits(cycles);
 }
 
+static bool kvm_arm_fw_reg_feat_enabled(unsigned long *reg_bmap, unsigned long feat_bit)
+{
+	return test_bit(feat_bit, reg_bmap);
+}
+
+static bool kvm_hvc_call_default_allowed(struct kvm_vcpu *vcpu, u32 func_id)
+{
+	switch (func_id) {
+	/*
+	 * List of function-ids that are not gated with the bitmapped feature
+	 * firmware registers, and are to be allowed for servicing the call by default.
+	 */
+	case ARM_SMCCC_VERSION_FUNC_ID:
+	case ARM_SMCCC_ARCH_FEATURES_FUNC_ID:
+	case ARM_SMCCC_HV_PV_TIME_FEATURES:
+	case ARM_SMCCC_HV_PV_TIME_ST:
+	case ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID:
+	case ARM_SMCCC_VENDOR_HYP_KVM_FEATURES_FUNC_ID:
+	case ARM_SMCCC_VENDOR_HYP_KVM_PTP_FUNC_ID:
+		return true;
+	default:
+		return kvm_psci_func_id_is_valid(vcpu, func_id);
+	}
+}
+
+static bool kvm_hvc_call_allowed(struct kvm_vcpu *vcpu, u32 func_id)
+{
+	struct kvm_smccc_features *smccc_feat = &vcpu->kvm->arch.smccc_feat;
+
+	switch (func_id) {
+	case ARM_SMCCC_TRNG_VERSION:
+	case ARM_SMCCC_TRNG_FEATURES:
+	case ARM_SMCCC_TRNG_GET_UUID:
+	case ARM_SMCCC_TRNG_RND32:
+	case ARM_SMCCC_TRNG_RND64:
+		return kvm_arm_fw_reg_feat_enabled(&smccc_feat->std_bmap,
+						KVM_REG_ARM_STD_BIT_TRNG_V1_0);
+	default:
+		return kvm_hvc_call_default_allowed(vcpu, func_id);
+	}
+}
+
 int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
 {
 	u32 func_id = smccc_get_function(vcpu);
@@ -65,6 +107,9 @@ int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
 	u32 feature;
 	gpa_t gpa;
 
+	if (!kvm_hvc_call_allowed(vcpu, func_id))
+		goto out;
+
 	switch (func_id) {
 	case ARM_SMCCC_VERSION_FUNC_ID:
 		val[0] = ARM_SMCCC_VERSION_1_1;
@@ -155,6 +200,7 @@ int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
 		return kvm_psci_call(vcpu);
 	}
 
+out:
 	smccc_set_retval(vcpu, val[0], val[1], val[2], val[3]);
 	return 1;
 }
@@ -164,8 +210,16 @@ static const u64 kvm_arm_fw_reg_ids[] = {
 	KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1,
 	KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2,
 	KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_3,
+	KVM_REG_ARM_STD_BMAP,
 };
 
+void kvm_arm_init_hypercalls(struct kvm *kvm)
+{
+	struct kvm_smccc_features *smccc_feat = &kvm->arch.smccc_feat;
+
+	smccc_feat->std_bmap = KVM_ARM_SMCCC_STD_FEATURES;
+}
+
 int kvm_arm_get_fw_num_regs(struct kvm_vcpu *vcpu)
 {
 	return ARRAY_SIZE(kvm_arm_fw_reg_ids);
@@ -237,6 +291,7 @@ static int get_kernel_wa_level(u64 regid)
 
 int kvm_arm_get_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 {
+	struct kvm_smccc_features *smccc_feat = &vcpu->kvm->arch.smccc_feat;
 	void __user *uaddr = (void __user *)(long)reg->addr;
 	u64 val;
 
@@ -249,6 +304,9 @@ int kvm_arm_get_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	case KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_3:
 		val = get_kernel_wa_level(reg->id) & KVM_REG_FEATURE_LEVEL_MASK;
 		break;
+	case KVM_REG_ARM_STD_BMAP:
+		val = READ_ONCE(smccc_feat->std_bmap);
+		break;
 	default:
 		return -ENOENT;
 	}
@@ -259,6 +317,40 @@ int kvm_arm_get_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	return 0;
 }
 
+static int kvm_arm_set_fw_reg_bmap(struct kvm_vcpu *vcpu, u64 reg_id, u64 val)
+{
+	int ret = 0;
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_smccc_features *smccc_feat = &kvm->arch.smccc_feat;
+	unsigned long *fw_reg_bmap, fw_reg_features;
+
+	switch (reg_id) {
+	case KVM_REG_ARM_STD_BMAP:
+		fw_reg_bmap = &smccc_feat->std_bmap;
+		fw_reg_features = KVM_ARM_SMCCC_STD_FEATURES;
+		break;
+	default:
+		return -ENOENT;
+	}
+
+	/* Check for unsupported bit */
+	if (val & ~fw_reg_features)
+		return -EINVAL;
+
+	mutex_lock(&kvm->lock);
+
+	/* Return -EBUSY if the VM (any vCPU) has already started running. */
+	if (test_bit(KVM_ARCH_FLAG_HAS_RAN_ONCE, &kvm->arch.flags)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	WRITE_ONCE(*fw_reg_bmap, val);
+out:
+	mutex_unlock(&kvm->lock);
+	return ret;
+}
+
 int kvm_arm_set_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 {
 	void __user *uaddr = (void __user *)(long)reg->addr;
@@ -337,6 +429,8 @@ int kvm_arm_set_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 			return -EINVAL;
 
 		return 0;
+	case KVM_REG_ARM_STD_BMAP:
+		return kvm_arm_set_fw_reg_bmap(vcpu, reg->id, val);
 	default:
 		return -ENOENT;
 	}
diff --git a/arch/arm64/kvm/psci.c b/arch/arm64/kvm/psci.c
index 346535169faa..67d1273e8086 100644
--- a/arch/arm64/kvm/psci.c
+++ b/arch/arm64/kvm/psci.c
@@ -436,3 +436,16 @@ int kvm_psci_call(struct kvm_vcpu *vcpu)
 		return -EINVAL;
 	}
 }
+
+bool kvm_psci_func_id_is_valid(struct kvm_vcpu *vcpu, u32 func_id)
+{
+	/* PSCI 0.1 doesn't comply with the standard SMCCC */
+	if (kvm_psci_version(vcpu) == KVM_ARM_PSCI_0_1)
+		return (func_id == KVM_PSCI_FN_CPU_OFF || func_id == KVM_PSCI_FN_CPU_ON);
+
+	if (ARM_SMCCC_OWNER_NUM(func_id) == ARM_SMCCC_OWNER_STANDARD &&
+		ARM_SMCCC_FUNC_NUM(func_id) >= 0 && ARM_SMCCC_FUNC_NUM(func_id) <= 0x1f)
+		return true;
+
+	return false;
+}
diff --git a/include/kvm/arm_hypercalls.h b/include/kvm/arm_hypercalls.h
index 5d38628a8d04..499b45b607b6 100644
--- a/include/kvm/arm_hypercalls.h
+++ b/include/kvm/arm_hypercalls.h
@@ -6,6 +6,11 @@
 
 #include <asm/kvm_emulate.h>
 
+/* Last valid bits of the bitmapped firmware registers */
+#define KVM_REG_ARM_STD_BMAP_BIT_MAX		0
+
+#define KVM_ARM_SMCCC_STD_FEATURES		GENMASK(KVM_REG_ARM_STD_BMAP_BIT_MAX, 0)
+
 int kvm_hvc_call_handler(struct kvm_vcpu *vcpu);
 
 static inline u32 smccc_get_function(struct kvm_vcpu *vcpu)
@@ -42,6 +47,7 @@ static inline void smccc_set_retval(struct kvm_vcpu *vcpu,
 
 struct kvm_one_reg;
 
+void kvm_arm_init_hypercalls(struct kvm *kvm);
 int kvm_arm_get_fw_num_regs(struct kvm_vcpu *vcpu);
 int kvm_arm_copy_fw_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices);
 int kvm_arm_get_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
diff --git a/include/kvm/arm_psci.h b/include/kvm/arm_psci.h
index 6e55b9283789..c47be3e26965 100644
--- a/include/kvm/arm_psci.h
+++ b/include/kvm/arm_psci.h
@@ -36,7 +36,7 @@ static inline int kvm_psci_version(struct kvm_vcpu *vcpu)
 	return KVM_ARM_PSCI_0_1;
 }
 
-
 int kvm_psci_call(struct kvm_vcpu *vcpu);
+bool kvm_psci_func_id_is_valid(struct kvm_vcpu *vcpu, u32 func_id);
 
 #endif /* __KVM_ARM_PSCI_H__ */
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
