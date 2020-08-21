Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1243624DEEA
	for <lists+kvmarm@lfdr.de>; Fri, 21 Aug 2020 19:51:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 95ACF4C5B6;
	Fri, 21 Aug 2020 13:51:27 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KYQU0GYA8L5L; Fri, 21 Aug 2020 13:51:27 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 41CFA4C55F;
	Fri, 21 Aug 2020 13:51:26 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B8CC04C551
 for <kvmarm@lists.cs.columbia.edu>; Fri, 21 Aug 2020 13:51:24 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6jLWHGa53OLg for <kvmarm@lists.cs.columbia.edu>;
 Fri, 21 Aug 2020 13:51:23 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 1DBDC4C4CB
 for <kvmarm@lists.cs.columbia.edu>; Fri, 21 Aug 2020 13:51:23 -0400 (EDT)
Received: from gaia (unknown [95.146.230.145])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 17E9520702;
 Fri, 21 Aug 2020 17:51:19 +0000 (UTC)
Date: Fri, 21 Aug 2020 18:51:16 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v4 3/3] arm64: Add workaround for Arm Cortex-A77 erratum
 1508412
Message-ID: <20200821175116.GE6823@gaia>
References: <20200803193127.3012242-1-robh@kernel.org>
 <20200803193127.3012242-4-robh@kernel.org>
 <20200821120659.GB6823@gaia>
 <20200821121209.GB20833@willie-the-truck>
 <20200821122633.GC6823@gaia>
 <8c641833ff20d5a35981c456d4fe1d5a@kernel.org>
 <20200821140525.GD6823@gaia>
 <4bc5ca546826da4682ec3b126052daea@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4bc5ca546826da4682ec3b126052daea@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Rob Herring <robh@kernel.org>, Will Deacon <will@kernel.org>,
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

On Fri, Aug 21, 2020 at 06:02:39PM +0100, Marc Zyngier wrote:
> On 2020-08-21 15:05, Catalin Marinas wrote:
> > On Fri, Aug 21, 2020 at 01:45:40PM +0100, Marc Zyngier wrote:
> > > On 2020-08-21 13:26, Catalin Marinas wrote:
> > > > On Fri, Aug 21, 2020 at 01:12:10PM +0100, Will Deacon wrote:
> > > > > On Fri, Aug 21, 2020 at 01:07:00PM +0100, Catalin Marinas wrote:
> > > > > > On Mon, Aug 03, 2020 at 01:31:27PM -0600, Rob Herring wrote:
> > > > > > > @@ -979,6 +980,14 @@
> > > > > > >  		write_sysreg(__scs_new, sysreg);			\
> > > > > > >  } while (0)
> > > > > > >
> > > > > > > +#define read_sysreg_par() ({						\
> > > > > > > +	u64 par;							\
> > > > > > > +	asm(ALTERNATIVE("nop", "dmb sy", ARM64_WORKAROUND_1508412));	\
> > > > > > > +	par = read_sysreg(par_el1);					\
> > > > > > > +	asm(ALTERNATIVE("nop", "dmb sy", ARM64_WORKAROUND_1508412));	\
> > > > > > > +	par;								\
> > > > > > > +})
> > > > > >
> > > > > > I was about to queue this up but one more point to clarify: can we get
> > > > > > an interrupt at either side of the PAR_EL1 read and the handler do a
> > > > > > device read, triggering the erratum? Do we need a DMB at exception
> > > > > > entry/return?
> > > > >
> > > > > Disabling irqs around the PAR access would be simpler, I think
> > > > > (assuming
> > > > > this is needed).
> > > >
> > > > This wouldn't work if it interrupts a guest.
> > > 
> > > If we take an interrupt either side of the PAR_EL1 read and that we
> > > fully exit, the saving of PAR_EL1 on the way out solves the problem.
> > > 
> > > If we don't fully exit, but instead reenter the guest immediately
> > > (fixup_guest_exit() returns true), we'd need a DMB at that point,
> > > at least because of the GICv2 proxying code which performs device
> > > accesses on the guest's behalf.
> > 
> > If you are ok with the diff below, I can fold it in:
> > 
> > diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h
> > b/arch/arm64/kvm/hyp/include/hyp/switch.h
> > index ca88ea416176..8770cf7ccd42 100644
> > --- a/arch/arm64/kvm/hyp/include/hyp/switch.h
> > +++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
> > @@ -420,7 +420,7 @@ static inline bool fixup_guest_exit(struct
> > kvm_vcpu *vcpu, u64 *exit_code)
> >  	if (cpus_have_final_cap(ARM64_WORKAROUND_CAVIUM_TX2_219_TVM) &&
> >  	    kvm_vcpu_trap_get_class(vcpu) == ESR_ELx_EC_SYS64 &&
> >  	    handle_tx2_tvm(vcpu))
> > -		return true;
> > +		goto guest;
> > 
> >  	/*
> >  	 * We trap the first access to the FP/SIMD to save the host context
> > @@ -430,13 +430,13 @@ static inline bool fixup_guest_exit(struct
> > kvm_vcpu *vcpu, u64 *exit_code)
> >  	 * Similarly for trapped SVE accesses.
> >  	 */
> >  	if (__hyp_handle_fpsimd(vcpu))
> > -		return true;
> > +		goto guest;
> > 
> >  	if (__hyp_handle_ptrauth(vcpu))
> > -		return true;
> > +		goto guest;
> > 
> >  	if (!__populate_fault_info(vcpu))
> > -		return true;
> > +		goto guest;
> > 
> >  	if (static_branch_unlikely(&vgic_v2_cpuif_trap)) {
> >  		bool valid;
> > @@ -451,7 +451,7 @@ static inline bool fixup_guest_exit(struct
> > kvm_vcpu *vcpu, u64 *exit_code)
> >  			int ret = __vgic_v2_perform_cpuif_access(vcpu);
> > 
> >  			if (ret == 1)
> > -				return true;
> > +				goto guest;
> > 
> >  			/* Promote an illegal access to an SError.*/
> >  			if (ret == -1)
> > @@ -467,12 +467,17 @@ static inline bool fixup_guest_exit(struct
> > kvm_vcpu *vcpu, u64 *exit_code)
> >  		int ret = __vgic_v3_perform_cpuif_access(vcpu);
> > 
> >  		if (ret == 1)
> > -			return true;
> > +			goto guest;
> >  	}
> > 
> >  exit:
> >  	/* Return to the host kernel and handle the exit */
> >  	return false;
> > +
> > +guest:
> > +	/* Re-enter the guest */
> > +	asm(ALTERNATIVE("nop", "dmb sy", ARM64_WORKAROUND_1508412));
> > +	return true;
> >  }
> > 
> >  static inline bool __needs_ssbd_off(struct kvm_vcpu *vcpu)
> 
> Looks good to me!

Thanks Marc. Since it needs the local_irq_save() around the PAR_EL1
access in read_sysreg_par(), I'll wait for Rob to update the patches.
Rob also asked the hardware guys for clarification on this scenario, so
let's see what they reply.

-- 
Catalin
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
