Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 57A8A7FC9A
	for <lists+kvmarm@lfdr.de>; Fri,  2 Aug 2019 16:50:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F396A4A571;
	Fri,  2 Aug 2019 10:50:52 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FZyELmngtvYj; Fri,  2 Aug 2019 10:50:51 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8F7814A523;
	Fri,  2 Aug 2019 10:50:51 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 146DB4A56F
 for <kvmarm@lists.cs.columbia.edu>; Fri,  2 Aug 2019 10:50:50 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OgdCLBxliOnr for <kvmarm@lists.cs.columbia.edu>;
 Fri,  2 Aug 2019 10:50:48 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 305EF4A56A
 for <kvmarm@lists.cs.columbia.edu>; Fri,  2 Aug 2019 10:50:47 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC60B1596;
 Fri,  2 Aug 2019 07:50:46 -0700 (PDT)
Received: from e112269-lin.arm.com (e112269-lin.cambridge.arm.com
 [10.1.196.133])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 11E373F575;
 Fri,  2 Aug 2019 07:50:44 -0700 (PDT)
From: Steven Price <steven.price@arm.com>
To: 
Subject: [PATCH 8/9] arm/arm64: Make use of the SMCCC 1.1 wrapper
Date: Fri,  2 Aug 2019 15:50:16 +0100
Message-Id: <20190802145017.42543-9-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190802145017.42543-1-steven.price@arm.com>
References: <20190802145017.42543-1-steven.price@arm.com>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, linux-doc@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, Steven Price <steven.price@arm.com>,
 linux-arm-kernel@lists.infradead.org, Marc Zyngier <maz@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu
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

Rather than directly choosing which function to use based on
psci_ops.conduit, use the new arm_smccc_1_1 wrapper instead.

In some cases we still need to do some operations based on the
conduit, but the code duplication is removed.

No functional change.

Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/arm/mm/proc-v7-bugs.c     | 13 +++---
 arch/arm64/kernel/cpu_errata.c | 80 ++++++++++++----------------------
 2 files changed, 33 insertions(+), 60 deletions(-)

diff --git a/arch/arm/mm/proc-v7-bugs.c b/arch/arm/mm/proc-v7-bugs.c
index 9a07916af8dd..8eb52f3385e7 100644
--- a/arch/arm/mm/proc-v7-bugs.c
+++ b/arch/arm/mm/proc-v7-bugs.c
@@ -78,12 +78,13 @@ static void cpu_v7_spectre_init(void)
 		if (psci_ops.smccc_version == SMCCC_VERSION_1_0)
 			break;
 
+		arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
+				     ARM_SMCCC_ARCH_WORKAROUND_1, &res);
+		if ((int)res.a0 != 0)
+			return;
+
 		switch (psci_ops.conduit) {
 		case PSCI_CONDUIT_HVC:
-			arm_smccc_1_1_hvc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
-					  ARM_SMCCC_ARCH_WORKAROUND_1, &res);
-			if ((int)res.a0 != 0)
-				break;
 			per_cpu(harden_branch_predictor_fn, cpu) =
 				call_hvc_arch_workaround_1;
 			cpu_do_switch_mm = cpu_v7_hvc_switch_mm;
@@ -91,10 +92,6 @@ static void cpu_v7_spectre_init(void)
 			break;
 
 		case PSCI_CONDUIT_SMC:
-			arm_smccc_1_1_smc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
-					  ARM_SMCCC_ARCH_WORKAROUND_1, &res);
-			if ((int)res.a0 != 0)
-				break;
 			per_cpu(harden_branch_predictor_fn, cpu) =
 				call_smc_arch_workaround_1;
 			cpu_do_switch_mm = cpu_v7_smc_switch_mm;
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 1e43ba5c79b7..400a49aaae85 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -215,40 +215,31 @@ static int detect_harden_bp_fw(void)
 	if (psci_ops.smccc_version == SMCCC_VERSION_1_0)
 		return -1;
 
