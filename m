Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEE3414979
	for <lists+kvmarm@lfdr.de>; Wed, 22 Sep 2021 14:47:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EE25C4B0ED;
	Wed, 22 Sep 2021 08:47:21 -0400 (EDT)
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
	with ESMTP id KLVwlx8KLayC; Wed, 22 Sep 2021 08:47:21 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7DAD64B0BF;
	Wed, 22 Sep 2021 08:47:20 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9CB964A19A
 for <kvmarm@lists.cs.columbia.edu>; Wed, 22 Sep 2021 08:47:18 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vAiCMSijKcV9 for <kvmarm@lists.cs.columbia.edu>;
 Wed, 22 Sep 2021 08:47:14 -0400 (EDT)
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com
 [209.85.222.201])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 788934A524
 for <kvmarm@lists.cs.columbia.edu>; Wed, 22 Sep 2021 08:47:13 -0400 (EDT)
Received: by mail-qk1-f201.google.com with SMTP id
 h7-20020a37b707000000b003fa4d25d9d0so9811336qkf.17
 for <kvmarm@lists.cs.columbia.edu>; Wed, 22 Sep 2021 05:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=CNIg0Z/y3l4EkHt/waE/OlJsRp9j4iTUXMTTmpM3yUM=;
 b=q+BZ0wa823wy5XPLOi0/rBFrYVDOcxn7q7aab0MQd5lwHCb2m3a298W6/lwcxi1KvT
 4nAOPtElTq1RzB5+NboqXxzBlzOoRCW7OiPMWqVimmmz+aATsrHiaNVjDhepvyNVI8P5
 NSp1ltOWcO2qXhH0gYjsVmE6RR6OIQlGetuixTcEELL5jZbw3ztnRDZHzvJgKvN635C3
 BvFXWkpUkBv4/krJCm0n++aNgOXm60Nl/hG9NS6jo/hkvXtP+kx/F51ajSXovIblfc15
 tjqZqr8udvh6XjUq+El9NQlFXP5pC4ov6DUhOqP9QVITwoEl/K9xUYE9x7AD4Sybu4W6
 w6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=CNIg0Z/y3l4EkHt/waE/OlJsRp9j4iTUXMTTmpM3yUM=;
 b=fcjsH4TBV0Rt5fWqPrqeblerZsSc5JOFhf2ClCb4VonnMcFZSht4HYoyiyqzokR6Qp
 EnNXf4F9mekIUsuX5VYIh42TtY1J3U8ePUypzqD+spge09242chWzNsmdofDM7jvOU/v
 7vYywUKTHUzgK1U/AC8UjcvBM9OBOmOZ8VO4OqBTD+XNYNtkw3CZ2EBzxpGHq9fhv5yL
 c1qC7kwXqRq8qvfbzMe1KStE3utZdNS5ud8un2maa9uUDvmvh0/RaFAvp3H6riwvqqJA
 Vg/AB7pW4Ymr/ujlZZLfBDjRF2wdOVdRsYEhEXXmpoocX+he4DWVUNUpfggGHM/gmYkK
 ah7g==
X-Gm-Message-State: AOAM533bedC2Hm267P5FG4O6kIQNOx7uplxIDvv4zjKc48ohCjvpIqFJ
 G0+4+8RALNNW1Brcj94P288qqvEjCr4IkRY1ax6kl6TrckG/UVXRd9csuy1jPCvdyYJ0tplua6R
 Jqrvdh+O++t34NvxX6LdX7QFcy1UYp0TwZ/IRtquONc385JOfli2hte5CJ4MXxxp6Zs8=
X-Google-Smtp-Source: ABdhPJzOzxDncRyNDkp6CnLPon8viWc4tKadnPqLgmuGDubBlNsdaMJQ6Mx0DqekESIfQ+uNmBdqHwoeQg==
X-Received: from tabba.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:482])
 (user=tabba job=sendgmr) by 2002:a05:6214:122e:: with SMTP id
 p14mr36432921qvv.57.1632314833014; Wed, 22 Sep 2021 05:47:13 -0700 (PDT)
