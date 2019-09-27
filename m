Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED27C0502
	for <lists+kvmarm@lfdr.de>; Fri, 27 Sep 2019 14:18:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 96BD14A762;
	Fri, 27 Sep 2019 08:18:53 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.202
X-Spam-Level: 
X-Spam-Status: No, score=-4.202 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5, SPF_HELO_PASS=-0.001]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RJuoo2B2iuIo; Fri, 27 Sep 2019 08:18:53 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 720C74A757;
	Fri, 27 Sep 2019 08:18:52 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id F1B224A751
 for <kvmarm@lists.cs.columbia.edu>; Fri, 27 Sep 2019 08:18:50 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a0Y9GcDBuoNB for <kvmarm@lists.cs.columbia.edu>;
 Fri, 27 Sep 2019 08:18:49 -0400 (EDT)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id BCF184A73F
 for <kvmarm@lists.cs.columbia.edu>; Fri, 27 Sep 2019 08:18:49 -0400 (EDT)
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 077CF64391;
 Fri, 27 Sep 2019 12:18:49 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ED499600C6;
 Fri, 27 Sep 2019 12:18:47 +0000 (UTC)
Date: Fri, 27 Sep 2019 14:18:45 +0200
From: Andrew Jones <drjones@redhat.com>
To: Andre Przywara <andre.przywara@arm.com>
Subject: Re: [kvm-unit-tests PATCH 1/6] arm: gic: check_acked: add test
 description
Message-ID: <20190927121845.wjes372uf2hhw2wz@kamzik.brq.redhat.com>
References: <20190927104227.253466-1-andre.przywara@arm.com>
 <20190927104227.253466-2-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190927104227.253466-2-andre.przywara@arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Fri, 27 Sep 2019 12:18:49 +0000 (UTC)
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
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

On Fri, Sep 27, 2019 at 11:42:22AM +0100, Andre Przywara wrote:
> At the moment the check_acked() IRQ helper function just prints a
> generic "Completed" or "Timed out" message, without given a more
> detailed test description.
> 
> To be able to tell the different IRQ tests apart, and also to allow
> re-using it more easily, add a "description" parameter string,
> which is prefixing the output line. This gives more information on what
> exactly was tested.
> 
> This also splits the variable output part of the line (duration of IRQ
> delivery) into a separate INFO: line, to not confuse testing frameworks.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arm/gic.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/arm/gic.c b/arm/gic.c
> index ed5642e..6fd5e5e 100644
> --- a/arm/gic.c
> +++ b/arm/gic.c
> @@ -60,7 +60,7 @@ static void stats_reset(void)
>  	smp_wmb();
>  }
>  
> -static void check_acked(cpumask_t *mask)
> +static void check_acked(const char *testname, cpumask_t *mask)
>  {
>  	int missing = 0, extra = 0, unexpected = 0;
>  	int nr_pass, cpu, i;
> @@ -88,7 +88,9 @@ static void check_acked(cpumask_t *mask)
>  			}
>  		}
>  		if (nr_pass == nr_cpus) {
> -			report("Completed in %d ms", !bad, ++i * 100);
> +			report("%s", !bad, testname);
> +			if (i)
> +				report_info("took more than %d ms", i * 100);

Any reason for dropping the '++'? Without it we don't account for the last
100 ms.

>  			return;
>  		}
>  	}
> @@ -105,8 +107,9 @@ static void check_acked(cpumask_t *mask)
>  		}
>  	}
>  
> -	report("Timed-out (5s). ACKS: missing=%d extra=%d unexpected=%d",
> -	       false, missing, extra, unexpected);
> +	report("%s", false, testname);
> +	report_info("Timed-out (5s). ACKS: missing=%d extra=%d unexpected=%d",
> +		    missing, extra, unexpected);
>  }
>  
>  static void check_spurious(void)
> @@ -185,7 +188,7 @@ static void ipi_test_self(void)
>  	cpumask_clear(&mask);
>  	cpumask_set_cpu(smp_processor_id(), &mask);
>  	gic->ipi.send_self();
> -	check_acked(&mask);
> +	check_acked("IPI to self", &mask);

Could even do "IPI: self"
              "IPI: directed"
              "IPI: broadcast"

to improve parsibility

>  	report_prefix_pop();
>  }
>  
> @@ -200,7 +203,7 @@ static void ipi_test_smp(void)
>  	for (i = smp_processor_id() & 1; i < nr_cpus; i += 2)
>  		cpumask_clear_cpu(i, &mask);
>  	gic_ipi_send_mask(IPI_IRQ, &mask);
> -	check_acked(&mask);
> +	check_acked("directed IPI", &mask);
>  	report_prefix_pop();
>  
>  	report_prefix_push("broadcast");
> @@ -208,7 +211,7 @@ static void ipi_test_smp(void)
>  	cpumask_copy(&mask, &cpu_present_mask);
>  	cpumask_clear_cpu(smp_processor_id(), &mask);
>  	gic->ipi.send_broadcast();
> -	check_acked(&mask);
> +	check_acked("IPI broadcast", &mask);
>  	report_prefix_pop();
>  }
>  
> -- 
> 2.17.1
>

Thanks,
drew 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
