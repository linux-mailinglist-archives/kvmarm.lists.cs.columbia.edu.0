Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6304BA4AE
	for <lists+kvmarm@lfdr.de>; Thu, 17 Feb 2022 16:43:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 67ED649F1D;
	Thu, 17 Feb 2022 10:43:03 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.8
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, URIBL_BLOCKED=0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8jVzvZWaEjxZ; Thu, 17 Feb 2022 10:43:03 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DB6C849F13;
	Thu, 17 Feb 2022 10:43:01 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A09A949F13
 for <kvmarm@lists.cs.columbia.edu>; Thu, 17 Feb 2022 10:43:00 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n8o7rIVXjd0o for <kvmarm@lists.cs.columbia.edu>;
 Thu, 17 Feb 2022 10:42:58 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C5BD141071
 for <kvmarm@lists.cs.columbia.edu>; Thu, 17 Feb 2022 10:42:58 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AC8212FC;
 Thu, 17 Feb 2022 07:42:58 -0800 (PST)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E6823F70D;
 Thu, 17 Feb 2022 07:42:56 -0800 (PST)
Date: Thu, 17 Feb 2022 15:43:15 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Sebastian Ene <sebastianene@google.com>
Subject: Re: [PATCH kvmtool v2] aarch64: Add stolen time support
Message-ID: <Yg5tE3TqgwWRFypB@monolith.localdoman>
References: <Yg5lBZKsSoPNmVkT@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yg5lBZKsSoPNmVkT@google.com>
Cc: kvm@vger.kernel.org, maz@kernel.org, will@kernel.org,
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

Hi,

Some general comments while I familiarize myself with the stolen time spec.

On Thu, Feb 17, 2022 at 03:08:53PM +0000, Sebastian Ene wrote:
> This patch adds support for stolen time by sharing a memory region
> with the guest which will be used by the hypervisor to store the stolen
> time information. The exact format of the structure stored by the
> hypervisor is described in the ARM DEN0057A document.
> 
> Signed-off-by: Sebastian Ene <sebastianene@google.com>
> ---

It is customary to describe the changes you have made from the previous version,
to make it easier for the people who want to review your code.

>  Makefile                               |  1 +
>  arm/aarch64/arm-cpu.c                  |  1 +
>  arm/aarch64/include/kvm/kvm-cpu-arch.h |  1 +
>  arm/aarch64/pvtime.c                   | 84 ++++++++++++++++++++++++++
>  arm/include/arm-common/kvm-arch.h      |  4 ++
>  arm/kvm-cpu.c                          | 14 ++---
>  6 files changed, 98 insertions(+), 7 deletions(-)
>  create mode 100644 arm/aarch64/pvtime.c
> 
> diff --git a/Makefile b/Makefile
> index f251147..e9121dc 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -182,6 +182,7 @@ ifeq ($(ARCH), arm64)
>  	OBJS		+= arm/aarch64/arm-cpu.o
>  	OBJS		+= arm/aarch64/kvm-cpu.o
>  	OBJS		+= arm/aarch64/kvm.o
> +	OBJS		+= arm/aarch64/pvtime.o
>  	ARCH_INCLUDE	:= $(HDRS_ARM_COMMON)
>  	ARCH_INCLUDE	+= -Iarm/aarch64/include
>  
> diff --git a/arm/aarch64/arm-cpu.c b/arm/aarch64/arm-cpu.c
> index d7572b7..326fb20 100644
> --- a/arm/aarch64/arm-cpu.c
> +++ b/arm/aarch64/arm-cpu.c
> @@ -22,6 +22,7 @@ static void generate_fdt_nodes(void *fdt, struct kvm *kvm)
>  static int arm_cpu__vcpu_init(struct kvm_cpu *vcpu)
>  {
>  	vcpu->generate_fdt_nodes = generate_fdt_nodes;
> +	kvm_cpu__setup_pvtime(vcpu);
>  	return 0;
>  }
>  
> diff --git a/arm/aarch64/include/kvm/kvm-cpu-arch.h b/arm/aarch64/include/kvm/kvm-cpu-arch.h
> index 8dfb82e..b57d6e6 100644
> --- a/arm/aarch64/include/kvm/kvm-cpu-arch.h
> +++ b/arm/aarch64/include/kvm/kvm-cpu-arch.h
> @@ -19,5 +19,6 @@
>  
>  void kvm_cpu__select_features(struct kvm *kvm, struct kvm_vcpu_init *init);
>  int kvm_cpu__configure_features(struct kvm_cpu *vcpu);
> +void kvm_cpu__setup_pvtime(struct kvm_cpu *vcpu);
>  
>  #endif /* KVM__KVM_CPU_ARCH_H */
> diff --git a/arm/aarch64/pvtime.c b/arm/aarch64/pvtime.c
> new file mode 100644
> index 0000000..c09fd89
> --- /dev/null
> +++ b/arm/aarch64/pvtime.c
> @@ -0,0 +1,84 @@
> +#include "kvm/kvm.h"
> +#include "kvm/kvm-cpu.h"
> +#include "kvm/util.h"
> +
> +#include <linux/byteorder.h>
> +#include <linux/types.h>
> +
> +struct pvtime_data_priv {
> +	bool	is_supported;
> +	char	*usr_mem;
> +};
> +
> +static struct pvtime_data_priv pvtime_data = {
> +	.is_supported	= true,
> +	.usr_mem	= NULL
> +};
> +
> +static int pvtime__alloc_region(struct kvm *kvm)
> +{
> +	char *mem;
> +	int ret = 0;
> +
> +	mem = mmap(NULL, AARCH64_PVTIME_IPA_MAX_SIZE, PROT_RW,
> +		   MAP_ANON_NORESERVE, -1, 0);
> +	if (mem == MAP_FAILED)
> +		return -ENOMEM;
> +
> +	ret = kvm__register_dev_mem(kvm, AARCH64_PVTIME_IPA_START,
> +				    AARCH64_PVTIME_IPA_MAX_SIZE, mem);
> +	if (ret) {
> +		munmap(mem, AARCH64_PVTIME_IPA_MAX_SIZE);
> +		return ret;
> +	}
> +
> +	pvtime_data.usr_mem = mem;
> +	return ret;
> +}
> +
> +static int pvtime__teardown_region(struct kvm *kvm)
> +{
> +	if (pvtime_data.usr_mem == NULL)
> +		return 0;
> +
> +	kvm__destroy_mem(kvm, AARCH64_PVTIME_IPA_START,
> +			 AARCH64_PVTIME_IPA_MAX_SIZE, pvtime_data.usr_mem);
> +	munmap(pvtime_data.usr_mem, AARCH64_PVTIME_IPA_MAX_SIZE);
> +	pvtime_data.usr_mem = NULL;
> +	return 0;
> +}
> +
> +void kvm_cpu__setup_pvtime(struct kvm_cpu *vcpu)
> +{
> +	int ret;
> +	u64 pvtime_guest_addr = AARCH64_PVTIME_IPA_START + vcpu->cpu_id *
> +		AARCH64_PVTIME_SIZE;
> +	struct kvm_device_attr pvtime_attr = (struct kvm_device_attr) {
> +		.group	= KVM_ARM_VCPU_PVTIME_CTRL,
> +		.addr	= KVM_ARM_VCPU_PVTIME_IPA
> +	};
> +
> +	if (!pvtime_data.is_supported)
> +		return;
> +
> +	ret = ioctl(vcpu->vcpu_fd, KVM_HAS_DEVICE_ATTR, &pvtime_attr);
> +	if (ret)
> +		goto out_err;
> +
> +	if (!pvtime_data.usr_mem) {
> +		ret = pvtime__alloc_region(vcpu->kvm);
> +		if (ret)
> +			goto out_err;
> +	}
> +
> +	pvtime_attr.addr = (u64)&pvtime_guest_addr;
> +	ret = ioctl(vcpu->vcpu_fd, KVM_SET_DEVICE_ATTR, &pvtime_attr);
> +	if (!ret)
> +		return;
> +
> +	pvtime__teardown_region(vcpu->kvm);
> +out_err:
> +	pvtime_data.is_supported = false;
> +}
> +
> +dev_exit(pvtime__teardown_region);
> diff --git a/arm/include/arm-common/kvm-arch.h b/arm/include/arm-common/kvm-arch.h
> index c645ac0..865bd68 100644
> --- a/arm/include/arm-common/kvm-arch.h
> +++ b/arm/include/arm-common/kvm-arch.h
> @@ -54,6 +54,10 @@
>  #define ARM_PCI_MMIO_SIZE	(ARM_MEMORY_AREA - \
>  				(ARM_AXI_AREA + ARM_PCI_CFG_SIZE))
>  
> +#define AARCH64_PVTIME_IPA_MAX_SIZE	SZ_64K
> +#define AARCH64_PVTIME_IPA_START	(ARM_MEMORY_AREA - \
> +					 AARCH64_PVTIME_IPA_MAX_SIZE)

