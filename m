Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3618F2569D
	for <lists+kvmarm@lfdr.de>; Tue, 21 May 2019 19:26:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 776784A50C;
	Tue, 21 May 2019 13:25:56 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KmwUYXgb9sEA; Tue, 21 May 2019 13:25:56 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B4FA74A516;
	Tue, 21 May 2019 13:25:54 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 837B24A483
 for <kvmarm@lists.cs.columbia.edu>; Tue, 21 May 2019 13:25:53 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7HhjsJa0jJwi for <kvmarm@lists.cs.columbia.edu>;
 Tue, 21 May 2019 13:25:51 -0400 (EDT)
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B18A14A521
 for <kvmarm@lists.cs.columbia.edu>; Tue, 21 May 2019 13:25:51 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32CBD15A2;
 Tue, 21 May 2019 10:25:51 -0700 (PDT)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 897D93F718;
 Tue, 21 May 2019 10:25:49 -0700 (PDT)
From: James Morse <james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.cs.columbia.edu
Subject: [PATCH 2/2] KVM: arm/arm64: Move cc/it checks under hyp's Makefile to
 avoid instrumentation
Date: Tue, 21 May 2019 18:25:31 +0100
Message-Id: <20190521172531.89309-3-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190521172531.89309-1-james.morse@arm.com>
References: <20190521172531.89309-1-james.morse@arm.com>
MIME-Version: 1.0
Cc: Marc Zyngier <marc.zyngier@arm.com>
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

KVM has helpers to handle the condition codes of trapped aarch32
instructions. These are marked __hyp_text and used from HYP, but they
aren't built by the 'hyp' Makefile, which has all the runes to avoid ASAN
and KCOV instrumentation, used when debugging.

Move this code to a new hyp/aarch32.c to avoid a hyp-panic when starting
an aarch32 guest on a host built with the ASAN/KCOV debug options.

Fixes: 021234ef3752f ("KVM: arm64: Make kvm_condition_valid32() accessible from EL2")
Fixes: 8cebe750c4d9a ("arm64: KVM: Make kvm_skip_instr32 available to HYP")
Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm/kvm/hyp/Makefile   |   1 +
 arch/arm64/kvm/hyp/Makefile |   1 +
 virt/kvm/arm/aarch32.c      | 121 --------------------------------
 virt/kvm/arm/hyp/aarch32.c  | 136 ++++++++++++++++++++++++++++++++++++
 4 files changed, 138 insertions(+), 121 deletions(-)
 create mode 100644 virt/kvm/arm/hyp/aarch32.c

diff --git a/arch/arm/kvm/hyp/Makefile b/arch/arm/kvm/hyp/Makefile
index d2b5ec9c4b92..ba88b1eca93c 100644
--- a/arch/arm/kvm/hyp/Makefile
+++ b/arch/arm/kvm/hyp/Makefile
@@ -11,6 +11,7 @@ CFLAGS_ARMV7VE		   :=$(call cc-option, -march=armv7ve)
 
 obj-$(CONFIG_KVM_ARM_HOST) += $(KVM)/arm/hyp/vgic-v3-sr.o
 obj-$(CONFIG_KVM_ARM_HOST) += $(KVM)/arm/hyp/timer-sr.o
+obj-$(CONFIG_KVM_ARM_HOST) += $(KVM)/arm/hyp/aarch32.o
 
 obj-$(CONFIG_KVM_ARM_HOST) += tlb.o
 obj-$(CONFIG_KVM_ARM_HOST) += cp15-sr.o
diff --git a/arch/arm64/kvm/hyp/Makefile b/arch/arm64/kvm/hyp/Makefile
index 82d1904328ad..ea710f674cb6 100644
--- a/arch/arm64/kvm/hyp/Makefile
+++ b/arch/arm64/kvm/hyp/Makefile
@@ -10,6 +10,7 @@ KVM=../../../../virt/kvm
 
 obj-$(CONFIG_KVM_ARM_HOST) += $(KVM)/arm/hyp/vgic-v3-sr.o
 obj-$(CONFIG_KVM_ARM_HOST) += $(KVM)/arm/hyp/timer-sr.o
+obj-$(CONFIG_KVM_ARM_HOST) += $(KVM)/arm/hyp/aarch32.o
 
 obj-$(CONFIG_KVM_ARM_HOST) += vgic-v2-cpuif-proxy.o
 obj-$(CONFIG_KVM_ARM_HOST) += sysreg-sr.o
diff --git a/virt/kvm/arm/aarch32.c b/virt/kvm/arm/aarch32.c
index 5abbe9b3c652..6880236974b8 100644
--- a/virt/kvm/arm/aarch32.c
+++ b/virt/kvm/arm/aarch32.c
@@ -25,127 +25,6 @@
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_hyp.h>
 
