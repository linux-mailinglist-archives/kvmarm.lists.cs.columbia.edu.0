Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7064B422C
	for <lists+kvmarm@lfdr.de>; Mon, 14 Feb 2022 07:58:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CD63849ED2;
	Mon, 14 Feb 2022 01:58:27 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.912
X-Spam-Level: 
X-Spam-Status: No, score=0.912 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_BLOCKED=0.001,
	T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pRA7ZxPZVeJc; Mon, 14 Feb 2022 01:58:27 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 29D6E49E2B;
	Mon, 14 Feb 2022 01:58:26 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 04F8749E1E
 for <kvmarm@lists.cs.columbia.edu>; Mon, 14 Feb 2022 01:58:25 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VTzPsshy-psO for <kvmarm@lists.cs.columbia.edu>;
 Mon, 14 Feb 2022 01:58:23 -0500 (EST)
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com
 [209.85.210.202])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9102A40307
 for <kvmarm@lists.cs.columbia.edu>; Mon, 14 Feb 2022 01:58:23 -0500 (EST)
Received: by mail-pf1-f202.google.com with SMTP id
 d5-20020a623605000000b004e01ccd08abso11092320pfa.10
 for <kvmarm@lists.cs.columbia.edu>; Sun, 13 Feb 2022 22:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=T5yz703N//8esWizVyVeAiBEbNVxJBnpEoyrN6w9wuM=;
 b=rSJWrsmltlCZIDqAfHFSwzyq7er2gLTFyd2J4jOsXihtmvAO3JY+gNxdYVIxVS3QZo
 60Ye//a+arlZboxvrgEuT3IvmxkKT0kcMzsm5+BNLYunduGSn/bTbA9wZWyFllLVZnzl
 Z09mRF0N0Z6EH52fWDbarVKJ0xe6SxaOB5m8OVTTYP25Y28ytjVuzC0l6ICYsvO65aa5
 AwaOtHj/KIYVIBGx5DeKuSyJ9YFBm4Ife2A/m7lSXqaLtvvnBHpevZATS/57oDq6LDVg
 2RFo1+/3vkU4YLGKZyl5j1eEa7DKszTnO0kD5+83Kmjc+Vm7BnetVjn6bx+f9mzvAP6O
 FgYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=T5yz703N//8esWizVyVeAiBEbNVxJBnpEoyrN6w9wuM=;
 b=Gz+blSdYYGXlG9Ou4u3fN+NpMKURwTZkt2RElWxgBWUEZC+LdDnr0a0gs4qcTHjeUV
 YZb6gQ3OFQiu6Wur+CV1uBvbuar/+rYKZzNe9KnBrIq6qOyJRsE8UDlgy0j9pU1i3lSl
 leh8+qHu1wr3PyzfSREkKbUbTYb3SMwa77VPVC+Y1jJowjuA4ratfTDy2+tLw7GrUBed
 h1qiQsk/2vZ7f4GSt1k4s2wyuyIDz9MHNmtKFSHuQ3CJq50RcVEQMcR2PiNaLG/etMJ2
 I23Rr82YcVCyRfxvcvboqk3BV9nuxdXs0/yvDcHQn5n7gt36/1tzaEIj+eJvYUxvYWkw
 KGBQ==
X-Gm-Message-State: AOAM532mM78SY9m+jSMm10HU774g/y8VZPh0uNH0eHpr3zZJQpXg4oOQ
 zr3cKjMsH4zS9kHkti4j0Y9S7NJBHKQ=
X-Google-Smtp-Source: ABdhPJyapHwwcNZT0cLzLPIpK8udqibBngwQltSWnOSmGPSRzQ13EtqmPxecTMY1chhYXpuk2EeuMxpBw5c=
X-Received: from reiji-vws-sp.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:3d59])
 (user=reijiw job=sendgmr) by 2002:a05:6a00:174d:: with SMTP id
 j13mr12921862pfc.58.1644821902675; Sun, 13 Feb 2022 22:58:22 -0800 (PST)
