Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C681947068B
	for <lists+kvmarm@lfdr.de>; Fri, 10 Dec 2021 17:58:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 764314B174;
	Fri, 10 Dec 2021 11:58:18 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pOfcsApb49ZZ; Fri, 10 Dec 2021 11:58:18 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D98494B1ED;
	Fri, 10 Dec 2021 11:58:15 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4EBDC4B1BD
 for <kvmarm@lists.cs.columbia.edu>; Fri, 10 Dec 2021 11:58:14 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UrxiNxocc6PN for <kvmarm@lists.cs.columbia.edu>;
 Fri, 10 Dec 2021 11:58:12 -0500 (EST)
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com
 [209.85.216.73])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 721564B1ED
 for <kvmarm@lists.cs.columbia.edu>; Fri, 10 Dec 2021 11:58:12 -0500 (EST)
Received: by mail-pj1-f73.google.com with SMTP id
 a16-20020a17090aa51000b001a78699acceso8547555pjq.8
 for <kvmarm@lists.cs.columbia.edu>; Fri, 10 Dec 2021 08:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=soRf/f86tn9EgpDz/Rxh2hqi6M9zCN/IpkFxvnGPCO0=;
 b=OYPS1qh4ANQgQiAAb+Tmau/RNBCYIbP12Fcrjwkaytv25JIJHVfw6u5BBU0XqmJRNS
 FYzTYQC60QYgACItEttbP03k45/Hg5O4VGRgQbT3H+2cGYv4HuiNMzA5n3/VUG9fXzJ9
 bdeLN7YAK1UEqL1GLalbSztmd1e43YXZJRhmjYBzqcmDSTI7USrwECbboBasNUQVM+XX
 VFwowZRvQ+BooBtqJpw342mWsnpcjlTwVCzdmnX619NSmOcjaEJwu4Qn0bkzAsHFOoWS
 RrVX6hwMgdoj6/FuczQfuqy2CJM/F9RjhDYvTct5CxXHnpZgz1Ry6ZIw4QaoTwbNQE4c
 jn4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=soRf/f86tn9EgpDz/Rxh2hqi6M9zCN/IpkFxvnGPCO0=;
 b=Wk4RhkPX5lTrN9dWKfLnLQwhahQkhCmCDk2ffaALIymeFA3W6D7ufDuMdPVlLnEnpF
 upZ0Aq1ewS8n01A0+d/KluP9Dmi6cHAyWJKFgI75rBnKBBTxchndbW86Xl0b4gF6LRoS
 ccoITZzduETrBEPoZGSIn554EY9ONkspxWrGQZEvaV6i+3BnlEr8Ny4lQkYhzbenDuYD
 nKgB8ajioUABU7l5nOhK1qCUL18LJ/+pn2qgjsWTBHx8/lm7SQ2quu0D5FrqatLLw8vI
 0WJyd7NkUARi0k13SkdQURYJLPqi+XDRftx+Vby+hF7qseexUjbVDbw1Z3zLfsuVH9fT
 J6nw==
X-Gm-Message-State: AOAM531fgyKiCoofTznlP9yrTU31ZcpOZBA0Hv4k30DHT6gUKewAGtNF
 +CYMWbPyAYepBqQ4IcE46M5xcSgWJHfpUQ==
X-Google-Smtp-Source: ABdhPJw9DvlA0cqU820KIioRpH7GZNDlOYSdpCWD+JN1yzQboRKYwTmpx0Szg+6dBvUgXi9jLCgclA0G24K0dw==
X-Received: from ricarkol2.c.googlers.com
 ([fda3:e722:ac3:cc00:24:72f4:c0a8:62fe])
 (user=ricarkol job=sendgmr) by 2002:a62:798e:0:b0:4a7:89cf:8526 with SMTP id
 u136-20020a62798e000000b004a789cf8526mr19011939pfc.10.1639155491469; Fri, 10
 Dec 2021 08:58:11 -0800 (PST)
Date: Fri, 10 Dec 2021 08:58:03 -0800
In-Reply-To: <20211210165804.1623253-1-ricarkol@google.com>
Message-Id: <20211210165804.1623253-3-ricarkol@google.com>
Mime-Version: 1.0
References: <20211210165804.1623253-1-ricarkol@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [kvm-unit-tests PATCH 2/3] arm64: debug: add a migration test for
 watchpoint state
From: Ricardo Koller <ricarkol@google.com>
To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Cc: maz@kernel.org, pshier@google.com, Paolo Bonzini <pbonzini@redhat.com>
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

Test the migration of watchpoint state. Program as many watchpoints as
possible, migrate, and check that we get the corresponding exceptions.

Signed-off-by: Ricardo Koller <ricarkol@google.com>
---
 arm/debug.c       | 164 ++++++++++++++++++++++++++++++++++++++++++++++
 arm/unittests.cfg |  12 ++++
 2 files changed, 176 insertions(+)

