Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 616374DE2FA
	for <lists+kvmarm@lfdr.de>; Fri, 18 Mar 2022 21:54:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A6EA449F09;
	Fri, 18 Mar 2022 16:54:36 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.788
X-Spam-Level: 
X-Spam-Status: No, score=-1.788 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ORW2N4xyrdqn; Fri, 18 Mar 2022 16:54:36 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E03C149E57;
	Fri, 18 Mar 2022 16:54:34 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6665340C52
 for <kvmarm@lists.cs.columbia.edu>; Fri, 18 Mar 2022 16:54:33 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OlWosTKE1+e4 for <kvmarm@lists.cs.columbia.edu>;
 Fri, 18 Mar 2022 16:54:31 -0400 (EDT)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A32964076C
 for <kvmarm@lists.cs.columbia.edu>; Fri, 18 Mar 2022 16:54:31 -0400 (EDT)
Received: by mail-pg1-f176.google.com with SMTP id bc27so5834958pgb.4
 for <kvmarm@lists.cs.columbia.edu>; Fri, 18 Mar 2022 13:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=3LFCvUO6+UIda2BmSoPhc0rSyFVg8Hx+1ToRaMaHtdA=;
 b=UEtrAit45+IakYtTYUf7AEnm9t/ruyFtCm1WQxiruHS//72eSLlCnrE8TJhM6mZurW
 e9hTbacpzc3FM/u6Rblb1Ippm9d7EqwfXCRrJGKJnzsiaf76T4x78KQhRZ7gs0SFktEV
 /fIYmUtRqknSIjz8Bygbx/Fn7QiuNhBPZkHz4l7Lo/e86cBGv4IkbD6PgVY+L2IZfAks
 3+ojqda0Z1+SHQ28yTKFw17uYbPsQ2+X4XFQakBasFLDCRbwa+ceuL3UZTOjARmUJfH3
 bZnqyhDjFcwPAClKdR9EZCu8kolEi/uHZh0NCI4GyoWysv5TmjyuOLjNsr22ToVd2hwD
 2VeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3LFCvUO6+UIda2BmSoPhc0rSyFVg8Hx+1ToRaMaHtdA=;
 b=Uf1YVffVExEAv3S5Zfg5U7SUHl3gICtQ2hzz5D1+N1Q1pWScpWz+vIaU1moJqmTrpP
 EmuQDGJTUFO9saWliU98MuohIRAevSUdckoTa9bmekozALxNTm5pAZN+qL3k+Yf571Fy
 PJS7WyYmFulA9XEbJenFY5lh0WQ4y63opxy53GPY8sbfwiOqwk28euqcEtU+jTrI3TIr
 fh+Lcs5+2pImcC1C43ghqrJ64mWR7+PgcYIrefQJcKZSm3FTXCijlbVushfXPexoUzXH
 75pOkljNHMzcLDqenhqDFRMJa0Rrtc/WiEWeQT/X3bn5GfKI+JcEHdQCmn2SriKQYBm8
 XA9w==
X-Gm-Message-State: AOAM531v2zUlZ0bPRDlbKbXz/P3+f9i042jPGxLeUiv18JqBgasR5wPi
 nrHQuJw5LPt8Foy6kRm2Ffwdaw==
X-Google-Smtp-Source: ABdhPJzBNKKIB+jPsUPpZDO5y9raTfoyurP7/cjRuTSregxme0ISNRDrDIYT+nVp1296oQ+M8HcRPQ==
X-Received: by 2002:a63:7:0:b0:37f:fa5b:95f9 with SMTP id
 7-20020a630007000000b0037ffa5b95f9mr9419514pga.57.1647636870387; 
 Fri, 18 Mar 2022 13:54:30 -0700 (PDT)
Received: from google.com (150.12.83.34.bc.googleusercontent.com.
 [34.83.12.150]) by smtp.gmail.com with ESMTPSA id
 w21-20020a634755000000b00368f3ba336dsm8219326pgk.88.2022.03.18.13.54.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Mar 2022 13:54:29 -0700 (PDT)
Date: Fri, 18 Mar 2022 13:54:26 -0700
From: Ricardo Koller <ricarkol@google.com>
To: Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v2 3/3] KVM: arm64: selftests: add edge cases tests into
 arch_timer_edge_cases
