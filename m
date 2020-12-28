Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 26E2C2E3655
	for <lists+kvmarm@lfdr.de>; Mon, 28 Dec 2020 12:20:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D1F5C4B1AF;
	Mon, 28 Dec 2020 06:20:11 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XmMpSm6DbYGN; Mon, 28 Dec 2020 06:20:10 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0AC764B239;
	Mon, 28 Dec 2020 06:20:10 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EA4C94B1FE
 for <kvmarm@lists.cs.columbia.edu>; Mon, 28 Dec 2020 06:20:07 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7HCFAEQe6r0H for <kvmarm@lists.cs.columbia.edu>;
 Mon, 28 Dec 2020 06:20:06 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id B9F574B198
 for <kvmarm@lists.cs.columbia.edu>; Mon, 28 Dec 2020 06:20:01 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CC3A1229C6;
 Mon, 28 Dec 2020 11:20:00 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1ktq6L-0048wX-Pf; Mon, 28 Dec 2020 10:50:09 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.cs.columbia.edu
Subject: [PATCH 12/17] arm64: Allow ID_AA64MMFR1_EL1.VH to be overridden from
 the command line
Date: Mon, 28 Dec 2020 10:49:53 +0000
Message-Id: <20201228104958.1848833-13-maz@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201228104958.1848833-1-maz@kernel.org>
References: <20201228104958.1848833-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, catalin.marinas@arm.com, will@kernel.org,
 mark.rutland@arm.com, dbrazdil@google.com, alexandru.elisei@arm.com,
 ardb@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com,
 suzuki.poulose@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>
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

As we want to be able to disable VHE at runtime, let's match
"id_aa64mmfr1.vh=" from the command line as an override.
This doesn't have much effect yet as out boot code doesn't look
at the cpufeature, but only at the HW registers.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/cpufeature.h |  3 +++
 arch/arm64/kernel/cpufeature.c      |  6 +++++-
 arch/arm64/kernel/idreg-override.c  | 12 ++++++++++++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 465d2cb63bfc..ef9487dfadca 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -813,6 +813,9 @@ static inline unsigned int get_vmid_bits(u64 mmfr1)
 	return 8;
 }
 
+extern u64 id_aa64mmfr1_val;
+extern u64 id_aa64mmfr1_mask;
+
 u32 get_kvm_ipa_limit(void);
 void dump_cpu_features(void);
 
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 2dbfc0096b0d..623a74090c9e 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -555,6 +555,9 @@ static const struct arm64_ftr_bits ftr_raz[] = {
 
 #define ARM64_FTR_REG(id, table) ARM64_FTR_REG_OVERRIDE(id, table, NULL, NULL)
 
+u64 id_aa64mmfr1_val;
+u64 id_aa64mmfr1_mask;
+
 static const struct __ftr_reg_entry {
 	u32			sys_id;
 	struct arm64_ftr_reg 	*reg;
@@ -602,7 +605,8 @@ static const struct __ftr_reg_entry {
 
 	/* Op1 = 0, CRn = 0, CRm = 7 */
 	ARM64_FTR_REG(SYS_ID_AA64MMFR0_EL1, ftr_id_aa64mmfr0),
-	ARM64_FTR_REG(SYS_ID_AA64MMFR1_EL1, ftr_id_aa64mmfr1),
+	ARM64_FTR_REG_OVERRIDE(SYS_ID_AA64MMFR1_EL1, ftr_id_aa64mmfr1,
+			       &id_aa64mmfr1_val, &id_aa64mmfr1_mask),
 	ARM64_FTR_REG(SYS_ID_AA64MMFR2_EL1, ftr_id_aa64mmfr2),
 
 	/* Op1 = 0, CRn = 1, CRm = 2 */
diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-override.c
index 98fc664c2504..76f3d481535d 100644
--- a/arch/arm64/kernel/idreg-override.c
+++ b/arch/arm64/kernel/idreg-override.c
@@ -10,6 +10,7 @@
 #include <linux/libfdt.h>
 
 #include <asm/cacheflush.h>
+#include <asm/cpufeature.h>
 #include <asm/setup.h>
 
 struct reg_desc {
@@ -22,7 +23,18 @@ struct reg_desc {
 	} 			fields[];
 };
 
+static const struct reg_desc mmfr1 __initdata = {
+	.name		= "id_aa64mmfr1",
+	.val		= &id_aa64mmfr1_val,
+	.mask		= &id_aa64mmfr1_mask,
+	.fields		= {
+	        { "vh", ID_AA64MMFR1_VHE_SHIFT },
+		{}
+	},
+};
+
 static const struct reg_desc * const regs[] __initdata = {
+	&mmfr1,
 };
 
 static int __init find_field(const char *cmdline, const struct reg_desc *reg,
-- 
2.29.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
