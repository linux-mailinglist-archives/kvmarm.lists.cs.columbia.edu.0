Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 64A92506A10
	for <lists+kvmarm@lfdr.de>; Tue, 19 Apr 2022 13:25:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 11BAE4B218;
	Tue, 19 Apr 2022 07:25:42 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3hB42zJdWtdN; Tue, 19 Apr 2022 07:25:40 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3E1E040FF0;
	Tue, 19 Apr 2022 07:25:40 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D74C440B6C
 for <kvmarm@lists.cs.columbia.edu>; Tue, 19 Apr 2022 07:25:38 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Rn9w0v1TzpoB for <kvmarm@lists.cs.columbia.edu>;
 Tue, 19 Apr 2022 07:25:34 -0400 (EDT)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D51CE49EFE
 for <kvmarm@lists.cs.columbia.edu>; Tue, 19 Apr 2022 07:25:32 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 97E11B817FB;
 Tue, 19 Apr 2022 11:25:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C21CBC385AD;
 Tue, 19 Apr 2022 11:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650367530;
 bh=J+dyG7QFvE6dvBo1woO7PdEkxAJWkglSxUIN59CRX8k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Md9wfF+jEuntXn10CIHzQUkCtB0W/xakw4lPNqbZdCcMxZ0IvpZHLKzXff30Vp1co
 VEPB4ACJyQh+nlWzsYOea6ETvBpgrm/9oSUt2Ig76XzdInx+esxjeK3ZOhxj7ZT6V8
 4qMuViT5Pe45oDloGFgLl4XotTZq9d2K8308Lfml7SbBZO1BnUksVPf1nlTUf+NgtL
 nX6Ld2JDQGumBwyQZ/ihvvu1hnxHK4fU1ca+PbpVX8DJm6+fFFfGtmnHgQnInz1cgA
 B/ya5D18225yzxnrUdqONTueXlpH9ckjhVr7gi0nJ8/u9+jCmJsOqgNZP6Re6fK7LD
 w0tgOe0QBVrqw==
From: Mark Brown <broonie@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 Shuah Khan <shuah@kernel.org>
Subject: [PATCH v14 30/39] kselftest/arm64: Add tests for TPIDR2
Date: Tue, 19 Apr 2022 12:22:38 +0100
Message-Id: <20220419112247.711548-31-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220419112247.711548-1-broonie@kernel.org>
References: <20220419112247.711548-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9077; h=from:subject;
 bh=J+dyG7QFvE6dvBo1woO7PdEkxAJWkglSxUIN59CRX8k=;
 b=owEBbAGT/pANAwAKASTWi3JdVIfQAcsmYgBiXpt/LcL33bi4jWtgTB6qLq24uN1DxJr+gCLjcXKo
 xgynPSSJATIEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYl6bfwAKCRAk1otyXVSH0LhCB/
 j7nwYnpf1FaSO8lfjKvD6YUnBxDhCMJXOSaCM/tBuuggidsQiPEY93wq/z/ZnfLm642nfht/4w8g9J
 5xfb+J5r46MsJRcLlQITcNwIhKsMIP3qkkOCJrZ685eXIkeDNFuQGEeIOsGI0Dm8Y4qF4LvBsrCEXf
 63pokqnLuFa7Y/ejctzcc/6jyCAHgf+TE5cNcx6WxtW7G7dcBxlhGVe31Pr5gm+5zWgAC6opxNJmWv
 KMRd0uityPEEQt1thW3xLSPTZCykuhoGSwXTm/XTg7E8L20TldECumX8gcpJtiqD166nN1UYXdHij9
 qPu48oAXZ7FocXYAKsrJDWa1EugWg=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Cc: Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
 Luis Machado <luis.machado@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>,
 Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kselftest@vger.kernel.org, Alan Hayward <alan.hayward@arm.com>,
 kvmarm@lists.cs.columbia.edu, Salil Akerkar <Salil.Akerkar@arm.com>,
 Luca Salabrino <luca.scalabrino@arm.com>
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

The Scalable Matrix Extension adds a new system register TPIDR2 intended to
be used by libc for its own thread specific use, add some kselftests which
exercise the ABI for it.

Since this test should with some adjustment work for TPIDR and any other
similar registers added in future add tests for it in a separate
directory rather than placing it with the other floating point tests,
nothing existing looked suitable so I created a new test directory
called "abi".

Since this feature is intended to be used by libc the test is built as
freestanding code using nolibc so we don't end up with the test program
and libc both trying to manage the register simultaneously and
distrupting each other. As a result of being written using nolibc rather
than using hwcaps to identify if SME is available in the system we check
for the default SME vector length configuration in proc, adding hwcap
support to nolibc seems like disproportionate effort and didn't feel
entirely idiomatic for what nolibc is trying to do.

Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 tools/testing/selftests/arm64/abi/.gitignore |   1 +
 tools/testing/selftests/arm64/abi/Makefile   |   9 +-
 tools/testing/selftests/arm64/abi/tpidr2.c   | 298 +++++++++++++++++++
 3 files changed, 307 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/arm64/abi/tpidr2.c

