Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B7B25127EFF
	for <lists+kvmarm@lfdr.de>; Fri, 20 Dec 2019 16:06:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6ABCE4A578;
	Fri, 20 Dec 2019 10:06:02 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zuLiaQm30fvE; Fri, 20 Dec 2019 10:06:01 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 42B484A95B;
	Fri, 20 Dec 2019 10:06:01 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8E3B14A4F7
 for <kvmarm@lists.cs.columbia.edu>; Fri, 20 Dec 2019 10:06:00 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X9f-fgcTVGtU for <kvmarm@lists.cs.columbia.edu>;
 Fri, 20 Dec 2019 10:05:59 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 336C14A51F
 for <kvmarm@lists.cs.columbia.edu>; Fri, 20 Dec 2019 10:05:58 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D609C31B;
 Fri, 20 Dec 2019 07:05:57 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4E1D83F6CF;
 Fri, 20 Dec 2019 07:05:56 -0800 (PST)
From: Mark Rutland <mark.rutland@arm.com>
To: kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 maz@kernel.org
Subject: [PATCH 1/3] KVM: arm64: correct PSTATE on exception entry
Date: Fri, 20 Dec 2019 15:05:47 +0000
Message-Id: <20191220150549.31948-2-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191220150549.31948-1-mark.rutland@arm.com>
References: <20191220150549.31948-1-mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>, stable@vger.kernel.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

When KVM injects an exception into a guest, it generates the PSTATE
value from scratch, configuring PSTATE.{M[4:0],DAIF}, and setting all
other bits to zero.

This isn't correct, as the architecture specifies that some PSTATE bits
are (conditionally) cleared or set upon an exception, and others are
unchanged from the original context.

This patch adds logic to match the architectural behaviour. To make this
simple to follow/audit/extend, documentation references are provided,
and bits are configured in order of their layout in SPSR_EL2. This
layout can be seen in the diagram on ARM DDI 0487E.a page C5-429.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: Drew Jones <drjones@redhat.com>
Cc: James Morse <james.morse@arm.com>
Cc: Julien Thierry <julien.thierry.kdev@gmail.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: stable@vger.kernel.org
---
 arch/arm64/include/uapi/asm/ptrace.h |  1 +
 arch/arm64/kvm/inject_fault.c        | 69 +++++++++++++++++++++++++++++++++---
 2 files changed, 65 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
index 7ed9294e2004..d1bb5b69f1ce 100644
--- a/arch/arm64/include/uapi/asm/ptrace.h
+++ b/arch/arm64/include/uapi/asm/ptrace.h
@@ -49,6 +49,7 @@
 #define PSR_SSBS_BIT	0x00001000
 #define PSR_PAN_BIT	0x00400000
 #define PSR_UAO_BIT	0x00800000
+#define PSR_DIT_BIT	0x01000000
 #define PSR_V_BIT	0x10000000
 #define PSR_C_BIT	0x20000000
 #define PSR_Z_BIT	0x40000000
diff --git a/arch/arm64/kvm/inject_fault.c b/arch/arm64/kvm/inject_fault.c
index a9d25a305af5..270d91c05246 100644
--- a/arch/arm64/kvm/inject_fault.c
+++ b/arch/arm64/kvm/inject_fault.c
@@ -14,9 +14,6 @@
 #include <asm/kvm_emulate.h>
 #include <asm/esr.h>
 
-#define PSTATE_FAULT_BITS_64 	(PSR_MODE_EL1h | PSR_A_BIT | PSR_F_BIT | \
-				 PSR_I_BIT | PSR_D_BIT)
-
 #define CURRENT_EL_SP_EL0_VECTOR	0x0
 #define CURRENT_EL_SP_ELx_VECTOR	0x200
 #define LOWER_EL_AArch64_VECTOR		0x400
@@ -50,6 +47,68 @@ static u64 get_except_vector(struct kvm_vcpu *vcpu, enum exception_type type)
 	return vcpu_read_sys_reg(vcpu, VBAR_EL1) + exc_offset + type;
 }
 
