Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 13F15669CB
	for <lists+kvmarm@lfdr.de>; Fri, 12 Jul 2019 11:19:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 414734A548;
	Fri, 12 Jul 2019 05:19:58 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -3.291
X-Spam-Level: 
X-Spam-Status: No, score=-3.291 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_ALL=0.8, DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_HI=-5, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@amazon.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ILj-uviIetyD; Fri, 12 Jul 2019 05:19:58 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B83C64A52E;
	Fri, 12 Jul 2019 05:19:54 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 50C224A516
 for <kvmarm@lists.cs.columbia.edu>; Fri, 12 Jul 2019 05:19:53 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CCD5B5-UqMXE for <kvmarm@lists.cs.columbia.edu>;
 Fri, 12 Jul 2019 05:19:52 -0400 (EDT)
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id F17284A4EA
 for <kvmarm@lists.cs.columbia.edu>; Fri, 12 Jul 2019 05:19:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1562923191; x=1594459191;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=LWHBz0SXs21KNm8cdEH/yPSg9EsuzjCCxxmRa6sgvcw=;
 b=ESdtm/N4p7hwK+w4Ca0P80KUtjwJqUeIfFzZcPfYWB7BgQwiq8cD0wWe
 DG+hWx91eQyYWn7xigecPOYLbkHSI3zKxMoWCdim8Zfup0EzsrnwSWowP
 dgBYA9F0UzW01DGmVHR0KFmfRbmrbOCgrZK5S9I+NWR9L9SFAXGySZlxs I=;
X-IronPort-AV: E=Sophos;i="5.62,481,1554768000"; d="scan'208";a="741478283"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO
 email-inbound-relay-1d-2c665b5d.us-east-1.amazon.com) ([10.124.125.2])
 by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP;
 12 Jul 2019 09:19:50 +0000
Received: from EX13MTAUWC001.ant.amazon.com
 (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
 by email-inbound-relay-1d-2c665b5d.us-east-1.amazon.com (Postfix) with ESMTPS
 id BF68FA2134; Fri, 12 Jul 2019 09:19:48 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 12 Jul 2019 09:19:48 +0000
Received: from u79c5a0a55de558.ant.amazon.com (10.43.160.20) by
 EX13D20UWC001.ant.amazon.com (10.43.162.244) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 12 Jul 2019 09:19:45 +0000
From: Alexander Graf <graf@amazon.com>
To: <kvm@vger.kernel.org>
Subject: [PATCH kvm-unit-tests v2] arm: Add PL031 test
Date: Fri, 12 Jul 2019 11:19:38 +0200
Message-ID: <20190712091938.492-1-graf@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.43.160.20]
X-ClientProxiedBy: EX13D01UWB004.ant.amazon.com (10.43.161.157) To
 EX13D20UWC001.ant.amazon.com (10.43.162.244)
Cc: Marc Zyngier <marc.zyngier@arm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 kvmarm@lists.cs.columbia.edu, Andre Przywara <andre.przywara@arm.com>
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

This patch adds a unit test for the PL031 RTC that is used in the virt machine.
It just pokes basic functionality. I've mostly written it to familiarize myself
with the device, but I suppose having the test around does not hurt, as it also
exercises the GIC SPI interrupt path.

Signed-off-by: Alexander Graf <graf@amazon.com>

---

v1 -> v2:

  - Use FDT to find base, irq and existence
  - Put isb after timer read
  - Use dist_base for gicv3
---
 arm/Makefile.common |   1 +
 arm/pl031.c         | 265 ++++++++++++++++++++++++++++++++++++++++++++
 lib/arm/asm/gic.h   |   1 +
 3 files changed, 267 insertions(+)
 create mode 100644 arm/pl031.c

diff --git a/arm/Makefile.common b/arm/Makefile.common
index f0c4b5d..b8988f2 100644
--- a/arm/Makefile.common
+++ b/arm/Makefile.common
@@ -11,6 +11,7 @@ tests-common += $(TEST_DIR)/pmu.flat
 tests-common += $(TEST_DIR)/gic.flat
 tests-common += $(TEST_DIR)/psci.flat
 tests-common += $(TEST_DIR)/sieve.flat
+tests-common += $(TEST_DIR)/pl031.flat
 
 tests-all = $(tests-common) $(tests)
 all: directories $(tests-all)
