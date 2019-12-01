Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5BA10E1D9
	for <lists+kvmarm@lfdr.de>; Sun,  1 Dec 2019 13:20:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0E4AA4AECC;
	Sun,  1 Dec 2019 07:20:57 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u5tXxHJkWKEF; Sun,  1 Dec 2019 07:20:56 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DFB194AEE6;
	Sun,  1 Dec 2019 07:20:52 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8E23A4AECF
 for <kvmarm@lists.cs.columbia.edu>; Sun,  1 Dec 2019 07:20:51 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GqtQy9vejUR3 for <kvmarm@lists.cs.columbia.edu>;
 Sun,  1 Dec 2019 07:20:50 -0500 (EST)
Received: from inca-roads.misterjones.org (inca-roads.misterjones.org
 [213.251.177.50])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 929334AC80
 for <kvmarm@lists.cs.columbia.edu>; Sun,  1 Dec 2019 07:20:49 -0500 (EST)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by cheepnis.misterjones.org with esmtpsa
 (TLSv1.2:DHE-RSA-AES128-GCM-SHA256:128) (Exim 4.80)
 (envelope-from <maz@kernel.org>)
 id 1ibODX-0007WK-Hy; Sun, 01 Dec 2019 13:20:47 +0100
From: Marc Zyngier <maz@kernel.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/5] target/arm: Handle trapping to EL2 of AArch32 VMRS
 instructions
Date: Sun,  1 Dec 2019 12:20:16 +0000
Message-Id: <20191201122018.25808-4-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191201122018.25808-1-maz@kernel.org>
References: <20191201122018.25808-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: qemu-devel@nongnu.org, kvmarm@lists.cs.columbia.edu,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 edgar.iglesias@xilinx.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org);
 SAEximRunCond expanded to false
Cc: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>,
 Richard Henderson <richard.henderson@linaro.org>, kvmarm@lists.cs.columbia.edu
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

HCR_EL2.TID3 requires that AArch32 reads of MVFR[012] are trapped to
EL2, and HCR_EL2.TID0 does the same for reads of FPSID.
In order to handle this, introduce a new TCG helper function that
checks for these control bits before executing the VMRC instruction.

Tested with a hacked-up version of KVM/arm64 that sets the control
bits for 32bit guests.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 target/arm/helper-a64.h        |  2 ++
 target/arm/translate-vfp.inc.c | 18 +++++++++++++++---
 target/arm/vfp_helper.c        | 29 +++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index a915c1247f..0af44dc814 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -102,3 +102,5 @@ DEF_HELPER_FLAGS_3(autda, TCG_CALL_NO_WG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(autdb, TCG_CALL_NO_WG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_2(xpaci, TCG_CALL_NO_RWG_SE, i64, env, i64)
 DEF_HELPER_FLAGS_2(xpacd, TCG_CALL_NO_RWG_SE, i64, env, i64)
+
+DEF_HELPER_3(check_hcr_el2_trap, void, env, i32, i32)
diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 85c5ef897b..bf90ac0e5b 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -761,13 +761,25 @@ static bool trans_VMSR_VMRS(DisasContext *s, arg_VMSR_VMRS *a)
     if (a->l) {
         /* VMRS, move VFP special register to gp register */
         switch (a->reg) {
+        case ARM_VFP_MVFR0:
+        case ARM_VFP_MVFR1:
+        case ARM_VFP_MVFR2:
         case ARM_VFP_FPSID:
+            if (s->current_el == 1) {
+                TCGv_i32 tcg_reg, tcg_rt;
+
+                gen_set_condexec(s);
+                gen_set_pc_im(s, s->pc_curr);
+                tcg_reg = tcg_const_i32(a->reg);
+                tcg_rt = tcg_const_i32(a->rt);
+                gen_helper_check_hcr_el2_trap(cpu_env, tcg_rt, tcg_reg);
+                tcg_temp_free_i32(tcg_reg);
+                tcg_temp_free_i32(tcg_rt);
+            }
+            /* fall through */
         case ARM_VFP_FPEXC:
         case ARM_VFP_FPINST:
         case ARM_VFP_FPINST2:
-        case ARM_VFP_MVFR0:
-        case ARM_VFP_MVFR1:
-        case ARM_VFP_MVFR2:
             tmp = load_cpu_field(vfp.xregs[a->reg]);
             break;
         case ARM_VFP_FPSCR:
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 9710ef1c3e..0ae7d4f34a 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -1322,4 +1322,33 @@ float64 HELPER(frint64_d)(float64 f, void *fpst)
     return frint_d(f, fpst, 64);
 }
 
+void HELPER(check_hcr_el2_trap)(CPUARMState *env, uint32_t rt, uint32_t reg)
+{
+    uint32_t syndrome;
+
+    switch (reg) {
+    case ARM_VFP_MVFR0:
+    case ARM_VFP_MVFR1:
+    case ARM_VFP_MVFR2:
+        if (!(arm_hcr_el2_eff(env) & HCR_TID3)) {
+            return;
+        }
+        break;
+    case ARM_VFP_FPSID:
+        if (!(arm_hcr_el2_eff(env) & HCR_TID0)) {
+            return;
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    syndrome = ((EC_FPIDTRAP << ARM_EL_EC_SHIFT)
+                | ARM_EL_IL
+                | (1 << 24) | (0xe << 20) | (7 << 14)
+                | (reg << 10) | (rt << 5) | 1);
+
+    raise_exception(env, EXCP_HYP_TRAP, syndrome, 2);
+}
+
 #endif
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
