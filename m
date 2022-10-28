Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8CB610F7E
	for <lists+kvmarm@lfdr.de>; Fri, 28 Oct 2022 13:16:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E01E54B090;
	Fri, 28 Oct 2022 07:16:43 -0400 (EDT)
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
	with ESMTP id HpATJV3jpuZj; Fri, 28 Oct 2022 07:16:43 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9486349F53;
	Fri, 28 Oct 2022 07:16:41 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 085D8403FD
 for <kvmarm@lists.cs.columbia.edu>; Fri, 28 Oct 2022 07:16:40 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a8CF+176TRKd for <kvmarm@lists.cs.columbia.edu>;
 Fri, 28 Oct 2022 07:16:37 -0400 (EDT)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 29FF44A105
 for <kvmarm@lists.cs.columbia.edu>; Fri, 28 Oct 2022 07:16:37 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id A4D89627BC;
 Fri, 28 Oct 2022 11:16:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1475DC43143;
 Fri, 28 Oct 2022 11:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1666955796;
 bh=D60MFyLpEw78+sOWRo2TJ29+lIqz4GhgxHE8JUK81VY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kZf2AQm6n9v8xz3e37qa/cp6qNuBFgZSLeH20bvw1o5CC8HbJQ4ZbAE0km0ktuKKG
 dr2CwblhcTC6ak7+T0/25GXzw1+oSvwD5Hd3W7aXwlnNwLbAoQsrwpVpWhOvnqHzAY
 Bhge71dzPqrTOeEPV2jU408ATrKjH3u5gpd10/QnuTN80PrDo2NQ8wJcPEcS9nXh5/
 lxeq2+Z51/qne7ZczQoEcx9rr2sFx7A60hG8dSmXB99RUzxY2AlwDrf5ggkFaVDG2q
 Ve/R+7iFURqXB3DqFDr42pwok8jfw19f21HL7Nf2i/aK4FnEoVhlxbsaU1eABYsA+H
 vYZ6KkQDazNFA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <maz@kernel.org>) id 1ooN09-002E4C-Hh;
 Fri, 28 Oct 2022 11:54:13 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, <kvmarm@lists.cs.columbia.edu>,
 <kvmarm@lists.linux.dev>, kvm@vger.kernel.org
Subject: [PATCH v2 10/14] KVM: arm64: PMU: Move the ID_AA64DFR0_EL1.PMUver
 limit to VM creation
Date: Fri, 28 Oct 2022 11:53:58 +0100
Message-Id: <20221028105402.2030192-11-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221028105402.2030192-1-maz@kernel.org>
References: <20221028105402.2030192-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvmarm@lists.linux.dev, kvm@vger.kernel.org,
 james.morse@arm.com, suzuki.poulose@arm.com, alexandru.elisei@arm.com,
 oliver.upton@linux.dev, ricarkol@google.com, reijiw@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
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

As further patches will enable the selection of a PMU revision
from userspace, sample the supported PMU revision at VM creation
time, rather than building each time the ID_AA64DFR0_EL1 register
is accessed.

This shouldn't result in any change in behaviour.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h |  1 +
 arch/arm64/kvm/arm.c              |  6 +++++
 arch/arm64/kvm/pmu-emul.c         | 11 +++++++++
 arch/arm64/kvm/sys_regs.c         | 41 +++++++++++++++++++++++++------
 include/kvm/arm_pmu.h             |  6 +++++
 5 files changed, 57 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 45e2136322ba..90c9a2dd3f26 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -163,6 +163,7 @@ struct kvm_arch {
 
 	u8 pfr0_csv2;
 	u8 pfr0_csv3;
+	u8 dfr0_pmuver;
 
 	/* Hypercall features firmware registers' descriptor */
 	struct kvm_smccc_features smccc_feat;
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 94d33e296e10..6b3ed524630d 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -164,6 +164,12 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	set_default_spectre(kvm);
 	kvm_arm_init_hypercalls(kvm);
 
+	/*
+	 * Initialise the default PMUver before there is a chance to
+	 * create an actual PMU.
+	 */
+	kvm->arch.dfr0_pmuver = kvm_arm_pmu_get_pmuver_limit();
+
 	return ret;
 out_free_stage2_pgd:
 	kvm_free_stage2_pgd(&kvm->arch.mmu);
diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index 87585c12ca41..f126b45aa6c6 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -1049,3 +1049,14 @@ int kvm_arm_pmu_v3_has_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
 
 	return -ENXIO;
 }
