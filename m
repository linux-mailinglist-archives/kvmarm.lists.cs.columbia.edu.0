Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE1C429CA3
	for <lists+kvmarm@lfdr.de>; Tue, 12 Oct 2021 06:37:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C43F44B15C;
	Tue, 12 Oct 2021 00:37:00 -0400 (EDT)
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
	with ESMTP id 4kQpU8AMneYg; Tue, 12 Oct 2021 00:36:59 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 866404B159;
	Tue, 12 Oct 2021 00:36:57 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 962AD4B130
 for <kvmarm@lists.cs.columbia.edu>; Tue, 12 Oct 2021 00:36:56 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SeQCIz4Egfx9 for <kvmarm@lists.cs.columbia.edu>;
 Tue, 12 Oct 2021 00:36:55 -0400 (EDT)
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com
 [209.85.215.202])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 8E23E4B128
 for <kvmarm@lists.cs.columbia.edu>; Tue, 12 Oct 2021 00:36:55 -0400 (EDT)
Received: by mail-pg1-f202.google.com with SMTP id
 n22-20020a6563d6000000b0029261ffde9bso8020399pgv.22
 for <kvmarm@lists.cs.columbia.edu>; Mon, 11 Oct 2021 21:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=7vo9Jye3iy34d7wxk7g8XLP+SJucgQI7Y2FBb4PVMnw=;
 b=XCT8s0xZr8hIUrdDmvqfnOnxYqMGJEiaoh+nFQ5WhVn0ZRTLWHNTAn+HFJmbjCOnY6
 x5CrPKVbLKHn40TQUW6a7Q7MVzdtVa4bBdMtIBG8yxn4VHVcVH8spAAakxPJeKOiObxk
 7xAxslDtmuqWhePLlKBtuFovwM6E11QC69B+fMBVFwNCeVZTacs5Lyd0WdW3GE3W7S2I
 Xk+6327uHlA8k24iPB2Rs4HTIpXl7swnhKavBqrVmt7TV46GZ+okhJnmWDSjvxezpDyE
 StUmedw/6Ehw533z4QaBgSx9/KKX3YCeVLKGVZzAXzgfoBIc9HpvhWvm8/2pXkJttqTB
 giJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=7vo9Jye3iy34d7wxk7g8XLP+SJucgQI7Y2FBb4PVMnw=;
 b=F2ZMaeKkXorh0hkFXVDZA68VObu4EG3CUioWWC/gJOnqmsk+A1wy8YdJAtI/FGe3zn
 sBwUIy8REK0BOEAbyxTjpa/6ocSXWXO/zgvKdwQIs90m+KkrpIIdWFTZy9cPnJNZ540z
 c7Dquu7RyVZ0PLe1sCBFPAPIRx/DBD/PEMTlMP0dh/kzPtonkOt2tulzXhMyly+aRn93
 zExP06iAxT2Uoy6/RYgaWBQ0dtdWfTQ93D8zahqEB1XQM+veeT24EcdAneyWMPxKxjvr
 JuNfbdItkefjSLdHn96YLeNF/ZcnhGjmPEIMZdtUQZifm4f/NINvkP1Y/QHud6Vnk9xq
 zyBQ==
X-Gm-Message-State: AOAM531Ru9nIvOMc56DiTnrW7ZQNUylCdeKrCertqLX6O7RhnGkvcPYA
 y1SqRecuCgbWrR+kea+N5bYpNsNZLRA=
X-Google-Smtp-Source: ABdhPJx0SaVYdmsGOHnnA4GhbM5OqxPa33tsX7LZFC6lKXCPshs+pcbFLj6wvFn9yiyMZ22Y3bGPzseV7Jk=
X-Received: from reiji-vws.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:15a3])
 (user=reijiw job=sendgmr) by 2002:a17:902:8b8b:b0:13d:e91c:a1b9 with SMTP id
 ay11-20020a1709028b8b00b0013de91ca1b9mr28229688plb.60.1634013414788; Mon, 11
 Oct 2021 21:36:54 -0700 (PDT)
Date: Mon, 11 Oct 2021 21:35:33 -0700
In-Reply-To: <20211012043535.500493-1-reijiw@google.com>
Message-Id: <20211012043535.500493-24-reijiw@google.com>
Mime-Version: 1.0
References: <20211012043535.500493-1-reijiw@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [RFC PATCH 23/25] KVM: arm64: Trap disabled features of
 ID_AA64ISAR1_EL1
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

Add feature_config_ctrl for PTRAUTH, which is indicated in
ID_AA64ISAR1_EL1, to program configuration register to trap
guest's using the feature when it is not exposed to the guest.

Signed-off-by: Reiji Watanabe <reijiw@google.com>
---
 arch/arm64/kvm/sys_regs.c | 41 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 68df4e4eba05..e74b33741dc4 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -281,6 +281,35 @@ static bool trap_raz_wi(struct kvm_vcpu *vcpu,
 	(cpuid_feature_extract_unsigned_field(val, ID_AA64ISAR1_GPI_SHIFT) >= \
 	 ID_AA64ISAR1_GPI_IMP_DEF)
 
+/*
+ * Return true if ptrauth needs to be trapped.
+ * (i.e. if ptrauth is supported on the host but not exposed to the guest)
+ */
+static bool vcpu_need_trap_ptrauth(struct kvm_vcpu *vcpu)
+{
+	u64 val;
+	unsigned int gpi, gpa, api, apa;
+	unsigned int generic, address;
+
+	if (!system_has_full_ptr_auth())
+		/* The feature is not supported. */
+		return false;
+
+	val = __vcpu_sys_reg(vcpu, IDREG_SYS_IDX(SYS_ID_AA64ISAR1_EL1));
+	gpi = aa64isar1_has_gpi(val);
+	gpa = aa64isar1_has_gpa(val);
+	api = aa64isar1_has_api(val);
+	apa = aa64isar1_has_apa(val);
+	generic = gpi || gpa;
+	address = api || apa;
+	if (generic && address)
+		/* The feature is available. */
+		return false;
+
+	/* The feature is supported but hidden. */
+	return true;
+}
+
 enum vcpu_config_reg {
 	VCPU_HCR_EL2 = 1,
 	VCPU_MDCR_EL2,
@@ -385,6 +414,14 @@ static struct feature_config_ctrl ftr_ctrl_lor = {
 	.cfg_val = HCR_TLOR,
 };
 
+/* For SYS_ID_AA64ISAR1_EL1 */
+static struct feature_config_ctrl ftr_ctrl_ptrauth = {
+	.ftr_need_trap = vcpu_need_trap_ptrauth,
+	.cfg_reg = VCPU_HCR_EL2,
+	.cfg_mask = (HCR_API | HCR_APK),
+	.cfg_val = 0,
+};
+
 struct id_reg_info {
 	u32	sys_reg;	/* Register ID */
 	u64	sys_val;	/* Sanitized system value */
@@ -763,6 +800,10 @@ static struct id_reg_info id_aa64isar1_el1_info = {
 	.init = init_id_aa64isar1_el1_info,
 	.validate = validate_id_aa64isar1_el1,
 	.get_reset_val = get_reset_id_aa64isar1_el1,
+	.trap_features = &(const struct feature_config_ctrl *[]) {
+		&ftr_ctrl_ptrauth,
+		NULL,
+	},
 };
 
 static struct id_reg_info id_aa64dfr0_el1_info = {
-- 
2.33.0.882.g93a45727a2-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
