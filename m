Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE6150C140
	for <lists+kvmarm@lfdr.de>; Fri, 22 Apr 2022 23:49:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 66AE04B0CC;
	Fri, 22 Apr 2022 17:49:07 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.788
X-Spam-Level: 
X-Spam-Status: No, score=-1.788 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4dzGxaW8NAfK; Fri, 22 Apr 2022 17:49:07 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9A2EC4B0CE;
	Fri, 22 Apr 2022 17:49:05 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2EA0B4A193
 for <kvmarm@lists.cs.columbia.edu>; Fri, 22 Apr 2022 17:49:05 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SwOLM3t6X083 for <kvmarm@lists.cs.columbia.edu>;
 Fri, 22 Apr 2022 17:49:03 -0400 (EDT)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com
 [209.85.166.44])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 58F8C49F44
 for <kvmarm@lists.cs.columbia.edu>; Fri, 22 Apr 2022 17:49:03 -0400 (EDT)
Received: by mail-io1-f44.google.com with SMTP id r12so9972494iod.6
 for <kvmarm@lists.cs.columbia.edu>; Fri, 22 Apr 2022 14:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Wqxk/7BWwKhDbIHiaUdzBDMbMgVZ3yRG1SK0Ix0NMTU=;
 b=O+rU6Jlxdx3sjpU8SpvNtEOHSoylnhjDYkTP99JS87zk8xt54LYOPh9o+072XLOaDk
 Z+89i8rH7C1ZPQn2mGJdCB/CRnsvE9pAcJ6FybN+4xfCpCQchsdI/HaoIAg3bJEnZVkH
 k9UbKMzgATyYX+W2rdi15ekS3g21egGW25TECXUlBGB2fwT/zOu7jkwEKqOt1Kn7kM0k
 CRgDO4poVjqs8ZZF/NUSYqpsUOpt5vnnNZM1iBFbuTI1talVCJ/QI389nAFjLTgHNTVn
 bz7T3wvgKTZ3YKhseH5iHl1qpH/kWFVS3ceWAy2W+kSylWmnHJQkP6vIhxoqxUxH/peV
 Wpyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Wqxk/7BWwKhDbIHiaUdzBDMbMgVZ3yRG1SK0Ix0NMTU=;
 b=K+5jyUejxdLJ8EMxARx+FvpL+Q11AKDQ8lygmRWmmD32c8ae/kTUAgm16DeofUQN6E
 KnWuyTYIG1W1QP4ZNzAf8eDMmMzqhxtlwY0722c8z58HAgN/FYjwFDrIllGq8TO6WtE5
 HIDIKJcuja7Vtrsd+TkzcaOVD/SqK8bD7ura0KCyQhZAZzHU7n1qviwl/oecNEODu98z
 c60/5tNn2gU7nsLqjLEems+e0+ThjpXuvrJ+CWmZsy7+/1XKX6LTMl6YfF/aD2tpmQsI
 K36HkXRUSmkZhaPXZOrehOh9DhQug4UefPaV3sW9p8xC5nEqhwII35Frny/Tes6q5l7c
 cZTQ==
X-Gm-Message-State: AOAM530xnoTSc0c5VL5S4f9VyPYSdEB/bL/oFWlgD1a8DG26WA9vyg2K
 8YVvl/KE1M7O3qZ4WdemVptHSA==
X-Google-Smtp-Source: ABdhPJxFrY69lvePMpjbME6SDx+A/cbPBDwjdJ1k4CPYAtnQCgb9hI+2EQqelXg5xz5r5XBurSZ4Hw==
X-Received: by 2002:a05:6638:d06:b0:326:ba0:347 with SMTP id
 q6-20020a0566380d0600b003260ba00347mr2922518jaj.68.1650664142366; 
 Fri, 22 Apr 2022 14:49:02 -0700 (PDT)
Received: from google.com (194.225.68.34.bc.googleusercontent.com.
 [34.68.225.194]) by smtp.gmail.com with ESMTPSA id
 l14-20020a05660227ce00b00645ebb013c1sm2690453ios.45.2022.04.22.14.49.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Apr 2022 14:49:01 -0700 (PDT)
Date: Fri, 22 Apr 2022 21:48:58 +0000
From: Oliver Upton <oupton@google.com>
To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v6 03/18] KVM: arm64: Add SDEI virtualization
 infrastructure
Message-ID: <YmMiyt/TDjJt0mdG@google.com>
References: <20220403153911.12332-1-gshan@redhat.com>
 <20220403153911.12332-4-gshan@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220403153911.12332-4-gshan@redhat.com>
