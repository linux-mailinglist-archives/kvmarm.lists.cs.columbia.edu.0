Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE566493F7
	for <lists+kvmarm@lfdr.de>; Sun, 11 Dec 2022 12:40:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 980654BF28;
	Sun, 11 Dec 2022 06:40:53 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -6.899
X-Spam-Level: 
X-Spam-Status: No, score=-6.899 required=6.1 tests=[BAYES_00=-1.9,
	RCVD_IN_DNSWL_HI=-5, URIBL_BLOCKED=0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yhlZqWrDKTUa; Sun, 11 Dec 2022 06:40:53 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 20D3E4BF22;
	Sun, 11 Dec 2022 06:40:52 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7B1814BEC5
 for <kvmarm@lists.cs.columbia.edu>; Sun, 11 Dec 2022 06:40:51 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mLvhSKGyiYzd for <kvmarm@lists.cs.columbia.edu>;
 Sun, 11 Dec 2022 06:40:49 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BD26F4BEAA
 for <kvmarm@lists.cs.columbia.edu>; Sun, 11 Dec 2022 06:40:49 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9481F1FB;
 Sun, 11 Dec 2022 03:41:29 -0800 (PST)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1069B3FB9E;
 Sun, 11 Dec 2022 03:40:46 -0800 (PST)
Date: Sun, 11 Dec 2022 11:40:39 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [kvm-unit-tests PATCH 1/3] arm: pmu: Fix overflow checks for
 PMUv3p5 long counters
Message-ID: <Y5XBo6s9JQVY79Wu@monolith.localdoman>
References: <20221202045527.3646838-1-ricarkol@google.com>
 <20221202045527.3646838-2-ricarkol@google.com>
 <Y5N0os7zL/BaMBa3@monolith.localdoman>
 <87fsdnfroe.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87fsdnfroe.wl-maz@kernel.org>
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

Hi Marc,

On Sat, Dec 10, 2022 at 11:01:53AM +0000, Marc Zyngier wrote:
> On Fri, 09 Dec 2022 17:47:14 +0000,
> Alexandru Elisei <alexandru.elisei@arm.com> wrote:
> > 
> > Hi,
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
> > 
> > Hm... in the Arm ARM it says that counters are 64-bit if PMUv3p5 is
> > implemented.  But it doesn't say anywhere that versions newer than p5 are
> > required to implement PMUv3p5.
> 
> And I don't think it needs to say it, because there is otherwise no
> way for SW to discover whether 64bit counters are implemented or not.
> 
> > 
> > For example, for PMUv3p7, it says that the feature is mandatory in Arm8.7
> > implementations. My interpretation of that is that it is not forbidden for
> > an implementer to cherry-pick this version on older versions of the
> > architecture where PMUv3p5 is not implemented.
> 
> I'm sorry to have to say that, but I find your suggestion that PMUv3p7
> could be implemented without supporting the full gamut of PMUv3p5
> ludicrous.
> 
> Please look back at the ARM ARM, specially at the tiny section titled
> "Alternative ID scheme used for the Performance Monitors Extension
> version" (DDI0487I.a, D17.1.3, page 5553), and the snipped of C code
> that performs exactly this check:
> 
> <quote>
>   if (value != 0xF and value >= number) {
>   	// do something that relies on version 'number' of the feature
>   }
> </quote>
> 
> Replace 'value' with 7 (PMUv3p7), 'number' with 6 (PMUv3p5), and you
> get the exact property that you pretend doesn't exist, allowing you to
> rely on PMUv3p5 to be implemented when the HW has PMUv3p7.
> 
> > Maybe the check should be pmu.version == ID_DFR0_PMU_V3_8_5, to match the
> > counter definitions in the architecture?
> 
> No, that'd be totally wrong. You need to check your understanding of
> how the ID registers work.

A simple "hey, you're wrong here, the PMU extensions do not follow the
principles of the ID scheme for fields in ID registers" would have
sufficed. Guess you never made a silly mistake ever, right?

Otherwise, good job encouraging people to help review KVM/arm64 patches ;)

Thanks,
Alex
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
