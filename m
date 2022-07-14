Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0556B5751A5
	for <lists+kvmarm@lfdr.de>; Thu, 14 Jul 2022 17:20:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A54FF4C5B9;
	Thu, 14 Jul 2022 11:20:44 -0400 (EDT)
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
	with ESMTP id 1XTj9F21ONho; Thu, 14 Jul 2022 11:20:44 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 213CB4C5A4;
	Thu, 14 Jul 2022 11:20:39 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CB8814C5DE
 for <kvmarm@lists.cs.columbia.edu>; Thu, 14 Jul 2022 11:20:35 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bv51bJl+lRoK for <kvmarm@lists.cs.columbia.edu>;
 Thu, 14 Jul 2022 11:20:34 -0400 (EDT)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id E595F4C50B
 for <kvmarm@lists.cs.columbia.edu>; Thu, 14 Jul 2022 11:20:33 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5AA0861F03;
 Thu, 14 Jul 2022 15:20:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7DC4C34115;
 Thu, 14 Jul 2022 15:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1657812033;
 bh=ggmdSPQQeOCOGQkP4N4kZuahykMtCroNXykL5KKSOUk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=sC8vk0A01pkUyEp85yYakCyYq9Rsjc3qlS+BEznOM4/IgdLay07yvyi1mx7B8O6HM
 8nToLOmaQt763276Dg30z4Cp5mwfY1/A1QXF9IwAbJBFTKZtOsJRq91ZFHK3XQvWCr
 iLHm7v5GYNDCvGf+mLh4EpG93vmMlv1PnJZdj/kEGIe/2iTWXnloTcBHqWBPM9CRGD
 z8ljot8PG9yh7HvLf7Jls0nHjav9gpUmasXzVNvolVHQKSV4t5NNeN8XvZOUwMc+d3
 EUE2oQ7MjJr9YK/20HaaXzTq2cWlNnjDPqma8zKOEHzSFrdbQ3HEZ8SZtM/K4OH/2r
 Wry/c0gcgFrgg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <maz@kernel.org>) id 1oC0dh-007UVL-Ku;
 Thu, 14 Jul 2022 16:20:29 +0100
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 09/20] KVM: arm64: vgic-v3: Make the userspace accessors
 use sysreg API
Date: Thu, 14 Jul 2022 16:20:13 +0100
Message-Id: <20220714152024.1673368-10-maz@kernel.org>
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

