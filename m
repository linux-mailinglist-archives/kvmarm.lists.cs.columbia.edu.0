Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BF04C5104C6
	for <lists+kvmarm@lfdr.de>; Tue, 26 Apr 2022 18:59:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1C4684B12C;
	Tue, 26 Apr 2022 12:59:26 -0400 (EDT)
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
	with ESMTP id 1Qfevb8-PZKI; Tue, 26 Apr 2022 12:59:25 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 29C7140C0A;
	Tue, 26 Apr 2022 12:59:24 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EEA0649F26
 for <kvmarm@lists.cs.columbia.edu>; Tue, 26 Apr 2022 12:59:21 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xw5E+GDxlhGY for <kvmarm@lists.cs.columbia.edu>;
 Tue, 26 Apr 2022 12:59:20 -0400 (EDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com
 [209.85.219.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 48AFB49E43
 for <kvmarm@lists.cs.columbia.edu>; Tue, 26 Apr 2022 12:59:20 -0400 (EDT)
Received: by mail-yb1-f172.google.com with SMTP id e12so5228146ybc.11
 for <kvmarm@lists.cs.columbia.edu>; Tue, 26 Apr 2022 09:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GH43qdalFH201bywPnynKUZzlq3g2/HxF1LQk9DABhQ=;
 b=Uzta1YZI7Jy2BsepTIAPH2iHY8+QVbAQm2WuRTvfQjdO+Zl0TRZ5s48KpmTMOljED8
 dlp+glTdjoXZ7+WRnbWOM34zoxDTa5fTmwjYVFz/zrw/gq+TTnuEA68ZkGWgFx5k062m
 d7NtID9A7CDm0FTV2cgPwBgxxuSD7QL05dGsXXxz21Djn9hWloPKV30mFUxO8MQndSPi
 ZcxzBwBKKlk43RePiPZmgRKr55YK4Jpw3zrGexCE6fuDTrHQZL275xlKSdQqnp19MZtS
 q9mjO9zgmXQbLR287q01cq28x/be2qK1DLQoklNucuYOBt5GJCrghmJRkrKZzb5HvEC0
 oAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GH43qdalFH201bywPnynKUZzlq3g2/HxF1LQk9DABhQ=;
 b=DQaPeQ8DcCPu7ivyCSe2ZTeCbJgv9JjfPNN5PoC8AG2KTW5D8ZLQSatiHvbq9eU1fd
 gJgX6Q1AMWBCfGOY3B+gqWmxkwvM5YlZhOevilQPsVm7I98FDff7/ezAPegarQUPXzT5
 ga1jjs/vAijGPNExQMiYhBm5S0UOn5y6LdscwkenWQ/1vGrrFuUQlkfV4b+O8JbAL+J7
 l9mopbGuyaXooK4tR3uX77r7uFEEY+0YowiA4OnQzBvo2cjegiS74eZCUh9MKGMhBpvR
 RHFcgLzauoM3yRVdf//vTH8cQkWhOFHwFp0JNx2POek5+auiwnVPrRPALOCeg8IKjIHq
 s2OA==
X-Gm-Message-State: AOAM533aNXRx8CPD5efheOY1dxZUfWZ/ybYH+87ydg9lhxpRUsJ/MIkv
 p7evZi98NatCG2D236Trl1cGZZE0RyOziz0l30sWKw==
X-Google-Smtp-Source: ABdhPJyS816mANzNCVy6Xw+/t0TYvoxND0MQXvY0xO2rpGgXp0BPOB5YvkrnMrAaGay/ubrvl3TbG4MxQf+GkmNhPEc=
X-Received: by 2002:a05:6902:1242:b0:644:c30c:cfcc with SMTP id
 t2-20020a056902124200b00644c30ccfccmr21290240ybu.509.1650992359476; Tue, 26
 Apr 2022 09:59:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220423000328.2103733-1-rananta@google.com>
 <20220423000328.2103733-9-rananta@google.com>
 <896e95a1-6a3e-c524-4951-8fae9697b85e@redhat.com>
In-Reply-To: <896e95a1-6a3e-c524-4951-8fae9697b85e@redhat.com>
From: Raghavendra Rao Ananta <rananta@google.com>
Date: Tue, 26 Apr 2022 09:59:08 -0700
Message-ID: <CAJHc60z_+O09u0wB9=PnuEu3bZC0tQG93iWbjTP7-WvnN-FEnQ@mail.gmail.com>
Subject: Re: [PATCH v6 8/9] selftests: KVM: aarch64: Introduce hypercall ABI
 test
To: Gavin Shan <gshan@redhat.com>
Cc: kvm@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Peter Shier <pshier@google.com>, linux-kernel@vger.kernel.org,
 Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvmarm@lists.cs.columbia.edu,
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

Hi Gavin,

On Tue, Apr 26, 2022 at 12:50 AM Gavin Shan <gshan@redhat.com> wrote:
>
> Hi Raghavendra,
>
> On 4/23/22 8:03 AM, Raghavendra Rao Ananta wrote:
> > Introduce a KVM selftest to check the hypercall interface
> > for arm64 platforms. The test validates the user-space'
> > [GET|SET]_ONE_REG interface to read/write the psuedo-firmware
> > registers as well as its effects on the guest upon certain
> > configurations.
> >
> > Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> > ---
> >   tools/testing/selftests/kvm/.gitignore        |   1 +
> >   tools/testing/selftests/kvm/Makefile          |   1 +
> >   .../selftests/kvm/aarch64/hypercalls.c        | 335 ++++++++++++++++++
> >   3 files changed, 337 insertions(+)
> >   create mode 100644 tools/testing/selftests/kvm/aarch64/hypercalls.c
> >
>
> There are comments about @false_hvc_info[] and some nits, as below.
> Please evaluate and improve if it makes sense to you. Otherwise, it
> looks good to me:
>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
>
> > diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
> > index 1bb575dfc42e..b17e464ec661 100644
> > --- a/tools/testing/selftests/kvm/.gitignore
> > +++ b/tools/testing/selftests/kvm/.gitignore
> > @@ -2,6 +2,7 @@
> >   /aarch64/arch_timer
> >   /aarch64/debug-exceptions
> >   /aarch64/get-reg-list
> > +/aarch64/hypercalls
> >   /aarch64/psci_test
> >   /aarch64/vcpu_width_config
> >   /aarch64/vgic_init
> > diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> > index c2cf4d318296..97eef0c03d3b 100644
> > --- a/tools/testing/selftests/kvm/Makefile
> > +++ b/tools/testing/selftests/kvm/Makefile
> > @@ -105,6 +105,7 @@ TEST_GEN_PROGS_x86_64 += system_counter_offset_test
> >   TEST_GEN_PROGS_aarch64 += aarch64/arch_timer
> >   TEST_GEN_PROGS_aarch64 += aarch64/debug-exceptions
> >   TEST_GEN_PROGS_aarch64 += aarch64/get-reg-list
> > +TEST_GEN_PROGS_aarch64 += aarch64/hypercalls
> >   TEST_GEN_PROGS_aarch64 += aarch64/psci_test
> >   TEST_GEN_PROGS_aarch64 += aarch64/vcpu_width_config
> >   TEST_GEN_PROGS_aarch64 += aarch64/vgic_init
> > diff --git a/tools/testing/selftests/kvm/aarch64/hypercalls.c b/tools/testing/selftests/kvm/aarch64/hypercalls.c
> > new file mode 100644
> > index 000000000000..f404343a0ae3
> > --- /dev/null
> > +++ b/tools/testing/selftests/kvm/aarch64/hypercalls.c
> > @@ -0,0 +1,335 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +
> > +/* hypercalls: Check the ARM64's psuedo-firmware bitmap register interface.
> > + *
> > + * The test validates the basic hypercall functionalities that are exposed
> > + * via the psuedo-firmware bitmap register. This includes the registers'
> > + * read/write behavior before and after the VM has started, and if the
> > + * hypercalls are properly masked or unmasked to the guest when disabled or
> > + * enabled from the KVM userspace, respectively.
> > + */
> > +
> > +#include <errno.h>
> > +#include <linux/arm-smccc.h>
> > +#include <asm/kvm.h>
> > +#include <kvm_util.h>
> > +
> > +#include "processor.h"
> > +
> > +#define FW_REG_ULIMIT_VAL(max_feat_bit) (GENMASK(max_feat_bit, 0))
> > +
> > +/* Last valid bits of the bitmapped firmware registers */
> > +#define KVM_REG_ARM_STD_BMAP_BIT_MAX         0
> > +#define KVM_REG_ARM_STD_HYP_BMAP_BIT_MAX     0
> > +#define KVM_REG_ARM_VENDOR_HYP_BMAP_BIT_MAX  1
> > +
> > +struct kvm_fw_reg_info {
> > +     uint64_t reg;           /* Register definition */
> > +     uint64_t max_feat_bit;  /* Bit that represents the upper limit of the feature-map */
> > +};
> > +
> > +#define FW_REG_INFO(r)                       \
> > +     {                                       \
> > +             .reg = r,                       \
> > +             .max_feat_bit = r##_BIT_MAX,    \
> > +     }
> > +
> > +static const struct kvm_fw_reg_info fw_reg_info[] = {
> > +     FW_REG_INFO(KVM_REG_ARM_STD_BMAP),
> > +     FW_REG_INFO(KVM_REG_ARM_STD_HYP_BMAP),
> > +     FW_REG_INFO(KVM_REG_ARM_VENDOR_HYP_BMAP),
> > +};
> > +
> > +enum test_stage {
> > +     TEST_STAGE_REG_IFACE,
> > +     TEST_STAGE_HVC_IFACE_FEAT_DISABLED,
> > +     TEST_STAGE_HVC_IFACE_FEAT_ENABLED,
> > +     TEST_STAGE_HVC_IFACE_FALSE_INFO,
> > +     TEST_STAGE_END,
> > +};
> > +
> > +static int stage = TEST_STAGE_REG_IFACE;
> > +
> > +struct test_hvc_info {
> > +     uint32_t func_id;
> > +     uint64_t arg1;
> > +};
> > +
> > +#define TEST_HVC_INFO(f, a1) \
> > +     {                       \
> > +             .func_id = f,   \
> > +             .arg1 = a1,     \
> > +     }
> > +
> > +static const struct test_hvc_info hvc_info[] = {
> > +     /* KVM_REG_ARM_STD_BMAP */
> > +     TEST_HVC_INFO(ARM_SMCCC_TRNG_VERSION, 0),
> > +     TEST_HVC_INFO(ARM_SMCCC_TRNG_FEATURES, ARM_SMCCC_TRNG_RND64),
> > +     TEST_HVC_INFO(ARM_SMCCC_TRNG_GET_UUID, 0),
> > +     TEST_HVC_INFO(ARM_SMCCC_TRNG_RND32, 0),
> > +     TEST_HVC_INFO(ARM_SMCCC_TRNG_RND64, 0),
> > +
> > +     /* KVM_REG_ARM_STD_HYP_BMAP */
> > +     TEST_HVC_INFO(ARM_SMCCC_ARCH_FEATURES_FUNC_ID, ARM_SMCCC_HV_PV_TIME_FEATURES),
> > +     TEST_HVC_INFO(ARM_SMCCC_HV_PV_TIME_FEATURES, ARM_SMCCC_HV_PV_TIME_ST),
> > +     TEST_HVC_INFO(ARM_SMCCC_HV_PV_TIME_ST, 0),
> > +
> > +     /* KVM_REG_ARM_VENDOR_HYP_BMAP */
> > +     TEST_HVC_INFO(ARM_SMCCC_VENDOR_HYP_KVM_FEATURES_FUNC_ID,
> > +                     ARM_SMCCC_VENDOR_HYP_KVM_PTP_FUNC_ID),
> > +     TEST_HVC_INFO(ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID, 0),
> > +     TEST_HVC_INFO(ARM_SMCCC_VENDOR_HYP_KVM_PTP_FUNC_ID, KVM_PTP_VIRT_COUNTER),
> > +};
> > +
> > +/* Feed false hypercall info to test the KVM behavior */
> > +static const struct test_hvc_info false_hvc_info[] = {
> > +     /* Feature support check against a different family of hypercalls */
> > +     TEST_HVC_INFO(ARM_SMCCC_TRNG_FEATURES, ARM_SMCCC_VENDOR_HYP_KVM_PTP_FUNC_ID),
> > +     TEST_HVC_INFO(ARM_SMCCC_ARCH_FEATURES_FUNC_ID, ARM_SMCCC_TRNG_RND64),
> > +     TEST_HVC_INFO(ARM_SMCCC_HV_PV_TIME_FEATURES, ARM_SMCCC_TRNG_RND64),
> > +};
> > +
>
> I don't see too much benefits of @false_hvc_info[] because
> NOT_SUPPORTED is always returned from its test case. I think
> it and its test case can be removed if you agree. I'm not
> sure if it was suggested by somebody else.
>
While this is not exactly testing the bitmap firmware registers, the
idea behind introducing false_hvc_info[] was to introduce some
negative tests and see if KVM handles it well. Especially with
*_FEATURES func_ids, we can accidentally introduce functional bugs in
KVM, and these would act as our safety net. I was planning to also
test with some reserved hypercall numbers, just to test if the kernel
doesn't panic for some reason.

> > +static void guest_test_hvc(const struct test_hvc_info *hc_info)
> > +{
> > +     unsigned int i;
> > +     struct arm_smccc_res res;
> > +     unsigned int hvc_info_arr_sz;
> > +
> > +     hvc_info_arr_sz =
> > +     hc_info == hvc_info ? ARRAY_SIZE(hvc_info) : ARRAY_SIZE(false_hvc_info);
> > +
> > +     for (i = 0; i < hvc_info_arr_sz; i++, hc_info++) {
> > +             memset(&res, 0, sizeof(res));
> > +             smccc_hvc(hc_info->func_id, hc_info->arg1, 0, 0, 0, 0, 0, 0, &res);
> > +
> > +             switch (stage) {
> > +             case TEST_STAGE_HVC_IFACE_FEAT_DISABLED:
> > +             case TEST_STAGE_HVC_IFACE_FALSE_INFO:
> > +                     GUEST_ASSERT_3(res.a0 == SMCCC_RET_NOT_SUPPORTED,
> > +                                     res.a0, hc_info->func_id, hc_info->arg1);
> > +                     break;
> > +             case TEST_STAGE_HVC_IFACE_FEAT_ENABLED:
> > +                     GUEST_ASSERT_3(res.a0 != SMCCC_RET_NOT_SUPPORTED,
> > +                                     res.a0, hc_info->func_id, hc_info->arg1);
> > +                     break;
> > +             default:
> > +                     GUEST_ASSERT_1(0, stage);
> > +             }
> > +     }
> > +}
> > +
> > +static void guest_code(void)
> > +{
> > +     while (stage != TEST_STAGE_END) {
> > +             switch (stage) {
> > +             case TEST_STAGE_REG_IFACE:
> > +                     break;
> > +             case TEST_STAGE_HVC_IFACE_FEAT_DISABLED:
> > +             case TEST_STAGE_HVC_IFACE_FEAT_ENABLED:
> > +                     guest_test_hvc(hvc_info);
> > +                     break;
> > +             case TEST_STAGE_HVC_IFACE_FALSE_INFO:
> > +                     guest_test_hvc(false_hvc_info);
> > +                     break;
> > +             default:
> > +                     GUEST_ASSERT_1(0, stage);
> > +             }
> > +
> > +             GUEST_SYNC(stage);
> > +     }
> > +
> > +     GUEST_DONE();
> > +}
> > +
> > +static int set_fw_reg(struct kvm_vm *vm, uint64_t id, uint64_t val)
> > +{
> > +     struct kvm_one_reg reg = {
> > +             .id = id,
> > +             .addr = (uint64_t)&val,
> > +     };
> > +
> > +     return _vcpu_ioctl(vm, 0, KVM_SET_ONE_REG, &reg);
> > +}
> > +
> > +static void get_fw_reg(struct kvm_vm *vm, uint64_t id, uint64_t *addr)
> > +{
> > +     struct kvm_one_reg reg = {
> > +             .id = id,
> > +             .addr = (uint64_t)addr,
> > +     };
> > +
> > +     vcpu_ioctl(vm, 0, KVM_GET_ONE_REG, &reg);
> > +}
> > +
> > +struct st_time {
> > +     uint32_t rev;
> > +     uint32_t attr;
> > +     uint64_t st_time;
> > +};
> > +
> > +#define STEAL_TIME_SIZE              ((sizeof(struct st_time) + 63) & ~63)
> > +#define ST_GPA_BASE          (1 << 30)
> > +
> > +static void steal_time_init(struct kvm_vm *vm)
> > +{
> > +     uint64_t st_ipa = (ulong)ST_GPA_BASE;
> > +     unsigned int gpages;
> > +     struct kvm_device_attr dev = {
> > +             .group = KVM_ARM_VCPU_PVTIME_CTRL,
> > +             .attr = KVM_ARM_VCPU_PVTIME_IPA,
> > +             .addr = (uint64_t)&st_ipa,
> > +     };
> > +
> > +     gpages = vm_calc_num_guest_pages(VM_MODE_DEFAULT, STEAL_TIME_SIZE);
> > +     vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, ST_GPA_BASE, 1, gpages, 0);
> > +
> > +     vcpu_ioctl(vm, 0, KVM_SET_DEVICE_ATTR, &dev);
> > +}
> > +
> > +static void test_fw_regs_before_vm_start(struct kvm_vm *vm)
> > +{
> > +     uint64_t val;
> > +     unsigned int i;
> > +     int ret;
> > +
> > +     for (i = 0; i < ARRAY_SIZE(fw_reg_info); i++) {
> > +             const struct kvm_fw_reg_info *reg_info = &fw_reg_info[i];
> > +
> > +             /* First 'read' should be an upper limit of the features supported */
> > +             get_fw_reg(vm, reg_info->reg, &val);
> > +             TEST_ASSERT(val == FW_REG_ULIMIT_VAL(reg_info->max_feat_bit),
> > +                     "Expected all the features to be set for reg: 0x%lx; expected: 0x%lx; read: 0x%lx\n",
> > +                     reg_info->reg, FW_REG_ULIMIT_VAL(reg_info->max_feat_bit), val);
> > +
> > +             /* Test a 'write' by disabling all the features of the register map */
> > +             ret = set_fw_reg(vm, reg_info->reg, 0);
> > +             TEST_ASSERT(ret == 0,
> > +                     "Failed to clear all the features of reg: 0x%lx; ret: %d\n",
> > +                     reg_info->reg, errno);
> > +
> > +             get_fw_reg(vm, reg_info->reg, &val);
> > +             TEST_ASSERT(val == 0,
> > +                     "Expected all the features to be cleared for reg: 0x%lx\n", reg_info->reg);
> > +
> > +             /*
> > +              * Test enabling a feature that's not supported.
> > +              * Avoid this check if all the bits are occupied.
> > +              */
> > +             if (reg_info->max_feat_bit < 63) {
> > +                     ret = set_fw_reg(vm, reg_info->reg, BIT(reg_info->max_feat_bit + 1));
> > +                     TEST_ASSERT(ret != 0 && errno == EINVAL,
> > +                     "Unexpected behavior or return value (%d) while setting an unsupported feature for reg: 0x%lx\n",
> > +                     errno, reg_info->reg);
> > +             }
> > +     }
> > +}
>
> Just in case :)
>
>       ret = set_fw_reg(vm, reg_info->reg, GENMASK(63, reg_info->max_feat_bit + 1));
>
It may be better to cover the entire range, but to test only the
(max_feat_bit + 1) gives us the advantage of checking if there's any
discrepancy between the kernel and the test, now that *_BIT_MAX are
not a part of UAPI headers.

