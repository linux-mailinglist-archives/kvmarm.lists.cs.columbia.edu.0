Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3370E344059
	for <lists+kvmarm@lfdr.de>; Mon, 22 Mar 2021 13:01:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B09784B331;
	Mon, 22 Mar 2021 08:01:26 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QwXIa2hji6d6; Mon, 22 Mar 2021 08:01:26 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E44144B326;
	Mon, 22 Mar 2021 08:01:24 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 876694B31A
 for <kvmarm@lists.cs.columbia.edu>; Mon, 22 Mar 2021 08:01:23 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b7TF5T-A-mEm for <kvmarm@lists.cs.columbia.edu>;
 Mon, 22 Mar 2021 08:01:21 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CF22E4B318
 for <kvmarm@lists.cs.columbia.edu>; Mon, 22 Mar 2021 08:01:21 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42ADA1063;
 Mon, 22 Mar 2021 05:01:21 -0700 (PDT)
Received: from [192.168.0.110] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 818BE3F718;
 Mon, 22 Mar 2021 05:01:20 -0700 (PDT)
Subject: Re: [kvm-unit-tests PATCH 2/6] arm/arm64: Remove dcache_line_size
 global variable
To: Andre Przywara <andre.przywara@arm.com>
References: <20210227104201.14403-1-alexandru.elisei@arm.com>
 <20210227104201.14403-3-alexandru.elisei@arm.com>
 <20210304150031.7805c75e@slackpad.fritz.box>
 <ce582839-edef-c055-b0a3-6261397b6b8d@arm.com>
 <20210316154002.3d9e0575@slackpad.fritz.box>
From: Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <96eaa6ab-a379-b69c-d813-9362477cd196@arm.com>
Date: Mon, 22 Mar 2021 12:01:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210316154002.3d9e0575@slackpad.fritz.box>
Content-Language: en-US
Cc: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org
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

Hi Andre,

