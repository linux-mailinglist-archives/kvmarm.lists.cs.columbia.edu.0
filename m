Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBC63795CA
	for <lists+kvmarm@lfdr.de>; Mon, 10 May 2021 19:28:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0FE194B5E4;
	Mon, 10 May 2021 13:28:54 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J1O-umlw7dnY; Mon, 10 May 2021 13:28:52 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 98DE34B841;
	Mon, 10 May 2021 13:28:50 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D19C64B841
 for <kvmarm@lists.cs.columbia.edu>; Mon, 10 May 2021 13:28:49 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i4zkWRhAE0p5 for <kvmarm@lists.cs.columbia.edu>;
 Mon, 10 May 2021 13:28:48 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 35A844B84D
 for <kvmarm@lists.cs.columbia.edu>; Mon, 10 May 2021 13:28:45 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 57F6D6162C;
 Mon, 10 May 2021 17:28:44 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1lg9GM-000Uqg-Qy; Mon, 10 May 2021 18:00:10 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: [PATCH v4 24/66] KVM: arm64: nv: Respect the virtual HCR_EL2.NV bit
 setting
Date: Mon, 10 May 2021 17:58:38 +0100
Message-Id: <20210510165920.1913477-25-maz@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210510165920.1913477-1-maz@kernel.org>
References: <20210510165920.1913477-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, andre.przywara@arm.com,
 christoffer.dall@arm.com, jintack@cs.columbia.edu, haibo.xu@linaro.org,
 james.morse@arm.com, suzuki.poulose@arm.com, alexandru.elisei@arm.com,
 kernel-team@android.com, jintack.lim@linaro.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, Andre Przywara <andre.przywara@arm.com>,
 Jintack Lim <jintack.lim@linaro.org>
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

Forward traps due to HCR_EL2.NV bit to the virtual EL2 if they are not
coming from the virtual EL2 and the virtual HCR_EL2.NV bit is set.

In addition to EL2 register accesses, setting NV bit will also make EL12
register accesses trap to EL2. To emulate this for the virtual EL2,
forword traps due to EL12 register accessses to the virtual EL2 if the
virtual HCR_EL2.NV bit is set.

This is for recursive nested virtualization.

Signed-off-by: Jintack Lim <jintack.lim@linaro.org>
[Moved code to emulate-nested.c]
Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/kvm_arm.h    |  1 +
 arch/arm64/include/asm/kvm_nested.h |  2 ++
 arch/arm64/kvm/emulate-nested.c     | 27 +++++++++++++++++++++++++++
 arch/arm64/kvm/handle_exit.c        |  7 +++++++
 arch/arm64/kvm/sys_regs.c           | 24 ++++++++++++++++++++++++
 5 files changed, 61 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index 4f987bd8fcf3..a85d7ea646cd 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -14,6 +14,7 @@
 /* Hyp Configuration Register (HCR) bits */
 #define HCR_ATA		(UL(1) << 56)
 #define HCR_FWB		(UL(1) << 46)
+#define HCR_NV		(UL(1) << 42)
 #define HCR_API		(UL(1) << 41)
 #define HCR_APK		(UL(1) << 40)
 #define HCR_TEA		(UL(1) << 37)
diff --git a/arch/arm64/include/asm/kvm_nested.h b/arch/arm64/include/asm/kvm_nested.h
index 4c2ac9650a3e..26cba7b4d743 100644
--- a/arch/arm64/include/asm/kvm_nested.h
+++ b/arch/arm64/include/asm/kvm_nested.h
@@ -62,5 +62,7 @@ static inline u64 translate_cnthctl_el2_to_cntkctl_el1(u64 cnthctl)
 }
 
 int handle_wfx_nested(struct kvm_vcpu *vcpu, bool is_wfe);
+extern bool forward_traps(struct kvm_vcpu *vcpu, u64 control_bit);
+extern bool forward_nv_traps(struct kvm_vcpu *vcpu);
 
 #endif /* __ARM64_KVM_NESTED_H */
diff --git a/arch/arm64/kvm/emulate-nested.c b/arch/arm64/kvm/emulate-nested.c
index ee91bcd925d8..feb9b5eded96 100644
--- a/arch/arm64/kvm/emulate-nested.c
+++ b/arch/arm64/kvm/emulate-nested.c
@@ -25,11 +25,38 @@
 
 #include "trace.h"
 