-/*
- * stolen from arch/arm/kernel/opcodes.c
- *
- * condition code lookup table
- * index into the table is test code: EQ, NE, ... LT, GT, AL, NV
- *
- * bit position in short is condition code: NZCV
- */
-static const unsigned short cc_map[16] = {
-	0xF0F0,			/* EQ == Z set            */
-	0x0F0F,			/* NE                     */
-	0xCCCC,			/* CS == C set            */
-	0x3333,			/* CC                     */
-	0xFF00,			/* MI == N set            */
-	0x00FF,			/* PL                     */
-	0xAAAA,			/* VS == V set            */
-	0x5555,			/* VC                     */
-	0x0C0C,			/* HI == C set && Z clear */
-	0xF3F3,			/* LS == C clear || Z set */
-	0xAA55,			/* GE == (N==V)           */
-	0x55AA,			/* LT == (N!=V)           */
-	0x0A05,			/* GT == (!Z && (N==V))   */
-	0xF5FA,			/* LE == (Z || (N!=V))    */
-	0xFFFF,			/* AL always              */
-	0			/* NV                     */
-};
-
-/*
- * Check if a trapped instruction should have been executed or not.
- */
-bool __hyp_text kvm_condition_valid32(const struct kvm_vcpu *vcpu)
-{
-	unsigned long cpsr;
-	u32 cpsr_cond;
-	int cond;
-
-	/* Top two bits non-zero?  Unconditional. */
-	if (kvm_vcpu_get_hsr(vcpu) >> 30)
-		return true;
-
-	/* Is condition field valid? */
-	cond = kvm_vcpu_get_condition(vcpu);
-	if (cond == 0xE)
-		return true;
-
-	cpsr = *vcpu_cpsr(vcpu);
-
-	if (cond < 0) {
-		/* This can happen in Thumb mode: examine IT state. */
-		unsigned long it;
-
-		it = ((cpsr >> 8) & 0xFC) | ((cpsr >> 25) & 0x3);
-
-		/* it == 0 => unconditional. */
-		if (it == 0)
-			return true;
-
-		/* The cond for this insn works out as the top 4 bits. */
-		cond = (it >> 4);
-	}
-
-	cpsr_cond = cpsr >> 28;
-
-	if (!((cc_map[cond] >> cpsr_cond) & 1))
-		return false;
-
-	return true;
-}
-
-/**
- * adjust_itstate - adjust ITSTATE when emulating instructions in IT-block
- * @vcpu:	The VCPU pointer
- *
- * When exceptions occur while instructions are executed in Thumb IF-THEN
- * blocks, the ITSTATE field of the CPSR is not advanced (updated), so we have
- * to do this little bit of work manually. The fields map like this:
- *
- * IT[7:0] -> CPSR[26:25],CPSR[15:10]
- */
-static void __hyp_text kvm_adjust_itstate(struct kvm_vcpu *vcpu)
-{
-	unsigned long itbits, cond;
-	unsigned long cpsr = *vcpu_cpsr(vcpu);
-	bool is_arm = !(cpsr & PSR_AA32_T_BIT);
-
-	if (is_arm || !(cpsr & PSR_AA32_IT_MASK))
-		return;
-
-	cond = (cpsr & 0xe000) >> 13;
-	itbits = (cpsr & 0x1c00) >> (10 - 2);
-	itbits |= (cpsr & (0x3 << 25)) >> 25;
-
-	/* Perform ITAdvance (see page A2-52 in ARM DDI 0406C) */
-	if ((itbits & 0x7) == 0)
-		itbits = cond = 0;
-	else
-		itbits = (itbits << 1) & 0x1f;
-
-	cpsr &= ~PSR_AA32_IT_MASK;
-	cpsr |= cond << 13;
-	cpsr |= (itbits & 0x1c) << (10 - 2);
-	cpsr |= (itbits & 0x3) << 25;
-	*vcpu_cpsr(vcpu) = cpsr;
-}
-
-/**
- * kvm_skip_instr - skip a trapped instruction and proceed to the next
- * @vcpu: The vcpu pointer
- */
-void __hyp_text kvm_skip_instr32(struct kvm_vcpu *vcpu, bool is_wide_instr)
-{
-	bool is_thumb;
-
-	is_thumb = !!(*vcpu_cpsr(vcpu) & PSR_AA32_T_BIT);
-	if (is_thumb && !is_wide_instr)
-		*vcpu_pc(vcpu) += 2;
-	else
-		*vcpu_pc(vcpu) += 4;
-	kvm_adjust_itstate(vcpu);
-}
-
 /*
  * Table taken from ARMv8 ARM DDI0487B-B, table G1-10.
  */
