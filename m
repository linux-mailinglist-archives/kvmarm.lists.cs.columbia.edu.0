Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id F17D225D582
	for <lists+kvmarm@lfdr.de>; Fri,  4 Sep 2020 11:59:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8CF724B32F;
	Fri,  4 Sep 2020 05:59:05 -0400 (EDT)
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
	with ESMTP id 41P6vuXDFl3I; Fri,  4 Sep 2020 05:59:05 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6645D4B33E;
	Fri,  4 Sep 2020 05:59:04 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8CE064B335
 for <kvmarm@lists.cs.columbia.edu>; Fri,  4 Sep 2020 05:59:03 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E689eB0YNij0 for <kvmarm@lists.cs.columbia.edu>;
 Fri,  4 Sep 2020 05:59:02 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 6BA0F4B2DA
 for <kvmarm@lists.cs.columbia.edu>; Fri,  4 Sep 2020 05:59:02 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 05C4B206B7;
 Fri,  4 Sep 2020 09:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599213541;
 bh=JQb0Km8vxsTnUcKSyoKH+85BrdLonv4re0h1/xowQ8o=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=uvzXgYnBgMCCGDKm/oK4IyteuvrmWNj+6m92k/fZUzX2At+5/OhA2cSsp15oYddEE
 IW92IlSLJ3mCCHR1X+xZ46BkB/kxNPAy1dS6I3GIBOqhi4bdCA7Klz0iTkxLGRwyhz
 imIz6ynRlUxHizT0/6sbo5kDcL5iPMqkydIZmSSQ=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=wait-a-minute.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1kE8Ul-0097wX-8D; Fri, 04 Sep 2020 10:58:59 +0100
Date: Fri, 04 Sep 2020 10:58:58 +0100
Message-ID: <87sgbx7ti5.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Subject: Re: [PATCH 2/2] KVM: arm64: Try PMD block mappings if PUD mappings
 are not supported
In-Reply-To: <20200901133357.52640-3-alexandru.elisei@arm.com>
References: <20200901133357.52640-1-alexandru.elisei@arm.com>
 <20200901133357.52640-3-alexandru.elisei@arm.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL/10.8 EasyPG/1.0.0 Emacs/26.3
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: alexandru.elisei@arm.com,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

Hi Alex,

On Tue, 01 Sep 2020 14:33:57 +0100,
Alexandru Elisei <alexandru.elisei@arm.com> wrote:
> 
> When userspace uses hugetlbfs for the VM memory, user_mem_abort() tries to
> use the same block size to map the faulting IPA in stage 2. If stage 2
> cannot use the same size mapping because the block size doesn't fit in the
> memslot or the memslot is not properly aligned, user_mem_abort() will fall
> back to a page mapping, regardless of the block size. We can do better for
> PUD backed hugetlbfs by checking if a PMD block mapping is possible before
> deciding to use a page.
> 
> vma_pagesize is an unsigned long, use 1UL instead of 1ULL when assigning
> its value.
> 
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> ---
>  arch/arm64/kvm/mmu.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 25e7dc52c086..f590f7355cda 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -1871,15 +1871,24 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  	else
>  		vma_shift = PAGE_SHIFT;
>  
> -	vma_pagesize = 1ULL << vma_shift;
>  	if (logging_active ||
> -	    (vma->vm_flags & VM_PFNMAP) ||
> -	    !fault_supports_stage2_huge_mapping(memslot, hva, vma_pagesize)) {
> +	    (vma->vm_flags & VM_PFNMAP)) {
>  		force_pte = true;
> -		vma_pagesize = PAGE_SIZE;
>  		vma_shift = PAGE_SHIFT;
>  	}
>  
> +	if (vma_shift == PUD_SHIFT &&
> +	    !fault_supports_stage2_huge_mapping(memslot, hva, PUD_SIZE))
> +		vma_shift = PMD_SHIFT;
> +
> +	if (vma_shift == PMD_SHIFT &&
> +	    !fault_supports_stage2_huge_mapping(memslot, hva, PMD_SIZE)) {
> +		force_pte = true;
> +		vma_shift = PAGE_SHIFT;
> +	}
> +
> +	vma_pagesize = 1UL << vma_shift;
> +
>  	/*
>  	 * The stage2 has a minimum of 2 level table (For arm64 see
>  	 * kvm_arm_setup_stage2()). Hence, we are guaranteed that we can
> @@ -1889,7 +1898,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  	 */
>  	if (vma_pagesize == PMD_SIZE ||
>  	    (vma_pagesize == PUD_SIZE && kvm_stage2_has_pmd(kvm)))
> -		gfn = (fault_ipa & huge_page_mask(hstate_vma(vma))) >> PAGE_SHIFT;
> +		gfn = (fault_ipa & ~(vma_pagesize - 1)) >> PAGE_SHIFT;
>  	mmap_read_unlock(current->mm);
>  
>  	/* We need minimum second+third level pages */

Although this looks like a sensible change, I'm a reluctant to take it
at this stage, given that we already have a bunch of patches from Will
to change the way we deal with PTs.

Could you look into how this could fit into the new code instead?

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
