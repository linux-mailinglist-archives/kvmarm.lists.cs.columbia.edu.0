Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 08C786059D5
	for <lists+kvmarm@lfdr.de>; Thu, 20 Oct 2022 10:32:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DC5704B93D;
	Thu, 20 Oct 2022 04:32:36 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.79
X-Spam-Level: 
X-Spam-Status: No, score=-1.79 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@linux.dev
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OuRGmDnC7XTk; Thu, 20 Oct 2022 04:32:36 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 541694B944;
	Thu, 20 Oct 2022 04:32:35 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 99CFE4B93B
 for <kvmarm@lists.cs.columbia.edu>; Thu, 20 Oct 2022 04:32:34 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id INYUUIdqAst2 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 20 Oct 2022 04:32:32 -0400 (EDT)
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id CD8F34B935
 for <kvmarm@lists.cs.columbia.edu>; Thu, 20 Oct 2022 04:32:32 -0400 (EDT)
Date: Thu, 20 Oct 2022 11:32:28 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1666254751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ctJTA03g4S212w2fsHSI6DaGgRDXgMSNX17PNK39G/0=;
 b=pgyjDfj23srvir/0JWPCeon9S2icBTGfjwie/jgTm29lfHFUB5MWMUQC2NOCYHM+Ev6Kwu
 vYfDqUZn9trZqo950qlzCnTvt9p28mC3423MnKGH9g/cZ6eb9s50soaCKfJQLzQJkzCN7N
 sIVBDEL8fDY+TEzFGGrstuX4JGlSOfY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH v2 07/15] KVM: arm64: Use an opaque type for pteps
Message-ID: <Y1EHnFN2Goj2eLkE@google.com>
References: <20221007232818.459650-1-oliver.upton@linux.dev>
 <20221007232818.459650-8-oliver.upton@linux.dev>
 <Y1CFl8sLllXm4seK@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y1CFl8sLllXm4seK@google.com>
X-Migadu-Flow: FLOW_OUT
Cc: kvm@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, kvmarm@lists.linux.dev,
 Ben Gardon <bgardon@google.com>, David Matlack <dmatlack@google.com>,
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