Cc: maz@kernel.org, linux-kernel@vger.kernel.org, eauger@redhat.com,
 shan.gavin@gmail.com, Jonathan.Cameron@huawei.com, pbonzini@redhat.com,
 vkuznets@redhat.com, will@kernel.org, kvmarm@lists.cs.columbia.edu
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

On Sun, Apr 03, 2022 at 11:38:56PM +0800, Gavin Shan wrote:
> Software Delegated Exception Interface (SDEI) provides a mechanism
> for registering and servicing system events, as defined by ARM DEN0054C
> specification. One of these events will be used by Asynchronous Page
> Fault (Async PF) to deliver notifications from host to guest.
> 
> The events are classified into shared and private ones according to
> their scopes. The shared events are system or VM scoped, but the
> private events are CPU or VCPU scoped. The shared events can be
> registered, enabled, unregistered and reset through hypercalls
> issued from any VCPU. However, the private events are registered,
> enabled, unregistered and reset on the calling VCPU through
> hypercalls. Besides, the events are also classified into critical
> and normal events according their priority. During event delivery
> and handling, the normal event can be preempted by another critical
> event, but not in reverse way. The critical event is never preempted
> by another normal event.

We don't have any need for critical events though, right? We should avoid
building out the plumbing around the concept of critical events until
there is an actual use case for it.

