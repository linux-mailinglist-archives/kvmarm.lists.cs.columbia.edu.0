Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8881F50627F
	for <lists+kvmarm@lfdr.de>; Tue, 19 Apr 2022 05:09:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CC5F24B0C0;
	Mon, 18 Apr 2022 23:09:43 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.788
X-Spam-Level: 
X-Spam-Status: No, score=-1.788 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cqRIDzgAuUS6; Mon, 18 Apr 2022 23:09:43 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4B1F149AF7;
	Mon, 18 Apr 2022 23:09:42 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DE43A405C1
 for <kvmarm@lists.cs.columbia.edu>; Mon, 18 Apr 2022 23:09:40 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lcf6Kx8v0Xp8 for <kvmarm@lists.cs.columbia.edu>;
 Mon, 18 Apr 2022 23:09:39 -0400 (EDT)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 78544404B2
 for <kvmarm@lists.cs.columbia.edu>; Mon, 18 Apr 2022 23:09:39 -0400 (EDT)
Received: by mail-pj1-f50.google.com with SMTP id o5so14644765pjr.0
 for <kvmarm@lists.cs.columbia.edu>; Mon, 18 Apr 2022 20:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=YKFfQt23dUtFGdrF1F7iYdCmDeBOcbP+xYI8BamkfTw=;
 b=muAPJeUCZ5EJiVsOdNd9dCpcCg/ha6GLJsvBjQBcNtt81FrKtDx8HJjd+V50X1tF7S
 uQcP3bQXPka3bws59iWSiL2Gp1FBmf4sLX78INZX3gAUU7V3g2SLd/EMelp0MhcD4UnY
 xbe4zEsZsbw+eeBq7gXuiUIGVizGkuLhPs0ldjBGseAP02JFKWTpc9ElpDSpM4f78Ilj
 zFLticmKgXr3LlvcfrKk/COekG8ntHT93kC3/MyeMzRUm9Z8F2leXYIBPC3j4ut6EM92
 pI1CliaqcoNL7MKnKqvWNXBxdeGJ8YEIqlEjiXUS63RUqHdXLxUGrlbp1gcU+IJZnXex
 5GIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=YKFfQt23dUtFGdrF1F7iYdCmDeBOcbP+xYI8BamkfTw=;
 b=oy11PCZrFED+KG98kWKT2Apey7N9fjhodEVvhpCtzFOwjHtgxR3/0//nevoqLQFxtH
 DE1TPxsSYGzAB0s82TtxW/HrERsr9OkzbMBYaEbbaUVnpwamb2WTqmn41WOIZyHGuglp
 OwPdZ9qm8HTXaQTuYYfApVt/26S7A2LZIRCa0tDIgofEBJe2SHKElcBApxtKVswWXmOP
 9r+WGlumaSEI4vr1lgfIHJK0LtfH+15e8IbzJCAq5mR7Ru7IjQ5Cl4ilAin3Pljmi/1F
 nnkJRVcifTD5liuPIQS+N9n9ybBDmrl+MDVEGqcgSX5Kne+9i+67L/juohiIDXKPKyYQ
 Brmg==
X-Gm-Message-State: AOAM5308U7Q/Qk5hRsmnFoEnSVHLPNfnowvSJysbPdh9Gb0q5dOL8HHi
 AQrbBoA9DFa2yRbNCav3WheLQg==
X-Google-Smtp-Source: ABdhPJx8u1DTy7iFh4/9gYKF1ioP+FdchbYezQT//Rc+Rc7XFGRYkIfgKljUvVDDsC4SClkf8FitrQ==
X-Received: by 2002:a17:902:ed53:b0:159:804:e854 with SMTP id
 y19-20020a170902ed5300b001590804e854mr4765878plb.90.1650337778103; 
 Mon, 18 Apr 2022 20:09:38 -0700 (PDT)
Received: from google.com (150.12.83.34.bc.googleusercontent.com.
 [34.83.12.150]) by smtp.gmail.com with ESMTPSA id
 p34-20020a056a000a2200b004cd49fc15e5sm15394994pfh.59.2022.04.18.20.09.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Apr 2022 20:09:37 -0700 (PDT)
Date: Mon, 18 Apr 2022 20:09:34 -0700
From: Ricardo Koller <ricarkol@google.com>
To: Oliver Upton <oupton@google.com>
Subject: Re: [RFC PATCH 14/17] KVM: arm64: Punt last page reference to rcu
 callback for parallel walk
