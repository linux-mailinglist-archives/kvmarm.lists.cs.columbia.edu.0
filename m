Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2694C31362
	for <lists+kvmarm@lfdr.de>; Fri, 31 May 2019 19:04:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C90F04A4F1;
	Fri, 31 May 2019 13:04:46 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w41UkqNPG7cm; Fri, 31 May 2019 13:04:46 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 685034A420;
	Fri, 31 May 2019 13:04:45 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5840E4A3BF
 for <kvmarm@lists.cs.columbia.edu>; Fri, 31 May 2019 13:04:43 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QpOdkcS43qrR for <kvmarm@lists.cs.columbia.edu>;
 Fri, 31 May 2019 13:04:41 -0400 (EDT)
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CDE474A369
 for <kvmarm@lists.cs.columbia.edu>; Fri, 31 May 2019 13:04:41 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5048815AD;
 Fri, 31 May 2019 10:04:41 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 826843F59C;
 Fri, 31 May 2019 10:04:39 -0700 (PDT)
Date: Fri, 31 May 2019 18:04:36 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH kvmtool v3 6/9] arm/arm64: Factor out ptrauth vcpu
 feature setup
Message-ID: <20190531180436.118450c5@donnerap.cambridge.arm.com>
In-Reply-To: <1559229194-3036-7-git-send-email-Dave.Martin@arm.com>
References: <1559229194-3036-1-git-send-email-Dave.Martin@arm.com>
 <1559229194-3036-7-git-send-email-Dave.Martin@arm.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Cc: Christoffer Dall <cdall@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>,
 Will Deacon <will.deacon@arm.com>,
 Kristina Martsenko <kristina.martsenko@arm.com>,
 Zhang Lei <zhang.lei@jp.fujitsu.com>,
 Amit Daniel Kachhap <amit.kachhap@arm.com>, kvmarm@lists.cs.columbia.edu,
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

On Thu, 30 May 2019 16:13:11 +0100
Dave Martin <Dave.Martin@arm.com> wrote:

> In the interest of readability, factor out the vcpu feature setup
> for ptrauth into a separate function.
> 
> Also, because aarch32 doesn't have this feature or the related
> command line options anyway, move the actual code into aarch64/.
> 
> Since ARM_VCPU_PTRAUTH_FEATURE is only there to make the ptrauth
> feature setup code compile on arm, it is no longer needed: inline
> and remove it.

I am not sure this is useful as a separate patch, so can we just merge this into 5/9?

Cheers,
Andre.

> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> ---
>  arm/aarch32/include/kvm/kvm-cpu-arch.h |  3 ++-
>  arm/aarch64/include/kvm/kvm-cpu-arch.h |  3 +--
>  arm/aarch64/kvm-cpu.c                  | 22 ++++++++++++++++++++++
>  arm/kvm-cpu.c                          | 12 +-----------
>  4 files changed, 26 insertions(+), 14 deletions(-)
> 
> diff --git a/arm/aarch32/include/kvm/kvm-cpu-arch.h b/arm/aarch32/include/kvm/kvm-cpu-arch.h
> index 3ec6f03..01983f0 100644
> --- a/arm/aarch32/include/kvm/kvm-cpu-arch.h
> +++ b/arm/aarch32/include/kvm/kvm-cpu-arch.h
> @@ -13,6 +13,7 @@
>  #define ARM_CPU_ID		0, 0, 0
>  #define ARM_CPU_ID_MPIDR	5
>  
> -#define ARM_VCPU_PTRAUTH_FEATURE	0
> +static inline void kvm_cpu__select_features(struct kvm *kvm,
> +					    struct kvm_vcpu_init *init) { }
>  
>  #endif /* KVM__KVM_CPU_ARCH_H */
> diff --git a/arm/aarch64/include/kvm/kvm-cpu-arch.h b/arm/aarch64/include/kvm/kvm-cpu-arch.h
> index 9fa99fb..e6875fc 100644
> --- a/arm/aarch64/include/kvm/kvm-cpu-arch.h
> +++ b/arm/aarch64/include/kvm/kvm-cpu-arch.h
> @@ -17,7 +17,6 @@
>  #define ARM_CPU_CTRL		3, 0, 1, 0
>  #define ARM_CPU_CTRL_SCTLR_EL1	0
>  
> -#define ARM_VCPU_PTRAUTH_FEATURE	((1UL << KVM_ARM_VCPU_PTRAUTH_ADDRESS) \
> -					| (1UL << KVM_ARM_VCPU_PTRAUTH_GENERIC))
> +void kvm_cpu__select_features(struct kvm *kvm, struct kvm_vcpu_init *init);
>  
>  #endif /* KVM__KVM_CPU_ARCH_H */
> diff --git a/arm/aarch64/kvm-cpu.c b/arm/aarch64/kvm-cpu.c
> index 0aaefaf..d3c32e0 100644
> --- a/arm/aarch64/kvm-cpu.c
> +++ b/arm/aarch64/kvm-cpu.c
> @@ -128,6 +128,28 @@ static void reset_vcpu_aarch64(struct kvm_cpu *vcpu)
>  	}
>  }
>  
> +static void select_ptrauth_feature(struct kvm *kvm, struct kvm_vcpu_init *init)
> +{
> +	/* Check Pointer Authentication command line arguments. */
> +	if (kvm->cfg.arch.enable_ptrauth && kvm->cfg.arch.disable_ptrauth)
> +		die("Both enable-ptrauth and disable-ptrauth option cannot be present");
> +	/*
> +	 * Always enable Pointer Authentication if system supports
> +	 * this extension unless disable-ptrauth option is present.
> +	 */
> +	if (kvm__supports_extension(kvm, KVM_CAP_ARM_PTRAUTH_ADDRESS) &&
> +	    kvm__supports_extension(kvm, KVM_CAP_ARM_PTRAUTH_GENERIC) &&
> +	    !kvm->cfg.arch.disable_ptrauth) {
> +		init->features[0] |= 1UL << KVM_ARM_VCPU_PTRAUTH_ADDRESS;
> +		init->features[0] |= 1UL << KVM_ARM_VCPU_PTRAUTH_GENERIC;
> +	}
> +}
> +
> +void kvm_cpu__select_features(struct kvm *kvm, struct kvm_vcpu_init *init)
> +{
> +	select_ptrauth_feature(kvm, init);
> +}
> +
>  void kvm_cpu__reset_vcpu(struct kvm_cpu *vcpu)
>  {
>  	if (vcpu->kvm->cfg.arch.aarch32_guest)
> diff --git a/arm/kvm-cpu.c b/arm/kvm-cpu.c
> index acd1d5f..764fb05 100644
> --- a/arm/kvm-cpu.c
> +++ b/arm/kvm-cpu.c
> @@ -68,17 +68,7 @@ struct kvm_cpu *kvm_cpu__arch_init(struct kvm *kvm, unsigned long cpu_id)
>  		vcpu_init.features[0] |= (1UL << KVM_ARM_VCPU_PSCI_0_2);
>  	}
>  
> -	/* Check Pointer Authentication command line arguments. */
> -	if (kvm->cfg.arch.enable_ptrauth && kvm->cfg.arch.disable_ptrauth)
> -		die("Both enable-ptrauth and disable-ptrauth option cannot be present");
> -	/*
> -	 * Always enable Pointer Authentication if system supports
> -	 * this extension unless disable-ptrauth option is present.
> -	 */
> -	if (kvm__supports_extension(kvm, KVM_CAP_ARM_PTRAUTH_ADDRESS) &&
> -	    kvm__supports_extension(kvm, KVM_CAP_ARM_PTRAUTH_GENERIC) &&
> -	    !kvm->cfg.arch.disable_ptrauth)
> -			vcpu_init.features[0] |= ARM_VCPU_PTRAUTH_FEATURE;
> +	kvm_cpu__select_features(kvm, &vcpu_init);
>  
>  	/*
>  	 * If the preferred target ioctl is successful then

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
