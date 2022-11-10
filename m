Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A2248623818
	for <lists+kvmarm@lfdr.de>; Thu, 10 Nov 2022 01:23:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EFF434BA84;
	Wed,  9 Nov 2022 19:23:55 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T3iZKfDT2yU2; Wed,  9 Nov 2022 19:23:55 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AE9CB4BA83;
	Wed,  9 Nov 2022 19:23:53 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 227C74BA1C
 for <kvmarm@lists.cs.columbia.edu>; Wed,  9 Nov 2022 19:23:52 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kA1-a2pRVmEq for <kvmarm@lists.cs.columbia.edu>;
 Wed,  9 Nov 2022 19:23:50 -0500 (EST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2E5FE4BA0F
 for <kvmarm@lists.cs.columbia.edu>; Wed,  9 Nov 2022 19:23:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668039829;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=botc+GSES7pcXwVaEANFkRzKn7TjcqiodTpXY4Qz2/k=;
 b=CYv3uZtjif4Oe+3PXE/ID0A+0VE6Mskg0SOhgAtP0WAVnYem84WkQwUXQJP7LTCyYFlvvm
 /DXnqxZbKf/P0dSOvx9LbmHiRLzSelJCsHGXKCDRMG1WcYgHShmUpqcb6qp5vqEgKhmiED
 b/BHV+kg4EQcZOddpbeRtqkYlQnYSpo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-zRTV8thcNveGHsexU5KPPg-1; Wed, 09 Nov 2022 19:23:46 -0500
X-MC-Unique: zRTV8thcNveGHsexU5KPPg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6C66A3C025C7;
 Thu, 10 Nov 2022 00:23:45 +0000 (UTC)
Received: from [10.64.54.49] (vpn2-54-49.bne.redhat.com [10.64.54.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E756140EBF5;
 Thu, 10 Nov 2022 00:23:39 +0000 (UTC)
Subject: Re: [PATCH v5 01/14] KVM: arm64: Combine visitor arguments into a
 context structure
To: Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>,
 James Morse <james.morse@arm.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>
References: <20221107215644.1895162-1-oliver.upton@linux.dev>
 <20221107215644.1895162-2-oliver.upton@linux.dev>
From: Gavin Shan <gshan@redhat.com>
Message-ID: <190fd3d3-bf86-23cf-0424-336577655e8f@redhat.com>
Date: Thu, 10 Nov 2022 08:23:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20221107215644.1895162-2-oliver.upton@linux.dev>
Content-Language: en-US
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
 Ben Gardon <bgardon@google.com>, David Matlack <dmatlack@google.com>,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
Reply-To: Gavin Shan <gshan@redhat.com>
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

On 11/8/22 5:56 AM, Oliver Upton wrote:
> Passing new arguments by value to the visitor callbacks is extremely
> inflexible for stuffing new parameters used by only some of the
> visitors. Use a context structure instead and pass the pointer through
> to the visitor callback.
> 
> While at it, redefine the 'flags' parameter to the visitor to contain
> the bit indicating the phase of the walk. Pass the entire set of flags
> through the context structure such that the walker can communicate
> additional state to the visitor callback.
> 
> No functional change intended.
> 
> Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
> ---
>   arch/arm64/include/asm/kvm_pgtable.h  |  15 +-
>   arch/arm64/kvm/hyp/nvhe/mem_protect.c |  10 +-
>   arch/arm64/kvm/hyp/nvhe/setup.c       |  16 +-
>   arch/arm64/kvm/hyp/pgtable.c          | 269 +++++++++++++-------------
>   4 files changed, 154 insertions(+), 156 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

One nit below.

> diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
> index 3252eb50ecfe..607f9bb8aab4 100644
> --- a/arch/arm64/include/asm/kvm_pgtable.h
> +++ b/arch/arm64/include/asm/kvm_pgtable.h
> @@ -199,10 +199,17 @@ enum kvm_pgtable_walk_flags {
>   	KVM_PGTABLE_WALK_TABLE_POST		= BIT(2),
>   };
>   
> -typedef int (*kvm_pgtable_visitor_fn_t)(u64 addr, u64 end, u32 level,
> -					kvm_pte_t *ptep,
> -					enum kvm_pgtable_walk_flags flag,
> -					void * const arg);
> +struct kvm_pgtable_visit_ctx {
> +	kvm_pte_t				*ptep;
> +	void					*arg;
> +	u64					addr;
> +	u64					end;
> +	u32					level;
> +	enum kvm_pgtable_walk_flags		flags;
> +};
> +
> +typedef int (*kvm_pgtable_visitor_fn_t)(const struct kvm_pgtable_visit_ctx *ctx,
> +					enum kvm_pgtable_walk_flags visit);
>   

Does it make sense to reorder these fields in the context struct based on
their properties. For example, ptep is determined by the combination of
addr/level.

     struct kvm_pgtable_visit_ctx {
            enum kvm_pgtable_walk_flags     flags;
            u64                             addr;
            u64                             end;
            u32                             level;
            kvm_pte_t                       *ptep;
            void                            *arg;
     };
            

>   /**
>    * struct kvm_pgtable_walker - Hook into a page-table walk.
> diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> index 1e78acf9662e..8f5b6a36a039 100644
> --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> @@ -417,13 +417,11 @@ struct check_walk_data {
>   	enum pkvm_page_state	(*get_page_state)(kvm_pte_t pte);
>   };
>   
> -static int __check_page_state_visitor(u64 addr, u64 end, u32 level,
> -				      kvm_pte_t *ptep,
> -				      enum kvm_pgtable_walk_flags flag,
> -				      void * const arg)
> +static int __check_page_state_visitor(const struct kvm_pgtable_visit_ctx *ctx,
> +				      enum kvm_pgtable_walk_flags visit)
>   {
> -	struct check_walk_data *d = arg;
> -	kvm_pte_t pte = *ptep;
> +	struct check_walk_data *d = ctx->arg;
> +	kvm_pte_t pte = *ctx->ptep;
>   
>   	if (kvm_pte_valid(pte) && !addr_is_memory(kvm_pte_to_phys(pte)))
>   		return -EINVAL;
> diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
> index e8d4ea2fcfa0..a293cf5eba1b 100644
> --- a/arch/arm64/kvm/hyp/nvhe/setup.c
> +++ b/arch/arm64/kvm/hyp/nvhe/setup.c
> @@ -186,15 +186,13 @@ static void hpool_put_page(void *addr)
>   	hyp_put_page(&hpool, addr);
>   }
>   
> -static int finalize_host_mappings_walker(u64 addr, u64 end, u32 level,
> -					 kvm_pte_t *ptep,
> -					 enum kvm_pgtable_walk_flags flag,
> -					 void * const arg)
> +static int finalize_host_mappings_walker(const struct kvm_pgtable_visit_ctx *ctx,
> +					 enum kvm_pgtable_walk_flags visit)
>   {
> -	struct kvm_pgtable_mm_ops *mm_ops = arg;
> +	struct kvm_pgtable_mm_ops *mm_ops = ctx->arg;
>   	enum kvm_pgtable_prot prot;
>   	enum pkvm_page_state state;
> -	kvm_pte_t pte = *ptep;
> +	kvm_pte_t pte = *ctx->ptep;
>   	phys_addr_t phys;
>   
>   	if (!kvm_pte_valid(pte))
> @@ -205,11 +203,11 @@ static int finalize_host_mappings_walker(u64 addr, u64 end, u32 level,
>   	 * was unable to access the hyp_vmemmap and so the buddy allocator has
>   	 * initialised the refcount to '1'.
>   	 */
> -	mm_ops->get_page(ptep);
> -	if (flag != KVM_PGTABLE_WALK_LEAF)
> +	mm_ops->get_page(ctx->ptep);
> +	if (visit != KVM_PGTABLE_WALK_LEAF)
>   		return 0;
>   
> -	if (level != (KVM_PGTABLE_MAX_LEVELS - 1))
> +	if (ctx->level != (KVM_PGTABLE_MAX_LEVELS - 1))
>   		return -EINVAL;
>   
>   	phys = kvm_pte_to_phys(pte);
> diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> index cdf8e76b0be1..900c8b9c0cfc 100644
> --- a/arch/arm64/kvm/hyp/pgtable.c
> +++ b/arch/arm64/kvm/hyp/pgtable.c
> @@ -64,20 +64,20 @@ static bool kvm_phys_is_valid(u64 phys)
>   	return phys < BIT(id_aa64mmfr0_parange_to_phys_shift(ID_AA64MMFR0_EL1_PARANGE_MAX));
>   }
>   
> -static bool kvm_block_mapping_supported(u64 addr, u64 end, u64 phys, u32 level)
> +static bool kvm_block_mapping_supported(const struct kvm_pgtable_visit_ctx *ctx, u64 phys)
>   {
> -	u64 granule = kvm_granule_size(level);
> +	u64 granule = kvm_granule_size(ctx->level);
>   
> -	if (!kvm_level_supports_block_mapping(level))
> +	if (!kvm_level_supports_block_mapping(ctx->level))
>   		return false;
>   
> -	if (granule > (end - addr))
> +	if (granule > (ctx->end - ctx->addr))
>   		return false;
>   
>   	if (kvm_phys_is_valid(phys) && !IS_ALIGNED(phys, granule))
>   		return false;
>   
> -	return IS_ALIGNED(addr, granule);
> +	return IS_ALIGNED(ctx->addr, granule);
>   }
>   
>   static u32 kvm_pgtable_idx(struct kvm_pgtable_walk_data *data, u32 level)
> @@ -172,12 +172,12 @@ static kvm_pte_t kvm_init_invalid_leaf_owner(u8 owner_id)
>   	return FIELD_PREP(KVM_INVALID_PTE_OWNER_MASK, owner_id);
>   }
>   
> -static int kvm_pgtable_visitor_cb(struct kvm_pgtable_walk_data *data, u64 addr,
> -				  u32 level, kvm_pte_t *ptep,
> -				  enum kvm_pgtable_walk_flags flag)
> +static int kvm_pgtable_visitor_cb(struct kvm_pgtable_walk_data *data,
> +				  const struct kvm_pgtable_visit_ctx *ctx,
> +				  enum kvm_pgtable_walk_flags visit)
>   {
>   	struct kvm_pgtable_walker *walker = data->walker;
> -	return walker->cb(addr, data->end, level, ptep, flag, walker->arg);
> +	return walker->cb(ctx, visit);
>   }
>   
>   static int __kvm_pgtable_walk(struct kvm_pgtable_walk_data *data,
> @@ -186,20 +186,24 @@ static int __kvm_pgtable_walk(struct kvm_pgtable_walk_data *data,
>   static inline int __kvm_pgtable_visit(struct kvm_pgtable_walk_data *data,
>   				      kvm_pte_t *ptep, u32 level)
>   {
> +	enum kvm_pgtable_walk_flags flags = data->walker->flags;
> +	struct kvm_pgtable_visit_ctx ctx = {
> +		.ptep	= ptep,
> +		.arg	= data->walker->arg,
> +		.addr	= data->addr,
> +		.end	= data->end,
> +		.level	= level,
> +		.flags	= flags,
> +	};
>   	int ret = 0;
> -	u64 addr = data->addr;
>   	kvm_pte_t *childp, pte = *ptep;
>   	bool table = kvm_pte_table(pte, level);
> -	enum kvm_pgtable_walk_flags flags = data->walker->flags;
>   
> -	if (table && (flags & KVM_PGTABLE_WALK_TABLE_PRE)) {
> -		ret = kvm_pgtable_visitor_cb(data, addr, level, ptep,
> -					     KVM_PGTABLE_WALK_TABLE_PRE);
> -	}
> +	if (table && (ctx.flags & KVM_PGTABLE_WALK_TABLE_PRE))
> +		ret = kvm_pgtable_visitor_cb(data, &ctx, KVM_PGTABLE_WALK_TABLE_PRE);
>   
> -	if (!table && (flags & KVM_PGTABLE_WALK_LEAF)) {
> -		ret = kvm_pgtable_visitor_cb(data, addr, level, ptep,
> -					     KVM_PGTABLE_WALK_LEAF);
> +	if (!table && (ctx.flags & KVM_PGTABLE_WALK_LEAF)) {
> +		ret = kvm_pgtable_visitor_cb(data, &ctx, KVM_PGTABLE_WALK_LEAF);
>   		pte = *ptep;
>   		table = kvm_pte_table(pte, level);
>   	}
> @@ -218,10 +222,8 @@ static inline int __kvm_pgtable_visit(struct kvm_pgtable_walk_data *data,
>   	if (ret)
>   		goto out;
>   
> -	if (flags & KVM_PGTABLE_WALK_TABLE_POST) {
> -		ret = kvm_pgtable_visitor_cb(data, addr, level, ptep,
> -					     KVM_PGTABLE_WALK_TABLE_POST);
> -	}
> +	if (ctx.flags & KVM_PGTABLE_WALK_TABLE_POST)
> +		ret = kvm_pgtable_visitor_cb(data, &ctx, KVM_PGTABLE_WALK_TABLE_POST);
>   
>   out:
>   	return ret;
> @@ -292,13 +294,13 @@ struct leaf_walk_data {
>   	u32		level;
>   };
>   
> -static int leaf_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
> -		       enum kvm_pgtable_walk_flags flag, void * const arg)
> +static int leaf_walker(const struct kvm_pgtable_visit_ctx *ctx,
> +		       enum kvm_pgtable_walk_flags visit)
>   {
> -	struct leaf_walk_data *data = arg;
> +	struct leaf_walk_data *data = ctx->arg;
>   
> -	data->pte   = *ptep;
> -	data->level = level;
> +	data->pte   = *ctx->ptep;
> +	data->level = ctx->level;
>   
>   	return 0;
>   }
> @@ -383,47 +385,47 @@ enum kvm_pgtable_prot kvm_pgtable_hyp_pte_prot(kvm_pte_t pte)
>   	return prot;
>   }
>   
> -static bool hyp_map_walker_try_leaf(u64 addr, u64 end, u32 level,
> -				    kvm_pte_t *ptep, struct hyp_map_data *data)
> +static bool hyp_map_walker_try_leaf(const struct kvm_pgtable_visit_ctx *ctx,
> +				    struct hyp_map_data *data)
>   {
> -	kvm_pte_t new, old = *ptep;
> -	u64 granule = kvm_granule_size(level), phys = data->phys;
> +	kvm_pte_t new, old = *ctx->ptep;
> +	u64 granule = kvm_granule_size(ctx->level), phys = data->phys;
>   
> -	if (!kvm_block_mapping_supported(addr, end, phys, level))
> +	if (!kvm_block_mapping_supported(ctx, phys))
>   		return false;
>   
>   	data->phys += granule;
> -	new = kvm_init_valid_leaf_pte(phys, data->attr, level);
> +	new = kvm_init_valid_leaf_pte(phys, data->attr, ctx->level);
>   	if (old == new)
>   		return true;
>   	if (!kvm_pte_valid(old))
> -		data->mm_ops->get_page(ptep);
> +		data->mm_ops->get_page(ctx->ptep);
>   	else if (WARN_ON((old ^ new) & ~KVM_PTE_LEAF_ATTR_HI_SW))
>   		return false;
>   
> -	smp_store_release(ptep, new);
> +	smp_store_release(ctx->ptep, new);
>   	return true;
>   }
>   
> -static int hyp_map_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
> -			  enum kvm_pgtable_walk_flags flag, void * const arg)
> +static int hyp_map_walker(const struct kvm_pgtable_visit_ctx *ctx,
> +			  enum kvm_pgtable_walk_flags visit)
>   {
>   	kvm_pte_t *childp;
> -	struct hyp_map_data *data = arg;
> +	struct hyp_map_data *data = ctx->arg;
>   	struct kvm_pgtable_mm_ops *mm_ops = data->mm_ops;
>   
> -	if (hyp_map_walker_try_leaf(addr, end, level, ptep, arg))
> +	if (hyp_map_walker_try_leaf(ctx, data))
>   		return 0;
>   
> -	if (WARN_ON(level == KVM_PGTABLE_MAX_LEVELS - 1))
> +	if (WARN_ON(ctx->level == KVM_PGTABLE_MAX_LEVELS - 1))
>   		return -EINVAL;
>   
>   	childp = (kvm_pte_t *)mm_ops->zalloc_page(NULL);
>   	if (!childp)
>   		return -ENOMEM;
>   
> -	kvm_set_table_pte(ptep, childp, mm_ops);
> -	mm_ops->get_page(ptep);
> +	kvm_set_table_pte(ctx->ptep, childp, mm_ops);
> +	mm_ops->get_page(ctx->ptep);
>   	return 0;
>   }
>   
> @@ -456,39 +458,39 @@ struct hyp_unmap_data {
>   	struct kvm_pgtable_mm_ops	*mm_ops;
>   };
>   
> -static int hyp_unmap_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
> -			    enum kvm_pgtable_walk_flags flag, void * const arg)
> +static int hyp_unmap_walker(const struct kvm_pgtable_visit_ctx *ctx,
> +			    enum kvm_pgtable_walk_flags visit)
>   {
> -	kvm_pte_t pte = *ptep, *childp = NULL;
> -	u64 granule = kvm_granule_size(level);
> -	struct hyp_unmap_data *data = arg;
> +	kvm_pte_t pte = *ctx->ptep, *childp = NULL;
> +	u64 granule = kvm_granule_size(ctx->level);
> +	struct hyp_unmap_data *data = ctx->arg;
>   	struct kvm_pgtable_mm_ops *mm_ops = data->mm_ops;
>   
>   	if (!kvm_pte_valid(pte))
>   		return -EINVAL;
>   
> -	if (kvm_pte_table(pte, level)) {
> +	if (kvm_pte_table(pte, ctx->level)) {
>   		childp = kvm_pte_follow(pte, mm_ops);
>   
>   		if (mm_ops->page_count(childp) != 1)
>   			return 0;
>   
> -		kvm_clear_pte(ptep);
> +		kvm_clear_pte(ctx->ptep);
>   		dsb(ishst);
> -		__tlbi_level(vae2is, __TLBI_VADDR(addr, 0), level);
> +		__tlbi_level(vae2is, __TLBI_VADDR(ctx->addr, 0), ctx->level);
>   	} else {
> -		if (end - addr < granule)
> +		if (ctx->end - ctx->addr < granule)
>   			return -EINVAL;
>   
> -		kvm_clear_pte(ptep);
> +		kvm_clear_pte(ctx->ptep);
>   		dsb(ishst);
> -		__tlbi_level(vale2is, __TLBI_VADDR(addr, 0), level);
> +		__tlbi_level(vale2is, __TLBI_VADDR(ctx->addr, 0), ctx->level);
>   		data->unmapped += granule;
>   	}
>   
>   	dsb(ish);
>   	isb();
> -	mm_ops->put_page(ptep);
> +	mm_ops->put_page(ctx->ptep);
>   
>   	if (childp)
>   		mm_ops->put_page(childp);
> @@ -532,18 +534,18 @@ int kvm_pgtable_hyp_init(struct kvm_pgtable *pgt, u32 va_bits,
>   	return 0;
>   }
>   
> -static int hyp_free_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
> -			   enum kvm_pgtable_walk_flags flag, void * const arg)
> +static int hyp_free_walker(const struct kvm_pgtable_visit_ctx *ctx,
> +			   enum kvm_pgtable_walk_flags visit)
>   {
> -	struct kvm_pgtable_mm_ops *mm_ops = arg;
> -	kvm_pte_t pte = *ptep;
> +	struct kvm_pgtable_mm_ops *mm_ops = ctx->arg;
> +	kvm_pte_t pte = *ctx->ptep;
>   
>   	if (!kvm_pte_valid(pte))
>   		return 0;
>   
> -	mm_ops->put_page(ptep);
> +	mm_ops->put_page(ctx->ptep);
>   
> -	if (kvm_pte_table(pte, level))
> +	if (kvm_pte_table(pte, ctx->level))
>   		mm_ops->put_page(kvm_pte_follow(pte, mm_ops));
>   
>   	return 0;
> @@ -682,19 +684,19 @@ static bool stage2_pte_is_counted(kvm_pte_t pte)
>   	return !!pte;
>   }
>   
> -static void stage2_put_pte(kvm_pte_t *ptep, struct kvm_s2_mmu *mmu, u64 addr,
> -			   u32 level, struct kvm_pgtable_mm_ops *mm_ops)
> +static void stage2_put_pte(const struct kvm_pgtable_visit_ctx *ctx, struct kvm_s2_mmu *mmu,
> +			   struct kvm_pgtable_mm_ops *mm_ops)
>   {
>   	/*
>   	 * Clear the existing PTE, and perform break-before-make with
>   	 * TLB maintenance if it was valid.
>   	 */
> -	if (kvm_pte_valid(*ptep)) {
> -		kvm_clear_pte(ptep);
> -		kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, mmu, addr, level);
> +	if (kvm_pte_valid(*ctx->ptep)) {
> +		kvm_clear_pte(ctx->ptep);
> +		kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, mmu, ctx->addr, ctx->level);
>   	}
>   
> -	mm_ops->put_page(ptep);
> +	mm_ops->put_page(ctx->ptep);
>   }
>   
>   static bool stage2_pte_cacheable(struct kvm_pgtable *pgt, kvm_pte_t pte)
> @@ -708,29 +710,28 @@ static bool stage2_pte_executable(kvm_pte_t pte)
>   	return !(pte & KVM_PTE_LEAF_ATTR_HI_S2_XN);
>   }
>   
> -static bool stage2_leaf_mapping_allowed(u64 addr, u64 end, u32 level,
> +static bool stage2_leaf_mapping_allowed(const struct kvm_pgtable_visit_ctx *ctx,
>   					struct stage2_map_data *data)
>   {
> -	if (data->force_pte && (level < (KVM_PGTABLE_MAX_LEVELS - 1)))
> +	if (data->force_pte && (ctx->level < (KVM_PGTABLE_MAX_LEVELS - 1)))
>   		return false;
>   
> -	return kvm_block_mapping_supported(addr, end, data->phys, level);
> +	return kvm_block_mapping_supported(ctx, data->phys);
>   }
>   
> -static int stage2_map_walker_try_leaf(u64 addr, u64 end, u32 level,
> -				      kvm_pte_t *ptep,
> +static int stage2_map_walker_try_leaf(const struct kvm_pgtable_visit_ctx *ctx,
>   				      struct stage2_map_data *data)
>   {
> -	kvm_pte_t new, old = *ptep;
> -	u64 granule = kvm_granule_size(level), phys = data->phys;
> +	kvm_pte_t new, old = *ctx->ptep;
> +	u64 granule = kvm_granule_size(ctx->level), phys = data->phys;
>   	struct kvm_pgtable *pgt = data->mmu->pgt;
>   	struct kvm_pgtable_mm_ops *mm_ops = data->mm_ops;
>   
> -	if (!stage2_leaf_mapping_allowed(addr, end, level, data))
> +	if (!stage2_leaf_mapping_allowed(ctx, data))
>   		return -E2BIG;
>   
>   	if (kvm_phys_is_valid(phys))
> -		new = kvm_init_valid_leaf_pte(phys, data->attr, level);
> +		new = kvm_init_valid_leaf_pte(phys, data->attr, ctx->level);
>   	else
>   		new = kvm_init_invalid_leaf_owner(data->owner_id);
>   
> @@ -744,7 +745,7 @@ static int stage2_map_walker_try_leaf(u64 addr, u64 end, u32 level,
>   		if (!stage2_pte_needs_update(old, new))
>   			return -EAGAIN;
>   
> -		stage2_put_pte(ptep, data->mmu, addr, level, mm_ops);
> +		stage2_put_pte(ctx, data->mmu, mm_ops);
>   	}
>   
>   	/* Perform CMOs before installation of the guest stage-2 PTE */
> @@ -755,26 +756,25 @@ static int stage2_map_walker_try_leaf(u64 addr, u64 end, u32 level,
>   	if (mm_ops->icache_inval_pou && stage2_pte_executable(new))
>   		mm_ops->icache_inval_pou(kvm_pte_follow(new, mm_ops), granule);
>   
> -	smp_store_release(ptep, new);
> +	smp_store_release(ctx->ptep, new);
>   	if (stage2_pte_is_counted(new))
> -		mm_ops->get_page(ptep);
> +		mm_ops->get_page(ctx->ptep);
>   	if (kvm_phys_is_valid(phys))
>   		data->phys += granule;
>   	return 0;
>   }
>   
> -static int stage2_map_walk_table_pre(u64 addr, u64 end, u32 level,
> -				     kvm_pte_t *ptep,
> +static int stage2_map_walk_table_pre(const struct kvm_pgtable_visit_ctx *ctx,
>   				     struct stage2_map_data *data)
>   {
>   	if (data->anchor)
>   		return 0;
>   
> -	if (!stage2_leaf_mapping_allowed(addr, end, level, data))
> +	if (!stage2_leaf_mapping_allowed(ctx, data))
>   		return 0;
>   
> -	data->childp = kvm_pte_follow(*ptep, data->mm_ops);
> -	kvm_clear_pte(ptep);
> +	data->childp = kvm_pte_follow(*ctx->ptep, data->mm_ops);
> +	kvm_clear_pte(ctx->ptep);
>   
>   	/*
>   	 * Invalidate the whole stage-2, as we may have numerous leaf
> @@ -782,29 +782,29 @@ static int stage2_map_walk_table_pre(u64 addr, u64 end, u32 level,
>   	 * individually.
>   	 */
>   	kvm_call_hyp(__kvm_tlb_flush_vmid, data->mmu);
> -	data->anchor = ptep;
> +	data->anchor = ctx->ptep;
>   	return 0;
>   }
>   
> -static int stage2_map_walk_leaf(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
> +static int stage2_map_walk_leaf(const struct kvm_pgtable_visit_ctx *ctx,
>   				struct stage2_map_data *data)
>   {
>   	struct kvm_pgtable_mm_ops *mm_ops = data->mm_ops;
> -	kvm_pte_t *childp, pte = *ptep;
> +	kvm_pte_t *childp, pte = *ctx->ptep;
>   	int ret;
>   
>   	if (data->anchor) {
>   		if (stage2_pte_is_counted(pte))
> -			mm_ops->put_page(ptep);
> +			mm_ops->put_page(ctx->ptep);
>   
>   		return 0;
>   	}
>   
> -	ret = stage2_map_walker_try_leaf(addr, end, level, ptep, data);
> +	ret = stage2_map_walker_try_leaf(ctx, data);
>   	if (ret != -E2BIG)
>   		return ret;
>   
> -	if (WARN_ON(level == KVM_PGTABLE_MAX_LEVELS - 1))
> +	if (WARN_ON(ctx->level == KVM_PGTABLE_MAX_LEVELS - 1))
>   		return -EINVAL;
>   
>   	if (!data->memcache)
> @@ -820,16 +820,15 @@ static int stage2_map_walk_leaf(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
>   	 * will be mapped lazily.
>   	 */
>   	if (stage2_pte_is_counted(pte))
> -		stage2_put_pte(ptep, data->mmu, addr, level, mm_ops);
> +		stage2_put_pte(ctx, data->mmu, mm_ops);
>   
> -	kvm_set_table_pte(ptep, childp, mm_ops);
> -	mm_ops->get_page(ptep);
> +	kvm_set_table_pte(ctx->ptep, childp, mm_ops);
> +	mm_ops->get_page(ctx->ptep);
>   
>   	return 0;
>   }
>   
> -static int stage2_map_walk_table_post(u64 addr, u64 end, u32 level,
> -				      kvm_pte_t *ptep,
> +static int stage2_map_walk_table_post(const struct kvm_pgtable_visit_ctx *ctx,
>   				      struct stage2_map_data *data)
>   {
>   	struct kvm_pgtable_mm_ops *mm_ops = data->mm_ops;
> @@ -839,17 +838,17 @@ static int stage2_map_walk_table_post(u64 addr, u64 end, u32 level,
>   	if (!data->anchor)
>   		return 0;
>   
> -	if (data->anchor == ptep) {
> +	if (data->anchor == ctx->ptep) {
>   		childp = data->childp;
>   		data->anchor = NULL;
>   		data->childp = NULL;
> -		ret = stage2_map_walk_leaf(addr, end, level, ptep, data);
> +		ret = stage2_map_walk_leaf(ctx, data);
>   	} else {
> -		childp = kvm_pte_follow(*ptep, mm_ops);
> +		childp = kvm_pte_follow(*ctx->ptep, mm_ops);
>   	}
>   
>   	mm_ops->put_page(childp);
> -	mm_ops->put_page(ptep);
> +	mm_ops->put_page(ctx->ptep);
>   
>   	return ret;
>   }
> @@ -873,18 +872,18 @@ static int stage2_map_walk_table_post(u64 addr, u64 end, u32 level,
>    * the page-table, installing the block entry when it revisits the anchor
>    * pointer and clearing the anchor to NULL.
>    */
> -static int stage2_map_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
> -			     enum kvm_pgtable_walk_flags flag, void * const arg)
> +static int stage2_map_walker(const struct kvm_pgtable_visit_ctx *ctx,
> +			     enum kvm_pgtable_walk_flags visit)
>   {
> -	struct stage2_map_data *data = arg;
> +	struct stage2_map_data *data = ctx->arg;
>   
> -	switch (flag) {
> +	switch (visit) {
>   	case KVM_PGTABLE_WALK_TABLE_PRE:
> -		return stage2_map_walk_table_pre(addr, end, level, ptep, data);
> +		return stage2_map_walk_table_pre(ctx, data);
>   	case KVM_PGTABLE_WALK_LEAF:
> -		return stage2_map_walk_leaf(addr, end, level, ptep, data);
> +		return stage2_map_walk_leaf(ctx, data);
>   	case KVM_PGTABLE_WALK_TABLE_POST:
> -		return stage2_map_walk_table_post(addr, end, level, ptep, data);
> +		return stage2_map_walk_table_post(ctx, data);
>   	}
>   
>   	return -EINVAL;
> @@ -949,25 +948,24 @@ int kvm_pgtable_stage2_set_owner(struct kvm_pgtable *pgt, u64 addr, u64 size,
>   	return ret;
>   }
>   
> -static int stage2_unmap_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
> -			       enum kvm_pgtable_walk_flags flag,
> -			       void * const arg)
> +static int stage2_unmap_walker(const struct kvm_pgtable_visit_ctx *ctx,
> +			       enum kvm_pgtable_walk_flags visit)
>   {
> -	struct kvm_pgtable *pgt = arg;
> +	struct kvm_pgtable *pgt = ctx->arg;
>   	struct kvm_s2_mmu *mmu = pgt->mmu;
>   	struct kvm_pgtable_mm_ops *mm_ops = pgt->mm_ops;
> -	kvm_pte_t pte = *ptep, *childp = NULL;
> +	kvm_pte_t pte = *ctx->ptep, *childp = NULL;
>   	bool need_flush = false;
>   
>   	if (!kvm_pte_valid(pte)) {
>   		if (stage2_pte_is_counted(pte)) {
> -			kvm_clear_pte(ptep);
> -			mm_ops->put_page(ptep);
> +			kvm_clear_pte(ctx->ptep);
> +			mm_ops->put_page(ctx->ptep);
>   		}
>   		return 0;
>   	}
>   
> -	if (kvm_pte_table(pte, level)) {
> +	if (kvm_pte_table(pte, ctx->level)) {
>   		childp = kvm_pte_follow(pte, mm_ops);
>   
>   		if (mm_ops->page_count(childp) != 1)
> @@ -981,11 +979,11 @@ static int stage2_unmap_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
>   	 * block entry and rely on the remaining portions being faulted
>   	 * back lazily.
>   	 */
> -	stage2_put_pte(ptep, mmu, addr, level, mm_ops);
> +	stage2_put_pte(ctx, mmu, mm_ops);
>   
>   	if (need_flush && mm_ops->dcache_clean_inval_poc)
>   		mm_ops->dcache_clean_inval_poc(kvm_pte_follow(pte, mm_ops),
> -					       kvm_granule_size(level));
> +					       kvm_granule_size(ctx->level));
>   
>   	if (childp)
>   		mm_ops->put_page(childp);
> @@ -1012,18 +1010,17 @@ struct stage2_attr_data {
>   	struct kvm_pgtable_mm_ops	*mm_ops;
>   };
>   
> -static int stage2_attr_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
> -			      enum kvm_pgtable_walk_flags flag,
> -			      void * const arg)
> +static int stage2_attr_walker(const struct kvm_pgtable_visit_ctx *ctx,
> +			      enum kvm_pgtable_walk_flags visit)
>   {
> -	kvm_pte_t pte = *ptep;
> -	struct stage2_attr_data *data = arg;
> +	kvm_pte_t pte = *ctx->ptep;
> +	struct stage2_attr_data *data = ctx->arg;
>   	struct kvm_pgtable_mm_ops *mm_ops = data->mm_ops;
>   
>   	if (!kvm_pte_valid(pte))
>   		return 0;
>   
> -	data->level = level;
> +	data->level = ctx->level;
>   	data->pte = pte;
>   	pte &= ~data->attr_clr;
>   	pte |= data->attr_set;
> @@ -1039,10 +1036,10 @@ static int stage2_attr_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
>   		 * stage-2 PTE if we are going to add executable permission.
>   		 */
>   		if (mm_ops->icache_inval_pou &&
> -		    stage2_pte_executable(pte) && !stage2_pte_executable(*ptep))
> +		    stage2_pte_executable(pte) && !stage2_pte_executable(*ctx->ptep))
>   			mm_ops->icache_inval_pou(kvm_pte_follow(pte, mm_ops),
> -						  kvm_granule_size(level));
> -		WRITE_ONCE(*ptep, pte);
> +						  kvm_granule_size(ctx->level));
> +		WRITE_ONCE(*ctx->ptep, pte);
>   	}
>   
>   	return 0;
> @@ -1140,20 +1137,19 @@ int kvm_pgtable_stage2_relax_perms(struct kvm_pgtable *pgt, u64 addr,
>   	return ret;
>   }
>   
> -static int stage2_flush_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
> -			       enum kvm_pgtable_walk_flags flag,
> -			       void * const arg)
> +static int stage2_flush_walker(const struct kvm_pgtable_visit_ctx *ctx,
> +			       enum kvm_pgtable_walk_flags visit)
>   {
> -	struct kvm_pgtable *pgt = arg;
> +	struct kvm_pgtable *pgt = ctx->arg;
>   	struct kvm_pgtable_mm_ops *mm_ops = pgt->mm_ops;
> -	kvm_pte_t pte = *ptep;
> +	kvm_pte_t pte = *ctx->ptep;
>   
>   	if (!kvm_pte_valid(pte) || !stage2_pte_cacheable(pgt, pte))
>   		return 0;
>   
>   	if (mm_ops->dcache_clean_inval_poc)
>   		mm_ops->dcache_clean_inval_poc(kvm_pte_follow(pte, mm_ops),
> -					       kvm_granule_size(level));
> +					       kvm_granule_size(ctx->level));
>   	return 0;
>   }
>   
> @@ -1200,19 +1196,18 @@ int __kvm_pgtable_stage2_init(struct kvm_pgtable *pgt, struct kvm_s2_mmu *mmu,
>   	return 0;
>   }
>   
> -static int stage2_free_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
> -			      enum kvm_pgtable_walk_flags flag,
> -			      void * const arg)
> +static int stage2_free_walker(const struct kvm_pgtable_visit_ctx *ctx,
> +			      enum kvm_pgtable_walk_flags visit)
>   {
> -	struct kvm_pgtable_mm_ops *mm_ops = arg;
> -	kvm_pte_t pte = *ptep;
> +	struct kvm_pgtable_mm_ops *mm_ops = ctx->arg;
> +	kvm_pte_t pte = *ctx->ptep;
>   
>   	if (!stage2_pte_is_counted(pte))
>   		return 0;
>   
> -	mm_ops->put_page(ptep);
> +	mm_ops->put_page(ctx->ptep);
>   
> -	if (kvm_pte_table(pte, level))
> +	if (kvm_pte_table(pte, ctx->level))
>   		mm_ops->put_page(kvm_pte_follow(pte, mm_ops));
>   
>   	return 0;
> 

Thanks,
Gavin

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
