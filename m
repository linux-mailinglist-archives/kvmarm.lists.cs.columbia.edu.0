Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2F319E5C2
	for <lists+kvmarm@lfdr.de>; Sat,  4 Apr 2020 16:38:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 408D74B1F2;
	Sat,  4 Apr 2020 10:38:38 -0400 (EDT)
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
	with ESMTP id U4TD4NvC8ygQ; Sat,  4 Apr 2020 10:38:37 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3726D4B237;
	Sat,  4 Apr 2020 10:38:37 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 711994B232
 for <kvmarm@lists.cs.columbia.edu>; Sat,  4 Apr 2020 10:38:36 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KC0Jqf1HTHRJ for <kvmarm@lists.cs.columbia.edu>;
 Sat,  4 Apr 2020 10:38:35 -0400 (EDT)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 727784B1DD
 for <kvmarm@lists.cs.columbia.edu>; Sat,  4 Apr 2020 10:38:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586011115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MvxU7Ss59FG5Zx9PkSdNwBKbxalmhsB13IBVxvATAlI=;
 b=LlmxFPxTN27gISNgulFvkunrXhf7bL99jJeTO3gM+d7GhuGRLngz9tPxpmfsRlc/gwwkVx
 pHzNdJ1qPifP6yEttVRrnUqX397taIH/Jk8PNW2QBDhMBdxXSwc4Ssk1Oi4LIxUBhZ6VWL
 z3aVs6xZYcCnW1LJlk7bPIaxL7BY+ts=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-zOw8fEgVOxKiHMh8PXUAuw-1; Sat, 04 Apr 2020 10:38:33 -0400
X-MC-Unique: zOw8fEgVOxKiHMh8PXUAuw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1553A1005509;
 Sat,  4 Apr 2020 14:38:32 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 531BE9B912;
 Sat,  4 Apr 2020 14:38:30 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: pbonzini@redhat.com
Subject: [PULL kvm-unit-tests 22/39] arm: pmu: Test SW_INCR event count
Date: Sat,  4 Apr 2020 16:37:14 +0200
Message-Id: <20200404143731.208138-23-drjones@redhat.com>
In-Reply-To: <20200404143731.208138-1-drjones@redhat.com>
References: <20200404143731.208138-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org
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

From: Eric Auger <eric.auger@redhat.com>

Add tests dedicated to SW_INCR event counting.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 arm/pmu.c         | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 arm/unittests.cfg |  6 ++++++
 2 files changed, 53 insertions(+)

diff --git a/arm/pmu.c b/arm/pmu.c
index 4a605c18064f..16d723463395 100644
--- a/arm/pmu.c
+++ b/arm/pmu.c
@@ -140,6 +140,7 @@ static void test_event_introspection(void) {}
 static void test_event_counter_config(void) {}
 static void test_basic_event_count(void) {}
 static void test_mem_access(void) {}
+static void test_sw_incr(void) {}
 
 #elif defined(__aarch64__)
 #define ID_AA64DFR0_PERFMON_SHIFT 8
@@ -463,6 +464,48 @@ static void test_mem_access(void)
 			read_sysreg(pmovsclr_el0));
 }
 
+static void test_sw_incr(void)
+{
+	uint32_t events[] = {SW_INCR, SW_INCR};
+	int i;
+
+	if (!satisfy_prerequisites(events, ARRAY_SIZE(events)))
+		return;
+
+	pmu_reset();
+
+	write_regn_el0(pmevtyper, 0, SW_INCR | PMEVTYPER_EXCLUDE_EL0);
+	write_regn_el0(pmevtyper, 1, SW_INCR | PMEVTYPER_EXCLUDE_EL0);
+	/* enable counters #0 and #1 */
+	write_sysreg_s(0x3, PMCNTENSET_EL0);
+
+	write_regn_el0(pmevcntr, 0, PRE_OVERFLOW);
+
+	for (i = 0; i < 100; i++)
+		write_sysreg(0x1, pmswinc_el0);
+
+	report_info("SW_INCR counter #0 has value %ld", read_regn_el0(pmevcntr, 0));
+	report(read_regn_el0(pmevcntr, 0) == PRE_OVERFLOW,
+		"PWSYNC does not increment if PMCR.E is unset");
+
+	pmu_reset();
+
+	write_regn_el0(pmevcntr, 0, PRE_OVERFLOW);
+	write_sysreg_s(0x3, PMCNTENSET_EL0);
+	set_pmcr(pmu.pmcr_ro | PMU_PMCR_E);
+
+	for (i = 0; i < 100; i++)
+		write_sysreg(0x3, pmswinc_el0);
+
+	report(read_regn_el0(pmevcntr, 0)  == 84, "counter #1 after + 100 SW_INCR");
+	report(read_regn_el0(pmevcntr, 1)  == 100,
+		"counter #0 after + 100 SW_INCR");
+	report_info("counter values after 100 SW_INCR #0=%ld #1=%ld",
+		    read_regn_el0(pmevcntr, 0), read_regn_el0(pmevcntr, 1));
+	report(read_sysreg(pmovsclr_el0) == 0x1,
+		"overflow reg after 100 SW_INCR");
+}
+
 #endif
 
 /*
@@ -649,6 +692,10 @@ int main(int argc, char *argv[])
 		report_prefix_push(argv[1]);
 		test_mem_access();
 		report_prefix_pop();
+	} else if (strcmp(argv[1], "pmu-sw-incr") == 0) {
+		report_prefix_push(argv[1]);
+		test_sw_incr();
+		report_prefix_pop();
 	} else {
 		report_abort("Unknown sub-test '%s'", argv[1]);
 	}
diff --git a/arm/unittests.cfg b/arm/unittests.cfg
index 32ab8c6fe06a..175afe68225a 100644
--- a/arm/unittests.cfg
+++ b/arm/unittests.cfg
@@ -90,6 +90,12 @@ groups = pmu
 arch = arm64
 extra_params = -append 'pmu-mem-access'
 
+[pmu-sw-incr]
+file = pmu.flat
+groups = pmu
+arch = arm64
+extra_params = -append 'pmu-sw-incr'
+
 # Test PMU support (TCG) with -icount IPC=1
 #[pmu-tcg-icount-1]
 #file = pmu.flat
-- 
2.25.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
