Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0342C4D59F5
	for <lists+kvmarm@lfdr.de>; Fri, 11 Mar 2022 05:49:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 66F8949F1C;
	Thu, 10 Mar 2022 23:49:14 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.788
X-Spam-Level: 
X-Spam-Status: No, score=-1.788 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lywyjvaRnM4a; Thu, 10 Mar 2022 23:49:14 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9D87E49EB5;
	Thu, 10 Mar 2022 23:49:12 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 62C2E49F03
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Mar 2022 23:49:11 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FTustGZvpNx1 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 10 Mar 2022 23:49:09 -0500 (EST)
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com
 [209.85.210.201])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 72A3849EF1
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Mar 2022 23:49:08 -0500 (EST)
Received: by mail-pf1-f201.google.com with SMTP id
 h69-20020a628348000000b004f769e5b4bdso2740522pfe.10
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Mar 2022 20:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=46qXeSpi4Sz/Cxmd+kiVveMfXndYTJmQfut6cp7XrW4=;
 b=CPA2eRLxteZJs71CJ0dQUl7ireq+1W+7rl/oRTYFYRyGUMOlkRpx2xNk/s4nJt0A5r
 2C238ZfVTpkE8Ujii9v29Vnk3ITgwjUnaK5PZZcdRWiOcqwYYB1AfVnxYQDJqGFhu/IJ
 4XJ2k1wjuss+Kvd7Au27jIRjPf3JHrzenFHb9knbYT8bjBzl7Glg6u4TzmchCCtHmDo5
 xQwJVTxMcZqLGgRxDvWHsAJvBNogJqoy9TP687htkO+JtIaYO9W+v/vnOaPs9OWplpPv
 mu4BnmDtCuFN7vZQ5agxRAstLL9+XA9aErEQiU7EXruF8IhFID8v76gHBJml9H2eG3Rm
 aVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=46qXeSpi4Sz/Cxmd+kiVveMfXndYTJmQfut6cp7XrW4=;
 b=dd4m7+phBjvDDytXMwfop9F/dZe7Ef6T+R2HUXp+pUhFPjYdhY6MvAYL9UOOib9B7Q
 rn9uJJ8RYK/PpCte7OgVoqOEfLD61IdIV3OGIc5iQGsxptNTcEIVWGeX2UdJjZ1NWOu8
 Eis5sr3IfvPBNK/qCiB+OPQ04QC60N0MrOivpvnAbtzTHSD6EV1m/a6EAUfiznZLHUrB
 aII37KL7WctqIyeIr+uEuc5+F6Cs5B/zi6OU1ks6Pjq5aVViNFVoRH2iCQV7hvA4m7u9
 6fcNDmcm+b7Pl4IXjTOjcNLWa61IUum9ElnkdgE7g9XsObBRS/ClbBcF9JDibWqthQTZ
 suxw==
X-Gm-Message-State: AOAM532TIyxNNg0urZ/VQk0ozqVdjRHeQdMiXWtnyES2ZeEpTP0wLSN1
 mPBvIesYGtW2MgJadVM+2v7A8hTChSA=
X-Google-Smtp-Source: ABdhPJwSHuu2+YqzR0IJLcSfz4UuQFLPxAgOKQjBnghAqNzp2YYPCYKHN+sp+/U5r8Ffe0yVzT7zWbBDzAU=
X-Received: from reiji-vws-sp.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:3d59])
 (user=reijiw job=sendgmr) by 2002:a17:90b:1e10:b0:1bf:6c78:54a9 with SMTP id
 pg16-20020a17090b1e1000b001bf6c7854a9mr434986pjb.1.1646974147365; Thu, 10 Mar
 2022 20:49:07 -0800 (PST)
Date: Thu, 10 Mar 2022 20:48:08 -0800
In-Reply-To: <20220311044811.1980336-1-reijiw@google.com>
Message-Id: <20220311044811.1980336-23-reijiw@google.com>
Mime-Version: 1.0
References: <20220311044811.1980336-1-reijiw@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [PATCH v6 22/25] KVM: arm64: Trap disabled features of
 ID_AA64MMFR1_EL1
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

