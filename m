Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 09A614621A5
	for <lists+kvmarm@lfdr.de>; Mon, 29 Nov 2021 21:07:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AFEA64B248;
	Mon, 29 Nov 2021 15:07:46 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, T_DKIM_INVALID=0.01]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yWPv2TS-HEHn; Mon, 29 Nov 2021 15:07:46 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 24FC34B246;
	Mon, 29 Nov 2021 15:07:43 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 659954B212
 for <kvmarm@lists.cs.columbia.edu>; Mon, 29 Nov 2021 15:07:42 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TQ+h62teRFib for <kvmarm@lists.cs.columbia.edu>;
 Mon, 29 Nov 2021 15:07:41 -0500 (EST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 42B574B0BE
 for <kvmarm@lists.cs.columbia.edu>; Mon, 29 Nov 2021 15:07:39 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 3F9E9CE16B4;
 Mon, 29 Nov 2021 20:07:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC375C53FAD;
 Mon, 29 Nov 2021 20:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638216455;
 bh=DG5uIX2bquWNN63M+COe51RmuG6Tckf1/Wal1EhHeWQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PgN2Z/OT8rVmyE94YzzntX/KUyOTHCZnRlRXDduWjQrOkZKgVv6yfHHBGolbg7Nqx
 6bDu9wn/R9jJdYNFgupIxbU0za3fZrON2Ho/DvmeQQo8RNQcBl59h19dBQU1nkha7U
 NfGGcz77oIMxRDzLBUVM2qk5ydaEfvYKDbpzcfA7+8mEVbz/6SLhxo68cIQfSZy/fq
 AfSRGOI+FnYDqL2MxD7qVlXskidM4rvG2jn0PsgffeUxH3zvZHFhqCcOFCJAbJiH4i
 0Tfk07PnuF6ndJjeES3rqAPN8kc0OT2Wi6Nzr4vncjjAbPTAfCrq/g8gJlP8uglu9L
 1majtVC9ZYfKw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1mrmqw-008gvR-CX; Mon, 29 Nov 2021 20:02:18 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: [PATCH v5 28/69] KVM: arm64: nv: Respect virtual CPTR_EL2.{TFP,
 FPEN} settings
Date: Mon, 29 Nov 2021 20:01:09 +0000
Message-Id: <20211129200150.351436-29-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211129200150.351436-1-maz@kernel.org>
References: <20211129200150.351436-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, andre.przywara@arm.com,
 christoffer.dall@arm.com, jintack@cs.columbia.edu, haibo.xu@linaro.org,
 gankulkarni@os.amperecomputing.com, james.morse@arm.com,
 suzuki.poulose@arm.com, alexandru.elisei@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, Andre Przywara <andre.przywara@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
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

From: Jintack Lim <jintack.lim@linaro.org>

Forward traps due to FP/ASIMD register accesses to the virtual EL2
if virtual CPTR_EL2.TFP is set (with HCR_EL2.E2H == 0) or
CPTR_EL2.FPEN is configure to do so (with HCR_EL2.E2h == 1).

Signed-off-by: Jintack Lim <jintack.lim@linaro.org>
Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
[maz: account for HCR_EL2.E2H when testing for TFP/FPEN, with
 all the hard work actually being done by Chase Conklin]
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/kvm_emulate.h    | 26 +++++++++++++++++++++++++
 arch/arm64/kvm/handle_exit.c            | 16 +++++++++++----
 arch/arm64/kvm/hyp/include/hyp/switch.h |  8 ++++++--
 3 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 2db11ff3fdad..105fb0d4a366 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -11,12 +11,14 @@
 #ifndef __ARM64_KVM_EMULATE_H__
 #define __ARM64_KVM_EMULATE_H__
 
+#include <linux/bitfield.h>
 #include <linux/kvm_host.h>
 
 #include <asm/debug-monitors.h>
 #include <asm/esr.h>
 #include <asm/kvm_arm.h>
 #include <asm/kvm_hyp.h>
+#include <asm/kvm_nested.h>
 #include <asm/ptrace.h>
 #include <asm/cputype.h>
 #include <asm/virt.h>
@@ -324,6 +326,30 @@ static inline bool vcpu_mode_priv(const struct kvm_vcpu *vcpu)
 	return mode != PSR_MODE_EL0t;
 }
 