+bool forward_traps(struct kvm_vcpu *vcpu, u64 control_bit)
+{
+	bool control_bit_set;
+
+	if (!nested_virt_in_use(vcpu))
+		return false;
+
+	control_bit_set = __vcpu_sys_reg(vcpu, HCR_EL2) & control_bit;
+	if (!vcpu_mode_el2(vcpu) && control_bit_set) {
+		kvm_inject_nested_sync(vcpu, kvm_vcpu_get_esr(vcpu));
+		return true;
+	}
+	return false;
+}
+
+bool forward_nv_traps(struct kvm_vcpu *vcpu)
+{
+	return forward_traps(vcpu, HCR_NV);
+}
+
 void kvm_emulate_nested_eret(struct kvm_vcpu *vcpu)
 {
 	u64 spsr, elr, mode;
 	bool direct_eret;
 
+	/*
+	 * Forward this trap to the virtual EL2 if the virtual
+	 * HCR_EL2.NV bit is set and this is coming from !EL2.
+	 */
+	if (forward_nv_traps(vcpu))
+		return;
+
 	/*
 	 * Going through the whole put/load motions is a waste of time
 	 * if this is a VHE guest hypervisor returning to its own
diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index 3380c5a91b60..5f1e3989c4bc 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -64,6 +64,13 @@ static int handle_smc(struct kvm_vcpu *vcpu)
 {
 	int ret;
 
+	/*
+	 * Forward this trapped smc instruction to the virtual EL2 if
+	 * the guest has asked for it.
+	 */
+	if (forward_traps(vcpu, HCR_TSC))
+		return 1;
+
 	/*
 	 * "If an SMC instruction executed at Non-secure EL1 is
 	 * trapped to EL2 because HCR_EL2.TSC is 1, the exception is a
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index d5c4455713c4..98b6fe77b53e 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -271,10 +271,19 @@ static u32 get_ccsidr(u32 csselr)
 	return ccsidr;
 }
 
+static bool el12_reg(struct sys_reg_params *p)
+{
+	/* All *_EL12 registers have Op1=5. */
+	return (p->Op1 == 5);
+}
+
 static bool access_rw(struct kvm_vcpu *vcpu,
 		      struct sys_reg_params *p,
 		      const struct sys_reg_desc *r)
 {
+	if (el12_reg(p) && forward_nv_traps(vcpu))
+		return false;
+
 	if (p->is_write)
 		vcpu_write_sys_reg(vcpu, p->regval, r->reg);
 	else
@@ -287,6 +296,9 @@ static bool access_sctlr_el2(struct kvm_vcpu *vcpu,
 			     struct sys_reg_params *p,
 			     const struct sys_reg_desc *r)
 {
+	if (el12_reg(p) && forward_nv_traps(vcpu))
+		return false;
+
 	if (p->is_write) {
 		u64 val = p->regval;
 
@@ -371,6 +383,9 @@ static bool access_vm_reg(struct kvm_vcpu *vcpu,
 	bool was_enabled = vcpu_has_cache_enabled(vcpu);
 	u64 val, mask, shift;
 
+	if (el12_reg(p) && forward_nv_traps(vcpu))
+		return false;
+
 	/* We don't expect TRVM on the host */
 	BUG_ON(!vcpu_mode_el2(vcpu) && !p->is_write);
 
@@ -1588,6 +1603,9 @@ static bool access_elr(struct kvm_vcpu *vcpu,
 		       struct sys_reg_params *p,
 		       const struct sys_reg_desc *r)
 {
+	if (el12_reg(p) && forward_nv_traps(vcpu))
+		return false;
+
 	if (p->is_write)
 		vcpu_write_sys_reg(vcpu, p->regval, ELR_EL1);
 	else
@@ -1600,6 +1618,9 @@ static bool access_spsr(struct kvm_vcpu *vcpu,
 			struct sys_reg_params *p,
 			const struct sys_reg_desc *r)
 {
+	if (el12_reg(p) && forward_nv_traps(vcpu))
+		return false;
+
 	if (p->is_write)
 		__vcpu_sys_reg(vcpu, SPSR_EL1) = p->regval;
 	else
@@ -1612,6 +1633,9 @@ static bool access_spsr_el2(struct kvm_vcpu *vcpu,
 			    struct sys_reg_params *p,
 			    const struct sys_reg_desc *r)
 {
+	if (el12_reg(p) && forward_nv_traps(vcpu))
+		return false;
+
 	if (p->is_write)
 		vcpu_write_sys_reg(vcpu, p->regval, SPSR_EL2);
 	else
-- 
2.29.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
