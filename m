Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2B63845413F
	for <lists+kvmarm@lfdr.de>; Wed, 17 Nov 2021 07:50:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CDF984B125;
	Wed, 17 Nov 2021 01:50:29 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MfMM56GhKcWn; Wed, 17 Nov 2021 01:50:29 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 99CFF4B0DF;
	Wed, 17 Nov 2021 01:50:28 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8D9684A19F
 for <kvmarm@lists.cs.columbia.edu>; Wed, 17 Nov 2021 01:50:26 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3RhybwUl2tgZ for <kvmarm@lists.cs.columbia.edu>;
 Wed, 17 Nov 2021 01:50:25 -0500 (EST)
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com
 [209.85.216.74])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 5ABC549E5F
 for <kvmarm@lists.cs.columbia.edu>; Wed, 17 Nov 2021 01:50:25 -0500 (EST)
Received: by mail-pj1-f74.google.com with SMTP id
 d3-20020a17090a6a4300b001a70e45f34cso881553pjm.0
 for <kvmarm@lists.cs.columbia.edu>; Tue, 16 Nov 2021 22:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=LMhbb8z+xm9w4/dja4Fw2MViuPAGvmmbQ+PVrYP0i5Q=;
 b=SHNcn7oF3x+HutlCWfvIjEAcuL9nEimGUkVvMDgZQWTx6O+yl+XGGHBSaV4C4FE9Hd
 r00c15U+WA/c/IC5ocEZq7Xo1J9td6jlOfz7tLGtc0DzkplgSJaZai2mGzwHpHOJJcJ3
 mntmYW8ApfOYm/CMasymg9RgoGV3hB6XEG8roGM5q7qI8dhIiTyXIpTSNJEPSEY11kZr
 TA7jjU63CGF/1Ds1KIhKHcysXlmGwvLJGJW5xXRqJTQCnLk1K2HXho0wMctqMKCNvp/r
 gqBI19+OFVf7Z0+X/Ltrx8hqOclgC3e3HmVDOL7XtGmdlv07TZqPfbNemzRwNjRoQdZc
 kWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=LMhbb8z+xm9w4/dja4Fw2MViuPAGvmmbQ+PVrYP0i5Q=;
 b=egYPZeZ00fuB4pU/32PRe+2+vrXYFk0X0UlfBG7yW4BSvJx9VpGSDwHGfybjx6ezD9
 /26RLj0sRK2PwGsDjkU7nU30oppOCUgmGossxtuyGDqSiofBeUWAWUaVivBbn5bzAnAE
 8rSADRGFgN5OavUd1iNUdE0CJQdf6yvcEn2GLykR6NQf5X+YWnX/Hr9/m94skU1WqWWK
 /i46KMW7YSPhbOTOOHMpXo+iMp71vxxIL9prCEpZoHnW5M4kBkd7gX3LvpEFbIOjSoz1
 kLW2Jo4TH5jsV4WdYplt8Qw+imi1i0QbmH/qs7n3y1p8wX05AvdyqU4xAexK86nAO+ul
 3lPg==
X-Gm-Message-State: AOAM5307Ash6u9rWR8QGTLxrKtdGcza91wJF/WWuQMXEMyw0f7AGE6lU
 5F8z7+dP/5UpSfLE4NePArlXFVcTJGI=
X-Google-Smtp-Source: ABdhPJyqvIkcOzg9kv5HN+bRx6bfyb/Kt8VaG6o4P5ZXqPuVs07Jl4gjrYMSnip9n9ksQ1DhnYmfpYKYXKE=
X-Received: from reiji-vws-sp.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:3d59])
 (user=reijiw job=sendgmr) by 2002:a17:90a:284f:: with SMTP id
 p15mr312752pjf.1.1637131824128; Tue, 16 Nov 2021 22:50:24 -0800 (PST)
Date: Tue, 16 Nov 2021 22:43:36 -0800
In-Reply-To: <20211117064359.2362060-1-reijiw@google.com>
Message-Id: <20211117064359.2362060-7-reijiw@google.com>
Mime-Version: 1.0
References: <20211117064359.2362060-1-reijiw@google.com>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [RFC PATCH v3 06/29] KVM: arm64: Make ID_AA64ISAR0_EL1 writable
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

This patch adds id_reg_info for ID_AA64ISAR0_EL1 to make it writable
by userspace.

Updating sm3, sm4, sha1, sha2 and sha3 fields are allowed only
if values of those fields follow Arm ARM.

Signed-off-by: Reiji Watanabe <reijiw@google.com>
---
 arch/arm64/kvm/sys_regs.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 7dc2b0d41b75..fdd707462fa8 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -448,6 +448,29 @@ static int validate_id_aa64pfr1_el1(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
+static int validate_id_aa64isar0_el1(struct kvm_vcpu *vcpu,
+				     const struct id_reg_info *id_reg, u64 val)
+{
+	unsigned int sm3, sm4, sha1, sha2, sha3;
+
+	/* Run consistency checkings according to Arm ARM */
+	sm3 = cpuid_feature_extract_unsigned_field(val, ID_AA64ISAR0_SM3_SHIFT);
+	sm4 = cpuid_feature_extract_unsigned_field(val, ID_AA64ISAR0_SM4_SHIFT);
+	if (sm3 != sm4)
+		return -EINVAL;
+
+	sha1 = cpuid_feature_extract_unsigned_field(val, ID_AA64ISAR0_SHA1_SHIFT);
+	sha2 = cpuid_feature_extract_unsigned_field(val, ID_AA64ISAR0_SHA2_SHIFT);
+	if ((sha1 == 0) ^ (sha2 == 0))
+		return -EINVAL;
+
+	sha3 = cpuid_feature_extract_unsigned_field(val, ID_AA64ISAR0_SHA3_SHIFT);
+	if (((sha2 == 2) ^ (sha3 == 1)) || (!sha1 && sha3))
+		return -EINVAL;
+
+	return 0;
+}
+
 static void init_id_aa64pfr0_el1_info(struct id_reg_info *id_reg)
 {
 	u64 limit = id_reg->vcpu_limit_val;
@@ -526,6 +549,11 @@ static struct id_reg_info id_aa64pfr1_el1_info = {
 	.get_reset_val = get_reset_id_aa64pfr1_el1,
 };
 
+static struct id_reg_info id_aa64isar0_el1_info = {
+	.sys_reg = SYS_ID_AA64ISAR0_EL1,
+	.validate = validate_id_aa64isar0_el1,
+};
+
 /*
  * An ID register that needs special handling to control the value for the
  * guest must have its own id_reg_info in id_reg_info_table.
@@ -537,6 +565,7 @@ static struct id_reg_info id_aa64pfr1_el1_info = {
 static struct id_reg_info *id_reg_info_table[KVM_ARM_ID_REG_MAX_NUM] = {
 	[IDREG_IDX(SYS_ID_AA64PFR0_EL1)] = &id_aa64pfr0_el1_info,
 	[IDREG_IDX(SYS_ID_AA64PFR1_EL1)] = &id_aa64pfr1_el1_info,
+	[IDREG_IDX(SYS_ID_AA64ISAR0_EL1)] = &id_aa64isar0_el1_info,
 };
 
 static int validate_id_reg(struct kvm_vcpu *vcpu,
-- 
2.34.0.rc1.387.gb447b232ab-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
