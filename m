Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1152719D0ED
	for <lists+kvmarm@lfdr.de>; Fri,  3 Apr 2020 09:14:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B68C34B159;
	Fri,  3 Apr 2020 03:14:18 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QQVy8m9FCyFk; Fri,  3 Apr 2020 03:14:17 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4283F4B197;
	Fri,  3 Apr 2020 03:14:16 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 729AE4B180
 for <kvmarm@lists.cs.columbia.edu>; Fri,  3 Apr 2020 03:14:15 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T0QsNw2pdato for <kvmarm@lists.cs.columbia.edu>;
 Fri,  3 Apr 2020 03:14:14 -0400 (EDT)
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0CF944B18B
 for <kvmarm@lists.cs.columbia.edu>; Fri,  3 Apr 2020 03:14:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585898053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xpkHTljcpse3yFCcUdioV0eaYWDWlIDML1b2uKcb8a0=;
 b=MEyng8faeYi+M6R65iItmuQ28dYWsKATinPeJzMpXiBiJCAM7HVHRUh+ZVmYDenvOG7EFg
 1EwHznK3UhCcU+/vwu6lrrKYY4/7I/HNTgRvV0pG7+Tx7/lQtE1IoldfDl12+XBKl3WeXY
 8xJyYv4pLYlaq+8mzxqOHPoThVtlhG0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-NyJvrN8qPUeNgm_Kb3g6Aw-1; Fri, 03 Apr 2020 03:14:04 -0400
X-MC-Unique: NyJvrN8qPUeNgm_Kb3g6Aw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49C1E107ACC4;
 Fri,  3 Apr 2020 07:14:02 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-112-58.ams2.redhat.com [10.36.112.58])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 77B419A245;
 Fri,  3 Apr 2020 07:13:59 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, maz@kernel.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Subject: [kvm-unit-tests PATCH v4 07/12] arm: pmu: Basic event counter Tests
Date: Fri,  3 Apr 2020 09:13:21 +0200
Message-Id: <20200403071326.29932-8-eric.auger@redhat.com>
In-Reply-To: <20200403071326.29932-1-eric.auger@redhat.com>
References: <20200403071326.29932-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: andrew.murray@arm.com, andre.przywara@arm.com
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

Adds the following tests:
- event-counter-config: test event counter configuration
- basic-event-count:
  - programs counters #0 and #1 to count 2 required events
  (resp. CPU_CYCLES and INST_RETIRED). Counter #0 is preset
  to a value close enough to the 32b
  overflow limit so that we check the overflow bit is set
  after the execution of the asm loop.
- mem-access: counts MEM_ACCESS event on counters #0 and #1
  with and without 32-bit overflow.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>

---

v2 -> v3:
- used BIT() for PMEVTYPER_EXCLUDE_EL1/0
- print the event id in hexa (Peter)
- added prefix pop
- s/write_regn/write_regn_el0
- s/read_regn/read_regn_el0
- remove print_pmevtyper
- moved write/read_regn_el0 into lib/arm64/asm/sysreg.h
- added pmu prefix to the test names
- Kept Andre's R-b as functional code has not changed

v1 -> v2:
- fix PMCNTENSET_EL0 and PMCNTENCLR_EL0 op0
- print PMEVTYPER SH
- properly clobber used regs and add "cc"
- simplify mem_access_loop
---
 arm/pmu.c              | 248 +++++++++++++++++++++++++++++++++++++++++
 arm/unittests.cfg      |  18 +++
 lib/arm64/asm/sysreg.h |   6 +
 3 files changed, 272 insertions(+)

diff --git a/arm/pmu.c b/arm/pmu.c
index 8c49e50..45dccf7 100644
--- a/arm/pmu.c
+++ b/arm/pmu.c
@@ -19,9 +19,14 @@
 #include "asm/sysreg.h"
 #include "asm/processor.h"
 #include <bitops.h>
+#include <asm/gic.h>
 
 #define PMU_PMCR_E         (1 << 0)
+#define PMU_PMCR_P         (1 << 1)
 #define PMU_PMCR_C         (1 << 2)
+#define PMU_PMCR_D         (1 << 3)
+#define PMU_PMCR_X         (1 << 4)
+#define PMU_PMCR_DP        (1 << 5)
 #define PMU_PMCR_LC        (1 << 6)
 #define PMU_PMCR_N_SHIFT   11
 #define PMU_PMCR_N_MASK    0x1f
@@ -38,6 +43,7 @@
 #define SW_INCR			0x0
 #define INST_RETIRED		0x8
 #define CPU_CYCLES		0x11
+#define MEM_ACCESS		0x13
 #define INST_PREC		0x1B
 #define STALL_FRONTEND		0x23
 #define STALL_BACKEND		0x24