On Wed, Oct 19, 2022 at 11:17:43PM +0000, Sean Christopherson wrote:
> On Fri, Oct 07, 2022, Oliver Upton wrote:
> > Use an opaque type for pteps and require visitors explicitly dereference
> > the pointer before using. Protecting page table memory with RCU requires
> > that KVM dereferences RCU-annotated pointers before using. However, RCU
> > is not available for use in the nVHE hypervisor and the opaque type can
> > be conditionally annotated with RCU for the stage-2 MMU.
> > 
> > Call the type a 'pteref' to avoid a naming collision with raw pteps. No
> > functional change intended.
> > 
> > Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
> > ---
> >  arch/arm64/include/asm/kvm_pgtable.h |  9 ++++++++-
> >  arch/arm64/kvm/hyp/pgtable.c         | 23 ++++++++++++-----------
> >  2 files changed, 20 insertions(+), 12 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
> > index c33edcf36b5b..beb89eac155c 100644
> > --- a/arch/arm64/include/asm/kvm_pgtable.h
> > +++ b/arch/arm64/include/asm/kvm_pgtable.h
> > @@ -25,6 +25,13 @@ static inline u64 kvm_get_parange(u64 mmfr0)
> >  
> >  typedef u64 kvm_pte_t;
> >  
> > +typedef kvm_pte_t *kvm_pteref_t;
> > +
> > +static inline kvm_pte_t *kvm_dereference_pteref(kvm_pteref_t pteref, bool shared)
> > +{
> > +	return pteref;
> 
> Returning the pointer is unsafe (when it becomes RCU-protected).  The full
> dereference of the data needs to occur under RCU protection, not just the retrieval
> of the pointer.  E.g. this (straw man) would be broken
> 
> 	bool table = kvm_pte_table(ctx.old, level);
> 
> 	rcu_read_lock();
> 	ptep = kvm_dereference_pteref(pteref, flags & KVM_PGTABLE_WALK_SHARED);
> 	rcu_read_unlock();
> 
> 	if (table && (ctx.flags & KVM_PGTABLE_WALK_TABLE_PRE))
> 		ret = kvm_pgtable_visitor_cb(data, &ctx, KVM_PGTABLE_WALK_TABLE_PRE);
> 
> 	if (!table && (ctx.flags & KVM_PGTABLE_WALK_LEAF)) {
> 		ret = kvm_pgtable_visitor_cb(data, &ctx, KVM_PGTABLE_WALK_LEAF);
> 		ctx.old = READ_ONCE(*ptep);
> 		table = kvm_pte_table(ctx.old, level);
> 	}
> 
> as the read of the entry pointed at by ptep could be to a page table that is freed
> in an RCU callback.
> 
> The naming collision you are trying to avoid is a symptom of this bad pattern,
> as there should never be "raw" pteps floating around, at least not in non-pKVM
> contexts that utilize RCU.

Fair enough, this was mostly from an attempt to avoid churn in the
visitor callbacks by adding more layering for reads/writes through RCU
pointers. The lifetime of the raw pointer is 'safe' as it sits on the
stack and we go behind the rcu lock much further up.

> > +}
> > +
> >  #define KVM_PTE_VALID			BIT(0)
> >  
> >  #define KVM_PTE_ADDR_MASK		GENMASK(47, PAGE_SHIFT)
> > @@ -170,7 +177,7 @@ typedef bool (*kvm_pgtable_force_pte_cb_t)(u64 addr, u64 end,
> >  struct kvm_pgtable {
> >  	u32					ia_bits;
> >  	u32					start_level;
> > -	kvm_pte_t				*pgd;
> > +	kvm_pteref_t				pgd;
> >  	struct kvm_pgtable_mm_ops		*mm_ops;
> >  
> >  	/* Stage-2 only */
> > diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> > index 02c33fccb178..6b6e1ed7ee2f 100644
> > --- a/arch/arm64/kvm/hyp/pgtable.c
> > +++ b/arch/arm64/kvm/hyp/pgtable.c
> > @@ -175,13 +175,14 @@ static int kvm_pgtable_visitor_cb(struct kvm_pgtable_walk_data *data,
> >  }
> >  
> >  static int __kvm_pgtable_walk(struct kvm_pgtable_walk_data *data,
> > -			      struct kvm_pgtable_mm_ops *mm_ops, kvm_pte_t *pgtable, u32 level);
> > +			      struct kvm_pgtable_mm_ops *mm_ops, kvm_pteref_t pgtable, u32 level);
> >  
> >  static inline int __kvm_pgtable_visit(struct kvm_pgtable_walk_data *data,
> >  				      struct kvm_pgtable_mm_ops *mm_ops,
> > -				      kvm_pte_t *ptep, u32 level)
> > +				      kvm_pteref_t pteref, u32 level)
> >  {
> >  	enum kvm_pgtable_walk_flags flags = data->walker->flags;
> > +	kvm_pte_t *ptep = kvm_dereference_pteref(pteref, false);
> >  	struct kvm_pgtable_visit_ctx ctx = {
> >  		.ptep	= ptep,
> >  		.old	= READ_ONCE(*ptep),
> 
> This is where you want the protection to kick in, e.g. 
> 
>   typedef kvm_pte_t __rcu *kvm_ptep_t;
> 
>   static inline kvm_pte_t kvm_read_pte(kvm_ptep_t ptep)
>   {
> 	return READ_ONCE(*rcu_dereference(ptep));
>   }
> 
> 		.old	= kvm_read_pte(ptep),
> 
> In other words, the pointer itself isn't that's protected, it's PTE that the
> pointer points at that's protected.

Right, but practically speaking it is the boundary at which we assert
that protection.

Anyhow, I'll look at abstracting the actual memory accesses in the
visitors without too much mess.

--
Thanks,
Oliver
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
