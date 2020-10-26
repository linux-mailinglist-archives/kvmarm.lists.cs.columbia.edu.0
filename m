Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3C663298E0E
	for <lists+kvmarm@lfdr.de>; Mon, 26 Oct 2020 14:35:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E35BE4B437;
	Mon, 26 Oct 2020 09:35:25 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L42WrIZoVTCR; Mon, 26 Oct 2020 09:35:22 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 44F634B4B4;
	Mon, 26 Oct 2020 09:35:18 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 49E854B3EA
 for <kvmarm@lists.cs.columbia.edu>; Mon, 26 Oct 2020 09:35:16 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hHW6ZdXPBe4n for <kvmarm@lists.cs.columbia.edu>;
 Mon, 26 Oct 2020 09:35:12 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 85E7E4B52E
 for <kvmarm@lists.cs.columbia.edu>; Mon, 26 Oct 2020 09:35:09 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7E3B62465D;
 Mon, 26 Oct 2020 13:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603719308;
 bh=gdX7E6xLMzfjP0pnhMlmC9cLjbp06QgwkPw2QUb+A44=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=tq5njhu8efZXMYul7OTAwzGZPy1adwOCo6F8SsMnFbRiHwDn/GwBV+s53vIsrSWO1
 9qY/EsDI0nec9ynd1BLDr3Hnc7DZrS3GXXGY6hzD3w7XG8JZit+x6rETntVsxH6O5W
 EHKJL0WploN+/IFU80DpKpk2BDKN2PNlEmF1+Ynk=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1kX2eQ-004Kjh-Kx; Mon, 26 Oct 2020 13:35:06 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: [PATCH 08/11] KVM: arm64: Inject AArch32 exceptions from HYP
Date: Mon, 26 Oct 2020 13:34:47 +0000
Message-Id: <20201026133450.73304-9-maz@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201026133450.73304-1-maz@kernel.org>
References: <20201026133450.73304-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, james.morse@arm.com,
 julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, ascull@google.com,
 will@kernel.org, qperret@google.com, dbrazdil@google.com,
 kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, Will Deacon <will@kernel.org>
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

Similarily to what has been done for AArch64, move the AArch32 exception
inhjection to HYP.

In order to not use the regmap selection code at EL2, simplify the code
populating the target mode's LR register by harcoding the two possible
LR registers (LR_abt in X20, LR_und in X22).

We also introduce new accessors for SPSR and CP15 registers.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kvm/aarch32.c       | 149 +---------------------
 arch/arm64/kvm/hyp/exception.c | 221 ++++++++++++++++++++++++++++++---
 2 files changed, 212 insertions(+), 158 deletions(-)

diff --git a/arch/arm64/kvm/aarch32.c b/arch/arm64/kvm/aarch32.c
index 40a62a99fbf8..ad453b47c517 100644
--- a/arch/arm64/kvm/aarch32.c
+++ b/arch/arm64/kvm/aarch32.c
@@ -19,20 +19,6 @@
 #define DFSR_FSC_EXTABT_nLPAE	0x08
 #define DFSR_LPAE		BIT(9)
 
-/*
- * Table taken from ARMv8 ARM DDI0487B-B, table G1-10.
- */
-static const u8 return_offsets[8][2] = {
-	[0] = { 0, 0 },		/* Reset, unused */
-	[1] = { 4, 2 },		/* Undefined */
-	[2] = { 0, 0 },		/* SVC, unused */
-	[3] = { 4, 4 },		/* Prefetch abort */
-	[4] = { 8, 8 },		/* Data abort */
-	[5] = { 0, 0 },		/* HVC, unused */
-	[6] = { 4, 4 },		/* IRQ, unused */
-	[7] = { 4, 4 },		/* FIQ, unused */
-};
-
 static bool pre_fault_synchronize(struct kvm_vcpu *vcpu)
 {
 	preempt_disable();
@@ -53,132 +39,10 @@ static void post_fault_synchronize(struct kvm_vcpu *vcpu, bool loaded)
 	}
 }
 
