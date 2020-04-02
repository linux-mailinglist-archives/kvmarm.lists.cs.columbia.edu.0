Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 37A1119C301
	for <lists+kvmarm@lfdr.de>; Thu,  2 Apr 2020 15:48:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DD1474B159;
	Thu,  2 Apr 2020 09:48:22 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6V0g+v00EwUd; Thu,  2 Apr 2020 09:48:22 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9F7D94B15D;
	Thu,  2 Apr 2020 09:48:21 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0ACC24B148
 for <kvmarm@lists.cs.columbia.edu>; Thu,  2 Apr 2020 09:48:21 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DdmRcoKKbyjm for <kvmarm@lists.cs.columbia.edu>;
 Thu,  2 Apr 2020 09:48:19 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E5B524B145
 for <kvmarm@lists.cs.columbia.edu>; Thu,  2 Apr 2020 09:48:19 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 964B930E;
 Thu,  2 Apr 2020 06:48:19 -0700 (PDT)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.145.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2BFFD3F52E;
 Thu,  2 Apr 2020 06:48:19 -0700 (PDT)
Date: Thu, 2 Apr 2020 15:48:17 +0200
From: Christoffer Dall <christoffer.dall@arm.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 2/2] KVM: arm64: PSCI: Forbid 64bit functions for 32bit
 guests
Message-ID: <20200402134817.GG3650@e113682-lin.lund.arm.com>
References: <20200401165816.530281-1-maz@kernel.org>
 <20200401165816.530281-3-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200401165816.530281-3-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu
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

On Wed, Apr 01, 2020 at 05:58:16PM +0100, Marc Zyngier wrote:
> Implementing (and even advertising) 64bit PSCI functions to 32bit
> guests is at least a bit odd, if not altogether violating the
> spec which says ("5.2.1 Register usage in arguments and return values"):
> 
> "Adherence to the SMC Calling Conventions implies that any AArch32
> caller of an SMC64 function will get a return code of 0xFFFFFFFF(int32).
> This matches the NOT_SUPPORTED error code used in PSCI"
> 
> Tighten the implementation by pretending these functions are not
> there for 32bit guests.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  virt/kvm/arm/psci.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/virt/kvm/arm/psci.c b/virt/kvm/arm/psci.c
> index 69ff4a51ceb5..122795cdd984 100644
> --- a/virt/kvm/arm/psci.c
> +++ b/virt/kvm/arm/psci.c
> @@ -199,6 +199,21 @@ static void kvm_psci_narrow_to_32bit(struct kvm_vcpu *vcpu)
>  		vcpu_set_reg(vcpu, i, (u32)vcpu_get_reg(vcpu, i));
>  }
>  
> +static unsigned long kvm_psci_check_allowed_function(struct kvm_vcpu *vcpu, u32 fn)
> +{
> +	switch(fn) {
> +	case PSCI_0_2_FN64_CPU_SUSPEND:
> +	case PSCI_0_2_FN64_CPU_ON:
> +	case PSCI_0_2_FN64_AFFINITY_INFO:
> +		/* Disallow these functions for 32bit guests */
> +		if (vcpu_mode_is_32bit(vcpu))
> +			return PSCI_RET_NOT_SUPPORTED;
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
>  static int kvm_psci_0_2_call(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm *kvm = vcpu->kvm;
> @@ -206,6 +221,10 @@ static int kvm_psci_0_2_call(struct kvm_vcpu *vcpu)
>  	unsigned long val;
>  	int ret = 1;
>  
> +	val = kvm_psci_check_allowed_function(vcpu, psci_fn);
> +	if (val)
> +		goto out;
> +
>  	switch (psci_fn) {
>  	case PSCI_0_2_FN_PSCI_VERSION:
>  		/*
> @@ -273,6 +292,7 @@ static int kvm_psci_0_2_call(struct kvm_vcpu *vcpu)
>  		break;
>  	}
>  
> +out:
>  	smccc_set_retval(vcpu, val, 0, 0, 0);
>  	return ret;
>  }
> @@ -290,6 +310,10 @@ static int kvm_psci_1_0_call(struct kvm_vcpu *vcpu)
>  		break;
>  	case PSCI_1_0_FN_PSCI_FEATURES:
>  		feature = smccc_get_arg1(vcpu);
> +		val = kvm_psci_check_allowed_function(vcpu, feature);
> +		if (val)
> +			break;
> +
>  		switch(feature) {
>  		case PSCI_0_2_FN_PSCI_VERSION:
>  		case PSCI_0_2_FN_CPU_SUSPEND:
> -- 
> 2.25.0
> 

Reviewed-by: Christoffer Dall <christoffer.dall@arm.com>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
