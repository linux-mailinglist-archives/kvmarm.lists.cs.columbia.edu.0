Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5918F4424A7
	for <lists+kvmarm@lfdr.de>; Tue,  2 Nov 2021 01:22:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F350E4B252;
	Mon,  1 Nov 2021 20:22:46 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TZC5vRSnYQo5; Mon,  1 Nov 2021 20:22:46 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 32F3E4B23C;
	Mon,  1 Nov 2021 20:22:45 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E02A94B236
 for <kvmarm@lists.cs.columbia.edu>; Mon,  1 Nov 2021 20:22:43 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ds9PzEojf22O for <kvmarm@lists.cs.columbia.edu>;
 Mon,  1 Nov 2021 20:22:42 -0400 (EDT)
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com
 [209.85.210.202])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 4F1B24B243
 for <kvmarm@lists.cs.columbia.edu>; Mon,  1 Nov 2021 20:22:42 -0400 (EDT)
Received: by mail-pf1-f202.google.com with SMTP id
 x25-20020aa79199000000b0044caf0d1ba8so10291282pfa.1
 for <kvmarm@lists.cs.columbia.edu>; Mon, 01 Nov 2021 17:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=L+cvvbG+AbS6lwK44pG2+9XXxadBNUHbWgXFY0L4Kik=;
 b=UkDi3m3SRR+RutJX+DLcrQtrA6/5bnnlFoWL6RzF80faB3B3FaBqPYeEibCLqj0olG
 +S34TuL7R/9c9RWpWc0a55wrWa1jUIFNlolrcUvuc0ZudaVgn3U9V+VKY8LUGVaOefhE
 Rm1QSGONSydIUTw+BOipBYPAz6N1ZF28VwCkTnxE+U8xZSNQCHuEiCVbZYzk8lEqsh6D
 ojBTc6fnPBQ5ytsjHgyGnPUy3bYwd5+v5QkSY7rREHqQFoivCg7ztI69RjLVedMwyWJj
 TKeLrGMiEayLKBzDMtoYU6b3Tdi2QmA8kilNWQrTyke1igxWhto5c8jxiuQgRoLw1sys
 Qw5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=L+cvvbG+AbS6lwK44pG2+9XXxadBNUHbWgXFY0L4Kik=;
 b=HzAyV/3ff/59AxsZ8cv1q159lN+sch7rKIF6HPhnlp9JqjNakqhldFUgPXpK5+qD5o
 qlsAzuxqrhGt639rTY+5eM9/dEzyTIxbal3I5y/lFIranA8s5SKDy/6Xh0FLTsbWmTh6
 vYgUgDsvfuF2rgOSW9Kg3fL8x+e5bfzcdm7yVSmsrVOCdVUf7+qzGK+6AoninFCRif/b
 1ouAx1tBh/bo5/NIfcI3PKFyToLPRRm0lSSamOMBFoghIHjDQ9YV/8DWMQOT9GUUMvYS
 YD6Kxce/4/a8duRIj5FGOUxdCrQvRN+YQoVY5qdBQBxaGIJuP7OlH6g909wa7GoSUNjR
 1Ong==
X-Gm-Message-State: AOAM531uHCeArtIRLlbJVhS8rIZB3NUNtHjubCzqG6EXG/j8a5eSqOaY
 8GXctprJkQsTJA4TKw/HMx+DPy8DFXql
X-Google-Smtp-Source: ABdhPJxfJF0pEwnq7m2SDK1WYpgrX79xXxzLJzvdVidDANpYkAF23OnhAWomc6Q06SgPN0ZhtNIRz+Enyq12
X-Received: from rananta-virt.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:1bcc])
 (user=rananta job=sendgmr) by 2002:aa7:8198:0:b0:44b:e191:7058 with SMTP id
 g24-20020aa78198000000b0044be1917058mr32989002pfi.39.1635812561476; Mon, 01
 Nov 2021 17:22:41 -0700 (PDT)
Date: Tue,  2 Nov 2021 00:22:03 +0000
In-Reply-To: <20211102002203.1046069-1-rananta@google.com>
Message-Id: <20211102002203.1046069-9-rananta@google.com>
Mime-Version: 1.0
References: <20211102002203.1046069-1-rananta@google.com>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [RFC PATCH 8/8] selftests: KVM: aarch64: Introduce hypercall ABI test
From: Raghavendra Rao Ananta <rananta@google.com>
To: Marc Zyngier <maz@kernel.org>, Andrew Jones <drjones@redhat.com>, 
 James Morse <james.morse@arm.com>, Alexandru Elisei <alexandru.elisei@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Peter Shier <pshier@google.com>, linux-kernel@vger.kernel.org,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
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
 .../selftests/kvm/aarch64/hypercalls.c        | 340 ++++++++++++++++++
 3 files changed, 342 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/aarch64/hypercalls.c

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index 100d9a3a37f6..b56532fc3678 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -2,6 +2,7 @@
 /aarch64/arch_timer
 /aarch64/debug-exceptions
 /aarch64/get-reg-list
+/aarch64/hypercalls
 /aarch64/psci_test
 /aarch64/vgic_init
 /s390x/memop
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 8bcc8d1f226e..4b4aa75663bd 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -89,6 +89,7 @@ TEST_GEN_PROGS_x86_64 += kvm_binary_stats_test
 TEST_GEN_PROGS_aarch64 += aarch64/arch_timer
 TEST_GEN_PROGS_aarch64 += aarch64/debug-exceptions
 TEST_GEN_PROGS_aarch64 += aarch64/get-reg-list
