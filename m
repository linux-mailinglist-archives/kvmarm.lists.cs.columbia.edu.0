Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 361AF199648
	for <lists+kvmarm@lfdr.de>; Tue, 31 Mar 2020 14:21:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 97FF44B087;
	Tue, 31 Mar 2020 08:21:08 -0400 (EDT)
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
	with ESMTP id WsKZ53oUXMUL; Tue, 31 Mar 2020 08:21:08 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4ABAE4B082;
	Tue, 31 Mar 2020 08:21:07 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BC1734A4C0
 for <kvmarm@lists.cs.columbia.edu>; Tue, 31 Mar 2020 08:21:06 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 36ituUHl4B6e for <kvmarm@lists.cs.columbia.edu>;
 Tue, 31 Mar 2020 08:21:04 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id DCF054A3B4
 for <kvmarm@lists.cs.columbia.edu>; Tue, 31 Mar 2020 08:21:03 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B1D76207FF;
 Tue, 31 Mar 2020 12:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1585657262;
 bh=9zxIPCaaItfToYBAt/BDtupFb/YWr9EAeF+COnu9wKc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=edw45DgbIaoLDogbATwIl8Nvnag736qsGuFJgmtb1t4xT/5VqhI6r9pXFD4TXp1Lj
 ii1+vMdQ8Bi0erMaZKglyiRYfH6iS5s4gD8wdq/1AT7sP/9+ReKjUIBNVelAr7YqVN
 Mrs4ezdm1bcMkN+5qmNg5nNU1eRFrJAmn3j4ufdo=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jJFpX-00HBlI-Jb; Tue, 31 Mar 2020 13:17:19 +0100
From: Marc Zyngier <maz@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 11/15] KVM: arm64: GICv4.1: Allow SGIs to switch between HW
 and SW interrupts
Date: Tue, 31 Mar 2020 13:16:41 +0100
Message-Id: <20200331121645.388250-12-maz@kernel.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200331121645.388250-1-maz@kernel.org>
References: <20200331121645.388250-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: pbonzini@redhat.com, arnd@arndb.de, catalin.marinas@arm.com,
 christoffer.dall@arm.com, eric.auger@redhat.com, karahmed@amazon.de,
 linus.walleij@linaro.org, olof@lixom.net, vladimir.murzin@arm.com,
 will@kernel.org, yuzenghui@huawei.com, james.morse@arm.com,
 julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
 linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 KarimAllah Ahmed <karahmed@amazon.de>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org,
 Olof Johansson <olof@lixom.net>, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu
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

In order to let a guest buy in the new, active-less SGIs, we
need to be able to switch between the two modes.

Handle this by stopping all guest activity, transfer the state
from one mode to the other, and resume the guest. Nothing calls
this code so far, but a later patch will plug it into the MMIO
emulation.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Link: https://lore.kernel.org/r/20200304203330.4967-20-maz@kernel.org
---
 include/kvm/arm_vgic.h      |  3 ++
 virt/kvm/arm/vgic/vgic-v4.c | 98 +++++++++++++++++++++++++++++++++++++
 virt/kvm/arm/vgic/vgic.h    |  1 +
 3 files changed, 102 insertions(+)

diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index 63457908c9c4..69f4164d6477 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -231,6 +231,9 @@ struct vgic_dist {
 	/* distributor enabled */
 	bool			enabled;
 
+	/* Wants SGIs without active state */
+	bool			nassgireq;
+
 	struct vgic_irq		*spis;
 
 	struct vgic_io_device	dist_iodev;
diff --git a/virt/kvm/arm/vgic/vgic-v4.c b/virt/kvm/arm/vgic/vgic-v4.c
index c2fcde104ea2..27ac833e5ec7 100644
--- a/virt/kvm/arm/vgic/vgic-v4.c
+++ b/virt/kvm/arm/vgic/vgic-v4.c
@@ -97,6 +97,104 @@ static irqreturn_t vgic_v4_doorbell_handler(int irq, void *info)
 	return IRQ_HANDLED;
 }
 
