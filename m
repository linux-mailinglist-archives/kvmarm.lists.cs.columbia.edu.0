Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C28DE183542
	for <lists+kvmarm@lfdr.de>; Thu, 12 Mar 2020 16:44:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 769BE4AEFA;
	Thu, 12 Mar 2020 11:44:38 -0400 (EDT)
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
	with ESMTP id r1RST-5RMDsN; Thu, 12 Mar 2020 11:44:38 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2B0DC4AEF3;
	Thu, 12 Mar 2020 11:44:37 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D961B4AEE6
 for <kvmarm@lists.cs.columbia.edu>; Thu, 12 Mar 2020 11:44:35 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1JLJzdQV1JrD for <kvmarm@lists.cs.columbia.edu>;
 Thu, 12 Mar 2020 11:44:34 -0400 (EDT)
Received: from us-smtp-1.mimecast.com (us-smtp-1.mimecast.com [205.139.110.61])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B19F74AEDE
 for <kvmarm@lists.cs.columbia.edu>; Thu, 12 Mar 2020 11:44:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584027874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aFpJASfu2ht2gDqiYkt5EXxaGYzykEHenqKpcZ6I3ns=;
 b=jHnJ7ZlOER4ci08FQjP31aPlcOdwdv3w+0+eNdc5uHzrGEouuhLepzg83IXI8tPY+o0zQ8
 l/4QAKqBASWAurYlyQFdexUz9rStef6CE4eIcp9XKm/woB31t6gVOYmf8oOotiW6c71sc1
 O2IUS1ViP5uKmAZZNVuvBSUBm3iUdU4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-zBMcV4IrO9OY-tiSY3O0sw-1; Thu, 12 Mar 2020 11:44:33 -0400
X-MC-Unique: zBMcV4IrO9OY-tiSY3O0sw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 787EC192299E;
 Thu, 12 Mar 2020 15:44:31 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.36.118.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E25FB5C1B5;
 Thu, 12 Mar 2020 15:44:26 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, maz@kernel.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Subject: [kvm-unit-tests PATCH v3 09/12] arm: pmu: Test chained counters
Date: Thu, 12 Mar 2020 16:42:58 +0100
Message-Id: <20200312154301.9130-10-eric.auger@redhat.com>
In-Reply-To: <20200312154301.9130-1-eric.auger@redhat.com>
References: <20200312154301.9130-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

Add 2 tests exercising chained counters. The first one uses
CPU_CYCLES and the second one uses SW_INCR.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v2 -> v3:
- added prefix pop
- added pmu prefix to the test names
- defines, event array ...
---
 arm/pmu.c         | 97 +++++++++++++++++++++++++++++++++++++++++++++++
 arm/unittests.cfg | 12 ++++++
 2 files changed, 109 insertions(+)

diff --git a/arm/pmu.c b/arm/pmu.c
index c954c71..ccca31b 100644
--- a/arm/pmu.c
+++ b/arm/pmu.c
@@ -47,6 +47,7 @@
 #define INST_PREC		0x1B
 #define STALL_FRONTEND		0x23
 #define STALL_BACKEND		0x24
+#define CHAIN			0x1E
 
 #define COMMON_EVENTS_LOW	0x0
 #define COMMON_EVENTS_HIGH	0x3F
@@ -141,6 +142,8 @@ static void test_event_counter_config(void) {}
 static void test_basic_event_count(void) {}
 static void test_mem_access(void) {}
 static void test_sw_incr(void) {}
+static void test_chained_counters(void) {}
+static void test_chained_sw_incr(void) {}
 
 #elif defined(__aarch64__)
 #define ID_AA64DFR0_PERFMON_SHIFT 8
@@ -507,6 +510,92 @@ static void test_sw_incr(void)
 		"overflow reg after 100 SW_INCR");
 }
 
