Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BCCF954620D
	for <lists+kvmarm@lfdr.de>; Fri, 10 Jun 2022 11:29:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 52EE14B3B8;
	Fri, 10 Jun 2022 05:29:06 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8M75di5xN+xP; Fri, 10 Jun 2022 05:29:04 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 173D14B3FC;
	Fri, 10 Jun 2022 05:29:01 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 14C0B4B3CC
 for <kvmarm@lists.cs.columbia.edu>; Fri, 10 Jun 2022 05:29:00 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fbv7ffweu4IR for <kvmarm@lists.cs.columbia.edu>;
 Fri, 10 Jun 2022 05:28:58 -0400 (EDT)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 7BC8B4B3B1
 for <kvmarm@lists.cs.columbia.edu>; Fri, 10 Jun 2022 05:28:58 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id E750F61EF6;
 Fri, 10 Jun 2022 09:28:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96456C3411D;
 Fri, 10 Jun 2022 09:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1654853337;
 bh=4ckXcuO+B/l9iJLZl+doV3AabOXpAFkDbMaPdb0HKSw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GnB9hGvAA2ElIeyxXBYS7hnfzivPtl6/qmuGHXY1neeOqRBMQkwE7UOuqOR2BTd5E
 GwZUnyze5LVJYnx94rENs9NIgoynKwKQQuA+pxly8dEOGtSjAllj2S0xT61RxufeBg
 3A3YGkVS4TKg4XnPCWMRaMGHbBUlItQlQdsRq9yfLLgtR8bc9z9x//+UBy6LlFPBG2
 AE+cU+UbiR+FNwnX3kq45XKrm8+uFYpuF51VqmmE8GrSPkQcnOYW9jeD4/ovYvsaCD
 B8hVGAtxA4k+/+3ZuxQHD8yB1aO8WC9OFRcxZsUe8m1bjJZEJcJtDsd3gbbTHeAe5R
 JEqVz52QZWC3A==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1nzawp-00H6Dt-LP; Fri, 10 Jun 2022 10:28:55 +0100
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 08/19] KVM: arm64: Move vcpu PC/Exception flags to the
 input flag set
Date: Fri, 10 Jun 2022 10:28:27 +0100
Message-Id: <20220610092838.1205755-9-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220610092838.1205755-1-maz@kernel.org>
References: <20220610092838.1205755-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, james.morse@arm.com,
 suzuki.poulose@arm.com, alexandru.elisei@arm.com, oupton@google.com,
 will@kernel.org, tabba@google.com, qperret@google.com, broonie@kernel.org,
 reijiw@google.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, Will Deacon <will@kernel.org>,
 Mark Brown <broonie@kernel.org>
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

The PC update flags (which also deal with exception injection)
is one of the most complicated use of the flag we have. Make it
more fool prof by:

- moving it over to the new accessors and assign it to the
  input flag set

- turn the combination of generic ELx flags with another flag
  indicating the target EL itself into an explicit set of
  flags for each EL and vector combination

- add a new accessor to pend the exception

This is otherwise a pretty straightformward conversion.

