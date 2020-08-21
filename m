Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9E02E24D4F4
	for <lists+kvmarm@lfdr.de>; Fri, 21 Aug 2020 14:26:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2736E4C4DA;
	Fri, 21 Aug 2020 08:26:41 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8gurtoNNpWwG; Fri, 21 Aug 2020 08:26:41 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 099764C4D5;
	Fri, 21 Aug 2020 08:26:40 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 814994C4D1
 for <kvmarm@lists.cs.columbia.edu>; Fri, 21 Aug 2020 08:26:39 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DugFDnVDYDKt for <kvmarm@lists.cs.columbia.edu>;
 Fri, 21 Aug 2020 08:26:38 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 7E6BD4C4D0
 for <kvmarm@lists.cs.columbia.edu>; Fri, 21 Aug 2020 08:26:38 -0400 (EDT)
Received: from gaia (unknown [95.146.230.145])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E1F6E20724;
 Fri, 21 Aug 2020 12:26:35 +0000 (UTC)
Date: Fri, 21 Aug 2020 13:26:33 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 3/3] arm64: Add workaround for Arm Cortex-A77 erratum
 1508412
Message-ID: <20200821122633.GC6823@gaia>
References: <20200803193127.3012242-1-robh@kernel.org>
 <20200803193127.3012242-4-robh@kernel.org>
 <20200821120659.GB6823@gaia>
 <20200821121209.GB20833@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200821121209.GB20833@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

On Fri, Aug 21, 2020 at 01:12:10PM +0100, Will Deacon wrote:
> On Fri, Aug 21, 2020 at 01:07:00PM +0100, Catalin Marinas wrote:
> > On Mon, Aug 03, 2020 at 01:31:27PM -0600, Rob Herring wrote:
> > > @@ -979,6 +980,14 @@
> > >  		write_sysreg(__scs_new, sysreg);			\
> > >  } while (0)
> > > 
> > > +#define read_sysreg_par() ({						\
> > > +	u64 par;							\
> > > +	asm(ALTERNATIVE("nop", "dmb sy", ARM64_WORKAROUND_1508412));	\
> > > +	par = read_sysreg(par_el1);					\
> > > +	asm(ALTERNATIVE("nop", "dmb sy", ARM64_WORKAROUND_1508412));	\
> > > +	par;								\
> > > +})
> > 
> > I was about to queue this up but one more point to clarify: can we get
> > an interrupt at either side of the PAR_EL1 read and the handler do a
> > device read, triggering the erratum? Do we need a DMB at exception
> > entry/return?
> 
> Disabling irqs around the PAR access would be simpler, I think (assuming
> this is needed).

This wouldn't work if it interrupts a guest.

-- 
Catalin
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
