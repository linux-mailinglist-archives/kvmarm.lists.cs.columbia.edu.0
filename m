Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0838A42BF7F
	for <lists+kvmarm@lfdr.de>; Wed, 13 Oct 2021 14:04:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AB18F4B129;
	Wed, 13 Oct 2021 08:04:13 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n62Hhg9DWdu5; Wed, 13 Oct 2021 08:04:13 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1A2FC4B0FB;
	Wed, 13 Oct 2021 08:04:09 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2A1704B11E
 for <kvmarm@lists.cs.columbia.edu>; Wed, 13 Oct 2021 08:04:06 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WgnX5LDS3LBu for <kvmarm@lists.cs.columbia.edu>;
 Wed, 13 Oct 2021 08:04:01 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id F13BF4B0DB
 for <kvmarm@lists.cs.columbia.edu>; Wed, 13 Oct 2021 08:04:00 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 22EA9610D0;
 Wed, 13 Oct 2021 12:04:00 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1maczG-00GTgY-Ba; Wed, 13 Oct 2021 13:03:58 +0100
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v9 13/22] KVM: arm64: pkvm: Use a single function to expose
 all id-regs
Date: Wed, 13 Oct 2021 13:03:37 +0100
Message-Id: <20211013120346.2926621-3-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211013120346.2926621-1-maz@kernel.org>
References: <20211010145636.1950948-12-tabba@google.com>
 <20211013120346.2926621-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, will@kernel.org, james.morse@arm.com,
 alexandru.elisei@arm.com, suzuki.poulose@arm.com, mark.rutland@arm.com,
 pbonzini@redhat.com, drjones@redhat.com, oupton@google.com, qperret@google.com,
 kernel-team@android.com, tabba@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, pbonzini@redhat.com, will@kernel.org
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

Rather than exposing a whole set of helper functions to retrieve
individual ID registers, use the existing decoding tree and expose
a single helper instead.

This allow a number of functions to be made static, and we now
have a single entry point to maintain.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kvm/hyp/include/nvhe/sys_regs.h | 14 +-------
 arch/arm64/kvm/hyp/nvhe/pkvm.c             | 10 +++---
 arch/arm64/kvm/hyp/nvhe/sys_regs.c         | 37 ++++++++++++----------
 3 files changed, 26 insertions(+), 35 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/sys_regs.h b/arch/arm64/kvm/hyp/include/nvhe/sys_regs.h
index 3288128738aa..8adc13227b1a 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/sys_regs.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/sys_regs.h
@@ -9,19 +9,7 @@
 
 #include <asm/kvm_host.h>
 
-u64 get_pvm_id_aa64pfr0(const struct kvm_vcpu *vcpu);
-u64 get_pvm_id_aa64pfr1(const struct kvm_vcpu *vcpu);
-u64 get_pvm_id_aa64zfr0(const struct kvm_vcpu *vcpu);
-u64 get_pvm_id_aa64dfr0(const struct kvm_vcpu *vcpu);
-u64 get_pvm_id_aa64dfr1(const struct kvm_vcpu *vcpu);
-u64 get_pvm_id_aa64afr0(const struct kvm_vcpu *vcpu);
-u64 get_pvm_id_aa64afr1(const struct kvm_vcpu *vcpu);
-u64 get_pvm_id_aa64isar0(const struct kvm_vcpu *vcpu);
-u64 get_pvm_id_aa64isar1(const struct kvm_vcpu *vcpu);
-u64 get_pvm_id_aa64mmfr0(const struct kvm_vcpu *vcpu);
-u64 get_pvm_id_aa64mmfr1(const struct kvm_vcpu *vcpu);
-u64 get_pvm_id_aa64mmfr2(const struct kvm_vcpu *vcpu);
-
+u64 pvm_read_id_reg(const struct kvm_vcpu *vcpu, u32 id);
 bool kvm_handle_pvm_sysreg(struct kvm_vcpu *vcpu, u64 *exit_code);
 int kvm_check_pvm_sysreg_table(void);
 void inject_undef64(struct kvm_vcpu *vcpu);
