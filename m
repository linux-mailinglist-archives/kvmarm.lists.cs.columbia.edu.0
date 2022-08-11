Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB7758F810
	for <lists+kvmarm@lfdr.de>; Thu, 11 Aug 2022 09:04:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 029C24E1D2;
	Thu, 11 Aug 2022 03:04:12 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.79
X-Spam-Level: 
X-Spam-Status: No, score=-1.79 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@linux.dev
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QQYAQ+TlgzY2; Thu, 11 Aug 2022 03:04:11 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4D2634E1BB;
	Thu, 11 Aug 2022 03:04:10 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CAED24E134
 for <kvmarm@lists.cs.columbia.edu>; Thu, 11 Aug 2022 03:04:09 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3BUCeOEiwqS5 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 11 Aug 2022 03:04:08 -0400 (EDT)
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 58A094E12F
 for <kvmarm@lists.cs.columbia.edu>; Thu, 11 Aug 2022 03:04:08 -0400 (EDT)
Date: Thu, 11 Aug 2022 09:04:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1660201446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TTaS2Wl4s+FHjKmL6fx39BEFrM00eO4qJqKwdGgGK7I=;
 b=w8b/zs5SmUNurS05xL67OGF8+skjQ1DyAZlcyLcQYzhCIi2446ekacCLSZ9eixKZOoQ44B
 okD9LuUqOgENU5sxRyi1cLrqtSpxkySgm4pG2PQTb2iVnCLheqRGT/o0znjI+/lnR0uAsQ
 hCmNaYbIx7w+6uKmVtL0w30DX9jyBGw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Andrew Jones <andrew.jones@linux.dev>
To: Ricardo Koller <ricarkol@google.com>
Subject: Re: [kvm-unit-tests PATCH v3 2/3] arm: pmu: Reset the pmu registers
 before starting some tests
Message-ID: <20220811070405.ivo5w2mliwi4cpqk@kamzik>
References: <20220805004139.990531-1-ricarkol@google.com>
 <20220805004139.990531-3-ricarkol@google.com>
 <20220810190216.hqt3wyzufyvhhpkf@kamzik>
 <YvRARgEDkSI1ken5@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YvRARgEDkSI1ken5@google.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Cc: kvm@vger.kernel.org, maz@kernel.org, kvmarm@lists.cs.columbia.edu
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

On Wed, Aug 10, 2022 at 04:33:26PM -0700, Ricardo Koller wrote:
> On Wed, Aug 10, 2022 at 09:02:16PM +0200, Andrew Jones wrote:
> > On Thu, Aug 04, 2022 at 05:41:38PM -0700, Ricardo Koller wrote:
> > > Some registers like the PMOVS reset to an architecturally UNKNOWN value.
> > > Most tests expect them to be reset (mostly zeroed) using pmu_reset().
> > > Add a pmu_reset() on all the tests that need one.
> > > 
> > > As a bonus, fix a couple of comments related to the register state
> > > before a sub-test.
> > > 
> > > Reviewed-by: Eric Auger <eric.auger@redhat.com>
> > > Signed-off-by: Ricardo Koller <ricarkol@google.com>
> > > ---
> > >  arm/pmu.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arm/pmu.c b/arm/pmu.c
> > > index 4c601b05..12e7d84e 100644
> > > --- a/arm/pmu.c
> > > +++ b/arm/pmu.c
> > > @@ -826,7 +826,7 @@ static void test_overflow_interrupt(void)
> > >  	write_regn_el0(pmevcntr, 1, PRE_OVERFLOW);
> > >  	isb();
> > >  
> > > -	/* interrupts are disabled */
> > > +	/* interrupts are disabled (PMINTENSET_EL1 == 0) */
> > >  
> > >  	mem_access_loop(addr, 200, pmu.pmcr_ro | PMU_PMCR_E);
> > >  	report(expect_interrupts(0), "no overflow interrupt after preset");
> > > @@ -842,7 +842,7 @@ static void test_overflow_interrupt(void)
> > >  	isb();
> > >  	report(expect_interrupts(0), "no overflow interrupt after counting");
> > >  
> > > -	/* enable interrupts */
> > > +	/* enable interrupts (PMINTENSET_EL1 <= ALL_SET) */
> > >  
> > >  	pmu_reset_stats();
> > >  
> > > @@ -890,6 +890,7 @@ static bool check_cycles_increase(void)
> > >  	bool success = true;
> > >  
> > >  	/* init before event access, this test only cares about cycle count */
> > > +	pmu_reset();
> > 
> > This and the other pmu_reset() call below break compilation on 32-bit arm,
> > because there's no pmu_reset() defined for it.
> I completely missed the 32-bit arm case. Thanks!
> 
> > It'd probably be best if
> > we actually implemented some sort of reset for arm, considering it's being
> > called in common tests.
> 
> Mind if I start by creating a pmu_reset() for 32-bit arm, which can
> later be used by a general arm_reset()?

No need to worry about a general one. We just need a pmu_reset implemented
for 32-bit arm up in its #ifdef __arm__ section.

Thanks,
drew

> 
> > 
> > Thanks,
> > drew
> > 
> > >  	set_pmcntenset(1 << PMU_CYCLE_IDX);
> > >  	set_pmccfiltr(0); /* count cycles in EL0, EL1, but not EL2 */
> > >  
> > > @@ -944,6 +945,7 @@ static bool check_cpi(int cpi)
> > >  	uint32_t pmcr = get_pmcr() | PMU_PMCR_LC | PMU_PMCR_C | PMU_PMCR_E;
> > >  
> > >  	/* init before event access, this test only cares about cycle count */
> > > +	pmu_reset();
> > >  	set_pmcntenset(1 << PMU_CYCLE_IDX);
> > >  	set_pmccfiltr(0); /* count cycles in EL0, EL1, but not EL2 */
> > >  
> > > -- 
> > > 2.37.1.559.g78731f0fdb-goog
> > > 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
