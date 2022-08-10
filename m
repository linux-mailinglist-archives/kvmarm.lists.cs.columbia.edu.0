Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 928B658F196
	for <lists+kvmarm@lfdr.de>; Wed, 10 Aug 2022 19:30:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9FED54DB93;
	Wed, 10 Aug 2022 13:30:38 -0400 (EDT)
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
	with ESMTP id PejCv3OilUho; Wed, 10 Aug 2022 13:30:38 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1C3E14DBA9;
	Wed, 10 Aug 2022 13:30:37 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4656E4DBA4
 for <kvmarm@lists.cs.columbia.edu>; Wed, 10 Aug 2022 13:30:36 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o776tBoRIu3M for <kvmarm@lists.cs.columbia.edu>;
 Wed, 10 Aug 2022 13:30:34 -0400 (EDT)
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id C0EAF4DB93
 for <kvmarm@lists.cs.columbia.edu>; Wed, 10 Aug 2022 13:30:34 -0400 (EDT)
Date: Wed, 10 Aug 2022 12:30:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1660152633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WoVFpwaOq8leNIXAsm/PUsis11E+vqMhQu8dN2blKRM=;
 b=u5eU+dm9LOKP3YpatYQd+mFSP4S1in3MqvMzDfXt+MRHDT25O3LhUXWkWH9NqVFJHTqULc
 LLaoRLSI4CUjPE/1n76GkRNnDq5+Oeqf+K1qkNnTOqSZO6gBe7HGvgRd4gubL5pXojHtYl
 He0t8RiP2v+hEZVJ7JmqS8SJmsaC0xo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Ricardo Koller <ricarkol@google.com>
Subject: Re: [kvm-unit-tests PATCH v3 3/3] arm: pmu: Check for overflow in
 the low counter in chained counters tests
Message-ID: <YvPrMtKkrVc8HhOA@google.com>
References: <20220805004139.990531-1-ricarkol@google.com>
 <20220805004139.990531-4-ricarkol@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220805004139.990531-4-ricarkol@google.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
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

On Thu, Aug 04, 2022 at 05:41:39PM -0700, Ricardo Koller wrote:
> A chained event overflowing on the low counter can set the overflow flag
> in PMOVS.  KVM does not set it, but real HW and the fast-model seem to.
> Moreover, the AArch64.IncrementEventCounter() pseudocode in the ARM ARM
> (DDI 0487H.a, J1.1.1 "aarch64/debug") also sets the PMOVS bit on
> overflow.
> 
> The pmu chain tests fail on bare metal when checking the overflow flag
> of the low counter _not_ being set on overflow.  Fix by checking for
> overflow. Note that this test fails in KVM without the respective fix.
> 

It'd be good to link out to the respective KVM fix, either by commit or
lore link if this patch lands before the kernel patches:

Link: http://lore.kernel.org/r/20220805135813.2102034-1-maz@kernel.org

--
Thanks,
Oliver

> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Ricardo Koller <ricarkol@google.com>
> ---
>  arm/pmu.c | 33 ++++++++++++++++++---------------
>  1 file changed, 18 insertions(+), 15 deletions(-)
> 
> diff --git a/arm/pmu.c b/arm/pmu.c
> index 12e7d84e..0a7e12f8 100644
> --- a/arm/pmu.c
> +++ b/arm/pmu.c
> @@ -583,7 +583,7 @@ static void test_chained_counters(void)
>  	precise_instrs_loop(22, pmu.pmcr_ro | PMU_PMCR_E);
>  
>  	report(read_regn_el0(pmevcntr, 1) == 1, "CHAIN counter #1 incremented");
> -	report(!read_sysreg(pmovsclr_el0), "no overflow recorded for chained incr #1");
> +	report(read_sysreg(pmovsclr_el0) == 0x1, "overflow recorded for chained incr #1");
>  
>  	/* test 64b overflow */
>  
> @@ -595,7 +595,7 @@ static void test_chained_counters(void)
>  	precise_instrs_loop(22, pmu.pmcr_ro | PMU_PMCR_E);
>  	report_info("overflow reg = 0x%lx", read_sysreg(pmovsclr_el0));
>  	report(read_regn_el0(pmevcntr, 1) == 2, "CHAIN counter #1 set to 2");
> -	report(!read_sysreg(pmovsclr_el0), "no overflow recorded for chained incr #2");
> +	report(read_sysreg(pmovsclr_el0) == 0x1, "overflow recorded for chained incr #2");
>  
>  	write_regn_el0(pmevcntr, 0, PRE_OVERFLOW);
>  	write_regn_el0(pmevcntr, 1, ALL_SET);
> @@ -603,7 +603,7 @@ static void test_chained_counters(void)
>  	precise_instrs_loop(22, pmu.pmcr_ro | PMU_PMCR_E);
>  	report_info("overflow reg = 0x%lx", read_sysreg(pmovsclr_el0));
>  	report(!read_regn_el0(pmevcntr, 1), "CHAIN counter #1 wrapped");
> -	report(read_sysreg(pmovsclr_el0) == 0x2, "overflow on chain counter");
> +	report(read_sysreg(pmovsclr_el0) == 0x3, "overflow on even and odd counters");
>  }
>  
>  static void test_chained_sw_incr(void)
> @@ -629,8 +629,9 @@ static void test_chained_sw_incr(void)
>  		write_sysreg(0x1, pmswinc_el0);
>  
>  	isb();
> -	report(!read_sysreg(pmovsclr_el0) && (read_regn_el0(pmevcntr, 1) == 1),
> -		"no overflow and chain counter incremented after 100 SW_INCR/CHAIN");
> +	report((read_sysreg(pmovsclr_el0) == 0x1) &&
> +		(read_regn_el0(pmevcntr, 1) == 1),
> +		"overflow and chain counter incremented after 100 SW_INCR/CHAIN");
>  	report_info("overflow=0x%lx, #0=%ld #1=%ld", read_sysreg(pmovsclr_el0),
>  		    read_regn_el0(pmevcntr, 0), read_regn_el0(pmevcntr, 1));
>  
> @@ -648,10 +649,10 @@ static void test_chained_sw_incr(void)
>  		write_sysreg(0x1, pmswinc_el0);
>  
>  	isb();
> -	report((read_sysreg(pmovsclr_el0) == 0x2) &&
> +	report((read_sysreg(pmovsclr_el0) == 0x3) &&
>  		(read_regn_el0(pmevcntr, 1) == 0) &&
>  		(read_regn_el0(pmevcntr, 0) == 84),
> -		"overflow on chain counter and expected values after 100 SW_INCR/CHAIN");
> +		"expected overflows and values after 100 SW_INCR/CHAIN");
>  	report_info("overflow=0x%lx, #0=%ld #1=%ld", read_sysreg(pmovsclr_el0),
>  		    read_regn_el0(pmevcntr, 0), read_regn_el0(pmevcntr, 1));
>  }
> @@ -731,8 +732,9 @@ static void test_chain_promotion(void)
>  	report_info("MEM_ACCESS counter #0 has value 0x%lx",
>  		    read_regn_el0(pmevcntr, 0));
>  
> -	report((read_regn_el0(pmevcntr, 1) == 1) && !read_sysreg(pmovsclr_el0),
> -		"CHAIN counter enabled: CHAIN counter was incremented and no overflow");
> +	report((read_regn_el0(pmevcntr, 1) == 1) &&
> +		(read_sysreg(pmovsclr_el0) == 0x1),
> +		"CHAIN counter enabled: CHAIN counter was incremented and overflow");
>  
>  	report_info("CHAIN counter #1 = 0x%lx, overflow=0x%lx",
>  		read_regn_el0(pmevcntr, 1), read_sysreg(pmovsclr_el0));
> @@ -759,8 +761,9 @@ static void test_chain_promotion(void)
>  	report_info("MEM_ACCESS counter #0 has value 0x%lx",
>  		    read_regn_el0(pmevcntr, 0));
>  
> -	report((read_regn_el0(pmevcntr, 1) == 1) && !read_sysreg(pmovsclr_el0),
> -		"32b->64b: CHAIN counter incremented and no overflow");
> +	report((read_regn_el0(pmevcntr, 1) == 1) &&
> +		(read_sysreg(pmovsclr_el0) == 0x1),
> +		"32b->64b: CHAIN counter incremented and overflow");
>  
>  	report_info("CHAIN counter #1 = 0x%lx, overflow=0x%lx",
>  		read_regn_el0(pmevcntr, 1), read_sysreg(pmovsclr_el0));
> @@ -868,8 +871,8 @@ static void test_overflow_interrupt(void)
>  	write_regn_el0(pmevcntr, 0, PRE_OVERFLOW);
>  	isb();
>  	mem_access_loop(addr, 200, pmu.pmcr_ro | PMU_PMCR_E);
> -	report(expect_interrupts(0),
> -		"no overflow interrupt expected on 32b boundary");
> +	report(expect_interrupts(0x1),
> +		"expect overflow interrupt on 32b boundary");
>  
>  	/* overflow on odd counter */
>  	pmu_reset_stats();
> @@ -877,8 +880,8 @@ static void test_overflow_interrupt(void)
>  	write_regn_el0(pmevcntr, 1, ALL_SET);
>  	isb();
>  	mem_access_loop(addr, 400, pmu.pmcr_ro | PMU_PMCR_E);
> -	report(expect_interrupts(0x2),
> -		"expect overflow interrupt on odd counter");
> +	report(expect_interrupts(0x3),
> +		"expect overflow interrupt on even and odd counter");
>  }
>  #endif
>  
> -- 
> 2.37.1.559.g78731f0fdb-goog
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
