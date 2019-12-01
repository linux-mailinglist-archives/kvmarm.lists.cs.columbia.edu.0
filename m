Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8446710E1D8
	for <lists+kvmarm@lfdr.de>; Sun,  1 Dec 2019 13:20:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1D0D74AED9;
	Sun,  1 Dec 2019 07:20:55 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kRj84NwdXyuC; Sun,  1 Dec 2019 07:20:55 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C52E14AECF;
	Sun,  1 Dec 2019 07:20:51 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BE56F4AC65
 for <kvmarm@lists.cs.columbia.edu>; Sun,  1 Dec 2019 07:20:50 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1H8BPxRsvtkS for <kvmarm@lists.cs.columbia.edu>;
 Sun,  1 Dec 2019 07:20:49 -0500 (EST)
Received: from inca-roads.misterjones.org (inca-roads.misterjones.org
 [213.251.177.50])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 8ED854A98A
 for <kvmarm@lists.cs.columbia.edu>; Sun,  1 Dec 2019 07:20:49 -0500 (EST)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by cheepnis.misterjones.org with esmtpsa
 (TLSv1.2:DHE-RSA-AES128-GCM-SHA256:128) (Exim 4.80)
 (envelope-from <maz@kernel.org>)
 id 1ibODY-0007WK-09; Sun, 01 Dec 2019 13:20:48 +0100
From: Marc Zyngier <maz@kernel.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/5] target/arm: Handle AArch32 CP15 trapping via HSTR_EL2
Date: Sun,  1 Dec 2019 12:20:17 +0000
Message-Id: <20191201122018.25808-5-maz@kernel.org>
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

HSTR_EL2 offers a way to trap ranges of CP15 system register
accesses to EL2, and it looks like this register is completely
ignored by QEMU.

To avoid adding extra .accessfn filters all over the place (which
would have a direct performance impact), let's add a new TB flag
that gets set whenever HSTR_EL2 is non-zero and that QEMU translates
a context where this trap has a chance to apply, and only generate
the extra access check if the hypervisor is actively using this feature.

Tested with a hand-crafted KVM guest accessing CBAR.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 target/arm/cpu.h       |  2 ++
 target/arm/helper.c    |  6 ++++++
 target/arm/op_helper.c | 21 +++++++++++++++++++++
 target/arm/translate.c |  3 ++-
 target/arm/translate.h |  2 ++
 5 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 83a809d4ba..cebb3511a5 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3215,6 +3215,8 @@ FIELD(TBFLAG_A32, NS, 6, 1)
 FIELD(TBFLAG_A32, VFPEN, 7, 1)          /* Partially cached, minus FPEXC. */
 FIELD(TBFLAG_A32, CONDEXEC, 8, 8)       /* Not cached. */
 FIELD(TBFLAG_A32, SCTLR_B, 16, 1)
+FIELD(TBFLAG_A32, HSTR_ACTIVE, 17, 1)
+
 /* For M profile only, set if FPCCR.LSPACT is set */
 FIELD(TBFLAG_A32, LSPACT, 18, 1)        /* Not cached. */
 /* For M profile only, set if we must create a new FP context */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 93ecab27c0..0ba08d550a 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11283,6 +11283,12 @@ static uint32_t rebuild_hflags_a32(CPUARMState *env, int fp_el,
     if (arm_el_is_aa64(env, 1)) {
         flags = FIELD_DP32(flags, TBFLAG_A32, VFPEN, 1);
     }
+
+    if (arm_current_el(env) < 2 && env->cp15.hstr_el2 &&
+        (arm_hcr_el2_eff(env) & (HCR_E2H | HCR_TGE)) != (HCR_E2H | HCR_TGE)) {
+        flags = FIELD_DP32(flags, TBFLAG_A32, HSTR_ACTIVE, 1);
+    }
+
     return rebuild_hflags_common_32(env, fp_el, mmu_idx, flags);
 }
 
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index b529d6c1bf..681c5f3681 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -603,6 +603,26 @@ void HELPER(access_check_cp_reg)(CPUARMState *env, void *rip, uint32_t syndrome,
         raise_exception(env, EXCP_UDEF, syndrome, exception_target_el(env));
     }
 
+    /* Check for an EL2 trap due to HSTR_EL2. We expect EL0 accesses
+     * to sysregs non accessible at EL0 to have UNDEF-ed already.
+     */
+    if (!env->aarch64 && arm_current_el(env) < 2 && ri->cp == 15 &&
+        (arm_hcr_el2_eff(env) & (HCR_E2H | HCR_TGE)) != (HCR_E2H | HCR_TGE)) {
+        uint32_t mask = 1 << ri->crn;
+
+        if (ri->type & ARM_CP_64BIT) {
+            mask = 1 << ri->crm;
+        }
+
+        /* T4 and T14 are RES0 */
+        mask &= ~((1 << 4) | (1 << 14));
+
+        if (env->cp15.hstr_el2 & mask) {
+            target_el = 2;
+            goto exept;
+        }
+    }
+
     if (!ri->accessfn) {
         return;
     }
@@ -652,6 +672,7 @@ void HELPER(access_check_cp_reg)(CPUARMState *env, void *rip, uint32_t syndrome,
         g_assert_not_reached();
     }
 
+exept:
     raise_exception(env, EXCP_UDEF, syndrome, target_el);
 }
 
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 4d5d4bd888..f162be8434 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -6897,7 +6897,7 @@ static int disas_coproc_insn(DisasContext *s, uint32_t insn)
             return 1;
         }
 
-        if (ri->accessfn ||
+        if (s->hstr_active || ri->accessfn ||
             (arm_dc_feature(s, ARM_FEATURE_XSCALE) && cpnum < 14)) {
             /* Emit code to perform further access permissions checks at
              * runtime; this may result in an exception.
@@ -10843,6 +10843,7 @@ static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
                                !arm_el_is_aa64(env, 3);
     dc->thumb = FIELD_EX32(tb_flags, TBFLAG_A32, THUMB);
     dc->sctlr_b = FIELD_EX32(tb_flags, TBFLAG_A32, SCTLR_B);
+    dc->hstr_active = FIELD_EX32(tb_flags, TBFLAG_A32, HSTR_ACTIVE);
     dc->be_data = FIELD_EX32(tb_flags, TBFLAG_ANY, BE_DATA) ? MO_BE : MO_LE;
     condexec = FIELD_EX32(tb_flags, TBFLAG_A32, CONDEXEC);
     dc->condexec_mask = (condexec & 0xf) << 1;
diff --git a/target/arm/translate.h b/target/arm/translate.h
index dd24f91f26..b837b7fcbf 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -77,6 +77,8 @@ typedef struct DisasContext {
     bool pauth_active;
     /* True with v8.5-BTI and SCTLR_ELx.BT* set.  */
     bool bt;
+    /* True if any CP15 access is trapped by HSTR_EL2 */
+    bool hstr_active;
     /*
      * >= 0, a copy of PSTATE.BTYPE, which will be 0 without v8.5-BTI.
      *  < 0, set by the current instruction.
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
