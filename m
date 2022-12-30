Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 07A4C6535F4
	for <lists+kvmarm@lfdr.de>; Wed, 21 Dec 2022 19:15:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7A99B4B8D7;
	Wed, 21 Dec 2022 13:15:22 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -6.789
X-Spam-Level: 
X-Spam-Status: No, score=-6.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, RCVD_IN_DNSWL_HI=-5, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fXKX6KAdaChD; Wed, 21 Dec 2022 13:15:22 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EEDC44B8C5;
	Wed, 21 Dec 2022 13:15:20 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 977814B8C2
 for <kvmarm@lists.cs.columbia.edu>; Wed, 21 Dec 2022 13:15:19 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id knaV-72Nd+BN for <kvmarm@lists.cs.columbia.edu>;
 Wed, 21 Dec 2022 13:15:17 -0500 (EST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 271E140B8D
 for <kvmarm@lists.cs.columbia.edu>; Wed, 21 Dec 2022 13:15:17 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 820CFB81C00;
 Wed, 21 Dec 2022 18:15:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB65C433F2;
 Wed, 21 Dec 2022 18:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1671646514;
 bh=94HjWxzW08Z//EfYfai+De+KLWMSXKM3yv9rcX7BXBI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=pNXZGN/6DplcAZ22blSBODPW+3U1rI/srCJqJWEYJMHRBZcD9tDR5PASqdB9ABMpP
 bnWEkclDBzzBpZ91xisf3coRVAhTgANYwREqRfntOyEew2jrk6cI0exwO0g/r5JU1Z
 Beefbnh5eK8iU6GWz9gNl2UOtOXQ/fr+GlHqVxPMRxrDit5d+A/qJxyYj7XpabDz8q
 u6MWO5Lq4vz9dBDlDW2vub8YYZHJD2VZxfY6xYvAunJaRPtyJCTUK9EBjPxjJekOBF
 D8UvTToB47Hf7/OzhrR+2NYo4123lsE0x+9XHgLoJYqFk5/SL7kImpdLFvb7l1icNS
 ySwP+KKuunPgg==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 21 Dec 2022 18:06:09 +0000
Subject: [PATCH 1/2] KVM: arm64: Convert non-GIC code to SYS_FIELD_{GET,PREP}
MIME-Version: 1.0
Message-Id: <20221221-kvm-sysreg-cleanup-v1-1-112ddb14fb4e@kernel.org>
References: <20221221-kvm-sysreg-cleanup-v1-0-112ddb14fb4e@kernel.org>
In-Reply-To: <20221221-kvm-sysreg-cleanup-v1-0-112ddb14fb4e@kernel.org>
To: Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Oliver Upton <oliver.upton@linux.dev>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
X-Mailer: b4 0.12-dev-05166
X-Developer-Signature: v=1; a=openpgp-sha256; l=12098; i=broonie@kernel.org;
 h=from:subject:message-id; bh=94HjWxzW08Z//EfYfai+De+KLWMSXKM3yv9rcX7BXBI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjo00qrLoEPRc3yuCaiqz/67t3qmEcYjeu1j/xnFCl
 ieOSuOCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY6NNKgAKCRAk1otyXVSH0CUVB/
 wO8Z8YqjFDavb/VLx69z1VGOfwzDn2srudII730tdKkji7i9m0Ak22LvFuH8toSDES2I+TZsnPPv3/
 idZc4GrLnQuFJ/59KmPUDiEVh4CDU0XfxiraTgSR27RycoZCESutHXQEzM+VD4Ec1tPc9xt9HrXjXK
 AW52jFWnBjZlShzMC3QT5kRs51J7ZicrC9mlFp5V0E+9unIRuPdcIbT8kfzrtXXNCTIhSOG+Z5k2ZM
 Pe2OPPzxy7FPTuKEkDWnanTAYXMUZu+8DrmeU+CqzeKuWZJWrLyVV9X4UJgqaZhfPAbWpcsBxNd/RF
 XgrSBhNg7owPcMacx0RuHPH8yUfaf4
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Cc: kvmarm@lists.linux.dev, Mark Brown <broonie@kernel.org>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
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

A while ago we introduced helpers which build on the generated defines for
the system registers which use token pasting to let us do FIELD_PREP() and
FIELD_GET() in a shorter and hopefully easier to read format, including one
specifically for enumerations. Update the bulk of the KVM code to use these
where the registers have already been converted, the remaining uses are in
the GIC code and will need conversions of the GIC registers.

No functional changes.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kvm/hyp/include/nvhe/fixed_config.h | 14 ++++-----
 arch/arm64/kvm/hyp/nvhe/pkvm.c                 | 40 +++++++++++++-------------
 arch/arm64/kvm/hyp/nvhe/sys_regs.c             | 12 ++++----
 arch/arm64/kvm/pmu-emul.c                      |  2 +-
 arch/arm64/kvm/sys_regs.c                      | 22 +++++++-------
 5 files changed, 46 insertions(+), 44 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/fixed_config.h b/arch/arm64/kvm/hyp/include/nvhe/fixed_config.h
index 07edfc7524c9..f42cd1bdb45b 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/fixed_config.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/fixed_config.h
@@ -49,11 +49,11 @@
  *	Supported by KVM
  */
 #define PVM_ID_AA64PFR0_RESTRICT_UNSIGNED (\
-	FIELD_PREP(ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_EL0), ID_AA64PFR0_EL1_ELx_64BIT_ONLY) | \
-	FIELD_PREP(ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_EL1), ID_AA64PFR0_EL1_ELx_64BIT_ONLY) | \
-	FIELD_PREP(ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_EL2), ID_AA64PFR0_EL1_ELx_64BIT_ONLY) | \
-	FIELD_PREP(ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_EL3), ID_AA64PFR0_EL1_ELx_64BIT_ONLY) | \
-	FIELD_PREP(ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_RAS), ID_AA64PFR0_EL1_RAS_IMP) \
+	SYS_FIELD_PREP_ENUM(ID_AA64PFR0_EL1, EL0, IMP) | \
+	SYS_FIELD_PREP_ENUM(ID_AA64PFR0_EL1, EL1, IMP) | \
+	SYS_FIELD_PREP_ENUM(ID_AA64PFR0_EL1, EL2, IMP) | \
+	SYS_FIELD_PREP_ENUM(ID_AA64PFR0_EL1, EL3, IMP) | \
+	SYS_FIELD_PREP_ENUM(ID_AA64PFR0_EL1, RAS, IMP)	 \
 	)
 
 /*
@@ -86,8 +86,8 @@
  * - 16-bit ASID
  */
 #define PVM_ID_AA64MMFR0_RESTRICT_UNSIGNED (\
