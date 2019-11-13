Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 69E9CFAFA6
	for <lists+kvmarm@lfdr.de>; Wed, 13 Nov 2019 12:27:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CD6604AFDE;
	Wed, 13 Nov 2019 06:27:01 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lHDFAbFQiZ-n; Wed, 13 Nov 2019 06:27:01 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5325B4B150;
	Wed, 13 Nov 2019 06:27:00 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B3A034B147
 for <kvmarm@lists.cs.columbia.edu>; Wed, 13 Nov 2019 06:26:58 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M7fHT-kZEf7J for <kvmarm@lists.cs.columbia.edu>;
 Wed, 13 Nov 2019 06:26:57 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 57D994B0BE
 for <kvmarm@lists.cs.columbia.edu>; Wed, 13 Nov 2019 06:26:57 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3B447A7;
 Wed, 13 Nov 2019 03:26:56 -0800 (PST)
Received: from [10.1.196.63] (e123195-lin.cambridge.arm.com [10.1.196.63])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C2B663F534;
 Wed, 13 Nov 2019 03:26:55 -0800 (PST)
Subject: Re: [kvm-unit-tests PATCH 17/17] arm: gic: Test Group0 SPIs
To: Andre Przywara <andre.przywara@arm.com>, Andrew Jones
 <drjones@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20191108144240.204202-1-andre.przywara@arm.com>
 <20191108144240.204202-18-andre.przywara@arm.com>
