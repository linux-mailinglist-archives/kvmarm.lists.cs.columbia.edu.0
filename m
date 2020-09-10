Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id EC3CB264625
	for <lists+kvmarm@lfdr.de>; Thu, 10 Sep 2020 14:37:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7EE254B422;
	Thu, 10 Sep 2020 08:37:22 -0400 (EDT)
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
	with ESMTP id keBecY-HxS5h; Thu, 10 Sep 2020 08:37:22 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 568F14B447;
	Thu, 10 Sep 2020 08:37:21 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3378D4B32E
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Sep 2020 08:37:20 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sXaXp6R1-DiE for <kvmarm@lists.cs.columbia.edu>;
 Thu, 10 Sep 2020 08:37:19 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 384D54B2F9
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Sep 2020 08:37:19 -0400 (EDT)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 69CA5208FE;
 Thu, 10 Sep 2020 12:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599741438;
 bh=FGth1o3am16uP55EdKwFtATWQdN/7+WK6TzP56kkx+k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=yGE4pFuEHg699m/skrZByTfKE9pun1HDxnxC3pdrxDV/uyySMADeeyXVqPrPg6sZz
 9R4wDEEK3/Lv5Tm446Nq3WB7+SALOrl4lkFAxGYLBBZ2WawixNGLT6CIzgf1YUZB2I
 c9p4mDXRuZrdvpvvz7v9v41Id8ezbVCA3XYnFto8=
Date: Thu, 10 Sep 2020 13:37:13 +0100
From: Will Deacon <will@kernel.org>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Subject: Re: [PATCH v4 02/21] KVM: arm64: Add stand-alone page-table walker
 infrastructure
Message-ID: <20200910123712.GB18100@willie-the-truck>
References: <20200907152344.12978-1-will@kernel.org>
 <20200907152344.12978-3-will@kernel.org>
 <4ef01cff-71ac-7f3c-2404-af184f5a5cb4@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4ef01cff-71ac-7f3c-2404-af184f5a5cb4@arm.com>
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

On Wed, Sep 09, 2020 at 04:29:26PM +0100, Alexandru Elisei wrote:
> On 9/7/20 4:23 PM, Will Deacon wrote:
> > [..]
> > +
> > +int kvm_pgtable_walk(struct kvm_pgtable *pgt, u64 addr, u64 size,
> > +		     struct kvm_pgtable_walker *walker)
> > +{
> > +	struct kvm_pgtable_walk_data walk_data = {
> > +		.pgt	= pgt,
> > +		.addr	= ALIGN_DOWN(addr, PAGE_SIZE),
> > +		.end	= PAGE_ALIGN(walk_data.addr + size),
> > +		.walker	= walker,
> > +	};
> 
> If the caller wants to walk [0x500, 0x1500), for PAGE_SIZE = 0x1000 (4K), the
> function walks the range [0x0, 0x1000). Is that intentional?

Yes, although the caller specifies a base and a *size*, rather than an end
address. As a concrete example, much of the hypervisor stage-1 mapping
is created using PAGE_SIZE mappings of random ELF symbols, which correspond
to arbitrary addresses. In these cases, we really do want to round-down the
address and perform a PAGE_SIZE mapping.

The alternative would be to return an error if the size is not page-aligned,
but I don't think that's really necessary, especially since we accept an
unaligned base.

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
