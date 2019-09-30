Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 56DB4C240D
	for <lists+kvmarm@lfdr.de>; Mon, 30 Sep 2019 17:14:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DFE854A6F5;
	Mon, 30 Sep 2019 11:14:40 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.202
X-Spam-Level: 
X-Spam-Status: No, score=-4.202 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5, SPF_HELO_PASS=-0.001]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fdjXwGQxYMnN; Mon, 30 Sep 2019 11:14:40 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AF6214A6F1;
	Mon, 30 Sep 2019 11:14:39 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7A90D4A69B
 for <kvmarm@lists.cs.columbia.edu>; Mon, 30 Sep 2019 11:14:38 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8GYeiUs9Nnoj for <kvmarm@lists.cs.columbia.edu>;
 Mon, 30 Sep 2019 11:14:37 -0400 (EDT)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 60B3E4A65D
 for <kvmarm@lists.cs.columbia.edu>; Mon, 30 Sep 2019 11:14:37 -0400 (EDT)
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A0C2285542;
 Mon, 30 Sep 2019 15:14:36 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1D3795D9C3;
 Mon, 30 Sep 2019 15:14:34 +0000 (UTC)
Date: Mon, 30 Sep 2019 17:14:32 +0200
From: Andrew Jones <drjones@redhat.com>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Subject: Re: [kvm-unit-tests PATCH 2/3] lib: arm/arm64: Add function to clear
 the PTE_USER bit
Message-ID: <20190930151432.zgcaxtn7glrffkkn@kamzik.brq.redhat.com>
References: <20190930142508.25102-1-alexandru.elisei@arm.com>
 <20190930142508.25102-3-alexandru.elisei@arm.com>
 <20190930145357.o7pq5ysttui2pjjm@kamzik.brq.redhat.com>
 <a33705e8-fd12-86db-be64-dca9900a5555@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a33705e8-fd12-86db-be64-dca9900a5555@arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Mon, 30 Sep 2019 15:14:36 +0000 (UTC)
Cc: kvm@vger.kernel.org, andre.przywara@arm.com, maz@kernel.org,
 pbonzini@redhat.com, kvmarm@lists.cs.columbia.edu
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

On Mon, Sep 30, 2019 at 04:09:49PM +0100, Alexandru Elisei wrote:
> Hi,
> 
> On 9/30/19 3:53 PM, Andrew Jones wrote:
> 
> > On Mon, Sep 30, 2019 at 03:25:07PM +0100, Alexandru Elisei wrote:
> > > The PTE_USER bit (AP[1]) in a page entry means that lower privilege levels
> > > (EL0, on arm64, or PL0, on arm) can read and write from that memory
> > > location [1][2]. On arm64, it also implies PXN (Privileged execute-never)
> > > when is set [3]. Add a function to clear the bit which we can use when we
> > > want to execute code from that page or the prevent access from lower
> > > exception levels.
> > > 
> > > Make it available to arm too, in case someone needs it at some point.
> > > 
> > > [1] ARM DDI 0406C.d, Table B3-6
> > > [2] ARM DDI 0487E.a, table D5-28
> > > [3] ARM DDI 0487E.a, table D5-33
> > > 
> > > Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> > > ---
> > >   lib/arm/asm/mmu-api.h |  1 +
> > >   lib/arm/mmu.c         | 15 +++++++++++++++
> > >   2 files changed, 16 insertions(+)
> > > 
> > > diff --git a/lib/arm/asm/mmu-api.h b/lib/arm/asm/mmu-api.h
> > > index df3ccf7bc7e0..8fe85ba31ec9 100644
> > > --- a/lib/arm/asm/mmu-api.h
> > > +++ b/lib/arm/asm/mmu-api.h
> > > @@ -22,4 +22,5 @@ extern void mmu_set_range_sect(pgd_t *pgtable, uintptr_t virt_offset,
> > >   extern void mmu_set_range_ptes(pgd_t *pgtable, uintptr_t virt_offset,
> > >   			       phys_addr_t phys_start, phys_addr_t phys_end,
> > >   			       pgprot_t prot);
> > > +extern void mmu_clear_user(unsigned long vaddr);
> > >   #endif
> > > diff --git a/lib/arm/mmu.c b/lib/arm/mmu.c
> > > index 3d38c8397f5a..78db22e6af14 100644
> > > --- a/lib/arm/mmu.c
> > > +++ b/lib/arm/mmu.c
> > > @@ -217,3 +217,18 @@ unsigned long __phys_to_virt(phys_addr_t addr)
> > >   	assert(!mmu_enabled() || __virt_to_phys(addr) == addr);
> > >   	return addr;
> > >   }
> > > +
> > > +void mmu_clear_user(unsigned long vaddr)
> > > +{
> > > +	pgd_t *pgtable;
> > > +	pteval_t *pte;
> > > +
> > > +	if (!mmu_enabled())
> > > +		return;
> > > +
> > > +	pgtable = current_thread_info()->pgtable;
> > > +	pte = get_pte(pgtable, vaddr);
> > > +
> > > +	*pte &= ~PTE_USER;
> > > +	flush_tlb_page(vaddr);
> > > +}
> > > -- 
> > > 2.20.1
> > > 
> > This is fine, but I think you could just export get_pte() and then
> > implement the PTE_USER clearing in the cache unit test instead. Anyway,
> 
> I thought about that, but I opted to make this a library function because I
> would like to modify it to also act on block mappings and use it in patch #4
> from the EL2 series (the patch that adds the prefetch abort test), and send
> that change as part of the EL2 series. I am assuming that this patch set
> will get merged before the EL2 series.

Yeah, I need to get back to that EL2 series. I just need to wrap up a
couple more things and then I'll be able to focus on it. If you have
some plans to refresh it, then feel free to do that now. When I get
back to it, I'll just jump into the refreshed version.

Thanks,
drew
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
