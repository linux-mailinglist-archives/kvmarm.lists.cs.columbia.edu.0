Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 59FBE37B808
	for <lists+kvmarm@lfdr.de>; Wed, 12 May 2021 10:32:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DA2674B365;
	Wed, 12 May 2021 04:32:17 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DaKc+3UJNOiv; Wed, 12 May 2021 04:32:17 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 72B4A4B572;
	Wed, 12 May 2021 04:32:16 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C6C864B37A
 for <kvmarm@lists.cs.columbia.edu>; Wed, 12 May 2021 04:32:14 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U0ImUZXDqsg1 for <kvmarm@lists.cs.columbia.edu>;
 Wed, 12 May 2021 04:32:13 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 4ED084B365
 for <kvmarm@lists.cs.columbia.edu>; Wed, 12 May 2021 04:32:13 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id D7764611CE;
 Wed, 12 May 2021 08:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620808332;
 bh=kGPdN86b0Oq5p5oLcXPvPWzKj3IOJoZBJavrii5GWJY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=u1W34uKaeHf+2TfWF+yKruaaxLBevPABgP3RFO+ihcQRfaQWyQMLywPoJSxZ15e5A
 A+ZxEiWJ8lqLT/nh8LkxANdYWeNVcjbDVL52jt0gHwdHZOS4G1TFXASmfA/oDZ7agt
 PhRu+0VONPTYTzDkJwnftRawjodjzxYGidMGhEjt9yRU9H+jtjGoCTlod+OJnq+wca
 11YeCdeNn8hWNAKihi0F3K865gkPlsUdThT2lOoK5R9zwC9O8I478n648PydiIRat/
 cFltwBimFJJjk6SnaBYU9LdxCN9h3S8WYLeeyIQDqH6hCskx1ho2me2wvgtGocUr+L
 0Kq+xkW4AbCkg==
Date: Wed, 12 May 2021 11:32:02 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v4 0/4] arm64: drop pfn_valid_within() and simplify
 pfn_valid()
Message-ID: <YJuSgvpjgV+E9WGE@kernel.org>
References: <20210511100550.28178-1-rppt@kernel.org>
 <CAMj1kXFHLkmgZKEb8BtgGt6GQ93Qd+yv6NtiCvtgX0ex9wSeyw@mail.gmail.com>
 <YJuE5O8nWNc1TGZ6@linux.ibm.com>
 <CAMj1kXE3G5v=1HFvGoW9weArBLpR_rDyAj0TZxTsZfdrNfgpyw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMj1kXE3G5v=1HFvGoW9weArBLpR_rDyAj0TZxTsZfdrNfgpyw@mail.gmail.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 David Hildenbrand <david@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Mike Rapoport <rppt@linux.ibm.com>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Marc Zyngier <maz@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Will Deacon <will@kernel.org>, kvmarm <kvmarm@lists.cs.columbia.edu>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
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

On Wed, May 12, 2021 at 09:59:33AM +0200, Ard Biesheuvel wrote:
> On Wed, 12 May 2021 at 09:34, Mike Rapoport <rppt@linux.ibm.com> wrote:
> >
> > On Wed, May 12, 2021 at 09:00:02AM +0200, Ard Biesheuvel wrote:
> > > On Tue, 11 May 2021 at 12:05, Mike Rapoport <rppt@kernel.org> wrote:
> > > >
> > > > From: Mike Rapoport <rppt@linux.ibm.com>
> > > >
> > > > Hi,
> > > >
> > > > These patches aim to remove CONFIG_HOLES_IN_ZONE and essentially hardwire
> > > > pfn_valid_within() to 1.
> > > >
> > > > The idea is to mark NOMAP pages as reserved in the memory map and restore
> > > > the intended semantics of pfn_valid() to designate availability of struct
> > > > page for a pfn.
> > > >
> > > > With this the core mm will be able to cope with the fact that it cannot use
> > > > NOMAP pages and the holes created by NOMAP ranges within MAX_ORDER blocks
> > > > will be treated correctly even without the need for pfn_valid_within.
> > > >
> > > > The patches are boot tested on qemu-system-aarch64.
> > > >
> > >
> > > Did you use EFI boot when testing this? The memory map is much more
> > > fragmented in that case, so this would be a good data point.
> >
> > Right, something like this:
> >
> 
> Yes, although it is not always that bad.
> 
> > [    0.000000] Early memory node ranges
> > [    0.000000]   node   0: [mem 0x0000000040000000-0x00000000ffffbfff]
> > [    0.000000]   node   0: [mem 0x00000000ffffc000-0x00000000ffffffff]
> 
> This is allocated below 4 GB by the firmware, for reasons that are
> only valid on x86 (where some of the early boot chain is IA32 only)
> 
> > [    0.000000]   node   0: [mem 0x0000000100000000-0x00000004386fffff]
> > [    0.000000]   node   0: [mem 0x0000000438700000-0x000000043899ffff]
> > [    0.000000]   node   0: [mem 0x00000004389a0000-0x00000004389bffff]
> > [    0.000000]   node   0: [mem 0x00000004389c0000-0x0000000438b5ffff]
> > [    0.000000]   node   0: [mem 0x0000000438b60000-0x000000043be3ffff]
> > [    0.000000]   node   0: [mem 0x000000043be40000-0x000000043becffff]
> > [    0.000000]   node   0: [mem 0x000000043bed0000-0x000000043bedffff]
> > [    0.000000]   node   0: [mem 0x000000043bee0000-0x000000043bffffff]
> > [    0.000000]   node   0: [mem 0x000000043c000000-0x000000043fffffff]
> >
> > This is a pity really, because I don't see a fundamental reason for those
> > tiny holes all over the place.
> >
> 
> There is a config option in the firmware build that allows these
> regions to be preallocated using larger windows, which greatly reduces
> the fragmentation.
> > I know that EFI/ACPI mandates "IO style" memory access for those regions,
> > but I fail to get why...
> >
> 
> Not sure what you mean by 'IO style memory access'.
 