@@ -47,6 +53,10 @@
 #define EXT_COMMON_EVENTS_LOW	0x4000
 #define EXT_COMMON_EVENTS_HIGH	0x403F
 
+#define ALL_SET			0xFFFFFFFF
+#define ALL_CLEAR		0x0
+#define PRE_OVERFLOW		0xFFFFFFF0
+
 struct pmu {
 	unsigned int version;
 	unsigned int nb_implemented_counters;
@@ -127,6 +137,9 @@ static inline void precise_instrs_loop(int loop, uint32_t pmcr)
 
 /* event counter tests only implemented for aarch64 */
 static void test_event_introspection(void) {}
+static void test_event_counter_config(void) {}
+static void test_basic_event_count(void) {}
+static void test_mem_access(void) {}
 
 #elif defined(__aarch64__)
 #define ID_AA64DFR0_PERFMON_SHIFT 8
@@ -175,6 +188,11 @@ static inline void precise_instrs_loop(int loop, uint32_t pmcr)
 }
 
 #define PMCEID1_EL0 sys_reg(3, 3, 9, 12, 7)
+#define PMCNTENSET_EL0 sys_reg(3, 3, 9, 12, 1)
+#define PMCNTENCLR_EL0 sys_reg(3, 3, 9, 12, 2)
+
+#define PMEVTYPER_EXCLUDE_EL1 BIT(31)
+#define PMEVTYPER_EXCLUDE_EL0 BIT(30)
 
 static bool is_event_supported(uint32_t n, bool warn)
 {
@@ -228,6 +246,224 @@ static void test_event_introspection(void)
 	report(required_events, "Check required events are implemented");
 }
 
