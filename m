Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFDE34ABF
	for <lists+kvmarm@lfdr.de>; Tue,  4 Jun 2019 16:46:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 207594A529;
	Tue,  4 Jun 2019 10:46:37 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oi+6F3Pumir5; Tue,  4 Jun 2019 10:46:36 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C0FC74A530;
	Tue,  4 Jun 2019 10:46:35 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CE23C4A4FA
 for <kvmarm@lists.cs.columbia.edu>; Tue,  4 Jun 2019 10:46:34 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I80tmxbKzVM2 for <kvmarm@lists.cs.columbia.edu>;
 Tue,  4 Jun 2019 10:46:33 -0400 (EDT)
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 688F34A51C
 for <kvmarm@lists.cs.columbia.edu>; Tue,  4 Jun 2019 10:46:33 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD95115AB;
 Tue,  4 Jun 2019 07:46:32 -0700 (PDT)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 637063F690;
 Tue,  4 Jun 2019 07:46:31 -0700 (PDT)
From: James Morse <james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.cs.columbia.edu
Subject: [PATCH v1 4/6] arm64: Update silicon-errata.txt for Neoverse-N1
 #1349291
Date: Tue,  4 Jun 2019 15:45:49 +0100
Message-Id: <20190604144551.188107-5-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190604144551.188107-1-james.morse@arm.com>
References: <20190604144551.188107-1-james.morse@arm.com>
MIME-Version: 1.0
Cc: Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
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

Neoverse-N1 affected by #1349291 may report an Uncontained RAS Error
as Unrecoverable. The kernel's architecture code already considers
Unrecoverable errors as fatal as without kernel-first support no
further error-handling is possible.

Now that KVM attributes SError to the host/guest more precisely
the host's architecture code will always handle host errors that
become pending during world-switch.
Errors misclassified by this errata that affected the guest will be
re-injected to the guest as an implementation-defined SError, which can
be uncontained.

Until kernel-first support is implemented, no workaround is needed
for this issue.

Signed-off-by: James Morse <james.morse@arm.com>
---
imp-def SError can mean uncontained. In the RAS spec, 2.4.2 "ESB and other
containable errors":
| It is [imp-def] whether [imp-def] and uncategorized SError interrupts
| are containable or Uncontainable.

 Documentation/arm64/silicon-errata.txt | 1 +
 arch/arm64/kernel/traps.c              | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
index 68d9b74fd751..7d010f739146 100644
--- a/Documentation/arm64/silicon-errata.txt
+++ b/Documentation/arm64/silicon-errata.txt
@@ -62,6 +62,7 @@ stable kernels.
 | ARM            | Cortex-A76      | #1165522        | ARM64_ERRATUM_1165522       |
 | ARM            | Cortex-A76      | #1286807        | ARM64_ERRATUM_1286807       |
 | ARM            | Neoverse-N1     | #1188873        | ARM64_ERRATUM_1188873       |
+| ARM            | Neoverse-N1     | #1349291        | N/A                         |
 | ARM            | MMU-500         | #841119,#826419 | N/A                         |
 |                |                 |                 |                             |
 | Cavium         | ThunderX ITS    | #22375, #24313  | CAVIUM_ERRATUM_22375        |
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index ade32046f3fe..4f427ad1089d 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -892,6 +892,10 @@ bool arm64_is_fatal_ras_serror(struct pt_regs *regs, unsigned int esr)
 		/*
 		 * The CPU can't make progress. The exception may have
 		 * been imprecise.
+		 *
+		 * Neoverse-N1 #1349291 means a non-KVM SError reported as
+		 * Unrecoverable should be treated as Uncontainable. We
+		 * call arm64_serror_panic() in both cases.
 		 */
 		return true;
 
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
