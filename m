Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7787B58D955
	for <lists+kvmarm@lfdr.de>; Tue,  9 Aug 2022 15:24:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 08A894C92E;
	Tue,  9 Aug 2022 09:24:03 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 required=6.1 tests=[BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KXywbRADUw34; Tue,  9 Aug 2022 09:24:02 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3D3624CAE1;
	Tue,  9 Aug 2022 09:24:00 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 998B04C254
 for <kvmarm@lists.cs.columbia.edu>; Tue,  9 Aug 2022 09:01:12 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KZip4pLJSpWP for <kvmarm@lists.cs.columbia.edu>;
 Tue,  9 Aug 2022 09:01:07 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id F1C6C4C240
 for <kvmarm@lists.cs.columbia.edu>; Tue,  9 Aug 2022 09:01:06 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E0B823A;
 Tue,  9 Aug 2022 06:01:07 -0700 (PDT)
Received: from [192.168.12.23] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E351F3F5A1;
 Tue,  9 Aug 2022 06:01:04 -0700 (PDT)
Message-ID: <af820fb3-cbf3-b4f6-5642-ebb5eb4f5b1d@arm.com>
Date: Tue, 9 Aug 2022 14:01:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [kvm-unit-tests RFC PATCH 12/19] arm/arm64: assembler.h: Replace
 size with end address for dcache_by_line_op
Content-Language: en-GB
To: Alexandru Elisei <alexandru.elisei@arm.com>, pbonzini@redhat.com,
 thuth@redhat.com, andrew.jones@linux.dev, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu
References: <20220809091558.14379-1-alexandru.elisei@arm.com>
 <20220809091558.14379-13-alexandru.elisei@arm.com>
From: Nikos Nikoleris <nikos.nikoleris@arm.com>
In-Reply-To: <20220809091558.14379-13-alexandru.elisei@arm.com>
X-Mailman-Approved-At: Tue, 09 Aug 2022 09:23:58 -0400
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

On 09/08/2022 10:15, Alexandru Elisei wrote:
> Commit b5f659be4775 ("arm/arm64: Remove dcache_line_size global
> variable") moved the dcache_by_line_op macro to assembler.h and changed
> it to take the size of the regions instead of the end address as
> parameter. This was done to keep the file in sync with the upstream
> Linux kernel implementation at the time.
> 
> But in both places where the macro is used, the code has the start and
> end address of the region, and it has to compute the size to pass it to
> dcache_by_line_op. Then the macro itsef computes the end by adding size
> to start.
> 
> Get rid of this massaging of parameters and change the macro to the end
> address as parameter directly.
> 
> Besides slightly simplyfing the code by remove two unneeded arithmetic
> operations, this makes the macro compatible with the current upstream
> version of Linux (which was similarly changed to take the end address in
> commit 163d3f80695e ("arm64: dcache_by_line_op to take end parameter
> instead of size")), which will allow us to reuse (part of) the Linux C
> wrappers over the assembly macro.
> 
> The change has been tested with the same snippet of code used to test
> commit 410b3bf09e76 ("arm/arm64: Perform dcache clean + invalidate after
> turning MMU off").
> 
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>

Reviewed-by: Nikos Nikoleris <nikos.nikoleris@arm.com>

Thanks,

Nikos

> ---
>   arm/cstart.S              |  1 -
>   arm/cstart64.S            |  1 -
>   lib/arm/asm/assembler.h   | 11 +++++------
>   lib/arm64/asm/assembler.h | 11 +++++------
>   4 files changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/arm/cstart.S b/arm/cstart.S
> index 39e70f40986a..096a77c454f4 100644
> --- a/arm/cstart.S
> +++ b/arm/cstart.S
> @@ -226,7 +226,6 @@ asm_mmu_disable:
>   	ldr	r0, [r0]
>   	ldr	r1, =__phys_end
>   	ldr	r1, [r1]
> -	sub	r1, r1, r0
>   	dcache_by_line_op dccimvac, sy, r0, r1, r2, r3
>   
>   	mov     pc, lr
> diff --git a/arm/cstart64.S b/arm/cstart64.S
> index 54773676d1d5..7cc90a9fa13f 100644
> --- a/arm/cstart64.S
> +++ b/arm/cstart64.S
> @@ -258,7 +258,6 @@ asm_mmu_disable:
>   	ldr	x0, [x0, :lo12:__phys_offset]
>   	adrp	x1, __phys_end
>   	ldr	x1, [x1, :lo12:__phys_end]
> -	sub	x1, x1, x0
>   	dcache_by_line_op civac, sy, x0, x1, x2, x3
>   
>   	ret
> diff --git a/lib/arm/asm/assembler.h b/lib/arm/asm/assembler.h
> index 4200252dd14d..db5f0f55027c 100644
> --- a/lib/arm/asm/assembler.h
> +++ b/lib/arm/asm/assembler.h
> @@ -25,17 +25,16 @@
>   
>   /*
>    * Macro to perform a data cache maintenance for the interval
> - * [addr, addr + size).
> + * [addr, end).
>    *
>    * 	op:		operation to execute
>    * 	domain		domain used in the dsb instruction
>    * 	addr:		starting virtual address of the region
> - * 	size:		size of the region
> - * 	Corrupts:	addr, size, tmp1, tmp2
> + * 	end:		the end of the region (non-inclusive)
> + * 	Corrupts:	addr, tmp1, tmp2
>    */
> -	.macro dcache_by_line_op op, domain, addr, size, tmp1, tmp2
> +	.macro dcache_by_line_op op, domain, addr, end, tmp1, tmp2
>   	dcache_line_size \tmp1, \tmp2
> -	add	\size, \addr, \size
>   	sub	\tmp2, \tmp1, #1
>   	bic	\addr, \addr, \tmp2
>   9998:
> @@ -45,7 +44,7 @@
>   	.err
>   	.endif
>   	add	\addr, \addr, \tmp1
> -	cmp	\addr, \size
> +	cmp	\addr, \end
>   	blo	9998b
>   	dsb	\domain
>   	.endm
> diff --git a/lib/arm64/asm/assembler.h b/lib/arm64/asm/assembler.h
> index aa8c65a2bb4a..1e09d65af4a7 100644
> --- a/lib/arm64/asm/assembler.h
> +++ b/lib/arm64/asm/assembler.h
> @@ -28,25 +28,24 @@
>   
>   /*
>    * Macro to perform a data cache maintenance for the interval
> - * [addr, addr + size). Use the raw value for the dcache line size because
> + * [addr, end). Use the raw value for the dcache line size because
>    * kvm-unit-tests has no concept of scheduling.
>    *
>    * 	op:		operation passed to dc instruction
>    * 	domain:		domain used in dsb instruction
>    * 	addr:		starting virtual address of the region
> - * 	size:		size of the region
> - * 	Corrupts:	addr, size, tmp1, tmp2
> + * 	end:		the end of the region (non-inclusive)
> + * 	Corrupts:	addr, tmp1, tmp2
>    */
>   
> -	.macro dcache_by_line_op op, domain, addr, size, tmp1, tmp2
> +	.macro dcache_by_line_op op, domain, addr, end, tmp1, tmp2
>   	raw_dcache_line_size \tmp1, \tmp2
> -	add	\size, \addr, \size
>   	sub	\tmp2, \tmp1, #1
>   	bic	\addr, \addr, \tmp2
>   9998:
>   	dc	\op, \addr
>   	add	\addr, \addr, \tmp1
> -	cmp	\addr, \size
> +	cmp	\addr, \end
>   	b.lo	9998b
>   	dsb	\domain
>   	.endm
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
