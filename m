Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 10E2417A25D
	for <lists+kvmarm@lfdr.de>; Thu,  5 Mar 2020 10:41:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8F0784AEB3;
	Thu,  5 Mar 2020 04:41:04 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pyLiv21yCd1x; Thu,  5 Mar 2020 04:41:04 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 37ABD4AEB1;
	Thu,  5 Mar 2020 04:41:03 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 47A914AEA0
 for <kvmarm@lists.cs.columbia.edu>; Thu,  5 Mar 2020 04:41:02 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Gt5S5QBzU3Da for <kvmarm@lists.cs.columbia.edu>;
 Thu,  5 Mar 2020 04:41:01 -0500 (EST)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1178A4A588
 for <kvmarm@lists.cs.columbia.edu>; Thu,  5 Mar 2020 04:41:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583401260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H+FCFIRFbznBQRS5RiI1oKiCG0Ih5s+Wl3PBFLEoSi4=;
 b=H3vPo03i5AdzR1EQ5Z05iGeYKRdRLnrW/kT+zhuIs16igUOiT3WHZ7twaMHsZJsAEjoLAR
 dI9d7nWyhp2YFxSwfwoe2WzpQpddam/p6P+dyXZfK7jgbi/FXu2c5QHlDYujcr0e+7DB/n
 70gOuKlVGvF4aTphUCxMJUiJIVg+ems=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-EoOYzJSpNP6oNmtkXi4aGQ-1; Thu, 05 Mar 2020 04:37:23 -0500
X-MC-Unique: EoOYzJSpNP6oNmtkXi4aGQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF678800D6C;
 Thu,  5 Mar 2020 09:37:21 +0000 (UTC)
Received: from kamzik.brq.redhat.com (ovpn-204-110.brq.redhat.com
 [10.40.204.110])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 84A6D90795;
 Thu,  5 Mar 2020 09:37:15 +0000 (UTC)
Date: Thu, 5 Mar 2020 10:37:12 +0100
From: Andrew Jones <drjones@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v2 6/9] arm: pmu: Test chained counter
Message-ID: <20200305093712.moxksc534hprwu5o@kamzik.brq.redhat.com>
References: <20200130112510.15154-1-eric.auger@redhat.com>
 <20200130112510.15154-7-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200130112510.15154-7-eric.auger@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: kvm@vger.kernel.org, maz@kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, andre.przywara@arm.com, andrew.murray@arm.com,
 kvmarm@lists.cs.columbia.edu, eric.auger.pro@gmail.com
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

