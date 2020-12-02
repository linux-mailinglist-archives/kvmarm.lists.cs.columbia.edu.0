Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 49BA72CC229
	for <lists+kvmarm@lfdr.de>; Wed,  2 Dec 2020 17:27:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B05114B35F;
	Wed,  2 Dec 2020 11:27:14 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JbrH4-t70uRH; Wed,  2 Dec 2020 11:27:14 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 372584B39F;
	Wed,  2 Dec 2020 11:27:13 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8E5294B371
 for <kvmarm@lists.cs.columbia.edu>; Wed,  2 Dec 2020 11:27:12 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YU-HX33jyJbW for <kvmarm@lists.cs.columbia.edu>;
 Wed,  2 Dec 2020 11:27:11 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 062C64B35F
 for <kvmarm@lists.cs.columbia.edu>; Wed,  2 Dec 2020 11:27:11 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A8A71396;
 Wed,  2 Dec 2020 08:27:05 -0800 (PST)
Received: from [192.168.0.110] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8440F3F718;
 Wed,  2 Dec 2020 08:27:03 -0800 (PST)
Subject: Re: [RFC PATCH v3 08/16] KVM: arm64: Add a new VCPU device control
 group for SPE
To: James Morse <james.morse@arm.com>
References: <20201027172705.15181-1-alexandru.elisei@arm.com>
 <20201027172705.15181-9-alexandru.elisei@arm.com>
 <3f5b92d1-81d4-1df1-b666-bdb97857fbdf@arm.com>
From: Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <53f49d74-943a-dd38-2c67-193f877880d8@arm.com>
Date: Wed, 2 Dec 2020 16:28:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <3f5b92d1-81d4-1df1-b666-bdb97857fbdf@arm.com>
Content-Language: en-US
Cc: maz@kernel.org, linux-arm-kernel@lists.infradead.org,
 Sudeep Holla <sudeep.holla@arm.com>, will@kernel.org,
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

Hi James,

On 11/19/20 4:58 PM, James Morse wrote:
> Hi Alex,
>
> On 27/10/2020 17:26, Alexandru Elisei wrote:
>> From: Sudeep Holla <sudeep.holla@arm.com>
>>
>> To configure the virtual SPE buffer management interrupt number, we use a
>> VCPU kvm_device ioctl, encapsulating the KVM_ARM_VCPU_SPE_IRQ attribute
>> within the KVM_ARM_VCPU_SPE_CTRL group.
>>
>> After configuring the SPE, userspace is required to call the VCPU ioctl
>> with the attribute KVM_ARM_VCPU_SPE_INIT to initialize SPE on the VCPU.
>> diff --git a/Documentation/virt/kvm/devices/vcpu.rst b/Documentation/virt/kvm/devices/vcpu.rst
>> index 2acec3b9ef65..6135b9827fbe 100644
>> --- a/Documentation/virt/kvm/devices/vcpu.rst
>> +++ b/Documentation/virt/kvm/devices/vcpu.rst
>> @@ -161,3 +161,43 @@ Specifies the base address of the stolen time structure for this VCPU. The
>>  base address must be 64 byte aligned and exist within a valid guest memory
>>  region. See Documentation/virt/kvm/arm/pvtime.rst for more information
>>  including the layout of the stolen time structure.
>> +
>> +4. GROUP: KVM_ARM_VCPU_SPE_CTRL
>> +===============================
>> +
>> +:Architectures: ARM64
>> +
>> +4.1 ATTRIBUTE: KVM_ARM_VCPU_SPE_IRQ
>> +-----------------------------------
>> +
>> +:Parameters: in kvm_device_attr.addr the address for the SPE buffer management
>> +             interrupt is a pointer to an int
>> +
>> +Returns:
>> +
>> +	 =======  ========================================================
>> +	 -EBUSY   The SPE buffer management interrupt is already set
>> +	 -EINVAL  Invalid SPE overflow interrupt number
>> +	 -EFAULT  Could not read the buffer management interrupt number
>> +	 -ENXIO   SPE not supported or not properly configured
>> +	 =======  ========================================================
>> +
>> +A value describing the SPE (Statistical Profiling Extension) overflow interrupt
>> +number for this vcpu. This interrupt should be a PPI and the interrupt type and
>> +number must be same for each vcpu.
>> +
>> +4.2 ATTRIBUTE: KVM_ARM_VCPU_SPE_INIT
>> +------------------------------------
>> +
>> +:Parameters: no additional parameter in kvm_device_attr.addr
>> +
>> +Returns:
>> +
>> +	 =======  ======================================================
>> +	 -EBUSY   SPE already initialized
>> +	 -ENODEV  GIC not initialized
>> +	 -ENXIO   SPE not supported or not properly configured
>> +	 =======  ======================================================
>> +Request the initialization of the SPE. Must be done after initializing the
>> +in-kernel irqchip and after setting the interrupt number for the VCPU.
> Fantastic!
>
>
>> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
>> index f32490229a4c..4dc205fa4be1 100644
>> --- a/arch/arm64/kvm/reset.c
>> +++ b/arch/arm64/kvm/reset.c
>> @@ -87,6 +87,9 @@ int kvm_arch_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>>  	case KVM_CAP_ARM_PTRAUTH_GENERIC:
>>  		r = system_has_full_ptr_auth();
>>  		break;
>> +	case KVM_CAP_ARM_SPE:
>> +		r = kvm_arm_supports_spe();
>> +		break;
>>  	default:
>>  		r = 0;
>>  	}
>> @@ -223,6 +226,19 @@ static int kvm_vcpu_enable_ptrauth(struct kvm_vcpu *vcpu)
>>  	return 0;
>>  }
>>  
>> +static int kvm_vcpu_enable_spe(struct kvm_vcpu *vcpu)
>> +{
>> +	if (!kvm_arm_supports_spe())
>> +		return -EINVAL;
>> +
>> +	/* SPE is disabled if the PE is in AArch32 state */
>> +	if (test_bit(KVM_ARM_VCPU_EL1_32BIT, vcpu->arch.features))
>> +		return -EINVAL;
>> +
>> +	vcpu->arch.flags |= KVM_ARM64_GUEST_HAS_SPE;
>> +	return 0;
>> +}
> VCPU-reset promotes the VMM feature into flags. How does this interact with
> kvm_arm_spe_init()?
>
> It doesn't look like this resets any state, couldn't it be done once by kvm_arm_spe_init()?