+static void test_chained_counters(void)
+{
+	uint32_t events[] = {CPU_CYCLES, CHAIN};
+
+	if (!satisfy_prerequisites(events, ARRAY_SIZE(events)))
+		return;
+
+	pmu_reset();
+
+	write_regn_el0(pmevtyper, 0, CPU_CYCLES | PMEVTYPER_EXCLUDE_EL0);
+	write_regn_el0(pmevtyper, 1, CHAIN | PMEVTYPER_EXCLUDE_EL0);
+	/* enable counters #0 and #1 */
+	write_sysreg_s(0x3, PMCNTENSET_EL0);
+	write_regn_el0(pmevcntr, 0, PRE_OVERFLOW);
+
+	precise_instrs_loop(22, pmu.pmcr_ro | PMU_PMCR_E);
+
+	report(read_regn_el0(pmevcntr, 1) == 1, "CHAIN counter #1 incremented");
+	report(!read_sysreg(pmovsclr_el0), "check no overflow is recorded");
+
+	/* test 64b overflow */
+
+	pmu_reset();
+	write_sysreg_s(0x3, PMCNTENSET_EL0);
+
+	write_regn_el0(pmevcntr, 0, PRE_OVERFLOW);
+	write_regn_el0(pmevcntr, 1, 0x1);
+	precise_instrs_loop(22, pmu.pmcr_ro | PMU_PMCR_E);
+	report_info("overflow reg = 0x%lx", read_sysreg(pmovsclr_el0));
+	report(read_regn_el0(pmevcntr, 1) == 2, "CHAIN counter #1 incremented");
+	report(!read_sysreg(pmovsclr_el0), "check no overflow is recorded");
+
+	write_regn_el0(pmevcntr, 0, PRE_OVERFLOW);
+	write_regn_el0(pmevcntr, 1, ALL_SET);
+
+	precise_instrs_loop(22, pmu.pmcr_ro | PMU_PMCR_E);
+	report_info("overflow reg = 0x%lx", read_sysreg(pmovsclr_el0));
+	report(!read_regn_el0(pmevcntr, 1), "CHAIN counter #1 wrapped");
+	report(read_sysreg(pmovsclr_el0) == 0x2,
+		"check no overflow is recorded");
+}
+
+static void test_chained_sw_incr(void)
+{
+	uint32_t events[] = {SW_INCR, CHAIN};
+	int i;
+
+	if (!satisfy_prerequisites(events, ARRAY_SIZE(events)))
+		return;
+
+	pmu_reset();
+
+	write_regn_el0(pmevtyper, 0, SW_INCR | PMEVTYPER_EXCLUDE_EL0);
+	write_regn_el0(pmevtyper, 1, CHAIN | PMEVTYPER_EXCLUDE_EL0);
+	/* enable counters #0 and #1 */
+	write_sysreg_s(0x3, PMCNTENSET_EL0);
+
+	write_regn_el0(pmevcntr, 0, PRE_OVERFLOW);
+	set_pmcr(pmu.pmcr_ro | PMU_PMCR_E);
+	for (i = 0; i < 100; i++)
+		write_sysreg(0x1, pmswinc_el0);
+
+	report(!read_sysreg(pmovsclr_el0) && (read_regn_el0(pmevcntr, 1) == 1),
+		"overflow reg after 100 SW_INCR/CHAIN");
+	report_info("overflow=0x%lx, #0=%ld #1=%ld", read_sysreg(pmovsclr_el0),
+		    read_regn_el0(pmevcntr, 0), read_regn_el0(pmevcntr, 1));
+
+	/* 64b SW_INCR and overflow on CHAIN counter*/
+	pmu_reset();
+
+	write_regn_el0(pmevtyper, 1, events[1] | PMEVTYPER_EXCLUDE_EL0);
+	write_regn_el0(pmevcntr, 0, PRE_OVERFLOW);
+	write_regn_el0(pmevcntr, 1, ALL_SET);
+	write_sysreg_s(0x3, PMCNTENSET_EL0);
+	set_pmcr(pmu.pmcr_ro | PMU_PMCR_E);
+	for (i = 0; i < 100; i++)
+		write_sysreg(0x1, pmswinc_el0);
+
+	report((read_sysreg(pmovsclr_el0) == 0x2) &&
+		(read_regn_el0(pmevcntr, 1) == 0) &&
+		(read_regn_el0(pmevcntr, 0) == 84),
+		"overflow reg after 100 SW_INCR/CHAIN");
+	report_info("overflow=0x%lx, #0=%ld #1=%ld", read_sysreg(pmovsclr_el0),
+		    read_regn_el0(pmevcntr, 0), read_regn_el0(pmevcntr, 1));
+}
+
 #endif
 
 /*
@@ -697,6 +786,14 @@ int main(int argc, char *argv[])
 		report_prefix_push(argv[1]);
 		test_sw_incr();
 		report_prefix_pop();
+	} else if (strcmp(argv[1], "pmu-chained-counters") == 0) {
+		report_prefix_push(argv[1]);
+		test_chained_counters();
+		report_prefix_pop();
+	} else if (strcmp(argv[1], "pmu-chained-sw-incr") == 0) {
+		report_prefix_push(argv[1]);
+		test_chained_sw_incr();
+		report_prefix_pop();
 	} else {
 		report_abort("Unknown sub-test '%s'", argv[1]);
 	}
diff --git a/arm/unittests.cfg b/arm/unittests.cfg
index 175afe6..d31dcbf 100644
--- a/arm/unittests.cfg
+++ b/arm/unittests.cfg
@@ -96,6 +96,18 @@ groups = pmu
 arch = arm64
 extra_params = -append 'pmu-sw-incr'
 
+[pmu-chained-counters]
+file = pmu.flat
+groups = pmu
+arch = arm64
+extra_params = -append 'pmu-chained-counters'
+
+[pmu-chained-sw-incr]
+file = pmu.flat
+groups = pmu
+arch = arm64
+extra_params = -append 'pmu-chained-sw-incr'
+
 # Test PMU support (TCG) with -icount IPC=1
 #[pmu-tcg-icount-1]
 #file = pmu.flat
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
