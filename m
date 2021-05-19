Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B0435389501
	for <lists+kvmarm@lfdr.de>; Wed, 19 May 2021 20:06:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 55E7F4B879;
	Wed, 19 May 2021 14:06:22 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PeatGym7NSWh; Wed, 19 May 2021 14:06:22 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 23D444B85C;
	Wed, 19 May 2021 14:06:21 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DFE874B83C
 for <kvmarm@lists.cs.columbia.edu>; Wed, 19 May 2021 14:06:19 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wE1Mp6IKtMyD for <kvmarm@lists.cs.columbia.edu>;
 Wed, 19 May 2021 14:06:18 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A7DA74B3AC
 for <kvmarm@lists.cs.columbia.edu>; Wed, 19 May 2021 14:06:18 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9D76D611BF;
 Wed, 19 May 2021 18:06:13 +0000 (UTC)
Date: Wed, 19 May 2021 19:06:10 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v12 3/8] arm64: mte: Sync tags for pages where PTE is
 untagged
Message-ID: <20210519180610.GE21619@arm.com>
References: <20210517123239.8025-1-steven.price@arm.com>
 <20210517123239.8025-4-steven.price@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210517123239.8025-4-steven.price@arm.com>
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

On Mon, May 17, 2021 at 01:32:34PM +0100, Steven Price wrote:
> A KVM guest could store tags in a page even if the VMM hasn't mapped
> the page with PROT_MTE. So when restoring pages from swap we will
> need to check to see if there are any saved tags even if !pte_tagged().
> 
> However don't check pages for which pte_access_permitted() returns false
> as these will not have been swapped out.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  arch/arm64/include/asm/pgtable.h |  9 +++++++--
>  arch/arm64/kernel/mte.c          | 16 ++++++++++++++--
>  2 files changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 0b10204e72fc..275178a810c1 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -314,8 +314,13 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
>  	if (pte_present(pte) && pte_user_exec(pte) && !pte_special(pte))
>  		__sync_icache_dcache(pte);
>  
> -	if (system_supports_mte() &&
> -	    pte_present(pte) && pte_tagged(pte) && !pte_special(pte))
> +	/*
> +	 * If the PTE would provide user space access to the tags associated
> +	 * with it then ensure that the MTE tags are synchronised.  Exec-only
> +	 * mappings don't expose tags (instruction fetches don't check tags).
> +	 */
> +	if (system_supports_mte() && pte_present(pte) &&
> +	    pte_access_permitted(pte, false) && !pte_special(pte))
>  		mte_sync_tags(ptep, pte);

Looking at the mte_sync_page_tags() logic, we bail out early if it's the
old pte is not a swap one and the new pte is not tagged. So we only need
to call mte_sync_tags() if it's a tagged new pte or the old one is swap.
What about changing the set_pte_at() test to:

	if (system_supports_mte() && pte_present(pte) && !pte_special(pte) &&
	    (pte_tagged(pte) || is_swap_pte(READ_ONCE(*ptep))))
		mte_sync_tags(ptep, pte);

We can even change mte_sync_tags() to take the old pte directly:

	if (system_supports_mte() && pte_present(pte) && !pte_special(pte)) {
		pte_t old_pte = READ_ONCE(*ptep);
		if (pte_tagged(pte) || is_swap_pte(old_pte))
			mte_sync_tags(old_pte, pte);
	}

It would save a function call in most cases where the page is not
tagged.

-- 
Catalin
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
