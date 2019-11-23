Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 38986107E45
	for <lists+kvmarm@lfdr.de>; Sat, 23 Nov 2019 12:56:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6C65A4AEE4;
	Sat, 23 Nov 2019 06:56:32 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oRdbowMj5Bhr; Sat, 23 Nov 2019 06:56:32 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D9E8C4AED2;
	Sat, 23 Nov 2019 06:56:30 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CA5114AEC5
 for <kvmarm@lists.cs.columbia.edu>; Sat, 23 Nov 2019 06:56:29 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9MFIZqdDYgo6 for <kvmarm@lists.cs.columbia.edu>;
 Sat, 23 Nov 2019 06:56:28 -0500 (EST)
Received: from inca-roads.misterjones.org (inca-roads.misterjones.org
 [213.251.177.50])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 0349F4AC82
 for <kvmarm@lists.cs.columbia.edu>; Sat, 23 Nov 2019 06:56:27 -0500 (EST)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by cheepnis.misterjones.org with esmtpsa
 (TLSv1.2:DHE-RSA-AES128-GCM-SHA256:128) (Exim 4.80)
 (envelope-from <maz@kernel.org>)
 id 1iYU1Z-0007fK-N5; Sat, 23 Nov 2019 12:56:25 +0100
From: Marc Zyngier <maz@kernel.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/arm: Honor HCR_EL2.TID3 trapping requirements
Date: Sat, 23 Nov 2019 11:56:18 +0000
Message-Id: <20191123115618.29230-1-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: qemu-devel@nongnu.org, kvmarm@lists.cs.columbia.edu,
 peter.maydell@linaro.org, will@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org);
 SAEximRunCond expanded to false
Cc: Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu
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

HCR_EL2.TID3 mandates that access from EL1 to a long list of id
registers traps to EL2, and QEMU has so far ignored this requirement.

This breaks (among other things) KVM guests that have PtrAuth enabled,
while the hypervisor doesn't want to expose the feature to its guest.
To achieve this, KVM traps the ID registers (ID_AA64ISAR1_EL1 in this
case), and masks out the unsupported feature.

QEMU not honoring the trap request means that the guest observes
that the feature is present in the HW, starts using it, and dies
a horrible death when KVM injects an UNDEF, because the feature
*really* isn't supported.

Do the right thing by trapping to EL2 if HCR_EL2.TID3 is set.

Reported-by: Will Deacon <will@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
There is a number of other trap bits missing (TID[0-2], for example),
but this at least gets a mainline Linux going with cpu=max.

 target/arm/helper.c | 75 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 027fffbff6..976e96f62b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5978,6 +5978,26 @@ static const ARMCPRegInfo predinv_reginfo[] = {
     REGINFO_SENTINEL
 };
 
