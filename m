Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3E34E44FB
	for <lists+kvmarm@lfdr.de>; Tue, 22 Mar 2022 18:23:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BABD449EF1;
	Tue, 22 Mar 2022 13:23:36 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.788
X-Spam-Level: 
X-Spam-Status: No, score=-1.788 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mqPHUVhYsW9f; Tue, 22 Mar 2022 13:23:36 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8D20B49F2F;
	Tue, 22 Mar 2022 13:23:33 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 15A0649F27
 for <kvmarm@lists.cs.columbia.edu>; Tue, 22 Mar 2022 13:23:32 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DAEWQ+12i-iB for <kvmarm@lists.cs.columbia.edu>;
 Tue, 22 Mar 2022 13:23:30 -0400 (EDT)
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com
 [209.85.216.74])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 628FA49EF1
 for <kvmarm@lists.cs.columbia.edu>; Tue, 22 Mar 2022 13:23:30 -0400 (EDT)
Received: by mail-pj1-f74.google.com with SMTP id
 nr19-20020a17090b241300b001c6f8baf45eso1599358pjb.0
 for <kvmarm@lists.cs.columbia.edu>; Tue, 22 Mar 2022 10:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=jj1C5+9XaTs/lVlBaXMQH0LmOh3QVqhUhKOqof5ZYnY=;
 b=NMPcY3UqQPGc22qpqNT4ULqIZ5AElIe0iEN+hMskUIG7yNYqFkeNN818aYbgG2/MTn
 uq1Xp6fZvhn1N+LoWEsDvAtA7pIKZuMyad5IeO7UftSB0jnSAYHPG34ZYjGGX/mV7YyS
 Uu391aFGWdDxqVWi3aEtufjJPU3decBVZZ+h3S0BtFBfIf/3YK2509o8VDdhyUY6mrGj
 opeY/GILqj65AcmSNmd1esQ/YAR6Vg8QgcNa+M9Tu3u37rdd53JAApA6twubTH4atlhX
 u+VQEbmd8DYPDL1/mlk6RBjH1YDeNfB9w1y5QlI09uoSm43QHNf+XrqtM2eqjtKumOub
 bP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=jj1C5+9XaTs/lVlBaXMQH0LmOh3QVqhUhKOqof5ZYnY=;
 b=lEb1RpwyjG/KAnFThUlCHh47M3BsR+86zxWFVs5j3vKTKo4kLnwC/uCbNY6fDAXG+3
 6MvCmhQt9VUTrjgWDqVTe5kryVe2zDKVVBSJHNez/5CWfHmJQFkzxeWWbzLzmPJXF3AQ
 RvuPQdhoq/6XRVXIewjIeg/CPRKy//M438oD+GjlPwX4d9LxU1/p7UUjkjPhX2VxCW2l
 hfMEskAldi+/O2e+uNJ2DTfbemo8JTvQwzkCWLikccNFhLAeabpPDCu9oKnYppolgWTI
 ufDmCibSd3tmuYy5weKAgR0/PxuYz0LsCXi7IMu8iVEDpHVvDxl/odvpiWsTQ5QOW18U
 E/ug==
X-Gm-Message-State: AOAM5326WkUpiEHM/RuN/zruJhdJc9rAWKutU8z82AWSoR+qaVUUvlTG
 0/4Upp+kVDLpDv/9KGjtHAqhuVM+ISk14Q==
X-Google-Smtp-Source: ABdhPJxOIT4aHZ/IL38KBsIwUNlHPg8CPQx5nZYsC+4JU8k+AwR5VYJF60WMzCwVW/+TY+bajCmDdS8xAMZL/w==
X-Received: from ricarkol2.c.googlers.com
 ([fda3:e722:ac3:cc00:24:72f4:c0a8:62fe])
 (user=ricarkol job=sendgmr) by 2002:a17:902:d488:b0:154:6df6:1e81 with SMTP
 id c8-20020a170902d48800b001546df61e81mr8198200plg.105.1647969809633; Tue, 22
 Mar 2022 10:23:29 -0700 (PDT)
