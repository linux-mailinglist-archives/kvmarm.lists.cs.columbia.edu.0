Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE7D4C4C42
	for <lists+kvmarm@lfdr.de>; Fri, 25 Feb 2022 18:35:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A3B674B939;
	Fri, 25 Feb 2022 12:35:08 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ekDKAEFTjMvE; Fri, 25 Feb 2022 12:35:08 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D57E34B932;
	Fri, 25 Feb 2022 12:35:06 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A31594B816
 for <kvmarm@lists.cs.columbia.edu>; Fri, 25 Feb 2022 12:35:05 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sDF+85PRkzhd for <kvmarm@lists.cs.columbia.edu>;
 Fri, 25 Feb 2022 12:35:03 -0500 (EST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A7CE94B89F
 for <kvmarm@lists.cs.columbia.edu>; Fri, 25 Feb 2022 12:35:02 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 23A7861DC5;
 Fri, 25 Feb 2022 17:35:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C0CC340F0;
 Fri, 25 Feb 2022 17:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1645810501;
 bh=nBku+VpbPPwZNxZkel3x8Zlg6st0xpuzYLybd1RmoGU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=csb821ldJ+8fit5KE56xmfpQlCwtuOPuCqgAcdpUaYRxeWHFO5PY6JtwwvS4WHaHq
 At8aiToLn74MXQg7c8SIjwauGT0V6FIk5aOS7TB6lPm2m3DkhMTc9yyrSE9nvtbbLh
 PGMjfFs8yPZTy/DIgzJhE3Xw03xcFZz8ZdpZD5Vlq6unR/I5D5Qm2j3KQl2ufw5wv0
 IL9IDq5nzQH3Seh205WzBBzFSoGzw0wkn2aporPfdWSqfxm/1fLSjXayyQql9m+l+N
 ZrB2reX7FFKTgjD8kq8tyzWR9/3pCM6THJ1jsS1DYyQJmLw4KGMzPeORzT+LaTcchP
 DjpVutvGNmGpQ==
From: Mark Brown <broonie@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 Shuah Khan <shuah@kernel.org>
Subject: [PATCH v12 10/40] arm64/sme: Basic enumeration support
Date: Fri, 25 Feb 2022 16:58:53 +0000
Message-Id: <20220225165923.1474372-11-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220225165923.1474372-1-broonie@kernel.org>
References: <20220225165923.1474372-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13481; h=from:subject;
 bh=nBku+VpbPPwZNxZkel3x8Zlg6st0xpuzYLybd1RmoGU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiGQrSVbUBLe3btv+DZkvfc1fGWUZ2DVuNEUSi88xK
 M9SeVj+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYhkK0gAKCRAk1otyXVSH0I+jB/
 4gIRev+Gg1z9iN0F0LPlSTkISNIEO7ex2PRFITNWxYtQ0QvEYcuA2Chc9YC4mJAJIzPB4vIV0UekiS
 +D7cvi4LCi2x5NANLLehMwfowKvShxRfg9Q7nPXD/czbcXYiLY7BYw29MC3PBKpUKXwJGyGOZY/MCL
 XWNXqp0RQjbyvsh+XXo/z8CRRakheMiRF05v8C8flgT5JVOcqCIl0dqQ6985GSeSas6X3u7Sv4bE6j
 UODtELtBhLKNlKUu/5bBZMNUybgnX2Wiw2hUtgGnoBaY3+eDd+K4ODFubNaTumXkd3MyVQXZruYz1x
 DbnHE5FGCaWFFHZKQyOD9CWpVEFGxU
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Cc: Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
 Luis Machado <luis.machado@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>,
 Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kselftest@vger.kernel.org, Alan Hayward <alan.hayward@arm.com>,
 kvmarm@lists.cs.columbia.edu, Salil Akerkar <Salil.Akerkar@arm.com>
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

This patch introduces basic cpufeature support for discovering the presence
of the Scalable Matrix Extension.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/arm64/elf_hwcaps.rst  | 33 ++++++++++++++++
 arch/arm64/include/asm/cpu.h        |  1 +
 arch/arm64/include/asm/cpufeature.h | 12 ++++++
 arch/arm64/include/asm/fpsimd.h     |  2 +
 arch/arm64/include/asm/hwcap.h      |  8 ++++
 arch/arm64/include/uapi/asm/hwcap.h |  8 ++++
 arch/arm64/kernel/cpufeature.c      | 59 +++++++++++++++++++++++++++++
 arch/arm64/kernel/cpuinfo.c         |  9 +++++
 arch/arm64/kernel/fpsimd.c          | 30 +++++++++++++++
 arch/arm64/tools/cpucaps            |  2 +
 10 files changed, 164 insertions(+)

diff --git a/Documentation/arm64/elf_hwcaps.rst b/Documentation/arm64/elf_hwcaps.rst
index b72ff17d600a..5626cf208000 100644
--- a/Documentation/arm64/elf_hwcaps.rst
+++ b/Documentation/arm64/elf_hwcaps.rst
@@ -259,6 +259,39 @@ HWCAP2_RPRES
 
     Functionality implied by ID_AA64ISAR2_EL1.RPRES == 0b0001.
 
+HWCAP2_SME
+
+    Functionality implied by ID_AA64PFR1_EL1.SME == 0b0001, as described
+    by Documentation/arm64/sme.rst.
+
+HWCAP2_SME_I16I64
+
+    Functionality implied by ID_AA64SMFR0_EL1.I16I64 == 0b1111.
+
+HWCAP2_SME_F64F64
+
+    Functionality implied by ID_AA64SMFR0_EL1.F64F64 == 0b1.
+
+HWCAP2_SME_I8I32
+
+    Functionality implied by ID_AA64SMFR0_EL1.I8I32 == 0b1111.
+
+HWCAP2_SME_F16F32
+
+    Functionality implied by ID_AA64SMFR0_EL1.F16F32 == 0b1.
+
+HWCAP2_SME_B16F32
+
+    Functionality implied by ID_AA64SMFR0_EL1.B16F32 == 0b1.
+
+HWCAP2_SME_F32F32
+
+    Functionality implied by ID_AA64SMFR0_EL1.F32F32 == 0b1.
+
+HWCAP2_SME_FA64
+
+    Functionality implied by ID_AA64SMFR0_EL1.FA64 == 0b1.
+
 4. Unused AT_HWCAP bits
 -----------------------
 
diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
index a58e366f0b07..d08062bcb9c1 100644
--- a/arch/arm64/include/asm/cpu.h
+++ b/arch/arm64/include/asm/cpu.h
@@ -58,6 +58,7 @@ struct cpuinfo_arm64 {
 	u64		reg_id_aa64pfr0;
 	u64		reg_id_aa64pfr1;
 	u64		reg_id_aa64zfr0;
+	u64		reg_id_aa64smfr0;
 
 	struct cpuinfo_32bit	aarch32;
 
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 2728abd9cae4..f93b1442143f 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -728,6 +728,18 @@ static __always_inline bool system_supports_sve(void)
 		cpus_have_const_cap(ARM64_SVE);
 }
 
+static __always_inline bool system_supports_sme(void)
+{
+	return IS_ENABLED(CONFIG_ARM64_SME) &&
+		cpus_have_const_cap(ARM64_SME);
+}
+
+static __always_inline bool system_supports_fa64(void)
+{
+	return IS_ENABLED(CONFIG_ARM64_SME) &&
+		cpus_have_const_cap(ARM64_SME_FA64);
+}
+
 static __always_inline bool system_supports_cnp(void)
 {
 	return IS_ENABLED(CONFIG_ARM64_CNP) &&
diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 6e2dc9dcbf49..2e8ef00e7520 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -74,6 +74,8 @@ extern void sve_set_vq(unsigned long vq_minus_1);
 
 struct arm64_cpu_capabilities;
 extern void sve_kernel_enable(const struct arm64_cpu_capabilities *__unused);
+extern void sme_kernel_enable(const struct arm64_cpu_capabilities *__unused);
+extern void fa64_kernel_enable(const struct arm64_cpu_capabilities *__unused);
 
 extern u64 read_zcr_features(void);
 
diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
index f68fbb207473..76d9999527c5 100644
--- a/arch/arm64/include/asm/hwcap.h
+++ b/arch/arm64/include/asm/hwcap.h
@@ -108,6 +108,14 @@
 #define KERNEL_HWCAP_ECV		__khwcap2_feature(ECV)
 #define KERNEL_HWCAP_AFP		__khwcap2_feature(AFP)
 #define KERNEL_HWCAP_RPRES		__khwcap2_feature(RPRES)
+#define KERNEL_HWCAP_SME		__khwcap2_feature(SME)
+#define KERNEL_HWCAP_SME_I16I64		__khwcap2_feature(SME_I16I64)
+#define KERNEL_HWCAP_SME_F64F64		__khwcap2_feature(SME_F64F64)
+#define KERNEL_HWCAP_SME_I8I32		__khwcap2_feature(SME_I8I32)
+#define KERNEL_HWCAP_SME_F16F32		__khwcap2_feature(SME_F16F32)
+#define KERNEL_HWCAP_SME_B16F32		__khwcap2_feature(SME_B16F32)
+#define KERNEL_HWCAP_SME_F32F32		__khwcap2_feature(SME_F32F32)
+#define KERNEL_HWCAP_SME_FA64		__khwcap2_feature(SME_FA64)
 
 /*
  * This yields a mask that user programs can use to figure out what
diff --git a/arch/arm64/include/uapi/asm/hwcap.h b/arch/arm64/include/uapi/asm/hwcap.h
index f03731847d9d..60de5626f8fb 100644
--- a/arch/arm64/include/uapi/asm/hwcap.h
+++ b/arch/arm64/include/uapi/asm/hwcap.h
@@ -78,5 +78,13 @@
 #define HWCAP2_ECV		(1 << 19)
 #define HWCAP2_AFP		(1 << 20)
 #define HWCAP2_RPRES		(1 << 21)
+#define HWCAP2_SME		(1 << 22)
+#define HWCAP2_SME_I16I64	(1 << 23)
+#define HWCAP2_SME_F64F64	(1 << 24)
+#define HWCAP2_SME_I8I32	(1 << 25)
+#define HWCAP2_SME_F16F32	(1 << 26)
+#define HWCAP2_SME_B16F32	(1 << 27)
+#define HWCAP2_SME_F32F32	(1 << 28)
+#define HWCAP2_SME_FA64		(1 << 29)
 
 #endif /* _UAPI__ASM_HWCAP_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 64a748c2b351..5bfd440edd75 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -251,6 +251,8 @@ static const struct arm64_ftr_bits ftr_id_aa64pfr0[] = {
 };
 
 static const struct arm64_ftr_bits ftr_id_aa64pfr1[] = {
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
+		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_SME_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_MPAMFRAC_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_RASFRAC_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_MTE),
@@ -283,6 +285,24 @@ static const struct arm64_ftr_bits ftr_id_aa64zfr0[] = {
 	ARM64_FTR_END,
 };
 
+static const struct arm64_ftr_bits ftr_id_aa64smfr0[] = {
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
+		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_FA64_SHIFT, 1, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
+		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_I16I64_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
+		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_F64F64_SHIFT, 1, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
+		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_I8I32_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
+		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_F16F32_SHIFT, 1, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
+		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_B16F32_SHIFT, 1, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
+		       FTR_STRICT, FTR_EXACT, ID_AA64SMFR0_F32F32_SHIFT, 1, 0),
+	ARM64_FTR_END,
+};
+
 static const struct arm64_ftr_bits ftr_id_aa64mmfr0[] = {
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR0_ECV_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR0_FGT_SHIFT, 4, 0),
@@ -634,6 +654,7 @@ static const struct __ftr_reg_entry {
 	ARM64_FTR_REG_OVERRIDE(SYS_ID_AA64PFR1_EL1, ftr_id_aa64pfr1,
 			       &id_aa64pfr1_override),
 	ARM64_FTR_REG(SYS_ID_AA64ZFR0_EL1, ftr_id_aa64zfr0),
+	ARM64_FTR_REG(SYS_ID_AA64SMFR0_EL1, ftr_id_aa64smfr0),
 
 	/* Op1 = 0, CRn = 0, CRm = 5 */
 	ARM64_FTR_REG(SYS_ID_AA64DFR0_EL1, ftr_id_aa64dfr0),
@@ -947,6 +968,7 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
 	init_cpu_ftr_reg(SYS_ID_AA64PFR0_EL1, info->reg_id_aa64pfr0);
 	init_cpu_ftr_reg(SYS_ID_AA64PFR1_EL1, info->reg_id_aa64pfr1);
 	init_cpu_ftr_reg(SYS_ID_AA64ZFR0_EL1, info->reg_id_aa64zfr0);
+	init_cpu_ftr_reg(SYS_ID_AA64SMFR0_EL1, info->reg_id_aa64smfr0);
 
 	if (id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0))
 		init_32bit_cpu_features(&info->aarch32);
@@ -2403,6 +2425,33 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_cpuid_feature,
 		.min_field_value = 1,
 	},