> This introduces SDEI virtualization infrastructure for various objects
> used in the implementation. Currently, we don't support the shared
> event.
> 
>   * kvm_sdei_exposed_event
>     The event which are defined and exposed by KVM. The event can't
>     be registered until it's exposed. Besides, all the information
>     in this event can't be changed after it's exposed.
> 
>   * kvm_sdei_event
>     The events are created based on the exposed events. Their states
>     are changed when hypercalls are received or they are delivered
>     to guest for handling.
> 
>   * kvm_sdei_vcpu_context
>     The vcpu context helps to handle events. The interrupted context
>     is saved before the event handler is executed, and restored after
>     the event handler is to finish.
> 
>   * kvm_sdei_vcpu
>     Place holder for all objects for one particular VCPU.
> 
> The error of SDEI_NOT_SUPPORTED is returned for all hypercalls for now.
> They will be supported one by one in the subsequent patches.
> 
> Link: https://developer.arm.com/documentation/den0054/latest
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  arch/arm64/include/asm/kvm_host.h |   1 +
>  arch/arm64/include/asm/kvm_sdei.h | 148 ++++++++++++++++++++++++++++++
>  arch/arm64/kvm/Makefile           |   2 +-
>  arch/arm64/kvm/arm.c              |   4 +
>  arch/arm64/kvm/hypercalls.c       |   3 +
>  arch/arm64/kvm/sdei.c             |  98 ++++++++++++++++++++
>  include/uapi/linux/arm_sdei.h     |   4 +
>  7 files changed, 259 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/include/asm/kvm_sdei.h
>  create mode 100644 arch/arm64/kvm/sdei.c
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index e3b25dc6c367..7644a400c4a8 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -343,6 +343,7 @@ struct kvm_vcpu_arch {
>  	 * Anything that is not used directly from assembly code goes
>  	 * here.
>  	 */
> +	struct kvm_sdei_vcpu *sdei;
>  
>  	/*
>  	 * Guest registers we preserve during guest debugging.
> diff --git a/arch/arm64/include/asm/kvm_sdei.h b/arch/arm64/include/asm/kvm_sdei.h
> new file mode 100644
> index 000000000000..2dbfb3ae0a48
> --- /dev/null
> +++ b/arch/arm64/include/asm/kvm_sdei.h
> @@ -0,0 +1,148 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Definitions of various KVM SDEI events.
> + *
> + * Copyright (C) 2022 Red Hat, Inc.
> + *
> + * Author(s): Gavin Shan <gshan@redhat.com>
> + */
> +
> +#ifndef __ARM64_KVM_SDEI_H__
> +#define __ARM64_KVM_SDEI_H__
> +
> +#include <uapi/linux/arm_sdei.h>
> +#include <linux/arm-smccc.h>
> +#include <linux/bits.h>
> +#include <linux/spinlock.h>
> +
> +/*
> + * The event which are defined and exposed by KVM. The event can't
> + * be registered until it's exposed. Besides, all the information
> + * in this event can't be changed after it's exposed.
> + */

kernel doc style comments are highly preferable when describing a
complex struct. Figuring out what each of the fields mean is not
obvious.

> +struct kvm_sdei_exposed_event {
> +	unsigned int	num;
> +	unsigned char	type;
> +	unsigned char	signaled;

what is this used for?

> +	unsigned char	priority;
> +};

I don't think we have a need for this struct. ::type will always be set
to PRIVATE and ::priority will always be NORMAL.

> +/*
> + * Currently, only the private events are supported. The events are
> + * created based on the exposed events and their states are changed
> + * when hypercalls are received or they are delivered to guest for
> + * handling.
> + */
> +struct kvm_sdei_event {
> +	struct kvm_sdei_exposed_event	*exposed_event;

I'm not following what is meant by an exposed event. By default the
KVM will expose all of the events to its guests.

> +	unsigned char			route_mode;
> +	unsigned long			route_affinity;

If we only have private events, do we need to worry about routing?

> +	unsigned long			ep_address;
> +	unsigned long			ep_arg;
> +#define KVM_SDEI_EVENT_STATE_REGISTERED		BIT(0)
> +#define KVM_SDEI_EVENT_STATE_ENABLED		BIT(1)
> +#define KVM_SDEI_EVENT_STATE_UNREGISTER_PENDING	BIT(2)
> +	unsigned long			state;

Isn't this state actually local to a PE (not VM) for private events?

> +	unsigned long			event_count;
> +};
> +
> +/*
> + * The vcpu context helps to handle events. The preempted or interrupted
> + * context is saved before the event handler is executed, and restored
> + * after the event handler is to finish. The event with normal priority
> + * can be preempted by the one with critical priority. So there can be
> + * two contexts on one particular vcpu for the events with normal and
> + * critical priority separately.
> + */
> +struct kvm_sdei_vcpu_context {
> +	struct kvm_sdei_event	*event;

Do we need this if we disallow nesting events?

> +	unsigned long		regs[18];
> +	unsigned long		pc;
> +	unsigned long		pstate;
> +};
> +
> +struct kvm_sdei_vcpu {
> +	spinlock_t			lock;

Why do we need a lock? This state should only ever be messed with in the
context of a single vCPU to which we already have exclusive access.

> +	struct kvm_sdei_event		*events;
> +	unsigned char			masked;
> +	unsigned long			critical_event_count;
> +	unsigned long			normal_event_count;
> +	struct kvm_sdei_vcpu_context	context[SDEI_EVENT_PRIORITY_CRITICAL + 1];
> +};
> +
> +/*
> + * According to SDEI specification (v1.1), the event number spans 32-bits
> + * and the lower 24-bits are used as the (real) event number. I don't
> + * think we can use that much event numbers in one system. So we reserve
> + * two bits from the 24-bits real event number, to indicate its types:
> + * physical or virtual event. One reserved bit is enough for now, but
> + * two bits are reserved for possible extension in future.
> + *
> + * The physical events are owned by firmware while the virtual events
> + * are used by VMM and KVM.

Doesn't KVM own everything? I don't see how the guest could interact
with another SDEI implementation.

> + */
> +#define KVM_SDEI_EVENT_NUM_TYPE_SHIFT	22
> +#define KVM_SDEI_EVENT_NUM_TYPE_MASK	(3 << KVM_SDEI_EVENT_NUM_TYPE_SHIFT)
> +#define KVM_SDEI_EVENT_NUM_TYPE_PHYS	0
> +#define KVM_SDEI_EVENT_NUM_TYPE_VIRT	1
> +
> +static inline bool kvm_sdei_is_virtual(unsigned int num)
> +{
> +	unsigned int type;
> +
> +	type = (num & KVM_SDEI_EVENT_NUM_TYPE_MASK) >>
> +	       KVM_SDEI_EVENT_NUM_TYPE_SHIFT;
> +	if (type == KVM_SDEI_EVENT_NUM_TYPE_VIRT)
> +		return true;
> +
> +	return false;
> +}
> +
> +static inline bool kvm_sdei_is_sw_signaled(unsigned int num)
> +{
> +	return num == SDEI_SW_SIGNALED_EVENT;
> +}

Couldn't the caller just check the event number on their own?

> +static inline bool kvm_sdei_is_supported(unsigned int num)
> +{
> +	return kvm_sdei_is_sw_signaled(num) ||
> +	       kvm_sdei_is_virtual(num);
> +}

Is there ever going to be a situation where KVM has defined a new event
but doesn't actually support it?

> +static inline bool kvm_sdei_is_critical(unsigned char priority)
> +{
> +	return priority == SDEI_EVENT_PRIORITY_CRITICAL;
> +}
> +
> +static inline bool kvm_sdei_is_normal(unsigned char priority)
> +{
> +	return priority == SDEI_EVENT_PRIORITY_NORMAL;
> +}
> +
> +#define KVM_SDEI_REGISTERED_EVENT_FUNC(func, field)			\
> +static inline bool kvm_sdei_is_##func(struct kvm_sdei_event *event)	\
> +{									\
> +	return !!(event->state & KVM_SDEI_EVENT_STATE_##field);		\
> +}									\
> +									\
> +static inline void kvm_sdei_set_##func(struct kvm_sdei_event *event)	\
> +{									\
> +	event->state |= KVM_SDEI_EVENT_STATE_##field;			\
> +}									\
> +									\
> +static inline void kvm_sdei_clear_##func(struct kvm_sdei_event *event)	\
> +{									\
> +	event->state &= ~KVM_SDEI_EVENT_STATE_##field;			\
> +}
> +
> +KVM_SDEI_REGISTERED_EVENT_FUNC(registered, REGISTERED)
> +KVM_SDEI_REGISTERED_EVENT_FUNC(enabled, ENABLED)
> +KVM_SDEI_REGISTERED_EVENT_FUNC(unregister_pending, UNREGISTER_PENDING)

Are there any particular concerns about open coding the bitwise
operations that are getting wrapped here? test_bit()/set_bit() is also a
helpful construct.

> +/* APIs */
> +int kvm_sdei_call(struct kvm_vcpu *vcpu);
> +void kvm_sdei_create_vcpu(struct kvm_vcpu *vcpu);
> +void kvm_sdei_destroy_vcpu(struct kvm_vcpu *vcpu);
> +
> +#endif /* __ARM64_KVM_SDEI_H__ */
> diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
> index 261644b1a6bb..d6ced92ae3f0 100644
> --- a/arch/arm64/kvm/Makefile
> +++ b/arch/arm64/kvm/Makefile
> @@ -14,7 +14,7 @@ kvm-y += arm.o mmu.o mmio.o psci.o hypercalls.o pvtime.o \
>  	 inject_fault.o va_layout.o handle_exit.o \
>  	 guest.o debug.o reset.o sys_regs.o \
>  	 vgic-sys-reg-v3.o fpsimd.o pmu.o pkvm.o \
> -	 arch_timer.o trng.o vmid.o \
> +	 arch_timer.o trng.o vmid.o sdei.o \
>  	 vgic/vgic.o vgic/vgic-init.o \
>  	 vgic/vgic-irqfd.o vgic/vgic-v2.o \
>  	 vgic/vgic-v3.o vgic/vgic-v4.o \
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 523bc934fe2f..227c0e390571 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -38,6 +38,7 @@
>  #include <asm/kvm_asm.h>
>  #include <asm/kvm_mmu.h>
>  #include <asm/kvm_emulate.h>
> +#include <asm/kvm_sdei.h>
>  #include <asm/sections.h>
>  
>  #include <kvm/arm_hypercalls.h>
> @@ -331,6 +332,8 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
>  
>  	kvm_arm_pvtime_vcpu_init(&vcpu->arch);
>  
> +	kvm_sdei_create_vcpu(vcpu);
> +
>  	vcpu->arch.hw_mmu = &vcpu->kvm->arch.mmu;
>  
>  	err = kvm_vgic_vcpu_init(vcpu);
> @@ -352,6 +355,7 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
>  	kvm_mmu_free_memory_cache(&vcpu->arch.mmu_page_cache);
>  	kvm_timer_vcpu_terminate(vcpu);
>  	kvm_pmu_vcpu_destroy(vcpu);
> +	kvm_sdei_destroy_vcpu(vcpu);
>  
>  	kvm_arm_vcpu_destroy(vcpu);
>  }
> diff --git a/arch/arm64/kvm/hypercalls.c b/arch/arm64/kvm/hypercalls.c
> index b659387d8919..6aa027a4cee8 100644
> --- a/arch/arm64/kvm/hypercalls.c
> +++ b/arch/arm64/kvm/hypercalls.c
> @@ -5,6 +5,7 @@
>  #include <linux/kvm_host.h>
>  
>  #include <asm/kvm_emulate.h>
> +#include <asm/kvm_sdei.h>
>  
>  #include <kvm/arm_hypercalls.h>
>  #include <kvm/arm_psci.h>
> @@ -93,6 +94,8 @@ static int kvm_hvc_standard(struct kvm_vcpu *vcpu, u32 func)
>  	case PSCI_1_1_FN_SYSTEM_RESET2:
>  	case PSCI_1_1_FN64_SYSTEM_RESET2:
>  		return kvm_psci_call(vcpu);
> +	case SDEI_1_0_FN_SDEI_VERSION ... SDEI_1_1_FN_SDEI_FEATURES:
> +		return kvm_sdei_call(vcpu);

I mentioned in another thread, but reraising here on the new diff.
Prefer using the defined function [start, end] range in this switch
statement.

Overall, I think this still puts a lot of abstraction around the concept
of SDEI events, even though we have a very narrow use case for it in KVM
for now. Removing all of the plumbing for critical and shared events
should help collapse this quite a bit.

--
Thanks,
Oliver
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
