Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3F65465194F
	for <lists+kvmarm@lfdr.de>; Tue, 20 Dec 2022 04:10:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C8C974B81E;
	Mon, 19 Dec 2022 22:10:44 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -6.788
X-Spam-Level: 
X-Spam-Status: No, score=-6.788 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g4VdXim+Sjz6; Mon, 19 Dec 2022 22:10:44 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 519AB4B811;
	Mon, 19 Dec 2022 22:10:43 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id ACE5D4B824
 for <kvmarm@lists.cs.columbia.edu>; Mon, 19 Dec 2022 22:10:41 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jw3FJVLj+lXu for <kvmarm@lists.cs.columbia.edu>;
 Mon, 19 Dec 2022 22:10:40 -0500 (EST)
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com
 [209.85.210.201])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 362B34B7F9
 for <kvmarm@lists.cs.columbia.edu>; Mon, 19 Dec 2022 22:10:39 -0500 (EST)
Received: by mail-pf1-f201.google.com with SMTP id
 b6-20020aa78706000000b00579e3853125so5967579pfo.6
 for <kvmarm@lists.cs.columbia.edu>; Mon, 19 Dec 2022 19:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=oqCZvmKCVSuyHMTBvmIP/iUNp8G91xUVgWc9GZHrD1I=;
 b=E/a++PmBX6ewX4m6COGS7vCGTkwLxrielkcGStZi69eBPyewgcK5LWqj6M/lGNnAuG
 rLv3AVALryEe2DH5y31kLB8Q2LWAhdac3Vg5025GrX46f30Hq9nDoEK5CgbTD4/g4Q8k
 xO0Xav18ey6DRDaAJEP5stHm574BnWcRmEhOEXqb/mnGB/D8oK+jtXWQjtHSAMIwhBgf
 Pwq/5UhcWlgMjr/XOdFxmBHjqTCsum38zDRspXbzviesHiABaX8Ts/8TpI0yI9g1b0tW
 Tk9lIT4hNiq9EC3lIbuZfjOBR1n4a4lim0j1Pt9NXUHhgeTfh0KilEcgqU5o0qcCpVs0
 KZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oqCZvmKCVSuyHMTBvmIP/iUNp8G91xUVgWc9GZHrD1I=;
 b=Rjpq6FWl5qemA5mLWokzULnWRknRmcb5D0aIL1TOqeb50e0s9JeKd1+1NXQpsmmn98
 QJerNQCGb/mfO4L3mn9fIt2GUIwHdOfk2vMWwVLvaWZCTvQeClFlq+KFKtWFDx2C38cM
 +jGqwh6nq5ztFX4MCax7NT+JgGgNxC6XryWgfU2Pqdc2+l/SuapVB1Z4ktQP+4RtmroH
 CWfITMrfJNu2K4GkdkOHB7tHR2D9xsSBm5aoOPZuz/Pc/POJ0ym9yDPYDEgegbaHYs8B
 CDZwQUNQdoS7ylR3GUKr7VaUSlTWfYsxyed26DnSjLaL9bdEF0xgUWMdVD3ERD4qTjQO
 IEdw==
X-Gm-Message-State: ANoB5pm1SOpbmnTjJQhUEtJ8xXrSB+KWwQuHQ4hOGLhHy2GzneEBd9V7
 lTJnpk7Z7dUk+Y+UttUOBwSUkQkegfn/sQ==
X-Google-Smtp-Source: AA0mqf5hIPQ6xZOpAFX1wns9Agyqe6sbD1gEQS2FdUuLH8lZd32BznPph2C9+xp+W0c+2dPO0hwr+u7S4LfDWw==
X-Received: from ricarkol4.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:1248])
 (user=ricarkol job=sendgmr) by 2002:a05:6a00:2403:b0:572:698b:5f69 with SMTP
 id z3-20020a056a00240300b00572698b5f69mr84738387pfh.54.1671505838281; Mon, 19
 Dec 2022 19:10:38 -0800 (PST)
Date: Tue, 20 Dec 2022 03:10:30 +0000
In-Reply-To: <20221220031032.2648701-1-ricarkol@google.com>
Mime-Version: 1.0
References: <20221220031032.2648701-1-ricarkol@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221220031032.2648701-3-ricarkol@google.com>
Subject: [kvm-unit-tests PATCH v2 2/4] arm: pmu: Prepare for testing 64-bit
 overflows
From: Ricardo Koller <ricarkol@google.com>
To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, andrew.jones@linux.dev
Cc: maz@kernel.org
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

