Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2779C506522
	for <lists+kvmarm@lfdr.de>; Tue, 19 Apr 2022 08:58:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C73024B275;
	Tue, 19 Apr 2022 02:58:01 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.788
X-Spam-Level: 
X-Spam-Status: No, score=-1.788 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lnwMFoNlCWfm; Tue, 19 Apr 2022 02:58:00 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 54CE74B24D;
	Tue, 19 Apr 2022 02:58:00 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9E2FE4B20C
 for <kvmarm@lists.cs.columbia.edu>; Tue, 19 Apr 2022 02:57:58 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pgztfT5PkBvA for <kvmarm@lists.cs.columbia.edu>;
 Tue, 19 Apr 2022 02:57:57 -0400 (EDT)
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com
 [209.85.214.201])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id BBEDB4B227
 for <kvmarm@lists.cs.columbia.edu>; Tue, 19 Apr 2022 02:57:53 -0400 (EDT)
Received: by mail-pl1-f201.google.com with SMTP id
 q6-20020a170902eb8600b001588e49dcaaso9254564plg.9
 for <kvmarm@lists.cs.columbia.edu>; Mon, 18 Apr 2022 23:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=6xPTbO2+lphyYIiZZ7nszYhBXnFaCQQSE3MHungiG3k=;
 b=It96CsYEpNqOcLwAVOb9ZqqedaZuQTEj/TXyGKgn91DGN1sbhJ2YzVPkGyHNPtG0Nv
 aNAZtDspBnw31IkOSfsaQRnyOa1+vukEVhRRJuyFETlx+Xga9HV7nASuyNJsYJd6eFZO
 Z24gMEtrO+U5npwqvSLXDznZlYHSyFsmBAFIFZoEMTLt46ZN4DzUxj55xgjRqSxJ6hm5
 euhJuYDyTiUwy8G6uL3tc5CKsuhmecf0ulBOQZbgyj0Zgb0i2TxRTfji88zGyTtAvcIk
 KyaEUd4bs969tANr4AJvZOIcTWBIOCB3bZmNr5U2nuMhhVOvPHgX0HvX8PSt923l0aer
 fGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=6xPTbO2+lphyYIiZZ7nszYhBXnFaCQQSE3MHungiG3k=;
 b=lz0T4MH0v7z64CYzhLd+lz12DgEbcXirPcSMsFKOuLUj0UBcozKoz3LJ1Ds+0qD6hm
 CAdSVjkw/wekfCB6ehIiYbDhoXMhEN0Hl44vyVdPdzwrlriWgpQ/AP7e4Xk6F7Ekuc2n
 fx/5oxBLJmHtd9rA9DTVwnPT5h0Rsy/ybxTxkIM1w7zMWlAJ+LRTsIgKKFGOHSjVi4Ie
 9gK4jBztz9F4cPVYjyKwBPQwF+dzakYmGyJ0M8CZNadwJH1LU/oS2B7XKBz4YC6MT7eL
 lzFDadcmrpm5aYbTbYcUhkicml0X8GqjT69UjqPgiArjNbpqpbuxvyysUEKQuTTv4Krj
 G7fA==
X-Gm-Message-State: AOAM5312Yjo6UnPaw1s2zufIifJs1Dqrb44/dGbsjm4mX8LdiazlN9C7
 RtXjqvxKsViYnYhoM0BoVZV0cVQwLXg=
X-Google-Smtp-Source: ABdhPJy3D0n5a+z17jnE0L3OXrhl0HuwRJ6F1nYYDplfhvW3GN0Q2u9zJiIaYhrSBbwPfSrzLKaQHN+kyIk=
X-Received: from reiji-vws-sp.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:3d59])
 (user=reijiw job=sendgmr) by 2002:a05:6a00:1490:b0:4fb:1544:bc60 with SMTP id
 v16-20020a056a00149000b004fb1544bc60mr16144093pfu.73.1650351472945; Mon, 18
 Apr 2022 23:57:52 -0700 (PDT)
Date: Mon, 18 Apr 2022 23:55:35 -0700
In-Reply-To: <20220419065544.3616948-1-reijiw@google.com>
Message-Id: <20220419065544.3616948-30-reijiw@google.com>
Mime-Version: 1.0
References: <20220419065544.3616948-1-reijiw@google.com>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [PATCH v7 29/38] KVM: arm64: Trap disabled features of ID_AA64DFR0_EL1
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

Add feature_config_ctrl for PMUv3, PMS and TraceFilt, which are
indicated in ID_AA64DFR0_EL1, to program configuration registers
to trap guest's using those features when they are not exposed to
the guest.