Date: Wed, 22 Sep 2021 13:46:55 +0100
In-Reply-To: <20210922124704.600087-1-tabba@google.com>
Message-Id: <20210922124704.600087-4-tabba@google.com>
Mime-Version: 1.0
References: <20210922124704.600087-1-tabba@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v6 03/12] KVM: arm64: Move early handlers to per-EC handlers
From: Fuad Tabba <tabba@google.com>
To: kvmarm@lists.cs.columbia.edu
Cc: kernel-team@android.com, kvm@vger.kernel.org, maz@kernel.org,
 pbonzini@redhat.com, will@kernel.org, linux-arm-kernel@lists.infradead.org
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

From: Marc Zyngier <maz@kernel.org>

Simplify the early exception handling by slicing the gigantic decoding
tree into a more manageable set of functions, similar to what we have
in handle_exit.c.

This will also make the structure reusable for pKVM's own early exit
handling.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Fuad Tabba <tabba@google.com>
---
 arch/arm64/kvm/hyp/include/hyp/switch.h | 160 ++++++++++++++----------
 arch/arm64/kvm/hyp/nvhe/switch.c        |  17 +++
 arch/arm64/kvm/hyp/vhe/switch.c         |  17 +++
 3 files changed, 126 insertions(+), 68 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index 54abc8298ec3..0397606c0951 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -136,16 +136,7 @@ static inline void ___deactivate_traps(struct kvm_vcpu *vcpu)
 
 static inline bool __populate_fault_info(struct kvm_vcpu *vcpu)
 {
-	u8 ec;
-	u64 esr;
-
-	esr = vcpu->arch.fault.esr_el2;
-	ec = ESR_ELx_EC(esr);
-
-	if (ec != ESR_ELx_EC_DABT_LOW && ec != ESR_ELx_EC_IABT_LOW)
-		return true;
-
-	return __get_fault_info(esr, &vcpu->arch.fault);
+	return __get_fault_info(vcpu->arch.fault.esr_el2, &vcpu->arch.fault);
 }
 
 static inline void __hyp_sve_save_host(struct kvm_vcpu *vcpu)
@@ -166,8 +157,13 @@ static inline void __hyp_sve_restore_guest(struct kvm_vcpu *vcpu)
 	write_sysreg_el1(__vcpu_sys_reg(vcpu, ZCR_EL1), SYS_ZCR);
 }
 
-/* Check for an FPSIMD/SVE trap and handle as appropriate */
-static inline bool __hyp_handle_fpsimd(struct kvm_vcpu *vcpu)
+/*
+ * We trap the first access to the FP/SIMD to save the host context and
+ * restore the guest context lazily.
+ * If FP/SIMD is not implemented, handle the trap and inject an undefined
+ * instruction exception to the guest. Similarly for trapped SVE accesses.
+ */
+static bool kvm_hyp_handle_fpsimd(struct kvm_vcpu *vcpu, u64 *exit_code)
 {
 	bool sve_guest, sve_host;
 	u8 esr_ec;
@@ -185,9 +181,6 @@ static inline bool __hyp_handle_fpsimd(struct kvm_vcpu *vcpu)
 	}
 
 	esr_ec = kvm_vcpu_trap_get_class(vcpu);
-	if (esr_ec != ESR_ELx_EC_FP_ASIMD &&
-	    esr_ec != ESR_ELx_EC_SVE)
-		return false;
 
 	/* Don't handle SVE traps for non-SVE vcpus here: */
 	if (!sve_guest && esr_ec != ESR_ELx_EC_FP_ASIMD)
@@ -325,7 +318,7 @@ static inline bool esr_is_ptrauth_trap(u32 esr)
 
 DECLARE_PER_CPU(struct kvm_cpu_context, kvm_hyp_ctxt);
 
-static inline bool __hyp_handle_ptrauth(struct kvm_vcpu *vcpu)
+static bool kvm_hyp_handle_ptrauth(struct kvm_vcpu *vcpu, u64 *exit_code)
 {
 	struct kvm_cpu_context *ctxt;
 	u64 val;
@@ -350,6 +343,87 @@ static inline bool __hyp_handle_ptrauth(struct kvm_vcpu *vcpu)
 	return true;
 }
 
