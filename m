Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B5017115676
	for <lists+kvmarm@lfdr.de>; Fri,  6 Dec 2019 18:28:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 649814AF4C;
	Fri,  6 Dec 2019 12:28:08 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.391
X-Spam-Level: 
X-Spam-Status: No, score=-1.391 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ah+P0dIAFQ4M; Fri,  6 Dec 2019 12:28:08 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6543F4AF3F;
	Fri,  6 Dec 2019 12:28:06 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8079E4AECE
 for <kvmarm@lists.cs.columbia.edu>; Fri,  6 Dec 2019 12:28:04 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qfZ9zksKN9Zm for <kvmarm@lists.cs.columbia.edu>;
 Fri,  6 Dec 2019 12:28:03 -0500 (EST)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4BB104AE94
 for <kvmarm@lists.cs.columbia.edu>; Fri,  6 Dec 2019 12:28:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575653283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cSQq/C7pHCzkPl8tiWZuEBhfZM9PZ9tXND49zKMJFso=;
 b=auC4eH5FY42YDKcpTP9ic8ih/NWuoeIT4++bCj/B7CsjltpeCjbK272R3QRCFRD0CC4qBP
 DAcYPRhoJmJnbvto7InlVI/gGQxZicOArVnXnMwNI2eTiSS11BV+gDfegQEsaAMVnGykLq
 Uvow8soO1ZMexvJVaqi4kgi6eysEMn0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-8c5GEJRsMwWaBaD1nzgbAw-1; Fri, 06 Dec 2019 12:28:02 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8EB4F107ACC7;
 Fri,  6 Dec 2019 17:28:00 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-117.ams2.redhat.com [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1101760BF4;
 Fri,  6 Dec 2019 17:27:57 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, maz@kernel.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Subject: [kvm-unit-tests RFC 06/10] pmu: Test chained counter
Date: Fri,  6 Dec 2019 18:27:20 +0100
Message-Id: <20191206172724.947-7-eric.auger@redhat.com>
In-Reply-To: <20191206172724.947-1-eric.auger@redhat.com>
References: <20191206172724.947-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 8c5GEJRsMwWaBaD1nzgbAw-1
X-Mimecast-Spam-Score: 0
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

Add 2 tests exercising chained counters. The first one uses
CPU_CYCLES and the second one uses SW_INCR.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 arm/pmu.c         | 125 ++++++++++++++++++++++++++++++++++++++++++++++
 arm/unittests.cfg |  12 +++++
 2 files changed, 137 insertions(+)

diff --git a/arm/pmu.c b/arm/pmu.c
index 8ffeb93..e185809 100644
--- a/arm/pmu.c
+++ b/arm/pmu.c
@@ -114,6 +114,8 @@ static void test_event_introspection(void) {}
 static void test_event_counter_config(void) {}
 static void test_basic_event_count(void) {}
 static void test_mem_access(void) {}
+static void test_chained_counters(void) {}
+static void test_chained_sw_incr(void) {}
 
 #elif defined(__aarch64__)
 #define ID_AA64DFR0_PERFMON_SHIFT 8
@@ -452,6 +454,123 @@ static void test_mem_access(void)
 			read_sysreg(pmovsclr_el0));
 }
 