-	FIELD_PREP(ARM64_FEATURE_MASK(ID_AA64MMFR0_EL1_PARANGE), ID_AA64MMFR0_EL1_PARANGE_40) | \
-	FIELD_PREP(ARM64_FEATURE_MASK(ID_AA64MMFR0_EL1_ASIDBITS), ID_AA64MMFR0_EL1_ASIDBITS_16) \
+	SYS_FIELD_PREP_ENUM(ID_AA64MMFR0_EL1, PARANGE, 40) |	\
+	SYS_FIELD_PREP_ENUM(ID_AA64MMFR0_EL1, ASIDBITS, 16)	\
 	)
 
 /*
diff --git a/arch/arm64/kvm/hyp/nvhe/pkvm.c b/arch/arm64/kvm/hyp/nvhe/pkvm.c
index a06ece14a6d8..eec461e2c5d5 100644
--- a/arch/arm64/kvm/hyp/nvhe/pkvm.c
+++ b/arch/arm64/kvm/hyp/nvhe/pkvm.c
@@ -29,35 +29,35 @@ static void pvm_init_traps_aa64pfr0(struct kvm_vcpu *vcpu)
 	u64 cptr_set = 0;
 
 	/* Protected KVM does not support AArch32 guests. */
-	BUILD_BUG_ON(FIELD_GET(ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_EL0),
-		PVM_ID_AA64PFR0_RESTRICT_UNSIGNED) != ID_AA64PFR0_EL1_ELx_64BIT_ONLY);
-	BUILD_BUG_ON(FIELD_GET(ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_EL1),
-		PVM_ID_AA64PFR0_RESTRICT_UNSIGNED) != ID_AA64PFR0_EL1_ELx_64BIT_ONLY);
+	BUILD_BUG_ON(SYS_FIELD_GET(ID_AA64PFR0_EL1, EL0,
+				PVM_ID_AA64PFR0_RESTRICT_UNSIGNED) != ID_AA64PFR0_EL1_ELx_64BIT_ONLY);
+	BUILD_BUG_ON(SYS_FIELD_GET(ID_AA64PFR0_EL1, EL1,
+				PVM_ID_AA64PFR0_RESTRICT_UNSIGNED) != ID_AA64PFR0_EL1_ELx_64BIT_ONLY);
 
 	/*
 	 * Linux guests assume support for floating-point and Advanced SIMD. Do
 	 * not change the trapping behavior for these from the KVM default.
 	 */
