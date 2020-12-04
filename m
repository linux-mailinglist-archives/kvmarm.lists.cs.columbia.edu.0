Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4AD2CE8AB
	for <lists+kvmarm@lfdr.de>; Fri,  4 Dec 2020 08:36:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3691E4B2B3;
	Fri,  4 Dec 2020 02:36:04 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SmDKdDbqWsaQ; Fri,  4 Dec 2020 02:36:04 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 109234B299;
	Fri,  4 Dec 2020 02:36:03 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5ABE94B20C
 for <kvmarm@lists.cs.columbia.edu>; Fri,  4 Dec 2020 02:36:01 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j-2p9Amr-jEo for <kvmarm@lists.cs.columbia.edu>;
 Fri,  4 Dec 2020 02:36:00 -0500 (EST)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 47AA24A2E5
 for <kvmarm@lists.cs.columbia.edu>; Fri,  4 Dec 2020 02:36:00 -0500 (EST)
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CnPcx6ktLzhmMj;
 Fri,  4 Dec 2020 15:35:29 +0800 (CST)
Received: from [10.174.187.37] (10.174.187.37) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Fri, 4 Dec 2020 15:35:50 +0800
Subject: Re: [PATCH v2 1/2] clocksource: arm_arch_timer: Use stable count
 reader in erratum sne
To: Marc Zyngier <maz@kernel.org>
References: <20200818032814.15968-1-zhukeqian1@huawei.com>
 <20200818032814.15968-2-zhukeqian1@huawei.com>
 <c8e0506a7976deef0427a30b0d10e35b@kernel.org>
From: zhukeqian <zhukeqian1@huawei.com>
Message-ID: <e83c5aa4-3d1a-7647-dea6-4713606bacf8@huawei.com>
Date: Fri, 4 Dec 2020 15:35:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <c8e0506a7976deef0427a30b0d10e35b@kernel.org>
X-Originating-IP: [10.174.187.37]
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

On 2020/12/3 22:58, Marc Zyngier wrote:
> On 2020-08-18 04:28, Keqian Zhu wrote:
>> In commit 0ea415390cd3 ("clocksource/arm_arch_timer: Use arch_timer_read_counter
>> to access stable counters"), we separate stable and normal count reader to omit
>> unnecessary overhead on systems that have no timer erratum.
>>
>> However, in erratum_set_next_event_tval_generic(), count reader becomes normal
>> reader. This converts it to stable reader.
>>
>> Fixes: 0ea415390cd3 ("clocksource/arm_arch_timer: Use
>>        arch_timer_read_counter to access stable counters")
> 
> On a single line.
Addressed. Thanks.

> 
>> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
>> ---
>>  drivers/clocksource/arm_arch_timer.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/clocksource/arm_arch_timer.c
>> b/drivers/clocksource/arm_arch_timer.c
>> index 6c3e841..777d38c 100644
>> --- a/drivers/clocksource/arm_arch_timer.c
>> +++ b/drivers/clocksource/arm_arch_timer.c
>> @@ -396,10 +396,10 @@ static void
>> erratum_set_next_event_tval_generic(const int access, unsigned long
>>      ctrl &= ~ARCH_TIMER_CTRL_IT_MASK;
>>
>>      if (access == ARCH_TIMER_PHYS_ACCESS) {
>> -        cval = evt + arch_counter_get_cntpct();
>> +        cval = evt + arch_counter_get_cntpct_stable();
>>          write_sysreg(cval, cntp_cval_el0);
>>      } else {
>> -        cval = evt + arch_counter_get_cntvct();
>> +        cval = evt + arch_counter_get_cntvct_stable();
>>          write_sysreg(cval, cntv_cval_el0);
>>      }
> 
> With that fixed:
> 
> Acked-by: Marc Zyngier <maz@kernel.org>
> 
> This should go via the clocksource tree.
Added Cc to it's maintainers, thanks.

> 
> Thanks,
> 
>         M.
Cheers,
Keqian
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