+static void vgic_v4_sync_sgi_config(struct its_vpe *vpe, struct vgic_irq *irq)
+{
+	vpe->sgi_config[irq->intid].enabled	= irq->enabled;
+	vpe->sgi_config[irq->intid].group 	= irq->group;
+	vpe->sgi_config[irq->intid].priority	= irq->priority;
+}
+
+static void vgic_v4_enable_vsgis(struct kvm_vcpu *vcpu)
+{
+	struct its_vpe *vpe = &vcpu->arch.vgic_cpu.vgic_v3.its_vpe;
+	int i;
+
+	/*
+	 * With GICv4.1, every virtual SGI can be directly injected. So
+	 * let's pretend that they are HW interrupts, tied to a host
+	 * IRQ. The SGI code will do its magic.
+	 */
+	for (i = 0; i < VGIC_NR_SGIS; i++) {
+		struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, vcpu, i);
+		struct irq_desc *desc;
+		unsigned long flags;
+		int ret;
+
+		raw_spin_lock_irqsave(&irq->irq_lock, flags);
+
+		if (irq->hw)
+			goto unlock;
+
+		irq->hw = true;
+		irq->host_irq = irq_find_mapping(vpe->sgi_domain, i);
+
+		/* Transfer the full irq state to the vPE */
+		vgic_v4_sync_sgi_config(vpe, irq);
+		desc = irq_to_desc(irq->host_irq);
+		ret = irq_domain_activate_irq(irq_desc_get_irq_data(desc),
+					      false);
+		if (!WARN_ON(ret)) {
+			/* Transfer pending state */
+			ret = irq_set_irqchip_state(irq->host_irq,
+						    IRQCHIP_STATE_PENDING,
+						    irq->pending_latch);
+			WARN_ON(ret);
+			irq->pending_latch = false;
+		}
+	unlock:
+		raw_spin_unlock_irqrestore(&irq->irq_lock, flags);
+		vgic_put_irq(vcpu->kvm, irq);
+	}
+}
+
+static void vgic_v4_disable_vsgis(struct kvm_vcpu *vcpu)
+{
+	int i;
+
+	for (i = 0; i < VGIC_NR_SGIS; i++) {
+		struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, vcpu, i);
+		struct irq_desc *desc;
+		unsigned long flags;
+		int ret;
+
+		raw_spin_lock_irqsave(&irq->irq_lock, flags);
+
+		if (!irq->hw)
+			goto unlock;
+
+		irq->hw = false;
+		ret = irq_get_irqchip_state(irq->host_irq,
+					    IRQCHIP_STATE_PENDING,
+					    &irq->pending_latch);
+		WARN_ON(ret);
+
+		desc = irq_to_desc(irq->host_irq);
+		irq_domain_deactivate_irq(irq_desc_get_irq_data(desc));
+	unlock:
+		raw_spin_unlock_irqrestore(&irq->irq_lock, flags);
+		vgic_put_irq(vcpu->kvm, irq);
+	}
+}
+
+/* Must be called with the kvm lock held */
+void vgic_v4_configure_vsgis(struct kvm *kvm)
+{
+	struct vgic_dist *dist = &kvm->arch.vgic;
+	struct kvm_vcpu *vcpu;
+	int i;
+
+	kvm_arm_halt_guest(kvm);
+
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		if (dist->nassgireq)
+			vgic_v4_enable_vsgis(vcpu);
+		else
+			vgic_v4_disable_vsgis(vcpu);
+	}
+
+	kvm_arm_resume_guest(kvm);
+}
+
 /**
  * vgic_v4_init - Initialize the GICv4 data structures
  * @kvm:	Pointer to the VM being initialized
diff --git a/virt/kvm/arm/vgic/vgic.h b/virt/kvm/arm/vgic/vgic.h
index c7fefd6b1c80..769e4802645e 100644
--- a/virt/kvm/arm/vgic/vgic.h
+++ b/virt/kvm/arm/vgic/vgic.h
@@ -316,5 +316,6 @@ void vgic_its_invalidate_cache(struct kvm *kvm);
 bool vgic_supports_direct_msis(struct kvm *kvm);
 int vgic_v4_init(struct kvm *kvm);
 void vgic_v4_teardown(struct kvm *kvm);
+void vgic_v4_configure_vsgis(struct kvm *kvm);
 
 #endif
-- 
2.25.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
