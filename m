Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 585884D9593
	for <lists+kvmarm@lfdr.de>; Tue, 15 Mar 2022 08:48:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AED5749F07;
	Tue, 15 Mar 2022 03:48:26 -0400 (EDT)
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
	with ESMTP id InDVj3IV2+Ht; Tue, 15 Mar 2022 03:48:26 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0AD8749EFE;
	Tue, 15 Mar 2022 03:48:25 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A406549EBD
 for <kvmarm@lists.cs.columbia.edu>; Tue, 15 Mar 2022 03:48:23 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fdNP4T181RIu for <kvmarm@lists.cs.columbia.edu>;
 Tue, 15 Mar 2022 03:48:22 -0400 (EDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com
 [209.85.167.43])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D93F249E3F
 for <kvmarm@lists.cs.columbia.edu>; Tue, 15 Mar 2022 03:48:21 -0400 (EDT)
Received: by mail-lf1-f43.google.com with SMTP id n19so31420211lfh.8
 for <kvmarm@lists.cs.columbia.edu>; Tue, 15 Mar 2022 00:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jtmeeb0pfZwoaZkwm8IwKPhjw1b77pqcacHddIcCw/g=;
 b=otwCPsDN3kfCyiK3vNpJvNBORPnC9YsaZLL9OhEx/sYPC2vX8xEtuVmfUDZxNgIxhf
 8DQjrHGLVKYtTSsx9g6iypceyYJy5NcLfXL/qcgFTNlb7sxEgbRkO7P34YBzn3k6W1O0
 Bb/3PdjpvZ6pyTBzaAYv1LTKmrOv56wPZj8eEjCc0gkfYlZ17Kh/C/92OSHJE9cCWubN
 AusOkQD2WMQu1VEd6yUujilDrYOuM/qShCgCqta6XqRhwJkUWStgXV288HYF8BCYf1qO
 JcgGgK5E3bQoscvOeZk57pO5ytau/FohkWlQNLxjaLYLNPVFI8hwF5VgJ5ci0iOe5SWS
 DB6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jtmeeb0pfZwoaZkwm8IwKPhjw1b77pqcacHddIcCw/g=;
 b=pYwKa9BznB25sx3/jBfgB0v5Q/PsNuxHmt10/TXzuiz0GI7RXlTVgqSmYq9Z9dxMhX
 Lm/vWp81GvjkQQz8s7E6ZQkxO5vD1WCve1W8pwEnO540G0EFRospAIUJiJPalz5j3aac
 0mrG6d1XzbkAwqB6tJuQ0eMhEgDL/JDy+/rDEPDW8pUMlEYE4gNsL4AEuWfviZrpU1fh
 44LMyIpbsnl9T5rhHIqurUyOFdE6uKzXup4Iwv7usepiHtIV9r8NRuegVN/XGbKdSeXy
 11TDQRBHDnFnyIYLWmVqJ2vypktnvGhlc8D5Buj98p4lC5RT433IUUOTeuqQsGHiXIUY
 6VNg==
X-Gm-Message-State: AOAM531jYt1zi7oyP0rjo7Rgn7Um9YHxN6G2+fYO3axlBTE1KAHSxxTA
 IBkfP6nkxa/yh4GGUsap46bF4qT6QaS2L/KFtTpHSQ==
X-Google-Smtp-Source: ABdhPJxYnM2BU7IRwXtrCKWuCXeiCqFpjgN337WBL4OMsUyrUWh1nicZ0pZ4uuEKm992+NKG401/b94smpx9gvDWMow=
X-Received: by 2002:a19:7612:0:b0:448:307a:4bca with SMTP id
 c18-20020a197612000000b00448307a4bcamr16163258lff.361.1647330500112; Tue, 15
 Mar 2022 00:48:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220314061959.3349716-1-reijiw@google.com>
 <20220314061959.3349716-3-reijiw@google.com>
 <Yi+j7zGxA80ZR4t7@google.com>
 <27834312-1877-f244-634d-6e645dea9f9e@google.com>
In-Reply-To: <27834312-1877-f244-634d-6e645dea9f9e@google.com>
From: Oliver Upton <oupton@google.com>
Date: Tue, 15 Mar 2022 00:48:08 -0700
Message-ID: <CAOQ_Qsgw9iUPBA7o_reEbt96NDgVHit46_b_UozyNtNzFaFnHw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] KVM: arm64: mixed-width check should be skipped
 for uninitialized vCPUs
