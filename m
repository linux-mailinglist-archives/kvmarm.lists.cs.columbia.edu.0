Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 13EEB619C38
	for <lists+kvmarm@lfdr.de>; Fri,  4 Nov 2022 16:55:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 88207411BD;
	Fri,  4 Nov 2022 11:55:29 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 required=6.1 tests=[BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Kn334LOE-Ead; Fri,  4 Nov 2022 11:55:25 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 60D1240E25;
	Fri,  4 Nov 2022 11:55:25 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 41BDE41066
 for <kvmarm@lists.cs.columbia.edu>; Fri,  4 Nov 2022 11:55:24 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7Z9sH0OAH4SL for <kvmarm@lists.cs.columbia.edu>;
 Fri,  4 Nov 2022 11:55:22 -0400 (EDT)
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com
 [209.85.161.45])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id B076740BD9
 for <kvmarm@lists.cs.columbia.edu>; Fri,  4 Nov 2022 11:55:21 -0400 (EDT)
Received: by mail-oo1-f45.google.com with SMTP id
 r10-20020a4aa2ca000000b0049dd7ad4128so721025ool.13
 for <kvmarm@lists.cs.columbia.edu>; Fri, 04 Nov 2022 08:55:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vXHN85rGi/sHJxkCh/EJ6+8yFyKV7jY1RaGb4FopPeo=;
 b=ijaFr8KZHKaQ/M1tjKaJTcRerRLPtdrj0n6jMDewIBDJ53rBAHF0FzqN0npP+xqh8R
 PrzVjy+FxWHaqSF93hT4kVbXb2nLfowBp9pmDjhiDBRQX9IcfPokj4sbpE1092Ad4m2d
 ctKFh6WFcyjXtEn1ZszP8YaJLGe+eCDZ33wl0yBIBteKJ2/VvgCpH2J2szLM+08x0WVg
 nZHWsEmIsK/Sez2I6olEIgxnYngvW4A/CbucbfnPkKf7IFTohiS2aZ3Ov/Ne1xO1vgPw
 gOQiIIc31LruoaLORbEWKFxuLXDYzuz4HBIrTZxQgoU0fn7OOZXap+Gri1tM4yzc8miT
 /ByA==
X-Gm-Message-State: ACrzQf2ZqQTO/T5dTDwq41WjBn4Orpc+8hzlZhmKtDD6ujYOzO8wJuDy
 /yICGlujcQXZeHD3PYNQhQ==
X-Google-Smtp-Source: AMsMyM7pCwyPgb66JWSqAhyJT2Zy19MfmfLvn4n0Iy5I5SMyodx/qFkxvUx6vK81mIjTcgeM6iIZtg==
X-Received: by 2002:a4a:8e81:0:b0:475:811f:3f9e with SMTP id
 p1-20020a4a8e81000000b00475811f3f9emr15376005ook.35.1667577320918; 
 Fri, 04 Nov 2022 08:55:20 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net.
 [66.90.144.107]) by smtp.gmail.com with ESMTPSA id
 l8-20020a056870218800b0013669485016sm1884406oae.37.2022.11.04.08.55.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Nov 2022 08:55:20 -0700 (PDT)
Received: (nullmailer pid 1880412 invoked by uid 1000);
 Fri, 04 Nov 2022 15:55:18 -0000
From: Rob Herring <robh@kernel.org>
Date: Fri, 04 Nov 2022 10:55:02 -0500
Subject: [PATCH v3 2/8] arm64: Drop SYS_ from SPE register defines
MIME-Version: 1.0
Message-Id: <20220825-arm-spe-v8-7-v3-2-87682f78caac@kernel.org>
References: <20220825-arm-spe-v8-7-v3-0-87682f78caac@kernel.org>
In-Reply-To: <20220825-arm-spe-v8-7-v3-0-87682f78caac@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>, Will Deacon <will@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 Ingo Molnar <mingo@redhat.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 James Morse <james.morse@arm.com>, Alexandru Elisei <alexandru.elisei@arm.com>
X-Mailer: b4 0.11.0-dev
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, James Clark <james.clark@arm.com>,
 kvmarm@lists.linux.dev, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
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

