Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1616B4DA941
	for <lists+kvmarm@lfdr.de>; Wed, 16 Mar 2022 05:22:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5235649F0A;
	Wed, 16 Mar 2022 00:22:20 -0400 (EDT)
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
	with ESMTP id mi+AoA2D+6Pc; Wed, 16 Mar 2022 00:22:20 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BFE2849F05;
	Wed, 16 Mar 2022 00:22:18 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2188A49EF4
 for <kvmarm@lists.cs.columbia.edu>; Wed, 16 Mar 2022 00:22:17 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5lMf2gCgHoXs for <kvmarm@lists.cs.columbia.edu>;
 Wed, 16 Mar 2022 00:22:15 -0400 (EDT)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 6931C49E2B
 for <kvmarm@lists.cs.columbia.edu>; Wed, 16 Mar 2022 00:22:15 -0400 (EDT)
Received: by mail-pf1-f177.google.com with SMTP id h2so2249096pfh.6
 for <kvmarm@lists.cs.columbia.edu>; Tue, 15 Mar 2022 21:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=message-id:date:mime-version:user-agent:from:subject:to:cc
 :references:content-language:in-reply-to:content-transfer-encoding;
 bh=lFJ99hhFmIq7rC1PE0+N4190klv0nwxMR3DLMod1S9A=;
 b=LdT6RNPOeuJgpJilzt8vWJcsTGkEKvAxcuKl8sOYiz0igZHXtJwWUzfrJqbf9PV51m
 WDD2JFviWLS7vfFNUamPJDxsIAVYqnAIgAEubZhsuYa6I7eXl35t6uIXNbb78vztI8Za
 OjI5y/ck9fjAz43X/OU4MspWz9oMyuIGnpb+3pDwTqXmo4EcUdB9D4NHXkXMqe5TQkea
 rLhe/AZIQtKElHJOn5zSIDXSpyydiLVlXU5FuFkknIMFAhA+OoGa74/n0g9EzhdQtHKL
 S86e2VFj2DdM9k/Li8RDh/9HCOwp89wCmcJW81Lo4YCINnF8edRz6T9k/1/fqTSWqarS
 gt/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:from
 :subject:to:cc:references:content-language:in-reply-to
 :content-transfer-encoding;
 bh=lFJ99hhFmIq7rC1PE0+N4190klv0nwxMR3DLMod1S9A=;
 b=v78WQ5puVPIckYFYvHI+JXig/M9tgePhR9lZIw/HzWdaffKvUJVHa4rnpfSdm/zrXK
 jSu34n5lK11ao5hXhKXwBywRpVjCfDF7cM8jytOgn/fahvy7TWcftZBt+84RmpFw+esG
 mbGfwljV1ZWoy5eC2wXwnvyojP12/6o/LrfdBYtOXfhs8pTZ5zAm1ulCFIBp6O12QDfT
 uWKOSjdQmaRnPw8sYU8oE23LM9A2nXdgj/ykMzLQMfHZdYE2kq9/51r02Pa5gsdFAjY0
 1UQFYtCAHzZJwd2+vgAkFsiYhuzBVgCnJoVA1Y8MMYBYpK8dqHFg2qS5N0b46KDKZ6Xb
 MZLA==
X-Gm-Message-State: AOAM533MJYsOhtULwnFuBIuBf3wuLqFeAiUog21otjDeKy06c1SzsG3Z
 jwloaW1ozASReNg5oaOYpFlZbA==
X-Google-Smtp-Source: ABdhPJy319o4c6j9g0RGXgiJ7wMLhX3nc6TMODNJnvMiUqbz4GpbnnaeLOS7a6TCdEIb84a5cl4TDA==
X-Received: by 2002:a63:aa08:0:b0:373:cc0b:5b71 with SMTP id
 e8-20020a63aa08000000b00373cc0b5b71mr26713469pgf.599.1647404534082; 
 Tue, 15 Mar 2022 21:22:14 -0700 (PDT)
