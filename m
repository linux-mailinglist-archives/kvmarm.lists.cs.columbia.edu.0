Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B94115751E3
	for <lists+kvmarm@lfdr.de>; Thu, 14 Jul 2022 17:35:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 34C824C5D5;
	Thu, 14 Jul 2022 11:35:27 -0400 (EDT)
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
	with ESMTP id uDzQHCVfbbK7; Thu, 14 Jul 2022 11:35:27 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 87DE24C43A;
	Thu, 14 Jul 2022 11:35:25 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B41644C5D2
 for <kvmarm@lists.cs.columbia.edu>; Thu, 14 Jul 2022 11:35:24 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tFkEAbsayUsM for <kvmarm@lists.cs.columbia.edu>;
 Thu, 14 Jul 2022 11:35:23 -0400 (EDT)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 55FD04C591
 for <kvmarm@lists.cs.columbia.edu>; Thu, 14 Jul 2022 11:35:22 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 4F343B823BA;
 Thu, 14 Jul 2022 15:35:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B940CC34115;
 Thu, 14 Jul 2022 15:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1657812919;
 bh=I7vfD8wxK0JCiEPt+EPnd2AEjS9dl4ZDbFvErXUGHZ4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GeM5tDkhDRt2gSD8KQY/7ESbeamnoGA+H5KKZW3x9fPONKNhoyhcWthgwdzC19zbw
 sLes19njBPZpQ22nv1qKSnYNq6o9uBkzbf8f0adXBJ/lp5N7Z+603llb2pvBBzro9A
 RUFnPGGfYf0OKNqFbDQkF15U+v08hInJER5Ftf+sr1eChYIkUKquRG1Ntf7nD570aQ
 ia+pLUt/6RT+RwCMedLFZtJVhfLea8y/VeLlcaNfROXkumTnAYA90uI8n6AOyXJCJx
 RWmaYbwBHlnjjJWhTOVzVUxrFQEEcFJlD9+sI2JGREcu1jsRPku69A5iMYxwCSVFx/
 sOD53kWahhQyQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <maz@kernel.org>) id 1oC0dj-007UVL-0y;
 Thu, 14 Jul 2022 16:20:31 +0100
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 10/20] KVM: arm64: vgic-v3: Convert userspace accessors
 over to FIELD_GET/FIELD_PREP
Date: Thu, 14 Jul 2022 16:20:14 +0100
Message-Id: <20220714152024.1673368-11-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220714152024.1673368-1-maz@kernel.org>
References: <20220714152024.1673368-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, james.morse@arm.com,
 suzuki.poulose@arm.com, alexandru.elisei@arm.com, oliver.upton@linux.dev,
 reijiw@google.com, schspa@gmail.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Schspa Shi <schspa@gmail.com>, kernel-team@android.com,
 Oliver Upton <oliver.upton@linux.dev>
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

The GICv3 userspace accessors are all about dealing with conversion
between fields from architectural registers and internal representations.

However, and owing to the age of this code, the accessors use
a combination of shift/mask that is hard to read. It is nonetheless
easy to make it better by using the FIELD_{GET,PREP} macros that solely
rely on a mask.

This results in somewhat nicer looking code, and is probably easier
to maintain.

Reviewed-by: Reiji Watanabe <reijiw@google.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kvm/vgic-sys-reg-v3.c | 60 ++++++++++++++------------------
 1 file changed, 27 insertions(+), 33 deletions(-)

diff --git a/arch/arm64/kvm/vgic-sys-reg-v3.c b/arch/arm64/kvm/vgic-sys-reg-v3.c
index b755b02bc8ba..9e7c486b48c2 100644
--- a/arch/arm64/kvm/vgic-sys-reg-v3.c
+++ b/arch/arm64/kvm/vgic-sys-reg-v3.c
@@ -23,30 +23,25 @@ static int set_gic_ctlr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
 	 * Disallow restoring VM state if not supported by this
 	 * hardware.
 	 */
-	host_pri_bits = ((val & ICC_CTLR_EL1_PRI_BITS_MASK) >>
-			 ICC_CTLR_EL1_PRI_BITS_SHIFT) + 1;
+	host_pri_bits = FIELD_GET(ICC_CTLR_EL1_PRI_BITS_MASK, val) + 1;
 	if (host_pri_bits > vgic_v3_cpu->num_pri_bits)
 		return -EINVAL;
 
 	vgic_v3_cpu->num_pri_bits = host_pri_bits;
 
-	host_id_bits = (val & ICC_CTLR_EL1_ID_BITS_MASK) >>
-		ICC_CTLR_EL1_ID_BITS_SHIFT;
+	host_id_bits = FIELD_GET(ICC_CTLR_EL1_ID_BITS_MASK, val);
 	if (host_id_bits > vgic_v3_cpu->num_id_bits)
 		return -EINVAL;
 
 	vgic_v3_cpu->num_id_bits = host_id_bits;
 