This overlaps with the ARM_PCI_MMIO_AREA. If you want to change the memory
layout for a guest, there's a handy ASCII map at the top of this file.  That
should also be updated to reflect the modified layout.

Why do you want to put it below RAM? Is there a requirement to have it there or
was the location chosen for other reasons?

> +#define AARCH64_PVTIME_SIZE		(64)

This looks like something that should go in pvtime.c, as it's not relevant to
the memory layout.

>  
>  #define ARM_LOMAP_MAX_MEMORY	((1ULL << 32) - ARM_MEMORY_AREA)
>  #define ARM_HIMAP_MAX_MEMORY	((1ULL << 40) - ARM_MEMORY_AREA)
> diff --git a/arm/kvm-cpu.c b/arm/kvm-cpu.c
> index 6a2408c..84ac1e9 100644
> --- a/arm/kvm-cpu.c
> +++ b/arm/kvm-cpu.c
> @@ -116,6 +116,13 @@ struct kvm_cpu *kvm_cpu__arch_init(struct kvm *kvm, unsigned long cpu_id)
>  			die("Unable to find matching target");
>  	}
>  
> +	/* Populate the vcpu structure. */
> +	vcpu->kvm		= kvm;
> +	vcpu->cpu_id		= cpu_id;
> +	vcpu->cpu_type		= vcpu_init.target;
> +	vcpu->cpu_compatible	= target->compatible;
> +	vcpu->is_running	= true;
> +
>  	if (err || target->init(vcpu))
>  		die("Unable to initialise vcpu");
>  
> @@ -125,13 +132,6 @@ struct kvm_cpu *kvm_cpu__arch_init(struct kvm *kvm, unsigned long cpu_id)
>  		vcpu->ring = (void *)vcpu->kvm_run +
>  			     (coalesced_offset * PAGE_SIZE);
>  
> -	/* Populate the vcpu structure. */
> -	vcpu->kvm		= kvm;
> -	vcpu->cpu_id		= cpu_id;
> -	vcpu->cpu_type		= vcpu_init.target;
> -	vcpu->cpu_compatible	= target->compatible;
> -	vcpu->is_running	= true;
> -

Why this change?

Thanks,
Alex

>  	if (kvm_cpu__configure_features(vcpu))
>  		die("Unable to configure requested vcpu features");
>  
> -- 
> 2.35.1.265.g69c8d7142f-goog
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
