Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 99CB4652EA5
	for <lists+kvmarm@lfdr.de>; Wed, 21 Dec 2022 10:35:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9587B4B63F;
	Wed, 21 Dec 2022 04:35:14 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -6.789
X-Spam-Level: 
X-Spam-Status: No, score=-6.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, RCVD_IN_DNSWL_HI=-5, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lwvY8XgI6JVB; Wed, 21 Dec 2022 04:35:14 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 281194B639;
	Wed, 21 Dec 2022 04:35:13 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 14DE14B39B
 for <kvmarm@lists.cs.columbia.edu>; Wed, 21 Dec 2022 04:35:12 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nAfyKSS5tc9C for <kvmarm@lists.cs.columbia.edu>;
 Wed, 21 Dec 2022 04:35:10 -0500 (EST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9B2394B285
 for <kvmarm@lists.cs.columbia.edu>; Wed, 21 Dec 2022 04:35:10 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 794256172A;
 Wed, 21 Dec 2022 09:35:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9E35C433D2;
 Wed, 21 Dec 2022 09:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1671615308;
 bh=UUNY+TC8uH/w5Jhcrs2UNbTIXKI3gO1njZcObFLjccA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=JHHiYkJ+Su5hEWsch8CueGjPmBurDb2a2J3w996Qsd3OOVTJE7GDn/0/70rfyaKNL
 U0Gj2WnJogoVC2JquvVotR0utgZ+ricNT7jhAAWJPJngdlglwlB+6LzNB7QCC87bc+
 stH2wElrDv+6KUtlu5TuM+YAJwv9kgmU6W6Z3zi5/XemE5DNFs1+oR67h7K4ACkF+F
 gwjipq8AH8SmBxVPIM8gyqDbQc902fjjAZ1iaZ+NGSZCQrKyuE2S14zeqfmvxL5nzn
 nes6fP3HOCU7H0VXS7MIKSUMCf9+PGiq1vlMp6BFvmXcfvXbFC7t9yyD5siLr5cRfo
 cu321N5oyZ01w==
Received: from sofa.misterjones.org ([185.219.108.64]
 helo=goblin-girl.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <maz@kernel.org>) id 1p7vVC-00E7Dl-Ce;
 Wed, 21 Dec 2022 09:35:06 +0000
Date: Wed, 21 Dec 2022 09:35:06 +0000
Message-ID: <86pmcdaylx.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [PATCH 1/3] KVM: arm64: Fix S1PTW handling on RO memslots
In-Reply-To: <Y6IteDoK406o9pM+@google.com>
References: <20221220200923.1532710-1-maz@kernel.org>
 <20221220200923.1532710-2-maz@kernel.org>
 <Y6IteDoK406o9pM+@google.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/28.2
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: oliver.upton@linux.dev, kvmarm@lists.cs.columbia.edu,
 kvmarm@lists.linux.dev, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, james.morse@arm.com,
 suzuki.poulose@arm.com, alexandru.elisei@arm.com, ardb@kernel.org,
 will@kernel.org, qperret@google.com, stable@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, Will Deacon <will@kernel.org>, stable@vger.kernel.org,
 kvmarm@lists.linux.dev, kvmarm@lists.cs.columbia.edu,
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

On Tue, 20 Dec 2022 21:47:36 +0000,
Oliver Upton <oliver.upton@linux.dev> wrote:
> 
> Hi Marc,
> 
> On Tue, Dec 20, 2022 at 08:09:21PM +0000, Marc Zyngier wrote:
> > A recent development on the EFI front has resulted in guests having
> > their page tables baked in the firmware binary, and mapped into
> > the IPA space as part as a read-only memslot.
> 
> as part of a
> 
> > Not only this is legitimate, but it also results in added security,
> > so thumbs up. However, this clashes mildly with our handling of a S1PTW
> > as a write to correctly handle AF/DB updates to the S1 PTs, and results
> > in the guest taking an abort it won't recover from (the PTs mapping the
> > vectors will suffer freom the same problem...).
> 
> To be clear, the read-only page tables already have the AF set,
> right?  They certainly must, or else the guest isn't getting far :)

