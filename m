Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id EF1E21A7914
	for <lists+kvmarm@lfdr.de>; Tue, 14 Apr 2020 13:06:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7A51B4B22B;
	Tue, 14 Apr 2020 07:06:03 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CH3bo9WMCsoQ; Tue, 14 Apr 2020 07:06:03 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5A6F24B220;
	Tue, 14 Apr 2020 07:06:02 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C2C0E4B219
 for <kvmarm@lists.cs.columbia.edu>; Tue, 14 Apr 2020 07:06:01 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lWPXPP0m5fUJ for <kvmarm@lists.cs.columbia.edu>;
 Tue, 14 Apr 2020 07:06:00 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 72C4A4B217
 for <kvmarm@lists.cs.columbia.edu>; Tue, 14 Apr 2020 07:06:00 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9A441FB;
 Tue, 14 Apr 2020 04:05:59 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.30.4])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 748723F6C4;
 Tue, 14 Apr 2020 04:05:57 -0700 (PDT)
Date: Tue, 14 Apr 2020 12:05:54 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH RFCv1 0/7] Support Async Page Fault
Message-ID: <20200414110554.GB2486@C02TD0UTHF1T.local>
References: <20200410085820.758686-1-gshan@redhat.com>
 <d2882e806ad2f9793437160093c8d3fa@kernel.org>
 <6a1d7e8b-da10-409f-16d0-354004566a1a@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a1d7e8b-da10-409f-16d0-354004566a1a@redhat.com>
Cc: Marc Zyngier <maz@kernel.org>, sudeep.holla@arm.com, shan.gavin@gmail.com,
 catalin.marinas@arm.com, will@kernel.org, kvmarm@lists.cs.columbia.edu,
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

Hi Gavin,

On Tue, Apr 14, 2020 at 03:39:56PM +1000, Gavin Shan wrote:
> On 4/10/20 10:52 PM, Marc Zyngier wrote:
> > On 2020-04-10 09:58, Gavin Shan wrote:
> > > In order to fulfil the control flow and convey signals between host
> > > and guest. A IMPDEF system register (SYS_ASYNC_PF_EL1) is introduced.
> > > The register accepts control block's physical address, plus requested
> > > features. Also, the signal is sent using data abort with the specific
> > > IMPDEF Data Fault Status Code (DFSC). The specific signal is stored
> > > in the control block by host, to be consumed by guest.

> > - We don't add IMPDEF sysregs, period. That's reserved for the HW. If
> >    you want to trap, there's the HVC instruction to that effect.

> I really don't understand how IMPDEF sysreg is used by hardware vendors.
> Do we have an existing functionality, which depends on IMPDEF sysreg?
> I was thinking the IMPDEF sysreg can be used by software either, but
> it seems I'm wrong.

The key is in the name: an IMPLEMENTATION DEFINED register is defined by
the implementation (i.e. the specific CPU microarchitecture), so it's
wrong for software to come up with an arbitrary semantic as this will
differ from the implementation's defined semantic for the register.

Typically, IMP DEF resgisters are used for things that firmware needs to
do (e.g. enter/exit coherency), or for bringup-time debug (e.g. poking
into TLB/cache internals), and are not usually intended for general
purpose software.

Linux generally avoids the use of IMP DEF registers, but does so in some
cases (e.g. for PMUs) after FW explicitly describes that those are safe
to access.

Thanks,
Mark.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
