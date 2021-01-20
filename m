Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 86CFA2FD161
	for <lists+kvmarm@lfdr.de>; Wed, 20 Jan 2021 14:46:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1ABF14B1A5;
	Wed, 20 Jan 2021 08:46:17 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KscnUGh1rS3l; Wed, 20 Jan 2021 08:46:17 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EF27C4B199;
	Wed, 20 Jan 2021 08:46:15 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D56F34B14F
 for <kvmarm@lists.cs.columbia.edu>; Wed, 20 Jan 2021 08:46:14 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GfPAsFwIeKPg for <kvmarm@lists.cs.columbia.edu>;
 Wed, 20 Jan 2021 08:46:13 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id AA6944B13F
 for <kvmarm@lists.cs.columbia.edu>; Wed, 20 Jan 2021 08:46:13 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42EB2101E;
 Wed, 20 Jan 2021 05:46:13 -0800 (PST)
Received: from slackpad.fritz.box (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A0493F66E;
 Wed, 20 Jan 2021 05:46:11 -0800 (PST)
Date: Wed, 20 Jan 2021 13:45:24 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v6 0/5] ARM: arm64: Add SMCCC TRNG entropy service
Message-ID: <20210120134524.0c47139a@slackpad.fritz.box>
In-Reply-To: <d2423ab6e44855846a8f61f327932784@kernel.org>
References: <20210106103453.152275-1-andre.przywara@arm.com>
 <161114590396.218530.9227813162726341261.b4-ty@kernel.org>
 <d2423ab6e44855846a8f61f327932784@kernel.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Theodore Ts'o <tytso@mit.edu>, Will Deacon <will@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Linus Walleij <linus.walleij@linaro.org>, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 kvmarm@lists.cs.columbia.edu, Sudeep Holla <sudeep.holla@arm.com>,
 kernel-team@android.com, Ard Biesheuvel <ardb@kernel.org>,
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

On Wed, 20 Jan 2021 13:26:26 +0000
Marc Zyngier <maz@kernel.org> wrote:

Hi,

> On 2021-01-20 13:01, Will Deacon wrote:
> > On Wed, 6 Jan 2021 10:34:48 +0000, Andre Przywara wrote:  
> >> a fix to v5, now *really* fixing the wrong priority of SMCCC vs.
> >> RNDR in arch_get_random_seed_long_early(). Apologies for messing
> >> this up in v5 and thanks to broonie for being on the watch!
> >> 
> >> Will, Catalin: it would be much appreciated if you could consider 
> >> taking
> >> patch 1/5. This contains the common definitions, and is a
> >> prerequisite for every other patch, although they are somewhat
> >> independent and likely
> >> will need to go through different subsystems.
> >> 
> >> [...]  
> > 
> > Applied the first patch only to arm64 (for-next/rng), thanks!
> > 
> > [1/5] firmware: smccc: Add SMCCC TRNG function call IDs
> >       https://git.kernel.org/arm64/c/67c6bb56b649  
> 
> I can't see how the rest of the patches can go via any other tree
> if all the definitions are in the first one.
> 
> Andre, can you explain what your plan is?

Well, I don't really have a great solution for that, other than hoping
that 1/5 makes it into Linus' master at some point.

I see that it's a stretch, but pulling 1/5 into 5.11 now would
prepare the stage for the others to go via any tree, into 5.12-rc1?

Or you could maybe take both 1/5 and 5/5 into your kvm-arm tree, and
would hope that a git rebase later would sort this out for you?

But I think you are much more experienced in those kind of issues, so
happy to hear about any other solutions.

Thanks,
Andre
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
