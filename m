Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 87FA04C3394
	for <lists+kvmarm@lfdr.de>; Thu, 24 Feb 2022 18:26:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1BB864BE2D;
	Thu, 24 Feb 2022 12:26:39 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.788
X-Spam-Level: 
X-Spam-Status: No, score=-1.788 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RudxR-EgPsYp; Thu, 24 Feb 2022 12:26:37 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 292DB4BDBA;
	Thu, 24 Feb 2022 12:26:37 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E1DB94BDD0
 for <kvmarm@lists.cs.columbia.edu>; Thu, 24 Feb 2022 12:26:35 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cPUDL9Tmt8z6 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 24 Feb 2022 12:26:33 -0500 (EST)
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com
 [209.85.214.202])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id BAFA74BE19
 for <kvmarm@lists.cs.columbia.edu>; Thu, 24 Feb 2022 12:26:33 -0500 (EST)
Received: by mail-pl1-f202.google.com with SMTP id
 g8-20020a170902868800b0014f8ddfeee5so1415429plo.18
 for <kvmarm@lists.cs.columbia.edu>; Thu, 24 Feb 2022 09:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=KxLF7qzKbc8UFtk7tO6zSgT4pjqe2yY92U69kuJWElE=;
 b=Ibq2L/kDegT2ECNcaQXPAs7djEODMNl6Odaya6jgnPWZwo8ddlFwZQf5S2DV1lDKXh
 KvqDVlQRjlXs0r+9hv5s4YACXuw+mZH8LtJ9PjnUl+m/ZKgOJhNu5UTG/sW92wXtuJ53
 uTA70vfKFeeqKKcz3kmCuUJDCYC2jsj1x3VKD3fMxhwpYqXFxkE6Ryi/kYomzSshDYFb
 zaCFurXQqXvGlWD9SuSkzApAxF7z4m7vGgt6OanmwFR3UcAlwoV4m/vf2Dl/KySQsaX/
 ID6OoI+rC9i9ZACeBS2AWlYwc3JMYgiMB0VLfj+e4bNJ3K/2wDtWal25WRCbJUUBRdW1
 09hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=KxLF7qzKbc8UFtk7tO6zSgT4pjqe2yY92U69kuJWElE=;
 b=lx/qQLFNZxtAXC3i+YZOe7GjKLHkOd7aKbi0/AI0TGOUJiYTWDit1UK+jlWzum7N3u
 0ulhu1cKmsvfQIgt/o/q2kHbHcCJyTeI+P6ZPn9tDTBK674/S7bFCFiuGXqjbYMB84Ud
 hG3yQqYrI6ecjGZdVT93wZVTVvaW3fvp3ZcEnwR7MH2nfs1p1Hj7abZ/JnfgI018QfUm
 fcHHfGCD5idhQ1LbwUDv864/iXJRQ0x3uWBU6EGTt4HVGTlpp1IcGsSUJVkFEZzImFRt
 g6XjTlJc6LGwWRS5waOqrnt2HToDksjPLrWZOOtAy1LtRTDiQfXmdNYq1aikUnc4hvxJ
 KwAw==
X-Gm-Message-State: AOAM533rxLJoaQb+fPKRZw0tqsPb1z67uex2iYdrS/gPX6mrQ13724NM
 ezvI4JtAJJpwJpFiCXBDK1SpHNEO3S5G
X-Google-Smtp-Source: ABdhPJyrVMqrzObbtdrqsKfy7PVH706+lroyD/W5B1nltv6iTYOALVQlwfiPpkDn123mnsFrgGkxxJ5C3gkx
X-Received: from rananta-virt.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:1bcc])
 (user=rananta job=sendgmr) by 2002:a17:902:d345:b0:14f:ee29:5ee6 with SMTP id
 l5-20020a170902d34500b0014fee295ee6mr3440637plk.102.1645723593017; Thu, 24
 Feb 2022 09:26:33 -0800 (PST)
Date: Thu, 24 Feb 2022 17:25:57 +0000
In-Reply-To: <20220224172559.4170192-1-rananta@google.com>
Message-Id: <20220224172559.4170192-12-rananta@google.com>
Mime-Version: 1.0
References: <20220224172559.4170192-1-rananta@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v4 11/13] selftests: KVM: aarch64: Introduce hypercall ABI test
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

