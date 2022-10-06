Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 280315F6391
	for <lists+kvmarm@lfdr.de>; Thu,  6 Oct 2022 11:24:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2468448FA4;
	Thu,  6 Oct 2022 05:24:50 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 required=6.1 tests=[BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OcCVOw+RKEGX; Thu,  6 Oct 2022 05:24:50 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8B01F41174;
	Thu,  6 Oct 2022 05:24:48 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E72C14086D
 for <kvmarm@lists.cs.columbia.edu>; Thu,  6 Oct 2022 05:24:46 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id szNuRsdmb7X6 for <kvmarm@lists.cs.columbia.edu>;
 Thu,  6 Oct 2022 05:24:45 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 14CA740162
 for <kvmarm@lists.cs.columbia.edu>; Thu,  6 Oct 2022 05:24:45 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D7A123A;
 Thu,  6 Oct 2022 02:24:50 -0700 (PDT)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA4D13F73B;
 Thu,  6 Oct 2022 02:24:42 -0700 (PDT)
Date: Thu, 6 Oct 2022 10:25:50 +0100
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v3 0/3] arm: pmu: Fixes for bare metal
Message-ID: <Yz6fHp+PZG0pK3Fk@monolith.localdoman>
References: <20220805004139.990531-1-ricarkol@google.com>
 <89c93f1e-6e78-f679-aecb-7e506fa0cea3@redhat.com>
 <YzxmHpV2rpfaUdWi@monolith.localdoman>
 <5b69f259-4a25-18eb-6c7c-4b59e1f81036@redhat.com>
 <Yz1MiE64ZEa7twtM@monolith.localdoman>
 <2c577c0a-7bdb-81b0-f0c3-6ede3688b94d@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2c577c0a-7bdb-81b0-f0c3-6ede3688b94d@redhat.com>
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

On Wed, Oct 05, 2022 at 11:50:09AM +0200, Eric Auger wrote:
> Hi Alexandru,
> 
> On 10/5/22 11:21, Alexandru Elisei wrote:
> > Hi Eric,
> >
> > On Tue, Oct 04, 2022 at 07:31:25PM +0200, Eric Auger wrote:
> >> Hi Alexandru,
> >>
> >> On 10/4/22 18:58, Alexandru Elisei wrote:
> >>> Hi Eric,
> >>>
> >>> On Tue, Oct 04, 2022 at 06:20:23PM +0200, Eric Auger wrote:
> >>>> Hi Ricardo, Marc,
> >>>>
> >>>> On 8/5/22 02:41, Ricardo Koller wrote:
> >>>>> There are some tests that fail when running on bare metal (including a
> >>>>> passthrough prototype).  There are three issues with the tests.  The
> >>>>> first one is that there are some missing isb()'s between enabling event
> >>>>> counting and the actual counting. This wasn't an issue on KVM as
> >>>>> trapping on registers served as context synchronization events. The
> >>>>> second issue is that some tests assume that registers reset to 0.  And
> >>>>> finally, the third issue is that overflowing the low counter of a
> >>>>> chained event sets the overflow flag in PMVOS and some tests fail by
> >>>>> checking for it not being set.
> >>>>>
> >>>>> Addressed all comments from the previous version:
> >>>>> https://lore.kernel.org/kvmarm/20220803182328.2438598-1-ricarkol@google.com/T/#t
> >>>>> - adding missing isb() and fixed the commit message (Alexandru).
> >>>>> - fixed wording of a report() check (Andrew).
> >>>>>
> >>>>> Thanks!
> >>>>> Ricardo
> >>>>>
> >>>>> Ricardo Koller (3):
> >>>>>   arm: pmu: Add missing isb()'s after sys register writing
> >>>>>   arm: pmu: Reset the pmu registers before starting some tests
> >>>>>   arm: pmu: Check for overflow in the low counter in chained counters
> >>>>>     tests
> >>>>>
> >>>>>  arm/pmu.c | 56 ++++++++++++++++++++++++++++++++++++++-----------------
> >>>>>  1 file changed, 39 insertions(+), 17 deletions(-)
> >>>>>
> >>>> While testing this series and the related '[PATCH 0/9] KVM: arm64: PMU:
> >>>> Fixing chained events, and PMUv3p5 support' I noticed I have kvm unit
> >>>> test failures on some machines. This does not seem related to those
> >>>> series though since I was able to get them without. The failures happen
> >>>> on Amberwing machine for instance with the pmu-chain-promotion.
> >>>>
> >>>> While further investigating I noticed there is a lot of variability on
> >>>> the kvm unit test mem_access_loop() count. I can get the counter = 0x1F
> >>>> on the first iteration and 0x96 on the subsequent ones for instance.
> >>>> While running mem_access_loop(addr, 20, pmu.pmcr_ro | PMU_PMCR_E) I was
> >>>> expecting the counter to be close to 20. It is on some HW.
> >>>>
> >>>> [..]
> >>>>
> >>>> So I come to the actual question. Can we do any assumption on the
> >>>> (virtual) PMU quality/precision? If not, the tests I originally wrote
> >>>> are damned to fail on some HW (on some other they always pass) and I
> >>>> need to make a decision wrt re-writing part of them, expecially those
> >>>> which expect overflow after a given amount of ops. Otherwise, there is
> >>>> either something wrong in the test (asm?) or in KVM PMU emulation.
> >>>>
> >>>> I tried to bisect because I did observe the same behavior on some older
> >>>> kernels but the bisect was not successful as the issue does not happen
> >>>> always.
> >>>>
> >>>> Thoughts?
> >>> Looking at mem_access_loop(), the first thing that jumps out is the fact
> >>> that is missing a DSB barrier. ISB affects only instructions, not memory
> >>> accesses and without a DSB, the PE can reorder memory accesses however it
> >>> sees fit.
> >> Following your suggestion I added a dsh ish at the end of loop and
> >> before disabling pmcr_el0 (I hope this is the place you were thinking
> >> of) but unfortunately it does not seem to fix my issue.
> > Yes, DSB ISH after "b.gt 1b\n" and before the write to PMCR_EL0 that
> > disables the PMU.
> >
> > I think you also need a DSB ISH before the write to PMCR_EL0 that enables
> > the PMU in the first instruction of the asm block. In your example, the
> > MEM_ACCESS event count is higher than expected, and one explanation for the
> > large disparity that I can think of is that previous memory accesses are
> > reordered past the instruction that enables the PMU, which makes the PMU
> > add these events to the total event count.
> 
> Makes sense. I added those at the 2 locations but unfortunately it does
> not change the result for me.

Have you tried increasing the number of iterations for mem_access_loop to
something very large? If the number of unexpected accesses remains about
the same (~80) instead of growing proportionally with the number of
iterations, that might point to some extra accesses that are performed in
the setup phase instead of something fundamently wrong with the test.

Thanks,
Alex
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