+/*
+ * When an exception is taken, most PSTATE fields are left unchanged in the
+ * handler. However, some are explicitly overridden (e.g. M[4:0]). Luckily all
+ * of the inherited bits have the same position in the AArch64/AArch32 SPSR_ELx
+ * layouts, so we don't need to shuffle these for exceptions from AArch32 EL0.
+ *
+ * For the SPSR_ELx layout for AArch64, see ARM DDI 0487E.a page C5-429.
+ * For the SPSR_ELx layout for AArch32, see ARM DDI 0487E.a page C5-426.
+ *
+ * Here we manipulate the fields in order of the AArch64 SPSR_ELx layout, from
+ * MSB to LSB.
+ */
+static unsigned long get_except64_pstate(struct kvm_vcpu *vcpu)
+{
+	unsigned long sctlr = vcpu_read_sys_reg(vcpu, SCTLR_EL1);
+	unsigned long old, new;
+
+	old = *vcpu_cpsr(vcpu);
+	new = 0;
+
+	new |= (old & PSR_N_BIT);
+	new |= (old & PSR_Z_BIT);
+	new |= (old & PSR_C_BIT);
+	new |= (old & PSR_V_BIT);
+
+	// TODO: TCO (if/when ARMv8.5-MemTag is exposed to guests)
+
+	new |= (old & PSR_DIT_BIT);
+
+	// PSTATE.UAO is set to zero upon any exception to AArch64
+	// See ARM DDI 0487E.a, page D5-2579.
+
+	// PSTATE.PAN is unchanged unless overridden by SCTLR_ELx.SPAN
+	// See ARM DDI 0487E.a, page D5-2578.
+	new |= (old & PSR_PAN_BIT);
+	if (sctlr & SCTLR_EL1_SPAN)
+		new |= PSR_PAN_BIT;
+
+	// PSTATE.SS is set to zero upon any exception to AArch64
+	// See ARM DDI 0487E.a, page D2-2452.
+
+	// PSTATE.IL is set to zero upon any exception to AArch64
+	// See ARM DDI 0487E.a, page D1-2306.
+
+	// PSTATE.SSBS is set to SCTLR_ELx.DSSBS upon any exception to AArch64
+	// See ARM DDI 0487E.a, page D13-3258
+	if (sctlr & SCTLR_ELx_DSSBS)
+		new |= PSR_SSBS_BIT;
+
+	// PSTATE.BTYPE is set to zero upon any exception to AArch64
+	// See ARM DDI 0487E.a, pages D1-2293 to D1-2294.
+
+	new |= PSR_D_BIT;
+	new |= PSR_A_BIT;
+	new |= PSR_I_BIT;
+	new |= PSR_F_BIT;
+
+	new |= PSR_MODE_EL1h;
+
+	return new;
+}
+
 static void inject_abt64(struct kvm_vcpu *vcpu, bool is_iabt, unsigned long addr)
 {
 	unsigned long cpsr = *vcpu_cpsr(vcpu);
@@ -59,7 +118,7 @@ static void inject_abt64(struct kvm_vcpu *vcpu, bool is_iabt, unsigned long addr
 	vcpu_write_elr_el1(vcpu, *vcpu_pc(vcpu));
 	*vcpu_pc(vcpu) = get_except_vector(vcpu, except_type_sync);
 
-	*vcpu_cpsr(vcpu) = PSTATE_FAULT_BITS_64;
+	*vcpu_cpsr(vcpu) = get_except64_pstate(vcpu);
 	vcpu_write_spsr(vcpu, cpsr);
 
 	vcpu_write_sys_reg(vcpu, addr, FAR_EL1);
@@ -94,7 +153,7 @@ static void inject_undef64(struct kvm_vcpu *vcpu)
 	vcpu_write_elr_el1(vcpu, *vcpu_pc(vcpu));
 	*vcpu_pc(vcpu) = get_except_vector(vcpu, except_type_sync);
 
-	*vcpu_cpsr(vcpu) = PSTATE_FAULT_BITS_64;
+	*vcpu_cpsr(vcpu) = get_except64_pstate(vcpu);
 	vcpu_write_spsr(vcpu, cpsr);
 
 	/*
-- 
2.11.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