Well, my understanding is that the memory reserved by the firmware cannot
be mapped in the linear map because it might require different caching
modes (e.g like IO) and arm64 cannot tolerate aliased mappings with
different caching.
But what evades me is *why* these areas cannot be accessed as normal RAM.
 
> > > > I beleive it would be best to route these via mmotm tree.
> > > >
> > > > v4:
> > > > * rebase on v5.13-rc1
> > > >
> > > > v3: Link: https://lore.kernel.org/lkml/20210422061902.21614-1-rppt@kernel.org
> > > > * Fix minor issues found by Anshuman
> > > > * Freshen up the declaration of pfn_valid() to make it consistent with
> > > >   pfn_is_map_memory()
> > > > * Add more Acked-by and Reviewed-by tags, thanks Anshuman and David
> > > >
> > > > v2: Link: https://lore.kernel.org/lkml/20210421065108.1987-1-rppt@kernel.org
> > > > * Add check for PFN overflow in pfn_is_map_memory()
> > > > * Add Acked-by and Reviewed-by tags, thanks David.
> > > >
> > > > v1: Link: https://lore.kernel.org/lkml/20210420090925.7457-1-rppt@kernel.org
> > > > * Add comment about the semantics of pfn_valid() as Anshuman suggested
> > > > * Extend comments about MEMBLOCK_NOMAP, per Anshuman
> > > > * Use pfn_is_map_memory() name for the exported wrapper for
> > > >   memblock_is_map_memory(). It is still local to arch/arm64 in the end
> > > >   because of header dependency issues.
> > > >
> > > > rfc: Link: https://lore.kernel.org/lkml/20210407172607.8812-1-rppt@kernel.org
> > > >
> > > > Mike Rapoport (4):
> > > >   include/linux/mmzone.h: add documentation for pfn_valid()
> > > >   memblock: update initialization of reserved pages
> > > >   arm64: decouple check whether pfn is in linear map from pfn_valid()
> > > >   arm64: drop pfn_valid_within() and simplify pfn_valid()
> > > >
> > > >  arch/arm64/Kconfig              |  3 ---
> > > >  arch/arm64/include/asm/memory.h |  2 +-
> > > >  arch/arm64/include/asm/page.h   |  3 ++-
> > > >  arch/arm64/kvm/mmu.c            |  2 +-
> > > >  arch/arm64/mm/init.c            | 14 +++++++++++++-
> > > >  arch/arm64/mm/ioremap.c         |  4 ++--
> > > >  arch/arm64/mm/mmu.c             |  2 +-
> > > >  include/linux/memblock.h        |  4 +++-
> > > >  include/linux/mmzone.h          | 11 +++++++++++
> > > >  mm/memblock.c                   | 28 ++++++++++++++++++++++++++--
> > > >  10 files changed, 60 insertions(+), 13 deletions(-)
> > > >
> > > >
> > > > base-commit: 6efb943b8616ec53a5e444193dccf1af9ad627b5
> > > > --
> > > > 2.28.0
> > > >
> >
> > --
> > Sincerely yours,
> > Mike.

-- 
Sincerely yours,
Mike.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
