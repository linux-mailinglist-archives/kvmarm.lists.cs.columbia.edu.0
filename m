Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 053A917A1D8
	for <lists+kvmarm@lfdr.de>; Thu,  5 Mar 2020 10:05:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8ED134AEC8;
	Thu,  5 Mar 2020 04:05:18 -0500 (EST)
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
	with ESMTP id Gfj5jafEkn6E; Thu,  5 Mar 2020 04:05:18 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 52A5A4AEBF;
	Thu,  5 Mar 2020 04:05:17 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B54A64AEAC
 for <kvmarm@lists.cs.columbia.edu>; Thu,  5 Mar 2020 04:05:15 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s8EKs1VwQt0c for <kvmarm@lists.cs.columbia.edu>;
 Thu,  5 Mar 2020 04:05:14 -0500 (EST)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A8C6D4AE9D
 for <kvmarm@lists.cs.columbia.edu>; Thu,  5 Mar 2020 04:05:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583399114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/WRv5Va+ufzbIgCtr33R2bN2K8epUakX5vLunGi7LOQ=;
 b=RrJf0Ll2Dx3N+HDDBRv7CZhkEBFzF5D/8S7RlYneRKfSEyy+Q7H2ff/mklnfAJesLahpkS
 +YEDm2gvaD4TIVDBek/N+SCNeyUI3wymJT8sMNYklDlOL8ivlxM8BGSzIwFbnRbDF5f7fp
 6HeTSsYpwPn+MR9+glT1yaZETqp3ICM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-jVH5lGAvPvCiYGHWiO7vAg-1; Thu, 05 Mar 2020 04:05:10 -0500
X-MC-Unique: jVH5lGAvPvCiYGHWiO7vAg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA268DBAF;
 Thu,  5 Mar 2020 09:05:07 +0000 (UTC)
Received: from kamzik.brq.redhat.com (ovpn-204-110.brq.redhat.com
 [10.40.204.110])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A9719272A9;
 Thu,  5 Mar 2020 09:05:01 +0000 (UTC)
Date: Thu, 5 Mar 2020 10:04:59 +0100
From: Andrew Jones <drjones@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v2 4/9] arm: pmu: Check Required Event
 Support
Message-ID: <20200305090459.5hrrsf54zjxxoneq@kamzik.brq.redhat.com>
References: <20200130112510.15154-1-eric.auger@redhat.com>
 <20200130112510.15154-5-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200130112510.15154-5-eric.auger@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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

On Thu, Jan 30, 2020 at 12:25:05PM +0100, Eric Auger wrote:
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
> 
> ---
> 
> v1 -> v2:
> - fix is_event_supported()
> - fix boolean condition for PMU v4
> - fix PMCEID0 definition
> 
> RFC ->v1:
> - add a comment to explain the PMCEID0/1 splits
> ---
>  arm/pmu.c         | 62 +++++++++++++++++++++++++++++++++++++++++++++++
>  arm/unittests.cfg |  6 +++++
>  2 files changed, 68 insertions(+)
> 
> diff --git a/arm/pmu.c b/arm/pmu.c
> index d24857e..4a26a76 100644
> --- a/arm/pmu.c
> +++ b/arm/pmu.c
> @@ -101,6 +101,10 @@ static inline void precise_instrs_loop(int loop, uint32_t pmcr)
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
> @@ -139,6 +143,61 @@ static inline void precise_instrs_loop(int loop, uint32_t pmcr)
>  	: [pmcr] "r" (pmcr)
>  	: "cc");
>  }
> +
> +#define PMCEID1_EL0 sys_reg(3, 3, 9, 12, 7)
> +
> +static bool is_event_supported(uint32_t n, bool warn)
> +{
> +	uint64_t pmceid0 = read_sysreg(pmceid0_el0);
> +	uint64_t pmceid1 = read_sysreg_s(PMCEID1_EL0);
> +	bool supported;
> +	uint64_t reg;
> +
> +	/*
> +	 * The low 32-bits of PMCEID0/1 respectly describe
> +	 * event support for events 0-31/32-63. Their High
> +	 * 32-bits describe support for extended events
> +	 * starting at 0x4000, using the same split.
> +	 */
> +	if (n >= 0x0  && n <= 0x3F)
> +		reg = (pmceid0 & 0xFFFFFFFF) | ((pmceid1 & 0xFFFFFFFF) << 32);

Maybe it's time to add

#define upper_32_bits(n) ((u32)(((n) >> 16) >> 16))
#define lower_32_bits(n) ((u32)(n))

to the kvm-unit-tests framework.

> +	else if  (n >= 0x4000 && n <= 0x403F)
> +		reg = (pmceid0 >> 32) | ((pmceid1 >> 32) << 32);
> +	else
> +		abort();

assert(0) ensure we get a dump_stack() (although I haven't fixed
dump_stack for arm64 yet...). Could also do the assert first

assert((n >= 0x0  && n <= 0x3F) || (n >= 0x4000 && n <= 0x403F))
if (n <= 0x3F)
 ...
else
 ...

What about defines for these hex numbers?


> +
> +	supported =  reg & (1UL << (n & 0x3F));
                   ^ extra space

> +
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
> +
> +	/* PMUv3 requires an implementation includes some common events */
> +	required_events = is_event_supported(0x0, true) /* SW_INCR */ &&
> +			  is_event_supported(0x11, true) /* CPU_CYCLES */ &&
> +			  (is_event_supported(0x8, true) /* INST_RETIRED */ ||
> +			   is_event_supported(0x1B, true) /* INST_PREC */);

If defines are created then the comments can go away

	required_events = is_event_supported(SW_INCR, true) &&
			  is_event_supported(CPU_CYCLES, true) &&
			  (is_event_supported(INST_RETIRED, true) ||
			   is_event_supported(INST_PREC, true));


> +
> +	if (pmu.version == 0x4) {
> +		/* ARMv8.1 PMU: STALL_FRONTEND and STALL_BACKEND are required */
> +		required_events = required_events &&
> +				  is_event_supported(0x23, true) &&
> +				  is_event_supported(0x24, true);
> +	}
> +
> +	report(required_events, "Check required events are implemented");
> +}
> +
>  #endif
>  
>  /*
> @@ -326,6 +385,9 @@ int main(int argc, char *argv[])
>  		       "Monotonically increasing cycle count");
>  		report(check_cpi(cpi), "Cycle/instruction ratio");
>  		pmccntr64_test();
> +	} else if (strcmp(argv[1], "event-introspection") == 0) {
> +		report_prefix_push(argv[1]);
> +		test_event_introspection();

prefix pop

>  	} else {
>  		report_abort("Unknown sub-test '%s'", argv[1]);
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
>

Thanks,
drew 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
