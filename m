Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 20B4C349EA2
	for <lists+kvmarm@lfdr.de>; Fri, 26 Mar 2021 02:25:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8B77C4B45E;
	Thu, 25 Mar 2021 21:25:14 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 11aVARJHcNmS; Thu, 25 Mar 2021 21:25:14 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 186724B478;
	Thu, 25 Mar 2021 21:25:13 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 052304B45F
 for <kvmarm@lists.cs.columbia.edu>; Thu, 25 Mar 2021 21:25:12 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kh38oNdilwJs for <kvmarm@lists.cs.columbia.edu>;
 Thu, 25 Mar 2021 21:25:09 -0400 (EDT)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 6B7AA4B45E
 for <kvmarm@lists.cs.columbia.edu>; Thu, 25 Mar 2021 21:25:08 -0400 (EDT)
Received: from dggeml406-hub.china.huawei.com (unknown [172.30.72.57])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4F643T5XHTz5j2k;
 Fri, 26 Mar 2021 09:23:01 +0800 (CST)
Received: from dggpemm500023.china.huawei.com (7.185.36.83) by
 dggeml406-hub.china.huawei.com (10.3.17.50) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Fri, 26 Mar 2021 09:24:59 +0800
Received: from [10.174.187.128] (10.174.187.128) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Fri, 26 Mar 2021 09:24:59 +0800
Subject: Re: [RFC PATCH 4/4] KVM: arm64: Distinguish cases of memcache
 allocations completely
To: Alexandru Elisei <alexandru.elisei@arm.com>, Marc Zyngier
 <maz@kernel.org>, Will Deacon <will@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, James Morse <james.morse@arm.com>, Julien Thierry
 <julien.thierry.kdev@gmail.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Gavin Shan <gshan@redhat.com>, Quentin Perret <qperret@google.com>,
 <kvmarm@lists.cs.columbia.edu>, <linux-arm-kernel@lists.infradead.org>,
 <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210208112250.163568-1-wangyanan55@huawei.com>
 <20210208112250.163568-5-wangyanan55@huawei.com>
 <2c65bff2-be7f-b20c-9265-939bc73185b6@arm.com>
From: "wangyanan (Y)" <wangyanan55@huawei.com>
Message-ID: <24b3f625-4d9c-cabe-5758-cfa9a1a2ce18@huawei.com>
Date: Fri, 26 Mar 2021 09:24:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <2c65bff2-be7f-b20c-9265-939bc73185b6@arm.com>
Content-Language: en-US
X-Originating-IP: [10.174.187.128]
X-ClientProxiedBy: dggeme720-chm.china.huawei.com (10.1.199.116) To
 dggpemm500023.china.huawei.com (7.185.36.83)
X-CFilter-Loop: Reflected
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

Hi Alex,

On 2021/3/26 1:26, Alexandru Elisei wrote:
> Hi Yanan,
>
> On 2/8/21 11:22 AM, Yanan Wang wrote:
>> With a guest translation fault, the memcache pages are not needed if KVM
>> is only about to install a new leaf entry into the existing page table.
>> And with a guest permission fault, the memcache pages are also not needed
>> for a write_fault in dirty-logging time if KVM is only about to update
>> the existing leaf entry instead of collapsing a block entry into a table.
>>
>> By comparing fault_granule and vma_pagesize, cases that require allocations
>> from memcache and cases that don't can be distinguished completely.
>>
>> Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
>> ---
>>   arch/arm64/kvm/mmu.c | 25 ++++++++++++-------------
>>   1 file changed, 12 insertions(+), 13 deletions(-)
>>
>> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
>> index d151927a7d62..550498a9104e 100644
>> --- a/arch/arm64/kvm/mmu.c
>> +++ b/arch/arm64/kvm/mmu.c
>> @@ -815,19 +815,6 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>   	gfn = fault_ipa >> PAGE_SHIFT;
>>   	mmap_read_unlock(current->mm);
>>   
>> -	/*
>> -	 * Permission faults just need to update the existing leaf entry,
>> -	 * and so normally don't require allocations from the memcache. The
>> -	 * only exception to this is when dirty logging is enabled at runtime
>> -	 * and a write fault needs to collapse a block entry into a table.
>> -	 */
>> -	if (fault_status != FSC_PERM || (logging_active && write_fault)) {
>> -		ret = kvm_mmu_topup_memory_cache(memcache,
>> -						 kvm_mmu_cache_min_pages(kvm));
>> -		if (ret)
>> -			return ret;
>> -	}
>> -
>>   	mmu_seq = vcpu->kvm->mmu_notifier_seq;
>>   	/*
>>   	 * Ensure the read of mmu_notifier_seq happens before we call
>> @@ -887,6 +874,18 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>   	else if (cpus_have_const_cap(ARM64_HAS_CACHE_DIC))
>>   		prot |= KVM_PGTABLE_PROT_X;
>>   
>> +	/*
>> +	 * Allocations from the memcache are required only when granule of the
>> +	 * lookup level where the guest fault happened exceeds vma_pagesize,
>> +	 * which means new page tables will be created in the fault handlers.
>> +	 */
>> +	if (fault_granule > vma_pagesize) {
>> +		ret = kvm_mmu_topup_memory_cache(memcache,
>> +						 kvm_mmu_cache_min_pages(kvm));
>> +		if (ret)
>> +			return ret;
>> +	}
> I distinguish three situations:
>
> 1. fault_granule == vma_pagesize. If the stage 2 fault occurs at the leaf level,
> then it means that all the tables that the translation table walker traversed
> until the leaf are valid. No need to allocate a new page, as stage 2 will only
> change the leaf to point to a valid PA.
>
> 2. fault_granule > vma_pagesize. This means that there's a table missing at some
> point in the table walk, so we're going to need to allocate at least one table to
> hold the leaf entry. We need to topup the memory cache.
>
> 3. fault_granule < vma_pagesize. From our discussion in patch #3, this can happen
> only if the userspace translation tables use a block mapping, dirty page logging
> is enabled, the fault_ipa is mapped as a last level entry, dirty page logging gets
> disabled and then we get a fault. In this case, the PTE table will be coalesced
> into a PMD block mapping, and the PMD table entry that pointed to the PTE table
> will be changed to a block mapping. No table will be allocated.
>
> Looks to me like this patch is valid, but getting it wrong can break a VM and I
> would feel a lot more comfortable if someone who is more familiar with the code
> would have a look.
Thanks for your explanation here. Above is also what I thought about 
this patch.

Thanks,
Yanan
>
> Thanks,
>
> Alex
>
>> +
>>   	/*
>>   	 * Under the premise of getting a FSC_PERM fault, we just need to relax
>>   	 * permissions only if vma_pagesize equals fault_granule. Otherwise,
> .
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
