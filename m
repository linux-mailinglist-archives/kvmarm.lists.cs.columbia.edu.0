Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 21446404531
	for <lists+kvmarm@lfdr.de>; Thu,  9 Sep 2021 07:51:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8F5224B130;
	Thu,  9 Sep 2021 01:51:28 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G+EJc9Uv26A1; Thu,  9 Sep 2021 01:51:28 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E09C34B106;
	Thu,  9 Sep 2021 01:51:26 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4879C4B0C2
 for <kvmarm@lists.cs.columbia.edu>; Thu,  9 Sep 2021 01:51:25 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J4LbhjJbtYb6 for <kvmarm@lists.cs.columbia.edu>;
 Thu,  9 Sep 2021 01:51:23 -0400 (EDT)
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com
 [209.85.166.181])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id B71344A19A
 for <kvmarm@lists.cs.columbia.edu>; Thu,  9 Sep 2021 01:51:23 -0400 (EDT)
Received: by mail-il1-f181.google.com with SMTP id l10so759464ilh.8
 for <kvmarm@lists.cs.columbia.edu>; Wed, 08 Sep 2021 22:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=KRXuQBbGOZdnhL8mCDneScmauX8k4RjdUvz+VIMwq2w=;
 b=BI+XgAFZ+35Jh6NgkZ7sIp/KQ7pUze4/ooglvOyOBQ/5gO1jspHiZqqS6uULwjV+jN
 EaMnnFINhYh7wEUQwR6TroI9Tf9cDuhw37vNMi9bzSLDTDsfDNLrxALmtViCZE3sKqa6
 EX9tRewfKy8pDrQ9ZyCPC+KuSN4UPs6kWiKpyOGEPmOWWHucUKnbqaKdbcgIf/JRyk89
 Hy5QiunnaT9SN/VUu5t7su5Zhvcxaql4wSACdLTf8sLUg7jGVfRFO/5MYgmWPT4jc8JQ
 CDYv59er80RfhwpYiBMPwYyYk2MiTaz64BYwrd6eTJYpgBKUAigt/LC3il7phTsBN108
 bVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=KRXuQBbGOZdnhL8mCDneScmauX8k4RjdUvz+VIMwq2w=;
 b=waqvJQzTynlgvJGUm+z5bXL5/cp7j4xO80p8TYedWwcIMb7rgqpSOxKg20U2l+lfAL
 Xholav02EfApbMRfXpjjxyoWLECOoeM7n1xhNcG+iqRb9bI9mmPkKIS/8IKG5skOo6+6
 aHD1gQLLRWPQPt/vXnXGMxfR7vV0Juet0Sy1G223ZM4c/n6eS0Ii+ss77EsfUPX4ySr7
 e3Pb5XeMPsBDx1dgSW7jdfyt+581BYlHF2bgNZ4FU7nVbLUIH0ub93JcJdpiMEw6kccl
 LkjCnl3zGs9u/7G5fC/78gXmWZiJIFJjfBu6Z/f6QQ3oiMq4tXuXmqW8zK2xlL+h5jh9
 /fCQ==
X-Gm-Message-State: AOAM5320s6Kngg/TCGpkCCJgSuTTkoy0T6VTQfY8X+yWzZWPhJypOA58
 6aIq12n0ywk/RcWWFjkxW0JclQ==
X-Google-Smtp-Source: ABdhPJwKMcVSl3rWFq3w6Ojyrn8W6plvyjCxqSWtWoDgcFn8PM+nzCqe93KPbshaccYFkITUo31jig==
X-Received: by 2002:a92:de51:: with SMTP id e17mr1104372ilr.188.1631166682829; 
 Wed, 08 Sep 2021 22:51:22 -0700 (PDT)
Received: from google.com (194.225.68.34.bc.googleusercontent.com.
 [34.68.225.194])
 by smtp.gmail.com with ESMTPSA id n11sm440271ilq.21.2021.09.08.22.51.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Sep 2021 22:51:22 -0700 (PDT)
Date: Thu, 9 Sep 2021 05:51:18 +0000
From: Oliver Upton <oupton@google.com>
To: Raghavendra Rao Ananta <rananta@google.com>
Subject: Re: [PATCH v4 15/18] KVM: arm64: selftests: Add arch_timer test
Message-ID: <YTmg1i23taXTrOQS@google.com>
References: <20210909013818.1191270-1-rananta@google.com>
 <20210909013818.1191270-16-rananta@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210909013818.1191270-16-rananta@google.com>
