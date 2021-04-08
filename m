Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6C379357D54
	for <lists+kvmarm@lfdr.de>; Thu,  8 Apr 2021 09:28:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D478E4B994;
	Thu,  8 Apr 2021 03:28:38 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s2U9gygxFeCM; Thu,  8 Apr 2021 03:28:38 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 767BC4B9AB;
	Thu,  8 Apr 2021 03:28:37 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0DEB24B947
 for <kvmarm@lists.cs.columbia.edu>; Thu,  8 Apr 2021 03:28:37 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0NhKL1Z-BTKS for <kvmarm@lists.cs.columbia.edu>;
 Thu,  8 Apr 2021 03:28:34 -0400 (EDT)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 63CD74B8F5
 for <kvmarm@lists.cs.columbia.edu>; Thu,  8 Apr 2021 03:28:33 -0400 (EDT)
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FGCVd17nRz1BFsl;
 Thu,  8 Apr 2021 15:26:17 +0800 (CST)
Received: from [10.174.184.42] (10.174.184.42) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Thu, 8 Apr 2021 15:28:18 +0800
Subject: Re: [RFC PATCH v2 2/2] kvm/arm64: Try stage2 block mapping for host
 device MMIO
To: Marc Zyngier <maz@kernel.org>
References: <20210316134338.18052-1-zhukeqian1@huawei.com>
 <20210316134338.18052-3-zhukeqian1@huawei.com> <878s5up71v.wl-maz@kernel.org>
From: Keqian Zhu <zhukeqian1@huawei.com>
Message-ID: <9f74392b-1086-a85e-72d8-f7bd99d65ea7@huawei.com>
Date: Thu, 8 Apr 2021 15:28:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <878s5up71v.wl-maz@kernel.org>
X-Originating-IP: [10.174.184.42]
X-CFilter-Loop: Reflected
Cc: kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 linux-kernel@vger.kernel.org, lushenming@huawei.com,
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

On 2021/4/7 21:18, Marc Zyngier wrote:
> On Tue, 16 Mar 2021 13:43:38 +0000,
> Keqian Zhu <zhukeqian1@huawei.com> wrote:
>>
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
>> This adds device_rough_page_shift() to check these two points when
>> selecting block mapping size.
>>
>> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
>> ---
>>
>> Mainly for RFC, not fully tested. I will fully test it when the
>> code logic is well accepted.
>>
>> ---
>>  arch/arm64/kvm/mmu.c | 42 ++++++++++++++++++++++++++++++++++++++----
>>  1 file changed, 38 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
>> index c59af5ca01b0..224aa15eb4d9 100644
>> --- a/arch/arm64/kvm/mmu.c
>> +++ b/arch/arm64/kvm/mmu.c
>> @@ -624,6 +624,36 @@ static void kvm_send_hwpoison_signal(unsigned long address, short lsb)
>>  	send_sig_mceerr(BUS_MCEERR_AR, (void __user *)address, lsb, current);
>>  }
>>  
>> +/*
>> + * Find a mapping size that properly insides the intersection of vma and
>> + * memslot. And hva and pa have the same alignment to this mapping size.
>> + * It's rough because there are still other restrictions, which will be
>> + * checked by the following fault_supports_stage2_huge_mapping().
> 
> I don't think these restrictions make complete sense to me. If this is
> a PFNMAP VMA, we should use the biggest mapping size that covers the
> VMA, and not more than the VMA.
But as described by kvm_arch_prepare_memory_region(), the memslot may not fully
cover the VMA. If that's true and we just consider the boundary of the VMA, our
block mapping may beyond the boundary of memslot. Is this a problem?

> 
>> + */
>> +static short device_rough_page_shift(struct kvm_memory_slot *memslot,
>> +				     struct vm_area_struct *vma,
>> +				     unsigned long hva)
>> +{
>> +	size_t size = memslot->npages * PAGE_SIZE;
>> +	hva_t sec_start = max(memslot->userspace_addr, vma->vm_start);
>> +	hva_t sec_end = min(memslot->userspace_addr + size, vma->vm_end);
>> +	phys_addr_t pa = (vma->vm_pgoff << PAGE_SHIFT) + (hva - vma->vm_start);
>> +
>> +#ifndef __PAGETABLE_PMD_FOLDED
>> +	if ((hva & (PUD_SIZE - 1)) == (pa & (PUD_SIZE - 1)) &&
>> +	    ALIGN_DOWN(hva, PUD_SIZE) >= sec_start &&
>> +	    ALIGN(hva, PUD_SIZE) <= sec_end)
>> +		return PUD_SHIFT;
>> +#endif
>> +
>> +	if ((hva & (PMD_SIZE - 1)) == (pa & (PMD_SIZE - 1)) &&
>> +	    ALIGN_DOWN(hva, PMD_SIZE) >= sec_start &&
>> +	    ALIGN(hva, PMD_SIZE) <= sec_end)
>> +		return PMD_SHIFT;
>> +
>> +	return PAGE_SHIFT;
>> +}
>> +
>>  static bool fault_supports_stage2_huge_mapping(struct kvm_memory_slot *memslot,
>>  					       unsigned long hva,
>>  					       unsigned long map_size)
>> @@ -769,7 +799,10 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>  		return -EFAULT;
>>  	}
>>  
>> -	/* Let's check if we will get back a huge page backed by hugetlbfs */
>> +	/*
>> +	 * Let's check if we will get back a huge page backed by hugetlbfs, or
>> +	 * get block mapping for device MMIO region.
>> +	 */
>>  	mmap_read_lock(current->mm);
>>  	vma = find_vma_intersection(current->mm, hva, hva + 1);
>>  	if (unlikely(!vma)) {
>> @@ -780,11 +813,12 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>  
>>  	if (is_vm_hugetlb_page(vma))
>>  		vma_shift = huge_page_shift(hstate_vma(vma));
>> +	else if (vma->vm_flags & VM_PFNMAP)
>> +		vma_shift = device_rough_page_shift(memslot, vma, hva);
>>  	else
>>  		vma_shift = PAGE_SHIFT;
>>  
>> -	if (logging_active ||
>> -	    (vma->vm_flags & VM_PFNMAP)) {
>> +	if (logging_active) {
>>  		force_pte = true;
>>  		vma_shift = PAGE_SHIFT;
> 
> But why should we downgrade to page-size mappings if logging? This is
> a device, and you aren't moving the device around, are you? Or is your
> device actually memory with a device mapping that you are trying to
> migrate?
Thanks for the point. We should not move the device around, so we do not
need to consider logging when we build mapping for device.

I found that logging_active is per memslot and we're sure it's always false
for memslot with PFNMAP VMA, because the kvm_arch_prepare_memory_region()
forbids that. Then I think we're OK here.

Thanks,
Keqian

> 
>>  	}
>> @@ -855,7 +889,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>  
>>  	if (kvm_is_device_pfn(pfn)) {
>>  		device = true;
>> -		force_pte = true;
>> +		force_pte = (vma_pagesize == PAGE_SIZE);
>>  	} else if (logging_active && !write_fault) {
>>  		/*
>>  		 * Only actually map the page as writable if this was a write
>> -- 
>> 2.19.1
>>
>>
> 
> Thanks,
> 
> 	M.
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
