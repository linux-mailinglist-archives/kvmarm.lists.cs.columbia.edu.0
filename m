Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E67DF34E7B1
	for <lists+kvmarm@lfdr.de>; Tue, 30 Mar 2021 14:44:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 46D1F4B2FB;
	Tue, 30 Mar 2021 08:44:33 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9cRMCnOVl-Gn; Tue, 30 Mar 2021 08:44:33 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DE30B4B2DD;
	Tue, 30 Mar 2021 08:44:31 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 71E4F4B1F3
 for <kvmarm@lists.cs.columbia.edu>; Tue, 30 Mar 2021 08:44:30 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Fok4SaWVboE5 for <kvmarm@lists.cs.columbia.edu>;
 Tue, 30 Mar 2021 08:44:29 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 3D8BF4B1DA
 for <kvmarm@lists.cs.columbia.edu>; Tue, 30 Mar 2021 08:44:29 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1D5A661957;
 Tue, 30 Mar 2021 12:44:28 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1lRDjO-004g2i-7W; Tue, 30 Mar 2021 13:44:26 +0100
Date: Tue, 30 Mar 2021 13:44:25 +0100
Message-ID: <87lfa4rety.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] arm64: kvm: handle 52-bit VA regions correctly under nVHE
In-Reply-To: <20210330112126.463336-1-ardb@kernel.org>
References: <20210330112126.463336-1-ardb@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: ardb@kernel.org, linux-arm-kernel@lists.infradead.org,
 will@kernel.org, kernel-team@android.com, anshuman.khandual@arm.com,
 steve.capper@arm.com, catalin.marinas@arm.com, kvmarm@lists.cs.columbia.edu,
 qperret@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: will@kernel.org, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
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

On Tue, 30 Mar 2021 12:21:26 +0100,
Ard Biesheuvel <ardb@kernel.org> wrote:
> 
> Commit f4693c2716b35d08 ("arm64: mm: extend linear region for 52-bit VA
> configurations") introduced a new layout for the 52-bit VA space, in
> order to maximize the space available to the linear region. After this
> change, the kernel VA space is no longer split 1:1 down the middle, and
> as it turns out, this violates an assumption in the KVM init code when
> it chooses the layout for the nVHE EL2 mapping.
> 
> Given that EFI does not support 52-bit VA addressing (as it only
> supports 4k pages), and that in general, loaders cannot assume that the
> kernel being loaded supports 52-bit VA/PA addressing in the first place,
> we can safely assume that the kernel, and therefore the .idmap section,
> will be 48-bit addressable on 52-bit VA capable systems.
> 
> So in this case, organize the nVHE EL2 address space as a 2^48 byte
> window starting at address 0x0, containing the ID map and the
> hypervisor's private mappings, followed by a contiguous 2^52 - 2^48 byte
> linear region. (Note that EL1's linear region is 2^52 - 2^47 bytes in
> size, so it is slightly larger, but this only matters on systems where
> the DRAM footprint in the physical memory map exceeds 3968 TB)

So if I have memory in the [2^52 - 2^48, 2^52 - 2^47] range, not
necessarily because I have that much memory, but because my system has
multiple memory banks, one of which lands on that spot, I cannot map
such memory at EL2. We'll explode at run time.

Can we keep the private mapping to 47 bits and restore the missing
chunk to the linear mapping? Of course, it means that the linear map
is now potential no linear anymore, so we'd have to garantee that the
kernel lines in the first 2^47 bits instead. Crap.

> 
> Fixes: f4693c2716b35d08 ("arm64: mm: extend linear region for 52-bit VA configurations")
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  Documentation/arm64/booting.rst |  6 +++---
>  arch/arm64/kvm/va_layout.c      | 18 ++++++++++++++----
>  2 files changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/arm64/booting.rst b/Documentation/arm64/booting.rst
> index 7552dbc1cc54..418ec9b63d2c 100644
> --- a/Documentation/arm64/booting.rst
> +++ b/Documentation/arm64/booting.rst
> @@ -121,8 +121,8 @@ Header notes:
>  			  to the base of DRAM, since memory below it is not
>  			  accessible via the linear mapping
>  			1
> -			  2MB aligned base may be anywhere in physical
> -			  memory
> +			  2MB aligned base may be anywhere in the 48-bit
> +			  addressable physical memory region
>    Bits 4-63	Reserved.
>    ============= ===============================================================
>  
> @@ -132,7 +132,7 @@ Header notes:
>    depending on selected features, and is effectively unbound.
>  
>  The Image must be placed text_offset bytes from a 2MB aligned base
> -address anywhere in usable system RAM and called there. The region
> +address in 48-bit addressable system RAM and called there. The region
>  between the 2 MB aligned base address and the start of the image has no
>  special significance to the kernel, and may be used for other purposes.
>  At least image_size bytes from the start of the image must be free for
> diff --git a/arch/arm64/kvm/va_layout.c b/arch/arm64/kvm/va_layout.c
> index 978301392d67..e9ab449de197 100644
> --- a/arch/arm64/kvm/va_layout.c
> +++ b/arch/arm64/kvm/va_layout.c
> @@ -62,9 +62,19 @@ __init void kvm_compute_layout(void)
>  	phys_addr_t idmap_addr = __pa_symbol(__hyp_idmap_text_start);
>  	u64 hyp_va_msb;
>  
> -	/* Where is my RAM region? */
> -	hyp_va_msb  = idmap_addr & BIT(vabits_actual - 1);
> -	hyp_va_msb ^= BIT(vabits_actual - 1);
> +	/*
> +	 * On LVA capable hardware, the kernel is guaranteed to reside
> +	 * in the 48-bit addressable part of physical memory, and so
> +	 * the idmap will be located there as well. Put the EL2 linear
> +	 * region right after it, where it can grow upward to fill the
> +	 * entire 52-bit VA region.
> +	 */
> +	if (vabits_actual > VA_BITS_MIN) {
> +		hyp_va_msb = BIT(VA_BITS_MIN);
> +	} else {
> +		hyp_va_msb  = idmap_addr & BIT(vabits_actual - 1);
> +		hyp_va_msb ^= BIT(vabits_actual - 1);
> +	}
>  
>  	tag_lsb = fls64((u64)phys_to_virt(memblock_start_of_DRAM()) ^
>  			(u64)(high_memory - 1));
> @@ -72,7 +82,7 @@ __init void kvm_compute_layout(void)
>  	va_mask = GENMASK_ULL(tag_lsb - 1, 0);
>  	tag_val = hyp_va_msb;
>  
> -	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && tag_lsb != (vabits_actual - 1)) {
> +	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && tag_lsb < (vabits_actual - 1)) {
>  		/* We have some free bits to insert a random tag. */
>  		tag_val |= get_random_long() & GENMASK_ULL(vabits_actual - 2, tag_lsb);
>  	}

It seems __create_hyp_private mapping() still refers to (VA_BITS - 1)
to choose where to allocate the IO mappings, and
__pkvm_create_private_mapping() relies on similar things based on what
hyp_create_idmap().

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