Introduce a KVM selftest to check the hypercall interface
for arm64 platforms. The test validates the user-space's
IOCTL interface to read/write the psuedo-firmware registers
as well as its effects on the guest upon certain configurations.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/aarch64/hypercalls.c        | 376 ++++++++++++++++++
 3 files changed, 378 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/aarch64/hypercalls.c

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index ac69108d9ffd..f13c33fcd733 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -2,6 +2,7 @@
 /aarch64/arch_timer
 /aarch64/debug-exceptions
 /aarch64/get-reg-list
+/aarch64/hypercalls
 /aarch64/psci_test
 /aarch64/vgic_init
 /aarch64/vgic_irq
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 2a27c09b22ae..2181bdd5b09c 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -102,6 +102,7 @@ TEST_GEN_PROGS_x86_64 += system_counter_offset_test
 TEST_GEN_PROGS_aarch64 += aarch64/arch_timer
 TEST_GEN_PROGS_aarch64 += aarch64/debug-exceptions
 TEST_GEN_PROGS_aarch64 += aarch64/get-reg-list
+TEST_GEN_PROGS_aarch64 += aarch64/hypercalls
 TEST_GEN_PROGS_aarch64 += aarch64/psci_test
 TEST_GEN_PROGS_aarch64 += aarch64/vgic_init
 TEST_GEN_PROGS_aarch64 += aarch64/vgic_irq