On Thu, Jan 30, 2020 at 12:25:07PM +0100, Eric Auger wrote:
> Add 2 tests exercising chained counters. The first one uses
> CPU_CYCLES and the second one uses SW_INCR.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  arm/pmu.c         | 128 ++++++++++++++++++++++++++++++++++++++++++++++
>  arm/unittests.cfg |  12 +++++
>  2 files changed, 140 insertions(+)
> 
> diff --git a/arm/pmu.c b/arm/pmu.c
> index 1b0101f..538fbeb 100644
> --- a/arm/pmu.c
> +++ b/arm/pmu.c
> @@ -113,6 +113,8 @@ static void test_event_introspection(void) {}
>  static void test_event_counter_config(void) {}
>  static void test_basic_event_count(void) {}
>  static void test_mem_access(void) {}
> +static void test_chained_counters(void) {}
> +static void test_chained_sw_incr(void) {}
>  
>  #elif defined(__aarch64__)
>  #define ID_AA64DFR0_PERFMON_SHIFT 8
> @@ -458,6 +460,126 @@ static void test_mem_access(void)
>  			read_sysreg(pmovsclr_el0));
>  }
>  
> +static void test_chained_counters(void)
> +{
> +	uint32_t events[] = { 0x11 /* CPU_CYCLES */, 0x1E /* CHAIN */};
> +
> +	if (!satisfy_prerequisites(events, ARRAY_SIZE(events)))
> +		return;
> +
> +	pmu_reset();
> +
> +	write_regn(pmevtyper, 0, events[0] | PMEVTYPER_EXCLUDE_EL0);
> +	write_regn(pmevtyper, 1, events[1] | PMEVTYPER_EXCLUDE_EL0);
> +	/* enable counters #0 and #1 */
> +	write_sysreg_s(0x3, PMCNTENSET_EL0);
> +	/* preset counter #0 at 0xFFFFFFF0 */
> +	write_regn(pmevcntr, 0, 0xFFFFFFF0);
> +
> +	precise_instrs_loop(22, pmu.pmcr_ro | PMU_PMCR_E);
> +
> +	report(read_regn(pmevcntr, 1) == 1, "CHAIN counter #1 incremented");
> +	report(!read_sysreg(pmovsclr_el0), "check no overflow is recorded");
> +
> +	/* test 64b overflow */
> +
> +	pmu_reset();
> +	write_sysreg_s(0x3, PMCNTENSET_EL0);
> +
> +	write_regn(pmevcntr, 0, 0xFFFFFFF0);
> +	write_regn(pmevcntr, 1, 0x1);
> +	precise_instrs_loop(22, pmu.pmcr_ro | PMU_PMCR_E);
> +	report_info("overflow reg = 0x%lx", read_sysreg(pmovsclr_el0));
> +	report(read_regn(pmevcntr, 1) == 2, "CHAIN counter #1 incremented");
> +	report(!read_sysreg(pmovsclr_el0), "check no overflow is recorded");
> +
> +	write_regn(pmevcntr, 0, 0xFFFFFFF0);
> +	write_regn(pmevcntr, 1, 0xFFFFFFFF);
> +
> +	precise_instrs_loop(22, pmu.pmcr_ro | PMU_PMCR_E);
> +	report_info("overflow reg = 0x%lx", read_sysreg(pmovsclr_el0));
> +	report(!read_regn(pmevcntr, 1), "CHAIN counter #1 wrapped");
> +	report(read_sysreg(pmovsclr_el0) == 0x2,
> +		"check no overflow is recorded");
> +}
> +
> +static void test_chained_sw_incr(void)
> +{
> +	uint32_t events[] = { 0x0 /* SW_INCR */, 0x0 /* SW_INCR */};
> +	int i;
> +
> +	if (!satisfy_prerequisites(events, ARRAY_SIZE(events)))
> +		return;
> +
> +	pmu_reset();
> +
> +	write_regn(pmevtyper, 0, events[0] | PMEVTYPER_EXCLUDE_EL0);
> +	write_regn(pmevtyper, 1, events[1] | PMEVTYPER_EXCLUDE_EL0);
> +	/* enable counters #0 and #1 */
> +	write_sysreg_s(0x3, PMCNTENSET_EL0);
> +
> +	/* preset counter #0 at 0xFFFFFFF0 */
> +	write_regn(pmevcntr, 0, 0xFFFFFFF0);
> +
> +	for (i = 0; i < 100; i++)
> +		write_sysreg(0x1, pmswinc_el0);
> +
> +	report_info("SW_INCR counter #0 has value %ld", read_regn(pmevcntr, 0));
> +	report(read_regn(pmevcntr, 0) == 0xFFFFFFF0,
> +		"PWSYNC does not increment if PMCR.E is unset");
> +
> +	pmu_reset();
> +
> +	write_regn(pmevcntr, 0, 0xFFFFFFF0);
> +	write_sysreg_s(0x3, PMCNTENSET_EL0);
> +	set_pmcr(pmu.pmcr_ro | PMU_PMCR_E);
> +
> +	for (i = 0; i < 100; i++)
> +		write_sysreg(0x3, pmswinc_el0);
> +
> +	report(read_regn(pmevcntr, 0)  == 84, "counter #1 after + 100 SW_INCR");
> +	report(read_regn(pmevcntr, 1)  == 100,
> +		"counter #0 after + 100 SW_INCR");
> +	report_info("counter values after 100 SW_INCR #0=%ld #1=%ld",
> +		    read_regn(pmevcntr, 0), read_regn(pmevcntr, 1));
> +	report(read_sysreg(pmovsclr_el0) == 0x1,
> +		"overflow reg after 100 SW_INCR");
> +
> +	/* 64b SW_INCR */
> +	pmu_reset();
> +
> +	events[1] = 0x1E /* CHAIN */;
> +	write_regn(pmevtyper, 1, events[1] | PMEVTYPER_EXCLUDE_EL0);
> +	write_regn(pmevcntr, 0, 0xFFFFFFF0);
> +	write_sysreg_s(0x3, PMCNTENSET_EL0);
> +	set_pmcr(pmu.pmcr_ro | PMU_PMCR_E);
> +	for (i = 0; i < 100; i++)
> +		write_sysreg(0x3, pmswinc_el0);
> +
> +	report(!read_sysreg(pmovsclr_el0) && (read_regn(pmevcntr, 1) == 1),
> +		"overflow reg after 100 SW_INCR/CHAIN");
> +	report_info("overflow=0x%lx, #0=%ld #1=%ld", read_sysreg(pmovsclr_el0),
> +		    read_regn(pmevcntr, 0), read_regn(pmevcntr, 1));
> +
> +	/* 64b SW_INCR and overflow on CHAIN counter*/
> +	pmu_reset();
> +
> +	write_regn(pmevtyper, 1, events[1] | PMEVTYPER_EXCLUDE_EL0);
> +	write_regn(pmevcntr, 0, 0xFFFFFFF0);
> +	write_regn(pmevcntr, 1, 0xFFFFFFFF);
> +	write_sysreg_s(0x3, PMCNTENSET_EL0);
> +	set_pmcr(pmu.pmcr_ro | PMU_PMCR_E);
> +	for (i = 0; i < 100; i++)
> +		write_sysreg(0x3, pmswinc_el0);
> +
> +	report((read_sysreg(pmovsclr_el0) == 0x2) &&
> +		(read_regn(pmevcntr, 1) == 0) &&
> +		(read_regn(pmevcntr, 0) == 84),
> +		"overflow reg after 100 SW_INCR/CHAIN");
> +	report_info("overflow=0x%lx, #0=%ld #1=%ld", read_sysreg(pmovsclr_el0),
> +		    read_regn(pmevcntr, 0), read_regn(pmevcntr, 1));
> +}
> +
>  #endif
>  
>  /*
> @@ -657,6 +779,12 @@ int main(int argc, char *argv[])
>  	} else if (strcmp(argv[1], "mem-access") == 0) {
>  		report_prefix_push(argv[1]);
>  		test_mem_access();
> +	} else if (strcmp(argv[1], "chained-counters") == 0) {
> +		report_prefix_push(argv[1]);
> +		test_chained_counters();
> +	} else if (strcmp(argv[1], "chained-sw-incr") == 0) {
> +		report_prefix_push(argv[1]);
> +		test_chained_sw_incr();
>  	} else {
>  		report_abort("Unknown sub-test '%s'", argv[1]);
>  	}
> diff --git a/arm/unittests.cfg b/arm/unittests.cfg
> index 7a59403..1bd4319 100644
> --- a/arm/unittests.cfg
> +++ b/arm/unittests.cfg
> @@ -90,6 +90,18 @@ groups = pmu
>  arch = arm64
>  extra_params = -append 'mem-access'
>  
> +[pmu-chained-counters]
> +file = pmu.flat
> +groups = pmu
> +arch = arm64
> +extra_params = -append 'chained-counters'
> +
> +[pmu-chained-sw-incr]
> +file = pmu.flat
> +groups = pmu
> +arch = arm64
> +extra_params = -append 'chained-sw-incr'
> +
>  # Test PMU support (TCG) with -icount IPC=1
>  #[pmu-tcg-icount-1]
>  #file = pmu.flat
> -- 
> 2.20.1
> 
> 

Same comments as previous patch

Thanks,
drew

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
