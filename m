Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 575C24FF2F0
	for <lists+kvmarm@lfdr.de>; Wed, 13 Apr 2022 11:07:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AA8F54B2A8;
	Wed, 13 Apr 2022 05:07:34 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.79
X-Spam-Level: 
X-Spam-Status: No, score=-1.79 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EddyPN77ktKy; Wed, 13 Apr 2022 05:07:34 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BED124B275;
	Wed, 13 Apr 2022 05:07:32 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BE20549E57
 for <kvmarm@lists.cs.columbia.edu>; Wed, 13 Apr 2022 05:07:31 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VvkSmGbtGn4B for <kvmarm@lists.cs.columbia.edu>;
 Wed, 13 Apr 2022 05:07:29 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 111B140A84
 for <kvmarm@lists.cs.columbia.edu>; Wed, 13 Apr 2022 05:07:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649840848;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SDlJEhU1w1NiuS64juxKCj8lRqkoD4sH0jwdEczay8A=;
 b=EhTiqCJIt/xzXUPat38s/Ah0IxzVN8Lis/MtS90vcdz1XvsZoRNNJJi4Iqr0obs+lmfK9C
 L/j4zWati9nSmVPtInN2yAGax7A4H2wsWIQ9XvH4dVDLJENSB9LV1W6k9kMK6SYUEQrBdH
 hVBnS5WyoDQNA2NHE7Rzy4G2grMLdfw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-534-cJzR_M33P-mFRSURkftHYA-1; Wed, 13 Apr 2022 05:07:25 -0400
X-MC-Unique: cJzR_M33P-mFRSURkftHYA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B0B5F185A7A4;
 Wed, 13 Apr 2022 09:07:24 +0000 (UTC)