diff --git a/arm/debug.c b/arm/debug.c
index fedf4ab..b2240d7 100644
--- a/arm/debug.c
+++ b/arm/debug.c
@@ -9,20 +9,31 @@
 
 #define MDSCR_KDE		(1 << 13)
 #define MDSCR_MDE		(1 << 15)
+#define MDSCR_SS		(1 << 0)
 
 #define DBGBCR_LEN8		(0xff << 5)
 #define DBGBCR_EXEC		(0x0 << 3)
 #define DBGBCR_EL1		(0x1 << 1)
 #define DBGBCR_E		(0x1 << 0)
 
+#define DBGWCR_LEN8		(0xff << 5)
+#define DBGWCR_RD		(0x1 << 3)
+#define DBGWCR_WR		(0x2 << 3)
+#define DBGWCR_EL1		(0x1 << 1)
+#define DBGWCR_E		(0x1 << 0)
+
 #define SPSR_D			(1 << 9)
 
 #define ESR_EC_HW_BP_CURRENT    0x31
+#define ESR_EC_WP_CURRENT       0x35
 
 #define ID_AA64DFR0_BRPS_SHIFT	12
 #define ID_AA64DFR0_BRPS_MASK	0xf
+#define ID_AA64DFR0_WRPS_SHIFT	20
+#define ID_AA64DFR0_WRPS_MASK	0xf
 
 static volatile uint64_t hw_bp_idx, hw_bp_addr[16];
+static volatile uint64_t wp_idx, wp_data_addr[16];
 
 static void hw_bp_handler(struct pt_regs *regs, unsigned int esr)
 {
@@ -30,6 +41,12 @@ static void hw_bp_handler(struct pt_regs *regs, unsigned int esr)
 	regs->pstate |= SPSR_D;
 }
 
+static void wp_handler(struct pt_regs *regs, unsigned int esr)
+{
+	wp_data_addr[wp_idx++] = read_sysreg(far_el1);
+	regs->pstate |= SPSR_D;
+}
+
 static int get_num_hw_bp(void)
 {
 	uint64_t reg = read_sysreg(id_aa64dfr0_el1);
@@ -39,6 +56,15 @@ static int get_num_hw_bp(void)
 	return brps + 1;
 }
 
+static int get_num_wp(void)
+{
+	uint64_t reg = read_sysreg(id_aa64dfr0_el1);
+	/* Number of watchpoints, minus 1 */
+	uint8_t wrps = (reg >> ID_AA64DFR0_WRPS_SHIFT) & ID_AA64DFR0_WRPS_MASK;
+
+	return wrps + 1;
+}
+
 static void write_dbgbcr(int n, uint32_t bcr)
 {
 	switch (n) {
@@ -119,9 +145,90 @@ static void write_dbgbvr(int n, uint64_t bvr)
 	}
 }
 
+static void write_dbgwcr(int n, uint32_t wcr)
+{
+	switch (n) {
+	case 0:
+		write_sysreg(wcr, dbgwcr0_el1); break;
+	case 1:
+		write_sysreg(wcr, dbgwcr1_el1); break;
+	case 2:
+		write_sysreg(wcr, dbgwcr2_el1); break;
+	case 3:
+		write_sysreg(wcr, dbgwcr3_el1); break;
+	case 4:
+		write_sysreg(wcr, dbgwcr4_el1); break;
+	case 5:
+		write_sysreg(wcr, dbgwcr5_el1); break;
+	case 6:
+		write_sysreg(wcr, dbgwcr6_el1); break;
+	case 7:
+		write_sysreg(wcr, dbgwcr7_el1); break;
+	case 8:
+		write_sysreg(wcr, dbgwcr8_el1); break;
+	case 9:
+		write_sysreg(wcr, dbgwcr9_el1); break;
+	case 10:
+		write_sysreg(wcr, dbgwcr10_el1); break;
+	case 11:
+		write_sysreg(wcr, dbgwcr11_el1); break;
+	case 12:
+		write_sysreg(wcr, dbgwcr12_el1); break;
+	case 13:
+		write_sysreg(wcr, dbgwcr13_el1); break;
+	case 14:
+		write_sysreg(wcr, dbgwcr14_el1); break;
+	case 15:
+		write_sysreg(wcr, dbgwcr15_el1); break;
+	default:
+		report_abort("Invalid wcr");
+	}
+}
+
+static void write_dbgwvr(int n, uint64_t wvr)
+{
+	switch (n) {
+	case 0:
+		write_sysreg(wvr, dbgwvr0_el1); break;
+	case 1:
+		write_sysreg(wvr, dbgwvr1_el1); break;
+	case 2:
+		write_sysreg(wvr, dbgwvr2_el1); break;
+	case 3:
+		write_sysreg(wvr, dbgwvr3_el1); break;
+	case 4:
+		write_sysreg(wvr, dbgwvr4_el1); break;
+	case 5:
+		write_sysreg(wvr, dbgwvr5_el1); break;
+	case 6:
+		write_sysreg(wvr, dbgwvr6_el1); break;
+	case 7:
+		write_sysreg(wvr, dbgwvr7_el1); break;
+	case 8:
+		write_sysreg(wvr, dbgwvr8_el1); break;
+	case 9:
+		write_sysreg(wvr, dbgwvr9_el1); break;
+	case 10:
+		write_sysreg(wvr, dbgwvr10_el1); break;
+	case 11:
+		write_sysreg(wvr, dbgwvr11_el1); break;
+	case 12:
+		write_sysreg(wvr, dbgwvr12_el1); break;
+	case 13:
+		write_sysreg(wvr, dbgwvr13_el1); break;
+	case 14:
+		write_sysreg(wvr, dbgwvr14_el1); break;
+	case 15:
+		write_sysreg(wvr, dbgwvr15_el1); break;
+	default:
+		report_abort("invalid wvr");
+	}
+}
+
 static void reset_debug_state(void)
 {
 	int i, num_bp = get_num_hw_bp();
+	int num_wp = get_num_wp();
 
 	asm volatile("msr daifset, #8");
 
@@ -134,6 +241,10 @@ static void reset_debug_state(void)
 		write_dbgbvr(i, 0);
 		write_dbgbcr(i, 0);
 	}
