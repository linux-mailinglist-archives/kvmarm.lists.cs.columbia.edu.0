Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C6669DD87C
	for <lists+kvmarm@lfdr.de>; Sat, 19 Oct 2019 13:28:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3E82D4AA3D;
	Sat, 19 Oct 2019 07:28:26 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mbrzcy6aPTYX; Sat, 19 Oct 2019 07:28:26 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E13B34AA59;
	Sat, 19 Oct 2019 07:28:24 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2A8F44AA38
 for <kvmarm@lists.cs.columbia.edu>; Sat, 19 Oct 2019 07:28:24 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V1cXgeEI4bK9 for <kvmarm@lists.cs.columbia.edu>;
 Sat, 19 Oct 2019 07:28:22 -0400 (EDT)
Received: from inca-roads.misterjones.org (inca-roads.misterjones.org
 [213.251.177.50])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id CA34D4A99D
 for <kvmarm@lists.cs.columbia.edu>; Sat, 19 Oct 2019 07:28:22 -0400 (EDT)
Received: from [185.104.136.17] (helo=big-swifty.misterjones.org)
 by cheepnis.misterjones.org with esmtpsa (TLSv1.2:AES256-GCM-SHA384:256)
 (Exim 4.80) (envelope-from <maz@kernel.org>)
 id 1iLmuB-00071Z-9o; Sat, 19 Oct 2019 13:28:19 +0200
Date: Sat, 19 Oct 2019 12:28:12 +0100
Message-ID: <86d0etynxv.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v6 07/10] KVM: arm64: Provide VCPU attributes for stolen
 time
In-Reply-To: <20191011125930.40834-8-steven.price@arm.com>
References: <20191011125930.40834-1-steven.price@arm.com>
 <20191011125930.40834-8-steven.price@arm.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL/10.8 EasyPG/1.0.0 Emacs/26
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 185.104.136.17
X-SA-Exim-Rcpt-To: steven.price@arm.com, will@kernel.org,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 catalin.marinas@arm.com, pbonzini@redhat.com, rkrcmar@redhat.com,
 linux@armlinux.org.uk, james.morse@arm.com, julien.thierry.kdev@gmail.com,
 suzuki.poulose@arm.com, mark.rutland@arm.com, kvm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 linux-doc@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
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