+TEST_GEN_PROGS_aarch64 += aarch64/hypercalls
 TEST_GEN_PROGS_aarch64 += aarch64/psci_test
 TEST_GEN_PROGS_aarch64 += aarch64/vgic_init
 TEST_GEN_PROGS_aarch64 += demand_paging_test
diff --git a/tools/testing/selftests/kvm/aarch64/hypercalls.c b/tools/testing/selftests/kvm/aarch64/hypercalls.c
new file mode 100644
index 000000000000..fa422769fcda
--- /dev/null
+++ b/tools/testing/selftests/kvm/aarch64/hypercalls.c
@@ -0,0 +1,340 @@
+// SPDX-License-Identifier: GPL-2.0-only
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
+	FW_REG_INFO(KVM_REG_ARM_STD, KVM_REG_ARM_STD_BMAP_MAX - 1),
+	FW_REG_INFO(KVM_REG_ARM_STD_HYP, KVM_REG_ARM_STD_HYP_BMAP_MAX - 1),
+	FW_REG_INFO(KVM_REG_ARM_VENDOR_HYP, KVM_REG_ARM_VENDOR_HYP_BMAP_MAX - 1),
+};
+
+enum test_stage {
+	TEST_STAGE_REG_IFACE,
+	TEST_STAGE_HVC_IFACE_FEAT_DISABLED,
+	TEST_STAGE_HVC_IFACE_FEAT_ENABLED,
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
+	/* KVM_REG_ARM_STD: KVM_REG_ARM_STD_TRNG_V1_0 */
+	TEST_HVC_INFO(ARM_SMCCC_TRNG_FEATURES, ARM_SMCCC_TRNG_RND64, NULL, NULL),
+	TEST_HVC_INFO(ARM_SMCCC_TRNG_GET_UUID, 0, NULL, NULL),
+	TEST_HVC_INFO(ARM_SMCCC_TRNG_RND32, 0, NULL, NULL),
+	TEST_HVC_INFO(ARM_SMCCC_TRNG_RND64, 0, NULL, NULL),
+
+	/* KVM_REG_ARM_STD_HYP: PV_TIME */
+	TEST_HVC_INFO(ARM_SMCCC_HV_PV_TIME_FEATURES, ARM_SMCCC_HV_PV_TIME_ST, NULL, NULL),
+	TEST_HVC_INFO(ARM_SMCCC_HV_PV_TIME_ST, 0, NULL, NULL),
+
+	/* KVM_REG_ARM_VENDOR_HYP: PTP */
+	TEST_HVC_INFO(ARM_SMCCC_VENDOR_HYP_KVM_FEATURES_FUNC_ID,
+			ARM_SMCCC_VENDOR_HYP_KVM_PTP_FUNC_ID,
+			test_ptp_feat_hvc_disabled, test_ptp_feat_hvc_enabled),
+	TEST_HVC_INFO(ARM_SMCCC_VENDOR_HYP_KVM_PTP_FUNC_ID,
+			KVM_PTP_VIRT_COUNTER, NULL, NULL),
+};
+
+static void guest_test_hvc(int stage)
+{
+	unsigned int i;
+	struct arm_smccc_res res;
+
+	for (i = 0; i < ARRAY_SIZE(hvc_info); i++) {
+		const struct test_hvc_info *hc_info  = &hvc_info[i];
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
+			guest_test_hvc(stage);
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
+	}
+
+	for (i = 0; i < ARRAY_SIZE(fw_reg_info); i++) {
+		const struct kvm_fw_reg_info *reg_info = &fw_reg_info[i];
+
+		/* Test disabling all the features of the register map */
+		ret = set_fw_reg(vm, reg_info->reg, 0);
+		TEST_ASSERT(ret == 0,
+			"Failed to clear all the features of reg: 0x%lx; ret: %d\n",
+			reg_info->reg, errno);
+
+		get_fw_reg(vm, reg_info->reg, &val);
+		TEST_ASSERT(val == 0,
+			"Expected all the features to be cleared for reg: 0x%lx\n", reg_info->reg);
+
+		/* Test enabling a feature that's not supported. Avoid this
+		 * check if all the bits are occupied.
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
+		/* Before starting the VM, the test clears all the bits.
+		 * Check if that's still the case.
+		 */
+		get_fw_reg(vm, reg_info->reg, &val);
+		TEST_ASSERT(val == 0,
+			"Expected all the features to be cleared for reg: 0x%lx\n",
+			reg_info->reg);
+
+		/* Test setting the last known value. KVM should allow this
+		 * even if VM has started running.
+		 */
+		ret = set_fw_reg(vm, reg_info->reg, 0);
+		TEST_ASSERT(ret == 0,
+			"Failed to clear all the features of reg: 0x%lx; ret: %d\n",
+			reg_info->reg, errno);
+
+		/* Set all the features for this register again. KVM shouldn't
+		 * allow this as the VM is running.
+		 */
+		ret = set_fw_reg(vm, reg_info->reg, FW_REG_ULIMIT_VAL(reg_info->max_feat_bit));
+		TEST_ASSERT(ret != 0 && errno == EBUSY,
+		"Unexpected behavior or return value (%d) while setting a feature while VM is running for reg: 0x%lx\n",
+		errno, reg_info->reg);
+	}
+}
+
+static struct  kvm_vm *test_vm_create(void)
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
+			TEST_FAIL("%s at %s:%ld\n\tvalues: 0x%lx, %lu; %lu, stage: %u",
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
2.33.1.1089.g2158813163f-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
