Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 40D0F4B91A
	for <lists+kvmarm@lfdr.de>; Wed, 19 Jun 2019 14:52:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6425E4A4F3;
	Wed, 19 Jun 2019 08:52:11 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bWKv1xyeerEx; Wed, 19 Jun 2019 08:52:11 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1B4654A4E1;
	Wed, 19 Jun 2019 08:52:10 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4992D4A3B4
 for <kvmarm@lists.cs.columbia.edu>; Wed, 19 Jun 2019 08:52:08 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mNav8z0d6qSo for <kvmarm@lists.cs.columbia.edu>;
 Wed, 19 Jun 2019 08:52:07 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id F00A94A389
 for <kvmarm@lists.cs.columbia.edu>; Wed, 19 Jun 2019 08:52:06 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64E27360;
 Wed, 19 Jun 2019 05:52:06 -0700 (PDT)
Received: from [10.1.196.50] (e108454-lin.cambridge.arm.com [10.1.196.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0EDE23F738;
 Wed, 19 Jun 2019 05:52:03 -0700 (PDT)
Subject: Re: [PATCH RFC 11/14] arm64: Move the ASID allocator code in a
 separate file
To: Guo Ren <guoren@kernel.org>
References: <20190321163623.20219-1-julien.grall@arm.com>
 <20190321163623.20219-12-julien.grall@arm.com>
 <0dfe120b-066a-2ac8-13bc-3f5a29e2caa3@arm.com>
 <CAJF2gTTXHHgDboaexdHA284y6kNZVSjLis5-Q2rDnXCxr4RSmA@mail.gmail.com>
 <c871a5ae-914f-a8bb-9474-1dcfec5d45bf@arm.com>
 <CAJF2gTStSR7Jmu7=HaO5Wxz=Zn8A5-RD8ktori3oKEhM9vozAA@mail.gmail.com>
From: Julien Grall <julien.grall@arm.com>
Message-ID: <aafb3478-ce7b-3771-c03a-58510261f01c@arm.com>
Date: Wed, 19 Jun 2019 13:52:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAJF2gTStSR7Jmu7=HaO5Wxz=Zn8A5-RD8ktori3oKEhM9vozAA@mail.gmail.com>
Content-Language: en-US
Cc: aou@eecs.berkeley.edu, Marc Zyngier <marc.zyngier@arm.com>,
 catalin.marinas@arm.com, Anup Patel <anup.Patel@wdc.com>, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, rppt@linux.ibm.com, hch@infradead.org,
 Atish.Patra@wdc.com, Palmer Dabbelt <palmer@sifive.com>, gary@garyguo.net,
 paul.walmsley@sifive.com, linux-riscv@lists.infradead.org,
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

Hi Guo,

On 19/06/2019 12:51, Guo Ren wrote:
> On Wed, Jun 19, 2019 at 4:54 PM Julien Grall <julien.grall@arm.com> wrote:
>>
>>
>>
>> On 6/19/19 9:07 AM, Guo Ren wrote:
>>> Hi Julien,
>>
>> Hi,
>>
>>>
>>> You forgot CCing C-SKY folks :P
>>
>> I wasn't aware you could be interested :).
>>
>>>
>>> Move arm asid allocator code in a generic one is a agood idea, I've
>>> made a patchset for C-SKY and test is on processing, See:
>>> https://lore.kernel.org/linux-csky/1560930553-26502-1-git-send-email-guoren@kernel.org/
>>>
>>> If you plan to seperate it into generic one, I could co-work with you.
>>
>> Was the ASID allocator work out of box on C-Sky?
> Almost done, but one question:
> arm64 remove the code in switch_mm:
>    cpumask_clear_cpu(cpu, mm_cpumask(prev));
>    cpumask_set_cpu(cpu, mm_cpumask(next));


> 
> Why? Although arm64 cache operations could affect all harts with CTC
> method of interconnect, I think we should
> keep these code for primitive integrity in linux. Because cpu_bitmap
> is in mm_struct instead of mm->context.

I will let Will answer to this.

[...]

>> If so, I can easily move the code in a generic place (maybe lib/asid.c).
> I think it's OK.

Will emits concern to move the code in lib. So I will stick with what I 
currently have.

Cheers,

-- 
Julien Grall
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
