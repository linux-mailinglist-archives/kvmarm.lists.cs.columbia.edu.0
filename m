Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 01802379584
	for <lists+kvmarm@lfdr.de>; Mon, 10 May 2021 19:27:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A59924B451;
	Mon, 10 May 2021 13:27:22 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S3YkaVQhFKcY; Mon, 10 May 2021 13:27:22 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2BEDE4B4EF;
	Mon, 10 May 2021 13:27:21 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5C9844B490
 for <kvmarm@lists.cs.columbia.edu>; Mon, 10 May 2021 13:27:19 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Qt-X56V2QC4m for <kvmarm@lists.cs.columbia.edu>;
 Mon, 10 May 2021 13:27:18 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 2474F4B433
 for <kvmarm@lists.cs.columbia.edu>; Mon, 10 May 2021 13:27:18 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4CF2461469;
 Mon, 10 May 2021 17:27:17 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1lg9GI-000Uqg-LG; Mon, 10 May 2021 18:00:07 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: [PATCH v4 21/66] KVM: arm64: nv: Handle PSCI call via smc from the
 guest
Date: Mon, 10 May 2021 17:58:35 +0100
Message-Id: <20210510165920.1913477-22-maz@kernel.org>
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

VMs used to execute hvc #0 for the psci call if EL3 is not implemented.
However, when we come to provide the virtual EL2 mode to the VM, the
host OS inside the VM calls kvm_call_hyp() which is also hvc #0. So,
it's hard to differentiate between them from the host hypervisor's point
of view.

So, let the VM execute smc instruction for the psci call. On ARMv8.3,
even if EL3 is not implemented, a smc instruction executed at non-secure
EL1 is trapped to EL2 if HCR_EL2.TSC==1, rather than being treated as
UNDEFINED. So, the host hypervisor can handle this psci call without any
confusion.

Signed-off-by: Jintack Lim <jintack.lim@linaro.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kvm/handle_exit.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index fca0d44afe96..f0fc99c7c9ca 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -62,6 +62,8 @@ static int handle_hvc(struct kvm_vcpu *vcpu)
 
 static int handle_smc(struct kvm_vcpu *vcpu)
 {
+	int ret;
+
 	/*
 	 * "If an SMC instruction executed at Non-secure EL1 is
 	 * trapped to EL2 because HCR_EL2.TSC is 1, the exception is a
@@ -69,10 +71,28 @@ static int handle_smc(struct kvm_vcpu *vcpu)
 	 *
 	 * We need to advance the PC after the trap, as it would
 	 * otherwise return to the same address...
+	 *
+	 * If imm is non-zero, it's not defined, so just skip it.
+	 */
+	if (kvm_vcpu_hvc_get_imm(vcpu)) {
+		vcpu_set_reg(vcpu, 0, ~0UL);
+		kvm_incr_pc(vcpu);
+		return 1;
+	}
+
+	/*
+	 * If imm is zero, it's a psci call.
+	 * Note that on ARMv8.3, even if EL3 is not implemented, SMC executed
+	 * at Non-secure EL1 is trapped to EL2 if HCR_EL2.TSC==1, rather than
+	 * being treated as UNDEFINED.
 	 */
-	vcpu_set_reg(vcpu, 0, ~0UL);
+	ret = kvm_hvc_call_handler(vcpu);
+	if (ret < 0)
+		vcpu_set_reg(vcpu, 0, ~0UL);
+
 	kvm_incr_pc(vcpu);
-	return 1;
+
+	return ret;
 }
 
 /*
-- 
2.29.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
