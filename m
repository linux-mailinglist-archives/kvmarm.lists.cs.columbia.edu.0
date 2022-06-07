Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6F20E53A610
	for <lists+kvmarm@lfdr.de>; Wed,  1 Jun 2022 15:40:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 03A1340431;
	Wed,  1 Jun 2022 09:40:43 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 required=6.1 tests=[BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7lU9yj-T9QUs; Wed,  1 Jun 2022 09:40:41 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 49E974B3A6;
	Wed,  1 Jun 2022 09:40:41 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CA8FE4B385
 for <kvmarm@lists.cs.columbia.edu>; Wed,  1 Jun 2022 09:40:39 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LRmRwetnqcj8 for <kvmarm@lists.cs.columbia.edu>;
 Wed,  1 Jun 2022 09:40:38 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5DEB040336
 for <kvmarm@lists.cs.columbia.edu>; Wed,  1 Jun 2022 09:40:38 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9AC771480;
 Wed,  1 Jun 2022 06:40:37 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5ACBC3F73D;
 Wed,  1 Jun 2022 06:40:36 -0700 (PDT)
Date: Wed, 1 Jun 2022 14:21:18 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Subject: Re: [PATCH v3 kvmtool 12/13] Introduce kvm__arch_default_ram_address()
Message-ID: <20220601142118.67212340@donnerap.cambridge.arm.com>
In-Reply-To: <20220525112345.121321-13-alexandru.elisei@arm.com>
References: <20220525112345.121321-1-alexandru.elisei@arm.com>
 <20220525112345.121321-13-alexandru.elisei@arm.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Cc: julien@xen.org, maz@kernel.org, will@kernel.org,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

On Wed, 25 May 2022 12:23:44 +0100
Alexandru Elisei <alexandru.elisei@arm.com> wrote:

> Add a new function, kvm__arch_default_ram_address(), which returns the
> default address for guest RAM for each architecture.
> 
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  arm/aarch32/kvm.c | 5 +++++
>  arm/aarch64/kvm.c | 5 +++++
>  include/kvm/kvm.h | 1 +
>  mips/kvm.c        | 5 +++++
>  powerpc/kvm.c     | 5 +++++
>  riscv/kvm.c       | 5 +++++
>  x86/kvm.c         | 5 +++++
>  7 files changed, 31 insertions(+)
> 
> diff --git a/arm/aarch32/kvm.c b/arm/aarch32/kvm.c
> index 9d68d7a15ee2..768a56bbb5b4 100644
> --- a/arm/aarch32/kvm.c
> +++ b/arm/aarch32/kvm.c
> @@ -7,3 +7,8 @@ void kvm__arch_validate_cfg(struct kvm *kvm)
>  		    kvm->cfg.ram_size, ARM_LOMAP_MAX_MEMORY);
>  	}
>  }
> +
> +u64 kvm__arch_default_ram_address(void)
> +{
> +	return ARM_MEMORY_AREA;
> +}
> diff --git a/arm/aarch64/kvm.c b/arm/aarch64/kvm.c
> index 2134528bf7f2..357936844046 100644
> --- a/arm/aarch64/kvm.c
> +++ b/arm/aarch64/kvm.c
> @@ -46,6 +46,11 @@ void kvm__arch_validate_cfg(struct kvm *kvm)
>  	}
>  }
>  
> +u64 kvm__arch_default_ram_address(void)
> +{
> +	return ARM_MEMORY_AREA;
> +}
> +
>  /*
>   * Return the TEXT_OFFSET value that the guest kernel expects. Note
>   * that pre-3.17 kernels expose this value using the native endianness
> diff --git a/include/kvm/kvm.h b/include/kvm/kvm.h
> index 640b76c095f9..360430b78b1e 100644
> --- a/include/kvm/kvm.h
> +++ b/include/kvm/kvm.h
> @@ -190,6 +190,7 @@ void kvm__remove_socket(const char *name);
>  void kvm__arch_validate_cfg(struct kvm *kvm);
>  void kvm__arch_set_cmdline(char *cmdline, bool video);
>  void kvm__arch_init(struct kvm *kvm);
> +u64 kvm__arch_default_ram_address(void);
>  void kvm__arch_delete_ram(struct kvm *kvm);
>  int kvm__arch_setup_firmware(struct kvm *kvm);
>  int kvm__arch_free_firmware(struct kvm *kvm);
> diff --git a/mips/kvm.c b/mips/kvm.c
> index d8610cf81b94..4cbc9907731b 100644
> --- a/mips/kvm.c
> +++ b/mips/kvm.c
> @@ -12,6 +12,11 @@ struct kvm_ext kvm_req_ext[] = {
>  	{ 0, 0 }
>  };
>  
> +u64 kvm__arch_default_ram_address(void)
> +{
> +	return 0;
> +}
> +
>  void kvm__arch_validate_cfg(struct kvm *kvm)
>  {
>  }
> diff --git a/powerpc/kvm.c b/powerpc/kvm.c
> index d281b070fd0e..7b0d0669aff4 100644
> --- a/powerpc/kvm.c
> +++ b/powerpc/kvm.c
> @@ -48,6 +48,11 @@ struct kvm_ext kvm_req_ext[] = {
>  	{ 0, 0 }
>  };
>  
> +u64 kvm__arch_default_ram_address(void)
> +{
> +	return 0;
> +}
> +
>  void kvm__arch_validate_cfg(struct kvm *kvm)
>  {
>  }
> diff --git a/riscv/kvm.c b/riscv/kvm.c
> index c46660772aa0..4d6f5cb57ac8 100644
> --- a/riscv/kvm.c
> +++ b/riscv/kvm.c
> @@ -13,6 +13,11 @@ struct kvm_ext kvm_req_ext[] = {
>  	{ 0, 0 },
>  };
>  
> +u64 kvm__arch_default_ram_address(void)
> +{
> +	return RISCV_RAM;
> +}
> +
>  void kvm__arch_validate_cfg(struct kvm *kvm)
>  {
>  }
> diff --git a/x86/kvm.c b/x86/kvm.c
> index 24b0305a1841..328fa7500596 100644
> --- a/x86/kvm.c
> +++ b/x86/kvm.c
> @@ -35,6 +35,11 @@ struct kvm_ext kvm_req_ext[] = {
>  	{ 0, 0 }
>  };
>  
> +u64 kvm__arch_default_ram_address(void)
> +{
> +	return 0;
> +}
> +
>  void kvm__arch_validate_cfg(struct kvm *kvm)
>  {
>  }

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
