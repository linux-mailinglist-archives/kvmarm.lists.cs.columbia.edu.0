Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 26E87310A2C
	for <lists+kvmarm@lfdr.de>; Fri,  5 Feb 2021 12:24:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CB3184B3C8;
	Fri,  5 Feb 2021 06:24:07 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.209
X-Spam-Level: 
X-Spam-Status: No, score=0.209 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_LOW=-0.7,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id psbCtmqn7FpJ; Fri,  5 Feb 2021 06:24:07 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 98A9E4B3D3;
	Fri,  5 Feb 2021 06:24:06 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 780E34B391
 for <kvmarm@lists.cs.columbia.edu>; Fri,  5 Feb 2021 06:24:05 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C8KcO8xgBj5R for <kvmarm@lists.cs.columbia.edu>;
 Fri,  5 Feb 2021 06:24:04 -0500 (EST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 336E84B3C9
 for <kvmarm@lists.cs.columbia.edu>; Fri,  5 Feb 2021 06:24:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612524244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i9Rg/2n9s427TRpqjhYVmMfSakMhnUXk5dMT13Fz8l8=;
 b=KxLOninYeQo3ulgrcxctrhttHInOv4SQID77oHHEyR7my6ydJ5+fn/Q3WlFMtvNR02nKsK
 lEqI08yGzwuJvsWJsktPxh80Px9/T4T+/kDuTA4GC8d3zjecNpdQUr3kMuoiztyY9ooom9
 /niTM6SKlRjg+VSA6KTOEnWpMXag3Zc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-546-sKI6Hc8tN3yY27T8opSG6Q-1; Fri, 05 Feb 2021 06:24:02 -0500
X-MC-Unique: sKI6Hc8tN3yY27T8opSG6Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19EBA107ACE4;
 Fri,  5 Feb 2021 11:24:01 +0000 (UTC)
Received: from [10.36.113.43] (ovpn-113-43.ams2.redhat.com [10.36.113.43])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ABF9919C78;
 Fri,  5 Feb 2021 11:23:59 +0000 (UTC)
Subject: Re: [kvm-unit-tests PATCH v3 08/11] arm/arm64: gic: Split
 check_acked() into two functions
To: Alexandru Elisei <alexandru.elisei@arm.com>, drjones@redhat.com,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu
References: <20210129163647.91564-1-alexandru.elisei@arm.com>
 <20210129163647.91564-9-alexandru.elisei@arm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <3bf66487-7d5b-fa3c-54a4-dfe37f983061@redhat.com>
Date: Fri, 5 Feb 2021 12:23:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20210129163647.91564-9-alexandru.elisei@arm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: andre.przywara@arm.com
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

Hi Alexandru,

On 1/29/21 5:36 PM, Alexandru Elisei wrote:
> check_acked() has several peculiarities: is the only function among the
> check_* functions which calls report() directly, it does two things
> (waits for interrupts and checks for misfired interrupts) and it also
> mixes printf, report_info and report calls.
> 
> check_acked() also reports a pass and returns as soon all the target CPUs
> have received interrupts, However, a CPU not having received an interrupt
> *now* does not guarantee not receiving an erroneous interrupt if we wait
> long enough.
> 
> Rework the function by splitting it into two separate functions, each with
> a single responsibility: wait_for_interrupts(), which waits for the
> expected interrupts to fire, and check_acked() which checks that interrupts
> have been received as expected.
> 
> wait_for_interrupts() also waits an extra 100 milliseconds after the
> expected interrupts have been received in an effort to make sure we don't
> miss misfiring interrupts.
> 
> Splitting check_acked() into two functions will also allow us to
> customize the behavior of each function in the future more easily
> without using an unnecessarily long list of arguments for check_acked().
> 
> CC: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

> ---
>  arm/gic.c | 74 ++++++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 48 insertions(+), 26 deletions(-)
> 
> diff --git a/arm/gic.c b/arm/gic.c
> index af4d4645c0ae..2c96cf49ce8c 100644
> --- a/arm/gic.c
> +++ b/arm/gic.c
> @@ -61,41 +61,43 @@ static void stats_reset(void)
>  	}
>  }
>  
> -static void check_acked(const char *testname, cpumask_t *mask)
> +static void wait_for_interrupts(cpumask_t *mask)
>  {
> -	int missing = 0, extra = 0, unexpected = 0;
>  	int nr_pass, cpu, i;
> -	bool bad = false;
>  
>  	/* Wait up to 5s for all interrupts to be delivered */
> -	for (i = 0; i < 50; ++i) {
> +	for (i = 0; i < 50; i++) {
>  		mdelay(100);
>  		nr_pass = 0;
>  		for_each_present_cpu(cpu) {
> +			/*
> +			 * A CPU having received more than one interrupts will
> +			 * show up in check_acked(), and no matter how long we
> +			 * wait it cannot un-receive it. Consider at least one
> +			 * interrupt as a pass.
> +			 */
>  			nr_pass += cpumask_test_cpu(cpu, mask) ?
> -				acked[cpu] == 1 : acked[cpu] == 0;
> -			smp_rmb(); /* pairs with smp_wmb in ipi_handler */
> -
> -			if (bad_sender[cpu] != -1) {
> -				printf("cpu%d received IPI from wrong sender %d\n",
> -					cpu, bad_sender[cpu]);
> -				bad = true;
> -			}
> -
> -			if (bad_irq[cpu] != -1) {
> -				printf("cpu%d received wrong irq %d\n",
> -					cpu, bad_irq[cpu]);
> -				bad = true;
> -			}
> +				acked[cpu] >= 1 : acked[cpu] == 0;
>  		}
> +
>  		if (nr_pass == nr_cpus) {
> -			report(!bad, "%s", testname);
>  			if (i)
> -				report_info("took more than %d ms", i * 100);
> +				report_info("interrupts took more than %d ms", i * 100);
> +			/* Wait for unexpected interrupts to fire */
> +			mdelay(100);
>  			return;
>  		}
>  	}
>  
> +	report_info("interrupts timed-out (5s)");
> +}
> +
> +static bool check_acked(cpumask_t *mask)
> +{
> +	int missing = 0, extra = 0, unexpected = 0;
> +	bool pass = true;
> +	int cpu;
> +
>  	for_each_present_cpu(cpu) {
>  		if (cpumask_test_cpu(cpu, mask)) {
>  			if (!acked[cpu])
> @@ -106,11 +108,28 @@ static void check_acked(const char *testname, cpumask_t *mask)
>  			if (acked[cpu])
>  				++unexpected;
>  		}
> +		smp_rmb(); /* pairs with smp_wmb in ipi_handler */
> +
> +		if (bad_sender[cpu] != -1) {
> +			report_info("cpu%d received IPI from wrong sender %d",
> +					cpu, bad_sender[cpu]);
> +			pass = false;
> +		}
> +
> +		if (bad_irq[cpu] != -1) {
> +			report_info("cpu%d received wrong irq %d",
> +					cpu, bad_irq[cpu]);
> +			pass = false;
> +		}
> +	}
> +
> +	if (missing || extra || unexpected) {
> +		report_info("ACKS: missing=%d extra=%d unexpected=%d",
> +				missing, extra, unexpected);
> +		pass = false;
>  	}
>  
> -	report(false, "%s", testname);
> -	report_info("Timed-out (5s). ACKS: missing=%d extra=%d unexpected=%d",
> -		    missing, extra, unexpected);
> +	return pass;
>  }
>  
>  static void check_spurious(void)
> @@ -299,7 +318,8 @@ static void ipi_test_self(void)
>  	cpumask_clear(&mask);
>  	cpumask_set_cpu(smp_processor_id(), &mask);
>  	gic->ipi.send_self();
> -	check_acked("IPI: self", &mask);
> +	wait_for_interrupts(&mask);
> +	report(check_acked(&mask), "Interrupts received");
>  	report_prefix_pop();
>  }
>  
> @@ -314,7 +334,8 @@ static void ipi_test_smp(void)
>  	for (i = smp_processor_id() & 1; i < nr_cpus; i += 2)
>  		cpumask_clear_cpu(i, &mask);
>  	gic_ipi_send_mask(IPI_IRQ, &mask);
> -	check_acked("IPI: directed", &mask);
> +	wait_for_interrupts(&mask);
> +	report(check_acked(&mask), "Interrupts received");
>  	report_prefix_pop();
>  
>  	report_prefix_push("broadcast");
> @@ -322,7 +343,8 @@ static void ipi_test_smp(void)
>  	cpumask_copy(&mask, &cpu_present_mask);
>  	cpumask_clear_cpu(smp_processor_id(), &mask);
>  	gic->ipi.send_broadcast();
> -	check_acked("IPI: broadcast", &mask);
> +	wait_for_interrupts(&mask);
> +	report(check_acked(&mask), "Interrupts received");
>  	report_prefix_pop();
>  }
>  
> 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
