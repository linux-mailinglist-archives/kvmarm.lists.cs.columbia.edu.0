Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 102E02B52EC
	for <lists+kvmarm@lfdr.de>; Mon, 16 Nov 2020 21:44:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B29254C262;
	Mon, 16 Nov 2020 15:44:01 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KhgDqNtJ7xQF; Mon, 16 Nov 2020 15:44:01 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1F5D24C25C;
	Mon, 16 Nov 2020 15:44:00 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B64CD4C25A
 for <kvmarm@lists.cs.columbia.edu>; Mon, 16 Nov 2020 15:43:58 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V6u0RquxgWwg for <kvmarm@lists.cs.columbia.edu>;
 Mon, 16 Nov 2020 15:43:57 -0500 (EST)
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 895814C262
 for <kvmarm@lists.cs.columbia.edu>; Mon, 16 Nov 2020 15:43:56 -0500 (EST)
Received: by mail-wr1-f65.google.com with SMTP id s8so20252592wrw.10
 for <kvmarm@lists.cs.columbia.edu>; Mon, 16 Nov 2020 12:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dMjpiERxWdtVXkFd7Ern4M0cCd0kiv8tT2I9J/E/g7I=;
 b=U7/w3Fhf9DO5foQRW7muVXAu48l3LbirUtqZ9gJBCTgwMcBTtGFM1gJH0rYp327w0N
 cFyYfUWUW6mb5IvhOcUAOaq9RtpFcsrkyawQNbkS+/0zXCcBVj/JRDAQCvSs44nRQrTH
 /TIQgvF5AKG1qLOlN9nz99FMbmxcuTidQqlCcIh7BZx9sLiZ6Ldnp19kZSnHnecN6UYa
 47or/IhKPvtaT0ikk6q26xSnmF3tpajDvqbjS8How97682ISE5hOu7RDjW5Q/I6Ywurl
 IQqADgIEJdqKeph575DIoo6yj013/c/zrRdAtWx6/+9ezCPuauebfFn2BhbtMmaJLSuI
 VwNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dMjpiERxWdtVXkFd7Ern4M0cCd0kiv8tT2I9J/E/g7I=;
 b=GsCx0Fc84LtwFmv8lYpFPDUxVgaW0eG6yQuQsz0fW1KKFdS2OwH6aTXbLcDwh2/Hv7
 zAHoRZN3ehN0MWNrNvZKuKKR4qeBDRmfoFsBdFRCuX5MDaezODm3Gbufx1uzVOfRYYA4
 4ZIK4pEvev3zMmxyEgcvmDIrsL3eSjjbEcQuVZU8jLNLpzeZdoV/iIhJMOqPaJF0UFOy
 HAzWsYQiTC5E/IYx0F1psqEpVEaphfAiFngs7vuCARbX6Eb8JT3Y/aBe9Tj77BsLM5tK
 oKc1scc9F5rNZEH+oL6YOx27lUdjeSFX99sBmmV82UpTUi4Sfb7iaHP2db8wTRlcd1id
 Gv0A==
X-Gm-Message-State: AOAM531izSdbKhu1NgYDbrA1NSlHnrMjYByDda/xtjkD2q/Cnq0jvSj4
 plHGnjj2oewHQTZ1Z0yN8Trm7/wbDhICGxc60RY=
X-Google-Smtp-Source: ABdhPJzQKH1yeq/oMRiNiGuPYRxFYlhWF+NTE891QE/ynOYgdpF9Ld0Hyaa8WpJD7POvyBVvcFsSkw==
X-Received: by 2002:a5d:410c:: with SMTP id l12mr21265672wrp.173.1605559434950; 
 Mon, 16 Nov 2020 12:43:54 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:bc40:bd71:373a:1b33])
 by smtp.gmail.com with ESMTPSA id f13sm18795419wrq.78.2020.11.16.12.43.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2020 12:43:53 -0800 (PST)
From: David Brazdil <dbrazdil@google.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v2 15/24] kvm: arm64: Extract parts of el2_setup into a macro
Date: Mon, 16 Nov 2020 20:43:09 +0000
Message-Id: <20201116204318.63987-16-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116204318.63987-1-dbrazdil@google.com>
References: <20201116204318.63987-1-dbrazdil@google.com>
MIME-Version: 1.0
Cc: kernel-team@android.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Andrew Walbran <qwandor@google.com>, Marc Zyngier <maz@kernel.org>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, Tejun Heo <tj@kernel.org>,
 Dennis Zhou <dennis@kernel.org>, Christoph Lameter <cl@linux.com>,
 Will Deacon <will@kernel.org>
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