Received: from [192.168.86.237]
 (107-203-254-183.lightspeed.sntcca.sbcglobal.net. [107.203.254.183])
 by smtp.gmail.com with ESMTPSA id
 j11-20020a056a00234b00b004f7463022absm743536pfj.208.2022.03.15.21.22.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Mar 2022 21:22:13 -0700 (PDT)
Message-ID: <327cff85-ec57-2585-6ed2-24ff8f190d38@google.com>
Date: Tue, 15 Mar 2022 21:22:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From: Reiji Watanabe <reijiw@google.com>
Subject: Re: [PATCH v4 2/3] KVM: arm64: mixed-width check should be skipped
 for uninitialized vCPUs
To: Oliver Upton <oupton@google.com>
References: <20220314061959.3349716-1-reijiw@google.com>
 <20220314061959.3349716-3-reijiw@google.com> <Yi+j7zGxA80ZR4t7@google.com>
 <27834312-1877-f244-634d-6e645dea9f9e@google.com>
 <CAOQ_Qsgw9iUPBA7o_reEbt96NDgVHit46_b_UozyNtNzFaFnHw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAOQ_Qsgw9iUPBA7o_reEbt96NDgVHit46_b_UozyNtNzFaFnHw@mail.gmail.com>
Cc: kvm@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Peter Shier <pshier@google.com>, Will Deacon <will@kernel.org>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

Hi Oliver,

On Tue, Mar 15, 2022 at 12:48 AM Oliver Upton <oupton@google.com> wrote:
>
> On Mon, Mar 14, 2022 at 11:19 PM Reiji Watanabe <reijiw@google.com> wrote:
> >
> > Hi Oliver,
> >
> > On 3/14/22 1:22 PM, Oliver Upton wrote:
> > > On Sun, Mar 13, 2022 at 11:19:58PM -0700, Reiji Watanabe wrote:
> > >> KVM allows userspace to configure either all EL1 32bit or 64bit vCPUs
> > >> for a guest.  At vCPU reset, vcpu_allowed_register_width() checks
> > >> if the vcpu's register width is consistent with all other vCPUs'.
> > >> Since the checking is done even against vCPUs that are not initialized
> > >> (KVM_ARM_VCPU_INIT has not been done) yet, the uninitialized vCPUs
> > >> are erroneously treated as 64bit vCPU, which causes the function to
> > >> incorrectly detect a mixed-width VM.
> > >>
> > >> Introduce KVM_ARCH_FLAG_EL1_32BIT and KVM_ARCH_FLAG_REG_WIDTH_CONFIGURED
> > >> bits for kvm->arch.flags.  A value of the EL1_32BIT bit indicates that
> > >> the guest needs to be configured with all 32bit or 64bit vCPUs, and
> > >> a value of the REG_WIDTH_CONFIGURED bit indicates if a value of the
> > >> EL1_32BIT bit is valid (already set up). Values in those bits are set at
> > >> the first KVM_ARM_VCPU_INIT for the guest based on KVM_ARM_VCPU_EL1_32BIT
> > >> configuration for the vCPU.
> > >>
> > >> Check vcpu's register width against those new bits at the vcpu's
> > >> KVM_ARM_VCPU_INIT (instead of against other vCPUs' register width).
> > >>
> > >> Fixes: 66e94d5cafd4 ("KVM: arm64: Prevent mixed-width VM creation")
> > >> Signed-off-by: Reiji Watanabe <reijiw@google.com>
> > >
> > > Hrmph... I hate to be asking this question so late in the game, but...
> > >
> > > Are there any bits that we really allow variation per-vCPU besides
> > > KVM_ARM_VCPU_POWER_OFF? We unintentionally allow for variance with the
> > > KVM_ARM_VCPU_PSCI_0_2 bit even though that's complete nonsense.
> > >
> > > Stated plainly, should we just deny any attempts at asymmetry besides
> > > POWER_OFF?>
> > > Besides the nits, I see nothing objectionable with the patch. I'd really
> > > like to see more generalized constraints on vCPU configuration, but if
> > > this is the route we take:
> >
> > Prohibiting the mixed width configuration is not a new constraint that
> > this patch creates (this patch fixes a bug that erroneously detects
> > mixed-width configuration), and enforcing symmetry of other features
> > among vCPUs is a bit different matter.
>
> Right, I had managed to forget that context for a moment when I
> replied to you. Then I fully agree with this patch, and the other
> feature flags can be handled later.
>
> >
> > Having said that, I like the idea, which will be more consistent with
> > my ID register series (it can simplify things).  But, I'm not sure
> > if creating the constraint for those features would be a problem for
> > existing userspace even if allowing variation per-vCPU for the features
> > was not our intention.
> > I would guess having the constraint for KVM_ARM_VCPU_PSCI_0_2 should
> > be fine.  Do you think that should be fine for PMU, SVE, and PTRAUTH*
> > as well ?
>
> Personally, yes, but it prompts the question of if we could break
> userspace by applying restrictions after the fact. The original patch
> that applied the register width restrictions didn't cause much of a
> stir, so it seems possible we could get away with it.


I agree that it's possible we might get away with it, and I can try
that for the other features besides KVM_ARM_VCPU_POWER_OFF :)
(I will work it on separately from this series)

