Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E73C6E7758
	for <lists+kvmarm@lfdr.de>; Mon, 28 Oct 2019 18:09:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 770454AC82;
	Mon, 28 Oct 2019 13:09:53 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qKoC7tjHLsT6; Mon, 28 Oct 2019 13:09:53 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1F9B74AC7D;
	Mon, 28 Oct 2019 13:09:52 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 61CBE4A59D
 for <kvmarm@lists.cs.columbia.edu>; Mon, 28 Oct 2019 13:09:51 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EWM0FbsoKxMw for <kvmarm@lists.cs.columbia.edu>;
 Mon, 28 Oct 2019 13:09:50 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 445644A597
 for <kvmarm@lists.cs.columbia.edu>; Mon, 28 Oct 2019 13:09:50 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C62111FB;
 Mon, 28 Oct 2019 10:09:49 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F99E3F71F;
 Mon, 28 Oct 2019 10:09:49 -0700 (PDT)
Date: Mon, 28 Oct 2019 17:09:47 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2] KVM: arm64: Don't set HCR_EL2.TVM when S2FWB is
 supported
Message-ID: <20191028170946.GB52213@lakrids.cambridge.arm.com>
References: <20191028130541.30536-1-christoffer.dall@arm.com>
 <0c3291a7-18dc-1ae5-e706-8b04c9ab8a9e@arm.com>
 <86pnigyh90.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <86pnigyh90.wl-maz@kernel.org>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Cc: kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

On Mon, Oct 28, 2019 at 04:19:55PM +0000, Marc Zyngier wrote:
> On Mon, 28 Oct 2019 15:12:39 +0000,
> Alexandru Elisei <alexandru.elisei@arm.com> wrote:
> > On 10/28/19 1:05 PM, Christoffer Dall wrote:
> > > diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
> > > index d69c1efc63e7..70509799a2a9 100644
> > > --- a/arch/arm64/include/asm/kvm_emulate.h
> > > +++ b/arch/arm64/include/asm/kvm_emulate.h
> > > @@ -53,8 +53,18 @@ static inline void vcpu_reset_hcr(struct kvm_vcpu *vcpu)
> > >  		/* trap error record accesses */
> > >  		vcpu->arch.hcr_el2 |= HCR_TERR;
> > >  	}
> > > -	if (cpus_have_const_cap(ARM64_HAS_STAGE2_FWB))
> > > +
> > > +	if (cpus_have_const_cap(ARM64_HAS_STAGE2_FWB)) {
> > >  		vcpu->arch.hcr_el2 |= HCR_FWB;
> > > +	} else {
> > > +		/*
> > > +		 * For non-FWB CPUs, we trap VM ops (HCR_EL2.TVM) until M+C
> > > +		 * get set in SCTLR_EL1 such that we can detect when the guest
> > > +		 * MMU gets turned off and do the necessary cache maintenance
> > > +		 * then.
> > > +		 */
> > > +		vcpu->arch.hcr_el2 &= ~HCR_TVM;
> > 
> > Don't we want to set the bit here, so we're consistent with the
> > previous behaviour and the comment? Because with this patch, we
> > never set HCR_EL2.TVM...
> 
> Of course you're right. This is how I plan to fix it:
> 
> diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
> index 47c774c2d18b..7b835337f78b 100644
> --- a/arch/arm64/include/asm/kvm_emulate.h
> +++ b/arch/arm64/include/asm/kvm_emulate.h
> @@ -63,7 +63,7 @@ static inline void vcpu_reset_hcr(struct kvm_vcpu *vcpu)
>  		 * MMU gets turned on and do the necessary cache maintenance
>  		 * then.
>  		 */
> -		vcpu->arch.hcr_el2 &= ~HCR_TVM;
> +		vcpu->arch.hcr_el2 |= HCR_TVM;
>  	}

Ouch, yes. That was as suggested for v1, and I missed it when saying my
R-B held. :(

Mark.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
