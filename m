Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B40403F9C9A
	for <lists+kvmarm@lfdr.de>; Fri, 27 Aug 2021 18:36:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1860F4B11A;
	Fri, 27 Aug 2021 12:36:24 -0400 (EDT)
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
	with ESMTP id gOTL3zgTLdzr; Fri, 27 Aug 2021 12:36:23 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1A6C04B11E;
	Fri, 27 Aug 2021 12:36:20 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7EA354B118
 for <kvmarm@lists.cs.columbia.edu>; Fri, 27 Aug 2021 12:36:19 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4Dq952+h3B5q for <kvmarm@lists.cs.columbia.edu>;
 Fri, 27 Aug 2021 12:36:18 -0400 (EDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com
 [209.85.217.43])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 0206A4B0DD
 for <kvmarm@lists.cs.columbia.edu>; Fri, 27 Aug 2021 12:36:17 -0400 (EDT)
Received: by mail-vs1-f43.google.com with SMTP id s19so4992984vsl.11
 for <kvmarm@lists.cs.columbia.edu>; Fri, 27 Aug 2021 09:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nFiQiOvIx+N82BQ9SAa4EqJhljbHwhyIContW19g9yM=;
 b=s1HMejfaao0vwsGP3KWxN1+U1STZcYJMoZyVrKQxw287X5YwR0JNjWBO/S1ePp2Bkt
 IZBXm3iqfWky0F0/pb5U5TxQflwRChbs2g9TZiDHJ/sBrPbGC/r4TLP5Oitl+etVlEfF
 2JZfv9YH9cdZqrgecGth2UUDf+NbJDTFjlV9/m2hTzundVPuosV9Ww/UFCubyyx4Wgxc
 4NrooUqTDRkyySmfLgaxtNWexx9GL8kxfWLMR7qCH3npNmObazsFriSkUn1UUW0RoMZw
 svSu7XRV17JDYhJmxBsNH2+b2bdaOtHmFBWUxut7zqlseI3994VHzvqZQmkLWmqytsI9
 qE0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nFiQiOvIx+N82BQ9SAa4EqJhljbHwhyIContW19g9yM=;
 b=h/irg5ElV/BpGL89u67XV1l6dE7uPyT9OLPQlGegACLj1gMCfiRVZGRgWZEHqQDmU8
 BB854OEwY5O9suZtxryJPWUjHbb6+FPtuxyCLGUgZywTe613TOELsQNd7pdf2sdAQFvd
 QRJLCayrzb4o7pDjsKdjpb4r1pNpf5fv0lqaw6+htUOIXjg+UP6u2sfCsJLidwo3NIi2
 h89utCuQhrkQW9yjvp+wyjLsdDmNBCL/4TlIUrx+/t8nWNybjfgIHV0eGG6ONXJ8Bqhy
 IB6eagpf4U4A8XOn0dpC4tkT0OHFLv0GJ3jv4nT/sDySoB7pzol1CF0fmAV38zlsO55Z
 XCJA==
X-Gm-Message-State: AOAM532sgKfM0U9Z93CtaCz0rXM2YRDZfCYmE556B59kLSyXH6TVrOfS
 PjlyHOPm7+gjlWLBVEPYV8jgrqK7hT0pUImjJTkOPw==
X-Google-Smtp-Source: ABdhPJx5b3vmJR10GW0CjymdMn7zE7I/5iXMeBDau+XjdSADpsrI+k1EDhI3EcxhdDjZuuu3DQC8tegzH8BS9rKvTDA=
X-Received: by 2002:a05:6102:dd0:: with SMTP id
 e16mr7872617vst.7.1630082177278; 
 Fri, 27 Aug 2021 09:36:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210818184311.517295-1-rananta@google.com>
 <20210818184311.517295-11-rananta@google.com>
 <YSgNiY5iAI8BFN7G@google.com>
In-Reply-To: <YSgNiY5iAI8BFN7G@google.com>
From: Raghavendra Rao Ananta <rananta@google.com>
Date: Fri, 27 Aug 2021 09:36:05 -0700
Message-ID: <CAJHc60yde6-NqvpWKxFBsVP=q1DjK27270VOkyZyLTRx04K1iA@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] KVM: arm64: selftests: Add arch_timer test
To: Ricardo Koller <ricarkol@google.com>
Cc: kvm@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Peter Shier <pshier@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
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