Received: from [10.72.13.171] (ovpn-13-171.pek2.redhat.com [10.72.13.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F30731400B18;
 Wed, 13 Apr 2022 09:07:17 +0000 (UTC)
Subject: Re: [PATCH v5 08/10] selftests: KVM: aarch64: Introduce hypercall ABI
 test
To: Raghavendra Rao Ananta <rananta@google.com>, Marc Zyngier
 <maz@kernel.org>, Andrew Jones <drjones@redhat.com>,
 James Morse <james.morse@arm.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>
References: <20220407011605.1966778-1-rananta@google.com>
 <20220407011605.1966778-9-rananta@google.com>
From: Gavin Shan <gshan@redhat.com>
Message-ID: <7da91aa4-4fa9-13e6-5561-036cfce3e3e0@redhat.com>
Date: Wed, 13 Apr 2022 17:07:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20220407011605.1966778-9-rananta@google.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Cc: kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Peter Shier <pshier@google.com>, linux-kernel@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
Reply-To: Gavin Shan <gshan@redhat.com>
List-Id: Where KVM/ARM decisions are made <kvmarm.lists.cs.columbia.edu>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

Hi Raghavendra,

On 4/7/22 9:16 AM, Raghavendra Rao Ananta wrote:
> Introduce a KVM selftest to check the hypercall interface
> for arm64 platforms. The test validates the user-space's
> IOCTL interface to read/write the psuedo-firmware registers
> as well as its effects on the guest upon certain configurations.
> 
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> ---
>   tools/testing/selftests/kvm/.gitignore        |   1 +
>   tools/testing/selftests/kvm/Makefile          |   1 +
>   .../selftests/kvm/aarch64/hypercalls.c        | 344 ++++++++++++++++++
>   3 files changed, 346 insertions(+)
>   create mode 100644 tools/testing/selftests/kvm/aarch64/hypercalls.c
> 

To be more precise, s/IOCTL/{GET,SET}_ONE_REG ?

> diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
> index e82b816a6608..7ef52b3b1560 100644
> --- a/tools/testing/selftests/kvm/.gitignore
> +++ b/tools/testing/selftests/kvm/.gitignore
> @@ -2,6 +2,7 @@
>   /aarch64/arch_timer
>   /aarch64/debug-exceptions
>   /aarch64/get-reg-list
> +/aarch64/hypercalls
>   /aarch64/psci_test
>   /aarch64/vgic_init
>   /aarch64/vgic_irq
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index 2f74f502de65..af4cb88bcf83 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -105,6 +105,7 @@ TEST_GEN_PROGS_x86_64 += system_counter_offset_test
>   TEST_GEN_PROGS_aarch64 += aarch64/arch_timer
>   TEST_GEN_PROGS_aarch64 += aarch64/debug-exceptions
>   TEST_GEN_PROGS_aarch64 += aarch64/get-reg-list
> +TEST_GEN_PROGS_aarch64 += aarch64/hypercalls
>   TEST_GEN_PROGS_aarch64 += aarch64/psci_test
>   TEST_GEN_PROGS_aarch64 += aarch64/vgic_init
>   TEST_GEN_PROGS_aarch64 += aarch64/vgic_irq
> diff --git a/tools/testing/selftests/kvm/aarch64/hypercalls.c b/tools/testing/selftests/kvm/aarch64/hypercalls.c
> new file mode 100644
> index 000000000000..9941fb75772a
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/aarch64/hypercalls.c
> @@ -0,0 +1,344 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/* hypercalls: Check the ARM64's psuedo-firmware bitmap register interface.
> + *
> + * The test validates the basic hypercall functionalities that are exposed
> + * via the psuedo-firmware bitmap register. This includes the registers'
> + * read/write behavior before and after the VM has started, and if the
> + * hypercalls are properly masked or unmasked to the guest when disabled or
> + * enabled from the KVM userspace, respectively.
> + */
> +
> +#include <errno.h>
> +#include <linux/arm-smccc.h>
> +#include <asm/kvm.h>
> +#include <kvm_util.h>
> +
> +#include "processor.h"
> +
> +#define FW_REG_ULIMIT_VAL(max_feat_bit) (GENMASK_ULL(max_feat_bit, 0))
> +
> +/* Last valid bits of the bitmapped firmware registers */
> +#define KVM_REG_ARM_STD_BMAP_BIT_MAX		0
> +#define KVM_REG_ARM_STD_HYP_BMAP_BIT_MAX	0
> +#define KVM_REG_ARM_VENDOR_HYP_BMAP_BIT_MAX	1
> +
> +struct kvm_fw_reg_info {
> +	uint64_t reg;		/* Register definition */
> +	uint64_t max_feat_bit;	/* Bit that represents the upper limit of the feature-map */
> +};
> +
> +#define FW_REG_INFO(r, bit_max)			\
> +	{					\
> +		.reg = r,			\
> +		.max_feat_bit = bit_max,	\
> +	}
> +
> +static const struct kvm_fw_reg_info fw_reg_info[] = {
> +	FW_REG_INFO(KVM_REG_ARM_STD_BMAP, KVM_REG_ARM_STD_BMAP_BIT_MAX),
> +	FW_REG_INFO(KVM_REG_ARM_STD_HYP_BMAP, KVM_REG_ARM_STD_HYP_BMAP_BIT_MAX),
> +	FW_REG_INFO(KVM_REG_ARM_VENDOR_HYP_BMAP, KVM_REG_ARM_VENDOR_HYP_BMAP_BIT_MAX),
> +};
> +

This can be simplifed by:

#define FW_REG_INFO(r)			\
	{ .reg = r,			\
	  .max_feat_bit = r_##BIT_MAX,	\
	}

static const struct kvm_fw_reg_info fw_reg_info[] = {
	FW_REG_INFO(KVM_REG_ARM_STD_BMAP),
	FW_REG_INFO(KVM_REG_ARM_STD_HYP_BMAP),
	FW_REG_INFO(KVM_REG_ARM_VENDOR_HYP_BMAP),
};

> +enum test_stage {
> +	TEST_STAGE_REG_IFACE,
> +	TEST_STAGE_HVC_IFACE_FEAT_DISABLED,
> +	TEST_STAGE_HVC_IFACE_FEAT_ENABLED,
> +	TEST_STAGE_HVC_IFACE_FALSE_INFO,
> +	TEST_STAGE_END,
> +};
> +
> +static int stage;
> +

I think it'd better to initialize @stage to TEST_STAGE_REG_IFACE.

> +struct test_hvc_info {
> +	uint32_t func_id;
> +	int64_t arg0;
> +};
> +
> +#define TEST_HVC_INFO(f, a0)	\
> +	{			\
> +		.func_id = f,	\
> +		.arg0 = a0,	\
> +	}
> +

According to those functions (smccc_get_{function, argx}()) defined
in include/kvm/arm_hypercalls.h, @arg0 would have type of "uint64_t"
if I'm correct. Besides, @func_id is arg0 and arg0 should be arg1?
So if I'm correct, this would be:

struct test_hvc_info {
	uint32_t func_id;
	uint64_t arg1
};

> +static const struct test_hvc_info hvc_info[] = {
> +	/* KVM_REG_ARM_STD_BMAP */
> +	TEST_HVC_INFO(ARM_SMCCC_TRNG_VERSION, 0),
> +	TEST_HVC_INFO(ARM_SMCCC_TRNG_FEATURES, ARM_SMCCC_TRNG_RND64),
> +	TEST_HVC_INFO(ARM_SMCCC_TRNG_GET_UUID, 0),
> +	TEST_HVC_INFO(ARM_SMCCC_TRNG_RND32, 0),
> +	TEST_HVC_INFO(ARM_SMCCC_TRNG_RND64, 0),
> +
> +	/* KVM_REG_ARM_STD_HYP_BMAP */
> +	TEST_HVC_INFO(ARM_SMCCC_ARCH_FEATURES_FUNC_ID, ARM_SMCCC_HV_PV_TIME_FEATURES),
> +	TEST_HVC_INFO(ARM_SMCCC_HV_PV_TIME_FEATURES, ARM_SMCCC_HV_PV_TIME_ST),
> +	TEST_HVC_INFO(ARM_SMCCC_HV_PV_TIME_ST, 0),
> +
> +	/* KVM_REG_ARM_VENDOR_HYP_BMAP */
> +	TEST_HVC_INFO(ARM_SMCCC_VENDOR_HYP_KVM_FEATURES_FUNC_ID,
> +			ARM_SMCCC_VENDOR_HYP_KVM_PTP_FUNC_ID),
> +	TEST_HVC_INFO(ARM_SMCCC_VENDOR_HYP_KVM_PTP_FUNC_ID, KVM_PTP_VIRT_COUNTER),
> +};
> +
> +/* Feed false hypercall info to test the KVM behavior */
> +static const struct test_hvc_info false_hvc_info[] = {
> +	/* Feature support check against a different family of hypercalls */
> +	TEST_HVC_INFO(ARM_SMCCC_TRNG_FEATURES, ARM_SMCCC_VENDOR_HYP_KVM_PTP_FUNC_ID),
> +	TEST_HVC_INFO(ARM_SMCCC_ARCH_FEATURES_FUNC_ID, ARM_SMCCC_TRNG_RND64),
> +	TEST_HVC_INFO(ARM_SMCCC_HV_PV_TIME_FEATURES, ARM_SMCCC_TRNG_RND64),
> +};
> +
> +static void guest_test_hvc(const struct test_hvc_info *hc_info)
> +{
> +	unsigned int i;
> +	struct arm_smccc_res res;
> +	unsigned int hvc_info_arr_sz;
> +
> +	hvc_info_arr_sz =
> +	hc_info == hvc_info ? ARRAY_SIZE(hvc_info) : ARRAY_SIZE(false_hvc_info);
> +
> +	for (i = 0; i < hvc_info_arr_sz; i++, hc_info++) {
> +
> +		memset(&res, 0, sizeof(res));
> +		smccc_hvc(hc_info->func_id, hc_info->arg0, 0, 0, 0, 0, 0, 0, &res);
> +

Unnecessary empty line before memset(). I don't find where smccc_hvc()
is defined.

> +		switch (stage) {
> +		case TEST_STAGE_HVC_IFACE_FEAT_DISABLED:
> +		case TEST_STAGE_HVC_IFACE_FALSE_INFO:
> +			GUEST_ASSERT_3(res.a0 == SMCCC_RET_NOT_SUPPORTED,
> +					res.a0, hc_info->func_id, hc_info->arg0);
                                        ^^

It seems the code here isn't properly aligned. Maybe it's your
preference :)

> +			break;
> +		case TEST_STAGE_HVC_IFACE_FEAT_ENABLED:
> +			GUEST_ASSERT_3(res.a0 != SMCCC_RET_NOT_SUPPORTED,
> +					res.a0, hc_info->func_id, hc_info->arg0);
> +			break;
> +		default:
> +			GUEST_ASSERT_1(0, stage);
> +		}
> +	}
> +}
> +
> +static void guest_code(void)
> +{
> +	while (stage != TEST_STAGE_END) {
> +		switch (stage) {
> +		case TEST_STAGE_REG_IFACE:
> +			break;
> +		case TEST_STAGE_HVC_IFACE_FEAT_DISABLED:
> +		case TEST_STAGE_HVC_IFACE_FEAT_ENABLED:
> +			guest_test_hvc(hvc_info);
> +			break;
> +		case TEST_STAGE_HVC_IFACE_FALSE_INFO:
> +			guest_test_hvc(false_hvc_info);
> +			break;
> +		default:
> +			GUEST_ASSERT_1(0, stage);
> +		}
> +
> +		GUEST_SYNC(stage);
> +	}
> +
> +	GUEST_DONE();
> +}
> +
> +static int set_fw_reg(struct kvm_vm *vm, uint64_t id, uint64_t val)
> +{
> +	struct kvm_one_reg reg = {
> +		.id = id,
> +		.addr = (uint64_t)&val,
> +	};
> +
> +	return _vcpu_ioctl(vm, 0, KVM_SET_ONE_REG, &reg);
> +}
> +
> +static void get_fw_reg(struct kvm_vm *vm, uint64_t id, uint64_t *addr)
> +{
> +	struct kvm_one_reg reg = {
> +		.id = id,
> +		.addr = (uint64_t)addr,
> +	};
> +
> +	vcpu_ioctl(vm, 0, KVM_GET_ONE_REG, &reg);
> +}
> +
> +struct st_time {
> +	uint32_t rev;
> +	uint32_t attr;
> +	uint64_t st_time;
> +};
> +
> +#define STEAL_TIME_SIZE		((sizeof(struct st_time) + 63) & ~63)
> +#define ST_GPA_BASE		(1 << 30)
> +
> +static void steal_time_init(struct kvm_vm *vm)
> +{
> +	uint64_t st_ipa = (ulong)ST_GPA_BASE;
> +	unsigned int gpages;
> +	struct kvm_device_attr dev = {
> +		.group = KVM_ARM_VCPU_PVTIME_CTRL,
> +		.attr = KVM_ARM_VCPU_PVTIME_IPA,
> +		.addr = (uint64_t)&st_ipa,
> +	};
> +
> +	gpages = vm_calc_num_guest_pages(VM_MODE_DEFAULT, STEAL_TIME_SIZE);
> +	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, ST_GPA_BASE, 1, gpages, 0);
> +
> +	vcpu_ioctl(vm, 0, KVM_SET_DEVICE_ATTR, &dev);
> +}
> +

