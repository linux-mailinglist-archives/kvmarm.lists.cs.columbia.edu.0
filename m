Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0211D938B
	for <lists+kvmarm@lfdr.de>; Tue, 19 May 2020 11:41:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C1B2E4B085;
	Tue, 19 May 2020 05:41:54 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sOfXvvvLovFF; Tue, 19 May 2020 05:41:54 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 57BCC4B187;
	Tue, 19 May 2020 05:41:53 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 23FAF4B169
 for <kvmarm@lists.cs.columbia.edu>; Tue, 19 May 2020 05:41:52 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P9n+Gync3eaj for <kvmarm@lists.cs.columbia.edu>;
 Tue, 19 May 2020 05:41:50 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B5AAB4B10E
 for <kvmarm@lists.cs.columbia.edu>; Tue, 19 May 2020 05:41:50 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60D65101E;
 Tue, 19 May 2020 02:41:50 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.75.102])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6610A3F305;
 Tue, 19 May 2020 02:41:47 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH V4 04/17] arm64/cpufeature: Introduce ID_PFR2 CPU register
Date: Tue, 19 May 2020 15:10:41 +0530
Message-Id: <1589881254-10082-5-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589881254-10082-1-git-send-email-anshuman.khandual@arm.com>
References: <1589881254-10082-1-git-send-email-anshuman.khandual@arm.com>
Cc: catalin.marinas@arm.com, Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-kernel@vger.kernel.org, maz@kernel.org, will@kernel.org,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

This adds basic building blocks required for ID_PFR2 CPU register which
provides information about the AArch32 programmers model which must be
interpreted along with ID_PFR0 and ID_PFR1 CPU registers. This is added
per ARM DDI 0487F.a specification.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvmarm@lists.cs.columbia.edu
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/cpu.h    |  1 +
 arch/arm64/include/asm/sysreg.h |  4 ++++
 arch/arm64/kernel/cpufeature.c  | 11 +++++++++++
 arch/arm64/kernel/cpuinfo.c     |  1 +
 arch/arm64/kvm/sys_regs.c       |  2 +-
 5 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
index b4a40535a3d8..464e828a994d 100644
--- a/arch/arm64/include/asm/cpu.h
+++ b/arch/arm64/include/asm/cpu.h
@@ -46,6 +46,7 @@ struct cpuinfo_arm64 {
 	u32		reg_id_mmfr3;
 	u32		reg_id_pfr0;
 	u32		reg_id_pfr1;
+	u32		reg_id_pfr2;
 
 	u32		reg_mvfr0;
 	u32		reg_mvfr1;
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index ea55fe5925c4..d0ea916b8528 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -138,6 +138,7 @@
 
 #define SYS_ID_PFR0_EL1			sys_reg(3, 0, 0, 1, 0)
 #define SYS_ID_PFR1_EL1			sys_reg(3, 0, 0, 1, 1)
+#define SYS_ID_PFR2_EL1			sys_reg(3, 0, 0, 3, 4)
 #define SYS_ID_DFR0_EL1			sys_reg(3, 0, 0, 1, 2)
 #define SYS_ID_AFR0_EL1			sys_reg(3, 0, 0, 1, 3)
 #define SYS_ID_MMFR0_EL1		sys_reg(3, 0, 0, 1, 4)
@@ -789,6 +790,9 @@
 #define ID_ISAR6_DP_SHIFT		4
 #define ID_ISAR6_JSCVT_SHIFT		0
 
+#define ID_PFR2_SSBS_SHIFT		4
+#define ID_PFR2_CSV3_SHIFT		0
+
 #define MVFR0_FPROUND_SHIFT		28
 #define MVFR0_FPSHVEC_SHIFT		24
 #define MVFR0_FPSQRT_SHIFT		20
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 0d2b011c5930..600ce237c487 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -439,6 +439,12 @@ static const struct arm64_ftr_bits ftr_id_pfr1[] = {
 	ARM64_FTR_END,
 };
 
+static const struct arm64_ftr_bits ftr_id_pfr2[] = {
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_PFR2_SSBS_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_PFR2_CSV3_SHIFT, 4, 0),
+	ARM64_FTR_END,
+};
+
 static const struct arm64_ftr_bits ftr_id_dfr0[] = {
 	/* [31:28] TraceFilt */
 	S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 24, 4, 0xf),	/* PerfMon */