Probably also include your test along with the existing one?
>
> > +
> > +static void test_fw_regs_after_vm_start(struct kvm_vm *vm)
> > +{
> > +     uint64_t val;
> > +     unsigned int i;
> > +     int ret;
> > +
> > +     for (i = 0; i < ARRAY_SIZE(fw_reg_info); i++) {
> > +             const struct kvm_fw_reg_info *reg_info = &fw_reg_info[i];
> > +
> > +             /*
> > +              * Before starting the VM, the test clears all the bits.
> > +              * Check if that's still the case.
> > +              */
> > +             get_fw_reg(vm, reg_info->reg, &val);
> > +             TEST_ASSERT(val == 0,
> > +                     "Expected all the features to be cleared for reg: 0x%lx\n",
> > +                     reg_info->reg);
> > +
> > +             /*
> > +              * Set all the features for this register again. KVM shouldn't
> > +              * allow this as the VM is running.
> > +              */
> > +             ret = set_fw_reg(vm, reg_info->reg, FW_REG_ULIMIT_VAL(reg_info->max_feat_bit));
> > +             TEST_ASSERT(ret != 0 && errno == EBUSY,
> > +             "Unexpected behavior or return value (%d) while setting a feature while VM is running for reg: 0x%lx\n",
> > +             errno, reg_info->reg);
> > +     }
> > +}
> > +
>
> I guess you want to check -EBUSY is returned. In that case,
> the comments here could be clearer, something like below
> to emphasize '-EBUSY'.
>
>          /*
>           * After VM runs for once, -EBUSY should be returned on attempt
>           * to set features. Check if the correct errno is returned.
>           */
>
Sounds good.