On 3/16/21 3:40 PM, Andre Przywara wrote:
> On Mon, 15 Mar 2021 15:46:09 +0000
> Alexandru Elisei <alexandru.elisei@arm.com> wrote:
>
> Hi Alex,
>
>> On 3/4/21 3:00 PM, Andre Przywara wrote:
>>> On Sat, 27 Feb 2021 10:41:57 +0000
>>> Alexandru Elisei <alexandru.elisei@arm.com> wrote:
>>>  
>>>> Compute the dcache line size when doing dcache maintenance instead of using
>>>> a global variable computed in setup(), which allows us to do dcache
>>>> maintenance at any point in the boot process. This will be useful for
>>>> running as an EFI app and it also aligns our implementation to that of the
>>>> Linux kernel.  
>>> Can you add that this changes the semantic of dcache_by_line_op to use
>>> the size instead of the end address?  
>> Sure, I can do that. The dcache_by_line_op was never visible to code outside
>> assembly, and it was only used by asm_mmu_disable, so no other callers are
>> affected by this change.
> Thanks, just a short sentence suffices. I was just mentioning this
> since many cache-op wrappers I have seen use (start,stop) pairs, while
> I actually think (start,length) is more practical. So it just deserves
> a short mentioning in case anyone was familiar with the previous
> arguments and wonders what's going on.
>
>>>  
>>>> For consistency, the arm code has been similary modified.
>>>>
>>>> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
>>>> ---
>>>>  lib/arm/asm/assembler.h   | 44 ++++++++++++++++++++++++++++++++
>>>>  lib/arm/asm/processor.h   |  7 ------
>>>>  lib/arm64/asm/assembler.h | 53 +++++++++++++++++++++++++++++++++++++++
>>>>  lib/arm64/asm/processor.h |  7 ------
>>>>  lib/arm/setup.c           |  7 ------
>>>>  arm/cstart.S              | 18 +++----------
>>>>  arm/cstart64.S            | 16 ++----------
>>>>  7 files changed, 102 insertions(+), 50 deletions(-)
>>>>  create mode 100644 lib/arm/asm/assembler.h
>>>>  create mode 100644 lib/arm64/asm/assembler.h
>>>>
>>>> diff --git a/lib/arm/asm/assembler.h b/lib/arm/asm/assembler.h
>>>> new file mode 100644
>>>> index 000000000000..6b932df86204
>>>> --- /dev/null
>>>> +++ b/lib/arm/asm/assembler.h
>>>> @@ -0,0 +1,44 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>> +/*
>>>> + * Based on several files from Linux version v5.10: arch/arm/mm/proc-macros.S,
>>>> + * arch/arm/mm/proc-v7.S.
>>>> + */
>>>> +
>>>> +/*
>>>> + * dcache_line_size - get the minimum D-cache line size from the CTR register
>>> `> + * on ARMv7.  
>> Well, it's in the arm directory and there's a file with the same name under
>> lib/arm64/asm/, so I don't think there's any room for confusion here.
> Mmh, this v7 line was already in there, and I didn't complain, it was
> apparently just a stray character sneaking in the reply which made this
> look like a comment?

I guess so, my bad.

>
>>>> + */
>>>> +	.macro	dcache_line_size, reg, tmp
>>>> +	mrc	p15, 0, \tmp, c0, c0, 1		// read ctr
>>>> +	lsr	\tmp, \tmp, #16
>>>> +	and	\tmp, \tmp, #0xf		// cache line size encoding
>>>> +	mov	\reg, #4			// bytes per word
>>>> +	mov	\reg, \reg, lsl \tmp		// actual cache line size
>>>> +	.endm
>>>> +
>>>> +/*
>>>> + * Macro to perform a data cache maintenance for the interval
>>>> + * [addr, addr + size).
>>>> + *
>>>> + * 	op:		operation to execute
>>>> + * 	domain		domain used in the dsb instruction
>>>> + * 	addr:		starting virtual address of the region
>>>> + * 	size:		size of the region
>>>> + * 	Corrupts:	addr, size, tmp1, tmp2
>>>> + */
>>>> +	.macro dcache_by_line_op op, domain, addr, size, tmp1, tmp2
>>>> +	dcache_line_size \tmp1, \tmp2
>>>> +	add	\size, \addr, \size
>>>> +	sub	\tmp2, \tmp1, #1
>>>> +	bic	\addr, \addr, \tmp2  
>>> Just a nit, but since my brain was in assembly land: We could skip tmp2,
>>> by adding back #1 to tmp1 after the bic.
>>> Same for the arm64 code.  
>> Using one less temporary register wouldn't help with register pressure:
>>
>> - On arm, registers r0-r3 are used, which ARM IHI 0042F says that they can be used
>> as scratch registers and the caller will save their contents before the calling
>> the function (or not use them at all).
>>
>> - On arm64, register x0-x3 are used, which have a similar usage according to ARM
>> IHI 0055B.
>>
>> Using one less temporary register means one more instruction, but not relevant
>> since the macro will perform writes, as even invalidation is transformed to a
>> clean + invalidate under virtualization.
> I am not talking about micro-optimisation here, but this is a *macro*,
> not a function, so could potentially be used in multiple different
> places, for instance inside leaf functions. And maybe that already uses
> two registers on its own, so can't spare three extra ones?
>
> Was just a hint, anyway ...
>
>> The reason I chose to keep the macro unchanged for arm64 is that it matches the
>> Linux definition, and I think it's better to try not to deviate too much from it,
>> as in the long it will make maintenance easier for everyone.
>> For arm, I wrote it this way to match the arm64 definition.
>>
>>>  
>>>> +9998:
>>>> +	.ifc	\op, dccimvac
>>>> +	mcr	p15, 0, \addr, c7, c14, 1
>>>> +	.else
>>>> +	.err
>>>> +	.endif
>>>> +	add	\addr, \addr, \tmp1
>>>> +	cmp	\addr, \size
>>>> +	blo	9998b
>>>> +	dsb	\domain
>>>> +	.endm
>>>> diff --git a/lib/arm/asm/processor.h b/lib/arm/asm/processor.h
>>>> index 273366d1fe1c..3c36eac903f0 100644
>>>> --- a/lib/arm/asm/processor.h
>>>> +++ b/lib/arm/asm/processor.h
>>>> @@ -9,11 +9,6 @@
>>>>  #include <asm/sysreg.h>
>>>>  #include <asm/barrier.h>  
>>> Do we want the same protection against inclusion from C here as in the
>>> arm64 version?  
>> We do, I will add it in the next iteration.
>>
>>>  
>>>> -#define CTR_DMINLINE_SHIFT	16
>>>> -#define CTR_DMINLINE_MASK	(0xf << 16)
>>>> -#define CTR_DMINLINE(x)	\
>>>> -	(((x) & CTR_DMINLINE_MASK) >> CTR_DMINLINE_SHIFT)
>>>> -
>>>>  enum vector {
>>>>  	EXCPTN_RST,
>>>>  	EXCPTN_UND,
>>>> @@ -89,6 +84,4 @@ static inline u32 get_ctr(void)
>>>>  	return read_sysreg(CTR);
>>>>  }
>>>>  
>>>> -extern unsigned long dcache_line_size;
>>>> -
>>>>  #endif /* _ASMARM_PROCESSOR_H_ */
>>>> diff --git a/lib/arm64/asm/assembler.h b/lib/arm64/asm/assembler.h
>>>> new file mode 100644
>>>> index 000000000000..f801c0c43d02
>>>> --- /dev/null
>>>> +++ b/lib/arm64/asm/assembler.h
>>>> @@ -0,0 +1,53 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>>> +/*
>>>> + * Based on the file arch/arm64/include/asm/assembled.h from Linux v5.10, which
>>>> + * in turn is based on arch/arm/include/asm/assembler.h and
>>>> + * arch/arm/mm/proc-macros.S
>>>> + *
>>>> + * Copyright (C) 1996-2000 Russell King
>>>> + * Copyright (C) 2012 ARM Ltd.
>>>> + */
>>>> +#ifndef __ASSEMBLY__
>>>> +#error "Only include this from assembly code"
>>>> +#endif
>>>> +
>>>> +#ifndef __ASM_ASSEMBLER_H
>>>> +#define __ASM_ASSEMBLER_H
>>>> +
>>>> +/*
>>>> + * raw_dcache_line_size - get the minimum D-cache line size on this CPU
>>>> + * from the CTR register.
>>>> + */
>>>> +	.macro	raw_dcache_line_size, reg, tmp
>>>> +	mrs	\tmp, ctr_el0			// read CTR
>>>> +	ubfm	\tmp, \tmp, #16, #19		// cache line size encoding  
>>> this encoding of ubfm is supposed to be written as:
>>> 	ubfx \tmp, \tmp, #16, #4
>>> This is also what objdump makes of the above.  
>> I would rather keep it the same as Linux.
> Which means I need to send a patch there? ;-)

