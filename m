Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5F07264A29B
	for <lists+kvmarm@lfdr.de>; Mon, 12 Dec 2022 14:56:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5C3AB4B9F8;
	Mon, 12 Dec 2022 08:56:42 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -6.899
X-Spam-Level: 
X-Spam-Status: No, score=-6.899 required=6.1 tests=[BAYES_00=-1.9,
	RCVD_IN_DNSWL_HI=-5, URIBL_BLOCKED=0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5WfvxYtG+NRx; Mon, 12 Dec 2022 08:56:42 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D4E014B9D2;
	Mon, 12 Dec 2022 08:56:40 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DF93D4B99D
 for <kvmarm@lists.cs.columbia.edu>; Mon, 12 Dec 2022 08:56:39 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GSoDG8mfxtXf for <kvmarm@lists.cs.columbia.edu>;
 Mon, 12 Dec 2022 08:56:38 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6E1234B99B
 for <kvmarm@lists.cs.columbia.edu>; Mon, 12 Dec 2022 08:56:38 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A5461FB;
 Mon, 12 Dec 2022 05:57:18 -0800 (PST)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 276243F71E;
 Mon, 12 Dec 2022 05:56:36 -0800 (PST)
Date: Mon, 12 Dec 2022 13:56:33 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [kvm-unit-tests PATCH 1/3] arm: pmu: Fix overflow checks for
 PMUv3p5 long counters
Message-ID: <Y5czEQPdsaZPlSuB@monolith.localdoman>
References: <20221202045527.3646838-1-ricarkol@google.com>
 <20221202045527.3646838-2-ricarkol@google.com>
 <Y5N0os7zL/BaMBa3@monolith.localdoman>
 <87fsdnfroe.wl-maz@kernel.org>
 <Y5XBo6s9JQVY79Wu@monolith.localdoman>
 <867cyxq9fl.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <867cyxq9fl.wl-maz@kernel.org>
Cc: kvm@vger.kernel.org, andrew.jones@linux.dev, kvmarm@lists.cs.columbia.edu
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

Hi,

On Mon, Dec 12, 2022 at 09:05:02AM +0000, Marc Zyngier wrote:
> Alex,
> 
> On Sun, 11 Dec 2022 11:40:39 +0000,
> Alexandru Elisei <alexandru.elisei@arm.com> wrote:
> > 
> > A simple "hey, you're wrong here, the PMU extensions do not follow the
> > principles of the ID scheme for fields in ID registers" would have
> > sufficed.
> 
> This is what I did, and saved you the hassle of looking it up.

The comment was about how you went about it, not about proving someone
wrong. As expressive as it might be, I don't think that calling someone's
suggestion "ludicrous" from the position of authority associated with being
a maintainer is constructive; and can also be interpreted as a personal
attack (you used **your** suggestion, not **this** suggestion). I didn't
interpret it that way, just saying that it can be.

> 
> > Guess you never made a silly mistake ever, right?
> 
> It's not so much about making a silly mistake. I do that all the time.
> But it is about the way you state these things, and the weight that
> your reviews carry. You're a trusted reviewer, with a lot of
> experience, and posting with an @arm.com address: what you say in a
> public forum sticks. When you assert that the author is wrong, they
> will take it at face value.

This is how I stated things:

"Hm... in the Arm ARM it says that counters are 64-bit if PMUv3p5 is
implemented.  But it doesn't say anywhere that versions newer than p5 are
required to implement PMUv3p5." -> patently false, easily provable with the
Arm ARM and by logic (as you did). My entire argument was based on this, so
once this has been proven false, I would say that the rest of my argument
falls apart.

"For example, for PMUv3p7, it says that the feature is mandatory in Arm8.7
implementations. **My interpretation** of that is that it is not forbidden
for an implementer to cherry-pick this version on older versions of the
architecture where PMUv3p5 is not implemented." -> emphasis on the "my
interpretation"; also easy to prove false because PMUv3p5+ is required to
implement PMUv3p5, as per the architecture.

"**Maybe** the check should be pmu.version == ID_DFR0_PMU_V3_8_5, to match
the counter definitions in the architecture?" -> emphasis on the "maybe",
and the question mark at the end.

My intention wasn't to dictate something, my intention was to have a
conversation about the patch, with the mindset that I might be wrong. What
made you get the idea that I was asserting that the author is wrong? Where
by "asserting the author is wrong" I understand framing my comment in such
a way as to leave no room for further discussions. Or did you mean
something else by that?

Or, to put it another way, what about the way I stated things could have
been done better (other than not being wrong, obviously)?

> 
> > Otherwise, good job encouraging people to help review KVM/arm64 patches ;)
> 
> What is the worse: no review? or a review that spreads confusion?
> Think about it. I'm all for being nice, but I will call bullshit when

That wasn't about calling people out on their mistakes. I was saying that
the way you "call bullshit", as you put it, might be a put off for some
people. Call me naive, but I like to think that not everyone that comments
on a patch does it because they have to.

> I see it asserted by people with a certain level of authority.
> 
> And I've long made up my mind about the state of the KVM/arm64 review
> process -- reviews rarely come from people who have volunteered to do
> so, but instead from those who have either a vested interest in it, or
> an ulterior motive. Hey ho...

I genuinely don't know what to make of this. I can't even tell if it's
directed at me or not.

Thanks,
Alex
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
