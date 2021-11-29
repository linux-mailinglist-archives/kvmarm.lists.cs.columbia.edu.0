Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 254D046219B
	for <lists+kvmarm@lfdr.de>; Mon, 29 Nov 2021 21:07:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BE50D4B191;
	Mon, 29 Nov 2021 15:07:30 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, T_DKIM_INVALID=0.01]
	autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1hDY2+ez3woV; Mon, 29 Nov 2021 15:07:29 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 692724B1F5;
	Mon, 29 Nov 2021 15:07:29 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9EF8349F8F
 for <kvmarm@lists.cs.columbia.edu>; Mon, 29 Nov 2021 15:07:28 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g9cRWtqjGeOa for <kvmarm@lists.cs.columbia.edu>;
 Mon, 29 Nov 2021 15:07:26 -0500 (EST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 0A3854B191
 for <kvmarm@lists.cs.columbia.edu>; Mon, 29 Nov 2021 15:07:25 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 0B8ECCE167D;
 Mon, 29 Nov 2021 20:07:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56279C53FD1;
 Mon, 29 Nov 2021 20:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638216441;
 bh=KgGc5JJnyi+xoK5NH4X6bBiIwukmrEnb3nTjfxdMvYs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=P5/kxhwLYUpTNjFQPl07X15iWM7Puie4W0qXKlsI0nCQIwSm2vNPGG4JXlAPmMbqL
 leElLrzDLpKJj8clKWKzpBWKLGhjGWMouOK+t71bKIB0+J/Gsh4L0zGOV1MqRvqQiM
 LwW9Pb116GhM8Bpr4ql6tf3zVXsrYjzgrN627OJkt8uVSyZUKkdKGEQYTaVFUiKSWP
 NCRnEGHfx61c4ztDdCErsrtapGmKDg10bkTL95O3NTQkb08beSWiDGHmdCITxl2b9W
 VGzB+gaYA7Xfe54zOrcE0RAUYCAtlDAy+Ip9hqBhki6Fb1LkJNXfvjEFVnH8f+yBkx
 l/iPWDAWbCROw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1mrmrJ-008gvR-0I; Mon, 29 Nov 2021 20:02:41 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: [PATCH v5 68/69] KVM: arm64: nv: Fast-track 'InHost' exception returns
Date: Mon, 29 Nov 2021 20:01:49 +0000
Message-Id: <20211129200150.351436-69-maz@kernel.org>
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
 arch/arm64/kvm/emulate-nested.c | 26 ++-----------------
 arch/arm64/kvm/hyp/vhe/switch.c | 46 +++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/kvm/emulate-nested.c b/arch/arm64/kvm/emulate-nested.c
index 5fbf8978acf2..97e26a4539a9 100644
--- a/arch/arm64/kvm/emulate-nested.c
+++ b/arch/arm64/kvm/emulate-nested.c
@@ -52,8 +52,7 @@ bool forward_nv_traps(struct kvm_vcpu *vcpu)
 
 void kvm_emulate_nested_eret(struct kvm_vcpu *vcpu)
 {
-	u64 spsr, elr, mode;
-	bool direct_eret;
+	u64 spsr, elr;
 
 	/*
 	 * Forward this trap to the virtual EL2 if the virtual
@@ -62,31 +61,10 @@ void kvm_emulate_nested_eret(struct kvm_vcpu *vcpu)
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
 	elr = __vcpu_sys_reg(vcpu, ELR_EL2);
 
 	trace_kvm_nested_eret(vcpu, elr, spsr);
diff --git a/arch/arm64/kvm/hyp/vhe/switch.c b/arch/arm64/kvm/hyp/vhe/switch.c
index 5cadda79089a..6cbe6a89dbdb 100644
--- a/arch/arm64/kvm/hyp/vhe/switch.c
+++ b/arch/arm64/kvm/hyp/vhe/switch.c
@@ -162,6 +162,51 @@ void deactivate_traps_vhe_put(struct kvm_vcpu *vcpu)
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
@@ -171,6 +216,7 @@ static const exit_handler_fn hyp_exit_handlers[] = {
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