The vgic-v3 sysreg accessors have been ignored as the rest of the
sysreg internal API was evolving, and are stuck with the .access
method (which is normally reserved to the guest's own access)
for the userspace accesses (which should use the .set/.get_user()
methods).

Catch up with the program and repaint all the accessors so that
they fit into the normal userspace model, and plug the result into
the helpers that have been introduced earlier.

Reviewed-by: Reiji Watanabe <reijiw@google.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kvm/vgic-sys-reg-v3.c | 454 +++++++++++++++++--------------
 1 file changed, 257 insertions(+), 197 deletions(-)

diff --git a/arch/arm64/kvm/vgic-sys-reg-v3.c b/arch/arm64/kvm/vgic-sys-reg-v3.c
index 88eb5b049c2c..b755b02bc8ba 100644
--- a/arch/arm64/kvm/vgic-sys-reg-v3.c
+++ b/arch/arm64/kvm/vgic-sys-reg-v3.c
@@ -10,254 +10,330 @@
 #include "vgic/vgic.h"
 #include "sys_regs.h"
 
-static bool access_gic_ctlr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
-			    const struct sys_reg_desc *r)
+static int set_gic_ctlr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
+			u64 val)
 {
 	u32 host_pri_bits, host_id_bits, host_seis, host_a3v, seis, a3v;
 	struct vgic_cpu *vgic_v3_cpu = &vcpu->arch.vgic_cpu;
 	struct vgic_vmcr vmcr;
+
+	vgic_get_vmcr(vcpu, &vmcr);
+
+	/*
+	 * Disallow restoring VM state if not supported by this
+	 * hardware.
+	 */
+	host_pri_bits = ((val & ICC_CTLR_EL1_PRI_BITS_MASK) >>
+			 ICC_CTLR_EL1_PRI_BITS_SHIFT) + 1;
+	if (host_pri_bits > vgic_v3_cpu->num_pri_bits)
+		return -EINVAL;
+
+	vgic_v3_cpu->num_pri_bits = host_pri_bits;
+
+	host_id_bits = (val & ICC_CTLR_EL1_ID_BITS_MASK) >>
+		ICC_CTLR_EL1_ID_BITS_SHIFT;
+	if (host_id_bits > vgic_v3_cpu->num_id_bits)
+		return -EINVAL;
+
+	vgic_v3_cpu->num_id_bits = host_id_bits;
+
+	host_seis = ((kvm_vgic_global_state.ich_vtr_el2 &
+		      ICH_VTR_SEIS_MASK) >> ICH_VTR_SEIS_SHIFT);
+	seis = (val & ICC_CTLR_EL1_SEIS_MASK) >>
+		ICC_CTLR_EL1_SEIS_SHIFT;
+	if (host_seis != seis)
+		return -EINVAL;
+
+	host_a3v = ((kvm_vgic_global_state.ich_vtr_el2 &
+		     ICH_VTR_A3V_MASK) >> ICH_VTR_A3V_SHIFT);
+	a3v = (val & ICC_CTLR_EL1_A3V_MASK) >> ICC_CTLR_EL1_A3V_SHIFT;
+	if (host_a3v != a3v)
+		return -EINVAL;
+
+	/*
+	 * Here set VMCR.CTLR in ICC_CTLR_EL1 layout.
+	 * The vgic_set_vmcr() will convert to ICH_VMCR layout.
+	 */
+	vmcr.cbpr = (val & ICC_CTLR_EL1_CBPR_MASK) >> ICC_CTLR_EL1_CBPR_SHIFT;
+	vmcr.eoim = (val & ICC_CTLR_EL1_EOImode_MASK) >> ICC_CTLR_EL1_EOImode_SHIFT;
+	vgic_set_vmcr(vcpu, &vmcr);
+
+	return 0;
+}
+
+static int get_gic_ctlr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
+			u64 *valp)
+{
+	struct vgic_cpu *vgic_v3_cpu = &vcpu->arch.vgic_cpu;
+	struct vgic_vmcr vmcr;
 	u64 val;
 
 	vgic_get_vmcr(vcpu, &vmcr);
-	if (p->is_write) {
-		val = p->regval;
-
-		/*
-		 * Disallow restoring VM state if not supported by this
-		 * hardware.
-		 */
-		host_pri_bits = ((val & ICC_CTLR_EL1_PRI_BITS_MASK) >>
-				 ICC_CTLR_EL1_PRI_BITS_SHIFT) + 1;
-		if (host_pri_bits > vgic_v3_cpu->num_pri_bits)
-			return false;
-
-		vgic_v3_cpu->num_pri_bits = host_pri_bits;
-
-		host_id_bits = (val & ICC_CTLR_EL1_ID_BITS_MASK) >>
-				ICC_CTLR_EL1_ID_BITS_SHIFT;
-		if (host_id_bits > vgic_v3_cpu->num_id_bits)
-			return false;
-
-		vgic_v3_cpu->num_id_bits = host_id_bits;
-
-		host_seis = ((kvm_vgic_global_state.ich_vtr_el2 &
-			     ICH_VTR_SEIS_MASK) >> ICH_VTR_SEIS_SHIFT);
-		seis = (val & ICC_CTLR_EL1_SEIS_MASK) >>
-			ICC_CTLR_EL1_SEIS_SHIFT;
-		if (host_seis != seis)
-			return false;
-
-		host_a3v = ((kvm_vgic_global_state.ich_vtr_el2 &
-			    ICH_VTR_A3V_MASK) >> ICH_VTR_A3V_SHIFT);
-		a3v = (val & ICC_CTLR_EL1_A3V_MASK) >> ICC_CTLR_EL1_A3V_SHIFT;
-		if (host_a3v != a3v)
-			return false;
-
-		/*
-		 * Here set VMCR.CTLR in ICC_CTLR_EL1 layout.
-		 * The vgic_set_vmcr() will convert to ICH_VMCR layout.
-		 */
-		vmcr.cbpr = (val & ICC_CTLR_EL1_CBPR_MASK) >> ICC_CTLR_EL1_CBPR_SHIFT;
-		vmcr.eoim = (val & ICC_CTLR_EL1_EOImode_MASK) >> ICC_CTLR_EL1_EOImode_SHIFT;
-		vgic_set_vmcr(vcpu, &vmcr);
-	} else {
-		val = 0;
-		val |= (vgic_v3_cpu->num_pri_bits - 1) <<
-			ICC_CTLR_EL1_PRI_BITS_SHIFT;
-		val |= vgic_v3_cpu->num_id_bits << ICC_CTLR_EL1_ID_BITS_SHIFT;
-		val |= ((kvm_vgic_global_state.ich_vtr_el2 &
-			ICH_VTR_SEIS_MASK) >> ICH_VTR_SEIS_SHIFT) <<
-			ICC_CTLR_EL1_SEIS_SHIFT;
-		val |= ((kvm_vgic_global_state.ich_vtr_el2 &
-			ICH_VTR_A3V_MASK) >> ICH_VTR_A3V_SHIFT) <<
-			ICC_CTLR_EL1_A3V_SHIFT;
-		/*
-		 * The VMCR.CTLR value is in ICC_CTLR_EL1 layout.
-		 * Extract it directly using ICC_CTLR_EL1 reg definitions.
-		 */
-		val |= (vmcr.cbpr << ICC_CTLR_EL1_CBPR_SHIFT) & ICC_CTLR_EL1_CBPR_MASK;
-		val |= (vmcr.eoim << ICC_CTLR_EL1_EOImode_SHIFT) & ICC_CTLR_EL1_EOImode_MASK;
-
-		p->regval = val;
-	}
+	val = 0;
+	val |= (vgic_v3_cpu->num_pri_bits - 1) << ICC_CTLR_EL1_PRI_BITS_SHIFT;
+	val |= vgic_v3_cpu->num_id_bits << ICC_CTLR_EL1_ID_BITS_SHIFT;
+	val |= ((kvm_vgic_global_state.ich_vtr_el2 &
+		 ICH_VTR_SEIS_MASK) >> ICH_VTR_SEIS_SHIFT) <<
+		ICC_CTLR_EL1_SEIS_SHIFT;
+	val |= ((kvm_vgic_global_state.ich_vtr_el2 &
+		 ICH_VTR_A3V_MASK) >> ICH_VTR_A3V_SHIFT) <<
+		ICC_CTLR_EL1_A3V_SHIFT;
+	/*
+	 * The VMCR.CTLR value is in ICC_CTLR_EL1 layout.
+	 * Extract it directly using ICC_CTLR_EL1 reg definitions.
+	 */
+	val |= (vmcr.cbpr << ICC_CTLR_EL1_CBPR_SHIFT) & ICC_CTLR_EL1_CBPR_MASK;
+	val |= (vmcr.eoim << ICC_CTLR_EL1_EOImode_SHIFT) & ICC_CTLR_EL1_EOImode_MASK;
+
+	*valp = val;
 
-	return true;
+	return 0;
 }
 
