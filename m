Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC4630A6F4
	for <lists+kvmarm@lfdr.de>; Mon,  1 Feb 2021 12:57:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4CE244B40F;
	Mon,  1 Feb 2021 06:57:05 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sr-QA4NJwwns; Mon,  1 Feb 2021 06:57:04 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F2EC64B468;
	Mon,  1 Feb 2021 06:57:02 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7D5B24B46A
 for <kvmarm@lists.cs.columbia.edu>; Mon,  1 Feb 2021 06:56:59 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AK40fJKobE0O for <kvmarm@lists.cs.columbia.edu>;
 Mon,  1 Feb 2021 06:56:57 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 21EB74B3ED
 for <kvmarm@lists.cs.columbia.edu>; Mon,  1 Feb 2021 06:56:55 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 316B364EA2;
 Mon,  1 Feb 2021 11:56:54 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1l6Xp6-00BG09-Bp; Mon, 01 Feb 2021 11:56:52 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 linux-kernel@vger.kernel.org
Subject: [PATCH v6 09/21] arm64: cpufeature: Add global feature override
 facility
Date: Mon,  1 Feb 2021 11:56:25 +0000
Message-Id: <20210201115637.3123740-10-maz@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210201115637.3123740-1-maz@kernel.org>
References: <20210201115637.3123740-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
 catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
 dbrazdil@google.com, alexandru.elisei@arm.com, ardb@kernel.org,
 jingzhangos@google.com, pajay@qti.qualcomm.com, psodagud@codeaurora.org,
 sramana@codeaurora.org, james.morse@arm.com, julien.thierry.kdev@gmail.com,
 suzuki.poulose@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Prasad Sodagudi <psodagud@codeaurora.org>,
 Srinivas Ramana <sramana@codeaurora.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Ajay Patil <pajay@qti.qualcomm.com>,
 kernel-team@android.com, Will Deacon <will@kernel.org>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

Add a facility to globally override a feature, no matter what
the HW says. Yes, this sounds dangerous, but we do respect the
"safe" value for a given feature. This doesn't mean the user
doesn't need to know what they are doing.

Nothing uses this yet, so we are pretty safe. For now.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Acked-by: David Brazdil <dbrazdil@google.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/cpufeature.h |  6 ++++
 arch/arm64/kernel/cpufeature.c      | 45 +++++++++++++++++++++++++----
 2 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 9a555809b89c..b1f53147e2b2 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -63,6 +63,11 @@ struct arm64_ftr_bits {
 	s64		safe_val; /* safe value for FTR_EXACT features */
 };
 
+struct arm64_ftr_override {
+	u64		val;
+	u64		mask;
+};
+
 /*
  * @arm64_ftr_reg - Feature register
  * @strict_mask		Bits which should match across all CPUs for sanity.
@@ -74,6 +79,7 @@ struct arm64_ftr_reg {
 	u64				user_mask;
 	u64				sys_val;
 	u64				user_val;
+	struct arm64_ftr_override	*override;
 	const struct arm64_ftr_bits	*ftr_bits;
 };
 
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index e99eddec0a46..a4e5c619a516 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -352,9 +352,12 @@ static const struct arm64_ftr_bits ftr_ctr[] = {
 	ARM64_FTR_END,
 };
 
+static struct arm64_ftr_override __ro_after_init no_override = { };
+
 struct arm64_ftr_reg arm64_ftr_reg_ctrel0 = {
 	.name		= "SYS_CTR_EL0",
-	.ftr_bits	= ftr_ctr
+	.ftr_bits	= ftr_ctr,
+	.override	= &no_override,
 };
 
 static const struct arm64_ftr_bits ftr_id_mmfr0[] = {
@@ -544,13 +547,16 @@ static const struct arm64_ftr_bits ftr_raz[] = {
 	ARM64_FTR_END,
 };
 
-#define ARM64_FTR_REG(id, table) {		\
-	.sys_id = id,				\
-	.reg = 	&(struct arm64_ftr_reg){	\
-		.name = #id,			\
-		.ftr_bits = &((table)[0]),	\
+#define ARM64_FTR_REG_OVERRIDE(id, table, ovr) {		\
+		.sys_id = id,					\
+		.reg = 	&(struct arm64_ftr_reg){		\
+			.name = #id,				\
+			.override = (ovr),			\
+			.ftr_bits = &((table)[0]),		\
 	}}
 
+#define ARM64_FTR_REG(id, table) ARM64_FTR_REG_OVERRIDE(id, table, &no_override)
+
 static const struct __ftr_reg_entry {
 	u32			sys_id;
 	struct arm64_ftr_reg 	*reg;
@@ -770,6 +776,33 @@ static void __init init_cpu_ftr_reg(u32 sys_reg, u64 new)
 	for (ftrp = reg->ftr_bits; ftrp->width; ftrp++) {
 		u64 ftr_mask = arm64_ftr_mask(ftrp);
 		s64 ftr_new = arm64_ftr_value(ftrp, new);
+		s64 ftr_ovr = arm64_ftr_value(ftrp, reg->override->val);
+
+		if ((ftr_mask & reg->override->mask) == ftr_mask) {
+			s64 tmp = arm64_ftr_safe_value(ftrp, ftr_ovr, ftr_new);
+			char *str = NULL;
+
+			if (ftr_ovr != tmp) {
+				/* Unsafe, remove the override */
+				reg->override->mask &= ~ftr_mask;
+				reg->override->val &= ~ftr_mask;
+				tmp = ftr_ovr;
+				str = "ignoring override";
+			} else if (ftr_new != tmp) {
+				/* Override was valid */
+				ftr_new = tmp;
+				str = "forced";
+			} else if (ftr_ovr == tmp) {
+				/* Override was the safe value */
+				str = "already set";
+			}
+
+			if (str)
+				pr_warn("%s[%d:%d]: %s to %llx\n",
+					reg->name,
+					ftrp->shift + ftrp->width - 1,
+					ftrp->shift, str, tmp);
+		}
 
 		val = arm64_ftr_set_value(ftrp, val, ftr_new);
 
-- 
2.29.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