+static CPAccessResult access_aa64idreg(CPUARMState *env, const ARMCPRegInfo *ri,
+                                       bool isread)
+{
+    if ((arm_current_el(env) < 2) && (arm_hcr_el2_eff(env) & HCR_TID3)) {
+        return CP_ACCESS_TRAP_EL2;
+    }
+
+    return CP_ACCESS_OK;
+}
+
+static CPAccessResult access_aa32idreg(CPUARMState *env, const ARMCPRegInfo *ri,
+                                       bool isread)
+{
+    if (arm_feature(env, ARM_FEATURE_V8)) {
+        return access_aa64idreg(env, ri, isread);
+    }
+
+    return CP_ACCESS_OK;
+}
+
 void register_cp_regs_for_features(ARMCPU *cpu)
 {
     /* Register all the coprocessor registers based on feature bits */
@@ -6001,6 +6021,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             { .name = "ID_PFR0", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 0,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa32idreg,
               .resetvalue = cpu->id_pfr0 },
             /* ID_PFR1 is not a plain ARM_CP_CONST because we don't know
              * the value of the GIC field until after we define these regs.
@@ -6008,63 +6029,78 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             { .name = "ID_PFR1", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_NO_RAW,
+              .accessfn = access_aa32idreg,
               .readfn = id_pfr1_read,
               .writefn = arm_cp_write_ignore },
             { .name = "ID_DFR0", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa32idreg,
               .resetvalue = cpu->id_dfr0 },
             { .name = "ID_AFR0", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 3,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa32idreg,
               .resetvalue = cpu->id_afr0 },
             { .name = "ID_MMFR0", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 4,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa32idreg,
               .resetvalue = cpu->id_mmfr0 },
             { .name = "ID_MMFR1", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 5,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa32idreg,
               .resetvalue = cpu->id_mmfr1 },
             { .name = "ID_MMFR2", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 6,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa32idreg,
               .resetvalue = cpu->id_mmfr2 },
             { .name = "ID_MMFR3", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 7,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa32idreg,
               .resetvalue = cpu->id_mmfr3 },
             { .name = "ID_ISAR0", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 0,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa32idreg,
               .resetvalue = cpu->isar.id_isar0 },
             { .name = "ID_ISAR1", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa32idreg,
               .resetvalue = cpu->isar.id_isar1 },
             { .name = "ID_ISAR2", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa32idreg,
               .resetvalue = cpu->isar.id_isar2 },
             { .name = "ID_ISAR3", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 3,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa32idreg,
               .resetvalue = cpu->isar.id_isar3 },
             { .name = "ID_ISAR4", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 4,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa32idreg,
               .resetvalue = cpu->isar.id_isar4 },
             { .name = "ID_ISAR5", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 5,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa32idreg,
               .resetvalue = cpu->isar.id_isar5 },
             { .name = "ID_MMFR4", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 6,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa32idreg,
               .resetvalue = cpu->id_mmfr4 },
             { .name = "ID_ISAR6", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 7,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa32idreg,
               .resetvalue = cpu->isar.id_isar6 },
             REGINFO_SENTINEL
         };
@@ -6185,11 +6221,13 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             { .name = "ID_AA64PFR0_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 0,
               .access = PL1_R, .type = ARM_CP_NO_RAW,
+              .accessfn = access_aa64idreg,
               .readfn = id_aa64pfr0_read,
               .writefn = arm_cp_write_ignore },
             { .name = "ID_AA64PFR1_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64idreg,
               .resetvalue = cpu->isar.id_aa64pfr1},
             { .name = "ID_AA64PFR2_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 2,
@@ -6198,151 +6236,188 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             { .name = "ID_AA64PFR3_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 3,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64idreg,
               .resetvalue = 0 },
             { .name = "ID_AA64ZFR0_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 4,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64idreg,
               /* At present, only SVEver == 0 is defined anyway.  */
               .resetvalue = 0 },
             { .name = "ID_AA64PFR5_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 5,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64idreg,
               .resetvalue = 0 },
             { .name = "ID_AA64PFR6_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 6,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64idreg,
               .resetvalue = 0 },
             { .name = "ID_AA64PFR7_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 7,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64idreg,
               .resetvalue = 0 },
             { .name = "ID_AA64DFR0_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 0,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64idreg,
               .resetvalue = cpu->id_aa64dfr0 },
             { .name = "ID_AA64DFR1_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64idreg,
               .resetvalue = cpu->id_aa64dfr1 },
             { .name = "ID_AA64DFR2_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64idreg,
               .resetvalue = 0 },
             { .name = "ID_AA64DFR3_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 3,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64idreg,
               .resetvalue = 0 },
             { .name = "ID_AA64AFR0_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 4,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64idreg,
               .resetvalue = cpu->id_aa64afr0 },
             { .name = "ID_AA64AFR1_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 5,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64idreg,
               .resetvalue = cpu->id_aa64afr1 },
             { .name = "ID_AA64AFR2_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 6,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64idreg,
               .resetvalue = 0 },
             { .name = "ID_AA64AFR3_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 7,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64idreg,
               .resetvalue = 0 },
             { .name = "ID_AA64ISAR0_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 0,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64idreg,
               .resetvalue = cpu->isar.id_aa64isar0 },
             { .name = "ID_AA64ISAR1_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64idreg,
               .resetvalue = cpu->isar.id_aa64isar1 },
             { .name = "ID_AA64ISAR2_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64idreg,
               .resetvalue = 0 },
             { .name = "ID_AA64ISAR3_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 3,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64idreg,
               .resetvalue = 0 },
             { .name = "ID_AA64ISAR4_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 4,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64idreg,
               .resetvalue = 0 },
             { .name = "ID_AA64ISAR5_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 5,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64idreg,
               .resetvalue = 0 },
             { .name = "ID_AA64ISAR6_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 6,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64idreg,
               .resetvalue = 0 },
             { .name = "ID_AA64ISAR7_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 7,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64idreg,
               .resetvalue = 0 },
             { .name = "ID_AA64MMFR0_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 0,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64idreg,
               .resetvalue = cpu->isar.id_aa64mmfr0 },
             { .name = "ID_AA64MMFR1_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64idreg,
               .resetvalue = cpu->isar.id_aa64mmfr1 },
             { .name = "ID_AA64MMFR2_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64idreg,
               .resetvalue = 0 },
             { .name = "ID_AA64MMFR3_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 3,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64idreg,
               .resetvalue = 0 },
             { .name = "ID_AA64MMFR4_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 4,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64idreg,
               .resetvalue = 0 },
             { .name = "ID_AA64MMFR5_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 5,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64idreg,
               .resetvalue = 0 },
             { .name = "ID_AA64MMFR6_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 6,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64idreg,
               .resetvalue = 0 },
             { .name = "ID_AA64MMFR7_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 7,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64idreg,
               .resetvalue = 0 },
             { .name = "MVFR0_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 0,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64idreg,
               .resetvalue = cpu->isar.mvfr0 },
             { .name = "MVFR1_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64idreg,
               .resetvalue = cpu->isar.mvfr1 },
             { .name = "MVFR2_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64idreg,
               .resetvalue = cpu->isar.mvfr2 },
             { .name = "MVFR3_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 3,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64idreg,
               .resetvalue = 0 },
             { .name = "MVFR4_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 4,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64idreg,
               .resetvalue = 0 },
             { .name = "MVFR5_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 5,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64idreg,
               .resetvalue = 0 },
             { .name = "MVFR6_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 6,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64idreg,
               .resetvalue = 0 },
             { .name = "MVFR7_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 7,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64idreg,
               .resetvalue = 0 },
             { .name = "PMCEID0", .state = ARM_CP_STATE_AA32,
               .cp = 15, .opc1 = 0, .crn = 9, .crm = 12, .opc2 = 6,
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
