Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 77DA73D8D95
	for <lists+kvmarm@lfdr.de>; Wed, 28 Jul 2021 14:17:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 075204B096;
	Wed, 28 Jul 2021 08:17:13 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jP2FU3vnNK+X; Wed, 28 Jul 2021 08:17:12 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CDC8F4B092;
	Wed, 28 Jul 2021 08:17:11 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 54AC74AEDC
 for <kvmarm@lists.cs.columbia.edu>; Wed, 28 Jul 2021 08:17:10 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tAUInoEiNX0B for <kvmarm@lists.cs.columbia.edu>;
 Wed, 28 Jul 2021 08:17:09 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id F23804A195
 for <kvmarm@lists.cs.columbia.edu>; Wed, 28 Jul 2021 08:17:08 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E5AE560F46;
 Wed, 28 Jul 2021 12:17:07 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1m8iUj-001Wc7-UM; Wed, 28 Jul 2021 13:17:06 +0100
Date: Wed, 28 Jul 2021 13:17:05 +0100
Message-ID: <87sfzyd45a.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Subject: Re: [PATCH v2 1/6] KVM: arm64: Introduce helper to retrieve a PTE and
 its level
In-Reply-To: <11d5e176-ac47-e215-b82a-b8f074220bd6@arm.com>
References: <20210726153552.1535838-1-maz@kernel.org>
 <20210726153552.1535838-2-maz@kernel.org>
 <11d5e176-ac47-e215-b82a-b8f074220bd6@arm.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: alexandru.elisei@arm.com,
 linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, linux-mm@kvack.org, seanjc@google.com,
 willy@infradead.org, pbonzini@redhat.com, will@kernel.org, qperret@google.com,
 james.morse@arm.com, suzuki.poulose@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, kvm@vger.kernel.org,
 Sean Christopherson <seanjc@google.com>, Matthew Wilcox <willy@infradead.org>,
 linux-mm@kvack.org, Paolo Bonzini <pbonzini@redhat.com>,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
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

Hi Alex,

On Tue, 27 Jul 2021 16:25:34 +0100,
Alexandru Elisei <alexandru.elisei@arm.com> wrote:
> 
> Hi Marc,
> 
> On 7/26/21 4:35 PM, Marc Zyngier wrote:
> > It is becoming a common need to fetch the PTE for a given address
> > together with its level. Add such a helper.
> >
> > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > ---
> >  arch/arm64/include/asm/kvm_pgtable.h | 19 ++++++++++++++
> >  arch/arm64/kvm/hyp/pgtable.c         | 39 ++++++++++++++++++++++++++++
> >  2 files changed, 58 insertions(+)
> >
> > diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
> > index f004c0115d89..082b9d65f40b 100644
> > --- a/arch/arm64/include/asm/kvm_pgtable.h
> > +++ b/arch/arm64/include/asm/kvm_pgtable.h
> > @@ -432,6 +432,25 @@ int kvm_pgtable_stage2_flush(struct kvm_pgtable *pgt, u64 addr, u64 size);
> >  int kvm_pgtable_walk(struct kvm_pgtable *pgt, u64 addr, u64 size,
> >  		     struct kvm_pgtable_walker *walker);
> >  
> > +/**
> > + * kvm_pgtable_get_leaf() - Walk a page-table and retrieve the leaf entry
> > + *			    with its level.
> > + * @pgt:	Page-table structure initialised by kvm_pgtable_*_init().
> 
> Yet in the next patch you use a struct kvm_pgtable_pgt not
> initialized by any of the kvm_pgtable_*_init() functions. It doesn't
> hurt correctness, but it might confuse potential users of this
> function.

Fair enough. I'll add something like "[...] or any similar initialisation".

> 
> > + * @addr:	Input address for the start of the walk.
> > + * @ptep:	Pointer to storage for the retrieved PTE.
> > + * @level:	Pointer to storage for the level of the retrieved PTE.
> > + *
> > + * The offset of @addr within a page is ignored.
> > + *
> > + * The walker will walk the page-table entries corresponding to the input
> > + * address specified, retrieving the leaf corresponding to this address.
> > + * Invalid entries are treated as leaf entries.
> > + *
> > + * Return: 0 on success, negative error code on failure.
> > + */
> > +int kvm_pgtable_get_leaf(struct kvm_pgtable *pgt, u64 addr,
> > +			 kvm_pte_t *ptep, u32 *level);
> > +
> >  /**
> >   * kvm_pgtable_stage2_find_range() - Find a range of Intermediate Physical
> >   *				     Addresses with compatible permission
> > diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> > index 05321f4165e3..78f36bd5df6c 100644
> > --- a/arch/arm64/kvm/hyp/pgtable.c
> > +++ b/arch/arm64/kvm/hyp/pgtable.c
> > @@ -326,6 +326,45 @@ int kvm_pgtable_walk(struct kvm_pgtable *pgt, u64 addr, u64 size,
> >  	return _kvm_pgtable_walk(&walk_data);
> >  }
> >  
> > +struct leaf_walk_data {
> > +	kvm_pte_t	pte;
> > +	u32		level;
> > +};
> > +
> > +static int leaf_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
> > +		       enum kvm_pgtable_walk_flags flag, void * const arg)
> > +{
> > +	struct leaf_walk_data *data = arg;
> > +
> > +	data->pte   = *ptep;
> > +	data->level = level;
> > +
> > +	return 0;
> > +}
> > +
> > +int kvm_pgtable_get_leaf(struct kvm_pgtable *pgt, u64 addr,
> > +			 kvm_pte_t *ptep, u32 *level)
> > +{
> > +	struct leaf_walk_data data;
> > +	struct kvm_pgtable_walker walker = {
> > +		.cb	= leaf_walker,
> > +		.flags	= KVM_PGTABLE_WALK_LEAF,
> > +		.arg	= &data,
> > +	};
> > +	int ret;
> > +
> > +	ret = kvm_pgtable_walk(pgt, ALIGN_DOWN(addr, PAGE_SIZE),
> > +			       PAGE_SIZE, &walker);
> 
> kvm_pgtable_walk() already aligns addr down to PAGE_SIZE, I don't
> think that's needed here. But not harmful either.

It is more that if you don't align it down, the size becomes awkward
to express. Masking is both cheap and readable.

> 
> Otherwise, the patch looks good to me:
> 
> Reviewed-by: Alexandru Elisei <alexandru.elisei@arm.com>

Thanks!

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
