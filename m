Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4652FA1ED
	for <lists+kvmarm@lfdr.de>; Mon, 18 Jan 2021 14:44:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0CAEE4B2A1;
	Mon, 18 Jan 2021 08:44:13 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HjGBc-Xf1gWf; Mon, 18 Jan 2021 08:44:12 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A61834B279;
	Mon, 18 Jan 2021 08:44:11 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6F4CF4B1AB
 for <kvmarm@lists.cs.columbia.edu>; Mon, 18 Jan 2021 08:44:10 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ldsHDFf5Ocnl for <kvmarm@lists.cs.columbia.edu>;
 Mon, 18 Jan 2021 08:44:09 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 0529F4B13A
 for <kvmarm@lists.cs.columbia.edu>; Mon, 18 Jan 2021 08:44:08 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B68C420E65;
 Mon, 18 Jan 2021 13:44:07 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1l1UpB-008VJT-Ih; Mon, 18 Jan 2021 13:44:05 +0000
MIME-Version: 1.0
Date: Mon, 18 Jan 2021 13:44:05 +0000
From: Marc Zyngier <maz@kernel.org>
To: Jianyong Wu <Jianyong.Wu@arm.com>
Subject: Re: [PATCH] arm64/kvm: correct the error report in
 kvm_handle_guest_abort
In-Reply-To: <VE1PR08MB4766C8FE66A84082326A4090F4A40@VE1PR08MB4766.eurprd08.prod.outlook.com>
References: <20210115093028.6504-1-jianyong.wu@arm.com>
 <6f5a2ce458e33f879635f45140293517@kernel.org>
 <VE1PR08MB47664805860F1156223A7615F4A60@VE1PR08MB4766.eurprd08.prod.outlook.com>
 <VE1PR08MB47669476FED079360D67B5FEF4A40@VE1PR08MB4766.eurprd08.prod.outlook.com>
 <31dd6e2f8b3980337c8093d2ab626636@kernel.org>
 <VE1PR08MB4766C8FE66A84082326A4090F4A40@VE1PR08MB4766.eurprd08.prod.outlook.com>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <f612e22b00f32a4de9dcfeafd7c441a2@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: Jianyong.Wu@arm.com, Justin.He@arm.com, nd@arm.com,
 will@kernel.org, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: will@kernel.org, nd <nd@arm.com>, Justin He <Justin.He@arm.com>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On 2021-01-18 13:38, Jianyong Wu wrote:
