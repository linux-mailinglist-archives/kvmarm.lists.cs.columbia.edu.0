Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C5ACA4D9138
	for <lists+kvmarm@lfdr.de>; Tue, 15 Mar 2022 01:23:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 383FF49EEF;
	Mon, 14 Mar 2022 20:23:44 -0400 (EDT)
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
	with ESMTP id jBRNib3xIRch; Mon, 14 Mar 2022 20:23:44 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AF6CF49EE9;
	Mon, 14 Mar 2022 20:23:42 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CC5D149E35
 for <kvmarm@lists.cs.columbia.edu>; Mon, 14 Mar 2022 20:23:41 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J5hjjPLyjN44 for <kvmarm@lists.cs.columbia.edu>;
 Mon, 14 Mar 2022 20:23:40 -0400 (EDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com
 [209.85.219.177])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9049A49E2B
 for <kvmarm@lists.cs.columbia.edu>; Mon, 14 Mar 2022 20:23:40 -0400 (EDT)
Received: by mail-yb1-f177.google.com with SMTP id m67so788852ybm.4
 for <kvmarm@lists.cs.columbia.edu>; Mon, 14 Mar 2022 17:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EGfNWx74UGuUub5piWt3tsVOuTbPS9Nq0NSKYIwZfOc=;
 b=PYRfwuzfXlVuwTmkFVHsCaGsito8gFKFX2Q5Ixo4mOCFQegWQ3Ua2OPPOyN3A0VimE
 Q3DNZDn0azVbow/4cs7W963T2YreqnPHkXWXX60007eVdm/TIwcbMxgLqqH5+XzO4yHM
 GUiu2DUkVT79FkM54HgFWJb2rPzZN2SE77olXoMm5rnY4A+F/HizB7IDBdvQ5dQ8Yf6l
 Psc/LChDPo9yVp7pL2PdGYEA6xTADKKX+PVtMqWag0gBVoGxx7n6y9xmQq7DerQ/2CVW
 2go7i1Gdudvc7dveN2yVpzs4YRCoHosYoelNlPhGpvwZ14oklaed28LZ9BgCFhrR67UN
 FMVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EGfNWx74UGuUub5piWt3tsVOuTbPS9Nq0NSKYIwZfOc=;
 b=awlpvQPJtlLSd9HjLkgLJ96aRQy1COdRWbJ/3Q/5IaRj0UsXfDt2lPTnBTj1R33/13
 hvuw6FkVLizPOxSeSkm/h72PR9TNOPbEIQyCmXbFRnHsTEGiLQwSiAR2iLx3kL8D3Rdg
 mK31hb6EgJY7mftCJ12Qwmtc/Ohv0Uswh5pPGyTMaB+rvNhtUhcIc6XFCuF80xbKJ9CT
 vO6fYvvWozDMJtX42Nlr8hgf0UYtlzLenkz66KscMcx3mzvce/KpAOfaphHx+bXxpgiC
 0dQYbLGwMe0ISa8EVWo07XScrzzGvRhF/tqFzdC9WDKnMzhMXgJGf0RE1yK4E7vexKYZ
 ZeoA==
X-Gm-Message-State: AOAM530DGXCiRqyFmeeFkHFTfvBjqHWpX4jqjdQqGCT7V74KqwYXCEFo
 3tiBjqzmIhArHcpMfhQqD+3jWtNergJ/l5MRdiFtPg==
X-Google-Smtp-Source: ABdhPJwfwj8uxFtCbOhp08GGf72OizUn5mMAatGc9XWM0wr+mGQO9ZtqIutLsRpwHCI+V+8WZgRGYPvDEQOa43mJIy8=
X-Received: by 2002:a25:d512:0:b0:61d:aded:1743 with SMTP id
 r18-20020a25d512000000b0061daded1743mr19336522ybe.526.1647303819857; Mon, 14
 Mar 2022 17:23:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220224172559.4170192-1-rananta@google.com>
 <20220224172559.4170192-7-rananta@google.com>
 <Yi+bVM742+9W4TYj@google.com>
In-Reply-To: <Yi+bVM742+9W4TYj@google.com>
From: Raghavendra Rao Ananta <rananta@google.com>
Date: Mon, 14 Mar 2022 17:23:27 -0700
Message-ID: <CAJHc60yJQ4VOq9OoyGncL07bfvQuz0mPYXCVf2WhL-8QzM5-nA@mail.gmail.com>
Subject: Re: [PATCH v4 06/13] KVM: arm64: Add standard hypervisor firmware
 register
To: Oliver Upton <oupton@google.com>
Cc: kvm@vger.kernel.org, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Peter Shier <pshier@google.com>,
 linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
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