diff --git a/virt/kvm/arm/hyp/aarch32.c b/virt/kvm/arm/hyp/aarch32.c
new file mode 100644
index 000000000000..d31f267961e7
--- /dev/null
+++ b/virt/kvm/arm/hyp/aarch32.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Hyp portion of the (not much of an) Emulation layer for 32bit guests.
+ *
+ * Copyright (C) 2012,2013 - ARM Ltd
+ * Author: Marc Zyngier <marc.zyngier@arm.com>
+ *
+ * based on arch/arm/kvm/emulate.c
+ * Copyright (C) 2012 - Virtual Open Systems and Columbia University
+ * Author: Christoffer Dall <c.dall@virtualopensystems.com>
+ */
+
+#include <linux/kvm_host.h>
+#include <asm/kvm_emulate.h>
+#include <asm/kvm_hyp.h>
+
+/*
+ * stolen from arch/arm/kernel/opcodes.c
+ *
+ * condition code lookup table
+ * index into the table is test code: EQ, NE, ... LT, GT, AL, NV
+ *
+ * bit position in short is condition code: NZCV
+ */
+static const unsigned short cc_map[16] = {
+	0xF0F0,			/* EQ == Z set            */
+	0x0F0F,			/* NE                     */
+	0xCCCC,			/* CS == C set            */
+	0x3333,			/* CC                     */
+	0xFF00,			/* MI == N set            */
+	0x00FF,			/* PL                     */
+	0xAAAA,			/* VS == V set            */
+	0x5555,			/* VC                     */
+	0x0C0C,			/* HI == C set && Z clear */
+	0xF3F3,			/* LS == C clear || Z set */
+	0xAA55,			/* GE == (N==V)           */
+	0x55AA,			/* LT == (N!=V)           */
+	0x0A05,			/* GT == (!Z && (N==V))   */
+	0xF5FA,			/* LE == (Z || (N!=V))    */
+	0xFFFF,			/* AL always              */
+	0			/* NV                     */
+};
+
+/*
+ * Check if a trapped instruction should have been executed or not.
+ */
+bool __hyp_text kvm_condition_valid32(const struct kvm_vcpu *vcpu)
+{
+	unsigned long cpsr;
+	u32 cpsr_cond;
+	int cond;
+
+	/* Top two bits non-zero?  Unconditional. */
+	if (kvm_vcpu_get_hsr(vcpu) >> 30)
+		return true;
+
+	/* Is condition field valid? */
+	cond = kvm_vcpu_get_condition(vcpu);
+	if (cond == 0xE)
+		return true;
+
+	cpsr = *vcpu_cpsr(vcpu);
+
+	if (cond < 0) {
+		/* This can happen in Thumb mode: examine IT state. */
+		unsigned long it;
+
+		it = ((cpsr >> 8) & 0xFC) | ((cpsr >> 25) & 0x3);
+
+		/* it == 0 => unconditional. */
+		if (it == 0)
+			return true;
+
+		/* The cond for this insn works out as the top 4 bits. */
+		cond = (it >> 4);
+	}
+
+	cpsr_cond = cpsr >> 28;
+
+	if (!((cc_map[cond] >> cpsr_cond) & 1))
+		return false;
+
+	return true;
+}
+
+/**
+ * adjust_itstate - adjust ITSTATE when emulating instructions in IT-block
+ * @vcpu:	The VCPU pointer
+ *
+ * When exceptions occur while instructions are executed in Thumb IF-THEN
+ * blocks, the ITSTATE field of the CPSR is not advanced (updated), so we have
+ * to do this little bit of work manually. The fields map like this:
+ *
+ * IT[7:0] -> CPSR[26:25],CPSR[15:10]
+ */
+static void __hyp_text kvm_adjust_itstate(struct kvm_vcpu *vcpu)
+{
+	unsigned long itbits, cond;
+	unsigned long cpsr = *vcpu_cpsr(vcpu);
+	bool is_arm = !(cpsr & PSR_AA32_T_BIT);
+
+	if (is_arm || !(cpsr & PSR_AA32_IT_MASK))
+		return;
+
+	cond = (cpsr & 0xe000) >> 13;
+	itbits = (cpsr & 0x1c00) >> (10 - 2);
+	itbits |= (cpsr & (0x3 << 25)) >> 25;
+
+	/* Perform ITAdvance (see page A2-52 in ARM DDI 0406C) */
+	if ((itbits & 0x7) == 0)
+		itbits = cond = 0;
+	else
+		itbits = (itbits << 1) & 0x1f;
+
+	cpsr &= ~PSR_AA32_IT_MASK;
+	cpsr |= cond << 13;
+	cpsr |= (itbits & 0x1c) << (10 - 2);
+	cpsr |= (itbits & 0x3) << 25;
+	*vcpu_cpsr(vcpu) = cpsr;
+}
+
+/**
+ * kvm_skip_instr - skip a trapped instruction and proceed to the next
+ * @vcpu: The vcpu pointer
+ */
+void __hyp_text kvm_skip_instr32(struct kvm_vcpu *vcpu, bool is_wide_instr)
+{
+	bool is_thumb;
+
+	is_thumb = !!(*vcpu_cpsr(vcpu) & PSR_AA32_T_BIT);
+	if (is_thumb && !is_wide_instr)
+		*vcpu_pc(vcpu) += 2;
+	else
+		*vcpu_pc(vcpu) += 4;
+	kvm_adjust_itstate(vcpu);
+}
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
