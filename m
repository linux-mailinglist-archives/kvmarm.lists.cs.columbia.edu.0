Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7062D264694
	for <lists+kvmarm@lfdr.de>; Thu, 10 Sep 2020 15:09:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C24854B22A;
	Thu, 10 Sep 2020 09:09:12 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VnC1TUQ1TJAH; Thu, 10 Sep 2020 09:09:12 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 898074B1BF;
	Thu, 10 Sep 2020 09:09:11 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D12094B19B
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Sep 2020 09:09:09 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Tgo06nzaLgkx for <kvmarm@lists.cs.columbia.edu>;
 Thu, 10 Sep 2020 09:09:08 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9C77C4B11E
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Sep 2020 09:09:08 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D13F01063;
 Thu, 10 Sep 2020 06:09:07 -0700 (PDT)
Received: from [192.168.0.110] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 958A23F66E;
 Thu, 10 Sep 2020 06:09:06 -0700 (PDT)
Subject: Re: [PATCH v4 17/21] KVM: arm64: Convert user_mem_abort() to generic
 page-table API
To: Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>
References: <20200907152344.12978-1-will@kernel.org>
 <20200907152344.12978-18-will@kernel.org>
 <2ae77a66-9cc4-f4e1-9e98-a50d5891cf20@arm.com>
 <c2e5e055251db637327f81da452cea2c@kernel.org>
 <20200910105107.GA17887@willie-the-truck>
From: Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <41e4a714-138c-1132-575f-cfd8a447c7ef@arm.com>
Date: Thu, 10 Sep 2020 14:10:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200910105107.GA17887@willie-the-truck>
Content-Language: en-US
Cc: Catalin Marinas <catalin.marinas@arm.com>, kernel-team@android.com,
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

Hi,

On 9/10/20 11:51 AM, Will Deacon wrote:
> On Wed, Sep 09, 2020 at 06:12:29PM +0100, Marc Zyngier wrote:
>> On 2020-09-09 15:20, Alexandru Elisei wrote:
>>> On 9/7/20 4:23 PM, Will Deacon wrote:
>>>> @@ -1610,62 +1605,31 @@ static int user_mem_abort(struct kvm_vcpu
>>>> *vcpu, phys_addr_t fault_ipa,
>>>>  	if (vma_pagesize == PAGE_SIZE && !force_pte)
>>>>  		vma_pagesize = transparent_hugepage_adjust(memslot, hva,
>>>>  							   &pfn, &fault_ipa);
>>>> -	if (writable)
>>>> +	if (writable) {
>>>> +		prot |= KVM_PGTABLE_PROT_W;
>>>>  		kvm_set_pfn_dirty(pfn);
>>>> +		mark_page_dirty(kvm, gfn);
>>> The previous code called mark_page_dirty() only if the vma_pagesize ==
>>> PAGE_SIZE
>>> (and writable was true, obviously). Is this supposed to fix a bug?
>> No, this is actually introducing one. mark_page_dirty() checks that there is
>> an
>> associated bitmap, and thus only happens when writing to a single page, but
>> we
>> shouldn't do it for R/O memslots, which the current code avoids. It should
>> be
>> guarded by logging_active.
> gfn_to_pfn_prot() will set "writable" to false for R/O memslots, so I think
> we're good here.

That also looks correct to me, gfn_to_pfn_prot() -> __gfn_to_pfn_memslot() sets
*writable to false if the memslot is readonly.

Marc is also right, mark_page_dirty() first checks if there's a dirty bitmap
associated with the memslot, and memslot->dirty_bitmap gets allocated only if
KVM_SET_USER_MEMORY_REGION was called with the KVM_MEM_LOG_DIRTY_PAGES flag set
(should've checked for that before asking).

Thanks,
Alex
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
