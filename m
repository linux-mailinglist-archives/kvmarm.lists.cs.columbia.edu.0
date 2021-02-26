Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 74937326510
	for <lists+kvmarm@lfdr.de>; Fri, 26 Feb 2021 16:58:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 079F24B2F6;
	Fri, 26 Feb 2021 10:58:22 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0acTTYRNKeXh; Fri, 26 Feb 2021 10:58:21 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 77ECF4B1BA;
	Fri, 26 Feb 2021 10:58:20 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5A67A4B152
 for <kvmarm@lists.cs.columbia.edu>; Fri, 26 Feb 2021 10:58:19 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gPrXTQ1SlVwq for <kvmarm@lists.cs.columbia.edu>;
 Fri, 26 Feb 2021 10:58:17 -0500 (EST)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 7DB7D4B14E
 for <kvmarm@lists.cs.columbia.edu>; Fri, 26 Feb 2021 10:58:17 -0500 (EST)
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.55])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4DnDlr1xDyz5Vws;
 Fri, 26 Feb 2021 23:56:08 +0800 (CST)
Received: from [10.174.187.128] (10.174.187.128) by
 dggeme752-chm.china.huawei.com (10.3.19.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Fri, 26 Feb 2021 23:58:10 +0800
Subject: Re: [RFC PATCH 1/4] KVM: arm64: Move the clean of dcache to the map
 handler
To: Marc Zyngier <maz@kernel.org>
References: <20210208112250.163568-1-wangyanan55@huawei.com>
 <20210208112250.163568-2-wangyanan55@huawei.com>
 <871rd41ngf.wl-maz@kernel.org>
From: "wangyanan (Y)" <wangyanan55@huawei.com>
Message-ID: <6b6e56db-2111-f1ed-da6d-1fb622239851@huawei.com>
Date: Fri, 26 Feb 2021 23:58:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <871rd41ngf.wl-maz@kernel.org>
Content-Language: en-US
X-Originating-IP: [10.174.187.128]
X-ClientProxiedBy: dggeme712-chm.china.huawei.com (10.1.199.108) To
 dggeme752-chm.china.huawei.com (10.3.19.98)
X-CFilter-Loop: Reflected
Cc: kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu


On 2021/2/25 17:55, Marc Zyngier wrote:
> Hi Yanan,
>
> On Mon, 08 Feb 2021 11:22:47 +0000,
> Yanan Wang <wangyanan55@huawei.com> wrote:
>> We currently uniformly clean dcache in user_mem_abort() before calling the
>> fault handlers, if we take a translation fault and the pfn is cacheable.
>> But if there are concurrent translation faults on the same page or block,
>> clean of dcache for the first time is necessary while the others are not.
>>
>> By moving clean of dcache to the map handler, we can easily identify the
>> conditions where CMOs are really needed and avoid the unnecessary ones.
>> As it's a time consuming process to perform CMOs especially when flushing
>> a block range, so this solution reduces much load of kvm and improve the
>> efficiency of creating mappings.
> That's an interesting approach. However, wouldn't it be better to
> identify early that there is already something mapped, and return to
> the guest ASAP?
>
> Can you quantify the benefit of this patch alone?
>
>> Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
>> ---
>>   arch/arm64/include/asm/kvm_mmu.h | 16 --------------
>>   arch/arm64/kvm/hyp/pgtable.c     | 38 ++++++++++++++++++++------------
>>   arch/arm64/kvm/mmu.c             | 14 +++---------
>>   3 files changed, 27 insertions(+), 41 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
>> index e52d82aeadca..4ec9879e82ed 100644
>> --- a/arch/arm64/include/asm/kvm_mmu.h
>> +++ b/arch/arm64/include/asm/kvm_mmu.h
>> @@ -204,22 +204,6 @@ static inline bool vcpu_has_cache_enabled(struct kvm_vcpu *vcpu)
>>   	return (vcpu_read_sys_reg(vcpu, SCTLR_EL1) & 0b101) == 0b101;
>>   }
>>   
>> -static inline void __clean_dcache_guest_page(kvm_pfn_t pfn, unsigned long size)
>> -{
>> -	void *va = page_address(pfn_to_page(pfn));
>> -
>> -	/*
>> -	 * With FWB, we ensure that the guest always accesses memory using
>> -	 * cacheable attributes, and we don't have to clean to PoC when
>> -	 * faulting in pages. Furthermore, FWB implies IDC, so cleaning to
>> -	 * PoU is not required either in this case.
>> -	 */
>> -	if (cpus_have_const_cap(ARM64_HAS_STAGE2_FWB))
>> -		return;
>> -
>> -	kvm_flush_dcache_to_poc(va, size);
>> -}
>> -
>>   static inline void __invalidate_icache_guest_page(kvm_pfn_t pfn,
>>   						  unsigned long size)
>>   {
>> diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
>> index 4d177ce1d536..2f4f87021980 100644
>> --- a/arch/arm64/kvm/hyp/pgtable.c
>> +++ b/arch/arm64/kvm/hyp/pgtable.c
>> @@ -464,6 +464,26 @@ static int stage2_map_set_prot_attr(enum kvm_pgtable_prot prot,
>>   	return 0;
>>   }
>>   
>> +static bool stage2_pte_cacheable(kvm_pte_t pte)
>> +{
>> +	u64 memattr = pte & KVM_PTE_LEAF_ATTR_LO_S2_MEMATTR;
>> +	return memattr == PAGE_S2_MEMATTR(NORMAL);
>> +}
>> +
>> +static void stage2_flush_dcache(void *addr, u64 size)
>> +{
>> +	/*
>> +	 * With FWB, we ensure that the guest always accesses memory using
>> +	 * cacheable attributes, and we don't have to clean to PoC when
>> +	 * faulting in pages. Furthermore, FWB implies IDC, so cleaning to
>> +	 * PoU is not required either in this case.
>> +	 */
>> +	if (cpus_have_const_cap(ARM64_HAS_STAGE2_FWB))
>> +		return;
>> +
>> +	__flush_dcache_area(addr, size);
>> +}
>> +
>>   static int stage2_map_walker_try_leaf(u64 addr, u64 end, u32 level,
>>   				      kvm_pte_t *ptep,
>>   				      struct stage2_map_data *data)
>> @@ -495,6 +515,10 @@ static int stage2_map_walker_try_leaf(u64 addr, u64 end, u32 level,
>>   		put_page(page);
>>   	}
>>   
>> +	/* Flush data cache before installation of the new PTE */
>> +	if (stage2_pte_cacheable(new))
>> +		stage2_flush_dcache(__va(phys), granule);
>> +
>>   	smp_store_release(ptep, new);
>>   	get_page(page);
>>   	data->phys += granule;
>> @@ -651,20 +675,6 @@ int kvm_pgtable_stage2_map(struct kvm_pgtable *pgt, u64 addr, u64 size,
>>   	return ret;
>>   }
>>   
>> -static void stage2_flush_dcache(void *addr, u64 size)
>> -{
>> -	if (cpus_have_const_cap(ARM64_HAS_STAGE2_FWB))
>> -		return;
>> -
>> -	__flush_dcache_area(addr, size);
>> -}
>> -
>> -static bool stage2_pte_cacheable(kvm_pte_t pte)
>> -{
>> -	u64 memattr = pte & KVM_PTE_LEAF_ATTR_LO_S2_MEMATTR;
>> -	return memattr == PAGE_S2_MEMATTR(NORMAL);
>> -}
>> -
>>   static int stage2_unmap_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
>>   			       enum kvm_pgtable_walk_flags flag,
>>   			       void * const arg)
>> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
>> index 77cb2d28f2a4..d151927a7d62 100644
>> --- a/arch/arm64/kvm/mmu.c
>> +++ b/arch/arm64/kvm/mmu.c
>> @@ -609,11 +609,6 @@ void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
>>   	kvm_mmu_write_protect_pt_masked(kvm, slot, gfn_offset, mask);
>>   }
>>   
>> -static void clean_dcache_guest_page(kvm_pfn_t pfn, unsigned long size)
>> -{
>> -	__clean_dcache_guest_page(pfn, size);
>> -}
>> -
>>   static void invalidate_icache_guest_page(kvm_pfn_t pfn, unsigned long size)
>>   {
>>   	__invalidate_icache_guest_page(pfn, size);
>> @@ -882,9 +877,6 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>   	if (writable)
>>   		prot |= KVM_PGTABLE_PROT_W;
>>   
>> -	if (fault_status != FSC_PERM && !device)
>> -		clean_dcache_guest_page(pfn, vma_pagesize);
>> -
>>   	if (exec_fault) {
>>   		prot |= KVM_PGTABLE_PROT_X;
>>   		invalidate_icache_guest_page(pfn, vma_pagesize);
> It seems that the I-side CMO now happens *before* the D-side, which
> seems odd.

Yes, indeed. It is not so right in principle to put invalidation of 
icache before flush of dcache.

Thanks,

Yanan

> What prevents the CPU from speculatively fetching
> instructions in the interval? I would also feel much more confident if
> the two were kept close together.
>
> Thanks,
>
> 	M.
>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
