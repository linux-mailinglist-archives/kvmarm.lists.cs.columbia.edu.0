Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id F06B639759E
	for <lists+kvmarm@lfdr.de>; Tue,  1 Jun 2021 16:38:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 58AE24A4A4;
	Tue,  1 Jun 2021 10:38:30 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ig2joqxkjsH3; Tue,  1 Jun 2021 10:38:30 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0F3A64A3B4;
	Tue,  1 Jun 2021 10:38:29 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CF7244A32E
 for <kvmarm@lists.cs.columbia.edu>; Tue,  1 Jun 2021 10:38:27 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id riOeleJY+GWs for <kvmarm@lists.cs.columbia.edu>;
 Tue,  1 Jun 2021 10:38:26 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 8D3224A2E5
 for <kvmarm@lists.cs.columbia.edu>; Tue,  1 Jun 2021 10:38:26 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 73E7B61375;
 Tue,  1 Jun 2021 14:38:25 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1lo5XD-004q07-As; Tue, 01 Jun 2021 15:38:23 +0100
Date: Tue, 01 Jun 2021 15:38:22 +0100
Message-ID: <87k0nd1wgx.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Quentin Perret <qperret@google.com>
Subject: Re: [PATCH 3/7] KVM: arm64: Remove list_head from hyp_page
In-Reply-To: <20210527125134.2116404-4-qperret@google.com>
References: <20210527125134.2116404-1-qperret@google.com>
 <20210527125134.2116404-4-qperret@google.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: qperret@google.com, will@kernel.org, james.morse@arm.com,
 alexandru.elisei@arm.com, catalin.marinas@arm.com, suzuki.poulose@arm.com,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kernel-team@android.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, will@kernel.org, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
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

On Thu, 27 May 2021 13:51:30 +0100,
Quentin Perret <qperret@google.com> wrote:
> 
> The list_head member of struct hyp_page is only needed when the page is
> attached to a free-list, which by definition implies the page is free.
> As such, nothing prevents us from using the page itself to store the
> list_head, hence reducing the size of the vmemmap.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/kvm/hyp/include/nvhe/memory.h |  1 -
>  arch/arm64/kvm/hyp/nvhe/page_alloc.c     | 39 ++++++++++++++++++++----
>  2 files changed, 33 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp/include/nvhe/memory.h b/arch/arm64/kvm/hyp/include/nvhe/memory.h
> index fd78bde939ee..7691ab495eb4 100644
> --- a/arch/arm64/kvm/hyp/include/nvhe/memory.h
> +++ b/arch/arm64/kvm/hyp/include/nvhe/memory.h
> @@ -12,7 +12,6 @@ struct hyp_page {
>  	unsigned int refcount;
>  	unsigned int order;
>  	struct hyp_pool *pool;
> -	struct list_head node;
>  };
>  
>  extern u64 __hyp_vmemmap;
> diff --git a/arch/arm64/kvm/hyp/nvhe/page_alloc.c b/arch/arm64/kvm/hyp/nvhe/page_alloc.c
> index 7ee882f36767..ce7379f1480b 100644
> --- a/arch/arm64/kvm/hyp/nvhe/page_alloc.c
> +++ b/arch/arm64/kvm/hyp/nvhe/page_alloc.c
> @@ -62,6 +62,34 @@ static struct hyp_page *__find_buddy_avail(struct hyp_pool *pool,
>  
>  }
>  
> +/*
> + * Pages that are available for allocation are tracked in free-lists, so we use
> + * the pages themselves to store the list nodes to avoid wasting space. As the
> + * allocator always returns zeroed pages (which are zeroed on the hyp_put_page()
> + * path to optimize allocation speed), we also need to clean-up the list node in
> + * each page when we take it out of the list.
> + */
> +static inline void page_remove_from_list(struct hyp_page *p)
> +{
> +	struct list_head *node = (struct list_head *)hyp_page_to_virt(p);

Nit: How about changing hyp_page_to_virt() so that it returns a
convenient 'void *', and get rid of the ugly casts?

> +
> +	__list_del_entry(node);
> +	memset(node, 0, sizeof(*node));
> +}
> +
> +static inline void page_add_to_list(struct hyp_page *p, struct list_head *head)
> +{
> +	struct list_head *node = (struct list_head *)hyp_page_to_virt(p);
> +
> +	INIT_LIST_HEAD(node);
> +	list_add_tail(node, head);
> +}
> +
> +static inline struct hyp_page *node_to_page(struct list_head *node)
> +{
> +	return (struct hyp_page *)hyp_virt_to_page(node);

Why is this cast necessary? If I'm not mistaken, hyp_vmemmap is
already cast as a 'struct hyp_page *', so hyp_virt_to_page() should
return the same type.

> +}
> +
>  static void __hyp_attach_page(struct hyp_pool *pool,
>  			      struct hyp_page *p)
>  {
> @@ -83,14 +111,14 @@ static void __hyp_attach_page(struct hyp_pool *pool,
>  			break;
>  
>  		/* Take the buddy out of its list, and coallesce with @p */
> -		list_del_init(&buddy->node);
> +		page_remove_from_list(buddy);
>  		buddy->order = HYP_NO_ORDER;
>  		p = min(p, buddy);
>  	}
>  
>  	/* Mark the new head, and insert it */
>  	p->order = order;
> -	list_add_tail(&p->node, &pool->free_area[order]);
> +	page_add_to_list(p, &pool->free_area[order]);
>  }
>  
>  static struct hyp_page *__hyp_extract_page(struct hyp_pool *pool,
> @@ -99,7 +127,7 @@ static struct hyp_page *__hyp_extract_page(struct hyp_pool *pool,
>  {
>  	struct hyp_page *buddy;
>  
> -	list_del_init(&p->node);
> +	page_remove_from_list(p);
>  	while (p->order > order) {
>  		/*
>  		 * The buddy of order n - 1 currently has HYP_NO_ORDER as it
> @@ -110,7 +138,7 @@ static struct hyp_page *__hyp_extract_page(struct hyp_pool *pool,
>  		p->order--;
>  		buddy = __find_buddy_nocheck(pool, p, p->order);
>  		buddy->order = p->order;
> -		list_add_tail(&buddy->node, &pool->free_area[buddy->order]);
> +		page_add_to_list(buddy, &pool->free_area[buddy->order]);
>  	}
>  
>  	return p;
> @@ -158,7 +186,7 @@ void *hyp_alloc_pages(struct hyp_pool *pool, unsigned int order)
>  	}
>  
>  	/* Extract it from the tree at the right order */
> -	p = list_first_entry(&pool->free_area[i], struct hyp_page, node);
> +	p = node_to_page(pool->free_area[i].next);
>  	p = __hyp_extract_page(pool, p, order);
>  
>  	hyp_set_page_refcounted(p);
> @@ -186,7 +214,6 @@ int hyp_pool_init(struct hyp_pool *pool, u64 pfn, unsigned int nr_pages,
>  	for (i = 0; i < nr_pages; i++) {
>  		p[i].pool = pool;
>  		p[i].order = 0;
> -		INIT_LIST_HEAD(&p[i].node);
>  		hyp_set_page_refcounted(&p[i]);
>  	}
>  
> -- 
> 2.31.1.818.g46aad6cb9e-goog
> 
> 

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
