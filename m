Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 85D5320EB28
	for <lists+kvmarm@lfdr.de>; Tue, 30 Jun 2020 03:57:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F02FA4B5C3;
	Mon, 29 Jun 2020 21:57:21 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ALhYMhYuREKO; Mon, 29 Jun 2020 21:57:21 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 44C6E4B5BB;
	Mon, 29 Jun 2020 21:57:20 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 772DB4B5B3
 for <kvmarm@lists.cs.columbia.edu>; Mon, 29 Jun 2020 21:57:18 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2dLoEcv5NqXu for <kvmarm@lists.cs.columbia.edu>;
 Mon, 29 Jun 2020 21:57:17 -0400 (EDT)
Received: from us-smtp-1.mimecast.com (us-smtp-1.mimecast.com [207.211.31.81])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id F3D6D4B59F
 for <kvmarm@lists.cs.columbia.edu>; Mon, 29 Jun 2020 21:57:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593482236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WLg+0/e1gD4KYJIzB4LjsZyscotapsY6RmTBboCCRQI=;
 b=BMXz/HFNqGVfYyoVLd0PiTUolrufsSkpV/+F3QDiMzxhlKsKCtHf10xWKw9ndKhNGMPXDU
 tAicjtyUYRXYDdkozsYR3iU+/OktDUlL9+msS3jMWV6GbA2YLjuKRipM3uff3oJXgOyFAp
 b+8vSxZaL+FHL8HJAY7wwfWMoCRkctI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-mgQKifUANGS9SAzz8nxZhw-1; Mon, 29 Jun 2020 21:57:12 -0400
X-MC-Unique: mgQKifUANGS9SAzz8nxZhw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91CE3464;
 Tue, 30 Jun 2020 01:57:11 +0000 (UTC)
Received: from localhost.localdomain.com (vpn2-54-102.bne.redhat.com
 [10.64.54.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4DCC75D9CC;
 Tue, 30 Jun 2020 01:57:08 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v2] kvm/arm64: Rename HSR to ESR
Date: Tue, 30 Jun 2020 11:57:05 +1000
Message-Id: <20200630015705.103366-1-gshan@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: maz@misterjones.org
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

kvm/arm32 isn't supported since commit 541ad0150ca4 ("arm: Remove
32bit KVM host support"). So HSR isn't meaningful since then. This
renames HSR to ESR accordingly. This shouldn't cause any functional
changes:

   * Rename kvm_vcpu_get_hsr() to kvm_vcpu_get_esr() to make the
     function names self-explanatory.
   * Rename variables from @hsr to @esr to make them self-explanatory.

Note that the renaming on uapi and tracepoint will cause ABI changes,
which we should avoid. Specificly, there are 4 related source files
in this regard:

   * arch/arm64/include/uapi/asm/kvm.h  (struct kvm_debug_exit_arch::hsr)
   * arch/arm64/kvm/handle_exit.c       (struct kvm_debug_exit_arch::hsr)
   * arch/arm64/kvm/trace_arm.h         (tracepoints)
   * arch/arm64/kvm/trace_handle_exit.h (tracepoints)

Signed-off-by: Gavin Shan <gshan@redhat.com>
Acked-by: Andrew Scull <ascull@google.com>
---
v2: Drop changes to uapi/tracepoints
    Pick ack from Andrew Scull
    Drop PATCH[2/2] to detach ESR operator from vCPU struct
---
 arch/arm64/include/asm/kvm_emulate.h | 34 ++++++++++++++--------------
 arch/arm64/kvm/handle_exit.c         | 32 +++++++++++++-------------
 arch/arm64/kvm/hyp/aarch32.c         |  2 +-
 arch/arm64/kvm/hyp/switch.c          | 14 ++++++------
 arch/arm64/kvm/hyp/vgic-v3-sr.c      |  4 ++--
 arch/arm64/kvm/mmu.c                 |  6 ++---
 arch/arm64/kvm/sys_regs.c            | 28 +++++++++++------------
 7 files changed, 60 insertions(+), 60 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 4d0f8ea600ba..c9ba0df47f7d 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -259,14 +259,14 @@ static inline bool vcpu_mode_priv(const struct kvm_vcpu *vcpu)
 	return mode != PSR_MODE_EL0t;
 }
 