When the a CPU is booted in EL2, the kernel checks for VHE support and
initializes the CPU core accordingly. For nVHE it also installs the stub
vectors and drops down to EL1.

Once KVM gains the ability to boot cores without going through the
kernel entry point, it will need to initialize the CPU the same way.
Extract the relevant bits of el2_setup into an init_el2_state macro
with an argument specifying whether to initialize for VHE or nVHE.

No functional change. Size of el2_setup increased by 148 bytes due
to duplication.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/el2_setup.h | 185 +++++++++++++++++++++++++++++
 arch/arm64/kernel/head.S           | 144 +++-------------------
 2 files changed, 201 insertions(+), 128 deletions(-)
 create mode 100644 arch/arm64/include/asm/el2_setup.h

diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
new file mode 100644
index 000000000000..e5026e0aa878
--- /dev/null
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -0,0 +1,185 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2012,2013 - ARM Ltd
+ * Author: Marc Zyngier <marc.zyngier@arm.com>
+ */
+
+#ifndef __ARM_KVM_INIT_H__
+#define __ARM_KVM_INIT_H__
+
+#ifndef __ASSEMBLY__
+#error Assembly-only header
+#endif
+
+#ifdef CONFIG_ARM_GIC_V3
+#include <linux/irqchip/arm-gic-v3.h>
+#endif
+
+#include <asm/kvm_arm.h>
+#include <asm/ptrace.h>
+#include <asm/sysreg.h>
+
+.macro __init_el2_sctlr
+	mov_q	x0, (SCTLR_EL2_RES1 | ENDIAN_SET_EL2)
+	msr	sctlr_el2, x0
+	isb
+.endm
+
+/*
+ * Allow Non-secure EL1 and EL0 to access physical timer and counter.
+ * This is not necessary for VHE, since the host kernel runs in EL2,
+ * and EL0 accesses are configured in the later stage of boot process.
+ * Note that when HCR_EL2.E2H == 1, CNTHCTL_EL2 has the same bit layout
+ * as CNTKCTL_EL1, and CNTKCTL_EL1 accessing instructions are redefined
+ * to access CNTHCTL_EL2. This allows the kernel designed to run at EL1
+ * to transparently mess with the EL0 bits via CNTKCTL_EL1 access in
+ * EL2.
+ */
+.macro __init_el2_timers mode
+.ifeqs "\mode", "nvhe"
+	mrs	x0, cnthctl_el2
+	orr	x0, x0, #3			// Enable EL1 physical timers
+	msr	cnthctl_el2, x0
+.endif
+	msr	cntvoff_el2, xzr		// Clear virtual offset
+.endm
+
+.macro __init_el2_debug mode
+	mrs	x1, id_aa64dfr0_el1
+	sbfx	x0, x1, #ID_AA64DFR0_PMUVER_SHIFT, #4
+	cmp	x0, #1
+	b.lt	1f				// Skip if no PMU present
+	mrs	x0, pmcr_el0			// Disable debug access traps
+	ubfx	x0, x0, #11, #5			// to EL2 and allow access to
+1:
+	csel	x2, xzr, x0, lt			// all PMU counters from EL1
+
+	/* Statistical profiling */
+	ubfx	x0, x1, #ID_AA64DFR0_PMSVER_SHIFT, #4
+	cbz	x0, 3f				// Skip if SPE not present
+
+.ifeqs "\mode", "nvhe"
+	mrs_s	x0, SYS_PMBIDR_EL1              // If SPE available at EL2,
+	and	x0, x0, #(1 << SYS_PMBIDR_EL1_P_SHIFT)
+	cbnz	x0, 2f				// then permit sampling of physical
+	mov	x0, #(1 << SYS_PMSCR_EL2_PCT_SHIFT | \
+		      1 << SYS_PMSCR_EL2_PA_SHIFT)
+	msr_s	SYS_PMSCR_EL2, x0		// addresses and physical counter
+2:
+	mov	x0, #(MDCR_EL2_E2PB_MASK << MDCR_EL2_E2PB_SHIFT)
+	orr	x2, x2, x0			// If we don't have VHE, then
+						// use EL1&0 translation.
+.else
+	orr	x2, x2, #MDCR_EL2_TPMS		// For VHE, use EL2 translation
+						// and disable access from EL1
+.endif
+
+3:
+	msr	mdcr_el2, x2			// Configure debug traps
+.endm
+
+/* LORegions */
+.macro __init_el2_lor
+	mrs	x1, id_aa64mmfr1_el1
+	ubfx	x0, x1, #ID_AA64MMFR1_LOR_SHIFT, 4
+	cbz	x0, 1f
+	msr_s	SYS_LORC_EL1, xzr
+1:
+.endm
+
+/* Stage-2 translation */
+.macro __init_el2_stage2
+	msr	vttbr_el2, xzr
+.endm
+
+/* GICv3 system register access */
+#ifdef CONFIG_ARM_GIC_V3
+.macro __init_el2_gicv3
+	mrs	x0, id_aa64pfr0_el1
+	ubfx	x0, x0, #ID_AA64PFR0_GIC_SHIFT, #4
+	cbz	x0, 1f
+
+	mrs_s	x0, SYS_ICC_SRE_EL2
+	orr	x0, x0, #ICC_SRE_EL2_SRE	// Set ICC_SRE_EL2.SRE==1
+	orr	x0, x0, #ICC_SRE_EL2_ENABLE	// Set ICC_SRE_EL2.Enable==1
+	msr_s	SYS_ICC_SRE_EL2, x0
+	isb					// Make sure SRE is now set
+	mrs_s	x0, SYS_ICC_SRE_EL2		// Read SRE back,
+	tbz	x0, #0, 1f			// and check that it sticks
+	msr_s	SYS_ICH_HCR_EL2, xzr		// Reset ICC_HCR_EL2 to defaults
+1:
+.endm
+#endif
+
+/* Virtual CPU ID registers */
+.macro __init_el2_nvhe_idregs
+	mrs	x0, midr_el1
+	mrs	x1, mpidr_el1
+	msr	vpidr_el2, x0
+	msr	vmpidr_el2, x1
+.endm
+
+/* Coprocessor traps */
+.macro __init_el2_nvhe_cptr
+	mov	x0, #0x33ff
+	msr	cptr_el2, x0			// Disable copro. traps to EL2
+.endm
+
+/* SVE register access */
+.macro __init_el2_nvhe_sve
+	mrs	x1, id_aa64pfr0_el1
+	ubfx	x1, x1, #ID_AA64PFR0_SVE_SHIFT, #4
+	cbz	x1, 1f
+
+	bic	x0, x0, #CPTR_EL2_TZ		// Also disable SVE traps
+	msr	cptr_el2, x0			// Disable copro. traps to EL2
+	isb
+	mov	x1, #ZCR_ELx_LEN_MASK		// SVE: Enable full vector
+	msr_s	SYS_ZCR_EL2, x1			// length for EL1.
+1:
+.endm
+
+.macro __init_el2_nvhe_spsr
+	mov	x0, #(PSR_F_BIT | PSR_I_BIT | PSR_A_BIT | PSR_D_BIT |\
+		      PSR_MODE_EL1h)
+	msr	spsr_el2, x0
+.endm
+
+.macro init_el2_state mode
+
+.ifnes "\mode", "vhe"
+.ifnes "\mode", "nvhe"
+.error "Invalid 'mode' argument"
+.endif
+.endif
+
+	__init_el2_sctlr
+	__init_el2_timers \mode
+	__init_el2_debug \mode
+	__init_el2_lor
+	__init_el2_stage2
+
+#ifdef CONFIG_ARM_GIC_V3
+	__init_el2_gicv3
+#endif
+
+#ifdef CONFIG_COMPAT
+	msr	hstr_el2, xzr			// Disable CP15 traps to EL2
+#endif
+
+	/*
+	 * When VHE is not in use, early init of EL2 needs to be done here.
+	 * When VHE _is_ in use, EL1 will not be used in the host and
+	 * requires no configuration, and all non-hyp-specific EL2 setup
+	 * will be done via the _EL1 system register aliases in __cpu_setup.
+	 */
+.ifeqs "\mode", "nvhe"
+	__init_el2_nvhe_idregs
+	__init_el2_nvhe_cptr
+	__init_el2_nvhe_sve
+	__init_el2_nvhe_spsr
+.endif
+
+.endm
+
+#endif /* __ARM_KVM_INIT_H__ */
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index d8d9caf02834..da913ce9e89f 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -11,7 +11,6 @@
 
 #include <linux/linkage.h>
 #include <linux/init.h>
