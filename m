Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5432B92B6
	for <lists+kvmarm@lfdr.de>; Thu, 19 Nov 2020 13:46:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BD2774B47D;
	Thu, 19 Nov 2020 07:46:00 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1CQF2aoZSl0w; Thu, 19 Nov 2020 07:46:00 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6D53F4B3E2;
	Thu, 19 Nov 2020 07:45:59 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D6D4D4B3DC
 for <kvmarm@lists.cs.columbia.edu>; Thu, 19 Nov 2020 07:45:57 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pu-gEvvvtLgd for <kvmarm@lists.cs.columbia.edu>;
 Thu, 19 Nov 2020 07:45:56 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 80A574B3D9
 for <kvmarm@lists.cs.columbia.edu>; Thu, 19 Nov 2020 07:45:56 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0ED1A1396;
 Thu, 19 Nov 2020 04:45:56 -0800 (PST)
Received: from [192.168.1.179] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8FFD83F718;
 Thu, 19 Nov 2020 04:45:53 -0800 (PST)
Subject: Re: [PATCH v4 2/2] arm64: kvm: Introduce MTE VCPU feature
To: Andrew Jones <drjones@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>
References: <20201026155727.36685-1-steven.price@arm.com>
 <20201026155727.36685-3-steven.price@arm.com> <X7P1VLZhBh045tsr@trantor>
 <f34b3d16-8bc7-af9d-c0e0-fb114d2465aa@arm.com> <X7VQua7YO4isMFPU@trantor>
 <20201118170552.cuczyylf34ows5jd@kamzik.brq.redhat.com>
From: Steven Price <steven.price@arm.com>
Message-ID: <f4f7073c-a0d5-f259-8fbc-514c0c5ddbed@arm.com>
Date: Thu, 19 Nov 2020 12:45:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201118170552.cuczyylf34ows5jd@kamzik.brq.redhat.com>
Content-Language: en-GB
Cc: Marc Zyngier <maz@kernel.org>, Juan Quintela <quintela@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org
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

On 18/11/2020 17:05, Andrew Jones wrote:
> On Wed, Nov 18, 2020 at 04:50:01PM +0000, Catalin Marinas wrote:
>> On Wed, Nov 18, 2020 at 04:01:20PM +0000, Steven Price wrote:
>>> On 17/11/2020 16:07, Catalin Marinas wrote:
>>>> On Mon, Oct 26, 2020 at 03:57:27PM +0000, Steven Price wrote:
>>>>> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
>>>>> index 19aacc7d64de..38fe25310ca1 100644
>>>>> --- a/arch/arm64/kvm/mmu.c
>>>>> +++ b/arch/arm64/kvm/mmu.c
>>>>> @@ -862,6 +862,26 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>>>>    	if (vma_pagesize == PAGE_SIZE && !force_pte)
>>>>>    		vma_pagesize = transparent_hugepage_adjust(memslot, hva,
>>>>>    							   &pfn, &fault_ipa);
>>>>> +
>>>>> +	/*
>>>>> +	 * The otherwise redundant test for system_supports_mte() allows the
>>>>> +	 * code to be compiled out when CONFIG_ARM64_MTE is not present.
>>>>> +	 */
>>>>> +	if (system_supports_mte() && kvm->arch.mte_enabled && pfn_valid(pfn)) {
>>>>> +		/*
>>>>> +		 * VM will be able to see the page's tags, so we must ensure
>>>>> +		 * they have been initialised.
>>>>> +		 */
>>>>> +		struct page *page = pfn_to_page(pfn);
>>>>> +		long i, nr_pages = compound_nr(page);
>>>>> +
>>>>> +		/* if PG_mte_tagged is set, tags have already been initialised */
>>>>> +		for (i = 0; i < nr_pages; i++, page++) {
>>>>> +			if (!test_and_set_bit(PG_mte_tagged, &page->flags))
>>>>> +				mte_clear_page_tags(page_address(page));
>>>>> +		}
>>>>> +	}
>>>>
>>>> If this page was swapped out and mapped back in, where does the
>>>> restoring from swap happen?
>>>
>>> Restoring from swap happens above this in the call to gfn_to_pfn_prot()
>>
>> Looking at the call chain, gfn_to_pfn_prot() ends up with
>> get_user_pages() using the current->mm (the VMM) and that does a
>> set_pte_at(), presumably restoring the tags. Does this mean that all
>> memory mapped by the VMM in user space should have PROT_MTE set?
>> Otherwise we don't take the mte_sync_tags() path in set_pte_at() and no
>> tags restored from swap (we do save them since when they were mapped,
>> PG_mte_tagged was set).
>>
>> So I think the code above should be similar to mte_sync_tags(), even
>> calling a common function, but I'm not sure where to get the swap pte
>> from.

You're right - the code is broken as it stands. I've just been able to 
reproduce the loss of tags due to swap.

The problem is that we also don't have a suitable pte to do the restore 
from swap from. So either set_pte_at() would have to unconditionally 
check for MTE tags for all previous swap entries as you suggest below. I 
had a quick go at testing this and hit issues with the idle task getting 
killed during boot - I fear there are some fun issues regarding 
initialisation order here.

Or we enforce PROT_MTE...

>> An alternative is to only enable HCR_EL2.ATA and MTE in guest if the vmm
>> mapped the memory with PROT_MTE.
> 
> This is a very reasonable alternative. The VMM must be aware of whether
> the guest may use MTE anyway. Asking it to map the memory with PROT_MTE
> when it wants to offer the guest that option is a reasonable requirement.
> If the memory is not mapped as such, then the host kernel shouldn't assume
> MTE may be used by the guest, and it should even enforce that it is not
> (by not enabling the feature).

The main issue with this is that the VMM can change the mappings while 
the guest is running, so the only place we can reliably check this is 
during user_mem_abort(). So we can't just downgrade HCR_EL2.ATA. This 
makes the error reporting not so great as the memory access is simply 
faulted. However I do have this working and it's actually (slightly) 
less code.

Another drawback is that the VMM needs to be more careful with the tags 
- e.g. for virtualised devices the VMM can't simply have a non-PROT_MTE 
mapping and ignore what the guest is doing with tags.

Steve
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
