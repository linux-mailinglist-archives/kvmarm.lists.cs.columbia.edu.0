Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id AC390161903
	for <lists+kvmarm@lfdr.de>; Mon, 17 Feb 2020 18:43:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1AADB4AF4D;
	Mon, 17 Feb 2020 12:43:22 -0500 (EST)
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
	with ESMTP id DBwioUd+LjoG; Mon, 17 Feb 2020 12:43:21 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C03984AF30;
	Mon, 17 Feb 2020 12:43:20 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B1AE14AF26
 for <kvmarm@lists.cs.columbia.edu>; Mon, 17 Feb 2020 12:43:19 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8jyjxnB2yY6m for <kvmarm@lists.cs.columbia.edu>;
 Mon, 17 Feb 2020 12:43:18 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 5AA744A830
 for <kvmarm@lists.cs.columbia.edu>; Mon, 17 Feb 2020 12:43:18 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3535420725;
 Mon, 17 Feb 2020 17:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581961397;
 bh=lPr9M38+t5sBMw6u5u7ZBlJacBz/RdUPLYWWMEb5nNk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=tVe05Pq6lqr4xtBpglJlPSurnLCwFA+rJdqpQZJ4DlhZQQZOrU/R/SeCPdQ+BFakp
 Ys32tvVejNhf5kOIa7yEQSSK1enWtUna1CieWb5rv+lvVLj484mHd4XD1vtZSj+Dhv
 9RFZ4vr78BmGKFJX7E7dV67+fAnuYn03nZO/mzfc=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1j3kQN-005yzm-KA; Mon, 17 Feb 2020 17:43:15 +0000
MIME-Version: 1.0
Date: Mon, 17 Feb 2020 17:43:15 +0000
From: Marc Zyngier <maz@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 12/94] KVM: arm64: nv: Add EL2->EL1 translation helpers
In-Reply-To: <20200217145630.GD47755@lakrids.cambridge.arm.com>
References: <20200211174938.27809-1-maz@kernel.org>
 <20200211174938.27809-13-maz@kernel.org>
 <20200217145630.GD47755@lakrids.cambridge.arm.com>
Message-ID: <97f6387adfec3b96182908f3d8f074ae@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, andre.przywara@arm.com,
 Dave.Martin@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Andre Przywara <andre.przywara@arm.com>, Dave Martin <Dave.Martin@arm.com>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

Hi Mark,

Congratulations, you will now be CC'd on all the subsequent postings
of this series! Yes, I'm that nice! ;-)

On 2020-02-17 14:56, Mark Rutland wrote:
> On Tue, Feb 11, 2020 at 05:48:16PM +0000, Marc Zyngier wrote:
>> Some EL2 system registers immediately affect the current execution
>> of the system, so we need to use their respective EL1 counterparts.
>> For this we need to define a mapping between the two.
>> 
>> These helpers will get used in subsequent patches.
>> 
>> Co-developed-by: Andre Przywara <andre.przywara@arm.com>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> ---
>>  arch/arm64/include/asm/kvm_emulate.h |  6 ++++
>>  arch/arm64/kvm/sys_regs.c            | 48 
>> ++++++++++++++++++++++++++++
>>  2 files changed, 54 insertions(+)
>> 
>> diff --git a/arch/arm64/include/asm/kvm_emulate.h 
>> b/arch/arm64/include/asm/kvm_emulate.h
>> index 282e9ddbe1bc..486978d0346b 100644
>> --- a/arch/arm64/include/asm/kvm_emulate.h
>> +++ b/arch/arm64/include/asm/kvm_emulate.h
>> @@ -58,6 +58,12 @@ void kvm_emulate_nested_eret(struct kvm_vcpu 
>> *vcpu);
>>  int kvm_inject_nested_sync(struct kvm_vcpu *vcpu, u64 esr_el2);
>>  int kvm_inject_nested_irq(struct kvm_vcpu *vcpu);
>> 
>> +u64 translate_tcr(u64 tcr);
>> +u64 translate_cptr(u64 tcr);
>> +u64 translate_sctlr(u64 tcr);
>> +u64 translate_ttbr0(u64 tcr);
>> +u64 translate_cnthctl(u64 tcr);
> 
> Sorry to bikeshed, but could we please make the direction of 
> translation
> explicit in the name? e.g. tcr_el2_to_tcr_el1(), or tcr_el2_to_el1()?

Sure, that's an easy one!

