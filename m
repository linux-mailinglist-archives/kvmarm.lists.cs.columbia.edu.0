Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 688484F700F
	for <lists+kvmarm@lfdr.de>; Thu,  7 Apr 2022 03:16:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EF46A4B20D;
	Wed,  6 Apr 2022 21:16:21 -0400 (EDT)
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
	with ESMTP id wWKOVJqcKS7x; Wed,  6 Apr 2022 21:16:21 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 484874B208;
	Wed,  6 Apr 2022 21:16:20 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CE4114A534
 for <kvmarm@lists.cs.columbia.edu>; Wed,  6 Apr 2022 21:16:18 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bmdRmTu8sl3y for <kvmarm@lists.cs.columbia.edu>;
 Wed,  6 Apr 2022 21:16:17 -0400 (EDT)
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com
 [209.85.219.201])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9B43A4B1AF
 for <kvmarm@lists.cs.columbia.edu>; Wed,  6 Apr 2022 21:16:16 -0400 (EDT)
Received: by mail-yb1-f201.google.com with SMTP id
 23-20020a250b17000000b0063d9e24cde4so3137508ybl.3
 for <kvmarm@lists.cs.columbia.edu>; Wed, 06 Apr 2022 18:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=HVD3ibgyCgHncCU5ocpp0BBdwizrz3uPCJH5E6zH/jA=;
 b=ChjX/cqSEWtzpl2qTHmW2WCKlWJA3sx15tSSG2PkJWJIueTclrWmG5Q+OBk1gq87G+
 iqVTWfgydyVInzXrX7p4q1SVYmhKNpIcjgpTpZzqeMWeSUTlXNNfz7xAkykoVkDgihwg
 8dShdbw/tS3Je7thsAVkEfv2XWrphX39KvAJP2OLvUe7QgcLpBibN9JqrKuzHRkkPdfi
 kKCNMuBsn+9jyBf1wsSRWfXVSJ0HaQCeozmiUQz/Pa9HJddcoxjdmmetDd2vLr8+iu4F
 hpioYer6zGsavMBb0rs0BsnhZ55MAS3kG1fV6LF4p9lblESY+j46Sf8DuPZzj8FLgq3d
 CvWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=HVD3ibgyCgHncCU5ocpp0BBdwizrz3uPCJH5E6zH/jA=;
 b=jy8TLr/FykW+frnUTjnalNV5ZLCYWwJrzVbZPpWfmb0xo4WK9gJZ5OH101bZiB0Na9
 BvVZ1cXopm1NA1xTJuilLqHx5y2lkhNtDtitS9b6tncGgaxYulBWrBVPrTiJaXNT5jaC
 jdTYPVX8fiQFnc+QJpPyZeSKBxmRBuRzJVMA7Q2SEFZ8wC+iWeFljzXNVA5GQQBJfcOv
 k7VWs3UWb/iD6VGijRpcRoDdOjnXz+0cB4Q4ntqtWsxpPNqghbyFl5qYP2eEX7n+Gozf
 EMcKcuEzQyZZHddlXjNsui/WmFLrLyEiihh17gh/Ko8HKtvm01v/TymvflCotKeb5VU5
 OWgw==
X-Gm-Message-State: AOAM5325nG93B4MnTdju2GONxxWWR5gcWaTCTwTXtxHBl3rOCYd0iTzk
 QPEzzVb0qS7RQAOCAygJ3/jMZLTHWGzN
X-Google-Smtp-Source: ABdhPJyFUaplha2YwCqtvv+p+MKgu55+whLAgHolgut8kZ9o3T/otA+vWsBlZ2G7pgowOO6acRqfDYakM4jV
X-Received: from rananta-virt.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:1bcc])
 (user=rananta job=sendgmr) by 2002:a5b:782:0:b0:634:683f:310e with SMTP id
 b2-20020a5b0782000000b00634683f310emr8744105ybq.398.1649294175928; Wed, 06
 Apr 2022 18:16:15 -0700 (PDT)
Date: Thu,  7 Apr 2022 01:15:57 +0000
In-Reply-To: <20220407011605.1966778-1-rananta@google.com>
Message-Id: <20220407011605.1966778-3-rananta@google.com>
Mime-Version: 1.0
References: <20220407011605.1966778-1-rananta@google.com>
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
Subject: [PATCH v5 02/10] KVM: arm64: Setup a framework for hypercall bitmap
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
this, extend the existing firmware psuedo-registers, such as
KVM_REG_ARM_PSCI_VERSION, but by creating a new COPROC register space
for all the hypercall services available.

