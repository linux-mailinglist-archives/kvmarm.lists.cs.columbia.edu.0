Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id AA7A76D893
	for <lists+kvmarm@lfdr.de>; Fri, 19 Jul 2019 03:49:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7A5DD4A52C;
	Thu, 18 Jul 2019 21:49:37 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pNjPZNBYeo+L; Thu, 18 Jul 2019 21:49:37 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8D35D4A525;
	Thu, 18 Jul 2019 21:49:35 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B66934A4F6
 for <kvmarm@lists.cs.columbia.edu>; Thu, 18 Jul 2019 21:49:33 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 62y1a1ZToJuq for <kvmarm@lists.cs.columbia.edu>;
 Thu, 18 Jul 2019 21:49:32 -0400 (EDT)
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id E92BA4A4EB
 for <kvmarm@lists.cs.columbia.edu>; Thu, 18 Jul 2019 21:49:31 -0400 (EDT)
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 946D830309C0A785A41F;
 Fri, 19 Jul 2019 09:49:28 +0800 (CST)
Received: from [127.0.0.1] (10.133.216.73) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Fri, 19 Jul 2019
 09:49:22 +0800
Subject: Re: [RFC] Add virtual SDEI support in qemu
To: Dave Martin <Dave.Martin@arm.com>, Mark Rutland <mark.rutland@arm.com>
References: <1b0aa6b2-80b1-a72e-6849-7323c3b9c6bc@huawei.com>
 <20190715134059.GJ2790@e103592.cambridge.arm.com>
 <20190715134848.GI56232@lakrids.cambridge.arm.com>
 <4daefb19-6c15-f82c-31e9-1ae035d45bd5@arm.com>
 <20190715144446.GK56232@lakrids.cambridge.arm.com>
 <20190716084734.GL2790@e103592.cambridge.arm.com>
From: Guoheyi <guoheyi@huawei.com>
Message-ID: <287f566e-7697-3763-56b8-eb4821bd8347@huawei.com>
Date: Fri, 19 Jul 2019 09:49:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20190716084734.GL2790@e103592.cambridge.arm.com>
X-Originating-IP: [10.133.216.73]
X-CFilter-Loop: Reflected
Cc: Marc Zyngier <marc.zyngier@arm.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.cs.columbia.edu,
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

Thanks for all your comments. I'm going to write a simple demo to go 
through the whole workflow first, and then adjust the policies following 
the conclusions of our discussion.

Heyi


On 2019/7/16 16:47, Dave Martin wrote:
> On Mon, Jul 15, 2019 at 03:44:46PM +0100, Mark Rutland wrote:
>> On Mon, Jul 15, 2019 at 03:26:39PM +0100, James Morse wrote:
>>> On 15/07/2019 14:48, Mark Rutland wrote:
>>>> On Mon, Jul 15, 2019 at 02:41:00PM +0100, Dave Martin wrote:
>>>>> One option (suggested to me by James Morse) would be to allow userspace
>>>>> to disable in the in-kernel PSCI implementation and provide its own
>>>>> PSCI to the guest via SMC -- in which case userspace that wants to
>>>>> implement SDEI would have to implement PSCI as well.
>>>> I think this would be the best approach, since it puts userspace in
>>>> charge of everything.
>>>>
>>>> However, this interacts poorly with FW-based mitigations that we
>>>> implement in hyp. I suspect we'd probably need a mechanism to delegate
>>>> that responsibility back to the kernel, and figure out if that has any
>>>> interaction with thigns that got punted to userspace...
>>> This has come up before:
>>> https://lore.kernel.org/r/59C139D0.3040507@arm.com
>>>
>>> I agree Qemu should opt-in to this, it needs to be a feature that is enabled.
>>>
>>> I had an early version of something like this for testing SDEI before
>>> there was firmware available. The review feedback from Christoffer was
>>> that it should include HVC and SMC, their immediates, and shouldn't be
>>> tied to SMC-CC ranges.
>>>
>>> I think this should be a catch-all as Heyi describes to deliver
>>> 'unhandled SMC/HVC' to user-space as hypercall exits. We should
>>> include the immediate in the struct.
>>>
>>> We can allow Qemu to disable the in-kernel PSCI implementation, which
>>> would let it be done in user-space via this catch-all mechanism. (PSCI
>>> in user-space has come up on another thread recently). The in-kernel
>>> PSCI needs to be default-on for backwards compatibility.
>>>
>>> As Mark points out, the piece that's left is the 'arch workaround'
>>> stuff. We always need to handle these in the kernel. I don't think
>>> these should be routed-back, they should be un-obtainable by
>>> user-space.
>> Sure; I meant that those should be handled in the kernel rather than
>> going to host userspace and back.
>>
>> I was suggesting was that userspace would opt into taking ownership of
>> all HVC calls, then explicitly opt-in to the kernel handling specific
>> (sets of) calls.
> The most logical thing to do would be to have userspace handle all
> calls, but add an ioctl to forward a call to KVM.  This puts userspace
> in charge of the SMCCC interface, with KVM handling only those things
> that userspace can't do for itself, on request.
>
> If the performance overhead is unacceptable for certain calls, we could
> have a way to delegate specific function IDs to KVM.  I suspect that
> will be the exception rather than the rule.
>
>> There are probably issues with that, but I suspect defining "all
>> undandled calls" will be problematic otherwise.
> Agreed: the set of calls not handled by KVM will mutate over time.
>
> Cheers
> ---Dave
>
> .
>


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
