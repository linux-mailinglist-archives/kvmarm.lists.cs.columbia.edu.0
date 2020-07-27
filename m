Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 24B5B22EA28
	for <lists+kvmarm@lfdr.de>; Mon, 27 Jul 2020 12:38:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 909A84B9F8;
	Mon, 27 Jul 2020 06:38:37 -0400 (EDT)
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
	with ESMTP id dLX2aRty6DsW; Mon, 27 Jul 2020 06:38:37 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 653524B9C5;
	Mon, 27 Jul 2020 06:38:36 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 35E134B983
 for <kvmarm@lists.cs.columbia.edu>; Mon, 27 Jul 2020 06:38:35 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iatCu26uR4pD for <kvmarm@lists.cs.columbia.edu>;
 Mon, 27 Jul 2020 06:38:34 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 4D30E4B955
 for <kvmarm@lists.cs.columbia.edu>; Mon, 27 Jul 2020 06:38:34 -0400 (EDT)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2064F20786;
 Mon, 27 Jul 2020 10:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595846313;
 bh=X1oH5+S/8MF67jZn0+kakzmbW4bT2ueiFuIM5HRKfSs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NeiwJP0ImE9rtaItGr9Vz38AV7ORR7m+iJyn7FckDbGEnAvWGASGYhpsq9M2DMAUJ
 w8UuBHcTWN9c7cFGOy94qSyOrf/P+70CrwUex49Qm3QqKCsVVeskD3p+WE9p5vLbky
 PdJnO0nULqadB4FX+MvX67U17kTVc0BU1fTWm2Yk=
Date: Mon, 27 Jul 2020 11:38:29 +0100
From: Will Deacon <will@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 0/3] KVM: arm64: Clean up memcache usage for page-table
 pages
Message-ID: <20200727103828.GE20194@willie-the-truck>
References: <20200723110227.16001-1-will@kernel.org>
 <ae7caba0eb8ab45db3aa4ae7f97820a3@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ae7caba0eb8ab45db3aa4ae7f97820a3@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
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

On Mon, Jul 27, 2020 at 09:45:39AM +0100, Marc Zyngier wrote:
> On 2020-07-23 12:02, Will Deacon wrote:
> > Here are some small cleanups I made to the memcache logic while hacking
> > on the
> > page-table code. The ioremap() behaviour looks like a bug to me,
> > although it's
> > just a performance thing so nothing urgent.
> > 
> > Cheers,
> > 
> > Will
> > 
> > --->8
> > 
> > Will Deacon (3):
> >   KVM: arm64: Don't free memcache pages in kvm_phys_addr_ioremap()
> >   KVM: arm64: Simplify mmu_topup_memory_cache()
> >   KVM: arm64: Remove mmu_free_memory_cache()
> > 
> >  arch/arm64/kvm/mmu.c | 34 ++++++++++++++--------------------
> >  1 file changed, 14 insertions(+), 20 deletions(-)
> 
> Although I'm OK with this series, it conflicts with the changes
> Sean did on the MMU memory cache in the core code, which also
> affects arm64.
> 
> I guess I'll queue patch 1 and 3 as fixes post -rc1. Patch 2 doesn't
> seem to make sense anymore in that context.

Cheers, that sounds good to me. None of this is urgent.

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
