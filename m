Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 417234042E3
	for <lists+kvmarm@lfdr.de>; Thu,  9 Sep 2021 03:39:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DFED94A500;
	Wed,  8 Sep 2021 21:39:04 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xuvonwErHdcI; Wed,  8 Sep 2021 21:39:03 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 39E214B139;
	Wed,  8 Sep 2021 21:39:03 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 372384B0C5
 for <kvmarm@lists.cs.columbia.edu>; Wed,  8 Sep 2021 21:39:02 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8TYqEhSrZUEt for <kvmarm@lists.cs.columbia.edu>;
 Wed,  8 Sep 2021 21:39:00 -0400 (EDT)
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com
 [209.85.219.202])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 93EC34B150
 for <kvmarm@lists.cs.columbia.edu>; Wed,  8 Sep 2021 21:39:00 -0400 (EDT)
Received: by mail-yb1-f202.google.com with SMTP id
 w8-20020a259188000000b0059bf0bed21fso365395ybl.18
 for <kvmarm@lists.cs.columbia.edu>; Wed, 08 Sep 2021 18:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=sYTxHN81HWMAWBMAFZhe/sBotYuafYXFEVQNuf++Zyk=;
 b=CZkgM1KvY1RtgLndtA4z5zG6o9zRio6jUnseBA4J9aQaDsS9LSL2T9hmLrQqLtJBq0
 QU4EhMnTrBCR6wQ8PMC7bsbBYasH/np893hGbPpOO0HFTqMh1rW26FOKEDSE+efrN4cQ
 X6dMtgvzxHdEpJOgNXc3pC/b0voWJj04VJ6P7/Ahxyq1dv7E6LmPyPDoVO82J4FWVqR9
 fjZf30HLy4+vpndb7CBl5ZRlgZ6htzPQCYy492hP6GV0rXVigT8b8BDB4AioUWlF6SXM
 vBT9qGfkn7NI6AF370hs+NPqPQzMAp/ZFhGcJngCgs8LcRlLchuGkZMSjoGe62ctnycm
 ZO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=sYTxHN81HWMAWBMAFZhe/sBotYuafYXFEVQNuf++Zyk=;
 b=12eW5jQJj1x0NlkauUjXBkTxq6tWJH3R1S7ZKfPx3ItAwJAHfEVIcBUxWCtRjgJyzV
 fbdWDqvMUtOpzQbM680JV1BO7QQjMTW3dkNsegvWFGLxFn2XrdLF8kr1RSyU8p3Ixv95
 ElFM8pr9sqrIk6wqvIMdVbvUZ9oCp2RUptQewyoarDVFGAL00gHxfLIF31xsUZ91UtBc
 37J7mu655Ct13A/McF//3L1cvidQr8c6rC5O4/ztTm5DhVPzIw/A2Xt939HMVMlx2YHX
 dLsTBiMJNL/73O8VMNtGRgWT5ubFCscZZFlZ+FAKvwV+trDlO9WLFAyLOnmKe3U2DV1n
 SaFg==
X-Gm-Message-State: AOAM530aLA2hhvXVIxj8ldD/H/p3VPMET3nMjEmDDt3yFOs4NOCT5tif
 wbOzTHn8d4qzXPZ7BgF6vsNgo+/a7EI/
X-Google-Smtp-Source: ABdhPJw+iR1R9CLVQISCK6O802kcPpf/id9xwgcaBNvySgPG88ZksEML2Pm/W6UIxu7SRhrY7mnYspcLWv+j
X-Received: from rananta-virt.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:1bcc])
 (user=rananta job=sendgmr) by 2002:a25:2cd5:: with SMTP id
 s204mr545043ybs.137.1631151540206; Wed, 08 Sep 2021 18:39:00 -0700 (PDT)
