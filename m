Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B761B247BEF
	for <lists+kvmarm@lfdr.de>; Tue, 18 Aug 2020 03:43:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4ABA24C252;
	Mon, 17 Aug 2020 21:43:01 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9vu5G-c8ksvT; Mon, 17 Aug 2020 21:43:01 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4096D4C1DB;
	Mon, 17 Aug 2020 21:43:00 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B9FB44BFE6
 for <kvmarm@lists.cs.columbia.edu>; Mon, 17 Aug 2020 21:42:58 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yE2vzRe3mLLY for <kvmarm@lists.cs.columbia.edu>;
 Mon, 17 Aug 2020 21:42:57 -0400 (EDT)
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9B7874BEE1
 for <kvmarm@lists.cs.columbia.edu>; Mon, 17 Aug 2020 21:42:57 -0400 (EDT)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id CD00468AFF19047C289E;
 Tue, 18 Aug 2020 09:42:54 +0800 (CST)
Received: from [10.174.187.22] (10.174.187.22) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Tue, 18 Aug 2020 09:42:47 +0800
Subject: Re: [PATCH 2/2] clocksource: arm_arch_timer: Correct fault
 programming of CNTKCTL_EL1.EVNTI
To: Marc Zyngier <maz@kernel.org>
References: <20200817122415.6568-1-zhukeqian1@huawei.com>
 <20200817122415.6568-3-zhukeqian1@huawei.com>
 <b37f6cf6a660f51690f0689509650eed@kernel.org>
From: zhukeqian <zhukeqian1@huawei.com>
Message-ID: <519050e9-7a51-5621-6709-0c82d33456f6@huawei.com>
Date: Tue, 18 Aug 2020 09:42:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <b37f6cf6a660f51690f0689509650eed@kernel.org>
X-Originating-IP: [10.174.187.22]
X-CFilter-Loop: Reflected
Cc: kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 linux-kernel@vger.kernel.org, Steven Price <steven.price@arm.com>,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

Hi Marc,

On 2020/8/17 20:56, Marc Zyngier wrote:
> On 2020-08-17 13:24, Keqian Zhu wrote:
>> ARM virtual counter supports event stream, it can only trigger an event
>> when the trigger bit (the value of CNTKCTL_EL1.EVNTI) of CNTVCT_EL0 changes,
>> so the actual period of event stream is 2^(cntkctl_evnti + 1). For example,
>> when the trigger bit is 0, then virtual counter trigger an event for every
>> two cycles.
>>
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
> 
> I have never given you this tag, you are making it up. Please read
> Documentation/process/submitting-patches.rst to understand what
> tag you can put by yourself.
Sorry about my mistake.
> 
> At best, put "Suggested-by" tag, as this is different from what
> I posted anyway.
OK, I will use this tag.

Thanks,
Keqian
> 
> Thanks,
> 
>         M.
> 
>> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
>> ---
>>  drivers/clocksource/arm_arch_timer.c | 10 +++++++---
>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/clocksource/arm_arch_timer.c
>> b/drivers/clocksource/arm_arch_timer.c
>> index 6e11c60..4140a37 100644
>> --- a/drivers/clocksource/arm_arch_timer.c
>> +++ b/drivers/clocksource/arm_arch_timer.c
>> @@ -794,10 +794,14 @@ static void arch_timer_configure_evtstream(void)
>>  {
>>      int evt_stream_div, pos;
>>
>> -    /* Find the closest power of two to the divisor */
>> -    evt_stream_div = arch_timer_rate / ARCH_TIMER_EVT_STREAM_FREQ;
>> +    /*
>> +     * Find the closest power of two to the divisor. As the event
>> +     * stream can at most be generated at half the frequency of the
>> +     * counter, use half the frequency when computing the divider.
>> +     */
>> +    evt_stream_div = arch_timer_rate / ARCH_TIMER_EVT_STREAM_FREQ / 2;
>>      pos = fls(evt_stream_div);
>> -    if (pos > 1 && !(evt_stream_div & (1 << (pos - 2))))
>> +    if ((pos == 1) || (pos > 1 && !(evt_stream_div & (1 << (pos - 2)))))
>>          pos--;
>>      /* enable event stream */
>>      arch_timer_evtstrm_enable(min(pos, 15));
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