> 
>> +
>>  static inline bool vcpu_el1_is_32bit(struct kvm_vcpu *vcpu)
>>  {
>>  	return !(vcpu->arch.hcr_el2 & HCR_RW);
>> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>> index 4b5310ea3bf8..634d3ee6799c 100644
>> --- a/arch/arm64/kvm/sys_regs.c
>> +++ b/arch/arm64/kvm/sys_regs.c
>> @@ -65,6 +65,54 @@ static bool write_to_read_only(struct kvm_vcpu 
>> *vcpu,
>>  	return false;
>>  }
>> 
>> +static u64 tcr_el2_ips_to_tcr_el1_ps(u64 tcr_el2)
>> +{
>> +	return ((tcr_el2 & TCR_EL2_PS_MASK) >> TCR_EL2_PS_SHIFT)
>> +		<< TCR_IPS_SHIFT;
>> +}
>> +
>> +u64 translate_tcr(u64 tcr)
>> +{
>> +	return TCR_EPD1_MASK |				/* disable TTBR1_EL1 */
>> +	       ((tcr & TCR_EL2_TBI) ? TCR_TBI0 : 0) |
>> +	       tcr_el2_ips_to_tcr_el1_ps(tcr) |
>> +	       (tcr & TCR_EL2_TG0_MASK) |
>> +	       (tcr & TCR_EL2_ORGN0_MASK) |
>> +	       (tcr & TCR_EL2_IRGN0_MASK) |
>> +	       (tcr & TCR_EL2_T0SZ_MASK);
>> +}
> 
> I'm guessing this is only meant to cover a !VHE guest EL2 for the
> moment, so only covers HCR_EL2.E2H=0? It might be worth mentioning in
> the commit message.

Indeed, all the "translate_*" function have a single purpose: converting
an !VHE EL2 layout into an EL1 layout.

> It looks like this is missing some bits (e.g. TBID, HPD, HD, HA) that
> could apply to the Guest-EL2 Stage-1. Maybe those are added by later
> patches, but that's not obvious to me at this point in the series.

ARMv8.3-PAUTH isn't supported, and ARMv8.1-TTHM cannot be supported at
Stage-2, so we don't support it at Stage-1 either (even if we 
technically
could). Maybe worth suggesting to the powers that be...

ARMv8.1-HPD is an oversight though, and we should be able to support it.

> 
>> +
>> +u64 translate_cptr(u64 cptr_el2)
>> +{
>> +	u64 cpacr_el1 = 0;
>> +
>> +	if (!(cptr_el2 & CPTR_EL2_TFP))
>> +		cpacr_el1 |= CPACR_EL1_FPEN;
>> +	if (cptr_el2 & CPTR_EL2_TTA)
>> +		cpacr_el1 |= CPACR_EL1_TTA;
>> +	if (!(cptr_el2 & CPTR_EL2_TZ))
>> +		cpacr_el1 |= CPACR_EL1_ZEN;
>> +
>> +	return cpacr_el1;
>> +}
> 
> Looking in ARM DDI 0487E.a I also see TCPAC and TAM; I guess we don't
> need to map those to anthing?

TCPAC allows us to trap CPACR_EL1, but we always have the physical
CPTR_EL2.TCPAC set in this case, so that bit doesn't need to translate
into anything.

TAM doesn't seem to translate into anything in CPACR_EL1, and I don't
plan to support the AMU any time soon with NV! ;-)

> 
>> +
>> +u64 translate_sctlr(u64 sctlr)
>> +{
>> +	/* Bit 20 is RES1 in SCTLR_EL1, but RES0 in SCTLR_EL2 */
>> +	return sctlr | BIT(20);
>> +}
> 
> Looking in ARM DDI 0487E.a section D13.2.105, bit 20 is TSCXT, so this
> might need to be reconsidered.

Huhuh, nice catch! We need to detect ARMv8.0-CSV2 here, and set the bit
accordingly.

> 
>> +
>> +u64 translate_ttbr0(u64 ttbr0)
>> +{
>> +	/* Force ASID to 0 (ASID 0 or RES0) */
>> +	return ttbr0 & ~GENMASK_ULL(63, 48);
>> +}
> 
> Again, I assume this is only meant to provide a !VHE EL2 as this 
> stands.

Indeed. I guess I need to write a better commit message to make this 
clear.

> 
>> +
>> +u64 translate_cnthctl(u64 cnthctl)
>> +{
>> +	return ((cnthctl & 0x3) << 10) | (cnthctl & 0xfc);
>> +}
> 
> I assume this yields CNTKCTL_EL1, but I don't entirely follow. For
> virtual-EL2 don't we have to force EL1P(C)TEN so that virtual-EL2
> accesses don't trap?

A non-VHE guest will use the _EL2 instructions to access its own timer,
which will trap. At the same time, we use the EL1 timer to implement
the vEL2 timer, meaning we also need to trap the EL1 timer. Yes, !VHE
looses on all fronts.

We could treat !VHE specially in the wap we map timers (complete 
emulation
for vEL2, and direct access for guest timers). But this seems pretty
complex for very little gain.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