Date: Thu,  9 Sep 2021 01:38:15 +0000
In-Reply-To: <20210909013818.1191270-1-rananta@google.com>
Message-Id: <20210909013818.1191270-16-rananta@google.com>
Mime-Version: 1.0
References: <20210909013818.1191270-1-rananta@google.com>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
Subject: [PATCH v4 15/18] KVM: arm64: selftests: Add arch_timer test
From: Raghavendra Rao Ananta <rananta@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
 Andrew Jones <drjones@redhat.com>, James Morse <james.morse@arm.com>, 
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Peter Shier <pshier@google.com>, linux-kernel@vger.kernel.org,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
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

Add a KVM selftest to validate the arch_timer functionality.
Primarily, the test sets up periodic timer interrupts and
validates the basic architectural expectations upon its receipt.

The test provides command-line options to configure the period
of the timer, number of iterations, and number of vCPUs.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
---
 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/aarch64/arch_timer.c        | 351 ++++++++++++++++++
 3 files changed, 353 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/aarch64/arch_timer.c

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index 98053d3afbda..c6058df0cd18 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
+/aarch64/arch_timer
 /aarch64/debug-exceptions
 /aarch64/get-reg-list
 /aarch64/psci_cpu_on_test
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 8342f65c1d96..46d43e706b20 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -84,6 +84,7 @@ TEST_GEN_PROGS_x86_64 += set_memory_region_test
 TEST_GEN_PROGS_x86_64 += steal_time
 TEST_GEN_PROGS_x86_64 += kvm_binary_stats_test
 
+TEST_GEN_PROGS_aarch64 += aarch64/arch_timer
 TEST_GEN_PROGS_aarch64 += aarch64/debug-exceptions
 TEST_GEN_PROGS_aarch64 += aarch64/get-reg-list
 TEST_GEN_PROGS_aarch64 += aarch64/psci_cpu_on_test