Date: Tue, 22 Mar 2022 10:23:19 -0700
In-Reply-To: <20220322172319.2943101-1-ricarkol@google.com>
Message-Id: <20220322172319.2943101-5-ricarkol@google.com>
Mime-Version: 1.0
References: <20220322172319.2943101-1-ricarkol@google.com>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [PATCH v3 4/4] KVM: arm64: selftests: add edge cases tests into
 arch_timer_edge_cases
From: Ricardo Koller <ricarkol@google.com>
To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, drjones@redhat.com
Cc: maz@kernel.org, pbonzini@redhat.com
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

Add tests that validates some edge cases related to the virtual
arch-timer:
- timers in the past, including TVALs that rollover from 0.
- timers across counter roll-overs.
- moving counters ahead and behind pending timers.
- reprograming timers.
- the same timer condition firing multiple times.
- masking/unmasking using the timer control mask.

Reviewed-by: Reiji Watanabe <reijiw@google.com>
Signed-off-by: Ricardo Koller <ricarkol@google.com>
---
 .../kvm/aarch64/arch_timer_edge_cases.c       | 300 +++++++++++++++++-
 1 file changed, 298 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/arch_timer_edge_cases.c b/tools/testing/selftests/kvm/aarch64/arch_timer_edge_cases.c
index 56376eea1a51..2575d8c70f1e 100644
--- a/tools/testing/selftests/kvm/aarch64/arch_timer_edge_cases.c
+++ b/tools/testing/selftests/kvm/aarch64/arch_timer_edge_cases.c
@@ -2,6 +2,12 @@
 /*
  * arch_timer_edge_cases.c - Tests the aarch64 timer IRQ functionality.
  *
+ * The test validates some edge cases related to the virtual arch-timer:
+ * - timers across counter roll-overs.
+ * - moving counters ahead and behind pending timers.
+ * - reprograming timers.
+ * - the same timer condition firing multiple times.
+ *
  * Some of these tests program timers and then wait indefinitely for them to
  * fire.  We rely on having a timeout mechanism in the "runner", like
  * tools/testing/selftests/kselftest/runner.sh.
@@ -45,6 +51,9 @@
 /* Number of runs. */
 #define NR_TEST_ITERS_DEF		5
 
