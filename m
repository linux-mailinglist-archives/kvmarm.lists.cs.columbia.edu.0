Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D4C73509E7
	for <lists+kvmarm@lfdr.de>; Mon, 24 Jun 2019 13:38:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 64D844A533;
	Mon, 24 Jun 2019 07:38:26 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Nw2D-MnMaCeo; Mon, 24 Jun 2019 07:38:26 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0C58C4A50F;
	Mon, 24 Jun 2019 07:38:25 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 772CD4A4A3
 for <kvmarm@lists.cs.columbia.edu>; Mon, 24 Jun 2019 07:38:23 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y5H3GdPlFY+j for <kvmarm@lists.cs.columbia.edu>;
 Mon, 24 Jun 2019 07:38:22 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EDC3E4A332
 for <kvmarm@lists.cs.columbia.edu>; Mon, 24 Jun 2019 07:38:21 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98B262B;
 Mon, 24 Jun 2019 04:38:21 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 438093F718;
 Mon, 24 Jun 2019 04:38:20 -0700 (PDT)
Date: Mon, 24 Jun 2019 12:38:18 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH 05/59] KVM: arm64: nv: Reset VCPU to EL2 registers if
 VCPU nested virt is set
Message-ID: <20190624113817.GN2790@e103592.cambridge.arm.com>
References: <20190621093843.220980-1-marc.zyngier@arm.com>
 <20190621093843.220980-6-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190621093843.220980-6-marc.zyngier@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: kvm@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>,
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

On Fri, Jun 21, 2019 at 10:37:49AM +0100, Marc Zyngier wrote:
> From: Christoffer Dall <christoffer.dall@arm.com>
> 
> Reset the VCPU with PSTATE.M = EL2h when the nested virtualization
> feature is enabled on the VCPU.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/kvm/reset.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
> index 1140b4485575..675ca07dbb05 100644
> --- a/arch/arm64/kvm/reset.c
> +++ b/arch/arm64/kvm/reset.c
> @@ -52,6 +52,11 @@ static const struct kvm_regs default_regs_reset = {
>  			PSR_F_BIT | PSR_D_BIT),
>  };
>  
> +static const struct kvm_regs default_regs_reset_el2 = {
> +	.regs.pstate = (PSR_MODE_EL2h | PSR_A_BIT | PSR_I_BIT |
> +			PSR_F_BIT | PSR_D_BIT),
> +};
> +

Is it worth having a #define for the common non-mode bits?  It's a bit
weird for EL2 and EL1 to have indepedent DAIF defaults.

Putting a big block of zeros in the kernel text just to initialise one
register seems overkill.  Now we're adding a third block of zeros,
maybe this is worth refactoring?  We really just need a memset(0)
followed by config-dependent initialisation of regs.pstate AFAICT.

Not a big deal though: this doesn't look like a high risk for
maintainability.

Cheers
---Dave

>  static const struct kvm_regs default_regs_reset32 = {
>  	.regs.pstate = (PSR_AA32_MODE_SVC | PSR_AA32_A_BIT |
>  			PSR_AA32_I_BIT | PSR_AA32_F_BIT),
> @@ -302,6 +307,8 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
>  			if (!cpu_has_32bit_el1())
>  				goto out;
>  			cpu_reset = &default_regs_reset32;
> +		} else if (test_bit(KVM_ARM_VCPU_NESTED_VIRT, vcpu->arch.features)) {
> +			cpu_reset = &default_regs_reset_el2;
>  		} else {
>  			cpu_reset = &default_regs_reset;
>  		}
> -- 
> 2.20.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
