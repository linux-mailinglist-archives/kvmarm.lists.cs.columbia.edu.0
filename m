Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C2AAD4D59E4
	for <lists+kvmarm@lfdr.de>; Fri, 11 Mar 2022 05:48:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4807549EAA;
	Thu, 10 Mar 2022 23:48:49 -0500 (EST)
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
	with ESMTP id MkTeo+rqJ9qL; Thu, 10 Mar 2022 23:48:47 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7706B49EF7;
	Thu, 10 Mar 2022 23:48:45 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8FD3E43479
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Mar 2022 23:48:44 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eKrIgG9lm1R8 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 10 Mar 2022 23:48:40 -0500 (EST)
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com
 [209.85.215.201])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D88CC49EBA
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Mar 2022 23:48:38 -0500 (EST)
Received: by mail-pg1-f201.google.com with SMTP id
 s5-20020a637705000000b00380cf1d3eb0so2962231pgc.5
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Mar 2022 20:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=IfOAE6MJtteJteQ/p4KBnqsn47ZknQ3Y2Evrog9PWzk=;
 b=aNHErz1fYG8L0XyouO5mJBzMVcDScmn3AExGM23ftL0XruZGC91v4Z7iTti8nYELwg
 TvJIHEa3l3pYL4CpUFwU2UpL6reUMmGozwyazWND4VVEqUC1L4ekPA0PiWJAJNKVFFiL
 TfTCLIVX1j0OXgn/v1UYMqcdKHDV874Cp6bbF79E8aQS4lMHxo5CgRR1et7IWse/sqll
 xVXHIAP18Y+a8wt9Mq/J5Fc8K7ghc4n8aicZ6Wxm98tU3oNBnPGVCDFCVzG7NPSPDnlt
 e09PKH72PObKpRmRsfp03zTR2TL7gtDYQbgcit8V5KzeQ+VvrBLdOsTRto1Wf0Sc5K+Z
 08IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=IfOAE6MJtteJteQ/p4KBnqsn47ZknQ3Y2Evrog9PWzk=;
 b=o+ox5CABKwGCVvfwBZlNRkBBZrmoujPB+9n5hckX737oNkC3bbiyUVdQpbDFoGUUeY
 r6za2GWzNgp3VXlxPoCYNBmXE/EBWeTKRXEHbtWuf1ZhX1VK22vMwCrN9m7UgqZzaKXW
 tbHI62kiUB+ULZ0bsHb+xvVaIycvK3K8raud/KNc+mp8/YPPGuqxXLTKrqF0aUDO2I/5
 jewKph07G2QRn4ibgrRk7ZsnxB+MQW8qE1FRWsM0/igqEu/1GO0eAIliQbnG8DKrUGOV
 HNgUfV9E1U+vzTsK5zJEKaGF1Pcq1SYgq9i0Cpz7Pvc56zyXmvPtp65GAFTIc89HenJT
 eaqg==
X-Gm-Message-State: AOAM533yjqqQJqazTVKOCdOgfI/5j6ZOf/EVXzVPyhslZuReou1bStzg
 xPGt8r+GUlAhjis34fgMe97B+POcyWo=
X-Google-Smtp-Source: ABdhPJwzfMcbrbgEtWV/95s64C/nKBD98oj5MQcWhr+sUPoX7DU0Px+/aQ/WIu8v7SyVMjKEcawv73k42YE=
X-Received: from reiji-vws-sp.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:3d59])
 (user=reijiw job=sendgmr) by 2002:a17:90b:3a91:b0:1bf:261e:7773 with SMTP id
 om17-20020a17090b3a9100b001bf261e7773mr19724859pjb.155.1646974118011; Thu, 10
 Mar 2022 20:48:38 -0800 (PST)
Date: Thu, 10 Mar 2022 20:47:50 -0800
In-Reply-To: <20220311044811.1980336-1-reijiw@google.com>
Message-Id: <20220311044811.1980336-5-reijiw@google.com>
Mime-Version: 1.0
References: <20220311044811.1980336-1-reijiw@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [PATCH v6 04/25] KVM: arm64: Make ID_AA64PFR0_EL1 writable
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

