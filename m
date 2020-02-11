Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3B69F1596F8
	for <lists+kvmarm@lfdr.de>; Tue, 11 Feb 2020 18:52:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E0B6E40456;
	Tue, 11 Feb 2020 12:52:26 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gWS+bNruchP0; Tue, 11 Feb 2020 12:52:25 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6053B4AEB9;
	Tue, 11 Feb 2020 12:52:23 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5584240456
 for <kvmarm@lists.cs.columbia.edu>; Tue, 11 Feb 2020 12:52:22 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KfscqUGTemEo for <kvmarm@lists.cs.columbia.edu>;
 Tue, 11 Feb 2020 12:52:21 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 4C9454AEBF
 for <kvmarm@lists.cs.columbia.edu>; Tue, 11 Feb 2020 12:52:20 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7E2FF20578;
 Tue, 11 Feb 2020 17:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581443539;
 bh=6SUf7Shc+/IFCYs1C6g+zQGf7SmOWSMKA9XYRA+43PI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YYe5WwvV9eLZIYh3pi0tYkueQOc1NtS75Xt9BCKB3kIlxkjSEym1Mygh4GrtSU8jq
 wXyDAlKkUxlKfy2NE9abDL6f/XPhs2ebqlBrHggTkmJ+XnL6dYI0i9zruPhY/WbJ51
 crVvzn4mfzSOEvzjTp3ELbbM91HQVKcOSmX6701U=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1j1Zfc-004O7k-Ib; Tue, 11 Feb 2020 17:50:00 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: [PATCH v2 12/94] KVM: arm64: nv: Add EL2->EL1 translation helpers
Date: Tue, 11 Feb 2020 17:48:16 +0000
Message-Id: <20200211174938.27809-13-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200211174938.27809-1-maz@kernel.org>
References: <20200211174938.27809-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, andre.przywara@arm.com,
 christoffer.dall@arm.com, Dave.Martin@arm.com, jintack@cs.columbia.edu,
 alexandru.elisei@arm.com, james.morse@arm.com, julien.thierry.kdev@gmail.com,
 suzuki.poulose@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Andre Przywara <andre.przywara@arm.com>, Dave Martin <Dave.Martin@arm.com>
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

Some EL2 system registers immediately affect the current execution
of the system, so we need to use their respective EL1 counterparts.
For this we need to define a mapping between the two.

These helpers will get used in subsequent patches.

Co-developed-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/kvm_emulate.h |  6 ++++
 arch/arm64/kvm/sys_regs.c            | 48 ++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 282e9ddbe1bc..486978d0346b 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -58,6 +58,12 @@ void kvm_emulate_nested_eret(struct kvm_vcpu *vcpu);
 int kvm_inject_nested_sync(struct kvm_vcpu *vcpu, u64 esr_el2);
 int kvm_inject_nested_irq(struct kvm_vcpu *vcpu);
 
+u64 translate_tcr(u64 tcr);
+u64 translate_cptr(u64 tcr);
+u64 translate_sctlr(u64 tcr);
+u64 translate_ttbr0(u64 tcr);
+u64 translate_cnthctl(u64 tcr);
+
 static inline bool vcpu_el1_is_32bit(struct kvm_vcpu *vcpu)
 {
 	return !(vcpu->arch.hcr_el2 & HCR_RW);
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 4b5310ea3bf8..634d3ee6799c 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -65,6 +65,54 @@ static bool write_to_read_only(struct kvm_vcpu *vcpu,
 	return false;
 }
 
+static u64 tcr_el2_ips_to_tcr_el1_ps(u64 tcr_el2)
+{
+	return ((tcr_el2 & TCR_EL2_PS_MASK) >> TCR_EL2_PS_SHIFT)
+		<< TCR_IPS_SHIFT;
+}
+
+u64 translate_tcr(u64 tcr)
+{
+	return TCR_EPD1_MASK |				/* disable TTBR1_EL1 */
+	       ((tcr & TCR_EL2_TBI) ? TCR_TBI0 : 0) |
+	       tcr_el2_ips_to_tcr_el1_ps(tcr) |
+	       (tcr & TCR_EL2_TG0_MASK) |
+	       (tcr & TCR_EL2_ORGN0_MASK) |
+	       (tcr & TCR_EL2_IRGN0_MASK) |
+	       (tcr & TCR_EL2_T0SZ_MASK);
+}
+
+u64 translate_cptr(u64 cptr_el2)
+{
+	u64 cpacr_el1 = 0;
+
+	if (!(cptr_el2 & CPTR_EL2_TFP))
+		cpacr_el1 |= CPACR_EL1_FPEN;
+	if (cptr_el2 & CPTR_EL2_TTA)
+		cpacr_el1 |= CPACR_EL1_TTA;
+	if (!(cptr_el2 & CPTR_EL2_TZ))
+		cpacr_el1 |= CPACR_EL1_ZEN;
+
+	return cpacr_el1;
+}
+
+u64 translate_sctlr(u64 sctlr)
+{
+	/* Bit 20 is RES1 in SCTLR_EL1, but RES0 in SCTLR_EL2 */
+	return sctlr | BIT(20);
+}
+
+u64 translate_ttbr0(u64 ttbr0)
+{
+	/* Force ASID to 0 (ASID 0 or RES0) */
+	return ttbr0 & ~GENMASK_ULL(63, 48);
+}
+
+u64 translate_cnthctl(u64 cnthctl)
+{
+	return ((cnthctl & 0x3) << 10) | (cnthctl & 0xfc);
+}
+
 u64 vcpu_read_sys_reg(const struct kvm_vcpu *vcpu, int reg)
 {
 	if (!vcpu->arch.sysregs_loaded_on_cpu)
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
