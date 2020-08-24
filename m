Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E067325027A
	for <lists+kvmarm@lfdr.de>; Mon, 24 Aug 2020 18:32:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 251274CBF1;
	Mon, 24 Aug 2020 12:32:20 -0400 (EDT)
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
	with ESMTP id dccghcZIqYIs; Mon, 24 Aug 2020 12:32:20 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E17B84CBEA;
	Mon, 24 Aug 2020 12:32:18 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2C89C4CBB1
 for <kvmarm@lists.cs.columbia.edu>; Mon, 24 Aug 2020 12:32:18 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SJzKGmEkhOYV for <kvmarm@lists.cs.columbia.edu>;
 Mon, 24 Aug 2020 12:32:17 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D48234C13B
 for <kvmarm@lists.cs.columbia.edu>; Mon, 24 Aug 2020 12:32:16 -0400 (EDT)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8E8902067C;
 Mon, 24 Aug 2020 16:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598286735;
 bh=JWw68BuVJ7xfLohloWh48lvCAxIed5C9r3jJcJyxoFU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=y+9T9DDdaJQxrm+zCaoyAUMyqLdeyuK0qOA+cQzh+mMxS41Bv8U+rmlEuVsrkVvGw
 v9T2hfFFPIeGCAOD2/nhQS5SvGDVtpEeC13I06nqHVJYs1m8Q2JYslDw/NiOUG9GRB
 UkP89VXdr0z4pAX8KrTtN8anYDfYxYgeaWa6l96g=
Date: Mon, 24 Aug 2020 17:32:09 +0100
From: Will Deacon <will@kernel.org>
To: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH stable v4.9 v2] arm64: entry: Place an SB sequence
 following an ERET instruction
Message-ID: <20200824163208.GA25316@willie-the-truck>
References: <20200709195034.15185-1-f.fainelli@gmail.com>
 <20200720130411.GB494210@kroah.com>
 <df1de420-ac59-3647-3b81-a0c163783225@gmail.com>
 <9c29080e-8b3a-571c-3296-e0487fa473fa@gmail.com>
 <20200807131429.GB664450@kroah.com>
 <20200821160316.GE21517@willie-the-truck>
 <7480435b-355d-b9f7-3a42-b72a9c4b6f63@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7480435b-355d-b9f7-3a42-b72a9c4b6f63@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Nick Desaulniers <ndesaulniers@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Fangrui Song <maskray@google.com>,
 Marc Zyngier <maz@kernel.org>, Will Deacon <will.deacon@arm.com>,
 open list <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
 "open list:KERNEL VIRTUAL MACHINE FOR ARM64 \(KVM/arm64\)"
 <kvmarm@lists.cs.columbia.edu>, Mark Brown <broonie@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Greg KH <gregkh@linuxfoundation.org>,
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

Hi Florian,

On Fri, Aug 21, 2020 at 10:16:23AM -0700, Florian Fainelli wrote:
> On 8/21/20 9:03 AM, Will Deacon wrote:
> > On Fri, Aug 07, 2020 at 03:14:29PM +0200, Greg KH wrote:
> >> On Thu, Aug 06, 2020 at 01:00:54PM -0700, Florian Fainelli wrote:
> >>> Greg, did you have a chance to queue those changes for 4.9, 4.14 and 4.19?
> >>>
> >>> https://lore.kernel.org/linux-arm-kernel/20200720182538.13304-1-f.fainelli@gmail.com/
> >>> https://lore.kernel.org/linux-arm-kernel/20200720182937.14099-1-f.fainelli@gmail.com/
> >>> https://lore.kernel.org/linux-arm-kernel/20200709195034.15185-1-f.fainelli@gmail.com/
> >>
> >> Nope, I was waiting for Will's "ack" for these.
> > 
> > This patch doesn't even build for me (the 'sb' macro is not defined in 4.9),
> > and I really wonder why we bother backporting it at all. Nobody's ever shown
> > it to be a problem in practice, and it's clear that this is just being
> > submitted to tick a box rather than anything else (otherwise it would build,
> > right?).
> 
> Doh, I completely missed submitting the patch this depended on that's
> why I did not notice the build failure locally, sorry about that, what a
> shame.
> 
> Would not be the same "tick a box" argument be used against your
> original submission then? Sure, I have not been able to demonstrate in
> real life this was a problem, however the same can be said about a lot
> security related fixes.

Sort of, although I wrote the original patch because it was dead easy to do
and saved having to think too much about the problem, whereas the complexity
of backporting largerly diminishes that imo.

> What if it becomes exploitable in the future, would not it be nice to
> have it in a 6 year LTS kernel?

Even if people are stuck on an old LTS, they should still be taking the
regular updates for it, and we would obviously need to backport the fix if
it turned out to be exploitable (and hey, we could even test it then!).

> > So I'm not going to Ack any of them. As with a lot of this side-channel
> > stuff the cure is far worse than the disease.
> Assuming that my v3 does build correctly, which it will, would you be
> keen on changing your position?

Note that I'm not trying to block this patch from going in, I'm just saying
that I'm not supportive of it. Perhaps somebody from Arm can review it if
they think it's worth the effort.

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
