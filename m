Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id DD08648A48B
	for <lists+kvmarm@lfdr.de>; Tue, 11 Jan 2022 01:51:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 21DE24B150;
	Mon, 10 Jan 2022 19:51:12 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.912
X-Spam-Level: 
X-Spam-Status: No, score=0.912 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_BLOCKED=0.001,
	T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r8s0G-EKPpIW; Mon, 10 Jan 2022 19:51:11 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 542A14A1D9;
	Mon, 10 Jan 2022 19:51:10 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 31FA34A1D9
 for <kvmarm@lists.cs.columbia.edu>; Mon, 10 Jan 2022 19:51:09 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w+kCdNNxe8Dv for <kvmarm@lists.cs.columbia.edu>;
 Mon, 10 Jan 2022 19:51:06 -0500 (EST)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com
 [209.85.219.175])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D166C49F52
 for <kvmarm@lists.cs.columbia.edu>; Mon, 10 Jan 2022 19:51:06 -0500 (EST)
Received: by mail-yb1-f175.google.com with SMTP id 127so26658252ybb.4
 for <kvmarm@lists.cs.columbia.edu>; Mon, 10 Jan 2022 16:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Pmpqp91e6SvUNAONlQ36UiaL7+XaopqtxX6bbBDZAFw=;
 b=OwmapPIMP2qKl+nRlrc/xDUIwFrqLB5DYd3AHOzmi8dZI+/U8mdA+6hG+XXxnjvz1f
 mXdgss0CqlbyJjFSKz3dNvQ6b5fGwehILLezow9a6G2fctZvMhXRfPqV8BH0p/7wGvt6
 9evYLpiFfihz+G+X9Ut1tO2I859ONevqSSUU00esXSHqmG2asaHo6RViszdXrgKXiKYc
 2BqdzD2qFNGIrweQzHNZ5nEfSohvfkmUmoCvW83U1Dhs+CJC7/UHKkTbNE5OXHf8guyb
 9ydwkYMICBKlMkxI2hVAjH0ETfFLH43xaEgKbE6uADcmHuu6yDrVhyj2tArT3kc1zNsL
 dBhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Pmpqp91e6SvUNAONlQ36UiaL7+XaopqtxX6bbBDZAFw=;
 b=6dI8Q+YeC1MHYoT0LIPVBoz9gt021qNANNmHrbrJOuwhnCnPITVqmF/Q9O68fePDhU
 FbYNTi6WKfjF1joDvJSTzD1M8SmENaKxW1EIYdgQFzWPHsJbe3FrgijUMOASHRN4sKDK
 0vJA+ZQEdkyIYXcO9lf+7Spi0NRFdnyfgtnpoVbZC4CPMvuYs5ZImGVqSUTQXs9lpJzv
 ePwV/oPGnPBP71JMqOfQPqOEP/7bb+DIl3ZSqmFgmQLdBvKMGxEUIQdridIEIlU5DWnF
 zQlEVGQ/Bj8kJ4IMRymcvzTY7zsw/hCu361S8beGM8vLF8cwAKTFIBlu15Vwmj1//cqz
 qVIQ==
X-Gm-Message-State: AOAM53179dUfntaE6yzaJbxP+481yAdB11F8osFJq53AmQV/VRmYy0PB
 Y0oMcskOOsnBt/M3ocG+FdTBY9AJ/To5g3UPBQ6fgw==
X-Google-Smtp-Source: ABdhPJxhivvY3ED9p2TAObQXTzuRRjN1B6OR494rM9cb+SNgIp3i5sbM+Eksa4+XqFmuiZIuMcQ3fjkINehk869GIG4=
X-Received: by 2002:a25:d34b:: with SMTP id e72mr3105475ybf.497.1641862265914; 
 Mon, 10 Jan 2022 16:51:05 -0800 (PST)