+#ifdef CONFIG_ARM64_SME
+	{
+		.desc = "Scalable Matrix Extension",
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.capability = ARM64_SME,
+		.sys_reg = SYS_ID_AA64PFR1_EL1,
+		.sign = FTR_UNSIGNED,
+		.field_pos = ID_AA64PFR1_SME_SHIFT,
+		.field_width = 4,
+		.min_field_value = ID_AA64PFR1_SME,
+		.matches = has_cpuid_feature,
+		.cpu_enable = sme_kernel_enable,
+	},
+	/* FA64 should be sorted after the base SME capability */
+	{
+		.desc = "FA64",
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.capability = ARM64_SME_FA64,
+		.sys_reg = SYS_ID_AA64SMFR0_EL1,
+		.sign = FTR_UNSIGNED,
+		.field_pos = ID_AA64SMFR0_FA64_SHIFT,
+		.field_width = 1,
+		.min_field_value = ID_AA64SMFR0_FA64,
+		.matches = has_cpuid_feature,
+		.cpu_enable = fa64_kernel_enable,
+	},
+#endif /* CONFIG_ARM64_SME */
 	{},
 };
 
@@ -2527,6 +2576,16 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(SYS_ID_AA64MMFR0_EL1, ID_AA64MMFR0_ECV_SHIFT, 4, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_ECV),
 	HWCAP_CAP(SYS_ID_AA64MMFR1_EL1, ID_AA64MMFR1_AFP_SHIFT, 4, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_AFP),
 	HWCAP_CAP(SYS_ID_AA64ISAR2_EL1, ID_AA64ISAR2_RPRES_SHIFT, 4, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_RPRES),