PMUv3p5 adds a knob, PMCR_EL0.LP == 1, that allows overflowing at 64-bits
instead of 32. Prepare by doing these 3 things:

1. Add a "bool overflow_at_64bits" argument to all tests checking
   overflows.
2. Extend satisfy_prerequisites() to check if the machine supports
   "overflow_at_64bits".
3. Refactor the test invocations to use the new "run_test()" which adds a
   report prefix indicating whether the test uses 64 or 32-bit overflows.

A subsequent commit will actually add the 64-bit overflow tests.

Signed-off-by: Ricardo Koller <ricarkol@google.com>
---
 arm/pmu.c | 92 ++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 53 insertions(+), 39 deletions(-)

diff --git a/arm/pmu.c b/arm/pmu.c
index 1b55e20..4cd3790 100644
--- a/arm/pmu.c
+++ b/arm/pmu.c
@@ -167,13 +167,13 @@ static void pmu_reset(void)
 /* event counter tests only implemented for aarch64 */
 static void test_event_introspection(void) {}
 static void test_event_counter_config(void) {}
-static void test_basic_event_count(void) {}
-static void test_mem_access(void) {}
-static void test_sw_incr(void) {}
-static void test_chained_counters(void) {}
-static void test_chained_sw_incr(void) {}
-static void test_chain_promotion(void) {}
-static void test_overflow_interrupt(void) {}
+static void test_basic_event_count(bool overflow_at_64bits) {}
+static void test_mem_access(bool overflow_at_64bits) {}
+static void test_sw_incr(bool overflow_at_64bits) {}
+static void test_chained_counters(bool unused) {}
+static void test_chained_sw_incr(bool unused) {}
+static void test_chain_promotion(bool unused) {}
+static void test_overflow_interrupt(bool overflow_at_64bits) {}
 
 #elif defined(__aarch64__)
 #define ID_AA64DFR0_PERFMON_SHIFT 8
@@ -419,16 +419,28 @@ static bool satisfy_prerequisites(uint32_t *events, unsigned int nb_events)
 			return false;
 		}
 	}
+
+	return true;
+}
+
+static bool check_overflow_prerequisites(bool overflow_at_64bits)
+{
+	if (overflow_at_64bits && pmu.version < ID_DFR0_PMU_V3_8_5) {
+		report_skip("Skip test as 64 overflows need FEAT_PMUv3p5");
+		return false;
+	}
+
 	return true;
 }
 
-static void test_basic_event_count(void)
+static void test_basic_event_count(bool overflow_at_64bits)
 {
 	uint32_t implemented_counter_mask, non_implemented_counter_mask;
 	uint32_t counter_mask;
 	uint32_t events[] = {CPU_CYCLES, INST_RETIRED};
 
-	if (!satisfy_prerequisites(events, ARRAY_SIZE(events)))
+	if (!satisfy_prerequisites(events, ARRAY_SIZE(events)) ||
+	    !check_overflow_prerequisites(overflow_at_64bits))
 		return;
 
 	implemented_counter_mask = BIT(pmu.nb_implemented_counters) - 1;
@@ -502,12 +514,13 @@ static void test_basic_event_count(void)
 		"check overflow happened on #0 only");
 }
 
-static void test_mem_access(void)
+static void test_mem_access(bool overflow_at_64bits)
 {
 	void *addr = malloc(PAGE_SIZE);
 	uint32_t events[] = {MEM_ACCESS, MEM_ACCESS};
 
-	if (!satisfy_prerequisites(events, ARRAY_SIZE(events)))
+	if (!satisfy_prerequisites(events, ARRAY_SIZE(events)) ||
+	    !check_overflow_prerequisites(overflow_at_64bits))
 		return;
 
 	pmu_reset();
@@ -538,13 +551,14 @@ static void test_mem_access(void)
 			read_sysreg(pmovsclr_el0));
 }
 
-static void test_sw_incr(void)
+static void test_sw_incr(bool overflow_at_64bits)
 {
 	uint32_t events[] = {SW_INCR, SW_INCR};
 	uint64_t cntr0;
 	int i;
 
-	if (!satisfy_prerequisites(events, ARRAY_SIZE(events)))
+	if (!satisfy_prerequisites(events, ARRAY_SIZE(events)) ||
+	    !check_overflow_prerequisites(overflow_at_64bits))
 		return;
 
 	pmu_reset();
@@ -587,7 +601,7 @@ static void test_sw_incr(void)
 		"overflow on counter #0 after 100 SW_INCR");
 }
 