-static bool access_gic_pmr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
-			   const struct sys_reg_desc *r)
+static int set_gic_pmr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
+		       u64 val)
 {
 	struct vgic_vmcr vmcr;
 
 	vgic_get_vmcr(vcpu, &vmcr);
-	if (p->is_write) {
-		vmcr.pmr = (p->regval & ICC_PMR_EL1_MASK) >> ICC_PMR_EL1_SHIFT;
-		vgic_set_vmcr(vcpu, &vmcr);
-	} else {
-		p->regval = (vmcr.pmr << ICC_PMR_EL1_SHIFT) & ICC_PMR_EL1_MASK;
-	}
+	vmcr.pmr = (val & ICC_PMR_EL1_MASK) >> ICC_PMR_EL1_SHIFT;
+	vgic_set_vmcr(vcpu, &vmcr);
 
-	return true;
+	return 0;
 }
 
-static bool access_gic_bpr0(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
-			    const struct sys_reg_desc *r)
+static int get_gic_pmr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
+		       u64 *val)
 {
 	struct vgic_vmcr vmcr;
 
 	vgic_get_vmcr(vcpu, &vmcr);
-	if (p->is_write) {
-		vmcr.bpr = (p->regval & ICC_BPR0_EL1_MASK) >>
-			    ICC_BPR0_EL1_SHIFT;
-		vgic_set_vmcr(vcpu, &vmcr);
-	} else {
-		p->regval = (vmcr.bpr << ICC_BPR0_EL1_SHIFT) &
-			     ICC_BPR0_EL1_MASK;
-	}
+	*val = (vmcr.pmr << ICC_PMR_EL1_SHIFT) & ICC_PMR_EL1_MASK;
 
-	return true;
+	return 0;
 }
 
