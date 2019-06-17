Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4C61848902
	for <lists+kvmarm@lfdr.de>; Mon, 17 Jun 2019 18:33:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D35224A4FF;
	Mon, 17 Jun 2019 12:33:48 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FCh6q9TO6ExE; Mon, 17 Jun 2019 12:33:48 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8F9984A512;
	Mon, 17 Jun 2019 12:33:47 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 477EE4A50C
 for <kvmarm@lists.cs.columbia.edu>; Mon, 17 Jun 2019 12:33:46 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H-HYbNUkZQUz for <kvmarm@lists.cs.columbia.edu>;
 Mon, 17 Jun 2019 12:33:45 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E8D8A4A47A
 for <kvmarm@lists.cs.columbia.edu>; Mon, 17 Jun 2019 12:33:44 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BDF328;
 Mon, 17 Jun 2019 09:33:44 -0700 (PDT)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 528A83F718;
 Mon, 17 Jun 2019 09:33:43 -0700 (PDT)
Subject: Re: [PATCH v9 4/5] KVM: arm/arm64: remove pmc->bitmask
To: andrew.murray@arm.com
References: <20190612190450.7085-1-andrew.murray@arm.com>
 <20190612190450.7085-5-andrew.murray@arm.com>
 <6a8e4fdd-d8cf-f3fb-55cd-2d06805b0eb9@arm.com>
 <20190613093957.GG49779@e119886-lin.cambridge.arm.com>
 <5e18d747-1d82-8eed-ef1c-de86c5b3a7e7@arm.com>
 <20190617154311.GM20984@e119886-lin.cambridge.arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <f3ea8075-b395-9fa4-afba-771011f62b59@arm.com>
Date: Mon, 17 Jun 2019 17:33:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190617154311.GM20984@e119886-lin.cambridge.arm.com>
Content-Language: en-US
Cc: marc.zyngier@arm.com, kvmarm@lists.cs.columbia.edu,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu



On 17/06/2019 16:43, Andrew Murray wrote:
> On Thu, Jun 13, 2019 at 05:50:43PM +0100, Suzuki K Poulose wrote:
>>
>>
>> On 13/06/2019 10:39, Andrew Murray wrote:
>>> On Thu, Jun 13, 2019 at 08:30:51AM +0100, Julien Thierry wrote:

>>>>> index ae1e886d4a1a..88ce24ae0b45 100644
>>>>> --- a/virt/kvm/arm/pmu.c
>>>>> +++ b/virt/kvm/arm/pmu.c
>>>>> @@ -47,7 +47,10 @@ u64 kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu, u64 select_idx)
>>>>>    		counter += perf_event_read_value(pmc->perf_event, &enabled,
>>>>>    						 &running);
>>>>> -	return counter & pmc->bitmask;
>>>>> +	if (select_idx != ARMV8_PMU_CYCLE_IDX)
>>>>> +		counter = lower_32_bits(counter);
>>>>
>>>> Shouldn't this depend on PMCR.LC as well? If PMCR.LC is clear we only
>>>> want the lower 32bits of the cycle counter.
>>>
>>> Yes that's correct. The hunk should look like this:
>>>
>>> -       return counter & pmc->bitmask;
>>> +       if (!(select_idx == ARMV8_PMU_CYCLE_IDX &&
>>> +             __vcpu_sys_reg(vcpu, PMCR_EL0) & ARMV8_PMU_PMCR_LC))
>>> +               counter = lower_32_bits(counter);
>>> +
>>> +       return counter;
>>
>> May be you could add a macro :
>>
>> #define vcpu_pmu_counter_is_64bit(vcpu, idx) ?
> 
> Yes I think a helper would be useful - though I'd prefer the name
> 'kvm_pmu_idx_is_long_cycle_counter'. This seems a little clearer as
> you could otherwise argue that a chained counter is also 64 bits.

When you get to add 64bit PMU counter (v8.5), this would be handy. So
having it de-coupled from the cycle counter may be a good idea. Anyways,
I leave that to you.

Cheers
Suzuki
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