Signed-off-by: Reiji Watanabe <reijiw@google.com>
---
 arch/arm64/kvm/sys_regs.c | 64 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 10f366957ce9..a09c910198d6 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -365,6 +365,30 @@ static void feature_mte_trap_activate(struct kvm_vcpu *vcpu)
 	feature_trap_activate(vcpu, VCPU_HCR_EL2, HCR_TID5, HCR_DCT | HCR_ATA);
 }
 
+static void feature_trace_trap_activate(struct kvm_vcpu *vcpu)
+{
+	if (has_vhe())
+		feature_trap_activate(vcpu, VCPU_CPTR_EL2, CPACR_EL1_TTA, 0);
+	else
+		feature_trap_activate(vcpu, VCPU_CPTR_EL2, CPTR_EL2_TTA, 0);
+}
+
+static void feature_pmuv3_trap_activate(struct kvm_vcpu *vcpu)
+{
+	feature_trap_activate(vcpu, VCPU_MDCR_EL2, MDCR_EL2_TPM, 0);
+}
+
+static void feature_pms_trap_activate(struct kvm_vcpu *vcpu)
+{
+	feature_trap_activate(vcpu, VCPU_MDCR_EL2, MDCR_EL2_TPMS,
+			      MDCR_EL2_E2PB_MASK << MDCR_EL2_E2PB_SHIFT);
+}
+
+static void feature_tracefilt_trap_activate(struct kvm_vcpu *vcpu)
+{
+	feature_trap_activate(vcpu, VCPU_MDCR_EL2, MDCR_EL2_TTRF, 0);
+}
+
 /* For ID_AA64PFR0_EL1 */
 static struct feature_config_ctrl ftr_ctrl_ras = {
 	.ftr_reg = SYS_ID_AA64PFR0_EL1,
@@ -391,6 +415,39 @@ static struct feature_config_ctrl ftr_ctrl_mte = {
 	.trap_activate = feature_mte_trap_activate,
 };
 
+/* For ID_AA64DFR0_EL1 */
+static struct feature_config_ctrl ftr_ctrl_trace = {
+	.ftr_reg = SYS_ID_AA64DFR0_EL1,
+	.ftr_shift = ID_AA64DFR0_TRACEVER_SHIFT,
+	.ftr_min = 1,
+	.ftr_signed = FTR_UNSIGNED,
+	.trap_activate = feature_trace_trap_activate,
+};
+
+static struct feature_config_ctrl ftr_ctrl_pmuv3 = {
+	.ftr_reg = SYS_ID_AA64DFR0_EL1,
+	.ftr_shift = ID_AA64DFR0_PMUVER_SHIFT,
+	.ftr_min = ID_AA64DFR0_PMUVER_8_0,
+	.ftr_signed = FTR_UNSIGNED,
+	.trap_activate = feature_pmuv3_trap_activate,
+};
+
+static struct feature_config_ctrl ftr_ctrl_pms = {
+	.ftr_reg = SYS_ID_AA64DFR0_EL1,
+	.ftr_shift = ID_AA64DFR0_PMSVER_SHIFT,
+	.ftr_min = ID_AA64DFR0_PMSVER_8_2,
+	.ftr_signed = FTR_UNSIGNED,
+	.trap_activate = feature_pms_trap_activate,
+};
+
+static struct feature_config_ctrl ftr_ctrl_tracefilt = {
+	.ftr_reg = SYS_ID_AA64DFR0_EL1,
+	.ftr_shift = ID_AA64DFR0_TRACE_FILT_SHIFT,
+	.ftr_min = 1,
+	.ftr_signed = FTR_UNSIGNED,
+	.trap_activate = feature_tracefilt_trap_activate,
+};
+
 #define __FTR_BITS(ftr_sign, ftr_type, bit_pos, safe) {		\
 	.sign = ftr_sign,					\
 	.type = ftr_type,					\
@@ -4389,6 +4446,13 @@ static struct id_reg_desc id_aa64dfr0_el1_desc = {
 	.ftr_bits = {
 		S_FTR_BITS(FTR_LOWER_SAFE, ID_AA64DFR0_DOUBLELOCK_SHIFT, 0xf),
 	},
+	.trap_features = &(const struct feature_config_ctrl *[]) {
+		&ftr_ctrl_trace,
+		&ftr_ctrl_pmuv3,
+		&ftr_ctrl_pms,
+		&ftr_ctrl_tracefilt,
+		NULL,
+	},
 };
 
 static struct id_reg_desc id_dfr0_el1_desc = {
-- 
2.36.0.rc0.470.gd361397f0d-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
