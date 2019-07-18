Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 97CEB6C4C6
	for <lists+kvmarm@lfdr.de>; Thu, 18 Jul 2019 04:02:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B4B8E4A56B;
	Wed, 17 Jul 2019 22:02:01 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fuDgM9lQWv8u; Wed, 17 Jul 2019 22:02:01 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 844B94A565;
	Wed, 17 Jul 2019 22:02:00 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BE30C4A555
 for <kvmarm@lists.cs.columbia.edu>; Wed, 17 Jul 2019 22:01:58 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jfXmLK0OSaoS for <kvmarm@lists.cs.columbia.edu>;
 Wed, 17 Jul 2019 22:01:56 -0400 (EDT)
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id E63C24A52A
 for <kvmarm@lists.cs.columbia.edu>; Wed, 17 Jul 2019 22:01:55 -0400 (EDT)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id B923175E6D083B2475B5;
 Thu, 18 Jul 2019 10:01:52 +0800 (CST)
Received: from [127.0.0.1] (10.184.12.158) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Thu, 18 Jul 2019
 10:01:46 +0800
Subject: Re: [PATCH] KVM: arm/arm64: Assign pmc->idx before
 kvm_pmu_stop_counter()
To: Marc Zyngier <maz@kernel.org>, Julien Thierry <julien.thierry@arm.com>,
 <kvmarm@lists.cs.columbia.edu>, <linux-arm-kernel@lists.infradead.org>
References: <1563366019-31200-1-git-send-email-yuzenghui@huawei.com>
 <01fa98c1-8274-445c-5e04-219372920ba2@arm.com>
 <26b64d48-5ff9-7d62-bc44-601fdcc43223@kernel.org>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <ae65afd1-fd9a-280f-285f-543b1fa246f3@huawei.com>
Date: Thu, 18 Jul 2019 09:59:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <26b64d48-5ff9-7d62-bc44-601fdcc43223@kernel.org>
Content-Language: en-US
X-Originating-IP: [10.184.12.158]
X-CFilter-Loop: Reflected
Cc: marc.zyngier@arm.com, linux-kernel@vger.kernel.org
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

Hi Julien, Marc,

On 2019/7/17 23:00, Marc Zyngier wrote:
> On 17/07/2019 14:44, Julien Thierry wrote:
>> Hi Zenghui,
>>
>> On 17/07/2019 13:20, Zenghui Yu wrote:
>>> We use "pmc->idx" and the "chained" bitmap to determine if the pmc is
>>> chained, in kvm_pmu_pmc_is_chained().  But idx might be uninitialized
>>> (and random) when we doing this decision, through a KVM_ARM_VCPU_INIT
>>> ioctl -> kvm_pmu_vcpu_reset(). And the test_bit() against this random
>>> idx will potentially hit a KASAN BUG [1].
>>>
>>> Fix it by moving the assignment of idx before kvm_pmu_stop_counter().
>>>
>>> [1] https://www.spinics.net/lists/kvm-arm/msg36700.html
>>>
>>> Fixes: 80f393a23be6 ("KVM: arm/arm64: Support chained PMU counters")
>>> Suggested-by: Andrew Murray <andrew.murray@arm.com>
>>> Cc: Marc Zyngier <maz@kernel.org>
>>> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>> ---
>>>   virt/kvm/arm/pmu.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
>>> index 3dd8238..521bfdd 100644
>>> --- a/virt/kvm/arm/pmu.c
>>> +++ b/virt/kvm/arm/pmu.c
>>> @@ -225,8 +225,8 @@ void kvm_pmu_vcpu_reset(struct kvm_vcpu *vcpu)
>>>   	struct kvm_pmu *pmu = &vcpu->arch.pmu;
>>>   
>>>   	for (i = 0; i < ARMV8_PMU_MAX_COUNTERS; i++) {
>>> -		kvm_pmu_stop_counter(vcpu, &pmu->pmc[i]);
>>>   		pmu->pmc[i].idx = i;
>>
>> Yes, this is kind of a static property that should really be part of a
>> "kvm_pmu_vcpu_init()" or "kvm_pmu_vcpu_create()" and is not expected to
>> be modified across resets...
>>
>> There is no such function at the time and I'm unsure whether this
>> warrants creating that separate function (I would still suggest creating
>> it to make things clearer).
> 
> Yup, that's pretty bad, now that you mention it. I'd be all for the
> introduction of kvm_pmu_vcpu_init(), given that we already have
> kvm_pmu_vcpu_destroy().
> 
>>
>>> +		kvm_pmu_stop_counter(vcpu, &pmu->pmc[i]);
>>
>> Whatever other opinions are on splitting pmu_vcpu_init/reset, that
>> change makes sense and fixes the issue:
>>
>> Acked-by: Julien Thierry <julien.thierry@arm.com>
>>
>>>   	}
>>>   
>>>   	bitmap_zero(vcpu->arch.pmu.chained, ARMV8_PMU_MAX_COUNTER_PAIRS);
>>>
>>
>> Cheers,
>>
> 
> Zenghui, could you please update your patch to take the above into account?

Sure. I will send a v2 with the new subject (may be "KVM: arm/arm64:
Introduce kvm_pmu_vcpu_init() to ...").

Thanks for your suggestions!


zenghui

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
