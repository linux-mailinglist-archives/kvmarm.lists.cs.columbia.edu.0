Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3465C19C2F6
	for <lists+kvmarm@lfdr.de>; Thu,  2 Apr 2020 15:47:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A19DA4B161;
	Thu,  2 Apr 2020 09:47:41 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qqxsXs4E4kcj; Thu,  2 Apr 2020 09:47:41 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7197B4B159;
	Thu,  2 Apr 2020 09:47:40 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 50D104B145
 for <kvmarm@lists.cs.columbia.edu>; Thu,  2 Apr 2020 09:47:39 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id waJ53XHk5OKY for <kvmarm@lists.cs.columbia.edu>;
 Thu,  2 Apr 2020 09:47:38 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2662C4B139
 for <kvmarm@lists.cs.columbia.edu>; Thu,  2 Apr 2020 09:47:38 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A7EC30E;
 Thu,  2 Apr 2020 06:47:37 -0700 (PDT)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.145.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F1B173F52E;
 Thu,  2 Apr 2020 06:47:36 -0700 (PDT)
Date: Thu, 2 Apr 2020 15:47:35 +0200
From: Christoffer Dall <christoffer.dall@arm.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 1/2] KVM: arm64: PSCI: Narrow input registers when using
 32bit functions
Message-ID: <20200402134735.GF3650@e113682-lin.lund.arm.com>
References: <20200401165816.530281-1-maz@kernel.org>
 <20200401165816.530281-2-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200401165816.530281-2-maz@kernel.org>
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

On Wed, Apr 01, 2020 at 05:58:15PM +0100, Marc Zyngier wrote:
> When a guest delibarately uses an SSMC32 function number (which is allowed),
> we should make sure we drop the top 32bits from the input arguments, as they
> could legitimately be junk.
> 
> Reported-by: Christoffer Dall <christoffer.dall@arm.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  virt/kvm/arm/psci.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/virt/kvm/arm/psci.c b/virt/kvm/arm/psci.c
> index 17e2bdd4b76f..69ff4a51ceb5 100644
> --- a/virt/kvm/arm/psci.c
> +++ b/virt/kvm/arm/psci.c
> @@ -187,6 +187,18 @@ static void kvm_psci_system_reset(struct kvm_vcpu *vcpu)
>  	kvm_prepare_system_event(vcpu, KVM_SYSTEM_EVENT_RESET);
>  }
>  
> +static void kvm_psci_narrow_to_32bit(struct kvm_vcpu *vcpu)
> +{
> +	int i;
> +
> +	/*
> +	 * Zero the input registers' upper 32 bits. They will be fully
> +	 * zeroed on exit, so we're fine changing them in place.
> +	 */
> +	for (i = 1; i < 4; i++)
> +		vcpu_set_reg(vcpu, i, (u32)vcpu_get_reg(vcpu, i));
> +}
> +
>  static int kvm_psci_0_2_call(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm *kvm = vcpu->kvm;
> @@ -211,12 +223,16 @@ static int kvm_psci_0_2_call(struct kvm_vcpu *vcpu)
>  		val = PSCI_RET_SUCCESS;
>  		break;
>  	case PSCI_0_2_FN_CPU_ON:
> +		kvm_psci_narrow_to_32bit(vcpu);
> +		fallthrough;
>  	case PSCI_0_2_FN64_CPU_ON:
>  		mutex_lock(&kvm->lock);
>  		val = kvm_psci_vcpu_on(vcpu);
>  		mutex_unlock(&kvm->lock);
>  		break;
>  	case PSCI_0_2_FN_AFFINITY_INFO:
> +		kvm_psci_narrow_to_32bit(vcpu);
> +		fallthrough;
>  	case PSCI_0_2_FN64_AFFINITY_INFO:
>  		val = kvm_psci_vcpu_affinity_info(vcpu);
>  		break;
> -- 
> 2.25.0
> 

Reviewed-by: Christoffer Dall <christoffer.dall@arm.com>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