To: Reiji Watanabe <reijiw@google.com>
Cc: kvm@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Peter Shier <pshier@google.com>, Will Deacon <will@kernel.org>,
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

On Mon, Mar 14, 2022 at 11:19 PM Reiji Watanabe <reijiw@google.com> wrote:
>
> Hi Oliver,
>
> On 3/14/22 1:22 PM, Oliver Upton wrote:
> > On Sun, Mar 13, 2022 at 11:19:58PM -0700, Reiji Watanabe wrote:
> >> KVM allows userspace to configure either all EL1 32bit or 64bit vCPUs
> >> for a guest.  At vCPU reset, vcpu_allowed_register_width() checks
> >> if the vcpu's register width is consistent with all other vCPUs'.
> >> Since the checking is done even against vCPUs that are not initialized
> >> (KVM_ARM_VCPU_INIT has not been done) yet, the uninitialized vCPUs
> >> are erroneously treated as 64bit vCPU, which causes the function to
> >> incorrectly detect a mixed-width VM.
> >>
> >> Introduce KVM_ARCH_FLAG_EL1_32BIT and KVM_ARCH_FLAG_REG_WIDTH_CONFIGURED
> >> bits for kvm->arch.flags.  A value of the EL1_32BIT bit indicates that
> >> the guest needs to be configured with all 32bit or 64bit vCPUs, and
> >> a value of the REG_WIDTH_CONFIGURED bit indicates if a value of the
> >> EL1_32BIT bit is valid (already set up). Values in those bits are set at
> >> the first KVM_ARM_VCPU_INIT for the guest based on KVM_ARM_VCPU_EL1_32BIT
> >> configuration for the vCPU.
> >>
> >> Check vcpu's register width against those new bits at the vcpu's
> >> KVM_ARM_VCPU_INIT (instead of against other vCPUs' register width).
> >>
> >> Fixes: 66e94d5cafd4 ("KVM: arm64: Prevent mixed-width VM creation")
> >> Signed-off-by: Reiji Watanabe <reijiw@google.com>
> >
> > Hrmph... I hate to be asking this question so late in the game, but...
> >
> > Are there any bits that we really allow variation per-vCPU besides
> > KVM_ARM_VCPU_POWER_OFF? We unintentionally allow for variance with the
> > KVM_ARM_VCPU_PSCI_0_2 bit even though that's complete nonsense.
> >
> > Stated plainly, should we just deny any attempts at asymmetry besides
> > POWER_OFF?>
> > Besides the nits, I see nothing objectionable with the patch. I'd really
> > like to see more generalized constraints on vCPU configuration, but if
> > this is the route we take:
>
> Prohibiting the mixed width configuration is not a new constraint that
> this patch creates (this patch fixes a bug that erroneously detects
> mixed-width configuration), and enforcing symmetry of other features
> among vCPUs is a bit different matter.

Right, I had managed to forget that context for a moment when I
replied to you. Then I fully agree with this patch, and the other
feature flags can be handled later.

>
> Having said that, I like the idea, which will be more consistent with
> my ID register series (it can simplify things).  But, I'm not sure
> if creating the constraint for those features would be a problem for
> existing userspace even if allowing variation per-vCPU for the features
> was not our intention.
> I would guess having the constraint for KVM_ARM_VCPU_PSCI_0_2 should
> be fine.  Do you think that should be fine for PMU, SVE, and PTRAUTH*
> as well ?

Personally, yes, but it prompts the question of if we could break
userspace by applying restrictions after the fact. The original patch
that applied the register width restrictions didn't cause much of a
stir, so it seems possible we could get away with it.

> >
> > Reviewed-by: Oliver Upton <oupton@google.com>
> >
> >> ---
> >>   arch/arm64/include/asm/kvm_emulate.h | 27 ++++++++----
> >>   arch/arm64/include/asm/kvm_host.h    |  9 ++++
> >>   arch/arm64/kvm/reset.c               | 64 ++++++++++++++++++----------
> >>   3 files changed, 70 insertions(+), 30 deletions(-)
> >>
> >> diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
> >> index d62405ce3e6d..7496deab025a 100644
> >> --- a/arch/arm64/include/asm/kvm_emulate.h
> >> +++ b/arch/arm64/include/asm/kvm_emulate.h
> >> @@ -43,10 +43,22 @@ void kvm_inject_pabt(struct kvm_vcpu *vcpu, unsigned long addr);
> >>
> >>   void kvm_vcpu_wfi(struct kvm_vcpu *vcpu);
> >>
> >> +#if defined(__KVM_VHE_HYPERVISOR__) || defined(__KVM_NVHE_HYPERVISOR__)
> >>   static __always_inline bool vcpu_el1_is_32bit(struct kvm_vcpu *vcpu)
> >>   {
> >>      return !(vcpu->arch.hcr_el2 & HCR_RW);
> >>   }
> >> +#else
> >> +static __always_inline bool vcpu_el1_is_32bit(struct kvm_vcpu *vcpu)
> >> +{
> >> +    struct kvm *kvm = vcpu->kvm;
> >> +
> >> +    WARN_ON_ONCE(!test_bit(KVM_ARCH_FLAG_REG_WIDTH_CONFIGURED,
> >> +                           &kvm->arch.flags));
> >> +
> >> +    return test_bit(KVM_ARCH_FLAG_EL1_32BIT, &kvm->arch.flags);
> >> +}
> >> +#endif
> >>
> >>   static inline void vcpu_reset_hcr(struct kvm_vcpu *vcpu)
> >>   {
> >> @@ -72,15 +84,14 @@ static inline void vcpu_reset_hcr(struct kvm_vcpu *vcpu)
> >>              vcpu->arch.hcr_el2 |= HCR_TVM;
> >>      }
> >>
> >> -    if (test_bit(KVM_ARM_VCPU_EL1_32BIT, vcpu->arch.features))
> >> +    if (vcpu_el1_is_32bit(vcpu))
> >>              vcpu->arch.hcr_el2 &= ~HCR_RW;
> >> -
> >> -    /*
> >> -     * TID3: trap feature register accesses that we virtualise.
> >> -     * For now this is conditional, since no AArch32 feature regs
> >> -     * are currently virtualised.
> >> -     */
> >> -    if (!vcpu_el1_is_32bit(vcpu))
> >> +    else
> >> +            /*
> >> +             * TID3: trap feature register accesses that we virtualise.
> >> +             * For now this is conditional, since no AArch32 feature regs
> >> +             * are currently virtualised.
> >> +             */
> >>              vcpu->arch.hcr_el2 |= HCR_TID3;
> >>
> >>      if (cpus_have_const_cap(ARM64_MISMATCHED_CACHE_TYPE) ||
> >> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> >> index 11a7ae747ded..22ad977069f5 100644
> >> --- a/arch/arm64/include/asm/kvm_host.h
> >> +++ b/arch/arm64/include/asm/kvm_host.h
> >> @@ -125,6 +125,15 @@ struct kvm_arch {
> >>   #define KVM_ARCH_FLAG_RETURN_NISV_IO_ABORT_TO_USER 0
> >>      /* Memory Tagging Extension enabled for the guest */
> >>   #define KVM_ARCH_FLAG_MTE_ENABLED                  1
> >> +    /*
> >> +     * The following two bits are used to indicate the guest's EL1
> >> +     * register width configuration. A value of KVM_ARCH_FLAG_EL1_32BIT
> >> +     * bit is valid only when KVM_ARCH_FLAG_REG_WIDTH_CONFIGURED is set.
> >> +     * Otherwise, the guest's EL1 register width has not yet been
> >> +     * determined yet.
> >> +     */
> >> +#define KVM_ARCH_FLAG_REG_WIDTH_CONFIGURED          2
> >> +#define KVM_ARCH_FLAG_EL1_32BIT                             3
> >>      unsigned long flags;
> >>
> >>      /*
> >> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
> >> index ecc40c8cd6f6..cbeb6216ee25 100644
> >> --- a/arch/arm64/kvm/reset.c
> >> +++ b/arch/arm64/kvm/reset.c
> >> @@ -181,27 +181,45 @@ static int kvm_vcpu_enable_ptrauth(struct kvm_vcpu *vcpu)
> >>      return 0;
> >>   }
> >>
> >> -static bool vcpu_allowed_register_width(struct kvm_vcpu *vcpu)
> >> +/*
> >> + * A guest can have either all EL1 32bit or 64bit vcpus only. It is
> >> + * indicated by a value of KVM_ARCH_FLAG_EL1_32BIT bit in kvm->arch.flags,
> >> + * which is valid only when KVM_ARCH_FLAG_REG_WIDTH_CONFIGURED in
> >> + * kvm->arch.flags is set.
> >> + * This function sets the EL1_32BIT bit based on the given @is32bit (and
> >> + * sets REG_WIDTH_CONFIGURED bit). When those flags are already set,
> >> + * @is32bit must be consistent with the flags.
> >> + * Returns 0 on success, or non-zero otherwise.
> >> + */
> >
> > nit: use kerneldoc style:
> >
> >    https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html
>
> Sure, I can fix the comment to use kerneldoc style.
>
>
> >
> >> +static int kvm_set_vm_width(struct kvm *kvm, bool is32bit)
> >>   {
> >> -    struct kvm_vcpu *tmp;
> >> -    bool is32bit;
> >> -    unsigned long i;
> >> +    bool allowed;
> >> +
> >> +    lockdep_assert_held(&kvm->lock);
> >> +
> >> +    if (test_bit(KVM_ARCH_FLAG_REG_WIDTH_CONFIGURED, &kvm->arch.flags)) {
> >> +            /*
> >> +             * The guest's register width is already configured.
> >> +             * Make sure that @is32bit is consistent with it.
> >> +             */
> >> +            allowed = (is32bit ==
> >> +                       test_bit(KVM_ARCH_FLAG_EL1_32BIT, &kvm->arch.flags));
> >> +            return allowed ? 0 : -EINVAL;
> >
> > nit: I'd avoid the ternary and just use a boring if/else (though I could
> > be in the minority here).
>
> I agree with you and will fix it.
> (The ternary with 'allowed' was just copied from the previous patch,
>   and I should have changed that in this patch...)
>
> Thanks,
> Reiji
>
>
> >
> >> +    }
> >>
> >> -    is32bit = vcpu_has_feature(vcpu, KVM_ARM_VCPU_EL1_32BIT);
> >>      if (!cpus_have_const_cap(ARM64_HAS_32BIT_EL1) && is32bit)
> >> -            return false;
> >> +            return -EINVAL;
> >>
> >>      /* MTE is incompatible with AArch32 */
> >> -    if (kvm_has_mte(vcpu->kvm) && is32bit)
> >> -            return false;
> >> +    if (kvm_has_mte(kvm) && is32bit)
> >> +            return -EINVAL;
> >>
> >> -    /* Check that the vcpus are either all 32bit or all 64bit */
> >> -    kvm_for_each_vcpu(i, tmp, vcpu->kvm) {
> >> -            if (vcpu_has_feature(tmp, KVM_ARM_VCPU_EL1_32BIT) != is32bit)
> >> -                    return false;
> >> -    }
> >> +    if (is32bit)
> >> +            set_bit(KVM_ARCH_FLAG_EL1_32BIT, &kvm->arch.flags);
> >>
> >> -    return true;
> >> +    set_bit(KVM_ARCH_FLAG_REG_WIDTH_CONFIGURED, &kvm->arch.flags);
> >> +
> >> +    return 0;
> >>   }
> >>
> >>   /**
> >> @@ -230,10 +248,17 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
> >>      u32 pstate;
> >>
> >>      mutex_lock(&vcpu->kvm->lock);
> >> -    reset_state = vcpu->arch.reset_state;
> >> -    WRITE_ONCE(vcpu->arch.reset_state.reset, false);
> >> +    ret = kvm_set_vm_width(vcpu->kvm,
> >> +                           vcpu_has_feature(vcpu, KVM_ARM_VCPU_EL1_32BIT));
> >> +    if (!ret) {
> >> +            reset_state = vcpu->arch.reset_state;
> >> +            WRITE_ONCE(vcpu->arch.reset_state.reset, false);
> >> +    }
> >>      mutex_unlock(&vcpu->kvm->lock);
> >>
> >> +    if (ret)
> >> +            return ret;
> >> +
> >>      /* Reset PMU outside of the non-preemptible section */
> >>      kvm_pmu_vcpu_reset(vcpu);
> >>
> >> @@ -260,14 +285,9 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
> >>              }
> >>      }
> >>
> >> -    if (!vcpu_allowed_register_width(vcpu)) {
> >> -            ret = -EINVAL;
> >> -            goto out;
> >> -    }
> >> -
> >>      switch (vcpu->arch.target) {
> >>      default:
> >> -            if (test_bit(KVM_ARM_VCPU_EL1_32BIT, vcpu->arch.features)) {
> >> +            if (vcpu_el1_is_32bit(vcpu)) {
> >>                      pstate = VCPU_RESET_PSTATE_SVC;
> >>              } else {
> >>                      pstate = VCPU_RESET_PSTATE_EL1;
> >> --
> >> 2.35.1.723.g4982287a31-goog
> >>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
