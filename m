Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 439C219D5B8
	for <lists+kvmarm@lfdr.de>; Fri,  3 Apr 2020 13:20:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B6FF34B167;
	Fri,  3 Apr 2020 07:20:33 -0400 (EDT)
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
	with ESMTP id N4-8bAqSbjy9; Fri,  3 Apr 2020 07:20:33 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 446714B162;
	Fri,  3 Apr 2020 07:20:32 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E9DFD4B15D
 for <kvmarm@lists.cs.columbia.edu>; Fri,  3 Apr 2020 07:20:30 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5xxzH85hpMo2 for <kvmarm@lists.cs.columbia.edu>;
 Fri,  3 Apr 2020 07:20:29 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id C75214B14F
 for <kvmarm@lists.cs.columbia.edu>; Fri,  3 Apr 2020 07:20:29 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A994520737;
 Fri,  3 Apr 2020 11:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1585912828;
 bh=VkbijjM+51iknoUD0yZ0gT3cXkNqrNfBcoLbQJeIJAM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Il47vERBim2JDy7oDA2LDIWqFNH+EnkbYyI8P8YBHlsP657q8CEuD0Rb2ZRtfQ04+
 WhbBrw/kMlQnXm+0hHylvFuMd/H7bTbcOB3JpCxiw2tl/EBZw8rDUYV1wcrqV5q8+H
 MU9H1dEB+kPMAyzG6CIW/FnWNe+APKgHh6Ss7+AA=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jKKN9-000U4Y-0m; Fri, 03 Apr 2020 12:20:27 +0100
Date: Fri, 3 Apr 2020 12:20:24 +0100
From: Marc Zyngier <maz@kernel.org>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Subject: Re: [PATCH 0/2] KVM: arm64: PSCI fixes
Message-ID: <20200403122024.60dcec10@why>
In-Reply-To: <23107386-bbad-6ee1-c1cc-03dd70868905@arm.com>
References: <20200401165816.530281-1-maz@kernel.org>
 <23107386-bbad-6ee1-c1cc-03dd70868905@arm.com>
Organization: Approximate
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: alexandru.elisei@arm.com,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org, Christoffer.Dall@arm.com, james.morse@arm.com,
 julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu
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

Hi Alexandru,

On Fri, 3 Apr 2020 11:35:00 +0100
Alexandru Elisei <alexandru.elisei@arm.com> wrote:

> Hi,
> 
> On 4/1/20 5:58 PM, Marc Zyngier wrote:
> > Christoffer recently pointed out that we don't narrow the arguments to
> > SMC32 PSCI functions called by a 64bit guest. This could result in a
> > guest failing to boot its secondary CPUs if it had junk in the upper
> > 32bits. Yes, this is silly, but the guest is allowed to do that. Duh.
> >
> > Whist I was looking at this, it became apparent that we allow a 32bit
> > guest to call 64bit functions, which the spec explicitly forbids. Oh
> > well, another patch.
> >
> > This has been lightly tested, but I feel that we could do with a new
> > set of PSCI corner cases in KVM-unit-tests (hint, nudge... ;-).  
> 
> Good idea. I was already planning to add new PSCI and timer tests, I'm waiting for
> Paolo to merge the pull request from Drew, which contains some fixes for the
> current tests.
> 
> >
> > Marc Zyngier (2):
> >   KVM: arm64: PSCI: Narrow input registers when using 32bit functions
> >   KVM: arm64: PSCI: Forbid 64bit functions for 32bit guests
> >
> >  virt/kvm/arm/psci.c | 40 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> >  
> I started reviewing the patches and I have a question. I'm probably missing
> something, but why make the changes to the PSCI code instead of making them in the
> kvm_hvc_call_handler function? From my understanding of the code, making the
> changes there would benefit all firmware interface that use SMCCC as the
> communication protocol, not just PSCI.

The problem is that it is not obvious whether other functions have
similar requirements. For example, the old PSCI 0.1 functions are
completely outside of the SMCCC scope (there is no split between 32 and
64bit functions, for example), and there is no generic way to discover
the number of arguments that you would want to narrow.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
