Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2A70C1C3806
	for <lists+kvmarm@lfdr.de>; Mon,  4 May 2020 13:26:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B360D4B3A4;
	Mon,  4 May 2020 07:26:33 -0400 (EDT)
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
	with ESMTP id 2eiiaOry2Y0Z; Mon,  4 May 2020 07:26:33 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9E3FF4B39D;
	Mon,  4 May 2020 07:26:32 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 365C34B397
 for <kvmarm@lists.cs.columbia.edu>; Mon,  4 May 2020 07:26:31 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4ZQN98MWH79k for <kvmarm@lists.cs.columbia.edu>;
 Mon,  4 May 2020 07:26:30 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 30D2F4B315
 for <kvmarm@lists.cs.columbia.edu>; Mon,  4 May 2020 07:26:30 -0400 (EDT)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BE1F520721;
 Mon,  4 May 2020 11:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588591589;
 bh=bbiZPVfmFqYVL/wAzhRV8cgjhVbnfg17BIGvQfSh0nQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MPL/S/eG4Q240qsKgogVhDaxe7bXcVOEZZ1eoUWmwg4D456a5QdiHxHN5TC9E8y+V
 cuPbf4aTEWSbPf2KO2NuVDuTpf6r5S5ZfSsM861OKx4cmvTXcOpzh3O0lddznL2K+d
 ygmVZUTM2rNDkjG9hpzw/Bz32OsC3TGPngbCFxI0=
Date: Mon, 4 May 2020 12:26:24 +0100
From: Will Deacon <will@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v3] arm64: Unify WORKAROUND_SPECULATIVE_AT_{NVHE,VHE}
Message-ID: <20200504112624.GA1326@willie-the-truck>
References: <20200504094858.108917-1-ascull@google.com>
 <20200504105539.GA4879@willie-the-truck>
 <7b3cc0b0a3fa6d08d8c8413e4498d485@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7b3cc0b0a3fa6d08d8c8413e4498d485@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Steven Price <steven.price@arm.com>, kvmarm@lists.cs.columbia.edu,
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

On Mon, May 04, 2020 at 12:13:02PM +0100, Marc Zyngier wrote:
> On 2020-05-04 11:55, Will Deacon wrote:
> > On Mon, May 04, 2020 at 10:48:58AM +0100, Andrew Scull wrote:
> > > Errata 1165522, 1319367 and 1530923 each allow TLB entries to be
> > > allocated as a result of a speculative AT instruction. In order to
> > > avoid mandating VHE on certain affected CPUs, apply the workaround to
> > > both the nVHE and the VHE case for all affected CPUs.
> > > 
> > > Signed-off-by: Andrew Scull <ascull@google.com>
> > > CC: Marc Zyngier <maz@kernel.org>
> > > CC: James Morse <james.morse@arm.com>
> > > CC: Suzuki K Poulose <suzuki.poulose@arm.com>
> > > CC: Will Deacon <will@kernel.org>
> > > CC: Steven Price <steven.price@arm.com>
> > > ---
> > > From v2 <20200422161346.67325-1-ascull@google.com>:
> > >  - const_cap -> final_cap merge correction
> > >  - based on 5.7 rc4
> > > ---
> > >  arch/arm64/Kconfig                | 39
> > > ++++++++++++++-----------------
> > >  arch/arm64/include/asm/cpucaps.h  | 15 ++++++------
> > >  arch/arm64/include/asm/kvm_host.h |  4 ----
> > >  arch/arm64/include/asm/kvm_hyp.h  |  2 +-
> > >  arch/arm64/kernel/cpu_errata.c    | 25 +++++++++-----------
> > >  arch/arm64/kvm/hyp/switch.c       |  6 ++---
> > >  arch/arm64/kvm/hyp/sysreg-sr.c    |  6 +++--
> > >  arch/arm64/kvm/hyp/tlb.c          | 11 +++++----
> > >  8 files changed, 50 insertions(+), 58 deletions(-)
> > 
> > Acked-by: Will Deacon <will@kernel.org>
> > 
> > We'll probably run into some trivial conflicts with the arm64 tree, but
> > I'm happy to put this on a branch if it helps. Marc?
> 
> I'd rather we avoid the conflicts by not repainting all the capabilities
> and just leave a capability unused until the next one fills in the slot.

I think we'll run into conflicts whatever we do, so I'd say the patch is
alright like it is.

> But otherwise, I'll take a stable branch.

Ok, let me cook that today.

> Also the current state of the KVM/arm tree is a bit crap as none of the
> fixes have made it into Linus' tree yet, and I don't have a good base
> for the current queue (the welcome-home branch could create havoc).

Seriously? I'll reply on your pull to see if I can help.

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