+	for (i = 0; i < num_wp; i++) {
+		write_dbgwvr(i, 0);
+		write_dbgwcr(i, 0);
+	}
 	isb();
 }
 
@@ -188,6 +299,51 @@ static void test_hw_bp(bool migrate)
 		report(hw_bp_addr[i] == addr, "hw breakpoint: %d", i);
 }
 
+static volatile char write_data[16];
+
+static void test_wp(bool migrate)
+{
+	uint32_t wcr;
+	uint32_t mdscr;
+	int num_wp = get_num_wp();
+	int i;
+
+	install_exception_handler(EL1H_SYNC, ESR_EC_WP_CURRENT, wp_handler);
+
+	reset_debug_state();
+
+	wcr = DBGWCR_LEN8 | DBGWCR_RD | DBGWCR_WR | DBGWCR_EL1 | DBGWCR_E;
+	for (i = 0; i < num_wp; i++) {
+		write_dbgwcr(i, wcr);
+		write_dbgwvr(i, (uint64_t)&write_data[i]);
+	}
+	isb();
+
+	asm volatile("msr daifclr, #8");
+
+	mdscr = read_sysreg(mdscr_el1) | MDSCR_KDE | MDSCR_MDE;
+	write_sysreg(mdscr, mdscr_el1);
+	isb();
+
+	if (migrate) {
+		do_migrate();
+		report(num_wp == get_num_wp(), "wrps match after migrate");
+	}
+
+	wp_idx = 0;
+
+	for (i = 0; i < num_wp; i++) {
+		write_data[i] = i;
+		asm volatile("msr daifclr, #8");
+	}
+
+	for (i = 0; i < num_wp; i++) {
+		report(wp_data_addr[i] == (uint64_t)&write_data[i],
+			"watchpoint received: %d", i);
+		report(write_data[i] == i, "watchpoint data: %d", i);
+	}
+}
+
 int main(int argc, char **argv)
 {
 	if (argc < 2)
@@ -201,6 +357,14 @@ int main(int argc, char **argv)
 		report_prefix_push(argv[1]);
 		test_hw_bp(true);
 		report_prefix_pop();
+	} else if (strcmp(argv[1], "wp") == 0) {
+		report_prefix_push(argv[1]);
+		test_wp(false);
+		report_prefix_pop();
+	} else if (strcmp(argv[1], "wp-migration") == 0) {
+		report_prefix_push(argv[1]);
+		test_wp(true);
+		report_prefix_pop();
 	} else {
 		report_abort("Unknown subtest '%s'", argv[1]);
 	}
diff --git a/arm/unittests.cfg b/arm/unittests.cfg
index 896ff87..bca2fad 100644
--- a/arm/unittests.cfg
+++ b/arm/unittests.cfg
@@ -254,3 +254,15 @@ file = debug.flat
 arch = arm64
 extra_params = -append 'bp-migration'
 groups = debug migration
+
+[debug-wp]
+file = debug.flat
+arch = arm64
+extra_params = -append 'wp'
+groups = debug
+
+[debug-wp-migration]
+file = debug.flat
+arch = arm64
+extra_params = -append 'wp-migration'
+groups = debug migration
-- 
2.34.1.173.g76aa8bc2d0-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