> > +static struct kvm_vm *test_vm_create(void)
> > +{
> > +     struct kvm_vm *vm;
> > +
> > +     vm = vm_create_default(0, 0, guest_code);
> > +
> > +     ucall_init(vm, NULL);
> > +     steal_time_init(vm);
> > +
> > +     return vm;
> > +}
> > +
> > +static struct kvm_vm *test_guest_stage(struct kvm_vm *vm)
> > +{
> > +     struct kvm_vm *ret_vm = vm;
> > +
> > +     pr_debug("Stage: %d\n", stage);
> > +
> > +     switch (stage) {
> > +     case TEST_STAGE_REG_IFACE:
> > +             test_fw_regs_after_vm_start(vm);
> > +             break;
> > +     case TEST_STAGE_HVC_IFACE_FEAT_DISABLED:
> > +             /* Start a new VM so that all the features are now enabled by default */
> > +             kvm_vm_free(vm);
> > +             ret_vm = test_vm_create();
> > +             break;
> > +     case TEST_STAGE_HVC_IFACE_FEAT_ENABLED:
> > +     case TEST_STAGE_HVC_IFACE_FALSE_INFO:
> > +             break;
> > +     default:
> > +             TEST_FAIL("Unknown test stage: %d\n", stage);
> > +     }
> > +
> > +     stage++;
> > +     sync_global_to_guest(vm, stage);
> > +
> > +     return ret_vm;
> > +}
> > +
> > +static void test_run(void)
> > +{
> > +     struct kvm_vm *vm;
> > +     struct ucall uc;
> > +     bool guest_done = false;
> > +
> > +     vm = test_vm_create();
> > +
> > +     test_fw_regs_before_vm_start(vm);
> > +
> > +     while (!guest_done) {
> > +             vcpu_run(vm, 0);
> > +
> > +             switch (get_ucall(vm, 0, &uc)) {
> > +             case UCALL_SYNC:
> > +                     vm = test_guest_stage(vm);
> > +                     break;
> > +             case UCALL_DONE:
> > +                     guest_done = true;
> > +                     break;
> > +             case UCALL_ABORT:
> > +                     TEST_FAIL("%s at %s:%ld\n\tvalues: 0x%lx, 0x%lx; 0x%lx, stage: %u",
> > +                     (const char *)uc.args[0], __FILE__, uc.args[1],
> > +                     uc.args[2], uc.args[3], uc.args[4], stage);
> > +                     break;
> > +             default:
> > +                     TEST_FAIL("Unexpected guest exit\n");
> > +             }
> > +     }
> > +
> > +     kvm_vm_free(vm);
> > +}
> > +
> > +int main(void)
> > +{
> > +     setbuf(stdout, NULL);
> > +
> > +     test_run();
> > +     return 0;
> > +}
> >
>
> Thanks,
> Gavin
>
Thanks for the reviews on all the patches, Gavin.

Regards,
Raghavendra
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