diff --git a/tools/testing/selftests/kvm/aarch64/arch_timer.c b/tools/testing/selftests/kvm/aarch64/arch_timer.c
new file mode 100644
index 000000000000..6141c387e6dc
--- /dev/null
+++ b/tools/testing/selftests/kvm/aarch64/arch_timer.c
@@ -0,0 +1,351 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * arch_timer.c - Tests the aarch64 timer IRQ functionality
+ *
+ * The test validates both the virtual and physical timer IRQs using
+ * CVAL and TVAL registers. This consitutes the four stages in the test.
+ * The guest's main thread configures the timer interrupt for a stage
+ * and waits for it to fire, with a timeout equal to the timer period.
+ * It asserts that the timeout doesn't exceed the timer period.
+ *
+ * On the other hand, upon receipt of an interrupt, the guest's interrupt
+ * handler validates the interrupt by checking if the architectural state
+ * is in compliance with the specifications.
+ *
+ * The test provides command-line options to configure the timer's
+ * period (-p), number of vCPUs (-n), and iterations per stage (-i).
+ *
+ * Copyright (c) 2021, Google LLC.
+ */
+
+#define _GNU_SOURCE
+
+#include <stdlib.h>
+#include <pthread.h>
+#include <linux/kvm.h>
+#include <linux/sizes.h>
+
+#include "kvm_util.h"
+#include "processor.h"
+#include "delay.h"
+#include "arch_timer.h"
+#include "gic.h"
+#include "vgic.h"
+
+#define NR_VCPUS_DEF			4
+#define NR_TEST_ITERS_DEF		5
+#define TIMER_TEST_PERIOD_MS_DEF	10
+#define TIMER_TEST_ERR_MARGIN_US	100
+
+struct test_args {
+	int nr_vcpus;
+	int nr_iter;
+	int timer_period_ms;
+};
+
+static struct test_args test_args = {
+	.nr_vcpus = NR_VCPUS_DEF,
+	.nr_iter = NR_TEST_ITERS_DEF,
+	.timer_period_ms = TIMER_TEST_PERIOD_MS_DEF,
+};
+
+#define msecs_to_usecs(msec)		((msec) * 1000LL)
+
+#define VTIMER_IRQ			27
+#define PTIMER_IRQ			30
+
+#define GICD_BASE_GPA			0x8000000ULL
+#define GICR_BASE_GPA			0x80A0000ULL
+
+enum guest_stage {
+	GUEST_STAGE_VTIMER_CVAL = 1,
+	GUEST_STAGE_VTIMER_TVAL,
+	GUEST_STAGE_PTIMER_CVAL,
+	GUEST_STAGE_PTIMER_TVAL,
+	GUEST_STAGE_MAX,
+};
+
+/* Shared variables between host and guest */
+struct test_vcpu_shared_data {
+	int nr_iter;
+	enum guest_stage guest_stage;
+	uint64_t xcnt;
+};
+
+struct test_vcpu {
+	uint32_t vcpuid;
+	pthread_t pt_vcpu_run;
+	struct kvm_vm *vm;
+};
+
+static struct test_vcpu test_vcpu[KVM_MAX_VCPUS];
+static struct test_vcpu_shared_data vcpu_shared_data[KVM_MAX_VCPUS];
+
+static void
+guest_configure_timer_action(struct test_vcpu_shared_data *shared_data)
+{
+	switch (shared_data->guest_stage) {
+	case GUEST_STAGE_VTIMER_CVAL:
+		timer_set_next_cval_ms(VIRTUAL, test_args.timer_period_ms);
+		shared_data->xcnt = timer_get_cntct(VIRTUAL);
+		timer_set_ctl(VIRTUAL, CTL_ENABLE);
+		break;
+	case GUEST_STAGE_VTIMER_TVAL:
+		timer_set_next_tval_ms(VIRTUAL, test_args.timer_period_ms);
+		shared_data->xcnt = timer_get_cntct(VIRTUAL);
+		timer_set_ctl(VIRTUAL, CTL_ENABLE);
+		break;
+	case GUEST_STAGE_PTIMER_CVAL:
+		timer_set_next_cval_ms(PHYSICAL, test_args.timer_period_ms);
+		shared_data->xcnt = timer_get_cntct(PHYSICAL);
+		timer_set_ctl(PHYSICAL, CTL_ENABLE);
+		break;
+	case GUEST_STAGE_PTIMER_TVAL:
+		timer_set_next_tval_ms(PHYSICAL, test_args.timer_period_ms);
+		shared_data->xcnt = timer_get_cntct(PHYSICAL);
+		timer_set_ctl(PHYSICAL, CTL_ENABLE);
+		break;
+	default:
+		GUEST_ASSERT(0);
+	}
+}
+
+static void guest_validate_irq(unsigned int intid,
+				struct test_vcpu_shared_data *shared_data)
+{
+	enum guest_stage stage = shared_data->guest_stage;
+	uint64_t xcnt = 0, xcnt_diff_us, cval = 0;
+	unsigned long xctl = 0;
+	unsigned int timer_irq = 0;
+
+	if (stage == GUEST_STAGE_VTIMER_CVAL ||
+		stage == GUEST_STAGE_VTIMER_TVAL) {
+		xctl = timer_get_ctl(VIRTUAL);
+		timer_set_ctl(VIRTUAL, CTL_IMASK);
+		xcnt = timer_get_cntct(VIRTUAL);
+		cval = timer_get_cval(VIRTUAL);
+		timer_irq = VTIMER_IRQ;
+	} else if (stage == GUEST_STAGE_PTIMER_CVAL ||
+		stage == GUEST_STAGE_PTIMER_TVAL) {
+		xctl = timer_get_ctl(PHYSICAL);
+		timer_set_ctl(PHYSICAL, CTL_IMASK);
+		xcnt = timer_get_cntct(PHYSICAL);
+		cval = timer_get_cval(PHYSICAL);
+		timer_irq = PTIMER_IRQ;
+	} else {
+		GUEST_ASSERT(0);
+	}
+
+	xcnt_diff_us = cycles_to_usec(xcnt - shared_data->xcnt);
+
+	/* Make sure we are dealing with the correct timer IRQ */
+	GUEST_ASSERT_2(intid == timer_irq, intid, timer_irq);
+
+	/* Basic 'timer condition met' check */
+	GUEST_ASSERT_3(xcnt >= cval, xcnt, cval, xcnt_diff_us);
+	GUEST_ASSERT_1(xctl & CTL_ISTATUS, xctl);
+}
+
+static void guest_irq_handler(struct ex_regs *regs)
+{
+	unsigned int intid = gic_get_and_ack_irq();
+	uint32_t cpu = get_vcpuid();
+	struct test_vcpu_shared_data *shared_data = &vcpu_shared_data[cpu];
+
+	guest_validate_irq(intid, shared_data);
+
+	WRITE_ONCE(shared_data->nr_iter, shared_data->nr_iter + 1);
+
+	gic_set_eoi(intid);
+}
+
+static void guest_run_stage(struct test_vcpu_shared_data *shared_data,
+				enum guest_stage stage)
+{
+	uint32_t irq_iter, config_iter;
+
+	shared_data->guest_stage = stage;
+	shared_data->nr_iter = 0;
+
+	for (config_iter = 0; config_iter < test_args.nr_iter; config_iter++) {
+		/* Setup the next interrupt */
+		guest_configure_timer_action(shared_data);
+
+		/* Setup a timeout for the interrupt to arrive */
+		udelay(msecs_to_usecs(test_args.timer_period_ms) +
+			TIMER_TEST_ERR_MARGIN_US);
+
+		irq_iter = READ_ONCE(shared_data->nr_iter);
+		GUEST_ASSERT_2(config_iter + 1 == irq_iter,
+				config_iter + 1, irq_iter);
+	}
+}
+
+static void guest_code(void)
+{
+	uint32_t cpu = get_vcpuid();
+	struct test_vcpu_shared_data *shared_data = &vcpu_shared_data[cpu];
+
+	local_irq_disable();
+
+	gic_init(GIC_V3, test_args.nr_vcpus,
+		(void *)GICD_BASE_GPA, (void *)GICR_BASE_GPA);
+
+	timer_set_ctl(VIRTUAL, CTL_IMASK);
+	timer_set_ctl(PHYSICAL, CTL_IMASK);
+
+	gic_irq_enable(VTIMER_IRQ);
+	gic_irq_enable(PTIMER_IRQ);
+	local_irq_enable();
+
+	guest_run_stage(shared_data, GUEST_STAGE_VTIMER_CVAL);
+	guest_run_stage(shared_data, GUEST_STAGE_VTIMER_TVAL);
+	guest_run_stage(shared_data, GUEST_STAGE_PTIMER_CVAL);
+	guest_run_stage(shared_data, GUEST_STAGE_PTIMER_TVAL);
+
+	GUEST_DONE();
+}
+
+static void *test_vcpu_run(void *arg)
+{
+	struct ucall uc;
+	struct test_vcpu *vcpu = arg;
+	struct kvm_vm *vm = vcpu->vm;
+	uint32_t vcpuid = vcpu->vcpuid;
+	struct test_vcpu_shared_data *shared_data = &vcpu_shared_data[vcpuid];
+
+	vcpu_run(vm, vcpuid);
+
+	switch (get_ucall(vm, vcpuid, &uc)) {
+	case UCALL_SYNC:
+	case UCALL_DONE:
+		break;
+	case UCALL_ABORT:
+		sync_global_from_guest(vm, *shared_data);
+		TEST_FAIL("%s at %s:%ld\n\tvalues: %lu, %lu; %lu, vcpu: %u; stage: %u; iter: %u",
+			(const char *)uc.args[0], __FILE__, uc.args[1],
+			uc.args[2], uc.args[3], uc.args[4], vcpuid,
+			shared_data->guest_stage, shared_data->nr_iter);
+		break;
+	default:
+		TEST_FAIL("Unexpected guest exit\n");
+	}
+
+	return NULL;
+}
+
+static void test_run(struct kvm_vm *vm)
+{
+	int i, ret;
+
+	for (i = 0; i < test_args.nr_vcpus; i++) {
+		ret = pthread_create(&test_vcpu[i].pt_vcpu_run, NULL,
+				test_vcpu_run, &test_vcpu[i]);
+		TEST_ASSERT(!ret, "Failed to create vCPU-%d pthread\n", i);
+	}
+
+	for (i = 0; i < test_args.nr_vcpus; i++)
+		pthread_join(test_vcpu[i].pt_vcpu_run, NULL);
+}
+
+static struct kvm_vm *test_vm_create(void)
+{
+	struct kvm_vm *vm;
+	unsigned int i;
+	int nr_vcpus = test_args.nr_vcpus;
+
+	vm = vm_create_default_with_vcpus(nr_vcpus, 0, 0, guest_code, NULL);
+
+	vm_init_descriptor_tables(vm);
+	vm_install_exception_handler(vm, VECTOR_IRQ_CURRENT, guest_irq_handler);
+
+	for (i = 0; i < nr_vcpus; i++) {
+		vcpu_init_descriptor_tables(vm, i);
+
+		test_vcpu[i].vcpuid = i;
+		test_vcpu[i].vm = vm;
+	}
+
+	ucall_init(vm, NULL);
+	vm_vcpuid_map_init(vm);
+	vgic_v3_setup(vm, GICD_BASE_GPA, GICR_BASE_GPA);
+
+	/* Make all the test's cmdline args visible to the guest */
+	sync_global_to_guest(vm, test_args);
+
+	return vm;
+}
+
+static void test_print_help(char *name)
+{
+	pr_info("Usage: %s [-h] [-n nr_vcpus] [-i iterations] [-p timer_period_ms]\n",
+		name);
+	pr_info("\t-n: Number of vCPUs to configure (default: %u; max: %u)\n",
+		NR_VCPUS_DEF, KVM_MAX_VCPUS);
+	pr_info("\t-i: Number of iterations per stage (default: %u)\n",
+		NR_TEST_ITERS_DEF);
+	pr_info("\t-p: Periodicity (in ms) of the guest timer (default: %u)\n",
+		TIMER_TEST_PERIOD_MS_DEF);
+	pr_info("\t-h: print this help screen\n");
+}
+
+static bool parse_args(int argc, char *argv[])
+{
+	int opt;
+
+	while ((opt = getopt(argc, argv, "hn:i:p:")) != -1) {
+		switch (opt) {
+		case 'n':
+			test_args.nr_vcpus = atoi(optarg);
+			if (test_args.nr_vcpus <= 0) {
+				pr_info("Positive value needed for -n\n");
+				goto err;
+			} else if (test_args.nr_vcpus > KVM_MAX_VCPUS) {
+				pr_info("Max allowed vCPUs: %u\n",
+					KVM_MAX_VCPUS);
+				goto err;
+			}
+			break;
+		case 'i':
+			test_args.nr_iter = atoi(optarg);
+			if (test_args.nr_iter <= 0) {
+				pr_info("Positive value needed for -i\n");
+				goto err;
+			}
+			break;
+		case 'p':
+			test_args.timer_period_ms = atoi(optarg);
+			if (test_args.timer_period_ms <= 0) {
+				pr_info("Positive value needed for -p\n");
+				goto err;
+			}
+			break;
+		case 'h':
+		default:
+			goto err;
+		}
+	}
+
+	return true;
+
+err:
+	test_print_help(argv[0]);
+	return false;
+}
+
+int main(int argc, char *argv[])
+{
+	struct kvm_vm *vm;
+
+	/* Tell stdout not to buffer its content */
+	setbuf(stdout, NULL);
+
+	if (!parse_args(argc, argv))
+		exit(KSFT_SKIP);
+
+	vm = test_vm_create();
+	test_run(vm);
+	kvm_vm_free(vm);
+
+	return 0;
+}
-- 
2.33.0.153.gba50c8fa24-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
