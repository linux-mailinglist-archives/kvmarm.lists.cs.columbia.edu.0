Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE214D8E0C
	for <lists+kvmarm@lfdr.de>; Mon, 14 Mar 2022 21:22:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6AB0B49EF8;
	Mon, 14 Mar 2022 16:22:16 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sPIbhlFU0L9f; Mon, 14 Mar 2022 16:22:16 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CE0E349ECC;
	Mon, 14 Mar 2022 16:22:14 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id F2CE249E5F
 for <kvmarm@lists.cs.columbia.edu>; Mon, 14 Mar 2022 16:22:13 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h9LWjQdoMj0i for <kvmarm@lists.cs.columbia.edu>;
 Mon, 14 Mar 2022 16:22:12 -0400 (EDT)
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com
 [209.85.166.181])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 68B3849E43
 for <kvmarm@lists.cs.columbia.edu>; Mon, 14 Mar 2022 16:22:12 -0400 (EDT)
Received: by mail-il1-f181.google.com with SMTP id h7so11906156ile.1
 for <kvmarm@lists.cs.columbia.edu>; Mon, 14 Mar 2022 13:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=2Bt6+Ca2x4nxRfIi5WYw88o7wk+blAKPH7fbDEP/s6U=;
 b=gNIjYO84h+WERe6rT3JV1WoytsmwcN2lH6DMwhce7wnNKPY4bzcCzqNCR1k7QiUnDt
 3wZjOwUbLwCJa5hwke3SdeYA0AB2f2Q+11WzlKgxEOIBmKvVWd/UEyXQzpCvCRxjNRVJ
 P0ZcRGH2QOHwCTfzJ4JDRhxSLJJLPzlg8GW4so/Ep/+MsmKBHClHAeZRuR4Wpfkl1teA
 wVZTjDXXbcMUMWFb1/Ya5bkDGXBuq6JDRHmDlHbk+t285Q4IYvK54Cat9yHSdUOY6+Jg
 wNCwJ3S81y3OGFCYAMobQieLpF01k3SIjCdc92rrXwZiL6tnC6d39gB4ykJh9H5nGUDF
 scSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2Bt6+Ca2x4nxRfIi5WYw88o7wk+blAKPH7fbDEP/s6U=;
 b=c8qBX+OXBaVlAjVZiOI2dHX/HzyUmYEraJuKMoY62lpbxAMYz+bxM77KflN98djyqx
 mw+0oZ1+j22obXAErq/z0ac4HEz6FkrideNtggeA8NZmkHgmywVF4w27p0q1LleKHyWU
 y+QCo9LM4nL/bi/Qr+qwHDuuKOufmj1jPsa6wiy/sGLrr/vkfrhoo5QCfAH+USIkY9r1
 y4EaOR1sMt8eSgM0XBjh/ruPJeuwzs+WUEXUqyN6ClMQyEjfEy04lWhYwRa1afQGlGt3
 njKRxgvlQXOp0ehYEZzl73oLGhbBLmhKHc9lO6u1gvZsclwOO7QsB+xn3ofYqm3x/hQy
 KgEQ==
X-Gm-Message-State: AOAM533OB7nTFuyBnUCUUIp/LLOGOIDO7r8pRLVWVH9So8YW7mswR07d
 4UJw210nwU4xxziNbGdGbXKiyg==
X-Google-Smtp-Source: ABdhPJwhm/TaO7FFg/+K/rjpb9mtXjkN554TejXnnYG/4s4LMcqQATZvLzU4jt2heXeJlc3hSmvw5Q==
X-Received: by 2002:a92:c088:0:b0:2c7:9421:3c7b with SMTP id
 h8-20020a92c088000000b002c794213c7bmr9181438ile.280.1647289331417; 
 Mon, 14 Mar 2022 13:22:11 -0700 (PDT)
Received: from google.com (194.225.68.34.bc.googleusercontent.com.
 [34.68.225.194]) by smtp.gmail.com with ESMTPSA id
 p22-20020a6bce16000000b00640922b3699sm8771766iob.15.2022.03.14.13.22.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Mar 2022 13:22:10 -0700 (PDT)
Date: Mon, 14 Mar 2022 20:22:07 +0000
From: Oliver Upton <oupton@google.com>
To: Reiji Watanabe <reijiw@google.com>
Subject: Re: [PATCH v4 2/3] KVM: arm64: mixed-width check should be skipped
 for uninitialized vCPUs
Message-ID: <Yi+j7zGxA80ZR4t7@google.com>
References: <20220314061959.3349716-1-reijiw@google.com>
 <20220314061959.3349716-3-reijiw@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220314061959.3349716-3-reijiw@google.com>
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