On Fri, 11 Oct 2019 13:59:27 +0100,
Steven Price <steven.price@arm.com> wrote:
> 
> Allow user space to inform the KVM host where in the physical memory
> map the paravirtualized time structures should be located.
> 
> User space can set an attribute on the VCPU providing the IPA base
> address of the stolen time structure for that VCPU. This must be
> repeated for every VCPU in the VM.
> 
> The address is given in terms of the physical address visible to
> the guest and must be 64 byte aligned. The guest will discover the
> address via a hypercall.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  arch/arm64/include/asm/kvm_host.h |  7 +++++
>  arch/arm64/include/uapi/asm/kvm.h |  2 ++
>  arch/arm64/kvm/guest.c            |  9 ++++++
>  include/uapi/linux/kvm.h          |  2 ++
>  virt/kvm/arm/pvtime.c             | 47 +++++++++++++++++++++++++++++++
>  5 files changed, 67 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 1697e63f6dd8..6af16b29a41f 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -489,6 +489,13 @@ long kvm_hypercall_pv_features(struct kvm_vcpu *vcpu);
>  long kvm_hypercall_stolen_time(struct kvm_vcpu *vcpu);
>  int kvm_update_stolen_time(struct kvm_vcpu *vcpu, bool init);
>  
> +int kvm_arm_pvtime_set_attr(struct kvm_vcpu *vcpu,
> +			    struct kvm_device_attr *attr);
> +int kvm_arm_pvtime_get_attr(struct kvm_vcpu *vcpu,
> +			    struct kvm_device_attr *attr);
> +int kvm_arm_pvtime_has_attr(struct kvm_vcpu *vcpu,
> +			    struct kvm_device_attr *attr);
> +
>  static inline void kvm_arm_pvtime_vcpu_init(struct kvm_vcpu_arch *vcpu_arch)
>  {
>  	vcpu_arch->steal.base = GPA_INVALID;
> diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
> index 67c21f9bdbad..cff1ba12c768 100644
> --- a/arch/arm64/include/uapi/asm/kvm.h
> +++ b/arch/arm64/include/uapi/asm/kvm.h
> @@ -323,6 +323,8 @@ struct kvm_vcpu_events {
>  #define KVM_ARM_VCPU_TIMER_CTRL		1
>  #define   KVM_ARM_VCPU_TIMER_IRQ_VTIMER		0
>  #define   KVM_ARM_VCPU_TIMER_IRQ_PTIMER		1
> +#define KVM_ARM_VCPU_PVTIME_CTRL	2
> +#define   KVM_ARM_VCPU_PVTIME_IPA	0
>  
>  /* KVM_IRQ_LINE irq field index values */
>  #define KVM_ARM_IRQ_VCPU2_SHIFT		28
> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> index dfd626447482..d3ac9d2fd405 100644
> --- a/arch/arm64/kvm/guest.c
> +++ b/arch/arm64/kvm/guest.c
> @@ -858,6 +858,9 @@ int kvm_arm_vcpu_arch_set_attr(struct kvm_vcpu *vcpu,
>  	case KVM_ARM_VCPU_TIMER_CTRL:
>  		ret = kvm_arm_timer_set_attr(vcpu, attr);
>  		break;
> +	case KVM_ARM_VCPU_PVTIME_CTRL:
> +		ret = kvm_arm_pvtime_set_attr(vcpu, attr);
> +		break;
>  	default:
>  		ret = -ENXIO;
>  		break;
> @@ -878,6 +881,9 @@ int kvm_arm_vcpu_arch_get_attr(struct kvm_vcpu *vcpu,
>  	case KVM_ARM_VCPU_TIMER_CTRL:
>  		ret = kvm_arm_timer_get_attr(vcpu, attr);
>  		break;
> +	case KVM_ARM_VCPU_PVTIME_CTRL:
> +		ret = kvm_arm_pvtime_get_attr(vcpu, attr);
> +		break;
>  	default:
>  		ret = -ENXIO;
>  		break;
> @@ -898,6 +904,9 @@ int kvm_arm_vcpu_arch_has_attr(struct kvm_vcpu *vcpu,
>  	case KVM_ARM_VCPU_TIMER_CTRL:
>  		ret = kvm_arm_timer_has_attr(vcpu, attr);
>  		break;
> +	case KVM_ARM_VCPU_PVTIME_CTRL:
> +		ret = kvm_arm_pvtime_has_attr(vcpu, attr);
> +		break;
>  	default:
>  		ret = -ENXIO;
>  		break;
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 52641d8ca9e8..a540c8357049 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1227,6 +1227,8 @@ enum kvm_device_type {
>  #define KVM_DEV_TYPE_ARM_VGIC_ITS	KVM_DEV_TYPE_ARM_VGIC_ITS
>  	KVM_DEV_TYPE_XIVE,
>  #define KVM_DEV_TYPE_XIVE		KVM_DEV_TYPE_XIVE
> +	KVM_DEV_TYPE_ARM_PV_TIME,
> +#define KVM_DEV_TYPE_ARM_PV_TIME	KVM_DEV_TYPE_ARM_PV_TIME
>  	KVM_DEV_TYPE_MAX,
>  };
>  
> diff --git a/virt/kvm/arm/pvtime.c b/virt/kvm/arm/pvtime.c
> index a90f1b4ebd13..9dc466861e1e 100644
> --- a/virt/kvm/arm/pvtime.c
> +++ b/virt/kvm/arm/pvtime.c
> @@ -2,7 +2,9 @@
>  // Copyright (C) 2019 Arm Ltd.
>  
>  #include <linux/arm-smccc.h>
> +#include <linux/kvm_host.h>
>  
> +#include <asm/kvm_mmu.h>
>  #include <asm/pvclock-abi.h>
>  
>  #include <kvm/arm_hypercalls.h>
> @@ -75,3 +77,48 @@ long kvm_hypercall_stolen_time(struct kvm_vcpu *vcpu)
>  
>  	return vcpu->arch.steal.base;
>  }
> +
> +int kvm_arm_pvtime_set_attr(struct kvm_vcpu *vcpu,
> +			    struct kvm_device_attr *attr)
> +{
> +	u64 __user *user = (u64 __user *)attr->addr;
> +	u64 ipa;
> +
> +	if (attr->attr != KVM_ARM_VCPU_PVTIME_IPA)
> +		return -ENXIO;
> +
> +	if (get_user(ipa, user))
> +		return -EFAULT;
> +	if (!IS_ALIGNED(ipa, 64))
> +		return -EINVAL;
> +	if (vcpu->arch.steal.base != GPA_INVALID)
> +		return -EEXIST;
> +	vcpu->arch.steal.base = ipa;

And what if this IPA doesn't point to any memslot? I understand that
everything will still work (kvm_put_user()) will handle the mishap,
but it makes it hard for userspace to know that something is wrong.

Is there any problem in mandating that the corresponding memslot
already has been created, and enforcing this check?

Thanks,

	M.

-- 
Jazz is not dead, it just smells funny.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
