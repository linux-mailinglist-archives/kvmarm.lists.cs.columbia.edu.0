Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id AA53AFAEBD
	for <lists+kvmarm@lfdr.de>; Wed, 13 Nov 2019 11:44:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2E0234B148;
	Wed, 13 Nov 2019 05:44:12 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GHMbn7mcYs5s; Wed, 13 Nov 2019 05:44:12 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A0C2F4B141;
	Wed, 13 Nov 2019 05:44:10 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A2D724B11A
 for <kvmarm@lists.cs.columbia.edu>; Wed, 13 Nov 2019 05:44:08 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jv+3StsGTd8m for <kvmarm@lists.cs.columbia.edu>;
 Wed, 13 Nov 2019 05:44:03 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4867D4B0DD
 for <kvmarm@lists.cs.columbia.edu>; Wed, 13 Nov 2019 05:44:03 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B97957A7;
 Wed, 13 Nov 2019 02:44:02 -0800 (PST)
Received: from [10.1.196.63] (e123195-lin.cambridge.arm.com [10.1.196.63])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C8B193F534;
 Wed, 13 Nov 2019 02:44:01 -0800 (PST)
Subject: Re: [kvm-unit-tests PATCH 16/17] arm: gic: Prepare interrupt
 statistics for both groups
To: Andre Przywara <andre.przywara@arm.com>, Andrew Jones
 <drjones@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20191108144240.204202-1-andre.przywara@arm.com>
 <20191108144240.204202-17-andre.przywara@arm.com>
From: Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <90acc4bd-22e6-38f5-c52f-c789e0996690@arm.com>
Date: Wed, 13 Nov 2019 10:44:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191108144240.204202-17-andre.przywara@arm.com>
Content-Language: en-US
Cc: Marc Zyngier <maz@kernel.org>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org
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

