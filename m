Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 37CB364CF23
	for <lists+kvmarm@lfdr.de>; Wed, 14 Dec 2022 19:07:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 556EB4B98B;
	Wed, 14 Dec 2022 13:07:22 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.788
X-Spam-Level: 
X-Spam-Status: No, score=-1.788 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wjvOhAji4ZxZ; Wed, 14 Dec 2022 13:07:22 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B31C24B976;
	Wed, 14 Dec 2022 13:07:20 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5F2AA4B968
 for <kvmarm@lists.cs.columbia.edu>; Wed, 14 Dec 2022 13:07:19 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gRqgrQV2o5tJ for <kvmarm@lists.cs.columbia.edu>;
 Wed, 14 Dec 2022 13:07:17 -0500 (EST)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D375E4B941
 for <kvmarm@lists.cs.columbia.edu>; Wed, 14 Dec 2022 13:07:17 -0500 (EST)
Received: by mail-pl1-f176.google.com with SMTP id w23so4136545ply.12
 for <kvmarm@lists.cs.columbia.edu>; Wed, 14 Dec 2022 10:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cI8YTtXtSllR0ZWQ1/hAxymikjU5SZ/BDOowwrdoNdI=;
 b=HQGukH33fF4QVzgSvQb36OEWRw/3gZKm63tARYNYf4TQrsB8GTXCrMzvmCE/5O7Soc
 pVq6ak2OLhxtKFkSc6KJ82YMXkgzWywqXCnFc005GMb+UWNSZFkE6UqIYtlJLdMT698Z
 s9oSWMSvf9mjdmEhv/+4U5CCv6jhZgOcu1YZARXjx5/tkkRYwftxkBMnrH3KZD3d1Rdv
 R+eZkOiFXdXKi0pRnTSLHhcivbdmtq2MMyyyBm7GwmIrg1UJmM//+QL3eBhGWXd1iOIu
 H/1r3O9wsBLEFieA+5wYY2lS6rLKH6TVFlHl/wNa4bh69ZbtZqwvtQrhVrKXEfAymjz9
 zbPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cI8YTtXtSllR0ZWQ1/hAxymikjU5SZ/BDOowwrdoNdI=;
 b=vK8XIYAJNMnFCaZaSGBJlvIYlM8k3eeX3mx7LUGa7ES6Y76GnKGJoLHw+plandpNTZ
 LWCE4y6NNvJ5ti21HGkyWuNyhvZeCAmcdNJh8Y7o8vSiAPpAaIVQmFCWcp9iDyMlXhQM
 1T1OX1pYQQT5fg9C4U5tzGkaGessqHq28WfVNm9U1FaeDed4giQylQbIuYBCFgcjiP1N
 8eFSQzoDjIGQK2gETZShXdTLaSULc6H5XomLE2nNYwg0pk626n9hFcycnZpb3U1IO09L
 fjIBnoZEywuRbA5qMp7gJFUsxBN+ZCk/MJF+DxRnnISLLVv7UoKU6q7PDzsRKYielQsz
 G1Mw==
X-Gm-Message-State: ANoB5plZL+ZpiVBdqXvw6rUcjZdTXKzQ9IJqeMmNDU/Z0KmYv4eRNWOw
 wJCj65DDlSD7Odo7XMV/L/YoIg==
X-Google-Smtp-Source: AA0mqf6Nv0wgvDSv0mEjitXi1b9M/rFWfd6EeMjprH01S1k7tVdrxI4JW3vcLRGoev0rw/t7QI22aA==
X-Received: by 2002:a17:902:da8d:b0:189:3a04:4466 with SMTP id
 j13-20020a170902da8d00b001893a044466mr950432plx.2.1671041236705; 
 Wed, 14 Dec 2022 10:07:16 -0800 (PST)
Received: from google.com (220.181.82.34.bc.googleusercontent.com.
 [34.82.181.220]) by smtp.gmail.com with ESMTPSA id
 o1-20020a170902bcc100b0017c37a5a2fdsm2141073pls.216.2022.12.14.10.07.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Dec 2022 10:07:16 -0800 (PST)
Date: Wed, 14 Dec 2022 10:07:12 -0800
From: Ricardo Koller <ricarkol@google.com>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Subject: Re: [kvm-unit-tests PATCH 1/3] arm: pmu: Fix overflow checks for
 PMUv3p5 long counters
