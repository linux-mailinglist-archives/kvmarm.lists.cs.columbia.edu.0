Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id EBA8545413B
	for <lists+kvmarm@lfdr.de>; Wed, 17 Nov 2021 07:49:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9A7874B131;
	Wed, 17 Nov 2021 01:49:46 -0500 (EST)
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
	with ESMTP id GD0-Y3ERVXR0; Wed, 17 Nov 2021 01:49:46 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1E9F64B12E;
	Wed, 17 Nov 2021 01:49:45 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2D11A4B0F4
 for <kvmarm@lists.cs.columbia.edu>; Wed, 17 Nov 2021 01:49:44 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hPJQylM43iD4 for <kvmarm@lists.cs.columbia.edu>;
 Wed, 17 Nov 2021 01:49:42 -0500 (EST)
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com
 [209.85.216.73])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 3B3E54B0EF
 for <kvmarm@lists.cs.columbia.edu>; Wed, 17 Nov 2021 01:49:42 -0500 (EST)
Received: by mail-pj1-f73.google.com with SMTP id
 x6-20020a17090a6c0600b001a724a5696cso842408pjj.6
 for <kvmarm@lists.cs.columbia.edu>; Tue, 16 Nov 2021 22:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=qDRe5fuo80YmvUNtfD5Ja6z7ccR/RWV02RqftfcvCIs=;
 b=p4IgY7M5dzGUm0FTOHN6RojbbXL8qCy1PuaurY9cIgw4B01w5Viyh2M0dH8YaUxi7R
 Ah1olmBugu2Z59OdOWWwkqgb5amrTrGkPe7C94JyMl/rxZkJZUzdj0F8/m8U4eN+wsGi
 Mki64bQf0DLumBFb1JOdfRDGP4115BaU/C3IqtAqvw8IQwsIClrQXlBbpxj0m6Gql2qJ
 C2bbo4JzPoC/RNpnVImycQeOAKS+gm5zTk5sKgoopxCbcf6VVT1SiPIOE2bk7X6M4+Pd
 KXYJk2uKHxbOuFp+jRrx5WO5UulcGoZ1y1O/BmQXdNiT1701SnvqauJlEp5rB9NJpiWr
 kXzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=qDRe5fuo80YmvUNtfD5Ja6z7ccR/RWV02RqftfcvCIs=;
 b=cfkXs0lbw5Soo/t5P2LsJ36cZYZ6L9tgWqhaKDZh3Es57slbFkHhvH085A7FX5rFkM
 ZLbQAHM+uPpYnjobDMHhm858CVpTKoB4JI2J2KbE5WNpPo3T3iaN2YMsIWFgTzpybwyI
 SgEjoKXjojuUGHx5+8bh1O1CtfgxwPwcS+2r0AkC5OUTh/Zl0AqB2FNiqPgxk9JC5SNo
 devS+cs/UZzBdiT/BEz5XmZ+j1Ve8VVhhBGdkvVEsGlgJCCpvLAOuvOBzsUXwZkYqn80
 Sz0T3kkdu/D7jj6HpA5teOsunlPMM2BBbuDmV5FBsat3b7FgUaKAjdmK33H+IesktRcd
 xO9g==
X-Gm-Message-State: AOAM532350TKZ/qX1zas/nJKt5y8e1FR1f1ytRLmJWeL7rw70tzn6A7d
 JW5sr8XmCpjOR2KLzoj6yyaFymKz2HI=
X-Google-Smtp-Source: ABdhPJxYms5sy9/Vws06L9k+7Ejmbx9NzNqqi7zJjdpiKjILO6Zl1rCaYDrhCNDTTderhUgOfEsUL2+4eE4=
X-Received: from reiji-vws-sp.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:3d59])
 (user=reijiw job=sendgmr) by 2002:a17:90a:390c:: with SMTP id
 y12mr313015pjb.0.1637131781162; Tue, 16 Nov 2021 22:49:41 -0800 (PST)
Date: Tue, 16 Nov 2021 22:43:33 -0800
In-Reply-To: <20211117064359.2362060-1-reijiw@google.com>
Message-Id: <20211117064359.2362060-4-reijiw@google.com>
Mime-Version: 1.0
References: <20211117064359.2362060-1-reijiw@google.com>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [RFC PATCH v3 03/29] KVM: arm64: Introduce struct id_reg_info
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

