Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 782CA3E8393
	for <lists+kvmarm@lfdr.de>; Tue, 10 Aug 2021 21:22:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 114F149FB7;
	Tue, 10 Aug 2021 15:22:04 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@gmail.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Wj13CbDn9Dxd; Tue, 10 Aug 2021 15:21:59 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A10354A4C0;
	Tue, 10 Aug 2021 15:21:56 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 40E6D49FB7
 for <kvmarm@lists.cs.columbia.edu>; Tue, 10 Aug 2021 15:21:56 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GL8el-I+ohUL for <kvmarm@lists.cs.columbia.edu>;
 Tue, 10 Aug 2021 15:21:51 -0400 (EDT)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com
 [209.85.167.180])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D95F7402DB
 for <kvmarm@lists.cs.columbia.edu>; Tue, 10 Aug 2021 15:21:51 -0400 (EDT)
Received: by mail-oi1-f180.google.com with SMTP id bi32so678609oib.2
 for <kvmarm@lists.cs.columbia.edu>; Tue, 10 Aug 2021 12:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=KAarKHT0m3MJ2O9D6qLLI1k9iEOlT/tM9BSCUbuRaoM=;
 b=Tz8cUBsx8ilYPTAqokUk3hy5ggYRuO8tc9Poy5urwAq0JoCBrzpxBYXSoEbKNUGFN5
 LJHV7Y/Rfuuw2pMsiwoNt2CgjP5JG6SUmW4JT1oBcQLnFglpNdXmRZXFOC2TaFSSpzjv
 xoPMLiVw6FgJbdcjqpFPvHgUgNcwTRSMaW0NENjzrP7yTjFu83k0kTdjC7xFiL5cbPed
 NRMD14yFkha2+DR1Wkkqk/YmaAjJklYTeCdTavWo2Fb6kZr1HA7slrPG/6n8FENo0TNn
 udeRFqfaSXzwL+15UlKeMxfUHCSioFu7eflrwGwB/h5wWwsOEtIwrZyThVK4Q6VlMzAn
 tKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KAarKHT0m3MJ2O9D6qLLI1k9iEOlT/tM9BSCUbuRaoM=;
 b=rOE8p63hNUiPVKsncAySE3Vxag0RrzDMbYXCmxEfrLal1eO+B20K2WScSXOtgbYAn6
 JGyul8T0RZhauGhYi2+iLOfD9e29hCMFSpVSbPOXKudnP3kDEdOArpb5cZWKNkQGsZVv
 htP5+kTEQhyyysEbPUJABzvaS6RpBCv6wTH/o1n2sjNipf1Di5GXdcMR0R8JrH6Q0ehq
 dCJpfC2XSN31R3AhSkNqifeDStzoOb9LPILp0i39sgIsMkQOYbopHf2c6z+4IoHCHHL9
 17nJqH6xjc/Ar1krH0/ERIzw4aMdVZSZYbhRP5CpM3Mij49sRdSq3oCxrjqyJPY9jqpf
 62Ag==
X-Gm-Message-State: AOAM5311tA2qgZepqsPnETdbEzhQPy+pShjyejBDtBwgYxg29MU5m2BH
 HaAMOP5qT5alQ6DNAslyNc4=
X-Google-Smtp-Source: ABdhPJwKep9KddVoYjOL1882ESwbTAv/JqcCb93BOr2zZaD0Lh8+HcI4C99dC3rYzVoJQsss4q7qLA==
X-Received: by 2002:aca:1b11:: with SMTP id b17mr4836676oib.158.1628623311215; 
 Tue, 10 Aug 2021 12:21:51 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 j2sm1009805oia.21.2021.08.10.12.21.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Aug 2021 12:21:50 -0700 (PDT)
Subject: Re: [PATCH v3] memblock: make memblock_find_in_range method private
To: Mike Rapoport <rppt@kernel.org>
References: <20210803064218.6611-1-rppt@kernel.org>
 <20210809190641.GA1176508@roeck-us.net> <YRLLpImNhZaLzs3z@kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <7db20940-cbd9-e900-db28-774c5782601c@roeck-us.net>
Date: Tue, 10 Aug 2021 12:21:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRLLpImNhZaLzs3z@kernel.org>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, "H. Peter Anvin" <hpa@zytor.com>,
 linux-riscv@lists.infradead.org, Frank Rowand <frowand.list@gmail.com>,
 kvmarm@lists.cs.columbia.edu, linux-s390@vger.kernel.org,
 Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, Marc Zyngier <maz@kernel.org>,
 x86@kernel.org, Russell King <linux@armlinux.org.uk>,
 Mike Rapoport <rppt@linux.ibm.com>, linux-acpi@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Len Brown <lenb@kernel.org>,
 devicetree@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
 Will Deacon <will@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
 Rob Herring <robh+dt@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 "Kirill A. Shutemov" <kirill@shutemov.name>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-mips@vger.kernel.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Andrew Morton <akpm@linux-foundation.org>
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

