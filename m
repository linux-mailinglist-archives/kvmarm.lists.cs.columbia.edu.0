Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 261B53DFF47
	for <lists+kvmarm@lfdr.de>; Wed,  4 Aug 2021 12:17:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id ABC164A1FA;
	Wed,  4 Aug 2021 06:17:53 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.209
X-Spam-Level: 
X-Spam-Status: No, score=0.209 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_LOW=-0.7,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kGlh-7RyAyy2; Wed,  4 Aug 2021 06:17:53 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E418C40870;
	Wed,  4 Aug 2021 06:17:51 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 968F740870
 for <kvmarm@lists.cs.columbia.edu>; Wed,  4 Aug 2021 06:17:50 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XvMFAZELIKUN for <kvmarm@lists.cs.columbia.edu>;
 Wed,  4 Aug 2021 06:17:49 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1C58540667
 for <kvmarm@lists.cs.columbia.edu>; Wed,  4 Aug 2021 06:17:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628072268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yAHqtcUxG4LMwS/rnasSwvRmZN2w1w2Oh9hd5R42nDA=;
 b=OR5qnG8vgvqk449xONgToo3kYgcQy4CsPpkoX1pK460lWhEL3nj8C2ldBMh6DRY97B/ilK
 dj++fsatKWQpAx2HTgbAsbtaBayllSg+GHh3xVighb0fRTJO5DRLdraaxnw+GaIuwsezoa
 ZGAYjVgaIkTvV/DR1dHwf9J02tEd9Zs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-7dpo8Qa_MbyuEoFYUWMPBA-1; Wed, 04 Aug 2021 06:17:47 -0400
X-MC-Unique: 7dpo8Qa_MbyuEoFYUWMPBA-1
Received: by mail-ej1-f70.google.com with SMTP id
 ju25-20020a17090798b9b029058c24b55273so677368ejc.8
 for <kvmarm@lists.cs.columbia.edu>; Wed, 04 Aug 2021 03:17:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=yAHqtcUxG4LMwS/rnasSwvRmZN2w1w2Oh9hd5R42nDA=;
 b=hMZ5p5pv3GUr33Nk8RGo1gErU3KUkv78sooBbkJHVupGG1QNIsM2B53yVjSdAwJN1W
 HUlqQmZrTXtAc7lWaFunS2oz1yBDi9SrWr2u5bJRfHJ5j+XVtwcE/mHgIjUmMDImqbmd
 AibaotTqvST6Q5xtZEqPiCAdtjJOQ57l4ohG9FK4l63MTbySPK3bDJSblJjsiDEw8ye5
 TeyFlkEBvoQKDmAaZvQXLYvMBtDLTCjpyy2YnTpFV1Bp5F5YIJ9jcejm3+SVVNZR807h
 O4w3Bs1QAI74ceWLu3oVywmc6kqxK76ZhhxCqSOgxUkzCxYVKWnsJ6ntkg2XoADahzAt
 hbtg==
X-Gm-Message-State: AOAM531XW+u+Q+/ICMLNt5YTmaDvgmPAHdRqNICMhqY19opr/UDC2tNC
 dFd2B7PpUxRNW8D36K43/mFFcGYHz6f/NioYejJSKWSFTpNE9StvssPyNvEatcd3F+MHAox+KzM
 QrFf1Bd2thNVp3fU0zLMWza64
X-Received: by 2002:a17:906:d20a:: with SMTP id
 w10mr25983912ejz.426.1628072266395; 
 Wed, 04 Aug 2021 03:17:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzLqKp+Ql5wUUtb0CIuwL7CjDbzZCxckuq+d95NKNnFVs8yTF1QE9iJ8L+9HoDcjHGYb66lkw==
X-Received: by 2002:a17:906:d20a:: with SMTP id
 w10mr25983875ejz.426.1628072266036; 
 Wed, 04 Aug 2021 03:17:46 -0700 (PDT)