+static bool kvm_hyp_handle_sysreg(struct kvm_vcpu *vcpu, u64 *exit_code)
+{
+	if (cpus_have_final_cap(ARM64_WORKAROUND_CAVIUM_TX2_219_TVM) &&
+	    handle_tx2_tvm(vcpu))
+		return true;
+
+	if (static_branch_unlikely(&vgic_v3_cpuif_trap) &&
+	    __vgic_v3_perform_cpuif_access(vcpu) == 1)
+		return true;
+
+	return false;
+}
+
+static bool kvm_hyp_handle_cp15(struct kvm_vcpu *vcpu, u64 *exit_code)
+{
+	if (static_branch_unlikely(&vgic_v3_cpuif_trap) &&
+	    __vgic_v3_perform_cpuif_access(vcpu) == 1)
+		return true;
+
+	return false;
+}
+
+static bool kvm_hyp_handle_iabt_low(struct kvm_vcpu *vcpu, u64 *exit_code)
+{
+	if (!__populate_fault_info(vcpu))
+		return true;
+
+	return false;
+}
+
+static bool kvm_hyp_handle_dabt_low(struct kvm_vcpu *vcpu, u64 *exit_code)
+{
+	if (!__populate_fault_info(vcpu))
+		return true;
+
+	if (static_branch_unlikely(&vgic_v2_cpuif_trap)) {
+		bool valid;
+
+		valid = kvm_vcpu_trap_get_fault_type(vcpu) == FSC_FAULT &&
+			kvm_vcpu_dabt_isvalid(vcpu) &&
+			!kvm_vcpu_abt_issea(vcpu) &&
+			!kvm_vcpu_abt_iss1tw(vcpu);
+
+		if (valid) {
+			int ret = __vgic_v2_perform_cpuif_access(vcpu);
+
+			if (ret == 1)
+				return true;
+
+			/* Promote an illegal access to an SError.*/
+			if (ret == -1)
+				*exit_code = ARM_EXCEPTION_EL1_SERROR;
+		}
+	}
+
+	return false;
+}
+
+typedef bool (*exit_handler_fn)(struct kvm_vcpu *, u64 *);
+
+static const exit_handler_fn *kvm_get_exit_handler_array(void);
+
+/*
+ * Allow the hypervisor to handle the exit with an exit handler if it has one.
+ *
+ * Returns true if the hypervisor handled the exit, and control should go back
+ * to the guest, or false if it hasn't.
+ */
+static inline bool kvm_hyp_handle_exit(struct kvm_vcpu *vcpu, u64 *exit_code)
+{
+	const exit_handler_fn *handlers = kvm_get_exit_handler_array();
+	exit_handler_fn fn;
+
+	fn = handlers[kvm_vcpu_trap_get_class(vcpu)];
+
+	if (fn)
+		return fn(vcpu, exit_code);
+
+	return false;
+}
+
 /*
  * Return true when we were able to fixup the guest exit and should return to
  * the guest, false when we should restore the host state and return to the
@@ -384,59 +458,9 @@ static inline bool fixup_guest_exit(struct kvm_vcpu *vcpu, u64 *exit_code)
 	if (*exit_code != ARM_EXCEPTION_TRAP)
 		goto exit;
 
-	if (cpus_have_final_cap(ARM64_WORKAROUND_CAVIUM_TX2_219_TVM) &&
-	    kvm_vcpu_trap_get_class(vcpu) == ESR_ELx_EC_SYS64 &&
-	    handle_tx2_tvm(vcpu))
+	/* Check if there's an exit handler and allow it to handle the exit. */
+	if (kvm_hyp_handle_exit(vcpu, exit_code))
 		goto guest;