-static bool access_gic_bpr1(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
-			    const struct sys_reg_desc *r)
+static int set_gic_bpr0(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
+			u64 val)
 {
 	struct vgic_vmcr vmcr;
 
-	if (!p->is_write)
-		p->regval = 0;
+	vgic_get_vmcr(vcpu, &vmcr);
+	vmcr.bpr = (val & ICC_BPR0_EL1_MASK) >> ICC_BPR0_EL1_SHIFT;
+	vgic_set_vmcr(vcpu, &vmcr);
+
+	return 0;
+}
+
+static int get_gic_bpr0(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
+			u64 *val)
+{
+	struct vgic_vmcr vmcr;
 
 	vgic_get_vmcr(vcpu, &vmcr);
-	if (!vmcr.cbpr) {
-		if (p->is_write) {
-			vmcr.abpr = (p->regval & ICC_BPR1_EL1_MASK) >>
-				     ICC_BPR1_EL1_SHIFT;
-			vgic_set_vmcr(vcpu, &vmcr);
-		} else {
-			p->regval = (vmcr.abpr << ICC_BPR1_EL1_SHIFT) &
-				     ICC_BPR1_EL1_MASK;
-		}
-	} else {
-		if (!p->is_write)
-			p->regval = min((vmcr.bpr + 1), 7U);
-	}
+	*val = (vmcr.bpr << ICC_BPR0_EL1_SHIFT) & ICC_BPR0_EL1_MASK;
 
-	return true;
+	return 0;
 }
 
