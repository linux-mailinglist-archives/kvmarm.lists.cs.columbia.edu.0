Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 616EE29702
	for <lists+kvmarm@lfdr.de>; Fri, 24 May 2019 13:21:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E5AC84A4CD;
	Fri, 24 May 2019 07:21:54 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OL1NDHLYvaUc; Fri, 24 May 2019 07:21:54 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2F1A94A4C2;
	Fri, 24 May 2019 07:21:53 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A4D304A380
 for <kvmarm@lists.cs.columbia.edu>; Fri, 24 May 2019 07:21:52 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OyT9BFR-hTez for <kvmarm@lists.cs.columbia.edu>;
 Fri, 24 May 2019 07:21:50 -0400 (EDT)
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B558E4A2E7
 for <kvmarm@lists.cs.columbia.edu>; Fri, 24 May 2019 07:21:50 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F6B7374;
 Fri, 24 May 2019 04:21:50 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 189EA3F703;
 Fri, 24 May 2019 04:21:47 -0700 (PDT)
Date: Fri, 24 May 2019 12:21:45 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v2 12/15] KVM: arm64: add a new vcpu device control group
 for SPEv1
Message-ID: <20190524112145.GC13121@e107155-lin>
References: <20190523103502.25925-1-sudeep.holla@arm.com>
 <20190523103502.25925-13-sudeep.holla@arm.com>
 <a2d64bf0-2424-83c5-d3c8-17affd59dd20@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a2d64bf0-2424-83c5-d3c8-17affd59dd20@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>, kvmarm@lists.cs.columbia.edu,
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