+/* Default "long" wait test time in ms. */
+#define LONG_WAIT_TEST_MS		100
+
 /* Shared with IRQ handler. */
 volatile struct test_vcpu_shared_data {
 	int handled;
@@ -53,6 +62,8 @@ volatile struct test_vcpu_shared_data {
 struct test_args {
 	/* Virtual or physical timer and counter tests. */
 	enum arch_timer timer;
+	/* Delay used in the test_long_timer_delays test. */
+	uint64_t long_wait_ms;
 	/* Number of iterations. */
 	int iterations;
 };
@@ -60,6 +71,7 @@ struct test_args {
 struct test_args test_args = {
 	/* Only testing VIRTUAL timers for now. */
 	.timer = VIRTUAL,
+	.long_wait_ms = LONG_WAIT_TEST_MS,
 	.iterations = NR_TEST_ITERS_DEF,
 };
 
@@ -67,10 +79,25 @@ static int vtimer_irq, ptimer_irq;
 
 enum sync_cmd {
 	SET_REG_KVM_REG_ARM_TIMER_CNT,
+	USERSPACE_USLEEP,
 	USERSPACE_SCHED_YIELD,
 	USERSPACE_MIGRATE_SELF,
 };
 
+typedef void (*sleep_method_t)(uint64_t usec);
+
+static void sleep_poll(uint64_t usec);
+static void sleep_sched_poll(uint64_t usec);
+static void sleep_in_userspace(uint64_t usec);
+static void sleep_migrate(uint64_t usec);
+
+sleep_method_t sleep_method[] = {
+	sleep_poll,
+	sleep_sched_poll,
+	sleep_migrate,
+	sleep_in_userspace,
+};
+
 typedef void (*wait_method_t)(void);
 
 static void wait_for_non_spurious_irq(void);
@@ -123,6 +150,9 @@ static uint32_t next_pcpu(void)
 #define USERSPACE_MIGRATE_VCPU()						\
 	USERSPACE_CMD(USERSPACE_MIGRATE_SELF)
 
+#define SLEEP_IN_USERSPACE(__usecs)						\
+	GUEST_SYNC_ARGS(USERSPACE_USLEEP, (__usecs), 0, 0, 0)
+
 static void guest_irq_handler(struct ex_regs *regs)
 {
 	unsigned int intid = gic_get_and_ack_irq();
@@ -260,6 +290,33 @@ static void wait_migrate_poll_for_irq(void)
 	poll_for_non_spurious_irq(true, USERSPACE_MIGRATE_SELF);
 }
 
+/*
+ * Both sleep_sched_poll and sleep_migrate temporarily check that the timer in
+ * use (test_args.timer) is the virtual one. That's because the sleep
+ * implementation polls on the physical one.
+ */
+
+static void sleep_sched_poll(uint64_t usec)
+{
+	if (test_args.timer == VIRTUAL)
+		guest_poll(PHYSICAL, usec, true, USERSPACE_SCHED_YIELD);
+	else
+		GUEST_ASSERT(0); /* Not implemented. */
+}
+
+static void sleep_migrate(uint64_t usec)
+{
+	if (test_args.timer == VIRTUAL)
+		guest_poll(PHYSICAL, usec, true, USERSPACE_MIGRATE_SELF);
+	else
+		GUEST_ASSERT(0); /* Not implemented. */
+}
+
+static void sleep_in_userspace(uint64_t usec)
+{
+	SLEEP_IN_USERSPACE(usec);
+}
+
 /*
  * Reset the timer state to some nice values like the counter not being close
  * to the edge, and the control register masked and disabled.
@@ -284,6 +341,156 @@ static void test_timer(uint64_t reset_cnt, uint64_t xval,
 	local_irq_enable();
 }
 
+/*
+ * Set the counter to just below the edge (CVAL_MAX) and set a timer that
+ * crosses it over.
+ */
+static void test_timers_across_rollovers(void)
+{
+	uint64_t edge_minus_5ms = CVAL_MAX - msec_to_cycles(5);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(wait_method); i++) {
+		wait_method_t wm = wait_method[i];
+
+		test_timer(edge_minus_5ms, msec_to_cycles(10), wm, TIMER_TVAL);
+		test_timer(edge_minus_5ms, TVAL_MAX, wm, TIMER_TVAL);
+		test_timer(edge_minus_5ms, TVAL_MIN, wm, TIMER_TVAL);
+	}
+}
+
+/* Check that timer control masks actually mask a timer being fired. */
+static void test_timer_control_masked(sleep_method_t guest_sleep)
+{
+	reset_timer_state(DEF_CNT);
+
+	/* Local IRQs are not masked at this point. */
+
+	program_timer_irq(-1, CTL_ENABLE | CTL_IMASK, TIMER_TVAL);
+
+	/* Assume no IRQ after waiting TIMEOUT_NO_IRQ_US microseconds */
+	guest_sleep(TIMEOUT_NO_IRQ_US);
+
+	ASSERT_IRQS_HANDLED(0);
+	timer_set_ctl(test_args.timer, CTL_IMASK);
+}
+
+/* Test masking/unmasking a timer using the timer mask (not the IRQ mask). */
+static void test_timer_control_mask_then_unmask(wait_method_t wm)
+{
+	reset_timer_state(DEF_CNT);
+	program_timer_irq(-1, CTL_ENABLE | CTL_IMASK, TIMER_TVAL);
+
+	/* No IRQs because the timer is still masked. */
+	ASSERT_IRQS_HANDLED(0);
+
+	/* Unmask the timer, and then get an IRQ. */
+	local_irq_disable();
+	timer_set_ctl(test_args.timer, CTL_ENABLE);
+	wm();
+
+	ASSERT_IRQS_HANDLED(1);
+	local_irq_enable();
+}
+
+/*
+ * Set a timer at the edge, and wait with irqs masked for so long that the
+ * counter rolls over and the "Timer Condition" doesn't apply anymore.  We
+ * should not get an IRQ fired.
+ */
+static void test_irq_masked_timer_across_rollover(sleep_method_t guest_sleep)
+{
+	local_irq_disable();
+	reset_timer_state(CVAL_MAX - msec_to_cycles(5));
+
+	program_timer_irq(-1, CTL_ENABLE, TIMER_TVAL);
+
+	GUEST_ASSERT(timer_get_ctl(test_args.timer) & CTL_ISTATUS);
+	guest_sleep(10 * 1000LL);
+	GUEST_ASSERT((timer_get_ctl(test_args.timer) & CTL_ISTATUS) == 0);
+
+	local_irq_enable();
+	isb();
+
+	ASSERT_IRQS_HANDLED(0);
+}
+
+static void test_control_masks(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(sleep_method); i++)
+		test_timer_control_masked(sleep_method[i]);
+
+	for (i = 0; i < ARRAY_SIZE(wait_method); i++)
+		test_timer_control_mask_then_unmask(wait_method[i]);
+
+	for (i = 0; i < ARRAY_SIZE(sleep_method); i++)
+		test_irq_masked_timer_across_rollover(sleep_method[i]);
+}
+
+static void test_fire_a_timer_multiple_times(wait_method_t wm, int num)
+{
+	int i;
+
+	local_irq_disable();
+	reset_timer_state(DEF_CNT);
+
+	program_timer_irq(0, CTL_ENABLE, TIMER_TVAL);
+
+	for (i = 1; i <= num; i++) {
+		wm();
+
+		/*
+		 * The IRQ handler masked and disabled the timer.
+		 * Enable and unmmask it again.
+		 */
+		timer_set_ctl(test_args.timer, CTL_ENABLE);
+
+		ASSERT_IRQS_HANDLED(i);
+	}
+
+	local_irq_enable();
+}
+
+static void test_timers_fired_multiple_times(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(wait_method); i++)
+		test_fire_a_timer_multiple_times(wait_method[i], 1000);
+}
+
+/* Set a timer for cval1 then reprogram it to cval2. */
+static void test_reprogram_timer(wait_method_t wm, bool use_sched,
+		uint64_t cnt, uint64_t cval1, uint64_t cval2)
+{
+	local_irq_disable();
+	reset_timer_state(cnt);
+
+	program_timer_irq(cval1, CTL_ENABLE, TIMER_CVAL);
+
+	if (use_sched)
+		USERSPACE_SCHEDULE();
+
+	timer_set_cval(test_args.timer, cval2);
+
+	wm();
+
+	local_irq_enable();
+	ASSERT_IRQS_HANDLED(1);
+};
+
+static void test_reprogram_timers(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(wait_method); i++) {
+		test_reprogram_timer(wait_method[i], true, 0, CVAL_MAX, 0);
+		test_reprogram_timer(wait_method[i], true, 0, CVAL_MAX, 0);
+	}
+}
+
 static void test_basic_functionality(void)
 {
 	int32_t tval = (int32_t)msec_to_cycles(10);
@@ -355,10 +562,86 @@ static void test_timers_sanity_checks(void)
 	timers_sanity_checks(true);
 }
 