diff --git a/arch/arm64/kvm/hyp/nvhe/pkvm.c b/arch/arm64/kvm/hyp/nvhe/pkvm.c
index 633547cc1033..62377fa8a4cb 100644
--- a/arch/arm64/kvm/hyp/nvhe/pkvm.c
+++ b/arch/arm64/kvm/hyp/nvhe/pkvm.c
@@ -15,7 +15,7 @@
  */
 static void pvm_init_traps_aa64pfr0(struct kvm_vcpu *vcpu)
 {
-	const u64 feature_ids = get_pvm_id_aa64pfr0(vcpu);
+	const u64 feature_ids = pvm_read_id_reg(vcpu, SYS_ID_AA64PFR0_EL1);
 	u64 hcr_set = HCR_RW;
 	u64 hcr_clear = 0;
 	u64 cptr_set = 0;
@@ -62,7 +62,7 @@ static void pvm_init_traps_aa64pfr0(struct kvm_vcpu *vcpu)
  */
 static void pvm_init_traps_aa64pfr1(struct kvm_vcpu *vcpu)
 {
-	const u64 feature_ids = get_pvm_id_aa64pfr1(vcpu);
+	const u64 feature_ids = pvm_read_id_reg(vcpu, SYS_ID_AA64PFR1_EL1);
 	u64 hcr_set = 0;
 	u64 hcr_clear = 0;
 
@@ -81,7 +81,7 @@ static void pvm_init_traps_aa64pfr1(struct kvm_vcpu *vcpu)
  */
 static void pvm_init_traps_aa64dfr0(struct kvm_vcpu *vcpu)
 {
-	const u64 feature_ids = get_pvm_id_aa64dfr0(vcpu);
+	const u64 feature_ids = pvm_read_id_reg(vcpu, SYS_ID_AA64DFR0_EL1);
 	u64 mdcr_set = 0;
 	u64 mdcr_clear = 0;
 	u64 cptr_set = 0;
@@ -125,7 +125,7 @@ static void pvm_init_traps_aa64dfr0(struct kvm_vcpu *vcpu)
  */
 static void pvm_init_traps_aa64mmfr0(struct kvm_vcpu *vcpu)
 {
-	const u64 feature_ids = get_pvm_id_aa64mmfr0(vcpu);
+	const u64 feature_ids = pvm_read_id_reg(vcpu, SYS_ID_AA64MMFR0_EL1);
 	u64 mdcr_set = 0;
 
 	/* Trap Debug Communications Channel registers */
@@ -140,7 +140,7 @@ static void pvm_init_traps_aa64mmfr0(struct kvm_vcpu *vcpu)
  */
 static void pvm_init_traps_aa64mmfr1(struct kvm_vcpu *vcpu)
 {
-	const u64 feature_ids = get_pvm_id_aa64mmfr1(vcpu);
+	const u64 feature_ids = pvm_read_id_reg(vcpu, SYS_ID_AA64MMFR1_EL1);
 	u64 hcr_set = 0;
 
 	/* Trap LOR */
diff --git a/arch/arm64/kvm/hyp/nvhe/sys_regs.c b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
index 6bde2dc5205c..f125d6a52880 100644
--- a/arch/arm64/kvm/hyp/nvhe/sys_regs.c
+++ b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
@@ -82,7 +82,7 @@ static u64 get_restricted_features_unsigned(u64 sys_reg_val,
  * based on allowed features, system features, and KVM support.
  */
 
-u64 get_pvm_id_aa64pfr0(const struct kvm_vcpu *vcpu)
+static u64 get_pvm_id_aa64pfr0(const struct kvm_vcpu *vcpu)
 {
 	const struct kvm *kvm = (const struct kvm *)kern_hyp_va(vcpu->kvm);
 	u64 set_mask = 0;
@@ -103,7 +103,7 @@ u64 get_pvm_id_aa64pfr0(const struct kvm_vcpu *vcpu)
 	return (id_aa64pfr0_el1_sys_val & allow_mask) | set_mask;
 }
 
-u64 get_pvm_id_aa64pfr1(const struct kvm_vcpu *vcpu)
+static u64 get_pvm_id_aa64pfr1(const struct kvm_vcpu *vcpu)
 {
 	const struct kvm *kvm = (const struct kvm *)kern_hyp_va(vcpu->kvm);
 	u64 allow_mask = PVM_ID_AA64PFR1_ALLOW;
@@ -114,7 +114,7 @@ u64 get_pvm_id_aa64pfr1(const struct kvm_vcpu *vcpu)
 	return id_aa64pfr1_el1_sys_val & allow_mask;
 }
 
-u64 get_pvm_id_aa64zfr0(const struct kvm_vcpu *vcpu)
+static u64 get_pvm_id_aa64zfr0(const struct kvm_vcpu *vcpu)
 {
 	/*
 	 * No support for Scalable Vectors, therefore, hyp has no sanitized
@@ -124,7 +124,7 @@ u64 get_pvm_id_aa64zfr0(const struct kvm_vcpu *vcpu)
 	return 0;
 }
 
-u64 get_pvm_id_aa64dfr0(const struct kvm_vcpu *vcpu)
+static u64 get_pvm_id_aa64dfr0(const struct kvm_vcpu *vcpu)
 {
 	/*
 	 * No support for debug, including breakpoints, and watchpoints,
@@ -134,7 +134,7 @@ u64 get_pvm_id_aa64dfr0(const struct kvm_vcpu *vcpu)
 	return 0;
 }
 
-u64 get_pvm_id_aa64dfr1(const struct kvm_vcpu *vcpu)
+static u64 get_pvm_id_aa64dfr1(const struct kvm_vcpu *vcpu)
 {
 	/*
 	 * No support for debug, therefore, hyp has no sanitized copy of the
@@ -144,7 +144,7 @@ u64 get_pvm_id_aa64dfr1(const struct kvm_vcpu *vcpu)
 	return 0;
 }
 
-u64 get_pvm_id_aa64afr0(const struct kvm_vcpu *vcpu)
+static u64 get_pvm_id_aa64afr0(const struct kvm_vcpu *vcpu)
 {
 	/*
 	 * No support for implementation defined features, therefore, hyp has no
@@ -154,7 +154,7 @@ u64 get_pvm_id_aa64afr0(const struct kvm_vcpu *vcpu)
 	return 0;
 }
 
-u64 get_pvm_id_aa64afr1(const struct kvm_vcpu *vcpu)
+static u64 get_pvm_id_aa64afr1(const struct kvm_vcpu *vcpu)
 {
 	/*
 	 * No support for implementation defined features, therefore, hyp has no
@@ -164,12 +164,12 @@ u64 get_pvm_id_aa64afr1(const struct kvm_vcpu *vcpu)
 	return 0;
 }
 
-u64 get_pvm_id_aa64isar0(const struct kvm_vcpu *vcpu)
+static u64 get_pvm_id_aa64isar0(const struct kvm_vcpu *vcpu)
 {
 	return id_aa64isar0_el1_sys_val & PVM_ID_AA64ISAR0_ALLOW;
 }
 
-u64 get_pvm_id_aa64isar1(const struct kvm_vcpu *vcpu)
+static u64 get_pvm_id_aa64isar1(const struct kvm_vcpu *vcpu)
 {
 	u64 allow_mask = PVM_ID_AA64ISAR1_ALLOW;
 
@@ -182,7 +182,7 @@ u64 get_pvm_id_aa64isar1(const struct kvm_vcpu *vcpu)
 	return id_aa64isar1_el1_sys_val & allow_mask;
 }
 
-u64 get_pvm_id_aa64mmfr0(const struct kvm_vcpu *vcpu)
+static u64 get_pvm_id_aa64mmfr0(const struct kvm_vcpu *vcpu)
 {
 	u64 set_mask;
 
@@ -192,22 +192,19 @@ u64 get_pvm_id_aa64mmfr0(const struct kvm_vcpu *vcpu)
 	return (id_aa64mmfr0_el1_sys_val & PVM_ID_AA64MMFR0_ALLOW) | set_mask;
 }
 
-u64 get_pvm_id_aa64mmfr1(const struct kvm_vcpu *vcpu)
+static u64 get_pvm_id_aa64mmfr1(const struct kvm_vcpu *vcpu)
 {
 	return id_aa64mmfr1_el1_sys_val & PVM_ID_AA64MMFR1_ALLOW;
 }
 
-u64 get_pvm_id_aa64mmfr2(const struct kvm_vcpu *vcpu)
+static u64 get_pvm_id_aa64mmfr2(const struct kvm_vcpu *vcpu)
 {
 	return id_aa64mmfr2_el1_sys_val & PVM_ID_AA64MMFR2_ALLOW;
 }
 
-/* Read a sanitized cpufeature ID register by its sys_reg_desc. */
-static u64 read_id_reg(const struct kvm_vcpu *vcpu,
-		       struct sys_reg_desc const *r)
+/* Read a sanitized cpufeature ID register by its encoding */
+u64 pvm_read_id_reg(const struct kvm_vcpu *vcpu, u32 id)
 {
-	u32 id = reg_to_encoding(r);
-
 	switch (id) {
 	case SYS_ID_AA64PFR0_EL1:
 		return get_pvm_id_aa64pfr0(vcpu);
@@ -245,6 +242,12 @@ static u64 read_id_reg(const struct kvm_vcpu *vcpu,
 	return 0;
 }
 
+static u64 read_id_reg(const struct kvm_vcpu *vcpu,
+		       struct sys_reg_desc const *r)
+{
+	return pvm_read_id_reg(vcpu, reg_to_encoding(r));
+}
+
 /*
  * Accessor for AArch32 feature id registers.
  *
-- 
2.30.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
