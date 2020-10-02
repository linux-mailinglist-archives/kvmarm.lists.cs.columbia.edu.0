Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3362D2816A3
	for <lists+kvmarm@lfdr.de>; Fri,  2 Oct 2020 17:31:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AC5764B315;
	Fri,  2 Oct 2020 11:31:07 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YZs8jvtyydIq; Fri,  2 Oct 2020 11:31:07 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 426A84B30D;
	Fri,  2 Oct 2020 11:31:06 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 05B2A4B2EF
 for <kvmarm@lists.cs.columbia.edu>; Fri,  2 Oct 2020 11:31:04 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cLn+efSzaVQ8 for <kvmarm@lists.cs.columbia.edu>;
 Fri,  2 Oct 2020 11:31:02 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 26F0E4B2E7
 for <kvmarm@lists.cs.columbia.edu>; Fri,  2 Oct 2020 11:31:02 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9AEAE1396;
 Fri,  2 Oct 2020 08:31:01 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D9EF43F73B;
 Fri,  2 Oct 2020 08:30:58 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] arm64: kvm: Introduce MTE VCPU feature
To: Andrew Jones <drjones@redhat.com>
References: <20200925093607.3051-1-steven.price@arm.com>
 <20200925093607.3051-3-steven.price@arm.com>
 <20201002143050.zamkpmqysy6k5ngl@kamzik.brq.redhat.com>