Received: from gator.home (cst2-174-132.cust.vodafone.cz. [31.30.174.132])
 by smtp.gmail.com with ESMTPSA id og35sm550359ejc.28.2021.08.04.03.17.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Aug 2021 03:17:45 -0700 (PDT)
Date: Wed, 4 Aug 2021 12:17:43 +0200
From: Andrew Jones <drjones@redhat.com>
To: Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v6 17/21] KVM: arm64: Allow userspace to configure a
 guest's counter-timer offset
Message-ID: <20210804101743.bgkggw7a3wbx7woi@gator.home>
References: <20210804085819.846610-1-oupton@google.com>
 <20210804085819.846610-18-oupton@google.com>
MIME-Version: 1.0
In-Reply-To: <20210804085819.846610-18-oupton@google.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Catalin Marinas <catalin.marinas@arm.com>, kvm@vger.kernel.org,
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Raghavendra Rao Anata <rananta@google.com>, Peter Shier <pshier@google.com>,
 Sean Christopherson <seanjc@google.com>, David Matlack <dmatlack@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, Jim Mattson <jmattson@google.com>
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

On Wed, Aug 04, 2021 at 08:58:15AM +0000, Oliver Upton wrote:
> Presently, KVM provides no facilities for correctly migrating a guest
> that depends on the physical counter-timer. Whie most guests (barring
> NV, of course) should not depend on the physical counter-timer, an
> operator may wish to provide a consistent view of the physical
> counter-timer across migrations.
> 
> Provide userspace with a new vCPU attribute to modify the guest
> counter-timer offset. Unlike KVM_REG_ARM_TIMER_OFFSET, this attribute is
> hidden from the guest's architectural state. The value offsets *both*
> the virtual and physical counter-timer views for the guest. Only support
> this attribute on ECV systems as ECV is required for hardware offsetting
> of the physical counter-timer.
> 
> Signed-off-by: Oliver Upton <oupton@google.com>
> ---
>  Documentation/virt/kvm/devices/vcpu.rst |  28 ++++++
>  arch/arm64/include/asm/kvm_asm.h        |   2 +
>  arch/arm64/include/asm/sysreg.h         |   2 +
>  arch/arm64/include/uapi/asm/kvm.h       |   1 +
>  arch/arm64/kvm/arch_timer.c             | 122 +++++++++++++++++++++++-
>  arch/arm64/kvm/hyp/nvhe/hyp-main.c      |   6 ++
>  arch/arm64/kvm/hyp/nvhe/timer-sr.c      |   5 +
>  arch/arm64/kvm/hyp/vhe/timer-sr.c       |   5 +
>  include/clocksource/arm_arch_timer.h    |   1 +
>  9 files changed, 169 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/virt/kvm/devices/vcpu.rst b/Documentation/virt/kvm/devices/vcpu.rst
> index 3b399d727c11..3ba35b9d9d03 100644
> --- a/Documentation/virt/kvm/devices/vcpu.rst
> +++ b/Documentation/virt/kvm/devices/vcpu.rst
> @@ -139,6 +139,34 @@ configured values on other VCPUs.  Userspace should configure the interrupt
>  numbers on at least one VCPU after creating all VCPUs and before running any
>  VCPUs.
>  
> +2.2. ATTRIBUTE: KVM_ARM_VCPU_TIMER_OFFSET
> +-----------------------------------------
> +
> +:Parameters: in kvm_device_attr.addr the address for the timer offset is a
> +             pointer to a __u64
> +
> +Returns:
> +
> +	 ======= ==================================
> +	 -EFAULT Error reading/writing the provided
> +		 parameter address
> +	 -ENXIO  Timer offsetting not implemented
> +	 ======= ==================================
> +
> +Specifies the guest's counter-timer offset from the host's virtual counter.
> +The guest's physical counter value is then derived by the following
> +equation:
> +
> +  guest_cntpct = host_cntvct - KVM_ARM_VCPU_TIMER_OFFSET
> +
> +The guest's virtual counter value is derived by the following equation:
> +
> +  guest_cntvct = host_cntvct - KVM_REG_ARM_TIMER_OFFSET
> +			- KVM_ARM_VCPU_TIMER_OFFSET
> +
> +KVM does not allow the use of varying offset values for different vCPUs;
> +the last written offset value will be broadcasted to all vCPUs in a VM.
> +
>  3. GROUP: KVM_ARM_VCPU_PVTIME_CTRL
>  ==================================
>  
> diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> index 9f0bf2109be7..ab1c8fdb0177 100644
> --- a/arch/arm64/include/asm/kvm_asm.h
> +++ b/arch/arm64/include/asm/kvm_asm.h
> @@ -65,6 +65,7 @@
>  #define __KVM_HOST_SMCCC_FUNC___pkvm_prot_finalize		19
>  #define __KVM_HOST_SMCCC_FUNC___pkvm_mark_hyp			20
>  #define __KVM_HOST_SMCCC_FUNC___kvm_adjust_pc			21
> +#define __KVM_HOST_SMCCC_FUNC___kvm_timer_set_cntpoff		22
>  
>  #ifndef __ASSEMBLY__
>  
> @@ -200,6 +201,7 @@ extern void __kvm_tlb_flush_vmid_ipa(struct kvm_s2_mmu *mmu, phys_addr_t ipa,
>  extern void __kvm_tlb_flush_vmid(struct kvm_s2_mmu *mmu);
>  
>  extern void __kvm_timer_set_cntvoff(u64 cntvoff);
> +extern void __kvm_timer_set_cntpoff(u64 cntpoff);
>  
>  extern int __kvm_vcpu_run(struct kvm_vcpu *vcpu);
>  
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 4dfc44066dfb..c34672aa65b9 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -586,6 +586,8 @@
>  #define SYS_ICH_LR14_EL2		__SYS__LR8_EL2(6)
>  #define SYS_ICH_LR15_EL2		__SYS__LR8_EL2(7)
>  
> +#define SYS_CNTPOFF_EL2			sys_reg(3, 4, 14, 0, 6)
> +
>  /* VHE encodings for architectural EL0/1 system registers */
>  #define SYS_SCTLR_EL12			sys_reg(3, 5, 1, 0, 0)
>  #define SYS_CPACR_EL12			sys_reg(3, 5, 1, 0, 2)
> diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
> index 949a31bc10f0..15150f8224a1 100644
> --- a/arch/arm64/include/uapi/asm/kvm.h
> +++ b/arch/arm64/include/uapi/asm/kvm.h
> @@ -366,6 +366,7 @@ struct kvm_arm_copy_mte_tags {
>  #define KVM_ARM_VCPU_TIMER_CTRL		1
>  #define   KVM_ARM_VCPU_TIMER_IRQ_VTIMER		0
>  #define   KVM_ARM_VCPU_TIMER_IRQ_PTIMER		1
> +#define   KVM_ARM_VCPU_TIMER_OFFSET		2
>  #define KVM_ARM_VCPU_PVTIME_CTRL	2
>  #define   KVM_ARM_VCPU_PVTIME_IPA	0
>  
> diff --git a/arch/arm64/kvm/arch_timer.c b/arch/arm64/kvm/arch_timer.c
> index a8815b09da3e..f15058612994 100644
> --- a/arch/arm64/kvm/arch_timer.c
> +++ b/arch/arm64/kvm/arch_timer.c
> @@ -85,11 +85,15 @@ u64 timer_get_cval(struct arch_timer_context *ctxt)
>  static u64 timer_get_offset(struct arch_timer_context *ctxt)
>  {
>  	struct kvm_vcpu *vcpu = ctxt->vcpu;
> +	struct arch_timer_cpu *timer = vcpu_timer(vcpu);

This new timer variable doesn't appear to get used.

>  
>  	switch(arch_timer_ctx_index(ctxt)) {
>  	case TIMER_VTIMER:
> +	case TIMER_PTIMER:
>  		return ctxt->host_offset;
>  	default:
> +		WARN_ONCE(1, "unrecognized timer %ld\n",
> +			  arch_timer_ctx_index(ctxt));
>  		return 0;
>  	}
>  }
> @@ -144,6 +148,7 @@ static void timer_set_offset(struct arch_timer_context *ctxt, u64 offset)
>  
>  	switch(arch_timer_ctx_index(ctxt)) {
>  	case TIMER_VTIMER:
> +	case TIMER_PTIMER:
>  		ctxt->host_offset = offset;
>  		break;
>  	default:
> @@ -572,6 +577,11 @@ static void set_cntvoff(u64 cntvoff)
>  	kvm_call_hyp(__kvm_timer_set_cntvoff, cntvoff);
>  }
>  
> +static void set_cntpoff(u64 cntpoff)
> +{
> +	kvm_call_hyp(__kvm_timer_set_cntpoff, cntpoff);
> +}
> +
>  static inline void set_timer_irq_phys_active(struct arch_timer_context *ctx, bool active)
>  {
>  	int r;
> @@ -647,6 +657,8 @@ void kvm_timer_vcpu_load(struct kvm_vcpu *vcpu)
>  	}
>  
>  	set_cntvoff(timer_get_offset(map.direct_vtimer));
> +	if (cpus_have_const_cap(ARM64_ECV))
> +		set_cntpoff(timer_get_offset(vcpu_ptimer(vcpu)));
>  
>  	kvm_timer_unblocking(vcpu);
>  
> @@ -814,6 +826,22 @@ static void update_vtimer_cntvoff(struct kvm_vcpu *vcpu, u64 cntvoff)
>  	mutex_unlock(&kvm->lock);
>  }
>  
> +static void update_ptimer_cntpoff(struct kvm_vcpu *vcpu, u64 cntpoff)
> +{
> +	struct kvm *kvm = vcpu->kvm;
> +	u64 cntvoff;
> +
> +	mutex_lock(&kvm->lock);
> +
> +	/* adjustments to the physical offset also affect vtimer */
> +	cntvoff = timer_get_offset(vcpu_vtimer(vcpu));
> +	cntvoff += cntpoff - timer_get_offset(vcpu_ptimer(vcpu));
> +
> +	update_timer_offset(vcpu, TIMER_PTIMER, cntpoff, false);
> +	update_timer_offset(vcpu, TIMER_VTIMER, cntvoff, false);
> +	mutex_unlock(&kvm->lock);
> +}
> +
>  void kvm_timer_vcpu_init(struct kvm_vcpu *vcpu)
>  {
>  	struct arch_timer_cpu *timer = vcpu_timer(vcpu);
> @@ -932,6 +960,29 @@ u64 kvm_arm_timer_get_reg(struct kvm_vcpu *vcpu, u64 regid)
>  	return (u64)-1;
>  }
>  
> +/**
> + * kvm_arm_timer_read_offset - returns the guest value of CNTVOFF_EL2.
> + * @vcpu: the vcpu pointer
> + *
> + * Computes the guest value of CNTVOFF_EL2 by subtracting the physical
> + * counter offset. Note that KVM defines CNTVOFF_EL2 as the offset from the
> + * guest's physical counter-timer, not the host's.
> + *
> + * Returns: the guest value for CNTVOFF_EL2
> + */
> +static u64 kvm_arm_timer_read_offset(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm *kvm = vcpu->kvm;
> +	u64 offset;
> +
> +	mutex_lock(&kvm->lock);
> +	offset = timer_get_offset(vcpu_vtimer(vcpu)) -
> +			timer_get_offset(vcpu_ptimer(vcpu));
> +	mutex_unlock(&kvm->lock);
> +
> +	return offset;
> +}
> +
>  static u64 kvm_arm_timer_read(struct kvm_vcpu *vcpu,
>  			      struct arch_timer_context *timer,
>  			      enum kvm_arch_timer_regs treg)
> @@ -957,7 +1008,7 @@ static u64 kvm_arm_timer_read(struct kvm_vcpu *vcpu,
>  		break;
>  
>  	case TIMER_REG_OFFSET:
> -		val = timer_get_offset(timer);
> +		val = kvm_arm_timer_read_offset(vcpu);
>  		break;
>  
>  	default:
> @@ -1350,6 +1401,9 @@ void kvm_timer_init_vhe(void)
>  	val = read_sysreg(cnthctl_el2);
>  	val |= (CNTHCTL_EL1PCEN << cnthctl_shift);
>  	val |= (CNTHCTL_EL1PCTEN << cnthctl_shift);
> +
> +	if (cpus_have_const_cap(ARM64_ECV))
> +		val |= CNTHCTL_ECV;
>  	write_sysreg(val, cnthctl_el2);
>  }
>  
> @@ -1364,7 +1418,8 @@ static void set_timer_irqs(struct kvm *kvm, int vtimer_irq, int ptimer_irq)
>  	}
>  }
>  
> -int kvm_arm_timer_set_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
> +static int kvm_arm_timer_set_attr_irq(struct kvm_vcpu *vcpu,
> +				      struct kvm_device_attr *attr)
>  {
>  	int __user *uaddr = (int __user *)(long)attr->addr;
>  	struct arch_timer_context *vtimer = vcpu_vtimer(vcpu);
> @@ -1397,7 +1452,37 @@ int kvm_arm_timer_set_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
>  	return 0;
>  }
>  
> -int kvm_arm_timer_get_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
> +static int kvm_arm_timer_set_attr_offset(struct kvm_vcpu *vcpu,
> +					 struct kvm_device_attr *attr)
> +{
> +	u64 __user *uaddr = (u64 __user *)(long)attr->addr;
> +	u64 offset;
> +
> +	if (!cpus_have_const_cap(ARM64_ECV))
> +		return -ENXIO;
> +
> +	if (get_user(offset, uaddr))
> +		return -EFAULT;
> +
> +	update_ptimer_cntpoff(vcpu, offset);
> +	return 0;
> +}
> +
> +int kvm_arm_timer_set_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
> +{
> +	switch (attr->attr) {
> +	case KVM_ARM_VCPU_TIMER_IRQ_VTIMER:
> +	case KVM_ARM_VCPU_TIMER_IRQ_PTIMER:
> +		return kvm_arm_timer_set_attr_irq(vcpu, attr);
> +	case KVM_ARM_VCPU_TIMER_OFFSET:
> +		return kvm_arm_timer_set_attr_offset(vcpu, attr);
> +	default:
> +		return -ENXIO;
> +	}
> +}
> +
> +static int kvm_arm_timer_get_attr_irq(struct kvm_vcpu *vcpu,
> +				      struct kvm_device_attr *attr)
>  {
>  	int __user *uaddr = (int __user *)(long)attr->addr;
>  	struct arch_timer_context *timer;
> @@ -1418,12 +1503,43 @@ int kvm_arm_timer_get_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
>  	return put_user(irq, uaddr);
>  }
>  
> +static int kvm_arm_timer_get_attr_offset(struct kvm_vcpu *vcpu,
> +					 struct kvm_device_attr *attr)
> +{
> +	u64 __user *uaddr = (u64 __user *)(long)attr->addr;
> +	u64 offset;
> +
> +	if (!cpus_have_const_cap(ARM64_ECV))
> +		return -ENXIO;
> +
> +	offset = timer_get_offset(vcpu_ptimer(vcpu));
> +	return put_user(offset, uaddr);
> +}
> +
> +int kvm_arm_timer_get_attr(struct kvm_vcpu *vcpu,
> +			   struct kvm_device_attr *attr)
> +{
> +	switch (attr->attr) {
> +	case KVM_ARM_VCPU_TIMER_IRQ_VTIMER:
> +	case KVM_ARM_VCPU_TIMER_IRQ_PTIMER:
> +		return kvm_arm_timer_get_attr_irq(vcpu, attr);
> +	case KVM_ARM_VCPU_TIMER_OFFSET:
> +		return kvm_arm_timer_get_attr_offset(vcpu, attr);
> +	default:
> +		return -ENXIO;
> +	}
> +}
> +
>  int kvm_arm_timer_has_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
>  {
>  	switch (attr->attr) {
>  	case KVM_ARM_VCPU_TIMER_IRQ_VTIMER:
>  	case KVM_ARM_VCPU_TIMER_IRQ_PTIMER:
>  		return 0;
> +	case KVM_ARM_VCPU_TIMER_OFFSET:
> +		if (cpus_have_const_cap(ARM64_ECV))
> +			return 0;
> +		break;
>  	}
>  
>  	return -ENXIO;
> diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> index 1632f001f4ed..cfa923df3af6 100644
> --- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> +++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> @@ -68,6 +68,11 @@ static void handle___kvm_timer_set_cntvoff(struct kvm_cpu_context *host_ctxt)
>  	__kvm_timer_set_cntvoff(cpu_reg(host_ctxt, 1));
>  }
>  
> +static void handle___kvm_timer_set_cntpoff(struct kvm_cpu_context *host_ctxt)
> +{
> +	__kvm_timer_set_cntpoff(cpu_reg(host_ctxt, 1));
> +}
> +
>  static void handle___kvm_enable_ssbs(struct kvm_cpu_context *host_ctxt)
>  {
>  	u64 tmp;
> @@ -197,6 +202,7 @@ static const hcall_t host_hcall[] = {
>  	HANDLE_FUNC(__pkvm_create_private_mapping),
>  	HANDLE_FUNC(__pkvm_prot_finalize),
>  	HANDLE_FUNC(__pkvm_mark_hyp),
> +	HANDLE_FUNC(__kvm_timer_set_cntpoff),
>  };
>  
>  static void handle_host_hcall(struct kvm_cpu_context *host_ctxt)
> diff --git a/arch/arm64/kvm/hyp/nvhe/timer-sr.c b/arch/arm64/kvm/hyp/nvhe/timer-sr.c
> index 9072e71693ba..5b8b4cd02506 100644
> --- a/arch/arm64/kvm/hyp/nvhe/timer-sr.c
> +++ b/arch/arm64/kvm/hyp/nvhe/timer-sr.c
> @@ -15,6 +15,11 @@ void __kvm_timer_set_cntvoff(u64 cntvoff)
>  	write_sysreg(cntvoff, cntvoff_el2);
>  }
>  
> +void __kvm_timer_set_cntpoff(u64 cntpoff)
> +{
> +	write_sysreg_s(cntpoff, SYS_CNTPOFF_EL2);
> +}
> +
>  /*
>   * Should only be called on non-VHE systems.
>   * VHE systems use EL2 timers and configure EL1 timers in kvm_timer_init_vhe().
> diff --git a/arch/arm64/kvm/hyp/vhe/timer-sr.c b/arch/arm64/kvm/hyp/vhe/timer-sr.c
> index 4cda674a8be6..231e16a071a5 100644
> --- a/arch/arm64/kvm/hyp/vhe/timer-sr.c
> +++ b/arch/arm64/kvm/hyp/vhe/timer-sr.c
> @@ -10,3 +10,8 @@ void __kvm_timer_set_cntvoff(u64 cntvoff)
>  {
>  	write_sysreg(cntvoff, cntvoff_el2);
>  }
> +
> +void __kvm_timer_set_cntpoff(u64 cntpoff)
> +{
> +	write_sysreg_s(cntpoff, SYS_CNTPOFF_EL2);
> +}
> diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
> index 73c7139c866f..7252ffa3d675 100644
> --- a/include/clocksource/arm_arch_timer.h
> +++ b/include/clocksource/arm_arch_timer.h
> @@ -21,6 +21,7 @@
>  #define CNTHCTL_EVNTEN			(1 << 2)
>  #define CNTHCTL_EVNTDIR			(1 << 3)
>  #define CNTHCTL_EVNTI			(0xF << 4)
> +#define CNTHCTL_ECV			(1 << 12)
>  
>  enum arch_timer_reg {
>  	ARCH_TIMER_REG_CTRL,
> -- 
> 2.32.0.605.g8dce9f2422-goog
>

Reviewed-by: Andrew Jones <drjones@redhat.com>

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
