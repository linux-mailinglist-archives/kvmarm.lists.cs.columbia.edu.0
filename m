Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 77F8F1CCF6B
	for <lists+kvmarm@lfdr.de>; Mon, 11 May 2020 04:14:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B849F4B116;
	Sun, 10 May 2020 22:14:34 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QUTe9+tNzKDN; Sun, 10 May 2020 22:14:34 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 30C3D4B110;
	Sun, 10 May 2020 22:14:33 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5C2154B10D
 for <kvmarm@lists.cs.columbia.edu>; Sun, 10 May 2020 22:14:31 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fJBowUJynalN for <kvmarm@lists.cs.columbia.edu>;
 Sun, 10 May 2020 22:14:29 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5F2AF4B10B
 for <kvmarm@lists.cs.columbia.edu>; Sun, 10 May 2020 22:14:29 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B86A31FB;
 Sun, 10 May 2020 19:14:28 -0700 (PDT)
Received: from [10.163.72.179] (unknown [10.163.72.179])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1FBA83F305;
 Sun, 10 May 2020 19:14:25 -0700 (PDT)
Subject: Re: [PATCH V2] arm64/cpufeature: Validate hypervisor capabilities
 during CPU hotplug
To: Marc Zyngier <maz@kernel.org>
References: <1588906358-7845-1-git-send-email-anshuman.khandual@arm.com>
 <875zd51iis.wl-maz@kernel.org>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <ecd96b3e-59b0-4bb5-bb2e-b1de80bb945c@arm.com>
Date: Mon, 11 May 2020 07:43:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <875zd51iis.wl-maz@kernel.org>
Content-Language: en-US
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org,
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



On 05/09/2020 04:29 PM, Marc Zyngier wrote:
> On Fri, 08 May 2020 03:52:38 +0100,
> Anshuman Khandual <anshuman.khandual@arm.com> wrote:
>>
>> This validates hypervisor capabilities like VMID width, IPA range for any
>> hot plug CPU against system finalized values. While here, it factors out
>> get_vmid_bits() for general use and also defines ID_AA64MMFR0_PARANGE_MASK.
> 
> Maybe add a quick word on the fact that we use KVM's view of the IPA
> space to allow a CPU to come up.

Sure, will do.

