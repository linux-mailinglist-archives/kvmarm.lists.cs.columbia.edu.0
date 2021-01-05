Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 220EE2EAF5F
	for <lists+kvmarm@lfdr.de>; Tue,  5 Jan 2021 16:49:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 564604B347;
	Tue,  5 Jan 2021 10:49:44 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ulEsbuEgTzvI; Tue,  5 Jan 2021 10:49:44 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E81FE4B345;
	Tue,  5 Jan 2021 10:49:42 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 49B2A4B2DE
 for <kvmarm@lists.cs.columbia.edu>; Tue,  5 Jan 2021 10:49:42 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WIV5dBRHVji7 for <kvmarm@lists.cs.columbia.edu>;
 Tue,  5 Jan 2021 10:49:39 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9658F4B2D1
 for <kvmarm@lists.cs.columbia.edu>; Tue,  5 Jan 2021 10:49:39 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D8921FB;
 Tue,  5 Jan 2021 07:49:39 -0800 (PST)
Received: from [192.168.0.110] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2BB9E3F70D;
 Tue,  5 Jan 2021 07:49:38 -0800 (PST)
Subject: Re: [PATCH] KVM: arm64: Replace KVM_ARM_PMU with HW_PERF_EVENTS
To: Marc Zyngier <maz@kernel.org>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
References: <20210104172723.2014324-1-maz@kernel.org>
From: Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <fd094578-0b7d-57be-6f68-a55aca39e961@arm.com>
Date: Tue, 5 Jan 2021 15:49:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210104172723.2014324-1-maz@kernel.org>
Content-Language: en-US
Cc: kernel-team@android.com
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

Hi Marc,

On 1/4/21 5:27 PM, Marc Zyngier wrote:
> KVM_ARM_PMU only existed for the benefit of 32bit ARM hosts,
> and makes no sense now that we are 64bit only. Get rid of it.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/kvm/Kconfig  | 8 --------
>  arch/arm64/kvm/Makefile | 2 +-
>  include/kvm/arm_pmu.h   | 2 +-
>  3 files changed, 2 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
> index 043756db8f6e..3964acf5451e 100644
> --- a/arch/arm64/kvm/Kconfig
> +++ b/arch/arm64/kvm/Kconfig
> @@ -49,14 +49,6 @@ if KVM
>  
>  source "virt/kvm/Kconfig"
>  
> -config KVM_ARM_PMU
> -	bool "Virtual Performance Monitoring Unit (PMU) support"
> -	depends on HW_PERF_EVENTS
> -	default y
> -	help
> -	  Adds support for a virtual Performance Monitoring Unit (PMU) in
> -	  virtual machines.
> -
>  endif # KVM
>  
>  endif # VIRTUALIZATION
> diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
> index 60fd181df624..13b017284bf9 100644
> --- a/arch/arm64/kvm/Makefile
> +++ b/arch/arm64/kvm/Makefile
> @@ -24,4 +24,4 @@ kvm-y := $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o $(KVM)/eventfd.o \
>  	 vgic/vgic-mmio-v3.o vgic/vgic-kvm-device.o \
>  	 vgic/vgic-its.o vgic/vgic-debug.o
>  
> -kvm-$(CONFIG_KVM_ARM_PMU)  += pmu-emul.o
> +kvm-$(CONFIG_HW_PERF_EVENTS)  += pmu-emul.o
> diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
> index fc85f50fa0e9..8dcb3e1477bc 100644
> --- a/include/kvm/arm_pmu.h
> +++ b/include/kvm/arm_pmu.h
> @@ -13,7 +13,7 @@
>  #define ARMV8_PMU_CYCLE_IDX		(ARMV8_PMU_MAX_COUNTERS - 1)
>  #define ARMV8_PMU_MAX_COUNTER_PAIRS	((ARMV8_PMU_MAX_COUNTERS + 1) >> 1)
>  
> -#ifdef CONFIG_KVM_ARM_PMU
> +#ifdef CONFIG_HW_PERF_EVENTS
>  
>  struct kvm_pmc {
>  	u8 idx;	/* index into the pmu->pmc array */

I grep'ed for KVM_ARM_PMU in the Linux sources, this patch takes care of all its
occurrences.

A few things popped into my mind when I saw the patch.

1. Replacing KVM_ARM_PMU with CONFIG_HW_PERF_EVENTS means it's not possible
anymore for the host to have perf support while KVM does not support emulating a
PMU. In this scenario, functions which would have been empty functions if
KVM_ARM_PMU was still around (I only found kvm_pmu_flush_hwstate() and
kvm_pmu_sync_hwstate() on the KVM_RUN path) will now be called and return early
after kvm_vcpu_has_pmu() returns 0. The overhead looks negligible to me, and I
don't think this configuration was common (especially since the default was y).

2. I did a grep for the files that include arm_pmu.h, and all the files were in
arch/arm64. I suppose arm_pmu.h exists in include/kvm instead of
arch/arm64/include/asm because it was shared with KVM/arm when it was still
around, right? Or is there another reason for that?

[1] https://www.spinics.net/lists/kvm-arm/msg44184.html

Thanks,
Alex
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
