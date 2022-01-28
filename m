Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A017A49F947
	for <lists+kvmarm@lfdr.de>; Fri, 28 Jan 2022 13:20:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 34D7F4B183;
	Fri, 28 Jan 2022 07:20:30 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1uQS4YQYF0VN; Fri, 28 Jan 2022 07:20:28 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F0ADF4B166;
	Fri, 28 Jan 2022 07:20:28 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DC7704A193
 for <kvmarm@lists.cs.columbia.edu>; Fri, 28 Jan 2022 07:20:27 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3HgPePtskTMg for <kvmarm@lists.cs.columbia.edu>;
 Fri, 28 Jan 2022 07:20:26 -0500 (EST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 01D6B4B192
 for <kvmarm@lists.cs.columbia.edu>; Fri, 28 Jan 2022 07:20:26 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 276A5B82569;
 Fri, 28 Jan 2022 12:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3866C340E6;
 Fri, 28 Jan 2022 12:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643372424;
 bh=gje3vkA14UP3nuQudSVwEhD1rU5ROtZr2FwWBn4yqXQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mS3nInkNlWiWb/tBu/Ah592ypmHhIKBgNKfESpsUwYtcnbbQCUPy5sUPCoDkH6Cxf
 wJxLFG0AjzF+KlFh/2ZtiVahMObah5VvuVdAvWKKG1IBNhyMc9NsQ93MN3gi/9DMxD
 4C7ZGIAxxbMiLBIzKpZo4n8GhK+1HRNWPQ/fwVfMDMwVd/j7X0eYxxTGosAl+dBkVI
 OfDpEn6sc01q0sjcb6VpUCR2SSGpYGxBJ7fMMSdz/2pjMYT/UPtY4UNnhtxuYjpyss
 j11Emlt4oFbUcR6nfuQu3RgZtrg/K3sBwoNkDqO0D9fv9hje2P9EZH1WjYfElSv/Un
 XRuxKMvjtKj0A==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1nDQDy-003njR-C7; Fri, 28 Jan 2022 12:19:30 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: [PATCH v6 17/64] KVM: arm64: nv: Emulate PSTATE.M for a guest
 hypervisor
Date: Fri, 28 Jan 2022 12:18:25 +0000
Message-Id: <20220128121912.509006-18-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220128121912.509006-1-maz@kernel.org>
References: <20220128121912.509006-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, andre.przywara@arm.com,
 christoffer.dall@arm.com, jintack@cs.columbia.edu, haibo.xu@linaro.org,
 gankulkarni@os.amperecomputing.com, chase.conklin@arm.com,
 linux@armlinux.org.uk, james.morse@arm.com, suzuki.poulose@arm.com,
 alexandru.elisei@arm.com, karl.heubaum@oracle.com, mihai.carabas@oracle.com,
 miguel.luis@oracle.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, Andre Przywara <andre.przywara@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Chase Conklin <chase.conklin@arm.com>,
 "Russell King \(Oracle\)" <linux@armlinux.org.uk>, mihai.carabas@oracle.com,
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

From: Christoffer Dall <christoffer.dall@arm.com>

We can no longer blindly copy the VCPU's PSTATE into SPSR_EL2 and return
to the guest and vice versa when taking an exception to the hypervisor,
because we emulate virtual EL2 in EL1 and therefore have to translate
the mode field from EL2 to EL1 and vice versa.

This requires keeping track of the state we enter the guest, for which
we transiently use a dedicated flag.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h          |  1 +
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h | 19 ++++++++++++++++-
 arch/arm64/kvm/hyp/vhe/switch.c            | 24 ++++++++++++++++++++++
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 8fffe2888403..fa253f08e0fd 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -472,6 +472,7 @@ struct kvm_vcpu_arch {
 #define KVM_ARM64_DEBUG_STATE_SAVE_SPE	(1 << 12) /* Save SPE context if active  */
 #define KVM_ARM64_DEBUG_STATE_SAVE_TRBE	(1 << 13) /* Save TRBE context if active  */
 #define KVM_ARM64_FP_FOREIGN_FPSTATE	(1 << 14)
+#define KVM_ARM64_IN_HYP_CONTEXT	(1 << 15) /* Guest running in HYP context */
 
 #define KVM_GUESTDBG_VALID_MASK (KVM_GUESTDBG_ENABLE | \
 				 KVM_GUESTDBG_USE_SW_BP | \
diff --git a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
index 283f780f5f56..e3689c6ce4cc 100644
--- a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
+++ b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
@@ -157,9 +157,26 @@ static inline void __sysreg_restore_el1_state(struct kvm_cpu_context *ctxt,
 	write_sysreg_el1(ctxt_sys_reg(ctxt, SPSR_EL1),	SYS_SPSR);
 }
 
+/* Read the VCPU state's PSTATE, but translate (v)EL2 to EL1. */
+static inline u64 to_hw_pstate(const struct kvm_cpu_context *ctxt)
+{
+	u64 mode = ctxt->regs.pstate & (PSR_MODE_MASK | PSR_MODE32_BIT);
+
+	switch (mode) {
+	case PSR_MODE_EL2t:
+		mode = PSR_MODE_EL1t;
+		break;
+	case PSR_MODE_EL2h:
+		mode = PSR_MODE_EL1h;
+		break;
+	}
+
+	return (ctxt->regs.pstate & ~(PSR_MODE_MASK | PSR_MODE32_BIT)) | mode;
+}
+
 static inline void __sysreg_restore_el2_return_state(struct kvm_cpu_context *ctxt)
 {
-	u64 pstate = ctxt->regs.pstate;
+	u64 pstate = to_hw_pstate(ctxt);
 	u64 mode = pstate & PSR_AA32_MODE_MASK;
 
 	/*
diff --git a/arch/arm64/kvm/hyp/vhe/switch.c b/arch/arm64/kvm/hyp/vhe/switch.c
index 11d053fdd604..82ddaebe66de 100644
--- a/arch/arm64/kvm/hyp/vhe/switch.c
+++ b/arch/arm64/kvm/hyp/vhe/switch.c
@@ -113,6 +113,25 @@ static const exit_handler_fn *kvm_get_exit_handler_array(struct kvm_vcpu *vcpu)
 
 static void early_exit_filter(struct kvm_vcpu *vcpu, u64 *exit_code)
 {
+	/*
+	 * If we were in HYP context on entry, adjust the PSTATE view
+	 * so that the usual helpers work correctly.
+	 */
+	if (unlikely(vcpu->arch.flags & KVM_ARM64_IN_HYP_CONTEXT)) {
+		u64 mode = *vcpu_cpsr(vcpu) & (PSR_MODE_MASK | PSR_MODE32_BIT);
+
+		switch (mode) {
+		case PSR_MODE_EL1t:
+			mode = PSR_MODE_EL2t;
+			break;
+		case PSR_MODE_EL1h:
+			mode = PSR_MODE_EL2h;
+			break;
+		}
+
+		*vcpu_cpsr(vcpu) &= ~(PSR_MODE_MASK | PSR_MODE32_BIT);
+		*vcpu_cpsr(vcpu) |= mode;
+	}
 }
 
 /* Switch to the guest for VHE systems running in EL2 */
@@ -147,6 +166,11 @@ static int __kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu)
 	sysreg_restore_guest_state_vhe(guest_ctxt);
 	__debug_switch_to_guest(vcpu);
 
+	if (is_hyp_ctxt(vcpu))
+		vcpu->arch.flags |= KVM_ARM64_IN_HYP_CONTEXT;
+	else
+		vcpu->arch.flags &= ~KVM_ARM64_IN_HYP_CONTEXT;
+
 	do {
 		/* Jump in the fire! */
 		exit_code = __guest_enter(vcpu);
-- 
2.30.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
