Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D082025C705
	for <lists+kvmarm@lfdr.de>; Thu,  3 Sep 2020 18:37:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 486E34B28F;
	Thu,  3 Sep 2020 12:37:20 -0400 (EDT)
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
	with ESMTP id vUCnNfAAMk8H; Thu,  3 Sep 2020 12:37:20 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1AD5E4B26D;
	Thu,  3 Sep 2020 12:37:19 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2CC8E4B212
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Sep 2020 12:37:18 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ipaYkMzXyriQ for <kvmarm@lists.cs.columbia.edu>;
 Thu,  3 Sep 2020 12:37:17 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id F36084B1FC
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Sep 2020 12:37:16 -0400 (EDT)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BC65720578;
 Thu,  3 Sep 2020 16:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599151035;
 bh=V2uzEbJjL0nt32Wj65d8TvDfKg2z8pr91NbW9R/dFhY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BGe4KI1NK2vcwg2DJp6tqgfHl265Uk+t//FyKmVB16N9OJLdhncn3/M7zxZib0Vbb
 elC+6fAUiQ6VTGqa2PBy/n844v+qq9FQ52H5cwqFUciaezbxnT+VLeL+vA3EQZbZo3
 V21DWyFEPPhMObCf466TlSNfDnXiiWsabI0spH6I=
Date: Thu, 3 Sep 2020 17:37:11 +0100
From: Will Deacon <will@kernel.org>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Subject: Re: [PATCH v3 08/21] KVM: arm64: Convert kvm_set_spte_hva() to
 generic page-table API
Message-ID: <20200903163711.GA7791@willie-the-truck>
References: <20200825093953.26493-1-will@kernel.org>
 <20200825093953.26493-9-will@kernel.org>
 <86bb295c-64d8-51a1-25f4-32a5a1bb2172@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <86bb295c-64d8-51a1-25f4-32a5a1bb2172@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Marc Zyngier <maz@kernel.org>, kernel-team@android.com,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>
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

On Wed, Sep 02, 2020 at 04:37:18PM +0100, Alexandru Elisei wrote:
> On 8/25/20 10:39 AM, Will Deacon wrote:
> > diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> > index 33146d3dc93a..704b471a48ce 100644
> > --- a/arch/arm64/kvm/mmu.c
> > +++ b/arch/arm64/kvm/mmu.c
> > @@ -1911,28 +1911,27 @@ int kvm_unmap_hva_range(struct kvm *kvm,
> >  
> >  static int kvm_set_spte_handler(struct kvm *kvm, gpa_t gpa, u64 size, void *data)
> >  {
> > -	pte_t *pte = (pte_t *)data;
> > +	kvm_pfn_t *pfn = (kvm_pfn_t *)data;
> >  
> >  	WARN_ON(size != PAGE_SIZE);
> > +
> >  	/*
> > -	 * We can always call stage2_set_pte with KVM_S2PTE_FLAG_LOGGING_ACTIVE
> > -	 * flag clear because MMU notifiers will have unmapped a huge PMD before
> > -	 * calling ->change_pte() (which in turn calls kvm_set_spte_hva()) and
> > -	 * therefore stage2_set_pte() never needs to clear out a huge PMD
> > -	 * through this calling path.
> > +	 * The MMU notifiers will have unmapped a huge PMD before calling
> > +	 * ->change_pte() (which in turn calls kvm_set_spte_hva()) and
> > +	 * therefore we never need to clear out a huge PMD through this
> > +	 * calling path and a memcache is not required.
> >  	 */
> > -	stage2_set_pte(&kvm->arch.mmu, NULL, gpa, pte, 0);
> > +	kvm_pgtable_stage2_map(kvm->arch.mmu.pgt, gpa, PAGE_SIZE,
> > +			       __pfn_to_phys(*pfn), KVM_PGTABLE_PROT_R, NULL);
> 
> I have to admit that I managed to confuse myself.
> 
> According to the comment, this is called after unmapping a huge PMD.
> __unmap_stage2_range() -> .. -> unmap_stage2_pmd() calls pmd_clear(), which means
> the PMD entry is now 0.
> 
> In __kvm_pgtable_visit(), kvm_pte_table() returns false, because the entry is
> invalid, and so we call stage2_map_walk_leaf(). Here, stage2_map_walker_try_leaf()
> will return false, because kvm_block_mapping_supported() returns false (PMD
> granule is larger than PAGE_SIZE), and then we end up allocating a table from the
> memcache. memcache which will NULL, and kvm_mmu_memory_cache_alloc() will
> dereference the NULL pointer.
> 
> I'm pretty sure there's something that I'm missing here, I would really appreciate
> someone pointing out where I'm making a mistake.

You're not missing anything, and this is actually a bug introduced by moving
to the generic mmu cache code. My old implementation (which you can still
see in the earlier patch) returns NULL if the cache is NULL, so I'll need to
reintroduce that check here. This then mimics the current behaviour of
ignoring map requests from the MMU if we need to allocate, and instead
handling them lazily when we take the fault.

Well spotted!

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