+#ifdef CONFIG_ARM64_SME
+	HWCAP_CAP(SYS_ID_AA64PFR1_EL1, ID_AA64PFR1_SME_SHIFT, 4, FTR_UNSIGNED, ID_AA64PFR1_SME, CAP_HWCAP, KERNEL_HWCAP_SME),
+	HWCAP_CAP(SYS_ID_AA64SMFR0_EL1, ID_AA64SMFR0_FA64_SHIFT, 1, FTR_UNSIGNED, ID_AA64SMFR0_FA64, CAP_HWCAP, KERNEL_HWCAP_SME_FA64),
+	HWCAP_CAP(SYS_ID_AA64SMFR0_EL1, ID_AA64SMFR0_I16I64_SHIFT, 4, FTR_UNSIGNED, ID_AA64SMFR0_I16I64, CAP_HWCAP, KERNEL_HWCAP_SME_I16I64),
+	HWCAP_CAP(SYS_ID_AA64SMFR0_EL1, ID_AA64SMFR0_F64F64_SHIFT, 1, FTR_UNSIGNED, ID_AA64SMFR0_F64F64, CAP_HWCAP, KERNEL_HWCAP_SME_F64F64),
+	HWCAP_CAP(SYS_ID_AA64SMFR0_EL1, ID_AA64SMFR0_I8I32_SHIFT, 4, FTR_UNSIGNED, ID_AA64SMFR0_I8I32, CAP_HWCAP, KERNEL_HWCAP_SME_I8I32),
+	HWCAP_CAP(SYS_ID_AA64SMFR0_EL1, ID_AA64SMFR0_F16F32_SHIFT, 1, FTR_UNSIGNED, ID_AA64SMFR0_F16F32, CAP_HWCAP, KERNEL_HWCAP_SME_F16F32),
+	HWCAP_CAP(SYS_ID_AA64SMFR0_EL1, ID_AA64SMFR0_B16F32_SHIFT, 1, FTR_UNSIGNED, ID_AA64SMFR0_B16F32, CAP_HWCAP, KERNEL_HWCAP_SME_B16F32),
+	HWCAP_CAP(SYS_ID_AA64SMFR0_EL1, ID_AA64SMFR0_F32F32_SHIFT, 1, FTR_UNSIGNED, ID_AA64SMFR0_F32F32, CAP_HWCAP, KERNEL_HWCAP_SME_F32F32),
+#endif /* CONFIG_ARM64_SME */
 	{},
 };
 
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 591c18a889a5..33ec182e872e 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -97,6 +97,14 @@ static const char *const hwcap_str[] = {
 	[KERNEL_HWCAP_ECV]		= "ecv",
 	[KERNEL_HWCAP_AFP]		= "afp",
 	[KERNEL_HWCAP_RPRES]		= "rpres",
+	[KERNEL_HWCAP_SME]		= "sme",
+	[KERNEL_HWCAP_SME_I16I64]	= "smei16i64",
+	[KERNEL_HWCAP_SME_F64F64]	= "smef64f64",
+	[KERNEL_HWCAP_SME_I8I32]	= "smei8i32",
+	[KERNEL_HWCAP_SME_F16F32]	= "smef16f32",
+	[KERNEL_HWCAP_SME_B16F32]	= "smeb16f32",
+	[KERNEL_HWCAP_SME_F32F32]	= "smef32f32",
+	[KERNEL_HWCAP_SME_FA64]		= "smefa64",
 };
 
 #ifdef CONFIG_COMPAT
