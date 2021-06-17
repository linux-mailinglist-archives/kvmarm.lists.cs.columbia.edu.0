Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E1BA93AB48F
	for <lists+kvmarm@lfdr.de>; Thu, 17 Jun 2021 15:21:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 533284A522;
	Thu, 17 Jun 2021 09:21:26 -0400 (EDT)
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
	with ESMTP id oy1e1EEe2s4O; Thu, 17 Jun 2021 09:21:26 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 186ED4A4CD;
	Thu, 17 Jun 2021 09:21:25 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5AF98407B0
 for <kvmarm@lists.cs.columbia.edu>; Thu, 17 Jun 2021 09:21:24 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LhTYmKlRBk2y for <kvmarm@lists.cs.columbia.edu>;
 Thu, 17 Jun 2021 09:21:23 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 47CFC4056A
 for <kvmarm@lists.cs.columbia.edu>; Thu, 17 Jun 2021 09:21:23 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD02A6112D;
 Thu, 17 Jun 2021 13:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623936082;
 bh=9m33aIOJbia+ShcJ940DomACgwPzr98gLkW2wr4hC0U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Vb3e9ZS14SiSso4EXORRrKwxfAZT20KMhCseWc54VYAc5MtG70waEtim/es9NVznb
 KZxnCTX+u/dwRN/5pESaYM3FZpZSC05Lqzsa5HbAJrOk43pEdk/krdZ10NrbEYSBzu
 HfhjoHpdabOfk6XKx0eib42VKJhHjwqmBoyD6YKubuKZB9QC7T1Ifr9yD+K3eflqBc
 uKupbuBOkbtc6w8EBmowP9qnR7esHF7xQpck+/SAfRDdi3Ub4ts1YhYRx3ohwTp1Rp
 vjynNariT2gyLgNMJbZfqpwB/XC45+n+U4u5f4GgnvMLcdI2596NypKVEF6jSxtVED
 B4DjgJJgNh+Lw==
Date: Thu, 17 Jun 2021 14:21:16 +0100
From: Will Deacon <will@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v7 4/4] KVM: arm64: Move guest CMOs to the fault handlers
Message-ID: <20210617132115.GA24656@willie-the-truck>
References: <20210617105824.31752-1-wangyanan55@huawei.com>
 <20210617105824.31752-5-wangyanan55@huawei.com>
 <20210617124557.GB24457@willie-the-truck>
 <87k0msd4ue.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87k0msd4ue.wl-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
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

On Thu, Jun 17, 2021 at 01:59:37PM +0100, Marc Zyngier wrote:
> On Thu, 17 Jun 2021 13:45:57 +0100,
> Will Deacon <will@kernel.org> wrote:
> > On Thu, Jun 17, 2021 at 06:58:24PM +0800, Yanan Wang wrote:
> > > @@ -606,6 +618,14 @@ static int stage2_map_walker_try_leaf(u64 addr, u64 end, u32 level,
> > >  		stage2_put_pte(ptep, data->mmu, addr, level, mm_ops);
> > >  	}
> > >  
> > > +	/* Perform CMOs before installation of the guest stage-2 PTE */
> > > +	if (mm_ops->clean_invalidate_dcache && stage2_pte_cacheable(pgt, new))
> > > +		mm_ops->clean_invalidate_dcache(kvm_pte_follow(new, mm_ops),
> > > +						granule);
> > > +
> > > +	if (mm_ops->invalidate_icache && stage2_pte_executable(new))
> > > +		mm_ops->invalidate_icache(kvm_pte_follow(new, mm_ops), granule);
> > 
> > One thing I'm missing here is why we need the indirection via mm_ops. Are
> > there cases where we would want to pass a different function pointer for
> > invalidating the icache? If not, why not just call the function directly?
> > 
> > Same for the D side.
> 
> If we didn't do that, we'd end-up having to track whether the guest
> context requires CMOs with additional flags, which is pretty ugly (see
> v5 of this series for reference [1]).

Fair enough, although the function pointers here _are_ being used as flags,
as they only ever have one of two possible values (NULL or the CMO function),
so it's a shame to bring in the indirect branch as well.

> It also means that we would have to drag the CM functions into the EL2
> object, something that we don't need with this approach.

I think it won't be long before we end up with CMO functions at EL2 and
you'd hope we'd be able to use the same code as EL1 for something like
that. But I also wouldn't want to put money on it...

Anyway, no strong opinion on this, it just jumped out when I skimmed the
patches.

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