These firmware registers are categorized based on the service call
owners, but unlike the existing firmware psuedo-registers, they hold
the features supported in the form of a bitmap.

During the VM initialization, the registers are set to upper-limit of
the features supported by the corresponding registers. It's expected
that the VMMs discover the features provided by each register via
GET_ONE_REG, and writeback the desired values using SET_ONE_REG.
KVM allows this modification only until the VM has started.

Some of the standard features are not mapped to any bits of the
registers. But since they can recreate the original problem of
making it available without userspace's consent, they need to
be explicitly added to the hvc_func_default_allowed_list[]. Any
function-id that's not enabled via the bitmap, or not listed in
hvc_func_default_allowed_list[], will be returned as
SMCCC_RET_NOT_SUPPORTED to the guest.

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
 arch/arm64/include/asm/kvm_host.h |  12 ++++
 arch/arm64/include/uapi/asm/kvm.h |   9 +++
 arch/arm64/kvm/arm.c              |   1 +
 arch/arm64/kvm/guest.c            |   8 ++-
 arch/arm64/kvm/hypercalls.c       | 102 ++++++++++++++++++++++++++++++
 include/kvm/arm_hypercalls.h      |   7 ++
 include/kvm/arm_psci.h            |  12 ++++
 7 files changed, 149 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index e3b25dc6c367..6e663383d7b4 100644
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
+	u64 std_bmap;
+};
+
 struct kvm_arch {
 	struct kvm_s2_mmu mmu;
 
@@ -140,6 +149,9 @@ struct kvm_arch {
 
 	u8 pfr0_csv2;
 	u8 pfr0_csv3;
+
+	/* Hypercall features firmware registers' descriptor */
+	struct kvm_smccc_features smccc_feat;
 };
 
 struct kvm_vcpu_fault_info {
diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index c1b6ddc02d2f..56e4bc58a355 100644
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
+#define KVM_REG_ARM_STD_BIT_TRNG_V1_0		BIT(0)
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
index fa6d9378d8e7..cf04b5ee5f56 100644
--- a/arch/arm64/kvm/hypercalls.c
+++ b/arch/arm64/kvm/hypercalls.c
@@ -58,6 +58,53 @@ static void kvm_ptp_get_time(struct kvm_vcpu *vcpu, u64 *val)
 	val[3] = lower_32_bits(cycles);
 }
 
+/*
+ * List of function-ids that are not gated with the bitmapped feature
+ * firmware registers, and are to be allowed for servicing the call by default.
+ */
+static const u32 hvc_func_default_allowed_list[] = {
+	ARM_SMCCC_VERSION_FUNC_ID,
+	ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
+	ARM_SMCCC_HV_PV_TIME_FEATURES,
+	ARM_SMCCC_HV_PV_TIME_ST,
+	ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID,
+	ARM_SMCCC_VENDOR_HYP_KVM_FEATURES_FUNC_ID,
+	ARM_SMCCC_VENDOR_HYP_KVM_PTP_FUNC_ID,
+};
+
+static bool kvm_hvc_call_default_allowed(struct kvm_vcpu *vcpu, u32 func_id)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(hvc_func_default_allowed_list); i++)
+		if (func_id == hvc_func_default_allowed_list[i])
+			return true;
+
+	return kvm_psci_func_id_is_valid(vcpu, func_id);
+}
+
+static bool kvm_arm_fw_reg_feat_enabled(u64 reg_bmap, u64 feat_bit)
+{
+	return reg_bmap & feat_bit;
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
+		return kvm_arm_fw_reg_feat_enabled(smccc_feat->std_bmap,
+						KVM_REG_ARM_STD_BIT_TRNG_V1_0);
+	default:
+		return kvm_hvc_call_default_allowed(vcpu, func_id);
+	}
+}
+
 int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
 {
 	u32 func_id = smccc_get_function(vcpu);
@@ -65,6 +112,9 @@ int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
 	u32 feature;
 	gpa_t gpa;
 
+	if (!kvm_hvc_call_allowed(vcpu, func_id))
+		goto out;
+
 	switch (func_id) {
 	case ARM_SMCCC_VERSION_FUNC_ID:
 		val[0] = ARM_SMCCC_VERSION_1_1;
@@ -155,6 +205,7 @@ int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
 		return kvm_psci_call(vcpu);
 	}
 
+out:
 	smccc_set_retval(vcpu, val[0], val[1], val[2], val[3]);
 	return 1;
 }