Message-ID: <YjTxgnwNaXfeerSw@google.com>
References: <20220317045127.124602-1-ricarkol@google.com>
 <20220317045127.124602-4-ricarkol@google.com>
 <YjLi9t5yRTNdyhFA@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YjLi9t5yRTNdyhFA@google.com>
Cc: kvm@vger.kernel.org, maz@kernel.org, pbonzini@redhat.com,
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

On Thu, Mar 17, 2022 at 07:27:50AM +0000, Oliver Upton wrote:
> Hi Ricardo,
> 
> On Wed, Mar 16, 2022 at 09:51:27PM -0700, Ricardo Koller wrote:
> > Add tests that validates some edge cases related to the virtual
> > arch-timer:
> > - timers in the past, including TVALs that rollover from 0.
> > - timers across counter roll-overs.
> > - moving counters ahead and behind pending timers.
> > - reprograming timers.
> > - the same timer condition firing multiple times.
> > - masking/unmasking using the timer control mask.
> > 
> > Reviewed-by: Reiji Watanabe <reijiw@google.com>
> > Signed-off-by: Ricardo Koller <ricarkol@google.com>
> > ---
> >  .../kvm/aarch64/arch_timer_edge_cases.c       | 329 +++++++++++++++++-
> >  1 file changed, 326 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/kvm/aarch64/arch_timer_edge_cases.c b/tools/testing/selftests/kvm/aarch64/arch_timer_edge_cases.c
> > index dc399482e35d..0eeb72767bea 100644
> > --- a/tools/testing/selftests/kvm/aarch64/arch_timer_edge_cases.c
> > +++ b/tools/testing/selftests/kvm/aarch64/arch_timer_edge_cases.c
> > @@ -2,6 +2,12 @@
> >  /*
> >   * arch_timer_edge_cases.c - Tests the aarch64 timer IRQ functionality.
> >   *
> > + * The test validates some edge cases related to the virtual arch-timer:
> > + * - timers across counter roll-overs.
> > + * - moving counters ahead and behind pending timers.
> > + * - reprograming timers.
> > + * - the same timer condition firing multiple times.
> > + *
> >   * Some of these tests program timers and then wait indefinitely for them to
> >   * fire.  We rely on having a timeout mechanism in the "runner", like
> >   * tools/testing/selftests/kselftest/runner.sh.
> > @@ -47,6 +53,9 @@
> >  /* Number of runs. */
> >  #define NR_TEST_ITERS_DEF		5
> >  
> > +/* Default "long" wait test time in ms. */
> > +#define LONG_WAIT_TEST_MS		100
> > +
> >  /* Shared with IRQ handler. */
> >  volatile struct test_vcpu_shared_data {
> >  	int handled;
> > @@ -55,6 +64,8 @@ volatile struct test_vcpu_shared_data {
> >  struct test_args {
> >  	/* Virtual or physical timer and counter tests. */
> >  	enum arch_timer timer;
> > +	/* Delay used in the test_long_timer_delays test. */
> > +	uint64_t long_wait_ms;
> >  	/* Number of iterations. */
> >  	int iterations;
> >  };
> > @@ -62,6 +73,7 @@ struct test_args {
> >  struct test_args test_args = {
> >  	/* Only testing VIRTUAL timers for now. */
> >  	.timer = VIRTUAL,
> > +	.long_wait_ms = LONG_WAIT_TEST_MS,
> >  	.iterations = NR_TEST_ITERS_DEF,
> >  };
> >  
> > @@ -69,10 +81,25 @@ static int vtimer_irq, ptimer_irq;
> >  
> >  enum sync_cmd {
> >  	SET_REG_KVM_REG_ARM_TIMER_CNT,
> > +	USERSPACE_USLEEP,
> >  	USERSPACE_SCHED_YIELD,
> >  	USERSPACE_MIGRATE_SELF,
> >  };
> >  
> > +typedef void (*sleep_method_t)(uint64_t usec);
> > +
> > +static void sleep_poll(uint64_t usec);
> > +static void sleep_sched_poll(uint64_t usec);
> > +static void sleep_in_userspace(uint64_t usec);
> > +static void sleep_migrate(uint64_t usec);
> > +
> > +sleep_method_t sleep_method[] = {
> > +	sleep_poll,
> > +	sleep_sched_poll,
> > +	sleep_migrate,
> > +	sleep_in_userspace,
> > +};
> > +
> >  typedef void (*wait_method_t)(void);
> >  
> >  static void wait_for_non_spurious_irq(void);
> > @@ -125,6 +152,9 @@ static uint32_t next_pcpu(void)
> >  #define USERSPACE_MIGRATE_VCPU()						\
> >  	USERSPACE_CMD(USERSPACE_MIGRATE_SELF)
> >  
> > +#define SLEEP_IN_USERSPACE(__usecs)						\
> > +	GUEST_SYNC_ARGS(USERSPACE_USLEEP, (__usecs), 0, 0, 0)
> > +
> >  static void guest_irq_handler(struct ex_regs *regs)
> >  {
> >  	unsigned int intid = gic_get_and_ack_irq();
> > @@ -227,6 +257,60 @@ static void wait_migrate_poll_for_irq(void)
> >  	poll_for_non_spurious_irq(true, USERSPACE_MIGRATE_SELF);
> >  }
> >  
> > +/*
> > + * Sleep for usec microseconds by polling in the guest (userspace=0) or in
> > + * userspace (e.g., userspace=1 and userspace_cmd=USERSPACE_SCHEDULE).
> > + */
> > +static void guest_poll(enum arch_timer timer, uint64_t usec,
> > +		bool userspace, enum sync_cmd userspace_cmd)
> > +{
> > +	uint64_t cycles = usec_to_cycles(usec);
> > +	uint64_t start = timer_get_cntct(timer);
> > +
> > +	/*
> > +	 * TODO: Take care of roll-overs. Right now, we are fine as we use the
> > +	 * virtual timer/counter for all of our roll-over tests, and so we can use
> > +	 * the physical counter for this function. Assert this (temporarily):
> > +	 */
> > +	GUEST_ASSERT(test_args.timer == VIRTUAL && timer == PHYSICAL);
> > +
> > +	while ((timer_get_cntct(timer) - start) < cycles) {
> > +		if (userspace)
> > +			USERSPACE_CMD(userspace_cmd);
> > +		else
> > +			cpu_relax();
> > +	}
> > +}
> > +
> > +static void sleep_poll(uint64_t usec)
> > +{
> > +	if (test_args.timer == VIRTUAL)
> > +		guest_poll(PHYSICAL, usec, false, -1);
> > +	else
> > +		GUEST_ASSERT(0); /* Not implemented. */
> > +}
> > +
> > +static void sleep_sched_poll(uint64_t usec)
> > +{
> > +	if (test_args.timer == VIRTUAL)
> > +		guest_poll(PHYSICAL, usec, true, USERSPACE_SCHED_YIELD);
> > +	else
> > +		GUEST_ASSERT(0); /* Not implemented. */
> > +}
> > +
> > +static void sleep_migrate(uint64_t usec)
> > +{
> > +	if (test_args.timer == VIRTUAL)
> > +		guest_poll(PHYSICAL, usec, true, USERSPACE_MIGRATE_SELF);
> > +	else
> > +		GUEST_ASSERT(0); /* Not implemented. */
> > +}
> 
> It may be worth mentioning that you're polling the counter that is *not*
> under test. I presume you do this so your sleep implementation is not
> affected by the test manipulations to the virtual counter.
> 
> > +static void sleep_in_userspace(uint64_t usec)
> > +{
> > +	SLEEP_IN_USERSPACE(usec);
> > +}
> > +
> >  /*
> >   * Reset the timer state to some nice values like the counter not being close
> >   * to the edge, and the control register masked and disabled.
> > @@ -251,6 +335,156 @@ static void test_timer(uint64_t reset_cnt, uint64_t xval,
> >  	local_irq_enable();
> >  }
> >  
> > +/*
> > + * Set the counter to just below the edge (CVAL_MAX) and set a timer that
> > + * crosses it over.
> > + */
> > +static void test_timers_across_rollovers(void)
> > +{
> > +	uint64_t edge_minus_5ms = CVAL_MAX - msec_to_cycles(5);
> > +	int i;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(wait_method); i++) {
> > +		wait_method_t wm = wait_method[i];
> > +
> > +		test_timer(edge_minus_5ms, msec_to_cycles(10), wm, TIMER_TVAL);
> > +		test_timer(edge_minus_5ms, TVAL_MAX, wm, TIMER_TVAL);
> > +		test_timer(edge_minus_5ms, TVAL_MIN, wm, TIMER_TVAL);
> > +	}
> > +}
> > +
> > +/* Check that timer control masks actually mask a timer being fired. */
> > +static void test_timer_control_masked(sleep_method_t guest_sleep)
> > +{
> > +	reset_timer_state(DEF_CNT);
> > +
> > +	/* Local IRQs are not masked at this point. */
> > +
> > +	program_timer_irq(-1, CTL_ENABLE | CTL_IMASK, TIMER_TVAL);
> > +
> > +	/* Assume no IRQ after waiting TIMEOUT_NO_IRQ_US microseconds */
> > +	guest_sleep(TIMEOUT_NO_IRQ_US);
> > +
> > +	ASSERT_IRQS_HANDLED(0);
> > +	timer_set_ctl(test_args.timer, CTL_IMASK);
> > +}
> > +
> > +/* Test masking/unmasking a timer using the timer mask (not the IRQ mask). */
> > +static void test_timer_control_mask_then_unmask(wait_method_t wm)
> > +{
> > +	reset_timer_state(DEF_CNT);
> > +	program_timer_irq(-1, CTL_ENABLE | CTL_IMASK, TIMER_TVAL);
> > +
> > +	/* No IRQs because the timer is still masked. */
> > +	ASSERT_IRQS_HANDLED(0);
> > +
> > +	/* Unmask the timer, and then get an IRQ. */
> > +	local_irq_disable();
> > +	timer_set_ctl(test_args.timer, CTL_ENABLE);
> > +	wm();
> > +
> > +	ASSERT_IRQS_HANDLED(1);
> > +	local_irq_enable();
> > +}
> > +
> > +/*
> > + * Set a timer at the edge, and wait with irqs masked for so long that the
> > + * counter rolls over and the "Timer Condition" doesn't apply anymore.  We
> > + * should still get an IRQ.
> 
> It looks like the test asserts we do not get an interrupt if the timer
> condtion is no longer valid.
> 
> > + */
> > +static void test_irq_masked_timer_across_rollover(sleep_method_t guest_sleep)
> > +{
> > +	local_irq_disable();
> > +	reset_timer_state(CVAL_MAX - msec_to_cycles(5));
> > +
> > +	program_timer_irq(-1, CTL_ENABLE, TIMER_TVAL);
> > +
> > +	GUEST_ASSERT(timer_get_ctl(test_args.timer) & CTL_ISTATUS);
> > +	guest_sleep(msecs_to_usecs(10));
> > +	GUEST_ASSERT((timer_get_ctl(test_args.timer) & CTL_ISTATUS) == 0);
> > +
> > +	local_irq_enable();
> > +	isb();
> > +
> > +	ASSERT_IRQS_HANDLED(0);
> > +}
> > +
> > +static void test_control_masks(void)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(sleep_method); i++)
> > +		test_timer_control_masked(sleep_method[i]);
> > +
> > +	for (i = 0; i < ARRAY_SIZE(wait_method); i++)
> > +		test_timer_control_mask_then_unmask(wait_method[i]);
> > +
> > +	for (i = 0; i < ARRAY_SIZE(sleep_method); i++)
> > +		test_irq_masked_timer_across_rollover(sleep_method[i]);
> > +}
> > +
> > +static void test_fire_a_timer_multiple_times(wait_method_t wm, int num)
> > +{
> > +	int i;
> > +
> > +	local_irq_disable();
> > +	reset_timer_state(DEF_CNT);
> > +
> > +	program_timer_irq(0, CTL_ENABLE, TIMER_TVAL);
> > +
> > +	for (i = 1; i <= num; i++) {
> > +		wm();
> > +
> > +		/*
> > +		 * The IRQ handler masked and disabled the timer.
> > +		 * Enable and unmmask it again.
> > +		 */
> > +		timer_set_ctl(test_args.timer, CTL_ENABLE);
> > +
> > +		ASSERT_IRQS_HANDLED(i);
> > +	}
> > +
> > +	local_irq_enable();
> > +}
> > +
> > +static void test_timers_fired_multiple_times(void)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(wait_method); i++)
> > +		test_fire_a_timer_multiple_times(wait_method[i], 1000);
> > +}
> > +
> > +/* Set a timer for cval1 then reprogram it to cval1. */
> 
> reprogram it to cval2
> 
> > +static void test_reprogram_timer(wait_method_t wm, bool use_sched,
> > +		uint64_t cnt, uint64_t cval1, uint64_t cval2)
> > +{
> > +	local_irq_disable();
> > +	reset_timer_state(cnt);
> > +
> > +	program_timer_irq(cval1, CTL_ENABLE, TIMER_CVAL);
> > +
> > +	if (use_sched)
> > +		USERSPACE_SCHEDULE();
> > +
> > +	timer_set_cval(test_args.timer, cval2);
> > +
> > +	wm();
> > +
> > +	local_irq_enable();
> > +	ASSERT_IRQS_HANDLED(1);
> > +};
> > +
> > +static void test_reprogram_timers(void)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(wait_method); i++) {
> > +		test_reprogram_timer(wait_method[i], true, 0, CVAL_MAX, 0);
> > +		test_reprogram_timer(wait_method[i], true, 0, CVAL_MAX, 0);
> > +	}
> > +}
> > +
> >  static void test_basic_functionality(void)
> >  {
> >  	int32_t tval = (int32_t)msec_to_cycles(10);
> > @@ -306,7 +540,7 @@ static void timers_sanity_checks(bool use_sched)
> >  	if (use_sched)
> >  		USERSPACE_SCHEDULE();
> >  	/* We just need 1 cycle to pass. */
> > -	isb();
> > +	sleep_poll(1);
> 
> Ah, this is exactly what I was asking for in patch 2. Is it possible to
> hoist the needed pieces into that patch so you always poll CNTPCT before
> reaching the assertion?
> 
> --
> Thanks,
> Oliver

ACK on all the comments. Will send a v3.

Thanks,
Ricardo

> 
> >  	GUEST_ASSERT(timer_get_tval(test_args.timer) < 0);
> >  
> >  	local_irq_enable();
> > @@ -322,10 +556,86 @@ static void test_timers_sanity_checks(void)
> >  	timers_sanity_checks(true);
> >  }
> >  
> > +/*
> > + * Set the counter to cnt_1, the [c|t]val to xval, the counter to cnt_2, and
> > + * then wait for an IRQ.
> > + */
> > +static void test_set_counter_after_programming_timer(uint64_t cnt_1,
> > +		uint64_t xval, uint64_t cnt_2, wait_method_t wm,
> > +		enum timer_view tv)
> > +{
> > +	local_irq_disable();
> > +
> > +	SET_COUNTER(cnt_1, test_args.timer);
> > +	timer_set_ctl(test_args.timer, CTL_IMASK);
> > +
> > +	program_timer_irq(xval, CTL_ENABLE, tv);
> > +	SET_COUNTER(cnt_2, test_args.timer);
> > +	wm();
> > +
> > +	ASSERT_IRQS_HANDLED(1);
> > +	local_irq_enable();
> > +}
> > +
> > +/* Set a timer and then move the counter ahead of it. */
> > +static void test_move_counters_after_timers(void)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(wait_method); i++) {
> > +		wait_method_t wm = wait_method[i];
> > +
> > +		test_set_counter_after_programming_timer(0, DEF_CNT,
> > +				DEF_CNT + 1, wm, TIMER_CVAL);
> > +		test_set_counter_after_programming_timer(CVAL_MAX, 1,
> > +				2, wm, TIMER_CVAL);
> > +		test_set_counter_after_programming_timer(0, TVAL_MAX,
> > +				(uint64_t)TVAL_MAX + 1, wm, TIMER_TVAL);
> > +	}
> > +}
> > +
> > +static void test_timers_in_the_past(void)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(wait_method); i++) {
> > +		wait_method_t wm = wait_method[i];
> > +
> > +		test_timer(DEF_CNT, DEF_CNT - 1, wm, TIMER_CVAL);
> > +		test_timer(DEF_CNT, TVAL_MIN, wm, TIMER_TVAL);
> > +		test_timer(CVAL_MAX, 0, wm, TIMER_CVAL);
> > +		test_timer(DEF_CNT, 0, wm, TIMER_CVAL);
> > +		test_timer(DEF_CNT, 0, wm, TIMER_TVAL);
> > +	}
> > +}
> > +
> > +static void test_long_timer_delays(void)
> > +{
> > +	uint64_t wait_ms = test_args.long_wait_ms;
> > +	int i;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(wait_method); i++) {
> > +		wait_method_t wm = wait_method[i];
> > +
> > +		test_timer(0, msec_to_cycles(wait_ms), wm, TIMER_CVAL);
> > +		test_timer(0, msec_to_cycles(wait_ms), wm, TIMER_TVAL);
> > +	}
> > +}
> > +
> >  static void guest_run_iteration(void)
> >  {
> >  	test_timers_sanity_checks();
> >  	test_basic_functionality();
> > +
> > +	test_timers_in_the_past();
> > +	test_timers_across_rollovers();
> > +
> > +	test_move_counters_after_timers();
> > +	test_reprogram_timers();
> > +
> > +	test_control_masks();
> > +
> > +	test_timers_fired_multiple_times();
> >  }
> >  
> >  static void guest_code(void)
> > @@ -348,6 +658,7 @@ static void guest_code(void)
> >  		guest_run_iteration();
> >  	}
> >  
> > +	test_long_timer_delays();
> >  	GUEST_DONE();
> >  }
> >  
> > @@ -420,6 +731,9 @@ static void handle_sync(struct kvm_vm *vm, struct ucall *uc)
> >  	case SET_REG_KVM_REG_ARM_TIMER_CNT:
> >  		kvm_set_cntxct(vm, val, timer);
> >  		break;
> > +	case USERSPACE_USLEEP:
> > +		usleep(val);
> > +		break;
> >  	case USERSPACE_SCHED_YIELD:
> >  		sched_yield();
> >  		break;
> > @@ -503,11 +817,13 @@ static struct kvm_vm *test_vm_create(void)
> >  
> >  static void test_print_help(char *name)
> >  {
> > -	pr_info("Usage: %s [-h] [-i iterations] [-w] [-p pcpu1,pcpu2]\n",
> > +	pr_info("Usage: %s [-h] [-i iterations] [-p pcpu1,pcpu2] [-l long_wait_ms]\n",
> >  		name);
> >  	pr_info("\t-i: Number of iterations (default: %u)\n",
> >  		NR_TEST_ITERS_DEF);
> >  	pr_info("\t-p: Pair of pcpus for the vcpus to alternate between.\n");
> > +	pr_info("\t-l: Delta (in ms) used for long wait time test (default: %u)\n",
> > +		LONG_WAIT_TEST_MS);
> >  	pr_info("\t-h: Print this help message\n");
> >  }
> >  
> > @@ -515,7 +831,7 @@ static bool parse_args(int argc, char *argv[])
> >  {
> >  	int opt, ret;
> >  
> > -	while ((opt = getopt(argc, argv, "hi:p:")) != -1) {
> > +	while ((opt = getopt(argc, argv, "hi:p:l:")) != -1) {
> >  		switch (opt) {
> >  		case 'i':
> >  			test_args.iterations = atoi(optarg);
> > @@ -531,6 +847,13 @@ static bool parse_args(int argc, char *argv[])
> >  				goto err;
> >  			}
> >  			break;
> > +		case 'l':
> > +			test_args.long_wait_ms = atoi(optarg);
> > +			if (test_args.long_wait_ms <= 0) {
> > +				pr_info("Positive value needed for -l\n");
> > +				goto err;
> > +			}
> > +			break;
> >  		case 'h':
> >  		default:
> >  			goto err;
> > -- 
> > 2.35.1.723.g4982287a31-goog
> > 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