Date: Sun, 13 Feb 2022 22:57:20 -0800
In-Reply-To: <20220214065746.1230608-1-reijiw@google.com>
Message-Id: <20220214065746.1230608-2-reijiw@google.com>
Mime-Version: 1.0
References: <20220214065746.1230608-1-reijiw@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH v5 01/27] KVM: arm64: Introduce a validation function for an
 ID register
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

Introduce arm64_check_features(), which does a basic validity checking
of an ID register value against the register's limit value, which is
generally the host's sanitized value.

This function will be used by the following patches to check if an ID
register value that userspace tries to set for a guest can be supported
on the host.

The validation is done using arm64_ftr_bits_kvm, which is created from
arm64_ftr_regs, with some entries overwritten by entries from
arm64_ftr_bits_kvm_override.

Signed-off-by: Reiji Watanabe <reijiw@google.com>
---
 arch/arm64/include/asm/cpufeature.h |   1 +
 arch/arm64/kernel/cpufeature.c      | 229 ++++++++++++++++++++++++++++
 2 files changed, 230 insertions(+)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index ef6be92b1921..a9edf1ca7dcb 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -631,6 +631,7 @@ void check_local_cpu_capabilities(void);
 
 u64 read_sanitised_ftr_reg(u32 id);
 u64 __read_sysreg_by_encoding(u32 sys_id);
+int arm64_check_features_kvm(u32 sys_reg, u64 val, u64 limit);
 
 static inline bool cpu_supports_mixed_endian_el0(void)
 {
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index e5f23dab1c8d..bc0ed09aa1b5 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -928,6 +928,10 @@ static void init_32bit_cpu_features(struct cpuinfo_32bit *info)
 	init_cpu_ftr_reg(SYS_MVFR2_EL1, info->reg_mvfr2);
 }
 
+#ifdef CONFIG_KVM
+static void init_arm64_ftr_bits_kvm(void);
+#endif
+
 void __init init_cpu_features(struct cpuinfo_arm64 *info)
 {
 	/* Before we start using the tables, make sure it is sorted */
@@ -970,6 +974,14 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
 	 * after we have initialised the CPU feature infrastructure.
 	 */
 	setup_boot_cpu_capabilities();
+
+#ifdef CONFIG_KVM
+	/*
+	 * Initialize arm64_ftr_bits_kvm, which will be used to provide
+	 * KVM with general feature checking for its guests.
+	 */
+	init_arm64_ftr_bits_kvm();
+#endif
 }
 
 static void update_cpu_ftr_reg(struct arm64_ftr_reg *reg, u64 new)
@@ -3156,3 +3168,220 @@ ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr,
 		return sprintf(buf, "Vulnerable\n");
 	}
 }
