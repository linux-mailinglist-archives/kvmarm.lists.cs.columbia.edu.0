Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 56BBF3795B7
	for <lists+kvmarm@lfdr.de>; Mon, 10 May 2021 19:28:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F3E004B490;
	Mon, 10 May 2021 13:28:31 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KHdc+z1pbviQ; Mon, 10 May 2021 13:28:31 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2D8874B83B;
	Mon, 10 May 2021 13:28:28 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 23FFD4B42A
 for <kvmarm@lists.cs.columbia.edu>; Mon, 10 May 2021 13:28:27 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id voJZ01QST5vh for <kvmarm@lists.cs.columbia.edu>;
 Mon, 10 May 2021 13:28:25 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 4BFE34B2A0
 for <kvmarm@lists.cs.columbia.edu>; Mon, 10 May 2021 13:28:23 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4DAD36161C;
 Mon, 10 May 2021 17:28:22 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1lg9GT-000Uqg-Sj; Mon, 10 May 2021 18:00:18 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: [PATCH v4 31/66] KVM: arm64: nv: Filter out unsupported features from
 ID regs
Date: Mon, 10 May 2021 17:58:45 +0100
Message-Id: <20210510165920.1913477-32-maz@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210510165920.1913477-1-maz@kernel.org>
References: <20210510165920.1913477-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, andre.przywara@arm.com,
 christoffer.dall@arm.com, jintack@cs.columbia.edu, haibo.xu@linaro.org,
 james.morse@arm.com, suzuki.poulose@arm.com, alexandru.elisei@arm.com,
 kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, Andre Przywara <andre.przywara@arm.com>
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

As there is a number of features that we either can't support,
or don't want to support right away with NV, let's add some
basic filtering so that we don't advertize silly things to the
EL2 guest.

Whilst we are at it, avertize ARMv8.4-TTL as well as ARMv8.5-GTG.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/kvm_nested.h |   6 ++
 arch/arm64/include/asm/sysreg.h     |   4 +
 arch/arm64/kvm/nested.c             | 152 ++++++++++++++++++++++++++++
 arch/arm64/kvm/sys_regs.c           |   6 +-
 arch/arm64/kvm/sys_regs.h           |   2 +
 5 files changed, 167 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_nested.h b/arch/arm64/include/asm/kvm_nested.h