-	BUILD_BUG_ON(!FIELD_GET(ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_FP),
-				PVM_ID_AA64PFR0_ALLOW));
-	BUILD_BUG_ON(!FIELD_GET(ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_AdvSIMD),
-				PVM_ID_AA64PFR0_ALLOW));
+	BUILD_BUG_ON(!SYS_FIELD_GET(ID_AA64PFR0_EL1, FP,
+				    PVM_ID_AA64PFR0_ALLOW));
+	BUILD_BUG_ON(!SYS_FIELD_GET(ID_AA64PFR0_EL1, AdvSIMD,
+				    PVM_ID_AA64PFR0_ALLOW));
 
 	/* Trap RAS unless all current versions are supported */
-	if (FIELD_GET(ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_RAS), feature_ids) <
+	if (SYS_FIELD_GET(ID_AA64PFR0_EL1, RAS, feature_ids) <
 	    ID_AA64PFR0_EL1_RAS_V1P1) {
 		hcr_set |= HCR_TERR | HCR_TEA;
 		hcr_clear |= HCR_FIEN;
 	}
 
 	/* Trap AMU */
-	if (!FIELD_GET(ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_AMU), feature_ids)) {
+	if (!SYS_FIELD_GET(ID_AA64PFR0_EL1, AMU, feature_ids)) {
 		hcr_clear |= HCR_AMVOFFEN;
 		cptr_set |= CPTR_EL2_TAM;
 	}
 
 	/* Trap SVE */
-	if (!FIELD_GET(ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_SVE), feature_ids))
+	if (!SYS_FIELD_GET(ID_AA64PFR0_EL1, SVE, feature_ids))
 		cptr_set |= CPTR_EL2_TZ;
 
 	vcpu->arch.hcr_el2 |= hcr_set;
@@ -75,7 +75,7 @@ static void pvm_init_traps_aa64pfr1(struct kvm_vcpu *vcpu)
 	u64 hcr_clear = 0;
 
 	/* Memory Tagging: Trap and Treat as Untagged if not supported. */