We currently have a non-standard SYS_ prefix in the constants generated
for the SPE register bitfields. Drop this in preparation for automatic
register definition generation.

The SPE mask defines were unshifted, and the SPE register field
enumerations were shifted. The autogenerated defines are the opposite,
so make the necessary adjustments.

No functional changes.

Tested-by: James Clark <james.clark@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v3:
 - No change
v2:
 - New patch
---
 arch/arm64/include/asm/el2_setup.h |   6 +-
 arch/arm64/include/asm/sysreg.h    | 112 ++++++++++++++++++-------------------
 arch/arm64/kvm/debug.c             |   2 +-
 arch/arm64/kvm/hyp/nvhe/debug-sr.c |   2 +-
 drivers/perf/arm_spe_pmu.c         |  85 ++++++++++++++--------------
 5 files changed, 103 insertions(+), 104 deletions(-)

diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index 668569adf4d3..f9da43e53cdb 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -53,10 +53,10 @@
 	cbz	x0, .Lskip_spe_\@		// Skip if SPE not present
 
 	mrs_s	x0, SYS_PMBIDR_EL1              // If SPE available at EL2,
-	and	x0, x0, #(1 << SYS_PMBIDR_EL1_P_SHIFT)
+	and	x0, x0, #(1 << PMBIDR_EL1_P_SHIFT)
 	cbnz	x0, .Lskip_spe_el2_\@		// then permit sampling of physical
-	mov	x0, #(1 << SYS_PMSCR_EL2_PCT_SHIFT | \
-		      1 << SYS_PMSCR_EL2_PA_SHIFT)
+	mov	x0, #(1 << PMSCR_EL2_PCT_SHIFT | \
+		      1 << PMSCR_EL2_PA_SHIFT)
 	msr_s	SYS_PMSCR_EL2, x0		// addresses and physical counter
 .Lskip_spe_el2_\@:
 	mov	x0, #(MDCR_EL2_E2PB_MASK << MDCR_EL2_E2PB_SHIFT)
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 9a4cf12e3e16..8df8a0a51273 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -239,59 +239,59 @@
 /*** Statistical Profiling Extension ***/
 /* ID registers */
 #define SYS_PMSIDR_EL1			sys_reg(3, 0, 9, 9, 7)
-#define SYS_PMSIDR_EL1_FE_SHIFT		0
-#define SYS_PMSIDR_EL1_FT_SHIFT		1
-#define SYS_PMSIDR_EL1_FL_SHIFT		2
-#define SYS_PMSIDR_EL1_ARCHINST_SHIFT	3
-#define SYS_PMSIDR_EL1_LDS_SHIFT	4
-#define SYS_PMSIDR_EL1_ERND_SHIFT	5
-#define SYS_PMSIDR_EL1_INTERVAL_SHIFT	8
-#define SYS_PMSIDR_EL1_INTERVAL_MASK	0xfUL
-#define SYS_PMSIDR_EL1_MAXSIZE_SHIFT	12
-#define SYS_PMSIDR_EL1_MAXSIZE_MASK	0xfUL
-#define SYS_PMSIDR_EL1_COUNTSIZE_SHIFT	16
-#define SYS_PMSIDR_EL1_COUNTSIZE_MASK	0xfUL
+#define PMSIDR_EL1_FE_SHIFT		0
+#define PMSIDR_EL1_FT_SHIFT		1
+#define PMSIDR_EL1_FL_SHIFT		2
+#define PMSIDR_EL1_ARCHINST_SHIFT	3
+#define PMSIDR_EL1_LDS_SHIFT	4
+#define PMSIDR_EL1_ERND_SHIFT	5
+#define PMSIDR_EL1_INTERVAL_SHIFT	8
+#define PMSIDR_EL1_INTERVAL_MASK	GENMASK_ULL(11, 8)
+#define PMSIDR_EL1_MAXSIZE_SHIFT	12
+#define PMSIDR_EL1_MAXSIZE_MASK		GENMASK_ULL(15, 12)
+#define PMSIDR_EL1_COUNTSIZE_SHIFT	16
+#define PMSIDR_EL1_COUNTSIZE_MASK	GENMASK_ULL(19, 16)
 
 #define SYS_PMBIDR_EL1			sys_reg(3, 0, 9, 10, 7)