index 07c15f51cf86..026ddaad972c 100644
--- a/arch/arm64/include/asm/kvm_nested.h
+++ b/arch/arm64/include/asm/kvm_nested.h
@@ -67,4 +67,10 @@ extern bool __forward_traps(struct kvm_vcpu *vcpu, unsigned int reg,
 extern bool forward_traps(struct kvm_vcpu *vcpu, u64 control_bit);
 extern bool forward_nv_traps(struct kvm_vcpu *vcpu);
 
+struct sys_reg_params;
+struct sys_reg_desc;
+
+void access_nested_id_reg(struct kvm_vcpu *v, struct sys_reg_params *p,
+			  const struct sys_reg_desc *r);
+
 #endif /* __ARM64_KVM_NESTED_H */
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 10c0d3a476e2..2704738d644a 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -828,6 +828,10 @@
 #define ID_AA64PFR0_FP_SUPPORTED	0x0
 #define ID_AA64PFR0_ASIMD_NI		0xf
 #define ID_AA64PFR0_ASIMD_SUPPORTED	0x0
+#define ID_AA64PFR0_EL3_64BIT_ONLY	0x1
+#define ID_AA64PFR0_EL3_32BIT_64BIT	0x2
+#define ID_AA64PFR0_EL2_64BIT_ONLY	0x1
+#define ID_AA64PFR0_EL2_32BIT_64BIT	0x2
 #define ID_AA64PFR0_EL1_64BIT_ONLY	0x1
 #define ID_AA64PFR0_EL1_32BIT_64BIT	0x2
 #define ID_AA64PFR0_EL0_64BIT_ONLY	0x1
diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index 42a96c8d2adc..99e1b97ae3ca 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -20,6 +20,10 @@
 #include <linux/kvm_host.h>
 
 #include <asm/kvm_emulate.h>
+#include <asm/kvm_nested.h>
+#include <asm/sysreg.h>
+
+#include "sys_regs.h"
 
 /*
  * Inject wfx to the virtual EL2 if this is not from the virtual EL2 and
@@ -38,3 +42,151 @@ int handle_wfx_nested(struct kvm_vcpu *vcpu, bool is_wfe)
 
 	return -EINVAL;
 }
+
+/*
+ * Our emulated CPU doesn't support all the possible features. For the
+ * sake of simplicity (and probably mental sanity), wipe out a number
+ * of feature bits we don't intend to support for the time being.
+ * This list should get updated as new features get added to the NV
+ * support, and new extension to the architecture.
+ */
+void access_nested_id_reg(struct kvm_vcpu *v, struct sys_reg_params *p,
+			  const struct sys_reg_desc *r)
+{
+	u32 id = sys_reg((u32)r->Op0, (u32)r->Op1,
+			 (u32)r->CRn, (u32)r->CRm, (u32)r->Op2);
+	u64 val, tmp;
+
+	if (!nested_virt_in_use(v))
+		return;
+
+	val = p->regval;
+
+	switch (id) {
+	case SYS_ID_AA64ISAR0_EL1:
+		/* Support everything but O.S. and Range TLBIs */
+		val &= ~(FEATURE(ID_AA64ISAR0_TLB)	|
+			 GENMASK_ULL(27, 24)		|
+			 GENMASK_ULL(3, 0));
+		break;
+
+	case SYS_ID_AA64ISAR1_EL1:
+		/* Support everything but PtrAuth and Spec Invalidation */
+		val &= ~(GENMASK_ULL(63, 56)		|
+			 FEATURE(ID_AA64ISAR1_SPECRES)	|
+			 FEATURE(ID_AA64ISAR1_GPI)	|
+			 FEATURE(ID_AA64ISAR1_GPA)	|
+			 FEATURE(ID_AA64ISAR1_API)	|
+			 FEATURE(ID_AA64ISAR1_APA));
+		break;
+
+	case SYS_ID_AA64PFR0_EL1:
+		/* No AMU, MPAM, S-EL2, RAS or SVE */
+		val &= ~(GENMASK_ULL(55, 52)		|
+			 FEATURE(ID_AA64PFR0_AMU)	|
+			 FEATURE(ID_AA64PFR0_MPAM)	|
+			 FEATURE(ID_AA64PFR0_SEL2)	|
+			 FEATURE(ID_AA64PFR0_RAS)	|
+			 FEATURE(ID_AA64PFR0_SVE)	|
+			 FEATURE(ID_AA64PFR0_EL3)	|
+			 FEATURE(ID_AA64PFR0_EL2));
+		/* 64bit EL2/EL3 only */
+		val |= FIELD_PREP(FEATURE(ID_AA64PFR0_EL2), 0b0001);
+		val |= FIELD_PREP(FEATURE(ID_AA64PFR0_EL3), 0b0001);
+		break;
+
+	case SYS_ID_AA64PFR1_EL1:
+		/* Only support SSBS */
+		val &= FEATURE(ID_AA64PFR1_SSBS);
+		break;
+
+	case SYS_ID_AA64MMFR0_EL1:
+		/* Hide ECV, FGT, ExS, Secure Memory */
+		val &= ~(GENMASK_ULL(63, 43)			|
+			 FEATURE(ID_AA64MMFR0_TGRAN4_2)		|
+			 FEATURE(ID_AA64MMFR0_TGRAN16_2)	|
+			 FEATURE(ID_AA64MMFR0_TGRAN64_2)	|
+			 FEATURE(ID_AA64MMFR0_SNSMEM));
+
+		/* Disallow unsupported S2 page sizes */
+		switch (PAGE_SIZE) {
+		case SZ_64K:
+			val |= FIELD_PREP(FEATURE(ID_AA64MMFR0_TGRAN16_2), 0b0001);
+			/* Fall through */
+		case SZ_16K:
+			val |= FIELD_PREP(FEATURE(ID_AA64MMFR0_TGRAN4_2), 0b0001);
+			/* Fall through */
+		case SZ_4K:
+			/* Support everything */
+			break;
+		}
+		/* Advertize supported S2 page sizes */
+		switch (PAGE_SIZE) {
+		case SZ_4K:
+			val |= FIELD_PREP(FEATURE(ID_AA64MMFR0_TGRAN4_2), 0b0010);
+			/* Fall through */
+		case SZ_16K:
+			val |= FIELD_PREP(FEATURE(ID_AA64MMFR0_TGRAN16_2), 0b0010);
+			/* Fall through */
+		case SZ_64K:
+			val |= FIELD_PREP(FEATURE(ID_AA64MMFR0_TGRAN64_2), 0b0010);
+			break;
+		}
+		/* Cap PARange to 40bits */
+		tmp = FIELD_GET(FEATURE(ID_AA64MMFR0_PARANGE), val);
+		if (tmp > 0b0010) {
+			val &= ~FEATURE(ID_AA64MMFR0_PARANGE);
+			val |= FIELD_PREP(FEATURE(ID_AA64MMFR0_PARANGE), 0b0010);
+		}
+		break;
+
+	case SYS_ID_AA64MMFR1_EL1:
+		val &= (FEATURE(ID_AA64MMFR1_PAN)	|
+			FEATURE(ID_AA64MMFR1_LOR)	|
+			FEATURE(ID_AA64MMFR1_HPD)	|
+			FEATURE(ID_AA64MMFR1_VHE)	|
+			FEATURE(ID_AA64MMFR1_VMIDBITS));
+		break;
+
+	case SYS_ID_AA64MMFR2_EL1:
+		val &= ~(FEATURE(ID_AA64MMFR2_EVT)	|
+			 FEATURE(ID_AA64MMFR2_BBM)	|
+			 FEATURE(ID_AA64MMFR2_TTL)	|
+			 GENMASK_ULL(47, 44)		|
+			 FEATURE(ID_AA64MMFR2_ST)	|
+			 FEATURE(ID_AA64MMFR2_CCIDX)	|
+			 FEATURE(ID_AA64MMFR2_LVA));
+
+		/* Force TTL support */
+		val |= FIELD_PREP(FEATURE(ID_AA64MMFR2_TTL), 0b0001);
+		break;
+
+	case SYS_ID_AA64DFR0_EL1:
+		/* Only limited support for PMU, Debug, BPs and WPs */
+		val &= (FEATURE(ID_AA64DFR0_PMSVER)	|
+			FEATURE(ID_AA64DFR0_WRPS)	|
+			FEATURE(ID_AA64DFR0_BRPS)	|
+			FEATURE(ID_AA64DFR0_DEBUGVER));
+
+		/* Cap PMU to ARMv8.1 */
+		tmp = FIELD_GET(FEATURE(ID_AA64DFR0_PMUVER), val);
+		if (tmp > 0b0100) {
+			val &= ~FEATURE(ID_AA64DFR0_PMUVER);
+			val |= FIELD_PREP(FEATURE(ID_AA64DFR0_PMUVER), 0b0100);
+		}
+		/* Cap Debug to ARMv8.1 */
+		tmp = FIELD_GET(FEATURE(ID_AA64DFR0_DEBUGVER), val);
+		if (tmp > 0b0111) {
+			val &= ~FEATURE(ID_AA64DFR0_DEBUGVER);
+			val |= FIELD_PREP(FEATURE(ID_AA64DFR0_DEBUGVER), 0b0111);
+		}
+		break;
+
+	default:
+		/* Unknown register, just wipe it clean */
+		val = 0;
+		break;
+	}
+
+	p->regval = val;
+}
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 2b8f3875faf2..6bd5e4084cee 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1304,8 +1304,6 @@ static bool access_arch_timer(struct kvm_vcpu *vcpu,
 	return true;
 }
 
-#define FEATURE(x)	(GENMASK_ULL(x##_SHIFT + 3, x##_SHIFT))
-
 /* Read a sanitised cpufeature ID register by sys_reg_desc */
 static u64 read_id_reg(const struct kvm_vcpu *vcpu,
 		struct sys_reg_desc const *r, bool raz)
@@ -1389,8 +1387,10 @@ static bool access_id_reg(struct kvm_vcpu *vcpu,
 			  const struct sys_reg_desc *r)
 {
 	bool raz = sysreg_visible_as_raz(vcpu, r);
+	bool ret = __access_id_reg(vcpu, p, r, raz);
 
-	return __access_id_reg(vcpu, p, r, raz);
+	access_nested_id_reg(vcpu, p, r);
+	return ret;
 }
 
 static bool access_raz_id_reg(struct kvm_vcpu *vcpu,
diff --git a/arch/arm64/kvm/sys_regs.h b/arch/arm64/kvm/sys_regs.h
index 9d0621417c2a..c6fbe3a7855e 100644
--- a/arch/arm64/kvm/sys_regs.h
+++ b/arch/arm64/kvm/sys_regs.h
@@ -170,4 +170,6 @@ const struct sys_reg_desc *find_reg_by_id(u64 id,
 	CRn(sys_reg_CRn(reg)), CRm(sys_reg_CRm(reg)),	\
 	Op2(sys_reg_Op2(reg))
 
+#define FEATURE(x)	(GENMASK_ULL(x##_SHIFT + 3, x##_SHIFT))
+
 #endif /* __ARM64_KVM_SYS_REGS_LOCAL_H__ */
-- 
2.29.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