@@ -400,6 +408,7 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
 	info->reg_id_aa64pfr0 = read_cpuid(ID_AA64PFR0_EL1);
 	info->reg_id_aa64pfr1 = read_cpuid(ID_AA64PFR1_EL1);
 	info->reg_id_aa64zfr0 = read_cpuid(ID_AA64ZFR0_EL1);
+	info->reg_id_aa64smfr0 = read_cpuid(ID_AA64SMFR0_EL1);
 
 	if (id_aa64pfr1_mte(info->reg_id_aa64pfr1))
 		info->reg_gmid = read_cpuid(GMID_EL1);
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 5280e098cfb5..576490be3c2b 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -987,6 +987,32 @@ void fpsimd_release_task(struct task_struct *dead_task)
 
 #endif /* CONFIG_ARM64_SVE */
 
+#ifdef CONFIG_ARM64_SME
+
+void sme_kernel_enable(const struct arm64_cpu_capabilities *__always_unused p)
+{
+	/* Set priority for all PEs to architecturally defined minimum */
+	write_sysreg_s(read_sysreg_s(SYS_SMPRI_EL1) & ~SMPRI_EL1_PRIORITY_MASK,
+		       SYS_SMPRI_EL1);
+
+	/* Allow SME in kernel */
+	write_sysreg(read_sysreg(CPACR_EL1) | CPACR_EL1_SMEN_EL1EN, CPACR_EL1);
+	isb();
+}
+
+/*
+ * This must be called after sme_kernel_enable(), we rely on the
+ * feature table being sorted to ensure this.
+ */
+void fa64_kernel_enable(const struct arm64_cpu_capabilities *__always_unused p)
+{
+	/* Allow use of FA64 */
+	write_sysreg_s(read_sysreg_s(SYS_SMCR_EL1) | SMCR_ELx_FA64_MASK,
+		       SYS_SMCR_EL1);
+}
+
+#endif /* CONFIG_ARM64_SVE */
+
 /*
  * Trapped SVE access
  *
@@ -1532,6 +1558,10 @@ static int __init fpsimd_init(void)
 	if (!cpu_have_named_feature(ASIMD))
 		pr_notice("Advanced SIMD is not implemented\n");
 
+
+	if (cpu_have_named_feature(SME) && !cpu_have_named_feature(SVE))
+		pr_notice("SME is implemented but not SVE\n");
+
 	return sve_sysctl_init();
 }
 core_initcall(fpsimd_init);
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index 9c65b1e25a96..0a602525bda6 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -41,6 +41,8 @@ KVM_PROTECTED_MODE
 MISMATCHED_CACHE_TYPE
 MTE
 MTE_ASYMM
+SME
+SME_FA64
 SPECTRE_V2
 SPECTRE_V3A
 SPECTRE_V4
-- 
2.30.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