Message-ID: <Yl4n7o45K0HFK52S@google.com>
References: <20220415215901.1737897-1-oupton@google.com>
 <20220415215901.1737897-15-oupton@google.com>
 <Yl4leEoIg+dr/1QM@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yl4leEoIg+dr/1QM@google.com>
Cc: kvm@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Ben Gardon <bgardon@google.com>, Peter Shier <pshier@google.com>,
 David Matlack <dmatlack@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

On Mon, Apr 18, 2022 at 07:59:04PM -0700, Ricardo Koller wrote:
> On Fri, Apr 15, 2022 at 09:58:58PM +0000, Oliver Upton wrote:
> > It is possible that a table page remains visible to another thread until
> > the next rcu synchronization event. To that end, we cannot drop the last
> > page reference synchronous with post-order traversal for a parallel
> > table walk.
> > 
> > Schedule an rcu callback to clean up the child table page for parallel
> > walks.
> > 
> > Signed-off-by: Oliver Upton <oupton@google.com>
> > ---
> >  arch/arm64/include/asm/kvm_pgtable.h |  3 ++
> >  arch/arm64/kvm/hyp/pgtable.c         | 24 +++++++++++++--
> >  arch/arm64/kvm/mmu.c                 | 44 +++++++++++++++++++++++++++-
> >  3 files changed, 67 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
> > index 74955aba5918..52e55e00f0ca 100644
> > --- a/arch/arm64/include/asm/kvm_pgtable.h
> > +++ b/arch/arm64/include/asm/kvm_pgtable.h
> > @@ -81,6 +81,8 @@ static inline bool kvm_level_supports_block_mapping(u32 level)
> >   * @put_page:			Decrement the refcount on a page. When the
> >   *				refcount reaches 0 the page is automatically
> >   *				freed.
> > + * @free_table:			Drop the last page reference, possibly in the
> > + *				next RCU sync if doing a shared walk.
> >   * @page_count:			Return the refcount of a page.
> >   * @phys_to_virt:		Convert a physical address into a virtual
> >   *				address	mapped in the current context.
> > @@ -98,6 +100,7 @@ struct kvm_pgtable_mm_ops {
> >  	void		(*get_page)(void *addr);
> >  	void		(*put_page)(void *addr);
> >  	int		(*page_count)(void *addr);
> > +	void		(*free_table)(void *addr, bool shared);
> >  	void*		(*phys_to_virt)(phys_addr_t phys);
> >  	phys_addr_t	(*virt_to_phys)(void *addr);
> >  	void		(*dcache_clean_inval_poc)(void *addr, size_t size);
> > diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> > index 121818d4c33e..a9a48edba63b 100644
> > --- a/arch/arm64/kvm/hyp/pgtable.c
> > +++ b/arch/arm64/kvm/hyp/pgtable.c
> > @@ -147,12 +147,19 @@ static inline void kvm_pgtable_walk_end(void)
> >  {}
> >  
> >  #define kvm_dereference_ptep	rcu_dereference_raw
> > +
> > +static inline void kvm_pgtable_destroy_barrier(void)
> > +{}
> > +
> >  #else
> >  #define kvm_pgtable_walk_begin	rcu_read_lock
> >  
> >  #define kvm_pgtable_walk_end	rcu_read_unlock
> >  
> >  #define kvm_dereference_ptep	rcu_dereference
> > +
> > +#define kvm_pgtable_destroy_barrier	rcu_barrier
> > +
> >  #endif
> >  
> >  static kvm_pte_t *kvm_pte_follow(kvm_pte_t pte, struct kvm_pgtable_mm_ops *mm_ops)
> > @@ -1063,7 +1070,12 @@ static int stage2_map_walk_table_post(u64 addr, u64 end, u32 level,
> >  		childp = kvm_pte_follow(*old, mm_ops);
> >  	}
> >  
> > -	mm_ops->put_page(childp);
> > +	/*
> > +	 * If we do not have exclusive access to the page tables it is possible
> > +	 * the unlinked table remains visible to another thread until the next
> > +	 * rcu synchronization.
> > +	 */
> > +	mm_ops->free_table(childp, shared);
> >  	mm_ops->put_page(ptep);
> >  
> >  	return ret;
> > @@ -1203,7 +1215,7 @@ static int stage2_unmap_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
> >  					       kvm_granule_size(level));
> >  
> >  	if (childp)
> > -		mm_ops->put_page(childp);
> > +		mm_ops->free_table(childp, shared);
> >  
> >  	return 0;
> >  }
> > @@ -1433,7 +1445,7 @@ static int stage2_free_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
> >  	mm_ops->put_page(ptep);
> >  
> >  	if (kvm_pte_table(*old, level))
> > -		mm_ops->put_page(kvm_pte_follow(*old, mm_ops));
> > +		mm_ops->free_table(kvm_pte_follow(*old, mm_ops), shared);
> >  
> >  	return 0;
> >  }
> > @@ -1452,4 +1464,10 @@ void kvm_pgtable_stage2_destroy(struct kvm_pgtable *pgt)
> >  	pgd_sz = kvm_pgd_pages(pgt->ia_bits, pgt->start_level) * PAGE_SIZE;
> >  	pgt->mm_ops->free_pages_exact(pgt->pgd, pgd_sz);
> >  	pgt->pgd = NULL;
> > +
> > +	/*
> > +	 * Guarantee that all unlinked subtrees associated with the stage2 page
> > +	 * table have also been freed before returning.
> > +	 */
> > +	kvm_pgtable_destroy_barrier();
> >  }
> > diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> > index cc6ed6b06ec2..6ecf37009c21 100644
> > --- a/arch/arm64/kvm/mmu.c
> > +++ b/arch/arm64/kvm/mmu.c
> > @@ -98,9 +98,50 @@ static bool kvm_is_device_pfn(unsigned long pfn)
> >  static void *stage2_memcache_zalloc_page(void *arg)
> >  {
> >  	struct kvm_mmu_caches *mmu_caches = arg;
> > +	struct stage2_page_header *hdr;
> > +	void *addr;
> >  
> >  	/* Allocated with __GFP_ZERO, so no need to zero */
> > -	return kvm_mmu_memory_cache_alloc(&mmu_caches->page_cache);
> > +	addr = kvm_mmu_memory_cache_alloc(&mmu_caches->page_cache);
> > +	if (!addr)
> > +		return NULL;
> > +
> > +	hdr = kvm_mmu_memory_cache_alloc(&mmu_caches->header_cache);
> > +	if (!hdr) {
> > +		free_page((unsigned long)addr);
> > +		return NULL;
> > +	}
> > +
> > +	hdr->page = virt_to_page(addr);
> > +	set_page_private(hdr->page, (unsigned long)hdr);
> > +	return addr;
> > +}
> > +
> > +static void stage2_free_page_now(struct stage2_page_header *hdr)
> > +{
> > +	WARN_ON(page_ref_count(hdr->page) != 1);
> > +
> > +	__free_page(hdr->page);
> > +	kmem_cache_free(stage2_page_header_cache, hdr);
> > +}
> > +
> > +static void stage2_free_page_rcu_cb(struct rcu_head *head)
> > +{
> > +	struct stage2_page_header *hdr = container_of(head, struct stage2_page_header,
> > +						      rcu_head);
> > +
> > +	stage2_free_page_now(hdr);
> > +}
> > +
> > +static void stage2_free_table(void *addr, bool shared)
> > +{
> > +	struct page *page = virt_to_page(addr);
> > +	struct stage2_page_header *hdr = (struct stage2_page_header *)page_private(page);
> > +
> > +	if (shared)
> > +		call_rcu(&hdr->rcu_head, stage2_free_page_rcu_cb);
> 
> Can the number of callbacks grow to "dangerous" numbers? can it be
> bounded with something like the following?
> 
> if number of readers is really high:
> 	synchronize_rcu() 
> else
> 	call_rcu()

sorry, meant to say "number of callbacks"
> 
> maybe the rcu API has an option for that.
> 
> > +	else
> > +		stage2_free_page_now(hdr);
> >  }
> >  
> >  static void *kvm_host_zalloc_pages_exact(size_t size)
> > @@ -613,6 +654,7 @@ static struct kvm_pgtable_mm_ops kvm_s2_mm_ops = {
> >  	.free_pages_exact	= free_pages_exact,
> >  	.get_page		= kvm_host_get_page,
> >  	.put_page		= kvm_host_put_page,
> > +	.free_table		= stage2_free_table,
> >  	.page_count		= kvm_host_page_count,
> >  	.phys_to_virt		= kvm_host_va,
> >  	.virt_to_phys		= kvm_host_pa,
> > -- 
> > 2.36.0.rc0.470.gd361397f0d-goog
> > 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