MIME-Version: 1.0
References: <20220104194918.373612-1-rananta@google.com>
 <20220104194918.373612-5-rananta@google.com>
 <CAAeT=FztkibSajKjnpRfObx+D1r8H1s_8-5MmqjemJTfmb2mpg@mail.gmail.com>
In-Reply-To: <CAAeT=FztkibSajKjnpRfObx+D1r8H1s_8-5MmqjemJTfmb2mpg@mail.gmail.com>
From: Raghavendra Rao Ananta <rananta@google.com>
Date: Mon, 10 Jan 2022 16:50:54 -0800
Message-ID: <CAJHc60ywYgAPfG11Ljkj3qzLoUn9mZPKnPH0P-HYS-pfs+A__g@mail.gmail.com>
Subject: Re: [RFC PATCH v3 04/11] KVM: arm64: Setup a framework for hypercall
 bitmap firmware registers
To: Reiji Watanabe <reijiw@google.com>
Cc: kvm@vger.kernel.org, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Peter Shier <pshier@google.com>,
 linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvmarm@lists.cs.columbia.edu,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
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

On Sun, Jan 9, 2022 at 10:29 PM Reiji Watanabe <reijiw@google.com> wrote:
>
> Hi Raghu,
>
> On Tue, Jan 4, 2022 at 11:49 AM Raghavendra Rao Ananta
> <rananta@google.com> wrote:
> >
> > KVM regularly introduces new hypercall services to the guests without
> > any consent from the Virtual Machine Manager (VMM). This means, the
> > guests can observe hypercall services in and out as they migrate
> > across various host kernel versions. This could be a major problem
> > if the guest discovered a hypercall, started using it, and after
> > getting migrated to an older kernel realizes that it's no longer
> > available. Depending on how the guest handles the change, there's
> > a potential chance that the guest would just panic.
> >
> > As a result, there's a need for the VMM to elect the services that
> > it wishes the guest to discover. VMM can elect these services based
> > on the kernels spread across its (migration) fleet. To remedy this,
> > extend the existing firmware psuedo-registers, such as
> > KVM_REG_ARM_PSCI_VERSION, for all the hypercall services available.
> >
> > These firmware registers are categorized based on the service call
> > owners, and unlike the existing firmware psuedo-registers, they hold
> > the features supported in the form of a bitmap.
> >
> > The capability, KVM_CAP_ARM_HVC_FW_REG_BMAP, is used to announce
> > this extension, which returns the number of psuedo-firmware
> > registers supported. During the VM initialization, the registers
> > holds an upper-limit of the features supported by the corresponding
> > registers. It's expected that the VMMs discover the features
> > provided by each register via GET_ONE_REG, and writeback the
> > desired values using SET_ONE_REG. KVM allows this modification
> > only until the VM has started.
> >
> > Older VMMs can simply ignore the capability and the hypercall services
> > will be exposed unconditionally to the guests, thus ensuring backward
> > compatibility.
> >
> > In this patch, the framework adds the register only for ARM's standard
> > secure services (owner value 4). Currently, this includes support only
> > for ARM True Random Number Generator (TRNG) service, with bit-0 of the
> > register representing mandatory features of v1.0. Other services are
> > momentarily added in the upcoming patches.
> >
> > Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> > ---
> >  arch/arm64/include/asm/kvm_host.h |  12 ++++
> >  arch/arm64/include/uapi/asm/kvm.h |   4 ++
> >  arch/arm64/kvm/arm.c              |   4 ++
> >  arch/arm64/kvm/hypercalls.c       | 103 +++++++++++++++++++++++++++++-
> >  arch/arm64/kvm/trng.c             |   8 +--
> >  include/kvm/arm_hypercalls.h      |   6 ++
> >  6 files changed, 129 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> > index 2a5f7f38006f..a32cded0371b 100644
> > --- a/arch/arm64/include/asm/kvm_host.h
> > +++ b/arch/arm64/include/asm/kvm_host.h
> > @@ -102,6 +102,15 @@ struct kvm_s2_mmu {
> >  struct kvm_arch_memory_slot {
> >  };
> >
> > +/**
> > + * struct kvm_hvc_desc: KVM ARM64 hypercall descriptor
> > + *
> > + * @hvc_std_bmap: Bitmap of standard secure service calls
> > + */
> > +struct kvm_hvc_desc {
> > +       u64 hvc_std_bmap;
> > +};
> > +
> >  struct kvm_arch {
> >         struct kvm_s2_mmu mmu;
> >
> > @@ -137,6 +146,9 @@ struct kvm_arch {
> >
> >         /* Memory Tagging Extension enabled for the guest */
> >         bool mte_enabled;
> > +
> > +       /* Hypercall firmware register' descriptor */
> > +       struct kvm_hvc_desc hvc_desc;
> >  };
> >
> >  struct kvm_vcpu_fault_info {
> > diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
> > index b3edde68bc3e..0d6f29c58456 100644
> > --- a/arch/arm64/include/uapi/asm/kvm.h
> > +++ b/arch/arm64/include/uapi/asm/kvm.h
> > @@ -281,6 +281,10 @@ struct kvm_arm_copy_mte_tags {
> >  #define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_REQUIRED       3
> >  #define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_ENABLED            (1U << 4)
> >
> > +#define KVM_REG_ARM_STD_BMAP                   KVM_REG_ARM_FW_REG(3)
> > +#define KVM_REG_ARM_STD_BIT_TRNG_V1_0          BIT(0)
> > +#define KVM_REG_ARM_STD_BMAP_BIT_MAX           0       /* Last valid bit */
> > +
> >  /* SVE registers */
> >  #define KVM_REG_ARM64_SVE              (0x15 << KVM_REG_ARM_COPROC_SHIFT)
> >
> > diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> > index e4727dc771bf..56fe81565235 100644
> > --- a/arch/arm64/kvm/arm.c
> > +++ b/arch/arm64/kvm/arm.c
> > @@ -156,6 +156,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
> >         kvm->arch.max_vcpus = kvm_arm_default_max_vcpus();
> >
> >         set_default_spectre(kvm);
> > +       kvm_arm_init_hypercalls(kvm);
> >
> >         return ret;
> >  out_free_stage2_pgd:
> > @@ -283,6 +284,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
> >         case KVM_CAP_ARM_PTRAUTH_GENERIC:
> >                 r = system_has_full_ptr_auth();
> >                 break;
> > +       case KVM_CAP_ARM_HVC_FW_REG_BMAP:
> > +               r = kvm_arm_num_fw_bmap_regs();
> > +               break;
>
> Looking at the discussion for the v2 series,
>
>  https://lore.kernel.org/kvmarm/20211130101958.fcdqthphyhxzvzla@gator.home/
>
> I assume that the number of the pseudo-firmware bitmap registers
> will be used to clear pseudo firmware bitmap registers that
> userspace doesn't know.
> I'm wondering how userspace can identify which pseudo-firmware
> registers that KVM_GET_REG_LIST provides are the pseudo-firmware
> bitmap registers that it doesn't know.
> For instance, suppose pseudo-firmware registers that KVM_GET_REG_LIST
> provides are KVM_REG_ARM_FW_REG(0) to KVM_REG_ARM_FW_REG(9), userspace
> doesn't knows KVM_REG_ARM_FW_REG(6) to KVM_REG_ARM_FW_REG(9), and
> KVM_CAP_ARM_HVC_FW_REG_BMAP returns 5, how can userspace identify
> remaining two bitmap registers from those 4 (fw-reg #6 to #9)
> firmware registers ?
>
In v3, we leave the decision upto the userspace. If the userspace
encounters a register that it's unaware, it can choose either to clear
it or let it get exposed to the guest as is (see the code snipped
shared by Andrew in the link).
Trying to understand the question better- are you asking how would
userspace distinguish between bitmap and regular fw registers with
intermixed sequence numbers?
If yes, do you foresee a reason why they 'unaware' registers needed to
be treated differently?
>
> >         default:
> >                 r = 0;
> >         }
> > diff --git a/arch/arm64/kvm/hypercalls.c b/arch/arm64/kvm/hypercalls.c
> > index 3c2fcf31ad3d..06243e4670eb 100644
> > --- a/arch/arm64/kvm/hypercalls.c
> > +++ b/arch/arm64/kvm/hypercalls.c
> > @@ -58,6 +58,29 @@ static void kvm_ptp_get_time(struct kvm_vcpu *vcpu, u64 *val)
> >         val[3] = lower_32_bits(cycles);
> >  }
> >
> > +static bool kvm_arm_fw_reg_feat_enabled(u64 reg_bmap, u64 feat_bit)
> > +{
> > +       return reg_bmap & feat_bit;
> > +}
> > +
> > +bool kvm_hvc_call_supported(struct kvm_vcpu *vcpu, u32 func_id)
> > +{
> > +       struct kvm_hvc_desc *hvc_desc = &vcpu->kvm->arch.hvc_desc;
> > +
> > +       switch (func_id) {
> > +       case ARM_SMCCC_TRNG_VERSION:
> > +       case ARM_SMCCC_TRNG_FEATURES:
> > +       case ARM_SMCCC_TRNG_GET_UUID:
> > +       case ARM_SMCCC_TRNG_RND32:
> > +       case ARM_SMCCC_TRNG_RND64:
> > +               return kvm_arm_fw_reg_feat_enabled(hvc_desc->hvc_std_bmap,
> > +                                               KVM_REG_ARM_STD_BIT_TRNG_V1_0);
> > +       default:
> > +               /* By default, allow the services that aren't listed here */
> > +               return true;
> > +       }
> > +}
>
> kvm_hvc_call_supported() could return true even for @func_id that
> kvm_hvc_call_handler() returns -EINVAL for.  Is this behavior what
> you really want ?
Yes. My idea was to let kvm_hvc_call_supported() check for the
support, while kvm_hvc_call_handler() does the real processing of the
call.

> If so, IMHO the function name might be a bit mis-leading.
> "kvm_hvc_call_disabled" (and flip the return value)
> might be closer to what it does(?).
>
Sorry, I'm unclear how flipping is helping. Wouldn't we return 'false'
if we don't have a case for the func_id, indicating it's NOT disabled,
but kvm_hvc_call_handler() can still return SMCCC_RET_NOT_SUPPORTED?
>
> > +
> >  int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
> >  {
> >         u32 func_id = smccc_get_function(vcpu);
> > @@ -65,6 +88,9 @@ int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
> >         u32 feature;
> >         gpa_t gpa;
> >
> > +       if (!kvm_hvc_call_supported(vcpu, func_id))
> > +               goto out;
> > +
> >         switch (func_id) {
> >         case ARM_SMCCC_VERSION_FUNC_ID:
> >                 val[0] = ARM_SMCCC_VERSION_1_1;
> > @@ -143,6 +169,7 @@ int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
> >                 return kvm_psci_call(vcpu);
> >         }
> >
> > +out:
> >         smccc_set_retval(vcpu, val[0], val[1], val[2], val[3]);
> >         return 1;
> >  }
> > @@ -153,9 +180,25 @@ static const u64 kvm_arm_fw_reg_ids[] = {
> >         KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2,
> >  };
> >
> > +static const u64 kvm_arm_fw_reg_bmap_ids[] = {
> > +       KVM_REG_ARM_STD_BMAP,
> > +};
> > +
> > +void kvm_arm_init_hypercalls(struct kvm *kvm)
> > +{
> > +       struct kvm_hvc_desc *hvc_desc = &kvm->arch.hvc_desc;
> > +
> > +       hvc_desc->hvc_std_bmap = ARM_SMCCC_STD_FEATURES;
> > +}
> > +
> > +int kvm_arm_num_fw_bmap_regs(void)
> > +{
> > +       return ARRAY_SIZE(kvm_arm_fw_reg_bmap_ids);
> > +}
> > +
> >  int kvm_arm_get_fw_num_regs(struct kvm_vcpu *vcpu)
> >  {
> > -       return ARRAY_SIZE(kvm_arm_fw_reg_ids);
> > +       return ARRAY_SIZE(kvm_arm_fw_reg_ids) + kvm_arm_num_fw_bmap_regs();
> >  }
> >
> >  int kvm_arm_copy_fw_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
> > @@ -167,6 +210,11 @@ int kvm_arm_copy_fw_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
> >                         return -EFAULT;
> >         }
> >
> > +       for (i = 0; i < ARRAY_SIZE(kvm_arm_fw_reg_bmap_ids); i++) {
> > +               if (put_user(kvm_arm_fw_reg_bmap_ids[i], uindices++))
> > +                       return -EFAULT;
> > +       }
> > +
> >         return 0;
> >  }
> >
> > @@ -211,9 +259,20 @@ static int get_kernel_wa_level(u64 regid)
> >         return -EINVAL;
> >  }
> >
> > +static void
> > +kvm_arm_get_fw_reg_bmap(struct kvm_vcpu *vcpu, u64 fw_reg_bmap, u64 *val)
> > +{
> > +       struct kvm *kvm = vcpu->kvm;
> > +
> > +       mutex_lock(&kvm->lock);
> > +       *val = fw_reg_bmap;
> > +       mutex_unlock(&kvm->lock);
>
> Why does it need to hold the lock ? (Wouldn't READ_ONCE be enough ?)
>
I don't have much experience with READ_ONCE at this point, but do you
think this read can be protected again the read/write in
kvm_arm_set_fw_reg_bmap()?
>
> > +}
> > +
> >  int kvm_arm_get_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
> >  {
> >         void __user *uaddr = (void __user *)(long)reg->addr;
> > +       struct kvm_hvc_desc *hvc_desc = &vcpu->kvm->arch.hvc_desc;
> >         u64 val;
> >
> >         switch (reg->id) {
> > @@ -224,6 +283,9 @@ int kvm_arm_get_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
> >         case KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2:
> >                 val = get_kernel_wa_level(reg->id) & KVM_REG_FEATURE_LEVEL_MASK;
> >                 break;
> > +       case KVM_REG_ARM_STD_BMAP:
> > +               kvm_arm_get_fw_reg_bmap(vcpu, hvc_desc->hvc_std_bmap, &val);
> > +               break;
> >         default:
> >                 return -ENOENT;
> >         }
> > @@ -234,6 +296,43 @@ int kvm_arm_get_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
> >         return 0;
> >  }
> >
> > +static int kvm_arm_set_fw_reg_bmap(struct kvm_vcpu *vcpu, u64 reg_id, u64 val)
> > +{
> > +       int ret = 0;
> > +       struct kvm *kvm = vcpu->kvm;
> > +       struct kvm_hvc_desc *hvc_desc = &kvm->arch.hvc_desc;
> > +       u64 *fw_reg_bmap, fw_reg_features;
> > +
> > +       switch (reg_id) {
> > +       case KVM_REG_ARM_STD_BMAP:
> > +               fw_reg_bmap = &hvc_desc->hvc_std_bmap;
> > +               fw_reg_features = ARM_SMCCC_STD_FEATURES;
> > +               break;
> > +       default:
> > +               return -ENOENT;
> > +       }
> > +
> > +       /* Check for unsupported bit */
> > +       if (val & ~fw_reg_features)
> > +               return -EINVAL;
> > +
> > +       mutex_lock(&kvm->lock);
> > +
> > +       /*
> > +        * If the VM (any vCPU) has already started running, return success
> > +        * if there's no change in the value. Else, return -EBUSY.
> > +        */
> > +       if (kvm_vm_has_started(kvm)) {
> > +               ret = *fw_reg_bmap != val ? -EBUSY : 0;
> > +               goto out;
> > +       }
> > +
> > +       *fw_reg_bmap = val;
> > +out:
> > +       mutex_unlock(&kvm->lock);
> > +       return ret;
> > +}
> > +
> >  int kvm_arm_set_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
> >  {
> >         void __user *uaddr = (void __user *)(long)reg->addr;
> > @@ -310,6 +409,8 @@ int kvm_arm_set_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
> >                         return -EINVAL;
> >
> >                 return 0;
> > +       case KVM_REG_ARM_STD_BMAP:
> > +               return kvm_arm_set_fw_reg_bmap(vcpu, reg->id, val);
> >         default:
> >                 return -ENOENT;
> >         }
> > diff --git a/arch/arm64/kvm/trng.c b/arch/arm64/kvm/trng.c
> > index 99bdd7103c9c..23f912514b06 100644
> > --- a/arch/arm64/kvm/trng.c
> > +++ b/arch/arm64/kvm/trng.c
> > @@ -60,14 +60,8 @@ int kvm_trng_call(struct kvm_vcpu *vcpu)
> >                 val = ARM_SMCCC_TRNG_VERSION_1_0;
> >                 break;
> >         case ARM_SMCCC_TRNG_FEATURES:
> > -               switch (smccc_get_arg1(vcpu)) {
> > -               case ARM_SMCCC_TRNG_VERSION:
> > -               case ARM_SMCCC_TRNG_FEATURES:
> > -               case ARM_SMCCC_TRNG_GET_UUID:
> > -               case ARM_SMCCC_TRNG_RND32:
> > -               case ARM_SMCCC_TRNG_RND64:
> > +               if (kvm_hvc_call_supported(vcpu, smccc_get_arg1(vcpu)))
> >                         val = TRNG_SUCCESS;
>
> kvm_hvc_call_supported() returns true for any values that are
> not explicitly listed in kvm_hvc_call_supported() (i.e. it returns
> true even for @func_id that are not any of ARM_SMCCC_TRNG_*).
> So, I don't think it can simply use the current kvm_hvc_call_supported.
>
You are right. Probably I should leave the case statements as is (or
think of some better way).

Thanks for the review and suggestions.

Regards,
Raghavendra
> Thanks,
> Reiji
>
> > -               }
> >                 break;
> >         case ARM_SMCCC_TRNG_GET_UUID:
> >                 smccc_set_retval(vcpu, le32_to_cpu(u[0]), le32_to_cpu(u[1]),
> > diff --git a/include/kvm/arm_hypercalls.h b/include/kvm/arm_hypercalls.h
> > index 5d38628a8d04..8fe68d8d6d96 100644
> > --- a/include/kvm/arm_hypercalls.h
> > +++ b/include/kvm/arm_hypercalls.h
> > @@ -6,6 +6,9 @@
> >
> >  #include <asm/kvm_emulate.h>
> >
> > +#define ARM_SMCCC_STD_FEATURES \
> > +       GENMASK_ULL(KVM_REG_ARM_STD_BMAP_BIT_MAX, 0)
> > +
> >  int kvm_hvc_call_handler(struct kvm_vcpu *vcpu);
> >
> >  static inline u32 smccc_get_function(struct kvm_vcpu *vcpu)
> > @@ -42,9 +45,12 @@ static inline void smccc_set_retval(struct kvm_vcpu *vcpu,
> >
> >  struct kvm_one_reg;
> >
> > +void kvm_arm_init_hypercalls(struct kvm *kvm);
> > +int kvm_arm_num_fw_bmap_regs(void);
> >  int kvm_arm_get_fw_num_regs(struct kvm_vcpu *vcpu);
> >  int kvm_arm_copy_fw_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices);
> >  int kvm_arm_get_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
> >  int kvm_arm_set_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
> > +bool kvm_hvc_call_supported(struct kvm_vcpu *vcpu, u32 func_id);
> >
> >  #endif
> > --
> > 2.34.1.448.ga2b2bfdf31-goog
> >
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