>> -----Original Message-----
>> From: Marc Zyngier <maz@kernel.org>
>> Sent: Monday, January 18, 2021 9:26 PM
>> To: Jianyong Wu <Jianyong.Wu@arm.com>
>> Cc: Justin He <Justin.He@arm.com>; nd <nd@arm.com>; will@kernel.org;
>> kvmarm@lists.cs.columbia.edu; linux-arm-kernel@lists.infradead.org
>> Subject: Re: [PATCH] arm64/kvm: correct the error report in
>> kvm_handle_guest_abort
>> 
>> On 2021-01-18 13:04, Jianyong Wu wrote:
>> > Hi Marc,
>> >
>> >> -----Original Message-----
>> >> From: kvmarm-bounces@lists.cs.columbia.edu <kvmarm-
>> >> bounces@lists.cs.columbia.edu> On Behalf Of Jianyong Wu
>> >> Sent: Saturday, January 16, 2021 4:47 PM
>> >> To: Marc Zyngier <maz@kernel.org>
>> >> Cc: Justin He <Justin.He@arm.com>; nd <nd@arm.com>; will@kernel.org;
>> >> kvmarm@lists.cs.columbia.edu; linux-arm-kernel@lists.infradead.org
>> >> Subject: RE: [PATCH] arm64/kvm: correct the error report in
>> >> kvm_handle_guest_abort
>> >>
>> >> Hi Marc,
>> >>
>> >> > -----Original Message-----
>> >> > From: Marc Zyngier <maz@kernel.org>
>> >> > Sent: Friday, January 15, 2021 7:21 PM
>> >> > To: Jianyong Wu <Jianyong.Wu@arm.com>
>> >> > Cc: James Morse <James.Morse@arm.com>; will@kernel.org; Suzuki
>> >> Poulose
>> >> > <Suzuki.Poulose@arm.com>; linux-arm-kernel@lists.infradead.org;
>> >> > kvmarm@lists.cs.columbia.edu; Steve Capper
>> <Steve.Capper@arm.com>;
>> >> > Justin He <Justin.He@arm.com>; nd <nd@arm.com>
>> >> > Subject: Re: [PATCH] arm64/kvm: correct the error report in
>> >> > kvm_handle_guest_abort
>> >> >
>> >> > On 2021-01-15 09:30, Jianyong Wu wrote:
>> >> > > Currently, error report when cache maintenance at read-only
>> >> > > memory range, like rom, is not clear enough and even not correct.
>> >> > > As the specific error is definitely known by kvm, it is obliged
>> >> > > to give it out.
>> >> > >
>> >> > > Fox example, in a qemu/kvm VM, if the guest do dc at the pflash
>> >> > > range from
>> >> > > 0 to 128M, error is reported by kvm as "Data abort outside
>> >> > > memslots with no valid syndrome info" which is not quite correct.
>> >> > >
>> >> > > Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>
>> >> > > ---
>> >> > >  arch/arm64/kvm/mmu.c | 12 +++++++++---
>> >> > >  1 file changed, 9 insertions(+), 3 deletions(-)
>> >> > >
>> >> > > diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c index
>> >> > > 7d2257cc5438..de66b7e38a5b 100644
>> >> > > --- a/arch/arm64/kvm/mmu.c
>> >> > > +++ b/arch/arm64/kvm/mmu.c
>> >> > > @@ -1022,9 +1022,15 @@ int kvm_handle_guest_abort(struct
>> kvm_vcpu
>> >> > > *vcpu)
>> >> > >  		 * So let's assume that the guest is just being
>> >> > >  		 * cautious, and skip the instruction.
>> >> > >  		 */
>> >> > > -		if (kvm_is_error_hva(hva) && kvm_vcpu_dabt_is_cm(vcpu))
>> >> > {
>> >> > > -			kvm_incr_pc(vcpu);
>> >> > > -			ret = 1;
>> >> > > +		if (kvm_vcpu_dabt_is_cm(vcpu)) {
>> >> > > +			if (kvm_is_error_hva(hva)) {
>> >> > > +				kvm_incr_pc(vcpu);
>> >> > > +				ret = 1;
>> >> > > +				goto out_unlock;
>> >> > > +			}
>> >> > > +
>> >> > > +			kvm_err("Do cache maintenance in the read-
>> only
>> >> > memory range\n");
>> >> >
>> >> > We don't scream on the console for guests bugs.
>> >> Ok
>> >>
>> >> >
>> >> > > +			ret = -EFAULT;
>> >> > >  			goto out_unlock;
>> >> > >  		}
>> >> >
>> >> > And what is userspace going to do with that? To be honest, I'd
>> >> > rather not report it in any case:
>> >> >
>> >> > - either it isn't mapped, and there is no cache to clean/invalidate
>> >> > - or it is mapped read-only:
>> >> >    - if it is a "DC IVAC", the guest should get the fault as per
>> >> >      the ARM ARM. But I don't think we can identify the particular CMO
>> >> >      at this stage, so actually performing an invalidation is the least
>> >> >      bad thing to do.
>> >> >
>> >> > How about this (untested)?
>> >
>> > I have tested for this. It works that DC ops can pass on memory range
>> > for rom. But there is performance issue. It takes too long a time that
>> > do DC on rom range compared with on  normal memory range. Here is
>> some
>> > data:
>> > Ops                  memory type                                size
>> >                   time
>> > dc civac         rom memory                                128M
>> >        6700ms;
>> > dc civac       writable normal memory             128M
>> > 300ms;
>> >
>> > It's a single thread test and may be worse on multi thread. I'm not
>> > sure we can bear it. WDYT?
>> 
>> The problem is that the guest is invalidating one cache-line at a 
>> time, but we
>> invalidate 128M at a time in your example.
>> 
>> I would say that I really don't care how slow it is. We cannot know 
>> which
>> address the guest is trying to invalidate (as your commit message 
>> shows,
>> there is no syndrome information available).
>> 
>> So it seems our only choices are:
>> - don't do any invalidation, which is likely to break the guest
>> - invalidate everything, always
>> 
>> Given that, I'd rather have a slow guest. Also, it very much looks 
>> like no
>> existing SW does this, so I cannot say I care much.
> 
> OK, get it.

Actually, there could be a way to make this a bit faster. Once we have
cleaned+invalidated the memslot, we could unmap it, speeding up the
following cache invalidations (nothing will be mapped).

Could you please share your test case?

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
