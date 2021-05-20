Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id CF12938AD05
	for <lists+kvmarm@lfdr.de>; Thu, 20 May 2021 13:54:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2D7444B4A9;
	Thu, 20 May 2021 07:54:38 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AYkJKbkgJtf8; Thu, 20 May 2021 07:54:38 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DE7274B526;
	Thu, 20 May 2021 07:54:36 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EB1584B4A9
 for <kvmarm@lists.cs.columbia.edu>; Thu, 20 May 2021 07:54:35 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7nhRcE9L4y13 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 20 May 2021 07:54:34 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9CB824B278
 for <kvmarm@lists.cs.columbia.edu>; Thu, 20 May 2021 07:54:34 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id DAF0161006;
 Thu, 20 May 2021 11:54:29 +0000 (UTC)
Date: Thu, 20 May 2021 12:54:27 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v12 4/8] arm64: kvm: Introduce MTE VM feature
Message-ID: <20210520115426.GB12251@arm.com>
References: <20210517123239.8025-1-steven.price@arm.com>
 <20210517123239.8025-5-steven.price@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210517123239.8025-5-steven.price@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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

On Mon, May 17, 2021 at 01:32:35PM +0100, Steven Price wrote:
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index c5d1f3c87dbd..8660f6a03f51 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -822,6 +822,31 @@ transparent_hugepage_adjust(struct kvm_memory_slot *memslot,
>  	return PAGE_SIZE;
>  }
>  
> +static int sanitise_mte_tags(struct kvm *kvm, unsigned long size,
> +			     kvm_pfn_t pfn)
> +{
> +	if (kvm_has_mte(kvm)) {
> +		/*
> +		 * The page will be mapped in stage 2 as Normal Cacheable, so
> +		 * the VM will be able to see the page's tags and therefore
> +		 * they must be initialised first. If PG_mte_tagged is set,
> +		 * tags have already been initialised.
> +		 */
> +		unsigned long i, nr_pages = size >> PAGE_SHIFT;
> +		struct page *page = pfn_to_online_page(pfn);
> +
> +		if (!page)
> +			return -EFAULT;

IIRC we ended up with pfn_to_online_page() to reject ZONE_DEVICE pages
that may be mapped into a guest and we have no idea whether they support
MTE. It may be worth adding a comment, otherwise, as Marc said, the page
wouldn't disappear.

> +
> +		for (i = 0; i < nr_pages; i++, page++) {
> +			if (!test_and_set_bit(PG_mte_tagged, &page->flags))
> +				mte_clear_page_tags(page_address(page));

We started the page->flags thread and ended up fixing it for the host
set_pte_at() as per the first patch:

https://lore.kernel.org/r/c3293d47-a5f2-ea4a-6730-f5cae26d8a7e@arm.com

Now, can we have a race between the stage 2 kvm_set_spte_gfn() and a
stage 1 set_pte_at()? Only the latter takes a lock. Or between two
kvm_set_spte_gfn() in different VMs? I think in the above thread we
concluded that there's only a problem if the page is shared between
multiple VMMs (MAP_SHARED). How realistic is this and what's the
workaround?

Either way, I think it's worth adding a comment here on the race on
page->flags as it looks strange that here it's just a test_and_set_bit()
while set_pte_at() uses a spinlock.

-- 
Catalin
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
