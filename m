Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id CA19149F91C
	for <lists+kvmarm@lfdr.de>; Fri, 28 Jan 2022 13:19:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5CAC64B0A0;
	Fri, 28 Jan 2022 07:19:36 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PoceB8Hjkzmf; Fri, 28 Jan 2022 07:19:36 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EB78C49F1C;
	Fri, 28 Jan 2022 07:19:33 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1D74F49EBC
 for <kvmarm@lists.cs.columbia.edu>; Fri, 28 Jan 2022 07:19:30 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yTuMgAH-26X8 for <kvmarm@lists.cs.columbia.edu>;
 Fri, 28 Jan 2022 07:19:28 -0500 (EST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id BA69849ED0
 for <kvmarm@lists.cs.columbia.edu>; Fri, 28 Jan 2022 07:19:28 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 3A68061B0A;
 Fri, 28 Jan 2022 12:19:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1033AC340E0;
 Fri, 28 Jan 2022 12:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643372368;
 bh=eRpA7PuBVwK38PgVvtKvrzegVcABRvqReK9LX0r1AU0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ddm4pcY+lGgTTrOvNVArwvxOblcEVr495653UDmvFkm3EXazRmb1zbNu9zOVoJiJ2
 1GssrrVtXk5RRUN96U1SmyFz6yw1RHur0rvQJnwCfNW0NeabTf6whVRQswbgYBMlNx
 Yq9ZKA+JhE9z/NDiUe6+DADuF3qUE3y+UAAHvzkTgInTHipniwr2C6Slf0L061s+9T
 In26ZMv2J9vJzas+wONMniH4bZoBBug49D54QjmZFQNKA6Z0lE0Nmp03bdhCb29/Qu
 r9krduqNcstGQVfESOyLL2fpbxxwurFyktTz7avWHHTGT8JVJESuyi4jdX0FonAywG
 55wpDOuyYlIkA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1nDQDu-003njR-52; Fri, 28 Jan 2022 12:19:26 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: [PATCH v6 06/64] KVM: arm64: nv: Add nested virt VCPU primitives for
 vEL2 VCPU state
Date: Fri, 28 Jan 2022 12:18:14 +0000
Message-Id: <20220128121912.509006-7-maz@kernel.org>
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

When running a nested hypervisor we commonly have to figure out if
the VCPU mode is running in the context of a guest hypervisor or guest
guest, or just a normal guest.

Add convenient primitives for this.

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/kvm_emulate.h | 53 ++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index d62405ce3e6d..ea9a130c4b6a 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -178,6 +178,59 @@ static __always_inline void vcpu_set_reg(struct kvm_vcpu *vcpu, u8 reg_num,
 		vcpu_gp_regs(vcpu)->regs[reg_num] = val;
 }
 
+static inline bool vcpu_is_el2_ctxt(const struct kvm_cpu_context *ctxt)
+{
+	switch (ctxt->regs.pstate & (PSR_MODE32_BIT | PSR_MODE_MASK)) {
+	case PSR_MODE_EL2h:
+	case PSR_MODE_EL2t:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static inline bool vcpu_is_el2(const struct kvm_vcpu *vcpu)
+{
+	return vcpu_is_el2_ctxt(&vcpu->arch.ctxt);
+}
+
+static inline bool __vcpu_el2_e2h_is_set(const struct kvm_cpu_context *ctxt)
+{
+	return ctxt_sys_reg(ctxt, HCR_EL2) & HCR_E2H;
+}
+
+static inline bool vcpu_el2_e2h_is_set(const struct kvm_vcpu *vcpu)
+{
+	return __vcpu_el2_e2h_is_set(&vcpu->arch.ctxt);
+}
+
+static inline bool __vcpu_el2_tge_is_set(const struct kvm_cpu_context *ctxt)
+{
+	return ctxt_sys_reg(ctxt, HCR_EL2) & HCR_TGE;
+}
+
+static inline bool vcpu_el2_tge_is_set(const struct kvm_vcpu *vcpu)
+{
+	return __vcpu_el2_tge_is_set(&vcpu->arch.ctxt);
+}
+
+static inline bool __is_hyp_ctxt(const struct kvm_cpu_context *ctxt)
+{
+	/*
+	 * We are in a hypervisor context if the vcpu mode is EL2 or
+	 * E2H and TGE bits are set. The latter means we are in the user space
+	 * of the VHE kernel. ARMv8.1 ARM describes this as 'InHost'
+	 */
+	return vcpu_is_el2_ctxt(ctxt) ||
+		(__vcpu_el2_e2h_is_set(ctxt) && __vcpu_el2_tge_is_set(ctxt)) ||
+		WARN_ON(__vcpu_el2_tge_is_set(ctxt));
+}
+
+static inline bool is_hyp_ctxt(const struct kvm_vcpu *vcpu)
+{
+	return __is_hyp_ctxt(&vcpu->arch.ctxt);
+}
+
 /*
  * The layout of SPSR for an AArch32 state is different when observed from an
  * AArch64 SPSR_ELx or an AArch32 SPSR_*. This function generates the AArch32
-- 
2.30.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
