Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 93ADF298ED8
	for <lists+kvmarm@lfdr.de>; Mon, 26 Oct 2020 15:06:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 30EE84B4F8;
	Mon, 26 Oct 2020 10:06:15 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1ekTobkOxWEe; Mon, 26 Oct 2020 10:06:15 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F04584B4F6;
	Mon, 26 Oct 2020 10:06:13 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A91A74B4DF
 for <kvmarm@lists.cs.columbia.edu>; Mon, 26 Oct 2020 10:06:12 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Uz4Q5oOw1DY3 for <kvmarm@lists.cs.columbia.edu>;
 Mon, 26 Oct 2020 10:06:11 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 43CD74B307
 for <kvmarm@lists.cs.columbia.edu>; Mon, 26 Oct 2020 10:06:11 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAA5030E;
 Mon, 26 Oct 2020 07:06:10 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.56.187])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3CE573F68F;
 Mon, 26 Oct 2020 07:06:09 -0700 (PDT)
Date: Mon, 26 Oct 2020 14:06:06 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 04/11] KVM: arm64: Move PC rollback on SError to HYP
Message-ID: <20201026140606.GF12454@C02TD0UTHF1T.local>
References: <20201026133450.73304-1-maz@kernel.org>
 <20201026133450.73304-5-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201026133450.73304-5-maz@kernel.org>
Cc: Will Deacon <will@kernel.org>, kernel-team@android.com,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 kvm@vger.kernel.org
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

On Mon, Oct 26, 2020 at 01:34:43PM +0000, Marc Zyngier wrote:
> Instead of handling the "PC rollback on SError during HVC" at EL1 (which
> requires disclosing PC to a potentially untrusted kernel), let's move
> this fixup to ... fixup_guest_exit(), which is where we do all fixups.
> 
> Isn't that neat?
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/kvm/handle_exit.c            | 17 -----------------
>  arch/arm64/kvm/hyp/include/hyp/switch.h | 15 +++++++++++++++
>  2 files changed, 15 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
> index d4e00a864ee6..f79137ee4274 100644
> --- a/arch/arm64/kvm/handle_exit.c
> +++ b/arch/arm64/kvm/handle_exit.c
> @@ -241,23 +241,6 @@ int handle_exit(struct kvm_vcpu *vcpu, int exception_index)
>  {
>  	struct kvm_run *run = vcpu->run;
>  
> -	if (ARM_SERROR_PENDING(exception_index)) {
> -		u8 esr_ec = ESR_ELx_EC(kvm_vcpu_get_esr(vcpu));
> -
> -		/*
> -		 * HVC already have an adjusted PC, which we need to
> -		 * correct in order to return to after having injected
> -		 * the SError.
> -		 *
> -		 * SMC, on the other hand, is *trapped*, meaning its
> -		 * preferred return address is the SMC itself.
> -		 */
> -		if (esr_ec == ESR_ELx_EC_HVC32 || esr_ec == ESR_ELx_EC_HVC64)
> -			*vcpu_pc(vcpu) -= 4;
> -
> -		return 1;
> -	}
> -
>  	exception_index = ARM_EXCEPTION_CODE(exception_index);
>  
>  	switch (exception_index) {
> diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
> index d687e574cde5..668f02c7b0b3 100644
> --- a/arch/arm64/kvm/hyp/include/hyp/switch.h
> +++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
> @@ -411,6 +411,21 @@ static inline bool fixup_guest_exit(struct kvm_vcpu *vcpu, u64 *exit_code)
>  	if (ARM_EXCEPTION_CODE(*exit_code) != ARM_EXCEPTION_IRQ)
>  		vcpu->arch.fault.esr_el2 = read_sysreg_el2(SYS_ESR);
>  
> +	if (ARM_SERROR_PENDING(*exit_code)) {
> +		u8 esr_ec = kvm_vcpu_trap_get_class(vcpu);
> +
> +		/*
> +		 * HVC already have an adjusted PC, which we need to
> +		 * correct in order to return to after having injected
> +		 * the SError.
> +		 *
> +		 * SMC, on the other hand, is *trapped*, meaning its
> +		 * preferred return address is the SMC itself.
> +		 */
> +		if (esr_ec == ESR_ELx_EC_HVC32 || esr_ec == ESR_ELx_EC_HVC64)
> +			*vcpu_pc(vcpu) -= 4;
> +	}
> +
>  	/*
>  	 * We're using the raw exception code in order to only process
>  	 * the trap if no SError is pending. We will come back to the
> -- 
> 2.28.0
> 
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