This patch adds id_reg_desc for ID_AA64PFR0_EL1 to make it writable by
userspace.

Return an error if userspace tries to set SVE/GIC field of the register
to a value that conflicts with SVE/GIC configuration for the guest.
SIMD/FP/SVE fields of the requested value are validated according to
Arm ARM.

Signed-off-by: Reiji Watanabe <reijiw@google.com>
---
 arch/arm64/include/asm/sysreg.h |   1 +
 arch/arm64/kvm/sys_regs.c       | 156 ++++++++++++++++++++------------
 arch/arm64/kvm/vgic/vgic-init.c |   9 ++
 3 files changed, 107 insertions(+), 59 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 2c9d8c0a3b75..84edc87f0005 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -813,6 +813,7 @@
 #define ID_AA64PFR0_ASIMD_SUPPORTED	0x0
 #define ID_AA64PFR0_ELx_64BIT_ONLY	0x1
 #define ID_AA64PFR0_ELx_32BIT_64BIT	0x2
+#define ID_AA64PFR0_GIC3		0x1
 
 /* id_aa64pfr1 */
 #define ID_AA64PFR1_MPAMFRAC_SHIFT	16
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 6305c2622c32..9e9fa90afb82 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -330,6 +330,87 @@ static void id_reg_desc_init(struct id_reg_desc *id_reg)
 	WARN_ON_ONCE(arm64_check_features_kvm(id, id_reg->vcpu_limit_val, val));
 }
 