From: Steven Price <steven.price@arm.com>
Message-ID: <8b617aef-2bff-8af0-df47-f9f863ab6fa0@arm.com>
Date: Fri, 2 Oct 2020 16:30:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201002143050.zamkpmqysy6k5ngl@kamzik.brq.redhat.com>
Content-Language: en-GB
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Juan Quintela <quintela@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 kvmarm@lists.cs.columbia.edu, Marc Zyngier <maz@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On 02/10/2020 15:30, Andrew Jones wrote:
> On Fri, Sep 25, 2020 at 10:36:07AM +0100, Steven Price wrote:
>> Add a new VM feature 'KVM_ARM_CAP_MTE' which enables memory tagging
>> for a VM. This exposes the feature to the guest and automatically tags
>> memory pages touched by the VM as PG_mte_tagged (and clears the tags
>> storage) to ensure that the guest cannot see stale tags, and so that the
>> tags are correctly saved/restored across swap.
>>
>> Signed-off-by: Steven Price <steven.price@arm.com>
>> ---
>>   arch/arm64/include/asm/kvm_emulate.h |  3 +++
>>   arch/arm64/include/asm/kvm_host.h    |  3 +++
>>   arch/arm64/kvm/arm.c                 |  9 +++++++++
>>   arch/arm64/kvm/mmu.c                 | 15 +++++++++++++++
>>   arch/arm64/kvm/sys_regs.c            |  6 +++++-
>>   include/uapi/linux/kvm.h             |  1 +
>>   6 files changed, 36 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
>> index 49a55be2b9a2..4923a566ae6e 100644
>> --- a/arch/arm64/include/asm/kvm_emulate.h
>> +++ b/arch/arm64/include/asm/kvm_emulate.h
>> @@ -79,6 +79,9 @@ static inline void vcpu_reset_hcr(struct kvm_vcpu *vcpu)
>>   	if (cpus_have_const_cap(ARM64_MISMATCHED_CACHE_TYPE) ||
>>   	    vcpu_el1_is_32bit(vcpu))
>>   		vcpu->arch.hcr_el2 |= HCR_TID2;
>> +
>> +	if (vcpu->kvm->arch.mte_enabled)
>> +		vcpu->arch.hcr_el2 |= HCR_ATA;
>>   }
>>   
>>   static inline unsigned long *vcpu_hcr(struct kvm_vcpu *vcpu)
>> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
>> index 4f4360dd149e..1379300c1487 100644
>> --- a/arch/arm64/include/asm/kvm_host.h
>> +++ b/arch/arm64/include/asm/kvm_host.h
>> @@ -110,6 +110,9 @@ struct kvm_arch {
>>   	 * supported.
>>   	 */
>>   	bool return_nisv_io_abort_to_user;
>> +
>> +	/* Memory Tagging Extension enabled for the guest */
>> +	bool mte_enabled;
>>   };
>>   
>>   struct kvm_vcpu_fault_info {
>> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
>> index 46dc3d75cf13..624edca0a1fa 100644
>> --- a/arch/arm64/kvm/arm.c
>> +++ b/arch/arm64/kvm/arm.c
>> @@ -87,6 +87,12 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
>>   		r = 0;
>>   		kvm->arch.return_nisv_io_abort_to_user = true;
>>   		break;
>> +	case KVM_CAP_ARM_MTE:
>> +		if (!system_supports_mte() || kvm->created_vcpus)
>> +			return -EINVAL;
>> +		r = 0;
>> +		kvm->arch.mte_enabled = true;
>> +		break;
>>   	default:
>>   		r = -EINVAL;
>>   		break;
>> @@ -206,6 +212,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>>   		 */
>>   		r = 1;
>>   		break;
>> +	case KVM_CAP_ARM_MTE:
>> +		r = system_supports_mte();
>> +		break;
>>   	default:
>>   		r = kvm_arch_vm_ioctl_check_extension(kvm, ext);
>>   		break;
>> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
>> index ba00bcc0c884..befb9e1f0aa6 100644
>> --- a/arch/arm64/kvm/mmu.c
>> +++ b/arch/arm64/kvm/mmu.c
>> @@ -1949,6 +1949,21 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>   	if (vma_pagesize == PAGE_SIZE && !force_pte)
>>   		vma_pagesize = transparent_hugepage_adjust(memslot, hva,
>>   							   &pfn, &fault_ipa);
>> +	if (system_supports_mte() && kvm->arch.mte_enabled && pfn_valid(pfn)) {
> 
> 'system_supports_mte() && kvm->arch.mte_enabled' is redundant, but I
> assume system_supports_mte() is there to improve the efficiency of the
> branch, as it's using cpus_have_const_cap().

system_supports_mte() compiles to 0 when MTE support isn't built in, so 
this code can be removed by the compiler, whereas with 
kvm->arch.mte_enabled I doubt the compiler can deduce that it is never set.

> Maybe a helper like
> 
>   static inline bool kvm_arm_mte_enabled(struct kvm *kvm)
>   {
>     return system_supports_mte() && kvm->arch.mte_enabled;
>   }
> 
> would allow both the more efficient branch and look less confusing
> where it gets used.

I wasn't sure it was worth having a helper since this was the only place 
checking this condition. It's also a bit tricky putting this in a 
logical header file, kvm_host.h doesn't work because struct kvm hasn't 
been defined by then.

Steve

>> +		/*
>> +		 * VM will be able to see the page's tags, so we must ensure
>> +		 * they have been initialised.
>> +		 */
>> +		struct page *page = pfn_to_page(pfn);
>> +		long i, nr_pages = compound_nr(page);
>> +
>> +		/* if PG_mte_tagged is set, tags have already been initialised */
>> +		for (i = 0; i < nr_pages; i++, page++) {
>> +			if (!test_and_set_bit(PG_mte_tagged, &page->flags))
>> +				mte_clear_page_tags(page_address(page));
>> +		}
>> +	}
>> +
>>   	if (writable)
>>   		kvm_set_pfn_dirty(pfn);
>>   
>> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>> index a655f172b5ad..5010a47152b4 100644
>> --- a/arch/arm64/kvm/sys_regs.c
>> +++ b/arch/arm64/kvm/sys_regs.c
>> @@ -1132,7 +1132,8 @@ static u64 read_id_reg(const struct kvm_vcpu *vcpu,
>>   			val &= ~(0xfUL << ID_AA64PFR0_SVE_SHIFT);
>>   		val &= ~(0xfUL << ID_AA64PFR0_AMU_SHIFT);
>>   	} else if (id == SYS_ID_AA64PFR1_EL1) {
>> -		val &= ~(0xfUL << ID_AA64PFR1_MTE_SHIFT);
>> +		if (!vcpu->kvm->arch.mte_enabled)
>> +			val &= ~(0xfUL << ID_AA64PFR1_MTE_SHIFT);
>>   	} else if (id == SYS_ID_AA64ISAR1_EL1 && !vcpu_has_ptrauth(vcpu)) {
>>   		val &= ~((0xfUL << ID_AA64ISAR1_APA_SHIFT) |
>>   			 (0xfUL << ID_AA64ISAR1_API_SHIFT) |
>> @@ -1394,6 +1395,9 @@ static bool access_mte_regs(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
>>   static unsigned int mte_visibility(const struct kvm_vcpu *vcpu,
>>   				   const struct sys_reg_desc *rd)
>>   {
>> +	if (vcpu->kvm->arch.mte_enabled)
>> +		return 0;
>> +
>>   	return REG_HIDDEN_USER | REG_HIDDEN_GUEST;
>>   }
>>   
>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>> index f6d86033c4fa..87678ed82ab4 100644
>> --- a/include/uapi/linux/kvm.h
>> +++ b/include/uapi/linux/kvm.h
>> @@ -1035,6 +1035,7 @@ struct kvm_ppc_resize_hpt {
>>   #define KVM_CAP_LAST_CPU 184
>>   #define KVM_CAP_SMALLER_MAXPHYADDR 185
>>   #define KVM_CAP_S390_DIAG318 186
>> +#define KVM_CAP_ARM_MTE 188
>>   
>>   #ifdef KVM_CAP_IRQ_ROUTING
>>   
>> -- 
>> 2.20.1
>>
>>
> 
> Besides the helper suggestion nit
> 
> Reviewed-by: Andrew Jones <drjones@redhat.com>
> 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
