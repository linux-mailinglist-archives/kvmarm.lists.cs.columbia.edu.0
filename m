Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BBC8539BAD7
	for <lists+kvmarm@lfdr.de>; Fri,  4 Jun 2021 16:21:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 457C04B100;
	Fri,  4 Jun 2021 10:21:56 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vSV54cpYyGl7; Fri,  4 Jun 2021 10:21:56 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4E82D4B0ED;
	Fri,  4 Jun 2021 10:21:52 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C2E034B0ED
 for <kvmarm@lists.cs.columbia.edu>; Fri,  4 Jun 2021 10:21:50 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 985JvPufaRT9 for <kvmarm@lists.cs.columbia.edu>;
 Fri,  4 Jun 2021 10:21:48 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1CB0E4B087
 for <kvmarm@lists.cs.columbia.edu>; Fri,  4 Jun 2021 10:21:48 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0BB72B;
 Fri,  4 Jun 2021 07:21:47 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.6.137])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F4AF3F774;
 Fri,  4 Jun 2021 07:21:44 -0700 (PDT)
Date: Fri, 4 Jun 2021 15:21:41 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH 3/4] KVM: arm64: Parse reserved-memory node for pkvm
 guest firmware region
Message-ID: <20210604142141.GC69333@C02TD0UTHF1T.local>
References: <20210603183347.1695-1-will@kernel.org>
 <20210603183347.1695-4-will@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210603183347.1695-4-will@kernel.org>
Cc: kvm@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvmarm@lists.cs.columbia.edu
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

On Thu, Jun 03, 2021 at 07:33:46PM +0100, Will Deacon wrote:
> Add support for a "linux,pkvm-guest-firmware-memory" reserved memory
> region, which can be used to identify a firmware image for protected
> VMs.

The idea that the guest's FW comes from the host's FW strikes me as
unusual; what's the rationale for this coming from the host FW? IIUC
other confidential compute VM environments allow you to load up whatever
virtual FW you want, but this is measured such that the virtual FW used
can be attested.

Thanks,
Mark.

> 
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  arch/arm64/kvm/Makefile |  2 +-
>  arch/arm64/kvm/pkvm.c   | 52 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 53 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/kvm/pkvm.c
> 
> diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
> index 589921392cb1..61e054411831 100644
> --- a/arch/arm64/kvm/Makefile
> +++ b/arch/arm64/kvm/Makefile
> @@ -14,7 +14,7 @@ kvm-y := $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o $(KVM)/eventfd.o \
>  	 $(KVM)/vfio.o $(KVM)/irqchip.o \
>  	 arm.o mmu.o mmio.o psci.o perf.o hypercalls.o pvtime.o \
>  	 inject_fault.o va_layout.o handle_exit.o \
> -	 guest.o debug.o reset.o sys_regs.o \
> +	 guest.o debug.o pkvm.o reset.o sys_regs.o \
>  	 vgic-sys-reg-v3.o fpsimd.o pmu.o \
>  	 arch_timer.o trng.o\
>  	 vgic/vgic.o vgic/vgic-init.o \
> diff --git a/arch/arm64/kvm/pkvm.c b/arch/arm64/kvm/pkvm.c
> new file mode 100644
> index 000000000000..7af5d03a3941
> --- /dev/null
> +++ b/arch/arm64/kvm/pkvm.c
> @@ -0,0 +1,52 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * KVM host (EL1) interface to Protected KVM (pkvm) code at EL2.
> + *
> + * Copyright (C) 2021 Google LLC
> + * Author: Will Deacon <will@kernel.org>
> + */
> +
> +#include <linux/kvm_host.h>
> +#include <linux/mm.h>
> +#include <linux/of_fdt.h>
> +#include <linux/of_reserved_mem.h>
> +
> +static struct reserved_mem *pkvm_firmware_mem;
> +
> +static int __init pkvm_firmware_rmem_err(struct reserved_mem *rmem,
> +					 const char *reason)
> +{
> +	phys_addr_t end = rmem->base + rmem->size;
> +
> +	kvm_err("Ignoring pkvm guest firmware memory reservation [%pa - %pa]: %s\n",
> +		&rmem->base, &end, reason);
> +	return -EINVAL;
> +}
> +
> +static int __init pkvm_firmware_rmem_init(struct reserved_mem *rmem)
> +{
> +	unsigned long node = rmem->fdt_node;
> +
> +	if (kvm_get_mode() != KVM_MODE_PROTECTED)
> +		return pkvm_firmware_rmem_err(rmem, "protected mode not enabled");
> +
> +	if (pkvm_firmware_mem)
> +		return pkvm_firmware_rmem_err(rmem, "duplicate reservation");
> +
> +	if (!of_get_flat_dt_prop(node, "no-map", NULL))
> +		return pkvm_firmware_rmem_err(rmem, "missing \"no-map\" property");
> +
> +	if (of_get_flat_dt_prop(node, "reusable", NULL))
> +		return pkvm_firmware_rmem_err(rmem, "\"reusable\" property unsupported");
> +
> +	if (!PAGE_ALIGNED(rmem->base))
> +		return pkvm_firmware_rmem_err(rmem, "base is not page-aligned");
> +
> +	if (!PAGE_ALIGNED(rmem->size))
> +		return pkvm_firmware_rmem_err(rmem, "size is not page-aligned");
> +
> +	pkvm_firmware_mem = rmem;
> +	return 0;
> +}
> +RESERVEDMEM_OF_DECLARE(pkvm_firmware, "linux,pkvm-guest-firmware-memory",
> +		       pkvm_firmware_rmem_init);
> -- 
> 2.32.0.rc0.204.g9fa02ecfa5-goog
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