-/*
- * When an exception is taken, most CPSR fields are left unchanged in the
- * handler. However, some are explicitly overridden (e.g. M[4:0]).
- *
- * The SPSR/SPSR_ELx layouts differ, and the below is intended to work with
- * either format. Note: SPSR.J bit doesn't exist in SPSR_ELx, but this bit was
- * obsoleted by the ARMv7 virtualization extensions and is RES0.
- *
- * For the SPSR layout seen from AArch32, see:
- * - ARM DDI 0406C.d, page B1-1148
- * - ARM DDI 0487E.a, page G8-6264
- *
- * For the SPSR_ELx layout for AArch32 seen from AArch64, see:
- * - ARM DDI 0487E.a, page C5-426
- *
- * Here we manipulate the fields in order of the AArch32 SPSR_ELx layout, from
- * MSB to LSB.
- */
-static unsigned long get_except32_cpsr(struct kvm_vcpu *vcpu, u32 mode)
-{
-	u32 sctlr = vcpu_cp15(vcpu, c1_SCTLR);
-	unsigned long old, new;
-
-	old = *vcpu_cpsr(vcpu);
-	new = 0;
-
-	new |= (old & PSR_AA32_N_BIT);
-	new |= (old & PSR_AA32_Z_BIT);
-	new |= (old & PSR_AA32_C_BIT);
-	new |= (old & PSR_AA32_V_BIT);
-	new |= (old & PSR_AA32_Q_BIT);
-
-	// CPSR.IT[7:0] are set to zero upon any exception
-	// See ARM DDI 0487E.a, section G1.12.3
-	// See ARM DDI 0406C.d, section B1.8.3
-
-	new |= (old & PSR_AA32_DIT_BIT);
-
-	// CPSR.SSBS is set to SCTLR.DSSBS upon any exception
-	// See ARM DDI 0487E.a, page G8-6244
-	if (sctlr & BIT(31))
-		new |= PSR_AA32_SSBS_BIT;
-
-	// CPSR.PAN is unchanged unless SCTLR.SPAN == 0b0
-	// SCTLR.SPAN is RES1 when ARMv8.1-PAN is not implemented
-	// See ARM DDI 0487E.a, page G8-6246
-	new |= (old & PSR_AA32_PAN_BIT);
-	if (!(sctlr & BIT(23)))
-		new |= PSR_AA32_PAN_BIT;
-
-	// SS does not exist in AArch32, so ignore
-
-	// CPSR.IL is set to zero upon any exception
-	// See ARM DDI 0487E.a, page G1-5527
-
-	new |= (old & PSR_AA32_GE_MASK);
-
-	// CPSR.IT[7:0] are set to zero upon any exception
-	// See prior comment above
-
-	// CPSR.E is set to SCTLR.EE upon any exception
-	// See ARM DDI 0487E.a, page G8-6245
-	// See ARM DDI 0406C.d, page B4-1701
-	if (sctlr & BIT(25))
-		new |= PSR_AA32_E_BIT;
-
-	// CPSR.A is unchanged upon an exception to Undefined, Supervisor
-	// CPSR.A is set upon an exception to other modes
-	// See ARM DDI 0487E.a, pages G1-5515 to G1-5516
-	// See ARM DDI 0406C.d, page B1-1182
-	new |= (old & PSR_AA32_A_BIT);
-	if (mode != PSR_AA32_MODE_UND && mode != PSR_AA32_MODE_SVC)
-		new |= PSR_AA32_A_BIT;
-
-	// CPSR.I is set upon any exception
-	// See ARM DDI 0487E.a, pages G1-5515 to G1-5516
-	// See ARM DDI 0406C.d, page B1-1182
-	new |= PSR_AA32_I_BIT;
-
-	// CPSR.F is set upon an exception to FIQ
-	// CPSR.F is unchanged upon an exception to other modes
-	// See ARM DDI 0487E.a, pages G1-5515 to G1-5516
-	// See ARM DDI 0406C.d, page B1-1182
-	new |= (old & PSR_AA32_F_BIT);
-	if (mode == PSR_AA32_MODE_FIQ)
-		new |= PSR_AA32_F_BIT;
-
-	// CPSR.T is set to SCTLR.TE upon any exception
-	// See ARM DDI 0487E.a, page G8-5514
-	// See ARM DDI 0406C.d, page B1-1181
-	if (sctlr & BIT(30))
-		new |= PSR_AA32_T_BIT;
-
-	new |= mode;
-
-	return new;
-}
-
-static void prepare_fault32(struct kvm_vcpu *vcpu, u32 mode, u32 vect_offset)
-{
-	unsigned long spsr = *vcpu_cpsr(vcpu);
-	bool is_thumb = (spsr & PSR_AA32_T_BIT);
-	u32 return_offset = return_offsets[vect_offset >> 2][is_thumb];
-	u32 sctlr = vcpu_cp15(vcpu, c1_SCTLR);
-
-	*vcpu_cpsr(vcpu) = get_except32_cpsr(vcpu, mode);
-
-	/* Note: These now point to the banked copies */
-	vcpu_write_spsr(vcpu, host_spsr_to_spsr32(spsr));
-	*vcpu_reg32(vcpu, 14) = *vcpu_pc(vcpu) + return_offset;
-
-	/* Branch to exception vector */
-	if (sctlr & (1 << 13))
-		vect_offset += 0xffff0000;
-	else /* always have security exceptions */
-		vect_offset += vcpu_cp15(vcpu, c12_VBAR);
-
-	*vcpu_pc(vcpu) = vect_offset;
-}
-
 void kvm_inject_undef32(struct kvm_vcpu *vcpu)
 {
-	bool loaded = pre_fault_synchronize(vcpu);
-
-	prepare_fault32(vcpu, PSR_AA32_MODE_UND, 4);
-	post_fault_synchronize(vcpu, loaded);
+	vcpu->arch.flags |= (KVM_ARM64_EXCEPT_AA32_UND |
+			     KVM_ARM64_PENDING_EXCEPTION);
 }
 
 /*
@@ -188,7 +52,6 @@ void kvm_inject_undef32(struct kvm_vcpu *vcpu)
 static void inject_abt32(struct kvm_vcpu *vcpu, bool is_pabt,
 			 unsigned long addr)
 {
-	u32 vect_offset;
 	u32 *far, *fsr;
 	bool is_lpae;
 	bool loaded;
@@ -196,17 +59,17 @@ static void inject_abt32(struct kvm_vcpu *vcpu, bool is_pabt,
 	loaded = pre_fault_synchronize(vcpu);
 
 	if (is_pabt) {
-		vect_offset = 12;
+		vcpu->arch.flags |= (KVM_ARM64_EXCEPT_AA32_IABT |
+				     KVM_ARM64_PENDING_EXCEPTION);
 		far = &vcpu_cp15(vcpu, c6_IFAR);
 		fsr = &vcpu_cp15(vcpu, c5_IFSR);
 	} else { /* !iabt */
