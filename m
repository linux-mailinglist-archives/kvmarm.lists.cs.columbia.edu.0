Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 86C1C4C4C89
	for <lists+kvmarm@lfdr.de>; Fri, 25 Feb 2022 18:36:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3201D4B9C5;
	Fri, 25 Feb 2022 12:36:42 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c48znk6NUSar; Fri, 25 Feb 2022 12:36:42 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 86F534B9B8;
	Fri, 25 Feb 2022 12:36:40 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0B39040FD6
 for <kvmarm@lists.cs.columbia.edu>; Fri, 25 Feb 2022 12:36:39 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FuwCrwbRItby for <kvmarm@lists.cs.columbia.edu>;
 Fri, 25 Feb 2022 12:36:37 -0500 (EST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 7E66A4B910
 for <kvmarm@lists.cs.columbia.edu>; Fri, 25 Feb 2022 12:36:37 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 1606B61DC3;
 Fri, 25 Feb 2022 17:36:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1362DC36AE9;
 Fri, 25 Feb 2022 17:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1645810596;
 bh=ctS7H/CeiOhoqzJ2YDVKb6KaMteDAVDglOQt4cf6B7E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hQBvDMV4PNWJvtfmJYy8ozoqc0FhW21vi5SP2P/JVsn4LPFHPCMGi/5bm0qEFv2tv
 VGd0NPQGwAj45h57qS4rKgLcrQpUPJioi5HPTZnyXGl7xnYLok+v+84ZOa/Vs5TN9A
 gE/7sXFDuxn0igd/QTjVatWNfzuy79cQFTYGoiVwN1+jTVhRBflJQ5ly4adIJT8tq4
 buDQG1gN+papf/Ady76vatMAAb1UXhu/sRwydzMwWy+VSG/6Zu8sVNVD+8gGsLGBl4
 XrlVIGPslU8EqU2C0U6syBcLY9XYFxQ9XUCdgpTgKcPGgAXJXA6Eykf3jYFbwIVohb
 EBHNAXL5FeN5g==
From: Mark Brown <broonie@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 Shuah Khan <shuah@kernel.org>
Subject: [PATCH v12 34/40] kselftest/arm64: sme: Provide streaming mode SVE
 stress test
Date: Fri, 25 Feb 2022 16:59:17 +0000
Message-Id: <20220225165923.1474372-35-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220225165923.1474372-1-broonie@kernel.org>
References: <20220225165923.1474372-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4967; h=from:subject;
 bh=ctS7H/CeiOhoqzJ2YDVKb6KaMteDAVDglOQt4cf6B7E=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiGQrk7Xs9FvxvvinxdDJxf/HRrH5fN7ruQDhsMa1m
 T91z7UaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYhkK5AAKCRAk1otyXVSH0KesB/
 kBtHkjZSCUDdduD2mlb4Bglgf08AZftSJtekpU8LPLP9sX2DbteiaeYQOvBbWsO2Roie2b9DY2/2e4
 pENr6wP/tIVHRDJJPlLWZykl5MhGnrN/sJu1da7JZirjj+Vx/ucASQFZEetck9O0fnx0ccaHl4jIC/
 xHvTiCmYPGIvnVVk8TkHbPnX4qiXpwqmjVEcmMkYtnzYDYbIF5k6y1fhNZROiIkTUPY3vCAKvN/dCP
 NTuKSOioHtpxmyXN+V2eW7e1wTmqV66T3J6wJ0TaF1NtEjcx9iz+V18f3zsmI1wTxLLP45CnoxViAF
 WaF5Yaf7Us8c5cNgf4PlJ3JWUiQCFf
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Cc: Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
 Luis Machado <luis.machado@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>,
 Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kselftest@vger.kernel.org, Alan Hayward <alan.hayward@arm.com>,
 kvmarm@lists.cs.columbia.edu, Salil Akerkar <Salil.Akerkar@arm.com>
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

One of the features of SME is the addition of streaming mode, in which we
have access to a set of streaming mode SVE registers at the SME vector
length. Since these are accessed using the SVE instructions let's reuse
the existing SVE stress test for testing with a compile time option for
controlling the few small differences needed:

 - Enter streaming mode immediately on starting the program.
 - In streaming mode FFR is removed so skip reading and writing FFR.

Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 tools/testing/selftests/arm64/fp/.gitignore  |  1 +
 tools/testing/selftests/arm64/fp/Makefile    |  3 +
 tools/testing/selftests/arm64/fp/ssve-stress | 59 ++++++++++++++++++++
 tools/testing/selftests/arm64/fp/sve-test.S  | 20 +++++++
 4 files changed, 83 insertions(+)
 create mode 100644 tools/testing/selftests/arm64/fp/ssve-stress

diff --git a/tools/testing/selftests/arm64/fp/.gitignore b/tools/testing/selftests/arm64/fp/.gitignore
index 6e9a610c5e5d..5729a5b1adfc 100644
--- a/tools/testing/selftests/arm64/fp/.gitignore
+++ b/tools/testing/selftests/arm64/fp/.gitignore
@@ -5,5 +5,6 @@ rdvl-sve
 sve-probe-vls
 sve-ptrace
 sve-test
+ssve-test
 vec-syscfg
 vlset
diff --git a/tools/testing/selftests/arm64/fp/Makefile b/tools/testing/selftests/arm64/fp/Makefile
index a224fff8082b..e6643c9b0474 100644
--- a/tools/testing/selftests/arm64/fp/Makefile
+++ b/tools/testing/selftests/arm64/fp/Makefile
@@ -5,6 +5,7 @@ TEST_GEN_PROGS := sve-ptrace sve-probe-vls vec-syscfg
 TEST_PROGS_EXTENDED := fp-pidbench fpsimd-test fpsimd-stress \
 	rdvl-sme rdvl-sve \
 	sve-test sve-stress \
+	ssve-test ssve-stress \
 	vlset
 
 all: $(TEST_GEN_PROGS) $(TEST_PROGS_EXTENDED)
@@ -19,6 +20,8 @@ sve-ptrace: sve-ptrace.o
 sve-probe-vls: sve-probe-vls.o rdvl.o
 sve-test: sve-test.o asm-utils.o
 	$(CC) -nostdlib $^ -o $@
+ssve-test: sve-test.S asm-utils.o
+	$(CC) -DSSVE -nostdlib $^ -o $@
 vec-syscfg: vec-syscfg.o rdvl.o
 vlset: vlset.o
 
diff --git a/tools/testing/selftests/arm64/fp/ssve-stress b/tools/testing/selftests/arm64/fp/ssve-stress
new file mode 100644
index 000000000000..e2bd2cc184ad
--- /dev/null
+++ b/tools/testing/selftests/arm64/fp/ssve-stress
@@ -0,0 +1,59 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright (C) 2015-2019 ARM Limited.
+# Original author: Dave Martin <Dave.Martin@arm.com>
+
+set -ue
+
+NR_CPUS=`nproc`
+
+pids=
+logs=
+
+cleanup () {
+	trap - INT TERM CHLD
+	set +e
+
+	if [ -n "$pids" ]; then
+		kill $pids
+		wait $pids
+		pids=
+	fi
+
+	if [ -n "$logs" ]; then
+		cat $logs
+		rm $logs
+		logs=
+	fi
+}
+
+interrupt () {
+	cleanup
+	exit 0
+}
+
+child_died () {
+	cleanup
+	exit 1
+}
+
+trap interrupt INT TERM EXIT
+
+for x in `seq 0 $((NR_CPUS * 4))`; do
+	log=`mktemp`
+	logs=$logs\ $log
+	./ssve-test >$log &
+	pids=$pids\ $!
+done
+
+# Wait for all child processes to be created:
+sleep 10
+
+while :; do
+	kill -USR1 $pids
+done &
+pids=$pids\ $!
+
+wait
+
+exit 1
diff --git a/tools/testing/selftests/arm64/fp/sve-test.S b/tools/testing/selftests/arm64/fp/sve-test.S
index f5b1b48ffff2..589264231a2d 100644
--- a/tools/testing/selftests/arm64/fp/sve-test.S
+++ b/tools/testing/selftests/arm64/fp/sve-test.S
@@ -13,6 +13,7 @@
 #include <asm/unistd.h>
 #include "assembler.h"
 #include "asm-offsets.h"
+#include "sme-inst.h"
 
 #define NZR	32
 #define NPR	16
@@ -156,6 +157,7 @@ endfunction
 // We fill the upper lanes of FFR with zeros.
 // Beware: corrupts P0.
 function setup_ffr
+#ifndef SSVE
 	mov	x4, x30
 
 	and	w0, w0, #0x3
@@ -178,6 +180,9 @@ function setup_ffr
 	wrffr	p0.b
 
 	ret	x4
+#else
+	ret
+#endif
 endfunction
 
 // Trivial memory compare: compare x2 bytes starting at address x0 with
@@ -260,6 +265,7 @@ endfunction
 // Beware -- corrupts P0.
 // Clobbers x0-x5.
 function check_ffr
+#ifndef SSVE
 	mov	x3, x30
 
 	ldr	x4, =scratch
@@ -280,6 +286,9 @@ function check_ffr
 	mov	x2, x5
 	mov	x30, x3
 	b	memcmp
+#else
+	ret
+#endif
 endfunction
 
 // Any SVE register modified here can cause corruption in the main
@@ -295,10 +304,12 @@ function irritator_handler
 	movi	v0.8b, #1
 	movi	v9.16b, #2
 	movi	v31.8b, #3
+#ifndef SSVE
 	// And P0
 	rdffr	p0.b
 	// And FFR
 	wrffr	p15.b
+#endif
 
 	ret
 endfunction
@@ -359,6 +370,11 @@ endfunction
 .globl _start
 function _start
 _start:
+#ifdef SSVE
+	puts	"Streaming mode "
+	smstart_sm
+#endif
+
 	// Sanity-check and report the vector length
 
 	rdvl	x19, #8
@@ -407,6 +423,10 @@ _start:
 	orr	w2, w2, #SA_NODEFER
 	bl	setsignal
 
+#ifdef SSVE
+	smstart_sm		// syscalls will have exited streaming mode
+#endif
+
 	mov	x22, #0		// generation number, increments per iteration
 .Ltest_loop:
 	rdvl	x0, #8
-- 
2.30.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