-	host_seis = ((kvm_vgic_global_state.ich_vtr_el2 &
-		      ICH_VTR_SEIS_MASK) >> ICH_VTR_SEIS_SHIFT);
-	seis = (val & ICC_CTLR_EL1_SEIS_MASK) >>
-		ICC_CTLR_EL1_SEIS_SHIFT;
+	host_seis = FIELD_GET(ICH_VTR_SEIS_MASK, kvm_vgic_global_state.ich_vtr_el2);
+	seis = FIELD_GET(ICC_CTLR_EL1_SEIS_MASK, val);
 	if (host_seis != seis)
 		return -EINVAL;
 
-	host_a3v = ((kvm_vgic_global_state.ich_vtr_el2 &
-		     ICH_VTR_A3V_MASK) >> ICH_VTR_A3V_SHIFT);
-	a3v = (val & ICC_CTLR_EL1_A3V_MASK) >> ICC_CTLR_EL1_A3V_SHIFT;
+	host_a3v = FIELD_GET(ICH_VTR_A3V_MASK, kvm_vgic_global_state.ich_vtr_el2);
+	a3v = FIELD_GET(ICC_CTLR_EL1_A3V_MASK, val);
 	if (host_a3v != a3v)
 		return -EINVAL;
 
@@ -54,8 +49,8 @@ static int set_gic_ctlr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
 	 * Here set VMCR.CTLR in ICC_CTLR_EL1 layout.
 	 * The vgic_set_vmcr() will convert to ICH_VMCR layout.
 	 */
-	vmcr.cbpr = (val & ICC_CTLR_EL1_CBPR_MASK) >> ICC_CTLR_EL1_CBPR_SHIFT;
-	vmcr.eoim = (val & ICC_CTLR_EL1_EOImode_MASK) >> ICC_CTLR_EL1_EOImode_SHIFT;
+	vmcr.cbpr = FIELD_GET(ICC_CTLR_EL1_CBPR_MASK, val);
+	vmcr.eoim = FIELD_GET(ICC_CTLR_EL1_EOImode_MASK, val);
 	vgic_set_vmcr(vcpu, &vmcr);
 
 	return 0;
@@ -70,20 +65,19 @@ static int get_gic_ctlr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
 
 	vgic_get_vmcr(vcpu, &vmcr);
 	val = 0;
-	val |= (vgic_v3_cpu->num_pri_bits - 1) << ICC_CTLR_EL1_PRI_BITS_SHIFT;
-	val |= vgic_v3_cpu->num_id_bits << ICC_CTLR_EL1_ID_BITS_SHIFT;
-	val |= ((kvm_vgic_global_state.ich_vtr_el2 &
-		 ICH_VTR_SEIS_MASK) >> ICH_VTR_SEIS_SHIFT) <<
-		ICC_CTLR_EL1_SEIS_SHIFT;
-	val |= ((kvm_vgic_global_state.ich_vtr_el2 &
-		 ICH_VTR_A3V_MASK) >> ICH_VTR_A3V_SHIFT) <<
-		ICC_CTLR_EL1_A3V_SHIFT;
+	val |= FIELD_PREP(ICC_CTLR_EL1_PRI_BITS_MASK, vgic_v3_cpu->num_pri_bits - 1);
+	val |= FIELD_PREP(ICC_CTLR_EL1_ID_BITS_MASK, vgic_v3_cpu->num_id_bits);
+	val |= FIELD_PREP(ICC_CTLR_EL1_SEIS_MASK,
+			  FIELD_GET(ICH_VTR_SEIS_MASK,
+				    kvm_vgic_global_state.ich_vtr_el2));
+	val |= FIELD_PREP(ICC_CTLR_EL1_A3V_MASK,
+			  FIELD_GET(ICH_VTR_A3V_MASK, kvm_vgic_global_state.ich_vtr_el2));
 	/*
 	 * The VMCR.CTLR value is in ICC_CTLR_EL1 layout.
 	 * Extract it directly using ICC_CTLR_EL1 reg definitions.
 	 */
-	val |= (vmcr.cbpr << ICC_CTLR_EL1_CBPR_SHIFT) & ICC_CTLR_EL1_CBPR_MASK;
-	val |= (vmcr.eoim << ICC_CTLR_EL1_EOImode_SHIFT) & ICC_CTLR_EL1_EOImode_MASK;
+	val |= FIELD_PREP(ICC_CTLR_EL1_CBPR_MASK, vmcr.cbpr);
+	val |= FIELD_PREP(ICC_CTLR_EL1_EOImode_MASK, vmcr.eoim);
 
 	*valp = val;
 
@@ -96,7 +90,7 @@ static int set_gic_pmr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
 	struct vgic_vmcr vmcr;
 
 	vgic_get_vmcr(vcpu, &vmcr);