-	if (!FIELD_GET(ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_MTE), feature_ids)) {
+	if (SYS_FIELD_GET(ID_AA64PFR1_EL1, MTE, feature_ids)) {
 		hcr_set |= HCR_TID5;
 		hcr_clear |= HCR_DCT | HCR_ATA;
 	}
@@ -95,32 +95,32 @@ static void pvm_init_traps_aa64dfr0(struct kvm_vcpu *vcpu)
 	u64 cptr_set = 0;
 
 	/* Trap/constrain PMU */
-	if (!FIELD_GET(ARM64_FEATURE_MASK(ID_AA64DFR0_EL1_PMUVer), feature_ids)) {
+	if (!SYS_FIELD_GET(ID_AA64DFR0_EL1, PMUVer, feature_ids)) {
 		mdcr_set |= MDCR_EL2_TPM | MDCR_EL2_TPMCR;
 		mdcr_clear |= MDCR_EL2_HPME | MDCR_EL2_MTPME |
 			      MDCR_EL2_HPMN_MASK;
 	}
 
 	/* Trap Debug */
-	if (!FIELD_GET(ARM64_FEATURE_MASK(ID_AA64DFR0_EL1_DebugVer), feature_ids))
+	if (!SYS_FIELD_GET(ID_AA64DFR0_EL1, DebugVer, feature_ids))
 		mdcr_set |= MDCR_EL2_TDRA | MDCR_EL2_TDA | MDCR_EL2_TDE;
 
 	/* Trap OS Double Lock */
-	if (!FIELD_GET(ARM64_FEATURE_MASK(ID_AA64DFR0_EL1_DoubleLock), feature_ids))
+	if (!SYS_FIELD_GET(ID_AA64DFR0_EL1, DoubleLock, feature_ids))
 		mdcr_set |= MDCR_EL2_TDOSA;
 
 	/* Trap SPE */
-	if (!FIELD_GET(ARM64_FEATURE_MASK(ID_AA64DFR0_EL1_PMSVer), feature_ids)) {
+	if (!SYS_FIELD_GET(ID_AA64DFR0_EL1, PMSVer, feature_ids)) {
 		mdcr_set |= MDCR_EL2_TPMS;
 		mdcr_clear |= MDCR_EL2_E2PB_MASK << MDCR_EL2_E2PB_SHIFT;
 	}
 
 	/* Trap Trace Filter */
-	if (!FIELD_GET(ARM64_FEATURE_MASK(ID_AA64DFR0_EL1_TraceFilt), feature_ids))
+	if (!SYS_FIELD_GET(ID_AA64DFR0_EL1, TraceFilt, feature_ids))
 		mdcr_set |= MDCR_EL2_TTRF;
 
 	/* Trap Trace */
-	if (!FIELD_GET(ARM64_FEATURE_MASK(ID_AA64DFR0_EL1_TraceVer), feature_ids))
+	if (!SYS_FIELD_GET(ID_AA64DFR0_EL1, TraceVer, feature_ids))
 		cptr_set |= CPTR_EL2_TTA;
 
 	vcpu->arch.mdcr_el2 |= mdcr_set;
@@ -137,7 +137,7 @@ static void pvm_init_traps_aa64mmfr0(struct kvm_vcpu *vcpu)
 	u64 mdcr_set = 0;
 
 	/* Trap Debug Communications Channel registers */
-	if (!FIELD_GET(ARM64_FEATURE_MASK(ID_AA64MMFR0_EL1_FGT), feature_ids))
+	if (!SYS_FIELD_GET(ID_AA64MMFR0_EL1, FGT, feature_ids))
 		mdcr_set |= MDCR_EL2_TDCC;
 
 	vcpu->arch.mdcr_el2 |= mdcr_set;
@@ -152,7 +152,7 @@ static void pvm_init_traps_aa64mmfr1(struct kvm_vcpu *vcpu)
 	u64 hcr_set = 0;
 
 	/* Trap LOR */
-	if (!FIELD_GET(ARM64_FEATURE_MASK(ID_AA64MMFR1_EL1_LO), feature_ids))
+	if (!SYS_FIELD_GET(ID_AA64MMFR1_EL1, LO, feature_ids))
 		hcr_set |= HCR_TLOR;
 
 	vcpu->arch.hcr_el2 |= hcr_set;
diff --git a/arch/arm64/kvm/hyp/nvhe/sys_regs.c b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
index 0f9ac25afdf4..1e656d928819 100644
--- a/arch/arm64/kvm/hyp/nvhe/sys_regs.c
+++ b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
@@ -92,10 +92,10 @@ static u64 get_pvm_id_aa64pfr0(const struct kvm_vcpu *vcpu)
 		PVM_ID_AA64PFR0_RESTRICT_UNSIGNED);
 
 	/* Spectre and Meltdown mitigation in KVM */
-	set_mask |= FIELD_PREP(ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_CSV2),
-			       (u64)kvm->arch.pfr0_csv2);
-	set_mask |= FIELD_PREP(ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_CSV3),
-			       (u64)kvm->arch.pfr0_csv3);
+	set_mask |= SYS_FIELD_PREP(ID_AA64PFR0_EL1, CSV2,
+				   (u64)kvm->arch.pfr0_csv2);
+	set_mask |= SYS_FIELD_PREP(ID_AA64PFR0_EL1, CSV3,
+				   (u64)kvm->arch.pfr0_csv3);
 
 	return (id_aa64pfr0_el1_sys_val & allow_mask) | set_mask;
 }
@@ -281,8 +281,8 @@ static bool pvm_access_id_aarch32(struct kvm_vcpu *vcpu,
 	 * No support for AArch32 guests, therefore, pKVM has no sanitized copy
 	 * of AArch32 feature id registers.
 	 */
-	BUILD_BUG_ON(FIELD_GET(ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_EL1),
-		     PVM_ID_AA64PFR0_RESTRICT_UNSIGNED) > ID_AA64PFR0_EL1_ELx_64BIT_ONLY);
+	BUILD_BUG_ON(SYS_FIELD_GET(ID_AA64PFR0_EL1, EL1,
+			   PVM_ID_AA64PFR0_RESTRICT_UNSIGNED) > ID_AA64PFR0_EL1_ELx_64BIT_ONLY);
 
 	return pvm_access_raz_wi(vcpu, p, r);
 }
diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index 24908400e190..ba2be9af0206 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -1058,5 +1058,5 @@ u8 kvm_arm_pmu_get_pmuver_limit(void)
 	tmp = cpuid_feature_cap_perfmon_field(tmp,
 					      ID_AA64DFR0_EL1_PMUVer_SHIFT,
 					      ID_AA64DFR0_EL1_PMUVer_V3P5);
