Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED452EBBF6
	for <lists+kvmarm@lfdr.de>; Wed,  6 Jan 2021 10:55:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BCB1B4B33B;
	Wed,  6 Jan 2021 04:55:19 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TeLdoH9QgKdu; Wed,  6 Jan 2021 04:55:19 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9499B4B32A;
	Wed,  6 Jan 2021 04:55:18 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 013C54B30E
 for <kvmarm@lists.cs.columbia.edu>; Wed,  6 Jan 2021 04:55:17 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wnDlCs4jNc-I for <kvmarm@lists.cs.columbia.edu>;
 Wed,  6 Jan 2021 04:55:15 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id AD64A4B30A
 for <kvmarm@lists.cs.columbia.edu>; Wed,  6 Jan 2021 04:55:15 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFD711FB;
 Wed,  6 Jan 2021 01:55:14 -0800 (PST)
Received: from slackpad.fritz.box (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 044EE3F719;
 Wed,  6 Jan 2021 01:55:12 -0800 (PST)
Date: Wed, 6 Jan 2021 09:54:32 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 4/5] arm64: Add support for SMCCC TRNG entropy source
Message-ID: <20210106095432.26e5b86d@slackpad.fritz.box>
In-Reply-To: <20210105170014.GG4487@sirena.org.uk>
References: <20210105163652.23646-1-andre.przywara@arm.com>
 <20210105163652.23646-5-andre.przywara@arm.com>
 <20210105170014.GG4487@sirena.org.uk>
Organization: Arm Ltd.
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Theodore Ts'o <tytso@mit.edu>, Catalin Marinas <catalin.marinas@arm.com>,
 Linus Walleij <linus.walleij@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>,
 linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 kvmarm@lists.cs.columbia.edu, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
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

On Tue, 5 Jan 2021 17:00:14 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Tue, Jan 05, 2021 at 04:36:51PM +0000, Andre Przywara wrote:
> 
> > @@ -77,10 +117,20 @@ arch_get_random_seed_long_early(unsigned long
> > *v) {
> >  	WARN_ON(system_state != SYSTEM_BOOTING);
> >  
> > -	if (!__early_cpu_has_rndr())
> > -		return false;
> > +	if (__early_cpu_has_rndr())
> > +		return __arm64_rndr(v);
> > +
> > +	if (smccc_trng_available) {
> > +		struct arm_smccc_res res;  
> 
> This still seems to be preferring RNDR over SMCCC for the early seed
> unless I'm misreading the diff?

Argh, my apologies for that blunder. I *did* change it, but must have
lost it when rebasing against my debug patches.
Will send a fixed version in a jiffy.

Cheers,
Andre.

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