diff --git a/tools/testing/selftests/arm64/abi/.gitignore b/tools/testing/selftests/arm64/abi/.gitignore
index b79cf5814c23..b9e54417250d 100644
--- a/tools/testing/selftests/arm64/abi/.gitignore
+++ b/tools/testing/selftests/arm64/abi/.gitignore
@@ -1 +1,2 @@
 syscall-abi
+tpidr2
diff --git a/tools/testing/selftests/arm64/abi/Makefile b/tools/testing/selftests/arm64/abi/Makefile
index 96eba974ac8d..c8d7f2495eb2 100644
--- a/tools/testing/selftests/arm64/abi/Makefile
+++ b/tools/testing/selftests/arm64/abi/Makefile
@@ -1,8 +1,15 @@
 # SPDX-License-Identifier: GPL-2.0
 # Copyright (C) 2021 ARM Limited
 
-TEST_GEN_PROGS := syscall-abi
+TEST_GEN_PROGS := syscall-abi tpidr2
 
 include ../../lib.mk
 
 $(OUTPUT)/syscall-abi: syscall-abi.c syscall-abi-asm.S
+
+# Build with nolibc since TPIDR2 is intended to be actively managed by
+# libc and we're trying to test the functionality that it depends on here.
+$(OUTPUT)/tpidr2: tpidr2.c
+	$(CC) -fno-asynchronous-unwind-tables -fno-ident -s -Os -nostdlib \
+		-static -include ../../../../include/nolibc/nolibc.h \
+		-ffreestanding -Wall $^ -o $@ -lgcc
diff --git a/tools/testing/selftests/arm64/abi/tpidr2.c b/tools/testing/selftests/arm64/abi/tpidr2.c
new file mode 100644
index 000000000000..351a098b503a
--- /dev/null
+++ b/tools/testing/selftests/arm64/abi/tpidr2.c
@@ -0,0 +1,298 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/sched.h>
+#include <linux/wait.h>
+
+#define SYS_TPIDR2 "S3_3_C13_C0_5"
+
+#define EXPECTED_TESTS 5
+
+static void putstr(const char *str)
+{
+	write(1, str, strlen(str));
+}
+
+static void putnum(unsigned int num)
+{
+	char c;
+
+	if (num / 10)
+		putnum(num / 10);
+
+	c = '0' + (num % 10);
+	write(1, &c, 1);
+}
+
+static int tests_run;
+static int tests_passed;
+static int tests_failed;
+static int tests_skipped;
+
+static void set_tpidr2(uint64_t val)
+{
+	asm volatile (
+		"msr	" SYS_TPIDR2 ", %0\n"
+		:
+		: "r"(val)
+		: "cc");
+}
+
+static uint64_t get_tpidr2(void)
+{
+	uint64_t val;
+
+	asm volatile (
+		"mrs	%0, " SYS_TPIDR2 "\n"
+		: "=r"(val)
+		:
+		: "cc");
+
+	return val;
+}
+
+static void print_summary(void)
+{
+	if (tests_passed + tests_failed + tests_skipped != EXPECTED_TESTS)
+		putstr("# UNEXPECTED TEST COUNT: ");
+
+	putstr("# Totals: pass:");
+	putnum(tests_passed);
+	putstr(" fail:");
+	putnum(tests_failed);
+	putstr(" xfail:0 xpass:0 skip:");
+	putnum(tests_skipped);
+	putstr(" error:0\n");
+}
+
+/* Processes should start with TPIDR2 == 0 */
+static int default_value(void)
+{
+	return get_tpidr2() == 0;
+}
+
+/* If we set TPIDR2 we should read that value */
+static int write_read(void)
+{
+	set_tpidr2(getpid());
+
+	return getpid() == get_tpidr2();
+}
+
+/* If we set a value we should read the same value after scheduling out */
+static int write_sleep_read(void)
+{
+	set_tpidr2(getpid());
+
+	msleep(100);
+
+	return getpid() == get_tpidr2();
+}
+
+/*
+ * If we fork the value in the parent should be unchanged and the
+ * child should start with the same value and be able to set its own
+ * value.
+ */
+static int write_fork_read(void)
+{
+	pid_t newpid, waiting, oldpid;
+	int status;
+
+	set_tpidr2(getpid());
+
+	oldpid = getpid();
+	newpid = fork();
+	if (newpid == 0) {
+		/* In child */
+		if (get_tpidr2() != oldpid) {
+			putstr("# TPIDR2 changed in child: ");
+			putnum(get_tpidr2());
+			putstr("\n");
+			exit(0);
+		}
+
+		set_tpidr2(getpid());
+		if (get_tpidr2() == getpid()) {
+			exit(1);
+		} else {
+			putstr("# Failed to set TPIDR2 in child\n");
+			exit(0);
+		}
+	}
+	if (newpid < 0) {
+		putstr("# fork() failed: -");
+		putnum(-newpid);
+		putstr("\n");
+		return 0;
+	}
+
+	for (;;) {
+		waiting = waitpid(newpid, &status, 0);
+
+		if (waiting < 0) {
+			if (errno == EINTR)
+				continue;
+			putstr("# waitpid() failed: ");
+			putnum(errno);
+			putstr("\n");
+			return 0;
+		}
+		if (waiting != newpid) {
+			putstr("# waitpid() returned wrong PID\n");
+			return 0;
+		}
+
+		if (!WIFEXITED(status)) {
+			putstr("# child did not exit\n");
+			return 0;
+		}
+
+		if (getpid() != get_tpidr2()) {
+			putstr("# TPIDR2 corrupted in parent\n");
+			return 0;
+		}
+
+		return WEXITSTATUS(status);
+	}
+}
+
+/*
+ * sys_clone() has a lot of per architecture variation so just define
+ * it here rather than adding it to nolibc, plus the raw API is a
+ * little more convenient for this test.
+ */
+static int sys_clone(unsigned long clone_flags, unsigned long newsp,
+		     int *parent_tidptr, unsigned long tls,
+		     int *child_tidptr)
+{
+	return my_syscall5(__NR_clone, clone_flags, newsp, parent_tidptr, tls,
+			   child_tidptr);
+}
+
+/*
+ * If we clone with CLONE_SETTLS then the value in the parent should
+ * be unchanged and the child should start with zero and be able to
+ * set its own value.
+ */
+static int write_clone_read(void)
+{
+	int parent_tid, child_tid;
+	pid_t parent, waiting;
+	int ret, status;
+
+	parent = getpid();
+	set_tpidr2(parent);
+
+	ret = sys_clone(CLONE_SETTLS, 0, &parent_tid, 0, &child_tid);
+	if (ret == -1) {
+		putstr("# clone() failed\n");
+		putnum(errno);
+		putstr("\n");
+		return 0;
+	}
+
+	if (ret == 0) {
+		/* In child */
+		if (get_tpidr2() != 0) {
+			putstr("# TPIDR2 non-zero in child: ");
+			putnum(get_tpidr2());
+			putstr("\n");
+			exit(0);
+		}
+
+		if (gettid() == 0)
+			putstr("# Child TID==0\n");
+		set_tpidr2(gettid());
+		if (get_tpidr2() == gettid()) {
+			exit(1);
+		} else {
+			putstr("# Failed to set TPIDR2 in child\n");
+			exit(0);
+		}
+	}
+
+	for (;;) {
+		waiting = wait4(ret, &status, __WCLONE, NULL);
+
+		if (waiting < 0) {
+			if (errno == EINTR)
+				continue;
+			putstr("# wait4() failed: ");
+			putnum(errno);
+			putstr("\n");
+			return 0;
+		}
+		if (waiting != ret) {
+			putstr("# wait4() returned wrong PID ");
+			putnum(waiting);
+			putstr("\n");
+			return 0;
+		}
+
+		if (!WIFEXITED(status)) {
+			putstr("# child did not exit\n");
+			return 0;
+		}
+
+		if (parent != get_tpidr2()) {
+			putstr("# TPIDR2 corrupted in parent\n");
+			return 0;
+		}
+
+		return WEXITSTATUS(status);
+	}
+}
+
+#define run_test(name)			     \
+	if (name()) {			     \
+		tests_passed++;		     \
+	} else {			     \
+		tests_failed++;		     \
+		putstr("not ");		     \
+	}				     \
+	putstr("ok ");			     \
+	putnum(++tests_run);		     \
+	putstr(" " #name "\n");
+
+int main(int argc, char **argv)
+{
+	int ret, i;
+
+	putstr("TAP version 13\n");
+	putstr("1..");
+	putnum(EXPECTED_TESTS);
+	putstr("\n");
+
+	putstr("# PID: ");
+	putnum(getpid());
+	putstr("\n");
+
+	/*
+	 * This test is run with nolibc which doesn't support hwcap and
+	 * it's probably disproportionate to implement so instead check
+	 * for the default vector length configuration in /proc.
+	 */
+	ret = open("/proc/sys/abi/sme_default_vector_length", O_RDONLY, 0);
+	if (ret >= 0) {
+		run_test(default_value);
+		run_test(write_read);
+		run_test(write_sleep_read);
+		run_test(write_fork_read);
+		run_test(write_clone_read);
+
+	} else {
+		putstr("# SME support not present\n");
+
+		for (i = 0; i < EXPECTED_TESTS; i++) {
+			putstr("ok ");
+			putnum(i);
+			putstr(" skipped, TPIDR2 not supported\n");
+		}
+
+		tests_skipped += EXPECTED_TESTS;
+	}
+
+	print_summary();
+
+	return 0;
+}
-- 
2.30.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