@@ -164,8 +215,16 @@ static const u64 kvm_arm_fw_reg_ids[] = {
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
@@ -237,6 +296,7 @@ static int get_kernel_wa_level(u64 regid)
 
 int kvm_arm_get_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 {
+	struct kvm_smccc_features *smccc_feat = &vcpu->kvm->arch.smccc_feat;
 	void __user *uaddr = (void __user *)(long)reg->addr;
 	u64 val;
 
@@ -249,6 +309,9 @@ int kvm_arm_get_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	case KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_3:
 		val = get_kernel_wa_level(reg->id) & KVM_REG_FEATURE_LEVEL_MASK;
 		break;
+	case KVM_REG_ARM_STD_BMAP:
+		val = READ_ONCE(smccc_feat->std_bmap);
+		break;
 	default:
 		return -ENOENT;
 	}
@@ -259,6 +322,43 @@ int kvm_arm_get_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	return 0;
 }
 
+static int kvm_arm_set_fw_reg_bmap(struct kvm_vcpu *vcpu, u64 reg_id, u64 val)
+{
+	int ret = 0;
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_smccc_features *smccc_feat = &kvm->arch.smccc_feat;
+	u64 *fw_reg_bmap, fw_reg_features;
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
+	/*
+	 * If the VM (any vCPU) has already started running, return success
+	 * if there's no change in the value. Else, return -EBUSY.
+	 */
+	if (test_bit(KVM_ARCH_FLAG_HAS_RAN_ONCE, &kvm->arch.flags)) {
+		ret = *fw_reg_bmap != val ? -EBUSY : 0;
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
@@ -337,6 +437,8 @@ int kvm_arm_set_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 			return -EINVAL;
 
 		return 0;
+	case KVM_REG_ARM_STD_BMAP:
+		return kvm_arm_set_fw_reg_bmap(vcpu, reg->id, val);
 	default:
 		return -ENOENT;
 	}
diff --git a/include/kvm/arm_hypercalls.h b/include/kvm/arm_hypercalls.h
index 5d38628a8d04..fd3ff350ee9d 100644
--- a/include/kvm/arm_hypercalls.h
+++ b/include/kvm/arm_hypercalls.h
@@ -6,6 +6,12 @@
 
 #include <asm/kvm_emulate.h>
 
+/* Last valid bits of the bitmapped firmware registers */
+#define KVM_REG_ARM_STD_BMAP_BIT_MAX		0
+
+#define KVM_ARM_SMCCC_STD_FEATURES \
+	GENMASK_ULL(KVM_REG_ARM_STD_BMAP_BIT_MAX, 0)
+
 int kvm_hvc_call_handler(struct kvm_vcpu *vcpu);
 
 static inline u32 smccc_get_function(struct kvm_vcpu *vcpu)
@@ -42,6 +48,7 @@ static inline void smccc_set_retval(struct kvm_vcpu *vcpu,
 
 struct kvm_one_reg;
 
+void kvm_arm_init_hypercalls(struct kvm *kvm);
 int kvm_arm_get_fw_num_regs(struct kvm_vcpu *vcpu);
 int kvm_arm_copy_fw_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices);
 int kvm_arm_get_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
diff --git a/include/kvm/arm_psci.h b/include/kvm/arm_psci.h
index 6e55b9283789..d7a87367de56 100644
--- a/include/kvm/arm_psci.h
+++ b/include/kvm/arm_psci.h
@@ -36,6 +36,18 @@ static inline int kvm_psci_version(struct kvm_vcpu *vcpu)
 	return KVM_ARM_PSCI_0_1;
 }
 
+static inline bool kvm_psci_func_id_is_valid(struct kvm_vcpu *vcpu, u32 func_id)
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
 
 int kvm_psci_call(struct kvm_vcpu *vcpu);
 
-- 
2.35.1.1094.g7c7d902a7c-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
