Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1712E37959E
	for <lists+kvmarm@lfdr.de>; Mon, 10 May 2021 19:27:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B3A634B429;
	Mon, 10 May 2021 13:27:54 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gyiLbxoZBvGN; Mon, 10 May 2021 13:27:54 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1CB544B83E;
	Mon, 10 May 2021 13:27:53 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A03B94B2E6
 for <kvmarm@lists.cs.columbia.edu>; Mon, 10 May 2021 13:27:51 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cUfu6BPsp6xy for <kvmarm@lists.cs.columbia.edu>;
 Mon, 10 May 2021 13:27:50 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 37B154B2BD
 for <kvmarm@lists.cs.columbia.edu>; Mon, 10 May 2021 13:27:50 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6A65461480;
 Mon, 10 May 2021 17:27:49 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1lg9GR-000Uqg-EW; Mon, 10 May 2021 18:00:16 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: [PATCH v4 29/66] KVM: arm64: nv: Configure HCR_EL2 for nested
 virtualization
Date: Mon, 10 May 2021 17:58:43 +0100
Message-Id: <20210510165920.1913477-30-maz@kernel.org>
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

We enable nested virtualization by setting the HCR NV and NV1 bit.

When the virtual E2H bit is set, we can support EL2 register accesses
via EL1 registers from the virtual EL2 by doing trap-and-emulate. A
better alternative, however, is to allow the virtual EL2 to access EL2
register states without trap. This can be easily achieved by not traping
EL1 registers since those registers already have EL2 register states.

Signed-off-by: Jintack Lim <jintack.lim@linaro.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kvm/hyp/vhe/switch.c | 36 ++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/hyp/vhe/switch.c b/arch/arm64/kvm/hyp/vhe/switch.c
index a238f52955c5..79789850639b 100644
--- a/arch/arm64/kvm/hyp/vhe/switch.c
+++ b/arch/arm64/kvm/hyp/vhe/switch.c
@@ -37,9 +37,39 @@ static void __activate_traps(struct kvm_vcpu *vcpu)
 	u64 hcr = vcpu->arch.hcr_el2;
 	u64 val;
 
-	/* Trap VM sysreg accesses if an EL2 guest is not using VHE. */
-	if (vcpu_mode_el2(vcpu) && !vcpu_el2_e2h_is_set(vcpu))
-		hcr |= HCR_TVM | HCR_TRVM;
+	if (is_hyp_ctxt(vcpu)) {
+		hcr |= HCR_NV;
+
+		if (!vcpu_el2_e2h_is_set(vcpu)) {
+			/*
+			 * For a guest hypervisor on v8.0, trap and emulate
+			 * the EL1 virtual memory control register accesses.
+			 */
+			hcr |= HCR_TVM | HCR_TRVM | HCR_NV1;
+		} else {
+			/*
+			 * For a guest hypervisor on v8.1 (VHE), allow to
+			 * access the EL1 virtual memory control registers
+			 * natively. These accesses are to access EL2 register
+			 * states.
+			 * Note that we still need to respect the virtual
+			 * HCR_EL2 state.
+			 */
+			u64 vhcr_el2 = __vcpu_sys_reg(vcpu, HCR_EL2);
+
+			/*
+			 * We already set TVM to handle set/way cache maint
+			 * ops traps, this somewhat collides with the nested
+			 * virt trapping for nVHE. So turn this off for now
+			 * here, in the hope that VHE guests won't ever do this.
+			 * TODO: find out whether it's worth to support both
+			 * cases at the same time.
+			 */
+			hcr &= ~HCR_TVM;
+
+			hcr |= vhcr_el2 & (HCR_TVM | HCR_TRVM);
+		}
+	}
 
 	___activate_traps(vcpu, hcr);
 
-- 
2.29.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
