Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C78B2DE959
	for <lists+kvmarm@lfdr.de>; Mon, 21 Oct 2019 12:22:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 57FBB4A9A9;
	Mon, 21 Oct 2019 06:22:28 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 1.592
X-Spam-Level: *
X-Spam-Status: No, score=1.592 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RDNS_NONE=0.793] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ig2-py7oOMo0; Mon, 21 Oct 2019 06:22:28 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A59DA4A9AE;
	Mon, 21 Oct 2019 06:22:26 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 60F644A98B
 for <kvmarm@lists.cs.columbia.edu>; Mon, 21 Oct 2019 06:22:25 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jNBWl7wd2Mo8 for <kvmarm@lists.cs.columbia.edu>;
 Mon, 21 Oct 2019 06:22:23 -0400 (EDT)
Received: from foss.arm.com (unknown [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9BF444A8BA
 for <kvmarm@lists.cs.columbia.edu>; Mon, 21 Oct 2019 06:22:23 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 480B7CA3;
 Mon, 21 Oct 2019 03:22:03 -0700 (PDT)
Received: from [10.1.194.43] (e112269-lin.cambridge.arm.com [10.1.194.43])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CDC833F718;
 Mon, 21 Oct 2019 03:22:00 -0700 (PDT)
Subject: Re: [PATCH v6 05/10] KVM: arm64: Support stolen time reporting via
 shared structure
To: Marc Zyngier <maz@kernel.org>
References: <20191011125930.40834-1-steven.price@arm.com>
 <20191011125930.40834-6-steven.price@arm.com> <86eez9yoog.wl-maz@kernel.org>
From: Steven Price <steven.price@arm.com>
Message-ID: <1bb10eb5-0fe8-57c9-3b67-9b3661a73d29@arm.com>
Date: Mon, 21 Oct 2019 11:21:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <86eez9yoog.wl-maz@kernel.org>
Content-Language: en-GB
Cc: kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 linux-doc@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Paolo Bonzini <pbonzini@redhat.com>, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu
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

On 19/10/2019 12:12, Marc Zyngier wrote:
> On Fri, 11 Oct 2019 13:59:25 +0100,
> Steven Price <steven.price@arm.com> wrote:
>>
>> Implement the service call for configuring a shared structure between a
>> VCPU and the hypervisor in which the hypervisor can write the time
>> stolen from the VCPU's execution time by other tasks on the host.
>>
>> User space allocates memory which is placed at an IPA also chosen by user
>> space. The hypervisor then updates the shared structure using
>> kvm_put_guest() to ensure single copy atomicity of the 64-bit value
>> reporting the stolen time in nanoseconds.
>>
>> Whenever stolen time is enabled by the guest, the stolen time counter is
>> reset.
>>
>> The stolen time itself is retrieved from the sched_info structure
>> maintained by the Linux scheduler code. We enable SCHEDSTATS when
>> selecting KVM Kconfig to ensure this value is meaningful.
>>
>> Signed-off-by: Steven Price <steven.price@arm.com>
>> ---
>>  arch/arm/include/asm/kvm_host.h   | 20 +++++++++++
>>  arch/arm64/include/asm/kvm_host.h | 21 +++++++++++-
>>  arch/arm64/kvm/Kconfig            |  1 +
>>  include/linux/kvm_types.h         |  2 ++
>>  virt/kvm/arm/arm.c                | 11 ++++++
>>  virt/kvm/arm/hypercalls.c         |  3 ++
>>  virt/kvm/arm/pvtime.c             | 56 +++++++++++++++++++++++++++++++
>>  7 files changed, 113 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
>> index 5a0c3569ebde..5c401482d62d 100644
>> --- a/arch/arm/include/asm/kvm_host.h
>> +++ b/arch/arm/include/asm/kvm_host.h
>> @@ -39,6 +39,7 @@
>>  	KVM_ARCH_REQ_FLAGS(0, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
>>  #define KVM_REQ_IRQ_PENDING	KVM_ARCH_REQ(1)
>>  #define KVM_REQ_VCPU_RESET	KVM_ARCH_REQ(2)
>> +#define KVM_REQ_RECORD_STEAL	KVM_ARCH_REQ(3)
>>  
>>  DECLARE_STATIC_KEY_FALSE(userspace_irqchip_in_use);
>>  
>> @@ -329,6 +330,25 @@ static inline long kvm_hypercall_pv_features(struct kvm_vcpu *vcpu)
>>  	return SMCCC_RET_NOT_SUPPORTED;
>>  }
>>  
>> +static inline long kvm_hypercall_stolen_time(struct kvm_vcpu *vcpu)
>> +{
>> +	return SMCCC_RET_NOT_SUPPORTED;
>> +}
>> +
>> +static inline int kvm_update_stolen_time(struct kvm_vcpu *vcpu, bool init)
>> +{
>> +	return -ENOTSUPP;
>> +}
>> +
>> +static inline void kvm_arm_pvtime_vcpu_init(struct kvm_vcpu_arch *vcpu_arch)
>> +{
>> +}
>> +
>> +static inline bool kvm_arm_is_pvtime_enabled(struct kvm_vcpu_arch *vcpu_arch)
>> +{
>> +	return false;
>> +}
>> +
>>  void kvm_mmu_wp_memory_region(struct kvm *kvm, int slot);
>>  
>>  struct kvm_vcpu *kvm_mpidr_to_vcpu(struct kvm *kvm, unsigned long mpidr);
>> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
>> index 93b46d9526d0..1697e63f6dd8 100644
>> --- a/arch/arm64/include/asm/kvm_host.h
>> +++ b/arch/arm64/include/asm/kvm_host.h
>> @@ -44,6 +44,7 @@
>>  	KVM_ARCH_REQ_FLAGS(0, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
>>  #define KVM_REQ_IRQ_PENDING	KVM_ARCH_REQ(1)
>>  #define KVM_REQ_VCPU_RESET	KVM_ARCH_REQ(2)
>> +#define KVM_REQ_RECORD_STEAL	KVM_ARCH_REQ(3)
>>  
>>  DECLARE_STATIC_KEY_FALSE(userspace_irqchip_in_use);
>>  
>> @@ -338,8 +339,14 @@ struct kvm_vcpu_arch {
>>  	/* True when deferrable sysregs are loaded on the physical CPU,
>>  	 * see kvm_vcpu_load_sysregs and kvm_vcpu_put_sysregs. */
>>  	bool sysregs_loaded_on_cpu;
>> -};
>>  
>> +	/* Guest PV state */
>> +	struct {
>> +		u64 steal;
>> +		u64 last_steal;
>> +		gpa_t base;
>> +	} steal;
>> +};
> 
> nit: Please keep an empty line at the end of the structure.
> 
>>  /* Pointer to the vcpu's SVE FFR for sve_{save,load}_state() */
>>  #define vcpu_sve_pffr(vcpu) ((void *)((char *)((vcpu)->arch.sve_state) + \
>>  				      sve_ffr_offset((vcpu)->arch.sve_max_vl)))
>> @@ -479,6 +486,18 @@ int kvm_perf_init(void);
>>  int kvm_perf_teardown(void);
>>  
>>  long kvm_hypercall_pv_features(struct kvm_vcpu *vcpu);
>> +long kvm_hypercall_stolen_time(struct kvm_vcpu *vcpu);
>> +int kvm_update_stolen_time(struct kvm_vcpu *vcpu, bool init);
>> +
>> +static inline void kvm_arm_pvtime_vcpu_init(struct kvm_vcpu_arch *vcpu_arch)
>> +{
>> +	vcpu_arch->steal.base = GPA_INVALID;
>> +}
>> +
>> +static inline bool kvm_arm_is_pvtime_enabled(struct kvm_vcpu_arch *vcpu_arch)
>> +{
>> +	return (vcpu_arch->steal.base != GPA_INVALID);
>> +}
>>  
>>  void kvm_set_sei_esr(struct kvm_vcpu *vcpu, u64 syndrome);
>>  
>> diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
>> index a67121d419a2..d8b88e40d223 100644
>> --- a/arch/arm64/kvm/Kconfig
>> +++ b/arch/arm64/kvm/Kconfig
>> @@ -39,6 +39,7 @@ config KVM
>>  	select IRQ_BYPASS_MANAGER
>>  	select HAVE_KVM_IRQ_BYPASS
>>  	select HAVE_KVM_VCPU_RUN_PID_CHANGE
>> +	select SCHEDSTATS
>>  	---help---
>>  	  Support hosting virtualized guest machines.
>>  	  We don't support KVM with 16K page tables yet, due to the multiple
>> diff --git a/include/linux/kvm_types.h b/include/linux/kvm_types.h
>> index bde5374ae021..1c88e69db3d9 100644
>> --- a/include/linux/kvm_types.h
>> +++ b/include/linux/kvm_types.h
>> @@ -35,6 +35,8 @@ typedef unsigned long  gva_t;
>>  typedef u64            gpa_t;
>>  typedef u64            gfn_t;
>>  
>> +#define GPA_INVALID	(~(gpa_t)0)
>> +
>>  typedef unsigned long  hva_t;
>>  typedef u64            hpa_t;
>>  typedef u64            hfn_t;
>> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
>> index 86c6aa1cb58e..5d3059aeadb1 100644
>> --- a/virt/kvm/arm/arm.c
>> +++ b/virt/kvm/arm/arm.c
>> @@ -40,6 +40,10 @@
>>  #include <asm/kvm_coproc.h>
>>  #include <asm/sections.h>
>>  
>> +#include <kvm/arm_hypercalls.h>
>> +#include <kvm/arm_pmu.h>
>> +#include <kvm/arm_psci.h>
>> +
>>  #ifdef REQUIRES_VIRT
>>  __asm__(".arch_extension	virt");
>>  #endif
>> @@ -351,6 +355,8 @@ int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
>>  
>>  	kvm_arm_reset_debug_ptr(vcpu);
>>  
>> +	kvm_arm_pvtime_vcpu_init(&vcpu->arch);
>> +
>>  	return kvm_vgic_vcpu_init(vcpu);
>>  }
>>  
>> @@ -380,6 +386,8 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
>>  	kvm_vcpu_load_sysregs(vcpu);
>>  	kvm_arch_vcpu_load_fp(vcpu);
>>  	kvm_vcpu_pmu_restore_guest(vcpu);
>> +	if (kvm_arm_is_pvtime_enabled(&vcpu->arch))
>> +		kvm_make_request(KVM_REQ_RECORD_STEAL, vcpu);
>>  
>>  	if (single_task_running())
>>  		vcpu_clear_wfe_traps(vcpu);
>> @@ -645,6 +653,9 @@ static void check_vcpu_requests(struct kvm_vcpu *vcpu)
>>  		 * that a VCPU sees new virtual interrupts.
>>  		 */
>>  		kvm_check_request(KVM_REQ_IRQ_PENDING, vcpu);
>> +
>> +		if (kvm_check_request(KVM_REQ_RECORD_STEAL, vcpu))
>> +			kvm_update_stolen_time(vcpu, false);
>>  	}
>>  }
>>  
>> diff --git a/virt/kvm/arm/hypercalls.c b/virt/kvm/arm/hypercalls.c
>> index 97ea8b133e77..5c333a64390e 100644
>> --- a/virt/kvm/arm/hypercalls.c
>> +++ b/virt/kvm/arm/hypercalls.c
>> @@ -56,6 +56,9 @@ int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
>>  	case ARM_SMCCC_HV_PV_TIME_FEATURES:
>>  		val = kvm_hypercall_pv_features(vcpu);
>>  		break;
>> +	case ARM_SMCCC_HV_PV_TIME_ST:
>> +		val = kvm_hypercall_stolen_time(vcpu);
>> +		break;
>>  	default:
>>  		return kvm_psci_call(vcpu);
>>  	}
>> diff --git a/virt/kvm/arm/pvtime.c b/virt/kvm/arm/pvtime.c
>> index 8d0fad671dcf..a90f1b4ebd13 100644
>> --- a/virt/kvm/arm/pvtime.c
>> +++ b/virt/kvm/arm/pvtime.c
>> @@ -3,8 +3,45 @@
>>  
>>  #include <linux/arm-smccc.h>
>>  
>> +#include <asm/pvclock-abi.h>
>> +
>>  #include <kvm/arm_hypercalls.h>
>>  
>> +int kvm_update_stolen_time(struct kvm_vcpu *vcpu, bool init)
>> +{
>> +	struct kvm *kvm = vcpu->kvm;
>> +	u64 steal;
>> +	u64 steal_le;
> 
> This should be __le64.
> 
>> +	u64 offset;
>> +	int idx;
>> +	u64 base = vcpu->arch.steal.base;
>> +
>> +	if (base == GPA_INVALID)
>> +		return -ENOTSUPP;
>> +
>> +	/* Let's do the local bookkeeping */
>> +	steal = vcpu->arch.steal.steal;
>> +	steal += current->sched_info.run_delay - vcpu->arch.steal.last_steal;
>> +	vcpu->arch.steal.last_steal = current->sched_info.run_delay;
>> +	vcpu->arch.steal.steal = steal;
>> +
>> +	steal_le = cpu_to_le64(steal);
>> +	idx = srcu_read_lock(&kvm->srcu);
>> +	if (init) {
>> +		struct pvclock_vcpu_stolen_time init_values = {
>> +			.revision = 0,
>> +			.attributes = 0
> 
> nit: 0 is the default initialiser.
> 
>> +		};
>> +		kvm_write_guest(kvm, base, &init_values,
>> +				sizeof(init_values));
>> +	}
> 
> I'm not convinced by this init phase right in the middle of the normal
> path. It looks ugly, and it'd be better if moved out of line. I'd
> suggest:
> 
> static void kvm_init_stolen_time(struct kvm_vcpu *vcpu)
> {
> 	struct pvclock_vcpu_stolen_time init_values = { };
> 
> 	vcpu->arch.steal.steal = 0;
> 	vcpu->arch.steal.last_steal = current->sched_info.run_delay;
> 
> 	idx = srcu_read_lock(&kvm->srcu);
> 	kvm_write_guest(kvm, base, &init_values, sizeof(init_values));
> 	srcu_read_unlock(&kvm->srcu, idx);
> }
> 
> and change the two callers accordingly. Or even better, move this code
> to the hypercall handling function, because that's where it actually
> belongs.

Ok, it does add a little bit of duplicated code. But it also gets rid of
the boolean argument that I never liked. As you suggest I might as well
move this into kvm_hypercall_stolen_time().

>> +	offset = offsetof(struct pvclock_vcpu_stolen_time, stolen_time);
>> +	kvm_put_guest(kvm, base + offset, steal_le, u64);
>> +	srcu_read_unlock(&kvm->srcu, idx);
>> +
>> +	return 0;
>> +}
>> +
>>  long kvm_hypercall_pv_features(struct kvm_vcpu *vcpu)
>>  {
>>  	u32 feature = smccc_get_arg1(vcpu);
>> @@ -12,6 +49,7 @@ long kvm_hypercall_pv_features(struct kvm_vcpu *vcpu)
>>  
>>  	switch (feature) {
>>  	case ARM_SMCCC_HV_PV_TIME_FEATURES:
>> +	case ARM_SMCCC_HV_PV_TIME_ST:
>>  		val = SMCCC_RET_SUCCESS;
>>  		break;
>>  	}
>> @@ -19,3 +57,21 @@ long kvm_hypercall_pv_features(struct kvm_vcpu *vcpu)
>>  	return val;
>>  }
>>  
>> +long kvm_hypercall_stolen_time(struct kvm_vcpu *vcpu)
> 
> Why long? If that's a base address, then it is either a phys_addr_t or
> a gpa_t. I'd suggest you move the error check to the caller.

This is a bit more tricky. It's a long because that's the declared type
of the SMCCC return in kvm_hvc_call_handler(). I can't (easily) move the
code into kvm_hvc_call_handler() because that is compiled for arm (as
well as arm64) and we don't have the definitions for stolen time there.
The best option I could come up with is to have a dummy stub for arm and
use generic types for this function.

This means we need a type which can contain both a gpa_t and the
SMCCC_RET_NOT_SUPPORTED error code.

I'm open to alternative suggestions on how to make this work.

Thanks,

Steve

>> +{
>> +	int err;
>> +
>> +	/*
>> +	 * Start counting stolen time from the time the guest requests
>> +	 * the feature enabled.
>> +	 */
>> +	vcpu->arch.steal.steal = 0;
>> +	vcpu->arch.steal.last_steal = current->sched_info.run_delay;
>> +
>> +	err = kvm_update_stolen_time(vcpu, true);
>> +
>> +	if (err)
>> +		return SMCCC_RET_NOT_SUPPORTED;
>> +
>> +	return vcpu->arch.steal.base;
>> +}
>> -- 
>> 2.20.1
>>
>>
> 
> Thanks,
> 
> 	M.
> 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
