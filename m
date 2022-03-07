Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D9DAD4CFD43
	for <lists+kvmarm@lfdr.de>; Mon,  7 Mar 2022 12:45:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2BE594B1A2;
	Mon,  7 Mar 2022 06:45:49 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 required=6.1 tests=[BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JFK42OwxoS0P; Mon,  7 Mar 2022 06:45:49 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B1CA44B1C9;
	Mon,  7 Mar 2022 06:45:47 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B25F14B1A3
 for <kvmarm@lists.cs.columbia.edu>; Mon,  7 Mar 2022 06:45:46 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0A947HDkdkNB for <kvmarm@lists.cs.columbia.edu>;
 Mon,  7 Mar 2022 06:45:45 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 43CBC4B1A2
 for <kvmarm@lists.cs.columbia.edu>; Mon,  7 Mar 2022 06:45:45 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97E3C1042;
 Mon,  7 Mar 2022 03:45:44 -0800 (PST)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6AF7A3F73D;
 Mon,  7 Mar 2022 03:45:43 -0800 (PST)
Date: Mon, 7 Mar 2022 11:46:09 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Sebastian Ene <sebastianene@google.com>
Subject: Re: [PATCH kvmtool v7 2/3] aarch64: Add stolen time support
Message-ID: <YiXwgY/n4Y3W4XAi@monolith.localdoman>
References: <20220302140734.1015958-1-sebastianene@google.com>
 <20220302140734.1015958-3-sebastianene@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220302140734.1015958-3-sebastianene@google.com>
Cc: maz@kernel.org, will@kernel.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
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

On Wed, Mar 02, 2022 at 02:07:35PM +0000, Sebastian Ene wrote:
> This patch adds support for stolen time by sharing a memory region
> with the guest which will be used by the hypervisor to store the stolen
> time information. Reserve a 64kb MMIO memory region after the RTC peripheral
> to be used by pvtime. The exact format of the structure stored by the
> hypervisor is described in the ARM DEN0057A document.
> 
> Signed-off-by: Sebastian Ene <sebastianene@google.com>
> ---
>  Makefile                               |   1 +
>  arm/aarch64/arm-cpu.c                  |   2 +-
>  arm/aarch64/include/kvm/kvm-cpu-arch.h |   1 +
>  arm/aarch64/pvtime.c                   | 103 +++++++++++++++++++++++++
>  arm/include/arm-common/kvm-arch.h      |   6 +-
>  include/kvm/kvm-config.h               |   1 +
>  6 files changed, 112 insertions(+), 2 deletions(-)
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
> index d7572b7..7e4a3c1 100644
> --- a/arm/aarch64/arm-cpu.c
> +++ b/arm/aarch64/arm-cpu.c
> @@ -22,7 +22,7 @@ static void generate_fdt_nodes(void *fdt, struct kvm *kvm)
>  static int arm_cpu__vcpu_init(struct kvm_cpu *vcpu)
>  {
>  	vcpu->generate_fdt_nodes = generate_fdt_nodes;
> -	return 0;
> +	return kvm_cpu__setup_pvtime(vcpu);
>  }
>  
>  static struct kvm_arm_target target_generic_v8 = {
> diff --git a/arm/aarch64/include/kvm/kvm-cpu-arch.h b/arm/aarch64/include/kvm/kvm-cpu-arch.h
> index 8dfb82e..2b2c1ff 100644
> --- a/arm/aarch64/include/kvm/kvm-cpu-arch.h
> +++ b/arm/aarch64/include/kvm/kvm-cpu-arch.h
> @@ -19,5 +19,6 @@
>  
>  void kvm_cpu__select_features(struct kvm *kvm, struct kvm_vcpu_init *init);
>  int kvm_cpu__configure_features(struct kvm_cpu *vcpu);
> +int kvm_cpu__setup_pvtime(struct kvm_cpu *vcpu);
>  
>  #endif /* KVM__KVM_CPU_ARCH_H */
> diff --git a/arm/aarch64/pvtime.c b/arm/aarch64/pvtime.c
> new file mode 100644
> index 0000000..fdde683
> --- /dev/null
> +++ b/arm/aarch64/pvtime.c
> @@ -0,0 +1,103 @@
> +#include "kvm/kvm.h"
> +#include "kvm/kvm-cpu.h"
> +#include "kvm/util.h"
> +
> +#include <linux/byteorder.h>
> +#include <linux/types.h>
> +
> +#define ARM_PVTIME_STRUCT_SIZE		(64)
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
> +	mem = mmap(NULL, ARM_PVTIME_MMIO_SIZE, PROT_RW,
> +		   MAP_ANON_NORESERVE, -1, 0);
> +	if (mem == MAP_FAILED)
> +		return -errno;
> +
> +	ret = kvm__register_dev_mem(kvm, ARM_PVTIME_MMIO_BASE,
> +				    ARM_PVTIME_MMIO_SIZE, mem);
> +	if (ret) {
> +		munmap(mem, ARM_PVTIME_MMIO_SIZE);
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
> +	kvm__destroy_mem(kvm, ARM_PVTIME_MMIO_BASE,
> +			 ARM_PVTIME_MMIO_SIZE, pvtime_data.usr_mem);
> +	munmap(pvtime_data.usr_mem, ARM_PVTIME_MMIO_SIZE);
> +	pvtime_data.usr_mem = NULL;
> +	return 0;
> +}
> +
> +dev_exit(pvtime__teardown_region);

This looks awkward: pvtime initialization is done in kvm_cpu__arch_init(), but
teardown is done in the device exit stage.

I think it would be better to choose one approach and stick with it: (1) keep
initialization in kvm_cpu__arch_init() and move teardown to kvm_cpu__delete();
or (2) treat pvtime as a device, move the code to hw/pvtime.c, compile the file
only for arm64 and move initialization to dev_init() (and keep teardown in
dev_exit()).

I have no preference for either, but I think a consistent approach to enabling
pvtime is desirable.

Thanks,
Alex
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
