Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E47E748D338
	for <lists+kvmarm@lfdr.de>; Thu, 13 Jan 2022 08:56:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 39AB84B11F;
	Thu, 13 Jan 2022 02:56:10 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E11TWjxoz0Ks; Thu, 13 Jan 2022 02:56:10 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 999794B0CB;
	Thu, 13 Jan 2022 02:56:08 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1359849F5D
 for <kvmarm@lists.cs.columbia.edu>; Thu, 13 Jan 2022 02:56:07 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4GkHSs6tp9Mc for <kvmarm@lists.cs.columbia.edu>;
 Thu, 13 Jan 2022 02:56:05 -0500 (EST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 62FD249F40
 for <kvmarm@lists.cs.columbia.edu>; Thu, 13 Jan 2022 02:56:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642060565;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=58PeUcHgXyMpJne7/ixWgpWL7455UdccWevxMoLDddg=;
 b=XxjcIJeQ1LQS/0jQEKqr7woXE+UMV+nKSo5UBVp44rRdyK6Xd18ViXT+6d+Yt75gBl8n74
 UIhdvdlS0ZxO7ky1gPw9SLfpyT+3QlxQGNEBgtUZ108B3zXviBAJY1wMAHUZE86tD1weeD
 ujHAfWKLdh+dICOIDTQX8MnqFiMuZRo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-201-BdWURdKdOrqeskXnRsVnQg-1; Thu, 13 Jan 2022 02:56:01 -0500
X-MC-Unique: BdWURdKdOrqeskXnRsVnQg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0432100C619;
 Thu, 13 Jan 2022 07:55:59 +0000 (UTC)
Received: from [10.72.13.202] (ovpn-13-202.pek2.redhat.com [10.72.13.202])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D17381059154;
 Thu, 13 Jan 2022 07:55:51 +0000 (UTC)
Subject: Re: [PATCH v4 05/15] KVM: arm64: Export kvm_handle_user_mem_abort()
To: Eric Auger <eauger@redhat.com>, kvmarm@lists.cs.columbia.edu
References: <20210815005947.83699-1-gshan@redhat.com>
 <20210815005947.83699-6-gshan@redhat.com>
 <53a578a1-6005-8e66-dda1-bd75d3a6f264@redhat.com>
From: Gavin Shan <gshan@redhat.com>
Message-ID: <4950704f-316f-e15c-2fc4-7e3ab2505363@redhat.com>
Date: Thu, 13 Jan 2022 15:55:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <53a578a1-6005-8e66-dda1-bd75d3a6f264@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: kvm@vger.kernel.org, maz@kernel.org, linux-kernel@vger.kernel.org,
 shan.gavin@gmail.com, Jonathan.Cameron@huawei.com, pbonzini@redhat.com,
 vkuznets@redhat.com, will@kernel.org
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
Reply-To: Gavin Shan <gshan@redhat.com>
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

Hi Eric,

On 11/11/21 2:02 AM, Eric Auger wrote:
> On 8/15/21 2:59 AM, Gavin Shan wrote:
>> The main work of stage-2 page fault is handled by user_mem_abort().
>> When asynchronous page fault is supported, one page fault need to
>> be handled with two calls to this function. It means the page fault
>> needs to be replayed asynchronously in that case.
>>
>>     * This renames the function to kvm_handle_user_mem_abort() and
>>       exports it.
>>
>>     * Add arguments @esr and @prefault to user_mem_abort(). @esr is
>>       the cached value of ESR_EL2 instead of fetching from the current
>>       vCPU when the page fault is replayed in scenario of asynchronous
>>       page fault. @prefault is used to indicate the page fault is replayed
>>       one or not.
> Also explain that fault_status arg is not needed anymore as derived from
> @esr because otherwise at first sight a distracted reviewer like me may
> have the impression you replaced fault_status by prefault while it is
> totally unrelated

Yep, good point. Will do in next respin.

>>
>>     * Define helper functions esr_dbat_*() in asm/esr.h to extract
>>       or check various fields of the passed ESR_EL2 value because
>>       those helper functions defined in asm/kvm_emulate.h assumes
>>       the ESR_EL2 value has been cached in vCPU struct. It won't
>>       be true on handling the replayed page fault in scenario of
>>       asynchronous page fault.
> I would introduce a seperate preliminary patch with those esr macros and
> changes to the call sites + changes below.

Ok. I will split this patch into two.

>>
>>     * Some helper functions defined in asm/kvm_emulate.h are used
>>       by mmu.c only and seem not to be used by other source file
>>       in near future. They are moved to mmu.c and renamed accordingly.>
>>       is_exec_fault: kvm_vcpu_trap_is_exec_fault
>>       is_write_fault: kvm_is_write_fault()
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   arch/arm64/include/asm/esr.h         |  6 ++++
>>   arch/arm64/include/asm/kvm_emulate.h | 27 ++---------------
>>   arch/arm64/include/asm/kvm_host.h    |  4 +++
>>   arch/arm64/kvm/mmu.c                 | 43 ++++++++++++++++++++++------
>>   4 files changed, 48 insertions(+), 32 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
>> index 29f97eb3dad4..0f2cb27691de 100644
>> --- a/arch/arm64/include/asm/esr.h
>> +++ b/arch/arm64/include/asm/esr.h
>> @@ -321,8 +321,14 @@
>>   					 ESR_ELx_CP15_32_ISS_DIR_READ)
>>   
>>   #ifndef __ASSEMBLY__
>> +#include <linux/bitfield.h>
>>   #include <asm/types.h>
>>   
>> +#define esr_dabt_fault_type(esr)	(esr & ESR_ELx_FSC_TYPE)
>> +#define esr_dabt_fault_level(esr)	(FIELD_GET(ESR_ELx_FSC_LEVEL, esr))
>> +#define esr_dabt_is_wnr(esr)		(!!(FIELD_GET(ESR_ELx_WNR, esr)))
>> +#define esr_dabt_is_s1ptw(esr)		(!!(FIELD_GET(ESR_ELx_S1PTW, esr)))
>> +
>>   static inline bool esr_is_data_abort(u32 esr)
>>   {
>>   	const u32 ec = ESR_ELx_EC(esr);
>> diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
>> index 923b4d08ea9a..90742f4b1acd 100644
>> --- a/arch/arm64/include/asm/kvm_emulate.h
>> +++ b/arch/arm64/include/asm/kvm_emulate.h
>> @@ -285,13 +285,13 @@ static __always_inline int kvm_vcpu_dabt_get_rd(const struct kvm_vcpu *vcpu)
>>   
>>   static __always_inline bool kvm_vcpu_abt_iss1tw(const struct kvm_vcpu *vcpu)
>>   {
>> -	return !!(kvm_vcpu_get_esr(vcpu) & ESR_ELx_S1PTW);
>> +	return esr_dabt_is_s1ptw(kvm_vcpu_get_esr(vcpu));
>>   }
>>   
>>   /* Always check for S1PTW *before* using this. */
>>   static __always_inline bool kvm_vcpu_dabt_iswrite(const struct kvm_vcpu *vcpu)
>>   {
>> -	return kvm_vcpu_get_esr(vcpu) & ESR_ELx_WNR;
>> +	return esr_dabt_is_wnr(kvm_vcpu_get_esr(vcpu));
>>   }
>>   
>>   static inline bool kvm_vcpu_dabt_is_cm(const struct kvm_vcpu *vcpu)
>> @@ -320,11 +320,6 @@ static inline bool kvm_vcpu_trap_is_iabt(const struct kvm_vcpu *vcpu)
>>   	return kvm_vcpu_trap_get_class(vcpu) == ESR_ELx_EC_IABT_LOW;
>>   }
>>   
>> -static inline bool kvm_vcpu_trap_is_exec_fault(const struct kvm_vcpu *vcpu)
>> -{
>> -	return kvm_vcpu_trap_is_iabt(vcpu) && !kvm_vcpu_abt_iss1tw(vcpu);
>> -}
>> -
>>   static __always_inline u8 kvm_vcpu_trap_get_fault(const struct kvm_vcpu *vcpu)
>>   {
>>   	return kvm_vcpu_get_esr(vcpu) & ESR_ELx_FSC;
>> @@ -332,12 +327,7 @@ static __always_inline u8 kvm_vcpu_trap_get_fault(const struct kvm_vcpu *vcpu)
>>   
>>   static __always_inline u8 kvm_vcpu_trap_get_fault_type(const struct kvm_vcpu *vcpu)
>>   {
>> -	return kvm_vcpu_get_esr(vcpu) & ESR_ELx_FSC_TYPE;
>> -}
>> -
>> -static __always_inline u8 kvm_vcpu_trap_get_fault_level(const struct kvm_vcpu *vcpu)
>> -{
>> -	return kvm_vcpu_get_esr(vcpu) & ESR_ELx_FSC_LEVEL;
>> +	return esr_dabt_fault_type(kvm_vcpu_get_esr(vcpu));
>>   }
>>   
>>   static __always_inline bool kvm_vcpu_abt_issea(const struct kvm_vcpu *vcpu)
>> @@ -365,17 +355,6 @@ static __always_inline int kvm_vcpu_sys_get_rt(struct kvm_vcpu *vcpu)
>>   	return ESR_ELx_SYS64_ISS_RT(esr);
>>   }
>>   
>> -static inline bool kvm_is_write_fault(struct kvm_vcpu *vcpu)
>> -{
>> -	if (kvm_vcpu_abt_iss1tw(vcpu))
>> -		return true;
>> -
>> -	if (kvm_vcpu_trap_is_iabt(vcpu))
>> -		return false;
>> -
>> -	return kvm_vcpu_dabt_iswrite(vcpu);
>> -}
>> -
>>   static inline unsigned long kvm_vcpu_get_mpidr_aff(struct kvm_vcpu *vcpu)
>>   {
>>   	return vcpu_read_sys_reg(vcpu, MPIDR_EL1) & MPIDR_HWID_BITMASK;
>> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
>> index 1824f7e1f9ab..581825b9df77 100644
>> --- a/arch/arm64/include/asm/kvm_host.h
>> +++ b/arch/arm64/include/asm/kvm_host.h
>> @@ -606,6 +606,10 @@ int __kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
>>   
>>   #define KVM_ARCH_WANT_MMU_NOTIFIER
>>   
>> +int kvm_handle_user_mem_abort(struct kvm_vcpu *vcpu,
>> +			      struct kvm_memory_slot *memslot,
>> +			      phys_addr_t fault_ipa, unsigned long hva,
>> +			      unsigned int esr, bool prefault);
>>   void kvm_arm_halt_guest(struct kvm *kvm);
>>   void kvm_arm_resume_guest(struct kvm *kvm);
>>   
>> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
>> index 0625bf2353c2..e4038c5e931d 100644
>> --- a/arch/arm64/kvm/mmu.c
>> +++ b/arch/arm64/kvm/mmu.c
>> @@ -892,9 +892,34 @@ static int sanitise_mte_tags(struct kvm *kvm, kvm_pfn_t pfn,
>>   	return 0;
>>   }
>>   
>> -static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>> -			  struct kvm_memory_slot *memslot, unsigned long hva,
>> -			  unsigned long fault_status)
>> +static inline bool is_exec_fault(unsigned int esr)
>> +{
>> +	if (ESR_ELx_EC(esr) != ESR_ELx_EC_IABT_LOW)
>> +		return false;
>> +
>> +	if (esr_dabt_is_s1ptw(esr))
>> +		return false;
>> +
>> +	return true;
>> +}
>> +
>> +static inline bool is_write_fault(unsigned int esr)
>> +{
>> +	if (esr_dabt_is_s1ptw(esr))
>> +		return true;
>> +
>> +	if (ESR_ELx_EC(esr) == ESR_ELx_EC_IABT_LOW)
>> +		return false;
>> +
>> +	return esr_dabt_is_wnr(esr);
>> +}
>> +
>> +int kvm_handle_user_mem_abort(struct kvm_vcpu *vcpu,
>> +			      struct kvm_memory_slot *memslot,
>> +			      phys_addr_t fault_ipa,
>> +			      unsigned long hva,
>> +			      unsigned int esr,
>> +			      bool prefault)
> you added the prefault arg but this latter is not used in the function?
> To me you shall introduce that change in a subsequent patch when relevant.