-static void test_chained_counters(void)
+static void test_chained_counters(bool unused)
 {
 	uint32_t events[] = {CPU_CYCLES, CHAIN};
 	uint64_t all_set = ALL_SET_AT(pmu.version >= ID_DFR0_PMU_V3_8_5);
@@ -630,7 +644,7 @@ static void test_chained_counters(void)
 	report(read_sysreg(pmovsclr_el0) == 0x3, "overflow on even and odd counters");
 }
 
-static void test_chained_sw_incr(void)
+static void test_chained_sw_incr(bool unused)
 {
 	uint32_t events[] = {SW_INCR, CHAIN};
 	uint64_t cntr0, cntr1;
@@ -686,7 +700,7 @@ static void test_chained_sw_incr(void)
 		    read_regn_el0(pmevcntr, 0), read_regn_el0(pmevcntr, 1));
 }
 
-static void test_chain_promotion(void)
+static void test_chain_promotion(bool unused)
 {
 	uint32_t events[] = {MEM_ACCESS, CHAIN};
 	void *addr = malloc(PAGE_SIZE);
@@ -835,13 +849,14 @@ static bool expect_interrupts(uint32_t bitmap)
 	return true;
 }
 
-static void test_overflow_interrupt(void)
+static void test_overflow_interrupt(bool overflow_at_64bits)
 {
 	uint32_t events[] = {MEM_ACCESS, SW_INCR};
 	void *addr = malloc(PAGE_SIZE);
 	int i;
 
-	if (!satisfy_prerequisites(events, ARRAY_SIZE(events)))
+	if (!satisfy_prerequisites(events, ARRAY_SIZE(events)) ||
+	    !check_overflow_prerequisites(overflow_at_64bits))
 		return;
 
 	gic_enable_defaults();
@@ -1065,6 +1080,19 @@ static bool pmu_probe(void)
 	return true;
 }
 
+static void run_test(char *name, void (*test)(bool), bool overflow_at_64bits)
+{
+	const char *prefix = overflow_at_64bits ? "64-bit overflows" : "32-bit overflows";
+
+	report_prefix_push(name);
+	report_prefix_push(prefix);
+
+	test(overflow_at_64bits);
+
+	report_prefix_pop();
+	report_prefix_pop();
+}
+
 int main(int argc, char *argv[])
 {
 	int cpi = 0;
@@ -1097,33 +1125,19 @@ int main(int argc, char *argv[])
 		test_event_counter_config();
 		report_prefix_pop();
 	} else if (strcmp(argv[1], "pmu-basic-event-count") == 0) {
-		report_prefix_push(argv[1]);
-		test_basic_event_count();
-		report_prefix_pop();
+		run_test(argv[1], test_basic_event_count, false);
 	} else if (strcmp(argv[1], "pmu-mem-access") == 0) {
-		report_prefix_push(argv[1]);
-		test_mem_access();
-		report_prefix_pop();
+		run_test(argv[1], test_mem_access, false);
 	} else if (strcmp(argv[1], "pmu-sw-incr") == 0) {
-		report_prefix_push(argv[1]);
-		test_sw_incr();
-		report_prefix_pop();
+		run_test(argv[1], test_sw_incr, false);
 	} else if (strcmp(argv[1], "pmu-chained-counters") == 0) {
-		report_prefix_push(argv[1]);
-		test_chained_counters();
-		report_prefix_pop();
+		run_test(argv[1], test_chained_counters, false);
 	} else if (strcmp(argv[1], "pmu-chained-sw-incr") == 0) {
-		report_prefix_push(argv[1]);
-		test_chained_sw_incr();
-		report_prefix_pop();
+		run_test(argv[1], test_chained_sw_incr, false);
 	} else if (strcmp(argv[1], "pmu-chain-promotion") == 0) {
-		report_prefix_push(argv[1]);
-		test_chain_promotion();
-		report_prefix_pop();
+		run_test(argv[1], test_chain_promotion, false);
 	} else if (strcmp(argv[1], "pmu-overflow-interrupt") == 0) {
-		report_prefix_push(argv[1]);
-		test_overflow_interrupt();
-		report_prefix_pop();
+		run_test(argv[1], test_overflow_interrupt, false);
 	} else {
 		report_abort("Unknown sub-test '%s'", argv[1]);
 	}
-- 
2.39.0.314.g84b9a713c41-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