-#define SYS_PMBIDR_EL1_ALIGN_SHIFT	0
-#define SYS_PMBIDR_EL1_ALIGN_MASK	0xfU
-#define SYS_PMBIDR_EL1_P_SHIFT		4
-#define SYS_PMBIDR_EL1_F_SHIFT		5
+#define PMBIDR_EL1_ALIGN_SHIFT		0
+#define PMBIDR_EL1_ALIGN_MASK		0xfU
+#define PMBIDR_EL1_P_SHIFT		4
+#define PMBIDR_EL1_F_SHIFT		5
 
 /* Sampling controls */
 #define SYS_PMSCR_EL1			sys_reg(3, 0, 9, 9, 0)
-#define SYS_PMSCR_EL1_E0SPE_SHIFT	0
-#define SYS_PMSCR_EL1_E1SPE_SHIFT	1
-#define SYS_PMSCR_EL1_CX_SHIFT		3
-#define SYS_PMSCR_EL1_PA_SHIFT		4
-#define SYS_PMSCR_EL1_TS_SHIFT		5
-#define SYS_PMSCR_EL1_PCT_SHIFT		6
+#define PMSCR_EL1_E0SPE_SHIFT		0
+#define PMSCR_EL1_E1SPE_SHIFT		1
+#define PMSCR_EL1_CX_SHIFT		3
+#define PMSCR_EL1_PA_SHIFT		4
+#define PMSCR_EL1_TS_SHIFT		5
+#define PMSCR_EL1_PCT_SHIFT		6
 
 #define SYS_PMSCR_EL2			sys_reg(3, 4, 9, 9, 0)
-#define SYS_PMSCR_EL2_E0HSPE_SHIFT	0
-#define SYS_PMSCR_EL2_E2SPE_SHIFT	1
-#define SYS_PMSCR_EL2_CX_SHIFT		3
-#define SYS_PMSCR_EL2_PA_SHIFT		4
-#define SYS_PMSCR_EL2_TS_SHIFT		5
-#define SYS_PMSCR_EL2_PCT_SHIFT		6
+#define PMSCR_EL2_E0HSPE_SHIFT		0
+#define PMSCR_EL2_E2SPE_SHIFT		1
+#define PMSCR_EL2_CX_SHIFT		3
+#define PMSCR_EL2_PA_SHIFT		4
+#define PMSCR_EL2_TS_SHIFT		5
+#define PMSCR_EL2_PCT_SHIFT		6
 
 #define SYS_PMSICR_EL1			sys_reg(3, 0, 9, 9, 2)
 
 #define SYS_PMSIRR_EL1			sys_reg(3, 0, 9, 9, 3)
-#define SYS_PMSIRR_EL1_RND_SHIFT	0
-#define SYS_PMSIRR_EL1_INTERVAL_SHIFT	8
-#define SYS_PMSIRR_EL1_INTERVAL_MASK	0xffffffUL
+#define PMSIRR_EL1_RND_SHIFT		0
+#define PMSIRR_EL1_INTERVAL_SHIFT	8
+#define PMSIRR_EL1_INTERVAL_MASK	GENMASK_ULL(31, 8)
 
 /* Filtering controls */
 #define SYS_PMSNEVFR_EL1		sys_reg(3, 0, 9, 9, 1)
 
 #define SYS_PMSFCR_EL1			sys_reg(3, 0, 9, 9, 4)
-#define SYS_PMSFCR_EL1_FE_SHIFT		0
-#define SYS_PMSFCR_EL1_FT_SHIFT		1
-#define SYS_PMSFCR_EL1_FL_SHIFT		2
-#define SYS_PMSFCR_EL1_B_SHIFT		16
-#define SYS_PMSFCR_EL1_LD_SHIFT		17
-#define SYS_PMSFCR_EL1_ST_SHIFT		18
+#define PMSFCR_EL1_FE_SHIFT		0
+#define PMSFCR_EL1_FT_SHIFT		1
+#define PMSFCR_EL1_FL_SHIFT		2
+#define PMSFCR_EL1_B_SHIFT		16
+#define PMSFCR_EL1_LD_SHIFT		17
+#define PMSFCR_EL1_ST_SHIFT		18
 
 #define SYS_PMSEVFR_EL1			sys_reg(3, 0, 9, 9, 5)
 #define PMSEVFR_EL1_RES0_IMP	\