This patch lays the groundwork to make ID registers writable.

Introduce struct id_reg_info for an ID register to manage the
register specific control of its value for the guest, and provide set
of functions commonly used for ID registers to make them writable.

The id_reg_info is used to do register specific initialization,
validation of the ID register and etc.  Not all ID registers must
have the id_reg_info. ID registers that don't have the id_reg_info
are handled in a common way that is applied to all ID registers.

At present, changing an ID register from userspace is allowed only
if the ID register has the id_reg_info, but that will be changed
by the following patches.

No ID register has the structure yet and the following patches
will add the id_reg_info for some ID registers.

Signed-off-by: Reiji Watanabe <reijiw@google.com>
---
 arch/arm64/include/asm/sysreg.h |   1 +
 arch/arm64/kvm/sys_regs.c       | 226 ++++++++++++++++++++++++++++++--
 2 files changed, 218 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 16b3f1a1d468..597609f26331 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -1197,6 +1197,7 @@
 #define ICH_VTR_TDS_MASK	(1 << ICH_VTR_TDS_SHIFT)
 
 #define ARM64_FEATURE_FIELD_BITS	4
+#define ARM64_FEATURE_FIELD_MASK	((1ull << ARM64_FEATURE_FIELD_BITS) - 1)
 
 /* Create a mask for the feature bits of the specified feature. */
 #define ARM64_FEATURE_MASK(x)	(GENMASK_ULL(x##_SHIFT + ARM64_FEATURE_FIELD_BITS - 1, x##_SHIFT))
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 5608d3410660..1552cd5581b7 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -265,6 +265,181 @@ static bool trap_raz_wi(struct kvm_vcpu *vcpu,
 		return read_zero(vcpu, p);
 }
 
