Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 88C222E9656
	for <lists+kvmarm@lfdr.de>; Mon,  4 Jan 2021 14:50:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3D9C94B2D4;
	Mon,  4 Jan 2021 08:50:51 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ow8+xRJpRxX2; Mon,  4 Jan 2021 08:50:51 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 517814B282;
	Mon,  4 Jan 2021 08:50:48 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 05ED54B277
 for <kvmarm@lists.cs.columbia.edu>; Mon,  4 Jan 2021 08:50:47 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5wfwKccv5-aT for <kvmarm@lists.cs.columbia.edu>;
 Mon,  4 Jan 2021 08:50:46 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 4E38C4B235
 for <kvmarm@lists.cs.columbia.edu>; Mon,  4 Jan 2021 08:50:44 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8898421BE5;
 Mon,  4 Jan 2021 13:50:43 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1kwQFt-005E24-RI; Mon, 04 Jan 2021 13:50:41 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.cs.columbia.edu
Subject: [PATCH v2 06/17] arm64: Move VHE-specific SPE setup to mutate_to_vhe()
Date: Mon,  4 Jan 2021 13:50:00 +0000
Message-Id: <20210104135011.2063104-7-maz@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210104135011.2063104-1-maz@kernel.org>
References: <20210104135011.2063104-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, catalin.marinas@arm.com, will@kernel.org,
 mark.rutland@arm.com, dbrazdil@google.com, alexandru.elisei@arm.com,
 ardb@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com,
 suzuki.poulose@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>
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

There isn't much that a VHE kernel needs on top of whatever has
been done for nVHE, so let's move the little we need to the
VHE stub (the SPE setup), and drop the init_el2_state macro.

No expected functional change.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kernel/hyp-stub.S | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
index b727848bd0ec..232aab84b3cd 100644
--- a/arch/arm64/kernel/hyp-stub.S
+++ b/arch/arm64/kernel/hyp-stub.S
@@ -92,9 +92,6 @@ SYM_CODE_START_LOCAL(mutate_to_vhe)
 	msr	hcr_el2, x0
 	isb
 
-	// Doesn't do much on VHE, but still, worth a shot
-	init_el2_state vhe
-
 	// Use the EL1 allocated stack, per-cpu offset
 	mrs	x0, sp_el1
 	mov	sp, x0
@@ -107,6 +104,31 @@ SYM_CODE_START_LOCAL(mutate_to_vhe)
 	mrs_s	x0, SYS_VBAR_EL12
 	msr	vbar_el1, x0
 
+	// Fixup SPE configuration, if supported...
+	mrs	x1, id_aa64dfr0_el1
+	ubfx	x1, x1, #ID_AA64DFR0_PMSVER_SHIFT, #4
+	mov	x2, xzr
+	cbz	x1, skip_spe
+
+	// ... and not owned by EL3
+	mrs_s	x0, SYS_PMBIDR_EL1
+	and	x0, x0, #(1 << SYS_PMBIDR_EL1_P_SHIFT)
+	cbnz	x0, skip_spe
+
+	// Let the SPE driver in control of the sampling
+	mrs_s	x0, SYS_PMSCR_EL1
+	bic	x0, x0, #(1 << SYS_PMSCR_EL2_PCT_SHIFT)
+	bic	x0, x0, #(1 << SYS_PMSCR_EL2_PA_SHIFT)
+	msr_s	SYS_PMSCR_EL1, x0
+	mov	x2, #MDCR_EL2_TPMS
+
+skip_spe:
+	// For VHE, use EL2 translation and disable access from EL1
+	mrs	x0, mdcr_el2
+	bic	x0, x0, #(MDCR_EL2_E2PB_MASK << MDCR_EL2_E2PB_SHIFT)
+	orr	x0, x0, x2
+	msr	mdcr_el2, x0
+
 	// Transfert the MM state from EL1 to EL2
 	mrs_s	x0, SYS_TCR_EL12
 	msr	tcr_el1, x0
-- 
2.29.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
