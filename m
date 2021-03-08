Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E848E3313C1
	for <lists+kvmarm@lfdr.de>; Mon,  8 Mar 2021 17:49:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5C5AE4B158;
	Mon,  8 Mar 2021 11:49:13 -0500 (EST)
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
	with ESMTP id FRCkTi1yKAIn; Mon,  8 Mar 2021 11:49:13 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 02D154B19D;
	Mon,  8 Mar 2021 11:49:12 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4D9A24B159
 for <kvmarm@lists.cs.columbia.edu>; Mon,  8 Mar 2021 11:49:10 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Iu19mdKV8nZS for <kvmarm@lists.cs.columbia.edu>;
 Mon,  8 Mar 2021 11:49:09 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id EC5634B158
 for <kvmarm@lists.cs.columbia.edu>; Mon,  8 Mar 2021 11:49:08 -0500 (EST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 211856518D;
 Mon,  8 Mar 2021 16:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615222147;
 bh=DVQbndAkIml65LX9jhn2q+DfBf8VuoyQTUefFkaqPEo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tWgWGGXkCUyhjf/GVVWLdQ6LjYCbv/H7gIus4CH46j4UVAMEKovo6/HoMTLjD91OO
 kjC2nPfUn8FtupBItp4dFse1GKcy5H0OVhZ2DONYWx6ZTgAfopZRbualOyhX46bZYM
 vlnsM8EMVi4xKMtwSN9SvQVfsg7F2w/MfMmGPH16y+QEfBTyErncsNG+S1Eo+BZzCL
 MVuRvnDWvxpcd7bZd778QrI/cBsxAJwBTzihcY96SrG9WFe6tVKalO6n4yJGlWdOxA
 4DQhY0DgZkMb0e8rhjeO+OUV0Uxg/grRb49P+8OX/lXVrLk87VYEsBxbfZ4i0EM3aA
 k3rWoqY3Stj5g==
Date: Mon, 8 Mar 2021 16:49:02 +0000
From: Will Deacon <will@kernel.org>
To: Jing Zhang <jingzhangos@google.com>
Subject: Re: [PATCH] KVM: arm64: Remove redundant check for S2FWB
Message-ID: <20210308164902.GA26772@willie-the-truck>
References: <20210205044403.1559010-1-jingzhangos@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210205044403.1559010-1-jingzhangos@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: maz@kernel.org, linux-arm-kernel@lists.infradead.org,
 catalin.marinas@arm.com, kvmarm@lists.cs.columbia.edu
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

On Fri, Feb 05, 2021 at 04:44:03AM +0000, Jing Zhang wrote:
> Remove redundant check for CPU feature S2FWB in dcache flush code
> to save some CPU cycles for every memslot flush and unmapping.
> And move the S2FWB check to outer functions to avoid future
> redundancy and keep consistent with other usage like in
> access_dcsw and kvm_arch_prepare_memory_region.
> 
> Signed-off-by: Jing Zhang <jingzhangos@google.com>
> ---
>  arch/arm64/kvm/hyp/pgtable.c | 9 ++-------
>  arch/arm64/kvm/mmu.c         | 3 ++-
>  2 files changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> index bdf8e55ed308..afd57564b1cb 100644
> --- a/arch/arm64/kvm/hyp/pgtable.c
> +++ b/arch/arm64/kvm/hyp/pgtable.c
> @@ -642,9 +642,6 @@ int kvm_pgtable_stage2_map(struct kvm_pgtable *pgt, u64 addr, u64 size,
>  
>  static void stage2_flush_dcache(void *addr, u64 size)
>  {
> -	if (cpus_have_const_cap(ARM64_HAS_STAGE2_FWB))
> -		return;
> -
>  	__flush_dcache_area(addr, size);
>  }
>  
> @@ -670,7 +667,8 @@ static int stage2_unmap_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
>  
>  		if (page_count(virt_to_page(childp)) != 1)
>  			return 0;
> -	} else if (stage2_pte_cacheable(pte)) {
> +	} else if (stage2_pte_cacheable(pte) &&
> +			!cpus_have_const_cap(ARM64_HAS_STAGE2_FWB)) {
>  		need_flush = true;
>  	}
>  
> @@ -846,9 +844,6 @@ int kvm_pgtable_stage2_flush(struct kvm_pgtable *pgt, u64 addr, u64 size)
>  		.flags	= KVM_PGTABLE_WALK_LEAF,
>  	};
>  
> -	if (cpus_have_const_cap(ARM64_HAS_STAGE2_FWB))
> -		return 0;
> -
>  	return kvm_pgtable_walk(pgt, addr, size, &walker);
>  }

I think we should leave pgtable.c as it is: there's no benefit from this
change on the unmap path, and the other path involves the case where the
caller has asked for a flush and we can elide it.

> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 7d2257cc5438..53130ed23304 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -1458,7 +1458,8 @@ void kvm_toggle_cache(struct kvm_vcpu *vcpu, bool was_enabled)
>  	 * If switching it off, need to clean the caches.
>  	 * Clean + invalidate does the trick always.
>  	 */
> -	if (now_enabled != was_enabled)
> +	if (now_enabled != was_enabled &&
> +			!cpus_have_const_cap(ARM64_HAS_STAGE2_FWB))
>  		stage2_flush_vm(vcpu->kvm);

This change looks fine, but I don't grok the justification in your follow-up
email. You say:

  | The saving is from the code path of memslot flush. The S2FWB check was
  | in stage2_flush_dcache, in which case, for a memslot flush, the check
  | was done for every page.

but I don't see where this is called for every page. It looks to me like it's
called for every pgd in the range, which is a very different kettle of frogs.

What am I missing?

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
