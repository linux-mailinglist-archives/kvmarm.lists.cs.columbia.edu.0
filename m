Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF072D60E9
	for <lists+kvmarm@lfdr.de>; Thu, 10 Dec 2020 17:04:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 172884B28F;
	Thu, 10 Dec 2020 11:04:15 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fpf1OSxnPgoY; Thu, 10 Dec 2020 11:04:14 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 105124B2A7;
	Thu, 10 Dec 2020 11:04:13 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 14E9B4B25F
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Dec 2020 11:04:12 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lS4vPlTpSpRh for <kvmarm@lists.cs.columbia.edu>;
 Thu, 10 Dec 2020 11:04:10 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 7F2D94B271
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Dec 2020 11:04:05 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9F93A23EB4;
 Thu, 10 Dec 2020 16:04:04 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1knONL-0008Di-2d; Thu, 10 Dec 2020 16:01:03 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: [PATCH v3 31/66] KVM: arm64: nv: Filter out unsupported features from
 ID regs
Date: Thu, 10 Dec 2020 15:59:27 +0000
Message-Id: <20201210160002.1407373-32-maz@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201210160002.1407373-1-maz@kernel.org>
References: <20201210160002.1407373-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, andre.przywara@arm.com,
 christoffer.dall@arm.com, jintack@cs.columbia.edu, alexandru.elisei@arm.com,
 james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
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
 arch/arm64/kvm/nested.c             | 152 ++++++++++++++++++++++++++++
 arch/arm64/kvm/sys_regs.c           |   4 +-
 3 files changed, 161 insertions(+), 1 deletion(-)

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
diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index 42a96c8d2adc..9fb44bc7db3f 100644
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
+#define FEATURE(x)	(GENMASK_ULL(x##_SHIFT + 3, x##_SHIFT))
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
+			 FEATURE(ID_AA64PFR0_EL2));
+		/* 64bit EL2 only */
+		val |= FIELD_PREP(FEATURE(ID_AA64PFR0_EL2), 0b0001);
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
index 80cf0c0761b9..d011b8156c52 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1372,8 +1372,10 @@ static bool access_id_reg(struct kvm_vcpu *vcpu,
 			  const struct sys_reg_desc *r)
 {
 	bool raz = sysreg_visible_as_raz(vcpu, r);
+	bool ret = __access_id_reg(vcpu, p, r, raz);
 
-	return __access_id_reg(vcpu, p, r, raz);
+	access_nested_id_reg(vcpu, p, r);
+	return ret;
 }
 
 static bool access_raz_id_reg(struct kvm_vcpu *vcpu,
-- 
2.29.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
