Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABFB1FD113
	for <lists+kvmarm@lfdr.de>; Wed, 17 Jun 2020 17:34:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0CD144B1AA;
	Wed, 17 Jun 2020 11:34:25 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lUz3bZTYkT2q; Wed, 17 Jun 2020 11:34:24 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0760C4B173;
	Wed, 17 Jun 2020 11:34:23 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 135CE4B0D4
 for <kvmarm@lists.cs.columbia.edu>; Wed, 17 Jun 2020 11:34:22 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tP1aaUwfKbkc for <kvmarm@lists.cs.columbia.edu>;
 Wed, 17 Jun 2020 11:34:20 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DBC9C4B0D1
 for <kvmarm@lists.cs.columbia.edu>; Wed, 17 Jun 2020 11:34:20 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55BD131B;
 Wed, 17 Jun 2020 08:34:20 -0700 (PDT)
Received: from [192.168.1.84] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9374A3F73C;
 Wed, 17 Jun 2020 08:34:18 -0700 (PDT)
Subject: Re: [RFC PATCH 2/2] arm64: kvm: Introduce MTE VCPU feature
To: Catalin Marinas <catalin.marinas@arm.com>
References: <20200617123844.29960-1-steven.price@arm.com>
 <20200617123844.29960-3-steven.price@arm.com> <20200617143809.GF5388@gaia>
From: Steven Price <steven.price@arm.com>
Message-ID: <9d4ef6cf-2333-83b8-c555-e70b99b95b28@arm.com>
Date: Wed, 17 Jun 2020 16:34:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200617143809.GF5388@gaia>
Content-Language: en-GB
Cc: Marc Zyngier <maz@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Dave P Martin <Dave.Martin@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>
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

On 17/06/2020 15:38, Catalin Marinas wrote:
> On Wed, Jun 17, 2020 at 01:38:44PM +0100, Steven Price wrote:
>> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
>> index e3b9ee268823..040a7fffaa93 100644
>> --- a/virt/kvm/arm/mmu.c
>> +++ b/virt/kvm/arm/mmu.c
>> @@ -1783,6 +1783,17 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>   			vma_pagesize = PMD_SIZE;
>>   	}
>>   
>> +	if (system_supports_mte() && kvm->arch.vcpu_has_mte) {
>> +		/*
>> +		 * VM will be able to see the page's tags, so we must ensure
>> +		 * they have been initialised.
>> +		 */
>> +		struct page *page = pfn_to_page(pfn);
>> +
>> +		if (!test_and_set_bit(PG_mte_tagged, &page->flags))
>> +			mte_clear_page_tags(page_address(page), page_size(page));
>> +	}
> 
> Are all the guest pages always mapped via a Stage 2 fault? It may be
> better if we did that via kvm_set_spte_hva().
> 

I was under the impression that pages are always faulted into the stage 
2, but I have to admit I'm not 100% sure about that.

kvm_set_spte_hva() may be more appropriate, although on first look I 
don't understand how that function deals with huge pages. Is it actually 
called for normal mappings or only for changes due to the likes of KSM?

Steve
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
