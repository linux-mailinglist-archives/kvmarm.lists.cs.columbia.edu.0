Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E73E64B8EB0
	for <lists+kvmarm@lfdr.de>; Wed, 16 Feb 2022 17:59:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 482FD49EE4;
	Wed, 16 Feb 2022 11:59:21 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V6W-NfU4VI9D; Wed, 16 Feb 2022 11:59:21 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BAF7649EEA;
	Wed, 16 Feb 2022 11:59:19 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 72D5049ED4
 for <kvmarm@lists.cs.columbia.edu>; Wed, 16 Feb 2022 11:59:18 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Zp6rAE5QhAGd for <kvmarm@lists.cs.columbia.edu>;
 Wed, 16 Feb 2022 11:59:17 -0500 (EST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 32BA649E1A
 for <kvmarm@lists.cs.columbia.edu>; Wed, 16 Feb 2022 11:59:17 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2B6BB61B98;
 Wed, 16 Feb 2022 16:59:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B56C004E1;
 Wed, 16 Feb 2022 16:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1645030753;
 bh=uVu4zdN8SO7+j0AXlkFCys1Fwhkdn9BpTEsbNFi295k=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=I5T6vatqtLYP2yJ05i/PEFFlqaSjw/6XP7ME7w1Sucj52yc0tzs7UaFi7wN7lZ46F
 wVHV1zCC4qk926wuHt2xeV3C+whVog5o2v37LmiKKbfHDGFGEz+CYNrYclTTGCropA
 z8bUt3ma6Cxat6PIofARKlYHlAtvasJfor70Uf/ZJnOAaE5S1Z11pPF8naBbVj+j5b
 TtcNetitW+uMdLSHTNLTcWOpXCSWE7furz8ZvwlPWuDW/4wBMLi+QwPq9IVnt22qZW
 T/7jWxkp46VeZa55CR1GquOjva3ot91QDLtTTB83kvd1IzMUHJt7AEzTLr0Jy5t1TN
 Blad18NSYTvxw==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1nKNe3-008Nk7-7K; Wed, 16 Feb 2022 16:59:11 +0000
MIME-Version: 1.0
Date: Wed, 16 Feb 2022 16:59:10 +0000
From: Marc Zyngier <maz@kernel.org>
To: Sebastian Ene <sebastianene@google.com>
Subject: Re: [PATCH kvmtool] aarch64: Add stolen time support
In-Reply-To: <Yg0jcO32I+zFz/0s@google.com>
References: <Yg0jcO32I+zFz/0s@google.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <6dcb9ce8090a34105be012965f3eadc4@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: sebastianene@google.com, kvm@vger.kernel.org,
 qperret@google.com, kvmarm@lists.cs.columbia.edu, will@kernel.org,
 julien.thierry.kdev@gmail.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: will@kernel.org, kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

Hi Sebastian,

Thanks for looking into this. A few comments below.

On 2022-02-16 16:16, Sebastian Ene wrote:
> This patch add support for stolen time by sharing a memory region
> with the guest which will be used by the hypervisor to store the stolen
> time information. The exact format of the structure stored by the
> hypervisor is described in the ARM DEN0057A document.
> 
> Signed-off-by: Sebastian Ene <sebastianene@google.com>
> ---
>  Makefile                          |  3 +-
>  arm/aarch64/arm-cpu.c             |  2 +
>  arm/aarch64/include/kvm/pvtime.h  |  6 +++
>  arm/aarch64/pvtime.c              | 83 +++++++++++++++++++++++++++++++
>  arm/include/arm-common/kvm-arch.h |  6 +++
>  arm/kvm-cpu.c                     | 14 +++---
>  6 files changed, 106 insertions(+), 8 deletions(-)
>  create mode 100644 arm/aarch64/include/kvm/pvtime.h
>  create mode 100644 arm/aarch64/pvtime.c
> 
> diff --git a/Makefile b/Makefile
> index f251147..282ae99 100644
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
> @@ -582,4 +583,4 @@ ifneq ($(MAKECMDGOALS),clean)
> 
>  KVMTOOLS-VERSION-FILE:
>  	@$(SHELL_PATH) util/KVMTOOLS-VERSION-GEN $(OUTPUT)
> -endif
> \ No newline at end of file
> +endif

Spurious change?

> diff --git a/arm/aarch64/arm-cpu.c b/arm/aarch64/arm-cpu.c
> index d7572b7..80bf83a 100644
> --- a/arm/aarch64/arm-cpu.c
> +++ b/arm/aarch64/arm-cpu.c
> @@ -2,6 +2,7 @@
>  #include "kvm/kvm.h"
>  #include "kvm/kvm-cpu.h"
>  #include "kvm/util.h"
> +#include "kvm/pvtime.h"
> 
>  #include "arm-common/gic.h"
>  #include "arm-common/timer.h"
> @@ -22,6 +23,7 @@ static void generate_fdt_nodes(void *fdt, struct kvm 
> *kvm)
>  static int arm_cpu__vcpu_init(struct kvm_cpu *vcpu)
>  {
>  	vcpu->generate_fdt_nodes = generate_fdt_nodes;
> +	pvtime__setup_vcpu(vcpu);
>  	return 0;
>  }
> 
> diff --git a/arm/aarch64/include/kvm/pvtime.h 
> b/arm/aarch64/include/kvm/pvtime.h
> new file mode 100644
> index 0000000..c31f019
> --- /dev/null
> +++ b/arm/aarch64/include/kvm/pvtime.h
> @@ -0,0 +1,6 @@
> +#ifndef KVM__PVTIME_H
> +#define KVM__PVTIME_H
> +
> +void pvtime__setup_vcpu(struct kvm_cpu *vcpu);
> +
> +#endif /* KVM__PVTIME_H */

How about sticking this in kvm-cpu-arch.h instead? A whole new include 
file
for just a prototype isn't totally warranted.

> diff --git a/arm/aarch64/pvtime.c b/arm/aarch64/pvtime.c
> new file mode 100644
> index 0000000..eb92388
> --- /dev/null
> +++ b/arm/aarch64/pvtime.c
> @@ -0,0 +1,83 @@
> +#include "kvm/kvm.h"
> +#include "kvm/kvm-cpu.h"
> +#include "kvm/util.h"
> +#include "kvm/pvtime.h"
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
> +static int pvtime__aloc_region(struct kvm *kvm)

s/aloc/alloc/ ?

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
> +	kvm__destroy_mem(kvm, AARCH64_PVTIME_IPA_START,
> +			 AARCH64_PVTIME_IPA_MAX_SIZE, pvtime_data.usr_mem);
> +	munmap(pvtime_data.usr_mem, AARCH64_PVTIME_IPA_MAX_SIZE);
> +	pvtime_data.usr_mem = NULL;
> +	return 0;
> +}
> +
> +void pvtime__setup_vcpu(struct kvm_cpu *vcpu)
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
> +	if (!pvtime_data.usr_mem) {
> +		ret = pvtime__aloc_region(vcpu->kvm);
> +		if (ret)
> +			goto out_err_alloc;
> +	}
> +
> +	ret = ioctl(vcpu->vcpu_fd, KVM_HAS_DEVICE_ATTR, &pvtime_attr);
> +	if (ret)
> +		goto out_err_attr;