It might be helpful to do TEST_FAIL() on error returned from
this vcpu_ioctl(), or skip those PVTIME SMCCC calls accordingly
if the attribute isn't set successfully.

> +static void test_fw_regs_before_vm_start(struct kvm_vm *vm)
> +{
> +	uint64_t val;
> +	unsigned int i;
> +	int ret;
> +
> +	for (i = 0; i < ARRAY_SIZE(fw_reg_info); i++) {
> +		const struct kvm_fw_reg_info *reg_info = &fw_reg_info[i];
> +
> +		/* First 'read' should be an upper limit of the features supported */
> +		get_fw_reg(vm, reg_info->reg, &val);
> +		TEST_ASSERT(val == FW_REG_ULIMIT_VAL(reg_info->max_feat_bit),
> +			"Expected all the features to be set for reg: 0x%lx; expected: 0x%llx; read: 0x%lx\n",
> +			reg_info->reg, GENMASK_ULL(reg_info->max_feat_bit, 0), val);
> +

s/GENMASK_ULL(...)/FW_REG_ULIMIT_VAL(...)

> +		/* Test a 'write' by disabling all the features of the register map */
> +		ret = set_fw_reg(vm, reg_info->reg, 0);
> +		TEST_ASSERT(ret == 0,
> +			"Failed to clear all the features of reg: 0x%lx; ret: %d\n",
> +			reg_info->reg, errno);
> +
> +		get_fw_reg(vm, reg_info->reg, &val);
> +		TEST_ASSERT(val == 0,
> +			"Expected all the features to be cleared for reg: 0x%lx\n", reg_info->reg);
> +
> +		/*
> +		 * Test enabling a feature that's not supported.
> +		 * Avoid this check if all the bits are occupied.
> +		 */
> +		if (reg_info->max_feat_bit < 63) {
> +			ret = set_fw_reg(vm, reg_info->reg, BIT(reg_info->max_feat_bit + 1));
> +			TEST_ASSERT(ret != 0 && errno == EINVAL,
> +			"Unexpected behavior or return value (%d) while setting an unsupported feature for reg: 0x%lx\n",
> +			errno, reg_info->reg);
> +		}
> +	}
> +}
> +
> +static void test_fw_regs_after_vm_start(struct kvm_vm *vm)
> +{
> +	uint64_t val;
> +	unsigned int i;
> +	int ret;
> +
> +	for (i = 0; i < ARRAY_SIZE(fw_reg_info); i++) {
> +		const struct kvm_fw_reg_info *reg_info = &fw_reg_info[i];
> +
> +		/*
> +		 * Before starting the VM, the test clears all the bits.
> +		 * Check if that's still the case.
> +		 */
> +		get_fw_reg(vm, reg_info->reg, &val);
> +		TEST_ASSERT(val == 0,
> +			"Expected all the features to be cleared for reg: 0x%lx\n",
> +			reg_info->reg);
> +
> +		/*
> +		 * Test setting the last read value. KVM should allow this
> +		 * even if VM has started running.
> +		 */
> +		ret = set_fw_reg(vm, reg_info->reg, val);
> +		TEST_ASSERT(ret == 0,
> +			"Failed to set the register with previously read value after Vm start for reg: 0x%lx; ret: %d\n",
> +			reg_info->reg, errno);
> +
> +		/*
> +		 * Set all the features for this register again. KVM shouldn't
> +		 * allow this as the VM is running.
> +		 */
> +		ret = set_fw_reg(vm, reg_info->reg, FW_REG_ULIMIT_VAL(reg_info->max_feat_bit));
> +		TEST_ASSERT(ret != 0 && errno == EBUSY,
> +		"Unexpected behavior or return value (%d) while setting a feature while VM is running for reg: 0x%lx\n",
> +		errno, reg_info->reg);
> +	}
> +}
> +
> +static struct kvm_vm *test_vm_create(void)
> +{
> +	struct kvm_vm *vm;
> +
> +	vm = vm_create_default(0, 0, guest_code);
> +
> +	ucall_init(vm, NULL);
> +	steal_time_init(vm);
> +
> +	return vm;
> +}
> +
> +static struct kvm_vm *test_guest_stage(struct kvm_vm *vm)
> +{
> +	struct kvm_vm *ret_vm = vm;
> +
> +	pr_debug("Stage: %d\n", stage);
> +
> +	switch (stage) {
> +	case TEST_STAGE_REG_IFACE:
> +		test_fw_regs_after_vm_start(vm);
> +		break;
> +	case TEST_STAGE_HVC_IFACE_FEAT_DISABLED:
> +		/* Start a new VM so that all the features are now enabled by default */
> +		kvm_vm_free(vm);
> +		ret_vm = test_vm_create();
> +		break;
> +	case TEST_STAGE_HVC_IFACE_FEAT_ENABLED:
> +	case TEST_STAGE_HVC_IFACE_FALSE_INFO:
> +		break;
> +	default:
> +		TEST_FAIL("Unknown test stage: %d\n", stage);
> +	}
> +
> +	stage++;
> +	sync_global_to_guest(vm, stage);
> +
> +	return ret_vm;
> +}
> +
> +static void test_run(void)
> +{
> +	struct kvm_vm *vm;
> +	struct ucall uc;
> +	bool guest_done = false;
> +
> +	vm = test_vm_create();
> +
> +	test_fw_regs_before_vm_start(vm);
> +
> +	while (!guest_done) {
> +		vcpu_run(vm, 0);
> +
> +		switch (get_ucall(vm, 0, &uc)) {
> +		case UCALL_SYNC:
> +			vm = test_guest_stage(vm);
> +			break;
> +		case UCALL_DONE:
> +			guest_done = true;
> +			break;
> +		case UCALL_ABORT:
> +			TEST_FAIL("%s at %s:%ld\n\tvalues: 0x%lx, 0x%lx; 0x%lx, stage: %u",
> +			(const char *)uc.args[0], __FILE__, uc.args[1],
> +			uc.args[2], uc.args[3], uc.args[4], stage);
> +			break;
> +		default:
> +			TEST_FAIL("Unexpected guest exit\n");
> +		}
> +	}
> +
> +	kvm_vm_free(vm);
> +}
> +
> +int main(void)
> +{
> +	setbuf(stdout, NULL);
> +
> +	test_run();
> +	return 0;
> +}
> 

Thanks,
Gavin

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
