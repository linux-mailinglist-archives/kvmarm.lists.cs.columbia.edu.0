Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 45F3BBF4B1
	for <lists+kvmarm@lfdr.de>; Thu, 26 Sep 2019 16:09:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B94044A75D;
	Thu, 26 Sep 2019 10:09:21 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yGjxJJl8nVJT; Thu, 26 Sep 2019 10:09:21 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AF2794A74A;
	Thu, 26 Sep 2019 10:09:19 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 38A684A707
 for <kvmarm@lists.cs.columbia.edu>; Thu, 26 Sep 2019 10:09:19 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WyI-Gj2M8r31 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 26 Sep 2019 10:09:15 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E50EF4A6F2
 for <kvmarm@lists.cs.columbia.edu>; Thu, 26 Sep 2019 10:09:14 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5ED031570;
 Thu, 26 Sep 2019 07:09:14 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 BF2293F534; Thu, 26 Sep 2019 07:09:12 -0700 (PDT)
Subject: Re: [PATCH 2/2] KVM: arm/arm64: Allow user injection of external data
 aborts
To: Christoffer Dall <christoffer.dall@arm.com>, kvmarm@lists.cs.columbia.edu
References: <20190909121337.27287-1-christoffer.dall@arm.com>
 <20190909121337.27287-3-christoffer.dall@arm.com>
From: Marc Zyngier <maz@kernel.org>
Organization: Approximate
Message-ID: <35eae9fa-b9f7-e5ca-b95f-d1d14216d6ee@kernel.org>
Date: Thu, 26 Sep 2019 15:09:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190909121337.27287-3-christoffer.dall@arm.com>
Content-Language: en-US
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Stefan Hajnoczi <stefanha@redhat.com>, linux-arm-kernel@lists.infradead.org
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

On 09/09/2019 13:13, Christoffer Dall wrote:
> In some scenarios, such as buggy guest or incorrect configuration of the
> VMM and firmware description data, userspace will detect a memory access
> to a portion of the IPA, which is not mapped to any MMIO region.
> 
> For this purpose, the appropriate action is to inject an external abort
> to the guest.  The kernel already has functionality to inject an
> external abort, but we need to wire up a signal from user space that
> lets user space tell the kernel to do this.
> 
> It turns out, we already have the set event functionality which we can
> perfectly reuse for this.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
> ---
>  Documentation/virt/kvm/api.txt    | 15 ++++++++++++++-
>  arch/arm/include/uapi/asm/kvm.h   |  3 ++-
>  arch/arm/kvm/guest.c              |  3 +++
>  arch/arm64/include/uapi/asm/kvm.h |  3 ++-
>  arch/arm64/kvm/guest.c            |  3 +++
>  arch/arm64/kvm/inject_fault.c     |  4 ++--
>  include/uapi/linux/kvm.h          |  1 +
>  virt/kvm/arm/arm.c                |  1 +
>  8 files changed, 28 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/virt/kvm/api.txt b/Documentation/virt/kvm/api.txt
> index 02501333f746..edd6cdc470ca 100644
> --- a/Documentation/virt/kvm/api.txt
> +++ b/Documentation/virt/kvm/api.txt
> @@ -955,6 +955,8 @@ The following bits are defined in the flags field:
>  
>  ARM/ARM64:
>  
> +User space may need to inject several types of events to the guest.
> +
>  If the guest accesses a device that is being emulated by the host kernel in
>  such a way that a real device would generate a physical SError, KVM may make
>  a virtual SError pending for that VCPU. This system error interrupt remains
> @@ -989,12 +991,23 @@ Specifying exception.has_esr on a system that does not support it will return
>  -EINVAL. Setting anything other than the lower 24bits of exception.serror_esr
>  will return -EINVAL.
>  
> +If the guest performed an access to I/O memory which could not be handled by
> +user space, for example because of missing instruction syndrome decode
> +information or because there is no device mapped at the accessed IPA, then
> +user space can ask the kernel to inject an external abort using the address
> +from the exiting fault on the VCPU. It is a programming error to set
> +ext_dabt_pending at the same time as any of the serror fields, or to set
> +ext_dabt_pending on an exit which was not either KVM_EXIT_MMIO or

... on *re-entry from* an exit?

> +KVM_EXIT_ARM_NISV. This feature is only available if the system supports
> +KVM_CAP_ARM_INJECT_EXT_DABT;

s/;/./

Can we add some wording to the fact that this is only a helper for the
most common case? Most of the ARM exceptions can otherwise be
constructed/injected using the SET_ONE_REG API.