Message-ID: <Y5oQ0KpDFHJoM0uh@google.com>
References: <20221202045527.3646838-1-ricarkol@google.com>
 <20221202045527.3646838-2-ricarkol@google.com>
 <Y5hxvj6p+mCC2DOs@monolith.localdoman>
 <Y5imhKUIJceHDUMD@google.com>
 <Y5irunF72esHzOWj@monolith.localdoman>
 <Y5i94ojqRTJMWu8U@google.com>
 <Y5mpbWmhTi41Rmni@monolith.localdoman>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y5mpbWmhTi41Rmni@monolith.localdoman>
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

On Wed, Dec 14, 2022 at 10:46:05AM +0000, Alexandru Elisei wrote:
> Hi,
> 
> On Tue, Dec 13, 2022 at 10:01:06AM -0800, Ricardo Koller wrote:
> > On Tue, Dec 13, 2022 at 04:43:38PM +0000, Alexandru Elisei wrote:
> > > Hi,
> > > 
> > > On Tue, Dec 13, 2022 at 08:21:24AM -0800, Ricardo Koller wrote:
> > > > On Tue, Dec 13, 2022 at 12:36:14PM +0000, Alexandru Elisei wrote:
> > > > > Hi,
> > > > > 
> > > > > Some more comments below.
> > > > > 
> > > > > On Fri, Dec 02, 2022 at 04:55:25AM +0000, Ricardo Koller wrote:
> > > > > > PMUv3p5 uses 64-bit counters irrespective of whether the PMU is configured
> > > > > > for overflowing at 32 or 64-bits. The consequence is that tests that check
> > > > > > the counter values after overflowing should not assume that values will be
> > > > > > wrapped around 32-bits: they overflow into the other half of the 64-bit
> > > > > > counters on PMUv3p5.
> > > > > > 
> > > > > > Fix tests by correctly checking overflowing-counters against the expected
> > > > > > 64-bit value.
> > > > > > 
> > > > > > Signed-off-by: Ricardo Koller <ricarkol@google.com>
> > > > > > ---
> > > > > >  arm/pmu.c | 29 ++++++++++++++++++-----------
> > > > > >  1 file changed, 18 insertions(+), 11 deletions(-)
> > > > > > 
> > > > > > diff --git a/arm/pmu.c b/arm/pmu.c
> > > > > > index cd47b14..eeac984 100644
> > > > > > --- a/arm/pmu.c
> > > > > > +++ b/arm/pmu.c
> > > > > > @@ -54,10 +54,10 @@
> > > > > >  #define EXT_COMMON_EVENTS_LOW	0x4000
> > > > > >  #define EXT_COMMON_EVENTS_HIGH	0x403F
> > > > > >  
> > > > > > -#define ALL_SET			0xFFFFFFFF
> > > > > > -#define ALL_CLEAR		0x0
> > > > > > -#define PRE_OVERFLOW		0xFFFFFFF0
> > > > > > -#define PRE_OVERFLOW2		0xFFFFFFDC
> > > > > > +#define ALL_SET			0x00000000FFFFFFFFULL
> > > > > > +#define ALL_CLEAR		0x0000000000000000ULL
> > > > > > +#define PRE_OVERFLOW		0x00000000FFFFFFF0ULL
> > > > > > +#define PRE_OVERFLOW2		0x00000000FFFFFFDCULL
> > > > > >  
> > > > > >  #define PMU_PPI			23
> > > > > >  
> > > > > > @@ -538,6 +538,7 @@ static void test_mem_access(void)
> > > > > >  static void test_sw_incr(void)
> > > > > >  {
> > > > > >  	uint32_t events[] = {SW_INCR, SW_INCR};
> > > > > > +	uint64_t cntr0;
> > > > > >  	int i;
> > > > > >  
> > > > > >  	if (!satisfy_prerequisites(events, ARRAY_SIZE(events)))
> > > > > > @@ -572,9 +573,9 @@ static void test_sw_incr(void)
> > > > > >  		write_sysreg(0x3, pmswinc_el0);
> > > > > >  
> > > > > >  	isb();
> > > > > > -	report(read_regn_el0(pmevcntr, 0)  == 84, "counter #1 after + 100 SW_INCR");
> > > > > > -	report(read_regn_el0(pmevcntr, 1)  == 100,
> > > > > > -		"counter #0 after + 100 SW_INCR");
> > > > > > +	cntr0 = (pmu.version < ID_DFR0_PMU_V3_8_5) ? 84 : PRE_OVERFLOW + 100;
> > > > > > +	report(read_regn_el0(pmevcntr, 0) == cntr0, "counter #0 after + 100 SW_INCR");
> > > > > > +	report(read_regn_el0(pmevcntr, 1) == 100, "counter #1 after + 100 SW_INCR");
> > > > > >  	report_info("counter values after 100 SW_INCR #0=%ld #1=%ld",
> > > > > >  		    read_regn_el0(pmevcntr, 0), read_regn_el0(pmevcntr, 1));
> > > > > >  	report(read_sysreg(pmovsclr_el0) == 0x1,
> > > > > > @@ -584,6 +585,7 @@ static void test_sw_incr(void)
> > > > > >  static void test_chained_counters(void)
> > > > > >  {
> > > > > >  	uint32_t events[] = {CPU_CYCLES, CHAIN};
> > > > > > +	uint64_t cntr1;
> > > > > >  
> > > > > >  	if (!satisfy_prerequisites(events, ARRAY_SIZE(events)))
> > > > > >  		return;
> > > > > > @@ -618,13 +620,16 @@ static void test_chained_counters(void)
> > > > > >  
> > > > > >  	precise_instrs_loop(22, pmu.pmcr_ro | PMU_PMCR_E);
> > > > > >  	report_info("overflow reg = 0x%lx", read_sysreg(pmovsclr_el0));
> > > > > > -	report(!read_regn_el0(pmevcntr, 1), "CHAIN counter #1 wrapped");
> > > > > > +	cntr1 = (pmu.version < ID_DFR0_PMU_V3_8_5) ? 0 : ALL_SET + 1;
> > > > > > +	report(read_regn_el0(pmevcntr, 1) == cntr1, "CHAIN counter #1 wrapped");
> > > > > 
> > > > > It looks to me like the intention of the test was to check that the counter
> > > > > programmed with the CHAIN event wraps, judging from the report message.
> > > > > 
> > > > 
> > > > Ah, right. Yeah, that message is confusing. It should be the short
> > > > version of "Inrementing at 32-bits resulted in the right value".
> > > > 
> > > > > I think it would be interesting to keep that by programming counter #1 with
> > > > > ~0ULL when PMUv3p5 (maybe call it ALL_SET64?) and test the counter value
> > > > > against 0.
> > > > 
> > > > The last commit adds tests using ALL_SET64.  Tests can be run in two
> > > > modes: overflow_at_64bits and not.  However, this test,
> > > > test_chained_counters(), and all other chained tests only use the
> > > > !overflow_at_64bits mode (even after the last commit). The reason is
> > > > that there are no CHAIN events when overflowing at 64-bits (more details
> > > > in the commit message). But, don't worry, there are lots of tests that
> > > > check wrapping at 64-bits (overflow_at_64bits=true).
> > > 
> > > What I was suggesting is this (change on top of this series, not on top of
> > > this patch, to get access to ALL_SET_AT):
> > 
> > Ooh, I see, I agree: it would be better to check that the odd counter
> > increments from ~0ULL to 0 when using 64-bit counters.
> > 
> > > 
> > > diff --git a/arm/pmu.c b/arm/pmu.c
> > > index 3cb563b1abe4..fd7f20fc6c52 100644
> > > --- a/arm/pmu.c
> > > +++ b/arm/pmu.c
> > > @@ -607,7 +607,6 @@ static void test_sw_incr(bool overflow_at_64bits)
> > >  static void test_chained_counters(bool overflow_at_64bits)
> > >  {
> > >         uint32_t events[] = {CPU_CYCLES, CHAIN};
> > > -       uint64_t cntr1;
> > > 
> > >         if (!satisfy_prerequisites(events, ARRAY_SIZE(events),
> > >                                    overflow_at_64bits))
> > > @@ -639,12 +638,11 @@ static void test_chained_counters(bool overflow_at_64bits)
> > >         report(read_sysreg(pmovsclr_el0) == 0x1, "overflow recorded for chained incr #2");
> > > 
> > >         write_regn_el0(pmevcntr, 0, PRE_OVERFLOW);
> > > -       write_regn_el0(pmevcntr, 1, ALL_SET);
> > > +       write_regn_el0(pmevcntr, 1, ALL_SET_AT(overflow_at_64bits));
> > 
> > The only change is that this should be:
> > 
> > 	ALL_SET_AT(pmu.version >= ID_DFR0_PMU_V3_8_5)
> > 
> > Because "overflow_at_64bits" implies PMCR_EL0.LP = 1.
> 
> Right, and test_chained_counters() is never called with overflow_at_64bits
> == true.
> 
> How about renaming the parameter overflow_at_64bits -> unused (or something
> like that) to make it clear that the function does the same thing
> regardless of the value?

Sounds good, will do for v2.

> 
> Thanks,
> Alex
> 
> > 
> > > 
> > >         precise_instrs_loop(22, pmu.pmcr_ro | PMU_PMCR_E);
> > >         report_info("overflow reg = 0x%lx", read_sysreg(pmovsclr_el0));
> > > -       cntr1 = (pmu.version < ID_DFR0_PMU_V3_8_5) ? 0 : ALL_SET + 1;
> > > -       report(read_regn_el0(pmevcntr, 1) == cntr1, "CHAIN counter #1 wrapped");
> > > +       report(read_regn_el0(pmevcntr, 1) == 0, "CHAIN counter #1 wrapped");
> > > 
> > >         report(read_sysreg(pmovsclr_el0) == 0x3, "overflow on even and odd counters");
> > >  }
> > > 
> > > The counters are 64bit, but the CHAIN event should still work because
> > > PMCR_EL0.LP is 0, according to the event description in the Arm ARM (ARM
> > > DDI 0487I.a, page D17-6461).
> > > 
> > > Thanks,
> > > Alex
> > > 
> > > > 
> > > > > Alternatively, the report message can be modified, and "wrapped"
> > > > > replaced with "incremented" (or something like that), to avoid confusion.
> > > > > 
> > > > > > +
> > > > > >  	report(read_sysreg(pmovsclr_el0) == 0x3, "overflow on even and odd counters");
> > > > > >  }
> > > > > >  
> > > > > >  static void test_chained_sw_incr(void)
> > > > > >  {
> > > > > >  	uint32_t events[] = {SW_INCR, CHAIN};
> > > > > > +	uint64_t cntr0, cntr1;
> > > > > >  	int i;
> > > > > >  
> > > > > >  	if (!satisfy_prerequisites(events, ARRAY_SIZE(events)))
> > > > > > @@ -665,10 +670,12 @@ static void test_chained_sw_incr(void)
> > > > > >  		write_sysreg(0x1, pmswinc_el0);
> > > > > >  
> > > > > >  	isb();
> > > > > > +	cntr0 = (pmu.version < ID_DFR0_PMU_V3_8_5) ? 0 : ALL_SET + 1;
> > > > > > +	cntr1 = (pmu.version < ID_DFR0_PMU_V3_8_5) ? 84 : PRE_OVERFLOW + 100;
> > > > > >  	report((read_sysreg(pmovsclr_el0) == 0x3) &&
> > > > > > -		(read_regn_el0(pmevcntr, 1) == 0) &&
> > > > > > -		(read_regn_el0(pmevcntr, 0) == 84),
> > > > > > -		"expected overflows and values after 100 SW_INCR/CHAIN");
> > > > > > +	       (read_regn_el0(pmevcntr, 1) == cntr0) &&
> > > > > > +	       (read_regn_el0(pmevcntr, 0) == cntr1),
> > > > > 
> > > > > This is hard to parse, it would be better if counter 0 is compared against
> > > > > cntr0 and counter 1 against cntr1.
> > > > 
> > > > Ah, yes, code is correct but that's indeed confusing.
> > > > 
> > > > > 
> > > > > Also, same suggestion here, looks like the test wants to check that the
> > > > > odd-numbered counter wraps around when counting the CHAIN event.
> > > > 
> > > > Ack. Will update for v2.
> > > > 
> > > > Thanks!
> > > > Ricardo
> > > > 
> > > > > 
> > > > > Thanks,
> > > > > Alex
> > > > > 
> > > > > > +	       "expected overflows and values after 100 SW_INCR/CHAIN");
> > > > > >  	report_info("overflow=0x%lx, #0=%ld #1=%ld", read_sysreg(pmovsclr_el0),
> > > > > >  		    read_regn_el0(pmevcntr, 0), read_regn_el0(pmevcntr, 1));
> > > > > >  }
> > > > > > -- 
> > > > > > 2.39.0.rc0.267.gcb52ba06e7-goog
> > > > > > 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
