Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D88274D8B7D
	for <lists+kvmarm@lfdr.de>; Mon, 14 Mar 2022 19:15:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 27D4D49EF6;
	Mon, 14 Mar 2022 14:15:32 -0400 (EDT)
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
	with ESMTP id WAxzw1pKgXBw; Mon, 14 Mar 2022 14:15:32 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 59CBE410F7;
	Mon, 14 Mar 2022 14:15:30 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5EDCB40256
 for <kvmarm@lists.cs.columbia.edu>; Mon, 14 Mar 2022 14:15:29 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jclPSHCTWuZk for <kvmarm@lists.cs.columbia.edu>;
 Mon, 14 Mar 2022 14:15:27 -0400 (EDT)
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com
 [209.85.166.41])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id B074F40066
 for <kvmarm@lists.cs.columbia.edu>; Mon, 14 Mar 2022 14:15:27 -0400 (EDT)
Received: by mail-io1-f41.google.com with SMTP id k25so19247410iok.8
 for <kvmarm@lists.cs.columbia.edu>; Mon, 14 Mar 2022 11:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=TVT6gHyYR3E1f7fI8ETVc81kqURLxi87xO38NM6Ru4c=;
 b=AIgZ850rREyXlWbNSquoDmJkzzs5MeFg6ZxNo3aaEslxbx+IkSj0DJ7IoRmLKL3TF8
 ct3Z/OV3pT0tfCun/Y5tZyEPmyyNeRyRSrcIgbHv9vph+hfbmgIaD8MYGA2TPkZqqJWj
 xAs7UBffKY4W3pENhiD+otz1tj4k6UZGpbGiCD0l++wTOyuWK2YIf9JPCozcYKprlLBO
 mIsgp4XEEIhSjBcPKYxUdpR03X3Oa15BDwkQV7MM9V4XOCWC+ro4I4c9S3WHxhONwRAd
 IqFQ16l6aS7vWKI8UC62qDkYUWgZez0tNUPZnHFEnDZrUKDqGqVr1solwwQGhI0wXjoF
 1AVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=TVT6gHyYR3E1f7fI8ETVc81kqURLxi87xO38NM6Ru4c=;
 b=lINMn9jvGCfMUTz+cUUrwdpnSjJmgrmS167mmH03zlLpTilAvm+TIVTzPPKRZuFFNe
 k8sHdbctYZ4SHpOxf0+RKkCBecsaaq9n6x5DLDFRTtFJZdwOp3VyoBjEwqkrR5cLagoB
 I+v9u5ZA756lhTIFbxVG1L89UfOkBv7J6l2JH3TqoMjJdgHkTE7CK8s9j5a4tCgbhBNc
 KnO+8ccZyQBgyNRUcFdyZfYuMgzBF31WqDAsG/Cnq+UEBCRsPACOw3F8Lm6Vc2ZhjB2n
 zjDbdJhP8jtsMpZ4PjNoj7kw922EyecH9dh+0eDCpw9p8rBFqOmFs5NoPgNeC18ce4Jy
 ut5w==
X-Gm-Message-State: AOAM530EevfckEj9ADFuYcccx1/8j/+iQ3NJGcZRUqhgOpW6CM+Cuqa6
 Sts0K6ouBc0MjBAL6eJOQecM7Q==
X-Google-Smtp-Source: ABdhPJxK/tyfiRDw//RP9bWTMHHjga9x1YoPA4TuHp9Hb5zqsv+XWQupTZbLBAv+r3p3vrlBTXmuxw==
X-Received: by 2002:a05:6638:388f:b0:319:c876:fa0 with SMTP id
 b15-20020a056638388f00b00319c8760fa0mr17230748jav.7.1647281726613; 
 Mon, 14 Mar 2022 11:15:26 -0700 (PDT)
Received: from google.com (194.225.68.34.bc.googleusercontent.com.
 [34.68.225.194]) by smtp.gmail.com with ESMTPSA id
 w2-20020a056e021a6200b002c655123821sm10048930ilv.37.2022.03.14.11.15.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Mar 2022 11:15:25 -0700 (PDT)
