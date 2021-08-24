Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E7D483F542F
	for <lists+kvmarm@lfdr.de>; Tue, 24 Aug 2021 02:47:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id ADCEA4B1CB;
	Mon, 23 Aug 2021 20:47:19 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jaLUhQLmmGc1; Mon, 23 Aug 2021 20:47:19 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4EA394B210;
	Mon, 23 Aug 2021 20:47:15 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6BE0E4B1CB
 for <kvmarm@lists.cs.columbia.edu>; Mon, 23 Aug 2021 20:47:13 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P7xHNd1sK5iv for <kvmarm@lists.cs.columbia.edu>;
 Mon, 23 Aug 2021 20:47:09 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 28E2D4B1B6
 for <kvmarm@lists.cs.columbia.edu>; Mon, 23 Aug 2021 20:47:09 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B21F0101E;
 Mon, 23 Aug 2021 17:47:08 -0700 (PDT)
Received: from slackpad.fritz.box (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EEF993F66F;
 Mon, 23 Aug 2021 17:47:07 -0700 (PDT)
Date: Tue, 24 Aug 2021 01:46:58 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2 2/3] kvmtool: arm64: Use the maximum supported IPA
 size when creating the VM
Message-ID: <20210824014658.0e9fa5f3@slackpad.fritz.box>
In-Reply-To: <20210822152526.1291918-3-maz@kernel.org>
References: <20210822152526.1291918-1-maz@kernel.org>
 <20210822152526.1291918-3-maz@kernel.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Cc: Will Deacon <will@kernel.org>, kernel-team@android.com,
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

On Sun, 22 Aug 2021 16:25:25 +0100
Marc Zyngier <maz@kernel.org> wrote:

Hi Marc,

> Instead of just asking the the default VM size, request the maximum
> IPA size to the kernel, and use this at VM creation time.
> 
> The IPA space is parametrized accordingly.

Thanks for the change!

> Signed-off-by: Marc Zyngier <maz@kernel.org>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  arm/aarch64/include/kvm/kvm-arch.h | 19 ++++++++++++++++---
>  arm/aarch64/kvm.c                  | 15 +++++++++++++++
>  2 files changed, 31 insertions(+), 3 deletions(-)
> 
> diff --git a/arm/aarch64/include/kvm/kvm-arch.h b/arm/aarch64/include/kvm/kvm-arch.h
> index 55ef8ed1..159567b9 100644
> --- a/arm/aarch64/include/kvm/kvm-arch.h
> +++ b/arm/aarch64/include/kvm/kvm-arch.h
> @@ -3,10 +3,23 @@
>  
>  struct kvm;
>  unsigned long long kvm__arch_get_kern_offset(struct kvm *kvm, int fd);
> +int kvm__arch_get_ipa_limit(struct kvm *kvm);
>  
> -#define ARM_MAX_MEMORY(kvm)	((kvm)->cfg.arch.aarch32_guest	?	\
> -				ARM_LOMAP_MAX_MEMORY		:	\
> -				ARM_HIMAP_MAX_MEMORY)
> +#define ARM_MAX_MEMORY(kvm)	({					\
> +	u64 max_ram;							\
> +									\
> +	if ((kvm)->cfg.arch.aarch32_guest) {				\
> +		max_ram = ARM_LOMAP_MAX_MEMORY;				\
> +	} else {							\
> +		int ipabits = kvm__arch_get_ipa_limit(kvm);		\
> +		if (ipabits <= 0)					\
> +			max_ram = ARM_HIMAP_MAX_MEMORY;			\
> +		else							\
> +			max_ram = (1ULL << ipabits) - ARM_MEMORY_AREA;	\
> +	}								\
> +									\
> +	max_ram;							\
> +})
>  
>  #include "arm-common/kvm-arch.h"
>  
> diff --git a/arm/aarch64/kvm.c b/arm/aarch64/kvm.c
> index 49e1dd31..d03a27f2 100644
> --- a/arm/aarch64/kvm.c
> +++ b/arm/aarch64/kvm.c
> @@ -46,3 +46,18 @@ fail:
>  	return 0x80000;
>  }
>  
> +int kvm__arch_get_ipa_limit(struct kvm *kvm)
> +{
> +	int ret;
> +
> +	ret = ioctl(kvm->sys_fd, KVM_CHECK_EXTENSION, KVM_CAP_ARM_VM_IPA_SIZE);
> +	if (ret <= 0)
> +		ret = 0;
> +
> +	return ret;
> +}
> +
> +int kvm__get_vm_type(struct kvm *kvm)
> +{
> +	return KVM_VM_TYPE_ARM_IPA_SIZE(kvm__arch_get_ipa_limit(kvm));
> +}

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
