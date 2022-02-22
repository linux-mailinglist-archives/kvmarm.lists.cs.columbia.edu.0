Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D468F4C01A7
	for <lists+kvmarm@lfdr.de>; Tue, 22 Feb 2022 19:53:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3CE6549F03;
	Tue, 22 Feb 2022 13:53:26 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 required=6.1 tests=[BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T7SFLwhfcEP8; Tue, 22 Feb 2022 13:53:26 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7557B49EF4;
	Tue, 22 Feb 2022 13:53:24 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5248949EB1
 for <kvmarm@lists.cs.columbia.edu>; Tue, 22 Feb 2022 13:53:23 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dYh3Jcl0AyfQ for <kvmarm@lists.cs.columbia.edu>;
 Tue, 22 Feb 2022 13:53:21 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C324949E08
 for <kvmarm@lists.cs.columbia.edu>; Tue, 22 Feb 2022 13:53:21 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0CE1F106F;
 Tue, 22 Feb 2022 10:53:21 -0800 (PST)
Received: from lakrids (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98D7E3F66F;
 Tue, 22 Feb 2022 10:53:18 -0800 (PST)
Date: Tue, 22 Feb 2022 18:53:16 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Kalesh Singh <kaleshsingh@google.com>
Subject: Re: [PATCH v2 1/9] KVM: arm64: Introduce hyp_alloc_private_va_range()
Message-ID: <YhUxHNRxxepEmc8j@lakrids>
References: <20220222165212.2005066-1-kaleshsingh@google.com>
 <20220222165212.2005066-2-kaleshsingh@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220222165212.2005066-2-kaleshsingh@google.com>
Cc: linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
 Pasha Tatashin <pasha.tatashin@soleen.com>, will@kernel.org,
 Peter Collingbourne <pcc@google.com>, maz@kernel.org,
 linux-kernel@vger.kernel.org, Joey Gouly <joey.gouly@arm.com>,
 kvmarm@lists.cs.columbia.edu, Andrew Walbran <qwandor@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, surenb@google.com
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

On Tue, Feb 22, 2022 at 08:51:02AM -0800, Kalesh Singh wrote:
> hyp_alloc_private_va_range() can be used to reserve private VA ranges
> in the nVHE hypervisor. Also update  __create_hyp_private_mapping()
> to allow specifying an alignment for the private VA mapping.
> 
> These will be used to implement stack guard pages for KVM nVHE hypervisor
> (nVHE Hyp mode / not pKVM), in a subsequent patch in the series.
> 
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---
>  arch/arm64/include/asm/kvm_mmu.h |  4 +++
>  arch/arm64/kvm/mmu.c             | 61 +++++++++++++++++++++-----------
>  2 files changed, 44 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
> index 81839e9a8a24..0b0c71302b92 100644
> --- a/arch/arm64/include/asm/kvm_mmu.h
> +++ b/arch/arm64/include/asm/kvm_mmu.h
> @@ -153,6 +153,10 @@ static __always_inline unsigned long __kern_hyp_va(unsigned long v)
>  int kvm_share_hyp(void *from, void *to);
>  void kvm_unshare_hyp(void *from, void *to);
>  int create_hyp_mappings(void *from, void *to, enum kvm_pgtable_prot prot);
> +unsigned long hyp_alloc_private_va_range(size_t size, size_t align);
> +int __create_hyp_private_mapping(phys_addr_t phys_addr, size_t size,
> +				size_t align, unsigned long *haddr,
> +				enum kvm_pgtable_prot prot);
>  int create_hyp_io_mappings(phys_addr_t phys_addr, size_t size,
>  			   void __iomem **kaddr,
>  			   void __iomem **haddr);
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index bc2aba953299..e5abcce44ad0 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -457,22 +457,16 @@ int create_hyp_mappings(void *from, void *to, enum kvm_pgtable_prot prot)
>  	return 0;
>  }
>  
> -static int __create_hyp_private_mapping(phys_addr_t phys_addr, size_t size,
> -					unsigned long *haddr,
> -					enum kvm_pgtable_prot prot)
> +
> +/*
> + * Allocates a private VA range below io_map_base.
> + *
> + * @size:	The size of the VA range to reserve.
> + * @align:	The required alignment for the allocation.
> + */
> +unsigned long hyp_alloc_private_va_range(size_t size, size_t align)
>  {
>  	unsigned long base;
> -	int ret = 0;
> -
> -	if (!kvm_host_owns_hyp_mappings()) {
> -		base = kvm_call_hyp_nvhe(__pkvm_create_private_mapping,
> -					 phys_addr, size, prot);
> -		if (IS_ERR_OR_NULL((void *)base))
> -			return PTR_ERR((void *)base);

There is a latent bug here; PTR_ERR() is not valid for NULL.

Today on arm64 that will happen to return 0, which may or may not be
what you want, but it's a bad pattern regardless.

That applies to the two copies below that this has been transformed
into.

Thanks,
Mark

> -		*haddr = base;
> -
> -		return 0;
> -	}
>  
>  	mutex_lock(&kvm_hyp_pgd_mutex);
>  
> @@ -484,8 +478,8 @@ static int __create_hyp_private_mapping(phys_addr_t phys_addr, size_t size,
>  	 *
>  	 * The allocated size is always a multiple of PAGE_SIZE.
>  	 */
> -	size = PAGE_ALIGN(size + offset_in_page(phys_addr));
> -	base = io_map_base - size;
> +	base = io_map_base - PAGE_ALIGN(size);
> +	base = ALIGN_DOWN(base, align);
>  
>  	/*
>  	 * Verify that BIT(VA_BITS - 1) hasn't been flipped by
> @@ -493,20 +487,45 @@ static int __create_hyp_private_mapping(phys_addr_t phys_addr, size_t size,
>  	 * overflowed the idmap/IO address range.
>  	 */
>  	if ((base ^ io_map_base) & BIT(VA_BITS - 1))
> -		ret = -ENOMEM;
> +		base = (unsigned long)ERR_PTR(-ENOMEM);
>  	else
>  		io_map_base = base;
>  
>  	mutex_unlock(&kvm_hyp_pgd_mutex);
>  
> +	return base;
> +}
> +
> +int __create_hyp_private_mapping(phys_addr_t phys_addr, size_t size,
> +				size_t align, unsigned long *haddr,
> +				enum kvm_pgtable_prot prot)
> +{
> +	unsigned long addr;
> +	int ret = 0;
> +
> +	if (!kvm_host_owns_hyp_mappings()) {
> +		addr = kvm_call_hyp_nvhe(__pkvm_create_private_mapping,
> +					 phys_addr, size, prot);
> +		if (IS_ERR_OR_NULL((void *)addr))
> +			return PTR_ERR((void *)addr);
> +		*haddr = addr;
> +
> +		return 0;
> +	}
> +
> +	size += offset_in_page(phys_addr);
> +	addr = hyp_alloc_private_va_range(size, align);
> +	if (IS_ERR_OR_NULL((void *)addr))
> +		return PTR_ERR((void *)addr);
> +
>  	if (ret)
>  		goto out;
>  
> -	ret = __create_hyp_mappings(base, size, phys_addr, prot);
> +	ret = __create_hyp_mappings(addr, size, phys_addr, prot);
>  	if (ret)
>  		goto out;
>  
> -	*haddr = base + offset_in_page(phys_addr);
> +	*haddr = addr + offset_in_page(phys_addr);
>  out:
>  	return ret;
>  }
> @@ -537,7 +556,7 @@ int create_hyp_io_mappings(phys_addr_t phys_addr, size_t size,
>  		return 0;
>  	}
>  
> -	ret = __create_hyp_private_mapping(phys_addr, size,
> +	ret = __create_hyp_private_mapping(phys_addr, size, PAGE_SIZE,
>  					   &addr, PAGE_HYP_DEVICE);
>  	if (ret) {
>  		iounmap(*kaddr);
> @@ -564,7 +583,7 @@ int create_hyp_exec_mappings(phys_addr_t phys_addr, size_t size,
>  
>  	BUG_ON(is_kernel_in_hyp_mode());
>  
> -	ret = __create_hyp_private_mapping(phys_addr, size,
> +	ret = __create_hyp_private_mapping(phys_addr, size, PAGE_SIZE,
>  					   &addr, PAGE_HYP_EXEC);
>  	if (ret) {
>  		*haddr = NULL;
> -- 
> 2.35.1.473.g83b2b277ed-goog
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
