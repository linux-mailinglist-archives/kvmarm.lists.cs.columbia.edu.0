Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 222B7E4F92
	for <lists+kvmarm@lfdr.de>; Fri, 25 Oct 2019 16:52:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C166B4A591;
	Fri, 25 Oct 2019 10:52:32 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GkwuuCKZ0Gec; Fri, 25 Oct 2019 10:52:31 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 860CA4A557;
	Fri, 25 Oct 2019 10:52:31 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C3E5F4A618
 for <kvmarm@lists.cs.columbia.edu>; Fri, 25 Oct 2019 10:52:29 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Pbhqtl55q6HX for <kvmarm@lists.cs.columbia.edu>;
 Fri, 25 Oct 2019 10:52:28 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A61A44A5A3
 for <kvmarm@lists.cs.columbia.edu>; Fri, 25 Oct 2019 10:52:28 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F42B492;
 Fri, 25 Oct 2019 07:52:28 -0700 (PDT)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.20])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0CE383F71A;
 Fri, 25 Oct 2019 07:52:26 -0700 (PDT)
From: Andrew Murray <andrew.murray@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v1 2/3] KVM: arm64: limit PMU version to ARMv8.4
Date: Fri, 25 Oct 2019 15:52:18 +0100
Message-Id: <20191025145219.28350-3-andrew.murray@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191025145219.28350-1-andrew.murray@arm.com>
References: <20191025145219.28350-1-andrew.murray@arm.com>
MIME-Version: 1.0
Cc: kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

ARMv8.5-PMU introduces 64-bit event counters, however KVM doesn't yet
support this. Let's trap the Debug Feature Registers in order to limit
PMUVer/PerfMon in the Debug Feature Registers to PMUv3 for ARMv8.4.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 arch/arm64/include/asm/sysreg.h |  4 ++++
 arch/arm64/kvm/sys_regs.c       | 36 +++++++++++++++++++++++++++++++--
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 972d196c7714..0e82e210e22b 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -672,6 +672,10 @@
 #define ID_AA64DFR0_TRACEVER_SHIFT	4
 #define ID_AA64DFR0_DEBUGVER_SHIFT	0
 
+#define ID_DFR0_PERFMON_SHIFT		24
+
+#define ID_DFR0_EL1_PMUVER_8_4		5
+
 #define ID_ISAR5_RDM_SHIFT		24
 #define ID_ISAR5_CRC32_SHIFT		16
 #define ID_ISAR5_SHA2_SHIFT		12
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 2071260a275b..829838c9af3f 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -666,6 +666,37 @@ static bool pmu_access_event_counter_el0_disabled(struct kvm_vcpu *vcpu)
 	return check_pmu_access_disabled(vcpu, ARMV8_PMU_USERENR_ER | ARMV8_PMU_USERENR_EN);
 }
 
+static bool access_id_aa64dfr0_el1(struct kvm_vcpu *vcpu,
+				   struct sys_reg_params *p,
+				   const struct sys_reg_desc *rd)
+{
+	if (p->is_write)
+		return write_to_read_only(vcpu, p, rd);
+
+	/* Limit guests to PMUv3 for ARMv8.4 */
+	p->regval = read_sanitised_ftr_reg(SYS_ID_AA64DFR0_EL1);
+	p->regval = cpuid_feature_cap_signed_field_width(p->regval,
+						ID_AA64DFR0_PMUVER_SHIFT,
+						4, ID_DFR0_EL1_PMUVER_8_4);
+
+	return p->regval;
+}
+
+static bool access_id_dfr0_el1(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
+			       const struct sys_reg_desc *rd)
+{
+	if (p->is_write)
+		return write_to_read_only(vcpu, p, rd);
+
+	/* Limit guests to PMUv3 for ARMv8.4 */
+	p->regval = read_sanitised_ftr_reg(SYS_ID_DFR0_EL1);
+	p->regval = cpuid_feature_cap_signed_field_width(p->regval,
+						ID_DFR0_PERFMON_SHIFT,
+						4, ID_DFR0_EL1_PMUVER_8_4);
+
+	return p->regval;
+}
+
 static bool access_pmcr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 			const struct sys_reg_desc *r)
 {
@@ -1405,7 +1436,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	/* CRm=1 */
 	ID_SANITISED(ID_PFR0_EL1),
 	ID_SANITISED(ID_PFR1_EL1),
-	ID_SANITISED(ID_DFR0_EL1),
+	{ SYS_DESC(SYS_ID_DFR0_EL1), access_id_dfr0_el1 },
+
 	ID_HIDDEN(ID_AFR0_EL1),
 	ID_SANITISED(ID_MMFR0_EL1),
 	ID_SANITISED(ID_MMFR1_EL1),
@@ -1444,7 +1476,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	ID_UNALLOCATED(4,7),
 
 	/* CRm=5 */
-	ID_SANITISED(ID_AA64DFR0_EL1),
+	{ SYS_DESC(SYS_ID_AA64DFR0_EL1), access_id_aa64dfr0_el1 },
 	ID_SANITISED(ID_AA64DFR1_EL1),
 	ID_UNALLOCATED(5,2),
 	ID_UNALLOCATED(5,3),
-- 
2.21.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
