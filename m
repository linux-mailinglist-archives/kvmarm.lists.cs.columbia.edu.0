Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7C87E3795AA
	for <lists+kvmarm@lfdr.de>; Mon, 10 May 2021 19:28:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 248A14B75E;
	Mon, 10 May 2021 13:28:13 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kP-xC25wG49R; Mon, 10 May 2021 13:28:13 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 27F974B832;
	Mon, 10 May 2021 13:28:10 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4CB184B429
 for <kvmarm@lists.cs.columbia.edu>; Mon, 10 May 2021 13:28:09 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GK07RroNkzWf for <kvmarm@lists.cs.columbia.edu>;
 Mon, 10 May 2021 13:28:08 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 82E924B84B
 for <kvmarm@lists.cs.columbia.edu>; Mon, 10 May 2021 13:28:06 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 46B606147F;
 Mon, 10 May 2021 17:28:05 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1lg9GZ-000Uqg-IK; Mon, 10 May 2021 18:00:23 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: [PATCH v4 38/66] KVM: arm64: nv: Introduce sys_reg_desc.forward_trap
Date: Mon, 10 May 2021 17:58:52 +0100
Message-Id: <20210510165920.1913477-39-maz@kernel.org>
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

This introduces a function prototype to determine if we need to forward
system instruction traps to the virtual EL2. The implementation of
forward_trap functions for each system instruction will be added in
later patches.

Signed-off-by: Jintack Lim <jintack.lim@linaro.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kvm/sys_regs.c | 8 ++++++++
 arch/arm64/kvm/sys_regs.h | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 7353d5eaeaca..14d1aac58f26 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2532,6 +2532,14 @@ static void perform_access(struct kvm_vcpu *vcpu,
 	 */
 	BUG_ON(!r->access);
 
+	/*
+	 * Forward this trap to the virtual EL2 if the guest hypervisor has
+	 * configured to trap the current instruction.
+	 */
+	if (nested_virt_in_use(vcpu) && r->forward_trap
+	    && unlikely(r->forward_trap(vcpu)))
+		return;
+
 	/* Skip instruction if instructed so */
 	if (likely(r->access(vcpu, params, r)))
 		kvm_incr_pc(vcpu);
diff --git a/arch/arm64/kvm/sys_regs.h b/arch/arm64/kvm/sys_regs.h
index c6fbe3a7855e..12227a3a6bb3 100644
--- a/arch/arm64/kvm/sys_regs.h
+++ b/arch/arm64/kvm/sys_regs.h
@@ -58,6 +58,12 @@ struct sys_reg_desc {
 	int (*set_user)(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
 			const struct kvm_one_reg *reg, void __user *uaddr);
 
+	/*
+	 * Forward the trap to the virtual EL2 if the guest hypervisor has
+	 * configured to trap the current instruction.
+	 */
+	bool (*forward_trap)(struct kvm_vcpu *vcpu);
+
 	/* Return mask of REG_* runtime visibility overrides */
 	unsigned int (*visibility)(const struct kvm_vcpu *vcpu,
 				   const struct sys_reg_desc *rd);
-- 
2.29.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
