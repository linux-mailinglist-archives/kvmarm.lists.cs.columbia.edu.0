Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 626D1366549
	for <lists+kvmarm@lfdr.de>; Wed, 21 Apr 2021 08:18:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D6D5E4B49E;
	Wed, 21 Apr 2021 02:18:06 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7I5iK7gLdQV9; Wed, 21 Apr 2021 02:18:06 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 167154B49A;
	Wed, 21 Apr 2021 02:18:03 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 304974B47E
 for <kvmarm@lists.cs.columbia.edu>; Wed, 21 Apr 2021 02:18:02 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N2s5vlnNLVeX for <kvmarm@lists.cs.columbia.edu>;
 Wed, 21 Apr 2021 02:17:58 -0400 (EDT)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id BFF264B47B
 for <kvmarm@lists.cs.columbia.edu>; Wed, 21 Apr 2021 02:17:57 -0400 (EDT)
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FQ9JF16xfzPsbv;
 Wed, 21 Apr 2021 14:14:53 +0800 (CST)
Received: from [10.174.187.224] (10.174.187.224) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Wed, 21 Apr 2021 14:17:44 +0800
Subject: Re: [PATCH] KVM: arm64: Correctly handle the mmio faulting
To: Gavin Shan <gshan@redhat.com>, Santosh Shukla <sashukla@nvidia.com>
References: <1603297010-18787-1-git-send-email-sashukla@nvidia.com>
 <8b20dfc0-3b5e-c658-c47d-ebc50d20568d@huawei.com>
 <2e23aaa7-0c8d-13ba-2eae-9e6ab2adc587@redhat.com>
From: Keqian Zhu <zhukeqian1@huawei.com>
Message-ID: <ed8a8b90-8b96-4967-01f5-cd0f536c38d2@huawei.com>
Date: Wed, 21 Apr 2021 14:17:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <2e23aaa7-0c8d-13ba-2eae-9e6ab2adc587@redhat.com>
X-Originating-IP: [10.174.187.224]
X-CFilter-Loop: Reflected
Cc: cjia@nvidia.com, kvm@vger.kernel.org, maz@kernel.org,
 linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
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

Hi Gavin,

On 2021/4/21 14:20, Gavin Shan wrote:
> Hi Keqian and Santosh,
> 
> On 4/21/21 12:59 PM, Keqian Zhu wrote:
>> On 2020/10/22 0:16, Santosh Shukla wrote:
>>> The Commit:6d674e28 introduces a notion to detect and handle the
>>> device mapping. The commit checks for the VM_PFNMAP flag is set
>>> in vma->flags and if set then marks force_pte to true such that
>>> if force_pte is true then ignore the THP function check
>>> (/transparent_hugepage_adjust()).
>>>
>>> There could be an issue with the VM_PFNMAP flag setting and checking.
>>> For example consider a case where the mdev vendor driver register's
>>> the vma_fault handler named vma_mmio_fault(), which maps the
>>> host MMIO region in-turn calls remap_pfn_range() and maps
>>> the MMIO's vma space. Where, remap_pfn_range implicitly sets
>>> the VM_PFNMAP flag into vma->flags.
>> Could you give the name of the mdev vendor driver that triggers this issue?
>> I failed to find one according to your description. Thanks.
>>
> 
> I think it would be fixed in driver side to set VM_PFNMAP in
> its mmap() callback (call_mmap()), like vfio PCI driver does.
> It means it won't be delayed until page fault is issued and
> remap_pfn_range() is called. It's determined from the beginning
> that the vma associated the mdev vendor driver is serving as
> PFN remapping purpose. So the vma should be populated completely,
> including the VM_PFNMAP flag before it becomes visible to user
> space.
> 
> The example can be found from vfio driver in drivers/vfio/pci/vfio_pci.c:
>     vfio_pci_mmap:       VM_PFNMAP is set for the vma
>     vfio_pci_mmap_fault: remap_pfn_range() is called
Right. I have discussed the above with Marc. I want to find the driver
to fix it. However, AFAICS, there is no driver matches the description...

Thanks,
Keqian

> 
> Thanks,
> Gavin
> 
>>>
>>> Now lets assume a mmio fault handing flow where guest first access
>>> the MMIO region whose 2nd stage translation is not present.
>>> So that results to arm64-kvm hypervisor executing guest abort handler,
>>> like below:
>>>
>>> kvm_handle_guest_abort() -->
>>>   user_mem_abort()--> {
>>>
>>>      ...
>>>      0. checks the vma->flags for the VM_PFNMAP.
>>>      1. Since VM_PFNMAP flag is not yet set so force_pte _is_ false;
>>>      2. gfn_to_pfn_prot() -->
>>>          __gfn_to_pfn_memslot() -->
>>>              fixup_user_fault() -->
>>>                  handle_mm_fault()-->
>>>                      __do_fault() -->
>>>                         vma_mmio_fault() --> // vendor's mdev fault handler
>>>                          remap_pfn_range()--> // Here sets the VM_PFNMAP
>>>                         flag into vma->flags.
>>>      3. Now that force_pte is set to false in step-2),
>>>         will execute transparent_hugepage_adjust() func and
>>>         that lead to Oops [4].
>>>   }
>>>
>>> The proposition is to check is_iomap flag before executing the THP
>>> function transparent_hugepage_adjust().
>>>
>>> [4] THP Oops:
>>>> pc: kvm_is_transparent_hugepage+0x18/0xb0
>>>> ...
>>>> ...
>>>> user_mem_abort+0x340/0x9b8
>>>> kvm_handle_guest_abort+0x248/0x468
>>>> handle_exit+0x150/0x1b0
>>>> kvm_arch_vcpu_ioctl_run+0x4d4/0x778
>>>> kvm_vcpu_ioctl+0x3c0/0x858
>>>> ksys_ioctl+0x84/0xb8
>>>> __arm64_sys_ioctl+0x28/0x38
>>>
>>> Tested on Huawei Kunpeng Taishan-200 arm64 server, Using VFIO-mdev device.
>>> Linux tip: 583090b1
>>>
>>> Fixes: 6d674e28 ("KVM: arm/arm64: Properly handle faulting of device mappings")
>>> Signed-off-by: Santosh Shukla <sashukla@nvidia.com>
>>> ---
>>>   arch/arm64/kvm/mmu.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
>>> index 3d26b47..ff15357 100644
>>> --- a/arch/arm64/kvm/mmu.c
>>> +++ b/arch/arm64/kvm/mmu.c
>>> @@ -1947,7 +1947,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>>        * If we are not forced to use page mapping, check if we are
>>>        * backed by a THP and thus use block mapping if possible.
>>>        */
>>> -    if (vma_pagesize == PAGE_SIZE && !force_pte)
>>> +    if (vma_pagesize == PAGE_SIZE && !force_pte && !is_iomap(flags))
>>>           vma_pagesize = transparent_hugepage_adjust(memslot, hva,
>>>                                  &pfn, &fault_ipa);
>>>       if (writable)
>>>
>>
> 
> .
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