On Thu, Aug 26, 2021 at 2:54 PM Ricardo Koller <ricarkol@google.com> wrote:
>
> On Wed, Aug 18, 2021 at 06:43:11PM +0000, Raghavendra Rao Ananta wrote:
> > Add a KVM selftest to validate the arch_timer functionality.
> > Primarily, the test sets up periodic timer interrupts and
> > validates the basic architectural expectations upon its receipt.
> >
> > The test provides command-line options to configure the period
> > of the timer, number of iterations, and number of vCPUs.
> >
> > Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> > ---
> >  tools/testing/selftests/kvm/.gitignore        |   1 +
> >  tools/testing/selftests/kvm/Makefile          |   1 +
> >  .../selftests/kvm/aarch64/arch_timer.c        | 382 ++++++++++++++++++
> >  3 files changed, 384 insertions(+)
> >  create mode 100644 tools/testing/selftests/kvm/aarch64/arch_timer.c
> >
> > diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
> > index 0709af0144c8..5f6cf0c76cf8 100644
> > --- a/tools/testing/selftests/kvm/.gitignore
> > +++ b/tools/testing/selftests/kvm/.gitignore
> > @@ -1,4 +1,5 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> > +/aarch64/arch_timer
> >  /aarch64/debug-exceptions
> >  /aarch64/get-reg-list
> >  /aarch64/vgic_init
> > diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> > index a170166334a3..62a2c3e4b50c 100644
> > --- a/tools/testing/selftests/kvm/Makefile
> > +++ b/tools/testing/selftests/kvm/Makefile
> > @@ -84,6 +84,7 @@ TEST_GEN_PROGS_x86_64 += set_memory_region_test
> >  TEST_GEN_PROGS_x86_64 += steal_time
> >  TEST_GEN_PROGS_x86_64 += kvm_binary_stats_test
> >
> > +TEST_GEN_PROGS_aarch64 += aarch64/arch_timer
> >  TEST_GEN_PROGS_aarch64 += aarch64/debug-exceptions
> >  TEST_GEN_PROGS_aarch64 += aarch64/get-reg-list
> >  TEST_GEN_PROGS_aarch64 += aarch64/vgic_init
> > diff --git a/tools/testing/selftests/kvm/aarch64/arch_timer.c b/tools/testing/selftests/kvm/aarch64/arch_timer.c
> > new file mode 100644
> > index 000000000000..88333fe1e567
> > --- /dev/null
> > +++ b/tools/testing/selftests/kvm/aarch64/arch_timer.c
> > @@ -0,0 +1,382 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * arch_timer.c - Tests the aarch64 timer IRQ functionality
> > + *
> > + * The test validates both the virtual and physical timer IRQs using
> > + * CVAL and TVAL registers. This consitutes the four stages in the test.
> > + * The guest's main thread configures the timer interrupt for a stage
> > + * and waits for it to fire, with a timeout equal to the timer period.
> > + * It asserts that the timeout doesn't exceed the timer period.
> > + *
> > + * On the other hand, upon receipt of an interrupt, the guest's interrupt
> > + * handler validates the interrupt by checking if the architectural state
> > + * is in compliance with the specifications.
> > + *
> > + * The test provides command-line options to configure the timer's
> > + * period (-p), number of vCPUs (-n), and iterations per stage (-i).
> > + *
> > + * Copyright (c) 2021, Google LLC.
> > + */
> > +
> > +#define _GNU_SOURCE
> > +
> > +#include <stdlib.h>
> > +#include <pthread.h>
> > +#include <linux/kvm.h>
> > +#include <linux/sizes.h>
> > +
> > +#include "kvm_util.h"
> > +#include "processor.h"
> > +#include "delay.h"
> > +#include "arch_timer.h"
> > +#include "gic.h"
> > +
> > +#define NR_VCPUS_DEF                 4
> > +#define NR_TEST_ITERS_DEF            5
> > +#define TIMER_TEST_PERIOD_MS_DEF     10
> > +#define TIMER_TEST_ERR_MARGIN_US     100
> > +
> > +struct test_args {
> > +     int nr_vcpus;
> > +     int nr_iter;
> > +     int timer_period_ms;
> > +};
> > +
> > +static struct test_args test_args = {
> > +     .nr_vcpus = NR_VCPUS_DEF,
> > +     .nr_iter = NR_TEST_ITERS_DEF,
> > +     .timer_period_ms = TIMER_TEST_PERIOD_MS_DEF,
> > +};
> > +
> > +#define msecs_to_usecs(msec)         ((msec) * 1000LL)
> > +
> > +#define VTIMER_IRQ                   27
> > +#define PTIMER_IRQ                   30
> > +
> > +#define REDIST_REGION_ATTR_ADDR(count, base, flags, index) \
> > +     (((uint64_t)(count) << 52) | \
> > +     ((uint64_t)((base) >> 16) << 16) | \
> > +     ((uint64_t)(flags) << 12) | \
> > +     index)
> > +
> > +#define GICD_BASE_GPA                        0x8000000ULL
> > +#define GICR_BASE_GPA                        0x80A0000ULL
> > +
> > +enum guest_stage {
> > +     GUEST_STAGE_VTIMER_CVAL = 1,
> > +     GUEST_STAGE_VTIMER_TVAL,
> > +     GUEST_STAGE_PTIMER_CVAL,
> > +     GUEST_STAGE_PTIMER_TVAL,
> > +     GUEST_STAGE_MAX,
> > +};
> > +
> > +/* Sahred variables between host and guest */
> > +struct test_vcpu_shared_data {
> > +     int nr_iter;
> > +     enum guest_stage guest_stage;
> > +     uint64_t xcnt;
> > +};
> > +
> > +struct test_vcpu {
> > +     uint32_t vcpuid;
> > +     pthread_t pt_vcpu_run;
> > +     struct kvm_vm *vm;
> > +};
> > +
> > +static struct test_vcpu test_vcpu[KVM_MAX_VCPUS];
> > +static struct test_vcpu_shared_data vcpu_shared_data[KVM_MAX_VCPUS];
> > +
> > +static void
> > +guest_configure_timer_action(struct test_vcpu_shared_data *shared_data)
> > +{
> > +     switch (shared_data->guest_stage) {
> > +     case GUEST_STAGE_VTIMER_CVAL:
> > +             timer_set_next_cval_ms(VIRTUAL, test_args.timer_period_ms);
> > +             shared_data->xcnt = timer_get_cntct(VIRTUAL);
> > +             timer_set_ctl(VIRTUAL, CTL_ENABLE);
> > +             break;
> > +     case GUEST_STAGE_VTIMER_TVAL:
> > +             timer_set_next_tval_ms(VIRTUAL, test_args.timer_period_ms);
> > +             shared_data->xcnt = timer_get_cntct(VIRTUAL);
> > +             timer_set_ctl(VIRTUAL, CTL_ENABLE);
> > +             break;
> > +     case GUEST_STAGE_PTIMER_CVAL:
> > +             timer_set_next_cval_ms(PHYSICAL, test_args.timer_period_ms);
> > +             shared_data->xcnt = timer_get_cntct(PHYSICAL);
> > +             timer_set_ctl(PHYSICAL, CTL_ENABLE);
> > +             break;
> > +     case GUEST_STAGE_PTIMER_TVAL:
> > +             timer_set_next_tval_ms(PHYSICAL, test_args.timer_period_ms);
> > +             shared_data->xcnt = timer_get_cntct(PHYSICAL);
> > +             timer_set_ctl(PHYSICAL, CTL_ENABLE);
> > +             break;
> > +     default:
> > +             GUEST_ASSERT(0);
> > +     }
> > +}
> > +
> > +static void guest_validate_irq(unsigned int intid,
> > +                             struct test_vcpu_shared_data *shared_data)
> > +{
> > +     enum guest_stage stage = shared_data->guest_stage;
> > +     uint64_t xcnt = 0, xcnt_diff_us, cval = 0;
> > +     unsigned long xctl = 0;
> > +     unsigned int timer_irq = 0;
> > +
> > +     if (stage == GUEST_STAGE_VTIMER_CVAL ||
> > +             stage == GUEST_STAGE_VTIMER_TVAL) {
> > +             xctl = timer_get_ctl(VIRTUAL);
> > +             timer_set_ctl(VIRTUAL, CTL_IMASK);
> > +             xcnt = timer_get_cntct(VIRTUAL);
> > +             cval = timer_get_cval(VIRTUAL);
> > +             timer_irq = VTIMER_IRQ;
> > +     } else if (stage == GUEST_STAGE_PTIMER_CVAL ||
> > +             stage == GUEST_STAGE_PTIMER_TVAL) {
> > +             xctl = timer_get_ctl(PHYSICAL);
> > +             timer_set_ctl(PHYSICAL, CTL_IMASK);
> > +             xcnt = timer_get_cntct(PHYSICAL);
> > +             cval = timer_get_cval(PHYSICAL);
> > +             timer_irq = PTIMER_IRQ;
> > +     } else {
> > +             GUEST_ASSERT(0);
> > +     }
> > +
> > +     xcnt_diff_us = cycles_to_usec(xcnt - shared_data->xcnt);
> > +
> > +     /* Make sure we are dealing with the correct timer IRQ */
> > +     GUEST_ASSERT_2(intid == timer_irq, intid, timer_irq);
> > +
> > +     /* Basic 'timer codition met' check */
> > +     GUEST_ASSERT_3(xcnt >= cval, xcnt, cval, xcnt_diff_us);
> > +     GUEST_ASSERT_1(xctl & CTL_ISTATUS, xctl);
> > +}
> > +
> > +static void guest_irq_handler(struct ex_regs *regs)
> > +{
> > +     unsigned int intid = gic_get_and_ack_irq();
> > +     uint32_t cpu = get_vcpuid();
> > +     struct test_vcpu_shared_data *shared_data = &vcpu_shared_data[cpu];
> > +
> > +     guest_validate_irq(intid, shared_data);
> > +
> > +     WRITE_ONCE(shared_data->nr_iter, shared_data->nr_iter + 1);
> > +
> > +     gic_set_eoi(intid);
> > +}
> > +
> > +static void guest_run_stage(struct test_vcpu_shared_data *shared_data,
> > +                             enum guest_stage stage)
> > +{
> > +     uint32_t irq_iter, config_iter;
> > +
> > +     shared_data->guest_stage = stage;
> > +     shared_data->nr_iter = 0;
> > +
> > +     for (config_iter = 0; config_iter < test_args.nr_iter; config_iter++) {
> > +             /* Setup the next interrupt */
> > +             guest_configure_timer_action(shared_data);
> > +
> > +             /* Setup a timeout for the interrupt to arrive */
> > +             udelay(msecs_to_usecs(test_args.timer_period_ms) +
> > +                     TIMER_TEST_ERR_MARGIN_US);
> > +
> > +             irq_iter = READ_ONCE(shared_data->nr_iter);
> > +             GUEST_ASSERT_2(config_iter + 1 == irq_iter,
> > +                             config_iter + 1, irq_iter);
> > +     };
> > +}
> > +
> > +static void guest_code(void)
> > +{
> > +     uint32_t cpu = get_vcpuid();
> > +     struct test_vcpu_shared_data *shared_data = &vcpu_shared_data[cpu];
> > +
> > +     local_irq_disable();
> > +
> > +     gic_init(GIC_V3, test_args.nr_vcpus,
> > +             (void *)GICD_BASE_GPA, (void *)GICR_BASE_GPA);
> > +
> > +     timer_set_ctl(VIRTUAL, CTL_IMASK);
> > +     timer_set_ctl(PHYSICAL, CTL_IMASK);
> > +
> > +     gic_irq_enable(VTIMER_IRQ);
> > +     gic_irq_enable(PTIMER_IRQ);
> > +     local_irq_enable();
> > +
> > +     guest_run_stage(shared_data, GUEST_STAGE_VTIMER_CVAL);
> > +     guest_run_stage(shared_data, GUEST_STAGE_VTIMER_TVAL);
> > +     guest_run_stage(shared_data, GUEST_STAGE_PTIMER_CVAL);
> > +     guest_run_stage(shared_data, GUEST_STAGE_PTIMER_TVAL);
> > +
> > +     GUEST_DONE();
> > +}
> > +
> > +static void *test_vcpu_run(void *arg)
> > +{
> > +     struct ucall uc;
> > +     struct test_vcpu *vcpu = arg;
> > +     struct kvm_vm *vm = vcpu->vm;
> > +     uint32_t vcpuid = vcpu->vcpuid;
> > +     struct test_vcpu_shared_data *shared_data = &vcpu_shared_data[vcpuid];
> > +
> > +     vcpu_run(vm, vcpuid);
> > +
> > +     switch (get_ucall(vm, vcpuid, &uc)) {
> > +     case UCALL_SYNC:
> > +     case UCALL_DONE:
> > +             break;
> > +     case UCALL_ABORT:
> > +             sync_global_from_guest(vm, *shared_data);
> > +             TEST_ASSERT(false,
> > +                     "%s at %s:%ld\n\tvalues: %lu, %lu; %lu, vcpu: %u; stage: %u; iter: %u",
> > +                     (const char *)uc.args[0], __FILE__, uc.args[1],
> > +                     uc.args[2], uc.args[3], uc.args[4], vcpuid,
> > +                     shared_data->guest_stage, shared_data->nr_iter);
> > +             break;
> > +     default:
> > +             TEST_FAIL("Unexpected guest exit\n");
> > +     }
> > +
> > +     return NULL;
> > +}
> > +
> > +static void test_run(struct kvm_vm *vm)
> > +{
> > +     int i, ret;
> > +
> > +     for (i = 0; i < test_args.nr_vcpus; i++) {
> > +             ret = pthread_create(&test_vcpu[i].pt_vcpu_run, NULL,
> > +                             test_vcpu_run, &test_vcpu[i]);
> > +             TEST_ASSERT(!ret, "Failed to create vCPU-%d pthread\n", i);
> > +     }
> > +
> > +     for (i = 0; i < test_args.nr_vcpus; i++)
> > +             pthread_join(test_vcpu[i].pt_vcpu_run, NULL);
> > +}
> > +
> > +static void test_vm_setup_gic(struct kvm_vm *vm, unsigned int n_gicr_pages)
>
> I think it's nicer if this takes nr_vcpus instead of gicr_pages.
>
> And, it possible, it would be doubly nice if it could be be made a
> library function (e.g., inside lib/aarch64/vgic.c?).
>
Yeah, great idea. I had the same suggestion from Reiji as well.