Cc: kvm@vger.kernel.org, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Peter Shier <pshier@google.com>,
 linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
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

On Thu, Sep 09, 2021 at 01:38:15AM +0000, Raghavendra Rao Ananta wrote:
> Add a KVM selftest to validate the arch_timer functionality.
> Primarily, the test sets up periodic timer interrupts and
> validates the basic architectural expectations upon its receipt.
> 
> The test provides command-line options to configure the period
> of the timer, number of iterations, and number of vCPUs.
> 
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> Reviewed-by: Andrew Jones <drjones@redhat.com>
> ---
>  tools/testing/selftests/kvm/.gitignore        |   1 +
>  tools/testing/selftests/kvm/Makefile          |   1 +
>  .../selftests/kvm/aarch64/arch_timer.c        | 351 ++++++++++++++++++
>  3 files changed, 353 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/aarch64/arch_timer.c
> 
> diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
> index 98053d3afbda..c6058df0cd18 100644
> --- a/tools/testing/selftests/kvm/.gitignore
> +++ b/tools/testing/selftests/kvm/.gitignore
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +/aarch64/arch_timer
>  /aarch64/debug-exceptions
>  /aarch64/get-reg-list
>  /aarch64/psci_cpu_on_test
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index 8342f65c1d96..46d43e706b20 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -84,6 +84,7 @@ TEST_GEN_PROGS_x86_64 += set_memory_region_test
>  TEST_GEN_PROGS_x86_64 += steal_time
>  TEST_GEN_PROGS_x86_64 += kvm_binary_stats_test
>  
> +TEST_GEN_PROGS_aarch64 += aarch64/arch_timer
>  TEST_GEN_PROGS_aarch64 += aarch64/debug-exceptions
>  TEST_GEN_PROGS_aarch64 += aarch64/get-reg-list
>  TEST_GEN_PROGS_aarch64 += aarch64/psci_cpu_on_test
> diff --git a/tools/testing/selftests/kvm/aarch64/arch_timer.c b/tools/testing/selftests/kvm/aarch64/arch_timer.c
> new file mode 100644
> index 000000000000..6141c387e6dc
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/aarch64/arch_timer.c
> @@ -0,0 +1,351 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * arch_timer.c - Tests the aarch64 timer IRQ functionality
> + *
> + * The test validates both the virtual and physical timer IRQs using
> + * CVAL and TVAL registers. This consitutes the four stages in the test.
> + * The guest's main thread configures the timer interrupt for a stage
> + * and waits for it to fire, with a timeout equal to the timer period.
> + * It asserts that the timeout doesn't exceed the timer period.
> + *
> + * On the other hand, upon receipt of an interrupt, the guest's interrupt
> + * handler validates the interrupt by checking if the architectural state
> + * is in compliance with the specifications.
> + *
> + * The test provides command-line options to configure the timer's
> + * period (-p), number of vCPUs (-n), and iterations per stage (-i).
> + *
> + * Copyright (c) 2021, Google LLC.
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include <stdlib.h>
> +#include <pthread.h>
> +#include <linux/kvm.h>
> +#include <linux/sizes.h>
> +
> +#include "kvm_util.h"
> +#include "processor.h"
> +#include "delay.h"
> +#include "arch_timer.h"
> +#include "gic.h"
> +#include "vgic.h"
> +
> +#define NR_VCPUS_DEF			4
> +#define NR_TEST_ITERS_DEF		5
> +#define TIMER_TEST_PERIOD_MS_DEF	10
> +#define TIMER_TEST_ERR_MARGIN_US	100
> +
> +struct test_args {
> +	int nr_vcpus;
> +	int nr_iter;
> +	int timer_period_ms;
> +};
> +
> +static struct test_args test_args = {
> +	.nr_vcpus = NR_VCPUS_DEF,
> +	.nr_iter = NR_TEST_ITERS_DEF,
> +	.timer_period_ms = TIMER_TEST_PERIOD_MS_DEF,
> +};
> +
> +#define msecs_to_usecs(msec)		((msec) * 1000LL)
> +
> +#define VTIMER_IRQ			27
> +#define PTIMER_IRQ			30