-
-	/*
-	 * We trap the first access to the FP/SIMD to save the host context
-	 * and restore the guest context lazily.
-	 * If FP/SIMD is not implemented, handle the trap and inject an
-	 * undefined instruction exception to the guest.
-	 * Similarly for trapped SVE accesses.
-	 */
-	if (__hyp_handle_fpsimd(vcpu))
-		goto guest;
-
-	if (__hyp_handle_ptrauth(vcpu))
-		goto guest;
-
-	if (!__populate_fault_info(vcpu))
-		goto guest;
-
-	if (static_branch_unlikely(&vgic_v2_cpuif_trap)) {
-		bool valid;
-
-		valid = kvm_vcpu_trap_get_class(vcpu) == ESR_ELx_EC_DABT_LOW &&
-			kvm_vcpu_trap_get_fault_type(vcpu) == FSC_FAULT &&
-			kvm_vcpu_dabt_isvalid(vcpu) &&
-			!kvm_vcpu_abt_issea(vcpu) &&
-			!kvm_vcpu_abt_iss1tw(vcpu);
-
-		if (valid) {
-			int ret = __vgic_v2_perform_cpuif_access(vcpu);
-
-			if (ret == 1)
-				goto guest;
-
-			/* Promote an illegal access to an SError.*/
-			if (ret == -1)
-				*exit_code = ARM_EXCEPTION_EL1_SERROR;
-
-			goto exit;
-		}
-	}
-
-	if (static_branch_unlikely(&vgic_v3_cpuif_trap) &&
-	    (kvm_vcpu_trap_get_class(vcpu) == ESR_ELx_EC_SYS64 ||
-	     kvm_vcpu_trap_get_class(vcpu) == ESR_ELx_EC_CP15_32)) {
-		int ret = __vgic_v3_perform_cpuif_access(vcpu);
-
-		if (ret == 1)
-			goto guest;
-	}
-
 exit:
 	/* Return to the host kernel and handle the exit */
 	return false;
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index a34b01cc8ab9..c52d580708e0 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -158,6 +158,23 @@ static void __pmu_switch_to_host(struct kvm_cpu_context *host_ctxt)
 		write_sysreg(pmu->events_host, pmcntenset_el0);
 }
 
+static const exit_handler_fn hyp_exit_handlers[] = {
+	[0 ... ESR_ELx_EC_MAX]		= NULL,
+	[ESR_ELx_EC_CP15_32]		= kvm_hyp_handle_cp15,
+	[ESR_ELx_EC_CP15_64]		= kvm_hyp_handle_cp15,
+	[ESR_ELx_EC_SYS64]		= kvm_hyp_handle_sysreg,
+	[ESR_ELx_EC_SVE]		= kvm_hyp_handle_fpsimd,
+	[ESR_ELx_EC_FP_ASIMD]		= kvm_hyp_handle_fpsimd,
+	[ESR_ELx_EC_IABT_LOW]		= kvm_hyp_handle_iabt_low,
+	[ESR_ELx_EC_DABT_LOW]		= kvm_hyp_handle_dabt_low,
+	[ESR_ELx_EC_PAC]		= kvm_hyp_handle_ptrauth,
+};
+
+static const exit_handler_fn *kvm_get_exit_handler_array(void)
+{
+	return hyp_exit_handlers;
+}
+
 /* Switch to the guest for legacy non-VHE systems */
 int __kvm_vcpu_run(struct kvm_vcpu *vcpu)
 {
diff --git a/arch/arm64/kvm/hyp/vhe/switch.c b/arch/arm64/kvm/hyp/vhe/switch.c
index ded2c66675f0..0e0d342358f7 100644
--- a/arch/arm64/kvm/hyp/vhe/switch.c
+++ b/arch/arm64/kvm/hyp/vhe/switch.c
@@ -96,6 +96,23 @@ void deactivate_traps_vhe_put(struct kvm_vcpu *vcpu)
 	__deactivate_traps_common(vcpu);
 }
 
+static const exit_handler_fn hyp_exit_handlers[] = {
+	[0 ... ESR_ELx_EC_MAX]		= NULL,
+	[ESR_ELx_EC_CP15_32]		= kvm_hyp_handle_cp15,
+	[ESR_ELx_EC_CP15_64]		= kvm_hyp_handle_cp15,
+	[ESR_ELx_EC_SYS64]		= kvm_hyp_handle_sysreg,
+	[ESR_ELx_EC_SVE]		= kvm_hyp_handle_fpsimd,
+	[ESR_ELx_EC_FP_ASIMD]		= kvm_hyp_handle_fpsimd,
+	[ESR_ELx_EC_IABT_LOW]		= kvm_hyp_handle_iabt_low,
+	[ESR_ELx_EC_DABT_LOW]		= kvm_hyp_handle_dabt_low,
+	[ESR_ELx_EC_PAC]		= kvm_hyp_handle_ptrauth,
+};
+
+static const exit_handler_fn *kvm_get_exit_handler_array(void)
+{
+	return hyp_exit_handlers;
+}
+
 /* Switch to the guest for VHE systems running in EL2 */
 static int __kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu)
 {
-- 
2.33.0.464.g1972c5931b-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
