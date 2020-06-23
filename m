Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E5478205216
	for <lists+kvmarm@lfdr.de>; Tue, 23 Jun 2020 14:12:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 60C854B0FA;
	Tue, 23 Jun 2020 08:12:29 -0400 (EDT)
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
	with ESMTP id FQ3QOe19aeUc; Tue, 23 Jun 2020 08:12:29 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 270D54B0E5;
	Tue, 23 Jun 2020 08:12:27 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6B8B74B0BD
 for <kvmarm@lists.cs.columbia.edu>; Tue, 23 Jun 2020 08:12:26 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Dg7vHGeT3ltp for <kvmarm@lists.cs.columbia.edu>;
 Tue, 23 Jun 2020 08:12:23 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 8FACE4AEDC
 for <kvmarm@lists.cs.columbia.edu>; Tue, 23 Jun 2020 08:12:23 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 745B420707;
 Tue, 23 Jun 2020 12:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592914342;
 bh=82FEL/lqihaAkT9TFcf9PCxFsGrapDUAVvxVatgi5Vo=;
 h=From:To:Cc:Subject:Date:From;
 b=pD87Q8rJB6cjNx4jAe7RfbqAjaHX3486yTR/IyiwU9rVik33STPz3KTZf1mEdrJMm
 MkYRT1QLW4gAG6Coup+KXL+blU0reYnw21TSoS6DYNEIXFu/NM1J+y44m6J6DkXhxG
 QbxgCa5SjpPW/IVpnkfMwAytwNhpiO+WxlwCPa5Q=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jnhmm-005gBg-Rs; Tue, 23 Jun 2020 13:12:21 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: [PATCH] KVM: arm64: vgic-v4: Plug race between non-residency and v4.1
 doorbell
Date: Tue, 23 Jun 2020 13:12:01 +0100
Message-Id: <20200623121201.362532-1-maz@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, james.morse@arm.com,
 julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, kernel-team@android.com,
 yuzenghui@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com
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

When making a vPE non-resident because it has hit a blocking WFI,
the doorbell can fire at any time after the write to the RD.
Crucially, it can fire right between the write to GICR_VPENDBASER
and the write to the pending_last field in the its_vpe structure.

This means that we would overwrite pending_last with stale data,
and potentially not wakeup until some unrelated event (such as
a timer interrupt) puts the vPE back on the CPU.

GICv4 isn't affected by this as we actively mask the doorbell on
entering the guest, while GICv4.1 automatically manages doorbell
delivery without any hypervisor-driven masking.

Use the vpe_lock to synchronize such update, which solves the
problem altogether.

Fixes: ae699ad348cdc ("irqchip/gic-v4.1: Move doorbell management to the GICv4 abstraction layer")
Reported-by: Zenghui Yu <yuzenghui@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kvm/vgic/vgic-v4.c    | 8 ++++++++
 drivers/irqchip/irq-gic-v3-its.c | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm64/kvm/vgic/vgic-v4.c b/arch/arm64/kvm/vgic/vgic-v4.c
index 27ac833e5ec7..b5fa73c9fd35 100644
--- a/arch/arm64/kvm/vgic/vgic-v4.c
+++ b/arch/arm64/kvm/vgic/vgic-v4.c
@@ -90,7 +90,15 @@ static irqreturn_t vgic_v4_doorbell_handler(int irq, void *info)
 	    !irqd_irq_disabled(&irq_to_desc(irq)->irq_data))
 		disable_irq_nosync(irq);
 
+	/*
+	 * The v4.1 doorbell can fire concurrently with the vPE being
+	 * made non-resident. Ensure we only update pending_last
+	 * *after* the non-residency sequence has completed.
+	 */
+	raw_spin_lock(&vcpu->arch.vgic_cpu.vgic_v3.its_vpe.vpe_lock);
 	vcpu->arch.vgic_cpu.vgic_v3.its_vpe.pending_last = true;
+	raw_spin_unlock(&vcpu->arch.vgic_cpu.vgic_v3.its_vpe.vpe_lock);
+
 	kvm_make_request(KVM_REQ_IRQ_PENDING, vcpu);
 	kvm_vcpu_kick(vcpu);
 
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index cd685f521c77..205f69592471 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -4054,16 +4054,24 @@ static void its_vpe_4_1_deschedule(struct its_vpe *vpe,
 	u64 val;
 
 	if (info->req_db) {
+		unsigned long flags;
+
 		/*
 		 * vPE is going to block: make the vPE non-resident with
 		 * PendingLast clear and DB set. The GIC guarantees that if
 		 * we read-back PendingLast clear, then a doorbell will be
 		 * delivered when an interrupt comes.
+		 *
+		 * Note the locking to deal with the concurrent update of
+		 * pending_last from the doorbell interrupt handler that can
+		 * run concurrently.
 		 */
+		raw_spin_lock_irqsave(&vpe->vpe_lock, flags);
 		val = its_clear_vpend_valid(vlpi_base,
 					    GICR_VPENDBASER_PendingLast,
 					    GICR_VPENDBASER_4_1_DB);
 		vpe->pending_last = !!(val & GICR_VPENDBASER_PendingLast);
+		raw_spin_unlock_irqrestore(&vpe->vpe_lock, flags);
 	} else {
 		/*
 		 * We're not blocking, so just make the vPE non-resident
-- 
2.27.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
