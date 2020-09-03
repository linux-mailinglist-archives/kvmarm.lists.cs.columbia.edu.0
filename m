Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 414DD25C768
	for <lists+kvmarm@lfdr.de>; Thu,  3 Sep 2020 18:48:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C01E94B2BC;
	Thu,  3 Sep 2020 12:48:41 -0400 (EDT)
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
	with ESMTP id s6BY+Kfx2sKV; Thu,  3 Sep 2020 12:48:41 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 99C814B2A4;
	Thu,  3 Sep 2020 12:48:40 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 17B8D4B290
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Sep 2020 12:48:39 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6t182bfUh7n2 for <kvmarm@lists.cs.columbia.edu>;
 Thu,  3 Sep 2020 12:48:38 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 0A18F4B28B
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Sep 2020 12:48:38 -0400 (EDT)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7D877208CA;
 Thu,  3 Sep 2020 16:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599151717;
 bh=8+S06Uyiw3SdnFNgrCZYHgr4j30sYSqjN45fSt4L5w4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=viVwj85lNLsnzzH7NV5X6ikkc60lwFlhPULIZQQZwxjWUcdIVDAfsUCyAfp7I+I00
 57PpxIhXayZtfLpPD6GiB/xJPlRqmEHHyu0qwWtLvjlvMw4TOOPylqO+J0RhaRLSpM
 SnIAFC/SDTbcCktxsA/Rx/0xkwDmpyJsVTJYv3aU=
Date: Thu, 3 Sep 2020 17:48:32 +0100
From: Will Deacon <will@kernel.org>
To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v3 10/21] KVM: arm64: Add support for stage-2 page-aging
 in generic page-table
Message-ID: <20200903164832.GB7791@willie-the-truck>
References: <20200825093953.26493-1-will@kernel.org>
 <20200825093953.26493-11-will@kernel.org>
 <cbf5a908-9e15-d0bb-459e-b5289d8a3ad8@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cbf5a908-9e15-d0bb-459e-b5289d8a3ad8@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Marc Zyngier <maz@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
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

On Thu, Sep 03, 2020 at 02:33:22PM +1000, Gavin Shan wrote:
> On 8/25/20 7:39 PM, Will Deacon wrote:
> > Add stage-2 mkyoung(), mkold() and is_young() operations to the generic
> > page-table code.
> > 
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Quentin Perret <qperret@google.com>
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> >   arch/arm64/include/asm/kvm_pgtable.h | 38 ++++++++++++
> >   arch/arm64/kvm/hyp/pgtable.c         | 86 ++++++++++++++++++++++++++++
> >   2 files changed, 124 insertions(+)

[...]

> > +static int stage2_update_leaf_attrs(struct kvm_pgtable *pgt, u64 addr,
> > +				    u64 size, kvm_pte_t attr_set,
> > +				    kvm_pte_t attr_clr, kvm_pte_t *orig_pte)
> > +{
> > +	int ret;
> > +	kvm_pte_t attr_mask = KVM_PTE_LEAF_ATTR_LO | KVM_PTE_LEAF_ATTR_HI;
> > +	struct stage2_attr_data data = {
> > +		.attr_set	= attr_set & attr_mask,
> > +		.attr_clr	= attr_clr & attr_mask,
> > +	};
> > +	struct kvm_pgtable_walker walker = {
> > +		.cb		= stage2_attr_walker,
> > +		.arg		= &data,
> > +		.flags		= KVM_PGTABLE_WALK_LEAF,
> > +	};
> > +
> > +	ret = kvm_pgtable_walk(pgt, addr, size, &walker);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (orig_pte)
> > +		*orig_pte = data.pte;
> > +	return 0;
> > +}
> > +
> 
> The @size is always 1 from the caller, which means the parameter
> can be dropped from stage2_update_leaf_attrs(). In the meanwhile,
> we don't know the page is mapped by PUD, PMD or PTE. So to have
> fixed value ("1") looks meaningless.

I add extra callers later on, for example kvm_pgtable_stage2_wrprotect(),
which pass a size, so it's needed for that.

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
