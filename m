Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 15C6E429C9C
	for <lists+kvmarm@lfdr.de>; Tue, 12 Oct 2021 06:36:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B965F4048B;
	Tue, 12 Oct 2021 00:36:53 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WpmewWVcnUWm; Tue, 12 Oct 2021 00:36:52 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0F0034B137;
	Tue, 12 Oct 2021 00:36:52 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 077684B132
 for <kvmarm@lists.cs.columbia.edu>; Tue, 12 Oct 2021 00:36:51 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 98i9fViZ-DaC for <kvmarm@lists.cs.columbia.edu>;
 Tue, 12 Oct 2021 00:36:50 -0400 (EDT)
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com
 [209.85.210.201])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 5F45B4B13A
 for <kvmarm@lists.cs.columbia.edu>; Tue, 12 Oct 2021 00:36:49 -0400 (EDT)
Received: by mail-pf1-f201.google.com with SMTP id
 3-20020a620603000000b0042aea40c2ddso8593439pfg.9
 for <kvmarm@lists.cs.columbia.edu>; Mon, 11 Oct 2021 21:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=aRSx5zsU8oar0tb24ztRfo+cPgh7JwnM1ai34rY7D1c=;
 b=cYhiDj33nfyC1+mBMm3OX/sk39KmpppUj6JtIztRs3tz0amKzYK5kcV4cxVpWZXfg4
 bTWk0/6bU4Zvq2uI+1uL/yMfWefIo4MQdEckJ44mowOvJtPPi0vus7k/2XEqB2ypPjY9
 fJX+tPmHrUgbq1fgzi8vtt8vcgO7dp1y5ioqBi0XzM89yZPoQd7PvWicCEHqmA23SP9q
 lH7fwIHrQjJtLM3nTriL0j9gmXlmqAPikl59xzwEsrjG139moFR1UUaBdUzjfgt+89UO
 WMoGcLgXEcRUFn2J9P77SlB4HqSPpjpY9XeBggk036qs3o/688SPHWQpfyAVju5CnKgT
 oIxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=aRSx5zsU8oar0tb24ztRfo+cPgh7JwnM1ai34rY7D1c=;
 b=I/IuriVolzQSRPOFaN2fM9eMJAx6G6C790Y72Sy3WRg1wYpYE0nx5KBNkY/uUvK9sO
 NQJDbYn26sBeJqqidtWR2WHo2KvTUZLQoueJqC6/NHcMvQ8kQ1EveUiSlIrbsfuFW2OB
 GCPH76vMfP+UsNVXY3PpWeLBzVOIsWAYQ9ntGWeoNVHYpG+doVYUTDtCqaIxrC/aqR0v
 +AC9u/bGUcbKwUN61wYKLTyzciFkfmW43+4VimdY0Vx4Y3pkgFirY1bkfc+vXBEM7SZp
 JaR2GR0kEsNmVw1SY4Q1gaRhz4IU4GbZuJxt7AxRBv3Zd6TKo089OiPLhm99kSJ/cMT3
 VKhQ==
X-Gm-Message-State: AOAM532oZKZqZRVkAUEtRBGCrwbA5t3zd2+a8iQqBSdiGyz4I3XuABuA
 NG7IDgaVQ19DbaEP2t2uwKcCWnIVNxo=
X-Google-Smtp-Source: ABdhPJwMjijcnPLmRF0gVFsrWCvfaeII36N+1PxEShOqBpmnd6e5wcu2sZR24dDiEMFwJYbs4Q5g7aB3YhQ=
X-Received: from reiji-vws.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:15a3])
 (user=reijiw job=sendgmr) by 2002:a05:6a00:181c:b0:44c:bf17:e8ad with SMTP id
 y28-20020a056a00181c00b0044cbf17e8admr28869751pfa.67.1634013408614; Mon, 11
 Oct 2021 21:36:48 -0700 (PDT)
Date: Mon, 11 Oct 2021 21:35:29 -0700
In-Reply-To: <20211012043535.500493-1-reijiw@google.com>
Message-Id: <20211012043535.500493-20-reijiw@google.com>
Mime-Version: 1.0
References: <20211012043535.500493-1-reijiw@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [RFC PATCH 19/25] KVM: arm64: Trap disabled features of
 ID_AA64PFR0_EL1
From: Reiji Watanabe <reijiw@google.com>
To: Marc Zyngier <maz@kernel.org>, kvmarm@lists.cs.columbia.edu
Cc: kvm@vger.kernel.org, Will Deacon <will@kernel.org>,
 Peter Shier <pshier@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
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

Add feature_config_ctrl for RAS and AMU, which are indicated in
ID_AA64PFR0_EL1, to program configuration registers to trap
guest's using those features when they are not exposed to the guest.

Introduce trap_ras_regs() to change a behavior of guest's access to
the registers, which is currently raz/wi, depending on the feature's
availability for the guest (and inject undefined instruction
exception when guest's RAS register access are trapped and RAS is
not exposed to the guest).  In order to keep the current visibility
of the RAS registers from userspace (always visible), a visibility
function for RAS registers is not added.