Date: Mon, 14 Mar 2022 18:15:22 +0000
From: Oliver Upton <oupton@google.com>
To: Raghavendra Rao Ananta <rananta@google.com>
Subject: Re: [PATCH v4 01/13] KVM: arm64: Factor out firmware register
 handling from psci.c
Message-ID: <Yi+GOgMDzwYB5oSs@google.com>
References: <20220224172559.4170192-1-rananta@google.com>
 <20220224172559.4170192-2-rananta@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220224172559.4170192-2-rananta@google.com>
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

Hi Raghu,

On Thu, Feb 24, 2022 at 05:25:47PM +0000, Raghavendra Rao Ananta wrote:
> Common hypercall firmware register handing is currently employed
> by psci.c. Since the upcoming patches add more of these registers,
> it's better to move the generic handling to hypercall.c for a
> cleaner presentation.
> 
> While we are at it, collect all the firmware registers under
> fw_reg_ids[] to help implement kvm_arm_get_fw_num_regs() and
> kvm_arm_copy_fw_reg_indices() in a generic way.
> 
> No functional change intended.
> 
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>

You might owe a rebase, thanks to the new Spectre bits KVM picked up (in
Linus' tree) and PSCIv1.1 (kvmarm/next) :-)

Besides the nits:

Reviewed-by: Oliver Upton <oupton@google.com>

> ---
>  arch/arm64/kvm/guest.c       |   2 +-
>  arch/arm64/kvm/hypercalls.c  | 170 +++++++++++++++++++++++++++++++++++
>  arch/arm64/kvm/psci.c        | 166 ----------------------------------
>  include/kvm/arm_hypercalls.h |   7 ++
>  include/kvm/arm_psci.h       |   7 --
>  5 files changed, 178 insertions(+), 174 deletions(-)
> 
> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> index e116c7767730..8238e52d890d 100644
> --- a/arch/arm64/kvm/guest.c
> +++ b/arch/arm64/kvm/guest.c
> @@ -18,7 +18,7 @@
>  #include <linux/string.h>
>  #include <linux/vmalloc.h>
>  #include <linux/fs.h>
> -#include <kvm/arm_psci.h>
> +#include <kvm/arm_hypercalls.h>
>  #include <asm/cputype.h>
>  #include <linux/uaccess.h>
>  #include <asm/fpsimd.h>
> diff --git a/arch/arm64/kvm/hypercalls.c b/arch/arm64/kvm/hypercalls.c
> index 30da78f72b3b..3c2fcf31ad3d 100644
> --- a/arch/arm64/kvm/hypercalls.c
> +++ b/arch/arm64/kvm/hypercalls.c
> @@ -146,3 +146,173 @@ int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
>  	smccc_set_retval(vcpu, val[0], val[1], val[2], val[3]);
>  	return 1;
>  }
> +
> +static const u64 kvm_arm_fw_reg_ids[] = {
> +	KVM_REG_ARM_PSCI_VERSION,
> +	KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1,
> +	KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2,
> +};
> +
> +int kvm_arm_get_fw_num_regs(struct kvm_vcpu *vcpu)
> +{
> +	return ARRAY_SIZE(kvm_arm_fw_reg_ids);
> +}
> +
> +int kvm_arm_copy_fw_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(kvm_arm_fw_reg_ids); i++) {
> +		if (put_user(kvm_arm_fw_reg_ids[i], uindices++))
> +			return -EFAULT;
> +	}
> +
> +	return 0;
> +}
> +
> +#define KVM_REG_FEATURE_LEVEL_WIDTH	4
> +#define KVM_REG_FEATURE_LEVEL_MASK	(BIT(KVM_REG_FEATURE_LEVEL_WIDTH) - 1)

Hrm... Not your code but this should really use GENMASK() to be
consistent with the rest of the kernel. Also, looks like _WIDTH is
useless.

Perhaps fold these together:

  #define KVM_REG_FEATURE_LEVEL_MASK	GENMASK(3, 0)

Also these kind of macros probably belong in headers.

