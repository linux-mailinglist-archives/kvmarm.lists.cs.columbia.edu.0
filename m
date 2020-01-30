Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5015714D9B8
	for <lists+kvmarm@lfdr.de>; Thu, 30 Jan 2020 12:26:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 025244A597;
	Thu, 30 Jan 2020 06:26:32 -0500 (EST)
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
	with ESMTP id pBvOjpKgyWZb; Thu, 30 Jan 2020 06:26:31 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A6EF14A946;
	Thu, 30 Jan 2020 06:26:30 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C24A94A5C3
 for <kvmarm@lists.cs.columbia.edu>; Thu, 30 Jan 2020 06:26:29 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X-kSjCAynw7T for <kvmarm@lists.cs.columbia.edu>;
 Thu, 30 Jan 2020 06:26:28 -0500 (EST)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 918134A598
 for <kvmarm@lists.cs.columbia.edu>; Thu, 30 Jan 2020 06:26:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580383588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9SlPk4NmjjNnpZB612uFFc7ZwjsKN9cXzlux9cD7IFw=;
 b=fo+2Cvgj7sV8gDo3LtxTU0nrRvDrG4JK6k+EiZRh55H0mdy4u/GG1G9irDm4ZbRpz+XQyT
 JQSpccZgJ1YI25vSNOoM8+Q/H4B8NOcTKAsXhFI2um+wQooh8kVQVUnCRH4+XYdiEO07GK
 FsoWq3N6NOFOmB5IOeg0h0rO214qCTU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-GbVGC-FgOV6xUg9HOdVxVQ-1; Thu, 30 Jan 2020 06:26:24 -0500
X-MC-Unique: GbVGC-FgOV6xUg9HOdVxVQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0801DDB6E;
 Thu, 30 Jan 2020 11:26:23 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 86D131000322;
 Thu, 30 Jan 2020 11:26:15 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, maz@kernel.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Subject: [kvm-unit-tests PATCH v2 9/9] arm: pmu: Test overflow interrupts
Date: Thu, 30 Jan 2020 12:25:10 +0100
Message-Id: <20200130112510.15154-10-eric.auger@redhat.com>
In-Reply-To: <20200130112510.15154-1-eric.auger@redhat.com>
References: <20200130112510.15154-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

Test overflows for MEM_ACCESS and SW_INCR events. Also tests
overflows with 64-bit events.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v1 -> v2:
- inline setup_irq() code
---
 arm/pmu.c         | 137 ++++++++++++++++++++++++++++++++++++++++++++++
 arm/unittests.cfg |   6 ++
 2 files changed, 143 insertions(+)

diff --git a/arm/pmu.c b/arm/pmu.c
index fa77ab3..ada28a4 100644
--- a/arm/pmu.c
+++ b/arm/pmu.c
@@ -45,6 +45,11 @@ struct pmu {
 	uint32_t pmcr_ro;
 };
 
+struct pmu_stats {
+	unsigned long bitmap;
+	uint32_t interrupts[32];
+};
+
 static struct pmu pmu;
 
 #if defined(__arm__)
@@ -116,6 +121,7 @@ static void test_mem_access(void) {}
 static void test_chained_counters(void) {}
 static void test_chained_sw_incr(void) {}
 static void test_chain_promotion(void) {}
+static void test_overflow_interrupt(void) {}
 
 #elif defined(__aarch64__)
 #define ID_AA64DFR0_PERFMON_SHIFT 8
@@ -261,6 +267,44 @@ asm volatile(
 	: "x9", "x10", "cc");
 }
 
+static struct pmu_stats pmu_stats;
+
+static void irq_handler(struct pt_regs *regs)
+{
+	uint32_t irqstat, irqnr;
+
+	irqstat = gic_read_iar();
+	irqnr = gic_iar_irqnr(irqstat);
+	gic_write_eoir(irqstat);
+
+	if (irqnr == 23) {
+		unsigned long overflows = read_sysreg(pmovsclr_el0);
+		int i;
+
+		report_info("--> PMU overflow interrupt %d (counter bitmask 0x%lx)",
+			    irqnr, overflows);
+		for (i = 0; i < 32; i++) {
+			if (test_and_clear_bit(i, &overflows)) {
+				pmu_stats.interrupts[i]++;
+				pmu_stats.bitmap |= 1 << i;
+			}
+		}
+		write_sysreg(0xFFFFFFFF, pmovsclr_el0);
+	} else {
+		report_info("Unexpected interrupt: %d\n", irqnr);
+	}
+}
+
+static void pmu_reset_stats(void)
+{
+	int i;
+
+	for (i = 0; i < 32; i++)
+		pmu_stats.interrupts[i] = 0;
+
+	pmu_stats.bitmap = 0;
+}
+
 static void pmu_reset(void)
 {
 	/* reset all counters, counting disabled at PMCR level*/
@@ -271,6 +315,7 @@ static void pmu_reset(void)
 	write_sysreg(0xFFFFFFFF, pmovsclr_el0);
 	/* disable overflow interrupts on all counters */
 	write_sysreg(0xFFFFFFFF, pmintenclr_el1);
+	pmu_reset_stats();
 	isb();
 }
 
