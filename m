Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6C36149FA02
	for <lists+kvmarm@lfdr.de>; Fri, 28 Jan 2022 13:50:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E28D24B1EF;
	Fri, 28 Jan 2022 07:50:51 -0500 (EST)
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
	with ESMTP id hvntCh0+RTl4; Fri, 28 Jan 2022 07:50:50 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7EFB64B1F4;
	Fri, 28 Jan 2022 07:50:50 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 048F34B1E7
 for <kvmarm@lists.cs.columbia.edu>; Fri, 28 Jan 2022 07:50:49 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EO8+MHqsu8EY for <kvmarm@lists.cs.columbia.edu>;
 Fri, 28 Jan 2022 07:50:47 -0500 (EST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 77A994B1E1
 for <kvmarm@lists.cs.columbia.edu>; Fri, 28 Jan 2022 07:50:46 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id E1EB961C4F;
 Fri, 28 Jan 2022 12:50:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6B19C340E0;
 Fri, 28 Jan 2022 12:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643374245;
 bh=F0Em6ITTrFeHlXFpHaH97jmBz05ld/C99fqLrfsvtwI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nNMZUgTSDc95vhn5CJxF71MSZilSq9yLXgzoGOaK299ZZiyXlQgLuyvfta8t0CQGi
 kt8Ytq+IeMqvRC6en9xS1M8BAeJpm3A2F0kFNEvfHh8CE0RBOBQbVpJMBZaiXqQe0m
 SPe9ZFjiQzy+58Rr8DXcOLB7Vr3FSnicyUbujy/37aN7ohoa+YpitHrL8wyTv1kwXy
 sb1yeHfaed6awyZEXC54SJyrBDDo8lj2A8a0bsCo4qevVXe40N1lA6asMIMR++INIR
 gu0e6qmvuvxmxSEcEEMKjtP0YTKIwam2keFoq1ycyQZdNwXYQ8vk71C6Wx7GsH1Wj/
 0pGIoErti6KwQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1nDQEc-003njR-Io; Fri, 28 Jan 2022 12:20:10 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: [PATCH v6 63/64] KVM: arm64: nv: Fast-track 'InHost' exception returns
Date: Fri, 28 Jan 2022 12:19:11 +0000
Message-Id: <20220128121912.509006-64-maz@kernel.org>
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

A significant part of the ARMv8.3-NV extension is to trap ERET
instructions so that the hypervisor gets a chance to switch
from a vEL2 L1 guest to an EL1 L2 guest.

But this also has the unfortunate consequence of trapping ERET
in unsuspecting circumstances, such as staying at vEL2 (interrupt
handling while being in the guest hypervisor), or returning to host
userspace in the case of a VHE guest.

Although we already make some effort to handle these ERET quicker
by not doing the put/load dance, it is still way too far down the
line for it to be efficient enough.

For these cases, it would ideal to ERET directly, no question asked.
Of course, we can't do that. But the next best thing is to do it as
early as possible, in fixup_guest_exit(), much as we would handle
FPSIMD exceptions.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kvm/emulate-nested.c | 29 +++------------------
 arch/arm64/kvm/hyp/vhe/switch.c | 46 +++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/kvm/emulate-nested.c b/arch/arm64/kvm/emulate-nested.c
index 1f6cf8fe9fe3..3f3b1296b4ac 100644
--- a/arch/arm64/kvm/emulate-nested.c
+++ b/arch/arm64/kvm/emulate-nested.c
@@ -76,8 +76,7 @@ static u64 kvm_check_illegal_exception_return(struct kvm_vcpu *vcpu, u64 spsr)
 
 void kvm_emulate_nested_eret(struct kvm_vcpu *vcpu)
 {
-	u64 spsr, elr, mode;
-	bool direct_eret;
+	u64 spsr, elr;
 
 	/*
 	 * Forward this trap to the virtual EL2 if the virtual
@@ -86,33 +85,11 @@ void kvm_emulate_nested_eret(struct kvm_vcpu *vcpu)
 	if (forward_nv_traps(vcpu))
 		return;
 
-	/*
-	 * Going through the whole put/load motions is a waste of time
-	 * if this is a VHE guest hypervisor returning to its own
-	 * userspace, or the hypervisor performing a local exception
-	 * return. No need to save/restore registers, no need to
-	 * switch S2 MMU. Just do the canonical ERET.
-	 */
-	spsr = vcpu_read_sys_reg(vcpu, SPSR_EL2);
-	spsr = kvm_check_illegal_exception_return(vcpu, spsr);
-
-	mode = spsr & (PSR_MODE_MASK | PSR_MODE32_BIT);
-
-	direct_eret  = (mode == PSR_MODE_EL0t &&
-			vcpu_el2_e2h_is_set(vcpu) &&
-			vcpu_el2_tge_is_set(vcpu));
-	direct_eret |= (mode == PSR_MODE_EL2h || mode == PSR_MODE_EL2t);
-
-	if (direct_eret) {
-		*vcpu_pc(vcpu) = vcpu_read_sys_reg(vcpu, ELR_EL2);
-		*vcpu_cpsr(vcpu) = spsr;
-		trace_kvm_nested_eret(vcpu, *vcpu_pc(vcpu), spsr);
-		return;
-	}
-
 	preempt_disable();
 	kvm_arch_vcpu_put(vcpu);
 
+	spsr = __vcpu_sys_reg(vcpu, SPSR_EL2);
+	spsr = kvm_check_illegal_exception_return(vcpu, spsr);
 	elr = __vcpu_sys_reg(vcpu, ELR_EL2);
 
 	trace_kvm_nested_eret(vcpu, elr, spsr);
diff --git a/arch/arm64/kvm/hyp/vhe/switch.c b/arch/arm64/kvm/hyp/vhe/switch.c
index 65120c9027d6..f469bf51b4be 100644
--- a/arch/arm64/kvm/hyp/vhe/switch.c
+++ b/arch/arm64/kvm/hyp/vhe/switch.c
@@ -161,6 +161,51 @@ void deactivate_traps_vhe_put(struct kvm_vcpu *vcpu)
 	__deactivate_traps_common(vcpu);
 }
 
+static bool kvm_hyp_handle_eret(struct kvm_vcpu *vcpu, u64 *exit_code)
+{
+	struct kvm_cpu_context *ctxt = &vcpu->arch.ctxt;
+	u64 spsr, mode;
+
+	/*
+	 * Going through the whole put/load motions is a waste of time
+	 * if this is a VHE guest hypervisor returning to its own
+	 * userspace, or the hypervisor performing a local exception
+	 * return. No need to save/restore registers, no need to
+	 * switch S2 MMU. Just do the canonical ERET.
+	 *
+	 * Unless the trap has to be forwarded further down the line,
+	 * of course...
+	 */
+	if (__vcpu_sys_reg(vcpu, HCR_EL2) & HCR_NV)
+		return false;
+
+	spsr = read_sysreg_el1(SYS_SPSR);
+	spsr = __fixup_spsr_el2_read(ctxt, spsr);
+	mode = spsr & (PSR_MODE_MASK | PSR_MODE32_BIT);
+
+	switch (mode) {
+	case PSR_MODE_EL0t:
+		if (!(vcpu_el2_e2h_is_set(vcpu) && vcpu_el2_tge_is_set(vcpu)))
+			return false;
+		break;
+	case PSR_MODE_EL2t:
+		mode = PSR_MODE_EL1t;
+		break;
+	case PSR_MODE_EL2h:
+		mode = PSR_MODE_EL1h;
+		break;
+	default:
+		return false;
+	}
+
+	spsr = (spsr & ~(PSR_MODE_MASK | PSR_MODE32_BIT)) | mode;
+
+	write_sysreg_el2(spsr, SYS_SPSR);
+	write_sysreg_el2(read_sysreg_el1(SYS_ELR), SYS_ELR);
+
+	return true;
+}
+
 static const exit_handler_fn hyp_exit_handlers[] = {
 	[0 ... ESR_ELx_EC_MAX]		= NULL,
 	[ESR_ELx_EC_CP15_32]		= kvm_hyp_handle_cp15_32,
@@ -170,6 +215,7 @@ static const exit_handler_fn hyp_exit_handlers[] = {
 	[ESR_ELx_EC_IABT_LOW]		= kvm_hyp_handle_iabt_low,
 	[ESR_ELx_EC_DABT_LOW]		= kvm_hyp_handle_dabt_low,
 	[ESR_ELx_EC_PAC]		= kvm_hyp_handle_ptrauth,
+	[ESR_ELx_EC_ERET]		= kvm_hyp_handle_eret,
 };
 
 static const exit_handler_fn *kvm_get_exit_handler_array(struct kvm_vcpu *vcpu)
-- 
2.30.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