> +
>  struct kvm_vcpu_events {
>  	struct {
>  		__u8 serror_pending;
>  		__u8 serror_has_esr;
> +		__u8 ext_dabt_pending;
>  		/* Align it to 8 bytes */
> -		__u8 pad[6];
> +		__u8 pad[5];
>  		__u64 serror_esr;
>  	} exception;
>  	__u32 reserved[12];
> diff --git a/arch/arm/include/uapi/asm/kvm.h b/arch/arm/include/uapi/asm/kvm.h
> index a4217c1a5d01..d2449a5bf8d5 100644
> --- a/arch/arm/include/uapi/asm/kvm.h
> +++ b/arch/arm/include/uapi/asm/kvm.h
> @@ -131,8 +131,9 @@ struct kvm_vcpu_events {
>  	struct {
>  		__u8 serror_pending;
>  		__u8 serror_has_esr;
> +		__u8 ext_dabt_pending;
>  		/* Align it to 8 bytes */
> -		__u8 pad[6];
> +		__u8 pad[5];
>  		__u64 serror_esr;
>  	} exception;
>  	__u32 reserved[12];
> diff --git a/arch/arm/kvm/guest.c b/arch/arm/kvm/guest.c
> index 684cf64b4033..4154c5589501 100644
> --- a/arch/arm/kvm/guest.c
> +++ b/arch/arm/kvm/guest.c
> @@ -263,11 +263,14 @@ int __kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
>  {
>  	bool serror_pending = events->exception.serror_pending;
>  	bool has_esr = events->exception.serror_has_esr;
> +	bool has_ext_dabt_pending = events->exception.ext_dabt_pending;
>  
>  	if (serror_pending && has_esr)
>  		return -EINVAL;
>  	else if (serror_pending)
>  		kvm_inject_vabt(vcpu);
> +	else if (has_ext_dabt_pending)
> +		kvm_inject_dabt(vcpu, kvm_vcpu_get_hfar(vcpu));
>  
>  	return 0;
>  }
> diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
> index 9a507716ae2f..7729efdb1c0c 100644
> --- a/arch/arm64/include/uapi/asm/kvm.h
> +++ b/arch/arm64/include/uapi/asm/kvm.h
> @@ -164,8 +164,9 @@ struct kvm_vcpu_events {
>  	struct {
>  		__u8 serror_pending;
>  		__u8 serror_has_esr;
> +		__u8 ext_dabt_pending;
>  		/* Align it to 8 bytes */
> -		__u8 pad[6];
> +		__u8 pad[5];
>  		__u64 serror_esr;
>  	} exception;
>  	__u32 reserved[12];
> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> index dfd626447482..10e6e2144dca 100644
> --- a/arch/arm64/kvm/guest.c
> +++ b/arch/arm64/kvm/guest.c
> @@ -720,6 +720,7 @@ int __kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
>  {
>  	bool serror_pending = events->exception.serror_pending;
>  	bool has_esr = events->exception.serror_has_esr;
> +	bool has_ext_dabt_pending = events->exception.ext_dabt_pending;
>  
>  	if (serror_pending && has_esr) {
>  		if (!cpus_have_const_cap(ARM64_HAS_RAS_EXTN))
> @@ -731,6 +732,8 @@ int __kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
>  			return -EINVAL;
>  	} else if (serror_pending) {
>  		kvm_inject_vabt(vcpu);
> +	} else if (has_ext_dabt_pending) {
> +		kvm_inject_dabt(vcpu, kvm_vcpu_get_hfar(vcpu));
>  	}
>  
>  	return 0;
> diff --git a/arch/arm64/kvm/inject_fault.c b/arch/arm64/kvm/inject_fault.c
> index a9d25a305af5..ccdb6a051ab2 100644
> --- a/arch/arm64/kvm/inject_fault.c
> +++ b/arch/arm64/kvm/inject_fault.c
> @@ -109,7 +109,7 @@ static void inject_undef64(struct kvm_vcpu *vcpu)
>  
>  /**
>   * kvm_inject_dabt - inject a data abort into the guest
> - * @vcpu: The VCPU to receive the undefined exception
> + * @vcpu: The VCPU to receive the data abort
>   * @addr: The address to report in the DFAR
>   *
>   * It is assumed that this code is called from the VCPU thread and that the
> @@ -125,7 +125,7 @@ void kvm_inject_dabt(struct kvm_vcpu *vcpu, unsigned long addr)
>  
>  /**
>   * kvm_inject_pabt - inject a prefetch abort into the guest
> - * @vcpu: The VCPU to receive the undefined exception
> + * @vcpu: The VCPU to receive the prefetch abort
>   * @addr: The address to report in the DFAR
>   *
>   * It is assumed that this code is called from the VCPU thread and that the
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index dd79235b6435..a80ee820e700 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1003,6 +1003,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_ARM_PTRAUTH_GENERIC 172
>  #define KVM_CAP_PMU_EVENT_FILTER 173
>  #define KVM_CAP_ARM_NISV_TO_USER 174
> +#define KVM_CAP_ARM_INJECT_EXT_DABT 175
>  
>  #ifdef KVM_CAP_IRQ_ROUTING
>  
> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
> index 7153504bb106..56a97dd9b292 100644
> --- a/virt/kvm/arm/arm.c
> +++ b/virt/kvm/arm/arm.c
> @@ -217,6 +217,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  	case KVM_CAP_IMMEDIATE_EXIT:
>  	case KVM_CAP_VCPU_EVENTS:
>  	case KVM_CAP_ARM_NISV_TO_USER:
> +	case KVM_CAP_ARM_INJECT_EXT_DABT:
>  		r = 1;
>  		break;
>  	case KVM_CAP_ARM_SET_DEVICE_ADDR:
> 

Otherwise looks good to me. If you respin the series, and unless anyone
shouts, I'll queue it. No hurry though, I'm going to take slow(er) the
following two weeks.

Thanks,

	M.
-- 
Jazz is not dead, it just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
