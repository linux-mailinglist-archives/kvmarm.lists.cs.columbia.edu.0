Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id CD25624D94F
	for <lists+kvmarm@lfdr.de>; Fri, 21 Aug 2020 18:03:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 44CE24C54E;
	Fri, 21 Aug 2020 12:03:27 -0400 (EDT)
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
	with ESMTP id Ej38i4IWoGFj; Fri, 21 Aug 2020 12:03:27 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1EC434C552;
	Fri, 21 Aug 2020 12:03:26 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DDB884C542
 for <kvmarm@lists.cs.columbia.edu>; Fri, 21 Aug 2020 12:03:24 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1ZDLNWt3lR-R for <kvmarm@lists.cs.columbia.edu>;
 Fri, 21 Aug 2020 12:03:23 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id B04664C540
 for <kvmarm@lists.cs.columbia.edu>; Fri, 21 Aug 2020 12:03:23 -0400 (EDT)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 925FE207BB;
 Fri, 21 Aug 2020 16:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598025802;
 bh=s7k7WVoMuW3YOq62B9s+ZiSRUJCQ9bWnTQTRHx+L47U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rUqMkCwqrjDQLVFDCML+UPPcErgSGgrMWu/c98cem9NQGN6T+mOGaXb0ioOHagXdG
 5y0iD5+V2N72brnN7NCXB43WQZhiDtmc9Me9xJT3z6dHpaKZXFDH8Y0r3F3qw/daXe
 xtT46gOoAtOT09c9Q1JHr9geLPFmMtNd8KKu0lt0=
Date: Fri, 21 Aug 2020 17:03:16 +0100
From: Will Deacon <will@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH stable v4.9 v2] arm64: entry: Place an SB sequence
 following an ERET instruction
Message-ID: <20200821160316.GE21517@willie-the-truck>
References: <20200709195034.15185-1-f.fainelli@gmail.com>
 <20200720130411.GB494210@kroah.com>
 <df1de420-ac59-3647-3b81-a0c163783225@gmail.com>
 <9c29080e-8b3a-571c-3296-e0487fa473fa@gmail.com>
 <20200807131429.GB664450@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200807131429.GB664450@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Nick Desaulniers <ndesaulniers@google.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Fangrui Song <maskray@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 open list <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
 "open list:KERNEL VIRTUAL MACHINE FOR ARM64 \(KVM/arm64\)"
 <kvmarm@lists.cs.columbia.edu>, Mark Brown <broonie@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Marc Zyngier <maz@kernel.org>,
 Kristina Martsenko <kristina.martsenko@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>, linux-arm-kernel@lists.infradead.org
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

On Fri, Aug 07, 2020 at 03:14:29PM +0200, Greg KH wrote:
> On Thu, Aug 06, 2020 at 01:00:54PM -0700, Florian Fainelli wrote:
> > 
> > 
> > On 7/20/2020 11:26 AM, Florian Fainelli wrote:
> > > On 7/20/20 6:04 AM, Greg KH wrote:
> > >> On Thu, Jul 09, 2020 at 12:50:23PM -0700, Florian Fainelli wrote:
> > >>> From: Will Deacon <will.deacon@arm.com>
> > >>>
> > >>> commit 679db70801da9fda91d26caf13bf5b5ccc74e8e8 upstream
> > >>>
> > >>> Some CPUs can speculate past an ERET instruction and potentially perform
> > >>> speculative accesses to memory before processing the exception return.
> > >>> Since the register state is often controlled by a lower privilege level
> > >>> at the point of an ERET, this could potentially be used as part of a
> > >>> side-channel attack.
> > >>>
> > >>> This patch emits an SB sequence after each ERET so that speculation is
> > >>> held up on exception return.
> > >>>
> > >>> Signed-off-by: Will Deacon <will.deacon@arm.com>
> > >>> [florian: Adjust hyp-entry.S to account for the label
> > >>>  added change to hyp/entry.S]
> > >>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> > >>> ---
> > >>> Changes in v2:
> > >>>
> > >>> - added missing hunk in hyp/entry.S per Will's feedback
> > >>
> > >> What about 4.19.y and 4.14.y trees?  I can't take something for 4.9.y
> > >> and then have a regression if someone moves to a newer release, right?
> > > 
> > > Sure, send you candidates for 4.14 and 4.19.
> > 
> > Greg, did you have a chance to queue those changes for 4.9, 4.14 and 4.19?
> > 
> > https://lore.kernel.org/linux-arm-kernel/20200720182538.13304-1-f.fainelli@gmail.com/
> > https://lore.kernel.org/linux-arm-kernel/20200720182937.14099-1-f.fainelli@gmail.com/
> > https://lore.kernel.org/linux-arm-kernel/20200709195034.15185-1-f.fainelli@gmail.com/
> 
> Nope, I was waiting for Will's "ack" for these.

This patch doesn't even build for me (the 'sb' macro is not defined in 4.9),
and I really wonder why we bother backporting it at all. Nobody's ever shown
it to be a problem in practice, and it's clear that this is just being
submitted to tick a box rather than anything else (otherwise it would build,
right?).

So I'm not going to Ack any of them. As with a lot of this side-channel
stuff the cure is far worse than the disease.

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
