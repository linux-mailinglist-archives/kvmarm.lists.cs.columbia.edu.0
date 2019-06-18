Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id AD1F24A500
	for <lists+kvmarm@lfdr.de>; Tue, 18 Jun 2019 17:18:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5AF184A51D;
	Tue, 18 Jun 2019 11:18:01 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Drrgqquk8t+1; Tue, 18 Jun 2019 11:18:00 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 240AA4A4EA;
	Tue, 18 Jun 2019 11:18:00 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 522E14A500
 for <kvmarm@lists.cs.columbia.edu>; Tue, 18 Jun 2019 11:17:59 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Vld7wlDoptbH for <kvmarm@lists.cs.columbia.edu>;
 Tue, 18 Jun 2019 11:17:58 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6D0634A4FA
 for <kvmarm@lists.cs.columbia.edu>; Tue, 18 Jun 2019 11:17:57 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1527A360;
 Tue, 18 Jun 2019 08:17:57 -0700 (PDT)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E9D1C3F718;
 Tue, 18 Jun 2019 08:17:55 -0700 (PDT)
From: James Morse <james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.cs.columbia.edu
Subject: [PATCH v3 1/6] arm64: assembler: Switch ESB-instruction with a
 vanilla nop if !ARM64_HAS_RAS
Date: Tue, 18 Jun 2019 16:17:33 +0100
Message-Id: <20190618151738.258983-2-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190618151738.258983-1-james.morse@arm.com>
References: <20190618151738.258983-1-james.morse@arm.com>
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

The ESB-instruction is a nop on CPUs that don't implement the RAS
extensions. This lets us use it in places like the vectors without
having to use alternatives.

If someone disables CONFIG_ARM64_RAS_EXTN, this instruction still has
its RAS extensions behaviour, but we no longer read DISR_EL1 as this
register does depend on alternatives.

This could go wrong if we want to synchronize an SError from a KVM
guest. On a CPU that has the RAS extensions, but the KConfig option
was disabled, we consume the pending SError with no chance of ever
reading it.

Hide the ESB-instruction behind the CONFIG_ARM64_RAS_EXTN option,
outputting a regular nop if the feature has been disabled.

Reported-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
New for v2. The esb where this would be a problem is added later in
this series, but there is no build-dependency.
---
 arch/arm64/include/asm/assembler.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 92b6b7cf67dd..2d2114b39846 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -107,7 +107,11 @@
  * RAS Error Synchronization barrier
  */
 	.macro  esb
+#ifdef CONFIG_ARM64_RAS_EXTN
 	hint    #16
+#else
+	nop
+#endif
 	.endm
 
 /*
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
