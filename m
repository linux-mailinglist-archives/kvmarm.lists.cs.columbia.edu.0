Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 76259E4F93
	for <lists+kvmarm@lfdr.de>; Fri, 25 Oct 2019 16:52:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 231914A618;
	Fri, 25 Oct 2019 10:52:34 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 84dG8Gmks-hy; Fri, 25 Oct 2019 10:52:32 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A408E4A86D;
	Fri, 25 Oct 2019 10:52:32 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C6AA44A656
 for <kvmarm@lists.cs.columbia.edu>; Fri, 25 Oct 2019 10:52:31 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yADHtvemddro for <kvmarm@lists.cs.columbia.edu>;
 Fri, 25 Oct 2019 10:52:30 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7E6674A618
 for <kvmarm@lists.cs.columbia.edu>; Fri, 25 Oct 2019 10:52:30 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36E8F28;
 Fri, 25 Oct 2019 07:52:30 -0700 (PDT)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.20])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE86C3F71A;
 Fri, 25 Oct 2019 07:52:28 -0700 (PDT)
From: Andrew Murray <andrew.murray@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v1 3/3] arm64: perf: Add support for ARMv8.5-PMU 64-bit
 counters
Date: Fri, 25 Oct 2019 15:52:19 +0100
Message-Id: <20191025145219.28350-4-andrew.murray@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191025145219.28350-1-andrew.murray@arm.com>
References: <20191025145219.28350-1-andrew.murray@arm.com>
MIME-Version: 1.0
Cc: kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

At present ARMv8 event counters are limited to 32-bits, though by
using the CHAIN event it's possible to combine adjacent counters to
achieve 64-bits. The perf config1:0 bit can be set to use such a
configuration.

With the introduction of ARMv8.5-PMU support, all event counters can
now be used as 64-bit counters.

Let's enable 64-bit event counters where support exists. Unless the
user sets config1:0 we will adjust the counter value such that it
overflows upon 32-bit overflow. This follows the same behaviour as
the cycle counter which has always been (and remains) 64-bits.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 arch/arm64/include/asm/perf_event.h |  3 +-
 arch/arm64/kernel/perf_event.c      | 86 +++++++++++++++++++++++------
 include/linux/perf/arm_pmu.h        |  1 +
 3 files changed, 72 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/include/asm/perf_event.h b/arch/arm64/include/asm/perf_event.h
index 2bdbc79bbd01..e7765b62c712 100644
--- a/arch/arm64/include/asm/perf_event.h
+++ b/arch/arm64/include/asm/perf_event.h
@@ -176,9 +176,10 @@
 #define ARMV8_PMU_PMCR_X	(1 << 4) /* Export to ETM */
 #define ARMV8_PMU_PMCR_DP	(1 << 5) /* Disable CCNT if non-invasive debug*/
 #define ARMV8_PMU_PMCR_LC	(1 << 6) /* Overflow on 64 bit cycle counter */
+#define ARMV8_PMU_PMCR_LP	(1 << 7) /* Long event counter enable */
 #define	ARMV8_PMU_PMCR_N_SHIFT	11	 /* Number of counters supported */
 #define	ARMV8_PMU_PMCR_N_MASK	0x1f
-#define	ARMV8_PMU_PMCR_MASK	0x7f	 /* Mask for writable bits */
+#define	ARMV8_PMU_PMCR_MASK	0xff	 /* Mask for writable bits */
 
 /*
  * PMOVSR: counters overflow flag status reg
diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index a0b4f1bca491..d8a3fa060abc 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -344,6 +344,17 @@ static struct attribute_group armv8_pmuv3_format_attr_group = {
 #define	ARMV8_IDX_COUNTER_LAST(cpu_pmu) \
 	(ARMV8_IDX_CYCLE_COUNTER + cpu_pmu->num_events - 1)
 
+
+/*
+ * We unconditionally enable ARMv8.5-PMU long event counter support
+ * (64-bit events) where supported. Indicate if this arm_pmu has long
+ * event counter support.
+ */
+static bool armv8pmu_has_long_event(struct arm_pmu *cpu_pmu)
+{
+	return (cpu_pmu->pmuver > ID_DFR0_EL1_PMUVER_8_4);
+}
+
 /*
  * We must chain two programmable counters for 64 bit events,
  * except when we have allocated the 64bit cycle counter (for CPU
@@ -353,9 +364,11 @@ static struct attribute_group armv8_pmuv3_format_attr_group = {
 static inline bool armv8pmu_event_is_chained(struct perf_event *event)
 {
 	int idx = event->hw.idx;
+	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
 
 	return !WARN_ON(idx < 0) &&
 	       armv8pmu_event_is_64bit(event) &&
+	       !armv8pmu_has_long_event(cpu_pmu) &&
 	       (idx != ARMV8_IDX_CYCLE_COUNTER);
 }
 
@@ -404,7 +417,7 @@ static inline void armv8pmu_select_counter(int idx)
 	isb();
 }
 
-static inline u32 armv8pmu_read_evcntr(int idx)
+static inline u64 armv8pmu_read_evcntr(int idx)
 {
 	armv8pmu_select_counter(idx);
 	return read_sysreg(pmxevcntr_el0);
@@ -421,6 +434,44 @@ static inline u64 armv8pmu_read_hw_counter(struct perf_event *event)
 	return val;
 }
 
+/*
+ * The cycle counter is always a 64-bit counter. When ARMV8_PMU_PMCR_LP
+ * is set the event counters also become 64-bit counters. Unless the
+ * user has requested a long counter (attr.config1) then we want to
+ * interrupt upon 32-bit overflow - we achieve this by applying a bias.
+ */
+static bool armv8pmu_event_needs_bias(struct perf_event *event)
+{
+	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	int idx = hwc->idx;
+
+	if (armv8pmu_event_is_64bit(event))
+		return false;
+
+	if (armv8pmu_has_long_event(cpu_pmu) ||
+	    idx == ARMV8_IDX_CYCLE_COUNTER)
+		return true;
+
+	return false;
+}
+
+static u64 armv8pmu_bias_long_counter(struct perf_event *event, u64 value)
+{
+	if (armv8pmu_event_needs_bias(event))
+		value |= GENMASK(63, 32);
+
+	return value;
+}
+
+static u64 armv8pmu_unbias_long_counter(struct perf_event *event, u64 value)
+{
+	if (armv8pmu_event_needs_bias(event))
+		value &= ~GENMASK(63, 32);
+
+	return value;
+}
+
 static u64 armv8pmu_read_counter(struct perf_event *event)
 {
 	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
@@ -436,10 +487,10 @@ static u64 armv8pmu_read_counter(struct perf_event *event)
 	else
 		value = armv8pmu_read_hw_counter(event);
 
-	return value;
+	return  armv8pmu_unbias_long_counter(event, value);
 }
 