diff --git a/arm/pl031.c b/arm/pl031.c
new file mode 100644
index 0000000..d975937
--- /dev/null
+++ b/arm/pl031.c
@@ -0,0 +1,265 @@
+/*
+ * Verify PL031 functionality
+ *
+ * This test verifies whether the emulated PL031 behaves correctly.
+ *
+ * Copyright 2019 Amazon.com, Inc. or its affiliates.
+ * Author: Alexander Graf <graf@amazon.com>
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2.
+ */
+#include <libcflat.h>
+#include <devicetree.h>
+#include <asm/processor.h>
+#include <asm/io.h>
+#include <asm/gic.h>
+
+struct pl031_regs {
+	uint32_t dr;	/* Data Register */
+	uint32_t mr;	/* Match Register */
+	uint32_t lr;	/* Load Register */
+	union {
+		uint8_t cr;	/* Control Register */
+		uint32_t cr32;
+	};
+	union {
+		uint8_t imsc;	/* Interrupt Mask Set or Clear register */
+		uint32_t imsc32;
+	};
+	union {
+		uint8_t ris;	/* Raw Interrupt Status */
+		uint32_t ris32;
+	};
+	union {
+		uint8_t mis;	/* Masked Interrupt Status */
+		uint32_t mis32;
+	};
+	union {
+		uint8_t icr;	/* Interrupt Clear Register */
+		uint32_t icr32;
+	};
+	uint32_t reserved[1008];
+	uint32_t periph_id[4];
+	uint32_t pcell_id[4];
+};
+
+static u32 cntfrq;
+static struct pl031_regs *pl031;
+static int pl031_irq;
+static void *gic_ispendr;
+static void *gic_isenabler;
+static bool irq_triggered;
+
+static uint64_t read_timer(void)
+{
+	uint64_t r = read_sysreg(cntpct_el0);
+	isb();
+
+	return r;
+}
+
+static int check_id(void)
+{
+	uint32_t id[] = { 0x31, 0x10, 0x14, 0x00, 0x0d, 0xf0, 0x05, 0xb1 };
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(id); i++)
+		if (id[i] != readl(&pl031->periph_id[i]))
+			return 1;
+
+	return 0;
+}
+
+static int check_ro(void)
+{
+	uint32_t offs[] = { offsetof(struct pl031_regs, ris),
+			    offsetof(struct pl031_regs, mis),
+			    offsetof(struct pl031_regs, periph_id[0]),
+			    offsetof(struct pl031_regs, periph_id[1]),
+			    offsetof(struct pl031_regs, periph_id[2]),
+			    offsetof(struct pl031_regs, periph_id[3]),
+			    offsetof(struct pl031_regs, pcell_id[0]),
+			    offsetof(struct pl031_regs, pcell_id[1]),
+			    offsetof(struct pl031_regs, pcell_id[2]),
+			    offsetof(struct pl031_regs, pcell_id[3]) };
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(offs); i++) {
+		uint32_t before32;
+		uint16_t before16;
+		uint8_t before8;
+		void *addr = (void*)pl031 + offs[i];
+		uint32_t poison = 0xdeadbeefULL;
+
+		before8 = readb(addr);
+		before16 = readw(addr);
+		before32 = readl(addr);
+
+		writeb(poison, addr);
+		writew(poison, addr);
+		writel(poison, addr);
+
+		if (before8 != readb(addr))
+			return 1;
+		if (before16 != readw(addr))
+			return 1;
+		if (before32 != readl(addr))
+			return 1;
+	}
+
+	return 0;
+}
+
+static int check_rtc_freq(void)
+{
+	uint32_t seconds_to_wait = 2;
+	uint32_t before = readl(&pl031->dr);
+	uint64_t before_tick = read_timer();
+	uint64_t target_tick = before_tick + (cntfrq * seconds_to_wait);
+
+	/* Wait for 2 seconds */
+	while (read_timer() < target_tick) ;
+
+	if (readl(&pl031->dr) != before + seconds_to_wait)
+		return 1;
+
+	return 0;
+}
+
+static bool gic_irq_pending(void)
+{
+	uint32_t offset = (pl031_irq / 32) * 4;
+
+	return readl(gic_ispendr + offset) & (1 << (pl031_irq & 31));
+}
+
+static void gic_irq_unmask(void)
+{
+	uint32_t offset = (pl031_irq / 32) * 4;
+
+	writel(1 << (pl031_irq & 31), gic_isenabler + offset);
+}
+
+static void irq_handler(struct pt_regs *regs)
+{
+	u32 irqstat = gic_read_iar();
+	u32 irqnr = gic_iar_irqnr(irqstat);
+
+	gic_write_eoir(irqstat);
+
+	if (irqnr == pl031_irq) {
+		report("  RTC RIS == 1", readl(&pl031->ris) == 1);
+		report("  RTC MIS == 1", readl(&pl031->mis) == 1);
+
+		/* Writing any value should clear IRQ status */
+		writel(0x80000000ULL, &pl031->icr);
+
+		report("  RTC RIS == 0", readl(&pl031->ris) == 0);
+		report("  RTC MIS == 0", readl(&pl031->mis) == 0);
+		irq_triggered = true;
+	} else {
+		report_info("Unexpected interrupt: %d\n", irqnr);
+		return;
+	}
+}
+
+static int check_rtc_irq(void)
+{
+	uint32_t seconds_to_wait = 1;
+	uint32_t before = readl(&pl031->dr);
+	uint64_t before_tick = read_timer();
+	uint64_t target_tick = before_tick + (cntfrq * (seconds_to_wait + 1));
+
+	report_info("Checking IRQ trigger (MR)");
+
+	irq_triggered = false;
+
+	/* Fire IRQ in 1 second */
+	writel(before + seconds_to_wait, &pl031->mr);
+
+	install_irq_handler(EL1H_IRQ, irq_handler);
+
+	/* Wait until 2 seconds are over */
+	while (read_timer() < target_tick) ;
+
+	report("  RTC IRQ not delivered without mask", !gic_irq_pending());
+
+	/* Mask the IRQ so that it gets delivered */
+	writel(1, &pl031->imsc);
+	report("  RTC IRQ pending now", gic_irq_pending());
+
+	/* Enable retrieval of IRQ */
+	gic_irq_unmask();
+	local_irq_enable();
+
+	report("  IRQ triggered", irq_triggered);
+	report("  RTC IRQ not pending anymore", !gic_irq_pending());
+	if (!irq_triggered) {
+		report_info("  RTC RIS: %x", readl(&pl031->ris));
+		report_info("  RTC MIS: %x", readl(&pl031->mis));
+		report_info("  RTC IMSC: %x", readl(&pl031->imsc));
+		report_info("  GIC IRQs pending: %08x %08x", readl(gic_ispendr), readl(gic_ispendr + 4));
+	}
+
+	local_irq_disable();
+	return 0;
+}
+
+static void rtc_irq_init(void)
+{
+	gic_enable_defaults();
+
+	switch (gic_version()) {
+	case 2:
+		gic_ispendr = gicv2_dist_base() + GICD_ISPENDR;
+		gic_isenabler = gicv2_dist_base() + GICD_ISENABLER;
+		break;
+	case 3:
+		gic_ispendr = gicv3_dist_base() + GICD_ISPENDR;
+		gic_isenabler = gicv3_dist_base() + GICD_ISENABLER;
+		break;
+	}
+}
+
+static int rtc_fdt_init(void)
+{
+	const struct fdt_property *prop;
+	const void *fdt = dt_fdt();
+	int node, len;
+	u32 *data;
+
+	node = fdt_node_offset_by_compatible(fdt, -1, "arm,pl031");
+	if (node < 0)
+		return -1;
+
+	prop = fdt_get_property(fdt, node, "interrupts", &len);
+	assert(prop && len == (3 * sizeof(u32)));
+	data = (u32 *)prop->data;
+	assert(data[0] == 0); /* SPI */
+	pl031_irq = SPI(fdt32_to_cpu(data[1]));
+
+	prop = fdt_get_property(fdt, node, "reg", &len);
+	assert(prop && len == (2 * sizeof(u64)));
+	data = (u32 *)prop->data;
+	pl031 = (void*)((ulong)fdt32_to_cpu(data[0]) << 32 | fdt32_to_cpu(data[1]));
+
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	cntfrq = get_cntfrq();
+	rtc_irq_init();
+	if (rtc_fdt_init()) {
+		report_skip("Skipping PL031 tests. No device present.");
+		return 0;
+	}
+
+	report("Periph/PCell IDs match", !check_id());
+	report("R/O fields are R/O", !check_ro());
+	report("RTC ticks at 1HZ", !check_rtc_freq());
+	report("RTC IRQ not pending yet", !gic_irq_pending());
+	check_rtc_irq();
+
+	return report_summary();
+}
diff --git a/lib/arm/asm/gic.h b/lib/arm/asm/gic.h
index f6dfb90..1fc10a0 100644
--- a/lib/arm/asm/gic.h
+++ b/lib/arm/asm/gic.h
@@ -41,6 +41,7 @@
 #include <asm/gic-v3.h>
 
 #define PPI(irq)			((irq) + 16)
+#define SPI(irq)			((irq) + GIC_FIRST_SPI)
 
 #ifndef __ASSEMBLY__
 #include <asm/cpumask.h>
-- 
2.17.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
