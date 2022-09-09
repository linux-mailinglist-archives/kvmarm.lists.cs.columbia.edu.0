Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 73C835B34CD
	for <lists+kvmarm@lfdr.de>; Fri,  9 Sep 2022 12:08:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 916E64CADA;
	Fri,  9 Sep 2022 06:08:16 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, RCVD_IN_DNSWL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
	T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@linux.dev
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Bow+znU1EVSE; Fri,  9 Sep 2022 06:08:16 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0FDF14CA1A;
	Fri,  9 Sep 2022 06:08:15 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 895104C8D9
 for <kvmarm@lists.cs.columbia.edu>; Fri,  9 Sep 2022 06:08:13 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bzqBlpdAeyKw for <kvmarm@lists.cs.columbia.edu>;
 Fri,  9 Sep 2022 06:08:11 -0400 (EDT)
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id F1E954C8CC
 for <kvmarm@lists.cs.columbia.edu>; Fri,  9 Sep 2022 06:08:10 -0400 (EDT)
Date: Fri, 9 Sep 2022 11:07:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1662718090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gNzaPZG1mLQyJyRsZVtVFOttl8uuZk01rBnRTGZpE+s=;
 b=uk4H9WhHFnTUkmuLpAFALPIaa+FU2UKVZ2XPdSwdnhtmtIobV8lxEqLkVO7Y7jbn01QNbB
 1IXt1sYeBb3Il0++CysKXgK+Hj0N/NTHW8+zOLFKdpKtjUJ+HWy/8ou2g7YtsfTllff+lu
 2L610rpZepsKnUQVPIxZalH6CRJXp8U=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: David Matlack <dmatlack@google.com>
Subject: Re: [PATCH 02/14] KVM: arm64: Tear down unlinked stage-2 subtree
 after break-before-make
Message-ID: <YxsQfwJ++izBQuEi@google.com>
References: <20220830194132.962932-1-oliver.upton@linux.dev>
 <20220830194132.962932-3-oliver.upton@linux.dev>
 <YxkFrSmSKdBFEoZp@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YxkFrSmSKdBFEoZp@google.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Cc: kvm@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Ben Gardon <bgardon@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
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

On Wed, Sep 07, 2022 at 01:57:17PM -0700, David Matlack wrote:
> On Tue, Aug 30, 2022 at 07:41:20PM +0000, Oliver Upton wrote:
> [...]
> >  
> > +static int stage2_map_walk_leaf(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
> > +				struct stage2_map_data *data);
> > +
> >  static int stage2_map_walk_table_pre(u64 addr, u64 end, u32 level,
> >  				     kvm_pte_t *ptep,
> >  				     struct stage2_map_data *data)
> >  {
> > -	if (data->anchor)
> 
> Should @anchor and @childp be removed from struct stage2_map_data? This
> commit removes the only remaining references to them.

Yup, I'll toss those in the next spin.

> > -		return 0;
> > +	struct kvm_pgtable_mm_ops *mm_ops = data->mm_ops;
> > +	kvm_pte_t *childp = kvm_pte_follow(*ptep, mm_ops);
> > +	struct kvm_pgtable *pgt = data->mmu->pgt;
> > +	int ret;
> >  
> >  	if (!stage2_leaf_mapping_allowed(addr, end, level, data))
> >  		return 0;
> >  
> > -	data->childp = kvm_pte_follow(*ptep, data->mm_ops);
> >  	kvm_clear_pte(ptep);
> >  
> >  	/*
> [...]
> >  static int stage2_map_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
> >  			     enum kvm_pgtable_walk_flags flag, void * const arg)
> > @@ -883,11 +849,9 @@ static int stage2_map_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
> >  		return stage2_map_walk_table_pre(addr, end, level, ptep, data);
> >  	case KVM_PGTABLE_WALK_LEAF:
> >  		return stage2_map_walk_leaf(addr, end, level, ptep, data);
> > -	case KVM_PGTABLE_WALK_TABLE_POST:
> > -		return stage2_map_walk_table_post(addr, end, level, ptep, data);
> 
> kvm_pgtable_stage2_set_owner() still uses stage2_map_walker() with
> KVM_PGTABLE_WALK_TABLE_POST.

Good catch, I'll drop the TABLE_POST flag there as well.

Appreciate the reviews on the series.

--
Thanks,
Oliver
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