Yes, the guest definitely has the AF set in the PT, and is not trying
to use the HW-assisted AF (which obviously wouldn't work).

>
> I understand you're trying to describe _why_ we promote S1PTW to a
> write, but doing it inline with the context of the EFI issue makes
> it slightly unclear. Could you break these ideas up into two
> paragraphs and maybe spell out the fault conditions a bit more?
> 
>   A recent development on the EFI front has resulted in guests having
>   their page tables baked in the firmware binary, and mapped into the
>   IPA space as part of a read-only memslot. Not only is this legitimate,
>   but it also results in added security, so thumbs up.
> 
>   It is possible to take an S1PTW translation fault if the S1 PTs are
>   unmapped at stage-2. However, KVM unconditionally treats S1PTW as a
>   write to correctly handle hardware AF/DB updates to the S1 PTs.
>   Furthermore, KVM injects a data abort into the guest for S1PTW writes.
>   In the aforementioned case this results in the guest taking an abort
>   it won't recover from, as the S1 PTs mapping the vectors suffer from
>   the same problem.
> 
> Dunno, maybe I stink at reading which is why I got confused in the
> first place.

Nothing wrong with you, just that my write-up is indeed sloppy. I'll
copy paste the above, thanks!

> 
> > So clearly our handling is... wrong.
> > 
> > Instead, switch to a two-pronged approach:
> > 
> > - On S1PTW translation fault, handle the fault as a read
> > 
> > - On S1PTW permission fault, handle the fault as a write
> > 
> > This is of no consequence to SW that *writes* to its PTs (the write
> > will trigger a non-S1PTW fault), and SW that uses RO PTs will not
> > use AF/DB anyway, as that'd be wrong.
> > 
> > Only in the case described in c4ad98e4b72c ("KVM: arm64: Assume write
> > fault on S1PTW permission fault on instruction fetch") do we end-up
> > with two back-to-back faults (page being evicted and faulted back).
> > I don't think this is a case worth optimising for.
> > 
> > Fixes: c4ad98e4b72c ("KVM: arm64: Assume write fault on S1PTW permission fault on instruction fetch")
> > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > Cc: stable@vger.kernel.org
> > ---
> >  arch/arm64/include/asm/kvm_emulate.h | 22 ++++++++++++++++++++--
> >  1 file changed, 20 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
> > index 9bdba47f7e14..fd6ad8b21f85 100644
> > --- a/arch/arm64/include/asm/kvm_emulate.h
> > +++ b/arch/arm64/include/asm/kvm_emulate.h
> > @@ -373,8 +373,26 @@ static __always_inline int kvm_vcpu_sys_get_rt(struct kvm_vcpu *vcpu)
> >  
> >  static inline bool kvm_is_write_fault(struct kvm_vcpu *vcpu)
> >  {
> > -	if (kvm_vcpu_abt_iss1tw(vcpu))
> > -		return true;
> > +	if (kvm_vcpu_abt_iss1tw(vcpu)) {
> > +		/*
> > +		 * Only a permission fault on a S1PTW should be
> > +		 * considered as a write. Otherwise, page tables baked
> > +		 * in a read-only memslot will result in an exception
> > +		 * being delivered in the guest.
> 
> Somewhat of a tangent, but:
> 
> Aren't we somewhat unaligned with the KVM UAPI by injecting an
> exception in this case? I know we've been doing it for a while, but it
> flies in the face of the rules outlined in the
> KVM_SET_USER_MEMORY_REGION documentation.

That's an interesting point, and I certainly haven't considered that
for faults introduced by page table walks.

I'm not sure what userspace can do with that though. The problem is
that this is a write for which we don't have useful data: although we
know it is a page-table walker access, we don't know what it was about
to write. The instruction that caused the write is meaningless (it
could either be a load, a store, or an instruction fetch). How do you
populate the data[] field then?

If anything, this is closer to KVM_EXIT_ARM_NISV, for which we give
userspace the full ESR and ask it to sort it out. I doubt it will be
able to, but hey, maybe it is worth a shot. This would need to be a
different exit reason though, as NISV is explicitly for non-memslot
stuff.

In any case, the documentation for KVM_SET_USER_MEMORY_REGION needs to
reflect the fact that KVM_EXIT_MMIO cannot represent a fault due to a
S1 PTW.

>
> > +		 * The drawback is that we end-up fauling twice if the
> 
> typo: s/fauling/faulting/
> 
> > +		 * guest is using any of HW AF/DB: a translation fault
> > +		 * to map the page containing the PT (read only at
> > +		 * first), then a permission fault to allow the flags
> > +		 * to be set.
> > +		 */
> > +		switch (kvm_vcpu_trap_get_fault_type(vcpu)) {
> > +		case ESR_ELx_FSC_PERM:
> > +			return true;
> > +		default:
> > +			return false;
> > +		}
> > +	}
> >  
> >  	if (kvm_vcpu_trap_is_iabt(vcpu))
> >  		return false;
> > -- 
> > 2.34.1
> > 
> 
> Besides the changelog/comment suggestions, the patch looks good to me.
> 
> Reviewed-by: Oliver Upton <oliver.upton@linux.dev>

Thanks for the quick review! I'll wait a bit before respinning the
series, as I'd like to get closure on the UAPI point you have raised.

Cheers,

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