Add feature_config_ctrl for LORegions, which is indicated in
ID_AA64MMFR1_EL1, to program configuration register to trap
guest's using the feature when it is not exposed to the guest.

Change trap_loregion() to use vcpu_feature_is_available()
to simplify checking of the feature's availability.

Signed-off-by: Reiji Watanabe <reijiw@google.com>
---
 arch/arm64/kvm/sys_regs.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 677815030d44..f3661881cbed 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -374,6 +374,11 @@ static void feature_tracefilt_trap_activate(struct kvm_vcpu *vcpu)
 	feature_trap_activate(vcpu, VCPU_MDCR_EL2, MDCR_EL2_TTRF, 0);
 }
 
+static void feature_lor_trap_activate(struct kvm_vcpu *vcpu)
+{
+	feature_trap_activate(vcpu, VCPU_HCR_EL2, HCR_TLOR, 0);
+}
+
 /* For ID_AA64PFR0_EL1 */
 static struct feature_config_ctrl ftr_ctrl_ras = {
 	.ftr_reg = SYS_ID_AA64PFR0_EL1,
@@ -433,6 +438,15 @@ static struct feature_config_ctrl ftr_ctrl_tracefilt = {
 	.trap_activate = feature_tracefilt_trap_activate,
 };
 
+/* For ID_AA64MMFR1_EL1 */
+static struct feature_config_ctrl ftr_ctrl_lor = {
+	.ftr_reg = SYS_ID_AA64MMFR1_EL1,
+	.ftr_shift = ID_AA64MMFR1_LOR_SHIFT,
+	.ftr_min = 1,
+	.ftr_signed = FTR_UNSIGNED,
+	.trap_activate = feature_lor_trap_activate,
+};
+
 /* id_reg_desc flags field values */
 #define ID_DESC_REG_UNALLOC	(1UL << 0)
 #define ID_DESC_REG_HIDDEN	(1UL << 1)
@@ -1003,10 +1017,9 @@ static bool trap_loregion(struct kvm_vcpu *vcpu,
 			  struct sys_reg_params *p,
 			  const struct sys_reg_desc *r)
 {
-	u64 val = read_id_reg_with_encoding(vcpu, SYS_ID_AA64MMFR1_EL1);
 	u32 sr = reg_to_encoding(r);
 
-	if (!(val & (0xfUL << ID_AA64MMFR1_LOR_SHIFT))) {
+	if (!vcpu_feature_is_available(vcpu, &ftr_ctrl_lor)) {
 		kvm_inject_undefined(vcpu);
 		return false;
 	}
@@ -3785,6 +3798,14 @@ static struct id_reg_desc id_aa64mmfr0_el1_desc = {
 	.validate = validate_id_aa64mmfr0_el1,
 };
 
+static struct id_reg_desc id_aa64mmfr1_el1_desc = {
+	.reg_desc = ID_SANITISED(ID_AA64MMFR1_EL1),
+	.trap_features = &(const struct feature_config_ctrl *[]) {
+		&ftr_ctrl_lor,
+		NULL,
+	},
+};
+
 static struct id_reg_desc id_aa64dfr0_el1_desc = {
 	.reg_desc = ID_SANITISED(ID_AA64DFR0_EL1),
 	.init = init_id_aa64dfr0_el1_desc,
@@ -3901,7 +3922,7 @@ static struct id_reg_desc *id_reg_desc_table[KVM_ARM_ID_REG_MAX_NUM] = {
 
 	/* CRm=7 */
 	ID_DESC(ID_AA64MMFR0_EL1, &id_aa64mmfr0_el1_desc),
-	ID_DESC_DEFAULT(ID_AA64MMFR1_EL1),
+	ID_DESC(ID_AA64MMFR1_EL1, &id_aa64mmfr1_el1_desc),
 	ID_DESC_DEFAULT(ID_AA64MMFR2_EL1),
 	ID_DESC_UNALLOC(7, 3),
 	ID_DESC_UNALLOC(7, 4),
-- 
2.35.1.723.g4982287a31-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