-static __always_inline u32 kvm_vcpu_get_hsr(const struct kvm_vcpu *vcpu)
+static __always_inline u32 kvm_vcpu_get_esr(const struct kvm_vcpu *vcpu)
 {
 	return vcpu->arch.fault.esr_el2;
 }
 
 static __always_inline int kvm_vcpu_get_condition(const struct kvm_vcpu *vcpu)
 {
-	u32 esr = kvm_vcpu_get_hsr(vcpu);
+	u32 esr = kvm_vcpu_get_esr(vcpu);
 
 	if (esr & ESR_ELx_CV)
 		return (esr & ESR_ELx_COND_MASK) >> ESR_ELx_COND_SHIFT;
@@ -291,64 +291,64 @@ static inline u64 kvm_vcpu_get_disr(const struct kvm_vcpu *vcpu)
 
 static inline u32 kvm_vcpu_hvc_get_imm(const struct kvm_vcpu *vcpu)
 {
-	return kvm_vcpu_get_hsr(vcpu) & ESR_ELx_xVC_IMM_MASK;
+	return kvm_vcpu_get_esr(vcpu) & ESR_ELx_xVC_IMM_MASK;
 }
 
 static __always_inline bool kvm_vcpu_dabt_isvalid(const struct kvm_vcpu *vcpu)
 {
-	return !!(kvm_vcpu_get_hsr(vcpu) & ESR_ELx_ISV);
+	return !!(kvm_vcpu_get_esr(vcpu) & ESR_ELx_ISV);
 }
 
 static inline unsigned long kvm_vcpu_dabt_iss_nisv_sanitized(const struct kvm_vcpu *vcpu)
 {
-	return kvm_vcpu_get_hsr(vcpu) & (ESR_ELx_CM | ESR_ELx_WNR | ESR_ELx_FSC);
+	return kvm_vcpu_get_esr(vcpu) & (ESR_ELx_CM | ESR_ELx_WNR | ESR_ELx_FSC);
 }
 
 static inline bool kvm_vcpu_dabt_issext(const struct kvm_vcpu *vcpu)
 {
-	return !!(kvm_vcpu_get_hsr(vcpu) & ESR_ELx_SSE);
+	return !!(kvm_vcpu_get_esr(vcpu) & ESR_ELx_SSE);
 }
 
 static inline bool kvm_vcpu_dabt_issf(const struct kvm_vcpu *vcpu)
 {
-	return !!(kvm_vcpu_get_hsr(vcpu) & ESR_ELx_SF);
+	return !!(kvm_vcpu_get_esr(vcpu) & ESR_ELx_SF);
 }
 
 static __always_inline int kvm_vcpu_dabt_get_rd(const struct kvm_vcpu *vcpu)
 {
-	return (kvm_vcpu_get_hsr(vcpu) & ESR_ELx_SRT_MASK) >> ESR_ELx_SRT_SHIFT;
+	return (kvm_vcpu_get_esr(vcpu) & ESR_ELx_SRT_MASK) >> ESR_ELx_SRT_SHIFT;
 }
 
 static __always_inline bool kvm_vcpu_dabt_iss1tw(const struct kvm_vcpu *vcpu)
 {
-	return !!(kvm_vcpu_get_hsr(vcpu) & ESR_ELx_S1PTW);
+	return !!(kvm_vcpu_get_esr(vcpu) & ESR_ELx_S1PTW);
 }
 
 static __always_inline bool kvm_vcpu_dabt_iswrite(const struct kvm_vcpu *vcpu)
 {
-	return !!(kvm_vcpu_get_hsr(vcpu) & ESR_ELx_WNR) ||
+	return !!(kvm_vcpu_get_esr(vcpu) & ESR_ELx_WNR) ||
 		kvm_vcpu_dabt_iss1tw(vcpu); /* AF/DBM update */
 }
 
 static inline bool kvm_vcpu_dabt_is_cm(const struct kvm_vcpu *vcpu)
 {
-	return !!(kvm_vcpu_get_hsr(vcpu) & ESR_ELx_CM);
+	return !!(kvm_vcpu_get_esr(vcpu) & ESR_ELx_CM);
 }
 
 static __always_inline unsigned int kvm_vcpu_dabt_get_as(const struct kvm_vcpu *vcpu)
 {
-	return 1 << ((kvm_vcpu_get_hsr(vcpu) & ESR_ELx_SAS) >> ESR_ELx_SAS_SHIFT);
+	return 1 << ((kvm_vcpu_get_esr(vcpu) & ESR_ELx_SAS) >> ESR_ELx_SAS_SHIFT);
 }
 
 /* This one is not specific to Data Abort */
 static __always_inline bool kvm_vcpu_trap_il_is32bit(const struct kvm_vcpu *vcpu)
 {
-	return !!(kvm_vcpu_get_hsr(vcpu) & ESR_ELx_IL);
+	return !!(kvm_vcpu_get_esr(vcpu) & ESR_ELx_IL);
 }
 
 static __always_inline u8 kvm_vcpu_trap_get_class(const struct kvm_vcpu *vcpu)
 {
-	return ESR_ELx_EC(kvm_vcpu_get_hsr(vcpu));
+	return ESR_ELx_EC(kvm_vcpu_get_esr(vcpu));
 }
 
 static inline bool kvm_vcpu_trap_is_iabt(const struct kvm_vcpu *vcpu)
@@ -358,12 +358,12 @@ static inline bool kvm_vcpu_trap_is_iabt(const struct kvm_vcpu *vcpu)
 
 static __always_inline u8 kvm_vcpu_trap_get_fault(const struct kvm_vcpu *vcpu)
 {
-	return kvm_vcpu_get_hsr(vcpu) & ESR_ELx_FSC;
+	return kvm_vcpu_get_esr(vcpu) & ESR_ELx_FSC;
 }
 
 static __always_inline u8 kvm_vcpu_trap_get_fault_type(const struct kvm_vcpu *vcpu)
 {
-	return kvm_vcpu_get_hsr(vcpu) & ESR_ELx_FSC_TYPE;
+	return kvm_vcpu_get_esr(vcpu) & ESR_ELx_FSC_TYPE;
 }
 
 static __always_inline bool kvm_vcpu_dabt_isextabt(const struct kvm_vcpu *vcpu)
@@ -387,7 +387,7 @@ static __always_inline bool kvm_vcpu_dabt_isextabt(const struct kvm_vcpu *vcpu)
 
 static __always_inline int kvm_vcpu_sys_get_rt(struct kvm_vcpu *vcpu)
 {
-	u32 esr = kvm_vcpu_get_hsr(vcpu);
+	u32 esr = kvm_vcpu_get_esr(vcpu);
 	return ESR_ELx_SYS64_ISS_RT(esr);
 }
 
diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index 5a02d4c90559..98ab33139982 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -89,7 +89,7 @@ static int handle_no_fpsimd(struct kvm_vcpu *vcpu, struct kvm_run *run)
  */
 static int kvm_handle_wfx(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
-	if (kvm_vcpu_get_hsr(vcpu) & ESR_ELx_WFx_ISS_WFE) {
+	if (kvm_vcpu_get_esr(vcpu) & ESR_ELx_WFx_ISS_WFE) {
 		trace_kvm_wfx_arm64(*vcpu_pc(vcpu), true);
 		vcpu->stat.wfe_exit_stat++;
 		kvm_vcpu_on_spin(vcpu, vcpu_mode_priv(vcpu));
@@ -119,13 +119,13 @@ static int kvm_handle_wfx(struct kvm_vcpu *vcpu, struct kvm_run *run)
  */
 static int kvm_handle_guest_debug(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
-	u32 hsr = kvm_vcpu_get_hsr(vcpu);
+	u32 esr = kvm_vcpu_get_esr(vcpu);
 	int ret = 0;
 
 	run->exit_reason = KVM_EXIT_DEBUG;
-	run->debug.arch.hsr = hsr;
+	run->debug.arch.hsr = esr;
 
-	switch (ESR_ELx_EC(hsr)) {
+	switch (ESR_ELx_EC(esr)) {
 	case ESR_ELx_EC_WATCHPT_LOW:
 		run->debug.arch.far = vcpu->arch.fault.far_el2;
 		/* fall through */
@@ -135,8 +135,8 @@ static int kvm_handle_guest_debug(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	case ESR_ELx_EC_BRK64:
 		break;
 	default:
-		kvm_err("%s: un-handled case hsr: %#08x\n",
-			__func__, (unsigned int) hsr);
+		kvm_err("%s: un-handled case esr: %#08x\n",
+			__func__, (unsigned int) esr);
 		ret = -1;
 		break;
 	}
@@ -146,10 +146,10 @@ static int kvm_handle_guest_debug(struct kvm_vcpu *vcpu, struct kvm_run *run)
 
 static int kvm_handle_unknown_ec(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
-	u32 hsr = kvm_vcpu_get_hsr(vcpu);
+	u32 esr = kvm_vcpu_get_esr(vcpu);
 
-	kvm_pr_unimpl("Unknown exception class: hsr: %#08x -- %s\n",
-		      hsr, esr_get_class_string(hsr));
+	kvm_pr_unimpl("Unknown exception class: esr: %#08x -- %s\n",
+		      esr, esr_get_class_string(esr));
 
 	kvm_inject_undefined(vcpu);
 	return 1;
@@ -200,10 +200,10 @@ static exit_handle_fn arm_exit_handlers[] = {
 
 static exit_handle_fn kvm_get_exit_handler(struct kvm_vcpu *vcpu)
 {
-	u32 hsr = kvm_vcpu_get_hsr(vcpu);
-	u8 hsr_ec = ESR_ELx_EC(hsr);
+	u32 esr = kvm_vcpu_get_esr(vcpu);
+	u8 esr_ec = ESR_ELx_EC(esr);
 
-	return arm_exit_handlers[hsr_ec];
+	return arm_exit_handlers[esr_ec];
 }
 
 /*
@@ -241,15 +241,15 @@ int handle_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		       int exception_index)
 {
 	if (ARM_SERROR_PENDING(exception_index)) {
-		u8 hsr_ec = ESR_ELx_EC(kvm_vcpu_get_hsr(vcpu));
+		u8 esr_ec = ESR_ELx_EC(kvm_vcpu_get_esr(vcpu));
 
 		/*
 		 * HVC/SMC already have an adjusted PC, which we need
 		 * to correct in order to return to after having
 		 * injected the SError.
 		 */
-		if (hsr_ec == ESR_ELx_EC_HVC32 || hsr_ec == ESR_ELx_EC_HVC64 ||
-		    hsr_ec == ESR_ELx_EC_SMC32 || hsr_ec == ESR_ELx_EC_SMC64) {
+		if (esr_ec == ESR_ELx_EC_HVC32 || esr_ec == ESR_ELx_EC_HVC64 ||
+		    esr_ec == ESR_ELx_EC_SMC32 || esr_ec == ESR_ELx_EC_SMC64) {
 			u32 adj =  kvm_vcpu_trap_il_is32bit(vcpu) ? 4 : 2;
 			*vcpu_pc(vcpu) -= adj;
 		}
@@ -307,5 +307,5 @@ void handle_exit_early(struct kvm_vcpu *vcpu, struct kvm_run *run,
 	exception_index = ARM_EXCEPTION_CODE(exception_index);
 
 	if (exception_index == ARM_EXCEPTION_EL1_SERROR)
-		kvm_handle_guest_serror(vcpu, kvm_vcpu_get_hsr(vcpu));
+		kvm_handle_guest_serror(vcpu, kvm_vcpu_get_esr(vcpu));
 }
diff --git a/arch/arm64/kvm/hyp/aarch32.c b/arch/arm64/kvm/hyp/aarch32.c
index 25c0e47d57cb..1e948704d60f 100644
--- a/arch/arm64/kvm/hyp/aarch32.c
+++ b/arch/arm64/kvm/hyp/aarch32.c
@@ -51,7 +51,7 @@ bool __hyp_text kvm_condition_valid32(const struct kvm_vcpu *vcpu)
 	int cond;
 
 	/* Top two bits non-zero?  Unconditional. */
-	if (kvm_vcpu_get_hsr(vcpu) >> 30)
+	if (kvm_vcpu_get_esr(vcpu) >> 30)
 		return true;
 
 	/* Is condition field valid? */
diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index db1c4487d95d..5164074c1ae1 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -356,7 +356,7 @@ static bool __hyp_text __populate_fault_info(struct kvm_vcpu *vcpu)
 static bool __hyp_text __hyp_handle_fpsimd(struct kvm_vcpu *vcpu)
 {
 	bool vhe, sve_guest, sve_host;
-	u8 hsr_ec;
+	u8 esr_ec;
 
 	if (!system_supports_fpsimd())
 		return false;
@@ -371,14 +371,14 @@ static bool __hyp_text __hyp_handle_fpsimd(struct kvm_vcpu *vcpu)
 		vhe = has_vhe();
 	}
 
-	hsr_ec = kvm_vcpu_trap_get_class(vcpu);
-	if (hsr_ec != ESR_ELx_EC_FP_ASIMD &&
-	    hsr_ec != ESR_ELx_EC_SVE)
+	esr_ec = kvm_vcpu_trap_get_class(vcpu);
+	if (esr_ec != ESR_ELx_EC_FP_ASIMD &&
+	    esr_ec != ESR_ELx_EC_SVE)
 		return false;
 
 	/* Don't handle SVE traps for non-SVE vcpus here: */
 	if (!sve_guest)
-		if (hsr_ec != ESR_ELx_EC_FP_ASIMD)
+		if (esr_ec != ESR_ELx_EC_FP_ASIMD)
 			return false;
 
 	/* Valid trap.  Switch the context: */
@@ -437,7 +437,7 @@ static bool __hyp_text __hyp_handle_fpsimd(struct kvm_vcpu *vcpu)
 
 static bool __hyp_text handle_tx2_tvm(struct kvm_vcpu *vcpu)
 {
-	u32 sysreg = esr_sys64_to_sysreg(kvm_vcpu_get_hsr(vcpu));
+	u32 sysreg = esr_sys64_to_sysreg(kvm_vcpu_get_esr(vcpu));
 	int rt = kvm_vcpu_sys_get_rt(vcpu);
 	u64 val = vcpu_get_reg(vcpu, rt);
 
@@ -529,7 +529,7 @@ static bool __hyp_text __hyp_handle_ptrauth(struct kvm_vcpu *vcpu)
 	u64 val;
 
 	if (!vcpu_has_ptrauth(vcpu) ||
-	    !esr_is_ptrauth_trap(kvm_vcpu_get_hsr(vcpu)))
+	    !esr_is_ptrauth_trap(kvm_vcpu_get_esr(vcpu)))
 		return false;
 
 	ctxt = &__hyp_this_cpu_ptr(kvm_host_data)->host_ctxt;
diff --git a/arch/arm64/kvm/hyp/vgic-v3-sr.c b/arch/arm64/kvm/hyp/vgic-v3-sr.c
index 10ed539835c1..bee0a74671ca 100644
--- a/arch/arm64/kvm/hyp/vgic-v3-sr.c
+++ b/arch/arm64/kvm/hyp/vgic-v3-sr.c
@@ -426,7 +426,7 @@ static int __hyp_text __vgic_v3_bpr_min(void)
 
 static int __hyp_text __vgic_v3_get_group(struct kvm_vcpu *vcpu)
 {
-	u32 esr = kvm_vcpu_get_hsr(vcpu);
+	u32 esr = kvm_vcpu_get_esr(vcpu);
 	u8 crm = (esr & ESR_ELx_SYS64_ISS_CRM_MASK) >> ESR_ELx_SYS64_ISS_CRM_SHIFT;
 
 	return crm != 8;
@@ -992,7 +992,7 @@ int __hyp_text __vgic_v3_perform_cpuif_access(struct kvm_vcpu *vcpu)
 	bool is_read;
 	u32 sysreg;
 
-	esr = kvm_vcpu_get_hsr(vcpu);
+	esr = kvm_vcpu_get_esr(vcpu);
 	if (vcpu_mode_is_32bit(vcpu)) {
 		if (!kvm_condition_valid(vcpu)) {
 			__kvm_skip_instr(vcpu);
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 8c0035cab6b6..36506112480e 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -2079,7 +2079,7 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		 * For RAS the host kernel may handle this abort.
 		 * There is no need to pass the error into the guest.
 		 */
-		if (!kvm_handle_guest_sea(fault_ipa, kvm_vcpu_get_hsr(vcpu)))
+		if (!kvm_handle_guest_sea(fault_ipa, kvm_vcpu_get_esr(vcpu)))
 			return 1;
 
 		if (unlikely(!is_iabt)) {
@@ -2088,7 +2088,7 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		}
 	}
 
-	trace_kvm_guest_fault(*vcpu_pc(vcpu), kvm_vcpu_get_hsr(vcpu),
+	trace_kvm_guest_fault(*vcpu_pc(vcpu), kvm_vcpu_get_esr(vcpu),
 			      kvm_vcpu_get_hfar(vcpu), fault_ipa);
 
 	/* Check the stage-2 fault is trans. fault or write fault */
@@ -2097,7 +2097,7 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		kvm_err("Unsupported FSC: EC=%#x xFSC=%#lx ESR_EL2=%#lx\n",
 			kvm_vcpu_trap_get_class(vcpu),
 			(unsigned long)kvm_vcpu_trap_get_fault(vcpu),
-			(unsigned long)kvm_vcpu_get_hsr(vcpu));
+			(unsigned long)kvm_vcpu_get_esr(vcpu));
 		return -EFAULT;
 	}
 
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index baf5ce9225ce..a96dd62a90ce 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2220,10 +2220,10 @@ static int emulate_cp(struct kvm_vcpu *vcpu,
 static void unhandled_cp_access(struct kvm_vcpu *vcpu,
 				struct sys_reg_params *params)
 {
-	u8 hsr_ec = kvm_vcpu_trap_get_class(vcpu);
+	u8 esr_ec = kvm_vcpu_trap_get_class(vcpu);
 	int cp = -1;
 
-	switch(hsr_ec) {
+	switch (esr_ec) {
 	case ESR_ELx_EC_CP15_32:
 	case ESR_ELx_EC_CP15_64:
 		cp = 15;
@@ -2254,17 +2254,17 @@ static int kvm_handle_cp_64(struct kvm_vcpu *vcpu,
 			    size_t nr_specific)
 {
 	struct sys_reg_params params;
-	u32 hsr = kvm_vcpu_get_hsr(vcpu);
+	u32 esr = kvm_vcpu_get_esr(vcpu);
 	int Rt = kvm_vcpu_sys_get_rt(vcpu);
-	int Rt2 = (hsr >> 10) & 0x1f;
+	int Rt2 = (esr >> 10) & 0x1f;
 
 	params.is_aarch32 = true;
 	params.is_32bit = false;
-	params.CRm = (hsr >> 1) & 0xf;
-	params.is_write = ((hsr & 1) == 0);
+	params.CRm = (esr >> 1) & 0xf;
+	params.is_write = ((esr & 1) == 0);
 
 	params.Op0 = 0;
-	params.Op1 = (hsr >> 16) & 0xf;
+	params.Op1 = (esr >> 16) & 0xf;
 	params.Op2 = 0;
 	params.CRn = 0;
 
@@ -2311,18 +2311,18 @@ static int kvm_handle_cp_32(struct kvm_vcpu *vcpu,
 			    size_t nr_specific)
 {
 	struct sys_reg_params params;
-	u32 hsr = kvm_vcpu_get_hsr(vcpu);
+	u32 esr = kvm_vcpu_get_esr(vcpu);
 	int Rt  = kvm_vcpu_sys_get_rt(vcpu);
 
 	params.is_aarch32 = true;
 	params.is_32bit = true;
-	params.CRm = (hsr >> 1) & 0xf;
+	params.CRm = (esr >> 1) & 0xf;
 	params.regval = vcpu_get_reg(vcpu, Rt);
-	params.is_write = ((hsr & 1) == 0);
-	params.CRn = (hsr >> 10) & 0xf;
+	params.is_write = ((esr & 1) == 0);
+	params.CRn = (esr >> 10) & 0xf;
 	params.Op0 = 0;
-	params.Op1 = (hsr >> 14) & 0x7;
-	params.Op2 = (hsr >> 17) & 0x7;
+	params.Op1 = (esr >> 14) & 0x7;
+	params.Op2 = (esr >> 17) & 0x7;
 
 	if (!emulate_cp(vcpu, &params, target_specific, nr_specific) ||
 	    !emulate_cp(vcpu, &params, global, nr_global)) {
@@ -2421,7 +2421,7 @@ static void reset_sys_reg_descs(struct kvm_vcpu *vcpu,
 int kvm_handle_sys_reg(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
 	struct sys_reg_params params;
-	unsigned long esr = kvm_vcpu_get_hsr(vcpu);
+	unsigned long esr = kvm_vcpu_get_esr(vcpu);
 	int Rt = kvm_vcpu_sys_get_rt(vcpu);
 	int ret;
 
-- 
2.23.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
