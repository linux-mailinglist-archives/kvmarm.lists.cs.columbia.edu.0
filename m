Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC2216163A
	for <lists+kvmarm@lfdr.de>; Mon, 17 Feb 2020 16:33:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B47754AF0E;
	Mon, 17 Feb 2020 10:33:27 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9jz5+QpAKwy6; Mon, 17 Feb 2020 10:33:27 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 77D074AF46;
	Mon, 17 Feb 2020 10:33:26 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 764D44AF37
 for <kvmarm@lists.cs.columbia.edu>; Mon, 17 Feb 2020 10:33:25 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NgE74xGNW-CC for <kvmarm@lists.cs.columbia.edu>;
 Mon, 17 Feb 2020 10:33:24 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 347164AF10
 for <kvmarm@lists.cs.columbia.edu>; Mon, 17 Feb 2020 10:33:24 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8BDD30E;
 Mon, 17 Feb 2020 07:33:23 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE7333F703;
 Mon, 17 Feb 2020 07:33:22 -0800 (PST)
Subject: Re: [PATCH 1/2] KVM: arm64: Add PMU event filtering infrastructure
To: Marc Zyngier <maz@kernel.org>
References: <20200214183615.25498-1-maz@kernel.org>
 <20200214183615.25498-2-maz@kernel.org>
 <ac2a8a87-3a90-1abb-30a5-00c20667cd14@arm.com> <868sl46t60.wl-maz@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <5d7a2907-f12c-0add-c020-c927aad50feb@arm.com>
Date: Mon, 17 Feb 2020 15:33:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <868sl46t60.wl-maz@kernel.org>
Content-Language: en-GB
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

On 15/02/2020 10:28 am, Marc Zyngier wrote:
> On Fri, 14 Feb 2020 22:01:01 +0000,
> Robin Murphy <robin.murphy@arm.com> wrote:
> 
> Hi Robin,
> 
>>
>> Hi Marc,
>>
>> On 2020-02-14 6:36 pm, Marc Zyngier wrote:
>> [...]
>>> @@ -585,6 +585,14 @@ static void kvm_pmu_create_perf_event(struct kvm_vcpu *vcpu, u64 select_idx)
>>>    	    pmc->idx != ARMV8_PMU_CYCLE_IDX)
>>>    		return;
>>>    +	/*
>>> +	 * If we have a filter in place and that the event isn't allowed, do
>>> +	 * not install a perf event either.
>>> +	 */
>>> +	if (vcpu->kvm->arch.pmu_filter &&
>>> +	    !test_bit(eventsel, vcpu->kvm->arch.pmu_filter))
>>> +		return;
>>
>> If I'm reading the derivation of eventsel right, this will end up
>> treating cycle counter events (aliased to SW_INCR) differently from
>> CPU_CYCLES, which doesn't seem desirable.
> 
> Indeed, this doesn't look quite right.
> 
> Looking at the description of event 0x11, it doesn't seem to count
> exactly like the cycle counter (there are a number of PMCR controls
> affecting it). But none of these actually apply to our PMU emulation
> (no secure mode, and the idea of dealing with virtual EL2 in the
> context of the PMU is... not appealing).
> 
> Now, given that we implement the cycle counter with event 0x11 anyway,
> I don't think there is any reason to deal with them separately.

Right, from the user's PoV they can only ask for event 0x11, and where 
it gets scheduled is more of a black-box implementation detail. Reading 
the Arm ARM doesn't leave me entirely convinced that cycles couldn't 
ever leak idle/not-idle information between closely-coupled PEs, so this 
might not be entirely academic.

>> Also, if the user did try to blacklist SW_INCR for ridiculous
>> reasons, we'd need to special-case kvm_pmu_software_increment() to
>> make it (not) work as expected, right?
> 
> I thought of that one, and couldn't see a reason to blacklist it
> (after all, the guest could also increment a variable) and send itself
> an interrupt. I'm tempted to simply document that event 0 is never
> filtered.

I'd say you're on even stronger ground simply because KVM's 
implementation of SW_INCR doesn't go near the PMU hardware at all, thus 
is well beyond the purpose of the blacklist anyway. I believe it's 
important that how the code behaves matches expectations, but there's no 
harm in changing the latter as appropriate ;)

Cheers,
Robin.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