Only if you want to try to convince people that ubfx is better than ubfm :)

> I am all for copying from reliable sources, but that doesn't mean that
> we can't improve on them.
>
> The ARM ARM says that ubfx is the preferred disassembly for this opcode.
> Plus there is a ubfx in AArch32 (with the exact same semantic and
> arguments), but no ubfm.
>
> It's just that my brain expects ubfx when extracting bits from a
> register, and I needed to wade through the exact definition of ubfm to
> understand what it does.
>
> So your choice, just wanted to point that out.

I think you've convinced me. I'm also more familiar with ubfx, the Arm ARM says
that ubfm is usually accessed via one of its aliases, and Linux seems to be moving
away from using ubfm (the only instances that I've found were
{raw_,}dcache_line_size which are very old, I think from the initial arm64
architecture enablement). I'll use ubfx instead.

Thanks,

Alex

>
> Cheers,
> Andre
>
>>> The rest looks good, I convinced myself that the assembly algorithms are
>>> correct.  
>> Thanks, much appreciated!
>>
>> Thanks,
>>
>> Alex
>>
>>> Cheers,
>>> Andre
>>>
>>>  
>>>> +	mov	\reg, #4			// bytes per word
>>>> +	lsl	\reg, \reg, \tmp		// actual cache line size
>>>> +	.endm
>>>> +
>>>> +/*
>>>> + * Macro to perform a data cache maintenance for the interval
>>>> + * [addr, addr + size). Use the raw value for the dcache line size because
>>>> + * kvm-unit-tests has no concept of scheduling.
>>>> + *
>>>> + * 	op:		operation passed to dc instruction
>>>> + * 	domain:		domain used in dsb instruciton
>>>> + * 	addr:		starting virtual address of the region
>>>> + * 	size:		size of the region
>>>> + * 	Corrupts:	addr, size, tmp1, tmp2
>>>> + */
>>>> +
>>>> +	.macro dcache_by_line_op op, domain, addr, size, tmp1, tmp2
>>>> +	raw_dcache_line_size \tmp1, \tmp2
>>>> +	add	\size, \addr, \size
>>>> +	sub	\tmp2, \tmp1, #1
>>>> +	bic	\addr, \addr, \tmp2
>>>> +9998:
>>>> +	dc	\op, \addr
>>>> +	add	\addr, \addr, \tmp1
>>>> +	cmp	\addr, \size
>>>> +	b.lo	9998b
>>>> +	dsb	\domain
>>>> +	.endm
>>>> +
>>>> +#endif	/* __ASM_ASSEMBLER_H */
>>>> diff --git a/lib/arm64/asm/processor.h b/lib/arm64/asm/processor.h
>>>> index 771b2d1e0c94..cdc2463e1981 100644
>>>> --- a/lib/arm64/asm/processor.h
>>>> +++ b/lib/arm64/asm/processor.h
>>>> @@ -16,11 +16,6 @@
>>>>  #define SCTLR_EL1_A	(1 << 1)
>>>>  #define SCTLR_EL1_M	(1 << 0)
>>>>  
>>>> -#define CTR_DMINLINE_SHIFT	16
>>>> -#define CTR_DMINLINE_MASK	(0xf << 16)
>>>> -#define CTR_DMINLINE(x)	\
>>>> -	(((x) & CTR_DMINLINE_MASK) >> CTR_DMINLINE_SHIFT)
>>>> -
>>>>  #ifndef __ASSEMBLY__
>>>>  #include <asm/ptrace.h>
>>>>  #include <asm/esr.h>
>>>> @@ -115,8 +110,6 @@ static inline u64 get_ctr(void)
>>>>  	return read_sysreg(ctr_el0);
>>>>  }
>>>>  
>>>> -extern unsigned long dcache_line_size;
>>>> -
>>>>  static inline unsigned long get_id_aa64mmfr0_el1(void)
>>>>  {
>>>>  	return read_sysreg(id_aa64mmfr0_el1);
>>>> diff --git a/lib/arm/setup.c b/lib/arm/setup.c
>>>> index 066524f8bf61..751ba980000a 100644
>>>> --- a/lib/arm/setup.c
>>>> +++ b/lib/arm/setup.c
>>>> @@ -42,8 +42,6 @@ static struct mem_region __initial_mem_regions[NR_INITIAL_MEM_REGIONS + 1];
>>>>  struct mem_region *mem_regions = __initial_mem_regions;
>>>>  phys_addr_t __phys_offset, __phys_end;
>>>>  
>>>> -unsigned long dcache_line_size;
>>>> -
>>>>  int mpidr_to_cpu(uint64_t mpidr)
>>>>  {
>>>>  	int i;
>>>> @@ -72,11 +70,6 @@ static void cpu_init(void)
>>>>  	ret = dt_for_each_cpu_node(cpu_set, NULL);
>>>>  	assert(ret == 0);
>>>>  	set_cpu_online(0, true);
>>>> -	/*
>>>> -	 * DminLine is log2 of the number of words in the smallest cache line; a
>>>> -	 * word is 4 bytes.
>>>> -	 */
>>>> -	dcache_line_size = 1 << (CTR_DMINLINE(get_ctr()) + 2);
>>>>  }
>>>>  
>>>>  unsigned int mem_region_get_flags(phys_addr_t paddr)
>>>> diff --git a/arm/cstart.S b/arm/cstart.S
>>>> index ef936ae2f874..954748b00f64 100644
>>>> --- a/arm/cstart.S
>>>> +++ b/arm/cstart.S
>>>> @@ -7,6 +7,7 @@
>>>>   */
>>>>  #define __ASSEMBLY__
>>>>  #include <auxinfo.h>
>>>> +#include <asm/assembler.h>
>>>>  #include <asm/thread_info.h>
>>>>  #include <asm/asm-offsets.h>
>>>>  #include <asm/pgtable-hwdef.h>
>>>> @@ -197,20 +198,6 @@ asm_mmu_enable:
>>>>  
>>>>  	mov     pc, lr
>>>>  
>>>> -.macro dcache_clean_inval domain, start, end, tmp1, tmp2
>>>> -	ldr	\tmp1, =dcache_line_size
>>>> -	ldr	\tmp1, [\tmp1]
>>>> -	sub	\tmp2, \tmp1, #1
>>>> -	bic	\start, \start, \tmp2
>>>> -9998:
>>>> -	/* DCCIMVAC */
>>>> -	mcr	p15, 0, \start, c7, c14, 1
>>>> -	add	\start, \start, \tmp1
>>>> -	cmp	\start, \end
>>>> -	blo	9998b
>>>> -	dsb	\domain
>>>> -.endm
>>>> -
>>>>  .globl asm_mmu_disable
>>>>  asm_mmu_disable:
>>>>  	/* SCTLR */
>>>> @@ -223,7 +210,8 @@ asm_mmu_disable:
>>>>  	ldr	r0, [r0]
>>>>  	ldr	r1, =__phys_end
>>>>  	ldr	r1, [r1]
>>>> -	dcache_clean_inval sy, r0, r1, r2, r3
>>>> +	sub	r1, r1, r0
>>>> +	dcache_by_line_op dccimvac, sy, r0, r1, r2, r3
>>>>  	isb
>>>>  
>>>>  	mov     pc, lr
>>>> diff --git a/arm/cstart64.S b/arm/cstart64.S
>>>> index fc1930bcdb53..046bd3914098 100644
>>>> --- a/arm/cstart64.S
>>>> +++ b/arm/cstart64.S
>>>> @@ -8,6 +8,7 @@
>>>>  #define __ASSEMBLY__
>>>>  #include <auxinfo.h>
>>>>  #include <asm/asm-offsets.h>
>>>> +#include <asm/assembler.h>
>>>>  #include <asm/ptrace.h>
>>>>  #include <asm/processor.h>
>>>>  #include <asm/page.h>
>>>> @@ -204,20 +205,6 @@ asm_mmu_enable:
>>>>  
>>>>  	ret
>>>>  
>>>> -/* Taken with small changes from arch/arm64/incluse/asm/assembler.h */
>>>> -.macro dcache_by_line_op op, domain, start, end, tmp1, tmp2
>>>> -	adrp	\tmp1, dcache_line_size
>>>> -	ldr	\tmp1, [\tmp1, :lo12:dcache_line_size]
>>>> -	sub	\tmp2, \tmp1, #1
>>>> -	bic	\start, \start, \tmp2
>>>> -9998:
>>>> -	dc	\op , \start
>>>> -	add	\start, \start, \tmp1
>>>> -	cmp	\start, \end
>>>> -	b.lo	9998b
>>>> -	dsb	\domain
>>>> -.endm
>>>> -
>>>>  .globl asm_mmu_disable
>>>>  asm_mmu_disable:
>>>>  	mrs	x0, sctlr_el1
>>>> @@ -230,6 +217,7 @@ asm_mmu_disable:
>>>>  	ldr	x0, [x0, :lo12:__phys_offset]
>>>>  	adrp	x1, __phys_end
>>>>  	ldr	x1, [x1, :lo12:__phys_end]
>>>> +	sub	x1, x1, x0
>>>>  	dcache_by_line_op civac, sy, x0, x1, x2, x3
>>>>  	isb
>>>>    
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