I don't know if these are guaranteed, necessarily. Probably safest to
determine the IRQ# from the KVM_ARM_VCPU_TIMER_IRQ_{P,V}TIMER vCPU
device attributes. Either that or write these values to the attributes.

> +#define GICD_BASE_GPA			0x8000000ULL
> +#define GICR_BASE_GPA			0x80A0000ULL
> +
> +enum guest_stage {
> +	GUEST_STAGE_VTIMER_CVAL = 1,
> +	GUEST_STAGE_VTIMER_TVAL,
> +	GUEST_STAGE_PTIMER_CVAL,
> +	GUEST_STAGE_PTIMER_TVAL,
> +	GUEST_STAGE_MAX,
> +};
> +
> +/* Shared variables between host and guest */
> +struct test_vcpu_shared_data {
> +	int nr_iter;
> +	enum guest_stage guest_stage;
> +	uint64_t xcnt;
> +};
> +
> +struct test_vcpu {
> +	uint32_t vcpuid;
> +	pthread_t pt_vcpu_run;
> +	struct kvm_vm *vm;
> +};
> +
> +static struct test_vcpu test_vcpu[KVM_MAX_VCPUS];
> +static struct test_vcpu_shared_data vcpu_shared_data[KVM_MAX_VCPUS];
> +
> +static void
> +guest_configure_timer_action(struct test_vcpu_shared_data *shared_data)
> +{
> +	switch (shared_data->guest_stage) {
> +	case GUEST_STAGE_VTIMER_CVAL:
> +		timer_set_next_cval_ms(VIRTUAL, test_args.timer_period_ms);
> +		shared_data->xcnt = timer_get_cntct(VIRTUAL);
> +		timer_set_ctl(VIRTUAL, CTL_ENABLE);
> +		break;
> +	case GUEST_STAGE_VTIMER_TVAL:
> +		timer_set_next_tval_ms(VIRTUAL, test_args.timer_period_ms);
> +		shared_data->xcnt = timer_get_cntct(VIRTUAL);
> +		timer_set_ctl(VIRTUAL, CTL_ENABLE);
> +		break;
> +	case GUEST_STAGE_PTIMER_CVAL:
> +		timer_set_next_cval_ms(PHYSICAL, test_args.timer_period_ms);
> +		shared_data->xcnt = timer_get_cntct(PHYSICAL);
> +		timer_set_ctl(PHYSICAL, CTL_ENABLE);
> +		break;
> +	case GUEST_STAGE_PTIMER_TVAL:
> +		timer_set_next_tval_ms(PHYSICAL, test_args.timer_period_ms);
> +		shared_data->xcnt = timer_get_cntct(PHYSICAL);
> +		timer_set_ctl(PHYSICAL, CTL_ENABLE);
> +		break;
> +	default:
> +		GUEST_ASSERT(0);
> +	}
> +}
> +
> +static void guest_validate_irq(unsigned int intid,
> +				struct test_vcpu_shared_data *shared_data)
> +{
> +	enum guest_stage stage = shared_data->guest_stage;
> +	uint64_t xcnt = 0, xcnt_diff_us, cval = 0;
> +	unsigned long xctl = 0;
> +	unsigned int timer_irq = 0;
> +
> +	if (stage == GUEST_STAGE_VTIMER_CVAL ||
> +		stage == GUEST_STAGE_VTIMER_TVAL) {
> +		xctl = timer_get_ctl(VIRTUAL);
> +		timer_set_ctl(VIRTUAL, CTL_IMASK);
> +		xcnt = timer_get_cntct(VIRTUAL);
> +		cval = timer_get_cval(VIRTUAL);
> +		timer_irq = VTIMER_IRQ;
> +	} else if (stage == GUEST_STAGE_PTIMER_CVAL ||
> +		stage == GUEST_STAGE_PTIMER_TVAL) {
> +		xctl = timer_get_ctl(PHYSICAL);
> +		timer_set_ctl(PHYSICAL, CTL_IMASK);
> +		xcnt = timer_get_cntct(PHYSICAL);
> +		cval = timer_get_cval(PHYSICAL);
> +		timer_irq = PTIMER_IRQ;
> +	} else {
> +		GUEST_ASSERT(0);
> +	}
> +
> +	xcnt_diff_us = cycles_to_usec(xcnt - shared_data->xcnt);
> +
> +	/* Make sure we are dealing with the correct timer IRQ */
> +	GUEST_ASSERT_2(intid == timer_irq, intid, timer_irq);
> +
> +	/* Basic 'timer condition met' check */
> +	GUEST_ASSERT_3(xcnt >= cval, xcnt, cval, xcnt_diff_us);
> +	GUEST_ASSERT_1(xctl & CTL_ISTATUS, xctl);
> +}
> +
> +static void guest_irq_handler(struct ex_regs *regs)
> +{
> +	unsigned int intid = gic_get_and_ack_irq();
> +	uint32_t cpu = get_vcpuid();
> +	struct test_vcpu_shared_data *shared_data = &vcpu_shared_data[cpu];
> +
> +	guest_validate_irq(intid, shared_data);
> +
> +	WRITE_ONCE(shared_data->nr_iter, shared_data->nr_iter + 1);
> +
> +	gic_set_eoi(intid);
> +}
> +
> +static void guest_run_stage(struct test_vcpu_shared_data *shared_data,
> +				enum guest_stage stage)
> +{
> +	uint32_t irq_iter, config_iter;
> +
> +	shared_data->guest_stage = stage;
> +	shared_data->nr_iter = 0;
> +
> +	for (config_iter = 0; config_iter < test_args.nr_iter; config_iter++) {
> +		/* Setup the next interrupt */
> +		guest_configure_timer_action(shared_data);
> +
> +		/* Setup a timeout for the interrupt to arrive */
> +		udelay(msecs_to_usecs(test_args.timer_period_ms) +
> +			TIMER_TEST_ERR_MARGIN_US);
> +
> +		irq_iter = READ_ONCE(shared_data->nr_iter);
> +		GUEST_ASSERT_2(config_iter + 1 == irq_iter,
> +				config_iter + 1, irq_iter);
> +	}
> +}
> +
> +static void guest_code(void)
> +{
> +	uint32_t cpu = get_vcpuid();
> +	struct test_vcpu_shared_data *shared_data = &vcpu_shared_data[cpu];
> +
> +	local_irq_disable();
> +
> +	gic_init(GIC_V3, test_args.nr_vcpus,
> +		(void *)GICD_BASE_GPA, (void *)GICR_BASE_GPA);
> +
> +	timer_set_ctl(VIRTUAL, CTL_IMASK);
> +	timer_set_ctl(PHYSICAL, CTL_IMASK);
> +
> +	gic_irq_enable(VTIMER_IRQ);
> +	gic_irq_enable(PTIMER_IRQ);
> +	local_irq_enable();
> +
> +	guest_run_stage(shared_data, GUEST_STAGE_VTIMER_CVAL);
> +	guest_run_stage(shared_data, GUEST_STAGE_VTIMER_TVAL);
> +	guest_run_stage(shared_data, GUEST_STAGE_PTIMER_CVAL);
> +	guest_run_stage(shared_data, GUEST_STAGE_PTIMER_TVAL);
> +
> +	GUEST_DONE();
> +}
> +
> +static void *test_vcpu_run(void *arg)
> +{
> +	struct ucall uc;
> +	struct test_vcpu *vcpu = arg;
> +	struct kvm_vm *vm = vcpu->vm;
> +	uint32_t vcpuid = vcpu->vcpuid;
> +	struct test_vcpu_shared_data *shared_data = &vcpu_shared_data[vcpuid];
> +
> +	vcpu_run(vm, vcpuid);
> +
> +	switch (get_ucall(vm, vcpuid, &uc)) {
> +	case UCALL_SYNC:
> +	case UCALL_DONE:
> +		break;
> +	case UCALL_ABORT:
> +		sync_global_from_guest(vm, *shared_data);
> +		TEST_FAIL("%s at %s:%ld\n\tvalues: %lu, %lu; %lu, vcpu: %u; stage: %u; iter: %u",
> +			(const char *)uc.args[0], __FILE__, uc.args[1],
> +			uc.args[2], uc.args[3], uc.args[4], vcpuid,
> +			shared_data->guest_stage, shared_data->nr_iter);
> +		break;
> +	default:
> +		TEST_FAIL("Unexpected guest exit\n");
> +	}
> +
> +	return NULL;
> +}
> +
> +static void test_run(struct kvm_vm *vm)
> +{
> +	int i, ret;
> +
> +	for (i = 0; i < test_args.nr_vcpus; i++) {
> +		ret = pthread_create(&test_vcpu[i].pt_vcpu_run, NULL,
> +				test_vcpu_run, &test_vcpu[i]);
> +		TEST_ASSERT(!ret, "Failed to create vCPU-%d pthread\n", i);
> +	}
> +
> +	for (i = 0; i < test_args.nr_vcpus; i++)
> +		pthread_join(test_vcpu[i].pt_vcpu_run, NULL);
> +}
> +
> +static struct kvm_vm *test_vm_create(void)
> +{
> +	struct kvm_vm *vm;
> +	unsigned int i;
> +	int nr_vcpus = test_args.nr_vcpus;
> +
> +	vm = vm_create_default_with_vcpus(nr_vcpus, 0, 0, guest_code, NULL);
> +
> +	vm_init_descriptor_tables(vm);
> +	vm_install_exception_handler(vm, VECTOR_IRQ_CURRENT, guest_irq_handler);
> +
> +	for (i = 0; i < nr_vcpus; i++) {
> +		vcpu_init_descriptor_tables(vm, i);
> +
> +		test_vcpu[i].vcpuid = i;
> +		test_vcpu[i].vm = vm;
> +	}
> +
> +	ucall_init(vm, NULL);
> +	vm_vcpuid_map_init(vm);
> +	vgic_v3_setup(vm, GICD_BASE_GPA, GICR_BASE_GPA);
> +
> +	/* Make all the test's cmdline args visible to the guest */
> +	sync_global_to_guest(vm, test_args);
> +
> +	return vm;
> +}
> +
> +static void test_print_help(char *name)
> +{
> +	pr_info("Usage: %s [-h] [-n nr_vcpus] [-i iterations] [-p timer_period_ms]\n",
> +		name);
> +	pr_info("\t-n: Number of vCPUs to configure (default: %u; max: %u)\n",
> +		NR_VCPUS_DEF, KVM_MAX_VCPUS);
> +	pr_info("\t-i: Number of iterations per stage (default: %u)\n",
> +		NR_TEST_ITERS_DEF);
> +	pr_info("\t-p: Periodicity (in ms) of the guest timer (default: %u)\n",
> +		TIMER_TEST_PERIOD_MS_DEF);
> +	pr_info("\t-h: print this help screen\n");
> +}
> +
> +static bool parse_args(int argc, char *argv[])
> +{
> +	int opt;
> +
> +	while ((opt = getopt(argc, argv, "hn:i:p:")) != -1) {
> +		switch (opt) {
> +		case 'n':
> +			test_args.nr_vcpus = atoi(optarg);
> +			if (test_args.nr_vcpus <= 0) {
> +				pr_info("Positive value needed for -n\n");
> +				goto err;
> +			} else if (test_args.nr_vcpus > KVM_MAX_VCPUS) {
> +				pr_info("Max allowed vCPUs: %u\n",
> +					KVM_MAX_VCPUS);
> +				goto err;
> +			}
> +			break;
> +		case 'i':
> +			test_args.nr_iter = atoi(optarg);
> +			if (test_args.nr_iter <= 0) {
> +				pr_info("Positive value needed for -i\n");
> +				goto err;
> +			}
> +			break;
> +		case 'p':
> +			test_args.timer_period_ms = atoi(optarg);
> +			if (test_args.timer_period_ms <= 0) {
> +				pr_info("Positive value needed for -p\n");
> +				goto err;
> +			}
> +			break;
> +		case 'h':
> +		default:
> +			goto err;
> +		}
> +	}
> +
> +	return true;
> +
> +err:
> +	test_print_help(argv[0]);
> +	return false;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	struct kvm_vm *vm;
> +
> +	/* Tell stdout not to buffer its content */
> +	setbuf(stdout, NULL);
> +
> +	if (!parse_args(argc, argv))
> +		exit(KSFT_SKIP);
> +
> +	vm = test_vm_create();
> +	test_run(vm);
> +	kvm_vm_free(vm);
> +
> +	return 0;
> +}
> -- 
> 2.33.0.153.gba50c8fa24-goog
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
