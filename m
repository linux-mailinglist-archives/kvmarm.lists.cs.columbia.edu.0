Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6B42507D5
	for <lists+kvmarm@lfdr.de>; Mon, 24 Aug 2020 20:36:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E51224CBAF;
	Mon, 24 Aug 2020 14:36:31 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.911
X-Spam-Level: 
X-Spam-Status: No, score=0.911 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, FREEMAIL_FROM=0.001,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@gmail.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mnES9VQ7uj2r; Mon, 24 Aug 2020 14:36:31 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9A4E54CC9E;
	Mon, 24 Aug 2020 14:36:30 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6D7D64CC19
 for <kvmarm@lists.cs.columbia.edu>; Mon, 24 Aug 2020 14:36:29 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZHD5veGsvlmM for <kvmarm@lists.cs.columbia.edu>;
 Mon, 24 Aug 2020 14:36:28 -0400 (EDT)
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
 [209.85.210.196])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 2348D4CB32
 for <kvmarm@lists.cs.columbia.edu>; Mon, 24 Aug 2020 14:36:28 -0400 (EDT)
Received: by mail-pf1-f196.google.com with SMTP id m8so5303357pfh.3
 for <kvmarm@lists.cs.columbia.edu>; Mon, 24 Aug 2020 11:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=b96xElma2wVNkZLWPyInMIgVAkPIrOZeVr/+MC3kMPQ=;
 b=kJIDOILbYl/7UguWLWS2J4Ts2X2NdD8kL8uqUY5o65T9vBehdn1gGl4vgizV6s8rVE
 B2euk//REx4SjEjprw+qtTl8QzH2yI3G+JTE8e8gSkGADHzc+Qp1k3ITuesmITUK27rz
 Vl7l62szu+Mw3v3Kyp70IdshpPjbRfTJSi6m4R5vCr/ZYlA3/78lFUYrscQMWK4BOWwM
 WM/D6Izu1r26KTHmwEK63H2D5yTTyQFZ1px05D97BaEmM8qZOPNF8bcM4hsj2067WCL/
 PZ71fawRO5V1MVoC26lU2gTUznvnvnlCOV3v5OiM1KDpNGTsumW1VKRC/Q4/KYFhSDAJ
 BVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=b96xElma2wVNkZLWPyInMIgVAkPIrOZeVr/+MC3kMPQ=;
 b=NvRH+1WQR9v5RxiRtYjaCkjHHrW3o6RvHYMDey0TQUYXP5V57vV6b2mlEhYdA8e+PV
 eHi1vq3gDtxm6UeptY1FeoCXxKi0zDTtHlfN5nsFMalGe4KQ1Ia63sDLPJIfvhHjsxlO
 KdA5YeE6FweqnY5xaRZrq8sNfbhCHxjtYZW1HH0jET4tAjHQW15hnPkyxzv+QT2KLmhi
 ebrMIbyIdRL78Sl0+quO85eQ5IujTk1y9wdOe6V4RNgc+ZX3O1lo0TAqdS5uAansFaPs
 RaoFLHh4SlMY9kEkybgFGT8A5ajouM4wt29wMe1xCgIpI6/ahY91CmE/L81mUn7o98DZ
 Rg2g==
X-Gm-Message-State: AOAM531ScgKe7E08hPHiETM5r+/QpEXOctfOJzYHvI7stjkSzM4cfqp9
 arnE6cObDQwF2r0jBn76Udg=
X-Google-Smtp-Source: ABdhPJwWVMNmiDhLowr36OW1PpCPBDb47C7dITpAO+Rb9ymj/lluEnztUgICYD9TJI0Q4fOtPRo/HA==
X-Received: by 2002:a63:f44d:: with SMTP id p13mr4113885pgk.363.1598294187273; 
 Mon, 24 Aug 2020 11:36:27 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id u191sm10235065pgu.56.2020.08.24.11.36.25
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 24 Aug 2020 11:36:26 -0700 (PDT)
From: Florian Fainelli <f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH stable 4.9 v3 1/2] arm64: Add support for SB barrier and patch
 in over DSB; ISB sequences