+	arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
+			     ARM_SMCCC_ARCH_WORKAROUND_1, &res);
+
+	switch ((int)res.a0) {
+	case 1:
+		/* Firmware says we're just fine */
+		return 0;
+	case 0:
+		break;
+	default:
+		return -1;
+	}
+
 	switch (psci_ops.conduit) {
 	case PSCI_CONDUIT_HVC:
-		arm_smccc_1_1_hvc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
-				  ARM_SMCCC_ARCH_WORKAROUND_1, &res);
-		switch ((int)res.a0) {
-		case 1:
-			/* Firmware says we're just fine */
-			return 0;
-		case 0:
-			cb = call_hvc_arch_workaround_1;
-			/* This is a guest, no need to patch KVM vectors */
-			smccc_start = NULL;
-			smccc_end = NULL;
-			break;
-		default:
-			return -1;
-		}
+		cb = call_hvc_arch_workaround_1;
+		/* This is a guest, no need to patch KVM vectors */
+		smccc_start = NULL;
+		smccc_end = NULL;
 		break;
 
 	case PSCI_CONDUIT_SMC:
-		arm_smccc_1_1_smc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
-				  ARM_SMCCC_ARCH_WORKAROUND_1, &res);
-		switch ((int)res.a0) {
-		case 1:
-			/* Firmware says we're just fine */
-			return 0;
-		case 0:
-			cb = call_smc_arch_workaround_1;
-			smccc_start = __smccc_workaround_1_smc_start;
-			smccc_end = __smccc_workaround_1_smc_end;
-			break;
-		default:
-			return -1;
-		}
+		cb = call_smc_arch_workaround_1;
+		smccc_start = __smccc_workaround_1_smc_start;
+		smccc_end = __smccc_workaround_1_smc_end;
 		break;
 
 	default:
@@ -338,6 +329,7 @@ void __init arm64_enable_wa2_handling(struct alt_instr *alt,
 
 void arm64_set_ssbd_mitigation(bool state)
 {
+	int conduit;
 	if (!IS_ENABLED(CONFIG_ARM64_SSBD)) {
 		pr_info_once("SSBD disabled by kernel configuration\n");
 		return;
@@ -351,19 +343,10 @@ void arm64_set_ssbd_mitigation(bool state)
 		return;
 	}
 
-	switch (psci_ops.conduit) {
-	case PSCI_CONDUIT_HVC:
-		arm_smccc_1_1_hvc(ARM_SMCCC_ARCH_WORKAROUND_2, state, NULL);
-		break;
+	conduit = arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_WORKAROUND_2, state,
+				       NULL);
 
-	case PSCI_CONDUIT_SMC:
-		arm_smccc_1_1_smc(ARM_SMCCC_ARCH_WORKAROUND_2, state, NULL);
-		break;
-
-	default:
-		WARN_ON_ONCE(1);
-		break;
-	}
+	WARN_ON_ONCE(conduit == PSCI_CONDUIT_NONE);
 }
 
 static bool has_ssbd_mitigation(const struct arm64_cpu_capabilities *entry,
@@ -373,6 +356,7 @@ static bool has_ssbd_mitigation(const struct arm64_cpu_capabilities *entry,
 	bool required = true;
 	s32 val;
 	bool this_cpu_safe = false;
+	int conduit;
 
 	WARN_ON(scope != SCOPE_LOCAL_CPU || preemptible());
 
@@ -397,18 +381,10 @@ static bool has_ssbd_mitigation(const struct arm64_cpu_capabilities *entry,
 		return false;
 	}
 
-	switch (psci_ops.conduit) {
-	case PSCI_CONDUIT_HVC:
-		arm_smccc_1_1_hvc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
-				  ARM_SMCCC_ARCH_WORKAROUND_2, &res);
-		break;
-
-	case PSCI_CONDUIT_SMC:
-		arm_smccc_1_1_smc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
-				  ARM_SMCCC_ARCH_WORKAROUND_2, &res);
-		break;
+	conduit = arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
+				       ARM_SMCCC_ARCH_WORKAROUND_2, &res);
 
-	default:
+	if (conduit == PSCI_CONDUIT_NONE) {
 		ssbd_state = ARM64_SSBD_UNKNOWN;
 		if (!this_cpu_safe)
 			__ssb_safe = false;
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
