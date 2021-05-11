Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7A41437B6CD
	for <lists+kvmarm@lfdr.de>; Wed, 12 May 2021 09:23:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C928C4B3B1;
	Wed, 12 May 2021 03:23:42 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@linux-foundation.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YfDSsx-vhWLq; Wed, 12 May 2021 03:23:42 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 80E894B833;
	Wed, 12 May 2021 03:23:41 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 47A0E4B557
 for <kvmarm@lists.cs.columbia.edu>; Tue, 11 May 2021 19:40:05 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8CdvPrFhndHU for <kvmarm@lists.cs.columbia.edu>;
 Tue, 11 May 2021 19:40:04 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 013EC4B1CF
 for <kvmarm@lists.cs.columbia.edu>; Tue, 11 May 2021 19:40:03 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id CEB36616ED;
 Tue, 11 May 2021 23:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
 s=korg; t=1620776402;
 bh=StGQ4zZ+sG3aVDQn1MpkpljgXREKqD6fxuaBEDSUudw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=hLUpIpjSxwdX1nAVP+N0LVLY1lMcui+/l5k4s7PPY993iDcrCDJiORv58ridgFjWj
 wF7Xs+ficCdWvf9n3xE8QH0AX1CndZ8jg99pk6I8kkslLGbrhvNIDIvE8Ao0cNHD9I
 umVQBDkgO0C86yyC8U/o7/4epynrz7QOojArhONg=
Date: Tue, 11 May 2021 16:40:01 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v4 4/4] arm64: drop pfn_valid_within() and simplify
 pfn_valid()
Message-Id: <20210511164001.7e905659fdbb8a5e190d303a@linux-foundation.org>
In-Reply-To: <20210511100550.28178-5-rppt@kernel.org>
References: <20210511100550.28178-1-rppt@kernel.org>
 <20210511100550.28178-5-rppt@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-Mailman-Approved-At: Wed, 12 May 2021 03:23:40 -0400
Cc: David Hildenbrand <david@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, linux-kernel@vger.kernel.org,
 Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org,
 kvmarm@lists.cs.columbia.edu, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
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

On Tue, 11 May 2021 13:05:50 +0300 Mike Rapoport <rppt@kernel.org> wrote:

> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> The arm64's version of pfn_valid() differs from the generic because of two
> reasons:
> 
> * Parts of the memory map are freed during boot. This makes it necessary to
>   verify that there is actual physical memory that corresponds to a pfn
>   which is done by querying memblock.
> 
> * There are NOMAP memory regions. These regions are not mapped in the
>   linear map and until the previous commit the struct pages representing
>   these areas had default values.
> 
> As the consequence of absence of the special treatment of NOMAP regions in
> the memory map it was necessary to use memblock_is_map_memory() in
> pfn_valid() and to have pfn_valid_within() aliased to pfn_valid() so that
> generic mm functionality would not treat a NOMAP page as a normal page.
> 
> Since the NOMAP regions are now marked as PageReserved(), pfn walkers and
> the rest of core mm will treat them as unusable memory and thus
> pfn_valid_within() is no longer required at all and can be disabled by
> removing CONFIG_HOLES_IN_ZONE on arm64.
> 
> pfn_valid() can be slightly simplified by replacing
> memblock_is_map_memory() with memblock_is_memory().
> 
> ...
>
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1052,9 +1052,6 @@ config NEED_PER_CPU_EMBED_FIRST_CHUNK
>  	def_bool y
>  	depends on NUMA
>  
> -config HOLES_IN_ZONE
> -	def_bool y
> -
>  source "kernel/Kconfig.hz"
>  
>  config ARCH_SPARSEMEM_ENABLE

https://lkml.kernel.org/r/20210417075946.181402-1-wangkefeng.wang@huawei.com
already did this, so I simply dropped that hunk?  And I don't think the
changelog needs updating for this?


> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 798f74f501d5..fb07218da2c0 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -251,7 +251,7 @@ int pfn_valid(unsigned long pfn)
>  	if (!early_section(ms))
>  		return pfn_section_valid(ms, pfn);
>  
> -	return memblock_is_map_memory(addr);
> +	return memblock_is_memory(addr);
>  }
>  EXPORT_SYMBOL(pfn_valid);

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
