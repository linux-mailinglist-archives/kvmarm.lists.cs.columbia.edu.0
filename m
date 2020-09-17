Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 061EB26D0B9
	for <lists+kvmarm@lfdr.de>; Thu, 17 Sep 2020 03:38:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3D4E54B61D;
	Wed, 16 Sep 2020 21:38:40 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lae8cjsX5d+s; Wed, 16 Sep 2020 21:38:40 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 286CC4B604;
	Wed, 16 Sep 2020 21:38:39 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4A6214B5E8
 for <kvmarm@lists.cs.columbia.edu>; Wed, 16 Sep 2020 21:38:37 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QZLhtaQq54Vm for <kvmarm@lists.cs.columbia.edu>;
 Wed, 16 Sep 2020 21:38:36 -0400 (EDT)
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D55F94B5E0
 for <kvmarm@lists.cs.columbia.edu>; Wed, 16 Sep 2020 21:38:35 -0400 (EDT)
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 4C4479FA31C5FF9D6CFA;
 Thu, 17 Sep 2020 09:38:32 +0800 (CST)
Received: from [127.0.0.1] (10.74.185.4) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Thu, 17 Sep 2020
 09:38:22 +0800
Subject: Re: [PATCH v2] KVM: arm64: fix doc warnings in mmu code
To: Will Deacon <will@kernel.org>
References: <1600221639-4471-1-git-send-email-tanxiaofei@huawei.com>
 <20200916083756.GD27496@willie-the-truck>
From: Xiaofei Tan <tanxiaofei@huawei.com>
Message-ID: <5F62BE0E.9060208@huawei.com>
Date: Thu, 17 Sep 2020 09:38:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20200916083756.GD27496@willie-the-truck>
X-Originating-IP: [10.74.185.4]
X-CFilter-Loop: Reflected
Cc: maz@kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com,
 catalin.marinas@arm.com, kvmarm@lists.cs.columbia.edu,
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


Hi Will,

Thanks for your advices, will accept all of them.

On 2020/9/16 16:37, Will Deacon wrote:
> On Wed, Sep 16, 2020 at 10:00:39AM +0800, Xiaofei Tan wrote:
>> Fix following warnings caused by mismatch bewteen function parameters
>> and comments.
>> arch/arm64/kvm/mmu.c:128: warning: Function parameter or member 'mmu' not described in '__unmap_stage2_range'
>> arch/arm64/kvm/mmu.c:128: warning: Function parameter or member 'may_block' not described in '__unmap_stage2_range'
>> arch/arm64/kvm/mmu.c:128: warning: Excess function parameter 'kvm' description in '__unmap_stage2_range'
>> arch/arm64/kvm/mmu.c:499: warning: Function parameter or member 'writable' not described in 'kvm_phys_addr_ioremap'
>> arch/arm64/kvm/mmu.c:538: warning: Function parameter or member 'mmu' not described in 'stage2_wp_range'
>> arch/arm64/kvm/mmu.c:538: warning: Excess function parameter 'kvm' description in 'stage2_wp_range'
>>
>> Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
>> ---
>>  arch/arm64/kvm/mmu.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
>> index e8a51799..909e995 100644
>> --- a/arch/arm64/kvm/mmu.c
>> +++ b/arch/arm64/kvm/mmu.c
>> @@ -114,9 +114,10 @@ static bool kvm_is_device_pfn(unsigned long pfn)
>>   */
>>  /**
>>   * unmap_stage2_range -- Clear stage2 page table entries to unmap a range
>> - * @kvm:   The VM pointer
>> + * @mmu:   pointer to mmu structure to operate on
>>   * @start: The intermediate physical base address of the range to unmap
>>   * @size:  The size of the area to unmap
>> + * @may_block: The flag that if block is allowed here
> 
> Whether or not we are permitted to block.
> 
>>   *
>>   * Clear a range of stage-2 mappings, lowering the various ref-counts.  Must
>>   * be called while holding mmu_lock (unless for freeing the stage2 pgd before
>> @@ -493,6 +494,7 @@ void kvm_free_stage2_pgd(struct kvm_s2_mmu *mmu)
>>   * @guest_ipa:	The IPA at which to insert the mapping
>>   * @pa:		The physical address of the device
>>   * @size:	The size of the mapping
>> + * @writable:   If it is writable here
> 
> Whether or not to create a writable mapping.
> 
>>   */
>>  int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
>>  			  phys_addr_t pa, unsigned long size, bool writable)
>> @@ -530,7 +532,7 @@ int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
>>  
>>  /**
>>   * stage2_wp_range() - write protect stage2 memory region range
>> - * @kvm:	The KVM pointer
>> + * @mmu:        pointer to mmu structure to operate on
> 
> The KVM stage-2 MMU pointer.
> 
> Will
> 
> .
> 

-- 
 thanks
tanxiaofei

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