@@ -301,37 +301,37 @@
 	(PMSEVFR_EL1_RES0_IMP & ~(BIT_ULL(18) | BIT_ULL(17) | BIT_ULL(11)))
 
 #define SYS_PMSLATFR_EL1		sys_reg(3, 0, 9, 9, 6)
-#define SYS_PMSLATFR_EL1_MINLAT_SHIFT	0
+#define PMSLATFR_EL1_MINLAT_SHIFT	0
 
 /* Buffer controls */
 #define SYS_PMBLIMITR_EL1		sys_reg(3, 0, 9, 10, 0)
-#define SYS_PMBLIMITR_EL1_E_SHIFT	0
-#define SYS_PMBLIMITR_EL1_FM_SHIFT	1
-#define SYS_PMBLIMITR_EL1_FM_MASK	0x3UL
-#define SYS_PMBLIMITR_EL1_FM_STOP_IRQ	(0 << SYS_PMBLIMITR_EL1_FM_SHIFT)
+#define PMBLIMITR_EL1_E_SHIFT		0
+#define PMBLIMITR_EL1_FM_SHIFT		1
+#define PMBLIMITR_EL1_FM_MASK	GENMASK_ULL(2, 1)
+#define PMBLIMITR_EL1_FM_STOP_IRQ	0
 
 #define SYS_PMBPTR_EL1			sys_reg(3, 0, 9, 10, 1)
 
 /* Buffer error reporting */
 #define SYS_PMBSR_EL1			sys_reg(3, 0, 9, 10, 3)
-#define SYS_PMBSR_EL1_COLL_SHIFT	16
-#define SYS_PMBSR_EL1_S_SHIFT		17
-#define SYS_PMBSR_EL1_EA_SHIFT		18
-#define SYS_PMBSR_EL1_DL_SHIFT		19
-#define SYS_PMBSR_EL1_EC_SHIFT		26
-#define SYS_PMBSR_EL1_EC_MASK		0x3fUL
+#define PMBSR_EL1_COLL_SHIFT		16
+#define PMBSR_EL1_S_SHIFT		17
+#define PMBSR_EL1_EA_SHIFT		18
+#define PMBSR_EL1_DL_SHIFT		19
+#define PMBSR_EL1_EC_SHIFT		26
+#define PMBSR_EL1_EC_MASK		GENMASK_ULL(31, 26)
 
-#define SYS_PMBSR_EL1_EC_BUF		(0x0UL << SYS_PMBSR_EL1_EC_SHIFT)
-#define SYS_PMBSR_EL1_EC_FAULT_S1	(0x24UL << SYS_PMBSR_EL1_EC_SHIFT)
-#define SYS_PMBSR_EL1_EC_FAULT_S2	(0x25UL << SYS_PMBSR_EL1_EC_SHIFT)
+#define PMBSR_EL1_EC_BUF		0x0UL
+#define PMBSR_EL1_EC_FAULT_S1		0x24UL
+#define PMBSR_EL1_EC_FAULT_S2		0x25UL
 
-#define SYS_PMBSR_EL1_FAULT_FSC_SHIFT	0
-#define SYS_PMBSR_EL1_FAULT_FSC_MASK	0x3fUL
+#define PMBSR_EL1_FAULT_FSC_SHIFT	0
+#define PMBSR_EL1_FAULT_FSC_MASK	0x3fUL
 
-#define SYS_PMBSR_EL1_BUF_BSC_SHIFT	0
-#define SYS_PMBSR_EL1_BUF_BSC_MASK	0x3fUL
+#define PMBSR_EL1_BUF_BSC_SHIFT		0
+#define PMBSR_EL1_BUF_BSC_MASK		0x3fUL
 
-#define SYS_PMBSR_EL1_BUF_BSC_FULL	(0x1UL << SYS_PMBSR_EL1_BUF_BSC_SHIFT)
+#define PMBSR_EL1_BUF_BSC_FULL		0x1UL
 
 /*** End of Statistical Profiling Extension ***/
 
diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
index fccf9ec01813..55f80fb93925 100644
--- a/arch/arm64/kvm/debug.c
+++ b/arch/arm64/kvm/debug.c
@@ -328,7 +328,7 @@ void kvm_arch_vcpu_load_debug_state_flags(struct kvm_vcpu *vcpu)
 	 * we may need to check if the host state needs to be saved.
 	 */
 	if (cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_PMSVer_SHIFT) &&
-	    !(read_sysreg_s(SYS_PMBIDR_EL1) & BIT(SYS_PMBIDR_EL1_P_SHIFT)))
+	    !(read_sysreg_s(SYS_PMBIDR_EL1) & BIT(PMBIDR_EL1_P_SHIFT)))
 		vcpu_set_flag(vcpu, DEBUG_STATE_SAVE_SPE);
 
 	/* Check if we have TRBE implemented and available at the host */
diff --git a/arch/arm64/kvm/hyp/nvhe/debug-sr.c b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
index e17455773b98..2673bde62fad 100644
--- a/arch/arm64/kvm/hyp/nvhe/debug-sr.c
+++ b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
@@ -27,7 +27,7 @@ static void __debug_save_spe(u64 *pmscr_el1)
 	 * Check if the host is actually using it ?
 	 */
 	reg = read_sysreg_s(SYS_PMBLIMITR_EL1);
-	if (!(reg & BIT(SYS_PMBLIMITR_EL1_E_SHIFT)))
+	if (!(reg & BIT(PMBLIMITR_EL1_E_SHIFT)))
 		return;
 
 	/* Yes; save the control register and disable data generation */
diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 65cf93dcc8ee..814ed18346b6 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -12,6 +12,7 @@
 #define DRVNAME					PMUNAME "_pmu"
 #define pr_fmt(fmt)				DRVNAME ": " fmt
 
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/bug.h>
 #include <linux/capability.h>
@@ -282,18 +283,18 @@ static u64 arm_spe_event_to_pmscr(struct perf_event *event)
 	struct perf_event_attr *attr = &event->attr;
 	u64 reg = 0;
 
-	reg |= ATTR_CFG_GET_FLD(attr, ts_enable) << SYS_PMSCR_EL1_TS_SHIFT;
-	reg |= ATTR_CFG_GET_FLD(attr, pa_enable) << SYS_PMSCR_EL1_PA_SHIFT;
-	reg |= ATTR_CFG_GET_FLD(attr, pct_enable) << SYS_PMSCR_EL1_PCT_SHIFT;
+	reg |= ATTR_CFG_GET_FLD(attr, ts_enable) << PMSCR_EL1_TS_SHIFT;
+	reg |= ATTR_CFG_GET_FLD(attr, pa_enable) << PMSCR_EL1_PA_SHIFT;
+	reg |= ATTR_CFG_GET_FLD(attr, pct_enable) << PMSCR_EL1_PCT_SHIFT;
 
 	if (!attr->exclude_user)
-		reg |= BIT(SYS_PMSCR_EL1_E0SPE_SHIFT);
+		reg |= BIT(PMSCR_EL1_E0SPE_SHIFT);
 
 	if (!attr->exclude_kernel)
-		reg |= BIT(SYS_PMSCR_EL1_E1SPE_SHIFT);
+		reg |= BIT(PMSCR_EL1_E1SPE_SHIFT);
 
 	if (get_spe_event_has_cx(event))
-		reg |= BIT(SYS_PMSCR_EL1_CX_SHIFT);
+		reg |= BIT(PMSCR_EL1_CX_SHIFT);
 
 	return reg;
 }
