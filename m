Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8308729FF8C
	for <lists+kvmarm@lfdr.de>; Fri, 30 Oct 2020 09:20:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 22C3B4B3A3;
	Fri, 30 Oct 2020 04:20:23 -0400 (EDT)
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
	with ESMTP id xc1ssDFyfMfw; Fri, 30 Oct 2020 04:20:23 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 104114B31F;
	Fri, 30 Oct 2020 04:20:22 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B38AF4B2BC
 for <kvmarm@lists.cs.columbia.edu>; Fri, 30 Oct 2020 04:20:20 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S1-rZR2pIODD for <kvmarm@lists.cs.columbia.edu>;
 Fri, 30 Oct 2020 04:20:19 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id B8E524B2BA
 for <kvmarm@lists.cs.columbia.edu>; Fri, 30 Oct 2020 04:20:19 -0400 (EDT)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 70DDF22210;
 Fri, 30 Oct 2020 08:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604046018;
 bh=jz2nrMDNAdbfuzWh4uO0aSdVQigN1U8vdrvthN7Q3nw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NqAZTqVPijbolh/JH+KJSzAKJIGgB4hcFfx+i4pevVMsiitSIWvWiKkix6XWPPJqD
 rsxz9l5rqblxN+E4KQg5XswOVkBJR19zwsejcgPtEabKmMCb64OOIQWyuDRlsLhzUg
 STdhKUQTIVJt2+mFTgvx1ePAuEQswuRm8mnYDsrs=
Date: Fri, 30 Oct 2020 08:20:14 +0000
From: Will Deacon <will@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCHv2 2/3] arm64: cpufeature: reorder
 cpus_have_{const,final}_cap()
Message-ID: <20201030082013.GC32066@willie-the-truck>
References: <20201026134931.28246-1-mark.rutland@arm.com>
 <20201026134931.28246-3-mark.rutland@arm.com>
 <20201030081848.GB32066@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201030081848.GB32066@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: maz@kernel.org, kvmarm@lists.cs.columbia.edu,
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

On Fri, Oct 30, 2020 at 08:18:48AM +0000, Will Deacon wrote:
> On Mon, Oct 26, 2020 at 01:49:30PM +0000, Mark Rutland wrote:
> > In a subsequent patch we'll modify cpus_have_const_cap() to call
> > cpus_have_final_cap(), and hence we need to define cpus_have_final_cap()
> > first.
> > 
> > To make subsequent changes easier to follow, this patch reorders the two
> > without making any other changes.
> > 
> > There should be no functional change as a result of this patch.
> 
> You say this...
> 
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: David Brazdil <dbrazdil@google.com>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Will Deacon <will@kernel.org>
> > ---
> >  arch/arm64/include/asm/cpufeature.h | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> > index f7e7144af174c..5d18c54507e6a 100644
> > --- a/arch/arm64/include/asm/cpufeature.h
> > +++ b/arch/arm64/include/asm/cpufeature.h
> > @@ -428,35 +428,35 @@ static __always_inline bool __cpus_have_const_cap(int num)
> >  }
> >  
> >  /*
> > - * Test for a capability, possibly with a runtime check.
> > + * Test for a capability without a runtime check.
> >   *
> > - * Before capabilities are finalized, this behaves as cpus_have_cap().
> > + * Before capabilities are finalized, this will BUG().
> >   * After capabilities are finalized, this is patched to avoid a runtime check.
> >   *
> >   * @num must be a compile-time constant.
> >   */
> > -static __always_inline bool cpus_have_const_cap(int num)
> > +static __always_inline bool cpus_have_final_cap(int num)
> >  {
> >  	if (system_capabilities_finalized())
> >  		return __cpus_have_const_cap(num);
> >  	else
> > -		return cpus_have_cap(num);
> > +		BUG();
> 
> ... but isn't the failure case of calling cpus_have_final_cap() early now
> different? What does BUG() do at EL2 w/ nVHE?

Ah no, sorry, I see you're just moving things around and the diff makes it
look confusing (that and I've been up since 5:30 for KVM Forum).

So on closer inspection:

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