On Mon, Mar 14, 2022 at 12:45 PM Oliver Upton <oupton@google.com> wrote:
>
> On Thu, Feb 24, 2022 at 05:25:52PM +0000, Raghavendra Rao Ananta wrote:
> > Introduce the firmware register to hold the standard hypervisor
> > service calls (owner value 5) as a bitmap. The bitmap represents
> > the features that'll be enabled for the guest, as configured by
> > the user-space. Currently, this includes support only for
> > Paravirtualized time, represented by bit-0.
> >
> > The register is also added to the kvm_arm_vm_scope_fw_regs[] list
> > as it maintains its state per-VM.
> >
> > Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> > ---
> >  arch/arm64/include/asm/kvm_host.h |  2 ++
> >  arch/arm64/include/uapi/asm/kvm.h |  4 ++++
> >  arch/arm64/kvm/guest.c            |  1 +
> >  arch/arm64/kvm/hypercalls.c       | 20 +++++++++++++++++++-
> >  include/kvm/arm_hypercalls.h      |  3 +++
> >  5 files changed, 29 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> > index 1909ced3208f..318148b69279 100644
> > --- a/arch/arm64/include/asm/kvm_host.h
> > +++ b/arch/arm64/include/asm/kvm_host.h
> > @@ -105,9 +105,11 @@ struct kvm_arch_memory_slot {
> >   * struct kvm_hvc_desc: KVM ARM64 hypercall descriptor
> >   *
> >   * @hvc_std_bmap: Bitmap of standard secure service calls
> > + * @hvc_std_hyp_bmap: Bitmap of standard hypervisor service calls
> >   */
> >  struct kvm_hvc_desc {
> >       u64 hvc_std_bmap;
> > +     u64 hvc_std_hyp_bmap;
> >  };
> >
> >  struct kvm_arch {
> > diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
> > index 2decc30d6b84..9a2caead7359 100644
> > --- a/arch/arm64/include/uapi/asm/kvm.h
> > +++ b/arch/arm64/include/uapi/asm/kvm.h
> > @@ -295,6 +295,10 @@ struct kvm_arm_copy_mte_tags {
> >  #define KVM_REG_ARM_STD_BIT_TRNG_V1_0                BIT(0)
> >  #define KVM_REG_ARM_STD_BMAP_BIT_MAX         0       /* Last valid bit */
> >
> > +#define KVM_REG_ARM_STD_HYP_BMAP             KVM_REG_ARM_FW_BMAP_REG(1)
> > +#define KVM_REG_ARM_STD_HYP_BIT_PV_TIME              BIT(0)
> > +#define KVM_REG_ARM_STD_HYP_BMAP_BIT_MAX     0       /* Last valid bit */
> > +
> >  /* SVE registers */
> >  #define KVM_REG_ARM64_SVE            (0x15 << KVM_REG_ARM_COPROC_SHIFT)
> >
> > diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> > index d66e6c742bbe..c42426d6137e 100644
> > --- a/arch/arm64/kvm/guest.c
> > +++ b/arch/arm64/kvm/guest.c
> > @@ -66,6 +66,7 @@ static const u64 kvm_arm_vm_scope_fw_regs[] = {
> >       KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1,
> >       KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2,
> >       KVM_REG_ARM_STD_BMAP,
> > +     KVM_REG_ARM_STD_HYP_BMAP,
> >  };
> >
> >  /**
> > diff --git a/arch/arm64/kvm/hypercalls.c b/arch/arm64/kvm/hypercalls.c
> > index 48c126c3da72..ebc0cc26cf2e 100644
> > --- a/arch/arm64/kvm/hypercalls.c
> > +++ b/arch/arm64/kvm/hypercalls.c
> > @@ -75,6 +75,10 @@ static bool kvm_hvc_call_supported(struct kvm_vcpu *vcpu, u32 func_id)
> >       case ARM_SMCCC_TRNG_RND64:
> >               return kvm_arm_fw_reg_feat_enabled(hvc_desc->hvc_std_bmap,
> >                                               KVM_REG_ARM_STD_BIT_TRNG_V1_0);
> > +     case ARM_SMCCC_HV_PV_TIME_FEATURES:
> > +     case ARM_SMCCC_HV_PV_TIME_ST:
> > +             return kvm_arm_fw_reg_feat_enabled(hvc_desc->hvc_std_hyp_bmap,
> > +                                     KVM_REG_ARM_STD_HYP_BIT_PV_TIME);
> >       default:
> >               /* By default, allow the services that aren't listed here */
> >               return true;
> > @@ -83,6 +87,7 @@ static bool kvm_hvc_call_supported(struct kvm_vcpu *vcpu, u32 func_id)
> >
> >  int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
> >  {
> > +     struct kvm_hvc_desc *hvc_desc = &vcpu->kvm->arch.hvc_desc;
> >       u32 func_id = smccc_get_function(vcpu);
> >       u64 val[4] = {SMCCC_RET_NOT_SUPPORTED};
> >       u32 feature;
> > @@ -134,7 +139,10 @@ int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
> >                       }
> >                       break;
> >               case ARM_SMCCC_HV_PV_TIME_FEATURES:
> > -                     val[0] = SMCCC_RET_SUCCESS;
> > +                     if (kvm_arm_fw_reg_feat_enabled(
> > +                                     hvc_desc->hvc_std_hyp_bmap,
>
> It is probably OK to keep this parameter on the line above (just stay
> under 100 characters a line).
>
Will rearrange this in the next series. Thanks.

Regards,
Raghavendra
> > +                                     KVM_REG_ARM_STD_HYP_BIT_PV_TIME))
> > +                             val[0] = SMCCC_RET_SUCCESS;
> >                       break;
> >               }
> >               break;
> > @@ -179,6 +187,7 @@ static const u64 kvm_arm_fw_reg_ids[] = {
> >       KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1,
> >       KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2,
> >       KVM_REG_ARM_STD_BMAP,
> > +     KVM_REG_ARM_STD_HYP_BMAP,
> >  };
> >
> >  void kvm_arm_init_hypercalls(struct kvm *kvm)
> > @@ -186,6 +195,7 @@ void kvm_arm_init_hypercalls(struct kvm *kvm)
> >       struct kvm_hvc_desc *hvc_desc = &kvm->arch.hvc_desc;
> >
> >       hvc_desc->hvc_std_bmap = ARM_SMCCC_STD_FEATURES;
> > +     hvc_desc->hvc_std_hyp_bmap = ARM_SMCCC_STD_HYP_FEATURES;
> >  }
> >
> >  int kvm_arm_get_fw_num_regs(struct kvm_vcpu *vcpu)
> > @@ -272,6 +282,9 @@ int kvm_arm_get_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
> >       case KVM_REG_ARM_STD_BMAP:
> >               val = READ_ONCE(hvc_desc->hvc_std_bmap);
> >               break;
> > +     case KVM_REG_ARM_STD_HYP_BMAP:
> > +             val = READ_ONCE(hvc_desc->hvc_std_hyp_bmap);
> > +             break;
> >       default:
> >               return -ENOENT;
> >       }
> > @@ -294,6 +307,10 @@ static int kvm_arm_set_fw_reg_bmap(struct kvm_vcpu *vcpu, u64 reg_id, u64 val)
> >               fw_reg_bmap = &hvc_desc->hvc_std_bmap;
> >               fw_reg_features = ARM_SMCCC_STD_FEATURES;
> >               break;
> > +     case KVM_REG_ARM_STD_HYP_BMAP:
> > +             fw_reg_bmap = &hvc_desc->hvc_std_hyp_bmap;
> > +             fw_reg_features = ARM_SMCCC_STD_HYP_FEATURES;
> > +             break;
> >       default:
> >               return -ENOENT;
> >       }
> > @@ -398,6 +415,7 @@ int kvm_arm_set_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
> >
> >               return 0;
> >       case KVM_REG_ARM_STD_BMAP:
> > +     case KVM_REG_ARM_STD_HYP_BMAP:
> >               return kvm_arm_set_fw_reg_bmap(vcpu, reg_id, val);
> >       default:
> >               return -ENOENT;
> > diff --git a/include/kvm/arm_hypercalls.h b/include/kvm/arm_hypercalls.h
> > index 64d30b452809..a1cb6e839c74 100644
> > --- a/include/kvm/arm_hypercalls.h
> > +++ b/include/kvm/arm_hypercalls.h
> > @@ -9,6 +9,9 @@
> >  #define ARM_SMCCC_STD_FEATURES \
> >       GENMASK_ULL(KVM_REG_ARM_STD_BMAP_BIT_MAX, 0)
> >
> > +#define ARM_SMCCC_STD_HYP_FEATURES \
> > +     GENMASK_ULL(KVM_REG_ARM_STD_HYP_BMAP_BIT_MAX, 0)
> > +
> >  int kvm_hvc_call_handler(struct kvm_vcpu *vcpu);
> >
> >  static inline u32 smccc_get_function(struct kvm_vcpu *vcpu)
> > --
> > 2.35.1.473.g83b2b277ed-goog
> >
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
