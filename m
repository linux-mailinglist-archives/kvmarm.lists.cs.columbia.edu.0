Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A0C312CD9B7
	for <lists+kvmarm@lfdr.de>; Thu,  3 Dec 2020 15:59:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4C43D4B215;
	Thu,  3 Dec 2020 09:59:31 -0500 (EST)
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
	with ESMTP id tEaNzPEMM+Jx; Thu,  3 Dec 2020 09:59:31 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 286B44B183;
	Thu,  3 Dec 2020 09:59:29 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B66E84B1E5
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Dec 2020 09:59:27 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WKsaDiu3vONP for <kvmarm@lists.cs.columbia.edu>;
 Thu,  3 Dec 2020 09:59:26 -0500 (EST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2F30E4B183
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Dec 2020 09:59:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607007566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BDeTIJEROcNVne18YaosCk9D2rmp/hO9A4ZZqG9b8tQ=;
 b=hZMqF9crf/fOMm1EVU1JV+PbIde3GUErzkuZpvmb2xdzr8UHW/FLRBbriWQNaVdgNo3Ehj
 TMGe3j5j8X1Edao1CrISztqlOf3+k2reR8YGTRLsv134s31RoQgzGCCs9xxjVraU0g7grc
 PoYqRvbvxaQKg4M/9V335Vuj43V7d00=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-d_OuL320N8iMfFk77dXFDw-1; Thu, 03 Dec 2020 09:59:23 -0500
X-MC-Unique: d_OuL320N8iMfFk77dXFDw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 734D8800D62;
 Thu,  3 Dec 2020 14:59:20 +0000 (UTC)
Received: from [10.36.112.89] (ovpn-112-89.ams2.redhat.com [10.36.112.89])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B8DA5D6AC;
 Thu,  3 Dec 2020 14:59:18 +0000 (UTC)
Subject: Re: [kvm-unit-tests PATCH 10/10] arm64: gic: Use IPI test checking
 for the LPI tests
To: Alexandru Elisei <alexandru.elisei@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, drjones@redhat.com
References: <20201125155113.192079-1-alexandru.elisei@arm.com>
 <20201125155113.192079-11-alexandru.elisei@arm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <31f306fe-f553-13ef-6b7b-c2dfc880fd43@redhat.com>
Date: Thu, 3 Dec 2020 15:59:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20201125155113.192079-11-alexandru.elisei@arm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
On 11/25/20 4:51 PM, Alexandru Elisei wrote:
> The LPI code validates a result similarly to the IPI tests, by checking if
> the target CPU received the interrupt with the expected interrupt number.
> However, the LPI tests invent their own way of checking the test results by
> creating a global struct (lpi_stats), using a separate interrupt handler
> (lpi_handler) and test function (check_lpi_stats).
> 
> There are several areas that can be improved in the LPI code, which are
> already covered by the IPI tests:
> 
> - check_lpi_stats() doesn't take into account that the target CPU can
>   receive the correct interrupt multiple times.
> - check_lpi_stats() doesn't take into the account the scenarios where all
>   online CPUs can receive the interrupt, but the target CPU is the last CPU
>   that touches lpi_stats.observed.
> - Insufficient or missing memory synchronization.
> 
> Instead of duplicating code, let's convert the LPI tests to use
> check_acked() and the same interrupt handler as the IPI tests, which has
> been renamed to irq_handler() to avoid any confusion.
> 
> check_lpi_stats() has been replaced with check_acked() which, together with
> using irq_handler(), instantly gives us more correctness checks and proper
> memory synchronization between threads. lpi_stats.expected has been
> replaced by the CPU mask and the expected interrupt number arguments to
> check_acked(), with no change in semantics.
> 
> lpi_handler() aborted the test if the interrupt number was not an LPI. This
> was changed in favor of allowing the test to continue, as it will fail in
> check_acked(), but possibly print information useful for debugging. If the
> test receives spurious interrupts, those are reported via report_info() at
> the end of the test for consistency with the IPI tests, which don't treat
> spurious interrupts as critical errors.
> 
> In the spirit of code reuse, secondary_lpi_tests() has been replaced with
> ipi_recv() because the two are now identical; ipi_recv() has been renamed
> to irq_recv(), similarly to irq_handler(), to avoid confusion.
> 
> CC: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> ---
> With this change, I get the following failure for its-trigger on a
> rockpro64 (running on the little cores):
> 
> $ taskset -c 0-3 arm/run arm/gic.flat -smp 4 -machine gic-version=3 -append its-trigger
> /usr/bin/qemu-system-aarch64 -nodefaults -machine virt,gic-version=host,accel=kvm -cpu host -device virtio-serial-device -device virtconsole,chardev=ctd -chardev testdev,id=ctd -device pci-testdev -display none -serial stdio -kernel arm/gic.flat -smp 4 -machine gic-version=3 -append its-trigger # -initrd /tmp/tmp.wWW0iJY6DS
> ITS: MAPD devid=2 size = 0x8 itt=0x403a0000 valid=1
> ITS: MAPD devid=7 size = 0x8 itt=0x403b0000 valid=1
> MAPC col_id=3 target_addr = 0x30000 valid=1
> MAPC col_id=2 target_addr = 0x20000 valid=1
> INVALL col_id=2
> INVALL col_id=3
> MAPTI dev_id=2 event_id=20 -> phys_id=8195, col_id=3
> MAPTI dev_id=7 event_id=255 -> phys_id=8196, col_id=2
> INT dev_id=2 event_id=20
> PASS: gicv3: its-trigger: int: dev=2, eventid=20  -> lpi= 8195, col=3
> INT dev_id=7 event_id=255
> PASS: gicv3: its-trigger: int: dev=7, eventid=255 -> lpi= 8196, col=2
> INV dev_id=2 event_id=20
> INT dev_id=2 event_id=20
> PASS: gicv3: its-trigger: inv/invall: dev2/eventid=20 does not trigger any LPI
> INT dev_id=2 event_id=20
> PASS: gicv3: its-trigger: inv/invall: dev2/eventid=20 still does not trigger any LPI
> INVALL col_id=3
> INT dev_id=2 event_id=20
> INFO: gicv3: its-trigger: inv/invall: ACKS: missing=0 extra=1 unexpected=0
> FAIL: gicv3: its-trigger: inv/invall: dev2/eventid=20 now triggers an LPI
> ITS: MAPD devid=2 size = 0x8 itt=0x403a0000 valid=0
> INT dev_id=2 event_id=20
> PASS: gicv3: its-trigger: mapd valid=false: no LPI after device unmap
> SUMMARY: 6 tests, 1 unexpected failures
> 
> The reason for the failure is that the test "dev2/eventid=20 now triggers
> an LPI" triggers 2 LPIs, not one. This behavior was present before this
> patch, but it was ignored because check_lpi_stats() wasn't looking at the
> acked array.
> 
> I'm not familiar with the ITS so I'm not sure if this is expected, if the
> test is incorrect or if there is something wrong with KVM emulation.
> 
> Did some more testing on an Ampere eMAG (fast out-of-order cores) using
> qemu and kvmtool and Linux v5.8, here's what I found:
> 
> - Using qemu and gic.flat built from *master*: error encountered 864 times
>   out of 1088 runs.
> - Using qemu: error encountered 852 times out of 1027 runs.
> - Using kvmtool: error encountered 8164 times out of 10602 runs.
> 
> Looks to me like it's consistent between master and this series, and
> between qemu and kvmtool.
> 
> Here's the diff that I used for testing master (I removed the diff line
> because it causes trouble when applying the main patch):
> 
> @@ -772,8 +772,12 @@ static void test_its_trigger(void)
>         /* Now call the invall and check the LPI hits */
>         its_send_invall(col3);
>         lpi_stats_expect(3, 8195);
> +       acked[3] = 0;
> +       dsb(ishst);
>         its_send_int(dev2, 20);
>         check_lpi_stats("dev2/eventid=20 now triggers an LPI");
> +       report_info("acked[3] = %d", acked[3]);
> +       report(acked[3] == 1, "dev2/eventid=20 received one interrupt");
>  
>         report_prefix_pop();
>  
> 
>  arm/gic.c | 185 ++++++++++++++++++++++++++----------------------------
>  1 file changed, 88 insertions(+), 97 deletions(-)
> 
> diff --git a/arm/gic.c b/arm/gic.c
> index da7b42da5449..6e93da80fe0d 100644
> --- a/arm/gic.c
> +++ b/arm/gic.c
> @@ -111,7 +111,7 @@ static bool check_acked(cpumask_t *mask, int sender, int irqnum)
>  		}
>  		if (!acked[cpu])
>  			continue;
> -		smp_rmb(); /* pairs with smp_wmb in ipi_handler */
> +		smp_rmb(); /* pairs with smp_wmb in irq_handler */
>  
>  		if (has_gicv2 && irq_sender[cpu] != sender) {
>  			report_info("cpu%d received IPI from wrong sender %d",
> @@ -149,11 +149,12 @@ static void check_spurious(void)
>  static int gic_get_sender(int irqstat)
>  {
>  	if (gic_version() == 2)
> +		/* GICC_IAR.CPUID is RAZ for non-SGIs */
>  		return (irqstat >> 10) & 7;
>  	return -1;
>  }
>  
> -static void ipi_handler(struct pt_regs *regs __unused)
> +static void irq_handler(struct pt_regs *regs __unused)
>  {
>  	u32 irqstat = gic_read_iar();
>  	u32 irqnr = gic_iar_irqnr(irqstat);
> @@ -192,75 +193,6 @@ static void setup_irq(irq_handler_fn handler)
>  }
>  
>  #if defined(__aarch64__)
> -struct its_event {
> -	int cpu_id;
> -	int lpi_id;
> -};
> -
> -struct its_stats {
> -	struct its_event expected;
> -	struct its_event observed;
> -};
> -
> -static struct its_stats lpi_stats;
> -
> -static void lpi_handler(struct pt_regs *regs __unused)
> -{
> -	u32 irqstat = gic_read_iar();
> -	int irqnr = gic_iar_irqnr(irqstat);
> -
> -	gic_write_eoir(irqstat);
> -	assert(irqnr >= 8192);
> -	smp_rmb(); /* pairs with wmb in lpi_stats_expect */
> -	lpi_stats.observed.cpu_id = smp_processor_id();
> -	lpi_stats.observed.lpi_id = irqnr;
> -	acked[lpi_stats.observed.cpu_id]++;
> -	smp_wmb(); /* pairs with rmb in check_lpi_stats */
> -}
> -
> -static void lpi_stats_expect(int exp_cpu_id, int exp_lpi_id)
> -{
> -	lpi_stats.expected.cpu_id = exp_cpu_id;
> -	lpi_stats.expected.lpi_id = exp_lpi_id;
> -	lpi_stats.observed.cpu_id = -1;
> -	lpi_stats.observed.lpi_id = -1;
> -	smp_wmb(); /* pairs with rmb in handler */
> -}
> -
> -static void check_lpi_stats(const char *msg)
> -{
> -	int i;
> -
> -	for (i = 0; i < 50; i++) {
> -		mdelay(100);
> -		smp_rmb(); /* pairs with wmb in lpi_handler */
> -		if (lpi_stats.observed.cpu_id == lpi_stats.expected.cpu_id &&
> -		    lpi_stats.observed.lpi_id == lpi_stats.expected.lpi_id) {
> -			report(true, "%s", msg);
> -			return;
> -		}
> -	}
> -
> -	if (lpi_stats.observed.cpu_id == -1 && lpi_stats.observed.lpi_id == -1) {
> -		report_info("No LPI received whereas (cpuid=%d, intid=%d) "
> -			    "was expected", lpi_stats.expected.cpu_id,
> -			    lpi_stats.expected.lpi_id);
> -	} else {
> -		report_info("Unexpected LPI (cpuid=%d, intid=%d)",
> -			    lpi_stats.observed.cpu_id,
> -			    lpi_stats.observed.lpi_id);
> -	}
> -	report(false, "%s", msg);
> -}
> -
> -static void secondary_lpi_test(void)
> -{
> -	setup_irq(lpi_handler);
> -	cpumask_set_cpu(smp_processor_id(), &ready);
> -	while (1)
> -		wfi();
> -}
> -
>  static void check_lpi_hits(int *expected, const char *msg)
>  {
>  	bool pass = true;
> @@ -347,7 +279,7 @@ static void ipi_test_smp(void)
>  
>  static void ipi_send(void)
>  {
> -	setup_irq(ipi_handler);
> +	setup_irq(irq_handler);
>  	wait_on_ready();
>  	ipi_test_self();
>  	ipi_test_smp();
> @@ -355,9 +287,9 @@ static void ipi_send(void)
>  	exit(report_summary());
>  }
>  
> -static void ipi_recv(void)
> +static void irq_recv(void)
>  {
> -	setup_irq(ipi_handler);
> +	setup_irq(irq_handler);
>  	cpumask_set_cpu(smp_processor_id(), &ready);
>  	while (1)
>  		wfi();
> @@ -368,7 +300,7 @@ static void ipi_test(void *data __unused)
>  	if (smp_processor_id() == IPI_SENDER)
>  		ipi_send();
>  	else
> -		ipi_recv();
> +		irq_recv();
>  }
>  
>  static struct gic gicv2 = {
> @@ -698,12 +630,12 @@ static int its_prerequisites(int nb_cpus)
>  
>  	stats_reset();
>  
> -	setup_irq(lpi_handler);
> +	setup_irq(irq_handler);
>  
>  	for_each_present_cpu(cpu) {
>  		if (cpu == 0)
>  			continue;
> -		smp_boot_secondary(cpu, secondary_lpi_test);
> +		smp_boot_secondary(cpu, irq_recv);
>  	}
>  	wait_on_ready();
>  
> @@ -757,6 +689,7 @@ static void test_its_trigger(void)
>  {
>  	struct its_collection *col3;
>  	struct its_device *dev2, *dev7;
> +	cpumask_t mask;
>  
>  	if (its_setup1())
>  		return;
> @@ -767,13 +700,27 @@ static void test_its_trigger(void)
>  
>  	report_prefix_push("int");
>  
> -	lpi_stats_expect(3, 8195);
> +	stats_reset();
> +	/*
> +	 * its_send_int() is missing the synchronization from the GICv3 IPI
> +	 * trigger functions.
> +	 */
> +	wmb();
so don't you want to add it in __its_send_int instead?

Eric
> +	cpumask_clear(&mask);
> +	cpumask_set_cpu(3, &mask);
>  	its_send_int(dev2, 20);
> -	check_lpi_stats("dev=2, eventid=20  -> lpi= 8195, col=3");
> +	wait_for_interrupts(&mask);
> +	report(check_acked(&mask, 0, 8195),
> +			"dev=2, eventid=20  -> lpi= 8195, col=3");
>  
> -	lpi_stats_expect(2, 8196);
> +	stats_reset();
> +	wmb();
> +	cpumask_clear(&mask);
> +	cpumask_set_cpu(2, &mask);
>  	its_send_int(dev7, 255);
> -	check_lpi_stats("dev=7, eventid=255 -> lpi= 8196, col=2");
> +	wait_for_interrupts(&mask);
> +	report(check_acked(&mask, 0, 8196),
> +			"dev=7, eventid=255 -> lpi= 8196, col=2");
>  
>  	report_prefix_pop();
>  
> @@ -786,9 +733,13 @@ static void test_its_trigger(void)
>  	gicv3_lpi_set_config(8195, LPI_PROP_DEFAULT & ~LPI_PROP_ENABLED);
>  	its_send_inv(dev2, 20);
>  
> -	lpi_stats_expect(-1, -1);
> +	stats_reset();
> +	wmb();
> +	cpumask_clear(&mask);
>  	its_send_int(dev2, 20);
> -	check_lpi_stats("dev2/eventid=20 does not trigger any LPI");
> +	wait_for_interrupts(&mask);
> +	report(check_acked(&mask, -1, -1),
> +			"dev2/eventid=20 does not trigger any LPI");
>  
>  	/*
>  	 * re-enable the LPI but willingly do not call invall
> @@ -796,15 +747,24 @@ static void test_its_trigger(void)
>  	 * The LPI should not hit
>  	 */
>  	gicv3_lpi_set_config(8195, LPI_PROP_DEFAULT);
> -	lpi_stats_expect(-1, -1);
> +	stats_reset();
> +	wmb();
> +	cpumask_clear(&mask);
>  	its_send_int(dev2, 20);
> -	check_lpi_stats("dev2/eventid=20 still does not trigger any LPI");
> +	wait_for_interrupts(&mask);
> +	report(check_acked(&mask, -1, -1),
> +			"dev2/eventid=20 still does not trigger any LPI");
>  
>  	/* Now call the invall and check the LPI hits */
>  	its_send_invall(col3);
> -	lpi_stats_expect(3, 8195);
> +	stats_reset();
> +	wmb();
> +	cpumask_clear(&mask);
> +	cpumask_set_cpu(3, &mask);
>  	its_send_int(dev2, 20);
> -	check_lpi_stats("dev2/eventid=20 now triggers an LPI");
> +	wait_for_interrupts(&mask);
> +	report(check_acked(&mask, 0, 8195),
> +			"dev2/eventid=20 now triggers an LPI");
>  
>  	report_prefix_pop();
>  
> @@ -815,9 +775,14 @@ static void test_its_trigger(void)
>  	 */
>  
>  	its_send_mapd(dev2, false);
> -	lpi_stats_expect(-1, -1);
> +	stats_reset();
> +	wmb();
> +	cpumask_clear(&mask);
>  	its_send_int(dev2, 20);
> -	check_lpi_stats("no LPI after device unmap");
> +	wait_for_interrupts(&mask);
> +	report(check_acked(&mask, -1, -1), "no LPI after device unmap");
> +
> +	check_spurious();
>  	report_prefix_pop();
>  }
>  
> @@ -825,6 +790,7 @@ static void test_its_migration(void)
>  {
>  	struct its_device *dev2, *dev7;
>  	bool test_skipped = false;
> +	cpumask_t mask;
>  
>  	if (its_setup1()) {
>  		test_skipped = true;
> @@ -841,13 +807,25 @@ do_migrate:
>  	if (test_skipped)
>  		return;
>  
> -	lpi_stats_expect(3, 8195);
> +	stats_reset();
> +	wmb();
> +	cpumask_clear(&mask);
> +	cpumask_set_cpu(3, &mask);
>  	its_send_int(dev2, 20);
> -	check_lpi_stats("dev2/eventid=20 triggers LPI 8195 on PE #3 after migration");
> +	wait_for_interrupts(&mask);
> +	report(check_acked(&mask, 0, 8195),
> +			"dev2/eventid=20 triggers LPI 8195 on PE #3 after migration");
>  
> -	lpi_stats_expect(2, 8196);
> +	stats_reset();
> +	wmb();
> +	cpumask_clear(&mask);
> +	cpumask_set_cpu(2, &mask);
>  	its_send_int(dev7, 255);
> -	check_lpi_stats("dev7/eventid=255 triggers LPI 8196 on PE #2 after migration");
> +	wait_for_interrupts(&mask);
> +	report(check_acked(&mask, 0, 8196),
> +			"dev7/eventid=255 triggers LPI 8196 on PE #2 after migration");
> +
> +	check_spurious();
>  }
>  
>  #define ERRATA_UNMAPPED_COLLECTIONS "ERRATA_8c58be34494b"
> @@ -857,6 +835,7 @@ static void test_migrate_unmapped_collection(void)
>  	struct its_collection *col = NULL;
>  	struct its_device *dev2 = NULL, *dev7 = NULL;
>  	bool test_skipped = false;
> +	cpumask_t mask;
>  	int pe0 = 0;
>  	u8 config;
>  
> @@ -891,17 +870,29 @@ do_migrate:
>  	its_send_mapc(col, true);
>  	its_send_invall(col);
>  
> -	lpi_stats_expect(2, 8196);
> +	stats_reset();
> +	wmb();
> +	cpumask_clear(&mask);
> +	cpumask_set_cpu(2, &mask);
>  	its_send_int(dev7, 255);
> -	check_lpi_stats("dev7/eventid= 255 triggered LPI 8196 on PE #2");
> +	wait_for_interrupts(&mask);
> +	report(check_acked(&mask, 0, 8196),
> +			"dev7/eventid= 255 triggered LPI 8196 on PE #2");
>  
>  	config = gicv3_lpi_get_config(8192);
>  	report(config == LPI_PROP_DEFAULT,
>  	       "Config of LPI 8192 was properly migrated");
>  
> -	lpi_stats_expect(pe0, 8192);
> +	stats_reset();
> +	wmb();
> +	cpumask_clear(&mask);
> +	cpumask_set_cpu(pe0, &mask);
>  	its_send_int(dev2, 0);
> -	check_lpi_stats("dev2/eventid = 0 triggered LPI 8192 on PE0");
> +	wait_for_interrupts(&mask);
> +	report(check_acked(&mask, 0, 8192),
> +			"dev2/eventid = 0 triggered LPI 8192 on PE0");
> +
> +	check_spurious();
>  }
>  
>  static void test_its_pending_migration(void)
> 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