BTW, if there had been a general interface to configure per-VM feature,
I would guess that interface might have been chosen for PSCI_0_2.
Perhaps we should consider creating it the next time per-VM feature
is introduced.

Thanks,
Reiji


>
> > >
> > > Reviewed-by: Oliver Upton <oupton@google.com>
> > >
> > >> ---
> > >>   arch/arm64/include/asm/kvm_emulate.h | 27 ++++++++----
> > >>   arch/arm64/include/asm/kvm_host.h    |  9 ++++
> > >>   arch/arm64/kvm/reset.c               | 64 ++++++++++++++++++----------
> > >>   3 files changed, 70 insertions(+), 30 deletions(-)
> > >>
> > >> diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
> > >> index d62405ce3e6d..7496deab025a 100644
> > >> --- a/arch/arm64/include/asm/kvm_emulate.h
> > >> +++ b/arch/arm64/include/asm/kvm_emulate.h
> > >> @@ -43,10 +43,22 @@ void kvm_inject_pabt(struct kvm_vcpu *vcpu, unsigned long addr);
> > >>
> > >>   void kvm_vcpu_wfi(struct kvm_vcpu *vcpu);
> > >>
> > >> +#if defined(__KVM_VHE_HYPERVISOR__) || defined(__KVM_NVHE_HYPERVISOR__)
> > >>   static __always_inline bool vcpu_el1_is_32bit(struct kvm_vcpu *vcpu)
> > >>   {
> > >>      return !(vcpu->arch.hcr_el2 & HCR_RW);
> > >>   }
> > >> +#else
> > >> +static __always_inline bool vcpu_el1_is_32bit(struct kvm_vcpu *vcpu)
> > >> +{
> > >> +    struct kvm *kvm = vcpu->kvm;
> > >> +
> > >> +    WARN_ON_ONCE(!test_bit(KVM_ARCH_FLAG_REG_WIDTH_CONFIGURED,
> > >> +                           &kvm->arch.flags));
> > >> +
> > >> +    return test_bit(KVM_ARCH_FLAG_EL1_32BIT, &kvm->arch.flags);
> > >> +}
> > >> +#endif
> > >>
> > >>   static inline void vcpu_reset_hcr(struct kvm_vcpu *vcpu)
> > >>   {
> > >> @@ -72,15 +84,14 @@ static inline void vcpu_reset_hcr(struct kvm_vcpu *vcpu)
> > >>              vcpu->arch.hcr_el2 |= HCR_TVM;
> > >>      }
> > >>
> > >> -    if (test_bit(KVM_ARM_VCPU_EL1_32BIT, vcpu->arch.features))
> > >> +    if (vcpu_el1_is_32bit(vcpu))
> > >>              vcpu->arch.hcr_el2 &= ~HCR_RW;
> > >> -
> > >> -    /*
> > >> -     * TID3: trap feature register accesses that we virtualise.
> > >> -     * For now this is conditional, since no AArch32 feature regs
> > >> -     * are currently virtualised.
> > >> -     */
> > >> -    if (!vcpu_el1_is_32bit(vcpu))
> > >> +    else
> > >> +            /*
> > >> +             * TID3: trap feature register accesses that we virtualise.
> > >> +             * For now this is conditional, since no AArch32 feature regs
> > >> +             * are currently virtualised.
> > >> +             */
> > >>              vcpu->arch.hcr_el2 |= HCR_TID3;
> > >>
> > >>      if (cpus_have_const_cap(ARM64_MISMATCHED_CACHE_TYPE) ||
> > >> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> > >> index 11a7ae747ded..22ad977069f5 100644
> > >> --- a/arch/arm64/include/asm/kvm_host.h
> > >> +++ b/arch/arm64/include/asm/kvm_host.h
> > >> @@ -125,6 +125,15 @@ struct kvm_arch {
> > >>   #define KVM_ARCH_FLAG_RETURN_NISV_IO_ABORT_TO_USER 0
> > >>      /* Memory Tagging Extension enabled for the guest */
> > >>   #define KVM_ARCH_FLAG_MTE_ENABLED                  1
> > >> +    /*
> > >> +     * The following two bits are used to indicate the guest's EL1
> > >> +     * register width configuration. A value of KVM_ARCH_FLAG_EL1_32BIT
> > >> +     * bit is valid only when KVM_ARCH_FLAG_REG_WIDTH_CONFIGURED is set.
> > >> +     * Otherwise, the guest's EL1 register width has not yet been
> > >> +     * determined yet.
> > >> +     */
> > >> +#define KVM_ARCH_FLAG_REG_WIDTH_CONFIGURED          2
> > >> +#define KVM_ARCH_FLAG_EL1_32BIT                             3
> > >>      unsigned long flags;
> > >>
> > >>      /*
> > >> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
> > >> index ecc40c8cd6f6..cbeb6216ee25 100644
> > >> --- a/arch/arm64/kvm/reset.c
> > >> +++ b/arch/arm64/kvm/reset.c
> > >> @@ -181,27 +181,45 @@ static int kvm_vcpu_enable_ptrauth(struct kvm_vcpu *vcpu)
> > >>      return 0;
> > >>   }
> > >>
> > >> -static bool vcpu_allowed_register_width(struct kvm_vcpu *vcpu)
> > >> +/*
> > >> + * A guest can have either all EL1 32bit or 64bit vcpus only. It is
> > >> + * indicated by a value of KVM_ARCH_FLAG_EL1_32BIT bit in kvm->arch.flags,
> > >> + * which is valid only when KVM_ARCH_FLAG_REG_WIDTH_CONFIGURED in
> > >> + * kvm->arch.flags is set.
> > >> + * This function sets the EL1_32BIT bit based on the given @is32bit (and
> > >> + * sets REG_WIDTH_CONFIGURED bit). When those flags are already set,
> > >> + * @is32bit must be consistent with the flags.
> > >> + * Returns 0 on success, or non-zero otherwise.
> > >> + */
> > >
> > > nit: use kerneldoc style:
> > >
> > >    https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html
> >
> > Sure, I can fix the comment to use kerneldoc style.
> >
> >
> > >
> > >> +static int kvm_set_vm_width(struct kvm *kvm, bool is32bit)
> > >>   {
> > >> -    struct kvm_vcpu *tmp;
> > >> -    bool is32bit;
> > >> -    unsigned long i;
> > >> +    bool allowed;
> > >> +
> > >> +    lockdep_assert_held(&kvm->lock);
> > >> +
> > >> +    if (test_bit(KVM_ARCH_FLAG_REG_WIDTH_CONFIGURED, &kvm->arch.flags)) {
> > >> +            /*
> > >> +             * The guest's register width is already configured.
> > >> +             * Make sure that @is32bit is consistent with it.
> > >> +             */
> > >> +            allowed = (is32bit ==
> > >> +                       test_bit(KVM_ARCH_FLAG_EL1_32BIT, &kvm->arch.flags));
> > >> +            return allowed ? 0 : -EINVAL;
> > >
> > > nit: I'd avoid the ternary and just use a boring if/else (though I could
> > > be in the minority here).
> >
> > I agree with you and will fix it.
> > (The ternary with 'allowed' was just copied from the previous patch,
> >   and I should have changed that in this patch...)
> >
> > Thanks,
> > Reiji
> >
> >
> > >
> > >> +    }
> > >>
> > >> -    is32bit = vcpu_has_feature(vcpu, KVM_ARM_VCPU_EL1_32BIT);
> > >>      if (!cpus_have_const_cap(ARM64_HAS_32BIT_EL1) && is32bit)
> > >> -            return false;
> > >> +            return -EINVAL;
> > >>
> > >>      /* MTE is incompatible with AArch32 */
> > >> -    if (kvm_has_mte(vcpu->kvm) && is32bit)
> > >> -            return false;
> > >> +    if (kvm_has_mte(kvm) && is32bit)
> > >> +            return -EINVAL;
> > >>
> > >> -    /* Check that the vcpus are either all 32bit or all 64bit */
> > >> -    kvm_for_each_vcpu(i, tmp, vcpu->kvm) {
> > >> -            if (vcpu_has_feature(tmp, KVM_ARM_VCPU_EL1_32BIT) != is32bit)
> > >> -                    return false;
> > >> -    }
> > >> +    if (is32bit)
> > >> +            set_bit(KVM_ARCH_FLAG_EL1_32BIT, &kvm->arch.flags);
> > >>
> > >> -    return true;
> > >> +    set_bit(KVM_ARCH_FLAG_REG_WIDTH_CONFIGURED, &kvm->arch.flags);
> > >> +
> > >> +    return 0;
> > >>   }
> > >>
> > >>   /**
> > >> @@ -230,10 +248,17 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
> > >>      u32 pstate;
> > >>
> > >>      mutex_lock(&vcpu->kvm->lock);
> > >> -    reset_state = vcpu->arch.reset_state;
> > >> -    WRITE_ONCE(vcpu->arch.reset_state.reset, false);
> > >> +    ret = kvm_set_vm_width(vcpu->kvm,
> > >> +                           vcpu_has_feature(vcpu, KVM_ARM_VCPU_EL1_32BIT));
> > >> +    if (!ret) {
> > >> +            reset_state = vcpu->arch.reset_state;
> > >> +            WRITE_ONCE(vcpu->arch.reset_state.reset, false);
> > >> +    }
> > >>      mutex_unlock(&vcpu->kvm->lock);
> > >>
> > >> +    if (ret)
> > >> +            return ret;
> > >> +
> > >>      /* Reset PMU outside of the non-preemptible section */
> > >>      kvm_pmu_vcpu_reset(vcpu);
> > >>
> > >> @@ -260,14 +285,9 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
> > >>              }
> > >>      }
> > >>
> > >> -    if (!vcpu_allowed_register_width(vcpu)) {
> > >> -            ret = -EINVAL;
> > >> -            goto out;
> > >> -    }
> > >> -
> > >>      switch (vcpu->arch.target) {
> > >>      default:
> > >> -            if (test_bit(KVM_ARM_VCPU_EL1_32BIT, vcpu->arch.features)) {
> > >> +            if (vcpu_el1_is_32bit(vcpu)) {
> > >>                      pstate = VCPU_RESET_PSTATE_SVC;
> > >>              } else {
> > >>                      pstate = VCPU_RESET_PSTATE_EL1;
> > >> --
> > >> 2.35.1.723.g4982287a31-goog
> > >>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
