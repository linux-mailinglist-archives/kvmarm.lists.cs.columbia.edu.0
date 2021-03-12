Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3AF3388AB
	for <lists+kvmarm@lfdr.de>; Fri, 12 Mar 2021 10:29:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BD4434B426;
	Fri, 12 Mar 2021 04:29:51 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TakMg9JCulq4; Fri, 12 Mar 2021 04:29:51 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 89D244B41D;
	Fri, 12 Mar 2021 04:29:50 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BDA094B369
 for <kvmarm@lists.cs.columbia.edu>; Fri, 12 Mar 2021 04:29:49 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WWIyoU-u6DNr for <kvmarm@lists.cs.columbia.edu>;
 Fri, 12 Mar 2021 04:29:48 -0500 (EST)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 84A454B334
 for <kvmarm@lists.cs.columbia.edu>; Fri, 12 Mar 2021 04:29:47 -0500 (EST)
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DxgTR1Pjnz8x4g;
 Fri, 12 Mar 2021 17:27:55 +0800 (CST)
Received: from [10.174.184.42] (10.174.184.42) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Fri, 12 Mar 2021 17:29:35 +0800
Subject: Re: [RFC PATCH] kvm: arm64: Try stage2 block mapping for host device
 MMIO
To: Marc Zyngier <maz@kernel.org>
References: <20210122083650.21812-1-zhukeqian1@huawei.com>
 <87y2euf5d2.wl-maz@kernel.org>
 <e2a36913-2ded-71ff-d3ed-f7f8d831447c@huawei.com>
 <87o8fog3et.wl-maz@kernel.org>
From: Keqian Zhu <zhukeqian1@huawei.com>
Message-ID: <e0859e30-a4ca-7456-385e-c9efd914e1e4@huawei.com>
Date: Fri, 12 Mar 2021 17:29:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <87o8fog3et.wl-maz@kernel.org>
X-Originating-IP: [10.174.184.42]
X-CFilter-Loop: Reflected
Cc: Andrew Morton <akpm@linux-foundation.org>, kvm@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org,
 Alexios Zavras <alexios.zavras@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 Robin Murphy <robin.murphy@arm.com>
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

On 2021/3/12 16:52, Marc Zyngier wrote:
> On Thu, 11 Mar 2021 14:28:17 +0000,
> Keqian Zhu <zhukeqian1@huawei.com> wrote:
>>
>> Hi Marc,
>>
>> On 2021/3/11 16:43, Marc Zyngier wrote:
>>> Digging this patch back from my Inbox...
>> Yeah, thanks ;-)
>>
>>>
>>> On Fri, 22 Jan 2021 08:36:50 +0000,
>>> Keqian Zhu <zhukeqian1@huawei.com> wrote:
>>>>
>>>> The MMIO region of a device maybe huge (GB level), try to use block
>>>> mapping in stage2 to speedup both map and unmap.
[...]

>>>>  			break;
>>>>  
>>>> -		pa += PAGE_SIZE;
>>>> +		pa += pgsize;
>>>>  	}
>>>>  
>>>>  	kvm_mmu_free_memory_cache(&cache);
>>>
>>> There is one issue with this patch, which is that it only does half
>>> the job. A VM_PFNMAP VMA can definitely be faulted in dynamically, and
>>> in that case we force this to be a page mapping. This conflicts with
>>> what you are doing here.
>> Oh yes, these two paths should keep a same mapping logic.
>>
>> I try to search the "force_pte" and find out some discussion [1]
>> between you and Christoffer.  And I failed to get a reason about
>> forcing pte mapping for device MMIO region (expect that we want to
>> keep a same logic with the eager mapping path). So if you don't
>> object to it, I will try to implement block mapping for device MMIO
>> in user_mem_abort().
>>
>>>
>>> There is also the fact that if we can map things on demand, why are we
>>> still mapping these MMIO regions ahead of time?
>>
>> Indeed. Though this provides good *startup* performance for guest
>> accessing MMIO, it's hard to keep the two paths in sync. We can keep
>> this minor optimization or delete it to avoid hard maintenance,
>> which one do you prefer?
> 
> I think we should be able to get rid of the startup path. If we can do
> it for memory, I see no reason not to do it for MMIO.
OK, I will do.

> 
>> BTW, could you please have a look at my another patch series[2]
>> about HW/SW combined dirty log? ;)
> 
> I will eventually, but while I really appreciate your contributions in
> terms of features and bug fixes, I would really *love* it if you were
> a bit more active on the list when it comes to reviewing other
> people's code.
> 
> There is no shortage of patches that really need reviewing, and just
> pointing me in the direction of your favourite series doesn't really
> help. I have something like 200+ patches that need careful reviewing
> in my inbox, and they all deserve the same level of attention.
> 
> To make it short, help me to help you!
My apologies, and I can't agree more.

I have noticed this, and have reviewed several patches of IOMMU community.
For that some patches are with much background knowledge, so it's hard to
review. I will dig into them in the future.

Thanks for your valuable advice. :)

Thanks,
Keqian


> 
> Thanks,
> 
> 	M.
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