Date: Mon, 24 Aug 2020 11:36:21 -0700
Message-Id: <1598294182-34012-2-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598294182-34012-1-git-send-email-f.fainelli@gmail.com>
References: <1598294182-34012-1-git-send-email-f.fainelli@gmail.com>
Cc: Marc Zyngier <maz@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
 Fangrui Song <maskray@google.com>, Nick Desaulniers <ndesaulniers@google.com>,
 Greg KH <gregkh@linuxfoundation.org>, Will Deacon <will.deacon@arm.com>,
 open list <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
 "open list:KERNEL VIRTUAL MACHINE FOR ARM64 \(KVM/arm64\)"
 <kvmarm@lists.cs.columbia.edu>, Mark Brown <broonie@kernel.org>,
 Kristina Martsenko <kristina.martsenko@arm.com>,
 Sami Tolvanen <samitolvanen@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>
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

From: Will Deacon <will.deacon@arm.com>

commit bd4fb6d270bc423a9a4098108784f7f9254c4e6d upstream

We currently use a DSB; ISB sequence to inhibit speculation in set_fs().
Whilst this works for current CPUs, future CPUs may implement a new SB
barrier instruction which acts as an architected speculation barrier.

On CPUs that support it, patch in an SB; NOP sequence over the DSB; ISB
sequence and advertise the presence of the new instruction to userspace.

Signed-off-by: Will Deacon <will.deacon@arm.com>
[florian:
- adjust number capabilities
- wire decoding of ftr_id_aa64_isar1
- __emit_inst -> __inst_arm
- sys_insn -> sys_reg]
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm64/include/asm/assembler.h  | 13 +++++++++++++
 arch/arm64/include/asm/barrier.h    |  4 ++++
 arch/arm64/include/asm/cpucaps.h    |  3 ++-
 arch/arm64/include/asm/sysreg.h     | 13 +++++++++++++
 arch/arm64/include/asm/uaccess.h    |  3 +--
 arch/arm64/include/uapi/asm/hwcap.h |  1 +
 arch/arm64/kernel/cpufeature.c      | 22 +++++++++++++++++++++-
 arch/arm64/kernel/cpuinfo.c         |  1 +
 8 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 3f85bbcd7e40..0f689aa0b300 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -95,6 +95,19 @@
 	.endm
 
 /*
+ * Speculation barrier
+ */
+	.macro	sb
+alternative_if_not ARM64_HAS_SB
+	dsb	nsh
+	isb
+alternative_else
+	SB_BARRIER_INSN
+	nop
+alternative_endif
+	.endm
+
+/*
  * Sanitise a 64-bit bounded index wrt speculation, returning zero if out
  * of bounds.
  */
diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index 0b0755c961ac..159329160fb4 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -33,6 +33,10 @@
 
 #define csdb()		asm volatile("hint #20" : : : "memory")
 
+#define spec_bar()	asm volatile(ALTERNATIVE("dsb nsh\nisb\n",		\
+						 SB_BARRIER_INSN"nop\n",	\
+						 ARM64_HAS_SB))
+
 #define mb()		dsb(sy)
 #define rmb()		dsb(ld)
 #define wmb()		dsb(st)
diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index 8c7c4b23a8b1..8a25f6e39f3a 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -38,7 +38,8 @@
 #define ARM64_HARDEN_BRANCH_PREDICTOR		17
 #define ARM64_SSBD				18
 #define ARM64_MISMATCHED_CACHE_TYPE		19
+#define ARM64_HAS_SB				20
 
-#define ARM64_NCAPS				20
+#define ARM64_NCAPS				21
 
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 88bbe364b6ae..1c49eaac1938 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -86,6 +86,12 @@
 #define SET_PSTATE_UAO(x) __inst_arm(0xd5000000 | REG_PSTATE_UAO_IMM |\
 				     (!!x)<<8 | 0x1f)
 
+#define __SYS_BARRIER_INSN(CRm, op2, Rt) \
+	__inst_arm(0xd5000000 | sys_reg(0, 3, 3, (CRm), (op2)) | ((Rt) & 0x1f))
+
+#define SB_BARRIER_INSN			__SYS_BARRIER_INSN(0, 7, 31)
+
+
 /* Common SCTLR_ELx flags. */
 #define SCTLR_ELx_EE    (1 << 25)
 #define SCTLR_ELx_I	(1 << 12)
@@ -116,6 +122,13 @@
 #define ID_AA64ISAR0_SHA1_SHIFT		8
 #define ID_AA64ISAR0_AES_SHIFT		4
 