+static void test_chained_counters(void)
+{
+	uint32_t events[] = { 0x11 /* CPU_CYCLES */, 0x1E /* CHAIN */};
+
+	if (!satisfy_prerequisites(events, ARRAY_SIZE(events)))
+		return;
+
+	pmu_reset();
+
+        write_regn(pmevtyper, 0, events[0] | PMEVTYPER_EXCLUDE_EL0);
+        write_regn(pmevtyper, 1, events[1] | PMEVTYPER_EXCLUDE_EL0);
+	/* enable counters #0 and #1 */
+	write_sysreg_s(0x3, PMCNTENSET_EL0);
+	/* preset counter #0 at 0xFFFFFFF0 */
+	write_regn(pmevcntr, 0, 0xFFFFFFF0);
+
+	precise_instrs_loop(22, pmu.pmcr_ro | PMU_PMCR_E);
+
+	report("CHAIN counter #1 incremented", read_regn(pmevcntr, 1) == 1); 
+	report("check no overflow is recorded", !read_sysreg(pmovsclr_el0));
+
+	/* test 64b overflow */
+
+	pmu_reset();
+	write_sysreg_s(0x3, PMCNTENSET_EL0);
+
+	write_regn(pmevcntr, 0, 0xFFFFFFF0);
+	write_regn(pmevcntr, 1, 0x1);
+	precise_instrs_loop(22, pmu.pmcr_ro | PMU_PMCR_E);
+	report_info("overflow reg = 0x%lx", read_sysreg(pmovsclr_el0));
+	report("CHAIN counter #1 incremented", read_regn(pmevcntr, 1) == 2); 
+	report("check no overflow is recorded", !read_sysreg(pmovsclr_el0));
+
+	write_regn(pmevcntr, 0, 0xFFFFFFF0);
+	write_regn(pmevcntr, 1, 0xFFFFFFFF);
+
+	precise_instrs_loop(22, pmu.pmcr_ro | PMU_PMCR_E);
+	report_info("overflow reg = 0x%lx", read_sysreg(pmovsclr_el0));
+	report("CHAIN counter #1 wrapped", !read_regn(pmevcntr, 1)); 
+	report("check no overflow is recorded", read_sysreg(pmovsclr_el0) == 0x2);
+}
+
+static void test_chained_sw_incr(void)
+{
+	uint32_t events[] = { 0x0 /* SW_INCR */, 0x0 /* SW_INCR */};
+	int i;
+
+	if (!satisfy_prerequisites(events, ARRAY_SIZE(events)))
+		return;
+
+	pmu_reset();
+
+        write_regn(pmevtyper, 0, events[0] | PMEVTYPER_EXCLUDE_EL0);
+        write_regn(pmevtyper, 1, events[1] | PMEVTYPER_EXCLUDE_EL0);
+	/* enable counters #0 and #1 */
+	write_sysreg_s(0x3, PMCNTENSET_EL0);
+
+	/* preset counter #0 at 0xFFFFFFF0 */
+	write_regn(pmevcntr, 0, 0xFFFFFFF0);
+
+	for (i = 0; i < 100; i++) {
+		write_sysreg(0x1, pmswinc_el0);
+	}
+	report_info("SW_INCR counter #0 has value %ld", read_regn(pmevcntr, 0)); 
+	report("PWSYNC does not increment if PMCR.E is unset",
+		read_regn(pmevcntr, 0) == 0xFFFFFFF0);
+
+	pmu_reset();
+
+	write_regn(pmevcntr, 0, 0xFFFFFFF0);
+	write_sysreg_s(0x3, PMCNTENSET_EL0);
+	set_pmcr(pmu.pmcr_ro | PMU_PMCR_E);
+
+	for (i = 0; i < 100; i++) {
+		write_sysreg(0x3, pmswinc_el0);
+	}
+	report("counter #1 after + 100 SW_INCR", read_regn(pmevcntr, 0)  == 84);
+	report("counter #0 after + 100 SW_INCR", read_regn(pmevcntr, 1)  == 100);
+	report_info(" counter values after 100 SW_INCR #0=%ld #1=%ld",
+			read_regn(pmevcntr, 0), read_regn(pmevcntr, 1));
+	report("overflow reg after 100 SW_INCR", read_sysreg(pmovsclr_el0) == 0x1);
+
+	/* 64b SW_INCR */
+	pmu_reset();
+
+	events[1] = 0x1E /* CHAIN */;
+        write_regn(pmevtyper, 1, events[1] | PMEVTYPER_EXCLUDE_EL0);
+	write_regn(pmevcntr, 0, 0xFFFFFFF0);
+	write_sysreg_s(0x3, PMCNTENSET_EL0);
+	set_pmcr(pmu.pmcr_ro | PMU_PMCR_E);
+	for (i = 0; i < 100; i++) {
+		write_sysreg(0x3, pmswinc_el0);
+	}
+	report("overflow reg after 100 SW_INCR/CHAIN",
+		!read_sysreg(pmovsclr_el0) && (read_regn(pmevcntr, 1) == 1));
+	report_info("overflow=0x%lx, #0=%ld #1=%ld", read_sysreg(pmovsclr_el0),
+		    read_regn(pmevcntr, 0), read_regn(pmevcntr, 1));
+
+	/* 64b SW_INCR and overflow on CHAIN counter*/
+	pmu_reset();
+
+        write_regn(pmevtyper, 1, events[1] | PMEVTYPER_EXCLUDE_EL0);
+	write_regn(pmevcntr, 0, 0xFFFFFFF0);
+	write_regn(pmevcntr, 1, 0xFFFFFFFF);
+	write_sysreg_s(0x3, PMCNTENSET_EL0);
+	set_pmcr(pmu.pmcr_ro | PMU_PMCR_E);
+	for (i = 0; i < 100; i++) {
+		write_sysreg(0x3, pmswinc_el0);
+	}
+	report("overflow reg after 100 SW_INCR/CHAIN",
+		(read_sysreg(pmovsclr_el0) == 0x2) &&
+		(read_regn(pmevcntr, 1) == 0) &&
+		(read_regn(pmevcntr, 0) == 84));
+	report_info("overflow=0x%lx, #0=%ld #1=%ld", read_sysreg(pmovsclr_el0),
+		    read_regn(pmevcntr, 0), read_regn(pmevcntr, 1));
+}
+
 #endif
 
 /*
@@ -648,6 +767,12 @@ int main(int argc, char *argv[])
 	} else if (strcmp(argv[1], "mem-access") == 0) {
 		report_prefix_push(argv[1]);
 		test_mem_access();
+	} else if (strcmp(argv[1], "chained-counters") == 0) {
+		report_prefix_push(argv[1]);
+		test_chained_counters();
+	} else if (strcmp(argv[1], "chained-sw-incr") == 0) {
+		report_prefix_push(argv[1]);
+		test_chained_sw_incr();
 	} else {
 		report_abort("Unknown subtest '%s'", argv[1]);
 	}
diff --git a/arm/unittests.cfg b/arm/unittests.cfg
index 7a59403..1bd4319 100644
--- a/arm/unittests.cfg
+++ b/arm/unittests.cfg
@@ -90,6 +90,18 @@ groups = pmu
 arch = arm64
 extra_params = -append 'mem-access'
 
+[pmu-chained-counters]
+file = pmu.flat
+groups = pmu
+arch = arm64
+extra_params = -append 'chained-counters'
+
+[pmu-chained-sw-incr]
+file = pmu.flat
+groups = pmu
+arch = arm64
+extra_params = -append 'chained-sw-incr'
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
