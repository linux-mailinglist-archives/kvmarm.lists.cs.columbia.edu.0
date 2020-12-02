Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3170C2CC06F
	for <lists+kvmarm@lfdr.de>; Wed,  2 Dec 2020 16:12:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9D6384B3C7;
	Wed,  2 Dec 2020 10:12:56 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l4qUPSMMXy2H; Wed,  2 Dec 2020 10:12:56 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 377C64B39F;
	Wed,  2 Dec 2020 10:12:55 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A4BFB4B352
 for <kvmarm@lists.cs.columbia.edu>; Wed,  2 Dec 2020 10:12:53 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jj3RiFAqYESl for <kvmarm@lists.cs.columbia.edu>;
 Wed,  2 Dec 2020 10:12:51 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5D01C4B348
 for <kvmarm@lists.cs.columbia.edu>; Wed,  2 Dec 2020 10:12:51 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FEDE1042;
 Wed,  2 Dec 2020 07:12:50 -0800 (PST)
Received: from [192.168.0.110] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9BB083F718;
 Wed,  2 Dec 2020 07:12:44 -0800 (PST)
Subject: Re: [RFC PATCH v3 06/16] KVM: arm64: Introduce SPE primitives
To: James Morse <james.morse@arm.com>
References: <20201027172705.15181-1-alexandru.elisei@arm.com>
 <20201027172705.15181-7-alexandru.elisei@arm.com>
 <8939725c-0922-e147-2622-ae5f752a74fc@arm.com>
From: Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <c3572bec-b94f-141f-954e-93bc570d5f0a@arm.com>
Date: Wed, 2 Dec 2020 15:13:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <8939725c-0922-e147-2622-ae5f752a74fc@arm.com>
Content-Language: en-US
Cc: maz@kernel.org, linux-arm-kernel@lists.infradead.org, will@kernel.org,
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

Hi James,

On 11/19/20 4:58 PM, James Morse wrote:
> Hi Alex,
>
> On 27/10/2020 17:26, Alexandru Elisei wrote:
>> KVM SPE emulation depends on the configuration option KVM_ARM_SPE and on on
>> having hardware SPE support on all CPUs.
>> The host driver must be
>> compiled-in because we need the SPE interrupt to be enabled; it will be
>> used to kick us out of the guest when the profiling buffer management
>> interrupt is asserted by the GIC (for example, when the buffer is full).
> Great: SPE IRQ very important...

Within reason.

>
>
>> Add a VCPU flag to inform KVM that the guest has SPE enabled.
>>
>> It's worth noting that even though the KVM_ARM_SPE config option is gated
>> by the SPE host driver being compiled-in, we don't actually check that the
>> driver was loaded successfully when we advertise SPE support for guests.
> Eh?

Yes, this looks half-baked, and probably is, because:

1. I'm not sure I haven't missed anything with my approach to handling the SPE
interrupt triggered by the guest (details in the cover letter). The other option
would be to use the SPE driver IRQ handler, which makes this moot.

2. The SPE driver probing fails when the host has kpti enabled (the kernel can't
profile userspace). In my opinion, this shouldn't affect SPE support for guests,
but I didn't want to modify the SPE driver at this stage because of 1.

If we agree on my approach to guest SPE interrupt handling, this patch can be
improved by at least checking that the SPE driver probed successfully and taking
the case where kpti is enabled into consideration.

>
>> That's because we can live with the SPE interrupt being disabled. There is
>> a delay between when the SPE hardware asserts the interrupt and when the
>> GIC samples the interrupt line and asserts it to the CPU. If the SPE
>> interrupt is disabled at the GIC level, this delay will be larger,
> How does this work? Surely the IRQ needs to be enabled before it can become pending at the
> CPU to kick us out of the guest...

As long as the SPE hardware asserts the buffer management interrupt to the GIC
(PMBSR_EL1.S = 1), no profiling is done. If the interrupt is not enabled at the
GIC level, then the CPU will not take the interrupt (obviously). But as far as the
SPE hardware is concerned, the interrupt is asserted and profiling is disabled.
The host checks the PMBSR_EL1.S bit on every VM exit to see if SPE asserts the
interrupt and there's no dependency on the GIC asserting the interrupt. The SPE
interrupt being disabled at the GIC level is not as bad as it sounds (but it's
definitely not ideal) because there will always be a delay between the SPE
hardware asserting the interrupt to the GIC and the GIC asserting it to the CPU.
Not requiring the interrupt to be enabled at the GIC level makes that delay longer
in the case where the host driver failed probing.

>
>
>> at most a host timer tick.
> (Because the timer brings us out of the guest anyway?)

Yes, once very 4 ms according to the default value for CONFIG_HZ.

Thanks,
Alex
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