-		vect_offset = 16;
+		vcpu->arch.flags |= (KVM_ARM64_EXCEPT_AA32_DABT |
+				     KVM_ARM64_PENDING_EXCEPTION);
 		far = &vcpu_cp15(vcpu, c6_DFAR);
 		fsr = &vcpu_cp15(vcpu, c5_DFSR);
 	}
 
-	prepare_fault32(vcpu, PSR_AA32_MODE_ABT, vect_offset);
-
 	*far = addr;
 
 	/* Give the guest an IMPLEMENTATION DEFINED exception */
diff --git a/arch/arm64/kvm/hyp/exception.c b/arch/arm64/kvm/hyp/exception.c
index cd6e643639e8..8d1d1bcd9e69 100644
--- a/arch/arm64/kvm/hyp/exception.c
+++ b/arch/arm64/kvm/hyp/exception.c
@@ -33,6 +33,16 @@ static void __vcpu_write_spsr(struct kvm_vcpu *vcpu, u64 val)
 {
 	write_sysreg_el1(val, SYS_SPSR);
 }
+
+static void __vcpu_write_spsr_abt(struct kvm_vcpu *vcpu, u64 val)
+{
+	vcpu->arch.ctxt.spsr_abt = val;
+}
+
+static void __vcpu_write_spsr_und(struct kvm_vcpu *vcpu, u64 val)
+{
+	vcpu->arch.ctxt.spsr_und = val;
+}
 #elif defined (__KVM_VHE_HYPERVISOR__)
 /* On VHE, all the registers are already loaded on the CPU */
 static inline u64 __vcpu_read_sys_reg(const struct kvm_vcpu *vcpu, int reg)