From: Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <88a5d9f9-e5fe-8025-8857-dc78a5aa791a@arm.com>
Date: Wed, 13 Nov 2019 11:26:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191108144240.204202-18-andre.przywara@arm.com>
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
> With the newly gained building blocks we can now actually test Group 0
> interrupts on our emulated/virtualized GIC.
> The least common denominator for the groups usage on both GICv2 and
> GICv3 is to configure group 0 interrupts to trigger FIQs, and group 1
> interrupts to trigger IRQs.
> For testing this we first configure our test SPI to belong to group 0,
> then trigger it to see that it is actually delivered as an FIQ, and not as
> an IRQ.
> The we change the group to become 1, and trigger again, this time
> expecting the opposite behaviour.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arm/gic.c | 103 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 101 insertions(+), 2 deletions(-)
>
> diff --git a/arm/gic.c b/arm/gic.c
> index 43a272b..9942314 100644
> --- a/arm/gic.c
> +++ b/arm/gic.c
> @@ -276,6 +276,22 @@ static void irqs_enable(void)
>  	local_irq_enable();
>  }
>  
> +static void fiqs_enable(void)
> +{
> +#ifdef __arm__
> +	install_exception_handler(EXCPTN_FIQ, fiq_handler);
> +#else
> +	install_irq_handler(EL1H_FIQ, fiq_handler);
> +#endif
> +	if (gic_version() == 3) {
> +		gicv3_write_grpen0(1);
> +	} else {
> +		gicv2_enable_fiq(true);
> +		gicv2_enable_group1(true);

Why do we enable group 1 here for GICv2? The commit message says that group 1
interrupts will be delivered as IRQs.

> +	}
> +	local_fiq_enable();
> +}
> +
>  static void ipi_send(void)
>  {
>  	irqs_enable();
> @@ -598,6 +614,7 @@ static void spi_configure_irq(int irq, int cpu)
>  
>  #define IRQ_STAT_NONE		0
>  #define IRQ_STAT_IRQ		1
> +#define IRQ_STAT_FIQ		2
>  #define IRQ_STAT_TYPE_MASK	0x3
>  #define IRQ_STAT_NO_CLEAR	4
>  
> @@ -617,14 +634,21 @@ static bool trigger_and_check_spi(const char *test_name,
>  	cpumask_clear(&cpumask);
>  	switch (irq_stat & IRQ_STAT_TYPE_MASK) {
>  	case IRQ_STAT_NONE:
> +		ret &= (check_acked(NULL, &cpumask, 0) >= 0);
> +		ret &= (check_acked(test_name, &cpumask, 1) >= 0);
>  		break;
>  	case IRQ_STAT_IRQ:
> +		ret &= (check_acked(NULL, &cpumask, 0) >= 0);
> +		cpumask_set_cpu(cpu, &cpumask);
> +		ret &= (check_acked(test_name, &cpumask, 1) >= 0);
> +		break;
> +	case IRQ_STAT_FIQ:
> +		ret &= (check_acked(NULL, &cpumask, 1) >= 0);
>  		cpumask_set_cpu(cpu, &cpumask);
> +		ret &= (check_acked(test_name, &cpumask, 0) >= 0);
>  		break;
>  	}
>  
> -	ret = (check_acked(test_name, &cpumask, 1) >= 0);
> -
>  	/* Clean up pending bit in case this IRQ wasn't taken. */
>  	if (!(irq_stat & IRQ_STAT_NO_CLEAR))
>  		gic_set_irq_bit(SPI_IRQ, GICD_ICPENDR);
> @@ -657,6 +681,9 @@ static void spi_test_smp(void)
>  	int cpu;
>  	int cores = 1;
>  
> +	if (nr_cpus > 8)
> +		printf("triggering SPIs on all %d cores, takes %d seconds\n",
> +		       nr_cpus, (nr_cpus - 1) * 3 / 2);

Can you explain how you got the elapsed time for triggering SPIs?

>  	wait_on_ready();
>  	for_each_present_cpu(cpu) {
>  		if (cpu == smp_processor_id())
> @@ -671,6 +698,46 @@ static void spi_test_smp(void)
>  }
>  
>  #define GICD_CTLR_ENABLE_BOTH (GICD_CTLR_ENABLE_G0 | GICD_CTLR_ENABLE_G1)
> +#define EXPECT_FIQ	true
> +#define EXPECT_IRQ	false
> +
> +/*
> + * Check whether our SPI interrupt is correctly delivered as an FIQ or as
> + * an IRQ, as configured.
> + * This tries to enable the two groups independently, to check whether
> + * the relation group0->FIQ and group1->IRQ holds.
> + */
> +static void gic_check_irq_delivery(void *gicd_base, bool as_fiq)

The function also checks for FIQs, as alluded to by the as_fiq parameter; also,
most of the function does different things based on that parameter. I think it
would be cleaner to split it into two functions, gic_check_irq_delivery and
gic_check_fiq_delivery. That way you can have more clearer messages for
trigger_and_check_spi and you get rid of the two defines above. At the very least,
it should be renamed to something more appropriate for what it does, like
gic_check_int_delivery.

> +{
> +	u32 reg = readl(gicd_base + GICD_CTLR) & ~GICD_CTLR_ENABLE_BOTH;
> +	int cpu = smp_processor_id();
> +
> +	/* Check that both groups disabled block the IRQ. */
> +	writel(reg, gicd_base + GICD_CTLR);
> +	trigger_and_check_spi("no IRQs with both groups disabled",
> +			      IRQ_STAT_NONE, cpu);
> +
> +	/* Check that just the *other* group enabled blocks the IRQ. */
> +	if (as_fiq)
> +		writel(reg | GICD_CTLR_ENABLE_G1, gicd_base + GICD_CTLR);
> +	else
> +		writel(reg | GICD_CTLR_ENABLE_G0, gicd_base + GICD_CTLR);
> +	trigger_and_check_spi("no IRQs with just the other group enabled",
> +			      IRQ_STAT_NONE, cpu);
> +
> +	/* Check that just this group enabled fires the IRQ. */
> +	if (as_fiq)
> +		writel(reg | GICD_CTLR_ENABLE_G0, gicd_base + GICD_CTLR);
> +	else
> +		writel(reg | GICD_CTLR_ENABLE_G1, gicd_base + GICD_CTLR);
> +	trigger_and_check_spi("just this group enabled",
> +			      as_fiq ? IRQ_STAT_FIQ : IRQ_STAT_IRQ, cpu);
> +
> +	/* Check that both groups enabled fires the IRQ. */
> +	writel(reg | GICD_CTLR_ENABLE_BOTH, gicd_base + GICD_CTLR);
> +	trigger_and_check_spi("both groups enabled",
> +			      as_fiq ? IRQ_STAT_FIQ : IRQ_STAT_IRQ, cpu);
> +}
>  
>  /*
>   * Check the security state configuration of the GIC.
> @@ -711,6 +778,9 @@ static bool gicv3_check_security(void *gicd_base)
>   * Check whether this works as expected (as Linux will not use this feature).
>   * We can only verify this state on a GICv3, so we check it there and silently
>   * assume it's valid for GICv2.
> + * GICv2 and GICv3 handle the groups differently, but we use the common
> + * denominator (Group0 as FIQ, Group1 as IRQ) and rely on the GIC library for
> + * abstraction.
>   */
>  static void test_irq_group(void *gicd_base)
>  {
> @@ -754,6 +824,35 @@ static void test_irq_group(void *gicd_base)
>  	gic_set_irq_group(SPI_IRQ, !reg);
>  	report("IGROUPR is writable", gic_get_irq_group(SPI_IRQ) != reg);
>  	gic_set_irq_group(SPI_IRQ, reg);
> +
> +	/*
> +	 * Configure group 0 interrupts as FIQs, install both an FIQ and IRQ
> +	 * handler and allow both types to be delivered to the core.
> +	 */
> +	irqs_enable();
> +	fiqs_enable();
> +
> +	/* Configure one SPI to be a group0 interrupt. */
> +	gic_set_irq_group(SPI_IRQ, 0);
> +	spi_configure_irq(SPI_IRQ, smp_processor_id());
> +	report_prefix_push("FIQ");
> +	gic_check_irq_delivery(gicd_base, EXPECT_FIQ);
> +	report_prefix_pop();
> +
> +	/* Configure the SPI to be a group1 interrupt instead. */
> +	gic_set_irq_group(SPI_IRQ, 1);
> +	report_prefix_push("IRQ");
> +	gic_check_irq_delivery(gicd_base, EXPECT_IRQ);
> +	report_prefix_pop();
> +
> +	/* Reset the IRQ to the default group. */
> +	if (is_gicv3)
> +		gic_set_irq_group(SPI_IRQ, 1);
> +	else
> +		gic_set_irq_group(SPI_IRQ, 0);
> +	gic_disable_irq(SPI_IRQ);
> +
> +	report_prefix_pop();
>  }
>  
>  static void spi_send(void)
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
