Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D7C2E4AC31D
	for <lists+kvmarm@lfdr.de>; Mon,  7 Feb 2022 16:25:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7458749EFD;
	Mon,  7 Feb 2022 10:25:15 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3bniPy3dxOkr; Mon,  7 Feb 2022 10:25:15 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EF7CA49EE7;
	Mon,  7 Feb 2022 10:25:13 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1B73349EE7
 for <kvmarm@lists.cs.columbia.edu>; Mon,  7 Feb 2022 10:25:12 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1hj17AguMYsM for <kvmarm@lists.cs.columbia.edu>;
 Mon,  7 Feb 2022 10:25:10 -0500 (EST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 97E6A40307
 for <kvmarm@lists.cs.columbia.edu>; Mon,  7 Feb 2022 10:25:10 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 253F561035;
 Mon,  7 Feb 2022 15:25:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21BABC36AE9;
 Mon,  7 Feb 2022 15:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1644247509;
 bh=814u6qr00Svitr+wGJ4FW2qUnHufihham66MiXu5/2Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TW/+tkfr2D1c0cdDK73xnMCb9s4qDz4aqtXDy8qS2JXX52VVjmwVOszZhCJVSeli0
 RmPQjDGN9lJaW8JSoeg1UeJjTJ4xfA2elAs5sVPW/90ayL+y8AmAwJwTIgDUnOeyij
 csWxN96qe/4o2lZkTnNfWGFKloiq/RKIUiG3++XRuyWUpVzzwCaU3NVGo3THMU4Y2l
 Qt6sDl2NclDNkH9qjLOCf4ghAqxUZqfYqTJtuvVWvsqSke8lBHXrIk29HHyjmvPKEL
 TwaigsuQ3I+Qn3X/Pjzd6qPOFPbk+TTP8ZArAktyoNqKt/XTwtf0XLpHjWKCcQrg0z
 3ORPcg8gDdpfg==
From: Mark Brown <broonie@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 Shuah Khan <shuah@kernel.org>
Subject: [PATCH v11 30/40] kselftest/arm64: Add manual encodings for SME
 instructions
Date: Mon,  7 Feb 2022 15:20:59 +0000
Message-Id: <20220207152109.197566-31-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220207152109.197566-1-broonie@kernel.org>
References: <20220207152109.197566-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1609; h=from:subject;
 bh=814u6qr00Svitr+wGJ4FW2qUnHufihham66MiXu5/2Q=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiATjcpQU/zMY016e3r9C1N+w3VbKrNCXwwUgVA8Z4
 S6BeLAKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYgE43AAKCRAk1otyXVSH0JSPB/
 sFqRyZJGz84m8hIKOzrXOdJ4N8/Jukp+2huVNit9hIIwBa3Tllk33k2qNgUpNYfi0Zcp2V2xXTgLdD
 CyuJZVvHjlIw8JEUAEmkF0RXP+k4iNmMccf1kkr6cfj9x5BEx5NcJgEAAUHrL9vMXBwF0+/edhURhh
 pV/97BbYKwqEevAy7RCZq9wtkWyhHq66mK8bZH6DpYbmnZw2K0O6lG44ahw4d0cuTh0IB8NgRQHGwh
 9P8eRjzN34Z2cucDTK7lHMFjwkMtXtTynEb6ZbLvji73SngwfEKb/USWwszhcUINbYQifq52yTIVv0
 84b45sgX93InVfyVBcKinXF8tth8z1
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

As for the kernel so that we don't have ambitious toolchain requirements
to build the tests manually encode some of the SVE instructions.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/sme-inst.h | 51 +++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 tools/testing/selftests/arm64/fp/sme-inst.h

diff --git a/tools/testing/selftests/arm64/fp/sme-inst.h b/tools/testing/selftests/arm64/fp/sme-inst.h
new file mode 100644
index 000000000000..7191e53ca1c0
--- /dev/null
+++ b/tools/testing/selftests/arm64/fp/sme-inst.h
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2021-2 ARM Limited.
+// Original author: Mark Brown <broonie@kernel.org>
+
+#ifndef SME_INST_H
+#define SME_INST_H
+
+/*
+ * RDSVL X\nx, #\imm
+ */
+.macro rdsvl nx, imm
+	.inst	0x4bf5800			\
+		| (\imm << 5)			\
+		| (\nx)
+.endm
+
+.macro smstop
+	msr	S0_3_C4_C6_3, xzr
+.endm
+
+.macro smstart_za
+	msr	S0_3_C4_C5_3, xzr
+.endm
+
+.macro smstart_sm
+	msr	S0_3_C4_C3_3, xzr
+.endm
+
+/*
+ * LDR (vector to ZA array):
+ *	LDR ZA[\nw, #\offset], [X\nxbase, #\offset, MUL VL]
+ */
+.macro _ldr_za nw, nxbase, offset=0
+	.inst	0xe1000000			\
+		| (((\nw) & 3) << 13)		\
+		| ((\nxbase) << 5)		\
+		| ((\offset) & 7)
+.endm
+
+/*
+ * STR (vector from ZA array):
+ *	STR ZA[\nw, #\offset], [X\nxbase, #\offset, MUL VL]
+ */
+.macro _str_za nw, nxbase, offset=0
+	.inst	0xe1200000			\
+		| (((\nw) & 3) << 13)		\
+		| ((\nxbase) << 5)		\
+		| ((\offset) & 7)
+.endm
+
+#endif
-- 
2.30.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