+/*
+ * Set the counter to cnt_1, the [c|t]val to xval, the counter to cnt_2, and
+ * then wait for an IRQ.
+ */
+static void test_set_counter_after_programming_timer(uint64_t cnt_1,
+		uint64_t xval, uint64_t cnt_2, wait_method_t wm,
+		enum timer_view tv)
+{
+	local_irq_disable();
+
+	SET_COUNTER(cnt_1, test_args.timer);
+	timer_set_ctl(test_args.timer, CTL_IMASK);
+
+	program_timer_irq(xval, CTL_ENABLE, tv);
+	SET_COUNTER(cnt_2, test_args.timer);
+	wm();
+
+	ASSERT_IRQS_HANDLED(1);
+	local_irq_enable();
+}
+
+/* Set a timer and then move the counter ahead of it. */
+static void test_move_counters_after_timers(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(wait_method); i++) {
+		wait_method_t wm = wait_method[i];
+
+		test_set_counter_after_programming_timer(0, DEF_CNT,
+				DEF_CNT + 1, wm, TIMER_CVAL);
+		test_set_counter_after_programming_timer(CVAL_MAX, 1,
+				2, wm, TIMER_CVAL);
+		test_set_counter_after_programming_timer(0, TVAL_MAX,
+				(uint64_t)TVAL_MAX + 1, wm, TIMER_TVAL);
+	}
+}
+
+static void test_timers_in_the_past(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(wait_method); i++) {
+		wait_method_t wm = wait_method[i];
+
+		test_timer(DEF_CNT, DEF_CNT - 1, wm, TIMER_CVAL);
+		test_timer(DEF_CNT, TVAL_MIN, wm, TIMER_TVAL);
+		test_timer(CVAL_MAX, 0, wm, TIMER_CVAL);
+		test_timer(DEF_CNT, 0, wm, TIMER_CVAL);
+		test_timer(DEF_CNT, 0, wm, TIMER_TVAL);
+	}
+}
+
+static void test_long_timer_delays(void)
+{
+	uint64_t wait_ms = test_args.long_wait_ms;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(wait_method); i++) {
+		wait_method_t wm = wait_method[i];
+
+		test_timer(0, msec_to_cycles(wait_ms), wm, TIMER_CVAL);
+		test_timer(0, msec_to_cycles(wait_ms), wm, TIMER_TVAL);
+	}
+}
+
 static void guest_run_iteration(void)
 {
 	test_timers_sanity_checks();
 	test_basic_functionality();
+
+	test_timers_in_the_past();
+	test_timers_across_rollovers();
+
+	test_move_counters_after_timers();
+	test_reprogram_timers();
+
+	test_control_masks();
+
+	test_timers_fired_multiple_times();
 }
 
 static void guest_code(void)
