Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 78DBD11EB05
	for <lists+kvmarm@lfdr.de>; Fri, 13 Dec 2019 20:11:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 09DB84A65C;
	Fri, 13 Dec 2019 14:11:18 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.391
X-Spam-Level: 
X-Spam-Status: No, score=-1.391 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id weyS5RoIUC-q; Fri, 13 Dec 2019 14:11:17 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CD8894ACF5;
	Fri, 13 Dec 2019 14:11:16 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 08EA74A8E0
 for <kvmarm@lists.cs.columbia.edu>; Fri, 13 Dec 2019 14:11:16 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V22O-ih-NI4j for <kvmarm@lists.cs.columbia.edu>;
 Fri, 13 Dec 2019 14:11:14 -0500 (EST)
Received: from us-smtp-1.mimecast.com (us-smtp-2.mimecast.com [207.211.31.81])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E26474A65C
 for <kvmarm@lists.cs.columbia.edu>; Fri, 13 Dec 2019 14:11:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576264274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eq3tHp7jLyViJfHrNkpUprKdOUFUFzEmN21wHzSWZQo=;
 b=KAcJlCY4kjtU+0GOp6/Pz1iV0j3JgGewkkZVlVgs7xhgVkz4jjHf9EmULOrLhmfwM5zKsO
 jkISZOsX2dAzaUNysx6yd9HlT6NCkRzB9iqIBnj73zcGdkEwHXal+PB0HiWV+coq0spH9/
 BecmTBgWHTfycX54AwjAmRo8awzLYJM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-AiqzPycOPumUKHGDf8sbOA-1; Fri, 13 Dec 2019 14:11:10 -0500
X-MC-Unique: AiqzPycOPumUKHGDf8sbOA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5DE8100550E;
 Fri, 13 Dec 2019 19:11:08 +0000 (UTC)
Received: from kamzik.brq.redhat.com (ovpn-204-115.brq.redhat.com
 [10.40.204.115])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5C8725D9C9;
 Fri, 13 Dec 2019 19:10:48 +0000 (UTC)
Date: Fri, 13 Dec 2019 20:10:43 +0100
From: Andrew Jones <drjones@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [kvm-unit-tests RFC 04/10] pmu: Check Required Event Support
Message-ID: <20191213191043.azvoxkcsahhycmhl@kamzik.brq.redhat.com>
References: <20191206172724.947-1-eric.auger@redhat.com>
 <20191206172724.947-5-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191206172724.947-5-eric.auger@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: kvm@vger.kernel.org, maz@kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, andre.przywara@arm.com, kvmarm@lists.cs.columbia.edu,
 eric.auger.pro@gmail.com
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