On 11/8/19 2:42 PM, Andre Przywara wrote:
> The arrays storing information about received interrupts need to
> differentiate between IRQs and FIQs, to detect interrupts firing in the
> wrong group.
>
> Extend the acked, spurious, bad_sender and bad_irq arrays to get another
> dimension, so that we can check the kind of interrupt easily.
> The fiq_handler marks its result using index 0, the irq_handler uses
> index 1.
> Also we add a group parameter to check_acked() and friends, to let them
> use the right group.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arm/gic.c | 78 ++++++++++++++++++++++++++++++-------------------------
>  1 file changed, 42 insertions(+), 36 deletions(-)
>
> diff --git a/arm/gic.c b/arm/gic.c
> index 6756850..43a272b 100644
> --- a/arm/gic.c
> +++ b/arm/gic.c
> @@ -33,8 +33,8 @@ struct gic {
>  };
>  
>  static struct gic *gic;
> -static int acked[NR_CPUS], spurious[NR_CPUS];
> -static int bad_sender[NR_CPUS], bad_irq[NR_CPUS];
> +static int acked[2][NR_CPUS], spurious[2][NR_CPUS];
> +static int bad_sender[2][NR_CPUS], bad_irq[2][NR_CPUS];
>  static cpumask_t ready;
>  
>  static void nr_cpu_check(int nr)
> @@ -55,14 +55,17 @@ static void stats_reset(void)
>  	int i;
>  
>  	for (i = 0; i < nr_cpus; ++i) {
> -		acked[i] = 0;
> -		bad_sender[i] = -1;
> -		bad_irq[i] = -1;
> +		acked[0][i] = 0;
> +		acked[1][i] = 0;
> +		bad_sender[0][i] = -1;
> +		bad_sender[1][i] = -1;
> +		bad_irq[0][i] = -1;
> +		bad_irq[1][i] = -1;

How about we use defines for the groups instead of 0/1? bad_irq[GIC_GROUP0][i] (or
whatever name you choose) looks more readable to me than bad_irq[0][i].

Thanks,
Alex
>  	}
>  	smp_wmb();
>  }
>  
> -static int check_acked(const char *testname, cpumask_t *mask)
> +static int check_acked(const char *testname, cpumask_t *mask, int group)
>  {
>  	int missing = 0, extra = 0, unexpected = 0;
>  	int nr_pass, cpu, i;
> @@ -76,17 +79,17 @@ static int check_acked(const char *testname, cpumask_t *mask)
>  		for_each_present_cpu(cpu) {
>  			smp_rmb();
>  			nr_pass += cpumask_test_cpu(cpu, mask) ?
> -				acked[cpu] == 1 : acked[cpu] == 0;
> +				acked[group][cpu] == 1 : acked[group][cpu] == 0;
>  
> -			if (bad_sender[cpu] != -1) {
> +			if (bad_sender[group][cpu] != -1) {
>  				printf("cpu%d received IPI from wrong sender %d\n",
> -					cpu, bad_sender[cpu]);
> +					cpu, bad_sender[group][cpu]);
>  				bad = true;
>  			}
>  
> -			if (bad_irq[cpu] != -1) {
> +			if (bad_irq[group][cpu] != -1) {
>  				printf("cpu%d received wrong irq %d\n",
> -					cpu, bad_irq[cpu]);
> +					cpu, bad_irq[group][cpu]);
>  				bad = true;
>  			}
>  		}
> @@ -109,12 +112,12 @@ static int check_acked(const char *testname, cpumask_t *mask)
>  
>  	for_each_present_cpu(cpu) {
>  		if (cpumask_test_cpu(cpu, mask)) {
> -			if (!acked[cpu])
> +			if (!acked[group][cpu])
>  				++missing;
> -			else if (acked[cpu] > 1)
> +			else if (acked[group][cpu] > 1)
>  				++extra;
>  		} else {
> -			if (acked[cpu])
> +			if (acked[group][cpu])
>  				++unexpected;
>  		}
>  	}
> @@ -132,9 +135,12 @@ static void check_spurious(void)
>  
>  	smp_rmb();
>  	for_each_present_cpu(cpu) {
> -		if (spurious[cpu])
> -			report_info("WARN: cpu%d got %d spurious interrupts",
> -				cpu, spurious[cpu]);
> +		if (spurious[0][cpu])
> +			report_info("WARN: cpu%d got %d spurious FIQs",
> +				    cpu, spurious[0][cpu]);
> +		if (spurious[1][cpu])
> +			report_info("WARN: cpu%d got %d spurious IRQs",
> +				    cpu, spurious[1][cpu]);
>  	}
>  }
>  
> @@ -144,14 +150,14 @@ static void check_ipi_sender(u32 irqstat)
>  		int src = (irqstat >> 10) & 7;
>  
>  		if (src != IPI_SENDER)
> -			bad_sender[smp_processor_id()] = src;
> +			bad_sender[1][smp_processor_id()] = src;
>  	}
>  }
>  
> -static void check_irqnr(u32 irqnr, int expected)
> +static void check_irqnr(u32 irqnr, int expected, int group)
>  {
>  	if (irqnr != expected)
> -		bad_irq[smp_processor_id()] = irqnr;
> +		bad_irq[group][smp_processor_id()] = irqnr;
>  }
>  
>  static void irq_handler(struct pt_regs *regs __unused)
> @@ -160,7 +166,7 @@ static void irq_handler(struct pt_regs *regs __unused)
>  	u32 irqnr = gic_iar_irqnr(irqstat);
>  
>  	if (irqnr == GICC_INT_SPURIOUS) {
> -		++spurious[smp_processor_id()];
> +		++spurious[1][smp_processor_id()];
>  		smp_wmb();
>  		return;
>  	}
> @@ -168,12 +174,12 @@ static void irq_handler(struct pt_regs *regs __unused)
>  	gic_write_eoir(irqstat, 1);
>  
>  	smp_rmb(); /* pairs with wmb in stats_reset */
> -	++acked[smp_processor_id()];
> +	++acked[1][smp_processor_id()];
>  	if (irqnr < GIC_NR_PRIVATE_IRQS) {
>  		check_ipi_sender(irqstat);
> -		check_irqnr(irqnr, IPI_IRQ);
> +		check_irqnr(irqnr, IPI_IRQ, 1);
>  	} else {
> -		check_irqnr(irqnr, SPI_IRQ);
> +		check_irqnr(irqnr, SPI_IRQ, 1);
>  	}
>  	smp_wmb(); /* pairs with rmb in check_acked */
>  }
> @@ -184,7 +190,7 @@ static inline void fiq_handler(struct pt_regs *regs __unused)
>  	u32 irqnr = gic_iar_irqnr(irqstat);
>  
>  	if (irqnr == GICC_INT_SPURIOUS) {
> -		++spurious[smp_processor_id()];
> +		++spurious[0][smp_processor_id()];
>  		smp_wmb();
>  		return;
>  	}
> @@ -192,12 +198,12 @@ static inline void fiq_handler(struct pt_regs *regs __unused)
>  	gic_write_eoir(irqstat, 0);
>  
>  	smp_rmb(); /* pairs with wmb in stats_reset */
> -	++acked[smp_processor_id()];
> +	++acked[0][smp_processor_id()];
>  	if (irqnr < GIC_NR_PRIVATE_IRQS) {
>  		check_ipi_sender(irqstat);
> -		check_irqnr(irqnr, IPI_IRQ);
> +		check_irqnr(irqnr, IPI_IRQ, 0);
>  	} else {
> -		check_irqnr(irqnr, SPI_IRQ);
> +		check_irqnr(irqnr, SPI_IRQ, 0);
>  	}
>  	smp_wmb(); /* pairs with rmb in check_acked */
>  }
> @@ -232,7 +238,7 @@ static void ipi_test_self(void)
>  	cpumask_clear(&mask);
>  	cpumask_set_cpu(smp_processor_id(), &mask);
>  	gic->ipi.send_self();
> -	check_acked("IPI: self", &mask);
> +	check_acked("IPI: self", &mask, 1);
>  	report_prefix_pop();
>  }
>  
> @@ -247,7 +253,7 @@ static void ipi_test_smp(void)
>  	for (i = smp_processor_id() & 1; i < nr_cpus; i += 2)
>  		cpumask_clear_cpu(i, &mask);
>  	gic_ipi_send_mask(IPI_IRQ, &mask);
> -	check_acked("IPI: directed", &mask);
> +	check_acked("IPI: directed", &mask, 1);
>  	report_prefix_pop();
>  
>  	report_prefix_push("broadcast");
> @@ -255,7 +261,7 @@ static void ipi_test_smp(void)
>  	cpumask_copy(&mask, &cpu_present_mask);
>  	cpumask_clear_cpu(smp_processor_id(), &mask);
>  	gic->ipi.send_broadcast();
> -	check_acked("IPI: broadcast", &mask);
> +	check_acked("IPI: broadcast", &mask, 1);
>  	report_prefix_pop();
>  }
>  
> @@ -327,11 +333,11 @@ static void ipi_clear_active_handler(struct pt_regs *regs __unused)
>  		writel(val, base + GICD_ICACTIVER);
>  
>  		smp_rmb(); /* pairs with wmb in stats_reset */
> -		++acked[smp_processor_id()];
> -		check_irqnr(irqnr, IPI_IRQ);
> +		++acked[1][smp_processor_id()];
> +		check_irqnr(irqnr, IPI_IRQ, 1);
>  		smp_wmb(); /* pairs with rmb in check_acked */
>  	} else {
> -		++spurious[smp_processor_id()];
> +		++spurious[1][smp_processor_id()];
>  		smp_wmb();
>  	}
>  }
> @@ -617,7 +623,7 @@ static bool trigger_and_check_spi(const char *test_name,
>  		break;
>  	}
>  
> -	ret = (check_acked(test_name, &cpumask) >= 0);
> +	ret = (check_acked(test_name, &cpumask, 1) >= 0);
>  
>  	/* Clean up pending bit in case this IRQ wasn't taken. */
>  	if (!(irq_stat & IRQ_STAT_NO_CLEAR))
> @@ -643,7 +649,7 @@ static void spi_test_single(void)
>  	cpumask_clear(&cpumask);
>  	cpumask_set_cpu(cpu, &cpumask);
>  	gic_enable_irq(SPI_IRQ);
> -	check_acked("now enabled SPI fires", &cpumask);
> +	check_acked("now enabled SPI fires", &cpumask, 1);
>  }
>  
>  static void spi_test_smp(void)
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