Reviewed-by: Fuad Tabba <tabba@google.com>
Reviewed-by: Reiji Watanabe <reijiw@google.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/kvm_emulate.h |  9 ++++-
 arch/arm64/include/asm/kvm_host.h    | 58 ++++++++++++++++------------
 arch/arm64/kvm/arm.c                 |  4 +-
 arch/arm64/kvm/hyp/exception.c       | 23 ++++++-----
 arch/arm64/kvm/hyp/nvhe/sys_regs.c   |  4 +-
 arch/arm64/kvm/inject_fault.c        | 17 +++-----
 6 files changed, 61 insertions(+), 54 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 0e66edd3aff2..6ec58080ece8 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -473,9 +473,16 @@ static inline unsigned long vcpu_data_host_to_guest(struct kvm_vcpu *vcpu,
 
 static __always_inline void kvm_incr_pc(struct kvm_vcpu *vcpu)
 {
-	vcpu->arch.flags |= KVM_ARM64_INCREMENT_PC;
+	vcpu_set_flag(vcpu, INCREMENT_PC);
 }
 
+#define kvm_pend_exception(v, e)					\
+	do {								\
+		vcpu_set_flag((v), PENDING_EXCEPTION);			\
+		vcpu_set_flag((v), e);					\
+	} while (0)
+
+
 static inline bool vcpu_has_feature(struct kvm_vcpu *vcpu, int feature)
 {
 	return test_bit(feature, vcpu->arch.features);
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 66a08b0e12a8..db42b4c06449 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -474,6 +474,40 @@ struct kvm_vcpu_arch {
 /* PTRAUTH exposed to guest */
 #define GUEST_HAS_PTRAUTH	__vcpu_single_flag(cflags, BIT(2))
 
+/* Exception pending */
+#define PENDING_EXCEPTION	__vcpu_single_flag(iflags, BIT(0))
+/*
+ * PC increment. Overlaps with EXCEPT_MASK on purpose so that it can't
+ * be set together with an exception...
+ */
+#define INCREMENT_PC		__vcpu_single_flag(iflags, BIT(1))
+/* Target EL/MODE (not a single flag, but let's abuse the macro) */
+#define EXCEPT_MASK		__vcpu_single_flag(iflags, GENMASK(3, 1))
+
+/* Helpers to encode exceptions with minimum fuss */
+#define __EXCEPT_MASK_VAL	unpack_vcpu_flag(EXCEPT_MASK)
+#define __EXCEPT_SHIFT		__builtin_ctzl(__EXCEPT_MASK_VAL)
+#define __vcpu_except_flags(_f)	iflags, (_f << __EXCEPT_SHIFT), __EXCEPT_MASK_VAL
+
+/*
+ * When PENDING_EXCEPTION is set, EXCEPT_MASK can take the following
+ * values:
+ *
+ * For AArch32 EL1:
+ */
+#define EXCEPT_AA32_UND		__vcpu_except_flags(0)
+#define EXCEPT_AA32_IABT	__vcpu_except_flags(1)
+#define EXCEPT_AA32_DABT	__vcpu_except_flags(2)
+/* For AArch64: */
+#define EXCEPT_AA64_EL1_SYNC	__vcpu_except_flags(0)
+#define EXCEPT_AA64_EL1_IRQ	__vcpu_except_flags(1)
+#define EXCEPT_AA64_EL1_FIQ	__vcpu_except_flags(2)
+#define EXCEPT_AA64_EL1_SERR	__vcpu_except_flags(3)
+/* For AArch64 with NV (one day): */
+#define EXCEPT_AA64_EL2_SYNC	__vcpu_except_flags(4)
+#define EXCEPT_AA64_EL2_IRQ	__vcpu_except_flags(5)
+#define EXCEPT_AA64_EL2_FIQ	__vcpu_except_flags(6)
+#define EXCEPT_AA64_EL2_SERR	__vcpu_except_flags(7)
 
 /* Pointer to the vcpu's SVE FFR for sve_{save,load}_state() */
 #define vcpu_sve_pffr(vcpu) (kern_hyp_va((vcpu)->arch.sve_state) +	\
@@ -498,30 +532,6 @@ struct kvm_vcpu_arch {
 /* vcpu_arch flags field values: */
 #define KVM_ARM64_DEBUG_DIRTY		(1 << 0)
 #define KVM_ARM64_HOST_SVE_ENABLED	(1 << 4) /* SVE enabled for EL0 */
-#define KVM_ARM64_PENDING_EXCEPTION	(1 << 8) /* Exception pending */
-/*
- * Overlaps with KVM_ARM64_EXCEPT_MASK on purpose so that it can't be
- * set together with an exception...
- */
-#define KVM_ARM64_INCREMENT_PC		(1 << 9) /* Increment PC */
-#define KVM_ARM64_EXCEPT_MASK		(7 << 9) /* Target EL/MODE */
-/*
- * When KVM_ARM64_PENDING_EXCEPTION is set, KVM_ARM64_EXCEPT_MASK can
- * take the following values:
- *
- * For AArch32 EL1:
- */
-#define KVM_ARM64_EXCEPT_AA32_UND	(0 << 9)
-#define KVM_ARM64_EXCEPT_AA32_IABT	(1 << 9)
-#define KVM_ARM64_EXCEPT_AA32_DABT	(2 << 9)
-/* For AArch64: */
-#define KVM_ARM64_EXCEPT_AA64_ELx_SYNC	(0 << 9)
-#define KVM_ARM64_EXCEPT_AA64_ELx_IRQ	(1 << 9)
-#define KVM_ARM64_EXCEPT_AA64_ELx_FIQ	(2 << 9)
-#define KVM_ARM64_EXCEPT_AA64_ELx_SERR	(3 << 9)
-#define KVM_ARM64_EXCEPT_AA64_EL1	(0 << 11)
-#define KVM_ARM64_EXCEPT_AA64_EL2	(1 << 11)
-
 #define KVM_ARM64_DEBUG_STATE_SAVE_SPE	(1 << 12) /* Save SPE context if active  */
 #define KVM_ARM64_DEBUG_STATE_SAVE_TRBE	(1 << 13) /* Save TRBE context if active  */
 #define KVM_ARM64_ON_UNSUPPORTED_CPU	(1 << 15) /* Physical CPU not in supported_cpus */
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 400bb0fe2745..5beabbe69585 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1013,8 +1013,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 	 * the vcpu state. Note that this relies on __kvm_adjust_pc()
 	 * being preempt-safe on VHE.
 	 */
-	if (unlikely(vcpu->arch.flags & (KVM_ARM64_PENDING_EXCEPTION |
-					 KVM_ARM64_INCREMENT_PC)))
+	if (unlikely(vcpu_get_flag(vcpu, PENDING_EXCEPTION) ||
+		     vcpu_get_flag(vcpu, INCREMENT_PC)))
 		kvm_call_hyp(__kvm_adjust_pc, vcpu);
 
 	vcpu_put(vcpu);
diff --git a/arch/arm64/kvm/hyp/exception.c b/arch/arm64/kvm/hyp/exception.c
index c5d009715402..b7557b25ed56 100644
--- a/arch/arm64/kvm/hyp/exception.c
+++ b/arch/arm64/kvm/hyp/exception.c
@@ -303,14 +303,14 @@ static void enter_exception32(struct kvm_vcpu *vcpu, u32 mode, u32 vect_offset)
 static void kvm_inject_exception(struct kvm_vcpu *vcpu)
 {
 	if (vcpu_el1_is_32bit(vcpu)) {
-		switch (vcpu->arch.flags & KVM_ARM64_EXCEPT_MASK) {
-		case KVM_ARM64_EXCEPT_AA32_UND:
+		switch (vcpu_get_flag(vcpu, EXCEPT_MASK)) {
+		case unpack_vcpu_flag(EXCEPT_AA32_UND):
 			enter_exception32(vcpu, PSR_AA32_MODE_UND, 4);
 			break;
-		case KVM_ARM64_EXCEPT_AA32_IABT:
+		case unpack_vcpu_flag(EXCEPT_AA32_IABT):
 			enter_exception32(vcpu, PSR_AA32_MODE_ABT, 12);
 			break;
-		case KVM_ARM64_EXCEPT_AA32_DABT:
+		case unpack_vcpu_flag(EXCEPT_AA32_DABT):
 			enter_exception32(vcpu, PSR_AA32_MODE_ABT, 16);
 			break;
 		default:
@@ -318,9 +318,8 @@ static void kvm_inject_exception(struct kvm_vcpu *vcpu)
 			break;
 		}
 	} else {
-		switch (vcpu->arch.flags & KVM_ARM64_EXCEPT_MASK) {
-		case (KVM_ARM64_EXCEPT_AA64_ELx_SYNC |
-		      KVM_ARM64_EXCEPT_AA64_EL1):
+		switch (vcpu_get_flag(vcpu, EXCEPT_MASK)) {
+		case unpack_vcpu_flag(EXCEPT_AA64_EL1_SYNC):
 			enter_exception64(vcpu, PSR_MODE_EL1h, except_type_sync);
 			break;
 		default:
@@ -340,12 +339,12 @@ static void kvm_inject_exception(struct kvm_vcpu *vcpu)
  */
 void __kvm_adjust_pc(struct kvm_vcpu *vcpu)
 {
-	if (vcpu->arch.flags & KVM_ARM64_PENDING_EXCEPTION) {
+	if (vcpu_get_flag(vcpu, PENDING_EXCEPTION)) {
 		kvm_inject_exception(vcpu);
-		vcpu->arch.flags &= ~(KVM_ARM64_PENDING_EXCEPTION |
-				      KVM_ARM64_EXCEPT_MASK);
-	} else 	if (vcpu->arch.flags & KVM_ARM64_INCREMENT_PC) {
+		vcpu_clear_flag(vcpu, PENDING_EXCEPTION);
+		vcpu_clear_flag(vcpu, EXCEPT_MASK);
+	} else if (vcpu_get_flag(vcpu, INCREMENT_PC)) {
 		kvm_skip_instr(vcpu);
-		vcpu->arch.flags &= ~KVM_ARM64_INCREMENT_PC;
+		vcpu_clear_flag(vcpu, INCREMENT_PC);
 	}
 }
diff --git a/arch/arm64/kvm/hyp/nvhe/sys_regs.c b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
index b6d86e423319..edd3eabf520f 100644
--- a/arch/arm64/kvm/hyp/nvhe/sys_regs.c
+++ b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
@@ -38,9 +38,7 @@ static void inject_undef64(struct kvm_vcpu *vcpu)
 	*vcpu_pc(vcpu) = read_sysreg_el2(SYS_ELR);
 	*vcpu_cpsr(vcpu) = read_sysreg_el2(SYS_SPSR);
 
-	vcpu->arch.flags |= (KVM_ARM64_EXCEPT_AA64_EL1 |
-			     KVM_ARM64_EXCEPT_AA64_ELx_SYNC |
-			     KVM_ARM64_PENDING_EXCEPTION);
+	kvm_pend_exception(vcpu, EXCEPT_AA64_EL1_SYNC);
 
 	__kvm_adjust_pc(vcpu);
 
diff --git a/arch/arm64/kvm/inject_fault.c b/arch/arm64/kvm/inject_fault.c
index 55a5dbe957e0..f32f4a2a347f 100644
--- a/arch/arm64/kvm/inject_fault.c
+++ b/arch/arm64/kvm/inject_fault.c
@@ -20,9 +20,7 @@ static void inject_abt64(struct kvm_vcpu *vcpu, bool is_iabt, unsigned long addr
 	bool is_aarch32 = vcpu_mode_is_32bit(vcpu);
 	u64 esr = 0;
 
-	vcpu->arch.flags |= (KVM_ARM64_EXCEPT_AA64_EL1		|
-			     KVM_ARM64_EXCEPT_AA64_ELx_SYNC	|
-			     KVM_ARM64_PENDING_EXCEPTION);
+	kvm_pend_exception(vcpu, EXCEPT_AA64_EL1_SYNC);
 
 	vcpu_write_sys_reg(vcpu, addr, FAR_EL1);
 
@@ -52,9 +50,7 @@ static void inject_undef64(struct kvm_vcpu *vcpu)
 {
 	u64 esr = (ESR_ELx_EC_UNKNOWN << ESR_ELx_EC_SHIFT);
 
-	vcpu->arch.flags |= (KVM_ARM64_EXCEPT_AA64_EL1		|
-			     KVM_ARM64_EXCEPT_AA64_ELx_SYNC	|
-			     KVM_ARM64_PENDING_EXCEPTION);
+	kvm_pend_exception(vcpu, EXCEPT_AA64_EL1_SYNC);
 
 	/*
 	 * Build an unknown exception, depending on the instruction
@@ -73,8 +69,7 @@ static void inject_undef64(struct kvm_vcpu *vcpu)
 
 static void inject_undef32(struct kvm_vcpu *vcpu)
 {
-	vcpu->arch.flags |= (KVM_ARM64_EXCEPT_AA32_UND |
-			     KVM_ARM64_PENDING_EXCEPTION);
+	kvm_pend_exception(vcpu, EXCEPT_AA32_UND);
 }
 
 /*
@@ -97,14 +92,12 @@ static void inject_abt32(struct kvm_vcpu *vcpu, bool is_pabt, u32 addr)
 	far = vcpu_read_sys_reg(vcpu, FAR_EL1);
 
 	if (is_pabt) {
-		vcpu->arch.flags |= (KVM_ARM64_EXCEPT_AA32_IABT |
-				     KVM_ARM64_PENDING_EXCEPTION);
+		kvm_pend_exception(vcpu, EXCEPT_AA32_IABT);
 		far &= GENMASK(31, 0);
 		far |= (u64)addr << 32;
 		vcpu_write_sys_reg(vcpu, fsr, IFSR32_EL2);
 	} else { /* !iabt */
-		vcpu->arch.flags |= (KVM_ARM64_EXCEPT_AA32_DABT |
-				     KVM_ARM64_PENDING_EXCEPTION);
+		kvm_pend_exception(vcpu, EXCEPT_AA32_DABT);
 		far &= GENMASK(63, 32);
 		far |= addr;
 		vcpu_write_sys_reg(vcpu, fsr, ESR_EL1);
-- 
2.34.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