+
+#ifdef CONFIG_KVM
+/*
+ * arm64_ftr_bits_kvm[] is used for KVM to check if features that are
+ * indicated in an ID register value for the guest are available on the host.
+ * arm64_ftr_bits_kvm[] is created based on arm64_ftr_regs[].  But, for
+ * registers for which arm64_ftr_bits_kvm_override[] has a corresponding
+ * entry, replace arm64_ftr_bits entries in arm64_ftr_bits_kvm[] with the
+ * ones in arm64_ftr_bits_kvm_override[].
+ *
+ * What to add to arm64_ftr_bits_kvm_override[] shouldn't be decided according
+ * to KVM's implementation, but according to schemes of ID register fields.
+ * (e.g. For ID_AA64DFR0_EL1.PMUVER, a higher value on the field indicates
+ * more features. So, the arm64_ftr_bits' type for the field can be
+ * FTR_LOWER_SAFE instead of FTR_EXACT unlike arm64_ftr_regs)
+ */
+
+/*
+ * The number of __ftr_reg_bits_entry entries in arm64_ftr_bits_kvm must be
+ * the same as the number of __ftr_reg_entry entries in arm64_ftr_regs.
+ */
+static struct __ftr_reg_bits_entry {
+	u32	sys_id;
+	struct arm64_ftr_bits	*ftr_bits;
+} arm64_ftr_bits_kvm[ARRAY_SIZE(arm64_ftr_regs)];
+
+/*
+ * Number of arm64_ftr_bits entries for each register.
+ * (Number of 4 bits fields in 64 bit register + 1 entry for ARM64_FTR_END)
+ */
+#define	MAX_FTR_BITS_LEN	17
+
+/* Use FTR_LOWER_SAFE for AA64DFR0_EL1.PMUVER and AA64DFR0_EL1.DEBUGVER. */
+static struct arm64_ftr_bits ftr_id_aa64dfr0_kvm[MAX_FTR_BITS_LEN] = {
+	S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64DFR0_PMUVER_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_DEBUGVER_SHIFT, 4, 0x6),
+	ARM64_FTR_END,
+};
+
+#define	ARM64_FTR_REG_BITS(id, table)	{	\
+	.sys_id = id,				\
+	.ftr_bits = &((table)[0]),		\
+}
+
+/*
+ * All entries in arm64_ftr_bits_kvm_override[] are used to override
+ * the corresponding entries in arm64_ftr_bits_kvm[].
+ */
+static struct __ftr_reg_bits_entry arm64_ftr_bits_kvm_override[] = {
+	ARM64_FTR_REG_BITS(SYS_ID_AA64DFR0_EL1, ftr_id_aa64dfr0_kvm),
+};
+
+/*
+ * Override entries in @orig_ftrp with the ones in @new_ftrp when their shift
+ * fields match.  The last entry of @orig_ftrp and @new_ftrp must be
+ * ARM64_FTR_END (.width == 0).
+ */
+static void arm64_ftr_reg_bits_override(struct arm64_ftr_bits *orig_ftrp,
+					const struct arm64_ftr_bits *new_ftrp)
+{
+	const struct arm64_ftr_bits *n_ftrp;
+	struct arm64_ftr_bits *o_ftrp;
+
+	for (n_ftrp = new_ftrp; n_ftrp->width; n_ftrp++) {
+		for (o_ftrp = orig_ftrp; o_ftrp->width; o_ftrp++) {
+			if (o_ftrp->shift == n_ftrp->shift) {
+				*o_ftrp = *n_ftrp;
+				break;
+			}
+		}
+	}
+}
+
+/*
+ * Copy arm64_ftr_bits entries from @src_ftrp to @dst_ftrp.  The last entries
+ * of @dst_ftrp and @src_ftrp must be ARM64_FTR_END (.width == 0).
+ */
+static void copy_arm64_ftr_bits(struct arm64_ftr_bits *dst_ftrp,
+				const struct arm64_ftr_bits *src_ftrp)
+{
+	int i = 0;
+
+	for (; src_ftrp[i].width; i++) {
+		if (WARN_ON_ONCE(i >= (MAX_FTR_BITS_LEN - 1)))
+			break;
+
+		dst_ftrp[i] = src_ftrp[i];
+	}
+
+	dst_ftrp[i].width = 0;
+}
+
+/*
+ * Initialize arm64_ftr_bits_kvm.  Copy arm64_ftr_bits for each ID register
+ * from arm64_ftr_regs to arm64_ftr_bits_kvm, and then override entries in
+ * arm64_ftr_bits_kvm with ones in arm64_ftr_bits_kvm_override.
+ */
+static void init_arm64_ftr_bits_kvm(void)
+{
+	struct arm64_ftr_bits ftr_temp[MAX_FTR_BITS_LEN];
+	static struct __ftr_reg_bits_entry *bits, *o_bits;
+	int i, j;
+
+	/* Copy entries from arm64_ftr_regs to arm64_ftr_bits_kvm */
+	for (i = 0; i < ARRAY_SIZE(arm64_ftr_bits_kvm); i++) {
+		bits = &arm64_ftr_bits_kvm[i];
+		bits->sys_id = arm64_ftr_regs[i].sys_id;
+		bits->ftr_bits = (struct arm64_ftr_bits *)arm64_ftr_regs[i].reg->ftr_bits;
+	};
+
+	/*
+	 * Override the entries in arm64_ftr_bits_kvm with the ones in
+	 * arm64_ftr_bits_kvm_override.
+	 */
+	for (i = 0; i < ARRAY_SIZE(arm64_ftr_bits_kvm_override); i++) {
+		o_bits = &arm64_ftr_bits_kvm_override[i];
+		for (j = 0; j < ARRAY_SIZE(arm64_ftr_bits_kvm); j++) {
+			bits = &arm64_ftr_bits_kvm[j];
+			if (bits->sys_id != o_bits->sys_id)
+				continue;
+
+			/*
+			 * The code below tries to sustain the ordering of
+			 * entries in bits even in o_bits, just in case
+			 * arm64_ftr_bits entries in arm64_ftr_regs have
+			 * any ordering requirements in the future (so that
+			 * the ones in arm64_ftr_bits_kvm_override doesn't
+			 * have to care).
+			 * So, rather than directly copying them to empty
+			 * slots in o_bits, the code simply copies entries
+			 * from bits to o_bits first, then overrides them with
+			 * original entries in o_bits.
+			 */
+			memset(ftr_temp, 0, sizeof(ftr_temp));
+
+			/*
+			 * Temporary save all entries in o_bits->ftr_bits
+			 * to ftr_temp.
+			 */
+			copy_arm64_ftr_bits(ftr_temp, o_bits->ftr_bits);
+
+			/*
+			 * Copy entries from bits->ftr_bits to o_bits->ftr_bits.
+			 */
+			copy_arm64_ftr_bits(o_bits->ftr_bits, bits->ftr_bits);
+
+			/*
+			 * Override entries in o_bits->ftr_bits with the
+			 * saved ones, and update bits->ftr_bits with
+			 * o_bits->ftr_bits.
+			 */
+			arm64_ftr_reg_bits_override(o_bits->ftr_bits, ftr_temp);
+			bits->ftr_bits = o_bits->ftr_bits;
+			break;
+		}
+	}
+}
+
+static int search_cmp_ftr_reg_bits(const void *id, const void *regp)
+{
+	return ((int)(unsigned long)id -
+		(int)((const struct __ftr_reg_bits_entry *)regp)->sys_id);
+}
+
+static const struct arm64_ftr_bits *get_arm64_ftr_bits_kvm(u32 sys_id)
+{
+	const struct __ftr_reg_bits_entry *ret;
+
+	ret = bsearch((const void *)(unsigned long)sys_id,
+		      arm64_ftr_bits_kvm,
+		      ARRAY_SIZE(arm64_ftr_bits_kvm),
+		      sizeof(arm64_ftr_bits_kvm[0]),
+		      search_cmp_ftr_reg_bits);
+	if (ret)
+		return ret->ftr_bits;
+
+	return NULL;
+}
+
+/*
+ * Check if features (or levels of features) that are indicated in the ID
+ * register value @val are also indicated in @limit.
+ * This function is for KVM to check if features that are indicated in @val,
+ * which will be used as the ID register value for its guest, are supported
+ * on the host.
+ * For AA64MMFR0_EL1.TGranX_2 fields, which don't follow the standard ID
+ * scheme, the function checks if values of the fields in @val are the same
+ * as the ones in @limit.
+ */
+int arm64_check_features_kvm(u32 sys_reg, u64 val, u64 limit)
+{
+	const struct arm64_ftr_bits *ftrp = get_arm64_ftr_bits_kvm(sys_reg);
+	u64 exposed_mask = 0;
+
+	if (!ftrp)
+		return -ENOENT;
+
+	for (; ftrp->width; ftrp++) {
+		s64 ftr_val = arm64_ftr_value(ftrp, val);
+		s64 ftr_lim = arm64_ftr_value(ftrp, limit);
+
+		exposed_mask |= arm64_ftr_mask(ftrp);
+
+		if (ftr_val == ftr_lim)
+			continue;
+
+		if (ftr_val != arm64_ftr_safe_value(ftrp, ftr_val, ftr_lim))
+			return -E2BIG;
+	}
+
+	/* Make sure that no unrecognized fields are set in @val. */
+	if (val & ~exposed_mask)
+		return -E2BIG;
+
+	return 0;
+}
+#endif /* CONFIG_KVM */
-- 
2.35.1.265.g69c8d7142f-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