@@ -302,8 +303,7 @@ static void arm_spe_event_sanitise_period(struct perf_event *event)
 {
 	struct arm_spe_pmu *spe_pmu = to_spe_pmu(event->pmu);
 	u64 period = event->hw.sample_period;
-	u64 max_period = SYS_PMSIRR_EL1_INTERVAL_MASK
-			 << SYS_PMSIRR_EL1_INTERVAL_SHIFT;
+	u64 max_period = PMSIRR_EL1_INTERVAL_MASK;
 
 	if (period < spe_pmu->min_period)
 		period = spe_pmu->min_period;
@@ -322,7 +322,7 @@ static u64 arm_spe_event_to_pmsirr(struct perf_event *event)
 
 	arm_spe_event_sanitise_period(event);
 
-	reg |= ATTR_CFG_GET_FLD(attr, jitter) << SYS_PMSIRR_EL1_RND_SHIFT;
+	reg |= ATTR_CFG_GET_FLD(attr, jitter) << PMSIRR_EL1_RND_SHIFT;
 	reg |= event->hw.sample_period;
 
 	return reg;
@@ -333,18 +333,18 @@ static u64 arm_spe_event_to_pmsfcr(struct perf_event *event)
 	struct perf_event_attr *attr = &event->attr;
 	u64 reg = 0;
 
-	reg |= ATTR_CFG_GET_FLD(attr, load_filter) << SYS_PMSFCR_EL1_LD_SHIFT;
-	reg |= ATTR_CFG_GET_FLD(attr, store_filter) << SYS_PMSFCR_EL1_ST_SHIFT;
-	reg |= ATTR_CFG_GET_FLD(attr, branch_filter) << SYS_PMSFCR_EL1_B_SHIFT;
+	reg |= ATTR_CFG_GET_FLD(attr, load_filter) << PMSFCR_EL1_LD_SHIFT;
+	reg |= ATTR_CFG_GET_FLD(attr, store_filter) << PMSFCR_EL1_ST_SHIFT;
+	reg |= ATTR_CFG_GET_FLD(attr, branch_filter) << PMSFCR_EL1_B_SHIFT;
 
 	if (reg)
-		reg |= BIT(SYS_PMSFCR_EL1_FT_SHIFT);
+		reg |= BIT(PMSFCR_EL1_FT_SHIFT);
 
 	if (ATTR_CFG_GET_FLD(attr, event_filter))
-		reg |= BIT(SYS_PMSFCR_EL1_FE_SHIFT);
+		reg |= BIT(PMSFCR_EL1_FE_SHIFT);
 
 	if (ATTR_CFG_GET_FLD(attr, min_latency))
-		reg |= BIT(SYS_PMSFCR_EL1_FL_SHIFT);
+		reg |= BIT(PMSFCR_EL1_FL_SHIFT);
 
 	return reg;
 }
@@ -359,7 +359,7 @@ static u64 arm_spe_event_to_pmslatfr(struct perf_event *event)
 {
 	struct perf_event_attr *attr = &event->attr;
 	return ATTR_CFG_GET_FLD(attr, min_latency)
-	       << SYS_PMSLATFR_EL1_MINLAT_SHIFT;
+	       << PMSLATFR_EL1_MINLAT_SHIFT;
 }
 
 static void arm_spe_pmu_pad_buf(struct perf_output_handle *handle, int len)
@@ -511,7 +511,7 @@ static void arm_spe_perf_aux_output_begin(struct perf_output_handle *handle,
 	limit = buf->snapshot ? arm_spe_pmu_next_snapshot_off(handle)
 			      : arm_spe_pmu_next_off(handle);
 	if (limit)
-		limit |= BIT(SYS_PMBLIMITR_EL1_E_SHIFT);
+		limit |= BIT(PMBLIMITR_EL1_E_SHIFT);
 
 	limit += (u64)buf->base;
 	base = (u64)buf->base + PERF_IDX2OFF(handle->head, buf);
@@ -570,28 +570,28 @@ arm_spe_pmu_buf_get_fault_act(struct perf_output_handle *handle)
 
 	/* Service required? */
 	pmbsr = read_sysreg_s(SYS_PMBSR_EL1);
-	if (!(pmbsr & BIT(SYS_PMBSR_EL1_S_SHIFT)))
+	if (!(pmbsr & BIT(PMBSR_EL1_S_SHIFT)))
 		return SPE_PMU_BUF_FAULT_ACT_SPURIOUS;
 
 	/*
 	 * If we've lost data, disable profiling and also set the PARTIAL
 	 * flag to indicate that the last record is corrupted.
 	 */
-	if (pmbsr & BIT(SYS_PMBSR_EL1_DL_SHIFT))
+	if (pmbsr & BIT(PMBSR_EL1_DL_SHIFT))
 		perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED |
 					     PERF_AUX_FLAG_PARTIAL);
 
 	/* Report collisions to userspace so that it can up the period */