I need to check here for incompatible features (KVM_ARM_VCPU_EL1_32BIT) or
unsupported SPE to return an error code to KVM_ARM_VCPU_INIT (the ioctl is handled
in kvm_arch_vcpu_ioctl_vcpu_init -> kvm_vcpu_set_target)

We need to track the feature per-vcpu, to refuse finalization if the feature was
not set on all of them. I could use features, but I think using flags will end up
slightly faster.

When KVM SPE is optimized, I will probably add at least one vcpu->arch.flags flag
(something like KVM_ARM64_HOST_USES_SPE) to allow for lazy save/restore of the
host SPE context when the flag is missing. I was thinking that in that case
checking vcpu->arch.flags will be cheaper. This is also the approach that SVE
uses, from what I can tell.

For now, I would prefer to keep it as a vcpu flag and make the decision once I
start implementing performance optimizations. But using features is definitely
doable if there are objections against using flags.

>
>
>>  /**
>>   * kvm_reset_vcpu - sets core registers and sys_regs to reset value
>>   * @vcpu: The VCPU pointer
>> @@ -274,6 +290,13 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
>>  		}
>>  	}
>>  
>> +	if (test_bit(KVM_ARM_VCPU_SPE, vcpu->arch.features)) {
>> +		if (kvm_vcpu_enable_spe(vcpu)) {
>> +			ret = -EINVAL;
>> +			goto out;
>> +		}
>> +	}
>> +
>>  	switch (vcpu->arch.target) {
>>  	default:
>>  		if (test_bit(KVM_ARM_VCPU_EL1_32BIT, vcpu->arch.features)) {
>> diff --git a/arch/arm64/kvm/spe.c b/arch/arm64/kvm/spe.c
>> new file mode 100644
>> index 000000000000..f91a52cd7cd3
>> --- /dev/null
>> +++ b/arch/arm64/kvm/spe.c
>> @@ -0,0 +1,129 @@
>> +static bool kvm_arm_spe_irq_is_valid(struct kvm *kvm, int irq)
>> +{
>> +	int i;
>> +	struct kvm_vcpu *vcpu;
>> +
>> +	/* The SPE overflow interrupt can be a PPI only */
>> +	if (!irq_is_ppi(irq))
>> +		return false;
>> +
>> +	kvm_for_each_vcpu(i, vcpu, kvm) {
>> +		if (!kvm_arm_spe_irq_initialized(vcpu))
>> +			continue;
>> +
>> +		if (vcpu->arch.spe_cpu.irq_num != irq)
>> +			return false;
>> +	}
> Looks like you didn't really want a vcpu property! (huh, patch 10 adds a vm property too)
> We're making this a vcpu property because of the PPI and system registers? (both good reasons)
>
> If the PPI number lived in struct kvm_arch, you'd only only need to check it was
> uninitialised, or the same to get the same behaviour, which would save some of this error
> handling.

The Arm ARM mandates that the SPE interrupt must be a PPI. I think it makes more
sense to have a Private Peripheral Interrupt ID saved as a per-vcpu variable than
a per-VM one, like a SPI.

>
>
>> +	return true;
>> +}
>> diff --git a/include/kvm/arm_spe.h b/include/kvm/arm_spe.h
>> index 46ec447ed013..0275e8097529 100644
>> --- a/include/kvm/arm_spe.h
>> +++ b/include/kvm/arm_spe.h
>> @@ -18,11 +18,38 @@ struct kvm_spe_cpu {
>>  	bool initialized; 	/* Feature is initialized on VCPU */
>>  };
>>  
>> +#define kvm_arm_spe_irq_initialized(v)			\
>> +	((v)->arch.spe_cpu.irq_num >= VGIC_NR_SGIS &&	\
>> +	 (v)->arch.spe_cpu.irq_num < VGIC_MAX_PRIVATE)
> Didn't GICv(mumbles) add an additional PPI range? Could this be made irq_is_ppi(), that
> way if the vgic gains support for that, we don't get weird behaviour here?

You're right, the macro reimplements irq_is_ppi(), I'll rewrite it to use
irq_is_ppi().

Thanks,
Alex
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