+/*
+ * A value for FCT_LOWER_SAFE must be zero and changing that will affect
+ * ftr_check_types of id_reg_info.
+ */
+enum feature_check_type {
+	FCT_LOWER_SAFE = 0,
+	FCT_HIGHER_SAFE,
+	FCT_HIGHER_OR_ZERO_SAFE,
+	FCT_EXACT,
+	FCT_EXACT_OR_ZERO_SAFE,
+	FCT_IGNORE,	/* Don't check (any value is fine) */
+};
+
+static int arm64_check_feature_one(enum feature_check_type type, int val,
+				   int limit)
+{
+	bool is_safe = false;
+
+	if (val == limit)
+		return 0;
+
+	switch (type) {
+	case FCT_LOWER_SAFE:
+		is_safe = (val <= limit);
+		break;
+	case FCT_HIGHER_OR_ZERO_SAFE:
+		if (val == 0) {
+			is_safe = true;
+			break;
+		}
+		fallthrough;
+	case FCT_HIGHER_SAFE:
+		is_safe = (val >= limit);
+		break;
+	case FCT_EXACT:
+		break;
+	case FCT_EXACT_OR_ZERO_SAFE:
+		is_safe = (val == 0);
+		break;
+	case FCT_IGNORE:
+		is_safe = true;
+		break;
+	default:
+		WARN_ONCE(1, "Unexpected feature_check_type (%d)\n", type);
+		break;
+	}
+
+	return is_safe ? 0 : -1;
+}
+
+#define	FCT_TYPE_MASK		0x7
+#define	FCT_TYPE_SHIFT		1
+#define	FCT_SIGN_MASK		0x1
+#define	FCT_SIGN_SHIFT		0
+#define	FCT_TYPE(val)	((val >> FCT_TYPE_SHIFT) & FCT_TYPE_MASK)
+#define	FCT_SIGN(val)	((val >> FCT_SIGN_SHIFT) & FCT_SIGN_MASK)
+
+#define	MAKE_FCT(shift, type, sign)				\
+	((u64)((((type) & FCT_TYPE_MASK) << FCT_TYPE_SHIFT) |	\
+	       (((sign) & FCT_SIGN_MASK) << FCT_SIGN_SHIFT)) << (shift))
+
+/* For signed field */
+#define	S_FCT(shift, type)	MAKE_FCT(shift, type, 1)
+/* For unigned field */
+#define	U_FCT(shift, type)	MAKE_FCT(shift, type, 0)
+
+/*
+ * @val and @lim are both a value of the ID register. The function checks
+ * if all features indicated in @val can be supported for guests on the host,
+ * which supports features indicated in @lim. @check_types indicates how
+ * features in the ID register needs to be checked.
+ * See comments for id_reg_info's ftr_check_types field for more detail.
+ */
+static int arm64_check_features(u64 check_types, u64 val, u64 lim)
+{
+	int i;
+
+	for (i = 0; i < 64; i += ARM64_FEATURE_FIELD_BITS) {
+		u8 ftr_check = (check_types >> i) & ARM64_FEATURE_FIELD_MASK;
+		bool is_sign = FCT_SIGN(ftr_check);
+		enum feature_check_type fctype = FCT_TYPE(ftr_check);
+		int fval, flim, ret;
+
+		fval = cpuid_feature_extract_field(val, i, is_sign);
+		flim = cpuid_feature_extract_field(lim, i, is_sign);
+
+		ret = arm64_check_feature_one(fctype, fval, flim);
+		if (ret)
+			return -E2BIG;
+	}
+	return 0;
+}
+
+struct id_reg_info {
+	u32	sys_reg;	/* Register ID */
+
+	/*
+	 * Limit value of the register for a vcpu. The value is the sanitized
+	 * system value with bits cleared for unsupported features for the
+	 * guest.
+	 */
+	u64	vcpu_limit_val;
+
+	/*
+	 * The ftr_check_types is comprised of a set of 4 bits fields.
+	 * Each 4 bits field is for a feature indicated by the same bits
+	 * field of the ID register and indicates how the feature support
+	 * for guests needs to be checked.
+	 * The bit 0 indicates that the corresponding ID register field
+	 * is signed(1) or unsigned(0).
+	 * The bits [3:1] hold feature_check_type for the field.
+	 * If all zero, all features in the ID register are treated as unsigned
+	 * fields and checked based on Principles of the ID scheme for fields
+	 * in ID registers (FCT_LOWER_SAFE of feature_check_type).
+	 */
+	u64	ftr_check_types;
+
+	/* Initialization function of the id_reg_info */
+	void (*init)(struct id_reg_info *id_reg);
+
+	/* Register specific validation function */
+	int (*validate)(struct kvm_vcpu *vcpu, const struct id_reg_info *id_reg,
+			u64 val);
+
+	/* Return the reset value of the register for the vCPU */
+	u64 (*get_reset_val)(struct kvm_vcpu *vcpu,
+			     const struct id_reg_info *id_reg);
+};
+
+static void id_reg_info_init(struct id_reg_info *id_reg)
+{
+	id_reg->vcpu_limit_val = read_sanitised_ftr_reg(id_reg->sys_reg);
+	if (id_reg->init)
+		id_reg->init(id_reg);
+}
+
+/*
+ * An ID register that needs special handling to control the value for the
+ * guest must have its own id_reg_info in id_reg_info_table.
+ * (i.e. the reset value is different from the host's sanitized value,
+ * the value is affected by opt-in features, some fields needs specific
+ * validation, etc.)
+ */
+#define	GET_ID_REG_INFO(id)	(id_reg_info_table[IDREG_IDX(id)])
+static struct id_reg_info *id_reg_info_table[KVM_ARM_ID_REG_MAX_NUM] = {};
+
+static int validate_id_reg(struct kvm_vcpu *vcpu,
+			   const struct sys_reg_desc *rd, u64 val)
+{
+	u32 id = reg_to_encoding(rd);
+	const struct id_reg_info *id_reg = GET_ID_REG_INFO(id);
+	u64 limit, check_types;
+	int err;
+
+	if (id_reg) {
+		check_types = id_reg->ftr_check_types;
+		limit = id_reg->vcpu_limit_val;
+	} else {
+		/* All fields are treated as unsigned and FCT_LOWER_SAFE */
+		check_types = 0;
+		limit = read_sanitised_ftr_reg(id);
+	}
+
+	/* Check if the value indicates any feature that is not in the limit. */
+	err = arm64_check_features(check_types, val, limit);
+	if (err)
+		return err;
+
+	if (id_reg && id_reg->validate)
+		/* Run the ID register specific validity check. */
+		err = id_reg->validate(vcpu, id_reg, val);
+
+	return err;
+}
+
 /*
  * ARMv8.1 mandates at least a trivial LORegion implementation, where all the
  * RW registers are RES0 (which we can implement as RAZ/WI). On an ARMv8.0
@@ -1183,11 +1358,19 @@ static unsigned int sve_visibility(const struct kvm_vcpu *vcpu,
 static void reset_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd)
 {
 	u32 id = reg_to_encoding(rd);
+	struct id_reg_info *id_reg;
+	u64 val;
 
 	if (vcpu_has_reset_once(vcpu))
 		return;
 
-	__vcpu_sys_reg(vcpu, IDREG_SYS_IDX(id)) = read_sanitised_ftr_reg(id);
+	id_reg = GET_ID_REG_INFO(id);
+	if (id_reg && id_reg->get_reset_val)
+		val = id_reg->get_reset_val(vcpu, id_reg);
+	else
+		val = read_sanitised_ftr_reg(id);
+
+	__vcpu_sys_reg(vcpu, IDREG_SYS_IDX(id)) = val;
 }
 
 static int set_id_aa64pfr0_el1(struct kvm_vcpu *vcpu,
@@ -1232,11 +1415,7 @@ static int set_id_aa64pfr0_el1(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
-/*
- * cpufeature ID register user accessors
- *
- * We don't allow the effective value to be changed.
- */
+/* cpufeature ID register user accessors */
 static int __get_id_reg(const struct kvm_vcpu *vcpu,
 			const struct sys_reg_desc *rd, void __user *uaddr,
 			bool raz)