-	if (pmbsr & BIT(SYS_PMBSR_EL1_COLL_SHIFT))
+	if (pmbsr & BIT(PMBSR_EL1_COLL_SHIFT))
 		perf_aux_output_flag(handle, PERF_AUX_FLAG_COLLISION);
 
 	/* We only expect buffer management events */
-	switch (pmbsr & (SYS_PMBSR_EL1_EC_MASK << SYS_PMBSR_EL1_EC_SHIFT)) {
-	case SYS_PMBSR_EL1_EC_BUF:
+	switch (FIELD_GET(PMBSR_EL1_EC_MASK, pmbsr)) {
+	case PMBSR_EL1_EC_BUF:
 		/* Handled below */
 		break;
-	case SYS_PMBSR_EL1_EC_FAULT_S1:
-	case SYS_PMBSR_EL1_EC_FAULT_S2:
+	case PMBSR_EL1_EC_FAULT_S1:
+	case PMBSR_EL1_EC_FAULT_S2:
 		err_str = "Unexpected buffer fault";
 		goto out_err;
 	default:
@@ -600,9 +600,8 @@ arm_spe_pmu_buf_get_fault_act(struct perf_output_handle *handle)
 	}
 
 	/* Buffer management event */
-	switch (pmbsr &
-		(SYS_PMBSR_EL1_BUF_BSC_MASK << SYS_PMBSR_EL1_BUF_BSC_SHIFT)) {
-	case SYS_PMBSR_EL1_BUF_BSC_FULL:
+	switch (FIELD_GET(PMBSR_EL1_BUF_BSC_MASK, pmbsr)) {
+	case PMBSR_EL1_BUF_BSC_FULL:
 		ret = SPE_PMU_BUF_FAULT_ACT_OK;
 		goto out_stop;
 	default:
@@ -717,23 +716,23 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
 		return -EINVAL;
 
 	reg = arm_spe_event_to_pmsfcr(event);
-	if ((reg & BIT(SYS_PMSFCR_EL1_FE_SHIFT)) &&
+	if ((reg & BIT(PMSFCR_EL1_FE_SHIFT)) &&
 	    !(spe_pmu->features & SPE_PMU_FEAT_FILT_EVT))
 		return -EOPNOTSUPP;
 
-	if ((reg & BIT(SYS_PMSFCR_EL1_FT_SHIFT)) &&
+	if ((reg & BIT(PMSFCR_EL1_FT_SHIFT)) &&
 	    !(spe_pmu->features & SPE_PMU_FEAT_FILT_TYP))
 		return -EOPNOTSUPP;
 
-	if ((reg & BIT(SYS_PMSFCR_EL1_FL_SHIFT)) &&
+	if ((reg & BIT(PMSFCR_EL1_FL_SHIFT)) &&
 	    !(spe_pmu->features & SPE_PMU_FEAT_FILT_LAT))
 		return -EOPNOTSUPP;
 
 	set_spe_event_has_cx(event);
 	reg = arm_spe_event_to_pmscr(event);
 	if (!perfmon_capable() &&
-	    (reg & (BIT(SYS_PMSCR_EL1_PA_SHIFT) |
-		    BIT(SYS_PMSCR_EL1_PCT_SHIFT))))
+	    (reg & (BIT(PMSCR_EL1_PA_SHIFT) |
+		    BIT(PMSCR_EL1_PCT_SHIFT))))
 		return -EACCES;
 
 	return 0;
@@ -971,14 +970,14 @@ static void __arm_spe_pmu_dev_probe(void *info)
 
 	/* Read PMBIDR first to determine whether or not we have access */
 	reg = read_sysreg_s(SYS_PMBIDR_EL1);
-	if (reg & BIT(SYS_PMBIDR_EL1_P_SHIFT)) {
+	if (reg & BIT(PMBIDR_EL1_P_SHIFT)) {
 		dev_err(dev,
 			"profiling buffer owned by higher exception level\n");
 		return;
 	}
 
 	/* Minimum alignment. If it's out-of-range, then fail the probe */
-	fld = reg >> SYS_PMBIDR_EL1_ALIGN_SHIFT & SYS_PMBIDR_EL1_ALIGN_MASK;
+	fld = (reg & PMBIDR_EL1_ALIGN_MASK) >> PMBIDR_EL1_ALIGN_SHIFT;
 	spe_pmu->align = 1 << fld;
 	if (spe_pmu->align > SZ_2K) {
 		dev_err(dev, "unsupported PMBIDR.Align [%d] on CPU %d\n",
@@ -988,26 +987,26 @@ static void __arm_spe_pmu_dev_probe(void *info)
 
 	/* It's now safe to read PMSIDR and figure out what we've got */
 	reg = read_sysreg_s(SYS_PMSIDR_EL1);
-	if (reg & BIT(SYS_PMSIDR_EL1_FE_SHIFT))
+	if (reg & BIT(PMSIDR_EL1_FE_SHIFT))
 		spe_pmu->features |= SPE_PMU_FEAT_FILT_EVT;
 
-	if (reg & BIT(SYS_PMSIDR_EL1_FT_SHIFT))
+	if (reg & BIT(PMSIDR_EL1_FT_SHIFT))
 		spe_pmu->features |= SPE_PMU_FEAT_FILT_TYP;
 
-	if (reg & BIT(SYS_PMSIDR_EL1_FL_SHIFT))
+	if (reg & BIT(PMSIDR_EL1_FL_SHIFT))
 		spe_pmu->features |= SPE_PMU_FEAT_FILT_LAT;
 
-	if (reg & BIT(SYS_PMSIDR_EL1_ARCHINST_SHIFT))
+	if (reg & BIT(PMSIDR_EL1_ARCHINST_SHIFT))
 		spe_pmu->features |= SPE_PMU_FEAT_ARCH_INST;
 
-	if (reg & BIT(SYS_PMSIDR_EL1_LDS_SHIFT))
+	if (reg & BIT(PMSIDR_EL1_LDS_SHIFT))
 		spe_pmu->features |= SPE_PMU_FEAT_LDS;
 
-	if (reg & BIT(SYS_PMSIDR_EL1_ERND_SHIFT))
+	if (reg & BIT(PMSIDR_EL1_ERND_SHIFT))
 		spe_pmu->features |= SPE_PMU_FEAT_ERND;
 
 	/* This field has a spaced out encoding, so just use a look-up */
-	fld = reg >> SYS_PMSIDR_EL1_INTERVAL_SHIFT & SYS_PMSIDR_EL1_INTERVAL_MASK;
+	fld = (reg & PMSIDR_EL1_INTERVAL_MASK) >> PMSIDR_EL1_INTERVAL_SHIFT;
 	switch (fld) {
 	case 0:
 		spe_pmu->min_period = 256;
@@ -1039,7 +1038,7 @@ static void __arm_spe_pmu_dev_probe(void *info)
 	}
 
 	/* Maximum record size. If it's out-of-range, then fail the probe */
-	fld = reg >> SYS_PMSIDR_EL1_MAXSIZE_SHIFT & SYS_PMSIDR_EL1_MAXSIZE_MASK;
+	fld = (reg & PMSIDR_EL1_MAXSIZE_MASK) >> PMSIDR_EL1_MAXSIZE_SHIFT;
 	spe_pmu->max_record_sz = 1 << fld;
 	if (spe_pmu->max_record_sz > SZ_2K || spe_pmu->max_record_sz < 16) {
 		dev_err(dev, "unsupported PMSIDR_EL1.MaxSize [%d] on CPU %d\n",
@@ -1047,7 +1046,7 @@ static void __arm_spe_pmu_dev_probe(void *info)
 		return;
 	}
 
-	fld = reg >> SYS_PMSIDR_EL1_COUNTSIZE_SHIFT & SYS_PMSIDR_EL1_COUNTSIZE_MASK;
+	fld = (reg & PMSIDR_EL1_COUNTSIZE_MASK) >> PMSIDR_EL1_COUNTSIZE_SHIFT;
 	switch (fld) {
 	default:
 		dev_warn(dev, "unknown PMSIDR_EL1.CountSize [%d]; assuming 2\n",

-- 
b4 0.11.0-dev
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
