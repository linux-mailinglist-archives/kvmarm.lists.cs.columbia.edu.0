Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C6412366581
	for <lists+kvmarm@lfdr.de>; Wed, 21 Apr 2021 08:37:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 351A04B4B5;
	Wed, 21 Apr 2021 02:37:19 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oUzcbhzcmQIe; Wed, 21 Apr 2021 02:37:19 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6ECEF4B4B7;
	Wed, 21 Apr 2021 02:37:15 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7F77E4B4AC
 for <kvmarm@lists.cs.columbia.edu>; Wed, 21 Apr 2021 02:37:13 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YQKBj4Ql3Spd for <kvmarm@lists.cs.columbia.edu>;
 Wed, 21 Apr 2021 02:37:09 -0400 (EDT)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 068084B4A9
 for <kvmarm@lists.cs.columbia.edu>; Wed, 21 Apr 2021 02:37:09 -0400 (EDT)
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FQ9kN3TrFzPshQ;
 Wed, 21 Apr 2021 14:34:04 +0800 (CST)
Received: from [10.174.187.224] (10.174.187.224) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Wed, 21 Apr 2021 14:36:56 +0800
Subject: Re: [PATCH v4 2/2] kvm/arm64: Try stage2 block mapping for host
 device MMIO
To: Gavin Shan <gshan@redhat.com>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <kvm@vger.kernel.org>,
 <kvmarm@lists.cs.columbia.edu>
References: <20210415140328.24200-1-zhukeqian1@huawei.com>
 <20210415140328.24200-3-zhukeqian1@huawei.com>
 <960e097d-818b-00bc-b2ee-0da17857f862@redhat.com>
From: Keqian Zhu <zhukeqian1@huawei.com>
Message-ID: <105a403a-e48b-15bc-44ff-0ff34f7d2194@huawei.com>
Date: Wed, 21 Apr 2021 14:36:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <960e097d-818b-00bc-b2ee-0da17857f862@redhat.com>
X-Originating-IP: [10.174.187.224]
X-CFilter-Loop: Reflected
Cc: Marc Zyngier <maz@kernel.org>
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



On 2021/4/21 15:52, Gavin Shan wrote:
> Hi Keqian,
> 
> On 4/16/21 12:03 AM, Keqian Zhu wrote:
>> The MMIO region of a device maybe huge (GB level), try to use
>> block mapping in stage2 to speedup both map and unmap.
>>
>> Compared to normal memory mapping, we should consider two more
>> points when try block mapping for MMIO region:
>>
>> 1. For normal memory mapping, the PA(host physical address) and
>> HVA have same alignment within PUD_SIZE or PMD_SIZE when we use
>> the HVA to request hugepage, so we don't need to consider PA
>> alignment when verifing block mapping. But for device memory
>> mapping, the PA and HVA may have different alignment.
>>
>> 2. For normal memory mapping, we are sure hugepage size properly
>> fit into vma, so we don't check whether the mapping size exceeds
>> the boundary of vma. But for device memory mapping, we should pay
>> attention to this.
>>
>> This adds get_vma_page_shift() to get page shift for both normal
>> memory and device MMIO region, and check these two points when
>> selecting block mapping size for MMIO region.
>>
>> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
>> ---
>>   arch/arm64/kvm/mmu.c | 61 ++++++++++++++++++++++++++++++++++++--------
>>   1 file changed, 51 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
>> index c59af5ca01b0..5a1cc7751e6d 100644
>> --- a/arch/arm64/kvm/mmu.c
>> +++ b/arch/arm64/kvm/mmu.c
>> @@ -738,6 +738,35 @@ transparent_hugepage_adjust(struct kvm_memory_slot *memslot,
>>       return PAGE_SIZE;
>>   }
>>   +static int get_vma_page_shift(struct vm_area_struct *vma, unsigned long hva)
>> +{
>> +    unsigned long pa;
>> +
>> +    if (is_vm_hugetlb_page(vma) && !(vma->vm_flags & VM_PFNMAP))
>> +        return huge_page_shift(hstate_vma(vma));
>> +
>> +    if (!(vma->vm_flags & VM_PFNMAP))
>> +        return PAGE_SHIFT;
>> +
>> +    VM_BUG_ON(is_vm_hugetlb_page(vma));
>> +
> 
> I don't understand how VM_PFNMAP is set for hugetlbfs related vma.
> I think they are exclusive, meaning the flag is never set for
> hugetlbfs vma. If it's true, VM_PFNMAP needn't be checked on hugetlbfs
> vma and the VM_BUG_ON() becomes unnecessary.
Yes, but we're not sure all drivers follow this rule. Add a BUG_ON() is
a way to catch issue.

> 
>> +    pa = (vma->vm_pgoff << PAGE_SHIFT) + (hva - vma->vm_start);
>> +
>> +#ifndef __PAGETABLE_PMD_FOLDED
>> +    if ((hva & (PUD_SIZE - 1)) == (pa & (PUD_SIZE - 1)) &&
>> +        ALIGN_DOWN(hva, PUD_SIZE) >= vma->vm_start &&
>> +        ALIGN(hva, PUD_SIZE) <= vma->vm_end)
>> +        return PUD_SHIFT;
>> +#endif
>> +
>> +    if ((hva & (PMD_SIZE - 1)) == (pa & (PMD_SIZE - 1)) &&
>> +        ALIGN_DOWN(hva, PMD_SIZE) >= vma->vm_start &&
>> +        ALIGN(hva, PMD_SIZE) <= vma->vm_end)
>> +        return PMD_SHIFT;
>> +
>> +    return PAGE_SHIFT;
>> +}
>> +
> 
> There is "switch(...)" fallback mechanism in user_mem_abort(). PUD_SIZE/PMD_SIZE
> can be downgraded accordingly if the addresses fails in the alignment check
> by fault_supports_stage2_huge_mapping(). I think it would make user_mem_abort()
> simplified if the logic can be moved to get_vma_page_shift().
> 
> Another question if we need the check from fault_supports_stage2_huge_mapping()
> if VM_PFNMAP area is going to be covered by block mapping. If so, the "switch(...)"
> fallback mechanism needs to be part of get_vma_page_shift().
Yes, Good suggestion. My idea is that we can keep this series simpler and do further
optimization in another patch series. Do you mind to send a patch?

Thanks,
Keqian
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