On Fri, May 24, 2019 at 11:37:51AM +0100, Marc Zyngier wrote:
> Hi Sudeep,
> 
> On 23/05/2019 11:34, Sudeep Holla wrote:
> > To configure the virtual SPEv1 overflow interrupt number, we use the
> > vcpu kvm_device ioctl, encapsulating the KVM_ARM_VCPU_SPE_V1_IRQ
> > attribute within the KVM_ARM_VCPU_SPE_V1_CTRL group.
> > 
> > After configuring the SPEv1, call the vcpu ioctl with attribute
> > KVM_ARM_VCPU_SPE_V1_INIT to initialize the SPEv1.
> > 
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  Documentation/virtual/kvm/devices/vcpu.txt |  28 ++++
> >  arch/arm64/include/asm/kvm_host.h          |   2 +-
> >  arch/arm64/include/uapi/asm/kvm.h          |   4 +
> >  arch/arm64/kvm/Makefile                    |   1 +
> >  arch/arm64/kvm/guest.c                     |   9 ++
> >  arch/arm64/kvm/reset.c                     |   3 +
> >  include/kvm/arm_spe.h                      |  35 +++++
> >  include/uapi/linux/kvm.h                   |   1 +
> >  virt/kvm/arm/arm.c                         |   1 +
> >  virt/kvm/arm/spe.c                         | 163 +++++++++++++++++++++
> >  10 files changed, 246 insertions(+), 1 deletion(-)
> >  create mode 100644 virt/kvm/arm/spe.c
> > 
> > diff --git a/Documentation/virtual/kvm/devices/vcpu.txt b/Documentation/virtual/kvm/devices/vcpu.txt
> > index 2b5dab16c4f2..d1ece488aeee 100644
> > --- a/Documentation/virtual/kvm/devices/vcpu.txt
> > +++ b/Documentation/virtual/kvm/devices/vcpu.txt
> > @@ -60,3 +60,31 @@ time to use the number provided for a given timer, overwriting any previously
> >  configured values on other VCPUs.  Userspace should configure the interrupt
> >  numbers on at least one VCPU after creating all VCPUs and before running any
> >  VCPUs.
> > +
> > +3. GROUP: KVM_ARM_VCPU_SPE_V1_CTRL
> > +Architectures: ARM64
> > +
> > +1.1. ATTRIBUTE: KVM_ARM_VCPU_SPE_V1_IRQ
> > +Parameters: in kvm_device_attr.addr the address for SPE buffer overflow interrupt
> > +	    is a pointer to an int
> > +Returns: -EBUSY: The SPE overflow interrupt is already set
> > +         -ENXIO: The overflow interrupt not set when attempting to get it
> > +         -ENODEV: SPEv1 not supported
> > +         -EINVAL: Invalid SPE overflow interrupt number supplied or
> > +                  trying to set the IRQ number without using an in-kernel
> > +                  irqchip.
> > +
> > +A value describing the SPEv1 (Statistical Profiling Extension v1) overflow
> > +interrupt number for this vcpu. This interrupt should be PPI and the interrupt
> > +type and number must be same for each vcpu.
> > +
> > +1.2 ATTRIBUTE: KVM_ARM_VCPU_SPE_V1_INIT
> > +Parameters: no additional parameter in kvm_device_attr.addr
> > +Returns: -ENODEV: SPEv1 not supported or GIC not initialized
> > +         -ENXIO: SPEv1 not properly configured or in-kernel irqchip not
> > +                 configured as required prior to calling this attribute
> > +         -EBUSY: SPEv1 already initialized
> > +
> > +Request the initialization of the SPEv1.  If using the SPEv1 with an in-kernel
> > +virtual GIC implementation, this must be done after initializing the in-kernel
> > +irqchip.
> > diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> > index 6921fdfd477b..fc4ead0774b3 100644
> > --- a/arch/arm64/include/asm/kvm_host.h
> > +++ b/arch/arm64/include/asm/kvm_host.h
> > @@ -50,7 +50,7 @@
> >  
> >  #define KVM_MAX_VCPUS VGIC_V3_MAX_CPUS
> >  
> > -#define KVM_VCPU_MAX_FEATURES 7
> > +#define KVM_VCPU_MAX_FEATURES 8
> >  
> >  #define KVM_REQ_SLEEP \
> >  	KVM_ARCH_REQ_FLAGS(0, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
> > diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
> > index 7b7ac0f6cec9..4c9e168de896 100644
> > --- a/arch/arm64/include/uapi/asm/kvm.h
> > +++ b/arch/arm64/include/uapi/asm/kvm.h
> > @@ -106,6 +106,7 @@ struct kvm_regs {
> >  #define KVM_ARM_VCPU_SVE		4 /* enable SVE for this CPU */
> >  #define KVM_ARM_VCPU_PTRAUTH_ADDRESS	5 /* VCPU uses address authentication */
> >  #define KVM_ARM_VCPU_PTRAUTH_GENERIC	6 /* VCPU uses generic authentication */
> > +#define KVM_ARM_VCPU_SPE_V1		7 /* Support guest SPEv1 */
> >  
> >  struct kvm_vcpu_init {
> >  	__u32 target;
> > @@ -306,6 +307,9 @@ struct kvm_vcpu_events {
> >  #define KVM_ARM_VCPU_TIMER_CTRL		1
> >  #define   KVM_ARM_VCPU_TIMER_IRQ_VTIMER		0
> >  #define   KVM_ARM_VCPU_TIMER_IRQ_PTIMER		1
> > +#define KVM_ARM_VCPU_SPE_V1_CTRL	2
> > +#define   KVM_ARM_VCPU_SPE_V1_IRQ	0
> > +#define   KVM_ARM_VCPU_SPE_V1_INIT	1
> >  
> >  /* KVM_IRQ_LINE irq field index values */
> >  #define KVM_ARM_IRQ_TYPE_SHIFT		24
> > diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
> > index 3ac1a64d2fb9..1ba6154dd8e1 100644
> > --- a/arch/arm64/kvm/Makefile
> > +++ b/arch/arm64/kvm/Makefile
> > @@ -35,3 +35,4 @@ kvm-$(CONFIG_KVM_ARM_HOST) += $(KVM)/arm/vgic/vgic-debug.o
> >  kvm-$(CONFIG_KVM_ARM_HOST) += $(KVM)/irqchip.o
> >  kvm-$(CONFIG_KVM_ARM_HOST) += $(KVM)/arm/arch_timer.o
> >  kvm-$(CONFIG_KVM_ARM_PMU) += $(KVM)/arm/pmu.o
> > +kvm-$(CONFIG_KVM_ARM_SPE) += $(KVM)/arm/spe.o
> > diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> > index 3ae2f82fca46..02c28a7eb332 100644
> > --- a/arch/arm64/kvm/guest.c
> > +++ b/arch/arm64/kvm/guest.c
> > @@ -848,6 +848,9 @@ int kvm_arm_vcpu_arch_set_attr(struct kvm_vcpu *vcpu,
> >  	case KVM_ARM_VCPU_TIMER_CTRL:
> >  		ret = kvm_arm_timer_set_attr(vcpu, attr);
> >  		break;
> > +	case KVM_ARM_VCPU_SPE_V1_CTRL:
> > +		ret = kvm_arm_spe_v1_set_attr(vcpu, attr);
> > +		break;
> >  	default:
> >  		ret = -ENXIO;
> >  		break;
> > @@ -868,6 +871,9 @@ int kvm_arm_vcpu_arch_get_attr(struct kvm_vcpu *vcpu,
> >  	case KVM_ARM_VCPU_TIMER_CTRL:
> >  		ret = kvm_arm_timer_get_attr(vcpu, attr);
> >  		break;
> > +	case KVM_ARM_VCPU_SPE_V1_CTRL:
> > +		ret = kvm_arm_spe_v1_get_attr(vcpu, attr);
> > +		break;
> >  	default:
> >  		ret = -ENXIO;
> >  		break;
> > @@ -888,6 +894,9 @@ int kvm_arm_vcpu_arch_has_attr(struct kvm_vcpu *vcpu,
> >  	case KVM_ARM_VCPU_TIMER_CTRL:
> >  		ret = kvm_arm_timer_has_attr(vcpu, attr);
> >  		break;
> > +	case KVM_ARM_VCPU_SPE_V1_CTRL:
> > +		ret = kvm_arm_spe_v1_has_attr(vcpu, attr);
> > +		break;
> >  	default:
> >  		ret = -ENXIO;
> >  		break;
> > diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
> > index 1140b4485575..33ce5248613e 100644
> > --- a/arch/arm64/kvm/reset.c
> > +++ b/arch/arm64/kvm/reset.c
> > @@ -91,6 +91,9 @@ int kvm_arch_vm_ioctl_check_extension(struct kvm *kvm, long ext)
> >  	case KVM_CAP_ARM_INJECT_SERROR_ESR:
> >  		r = cpus_have_const_cap(ARM64_HAS_RAS_EXTN);
> >  		break;
> > +	case KVM_CAP_ARM_SPE_V1:
> > +		r = kvm_arm_support_spe_v1();
> > +		break;
> >  	case KVM_CAP_SET_GUEST_DEBUG:
> >  	case KVM_CAP_VCPU_ATTRIBUTES:
> >  		r = 1;
> > diff --git a/include/kvm/arm_spe.h b/include/kvm/arm_spe.h
> > index fdcb0df1e0fd..8c2e8f10a965 100644
> > --- a/include/kvm/arm_spe.h
> > +++ b/include/kvm/arm_spe.h
> > @@ -19,6 +19,9 @@ struct kvm_spe {
> >  #ifdef CONFIG_KVM_ARM_SPE
> >  
> >  #define kvm_arm_spe_v1_ready(v)		((v)->arch.spe.ready)
> > +#define kvm_arm_spe_irq_initialized(v)		\
> > +	((v)->arch.spe.irq >= VGIC_NR_SGIS &&	\
> > +	(v)->arch.spe.irq <= VGIC_MAX_PRIVATE)
> >  
> >  static inline bool kvm_arm_support_spe_v1(void)
> >  {
> > @@ -27,10 +30,42 @@ static inline bool kvm_arm_support_spe_v1(void)
> >  	return !!cpuid_feature_extract_unsigned_field(dfr0,
> >  						      ID_AA64DFR0_PMSVER_SHIFT);
> >  }
> > +
> > +int kvm_arm_spe_v1_set_attr(struct kvm_vcpu *vcpu,
> > +			    struct kvm_device_attr *attr);
> > +int kvm_arm_spe_v1_get_attr(struct kvm_vcpu *vcpu,
> > +			    struct kvm_device_attr *attr);
> > +int kvm_arm_spe_v1_has_attr(struct kvm_vcpu *vcpu,
> > +			    struct kvm_device_attr *attr);
> > +int kvm_arm_spe_v1_enable(struct kvm_vcpu *vcpu);
> >  #else
> >  
> >  #define kvm_arm_spe_v1_ready(v)		(false)
> >  #define kvm_arm_support_spe_v1()	(false)
> > +#define kvm_arm_spe_irq_initialized(v)	(false)
> > +
> > +static inline int kvm_arm_spe_v1_set_attr(struct kvm_vcpu *vcpu,
> > +					  struct kvm_device_attr *attr)
> > +{
> > +	return -ENXIO;
> > +}
> > +
> > +static inline int kvm_arm_spe_v1_get_attr(struct kvm_vcpu *vcpu,
> > +					  struct kvm_device_attr *attr)
> > +{
> > +	return -ENXIO;
> > +}
> > +
> > +static inline int kvm_arm_spe_v1_has_attr(struct kvm_vcpu *vcpu,
> > +					  struct kvm_device_attr *attr)
> > +{
> > +	return -ENXIO;
> > +}
> > +
> > +static inline int kvm_arm_spe_v1_enable(struct kvm_vcpu *vcpu)
> > +{
> > +	return 0;
> > +}
> >  #endif /* CONFIG_KVM_ARM_SPE */
> >  
> >  #endif /* __ASM_ARM_KVM_SPE_H */
> > diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> > index 2fe12b40d503..698bcc2f96e3 100644
> > --- a/include/uapi/linux/kvm.h
> > +++ b/include/uapi/linux/kvm.h
> > @@ -993,6 +993,7 @@ struct kvm_ppc_resize_hpt {
> >  #define KVM_CAP_ARM_SVE 170
> >  #define KVM_CAP_ARM_PTRAUTH_ADDRESS 171
> >  #define KVM_CAP_ARM_PTRAUTH_GENERIC 172
> > +#define KVM_CAP_ARM_SPE_V1 173
> >  
> >  #ifdef KVM_CAP_IRQ_ROUTING
> >  
> > diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
> > index 90cedebaeb94..c5b711ef1cf8 100644
> > --- a/virt/kvm/arm/arm.c
> > +++ b/virt/kvm/arm/arm.c
> > @@ -34,6 +34,7 @@
> >  #include <trace/events/kvm.h>
> >  #include <kvm/arm_pmu.h>
> >  #include <kvm/arm_psci.h>
> > +#include <kvm/arm_spe.h>
> >  
> >  #define CREATE_TRACE_POINTS
> >  #include "trace.h"
> > diff --git a/virt/kvm/arm/spe.c b/virt/kvm/arm/spe.c
> > new file mode 100644
> > index 000000000000..87f02ed92426
> > --- /dev/null
> > +++ b/virt/kvm/arm/spe.c
> > @@ -0,0 +1,163 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2018 ARM Ltd.
> > + */
> > +
> > +#include <linux/cpu.h>
> > +#include <linux/kvm.h>
> > +#include <linux/kvm_host.h>
> > +#include <linux/uaccess.h>
> > +#include <asm/kvm_emulate.h>
> > +#include <kvm/arm_spe.h>
> > +#include <kvm/arm_vgic.h>
> > +
> > +int kvm_arm_spe_v1_enable(struct kvm_vcpu *vcpu)
> > +{
> > +	if (!vcpu->arch.spe.created)
> > +		return 0;
> > +
> > +	/*
> > +	 * A valid interrupt configuration for the SPE is either to have a
> > +	 * properly configured interrupt number and using an in-kernel irqchip.
> > +	 */
> > +	if (irqchip_in_kernel(vcpu->kvm)) {
> > +		int irq = vcpu->arch.spe.irq;
> > +
> > +		if (!kvm_arm_spe_irq_initialized(vcpu))
> > +			return -EINVAL;
> > +
> > +		if (!irq_is_ppi(irq))
> > +			return -EINVAL;
> > +	}
> > +
> > +	vcpu->arch.spe.ready = true;
> 
> I don't think we should entertain the idea of using SPE without an
> in-kernel irqchip, nor on systems that do not have a GIC.
>

I agree, but sorry I didn't realise that this infrastructure is just
to deal with those scenario. I assume these in place for sanity check
the details we get from DT/ACPI. My assumption is completely wrong I
suppose.

> But there is a more fundamental issue here: I do not see how the SPE
> interrupt get injected in the guest. I've gone through the series twice,
> and I can't see how we go from a physical interrupt triggered by the HW
> on the host to a virtual interrupt injected in the guest.
>

I haven't been able to trigger error/overflow interrupt from the guest
so far on the models. I initial started taking PMU KVM implementation
as reference and soon realised it is quite different. IIUC, we don't
need to inject the interrupt and KVM takes care to set the corresponding
virtual INTID to the pending state on vCPU.

--
Regards,
Sudeep


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
