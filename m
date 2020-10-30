Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 98B522A07B0
	for <lists+kvmarm@lfdr.de>; Fri, 30 Oct 2020 15:19:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 156CA4B4AC;
	Fri, 30 Oct 2020 10:19:01 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IVPx7pDiHoXi; Fri, 30 Oct 2020 10:19:00 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E17F84B4B3;
	Fri, 30 Oct 2020 10:18:59 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 92AFE4B4A6
 for <kvmarm@lists.cs.columbia.edu>; Fri, 30 Oct 2020 10:18:58 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IYB4IgQV88a9 for <kvmarm@lists.cs.columbia.edu>;
 Fri, 30 Oct 2020 10:18:55 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BE16C4B4A4
 for <kvmarm@lists.cs.columbia.edu>; Fri, 30 Oct 2020 10:18:55 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4FD6B139F;
 Fri, 30 Oct 2020 07:18:55 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.53.28])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0355D3F68F;
 Fri, 30 Oct 2020 07:18:53 -0700 (PDT)
Date: Fri, 30 Oct 2020 14:18:51 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCHv2 2/3] arm64: cpufeature: reorder
 cpus_have_{const,final}_cap()
Message-ID: <20201030141851.GC50718@C02TD0UTHF1T.local>
References: <20201026134931.28246-1-mark.rutland@arm.com>
 <20201026134931.28246-3-mark.rutland@arm.com>
 <20201030081848.GB32066@willie-the-truck>
 <20201030082013.GC32066@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201030082013.GC32066@willie-the-truck>
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

On Fri, Oct 30, 2020 at 08:20:14AM +0000, Will Deacon wrote:
> On Fri, Oct 30, 2020 at 08:18:48AM +0000, Will Deacon wrote:
> > On Mon, Oct 26, 2020 at 01:49:30PM +0000, Mark Rutland wrote:
> > > In a subsequent patch we'll modify cpus_have_const_cap() to call
> > > cpus_have_final_cap(), and hence we need to define cpus_have_final_cap()
> > > first.
> > > 
> > > To make subsequent changes easier to follow, this patch reorders the two
> > > without making any other changes.
> > > 
> > > There should be no functional change as a result of this patch.
> > 
> > You say this...

[...]

> > > -static __always_inline bool cpus_have_const_cap(int num)
> > > +static __always_inline bool cpus_have_final_cap(int num)
> > >  {
> > >  	if (system_capabilities_finalized())
> > >  		return __cpus_have_const_cap(num);
> > >  	else
> > > -		return cpus_have_cap(num);
> > > +		BUG();
> > 
> > ... but isn't the failure case of calling cpus_have_final_cap() early now
> > different? What does BUG() do at EL2 w/ nVHE?
> 
> Ah no, sorry, I see you're just moving things around and the diff makes it
> look confusing (that and I've been up since 5:30 for KVM Forum).

Indeed; the diff was even more confusing before I split this from the
changes in the next patch!

> So on closer inspection:
> 
> Acked-by: Will Deacon <will@kernel.org>

Cheers!

Mark.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