diff --git a/tools/testing/selftests/kvm/aarch64/hypercalls.c b/tools/testing/selftests/kvm/aarch64/hypercalls.c
new file mode 100644
index 000000000000..e4e3a286ff3e
--- /dev/null
+++ b/tools/testing/selftests/kvm/aarch64/hypercalls.c
@@ -0,0 +1,376 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/* hypercalls: Check the ARM64's psuedo-firmware bitmap register interface.
+ *
+ * The test validates the basic hypercall functionalities that are exposed
+ * via the psuedo-firmware bitmap register. This includes the registers'
+ * read/write behavior before and after the VM has started, and if the
+ * hypercalls are properly masked or unmasked to the guest when disabled or
+ * enabled from the KVM userspace, respectively.
+ */
+
+#include <errno.h>
+#include <linux/arm-smccc.h>
+#include <asm/kvm.h>
+#include <kvm_util.h>
+
+#include "processor.h"
+
+#define FW_REG_ULIMIT_VAL(max_feat_bit) (GENMASK_ULL(max_feat_bit, 0))
+
+struct kvm_fw_reg_info {
+	uint64_t reg;		/* Register definition */
+	uint64_t max_feat_bit;	/* Bit that represents the upper limit of the feature-map */
+};
+
+#define FW_REG_INFO(r, bit_max)			\
+	{					\
+		.reg = r,			\
+		.max_feat_bit = bit_max,	\
+	}
+
+static const struct kvm_fw_reg_info fw_reg_info[] = {
+	FW_REG_INFO(KVM_REG_ARM_STD_BMAP, KVM_REG_ARM_STD_BMAP_BIT_MAX),
+	FW_REG_INFO(KVM_REG_ARM_STD_HYP_BMAP, KVM_REG_ARM_STD_HYP_BMAP_BIT_MAX),
+	FW_REG_INFO(KVM_REG_ARM_VENDOR_HYP_BMAP, KVM_REG_ARM_VENDOR_HYP_BMAP_BIT_MAX),
+};
+
+enum test_stage {
+	TEST_STAGE_REG_IFACE,
+	TEST_STAGE_HVC_IFACE_FEAT_DISABLED,
+	TEST_STAGE_HVC_IFACE_FEAT_ENABLED,
+	TEST_STAGE_HVC_IFACE_FALSE_INFO,
+	TEST_STAGE_END,
+};
+
+static int stage;
+
+struct test_hvc_info {
+	uint32_t func_id;
+	int64_t arg0;
+
+	void (*test_hvc_disabled)(const struct test_hvc_info *hc_info,
+					struct arm_smccc_res *res);
+	void (*test_hvc_enabled)(const struct test_hvc_info *hc_info,
+					struct arm_smccc_res *res);
+};
+
+#define TEST_HVC_INFO(f, a0, test_disabled, test_enabled)	\
+	{							\
+		.func_id = f,					\
+		.arg0 = a0,					\
+		.test_hvc_disabled = test_disabled,		\
+		.test_hvc_enabled = test_enabled,		\
+	}
+
+static void
+test_ptp_feat_hvc_disabled(const struct test_hvc_info *hc_info, struct arm_smccc_res *res)
+{
+	GUEST_ASSERT_3((res->a0 & BIT(ARM_SMCCC_KVM_FUNC_PTP)) == 0,
+			res->a0, hc_info->func_id, hc_info->arg0);
+}
+
+static void
+test_ptp_feat_hvc_enabled(const struct test_hvc_info *hc_info, struct arm_smccc_res *res)
+{
+	GUEST_ASSERT_3((res->a0 & BIT(ARM_SMCCC_KVM_FUNC_PTP)) != 0,
+			res->a0, hc_info->func_id, hc_info->arg0);
+}
+
+static const struct test_hvc_info hvc_info[] = {
+	/* KVM_REG_ARM_STD_BMAP: KVM_REG_ARM_STD_BIT_TRNG_V1_0 */
+	TEST_HVC_INFO(ARM_SMCCC_TRNG_VERSION, 0, NULL, NULL),
+	TEST_HVC_INFO(ARM_SMCCC_TRNG_FEATURES, ARM_SMCCC_TRNG_RND64, NULL, NULL),
+	TEST_HVC_INFO(ARM_SMCCC_TRNG_GET_UUID, 0, NULL, NULL),
+	TEST_HVC_INFO(ARM_SMCCC_TRNG_RND32, 0, NULL, NULL),
+	TEST_HVC_INFO(ARM_SMCCC_TRNG_RND64, 0, NULL, NULL),
+
+	/* KVM_REG_ARM_STD_HYP_BMAP: KVM_REG_ARM_STD_HYP_BIT_PV_TIME */
+	TEST_HVC_INFO(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
+			ARM_SMCCC_HV_PV_TIME_FEATURES, NULL, NULL),
+	TEST_HVC_INFO(ARM_SMCCC_HV_PV_TIME_FEATURES,
+			ARM_SMCCC_HV_PV_TIME_ST, NULL, NULL),
+	TEST_HVC_INFO(ARM_SMCCC_HV_PV_TIME_ST, 0, NULL, NULL),
+
+	/* KVM_REG_ARM_VENDOR_HYP_BMAP: KVM_REG_ARM_VENDOR_HYP_BIT_PTP */
+	TEST_HVC_INFO(ARM_SMCCC_VENDOR_HYP_KVM_FEATURES_FUNC_ID,
+			ARM_SMCCC_VENDOR_HYP_KVM_PTP_FUNC_ID,
+			test_ptp_feat_hvc_disabled, test_ptp_feat_hvc_enabled),
+	TEST_HVC_INFO(ARM_SMCCC_VENDOR_HYP_KVM_PTP_FUNC_ID,
+			KVM_PTP_VIRT_COUNTER, NULL, NULL),
+};
+
+/* Feed false hypercall info to test the KVM behavior */
+static const struct test_hvc_info false_hvc_info[] = {
+	/* Feature support check against a different family of hypercalls */
+	TEST_HVC_INFO(ARM_SMCCC_TRNG_FEATURES,
+			ARM_SMCCC_VENDOR_HYP_KVM_PTP_FUNC_ID, NULL, NULL),
+	TEST_HVC_INFO(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
+			ARM_SMCCC_TRNG_RND64, NULL, NULL),
+	TEST_HVC_INFO(ARM_SMCCC_HV_PV_TIME_FEATURES,
+			ARM_SMCCC_TRNG_RND64, NULL, NULL),
+};
+
+static void guest_test_hvc(const struct test_hvc_info *hc_info)
+{
+	unsigned int i;
+	struct arm_smccc_res res;
+	unsigned int hvc_info_arr_sz;
+
+	hvc_info_arr_sz =
+	hc_info == hvc_info ? ARRAY_SIZE(hvc_info) : ARRAY_SIZE(false_hvc_info);
+
+	for (i = 0; i < hvc_info_arr_sz; i++, hc_info++) {
+
+		memset(&res, 0, sizeof(res));
+		smccc_hvc(hc_info->func_id, hc_info->arg0, 0, 0, 0, 0, 0, 0, &res);
+
+		switch (stage) {
+		case TEST_STAGE_HVC_IFACE_FEAT_DISABLED:
+			if (hc_info->test_hvc_disabled)
+				hc_info->test_hvc_disabled(hc_info, &res);
+			else
+				GUEST_ASSERT_3(res.a0 == SMCCC_RET_NOT_SUPPORTED,
+					res.a0, hc_info->func_id, hc_info->arg0);
+			break;
+		case TEST_STAGE_HVC_IFACE_FEAT_ENABLED:
+			if (hc_info->test_hvc_enabled)
+				hc_info->test_hvc_enabled(hc_info, &res);
+			else
+				GUEST_ASSERT_3(res.a0 != SMCCC_RET_NOT_SUPPORTED,
+					res.a0, hc_info->func_id, hc_info->arg0);
+			break;
+		case TEST_STAGE_HVC_IFACE_FALSE_INFO:
+			GUEST_ASSERT_3(res.a0 == SMCCC_RET_NOT_SUPPORTED,
+					res.a0, hc_info->func_id, hc_info->arg0);
+			break;
+		default:
+			GUEST_ASSERT_1(0, stage);
+		}
+	}
+}
+
+static void guest_code(void)
+{
+	while (stage != TEST_STAGE_END) {
+		switch (stage) {
+		case TEST_STAGE_REG_IFACE:
+			break;
+		case TEST_STAGE_HVC_IFACE_FEAT_DISABLED:
+		case TEST_STAGE_HVC_IFACE_FEAT_ENABLED:
+			guest_test_hvc(hvc_info);
+			break;
+		case TEST_STAGE_HVC_IFACE_FALSE_INFO:
+			guest_test_hvc(false_hvc_info);
+			break;
+		default:
+			GUEST_ASSERT_1(0, stage);
+		}
+
+		GUEST_SYNC(stage);
+	}
+
+	GUEST_DONE();
+}
+
+static int set_fw_reg(struct kvm_vm *vm, uint64_t id, uint64_t val)
+{
+	struct kvm_one_reg reg = {
+		.id = KVM_REG_ARM_FW_REG(id),
+		.addr = (uint64_t)&val,
+	};
+
+	return _vcpu_ioctl(vm, 0, KVM_SET_ONE_REG, &reg);
+}
+
+static void get_fw_reg(struct kvm_vm *vm, uint64_t id, uint64_t *addr)
+{
+	struct kvm_one_reg reg = {
+		.id = KVM_REG_ARM_FW_REG(id),
+		.addr = (uint64_t)addr,
+	};
+
+	return vcpu_ioctl(vm, 0, KVM_GET_ONE_REG, &reg);
+}
+
+struct st_time {
+	uint32_t rev;
+	uint32_t attr;
+	uint64_t st_time;
+};
+
+#define STEAL_TIME_SIZE		((sizeof(struct st_time) + 63) & ~63)
+#define ST_GPA_BASE		(1 << 30)
+
+static void steal_time_init(struct kvm_vm *vm)
+{
+	uint64_t st_ipa = (ulong)ST_GPA_BASE;
+	unsigned int gpages;
+	struct kvm_device_attr dev = {
+		.group = KVM_ARM_VCPU_PVTIME_CTRL,
+		.attr = KVM_ARM_VCPU_PVTIME_IPA,
+		.addr = (uint64_t)&st_ipa,
+	};
+
+	gpages = vm_calc_num_guest_pages(VM_MODE_DEFAULT, STEAL_TIME_SIZE);
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, ST_GPA_BASE, 1, gpages, 0);
+
+	vcpu_ioctl(vm, 0, KVM_SET_DEVICE_ATTR, &dev);
+}
+
+static void test_fw_regs_before_vm_start(struct kvm_vm *vm)
+{
+	uint64_t val;
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < ARRAY_SIZE(fw_reg_info); i++) {
+		const struct kvm_fw_reg_info *reg_info = &fw_reg_info[i];
+
+		/* First read should be an upper limit of the features supported */
+		get_fw_reg(vm, reg_info->reg, &val);
+		TEST_ASSERT(val == FW_REG_ULIMIT_VAL(reg_info->max_feat_bit),
+			"Expected all the features to be set for reg: 0x%lx; expected: 0x%llx; read: 0x%lx\n",
+			reg_info->reg, GENMASK_ULL(reg_info->max_feat_bit, 0), val);
+
+		/* Test 'write' by disabling all the features of the register map */
+		ret = set_fw_reg(vm, reg_info->reg, 0);
+		TEST_ASSERT(ret == 0,
+			"Failed to clear all the features of reg: 0x%lx; ret: %d\n",
+			reg_info->reg, errno);
+
+		get_fw_reg(vm, reg_info->reg, &val);
+		TEST_ASSERT(val == 0,
+			"Expected all the features to be cleared for reg: 0x%lx\n", reg_info->reg);
+
+		/*
+		 * Test enabling a feature that's not supported.
+		 * Avoid this check if all the bits are occupied.
+		 */
+		if (reg_info->max_feat_bit < 63) {
+			ret = set_fw_reg(vm, reg_info->reg, BIT(reg_info->max_feat_bit + 1));
+			TEST_ASSERT(ret != 0 && errno == EINVAL,
+			"Unexpected behavior or return value (%d) while setting an unsupported feature for reg: 0x%lx\n",
+			errno, reg_info->reg);
+		}
+	}
+}
+
+static void test_fw_regs_after_vm_start(struct kvm_vm *vm)
+{
+	uint64_t val;
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < ARRAY_SIZE(fw_reg_info); i++) {
+		const struct kvm_fw_reg_info *reg_info = &fw_reg_info[i];
+
+		/*
+		 * Before starting the VM, the test clears all the bits.
+		 * Check if that's still the case.
+		 */
+		get_fw_reg(vm, reg_info->reg, &val);
+		TEST_ASSERT(val == 0,
+			"Expected all the features to be cleared for reg: 0x%lx\n",
+			reg_info->reg);
+
+		/*
+		 * Test setting the last read value. KVM should allow this
+		 * even if VM has started running.
+		 */
+		ret = set_fw_reg(vm, reg_info->reg, val);
+		TEST_ASSERT(ret == 0,
+			"Failed to set the register with previously read value after Vm start for reg: 0x%lx; ret: %d\n",
+			reg_info->reg, errno);
+
+		/*
+		 * Set all the features for this register again. KVM shouldn't
+		 * allow this as the VM is running.
+		 */
+		ret = set_fw_reg(vm, reg_info->reg, FW_REG_ULIMIT_VAL(reg_info->max_feat_bit));
+		TEST_ASSERT(ret != 0 && errno == EBUSY,
+		"Unexpected behavior or return value (%d) while setting a feature while VM is running for reg: 0x%lx\n",
+		errno, reg_info->reg);
+	}
+}
+
+static struct kvm_vm *test_vm_create(void)
+{
+	struct kvm_vm *vm;
+
+	vm = vm_create_default(0, 0, guest_code);
+
+	ucall_init(vm, NULL);
+	steal_time_init(vm);
+
+	return vm;
+}
+
+static struct kvm_vm *test_guest_stage(struct kvm_vm *vm)
+{
+	struct kvm_vm *ret_vm = vm;
+
+	pr_debug("Stage: %d\n", stage);
+
+	switch (stage) {
+	case TEST_STAGE_REG_IFACE:
+		test_fw_regs_after_vm_start(vm);
+		break;
+	case TEST_STAGE_HVC_IFACE_FEAT_DISABLED:
+		/* Start a new VM so that all the features are now enabled by default */
+		kvm_vm_free(vm);
+		ret_vm = test_vm_create();
+		break;
+	case TEST_STAGE_HVC_IFACE_FEAT_ENABLED:
+	case TEST_STAGE_HVC_IFACE_FALSE_INFO:
+		break;
+	default:
+		TEST_FAIL("Unknown test stage: %d\n", stage);
+	}
+
+	stage++;
+	sync_global_to_guest(vm, stage);
+
+	return ret_vm;
+}
+
+static void test_run(void)
+{
+	struct kvm_vm *vm;
+	struct ucall uc;
+	bool guest_done = false;
+
+	vm = test_vm_create();
+
+	test_fw_regs_before_vm_start(vm);
+
+	while (!guest_done) {
+		vcpu_run(vm, 0);
+
+		switch (get_ucall(vm, 0, &uc)) {
+		case UCALL_SYNC:
+			vm = test_guest_stage(vm);
+			break;
+		case UCALL_DONE:
+			guest_done = true;
+			break;
+		case UCALL_ABORT:
+			TEST_FAIL("%s at %s:%ld\n\tvalues: 0x%lx, 0x%lx; 0x%lx, stage: %u",
+			(const char *)uc.args[0], __FILE__, uc.args[1],
+			uc.args[2], uc.args[3], uc.args[4], stage);
+			break;
+		default:
+			TEST_FAIL("Unexpected guest exit\n");
+		}
+	}
+
+	kvm_vm_free(vm);
+}
+
+int main(void)
+{
+	setbuf(stdout, NULL);
+
+	test_run();
+	return 0;
+}
-- 
2.35.1.473.g83b2b277ed-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