@@ -713,6 +758,95 @@ static void test_chain_promotion(void)
 			read_sysreg(pmovsclr_el0));
 }
 
+static bool expect_interrupts(uint32_t bitmap)
+{
+	int i;
+
+	if (pmu_stats.bitmap ^ bitmap)
+		return false;
+
+	for (i = 0; i < 32; i++) {
+		if (test_and_clear_bit(i, &pmu_stats.bitmap))
+			if (pmu_stats.interrupts[i] != 1)
+				return false;
+	}
+	return true;
+}
+
+static void test_overflow_interrupt(void)
+{
+	uint32_t events[] = { 0x13 /* MEM_ACCESS */, 0x00 /* SW_INCR */};
+	void *addr = malloc(PAGE_SIZE);
+	int i;
+
+	if (!satisfy_prerequisites(events, ARRAY_SIZE(events)))
+		return;
+
+	gic_enable_defaults();
+	install_irq_handler(EL1H_IRQ, irq_handler);
+	local_irq_enable();
+	gic_enable_irq(23);
+
+	pmu_reset();
+
+	write_regn(pmevtyper, 0, events[0] | PMEVTYPER_EXCLUDE_EL0);
+	write_regn(pmevtyper, 1, events[1] | PMEVTYPER_EXCLUDE_EL0);
+	write_sysreg_s(0x3, PMCNTENSET_EL0);
+	write_regn(pmevcntr, 0, 0xFFFFFFF0);
+	write_regn(pmevcntr, 1, 0xFFFFFFF0);
+	isb();
+
+	/* interrupts are disabled */
+
+	mem_access_loop(addr, 200, pmu.pmcr_ro | PMU_PMCR_E);
+	report(expect_interrupts(0), "no overflow interrupt received");
+
+	set_pmcr(pmu.pmcr_ro | PMU_PMCR_E);
+	for (i = 0; i < 100; i++)
+		write_sysreg(0x2, pmswinc_el0);
+
+	set_pmcr(pmu.pmcr_ro);
+	report(expect_interrupts(0), "no overflow interrupt received");
+
+	/* enable interrupts */
+
+	pmu_reset_stats();
+
+	write_regn(pmevcntr, 0, 0xFFFFFFF0);
+	write_regn(pmevcntr, 1, 0xFFFFFFF0);
+	write_sysreg(0xFFFFFFFF, pmintenset_el1);
+	isb();
+
+	mem_access_loop(addr, 200, pmu.pmcr_ro | PMU_PMCR_E);
+	for (i = 0; i < 100; i++)
+		write_sysreg(0x3, pmswinc_el0);
+
+	mem_access_loop(addr, 200, pmu.pmcr_ro);
+	report_info("overflow=0x%lx", read_sysreg(pmovsclr_el0));
+	report(expect_interrupts(0x3),
+		"overflow interrupts expected on #0 and #1");
+
+	/* promote to 64-b */
+
+	pmu_reset_stats();
+
+	events[1] = 0x1E /* CHAIN */;
+	write_regn(pmevtyper, 1, events[1] | PMEVTYPER_EXCLUDE_EL0);
+	write_regn(pmevcntr, 0, 0xFFFFFFF0);
+	isb();
+	mem_access_loop(addr, 200, pmu.pmcr_ro | PMU_PMCR_E);
+	report(expect_interrupts(0),
+		"no overflow interrupt expected on 32b boundary");
+
+	/* overflow on odd counter */
+	pmu_reset_stats();
+	write_regn(pmevcntr, 0, 0xFFFFFFF0);
+	write_regn(pmevcntr, 1, 0xFFFFFFFF);
+	isb();
+	mem_access_loop(addr, 400, pmu.pmcr_ro | PMU_PMCR_E);
+	report(expect_interrupts(0x2),
+		"expect overflow interrupt on odd counter");
+}
 #endif
 
 /*
@@ -921,6 +1055,9 @@ int main(int argc, char *argv[])
 	} else if (strcmp(argv[1], "chain-promotion") == 0) {
 		report_prefix_push(argv[1]);
 		test_chain_promotion();
+	} else if (strcmp(argv[1], "overflow-interrupt") == 0) {
+		report_prefix_push(argv[1]);
+		test_overflow_interrupt();
 	} else {
 		report_abort("Unknown sub-test '%s'", argv[1]);
 	}
diff --git a/arm/unittests.cfg b/arm/unittests.cfg
index eb6e87e..1d1bc27 100644
--- a/arm/unittests.cfg
+++ b/arm/unittests.cfg
@@ -108,6 +108,12 @@ groups = pmu
 arch = arm64
 extra_params = -append 'chain-promotion'
 
+[overflow-interrupt]
+file = pmu.flat
+groups = pmu
+arch = arm64
+extra_params = -append 'overflow-interrupt'
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