You should check for the stolen time capability before allocating and 
mapping
the memory.

> +
> +	pvtime_attr.addr = (u64)&pvtime_guest_addr;
> +	ret = ioctl(vcpu->vcpu_fd, KVM_SET_DEVICE_ATTR, &pvtime_attr);
> +	if (!ret)
> +		return;
> +
> +out_err_attr:
> +	pvtime__teardown_region(vcpu->kvm);
> +out_err_alloc:
> +	pvtime_data.is_supported = false;
> +}
> +
> +dev_exit(pvtime__teardown_region);
> diff --git a/arm/include/arm-common/kvm-arch.h
> b/arm/include/arm-common/kvm-arch.h
> index c645ac0..7b683d6 100644
> --- a/arm/include/arm-common/kvm-arch.h
> +++ b/arm/include/arm-common/kvm-arch.h
> @@ -54,6 +54,12 @@
>  #define ARM_PCI_MMIO_SIZE	(ARM_MEMORY_AREA - \
>  				(ARM_AXI_AREA + ARM_PCI_CFG_SIZE))
> 
> +#define AARCH64_PVTIME_IPA_MAX_SIZE		(0x10000)

SZ_64K?

> +#define AARCH64_PROTECTED_VM_FW_MAX_SIZE	(0x200000)

This definitely looks like something that shouldn't be there. Yet.

> +#define AARCH64_PVTIME_IPA_START	(ARM_MEMORY_AREA - \
> +					 AARCH64_PROTECTED_VM_FW_MAX_SIZE - \
> +					 AARCH64_PVTIME_IPA_MAX_SIZE)
> +#define AARCH64_PVTIME_SIZE		(64)
> 
>  #define ARM_LOMAP_MAX_MEMORY	((1ULL << 32) - ARM_MEMORY_AREA)
>  #define ARM_HIMAP_MAX_MEMORY	((1ULL << 40) - ARM_MEMORY_AREA)
> diff --git a/arm/kvm-cpu.c b/arm/kvm-cpu.c
> index 6a2408c..84ac1e9 100644
> --- a/arm/kvm-cpu.c
> +++ b/arm/kvm-cpu.c
> @@ -116,6 +116,13 @@ struct kvm_cpu *kvm_cpu__arch_init(struct kvm
> *kvm, unsigned long cpu_id)
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
> @@ -125,13 +132,6 @@ struct kvm_cpu *kvm_cpu__arch_init(struct kvm
> *kvm, unsigned long cpu_id)
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

What is the reason for moving these assignments around?

>  	if (kvm_cpu__configure_features(vcpu))
>  		die("Unable to configure requested vcpu features");

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