-#include <linux/irqchip/arm-gic-v3.h>
 #include <linux/pgtable.h>
 
 #include <asm/asm_pointer_auth.h>
@@ -21,6 +20,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/cache.h>
 #include <asm/cputype.h>
+#include <asm/el2_setup.h>
 #include <asm/elf.h>
 #include <asm/image.h>
 #include <asm/kernel-pgtable.h>
@@ -493,159 +493,47 @@ SYM_FUNC_START(el2_setup)
 	mrs	x0, CurrentEL
 	cmp	x0, #CurrentEL_EL2
 	b.eq	1f
+
 	mov_q	x0, (SCTLR_EL1_RES1 | ENDIAN_SET_EL1)
 	msr	sctlr_el1, x0
 	mov	w0, #BOOT_CPU_MODE_EL1		// This cpu booted in EL1
 	isb
 	ret
 
-1:	mov_q	x0, (SCTLR_EL2_RES1 | ENDIAN_SET_EL2)
-	msr	sctlr_el2, x0
-
+1:
 #ifdef CONFIG_ARM64_VHE
 	/*
-	 * Check for VHE being present. For the rest of the EL2 setup,
-	 * x2 being non-zero indicates that we do have VHE, and that the
-	 * kernel is intended to run at EL2.
+	 * Check for VHE being present. x2 being non-zero indicates that we
+	 * do have VHE, and that the kernel is intended to run at EL2.
 	 */
 	mrs	x2, id_aa64mmfr1_el1
 	ubfx	x2, x2, #ID_AA64MMFR1_VHE_SHIFT, #4