@@ -1247,11 +1426,12 @@ static int __get_id_reg(const struct kvm_vcpu *vcpu,
 	return reg_to_user(uaddr, &val, id);
 }
 
-static int __set_id_reg(const struct kvm_vcpu *vcpu,
+static int __set_id_reg(struct kvm_vcpu *vcpu,
 			const struct sys_reg_desc *rd, void __user *uaddr,
 			bool raz)
 {
 	const u64 id = sys_reg_to_index(rd);
+	u32 encoding = reg_to_encoding(rd);
 	int err;
 	u64 val;
 
@@ -1259,10 +1439,22 @@ static int __set_id_reg(const struct kvm_vcpu *vcpu,
 	if (err)
 		return err;
 
-	/* This is what we mean by invariant: you can't change it. */
-	if (val != read_id_reg(vcpu, rd, raz))
+	/* Don't allow to change the reg unless the reg has id_reg_info */
+	if (val != read_id_reg(vcpu, rd, raz) && !GET_ID_REG_INFO(encoding))
 		return -EINVAL;
 
+	if (raz)
+		return 0;
+
+	/* Don't allow to change the reg after the first KVM_RUN. */
+	if (vcpu->arch.has_run_once)
+		return -EINVAL;
+
+	err = validate_id_reg(vcpu, rd, val);
+	if (err)
+		return err;
+
+	__vcpu_sys_reg(vcpu, IDREG_SYS_IDX(encoding)) = val;
 	return 0;
 }
 
@@ -2826,6 +3018,20 @@ int kvm_arm_copy_sys_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
 	return write_demux_regids(uindices);
 }
 
+static void id_reg_info_init_all(void)
+{
+	int i;
+	struct id_reg_info *id_reg;
+
+	for (i = 0; i < ARRAY_SIZE(id_reg_info_table); i++) {
+		id_reg = (struct id_reg_info *)id_reg_info_table[i];
+		if (!id_reg)
+			continue;
+
+		id_reg_info_init(id_reg);
+	}
+}
+
 void kvm_sys_reg_table_init(void)
 {
 	unsigned int i;
@@ -2860,4 +3066,6 @@ void kvm_sys_reg_table_init(void)
 			break;
 	/* Clear all higher bits. */
 	cache_levels &= (1 << (i*3))-1;
+
+	id_reg_info_init_all();
 }
-- 
2.34.0.rc1.387.gb447b232ab-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