+/* id_aa64isar1 */
+#define ID_AA64ISAR1_SB_SHIFT		36
+#define ID_AA64ISAR1_LRCPC_SHIFT	20
+#define ID_AA64ISAR1_FCMA_SHIFT		16
+#define ID_AA64ISAR1_JSCVT_SHIFT	12
+#define ID_AA64ISAR1_DPB_SHIFT		0
+
 /* id_aa64pfr0 */
 #define ID_AA64PFR0_CSV3_SHIFT		60
 #define ID_AA64PFR0_CSV2_SHIFT		56
diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index f5cd96c60eb9..195323089e5a 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -71,8 +71,7 @@ static inline void set_fs(mm_segment_t fs)
 	 * Prevent a mispredicted conditional call to set_fs from forwarding
 	 * the wrong address limit to access_ok under speculation.
 	 */
-	dsb(nsh);
-	isb();
+	spec_bar();
 
 	/*
 	 * Enable/disable UAO so that copy_to_user() etc can access
diff --git a/arch/arm64/include/uapi/asm/hwcap.h b/arch/arm64/include/uapi/asm/hwcap.h
index a739287ef6a3..3aa659624968 100644
--- a/arch/arm64/include/uapi/asm/hwcap.h
+++ b/arch/arm64/include/uapi/asm/hwcap.h
@@ -30,5 +30,6 @@
 #define HWCAP_ATOMICS		(1 << 8)
 #define HWCAP_FPHP		(1 << 9)
 #define HWCAP_ASIMDHP		(1 << 10)
+#define HWCAP_SB		(1 << 29)
 
 #endif /* _UAPI__ASM_HWCAP_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 8cf001baee21..1a5879c0b711 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -93,6 +93,15 @@ static const struct arm64_ftr_bits ftr_id_aa64isar0[] = {
 	ARM64_FTR_END,
 };
 
+static const struct arm64_ftr_bits ftr_id_aa64isar1[] = {
+	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR1_SB_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR1_LRCPC_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR1_FCMA_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR1_JSCVT_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR1_DPB_SHIFT, 4, 0),
+	ARM64_FTR_END,
+};
+
 static const struct arm64_ftr_bits ftr_id_aa64pfr0[] = {
 	ARM64_FTR_BITS(FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64PFR0_CSV3_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64PFR0_CSV2_SHIFT, 4, 0),
@@ -326,7 +335,7 @@ static const struct __ftr_reg_entry {
 
 	/* Op1 = 0, CRn = 0, CRm = 6 */
 	ARM64_FTR_REG(SYS_ID_AA64ISAR0_EL1, ftr_id_aa64isar0),
-	ARM64_FTR_REG(SYS_ID_AA64ISAR1_EL1, ftr_aa64raz),
+	ARM64_FTR_REG(SYS_ID_AA64ISAR1_EL1, ftr_id_aa64isar1),
 
 	/* Op1 = 0, CRn = 0, CRm = 7 */
 	ARM64_FTR_REG(SYS_ID_AA64MMFR0_EL1, ftr_id_aa64mmfr0),
@@ -949,6 +958,16 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.enable = kpti_install_ng_mappings,
 	},
 #endif
+	{
+		.desc = "Speculation barrier (SB)",
+		.capability = ARM64_HAS_SB,
+		.def_scope = SCOPE_SYSTEM,
+		.matches = has_cpuid_feature,
+		.sys_reg = SYS_ID_AA64ISAR1_EL1,
+		.field_pos = ID_AA64ISAR1_SB_SHIFT,
+		.sign = FTR_UNSIGNED,
+		.min_field_value = 1,
+	},
 	{},
 };
 
@@ -976,6 +995,7 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_FP_SHIFT, FTR_SIGNED, 1, CAP_HWCAP, HWCAP_FPHP),
 	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_ASIMD_SHIFT, FTR_SIGNED, 0, CAP_HWCAP, HWCAP_ASIMD),
 	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_ASIMD_SHIFT, FTR_SIGNED, 1, CAP_HWCAP, HWCAP_ASIMDHP),
+	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_SB_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, HWCAP_SB),
 	{},
 };
 
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index b3d5b3e8fbcb..5de2d55a999e 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -63,6 +63,7 @@ static const char *const hwcap_str[] = {
 	"atomics",
 	"fphp",
 	"asimdhp",
+	"sb",
 	NULL
 };
 
-- 
2.7.4

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