> +
> +/*
> + * Convert the workaround level into an easy-to-compare number, where higher
> + * values mean better protection.
> + */
> +static int get_kernel_wa_level(u64 regid)
> +{
> +	switch (regid) {
> +	case KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1:
> +		switch (arm64_get_spectre_v2_state()) {
> +		case SPECTRE_VULNERABLE:
> +			return KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_NOT_AVAIL;
> +		case SPECTRE_MITIGATED:
> +			return KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_AVAIL;
> +		case SPECTRE_UNAFFECTED:
> +			return KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_NOT_REQUIRED;
> +		}
> +		return KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_NOT_AVAIL;
> +	case KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2:
> +		switch (arm64_get_spectre_v4_state()) {
> +		case SPECTRE_MITIGATED:
> +			/*
> +			 * As for the hypercall discovery, we pretend we
> +			 * don't have any FW mitigation if SSBS is there at
> +			 * all times.
> +			 */
> +			if (cpus_have_final_cap(ARM64_SSBS))
> +				return KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_AVAIL;
> +			fallthrough;
> +		case SPECTRE_UNAFFECTED:
> +			return KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_REQUIRED;
> +		case SPECTRE_VULNERABLE:
> +			return KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_AVAIL;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +int kvm_arm_get_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
> +{
> +	void __user *uaddr = (void __user *)(long)reg->addr;
> +	u64 val;
> +
> +	switch (reg->id) {
> +	case KVM_REG_ARM_PSCI_VERSION:
> +		val = kvm_psci_version(vcpu, vcpu->kvm);
> +		break;
> +	case KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1:
> +	case KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2:
> +		val = get_kernel_wa_level(reg->id) & KVM_REG_FEATURE_LEVEL_MASK;
> +		break;
> +	default:
> +		return -ENOENT;
> +	}
> +
> +	if (copy_to_user(uaddr, &val, KVM_REG_SIZE(reg->id)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
> +int kvm_arm_set_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
> +{
> +	void __user *uaddr = (void __user *)(long)reg->addr;
> +	u64 val;
> +	int wa_level;
> +
> +	if (copy_from_user(&val, uaddr, KVM_REG_SIZE(reg->id)))
> +		return -EFAULT;
> +
> +	switch (reg->id) {
> +	case KVM_REG_ARM_PSCI_VERSION:
> +	{
> +		bool wants_02;
> +
> +		wants_02 = test_bit(KVM_ARM_VCPU_PSCI_0_2, vcpu->arch.features);
> +
> +		switch (val) {
> +		case KVM_ARM_PSCI_0_1:
> +			if (wants_02)
> +				return -EINVAL;
> +			vcpu->kvm->arch.psci_version = val;
> +			return 0;
> +		case KVM_ARM_PSCI_0_2:
> +		case KVM_ARM_PSCI_1_0:
> +			if (!wants_02)
> +				return -EINVAL;
> +			vcpu->kvm->arch.psci_version = val;
> +			return 0;
> +		}
> +		break;
> +	}
> +
> +	case KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1:
> +		if (val & ~KVM_REG_FEATURE_LEVEL_MASK)
> +			return -EINVAL;
> +
> +		if (get_kernel_wa_level(reg->id) < val)
> +			return -EINVAL;
> +
> +		return 0;
> +
> +	case KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2:
> +		if (val & ~(KVM_REG_FEATURE_LEVEL_MASK |
> +			    KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_ENABLED))
> +			return -EINVAL;
> +
> +		/* The enabled bit must not be set unless the level is AVAIL. */
> +		if ((val & KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_ENABLED) &&
> +		    (val & KVM_REG_FEATURE_LEVEL_MASK) != KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_AVAIL)
> +			return -EINVAL;
> +
> +		/*
> +		 * Map all the possible incoming states to the only two we
> +		 * really want to deal with.
> +		 */
> +		switch (val & KVM_REG_FEATURE_LEVEL_MASK) {
> +		case KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_AVAIL:
> +		case KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_UNKNOWN:
> +			wa_level = KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_AVAIL;
> +			break;
> +		case KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_AVAIL:
> +		case KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_REQUIRED:
> +			wa_level = KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_REQUIRED;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +
> +		/*
> +		 * We can deal with NOT_AVAIL on NOT_REQUIRED, but not the
> +		 * other way around.
> +		 */
> +		if (get_kernel_wa_level(reg->id) < wa_level)
> +			return -EINVAL;
> +
> +		return 0;
> +	default:
> +		return -ENOENT;
> +	}
> +
> +	return -EINVAL;
> +}
> diff --git a/arch/arm64/kvm/psci.c b/arch/arm64/kvm/psci.c
> index 3eae32876897..d5bc663a8629 100644
> --- a/arch/arm64/kvm/psci.c
> +++ b/arch/arm64/kvm/psci.c
> @@ -403,169 +403,3 @@ int kvm_psci_call(struct kvm_vcpu *vcpu)
>  		return -EINVAL;
>  	};
>  }
> -
> -int kvm_arm_get_fw_num_regs(struct kvm_vcpu *vcpu)
> -{
> -	return 3;		/* PSCI version and two workaround registers */
> -}
> -
> -int kvm_arm_copy_fw_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
> -{
> -	if (put_user(KVM_REG_ARM_PSCI_VERSION, uindices++))
> -		return -EFAULT;
> -
> -	if (put_user(KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1, uindices++))
> -		return -EFAULT;
> -
> -	if (put_user(KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2, uindices++))
> -		return -EFAULT;
> -
> -	return 0;
> -}
> -
> -#define KVM_REG_FEATURE_LEVEL_WIDTH	4
> -#define KVM_REG_FEATURE_LEVEL_MASK	(BIT(KVM_REG_FEATURE_LEVEL_WIDTH) - 1)
> -
> -/*
> - * Convert the workaround level into an easy-to-compare number, where higher
> - * values mean better protection.
> - */
> -static int get_kernel_wa_level(u64 regid)
> -{
> -	switch (regid) {
> -	case KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1:
> -		switch (arm64_get_spectre_v2_state()) {
> -		case SPECTRE_VULNERABLE:
> -			return KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_NOT_AVAIL;
> -		case SPECTRE_MITIGATED:
> -			return KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_AVAIL;
> -		case SPECTRE_UNAFFECTED:
> -			return KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_NOT_REQUIRED;
> -		}
> -		return KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_NOT_AVAIL;
> -	case KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2:
> -		switch (arm64_get_spectre_v4_state()) {
> -		case SPECTRE_MITIGATED:
> -			/*
> -			 * As for the hypercall discovery, we pretend we
> -			 * don't have any FW mitigation if SSBS is there at
> -			 * all times.
> -			 */
> -			if (cpus_have_final_cap(ARM64_SSBS))
> -				return KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_AVAIL;
> -			fallthrough;
> -		case SPECTRE_UNAFFECTED:
> -			return KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_REQUIRED;
> -		case SPECTRE_VULNERABLE:
> -			return KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_AVAIL;
> -		}
> -	}
> -
> -	return -EINVAL;
> -}
> -
> -int kvm_arm_get_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
> -{
> -	void __user *uaddr = (void __user *)(long)reg->addr;
> -	u64 val;
> -
> -	switch (reg->id) {
> -	case KVM_REG_ARM_PSCI_VERSION:
> -		val = kvm_psci_version(vcpu, vcpu->kvm);
> -		break;
> -	case KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1:
> -	case KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2:
> -		val = get_kernel_wa_level(reg->id) & KVM_REG_FEATURE_LEVEL_MASK;
> -		break;
> -	default:
> -		return -ENOENT;
> -	}
> -
> -	if (copy_to_user(uaddr, &val, KVM_REG_SIZE(reg->id)))
> -		return -EFAULT;
> -
> -	return 0;
> -}
> -
> -int kvm_arm_set_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
> -{
> -	void __user *uaddr = (void __user *)(long)reg->addr;
> -	u64 val;
> -	int wa_level;
> -
> -	if (copy_from_user(&val, uaddr, KVM_REG_SIZE(reg->id)))
> -		return -EFAULT;
> -
> -	switch (reg->id) {
> -	case KVM_REG_ARM_PSCI_VERSION:
> -	{
> -		bool wants_02;
> -
> -		wants_02 = test_bit(KVM_ARM_VCPU_PSCI_0_2, vcpu->arch.features);
> -
> -		switch (val) {
> -		case KVM_ARM_PSCI_0_1:
> -			if (wants_02)
> -				return -EINVAL;
> -			vcpu->kvm->arch.psci_version = val;
> -			return 0;
> -		case KVM_ARM_PSCI_0_2:
> -		case KVM_ARM_PSCI_1_0:
> -			if (!wants_02)
> -				return -EINVAL;
> -			vcpu->kvm->arch.psci_version = val;
> -			return 0;
> -		}
> -		break;
> -	}
> -
> -	case KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1:
> -		if (val & ~KVM_REG_FEATURE_LEVEL_MASK)
> -			return -EINVAL;
> -
> -		if (get_kernel_wa_level(reg->id) < val)
> -			return -EINVAL;
> -
> -		return 0;
> -
> -	case KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2:
> -		if (val & ~(KVM_REG_FEATURE_LEVEL_MASK |
> -			    KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_ENABLED))
> -			return -EINVAL;
> -
> -		/* The enabled bit must not be set unless the level is AVAIL. */
> -		if ((val & KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_ENABLED) &&
> -		    (val & KVM_REG_FEATURE_LEVEL_MASK) != KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_AVAIL)
> -			return -EINVAL;
> -
> -		/*
> -		 * Map all the possible incoming states to the only two we
> -		 * really want to deal with.
> -		 */
> -		switch (val & KVM_REG_FEATURE_LEVEL_MASK) {
> -		case KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_AVAIL:
> -		case KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_UNKNOWN:
> -			wa_level = KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_AVAIL;
> -			break;
> -		case KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_AVAIL:
> -		case KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_REQUIRED:
> -			wa_level = KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_REQUIRED;
> -			break;
> -		default:
> -			return -EINVAL;
> -		}
> -
> -		/*
> -		 * We can deal with NOT_AVAIL on NOT_REQUIRED, but not the
> -		 * other way around.
> -		 */
> -		if (get_kernel_wa_level(reg->id) < wa_level)
> -			return -EINVAL;
> -
> -		return 0;
> -	default:
> -		return -ENOENT;
> -	}
> -
> -	return -EINVAL;
> -}
> diff --git a/include/kvm/arm_hypercalls.h b/include/kvm/arm_hypercalls.h
> index 0e2509d27910..5d38628a8d04 100644
> --- a/include/kvm/arm_hypercalls.h
> +++ b/include/kvm/arm_hypercalls.h
> @@ -40,4 +40,11 @@ static inline void smccc_set_retval(struct kvm_vcpu *vcpu,
>  	vcpu_set_reg(vcpu, 3, a3);
>  }
>  
> +struct kvm_one_reg;
> +
> +int kvm_arm_get_fw_num_regs(struct kvm_vcpu *vcpu);
> +int kvm_arm_copy_fw_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices);
> +int kvm_arm_get_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
> +int kvm_arm_set_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
> +
>  #endif
> diff --git a/include/kvm/arm_psci.h b/include/kvm/arm_psci.h
> index 5b58bd2fe088..080c2d0bd6e7 100644
> --- a/include/kvm/arm_psci.h
> +++ b/include/kvm/arm_psci.h
> @@ -42,11 +42,4 @@ static inline int kvm_psci_version(struct kvm_vcpu *vcpu, struct kvm *kvm)
>  
>  int kvm_psci_call(struct kvm_vcpu *vcpu);
>  
> -struct kvm_one_reg;
> -
> -int kvm_arm_get_fw_num_regs(struct kvm_vcpu *vcpu);
> -int kvm_arm_copy_fw_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices);
> -int kvm_arm_get_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
> -int kvm_arm_set_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
> -
>  #endif /* __KVM_ARM_PSCI_H__ */
> -- 
> 2.35.1.473.g83b2b277ed-goog
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
