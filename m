Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 53AE72461C9
	for <lists+kvmarm@lfdr.de>; Mon, 17 Aug 2020 11:03:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DCC6D4BFB3;
	Mon, 17 Aug 2020 05:03:23 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RB1mcNoQVfvK; Mon, 17 Aug 2020 05:03:23 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BAA984BF9F;
	Mon, 17 Aug 2020 05:03:22 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 83CDE4BF95
 for <kvmarm@lists.cs.columbia.edu>; Mon, 17 Aug 2020 05:03:21 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QtYL1yf8Jq1J for <kvmarm@lists.cs.columbia.edu>;
 Mon, 17 Aug 2020 05:03:20 -0400 (EDT)
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id DAC7B4BF8F
 for <kvmarm@lists.cs.columbia.edu>; Mon, 17 Aug 2020 05:03:19 -0400 (EDT)
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id C7AD0D26D5A74FB8370D;
 Mon, 17 Aug 2020 17:03:11 +0800 (CST)
Received: from [10.174.187.22] (10.174.187.22) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Mon, 17 Aug 2020 17:02:57 +0800
Subject: Re: [PATCH 1/3] KVM: arm64: Some fixes of PV-time interface document
To: Andrew Jones <drjones@redhat.com>
References: <20200817033729.10848-1-zhukeqian1@huawei.com>
 <20200817033729.10848-2-zhukeqian1@huawei.com>
 <20200817084735.xyfdtgcsuxzwgzyr@kamzik.brq.redhat.com>
From: zhukeqian <zhukeqian1@huawei.com>
Message-ID: <2128580f-1a3b-bdb3-e75a-99dcc36c66a3@huawei.com>
Date: Mon, 17 Aug 2020 17:02:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20200817084735.xyfdtgcsuxzwgzyr@kamzik.brq.redhat.com>
X-Originating-IP: [10.174.187.22]
X-CFilter-Loop: Reflected
Cc: kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 linux-kernel@vger.kernel.org, Steven Price <steven.price@arm.com>,
 Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

Hi Andrew,

On 2020/8/17 16:47, Andrew Jones wrote:
> On Mon, Aug 17, 2020 at 11:37:27AM +0800, Keqian Zhu wrote:
>> Rename PV_FEATURES tp PV_TIME_FEATURES
>>
>> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
>> ---
>>  Documentation/virt/kvm/arm/pvtime.rst | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/virt/kvm/arm/pvtime.rst b/Documentation/virt/kvm/arm/pvtime.rst
>> index 687b60d..94bffe2 100644
>> --- a/Documentation/virt/kvm/arm/pvtime.rst
>> +++ b/Documentation/virt/kvm/arm/pvtime.rst
>> @@ -3,7 +3,7 @@
>>  Paravirtualized time support for arm64
>>  ======================================
>>  
>> -Arm specification DEN0057/A defines a standard for paravirtualised time
>> +Arm specification DEN0057/A defines a standard for paravirtualized time
>>  support for AArch64 guests:
>>  
>>  https://developer.arm.com/docs/den0057/a
>> @@ -19,8 +19,8 @@ Two new SMCCC compatible hypercalls are defined:
>>  
>>  These are only available in the SMC64/HVC64 calling convention as
>>  paravirtualized time is not available to 32 bit Arm guests. The existence of
>> -the PV_FEATURES hypercall should be probed using the SMCCC 1.1 ARCH_FEATURES
>> -mechanism before calling it.
>> +the PV_TIME_FEATURES hypercall should be probed using the SMCCC 1.1
>> +ARCH_FEATURES mechanism before calling it.
>>  
>>  PV_TIME_FEATURES
>>      ============= ========    ==========
>> -- 
>> 1.8.3.1
>>
> 
> Reviewed-by: Andrew Jones <drjones@redhat.com>
Thanks for your review.

Also It will be very nice if you have time to review the patch series
supporting pvtime LPT.

Thanks,
Keqian
> 
> .
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