-static inline void armv8pmu_write_evcntr(int idx, u32 value)
+static inline void armv8pmu_write_evcntr(int idx, u64 value)
 {
 	armv8pmu_select_counter(idx);
 	write_sysreg(value, pmxevcntr_el0);
@@ -464,20 +515,14 @@ static void armv8pmu_write_counter(struct perf_event *event, u64 value)
 	struct hw_perf_event *hwc = &event->hw;
 	int idx = hwc->idx;
 
+	value = armv8pmu_bias_long_counter(event, value);
+
 	if (!armv8pmu_counter_valid(cpu_pmu, idx))
 		pr_err("CPU%u writing wrong counter %d\n",
 			smp_processor_id(), idx);
-	else if (idx == ARMV8_IDX_CYCLE_COUNTER) {
-		/*
-		 * The cycles counter is really a 64-bit counter.
-		 * When treating it as a 32-bit counter, we only count
-		 * the lower 32 bits, and set the upper 32-bits so that
-		 * we get an interrupt upon 32-bit overflow.
-		 */
-		if (!armv8pmu_event_is_64bit(event))
-			value |= 0xffffffff00000000ULL;
+	else if (idx == ARMV8_IDX_CYCLE_COUNTER)
 		write_sysreg(value, pmccntr_el0);
-	} else
+	else
 		armv8pmu_write_hw_counter(event, value);
 }
 
@@ -802,7 +847,8 @@ static int armv8pmu_get_event_idx(struct pmu_hw_events *cpuc,
 	/*
 	 * Otherwise use events counters
 	 */
-	if (armv8pmu_event_is_64bit(event))
+	if (armv8pmu_event_is_64bit(event) &&
+	    !armv8pmu_has_long_event(cpu_pmu))
 		return	armv8pmu_get_chain_idx(cpuc, cpu_pmu);
 	else
 		return armv8pmu_get_single_idx(cpuc, cpu_pmu);
@@ -874,7 +920,7 @@ static int armv8pmu_filter_match(struct perf_event *event)
 static void armv8pmu_reset(void *info)
 {
 	struct arm_pmu *cpu_pmu = (struct arm_pmu *)info;
-	u32 idx, nb_cnt = cpu_pmu->num_events;
+	u32 idx, pmcr, nb_cnt = cpu_pmu->num_events;
 
 	/* The counter and interrupt enable registers are unknown at reset. */
 	for (idx = ARMV8_IDX_CYCLE_COUNTER; idx < nb_cnt; ++idx) {
@@ -889,8 +935,13 @@ static void armv8pmu_reset(void *info)
 	 * Initialize & Reset PMNC. Request overflow interrupt for
 	 * 64 bit cycle counter but cheat in armv8pmu_write_counter().
 	 */
-	armv8pmu_pmcr_write(ARMV8_PMU_PMCR_P | ARMV8_PMU_PMCR_C |
-			    ARMV8_PMU_PMCR_LC);
+	pmcr = ARMV8_PMU_PMCR_P | ARMV8_PMU_PMCR_C | ARMV8_PMU_PMCR_LC;
+
+	/* Enable long event counter support where available */
+	if (armv8pmu_has_long_event(cpu_pmu))
+		pmcr |= ARMV8_PMU_PMCR_LP;
+
+	armv8pmu_pmcr_write(pmcr);
 }
 
 static int __armv8_pmuv3_map_event(struct perf_event *event,
@@ -973,6 +1024,7 @@ static void __armv8pmu_probe_pmu(void *info)
 	if (pmuver == 0xf || pmuver == 0)
 		return;
 
+	cpu_pmu->pmuver = pmuver;
 	probe->present = true;
 
 	/* Read the nb of CNTx counters supported from PMNC */
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 71f525a35ac2..5b616dde9a4c 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -80,6 +80,7 @@ struct arm_pmu {
 	struct pmu	pmu;
 	cpumask_t	supported_cpus;
 	char		*name;
+	int		pmuver;
 	irqreturn_t	(*handle_irq)(struct arm_pmu *pmu);
 	void		(*enable)(struct perf_event *event);
 	void		(*disable)(struct perf_event *event);
-- 
2.21.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
