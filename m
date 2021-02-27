Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D8EAB326CBD
	for <lists+kvmarm@lfdr.de>; Sat, 27 Feb 2021 11:41:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8BC494B3E9;
	Sat, 27 Feb 2021 05:41:57 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B9PB6ugWU0xr; Sat, 27 Feb 2021 05:41:57 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5042A4B430;
	Sat, 27 Feb 2021 05:41:56 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 72F774B444
 for <kvmarm@lists.cs.columbia.edu>; Sat, 27 Feb 2021 05:41:54 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IRUkJDuLMGGW for <kvmarm@lists.cs.columbia.edu>;
 Sat, 27 Feb 2021 05:41:53 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B10664B441
 for <kvmarm@lists.cs.columbia.edu>; Sat, 27 Feb 2021 05:41:52 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 607B712FC;
 Sat, 27 Feb 2021 02:41:52 -0800 (PST)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BEB713F73B;
 Sat, 27 Feb 2021 02:41:51 -0800 (PST)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: drjones@redhat.com,
	kvm@vger.kernel.org,
	kvmarm@lists.cs.columbia.edu
Subject: [kvm-unit-tests PATCH 5/6] arm64: Configure SCTLR_EL1 at boot
Date: Sat, 27 Feb 2021 10:42:00 +0000
Message-Id: <20210227104201.14403-6-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210227104201.14403-1-alexandru.elisei@arm.com>
References: <20210227104201.14403-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
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

Some fields in SCTLR_EL1 are UNKNOWN at reset and the arm64 boot
requirements, as stated by Linux in Documentation/arm64/booting.rst, do not
specify a particular value for all the fields. Do not rely on the good will
of the hypervisor and userspace to set SCTLR_EL1 to a sane value (by their
definition of sane) and set SCTLR_EL1 explicitely before running setup().
This will ensure that all tests are performed with the hardware set up
identically, regardless of the KVM or VMM versions.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 lib/arm64/asm/sysreg.h | 7 +++++++
 arm/cstart64.S         | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/lib/arm64/asm/sysreg.h b/lib/arm64/asm/sysreg.h
index 9d6b4fc66936..18c4ed39557a 100644
--- a/lib/arm64/asm/sysreg.h
+++ b/lib/arm64/asm/sysreg.h
@@ -8,6 +8,8 @@
 #ifndef _ASMARM64_SYSREG_H_
 #define _ASMARM64_SYSREG_H_
 
+#include <linux/const.h>
+
 #define sys_reg(op0, op1, crn, crm, op2) \
 	((((op0)&3)<<19)|((op1)<<16)|((crn)<<12)|((crm)<<8)|((op2)<<5))
 
@@ -87,4 +89,9 @@ asm(
 #define SCTLR_EL1_A	(1 << 1)
 #define SCTLR_EL1_M	(1 << 0)
 
+#define SCTLR_EL1_RES1	(_BITUL(7) | _BITUL(8) | _BITUL(11) | _BITUL(20) | \
+			 _BITUL(22) | _BITUL(23) | _BITUL(28) | _BITUL(29))
+#define INIT_SCTLR_EL1_MMU_OFF	\
+			SCTLR_EL1_RES1
+
 #endif /* _ASMARM64_SYSREG_H_ */
diff --git a/arm/cstart64.S b/arm/cstart64.S
index f6c5d2ebccf3..42a838ff4c38 100644
--- a/arm/cstart64.S
+++ b/arm/cstart64.S
@@ -52,6 +52,11 @@ start:
 	b	1b
 
 1:
+	/* set SCTLR_EL1 to a known value */
+	ldr	x4, =INIT_SCTLR_EL1_MMU_OFF
+	msr	sctlr_el1, x4
+	isb
+
 	/* set up stack */
 	mov	x4, #1
 	msr	spsel, x4
-- 
2.30.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