On 8/10/21 11:55 AM, Mike Rapoport wrote:
> On Mon, Aug 09, 2021 at 12:06:41PM -0700, Guenter Roeck wrote:
>> On Tue, Aug 03, 2021 at 09:42:18AM +0300, Mike Rapoport wrote:
>>> From: Mike Rapoport <rppt@linux.ibm.com>
>>>
>>> There are a lot of uses of memblock_find_in_range() along with
>>> memblock_reserve() from the times memblock allocation APIs did not exist.
>>>
>>> memblock_find_in_range() is the very core of memblock allocations, so any
>>> future changes to its internal behaviour would mandate updates of all the
>>> users outside memblock.
>>>
>>> Replace the calls to memblock_find_in_range() with an equivalent calls to
>>> memblock_phys_alloc() and memblock_phys_alloc_range() and make
>>> memblock_find_in_range() private method of memblock.
>>>
>>> This simplifies the callers, ensures that (unlikely) errors in
>>> memblock_reserve() are handled and improves maintainability of
>>> memblock_find_in_range().
>>>
>>> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
>>
>> I see a number of crashes in next-20210806 when booting x86 images from efi.
>>
>> [    0.000000] efi: EFI v2.70 by EDK II
>> [    0.000000] efi: SMBIOS=0x1fbcc000 ACPI=0x1fbfa000 ACPI 2.0=0x1fbfa014 MEMATTR=0x1f25f018
>> [    0.000000] SMBIOS 2.8 present.
>> [    0.000000] DMI: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
>> [    0.000000] last_pfn = 0x1ff50 max_arch_pfn = 0x400000000
>> [    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
>> [    0.000000] Kernel panic - not syncing: alloc_low_pages: can not alloc memory
>> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.14.0-rc4-next-20210806 #1
>> [    0.000000] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
>> [    0.000000] Call Trace:
>> [    0.000000]  ? dump_stack_lvl+0x57/0x7d
>> [    0.000000]  ? panic+0xfc/0x2c6
>> [    0.000000]  ? alloc_low_pages+0x117/0x156
>> [    0.000000]  ? phys_pmd_init+0x234/0x342
>> [    0.000000]  ? phys_pud_init+0x171/0x337
>> [    0.000000]  ? __kernel_physical_mapping_init+0xec/0x276
>> [    0.000000]  ? init_memory_mapping+0x1ea/0x2aa
>> [    0.000000]  ? init_range_memory_mapping+0xdf/0x12e
>> [    0.000000]  ? init_mem_mapping+0x1e9/0x26f
>> [    0.000000]  ? setup_arch+0x5ff/0xb6d
>> [    0.000000]  ? start_kernel+0x71/0x6b4
>> [    0.000000]  ? secondary_startup_64_no_verify+0xc2/0xcb
>>
>> Bisect points to this patch. Reverting it fixes the problem. Key seems to
>> be the amount of memory configured in qemu; the problem is not seen if
>> there is 1G or more of memory, but it is seen with all test boots with
>> 512M or 256M of memory. It is also seen with almost all 32-bit efi boots.
>>
>> The problem is not seen when booting without efi.
> 
> It looks like this change uncovered a problem in
> x86::memory_map_top_down().
> 
> The allocation in alloc_low_pages() is limited by min_pfn_mapped and
> max_pfn_mapped. The min_pfn_mapped is updated at every iteration of the
> loop in memory_map_top_down, but there is another loop in
> init_range_memory_mapping() that maps several regions below the current
> min_pfn_mapped without updating this variable.
> 
> The memory layout in qemu with 256M of RAM and EFI enabled, causes
> exhaustion of the memory limited by min_pfn_mapped and max_pfn_mapped
> before min_pfn_mapped is updated.
> 
> Before this commit there was unconditional "reservation" of 2M in the end
> of the memory that moved the initial min_pfn_mapped below the memory
> reserved by EFI. The addition of check for xen_domain() removed this
> reservation for !XEN and made alloc_low_pages() use the range already busy
> with EFI data.
> 
> The patch below moves the update of min_pfn_mapped near the update of
> max_pfn_mapped so that every time a new range is mapped both limits will be
> updated accordingly.
> 
> diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
> index 1152a29ce109..be279f6e5a0a 100644
> --- a/arch/x86/mm/init.c
> +++ b/arch/x86/mm/init.c
> @@ -1,3 +1,4 @@
> +#define DEBUG
>   #include <linux/gfp.h>
>   #include <linux/initrd.h>
>   #include <linux/ioport.h>
> @@ -485,6 +486,7 @@ static void add_pfn_range_mapped(unsigned long start_pfn, unsigned long end_pfn)
>   	nr_pfn_mapped = clean_sort_range(pfn_mapped, E820_MAX_ENTRIES);
>   
>   	max_pfn_mapped = max(max_pfn_mapped, end_pfn);
> +	min_pfn_mapped = min(min_pfn_mapped, start_pfn);
>   
>   	if (start_pfn < (1UL<<(32-PAGE_SHIFT)))
>   		max_low_pfn_mapped = max(max_low_pfn_mapped,
> @@ -643,7 +645,6 @@ static void __init memory_map_top_down(unsigned long map_start,
>   		mapped_ram_size += init_range_memory_mapping(start,
>   							last_start);
>   		last_start = start;
> -		min_pfn_mapped = last_start >> PAGE_SHIFT;
>   		if (mapped_ram_size >= step_size)
>   			step_size = get_new_step_size(step_size);
>   	}
>   

The offending patch was removed from next-20210810, but I applied the above change
to next-20210809 and it does indeed fix the problem. If it is added as separate patch,
please feel free to add

Tested-by: Guenter Roeck <linux@roeck-us.net>

Thanks,
Guenter
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
