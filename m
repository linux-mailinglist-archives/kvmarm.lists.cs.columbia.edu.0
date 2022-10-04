Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id DF9ED5F47F9
	for <lists+kvmarm@lfdr.de>; Tue,  4 Oct 2022 18:57:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 087C941174;
	Tue,  4 Oct 2022 12:57:07 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 required=6.1 tests=[BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sauCaOp31sOo; Tue,  4 Oct 2022 12:57:06 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 79B3640797;
	Tue,  4 Oct 2022 12:57:05 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3E32740465
 for <kvmarm@lists.cs.columbia.edu>; Tue,  4 Oct 2022 12:57:04 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mkXBm81KW2D6 for <kvmarm@lists.cs.columbia.edu>;
 Tue,  4 Oct 2022 12:57:02 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 752594045D
 for <kvmarm@lists.cs.columbia.edu>; Tue,  4 Oct 2022 12:57:02 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 693F5113E;
 Tue,  4 Oct 2022 09:57:08 -0700 (PDT)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3DEF73F792;
 Tue,  4 Oct 2022 09:57:00 -0700 (PDT)
Date: Tue, 4 Oct 2022 17:58:06 +0100
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v3 0/3] arm: pmu: Fixes for bare metal
Message-ID: <YzxmHpV2rpfaUdWi@monolith.localdoman>
References: <20220805004139.990531-1-ricarkol@google.com>
 <89c93f1e-6e78-f679-aecb-7e506fa0cea3@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <89c93f1e-6e78-f679-aecb-7e506fa0cea3@redhat.com>
Cc: kvm@vger.kernel.org, maz@kernel.org, andrew.jones@linux.dev,
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

Hi Eric,

On Tue, Oct 04, 2022 at 06:20:23PM +0200, Eric Auger wrote:
> Hi Ricardo, Marc,
> 
> On 8/5/22 02:41, Ricardo Koller wrote:
> > There are some tests that fail when running on bare metal (including a
> > passthrough prototype).  There are three issues with the tests.  The
> > first one is that there are some missing isb()'s between enabling event
> > counting and the actual counting. This wasn't an issue on KVM as
> > trapping on registers served as context synchronization events. The
> > second issue is that some tests assume that registers reset to 0.  And
> > finally, the third issue is that overflowing the low counter of a
> > chained event sets the overflow flag in PMVOS and some tests fail by
> > checking for it not being set.
> >
> > Addressed all comments from the previous version:
> > https://lore.kernel.org/kvmarm/20220803182328.2438598-1-ricarkol@google.com/T/#t
> > - adding missing isb() and fixed the commit message (Alexandru).
> > - fixed wording of a report() check (Andrew).
> >
> > Thanks!
> > Ricardo
> >
> > Ricardo Koller (3):
> >   arm: pmu: Add missing isb()'s after sys register writing
> >   arm: pmu: Reset the pmu registers before starting some tests
> >   arm: pmu: Check for overflow in the low counter in chained counters
> >     tests
> >
> >  arm/pmu.c | 56 ++++++++++++++++++++++++++++++++++++++-----------------
> >  1 file changed, 39 insertions(+), 17 deletions(-)
> >
> While testing this series and the related '[PATCH 0/9] KVM: arm64: PMU:
> Fixing chained events, and PMUv3p5 support' I noticed I have kvm unit
> test failures on some machines. This does not seem related to those
> series though since I was able to get them without. The failures happen
> on Amberwing machine for instance with the pmu-chain-promotion.
> 
> While further investigating I noticed there is a lot of variability on
> the kvm unit test mem_access_loop() count. I can get the counter = 0x1F
> on the first iteration and 0x96 on the subsequent ones for instance.
> While running mem_access_loop(addr, 20, pmu.pmcr_ro | PMU_PMCR_E) I was
> expecting the counter to be close to 20. It is on some HW.
> 
> [..]
> 
> So I come to the actual question. Can we do any assumption on the
> (virtual) PMU quality/precision? If not, the tests I originally wrote
> are damned to fail on some HW (on some other they always pass) and I
> need to make a decision wrt re-writing part of them, expecially those
> which expect overflow after a given amount of ops. Otherwise, there is
> either something wrong in the test (asm?) or in KVM PMU emulation.
> 
> I tried to bisect because I did observe the same behavior on some older
> kernels but the bisect was not successful as the issue does not happen
> always.
> 
> Thoughts?

Looking at mem_access_loop(), the first thing that jumps out is the fact
that is missing a DSB barrier. ISB affects only instructions, not memory
accesses and without a DSB, the PE can reorder memory accesses however it
sees fit.

I also believe precise_instrs_loop() to be in the same situation, as the
architecture doesn't guarantee that the cycle counter increments after
every CPU cycle (ARM DDI 0487I.a, page D11-5246):

"Although the architecture requires that direct reads of PMCCNTR_EL0 or
PMCCNTR occur in program order, there is no requirement that the count
increments between two such reads. Even when the counter is incrementing on
every clock cycle, software might need check that the difference between
two reads of the counter is nonzero."

There's also an entire section in ARM DDI 0487I.a dedicated to this, titled
"A reasonable degree of inaccuracy" (page D11-5248). I'll post some
snippets that I found interesting, but there are more examples and
explanations to be found in that chapter.

"In exceptional circumstances, such as a change in Security state or other
boundary condition, it is acceptable for the count to be inaccurate."

PMCR writes are trapped by KVM. Is a change in exception level an
"exception circumstance"? Could be, but couldn't find anything definitive.
For example, the architecture allows an implementation to drop an event in
the case of an interrupt:

"However, dropping a single branch count as the result of a rare
interaction with an interrupt is acceptable."

So events could definitely be dropped because of an interrupt for the host.

And there's also this:

"The imprecision means that the counter might have counted an event around
the time the counter was disabled, but does not allow the event to be
observed as counted after the counter was disabled."

If you want my opinion, if it is necessary to count the number of events
for a test instead, I would define a margin of error on the number of
events counted. Or the test could be changed to check that at least one
such event was observed.

Thanks,
Alex
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