-#else
-	mov	x2, xzr
-#endif
+	cbz	x2, el2_setup_nvhe
 
-	/* Hyp configuration. */
-	mov_q	x0, HCR_HOST_NVHE_FLAGS
-	cbz	x2, set_hcr
 	mov_q	x0, HCR_HOST_VHE_FLAGS
-set_hcr:
 	msr	hcr_el2, x0
 	isb
 
-	/*
-	 * Allow Non-secure EL1 and EL0 to access physical timer and counter.
-	 * This is not necessary for VHE, since the host kernel runs in EL2,
-	 * and EL0 accesses are configured in the later stage of boot process.
-	 * Note that when HCR_EL2.E2H == 1, CNTHCTL_EL2 has the same bit layout
-	 * as CNTKCTL_EL1, and CNTKCTL_EL1 accessing instructions are redefined
-	 * to access CNTHCTL_EL2. This allows the kernel designed to run at EL1
-	 * to transparently mess with the EL0 bits via CNTKCTL_EL1 access in
-	 * EL2.
-	 */
-	cbnz	x2, 1f
-	mrs	x0, cnthctl_el2
-	orr	x0, x0, #3			// Enable EL1 physical timers
-	msr	cnthctl_el2, x0
-1:
-	msr	cntvoff_el2, xzr		// Clear virtual offset
-
-#ifdef CONFIG_ARM_GIC_V3
-	/* GICv3 system register access */
-	mrs	x0, id_aa64pfr0_el1
-	ubfx	x0, x0, #ID_AA64PFR0_GIC_SHIFT, #4
-	cbz	x0, 3f
-
-	mrs_s	x0, SYS_ICC_SRE_EL2
-	orr	x0, x0, #ICC_SRE_EL2_SRE	// Set ICC_SRE_EL2.SRE==1
-	orr	x0, x0, #ICC_SRE_EL2_ENABLE	// Set ICC_SRE_EL2.Enable==1
-	msr_s	SYS_ICC_SRE_EL2, x0
-	isb					// Make sure SRE is now set
-	mrs_s	x0, SYS_ICC_SRE_EL2		// Read SRE back,
-	tbz	x0, #0, 3f			// and check that it sticks
-	msr_s	SYS_ICH_HCR_EL2, xzr		// Reset ICC_HCR_EL2 to defaults
-
-3:
-#endif
-
-	/* Populate ID registers. */
-	mrs	x0, midr_el1
-	mrs	x1, mpidr_el1
-	msr	vpidr_el2, x0
-	msr	vmpidr_el2, x1
-
-#ifdef CONFIG_COMPAT
-	msr	hstr_el2, xzr			// Disable CP15 traps to EL2
-#endif
-
-	/* EL2 debug */
-	mrs	x1, id_aa64dfr0_el1
-	sbfx	x0, x1, #ID_AA64DFR0_PMUVER_SHIFT, #4
-	cmp	x0, #1
-	b.lt	4f				// Skip if no PMU present
-	mrs	x0, pmcr_el0			// Disable debug access traps
-	ubfx	x0, x0, #11, #5			// to EL2 and allow access to
-4:
-	csel	x3, xzr, x0, lt			// all PMU counters from EL1
-
-	/* Statistical profiling */
-	ubfx	x0, x1, #ID_AA64DFR0_PMSVER_SHIFT, #4
-	cbz	x0, 7f				// Skip if SPE not present
-	cbnz	x2, 6f				// VHE?
-	mrs_s	x4, SYS_PMBIDR_EL1		// If SPE available at EL2,
-	and	x4, x4, #(1 << SYS_PMBIDR_EL1_P_SHIFT)
-	cbnz	x4, 5f				// then permit sampling of physical
-	mov	x4, #(1 << SYS_PMSCR_EL2_PCT_SHIFT | \
-		      1 << SYS_PMSCR_EL2_PA_SHIFT)
-	msr_s	SYS_PMSCR_EL2, x4		// addresses and physical counter
-5:
-	mov	x1, #(MDCR_EL2_E2PB_MASK << MDCR_EL2_E2PB_SHIFT)
-	orr	x3, x3, x1			// If we don't have VHE, then
-	b	7f				// use EL1&0 translation.
-6:						// For VHE, use EL2 translation
-	orr	x3, x3, #MDCR_EL2_TPMS		// and disable access from EL1
-7:
-	msr	mdcr_el2, x3			// Configure debug traps
-
-	/* LORegions */
-	mrs	x1, id_aa64mmfr1_el1
-	ubfx	x0, x1, #ID_AA64MMFR1_LOR_SHIFT, 4
-	cbz	x0, 1f
-	msr_s	SYS_LORC_EL1, xzr
-1:
-
-	/* Stage-2 translation */
-	msr	vttbr_el2, xzr
-
-	cbz	x2, install_el2_stub
+	init_el2_state vhe
 
 	mov	w0, #BOOT_CPU_MODE_EL2		// This CPU booted in EL2
 	isb
 	ret