-	return FIELD_GET(ARM64_FEATURE_MASK(ID_AA64DFR0_EL1_PMUVer), tmp);
+	return SYS_FIELD_GET(ID_AA64DFR0_EL1, PMUVer, tmp);
 }
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index d5ee52d6bf73..f97695bb8f64 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1111,12 +1111,14 @@ static u64 read_id_reg(const struct kvm_vcpu *vcpu, struct sys_reg_desc const *r
 			val &= ~ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_SVE);
 		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_AMU);
 		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_CSV2);
-		val |= FIELD_PREP(ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_CSV2), (u64)vcpu->kvm->arch.pfr0_csv2);
+		val |= SYS_FIELD_PREP(ID_AA64PFR0_EL1, CSV2,
+				      (u64)vcpu->kvm->arch.pfr0_csv2);
 		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_CSV3);
-		val |= FIELD_PREP(ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_CSV3), (u64)vcpu->kvm->arch.pfr0_csv3);
+		val |= SYS_FIELD_PREP(ID_AA64PFR0_EL1, CSV3,
+				      (u64)vcpu->kvm->arch.pfr0_csv3);
 		if (kvm_vgic_global_state.type == VGIC_V3) {
 			val &= ~ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_GIC);
-			val |= FIELD_PREP(ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_GIC), 1);
+			val |= SYS_FIELD_PREP(ID_AA64PFR0_EL1, GIC, 1);
 		}
 		break;
 	case SYS_ID_AA64PFR1_EL1:
@@ -1142,18 +1144,18 @@ static u64 read_id_reg(const struct kvm_vcpu *vcpu, struct sys_reg_desc const *r
 	case SYS_ID_AA64DFR0_EL1:
 		/* Limit debug to ARMv8.0 */
 		val &= ~ARM64_FEATURE_MASK(ID_AA64DFR0_EL1_DebugVer);
-		val |= FIELD_PREP(ARM64_FEATURE_MASK(ID_AA64DFR0_EL1_DebugVer), 6);
+		val |= SYS_FIELD_PREP(ID_AA64DFR0_EL1, DebugVer, 6);
 		/* Set PMUver to the required version */
 		val &= ~ARM64_FEATURE_MASK(ID_AA64DFR0_EL1_PMUVer);
-		val |= FIELD_PREP(ARM64_FEATURE_MASK(ID_AA64DFR0_EL1_PMUVer),
-				  vcpu_pmuver(vcpu));
+		val |= SYS_FIELD_PREP(ID_AA64DFR0_EL1, PMUVer,
+				      vcpu_pmuver(vcpu));
 		/* Hide SPE from guests */
 		val &= ~ARM64_FEATURE_MASK(ID_AA64DFR0_EL1_PMSVer);
 		break;
 	case SYS_ID_DFR0_EL1:
 		val &= ~ARM64_FEATURE_MASK(ID_DFR0_EL1_PerfMon);
-		val |= FIELD_PREP(ARM64_FEATURE_MASK(ID_DFR0_EL1_PerfMon),
-				  pmuver_to_perfmon(vcpu_pmuver(vcpu)));
+		val |= SYS_FIELD_PREP(ID_DFR0_EL1, PerfMon,
+				      pmuver_to_perfmon(vcpu_pmuver(vcpu)));
 		break;
 	}
 
@@ -1268,7 +1270,7 @@ static int set_id_aa64dfr0_el1(struct kvm_vcpu *vcpu,
 	 * allow an IMPDEF PMU though, only if no PMU is supported
 	 * (KVM backward compatibility handling).
 	 */
-	pmuver = FIELD_GET(ARM64_FEATURE_MASK(ID_AA64DFR0_EL1_PMUVer), val);
+	pmuver = SYS_FIELD_GET(ID_AA64DFR0_EL1, PMUVer, val);
 	if ((pmuver != ID_AA64DFR0_EL1_PMUVer_IMP_DEF && pmuver > host_pmuver))
 		return -EINVAL;
 
@@ -1307,7 +1309,7 @@ static int set_id_dfr0_el1(struct kvm_vcpu *vcpu,
 	 * AArch64 side (as everything is emulated with that), and
 	 * that this is a PMUv3.
 	 */
-	perfmon = FIELD_GET(ARM64_FEATURE_MASK(ID_DFR0_EL1_PerfMon), val);
+	perfmon = SYS_FIELD_GET(ID_DFR0_EL1, PerfMon, val);
 	if ((perfmon != ID_DFR0_EL1_PerfMon_IMPDEF && perfmon > host_perfmon) ||
 	    (perfmon != 0 && perfmon < ID_DFR0_EL1_PerfMon_PMUv3))
 		return -EINVAL;

-- 
2.30.2
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