@@ -57,10 +67,25 @@ static void __vcpu_write_spsr(struct kvm_vcpu *vcpu, u64 val)
 {
 	write_sysreg_el1(val, SYS_SPSR);
 }
+
+static void __vcpu_write_spsr_abt(struct kvm_vcpu *vcpu, u64 val)
+{
+	write_sysreg(val, spsr_abt);
+}
+
+static void __vcpu_write_spsr_und(struct kvm_vcpu *vcpu, u64 val)
+{
+	write_sysreg(val, spsr_und);
+}
 #else
 #error Hypervisor code only!
 #endif
 
+static inline u32 __vcpu_read_cp15(const struct kvm_vcpu *vcpu, int reg)
+{
+	return __vcpu_read_sys_reg(vcpu, reg / 2);
+}
+
 /*
  * This performs the exception entry at a given EL (@target_mode), stashing PC
  * and PSTATE into ELR and SPSR respectively, and compute the new PC/PSTATE.
@@ -155,23 +180,189 @@ static void enter_exception64(struct kvm_vcpu *vcpu, unsigned long target_mode,
 	__vcpu_write_spsr(vcpu, old);
 }
 
-void kvm_inject_exception(struct kvm_vcpu *vcpu)
+/*
+ * When an exception is taken, most CPSR fields are left unchanged in the
+ * handler. However, some are explicitly overridden (e.g. M[4:0]).
+ *
+ * The SPSR/SPSR_ELx layouts differ, and the below is intended to work with
+ * either format. Note: SPSR.J bit doesn't exist in SPSR_ELx, but this bit was
+ * obsoleted by the ARMv7 virtualization extensions and is RES0.
+ *
+ * For the SPSR layout seen from AArch32, see:
+ * - ARM DDI 0406C.d, page B1-1148
+ * - ARM DDI 0487E.a, page G8-6264
+ *
+ * For the SPSR_ELx layout for AArch32 seen from AArch64, see:
+ * - ARM DDI 0487E.a, page C5-426
+ *
+ * Here we manipulate the fields in order of the AArch32 SPSR_ELx layout, from
+ * MSB to LSB.
+ */
+static unsigned long get_except32_cpsr(struct kvm_vcpu *vcpu, u32 mode)
 {
-	switch (vcpu->arch.flags & KVM_ARM64_EXCEPT_MASK) {
-	case KVM_ARM64_EXCEPT_AA64_EL1_SYNC:
-		enter_exception64(vcpu, PSR_MODE_EL1h, except_type_sync);
-		break;
-	case KVM_ARM64_EXCEPT_AA64_EL1_IRQ:
-		enter_exception64(vcpu, PSR_MODE_EL1h, except_type_irq);
-		break;
-	case KVM_ARM64_EXCEPT_AA64_EL1_FIQ:
-		enter_exception64(vcpu, PSR_MODE_EL1h, except_type_fiq);
-		break;
-	case KVM_ARM64_EXCEPT_AA64_EL1_SERR:
-		enter_exception64(vcpu, PSR_MODE_EL1h, except_type_serror);
+	u32 sctlr = __vcpu_read_cp15(vcpu, c1_SCTLR);
+	unsigned long old, new;
+
+	old = *vcpu_cpsr(vcpu);
+	new = 0;
+
+	new |= (old & PSR_AA32_N_BIT);
+	new |= (old & PSR_AA32_Z_BIT);
+	new |= (old & PSR_AA32_C_BIT);
+	new |= (old & PSR_AA32_V_BIT);
+	new |= (old & PSR_AA32_Q_BIT);
+
+	// CPSR.IT[7:0] are set to zero upon any exception
+	// See ARM DDI 0487E.a, section G1.12.3
+	// See ARM DDI 0406C.d, section B1.8.3
+
+	new |= (old & PSR_AA32_DIT_BIT);
+
+	// CPSR.SSBS is set to SCTLR.DSSBS upon any exception
+	// See ARM DDI 0487E.a, page G8-6244
+	if (sctlr & BIT(31))
+		new |= PSR_AA32_SSBS_BIT;
+
+	// CPSR.PAN is unchanged unless SCTLR.SPAN == 0b0
+	// SCTLR.SPAN is RES1 when ARMv8.1-PAN is not implemented
+	// See ARM DDI 0487E.a, page G8-6246
+	new |= (old & PSR_AA32_PAN_BIT);
+	if (!(sctlr & BIT(23)))
+		new |= PSR_AA32_PAN_BIT;
+
+	// SS does not exist in AArch32, so ignore
+
+	// CPSR.IL is set to zero upon any exception
+	// See ARM DDI 0487E.a, page G1-5527
+
+	new |= (old & PSR_AA32_GE_MASK);
+
+	// CPSR.IT[7:0] are set to zero upon any exception
+	// See prior comment above
+
+	// CPSR.E is set to SCTLR.EE upon any exception
+	// See ARM DDI 0487E.a, page G8-6245
+	// See ARM DDI 0406C.d, page B4-1701
+	if (sctlr & BIT(25))
+		new |= PSR_AA32_E_BIT;
+
+	// CPSR.A is unchanged upon an exception to Undefined, Supervisor
+	// CPSR.A is set upon an exception to other modes
+	// See ARM DDI 0487E.a, pages G1-5515 to G1-5516
+	// See ARM DDI 0406C.d, page B1-1182
+	new |= (old & PSR_AA32_A_BIT);
+	if (mode != PSR_AA32_MODE_UND && mode != PSR_AA32_MODE_SVC)
+		new |= PSR_AA32_A_BIT;
+
+	// CPSR.I is set upon any exception
+	// See ARM DDI 0487E.a, pages G1-5515 to G1-5516
+	// See ARM DDI 0406C.d, page B1-1182
+	new |= PSR_AA32_I_BIT;
+
+	// CPSR.F is set upon an exception to FIQ
+	// CPSR.F is unchanged upon an exception to other modes
+	// See ARM DDI 0487E.a, pages G1-5515 to G1-5516
+	// See ARM DDI 0406C.d, page B1-1182
+	new |= (old & PSR_AA32_F_BIT);
+	if (mode == PSR_AA32_MODE_FIQ)
+		new |= PSR_AA32_F_BIT;
+
+	// CPSR.T is set to SCTLR.TE upon any exception
+	// See ARM DDI 0487E.a, page G8-5514
+	// See ARM DDI 0406C.d, page B1-1181
+	if (sctlr & BIT(30))
+		new |= PSR_AA32_T_BIT;
+
+	new |= mode;
+
+	return new;
+}
+
+/*
+ * Table taken from ARMv8 ARM DDI0487B-B, table G1-10.
+ */
+static const u8 return_offsets[8][2] = {
+	[0] = { 0, 0 },		/* Reset, unused */
+	[1] = { 4, 2 },		/* Undefined */
+	[2] = { 0, 0 },		/* SVC, unused */
+	[3] = { 4, 4 },		/* Prefetch abort */
+	[4] = { 8, 8 },		/* Data abort */
+	[5] = { 0, 0 },		/* HVC, unused */
+	[6] = { 4, 4 },		/* IRQ, unused */
+	[7] = { 4, 4 },		/* FIQ, unused */
+};
+
+static void enter_exception32(struct kvm_vcpu *vcpu, u32 mode, u32 vect_offset)
+{
+	unsigned long spsr = *vcpu_cpsr(vcpu);
+	bool is_thumb = (spsr & PSR_AA32_T_BIT);
+	u32 return_offset = return_offsets[vect_offset >> 2][is_thumb];
+	u32 sctlr = __vcpu_read_cp15(vcpu, c1_SCTLR);
+	int lr;
+
+	*vcpu_cpsr(vcpu) = get_except32_cpsr(vcpu, mode);
+
+	/*
+	 * Table D1-27 of DDI 0487F.c shows the GPR mapping between
+	 * AArch32 and AArch64. We only deal with ABT/UND.
+	 */
+	switch(mode) {
+	case PSR_AA32_MODE_ABT:
+		__vcpu_write_spsr_abt(vcpu, host_spsr_to_spsr32(spsr));
+		lr = 20;
 		break;
-	default:
-		/* EL2 are unimplemented until we get NV. One day. */
+		
+	case PSR_AA32_MODE_UND:
+		__vcpu_write_spsr_und(vcpu, host_spsr_to_spsr32(spsr));
+		lr = 22;
 		break;
 	}
+
+	vcpu_set_reg(vcpu, lr, *vcpu_pc(vcpu) + return_offset);
+
+	/* Branch to exception vector */
+	if (sctlr & (1 << 13))
+		vect_offset += 0xffff0000;
+	else /* always have security exceptions */
+		vect_offset += __vcpu_read_cp15(vcpu, c12_VBAR);
+
+	*vcpu_pc(vcpu) = vect_offset;
+}
+
+void kvm_inject_exception(struct kvm_vcpu *vcpu)
+{
+	if (vcpu_el1_is_32bit(vcpu)) {
+		switch (vcpu->arch.flags & KVM_ARM64_EXCEPT_MASK) {
+		case KVM_ARM64_EXCEPT_AA32_UND:
+			enter_exception32(vcpu, PSR_AA32_MODE_UND, 4);
+			break;
+		case KVM_ARM64_EXCEPT_AA32_IABT:
+			enter_exception32(vcpu, PSR_AA32_MODE_ABT, 12);
+			break;
+		case KVM_ARM64_EXCEPT_AA32_DABT:
+			enter_exception32(vcpu, PSR_AA32_MODE_ABT, 16);
+			break;
+		default:
+			/* Err... */
+			break;
+		}
+	} else {
+		switch (vcpu->arch.flags & KVM_ARM64_EXCEPT_MASK) {
+		case KVM_ARM64_EXCEPT_AA64_EL1_SYNC:
+			enter_exception64(vcpu, PSR_MODE_EL1h, except_type_sync);
+			break;
+		case KVM_ARM64_EXCEPT_AA64_EL1_IRQ:
+			enter_exception64(vcpu, PSR_MODE_EL1h, except_type_irq);
+			break;
+		case KVM_ARM64_EXCEPT_AA64_EL1_FIQ:
+			enter_exception64(vcpu, PSR_MODE_EL1h, except_type_fiq);
+			break;
+		case KVM_ARM64_EXCEPT_AA64_EL1_SERR:
+			enter_exception64(vcpu, PSR_MODE_EL1h, except_type_serror);
+			break;
+		default:
+			/* EL2 are unimplemented until we get NV. One day. */
+			break;
+		}
+	}
 }
-- 
2.28.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
