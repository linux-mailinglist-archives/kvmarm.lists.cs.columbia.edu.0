Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B0BCB4F94A4
	for <lists+kvmarm@lfdr.de>; Fri,  8 Apr 2022 13:55:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2A9854B186;
	Fri,  8 Apr 2022 07:55:31 -0400 (EDT)
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
	with ESMTP id LtcoZtFZu7+1; Fri,  8 Apr 2022 07:55:29 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C67C34B139;
	Fri,  8 Apr 2022 07:55:29 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E351E4B10B
 for <kvmarm@lists.cs.columbia.edu>; Fri,  8 Apr 2022 07:55:28 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZK8gBacAVU7H for <kvmarm@lists.cs.columbia.edu>;
 Fri,  8 Apr 2022 07:55:26 -0400 (EDT)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 4B2C44B0E6
 for <kvmarm@lists.cs.columbia.edu>; Fri,  8 Apr 2022 07:55:26 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id C3F69B82A90;
 Fri,  8 Apr 2022 11:55:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA883C385A8;
 Fri,  8 Apr 2022 11:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649418923;
 bh=a4jTOkRQpJP6+3na2bi7YpmqAd5XXyn7buPNcfTQ1WE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lBzD44d7rPers/A9axEfKg0MEy6CwIdNLiks56MxQ/J8qrQG3Y+5CP1I1iKrY4+4a
 gQEkUl4/eszu7TIrm4cH6IYHBFL/HY10R8/48SoZz5puPfCPveZmKKgHKVnaP+mwwL
 kBc16dfU+lSs81x2LKsYeORgEkofzEMWMxp6K4v84e5/Um+QeRDQK7rmA0ov6Y50WC
 G3RZhTfT+D5oG9ZVZJ+6W2BXDna/DaAEgWtkgFGhh08me90MLp4S55GKf+xiMCgRsN
 4G7GdF/KQBC2u3UOmcVLM8gTNItTRTx/l62vSDStnLxIYtpfhEdh3t0DCkW7PqYSnZ
 DpOYKLVeq6MZA==
From: Mark Brown <broonie@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 Shuah Khan <shuah@kernel.org>
Subject: [PATCH v13 02/39] kselftest/arm64: Remove assumption that tasks start
 FPSIMD only
Date: Fri,  8 Apr 2022 12:42:51 +0100
Message-Id: <20220408114328.1401034-3-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220408114328.1401034-1-broonie@kernel.org>
References: <20220408114328.1401034-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3717; h=from:subject;
 bh=a4jTOkRQpJP6+3na2bi7YpmqAd5XXyn7buPNcfTQ1WE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiUB/A2Yj2qaE22cbeGjQpnhdqs87ucVV8by5rRUVN
 s+bZuxeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYlAfwAAKCRAk1otyXVSH0NW1B/
 0WtYXHycWMiOzigh5lT9titoTAKJMhXRqJsHXGX3owJBAPlt10YY0lNBURLWJEBAO0OZxnY3c0q9ZO
 AQuqwJiGT68iDi7T9ASegELmGlYBIm/bhvSUbYJ4mO9rwmF9yprk8uFblggyDlkpHRSNoFkQ0uc9Bv
 kjonlHg9yPdIVEn7Ju8xRxlmLRoWEacPa5xEX/eyPYxBEuuV9MVoNxzRzFB9HGnnxsGgLRUDiZcVTM
 2zNyk608BgYgbbYi4taPexwUb3vGjNonZ07k7L4TggY2LWlNE2UMWu1WmE8KdvudyxuJR6WDsvC5rr
 S8qdeHlvXeR4NbVEA9FpGuUK+whM2p
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