On Sun, Mar 13, 2022 at 11:19:58PM -0700, Reiji Watanabe wrote:
> KVM allows userspace to configure either all EL1 32bit or 64bit vCPUs
> for a guest.  At vCPU reset, vcpu_allowed_register_width() checks
> if the vcpu's register width is consistent with all other vCPUs'.
> Since the checking is done even against vCPUs that are not initialized
> (KVM_ARM_VCPU_INIT has not been done) yet, the uninitialized vCPUs
> are erroneously treated as 64bit vCPU, which causes the function to
> incorrectly detect a mixed-width VM.
> 
> Introduce KVM_ARCH_FLAG_EL1_32BIT and KVM_ARCH_FLAG_REG_WIDTH_CONFIGURED
> bits for kvm->arch.flags.  A value of the EL1_32BIT bit indicates that
> the guest needs to be configured with all 32bit or 64bit vCPUs, and
> a value of the REG_WIDTH_CONFIGURED bit indicates if a value of the
> EL1_32BIT bit is valid (already set up). Values in those bits are set at
> the first KVM_ARM_VCPU_INIT for the guest based on KVM_ARM_VCPU_EL1_32BIT
> configuration for the vCPU.
> 
> Check vcpu's register width against those new bits at the vcpu's
> KVM_ARM_VCPU_INIT (instead of against other vCPUs' register width).
> 
> Fixes: 66e94d5cafd4 ("KVM: arm64: Prevent mixed-width VM creation")
> Signed-off-by: Reiji Watanabe <reijiw@google.com>

Hrmph... I hate to be asking this question so late in the game, but...

Are there any bits that we really allow variation per-vCPU besides
KVM_ARM_VCPU_POWER_OFF? We unintentionally allow for variance with the
KVM_ARM_VCPU_PSCI_0_2 bit even though that's complete nonsense.

Stated plainly, should we just deny any attempts at asymmetry besides
POWER_OFF?

Besides the nits, I see nothing objectionable with the patch. I'd really
like to see more generalized constraints on vCPU configuration, but if
this is the route we take:

Reviewed-by: Oliver Upton <oupton@google.com>

> ---
>  arch/arm64/include/asm/kvm_emulate.h | 27 ++++++++----
>  arch/arm64/include/asm/kvm_host.h    |  9 ++++
>  arch/arm64/kvm/reset.c               | 64 ++++++++++++++++++----------
>  3 files changed, 70 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
> index d62405ce3e6d..7496deab025a 100644
> --- a/arch/arm64/include/asm/kvm_emulate.h
> +++ b/arch/arm64/include/asm/kvm_emulate.h
> @@ -43,10 +43,22 @@ void kvm_inject_pabt(struct kvm_vcpu *vcpu, unsigned long addr);
>  
>  void kvm_vcpu_wfi(struct kvm_vcpu *vcpu);
>  
> +#if defined(__KVM_VHE_HYPERVISOR__) || defined(__KVM_NVHE_HYPERVISOR__)
>  static __always_inline bool vcpu_el1_is_32bit(struct kvm_vcpu *vcpu)
>  {
>  	return !(vcpu->arch.hcr_el2 & HCR_RW);
>  }
> +#else
> +static __always_inline bool vcpu_el1_is_32bit(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm *kvm = vcpu->kvm;
> +
> +	WARN_ON_ONCE(!test_bit(KVM_ARCH_FLAG_REG_WIDTH_CONFIGURED,
> +			       &kvm->arch.flags));
> +
> +	return test_bit(KVM_ARCH_FLAG_EL1_32BIT, &kvm->arch.flags);
> +}
> +#endif
>  
>  static inline void vcpu_reset_hcr(struct kvm_vcpu *vcpu)
>  {
> @@ -72,15 +84,14 @@ static inline void vcpu_reset_hcr(struct kvm_vcpu *vcpu)
>  		vcpu->arch.hcr_el2 |= HCR_TVM;
>  	}
>  
> -	if (test_bit(KVM_ARM_VCPU_EL1_32BIT, vcpu->arch.features))
> +	if (vcpu_el1_is_32bit(vcpu))
>  		vcpu->arch.hcr_el2 &= ~HCR_RW;
> -
> -	/*
> -	 * TID3: trap feature register accesses that we virtualise.
> -	 * For now this is conditional, since no AArch32 feature regs
> -	 * are currently virtualised.
> -	 */
> -	if (!vcpu_el1_is_32bit(vcpu))
> +	else
> +		/*
> +		 * TID3: trap feature register accesses that we virtualise.
> +		 * For now this is conditional, since no AArch32 feature regs
> +		 * are currently virtualised.
> +		 */
>  		vcpu->arch.hcr_el2 |= HCR_TID3;
>  
>  	if (cpus_have_const_cap(ARM64_MISMATCHED_CACHE_TYPE) ||
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 11a7ae747ded..22ad977069f5 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -125,6 +125,15 @@ struct kvm_arch {
>  #define KVM_ARCH_FLAG_RETURN_NISV_IO_ABORT_TO_USER	0
>  	/* Memory Tagging Extension enabled for the guest */
>  #define KVM_ARCH_FLAG_MTE_ENABLED			1
> +	/*
> +	 * The following two bits are used to indicate the guest's EL1
> +	 * register width configuration. A value of KVM_ARCH_FLAG_EL1_32BIT
> +	 * bit is valid only when KVM_ARCH_FLAG_REG_WIDTH_CONFIGURED is set.
> +	 * Otherwise, the guest's EL1 register width has not yet been
> +	 * determined yet.
> +	 */
> +#define KVM_ARCH_FLAG_REG_WIDTH_CONFIGURED		2
> +#define KVM_ARCH_FLAG_EL1_32BIT				3
>  	unsigned long flags;
>  
>  	/*
> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
> index ecc40c8cd6f6..cbeb6216ee25 100644
> --- a/arch/arm64/kvm/reset.c
> +++ b/arch/arm64/kvm/reset.c
> @@ -181,27 +181,45 @@ static int kvm_vcpu_enable_ptrauth(struct kvm_vcpu *vcpu)
>  	return 0;
>  }
>  
> -static bool vcpu_allowed_register_width(struct kvm_vcpu *vcpu)
> +/*
> + * A guest can have either all EL1 32bit or 64bit vcpus only. It is
> + * indicated by a value of KVM_ARCH_FLAG_EL1_32BIT bit in kvm->arch.flags,
> + * which is valid only when KVM_ARCH_FLAG_REG_WIDTH_CONFIGURED in
> + * kvm->arch.flags is set.
> + * This function sets the EL1_32BIT bit based on the given @is32bit (and
> + * sets REG_WIDTH_CONFIGURED bit). When those flags are already set,
> + * @is32bit must be consistent with the flags.
> + * Returns 0 on success, or non-zero otherwise.
> + */

nit: use kerneldoc style:

  https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html

> +static int kvm_set_vm_width(struct kvm *kvm, bool is32bit)
>  {
> -	struct kvm_vcpu *tmp;
> -	bool is32bit;
> -	unsigned long i;
> +	bool allowed;
> +
> +	lockdep_assert_held(&kvm->lock);
> +
> +	if (test_bit(KVM_ARCH_FLAG_REG_WIDTH_CONFIGURED, &kvm->arch.flags)) {
> +		/*
> +		 * The guest's register width is already configured.
> +		 * Make sure that @is32bit is consistent with it.
> +		 */
> +		allowed = (is32bit ==
> +			   test_bit(KVM_ARCH_FLAG_EL1_32BIT, &kvm->arch.flags));
> +		return allowed ? 0 : -EINVAL;

nit: I'd avoid the ternary and just use a boring if/else (though I could
be in the minority here).

> +	}
>  
> -	is32bit = vcpu_has_feature(vcpu, KVM_ARM_VCPU_EL1_32BIT);
>  	if (!cpus_have_const_cap(ARM64_HAS_32BIT_EL1) && is32bit)
> -		return false;
> +		return -EINVAL;
>  
>  	/* MTE is incompatible with AArch32 */
> -	if (kvm_has_mte(vcpu->kvm) && is32bit)
> -		return false;
> +	if (kvm_has_mte(kvm) && is32bit)
> +		return -EINVAL;
>  
> -	/* Check that the vcpus are either all 32bit or all 64bit */
> -	kvm_for_each_vcpu(i, tmp, vcpu->kvm) {
> -		if (vcpu_has_feature(tmp, KVM_ARM_VCPU_EL1_32BIT) != is32bit)
> -			return false;
> -	}
> +	if (is32bit)
> +		set_bit(KVM_ARCH_FLAG_EL1_32BIT, &kvm->arch.flags);
>  
> -	return true;
> +	set_bit(KVM_ARCH_FLAG_REG_WIDTH_CONFIGURED, &kvm->arch.flags);
> +
> +	return 0;
>  }
>  
>  /**
> @@ -230,10 +248,17 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
>  	u32 pstate;
>  
>  	mutex_lock(&vcpu->kvm->lock);
> -	reset_state = vcpu->arch.reset_state;
> -	WRITE_ONCE(vcpu->arch.reset_state.reset, false);
> +	ret = kvm_set_vm_width(vcpu->kvm,
> +			       vcpu_has_feature(vcpu, KVM_ARM_VCPU_EL1_32BIT));
> +	if (!ret) {
> +		reset_state = vcpu->arch.reset_state;
> +		WRITE_ONCE(vcpu->arch.reset_state.reset, false);
> +	}
>  	mutex_unlock(&vcpu->kvm->lock);
>  
> +	if (ret)
> +		return ret;
> +
>  	/* Reset PMU outside of the non-preemptible section */
>  	kvm_pmu_vcpu_reset(vcpu);
>  
> @@ -260,14 +285,9 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
>  		}
>  	}
>  
> -	if (!vcpu_allowed_register_width(vcpu)) {
> -		ret = -EINVAL;
> -		goto out;
> -	}
> -
>  	switch (vcpu->arch.target) {
>  	default:
> -		if (test_bit(KVM_ARM_VCPU_EL1_32BIT, vcpu->arch.features)) {
> +		if (vcpu_el1_is_32bit(vcpu)) {
>  			pstate = VCPU_RESET_PSTATE_SVC;
>  		} else {
>  			pstate = VCPU_RESET_PSTATE_EL1;
> -- 
> 2.35.1.723.g4982287a31-goog
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
