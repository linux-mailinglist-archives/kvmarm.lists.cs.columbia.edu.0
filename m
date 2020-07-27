Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5280122EA54
	for <lists+kvmarm@lfdr.de>; Mon, 27 Jul 2020 12:48:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DE39A4B9C8;
	Mon, 27 Jul 2020 06:48:14 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 22UGke3DimfU; Mon, 27 Jul 2020 06:48:14 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 86FFD4B9C2;
	Mon, 27 Jul 2020 06:48:13 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id AF21E4B8F6
 for <kvmarm@lists.cs.columbia.edu>; Mon, 27 Jul 2020 06:48:12 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wKYEqLkNMINd for <kvmarm@lists.cs.columbia.edu>;
 Mon, 27 Jul 2020 06:48:11 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E3AAB4B916
 for <kvmarm@lists.cs.columbia.edu>; Mon, 27 Jul 2020 06:48:10 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 600E630E;
 Mon, 27 Jul 2020 03:48:10 -0700 (PDT)
Received: from [192.168.1.84] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A66B93F66E;
 Mon, 27 Jul 2020 03:48:07 -0700 (PDT)
Subject: Re: [PATCH 0/9] arm64: Stolen time support
To: zhukeqian <zhukeqian1@huawei.com>
References: <20190802145017.42543-1-steven.price@arm.com>
 <1611996b-1ec1-dee7-ed61-b3b9df23f138@huawei.com>
From: Steven Price <steven.price@arm.com>
Message-ID: <25c7f2e2-e779-4e97-fdc5-0aba9fcf0fbc@arm.com>
Date: Mon, 27 Jul 2020 11:48:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1611996b-1ec1-dee7-ed61-b3b9df23f138@huawei.com>
Content-Language: en-GB
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 yebiaoxiang@huawei.com, Marc Zyngier <maz@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Will Deacon <will@kernel.org>,
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

On 21/07/2020 04:26, zhukeqian wrote:
> Hi Steven,

Hi Keqian,

> On 2019/8/2 22:50, Steven Price wrote:
>> This series add support for paravirtualized time for arm64 guests and
>> KVM hosts following the specification in Arm's document DEN 0057A:
>>
>> https://developer.arm.com/docs/den0057/a
>>
>> It implements support for stolen time, allowing the guest to
>> identify time when it is forcibly not executing.
>>
>> It doesn't implement support for Live Physical Time (LPT) as there are
>> some concerns about the overheads and approach in the above
> Do you plan to pick up LPT support? As there is demand of cross-frequency migration
> (from older platform to newer platform).

I don't have any plans to pick up the LPT support at the moment - feel 
free to pick it up! ;)

> I am not clear about the overheads and approach problem here, could you please
> give some detail information? Maybe we can work together to solve these concerns. :-)

Fundamentally the issue here is that LPT only solves one small part of 
migration between different hosts. To successfully migrate between hosts 
with different CPU implementations it is also necessary to be able to 
virtualise various ID registers (e.g. MIDR_EL1, REVIDR_EL1, AIDR_EL1) 
which we have no support for currently.

The problem with just virtualising the registers is how you handle 
errata. The guest will currently use those (and other) ID registers to 
decide whether to enable specific errata workarounds. But what errata 
should be enabled for a guest which might migrate to another host?

What we ideally need is a mechanism to communicate to the guest what 
workarounds are required to successfully run on any of the hosts that 
the guest may be migrated to. You may also have the situation where the 
workarounds required for two hosts are mutually incompatible - something 
needs to understand this and do the "right thing" (most likely just 
reject this situation, i.e. prevent the migration).

There are various options here: e.g. a para-virtualised interface to 
describe the workarounds (but this is hard to do in an OS-agnostic way), 
or virtual-ID registers describing an idealised environment where no 
workarounds are required (and only hosts that have no errata affecting a 
guest would be able to provide this).

Given the above complexity and the fact that Armv8.6-A standardises the 
frequency to 1GHz this didn't seem worth continuing with. So LPT was 
dropped from the spec and patches to avoid holding up the stolen time 
support.

However, if you have a use case which doesn't require such a generic 
migration (e.g. perhaps old and new platforms are based on the same IP) 
then it might be worth looking at bring this back. But to make the 
problem solvable it either needs to be restricted to platforms which are 
substantially the same (so the errata list will be identical), or 
there's work to be done in preparation to deal with migrating a guest 
successfully between hosts with potentially different errata requirements.

Can you share more details about the hosts that you are interested in 
migrating between?

Thanks,

Steve
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
