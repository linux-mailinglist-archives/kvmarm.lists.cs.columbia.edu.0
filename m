Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id F3919372F0F
	for <lists+kvmarm@lfdr.de>; Tue,  4 May 2021 19:40:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 19F1C4B528;
	Tue,  4 May 2021 13:40:30 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DyHaWk5drR9N; Tue,  4 May 2021 13:40:29 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B509D4B2D5;
	Tue,  4 May 2021 13:40:28 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E71DD4B2CF
 for <kvmarm@lists.cs.columbia.edu>; Tue,  4 May 2021 13:40:26 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4Yo9WoDmXNMr for <kvmarm@lists.cs.columbia.edu>;
 Tue,  4 May 2021 13:40:25 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 827C64B2CD
 for <kvmarm@lists.cs.columbia.edu>; Tue,  4 May 2021 13:40:25 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B4F6613CB;
 Tue,  4 May 2021 17:40:21 +0000 (UTC)
Date: Tue, 4 May 2021 18:40:18 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v11 2/6] arm64: kvm: Introduce MTE VM feature
Message-ID: <YJGHApOCXl811VK3@arm.com>
References: <20210416154309.22129-1-steven.price@arm.com>
 <20210416154309.22129-3-steven.price@arm.com>
 <20210428170705.GB4022@arm.com>
 <c3293d47-a5f2-ea4a-6730-f5cae26d8a7e@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c3293d47-a5f2-ea4a-6730-f5cae26d8a7e@arm.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 Marc Zyngier <maz@kernel.org>, Juan Quintela <quintela@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, linux-kernel@vger.kernel.org,
 Dave Martin <Dave.Martin@arm.com>, linux-arm-kernel@lists.infradead.org,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
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

On Thu, Apr 29, 2021 at 05:06:41PM +0100, Steven Price wrote:
> On 28/04/2021 18:07, Catalin Marinas wrote:
> > I probably asked already but is the only way to map a standard RAM page
> > (not device) in stage 2 via the fault handler? One case I had in mind
> > was something like get_user_pages() but it looks like that one doesn't
> > call set_pte_at_notify(). There are a few other places where
> > set_pte_at_notify() is called and these may happen before we got a
> > chance to fault on stage 2, effectively populating the entry (IIUC). If
> > that's an issue, we could move the above loop and check closer to the
> > actual pte setting like kvm_pgtable_stage2_map().
> 
> The only call sites of kvm_pgtable_stage2_map() are in mmu.c:
> 
>  * kvm_phys_addr_ioremap() - maps as device in stage 2
> 
>  * user_mem_abort() - handled above
> 
>  * kvm_set_spte_handler() - ultimately called from the .change_pte()
> callback of the MMU notifier
> 
> So the last one is potentially a problem. It's called via the MMU notifiers
> in the case of set_pte_at_notify(). The users of that are:
> 
>  * uprobe_write_opcode(): Allocates a new page and performs a
> copy_highpage() to copy the data to the new page (which with MTE includes
> the tags and will copy across the PG_mte_tagged flag).
> 
>  * write_protect_page() (KSM): Changes the permissions on the PTE but it's
> still the same page, so nothing to do regarding MTE.

My concern here is that the VMM had a stage 1 pte but we haven't yet
faulted in at stage 2 via user_mem_abort(), so we don't have any stage 2
pte set. write_protect_page() comes in and sets the new stage 2 pte via
the callback. I couldn't find any check in kvm_pgtable_stage2_map() for
the old pte, so it will set the new stage 2 pte regardless. A subsequent
guest read would no longer fault at stage 2.

>  * replace_page() (KSM): If the page has MTE tags then the MTE version of
> memcmp_pages() will return false, so the only caller
> (try_to_merge_one_page()) will never call this on a page with tags.
> 
>  * wp_page_copy(): This one is more interesting - if we go down the
> cow_user_page() path with an old page then everything is safe (tags are
> copied over). The is_zero_pfn() case worries me a bit - a new page is
> allocated, but I can't instantly see anything to zero out the tags (and set
> PG_mte_tagged).

True, I think tag zeroing happens only if we map it as PROT_MTE in the
VMM.

>  * migrate_vma_insert_page(): I think migration should be safe as the tags
> should be copied.
> 
> So wp_page_copy() looks suspicious.
> 
> kvm_pgtable_stage2_map() looks like it could be a good place for the checks,
> it looks like it should work and is probably a more obvious place for the
> checks.

That would be my preference. It also matches the stage 1 set_pte_at().

> > While the set_pte_at() race on the page flags is somewhat clearer, we
> > may still have a race here with the VMM's set_pte_at() if the page is
> > mapped as tagged. KVM has its own mmu_lock but it wouldn't be held when
> > handling the VMM page tables (well, not always, see below).
> > 
> > gfn_to_pfn_prot() ends up calling get_user_pages*(). At least the slow
> > path (hva_to_pfn_slow()) ends up with FOLL_TOUCH in gup and the VMM pte
> > would be set, tags cleared (if PROT_MTE) before the stage 2 pte. I'm not
> > sure whether get_user_page_fast_only() does the same.
> > 
> > The race with an mprotect(PROT_MTE) in the VMM is fine I think as the
> > KVM mmu notifier is invoked before set_pte_at() and racing with another
> > user_mem_abort() is serialised by the KVM mmu_lock. The subsequent
> > set_pte_at() would see the PG_mte_tagged set either by the current CPU
> > or by the one it was racing with.
> 
> Given the changes to set_pte_at() which means that tags are restored from
> swap even if !PROT_MTE, the only race I can see remaining is the creation of
> new PROT_MTE mappings. As you mention an attempt to change mappings in the
> VMM memory space should involve a mmu notifier call which I think serialises
> this. So the remaining issue is doing this in a separate address space.
> 
> So I guess the potential problem is:
> 
>  * allocate memory MAP_SHARED but !PROT_MTE
>  * fork()
>  * VM causes a fault in parent address space
>  * child does a mprotect(PROT_MTE)
> 
> With the last two potentially racing. Sadly I can't see a good way of
> handling that.

Ah, the mmap lock doesn't help as they are different processes
(mprotect() acquires it as a writer).

I wonder whether this is racy even in the absence of KVM. If both parent
and child do an mprotect(PROT_MTE), one of them may be reading stale
tags for a brief period.

Maybe we should revisit whether shared MTE pages are of any use, though
it's an ABI change (not bad if no-one is relying on this). However...

Thinking about this, we have a similar problem with the PG_dcache_clean
and two processes doing mprotect(PROT_EXEC). One of them could see the
flag set and skip the I-cache maintenance while the other executes
stale instructions. change_pte_range() could acquire the page lock if
the page is VM_SHARED (my preferred core mm fix). It doesn't immediately
solve the MTE/KVM case but we could at least take the page lock via
user_mem_abort().

Or maybe we just document this behaviour as racy both for PROT_EXEC and
PROT_MTE mappings and be done with this. The minor issue with PROT_MTE
is the potential leaking of tags (it's harder to leak information
through the I-cache).

-- 
Catalin
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
