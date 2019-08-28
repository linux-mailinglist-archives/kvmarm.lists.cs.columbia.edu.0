Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 68F3EA0376
	for <lists+kvmarm@lfdr.de>; Wed, 28 Aug 2019 15:39:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 16F944A596;
	Wed, 28 Aug 2019 09:39:14 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RieP9fYXhPBz; Wed, 28 Aug 2019 09:39:12 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A89CE4A5EE;
	Wed, 28 Aug 2019 09:39:10 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C1AD24A594
 for <kvmarm@lists.cs.columbia.edu>; Wed, 28 Aug 2019 09:39:09 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RJZDz2Vah1mv for <kvmarm@lists.cs.columbia.edu>;
 Wed, 28 Aug 2019 09:39:08 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B00AB4A599
 for <kvmarm@lists.cs.columbia.edu>; Wed, 28 Aug 2019 09:39:06 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71E42360;
 Wed, 28 Aug 2019 06:39:06 -0700 (PDT)
Received: from e121566-lin.cambridge.arm.com (e121566-lin.cambridge.arm.com
 [10.1.196.217])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5319C3F246;
 Wed, 28 Aug 2019 06:39:05 -0700 (PDT)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: kvm@vger.kernel.org,
	kvmarm@lists.cs.columbia.edu
Subject: [kvm-unit-tests RFC PATCH 12/16] arm64: timer: Add test for EL2 timers
Date: Wed, 28 Aug 2019 14:38:27 +0100
Message-Id: <1566999511-24916-13-git-send-email-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566999511-24916-1-git-send-email-alexandru.elisei@arm.com>
References: <1566999511-24916-1-git-send-email-alexandru.elisei@arm.com>
Cc: maz@kernel.org, andre.przywara@arm.com, pbonzini@redhat.com
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

When VHE is available, EL2 has two extra timers, the physical and virtual
EL2 timers. Extend the timer test to include them.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
I'm seeing three failed tests when running at EL2, I'm investigating those
to figure out if it's KVM or kvm-unit-tests related.

 lib/arm64/asm/sysreg.h |   8 +++
 arm/timer.c            | 150 +++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 154 insertions(+), 4 deletions(-)

diff --git a/lib/arm64/asm/sysreg.h b/lib/arm64/asm/sysreg.h
index ed407f93330d..02054fbe2763 100644
--- a/lib/arm64/asm/sysreg.h
+++ b/lib/arm64/asm/sysreg.h
@@ -19,6 +19,14 @@
 #define SYS_CNTV_CTL_EL02	sys_reg(3, 5, 14, 3, 1)
 #define SYS_CNTV_CVAL_EL02	sys_reg(3, 5, 14, 3, 2)
 
+#define SYS_CNTHP_TVAL_EL2	sys_reg(3, 4, 14, 2, 0)
+#define SYS_CNTHP_CTL_EL2	sys_reg(3, 4, 14, 2, 1)
+#define SYS_CNTHP_CVAL_EL2	sys_reg(3, 4, 14, 2, 2)
+
+#define SYS_CNTHV_TVAL_EL2	sys_reg(3, 4, 14, 3, 0)
+#define SYS_CNTHV_CTL_EL2	sys_reg(3, 4, 14, 3, 1)
+#define SYS_CNTHV_CVAL_EL2	sys_reg(3, 4, 14, 3, 2)
+
 #ifdef __ASSEMBLY__
 	.irp	num,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30
 	.equ	.L__reg_num_x\num, \num
diff --git a/arm/timer.c b/arm/timer.c
index 29477ee65878..faab671d0fb1 100644
--- a/arm/timer.c
+++ b/arm/timer.c
@@ -23,6 +23,8 @@ static void *gic_icenabler;
 
 static bool ptimer_unsupported;
 
+static int current_el;
+
 static void ptimer_unsupported_handler(struct pt_regs *regs, unsigned int esr)
 {
 	ptimer_unsupported = true;
@@ -159,6 +161,66 @@ static void write_ptimer_ctl_vhe(u64 val)
 	write_sysreg_s(val, SYS_CNTP_CTL_EL02);
 }
 
