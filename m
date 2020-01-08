Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0414B134214
	for <lists+kvmarm@lfdr.de>; Wed,  8 Jan 2020 13:44:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8D2494B07F;
	Wed,  8 Jan 2020 07:44:42 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hpFSyiGVB6LT; Wed,  8 Jan 2020 07:44:42 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1BDBB4B07A;
	Wed,  8 Jan 2020 07:44:41 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3B7E24B062
 for <kvmarm@lists.cs.columbia.edu>; Wed,  8 Jan 2020 07:44:40 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FAdgsfAjyImb for <kvmarm@lists.cs.columbia.edu>;
 Wed,  8 Jan 2020 07:44:38 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C545A4AFE9
 for <kvmarm@lists.cs.columbia.edu>; Wed,  8 Jan 2020 07:44:38 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 658EE31B;
 Wed,  8 Jan 2020 04:44:38 -0800 (PST)
Received: from [10.1.196.63] (e123195-lin.cambridge.arm.com [10.1.196.63])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 947923F703;
 Wed,  8 Jan 2020 04:44:36 -0800 (PST)
Subject: Re: [PATCH 1/3] KVM: arm64: correct PSTATE on exception entry
To: Mark Rutland <mark.rutland@arm.com>
References: <20191220150549.31948-1-mark.rutland@arm.com>
 <20191220150549.31948-2-mark.rutland@arm.com>
 <bace4197-a723-5312-3990-84232aab30d9@arm.com>
 <20200108111253.GA49203@lakrids.cambridge.arm.com>
From: Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <4be2f666-1139-0087-a69e-f8b779e71e11@arm.com>
Date: Wed, 8 Jan 2020 12:44:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200108111253.GA49203@lakrids.cambridge.arm.com>
Content-Language: en-US
Cc: maz@kernel.org, stable@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

Hi,

On 1/8/20 11:12 AM, Mark Rutland wrote:
> Hi Alex,
>
> On Fri, Dec 27, 2019 at 01:01:57PM +0000, Alexandru Elisei wrote:
>> On 12/20/19 3:05 PM, Mark Rutland wrote:
>>> When KVM injects an exception into a guest, it generates the PSTATE
>>> value from scratch, configuring PSTATE.{M[4:0],DAIF}, and setting all
>>> other bits to zero.
>>>
>>> This isn't correct, as the architecture specifies that some PSTATE bits
>>> are (conditionally) cleared or set upon an exception, and others are
>>> unchanged from the original context.
>>>
>>> This patch adds logic to match the architectural behaviour. To make this
>>> simple to follow/audit/extend, documentation references are provided,
>>> and bits are configured in order of their layout in SPSR_EL2. This
>>> layout can be seen in the diagram on ARM DDI 0487E.a page C5-429.
>>> +/*
>>> + * When an exception is taken, most PSTATE fields are left unchanged in the
>>> + * handler. However, some are explicitly overridden (e.g. M[4:0]). Luckily all
>>> + * of the inherited bits have the same position in the AArch64/AArch32 SPSR_ELx
>>> + * layouts, so we don't need to shuffle these for exceptions from AArch32 EL0.
>>> + *
>>> + * For the SPSR_ELx layout for AArch64, see ARM DDI 0487E.a page C5-429.
>>> + * For the SPSR_ELx layout for AArch32, see ARM DDI 0487E.a page C5-426.
>> The commit message mentions only the SPSR_ELx layout for AArch64.
> That was intentional; there I was only providing rationale for how to
> review the patch...
>
>>> + * Here we manipulate the fields in order of the AArch64 SPSR_ELx layout, from
>>> + * MSB to LSB.
> ... as also commented here.
>
> I can drop the reference from the commit message, if that's confusing?

It's fine as it is, no need to change it.

>
>>> + */
>>> +static unsigned long get_except64_pstate(struct kvm_vcpu *vcpu)
>>> +{
>>> +	unsigned long sctlr = vcpu_read_sys_reg(vcpu, SCTLR_EL1);
>>> +	unsigned long old, new;
>>> +
>>> +	old = *vcpu_cpsr(vcpu);
>>> +	new = 0;
>>> +
>>> +	new |= (old & PSR_N_BIT);
>>> +	new |= (old & PSR_Z_BIT);
>>> +	new |= (old & PSR_C_BIT);
>>> +	new |= (old & PSR_V_BIT);
>>> +
>>> +	// TODO: TCO (if/when ARMv8.5-MemTag is exposed to guests)
>>> +
>>> +	new |= (old & PSR_DIT_BIT);
>>> +
>>> +	// PSTATE.UAO is set to zero upon any exception to AArch64
>>> +	// See ARM DDI 0487E.a, page D5-2579.
>>> +
>>> +	// PSTATE.PAN is unchanged unless overridden by SCTLR_ELx.SPAN
>>> +	// See ARM DDI 0487E.a, page D5-2578.
>>> +	new |= (old & PSR_PAN_BIT);
>>> +	if (sctlr & SCTLR_EL1_SPAN)
>>> +		new |= PSR_PAN_BIT;
>> On page D13-3264, it is stated that the PAN bit is set unconditionally if
>> SCTLR_EL1.SPAN is clear, not set.
> very good spot, and that's a much better reference. 
>
> I had mistakenly assumed SPAN took effect when 0b1, since it wasn't
> called nSPAN, and page D5-2578 doesn't mention the polarity of the bit:
>
> | When ARMv8.1-PAN is implemented, the SCTLR_EL1.SPAN and SCTLR_EL2.SPAN
> | bits are used to control whether the PAN bit is set on an exception to
> | EL1 or EL2. 
>
> I've updated this to be:
>
> |	// PSTATE.PAN is unchanged unless SCTLR_ELx.SPAN == 0b0
> |	// SCTLR_ELx.SPAN is RES1 when ARMv8.1-PAN is not implemented
> |	// See ARM DDI 0487E.a, page D13-3264.
> |	new |= (old & PSR_PAN_BIT);
> |	if (!(sctlr & SCTLR_EL1_SPAN))
> |		new |= PSR_PAN_BIT;

Looks good.

>
> [...]
>
>> I've also checked the ARM ARM pages mentioned in the comments, and the
>> references are correct. The SPSR_EL2 layouts for exceptions taken from AArch64,
>> respectively AArch32, states are compatible with the way we create the SPSR_EL2
>> that will be used for eret'ing to the guest, just like the comment says.
> Thanks for confirming this!
>  
>> I have a suggestion. I think that in ARM ARM, shuffling things between sections
>> happens a lot less often than adding/removing things from one particular
>> section, so the pages referenced are more likely to change in later versions.
>> How about referencing the section instead of the exact page? Something like:
>> "This layout can be seen in the diagram on ARM DDI 0487E.a, section C5.2.18,
>> when an exception is taken from AArch64 state"?
> I did something like that initially, but the comments got very verbose,
> and so I moved to doc + page/section numbers alone.
>
> The section numbers and headings also vary between revisions of the ARM
> ARM, so I'd prefer to leave this as-is for now. I think it's always
> going to be necessary to look at the referenced version of the ARM ARM
> (in addition to a subsequent revision when updating things).

Makes sense.

Thanks,
Alex
>
> Thanks,
> Mark
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