+static inline bool guest_hyp_fpsimd_traps_enabled(const struct kvm_vcpu *vcpu)
+{
+	u64 val;
+
+	if (!nested_virt_in_use(vcpu))
+		return false;
+
+	val = vcpu_read_sys_reg(vcpu, CPTR_EL2);
+
+	if (!vcpu_el2_e2h_is_set(vcpu))
+		return (val & CPTR_EL2_TFP);
+
+	switch (FIELD_GET(CPACR_EL1_FPEN, val)) {
+	case 0b00:
+	case 0b10:
+		return true;
+	case 0b01:
+		return vcpu_el2_tge_is_set(vcpu) && !vcpu_mode_el2(vcpu);
+	case 0b11:
+	default:		/* GCC is dumb */
+		return false;
+	}
+}
+
 static __always_inline u32 kvm_vcpu_get_esr(const struct kvm_vcpu *vcpu)
 {
 	return vcpu->arch.fault.esr_el2;
diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index 68a9579aa13e..7721c7c36137 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -96,11 +96,19 @@ static int handle_smc(struct kvm_vcpu *vcpu)
 }
 
 /*
- * Guest access to FP/ASIMD registers are routed to this handler only
- * when the system doesn't support FP/ASIMD.
+ * This handles the cases where the system does not support FP/ASIMD or when
+ * we are running nested virtualization and the guest hypervisor is trapping
+ * FP/ASIMD accesses by its guest guest.
+ *
+ * All other handling of guest vs. host FP/ASIMD register state is handled in
+ * fixup_guest_exit().
  */
-static int handle_no_fpsimd(struct kvm_vcpu *vcpu)
+static int kvm_handle_fpasimd(struct kvm_vcpu *vcpu)
 {
+	if (guest_hyp_fpsimd_traps_enabled(vcpu))
+		return kvm_inject_nested_sync(vcpu, kvm_vcpu_get_esr(vcpu));
+
+	/* This is the case when the system doesn't support FP/ASIMD. */
 	kvm_inject_undefined(vcpu);
 	return 1;
 }
@@ -229,7 +237,7 @@ static exit_handle_fn arm_exit_handlers[] = {
 	[ESR_ELx_EC_BREAKPT_LOW]= kvm_handle_guest_debug,
 	[ESR_ELx_EC_BKPT32]	= kvm_handle_guest_debug,
 	[ESR_ELx_EC_BRK64]	= kvm_handle_guest_debug,
-	[ESR_ELx_EC_FP_ASIMD]	= handle_no_fpsimd,
+	[ESR_ELx_EC_FP_ASIMD]	= kvm_handle_fpasimd,
 	[ESR_ELx_EC_PAC]	= kvm_handle_ptrauth,
 };
 
diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index 0987abd4d57d..110b347f887a 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -184,8 +184,12 @@ static bool kvm_hyp_handle_fpsimd(struct kvm_vcpu *vcpu, u64 *exit_code)
 
 	esr_ec = kvm_vcpu_trap_get_class(vcpu);
 
-	/* Don't handle SVE traps for non-SVE vcpus here: */
-	if (!sve_guest && esr_ec != ESR_ELx_EC_FP_ASIMD)
+	/*
+	 * Don't handle SVE traps for non-SVE vcpus here. This
+	 * includes NV guests for the time being.
+	 */
+	if (!sve_guest && (esr_ec != ESR_ELx_EC_FP_ASIMD ||
+			   guest_hyp_fpsimd_traps_enabled(vcpu)))
 		return false;
 
 	/* Valid trap.  Switch the context: */
-- 
2.30.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