+static u64 read_hvtimer_cval(void)
+{
+	return read_sysreg_s(SYS_CNTHV_CVAL_EL2);
+}
+
+static void write_hvtimer_cval(u64 val)
+{
+	write_sysreg_s(val, SYS_CNTHV_CVAL_EL2);
+}
+
+static s32 read_hvtimer_tval(void)
+{
+	return read_sysreg_s(SYS_CNTHV_TVAL_EL2);
+}
+
+static void write_hvtimer_tval(s32 val)
+{
+	write_sysreg_s(val, SYS_CNTHV_TVAL_EL2);
+}
+
+static u64 read_hvtimer_ctl(void)
+{
+	return read_sysreg_s(SYS_CNTHV_CTL_EL2);
+}
+
+static void write_hvtimer_ctl(u64 val)
+{
+	write_sysreg_s(val, SYS_CNTHV_CTL_EL2);
+}
+
+static u64 read_hptimer_cval(void)
+{
+	return read_sysreg_s(SYS_CNTHP_CVAL_EL2);
+}
+
+static void write_hptimer_cval(u64 val)
+{
+	write_sysreg_s(val, SYS_CNTHP_CVAL_EL2);
+}
+
+static s32 read_hptimer_tval(void)
+{
+	return read_sysreg_s(SYS_CNTHP_TVAL_EL2);
+}
+
+static void write_hptimer_tval(s32 val)
+{
+	write_sysreg_s(val, SYS_CNTHP_TVAL_EL2);
+}
+
+static u64 read_hptimer_ctl(void)
+{
+	return read_sysreg_s(SYS_CNTHP_CTL_EL2);
+}
+
+static void write_hptimer_ctl(u64 val)
+{
+	write_sysreg_s(val, SYS_CNTHP_CTL_EL2);
+}
+
 struct timer_info {
 	u32 irq;
 	u32 irq_flags;
@@ -216,7 +278,29 @@ static struct timer_info ptimer_info_vhe = {
 	.write_ctl = write_ptimer_ctl_vhe,
 };
 
-static struct timer_info *vtimer, *ptimer;
+static struct timer_info hvtimer_info = {
+	.irq_received = false,
+	.read_counter = read_vtimer_counter,
+	.read_cval = read_hvtimer_cval,
+	.write_cval = write_hvtimer_cval,
+	.read_tval = read_hvtimer_tval,
+	.write_tval = write_hvtimer_tval,
+	.read_ctl = read_hvtimer_ctl,
+	.write_ctl = write_hvtimer_ctl,
+};
+
+static struct timer_info hptimer_info = {
+	.irq_received = false,
+	.read_counter = read_ptimer_counter,
+	.read_cval = read_hptimer_cval,
+	.write_cval = write_hptimer_cval,
+	.read_tval = read_hptimer_tval,
+	.write_tval = write_hptimer_tval,
+	.read_ctl = read_hptimer_ctl,
+	.write_ctl = write_hptimer_ctl,
+};
+
+static struct timer_info *vtimer, *ptimer, *hvtimer, *hptimer;
 
 static void set_timer_irq_enabled(struct timer_info *info, bool enabled)
 {
@@ -241,6 +325,10 @@ static void irq_handler(struct pt_regs *regs)
 		info = vtimer;
 	} else if (irqnr == PPI(ptimer->irq)) {
 		info = ptimer;
+	} else if (current_el == CurrentEL_EL2 && irqnr == PPI(hptimer->irq)) {
+		info = hptimer;
+	} else if (current_el == CurrentEL_EL2 && irqnr == PPI(hvtimer->irq)) {
+		info = hvtimer;
 	} else {
 		report_info("Unexpected interrupt: %d\n", irqnr);
 		return;
@@ -362,6 +450,20 @@ static void test_ptimer(void)
 	report_prefix_pop();
 }
 
+static void test_hvtimer(void)
+{
+	report_prefix_push("hvtimer-busy-loop");
+	test_timer(hvtimer);
+	report_prefix_pop();
+}
+
+static void test_hptimer(void)
+{
+	report_prefix_push("hptimer-busy-loop");
+	test_timer(hptimer);
+	report_prefix_pop();
+}
+
 static void test_init(void)
 {
 	const struct fdt_property *prop;
@@ -369,12 +471,14 @@ static void test_init(void)
 	int node, len;
 	u32 *data;
 
-	if (current_level() == CurrentEL_EL1) {
+	if (current_el == CurrentEL_EL1) {
 		vtimer = &vtimer_info;
 		ptimer = &ptimer_info;
 	} else {
 		vtimer = &vtimer_info_vhe;
 		ptimer = &ptimer_info_vhe;
+		hvtimer = &hvtimer_info;
+		hptimer = &hptimer_info;
 	}
 
 	node = fdt_node_offset_by_compatible(fdt, -1, "arm,armv8-timer");
@@ -390,6 +494,19 @@ static void test_init(void)
 	vtimer->irq = fdt32_to_cpu(data[7]);
 	vtimer->irq_flags = fdt32_to_cpu(data[8]);
 
+	if (current_el == CurrentEL_EL2) {
+		assert(fdt32_to_cpu(data[9]) == 1);
+		hptimer->irq = fdt32_to_cpu(data[10]);
+		hptimer->irq_flags = fdt32_to_cpu(data[11]);
+		/* The hvtimer is not in the DT, assume KVM default. */
+		hvtimer->irq = 28;
+		/*
+		 * With VHE, accesses to the vtimer are redirected to the
+		 * hvtimer. They should have the same interrupt properties.
+		 */
+		hvtimer->irq_flags = vtimer->irq_flags;
+	}
+
 	install_exception_handler(EL1H_SYNC, ESR_EL1_EC_UNKNOWN, ptimer_unsupported_handler);
 	ptimer->read_ctl();
 	install_exception_handler(EL1H_SYNC, ESR_EL1_EC_UNKNOWN, NULL);
@@ -433,12 +550,22 @@ static void print_timer_info(void)
 	printf("CNTVCT_EL0   : 0x%016lx\n", vtimer->read_counter());
 	printf("CNTV_CTL_EL0 : 0x%016lx\n", vtimer->read_ctl());
 	printf("CNTV_CVAL_EL0: 0x%016lx\n", vtimer->read_cval());
+
+	if (current_el == CurrentEL_EL2) {
+		printf("CNTHP_CTL_EL0 : 0x%016lx\n", hptimer->read_ctl());
+		printf("CNTHP_CVAL_EL0: 0x%016lx\n", hptimer->read_cval());
+
+		printf("CNTHV_CTL_EL0 : 0x%016lx\n", hvtimer->read_ctl());
+		printf("CNTHV_CVAL_EL0: 0x%016lx\n", hvtimer->read_cval());
+	}
 }
 
 int main(int argc, char **argv)
 {
 	int i;
 
+	current_el = current_level();
+
 	test_init();
 
 	print_timer_info();
@@ -446,13 +573,28 @@ int main(int argc, char **argv)
 	if (argc == 1) {
 		test_vtimer();
 		test_ptimer();
+		if (current_el == CurrentEL_EL2) {
+			test_hvtimer();
+			test_hptimer();
+		}
 	}
 
 	for (i = 1; i < argc; ++i) {
-		if (strcmp(argv[i], "vtimer") == 0)
+		if (strcmp(argv[i], "vtimer") == 0) {
 			test_vtimer();
-		if (strcmp(argv[i], "ptimer") == 0)
+		} if (strcmp(argv[i], "ptimer") == 0) {
 			test_ptimer();
+		} if (strcmp(argv[i], "hvtimer") == 0) {
+			if (current_el == CurrentEL_EL1)
+				report_info("Skipping hvtimer tests. Boot at EL2 to enable.");
+			else
+				test_hvtimer();
+		} if (strcmp(argv[i], "hptimer") == 0) {
+			if (current_el == CurrentEL_EL1)
+				report_info("Skipping hptimer tests. Boot at EL2 to enable.");
+			else
+				test_hptimer();
+		}
 	}
 
 	return report_summary();
-- 
2.7.4

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