-	vmcr.pmr = (val & ICC_PMR_EL1_MASK) >> ICC_PMR_EL1_SHIFT;
+	vmcr.pmr = FIELD_GET(ICC_PMR_EL1_MASK, val);
 	vgic_set_vmcr(vcpu, &vmcr);
 
 	return 0;
@@ -108,7 +102,7 @@ static int get_gic_pmr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
 	struct vgic_vmcr vmcr;
 
 	vgic_get_vmcr(vcpu, &vmcr);
-	*val = (vmcr.pmr << ICC_PMR_EL1_SHIFT) & ICC_PMR_EL1_MASK;
+	*val = FIELD_PREP(ICC_PMR_EL1_MASK, vmcr.pmr);
 
 	return 0;
 }
@@ -119,7 +113,7 @@ static int set_gic_bpr0(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
 	struct vgic_vmcr vmcr;
 
 	vgic_get_vmcr(vcpu, &vmcr);
-	vmcr.bpr = (val & ICC_BPR0_EL1_MASK) >> ICC_BPR0_EL1_SHIFT;
+	vmcr.bpr = FIELD_GET(ICC_BPR0_EL1_MASK, val);
 	vgic_set_vmcr(vcpu, &vmcr);
 
 	return 0;
@@ -131,7 +125,7 @@ static int get_gic_bpr0(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
 	struct vgic_vmcr vmcr;
 
 	vgic_get_vmcr(vcpu, &vmcr);
-	*val = (vmcr.bpr << ICC_BPR0_EL1_SHIFT) & ICC_BPR0_EL1_MASK;
+	*val = FIELD_PREP(ICC_BPR0_EL1_MASK, vmcr.bpr);
 
 	return 0;
 }
@@ -143,7 +137,7 @@ static int set_gic_bpr1(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
 
 	vgic_get_vmcr(vcpu, &vmcr);
 	if (!vmcr.cbpr) {
-		vmcr.abpr = (val & ICC_BPR1_EL1_MASK) >> ICC_BPR1_EL1_SHIFT;
+		vmcr.abpr = FIELD_GET(ICC_BPR1_EL1_MASK, val);
 		vgic_set_vmcr(vcpu, &vmcr);
 	}
 
@@ -157,7 +151,7 @@ static int get_gic_bpr1(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
 
 	vgic_get_vmcr(vcpu, &vmcr);
 	if (!vmcr.cbpr)
-		*val = (vmcr.abpr << ICC_BPR1_EL1_SHIFT) & ICC_BPR1_EL1_MASK;
+		*val = FIELD_PREP(ICC_BPR1_EL1_MASK, vmcr.abpr);
 	else
 		*val = min((vmcr.bpr + 1), 7U);
 
@@ -171,7 +165,7 @@ static int set_gic_grpen0(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
 	struct vgic_vmcr vmcr;
 
 	vgic_get_vmcr(vcpu, &vmcr);
-	vmcr.grpen0 = (val & ICC_IGRPEN0_EL1_MASK) >> ICC_IGRPEN0_EL1_SHIFT;
+	vmcr.grpen0 = FIELD_GET(ICC_IGRPEN0_EL1_MASK, val);
 	vgic_set_vmcr(vcpu, &vmcr);
 
 	return 0;
@@ -183,7 +177,7 @@ static int get_gic_grpen0(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
 	struct vgic_vmcr vmcr;
 
 	vgic_get_vmcr(vcpu, &vmcr);
-	*val = (vmcr.grpen0 << ICC_IGRPEN0_EL1_SHIFT) & ICC_IGRPEN0_EL1_MASK;
+	*val = FIELD_PREP(ICC_IGRPEN0_EL1_MASK, vmcr.grpen0);
 
 	return 0;
 }
@@ -194,7 +188,7 @@ static int set_gic_grpen1(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
 	struct vgic_vmcr vmcr;
 
 	vgic_get_vmcr(vcpu, &vmcr);
-	vmcr.grpen1 = (val & ICC_IGRPEN1_EL1_MASK) >> ICC_IGRPEN1_EL1_SHIFT;
+	vmcr.grpen1 = FIELD_GET(ICC_IGRPEN1_EL1_MASK, val);
 	vgic_set_vmcr(vcpu, &vmcr);
 
 	return 0;
@@ -206,7 +200,7 @@ static int get_gic_grpen1(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
 	struct vgic_vmcr vmcr;
 
 	vgic_get_vmcr(vcpu, &vmcr);
-	*val = (vmcr.grpen1 << ICC_IGRPEN1_EL1_SHIFT) & ICC_IGRPEN1_EL1_MASK;
+	*val = FIELD_GET(ICC_IGRPEN1_EL1_MASK, vmcr.grpen1);
 
 	return 0;
 }
-- 
2.34.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
