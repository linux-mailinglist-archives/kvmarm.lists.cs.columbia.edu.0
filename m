Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 040081EE7EA
	for <lists+kvmarm@lfdr.de>; Thu,  4 Jun 2020 17:39:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8117C4B3D8;
	Thu,  4 Jun 2020 11:39:16 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DUxthZ4t7j9G; Thu,  4 Jun 2020 11:39:16 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 263D64B364;
	Thu,  4 Jun 2020 11:39:15 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 87F3C4B364
 for <kvmarm@lists.cs.columbia.edu>; Thu,  4 Jun 2020 11:39:13 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FnyoKIDB3qLp for <kvmarm@lists.cs.columbia.edu>;
 Thu,  4 Jun 2020 11:39:12 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2D6F84B213
 for <kvmarm@lists.cs.columbia.edu>; Thu,  4 Jun 2020 11:39:12 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30DB31FB;
 Thu,  4 Jun 2020 08:39:06 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.9.165])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD38D3F305;
 Thu,  4 Jun 2020 08:39:03 -0700 (PDT)
Date: Thu, 4 Jun 2020 16:39:00 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 3/3] KVM: arm64: Enforce PtrAuth being disabled if not
 advertized
Message-ID: <20200604153900.GE75320@C02TD0UTHF1T.local>
References: <20200604133354.1279412-1-maz@kernel.org>
 <20200604133354.1279412-4-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200604133354.1279412-4-maz@kernel.org>
Cc: kernel-team@android.com, kvm@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

Hi Marc,

On Thu, Jun 04, 2020 at 02:33:54PM +0100, Marc Zyngier wrote:
> Even if we don't expose PtrAuth to a guest, the guest can still
> write to its SCTIRLE_1 register and set the En{I,D}{A,B} bits
> and execute PtrAuth instructions from the NOP space. This has
> the effect of trapping to EL2, and we currently inject an UNDEF.

I think it's worth noting that this is an ill-behaved guest, as those
bits are RES0 when pointer authentication isn't implemented.

The rationale for RES0/RES1 bits is that new HW can rely on old SW
programming them with the 0/1 as appropriate, and that old SW that does
not do so may encounter behaviour which from its PoV is UNPREDICTABLE.
The SW side of the contract is that you must program them as 0/1 unless
you know they're allocated with a specific meaning.

With that in mind I think the current behaviour is legitimate: from the
guest's PoV it's the same as there being a distinct extension which it
is not aware of where the En{I,D}{A,B} bits means "trap some HINTs to
EL1".

I don't think that we should attempt to work around broken software here
unless we absolutely have to, as it only adds complexity for no real
gain.

Thanks,
Mark.

> This is definitely the wrong thing to do, as the architecture says
> that these instructions should behave as NOPs.
> 
> Instead, we can simply reset the offending SCTLR_EL1 bits to
> zero, and resume the guest. It can still observe the SCTLR bits
> being set and then being cleared by magic, but that's much better
> than delivering an unexpected extension.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/kvm/handle_exit.c | 12 ------------
>  arch/arm64/kvm/hyp/switch.c  | 18 ++++++++++++++++--
>  2 files changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
> index 5a02d4c90559..98d8adf6f865 100644
> --- a/arch/arm64/kvm/handle_exit.c
> +++ b/arch/arm64/kvm/handle_exit.c
> @@ -162,17 +162,6 @@ static int handle_sve(struct kvm_vcpu *vcpu, struct kvm_run *run)
>  	return 1;
>  }
>  
> -/*
> - * Guest usage of a ptrauth instruction (which the guest EL1 did not turn into
> - * a NOP). If we get here, it is that we didn't fixup ptrauth on exit, and all
> - * that we can do is give the guest an UNDEF.
> - */
> -static int kvm_handle_ptrauth(struct kvm_vcpu *vcpu, struct kvm_run *run)
> -{
> -	kvm_inject_undefined(vcpu);
> -	return 1;
> -}
> -
>  static exit_handle_fn arm_exit_handlers[] = {
>  	[0 ... ESR_ELx_EC_MAX]	= kvm_handle_unknown_ec,
>  	[ESR_ELx_EC_WFx]	= kvm_handle_wfx,
> @@ -195,7 +184,6 @@ static exit_handle_fn arm_exit_handlers[] = {
>  	[ESR_ELx_EC_BKPT32]	= kvm_handle_guest_debug,
>  	[ESR_ELx_EC_BRK64]	= kvm_handle_guest_debug,
>  	[ESR_ELx_EC_FP_ASIMD]	= handle_no_fpsimd,
> -	[ESR_ELx_EC_PAC]	= kvm_handle_ptrauth,
>  };
>  
>  static exit_handle_fn kvm_get_exit_handler(struct kvm_vcpu *vcpu)
> diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
> index 2a50b3771c3b..fc09c3dfa466 100644
> --- a/arch/arm64/kvm/hyp/switch.c
> +++ b/arch/arm64/kvm/hyp/switch.c
> @@ -503,8 +503,22 @@ static bool __hyp_text __hyp_handle_ptrauth(struct kvm_vcpu *vcpu)
>  	struct kvm_cpu_context *ctxt;
>  	u64 val;
>  
> -	if (!vcpu_has_ptrauth(vcpu))
> -		return false;
> +	if (!vcpu_has_ptrauth(vcpu)) {
> +		if (ec != ESR_ELx_EC_PAC)
> +			return false;
> +
> +		/*
> +		 * Interesting situation: the guest has enabled PtrAuth,
> +		 * despite KVM not advertising it. Fix SCTLR_El1 on behalf
> +		 * of the guest (the bits should behave as RES0 anyway).
> +		 */
> +		val = read_sysreg_el1(SYS_SCTLR);
> +		val &= ~(SCTLR_ELx_ENIA | SCTLR_ELx_ENIB |
> +			 SCTLR_ELx_ENDA | SCTLR_ELx_ENDB);
> +		write_sysreg_el1(val, SYS_SCTLR);
> +
> +		return true;
> +	}
>  
>  	switch (ec) {
>  	case ESR_ELx_EC_PAC:
> -- 
> 2.26.2
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