> 
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: James Morse <james.morse@arm.com>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: kvmarm@lists.cs.columbia.edu
>> Cc: linux-kernel@vger.kernel.org
>>
>> Suggested-by: Suzuki Poulose <suzuki.poulose@arm.com>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> Changes in V2:
>>
>> - Added is_hyp_mode_available() check per Marc
>> - Moved verify_kvm_capabilities() into cpufeature.c per Marc
>> - Added helper get_kvm_ipa_limit() to fetch kvm_ipa_limit per Marc
>> - Renamed kvm as hyp including the commit message per Marc
>>
>> Changes in V1: (https://patchwork.kernel.org/patch/11532565/)
>>
>>  arch/arm64/include/asm/cpufeature.h | 20 +++++++++++++++++
>>  arch/arm64/include/asm/kvm_mmu.h    |  2 +-
>>  arch/arm64/include/asm/sysreg.h     |  1 +
>>  arch/arm64/kernel/cpufeature.c      | 33 +++++++++++++++++++++++++++++
>>  arch/arm64/kvm/reset.c              | 11 ++++++++--
>>  5 files changed, 64 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
>> index afe08251ff95..fbbb4d2216f0 100644
>> --- a/arch/arm64/include/asm/cpufeature.h
>> +++ b/arch/arm64/include/asm/cpufeature.h
>> @@ -745,6 +745,26 @@ static inline bool cpu_has_hw_af(void)
>>  extern bool cpu_has_amu_feat(int cpu);
>>  #endif
>>  
>> +static inline unsigned int get_vmid_bits(u64 mmfr1)
>> +{
>> +	int vmid_bits;
>> +
>> +	vmid_bits = cpuid_feature_extract_unsigned_field(mmfr1,
>> +						ID_AA64MMFR1_VMIDBITS_SHIFT);
>> +	if (vmid_bits == ID_AA64MMFR1_VMIDBITS_16)
>> +		return 16;
>> +
>> +	/*
>> +	 * Return the default here even if any reserved
>> +	 * value is fetched from the system register.
>> +	 */
>> +	return 8;
>> +}
>> +
>> +#ifdef CONFIG_KVM_ARM_HOST
> 
> nit: useless #ifdefery.

Dropped.

> 
>> +u32 get_kvm_ipa_limit(void);
>> +#endif
>> +
>>  #endif /* __ASSEMBLY__ */
>>  
>>  #endif
>> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
>> index 30b0e8d6b895..a7137e144b97 100644
>> --- a/arch/arm64/include/asm/kvm_mmu.h
>> +++ b/arch/arm64/include/asm/kvm_mmu.h
>> @@ -416,7 +416,7 @@ static inline unsigned int kvm_get_vmid_bits(void)
>>  {
>>  	int reg = read_sanitised_ftr_reg(SYS_ID_AA64MMFR1_EL1);
>>  
>> -	return (cpuid_feature_extract_unsigned_field(reg, ID_AA64MMFR1_VMIDBITS_SHIFT) == 2) ? 16 : 8;
>> +	return get_vmid_bits(reg);
>>  }
>>  
>>  /*
>> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
>> index c4ac0ac25a00..3510a4668970 100644
>> --- a/arch/arm64/include/asm/sysreg.h
>> +++ b/arch/arm64/include/asm/sysreg.h
>> @@ -705,6 +705,7 @@
>>  #define ID_AA64MMFR0_TGRAN16_SUPPORTED	0x1
>>  #define ID_AA64MMFR0_PARANGE_48		0x5
>>  #define ID_AA64MMFR0_PARANGE_52		0x6
>> +#define ID_AA64MMFR0_PARANGE_MASK	0x7
> 
> I realise this is already like this in the current code, but using 7
> as a mask value for the feature feels wrong. If we ever get a value
> with bit 3 of the capability being set, we will confuse it with some
> other configuration.
> 
> We should be more careful and pass the full value of the feature to
> id_aa64mmfr0_parange_to_phys_shift(), which already does the right
> thing.

So we should instead pass complete SYS_ID_AA64MMFR0_EL1 value (sanitized)
and do the masking inside id_aa64mmfr0_parange_to_phys_shift(), probably
dropping "_parange_to" from it's name. But kvm_arm_setup_stage2() fetches
only parange not IPA range. Otherwise a new helper id_aa64mmfr0_parange()
which takes full SYS_ID_AA64MMFR0_EL1 value and does the masking before
returning the parange could achieve the same result i.e localizing this
parange mask.

Actually, we could have both the above changes i.e there will be following
two helpers with ID_AA64MMFR0_PARANGE_MASK defined locally.

1. id_aa64mmfr0_phys_shift (u64 mmfr0)
2. id_aa64mmfr0_parange (u64 mmfr0)

Thoughts ?

> 
>>  
>>  #ifdef CONFIG_ARM64_PA_BITS_52
>>  #define ID_AA64MMFR0_PARANGE_MAX	ID_AA64MMFR0_PARANGE_52
>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>> index 9fac745aa7bb..7e5ff452574c 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -2181,6 +2181,36 @@ static void verify_sve_features(void)
>>  	/* Add checks on other ZCR bits here if necessary */
>>  }
>>  
>> +#ifdef CONFIG_KVM_ARM_HOST
>> +void verify_hyp_capabilities(void)
>> +{
>> +	u64 safe_mmfr1, mmfr0, mmfr1;
>> +	int parange, ipa_max;
>> +	unsigned int safe_vmid_bits, vmid_bits;
>> +
>> +	safe_mmfr1 = read_sanitised_ftr_reg(SYS_ID_AA64MMFR1_EL1);
>> +	mmfr0 = read_cpuid(ID_AA64MMFR0_EL1);
>> +	mmfr1 = read_cpuid(ID_AA64MMFR1_EL1);
>> +
>> +	/* Verify VMID bits */
>> +	safe_vmid_bits = get_vmid_bits(safe_mmfr1);
>> +	vmid_bits = get_vmid_bits(mmfr1);
>> +	if (vmid_bits < safe_vmid_bits) {
>> +		pr_crit("CPU%d: VMID width mismatch\n", smp_processor_id());
>> +		cpu_die_early();
>> +	}
>> +
>> +	/* Verify IPA range */
>> +	parange = mmfr0 & ID_AA64MMFR0_PARANGE_MASK;
>> +	ipa_max = id_aa64mmfr0_parange_to_phys_shift(parange);
>> +	if (ipa_max < get_kvm_ipa_limit()) {
>> +		pr_crit("CPU%d: IPA range mismatch\n", smp_processor_id());
>> +		cpu_die_early();
>> +	}
>> +}
>> +#else	/* !CONFIG_KVM_ARM_HOST */
>> +static inline void verify_hyp_capabilities(void) { }
>> +#endif	/* CONFIG_KVM_ARM_HOST */
>>  
>>  /*
>>   * Run through the enabled system capabilities and enable() it on this CPU.
>> @@ -2206,6 +2236,9 @@ static void verify_local_cpu_capabilities(void)
>>  
>>  	if (system_supports_sve())
>>  		verify_sve_features();
>> +
>> +	if (is_hyp_mode_available())
>> +		verify_hyp_capabilities();
>>  }
>>  
>>  void check_local_cpu_capabilities(void)
>> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
>> index 30b7ea680f66..1131b112dda2 100644
>> --- a/arch/arm64/kvm/reset.c
>> +++ b/arch/arm64/kvm/reset.c
>> @@ -340,11 +340,17 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
>>  	return ret;
>>  }
>>  
>> +u32 get_kvm_ipa_limit(void)
>> +{
>> +	return kvm_ipa_limit;
>> +}
>> +
>>  void kvm_set_ipa_limit(void)
>>  {
>>  	unsigned int ipa_max, pa_max, va_max, parange;
>>  
>> -	parange = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1) & 0x7;
>> +	parange = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1) &
>> +						ID_AA64MMFR0_PARANGE_MASK;
>>  	pa_max = id_aa64mmfr0_parange_to_phys_shift(parange);
>>  
>>  	/* Clamp the IPA limit to the PA size supported by the kernel */
>> @@ -406,7 +412,8 @@ int kvm_arm_setup_stage2(struct kvm *kvm, unsigned long type)
>>  		phys_shift = KVM_PHYS_SHIFT;
>>  	}
>>  
>> -	parange = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1) & 7;
>> +	parange = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1) &
>> +						ID_AA64MMFR0_PARANGE_MASK;
>>  	if (parange > ID_AA64MMFR0_PARANGE_MAX)
>>  		parange = ID_AA64MMFR0_PARANGE_MAX;
>>  	vtcr |= parange << VTCR_EL2_PS_SHIFT;
>> -- 
>> 2.20.1
>>
>>
> 
> With the couple of nits above addressed:
> 
> Reviewed-by: Marc Zyngier <maz@kernel.org>
> 
> 	M.
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