Yep, it's the preparatory patch for the following one. The other changes
included in this patch are also preparatory work. Considering to the
complexity of this patch, especially after we split it up into two patches.
I think it's fine to keep the change here.

[PATCH v4 08/15] KVM: arm64: Support page-ready notification

>>   {
>>   	int ret = 0;
>>   	bool write_fault, writable, force_pte = false;
>> @@ -909,14 +934,15 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>   	gfn_t gfn;
>>   	kvm_pfn_t pfn;
>>   	bool logging_active = memslot_is_logging(memslot);
>> -	unsigned long fault_level = kvm_vcpu_trap_get_fault_level(vcpu);
>> +	unsigned int fault_status = esr_dabt_fault_type(esr);
>> +	unsigned long fault_level = esr_dabt_fault_level(esr);
>>   	unsigned long vma_pagesize, fault_granule;
>>   	enum kvm_pgtable_prot prot = KVM_PGTABLE_PROT_R;
>>   	struct kvm_pgtable *pgt;
>>   
>>   	fault_granule = 1UL << ARM64_HW_PGTABLE_LEVEL_SHIFT(fault_level);
>> -	write_fault = kvm_is_write_fault(vcpu);
>> -	exec_fault = kvm_vcpu_trap_is_exec_fault(vcpu);
>> +	write_fault = is_write_fault(kvm_vcpu_get_esr(vcpu));
>> +	exec_fault = is_exec_fault(kvm_vcpu_get_esr(vcpu));
>>   	VM_BUG_ON(write_fault && exec_fault);
>>   
>>   	if (fault_status == FSC_PERM && !write_fault && !exec_fault) {
>> @@ -1176,7 +1202,7 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
>>   	gfn = fault_ipa >> PAGE_SHIFT;
>>   	memslot = gfn_to_memslot(vcpu->kvm, gfn);
>>   	hva = gfn_to_hva_memslot_prot(memslot, gfn, &writable);
>> -	write_fault = kvm_is_write_fault(vcpu);
>> +	write_fault = is_write_fault(kvm_vcpu_get_esr(vcpu));
>>   	if (kvm_is_error_hva(hva) || (write_fault && !writable)) {
>>   		/*
>>   		 * The guest has put either its instructions or its page-tables
>> @@ -1231,7 +1257,8 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
>>   		goto out_unlock;
>>   	}
>>   
>> -	ret = user_mem_abort(vcpu, fault_ipa, memslot, hva, fault_status);
>> +	ret = kvm_handle_user_mem_abort(vcpu, memslot, fault_ipa, hva,
>> +					kvm_vcpu_get_esr(vcpu), false);>  	if (ret == 0)
>>   		ret = 1;
>>   out:
>>

Thanks,
Gavin

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