+
+u8 kvm_arm_pmu_get_pmuver_limit(void)
+{
+	u64 tmp;
+
+	tmp = read_sanitised_ftr_reg(SYS_ID_AA64DFR0_EL1);
+	tmp = cpuid_feature_cap_perfmon_field(tmp,
+					      ID_AA64DFR0_EL1_PMUVer_SHIFT,
+					      ID_AA64DFR0_EL1_PMUVer_V3P4);
+	return FIELD_GET(ARM64_FEATURE_MASK(ID_AA64DFR0_EL1_PMUVer), tmp);
+}
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index f4a7c5abcbca..7a4cd644b9c0 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1062,6 +1062,32 @@ static bool access_arch_timer(struct kvm_vcpu *vcpu,
 	return true;
 }
 
+static u8 vcpu_pmuver(const struct kvm_vcpu *vcpu)
+{
+	if (kvm_vcpu_has_pmu(vcpu))
+		return vcpu->kvm->arch.dfr0_pmuver;
+
+	/* Special case for IMPDEF PMUs that KVM has exposed in the past... */
+	if (vcpu->kvm->arch.dfr0_pmuver == ID_AA64DFR0_EL1_PMUVer_IMP_DEF)
+		return ID_AA64DFR0_EL1_PMUVer_IMP_DEF;
+
+	/* The real "no PMU" */
+	return 0;
+}
+
+static u8 pmuver_to_perfmon(u8 pmuver)
+{
+	switch (pmuver) {
+	case ID_AA64DFR0_EL1_PMUVer_IMP:
+		return ID_DFR0_PERFMON_8_0;
+	case ID_AA64DFR0_EL1_PMUVer_IMP_DEF:
+		return ID_DFR0_PERFMON_IMP_DEF;
+	default:
+		/* Anything ARMv8.1+ has the same value. For now. */
+		return pmuver;
+	}
+}
+
 /* Read a sanitised cpufeature ID register by sys_reg_desc */
 static u64 read_id_reg(const struct kvm_vcpu *vcpu, struct sys_reg_desc const *r)
 {
@@ -1111,18 +1137,17 @@ static u64 read_id_reg(const struct kvm_vcpu *vcpu, struct sys_reg_desc const *r
 		/* Limit debug to ARMv8.0 */
 		val &= ~ARM64_FEATURE_MASK(ID_AA64DFR0_EL1_DebugVer);
 		val |= FIELD_PREP(ARM64_FEATURE_MASK(ID_AA64DFR0_EL1_DebugVer), 6);
-		/* Limit guests to PMUv3 for ARMv8.4 */
-		val = cpuid_feature_cap_perfmon_field(val,
-						      ID_AA64DFR0_EL1_PMUVer_SHIFT,
-						      kvm_vcpu_has_pmu(vcpu) ? ID_AA64DFR0_EL1_PMUVer_V3P4 : 0);
+		/* Set PMUver to the required version */
+		val &= ~ARM64_FEATURE_MASK(ID_AA64DFR0_EL1_PMUVer);
+		val |= FIELD_PREP(ARM64_FEATURE_MASK(ID_AA64DFR0_EL1_PMUVer),
+				  vcpu_pmuver(vcpu));
 		/* Hide SPE from guests */
 		val &= ~ARM64_FEATURE_MASK(ID_AA64DFR0_EL1_PMSVer);
 		break;
 	case SYS_ID_DFR0_EL1:
-		/* Limit guests to PMUv3 for ARMv8.4 */
-		val = cpuid_feature_cap_perfmon_field(val,
-						      ID_DFR0_PERFMON_SHIFT,
-						      kvm_vcpu_has_pmu(vcpu) ? ID_DFR0_PERFMON_8_4 : 0);
+		val &= ~ARM64_FEATURE_MASK(ID_DFR0_PERFMON);
+		val |= FIELD_PREP(ARM64_FEATURE_MASK(ID_DFR0_PERFMON),
+				  pmuver_to_perfmon(vcpu_pmuver(vcpu)));
 		break;
 	}
 
diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
index 96b192139a23..812f729c9108 100644
--- a/include/kvm/arm_pmu.h
+++ b/include/kvm/arm_pmu.h
@@ -89,6 +89,8 @@ void kvm_vcpu_pmu_restore_host(struct kvm_vcpu *vcpu);
 			vcpu->arch.pmu.events = *kvm_get_pmu_events();	\
 	} while (0)
 
+u8 kvm_arm_pmu_get_pmuver_limit(void);
+
 #else
 struct kvm_pmu {
 };
@@ -154,6 +156,10 @@ static inline u64 kvm_pmu_get_pmceid(struct kvm_vcpu *vcpu, bool pmceid1)
 static inline void kvm_pmu_update_vcpu_events(struct kvm_vcpu *vcpu) {}
 static inline void kvm_vcpu_pmu_restore_guest(struct kvm_vcpu *vcpu) {}
 static inline void kvm_vcpu_pmu_restore_host(struct kvm_vcpu *vcpu) {}
+static inline u8 kvm_arm_pmu_get_pmuver_limit(void)
+{
+	return 0;
+}
 
 #endif
 
-- 
2.34.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