Currently the sve-ptrace test for setting and reading FPSIMD data assumes
that the child will start off in FPSIMD only mode and that it can use this
to read some FPSIMD mode SVE ptrace data, skipping the test if it can't.
This isn't an assumption guaranteed by the ABI and also limits how we can
use this testcase within the program. Instead skip the initial read and
just generate a FPSIMD format buffer for the write part of the test, making
the coverage more robust in the face of future kernel and test program
changes.

Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/arm64/fp/sve-ptrace.c | 39 ++++++++-----------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/sve-ptrace.c b/tools/testing/selftests/arm64/fp/sve-ptrace.c
index 7682798adbba..8f6146d89ca4 100644
--- a/tools/testing/selftests/arm64/fp/sve-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/sve-ptrace.c
@@ -46,7 +46,7 @@ static const struct vec_type vec_types[] = {
 
 #define VL_TESTS (((SVE_VQ_MAX - SVE_VQ_MIN) + 1) * 3)
 #define FLAG_TESTS 2
-#define FPSIMD_TESTS 3
+#define FPSIMD_TESTS 2
 
 #define EXPECTED_TESTS ((VL_TESTS + FLAG_TESTS + FPSIMD_TESTS) * ARRAY_SIZE(vec_types))
 
@@ -240,28 +240,24 @@ static void check_u32(unsigned int vl, const char *reg,
 /* Access the FPSIMD registers via the SVE regset */
 static void ptrace_sve_fpsimd(pid_t child, const struct vec_type *type)
 {
-	void *svebuf = NULL;
-	size_t svebufsz = 0;
+	void *svebuf;
 	struct user_sve_header *sve;
 	struct user_fpsimd_state *fpsimd, new_fpsimd;
 	unsigned int i, j;
 	unsigned char *p;
+	int ret;
 
-	/* New process should start with FPSIMD registers only */
-	sve = get_sve(child, type, &svebuf, &svebufsz);
-	if (!sve) {
-		ksft_test_result_fail("get_sve(%s): %s\n",
-				      type->name, strerror(errno));
-
+	svebuf = malloc(SVE_PT_SIZE(0, SVE_PT_REGS_FPSIMD));
+	if (!svebuf) {
+		ksft_test_result_fail("Failed to allocate FPSIMD buffer\n");
 		return;
-	} else {
-		ksft_test_result_pass("get_sve(%s FPSIMD)\n", type->name);
 	}
 
-	ksft_test_result((sve->flags & SVE_PT_REGS_MASK) == SVE_PT_REGS_FPSIMD,
-			 "Got FPSIMD registers via %s\n", type->name);
-	if ((sve->flags & SVE_PT_REGS_MASK) != SVE_PT_REGS_FPSIMD)
-		goto out;
+	memset(svebuf, 0, SVE_PT_SIZE(0, SVE_PT_REGS_FPSIMD));
+	sve = svebuf;
+	sve->flags = SVE_PT_REGS_FPSIMD;
+	sve->size = SVE_PT_SIZE(0, SVE_PT_REGS_FPSIMD);
+	sve->vl = 16;  /* We don't care what the VL is */
 
 	/* Try to set a known FPSIMD state via PT_REGS_SVE */
 	fpsimd = (struct user_fpsimd_state *)((char *)sve +
@@ -273,12 +269,11 @@ static void ptrace_sve_fpsimd(pid_t child, const struct vec_type *type)
 			p[j] = j;
 	}
 
-	if (set_sve(child, type, sve)) {
-		ksft_test_result_fail("set_sve(%s FPSIMD): %s\n",
-				      type->name, strerror(errno));
-
+	ret = set_sve(child, type, sve);
+	ksft_test_result(ret == 0, "%s FPSIMD set via SVE: %d\n",
+			 type->name, ret);
+	if (ret)
 		goto out;
-	}
 
 	/* Verify via the FPSIMD regset */
 	if (get_fpsimd(child, &new_fpsimd)) {
@@ -548,11 +543,9 @@ static int do_parent(pid_t child)
 		if (getauxval(vec_types[i].hwcap_type) & vec_types[i].hwcap) {
 			ptrace_sve_fpsimd(child, &vec_types[i]);
 		} else {
-			ksft_test_result_skip("%s FPSIMD get via SVE\n",
-					      vec_types[i].name);
 			ksft_test_result_skip("%s FPSIMD set via SVE\n",
 					      vec_types[i].name);
-			ksft_test_result_skip("%s set read via FPSIMD\n",
+			ksft_test_result_skip("%s FPSIMD read\n",
 					      vec_types[i].name);
 		}
 
-- 
2.30.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