@@ -520,6 +526,7 @@ static const struct __ftr_reg_entry {
 	ARM64_FTR_REG(SYS_MVFR0_EL1, ftr_generic_32bits),
 	ARM64_FTR_REG(SYS_MVFR1_EL1, ftr_generic_32bits),
 	ARM64_FTR_REG(SYS_MVFR2_EL1, ftr_mvfr2),
+	ARM64_FTR_REG(SYS_ID_PFR2_EL1, ftr_id_pfr2),
 
 	/* Op1 = 0, CRn = 0, CRm = 4 */
 	ARM64_FTR_REG(SYS_ID_AA64PFR0_EL1, ftr_id_aa64pfr0),
@@ -726,6 +733,7 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
 		init_cpu_ftr_reg(SYS_ID_MMFR3_EL1, info->reg_id_mmfr3);
 		init_cpu_ftr_reg(SYS_ID_PFR0_EL1, info->reg_id_pfr0);
 		init_cpu_ftr_reg(SYS_ID_PFR1_EL1, info->reg_id_pfr1);
+		init_cpu_ftr_reg(SYS_ID_PFR2_EL1, info->reg_id_pfr2);
 		init_cpu_ftr_reg(SYS_MVFR0_EL1, info->reg_mvfr0);
 		init_cpu_ftr_reg(SYS_MVFR1_EL1, info->reg_mvfr1);
 		init_cpu_ftr_reg(SYS_MVFR2_EL1, info->reg_mvfr2);
@@ -859,6 +867,8 @@ static int update_32bit_cpu_features(int cpu, struct cpuinfo_arm64 *info,
 				      info->reg_id_pfr0, boot->reg_id_pfr0);
 	taint |= check_update_ftr_reg(SYS_ID_PFR1_EL1, cpu,
 				      info->reg_id_pfr1, boot->reg_id_pfr1);
+	taint |= check_update_ftr_reg(SYS_ID_PFR2_EL1, cpu,
+				      info->reg_id_pfr2, boot->reg_id_pfr2);
 	taint |= check_update_ftr_reg(SYS_MVFR0_EL1, cpu,
 				      info->reg_mvfr0, boot->reg_mvfr0);
 	taint |= check_update_ftr_reg(SYS_MVFR1_EL1, cpu,
@@ -986,6 +996,7 @@ static u64 __read_sysreg_by_encoding(u32 sys_id)
 	switch (sys_id) {
 	read_sysreg_case(SYS_ID_PFR0_EL1);
 	read_sysreg_case(SYS_ID_PFR1_EL1);
+	read_sysreg_case(SYS_ID_PFR2_EL1);
 	read_sysreg_case(SYS_ID_DFR0_EL1);
 	read_sysreg_case(SYS_ID_MMFR0_EL1);
 	read_sysreg_case(SYS_ID_MMFR1_EL1);
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 86136075ae41..cb79b083f97f 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -375,6 +375,7 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
 		info->reg_id_mmfr3 = read_cpuid(ID_MMFR3_EL1);
 		info->reg_id_pfr0 = read_cpuid(ID_PFR0_EL1);
 		info->reg_id_pfr1 = read_cpuid(ID_PFR1_EL1);
+		info->reg_id_pfr2 = read_cpuid(ID_PFR2_EL1);
 
 		info->reg_mvfr0 = read_cpuid(MVFR0_EL1);
 		info->reg_mvfr1 = read_cpuid(MVFR1_EL1);
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 51db934702b6..b784b156edb3 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1456,7 +1456,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	ID_SANITISED(MVFR1_EL1),
 	ID_SANITISED(MVFR2_EL1),
 	ID_UNALLOCATED(3,3),
-	ID_UNALLOCATED(3,4),
+	ID_SANITISED(ID_PFR2_EL1),
 	ID_UNALLOCATED(3,5),
 	ID_UNALLOCATED(3,6),
 	ID_UNALLOCATED(3,7),
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