-static bool access_gic_grpen0(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
-			      const struct sys_reg_desc *r)
+static int set_gic_bpr1(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
+			u64 val)
 {
 	struct vgic_vmcr vmcr;
 
 	vgic_get_vmcr(vcpu, &vmcr);
-	if (p->is_write) {
-		vmcr.grpen0 = (p->regval & ICC_IGRPEN0_EL1_MASK) >>
-			       ICC_IGRPEN0_EL1_SHIFT;
+	if (!vmcr.cbpr) {
+		vmcr.abpr = (val & ICC_BPR1_EL1_MASK) >> ICC_BPR1_EL1_SHIFT;
 		vgic_set_vmcr(vcpu, &vmcr);
-	} else {
-		p->regval = (vmcr.grpen0 << ICC_IGRPEN0_EL1_SHIFT) &
-			     ICC_IGRPEN0_EL1_MASK;
 	}
 
-	return true;
+	return 0;
 }
 
-static bool access_gic_grpen1(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
-			      const struct sys_reg_desc *r)
+static int get_gic_bpr1(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
+			u64 *val)
 {
 	struct vgic_vmcr vmcr;
 
 	vgic_get_vmcr(vcpu, &vmcr);
-	if (p->is_write) {
-		vmcr.grpen1 = (p->regval & ICC_IGRPEN1_EL1_MASK) >>
-			       ICC_IGRPEN1_EL1_SHIFT;
-		vgic_set_vmcr(vcpu, &vmcr);
-	} else {
-		p->regval = (vmcr.grpen1 << ICC_IGRPEN1_EL1_SHIFT) &
-			     ICC_IGRPEN1_EL1_MASK;
-	}
+	if (!vmcr.cbpr)
+		*val = (vmcr.abpr << ICC_BPR1_EL1_SHIFT) & ICC_BPR1_EL1_MASK;
+	else
+		*val = min((vmcr.bpr + 1), 7U);
+
+
+	return 0;
+}
+
+static int set_gic_grpen0(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
+			  u64 val)
+{
+	struct vgic_vmcr vmcr;
+
+	vgic_get_vmcr(vcpu, &vmcr);
+	vmcr.grpen0 = (val & ICC_IGRPEN0_EL1_MASK) >> ICC_IGRPEN0_EL1_SHIFT;
+	vgic_set_vmcr(vcpu, &vmcr);
+
+	return 0;
+}
+
+static int get_gic_grpen0(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
+			  u64 *val)
+{
+	struct vgic_vmcr vmcr;
+
+	vgic_get_vmcr(vcpu, &vmcr);
+	*val = (vmcr.grpen0 << ICC_IGRPEN0_EL1_SHIFT) & ICC_IGRPEN0_EL1_MASK;
+
+	return 0;
+}
+
+static int set_gic_grpen1(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
+			  u64 val)
+{
+	struct vgic_vmcr vmcr;
 
-	return true;
+	vgic_get_vmcr(vcpu, &vmcr);
+	vmcr.grpen1 = (val & ICC_IGRPEN1_EL1_MASK) >> ICC_IGRPEN1_EL1_SHIFT;
+	vgic_set_vmcr(vcpu, &vmcr);
+
+	return 0;
 }
 
-static void vgic_v3_access_apr_reg(struct kvm_vcpu *vcpu,
-				   struct sys_reg_params *p, u8 apr, u8 idx)
+static int get_gic_grpen1(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
+			  u64 *val)
+{
+	struct vgic_vmcr vmcr;
+
+	vgic_get_vmcr(vcpu, &vmcr);
+	*val = (vmcr.grpen1 << ICC_IGRPEN1_EL1_SHIFT) & ICC_IGRPEN1_EL1_MASK;
+
+	return 0;
+}
+
+static void set_apr_reg(struct kvm_vcpu *vcpu, u64 val, u8 apr, u8 idx)
 {
 	struct vgic_v3_cpu_if *vgicv3 = &vcpu->arch.vgic_cpu.vgic_v3;
-	uint32_t *ap_reg;
 
 	if (apr)
-		ap_reg = &vgicv3->vgic_ap1r[idx];
+		vgicv3->vgic_ap1r[idx] = val;
 	else
-		ap_reg = &vgicv3->vgic_ap0r[idx];
+		vgicv3->vgic_ap0r[idx] = val;
+}
+
+static u64 get_apr_reg(struct kvm_vcpu *vcpu, u8 apr, u8 idx)
+{
+	struct vgic_v3_cpu_if *vgicv3 = &vcpu->arch.vgic_cpu.vgic_v3;
 
-	if (p->is_write)
-		*ap_reg = p->regval;
+	if (apr)
+		return vgicv3->vgic_ap1r[idx];
 	else
-		p->regval = *ap_reg;
+		return vgicv3->vgic_ap0r[idx];
+}
+
+static int set_gic_ap0r(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
+			u64 val)
+
+{
+	u8 idx = r->Op2 & 3;
+
+	if (idx > vgic_v3_max_apr_idx(vcpu))
+		return -EINVAL;
+
+	set_apr_reg(vcpu, val, 0, idx);
+	return 0;
 }
 
-static bool access_gic_aprn(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
-			    const struct sys_reg_desc *r, u8 apr)
+static int get_gic_ap0r(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
+			u64 *val)
 {
 	u8 idx = r->Op2 & 3;
 
 	if (idx > vgic_v3_max_apr_idx(vcpu))
-		goto err;
+		return -EINVAL;
 
-	vgic_v3_access_apr_reg(vcpu, p, apr, idx);
-	return true;
-err:
-	if (!p->is_write)
-		p->regval = 0;
+	*val = get_apr_reg(vcpu, 0, idx);
 
-	return false;
+	return 0;
 }
 
-static bool access_gic_ap0r(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
-			    const struct sys_reg_desc *r)
+static int set_gic_ap1r(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
+			u64 val)
 
 {
-	return access_gic_aprn(vcpu, p, r, 0);
+	u8 idx = r->Op2 & 3;
+
+	if (idx > vgic_v3_max_apr_idx(vcpu))
+		return -EINVAL;
+
+	set_apr_reg(vcpu, val, 1, idx);
+	return 0;
+}
+
+static int get_gic_ap1r(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
+			u64 *val)
+{
+	u8 idx = r->Op2 & 3;
+
+	if (idx > vgic_v3_max_apr_idx(vcpu))
+		return -EINVAL;
+
+	*val = get_apr_reg(vcpu, 1, idx);
+
+	return 0;
 }
 
-static bool access_gic_ap1r(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
-			    const struct sys_reg_desc *r)
+static int set_gic_sre(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
+		       u64 val)
 {
-	return access_gic_aprn(vcpu, p, r, 1);
+	/* Validate SRE bit */
+	if (!(val & ICC_SRE_EL1_SRE))
+		return -EINVAL;
+
+	return 0;
 }
 
-static bool access_gic_sre(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
-			   const struct sys_reg_desc *r)
+static int get_gic_sre(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
+		       u64 *val)
 {
 	struct vgic_v3_cpu_if *vgicv3 = &vcpu->arch.vgic_cpu.vgic_v3;
 
-	/* Validate SRE bit */
-	if (p->is_write) {
-		if (!(p->regval & ICC_SRE_EL1_SRE))
-			return false;
-	} else {
-		p->regval = vgicv3->vgic_sre;
-	}
+	*val = vgicv3->vgic_sre;
 
-	return true;
+	return 0;
 }
+
 static const struct sys_reg_desc gic_v3_icc_reg_descs[] = {
-	{ SYS_DESC(SYS_ICC_PMR_EL1), access_gic_pmr },
-	{ SYS_DESC(SYS_ICC_BPR0_EL1), access_gic_bpr0 },
-	{ SYS_DESC(SYS_ICC_AP0R0_EL1), access_gic_ap0r },
-	{ SYS_DESC(SYS_ICC_AP0R1_EL1), access_gic_ap0r },
-	{ SYS_DESC(SYS_ICC_AP0R2_EL1), access_gic_ap0r },
-	{ SYS_DESC(SYS_ICC_AP0R3_EL1), access_gic_ap0r },
-	{ SYS_DESC(SYS_ICC_AP1R0_EL1), access_gic_ap1r },
-	{ SYS_DESC(SYS_ICC_AP1R1_EL1), access_gic_ap1r },
-	{ SYS_DESC(SYS_ICC_AP1R2_EL1), access_gic_ap1r },
-	{ SYS_DESC(SYS_ICC_AP1R3_EL1), access_gic_ap1r },
-	{ SYS_DESC(SYS_ICC_BPR1_EL1), access_gic_bpr1 },
-	{ SYS_DESC(SYS_ICC_CTLR_EL1), access_gic_ctlr },
-	{ SYS_DESC(SYS_ICC_SRE_EL1), access_gic_sre },
-	{ SYS_DESC(SYS_ICC_IGRPEN0_EL1), access_gic_grpen0 },
-	{ SYS_DESC(SYS_ICC_IGRPEN1_EL1), access_gic_grpen1 },
+	{ SYS_DESC(SYS_ICC_PMR_EL1),
+	  .set_user = set_gic_pmr, .get_user = get_gic_pmr, },
+	{ SYS_DESC(SYS_ICC_BPR0_EL1),
+	  .set_user = set_gic_bpr0, .get_user = get_gic_bpr0, },
+	{ SYS_DESC(SYS_ICC_AP0R0_EL1),
+	  .set_user = set_gic_ap0r, .get_user = get_gic_ap0r, },
+	{ SYS_DESC(SYS_ICC_AP0R1_EL1),
+	  .set_user = set_gic_ap0r, .get_user = get_gic_ap0r, },
+	{ SYS_DESC(SYS_ICC_AP0R2_EL1),
+	  .set_user = set_gic_ap0r, .get_user = get_gic_ap0r, },
+	{ SYS_DESC(SYS_ICC_AP0R3_EL1),
+	  .set_user = set_gic_ap0r, .get_user = get_gic_ap0r, },
+	{ SYS_DESC(SYS_ICC_AP1R0_EL1),
+	  .set_user = set_gic_ap1r, .get_user = get_gic_ap1r, },
+	{ SYS_DESC(SYS_ICC_AP1R1_EL1),
+	  .set_user = set_gic_ap1r, .get_user = get_gic_ap1r, },
+	{ SYS_DESC(SYS_ICC_AP1R2_EL1),
+	  .set_user = set_gic_ap1r, .get_user = get_gic_ap1r, },
+	{ SYS_DESC(SYS_ICC_AP1R3_EL1),
+	  .set_user = set_gic_ap1r, .get_user = get_gic_ap1r, },
+	{ SYS_DESC(SYS_ICC_BPR1_EL1),
+	  .set_user = set_gic_bpr1, .get_user = get_gic_bpr1, },
+	{ SYS_DESC(SYS_ICC_CTLR_EL1),
+	  .set_user = set_gic_ctlr, .get_user = get_gic_ctlr, },
+	{ SYS_DESC(SYS_ICC_SRE_EL1),
+	  .set_user = set_gic_sre, .get_user = get_gic_sre, },
+	{ SYS_DESC(SYS_ICC_IGRPEN0_EL1),
+	  .set_user = set_gic_grpen0, .get_user = get_gic_grpen0, },
+	{ SYS_DESC(SYS_ICC_IGRPEN1_EL1),
+	  .set_user = set_gic_grpen1, .get_user = get_gic_grpen1, },
 };
 
 static u64 attr_to_id(u64 attr)
@@ -282,31 +358,15 @@ int vgic_v3_cpu_sysregs_uaccess(struct kvm_vcpu *vcpu,
 				struct kvm_device_attr *attr,
 				bool is_write)
 {
-	u64 __user *uaddr = (u64 __user *)(long)attr->addr;
-	struct sys_reg_params params;
-	const struct sys_reg_desc *r;
-	u64 sysreg;
-
-	sysreg = attr_to_id(attr->attr);
-
-	if (is_write) {
-		if (get_user(params.regval, uaddr))
-			return -EFAULT;
-	}
-	params.is_write = is_write;
-
-	r = find_reg_by_id(sysreg, &params, gic_v3_icc_reg_descs,
-			   ARRAY_SIZE(gic_v3_icc_reg_descs));
-	if (!r)
-		return -ENXIO;
-
-	if (!r->access(vcpu, &params, r))
-		return -EINVAL;
-
-	if (!is_write) {
-		if (put_user(params.regval, uaddr))
-			return -EFAULT;
-	}
-
-	return 0;
+	struct kvm_one_reg reg = {
+		.id	= attr_to_id(attr->attr),
+		.addr	= attr->addr,
+	};
+
+	if (is_write)
+		return kvm_sys_reg_set_user(vcpu, &reg, gic_v3_icc_reg_descs,
+					    ARRAY_SIZE(gic_v3_icc_reg_descs));
+	else
+		return kvm_sys_reg_get_user(vcpu, &reg, gic_v3_icc_reg_descs,
+					    ARRAY_SIZE(gic_v3_icc_reg_descs));
 }
-- 
2.34.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
