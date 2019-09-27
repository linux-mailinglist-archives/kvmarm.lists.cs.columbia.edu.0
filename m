Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 12440C0396
	for <lists+kvmarm@lfdr.de>; Fri, 27 Sep 2019 12:42:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B5B014A75B;
	Fri, 27 Sep 2019 06:42:40 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UW9oBeOXQXew; Fri, 27 Sep 2019 06:42:39 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 196D94A758;
	Fri, 27 Sep 2019 06:42:39 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 933FA4A72B
 for <kvmarm@lists.cs.columbia.edu>; Fri, 27 Sep 2019 06:42:37 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ING+R81aVdjf for <kvmarm@lists.cs.columbia.edu>;
 Fri, 27 Sep 2019 06:42:36 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4042E4A728
 for <kvmarm@lists.cs.columbia.edu>; Fri, 27 Sep 2019 06:42:36 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2E271570;
 Fri, 27 Sep 2019 03:42:35 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.197.44])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2FF213F534;
 Fri, 27 Sep 2019 03:42:35 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Andrew Jones <drjones@redhat.com>
Subject: [kvm-unit-tests PATCH 2/6] arm: gic: Split variable output data from
 test name
Date: Fri, 27 Sep 2019 11:42:23 +0100
Message-Id: <20190927104227.253466-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190927104227.253466-1-andre.przywara@arm.com>
References: <20190927104227.253466-1-andre.przywara@arm.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

For some tests we mix variable diagnostic output with the test name,
which leads to variable test line, confusing some higher level
frameworks.

Split the output to always use the same test name for a certain test,
and put diagnostic output on a separate line using the INFO: tag.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arm/gic.c | 45 ++++++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/arm/gic.c b/arm/gic.c
index 6fd5e5e..66dcafe 100644
--- a/arm/gic.c
+++ b/arm/gic.c
@@ -353,8 +353,8 @@ static void test_typer_v2(uint32_t reg)
 {
 	int nr_gic_cpus = ((reg >> 5) & 0x7) + 1;
 
-	report("all %d CPUs have interrupts", nr_cpus == nr_gic_cpus,
-	       nr_gic_cpus);
+	report("all CPUs have interrupts", nr_cpus == nr_gic_cpus);
+	report_info("having %d CPUs", nr_gic_cpus);
 }
 
 #define BYTE(reg32, byte) (((reg32) >> ((byte) * 8)) & 0xff)
@@ -370,16 +370,21 @@ static void test_typer_v2(uint32_t reg)
 static void test_byte_access(void *base_addr, u32 pattern, u32 mask)
 {
 	u32 reg = readb(base_addr + 1);
+	bool res;
 
-	report("byte reads successful (0x%08x => 0x%02x)",
-	       reg == (BYTE(pattern, 1) & (mask >> 8)),
-	       pattern & mask, reg);
+	res = (reg == (BYTE(pattern, 1) & (mask >> 8)));
+	report("byte reads successful", res);
+	if (!res)
+		report_info("byte 1 of 0x%08x => 0x%02x", pattern & mask, reg);
 
 	pattern = REPLACE_BYTE(pattern, 2, 0x1f);
 	writeb(BYTE(pattern, 2), base_addr + 2);
 	reg = readl(base_addr);
-	report("byte writes successful (0x%02x => 0x%08x)",
-	       reg == (pattern & mask), BYTE(pattern, 2), reg);
+	res = (reg == (pattern & mask));
+	report("byte writes successful", res);
+	if (!res)
+		report_info("writing 0x%02x into bytes 2 => 0x%08x",
+			    BYTE(pattern, 2), reg);
 }
 
 static void test_priorities(int nr_irqs, void *priptr)
@@ -399,15 +404,16 @@ static void test_priorities(int nr_irqs, void *priptr)
 	pri_mask = readl(first_spi);
 
 	reg = ~pri_mask;
-	report("consistent priority masking (0x%08x)",
+	report("consistent priority masking",
 	       (((reg >> 16) == (reg & 0xffff)) &&
-	        ((reg & 0xff) == ((reg >> 8) & 0xff))), pri_mask);
+	        ((reg & 0xff) == ((reg >> 8) & 0xff))));
+	report_info("priority mask is 0x%08x", pri_mask);
 
 	reg = reg & 0xff;
 	for (pri_bits = 8; reg & 1; reg >>= 1, pri_bits--)
 		;
-	report("implements at least 4 priority bits (%d)",
-	       pri_bits >= 4, pri_bits);
+	report("implements at least 4 priority bits", pri_bits >= 4);
+	report_info("%d priority bits implemented", pri_bits);
 
 	pattern = 0;
 	writel(pattern, first_spi);
@@ -452,9 +458,9 @@ static void test_targets(int nr_irqs)
 	/* Check that bits for non implemented CPUs are RAZ/WI. */
 	if (nr_cpus < 8) {
 		writel(0xffffffff, targetsptr + GIC_FIRST_SPI);
-		report("bits for %d non-existent CPUs masked",
-		       !(readl(targetsptr + GIC_FIRST_SPI) & ~cpu_mask),
-		       8 - nr_cpus);
+		report("bits for non-existent CPUs masked",
+		       !(readl(targetsptr + GIC_FIRST_SPI) & ~cpu_mask));
+		report_info("%d non-existent CPUs", 8 - nr_cpus);
 	} else {
 		report_skip("CPU masking (all CPUs implemented)");
 	}
@@ -465,8 +471,10 @@ static void test_targets(int nr_irqs)
 	pattern = 0x0103020f;
 	writel(pattern, targetsptr + GIC_FIRST_SPI);
 	reg = readl(targetsptr + GIC_FIRST_SPI);
-	report("register content preserved (%08x => %08x)",
-	       reg == (pattern & cpu_mask), pattern & cpu_mask, reg);
+	report("register content preserved", reg == (pattern & cpu_mask));
+	if (reg != (pattern & cpu_mask))
+		report_info("writing %08x reads back as %08x",
+			    pattern & cpu_mask, reg);
 
 	/* The TARGETS registers are byte accessible. */
 	test_byte_access(targetsptr + GIC_FIRST_SPI, pattern, cpu_mask);
@@ -505,9 +513,8 @@ static void gic_test_mmio(void)
 	       test_readonly_32(gic_dist_base + GICD_IIDR, false));
 
 	reg = readl(idreg);
-	report("ICPIDR2 is read-only (0x%08x)",
-	       test_readonly_32(idreg, false),
-	       reg);
+	report("ICPIDR2 is read-only", test_readonly_32(idreg, false));
+	report_info("value of ICPIDR2: 0x%08x", reg);
 
 	test_priorities(nr_irqs, gic_dist_base + GICD_IPRIORITYR);
 
-- 
2.17.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