+/*
+ * Extra instructions inserted by the compiler would be difficult to compensate
+ * for, so hand assemble everything between, and including, the PMCR accesses
+ * to start and stop counting. isb instructions are inserted to make sure
+ * pmccntr read after this function returns the exact instructions executed
+ * in the controlled block. Loads @loop times the data at @address into x9.
+ */
+static void mem_access_loop(void *addr, int loop, uint32_t pmcr)
+{
+asm volatile(
+	"       msr     pmcr_el0, %[pmcr]\n"
+	"       isb\n"
+	"       mov     x10, %[loop]\n"
+	"1:     sub     x10, x10, #1\n"
+	"       ldr	x9, [%[addr]]\n"
+	"       cmp     x10, #0x0\n"
+	"       b.gt    1b\n"
+	"       msr     pmcr_el0, xzr\n"
+	"       isb\n"
+	:
+	: [addr] "r" (addr), [pmcr] "r" (pmcr), [loop] "r" (loop)
+	: "x9", "x10", "cc");
+}
+
+static void pmu_reset(void)
+{
+	/* reset all counters, counting disabled at PMCR level*/
+	set_pmcr(pmu.pmcr_ro | PMU_PMCR_LC | PMU_PMCR_C | PMU_PMCR_P);
+	/* Disable all counters */
+	write_sysreg_s(ALL_SET, PMCNTENCLR_EL0);
+	/* clear overflow reg */
+	write_sysreg(ALL_SET, pmovsclr_el0);
+	/* disable overflow interrupts on all counters */
+	write_sysreg(ALL_SET, pmintenclr_el1);
+	isb();
+}
+
+static void test_event_counter_config(void)
+{
+	int i;
+
+	if (!pmu.nb_implemented_counters) {
+		report_skip("No event counter, skip ...");
+		return;
+	}
+
+	pmu_reset();
+
+	/*
+	 * Test setting through PMESELR/PMXEVTYPER and PMEVTYPERn read,
+	 * select counter 0
+	 */
+	write_sysreg(1, PMSELR_EL0);
+	/* program this counter to count unsupported event */
+	write_sysreg(0xEA, PMXEVTYPER_EL0);
+	write_sysreg(0xdeadbeef, PMXEVCNTR_EL0);
+	report((read_regn_el0(pmevtyper, 1) & 0xFFF) == 0xEA,
+		"PMESELR/PMXEVTYPER/PMEVTYPERn");
+	report((read_regn_el0(pmevcntr, 1) == 0xdeadbeef),
+		"PMESELR/PMXEVCNTR/PMEVCNTRn");
+
+	/* try to configure an unsupported event within the range [0x0, 0x3F] */
+	for (i = 0; i <= 0x3F; i++) {
+		if (!is_event_supported(i, false))
+			break;
+	}
+	if (i > 0x3F) {
+		report_skip("pmevtyper: all events within [0x0, 0x3F] are supported");
+		return;
+	}
+
+	/* select counter 0 */
+	write_sysreg(0, PMSELR_EL0);
+	/* program this counter to count unsupported event */
+	write_sysreg(i, PMXEVCNTR_EL0);
+	/* read the counter value */
+	read_sysreg(PMXEVCNTR_EL0);
+	report(read_sysreg(PMXEVCNTR_EL0) == i,
+		"read of a counter programmed with unsupported event");
+
+}
+
+static bool satisfy_prerequisites(uint32_t *events, unsigned int nb_events)
+{
+	int i;
+
+	if (pmu.nb_implemented_counters < nb_events) {
+		report_skip("Skip test as number of counters is too small (%d)",
+			    pmu.nb_implemented_counters);
+		return false;
+	}
+
+	for (i = 0; i < nb_events; i++) {
+		if (!is_event_supported(events[i], false)) {
+			report_skip("Skip test as event 0x%x is not supported",
+				    events[i]);
+			return false;
+		}
+	}
+	return true;
+}
+
+static void test_basic_event_count(void)
+{
+	uint32_t implemented_counter_mask, non_implemented_counter_mask;
+	uint32_t counter_mask;
+	uint32_t events[] = {CPU_CYCLES, INST_RETIRED};
+
+	if (!satisfy_prerequisites(events, ARRAY_SIZE(events)))
+		return;
+
+	implemented_counter_mask = BIT(pmu.nb_implemented_counters) - 1;
+	non_implemented_counter_mask = ~(BIT(31) | implemented_counter_mask);
+	counter_mask = implemented_counter_mask | non_implemented_counter_mask;
+
+	write_regn_el0(pmevtyper, 0, CPU_CYCLES | PMEVTYPER_EXCLUDE_EL0);
+	write_regn_el0(pmevtyper, 1, INST_RETIRED | PMEVTYPER_EXCLUDE_EL0);
+
+	/* disable all counters */
+	write_sysreg_s(ALL_SET, PMCNTENCLR_EL0);
+	report(!read_sysreg_s(PMCNTENCLR_EL0) && !read_sysreg_s(PMCNTENSET_EL0),
+		"pmcntenclr: disable all counters");
+
+	/*
+	 * clear cycle and all event counters and allow counter enablement
+	 * through PMCNTENSET. LC is RES1.
+	 */
+	set_pmcr(pmu.pmcr_ro | PMU_PMCR_LC | PMU_PMCR_C | PMU_PMCR_P);
+	isb();
+	report(get_pmcr() == (pmu.pmcr_ro | PMU_PMCR_LC), "pmcr: reset counters");
+
+	/* Preset counter #0 to pre overflow value to trigger an overflow */
+	write_regn_el0(pmevcntr, 0, PRE_OVERFLOW);
+	report(read_regn_el0(pmevcntr, 0) == PRE_OVERFLOW,
+		"counter #0 preset to pre-overflow value");
+	report(!read_regn_el0(pmevcntr, 1), "counter #1 is 0");
+
+	/*
+	 * Enable all implemented counters and also attempt to enable
+	 * not supported counters. Counting still is disabled by !PMCR.E
+	 */
+	write_sysreg_s(counter_mask, PMCNTENSET_EL0);
+
+	/* check only those implemented are enabled */
+	report((read_sysreg_s(PMCNTENSET_EL0) == read_sysreg_s(PMCNTENCLR_EL0)) &&
+		(read_sysreg_s(PMCNTENSET_EL0) == implemented_counter_mask),
+		"pmcntenset: enabled implemented_counters");
+
+	/* Disable all counters but counters #0 and #1 */
+	write_sysreg_s(~0x3, PMCNTENCLR_EL0);
+	report((read_sysreg_s(PMCNTENSET_EL0) == read_sysreg_s(PMCNTENCLR_EL0)) &&
+		(read_sysreg_s(PMCNTENSET_EL0) == 0x3),
+		"pmcntenset: just enabled #0 and #1");
+
+	/* clear overflow register */
+	write_sysreg(ALL_SET, pmovsclr_el0);
+	report(!read_sysreg(pmovsclr_el0), "check overflow reg is 0");
+
+	/* disable overflow interrupts on all counters*/
+	write_sysreg(ALL_SET, pmintenclr_el1);
+	report(!read_sysreg(pmintenclr_el1),
+		"pmintenclr_el1=0, all interrupts disabled");
+
+	/* enable overflow interrupts on all event counters */
+	write_sysreg(implemented_counter_mask | non_implemented_counter_mask,
+		     pmintenset_el1);
+	report(read_sysreg(pmintenset_el1) == implemented_counter_mask,
+		"overflow interrupts enabled on all implemented counters");
+
+	/* Set PMCR.E, execute asm code and unset PMCR.E */
+	precise_instrs_loop(20, pmu.pmcr_ro | PMU_PMCR_E);
+
+	report_info("counter #0 is 0x%lx (CPU_CYCLES)",
+		    read_regn_el0(pmevcntr, 0));
+	report_info("counter #1 is 0x%lx (INST_RETIRED)",
+		    read_regn_el0(pmevcntr, 1));
+
+	report_info("overflow reg = 0x%lx", read_sysreg(pmovsclr_el0));
+	report(read_sysreg(pmovsclr_el0) & 0x1,
+		"check overflow happened on #0 only");
+}
+
+static void test_mem_access(void)
+{
+	void *addr = malloc(PAGE_SIZE);
+	uint32_t events[] = {MEM_ACCESS, MEM_ACCESS};
+
+	if (!satisfy_prerequisites(events, ARRAY_SIZE(events)))
+		return;
+
+	pmu_reset();
+
+	write_regn_el0(pmevtyper, 0, MEM_ACCESS | PMEVTYPER_EXCLUDE_EL0);
+	write_regn_el0(pmevtyper, 1, MEM_ACCESS | PMEVTYPER_EXCLUDE_EL0);
+	write_sysreg_s(0x3, PMCNTENSET_EL0);
+	isb();
+	mem_access_loop(addr, 20, pmu.pmcr_ro | PMU_PMCR_E);
+	report_info("counter #0 is %ld (MEM_ACCESS)", read_regn_el0(pmevcntr, 0));
+	report_info("counter #1 is %ld (MEM_ACCESS)", read_regn_el0(pmevcntr, 1));
+	/* We may measure more than 20 mem access depending on the core */
+	report((read_regn_el0(pmevcntr, 0) == read_regn_el0(pmevcntr, 1)) &&
+	       (read_regn_el0(pmevcntr, 0) >= 20) && !read_sysreg(pmovsclr_el0),
+	       "Ran 20 mem accesses");
+
+	pmu_reset();
+
+	write_regn_el0(pmevcntr, 0, PRE_OVERFLOW);
+	write_regn_el0(pmevcntr, 1, PRE_OVERFLOW);
+	write_sysreg_s(0x3, PMCNTENSET_EL0);
+	isb();
+	mem_access_loop(addr, 20, pmu.pmcr_ro | PMU_PMCR_E);
+	report(read_sysreg(pmovsclr_el0) == 0x3,
+	       "Ran 20 mem accesses with expected overflows on both counters");
+	report_info("cnt#0 = %ld cnt#1=%ld overflow=0x%lx",
+			read_regn_el0(pmevcntr, 0), read_regn_el0(pmevcntr, 1),
+			read_sysreg(pmovsclr_el0));
+}
+
 #endif
 
 /*
@@ -402,6 +638,18 @@ int main(int argc, char *argv[])
 		report_prefix_push(argv[1]);
 		test_event_introspection();
 		report_prefix_pop();
+	} else if (strcmp(argv[1], "pmu-event-counter-config") == 0) {
+		report_prefix_push(argv[1]);
+		test_event_counter_config();
+		report_prefix_pop();
+	} else if (strcmp(argv[1], "pmu-basic-event-count") == 0) {
+		report_prefix_push(argv[1]);
+		test_basic_event_count();
+		report_prefix_pop();
+	} else if (strcmp(argv[1], "pmu-mem-access") == 0) {
+		report_prefix_push(argv[1]);
+		test_mem_access();
+		report_prefix_pop();
 	} else {
 		report_abort("Unknown sub-test '%s'", argv[1]);
 	}
diff --git a/arm/unittests.cfg b/arm/unittests.cfg
index f993548..32ab8c6 100644
--- a/arm/unittests.cfg
+++ b/arm/unittests.cfg
@@ -72,6 +72,24 @@ groups = pmu
 arch = arm64
 extra_params = -append 'pmu-event-introspection'
 
+[pmu-event-counter-config]
+file = pmu.flat
+groups = pmu
+arch = arm64
+extra_params = -append 'pmu-event-counter-config'
+
+[pmu-basic-event-count]
+file = pmu.flat
+groups = pmu
+arch = arm64
+extra_params = -append 'pmu-basic-event-count'
+
+[pmu-mem-access]
+file = pmu.flat
+groups = pmu
+arch = arm64
+extra_params = -append 'pmu-mem-access'
+
 # Test PMU support (TCG) with -icount IPC=1
 #[pmu-tcg-icount-1]
 #file = pmu.flat
diff --git a/lib/arm64/asm/sysreg.h b/lib/arm64/asm/sysreg.h
index a45eebd..378bf7e 100644
--- a/lib/arm64/asm/sysreg.h
+++ b/lib/arm64/asm/sysreg.h
@@ -49,6 +49,12 @@
 	asm volatile("msr_s " xstr(r) ", %x0" : : "rZ" (__val));\
 } while (0)
 
+#define write_regn_el0(__reg, __n, __val) \
+	write_sysreg((__val), __reg ## __n ## _el0)
+
+#define read_regn_el0(__reg, __n) \
+	read_sysreg(__reg ## __n ## _el0)
+
 asm(
 "	.irp	num,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30\n"
 "	.equ	.L__reg_num_x\\num, \\num\n"
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
