Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2B01D1BF861
	for <lists+kvmarm@lfdr.de>; Thu, 30 Apr 2020 14:45:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8ACEB4B450;
	Thu, 30 Apr 2020 08:45:58 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id krAzoo84oZYM; Thu, 30 Apr 2020 08:45:58 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2C3034B44D;
	Thu, 30 Apr 2020 08:45:57 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 315D44B3E0
 for <kvmarm@lists.cs.columbia.edu>; Thu, 30 Apr 2020 08:45:56 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ch3EAM744v10 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 30 Apr 2020 08:45:55 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 078994B3D8
 for <kvmarm@lists.cs.columbia.edu>; Thu, 30 Apr 2020 08:45:55 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B533B205ED;
 Thu, 30 Apr 2020 12:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588250753;
 bh=zc3JaJmBWam2fMuCXHmaLPhGYq0c/2wb8dNG5ZJxYjY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=SrSWBQ6/k8OapgpOLCoiM+liIHO6EsmvBRD1hgViJ9NLdalanmfu1pxx3VHLv7s9X
 0Fgeyqk3gQ5TTsfP14dmOfXb8Z3NBuCu4vZReB4UTcU4qp8zLmqWpsLT4/kRktDDWP
 9SotYYwXonLcbgVKfayQHS+n5UNfN8pvpT637B6M=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jU8Zb-0081rl-W3; Thu, 30 Apr 2020 13:45:52 +0100
MIME-Version: 1.0
Date: Thu, 30 Apr 2020 13:45:51 +0100
From: Marc Zyngier <maz@kernel.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH] KVM: arm64: Fix 32bit PC wrap-around
In-Reply-To: <20200430123104.GB22842@willie-the-truck>
References: <20200430101513.318541-1-maz@kernel.org>
 <20200430102556.GE19932@willie-the-truck>
 <897baec2a3fad776716bccf3027340fa@kernel.org>
 <20200430123104.GB22842@willie-the-truck>
User-Agent: Roundcube Webmail/1.4.3
Message-ID: <1c0175a09a90d2b7c0243e5bcec7cc9a@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: will@kernel.org, linux-arm-kernel@lists.infradead.org,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, james.morse@arm.com,
 julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On 2020-04-30 13:31, Will Deacon wrote:
> On Thu, Apr 30, 2020 at 11:59:05AM +0100, Marc Zyngier wrote:
>> On 2020-04-30 11:25, Will Deacon wrote:
>> > On Thu, Apr 30, 2020 at 11:15:13AM +0100, Marc Zyngier wrote:
>> > > In the unlikely event that a 32bit vcpu traps into the hypervisor
>> > > on an instruction that is located right at the end of the 32bit
>> > > range, the emulation of that instruction is going to increment
>> > > PC past the 32bit range. This isn't great, as userspace can then
>> > > observe this value and get a bit confused.
>> > >
>> > > Conversly, userspace can do things like (in the context of a 64bit
>> > > guest that is capable of 32bit EL0) setting PSTATE to AArch64-EL0,
>> > > set PC to a 64bit value, change PSTATE to AArch32-USR, and observe
>> > > that PC hasn't been truncated. More confusion.
>> > >
>> > > Fix both by:
>> > > - truncating PC increments for 32bit guests
>> > > - sanitize PC every time a core reg is changed by userspace, and
>> > >   that PSTATE indicates a 32bit mode.
>> >
>> > It's not clear to me whether this needs a cc stable. What do you think?
>> > I
>> > suppose that it really depends on how confused e.g. QEMU gets.
>> 
>> It isn't so much QEMU itself that I'm worried about (the emulation 
>> shouldn't
>> really care about the PC), but the likes of GDB. So yes, a cc stable 
>> seems
>> to
>> be in order.
> 
> Okey doke.
> 
>> > > Signed-off-by: Marc Zyngier <maz@kernel.org>
>> > > ---
>> > >  arch/arm64/kvm/guest.c     | 4 ++++
>> > >  virt/kvm/arm/hyp/aarch32.c | 8 ++++++--
>> > >  2 files changed, 10 insertions(+), 2 deletions(-)
>> > >
>> > > diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
>> > > index 23ebe51410f0..2a159af82429 100644
>> > > --- a/arch/arm64/kvm/guest.c
>> > > +++ b/arch/arm64/kvm/guest.c
>> > > @@ -200,6 +200,10 @@ static int set_core_reg(struct kvm_vcpu *vcpu,
>> > > const struct kvm_one_reg *reg)
>> > >  	}
>> > >
>> > >  	memcpy((u32 *)regs + off, valp, KVM_REG_SIZE(reg->id));
>> > > +
>> > > +	if (*vcpu_cpsr(vcpu) & PSR_AA32_MODE_MASK)
>> > > +		*vcpu_pc(vcpu) = lower_32_bits(*vcpu_pc(vcpu));
>> >
>> > It seems slightly odd to me that we don't enforce this for *all* the
>> > registers when running as a 32-bit guest. Couldn't userspace be equally
>> > confused by a 64-bit lr or sp?
>> 
>> Fair point. How about this on top, which wipes the upper 32 bits for
>> each and every register in the current mode:
>> 
>> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
>> index 2a159af82429..f958c3c7bf65 100644
>> --- a/arch/arm64/kvm/guest.c
>> +++ b/arch/arm64/kvm/guest.c
>> @@ -201,9 +201,12 @@ static int set_core_reg(struct kvm_vcpu *vcpu, 
>> const
>> struct kvm_one_reg *reg)
>> 
>>  	memcpy((u32 *)regs + off, valp, KVM_REG_SIZE(reg->id));
>> 
>> -	if (*vcpu_cpsr(vcpu) & PSR_AA32_MODE_MASK)
>> -		*vcpu_pc(vcpu) = lower_32_bits(*vcpu_pc(vcpu));
>> +	if (*vcpu_cpsr(vcpu) & PSR_AA32_MODE_MASK) {
>> +		int i;
>> 
>> +		for (i = 0; i < 16; i++)
>> +			*vcpu_reg32(vcpu, i) = (u32)*vcpu_reg32(vcpu, i);
> 
> I think you're missing all the funny banked registers that live all the 
> way
> up to x30 iirc.

No, they are all indirected via vcpu_reg32(), which has the magic 
tables.
And the whole point is that we only want to affect the current mode (no 
point
in repainting the FIQ registers if the PSR says USR).

Or am I missing something obvious?

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