> > +{
> > +     uint64_t addr;
> > +     int gic_fd;
> > +
> > +     gic_fd = kvm_create_device(vm, KVM_DEV_TYPE_ARM_VGIC_V3, false);
> > +
> > +     addr = GICD_BASE_GPA;
> > +     kvm_device_access(gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
> > +                             KVM_VGIC_V3_ADDR_TYPE_DIST, &addr, true);
> > +     virt_pg_map(vm, GICD_BASE_GPA, GICD_BASE_GPA);
>
> Not really a big deal at the moment, but if KVM implemented ESPIs, then
> a 4k page wouldn't be enough. Why not map 64Ks as there's space for it?
>
Let's fix it while we are adding a new lib function.
> > +
> > +     addr = REDIST_REGION_ATTR_ADDR(test_args.nr_vcpus, GICR_BASE_GPA, 0, 0);
> > +     kvm_device_access(gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
> > +                     KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION, &addr, true);
> > +     virt_map(vm, GICR_BASE_GPA, GICR_BASE_GPA, n_gicr_pages);
> > +
> > +     kvm_device_access(gic_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
> > +                             KVM_DEV_ARM_VGIC_CTRL_INIT, NULL, true);
> > +}
> > +
> > +static struct kvm_vm *test_vm_create(void)
> > +{
> > +     struct kvm_vm *vm;
> > +     unsigned int i, n_gicr_pages;
> > +     int nr_vcpus = test_args.nr_vcpus;
> > +
> > +     /* Reserve additional pages for GICR MMIO based on nr_vcpus */
> > +     n_gicr_pages = vm_calc_num_guest_pages(VM_MODE_DEFAULT,
> > +                                             2 * SZ_64K * nr_vcpus);
>
> Might be better to use vm_get_page_size instead as it doesn't need the
> mode arg. Note that you would have to call it after creating the vm
> (vm_create..), but the nice thing is that that call uses the actual mode
> that the vm was created with. I propose moving this pages calculation to
> inside test_vm_setup_gic, which could take the number of vcpus as an arg
> (instead of nr_pages).
>
My idea was to reserve all the pages that we need in one go and the fact that
we know that we'd be creating a VM in a 'default' mode. But now that we are
moving to a lib function, I'll move the logic there.

Thanks for the suggestions.

Regards,
Raghavendra
> > +
> > +     vm = vm_create_default_with_vcpus(nr_vcpus, n_gicr_pages, 0,
> > +                                             guest_code, NULL);
> > +
> > +     vm_init_descriptor_tables(vm);
> > +     vm_install_exception_handler(vm, VECTOR_IRQ_CURRENT, guest_irq_handler);
> > +
> > +     for (i = 0; i < nr_vcpus; i++) {
> > +             vcpu_init_descriptor_tables(vm, i);
> > +
> > +             test_vcpu[i].vcpuid = i;
> > +             test_vcpu[i].vm = vm;
> > +     }
> > +
> > +     ucall_init(vm, NULL);
> > +     test_vm_setup_gic(vm, n_gicr_pages);
> > +
> > +     /* Make all the test's cmdline args visible to the guest */
> > +     sync_global_to_guest(vm, test_args);
> > +
> > +     return vm;
> > +}
> > +
> > +static void test_print_help(char *name)
> > +{
> > +     pr_info("Usage: %s [-h] [-n nr_vcpus] [-i iterations] [-p timer_period_ms]\n",
> > +             name);
> > +     pr_info("\t-n: Number of vCPUs to configure (default: %u; max: %u)\n",
> > +             NR_VCPUS_DEF, KVM_MAX_VCPUS);
> > +     pr_info("\t-i: Number of iterations per stage (default: %u)\n",
> > +             NR_TEST_ITERS_DEF);
> > +     pr_info("\t-p: Periodicity (in ms) of the guest timer (default: %u)\n",
> > +             TIMER_TEST_PERIOD_MS_DEF);
> > +     pr_info("\t-h: print this help screen\n");
> > +}
> > +
> > +static bool parse_args(int argc, char *argv[])
> > +{
> > +     int opt;
> > +
> > +     while ((opt = getopt(argc, argv, "hn:i:p:")) != -1) {
> > +             switch (opt) {
> > +             case 'n':
> > +                     test_args.nr_vcpus = atoi(optarg);
> > +                     if (test_args.nr_vcpus <= 0) {
> > +                             pr_info("Positive value needed for -n\n");
> > +                             goto err;
> > +                     } else if (test_args.nr_vcpus > KVM_MAX_VCPUS) {
> > +                             pr_info("Max allowed vCPUs: %u\n",
> > +                                     KVM_MAX_VCPUS);
> > +                             goto err;
> > +                     }
> > +                     break;
> > +             case 'i':
> > +                     test_args.nr_iter = atoi(optarg);
> > +                     if (test_args.nr_iter <= 0) {
> > +                             pr_info("Positive value needed for -i\n");
> > +                             goto err;
> > +                     }
> > +                     break;
> > +             case 'p':
> > +                     test_args.timer_period_ms = atoi(optarg);
> > +                     if (test_args.timer_period_ms <= 0) {
> > +                             pr_info("Positive value needed for -p\n");
> > +                             goto err;
> > +                     }
> > +                     break;
> > +             case 'h':
> > +             default:
> > +                     goto err;
> > +             }
> > +     }
> > +
> > +     return true;
> > +
> > +err:
> > +     test_print_help(argv[0]);
> > +     return false;
> > +}
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +     struct kvm_vm *vm;
> > +
> > +     /* Tell stdout not to buffer its content */
> > +     setbuf(stdout, NULL);
> > +
> > +     if (!parse_args(argc, argv))
> > +             exit(KSFT_SKIP);
> > +
> > +     vm = test_vm_create();
> > +     test_run(vm);
> > +     kvm_vm_free(vm);
> > +
> > +     return 0;
> > +}
> > --
> > 2.33.0.rc1.237.g0d66db33f3-goog
> >
>
> Thanks,
> Ricardo
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
