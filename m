Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 58387298E84
	for <lists+kvmarm@lfdr.de>; Mon, 26 Oct 2020 14:53:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E5AA14B4F6;
	Mon, 26 Oct 2020 09:53:15 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aD6umUPnJ9Cs; Mon, 26 Oct 2020 09:53:15 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B82B04B4F5;
	Mon, 26 Oct 2020 09:53:14 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2D0074B4DE
 for <kvmarm@lists.cs.columbia.edu>; Mon, 26 Oct 2020 09:53:14 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wHbU78IMZJJP for <kvmarm@lists.cs.columbia.edu>;
 Mon, 26 Oct 2020 09:53:13 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 00B244B4D4
 for <kvmarm@lists.cs.columbia.edu>; Mon, 26 Oct 2020 09:53:12 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DB49106F;
 Mon, 26 Oct 2020 06:53:12 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.56.187])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1557A3F68F;
 Mon, 26 Oct 2020 06:53:10 -0700 (PDT)
Date: Mon, 26 Oct 2020 13:53:08 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 01/11] KVM: arm64: Don't adjust PC on SError during SMC
 trap
Message-ID: <20201026135308.GC12454@C02TD0UTHF1T.local>
References: <20201026133450.73304-1-maz@kernel.org>
 <20201026133450.73304-2-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201026133450.73304-2-maz@kernel.org>
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

On Mon, Oct 26, 2020 at 01:34:40PM +0000, Marc Zyngier wrote:
> On SMC trap, the prefered return address is set to that of the SMC
> instruction itself. It is thus wrong to tyr and roll it back when

Typo: s/tyr/try/

> an SError occurs while trapping on SMC. It is still necessary on
> HVC though, as HVC doesn't cause a trap, and sets ELR to returning
> *after* the HVC.
> 
> It also became apparent that the is 16bit encoding for an AArch32

I guess s/that the is/that there is no/ ?

> HVC instruction, meaning that the displacement is always 4 bytes,
> no matter what the ISA is. Take this opportunity to simplify it.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Assuming that there is no 16-bit HVC:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/kvm/handle_exit.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
> index 5d690d60ccad..79a720657c47 100644
> --- a/arch/arm64/kvm/handle_exit.c
> +++ b/arch/arm64/kvm/handle_exit.c
> @@ -245,15 +245,15 @@ int handle_exit(struct kvm_vcpu *vcpu, int exception_index)
>  		u8 esr_ec = ESR_ELx_EC(kvm_vcpu_get_esr(vcpu));
>  
>  		/*
> -		 * HVC/SMC already have an adjusted PC, which we need
> -		 * to correct in order to return to after having
> -		 * injected the SError.
> +		 * HVC already have an adjusted PC, which we need to
> +		 * correct in order to return to after having injected
> +		 * the SError.
> +		 *
> +		 * SMC, on the other hand, is *trapped*, meaning its
> +		 * preferred return address is the SMC itself.
>  		 */
> -		if (esr_ec == ESR_ELx_EC_HVC32 || esr_ec == ESR_ELx_EC_HVC64 ||
> -		    esr_ec == ESR_ELx_EC_SMC32 || esr_ec == ESR_ELx_EC_SMC64) {
> -			u32 adj =  kvm_vcpu_trap_il_is32bit(vcpu) ? 4 : 2;
> -			*vcpu_pc(vcpu) -= adj;
> -		}
> +		if (esr_ec == ESR_ELx_EC_HVC32 || esr_ec == ESR_ELx_EC_HVC64)
> +			*vcpu_pc(vcpu) -= 4;
>  
>  		return 1;
>  	}
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