+static int validate_id_aa64pfr0_el1(struct kvm_vcpu *vcpu,
+				    const struct id_reg_desc *id_reg, u64 val)
+{
+	int fp, simd;
+	unsigned int gic;
+	bool vcpu_has_sve = vcpu_has_sve(vcpu);
+	bool pfr0_has_sve = id_aa64pfr0_sve(val);
+
+	simd = cpuid_feature_extract_signed_field(val, ID_AA64PFR0_ASIMD_SHIFT);
+	fp = cpuid_feature_extract_signed_field(val, ID_AA64PFR0_FP_SHIFT);
+	/* AdvSIMD field must have the same value as FP field */
+	if (simd != fp)
+		return -EINVAL;
+
+	/* fp must be supported when sve is supported */
+	if (pfr0_has_sve && (fp < 0))
+		return -EINVAL;
+
+	/* Check if there is a conflict with a request via KVM_ARM_VCPU_INIT */
+	if (vcpu_has_sve ^ pfr0_has_sve)
+		return -EPERM;
+
+	if ((irqchip_in_kernel(vcpu->kvm) &&
+	     vcpu->kvm->arch.vgic.vgic_model == KVM_DEV_TYPE_ARM_VGIC_V3)) {
+		gic = cpuid_feature_extract_unsigned_field(val,
+							ID_AA64PFR0_GIC_SHIFT);
+		if (gic == 0)
+			return -EPERM;
+
+		if (gic > ID_AA64PFR0_GIC3)
+			return -E2BIG;
+	} else {
+		u32 id = reg_to_encoding(&id_reg->reg_desc);
+		u64 mask = ARM64_FEATURE_MASK(ID_AA64PFR0_GIC);
+		int r = arm64_check_features_kvm(id, val & mask,
+						 id_reg->vcpu_limit_val & mask);
+
+		if (r)
+			return r;
+	}
+
+	return 0;
+}
+
+static void init_id_aa64pfr0_el1_desc(struct id_reg_desc *id_reg)
+{
+	u64 limit = id_reg->vcpu_limit_val;
+	unsigned int gic;
+
+	limit &= ~ARM64_FEATURE_MASK(ID_AA64PFR0_AMU);
+	if (!system_supports_sve())
+		limit &= ~ARM64_FEATURE_MASK(ID_AA64PFR0_SVE);
+
+	/*
+	 * The default is to expose CSV2 == 1 and CSV3 == 1 if the HW
+	 * isn't affected.  Userspace can override this as long as it
+	 * doesn't promise the impossible.
+	 */
+	limit &= ~(ARM64_FEATURE_MASK(ID_AA64PFR0_CSV2) |
+		   ARM64_FEATURE_MASK(ID_AA64PFR0_CSV3));
+
+	if (arm64_get_spectre_v2_state() == SPECTRE_UNAFFECTED)
+		limit |= FIELD_PREP(ARM64_FEATURE_MASK(ID_AA64PFR0_CSV2), 1);
+	if (arm64_get_meltdown_state() == SPECTRE_UNAFFECTED)
+		limit |= FIELD_PREP(ARM64_FEATURE_MASK(ID_AA64PFR0_CSV3), 1);
+
+	gic = cpuid_feature_extract_unsigned_field(limit, ID_AA64PFR0_GIC_SHIFT);
+	if (gic > 1) {
+		/* Limit to GICv3.0/4.0 */
+		limit &= ~ARM64_FEATURE_MASK(ID_AA64PFR0_GIC);
+		limit |= FIELD_PREP(ARM64_FEATURE_MASK(ID_AA64PFR0_GIC), ID_AA64PFR0_GIC3);
+	}
+	id_reg->vcpu_limit_val = limit;
+}
+
+static u64 vcpu_mask_id_aa64pfr0_el1(const struct kvm_vcpu *vcpu,
+					 const struct id_reg_desc *idr)
+{
+	return vcpu_has_sve(vcpu) ? 0 : ARM64_FEATURE_MASK(ID_AA64PFR0_SVE);
+}
+
 static int validate_id_reg(struct kvm_vcpu *vcpu,
 			   const struct id_reg_desc *id_reg, u64 val)
 {
@@ -1263,20 +1344,6 @@ static u64 read_id_reg_with_encoding(const struct kvm_vcpu *vcpu, u32 id)
 
 	val = read_kvm_id_reg(vcpu->kvm, id);
 	switch (id) {
-	case SYS_ID_AA64PFR0_EL1:
-		if (!vcpu_has_sve(vcpu))
-			val &= ~ARM64_FEATURE_MASK(ID_AA64PFR0_SVE);
-		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR0_AMU);
-		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR0_CSV2);
-		val |= FIELD_PREP(ARM64_FEATURE_MASK(ID_AA64PFR0_CSV2), (u64)vcpu->kvm->arch.pfr0_csv2);
-		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR0_CSV3);
-		val |= FIELD_PREP(ARM64_FEATURE_MASK(ID_AA64PFR0_CSV3), (u64)vcpu->kvm->arch.pfr0_csv3);
-		if (irqchip_in_kernel(vcpu->kvm) &&
-		    vcpu->kvm->arch.vgic.vgic_model == KVM_DEV_TYPE_ARM_VGIC_V3) {
-			val &= ~ARM64_FEATURE_MASK(ID_AA64PFR0_GIC);
-			val |= FIELD_PREP(ARM64_FEATURE_MASK(ID_AA64PFR0_GIC), 1);
-		}
-		break;
 	case SYS_ID_AA64PFR1_EL1:
 		if (!kvm_has_mte(vcpu->kvm))
 			val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_MTE);
@@ -1375,48 +1442,6 @@ static unsigned int sve_visibility(const struct kvm_vcpu *vcpu,
 	return REG_HIDDEN;
 }
 