No code is added for AMU's access/visibility handler because the
current code already injects the exception for Guest's AMU register
access unconditionally because AMU is never exposed to the guest.

Signed-off-by: Reiji Watanabe <reijiw@google.com>
---
 arch/arm64/kvm/sys_regs.c | 54 +++++++++++++++++++++++++++++++++------
 1 file changed, 46 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 55c514e21214..2b45db310151 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -310,6 +310,27 @@ struct feature_config_ctrl {
 	u64	cfg_val;	/* Value that are set for the field */
 };
 
+/* For ID_AA64PFR0_EL1 */
+static struct feature_config_ctrl ftr_ctrl_ras = {
+	.ftr_reg = SYS_ID_AA64PFR0_EL1,
+	.ftr_shift = ID_AA64PFR0_RAS_SHIFT,
+	.ftr_min = ID_AA64PFR0_RAS_V1,
+	.ftr_signed = FTR_UNSIGNED,
+	.cfg_reg = VCPU_HCR_EL2,
+	.cfg_mask = (HCR_TERR | HCR_TEA | HCR_FIEN),
+	.cfg_val = (HCR_TERR | HCR_TEA),
+};
+
+static struct feature_config_ctrl ftr_ctrl_amu = {
+	.ftr_reg = SYS_ID_AA64PFR0_EL1,
+	.ftr_shift = ID_AA64PFR0_AMU_SHIFT,
+	.ftr_min = ID_AA64PFR0_AMU,
+	.ftr_signed = FTR_UNSIGNED,
+	.cfg_reg = VCPU_CPTR_EL2,
+	.cfg_mask = CPTR_EL2_TAM,
+	.cfg_val = CPTR_EL2_TAM,
+};
+
 struct id_reg_info {
 	u32	sys_reg;	/* Register ID */
 	u64	sys_val;	/* Sanitized system value */
@@ -660,6 +681,11 @@ static struct id_reg_info id_aa64pfr0_el1_info = {
 	.init = init_id_aa64pfr0_el1_info,
 	.validate = validate_id_aa64pfr0_el1,
 	.get_reset_val = get_reset_id_aa64pfr0_el1,
+	.trap_features = &(const struct feature_config_ctrl *[]) {
+		&ftr_ctrl_ras,
+		&ftr_ctrl_amu,
+		NULL,
+	},
 };
 
 static struct id_reg_info id_aa64pfr1_el1_info = {
@@ -790,6 +816,18 @@ static inline bool vcpu_feature_is_available(struct kvm_vcpu *vcpu,
 	return feature_avail(ctrl, val);
 }
 
+static bool trap_ras_regs(struct kvm_vcpu *vcpu,
+			  struct sys_reg_params *p,
+			  const struct sys_reg_desc *r)
+{
+	if (!vcpu_feature_is_available(vcpu, &ftr_ctrl_ras)) {
+		kvm_inject_undefined(vcpu);
+		return false;
+	}
+
+	return trap_raz_wi(vcpu, p, r);
+}
+
 /*
  * ARMv8.1 mandates at least a trivial LORegion implementation, where all the
  * RW registers are RES0 (which we can implement as RAZ/WI). On an ARMv8.0
@@ -2052,14 +2090,14 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_AFSR1_EL1), access_vm_reg, reset_unknown, AFSR1_EL1 },
 	{ SYS_DESC(SYS_ESR_EL1), access_vm_reg, reset_unknown, ESR_EL1 },
 
-	{ SYS_DESC(SYS_ERRIDR_EL1), trap_raz_wi },
-	{ SYS_DESC(SYS_ERRSELR_EL1), trap_raz_wi },
-	{ SYS_DESC(SYS_ERXFR_EL1), trap_raz_wi },
-	{ SYS_DESC(SYS_ERXCTLR_EL1), trap_raz_wi },
-	{ SYS_DESC(SYS_ERXSTATUS_EL1), trap_raz_wi },
-	{ SYS_DESC(SYS_ERXADDR_EL1), trap_raz_wi },
-	{ SYS_DESC(SYS_ERXMISC0_EL1), trap_raz_wi },
-	{ SYS_DESC(SYS_ERXMISC1_EL1), trap_raz_wi },
+	{ SYS_DESC(SYS_ERRIDR_EL1), trap_ras_regs },
+	{ SYS_DESC(SYS_ERRSELR_EL1), trap_ras_regs },
+	{ SYS_DESC(SYS_ERXFR_EL1), trap_ras_regs },
+	{ SYS_DESC(SYS_ERXCTLR_EL1), trap_ras_regs },
+	{ SYS_DESC(SYS_ERXSTATUS_EL1), trap_ras_regs },
+	{ SYS_DESC(SYS_ERXADDR_EL1), trap_ras_regs },
+	{ SYS_DESC(SYS_ERXMISC0_EL1), trap_ras_regs },
+	{ SYS_DESC(SYS_ERXMISC1_EL1), trap_ras_regs },
 
 	MTE_REG(TFSR_EL1),
 	MTE_REG(TFSRE0_EL1),
-- 
2.33.0.882.g93a45727a2-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