On Fri, Dec 06, 2019 at 06:27:18PM +0100, Eric Auger wrote:
> If event counters are implemented check the common events
> required by the PMUv3 are implemented.
> 
> Some are unconditionally required (SW_INCR, CPU_CYCLES,
> either INST_RETIRED or INST_SPEC). Some others only are
> required if the implementation implements some other features.
> 
> Check those wich are unconditionally required.
> 
> This test currently fails on TCG as neither INST_RETIRED
> or INST_SPEC are supported.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  arm/pmu.c         | 70 +++++++++++++++++++++++++++++++++++++++++++++++
>  arm/unittests.cfg |  6 ++++
>  2 files changed, 76 insertions(+)
> 
> diff --git a/arm/pmu.c b/arm/pmu.c
> index 8e95251..f78c43f 100644
> --- a/arm/pmu.c
> +++ b/arm/pmu.c
> @@ -102,6 +102,10 @@ static inline void precise_instrs_loop(int loop, uint32_t pmcr)
>  	: [pmcr] "r" (pmcr), [z] "r" (0)
>  	: "cc");
>  }
> +
> +/* event counter tests only implemented for aarch64 */
> +static void test_event_introspection(void) {}
> +
>  #elif defined(__aarch64__)
>  #define ID_AA64DFR0_PERFMON_SHIFT 8
>  #define ID_AA64DFR0_PERFMON_MASK  0xf
> @@ -140,6 +144,69 @@ static inline void precise_instrs_loop(int loop, uint32_t pmcr)
>  	: [pmcr] "r" (pmcr)
>  	: "cc");
>  }
> +
> +#define PMCEID1_EL0 sys_reg(11, 3, 9, 12, 7)
> +
> +static bool is_event_supported(uint32_t n, bool warn)
> +{
> +	uint64_t pmceid0 = read_sysreg(pmceid0_el0);
> +	uint64_t pmceid1 = read_sysreg_s(PMCEID1_EL0);
> +	bool supported;
> +	uint32_t reg;
> +
> +	if (n >= 0x0  && n <= 0x1F) {
> +		reg = pmceid0 & 0xFFFFFFFF;
> +	} else if  (n >= 0x4000 && n <= 0x401F) {
> +		reg = pmceid0 >> 32;
> +	} else if (n >= 0x20  && n <= 0x3F) {
> +		reg = pmceid1 & 0xFFFFFFFF;
> +	} else if (n >= 0x4020 && n <= 0x403F) {
> +		reg = pmceid1 >> 32;


Lot's of stray spaces in there. Also the 0x4000 should probably get a
define, and maybe another for the size 0x20.

> +	} else {
> +		abort();
> +	}
> +	supported =  reg & (1 << n);
> +	if (!supported && warn)
> +		report_info("event %d is not supported", n);
> +	return supported;
> +}
> +
> +static void test_event_introspection(void)
> +{
> +	bool required_events;
> +
> +	if (!pmu.nb_implemented_counters) {
> +		report_skip("No event counter, skip ...");
> +		return;
> +	}
> +	if (pmu.nb_implemented_counters < 2)
> +		report_info("%d event counters are implemented. "
> +                            "ARM recommends to implement at least 2",
> +                            pmu.nb_implemented_counters);

nit: I'd use {} on these multi-line if's (even if they're just one line)

> +
> +	/* PMUv3 requires an implementation includes some common events */
> +	required_events = is_event_supported(0x0, true) /* SW_INCR */ &&
> +			  is_event_supported(0x11, true) /* CPU_CYCLES */ &&
> +			  (is_event_supported(0x8, true) /* INST_RETIRED */ ||
> +			   is_event_supported(0x1B, true) /* INST_PREC */);
> +	if (!is_event_supported(0x8, false))
> +		report_info("ARM strongly recomments INST_RETIRED (0x8) event "
                                          ^ recommends
> +			    "to be implemented");

Do we need to report Arm's recommendation?

> +
> +	if (pmu.version == 0x4) {
> +		/* ARMv8.1 PMU: STALL_FRONTEND and STALL_BACKEND are required */
> +		required_events = required_events ||
> +				  is_event_supported(0x23, true) ||
> +				  is_event_supported(0x24, true);
> +	}
> +
> +	/* L1D_CACHE_REFILL(0x3) and L1D_CACHE(0x4) are only required if
> +	   L1 data / unified cache. BR_MIS_PRED(0x10), BR_PRED(0x12) are only
> +	   required if program-flow prediction is implemented. */
> +
> +	report("Check required events are implemented", required_events);
> +}
> +
>  #endif
>  
>  /*
> @@ -324,6 +391,9 @@ int main(int argc, char *argv[])
>  		report("Monotonically increasing cycle count", check_cycles_increase());
>  		report("Cycle/instruction ratio", check_cpi(cpi));
>  		pmccntr64_test();
> +	} else if (strcmp(argv[1], "event-introspection") == 0) {
> +		report_prefix_push(argv[1]);
> +		test_event_introspection();
>  	} else {
>  		report_abort("Unknown subtest '%s'", argv[1]);
>  	}
> diff --git a/arm/unittests.cfg b/arm/unittests.cfg
> index 79f0d7a..4433ef3 100644
> --- a/arm/unittests.cfg
> +++ b/arm/unittests.cfg
> @@ -66,6 +66,12 @@ file = pmu.flat
>  groups = pmu
>  extra_params = -append 'cycle-counter 0'
>  
> +[pmu-event-introspection]
> +file = pmu.flat
> +groups = pmu
> +arch = arm64
> +extra_params = -append 'event-introspection'
> +
>  # Test PMU support (TCG) with -icount IPC=1
>  #[pmu-tcg-icount-1]
>  #file = pmu.flat
> -- 
> 2.20.1
>

Thanks,
drew 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