-static int set_id_aa64pfr0_el1(struct kvm_vcpu *vcpu,
-			       const struct sys_reg_desc *rd,
-			       const struct kvm_one_reg *reg, void __user *uaddr)
-{
-	const u64 id = sys_reg_to_index(rd);
-	u8 csv2, csv3;
-	int err;
-	u64 val;
-
-	err = reg_from_user(&val, uaddr, id);
-	if (err)
-		return err;
-
-	/*
-	 * Allow AA64PFR0_EL1.CSV2 to be set from userspace as long as
-	 * it doesn't promise more than what is actually provided (the
-	 * guest could otherwise be covered in ectoplasmic residue).
-	 */
-	csv2 = cpuid_feature_extract_unsigned_field(val, ID_AA64PFR0_CSV2_SHIFT);
-	if (csv2 > 1 ||
-	    (csv2 && arm64_get_spectre_v2_state() != SPECTRE_UNAFFECTED))
-		return -EINVAL;
-
-	/* Same thing for CSV3 */
-	csv3 = cpuid_feature_extract_unsigned_field(val, ID_AA64PFR0_CSV3_SHIFT);
-	if (csv3 > 1 ||
-	    (csv3 && arm64_get_meltdown_state() != SPECTRE_UNAFFECTED))
-		return -EINVAL;
-
-	/* We can only differ with CSV[23], and anything else is an error */
-	val ^= read_id_reg(vcpu, rd, false);
-	val &= ~((0xFUL << ID_AA64PFR0_CSV2_SHIFT) |
-		 (0xFUL << ID_AA64PFR0_CSV3_SHIFT));
-	if (val)
-		return -EINVAL;
-
-	vcpu->kvm->arch.pfr0_csv2 = csv2;
-	vcpu->kvm->arch.pfr0_csv3 = csv3 ;
-
-	return 0;
-}
-
 /* cpufeature ID register user accessors */
 static int __get_id_reg(const struct kvm_vcpu *vcpu,
 			const struct sys_reg_desc *rd, void __user *uaddr,
@@ -1736,8 +1761,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 
 	/* AArch64 ID registers */
 	/* CRm=4 */
-	{ SYS_DESC(SYS_ID_AA64PFR0_EL1), .access = access_id_reg,
-	  .get_user = get_id_reg, .set_user = set_id_aa64pfr0_el1, },
+	ID_SANITISED(ID_AA64PFR0_EL1),
 	ID_SANITISED(ID_AA64PFR1_EL1),
 	ID_UNALLOCATED(4,2),
 	ID_UNALLOCATED(4,3),
@@ -3102,8 +3126,22 @@ int kvm_set_id_reg_feature(struct kvm *kvm, u32 id, u8 field_shift, u8 fval)
 	return __modify_kvm_id_reg(kvm, id, val, preserve_mask);
 }
 
+static struct id_reg_desc id_aa64pfr0_el1_desc = {
+	.reg_desc = ID_SANITISED(ID_AA64PFR0_EL1),
+	.ignore_mask = ARM64_FEATURE_MASK(ID_AA64PFR0_GIC),
+	.init = init_id_aa64pfr0_el1_desc,
+	.validate = validate_id_aa64pfr0_el1,
+	.vcpu_mask = vcpu_mask_id_aa64pfr0_el1,
+};
+
+#define ID_DESC(id_reg_name, id_reg_desc)	\
+	[IDREG_IDX(SYS_##id_reg_name)] = (id_reg_desc)
+
 /* A table for ID registers's information. */
-static struct id_reg_desc *id_reg_desc_table[KVM_ARM_ID_REG_MAX_NUM] = {};
+static struct id_reg_desc *id_reg_desc_table[KVM_ARM_ID_REG_MAX_NUM] = {
+	/* CRm=4 */
+	ID_DESC(ID_AA64PFR0_EL1, &id_aa64pfr0_el1_desc),
+};
 
 static inline struct id_reg_desc *get_id_reg_desc(u32 id)
 {
diff --git a/arch/arm64/kvm/vgic/vgic-init.c b/arch/arm64/kvm/vgic/vgic-init.c
index fc00304fe7d8..f0632b46fbf9 100644
--- a/arch/arm64/kvm/vgic/vgic-init.c
+++ b/arch/arm64/kvm/vgic/vgic-init.c
@@ -117,6 +117,15 @@ int kvm_vgic_create(struct kvm *kvm, u32 type)
 	else
 		INIT_LIST_HEAD(&kvm->arch.vgic.rd_regions);
 
+	if (type == KVM_DEV_TYPE_ARM_VGIC_V3)
+		/*
+		 * Set ID_AA64PFR0_EL1.GIC to 1.  This shouldn't fail unless
+		 * any vCPU in the guest have started.
+		 */
+		WARN_ON_ONCE(kvm_set_id_reg_feature(kvm, SYS_ID_AA64PFR0_EL1,
+						    ID_AA64PFR0_GIC3,
+						    ID_AA64PFR0_GIC_SHIFT));
+
 out_unlock:
 	unlock_all_vcpus(kvm);
 	return ret;
-- 
2.35.1.723.g4982287a31-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