+#endif
 
-SYM_INNER_LABEL(install_el2_stub, SYM_L_LOCAL)
-	/*
-	 * When VHE is not in use, early init of EL2 and EL1 needs to be
-	 * done here.
-	 * When VHE _is_ in use, EL1 will not be used in the host and
-	 * requires no configuration, and all non-hyp-specific EL2 setup
-	 * will be done via the _EL1 system register aliases in __cpu_setup.
-	 */
-	mov_q	x0, (SCTLR_EL1_RES1 | ENDIAN_SET_EL1)
-	msr	sctlr_el1, x0
-
-	/* Coprocessor traps. */
-	mov	x0, #0x33ff
-	msr	cptr_el2, x0			// Disable copro. traps to EL2
-
-	/* SVE register access */
-	mrs	x1, id_aa64pfr0_el1
-	ubfx	x1, x1, #ID_AA64PFR0_SVE_SHIFT, #4
-	cbz	x1, 7f
-
-	bic	x0, x0, #CPTR_EL2_TZ		// Also disable SVE traps
-	msr	cptr_el2, x0			// Disable copro. traps to EL2
+SYM_INNER_LABEL(el2_setup_nvhe, SYM_L_LOCAL)
+	mov_q	x0, HCR_HOST_NVHE_FLAGS
+	msr	hcr_el2, x0
 	isb
-	mov	x1, #ZCR_ELx_LEN_MASK		// SVE: Enable full vector
-	msr_s	SYS_ZCR_EL2, x1			// length for EL1.
+
+	init_el2_state nvhe
 
 	/* Hypervisor stub */
-7:	adr_l	x0, __hyp_stub_vectors
+	adr_l	x0, __hyp_stub_vectors
 	msr	vbar_el2, x0
 
-	/* spsr */
-	mov	x0, #(PSR_F_BIT | PSR_I_BIT | PSR_A_BIT | PSR_D_BIT |\
-		      PSR_MODE_EL1h)
-	msr	spsr_el2, x0
+	mov_q	x0, (SCTLR_EL1_RES1 | ENDIAN_SET_EL1)
+	msr	sctlr_el1, x0
 	msr	elr_el2, lr
 	mov	w0, #BOOT_CPU_MODE_EL2		// This CPU booted in EL2
 	eret
-- 
2.29.2.299.gdc1121823c-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