@@ -381,6 +664,7 @@ static void guest_code(void)
 		guest_run_iteration();
 	}
 
+	test_long_timer_delays();
 	GUEST_DONE();
 }
 
@@ -450,6 +734,9 @@ static void handle_sync(struct kvm_vm *vm, struct ucall *uc)
 	case SET_REG_KVM_REG_ARM_TIMER_CNT:
 		kvm_set_cntxct(vm, val, timer);
 		break;
+	case USERSPACE_USLEEP:
+		usleep(val);
+		break;
 	case USERSPACE_SCHED_YIELD:
 		sched_yield();
 		break;
@@ -533,11 +820,13 @@ static struct kvm_vm *test_vm_create(void)
 
 static void test_print_help(char *name)
 {
-	pr_info("Usage: %s [-h] [-i iterations] [-w] [-p pcpu1,pcpu2]\n",
+	pr_info("Usage: %s [-h] [-i iterations] [-p pcpu1,pcpu2] [-l long_wait_ms]\n",
 		name);
 	pr_info("\t-i: Number of iterations (default: %u)\n",
 		NR_TEST_ITERS_DEF);
 	pr_info("\t-p: Pair of pcpus for the vcpus to alternate between.\n");
+	pr_info("\t-l: Delta (in ms) used for long wait time test (default: %u)\n",
+		LONG_WAIT_TEST_MS);
 	pr_info("\t-h: Print this help message\n");
 }
 
@@ -545,7 +834,7 @@ static bool parse_args(int argc, char *argv[])
 {
 	int opt, ret;
 
-	while ((opt = getopt(argc, argv, "hi:p:")) != -1) {
+	while ((opt = getopt(argc, argv, "hi:p:l:")) != -1) {
 		switch (opt) {
 		case 'i':
 			test_args.iterations = atoi(optarg);
@@ -569,6 +858,13 @@ static bool parse_args(int argc, char *argv[])
 				goto err;
 			}
 			break;
+		case 'l':
+			test_args.long_wait_ms = atoi(optarg);
+			if (test_args.long_wait_ms <= 0) {
+				print_skip("Positive value needed for -l");
+				goto err;
+			}
+			break;
 		case 'h':
 		default:
 			goto err;
-- 
2.35.1.894.gb6a874cedc-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
