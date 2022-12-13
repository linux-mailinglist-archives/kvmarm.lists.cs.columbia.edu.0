Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 92BB864BA0D
	for <lists+kvmarm@lfdr.de>; Tue, 13 Dec 2022 17:43:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DE4B94B902;
	Tue, 13 Dec 2022 11:43:46 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 required=6.1 tests=[BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QWf2KsNAbQj7; Tue, 13 Dec 2022 11:43:46 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3CBB84B925;
	Tue, 13 Dec 2022 11:43:45 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B25684B8FD
 for <kvmarm@lists.cs.columbia.edu>; Tue, 13 Dec 2022 11:43:44 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3G83+Wn34x-p for <kvmarm@lists.cs.columbia.edu>;
 Tue, 13 Dec 2022 11:43:42 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CD8614B8B4
 for <kvmarm@lists.cs.columbia.edu>; Tue, 13 Dec 2022 11:43:42 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B690E2F4;
 Tue, 13 Dec 2022 08:44:22 -0800 (PST)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B86C93F71E;
 Tue, 13 Dec 2022 08:43:40 -0800 (PST)
Date: Tue, 13 Dec 2022 16:43:38 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Ricardo Koller <ricarkol@google.com>
Subject: Re: [kvm-unit-tests PATCH 1/3] arm: pmu: Fix overflow checks for
 PMUv3p5 long counters
Message-ID: <Y5irunF72esHzOWj@monolith.localdoman>
References: <20221202045527.3646838-1-ricarkol@google.com>
 <20221202045527.3646838-2-ricarkol@google.com>
 <Y5hxvj6p+mCC2DOs@monolith.localdoman>
 <Y5imhKUIJceHDUMD@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y5imhKUIJceHDUMD@google.com>
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

Hi,

On Tue, Dec 13, 2022 at 08:21:24AM -0800, Ricardo Koller wrote:
> On Tue, Dec 13, 2022 at 12:36:14PM +0000, Alexandru Elisei wrote:
> > Hi,
> > 
> > Some more comments below.
> > 
> > On Fri, Dec 02, 2022 at 04:55:25AM +0000, Ricardo Koller wrote:
> > > PMUv3p5 uses 64-bit counters irrespective of whether the PMU is configured
> > > for overflowing at 32 or 64-bits. The consequence is that tests that check
> > > the counter values after overflowing should not assume that values will be
> > > wrapped around 32-bits: they overflow into the other half of the 64-bit
> > > counters on PMUv3p5.
> > > 
> > > Fix tests by correctly checking overflowing-counters against the expected
> > > 64-bit value.
> > > 
> > > Signed-off-by: Ricardo Koller <ricarkol@google.com>
> > > ---
> > >  arm/pmu.c | 29 ++++++++++++++++++-----------
> > >  1 file changed, 18 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/arm/pmu.c b/arm/pmu.c
> > > index cd47b14..eeac984 100644
> > > --- a/arm/pmu.c
> > > +++ b/arm/pmu.c
> > > @@ -54,10 +54,10 @@
> > >  #define EXT_COMMON_EVENTS_LOW	0x4000
> > >  #define EXT_COMMON_EVENTS_HIGH	0x403F
> > >  
> > > -#define ALL_SET			0xFFFFFFFF
> > > -#define ALL_CLEAR		0x0
> > > -#define PRE_OVERFLOW		0xFFFFFFF0
> > > -#define PRE_OVERFLOW2		0xFFFFFFDC
> > > +#define ALL_SET			0x00000000FFFFFFFFULL
> > > +#define ALL_CLEAR		0x0000000000000000ULL
> > > +#define PRE_OVERFLOW		0x00000000FFFFFFF0ULL
> > > +#define PRE_OVERFLOW2		0x00000000FFFFFFDCULL
> > >  
> > >  #define PMU_PPI			23
> > >  
> > > @@ -538,6 +538,7 @@ static void test_mem_access(void)
> > >  static void test_sw_incr(void)
> > >  {
> > >  	uint32_t events[] = {SW_INCR, SW_INCR};
> > > +	uint64_t cntr0;
> > >  	int i;
> > >  
> > >  	if (!satisfy_prerequisites(events, ARRAY_SIZE(events)))
> > > @@ -572,9 +573,9 @@ static void test_sw_incr(void)
> > >  		write_sysreg(0x3, pmswinc_el0);
> > >  
> > >  	isb();
> > > -	report(read_regn_el0(pmevcntr, 0)  == 84, "counter #1 after + 100 SW_INCR");
> > > -	report(read_regn_el0(pmevcntr, 1)  == 100,
> > > -		"counter #0 after + 100 SW_INCR");
> > > +	cntr0 = (pmu.version < ID_DFR0_PMU_V3_8_5) ? 84 : PRE_OVERFLOW + 100;
> > > +	report(read_regn_el0(pmevcntr, 0) == cntr0, "counter #0 after + 100 SW_INCR");
> > > +	report(read_regn_el0(pmevcntr, 1) == 100, "counter #1 after + 100 SW_INCR");
> > >  	report_info("counter values after 100 SW_INCR #0=%ld #1=%ld",
> > >  		    read_regn_el0(pmevcntr, 0), read_regn_el0(pmevcntr, 1));
> > >  	report(read_sysreg(pmovsclr_el0) == 0x1,
> > > @@ -584,6 +585,7 @@ static void test_sw_incr(void)
> > >  static void test_chained_counters(void)
> > >  {
> > >  	uint32_t events[] = {CPU_CYCLES, CHAIN};
> > > +	uint64_t cntr1;
> > >  
> > >  	if (!satisfy_prerequisites(events, ARRAY_SIZE(events)))
> > >  		return;
> > > @@ -618,13 +620,16 @@ static void test_chained_counters(void)
> > >  
> > >  	precise_instrs_loop(22, pmu.pmcr_ro | PMU_PMCR_E);
> > >  	report_info("overflow reg = 0x%lx", read_sysreg(pmovsclr_el0));
> > > -	report(!read_regn_el0(pmevcntr, 1), "CHAIN counter #1 wrapped");
> > > +	cntr1 = (pmu.version < ID_DFR0_PMU_V3_8_5) ? 0 : ALL_SET + 1;
> > > +	report(read_regn_el0(pmevcntr, 1) == cntr1, "CHAIN counter #1 wrapped");
> > 
> > It looks to me like the intention of the test was to check that the counter
> > programmed with the CHAIN event wraps, judging from the report message.
> > 
> 
> Ah, right. Yeah, that message is confusing. It should be the short
> version of "Inrementing at 32-bits resulted in the right value".
> 
> > I think it would be interesting to keep that by programming counter #1 with
> > ~0ULL when PMUv3p5 (maybe call it ALL_SET64?) and test the counter value
> > against 0.
> 
> The last commit adds tests using ALL_SET64.  Tests can be run in two
> modes: overflow_at_64bits and not.  However, this test,
> test_chained_counters(), and all other chained tests only use the
> !overflow_at_64bits mode (even after the last commit). The reason is
> that there are no CHAIN events when overflowing at 64-bits (more details
> in the commit message). But, don't worry, there are lots of tests that
> check wrapping at 64-bits (overflow_at_64bits=true).

What I was suggesting is this (change on top of this series, not on top of
this patch, to get access to ALL_SET_AT):

diff --git a/arm/pmu.c b/arm/pmu.c
index 3cb563b1abe4..fd7f20fc6c52 100644
--- a/arm/pmu.c
+++ b/arm/pmu.c
@@ -607,7 +607,6 @@ static void test_sw_incr(bool overflow_at_64bits)
 static void test_chained_counters(bool overflow_at_64bits)
 {
        uint32_t events[] = {CPU_CYCLES, CHAIN};
-       uint64_t cntr1;

        if (!satisfy_prerequisites(events, ARRAY_SIZE(events),
                                   overflow_at_64bits))
@@ -639,12 +638,11 @@ static void test_chained_counters(bool overflow_at_64bits)
        report(read_sysreg(pmovsclr_el0) == 0x1, "overflow recorded for chained incr #2");

        write_regn_el0(pmevcntr, 0, PRE_OVERFLOW);
-       write_regn_el0(pmevcntr, 1, ALL_SET);
+       write_regn_el0(pmevcntr, 1, ALL_SET_AT(overflow_at_64bits));

        precise_instrs_loop(22, pmu.pmcr_ro | PMU_PMCR_E);
        report_info("overflow reg = 0x%lx", read_sysreg(pmovsclr_el0));
-       cntr1 = (pmu.version < ID_DFR0_PMU_V3_8_5) ? 0 : ALL_SET + 1;
-       report(read_regn_el0(pmevcntr, 1) == cntr1, "CHAIN counter #1 wrapped");
+       report(read_regn_el0(pmevcntr, 1) == 0, "CHAIN counter #1 wrapped");

        report(read_sysreg(pmovsclr_el0) == 0x3, "overflow on even and odd counters");
 }

The counters are 64bit, but the CHAIN event should still work because
PMCR_EL0.LP is 0, according to the event description in the Arm ARM (ARM
DDI 0487I.a, page D17-6461).

Thanks,
Alex

> 
> > Alternatively, the report message can be modified, and "wrapped"
> > replaced with "incremented" (or something like that), to avoid confusion.
> > 
> > > +
> > >  	report(read_sysreg(pmovsclr_el0) == 0x3, "overflow on even and odd counters");
> > >  }
> > >  
> > >  static void test_chained_sw_incr(void)
> > >  {
> > >  	uint32_t events[] = {SW_INCR, CHAIN};
> > > +	uint64_t cntr0, cntr1;
> > >  	int i;
> > >  
> > >  	if (!satisfy_prerequisites(events, ARRAY_SIZE(events)))
> > > @@ -665,10 +670,12 @@ static void test_chained_sw_incr(void)
> > >  		write_sysreg(0x1, pmswinc_el0);
> > >  
> > >  	isb();
> > > +	cntr0 = (pmu.version < ID_DFR0_PMU_V3_8_5) ? 0 : ALL_SET + 1;
> > > +	cntr1 = (pmu.version < ID_DFR0_PMU_V3_8_5) ? 84 : PRE_OVERFLOW + 100;
> > >  	report((read_sysreg(pmovsclr_el0) == 0x3) &&
> > > -		(read_regn_el0(pmevcntr, 1) == 0) &&
> > > -		(read_regn_el0(pmevcntr, 0) == 84),
> > > -		"expected overflows and values after 100 SW_INCR/CHAIN");
> > > +	       (read_regn_el0(pmevcntr, 1) == cntr0) &&
> > > +	       (read_regn_el0(pmevcntr, 0) == cntr1),
> > 
> > This is hard to parse, it would be better if counter 0 is compared against
> > cntr0 and counter 1 against cntr1.
> 
> Ah, yes, code is correct but that's indeed confusing.
> 
> > 
> > Also, same suggestion here, looks like the test wants to check that the
> > odd-numbered counter wraps around when counting the CHAIN event.
> 
> Ack. Will update for v2.
> 
> Thanks!
> Ricardo
> 
> > 
> > Thanks,
> > Alex
> > 
> > > +	       "expected overflows and values after 100 SW_INCR/CHAIN");
> > >  	report_info("overflow=0x%lx, #0=%ld #1=%ld", read_sysreg(pmovsclr_el0),
> > >  		    read_regn_el0(pmevcntr, 0), read_regn_el0(pmevcntr, 1));
> > >  }
> > > -- 
> > > 2.39.0.rc0.267.gcb52ba06e7-goog
> > > 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
