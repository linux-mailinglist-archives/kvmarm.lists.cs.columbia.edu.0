Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC2B104171
	for <lists+kvmarm@lfdr.de>; Wed, 20 Nov 2019 17:52:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4E6B14AEFF;
	Wed, 20 Nov 2019 11:52:03 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pIQzaqm+4gcW; Wed, 20 Nov 2019 11:52:03 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 10FDD4AEED;
	Wed, 20 Nov 2019 11:52:02 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7C5594AEBF
 for <kvmarm@lists.cs.columbia.edu>; Wed, 20 Nov 2019 11:52:00 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O7ula964WpaB for <kvmarm@lists.cs.columbia.edu>;
 Wed, 20 Nov 2019 11:51:59 -0500 (EST)
Received: from inca-roads.misterjones.org (inca-roads.misterjones.org
 [213.251.177.50])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 4A3994AC87
 for <kvmarm@lists.cs.columbia.edu>; Wed, 20 Nov 2019 11:51:59 -0500 (EST)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by cheepnis.misterjones.org with esmtpsa
 (TLSv1.2:DHE-RSA-AES128-GCM-SHA256:128) (Exim 4.80)
 (envelope-from <maz@kernel.org>)
 id 1iXT4R-0007RI-KA; Wed, 20 Nov 2019 17:43:11 +0100
From: Marc Zyngier <maz@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 21/22] KVM: vgic-v4: Track the number of VLPIs per vcpu
Date: Wed, 20 Nov 2019 16:42:35 +0000
Message-Id: <20191120164236.29359-22-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191120164236.29359-1-maz@kernel.org>
References: <20191120164236.29359-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: pbonzini@redhat.com, rkrcmar@redhat.com, graf@amazon.com,
 drjones@redhat.com, borntraeger@de.ibm.com, christoffer.dall@arm.com,
 eric.auger@redhat.com, xypron.glpk@gmx.de, julien.grall@arm.com,
 mark.rutland@arm.com, bigeasy@linutronix.de, steven.price@arm.com,
 tglx@linutronix.de, will@kernel.org, yuzenghui@huawei.com, james.morse@arm.com,
 julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
 linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Steven Price <steven.price@arm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Julien Grall <julien.grall@arm.com>, linux-arm-kernel@lists.infradead.org,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
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

In order to find out whether a vcpu is likely to be the target of
VLPIs (and to further optimize the way we deal with those), let's
track the number of VLPIs a vcpu can receive.

This gets implemented with an atomic variable that gets incremented
or decremented on map, unmap and move of a VLPI.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Reviewed-by: Christoffer Dall <christoffer.dall@arm.com>
Link: https://lore.kernel.org/r/20191107160412.30301-2-maz@kernel.org
---
 include/linux/irqchip/arm-gic-v4.h | 2 ++
 virt/kvm/arm/vgic/vgic-init.c      | 1 +
 virt/kvm/arm/vgic/vgic-its.c       | 3 +++
 virt/kvm/arm/vgic/vgic-v4.c        | 2 ++
 4 files changed, 8 insertions(+)

diff --git a/include/linux/irqchip/arm-gic-v4.h b/include/linux/irqchip/arm-gic-v4.h
index ab1396afe08a..5dbcfc65f21e 100644
--- a/include/linux/irqchip/arm-gic-v4.h
+++ b/include/linux/irqchip/arm-gic-v4.h
@@ -32,6 +32,8 @@ struct its_vm {
 struct its_vpe {
 	struct page 		*vpt_page;
 	struct its_vm		*its_vm;
+	/* per-vPE VLPI tracking */
+	atomic_t		vlpi_count;
 	/* Doorbell interrupt */
 	int			irq;
 	irq_hw_number_t		vpe_db_lpi;
diff --git a/virt/kvm/arm/vgic/vgic-init.c b/virt/kvm/arm/vgic/vgic-init.c
index 6f50c429196d..b3c5de48064c 100644
--- a/virt/kvm/arm/vgic/vgic-init.c
+++ b/virt/kvm/arm/vgic/vgic-init.c
@@ -203,6 +203,7 @@ int kvm_vgic_vcpu_init(struct kvm_vcpu *vcpu)
 
 	INIT_LIST_HEAD(&vgic_cpu->ap_list_head);
 	raw_spin_lock_init(&vgic_cpu->ap_list_lock);
+	atomic_set(&vgic_cpu->vgic_v3.its_vpe.vlpi_count, 0);
 
 	/*
 	 * Enable and configure all SGIs to be edge-triggered and
diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index 2be6b66b3856..98c7360d9fb7 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -360,7 +360,10 @@ static int update_affinity(struct vgic_irq *irq, struct kvm_vcpu *vcpu)
 		if (ret)
 			return ret;
 
+		if (map.vpe)
+			atomic_dec(&map.vpe->vlpi_count);
 		map.vpe = &vcpu->arch.vgic_cpu.vgic_v3.its_vpe;
+		atomic_inc(&map.vpe->vlpi_count);
 
 		ret = its_map_vlpi(irq->host_irq, &map);
 	}
diff --git a/virt/kvm/arm/vgic/vgic-v4.c b/virt/kvm/arm/vgic/vgic-v4.c
index 0965fb0c427a..46f875589c47 100644
--- a/virt/kvm/arm/vgic/vgic-v4.c
+++ b/virt/kvm/arm/vgic/vgic-v4.c
@@ -309,6 +309,7 @@ int kvm_vgic_v4_set_forwarding(struct kvm *kvm, int virq,
 
 	irq->hw		= true;
 	irq->host_irq	= virq;
+	atomic_inc(&map.vpe->vlpi_count);
 
 out:
 	mutex_unlock(&its->its_lock);
@@ -342,6 +343,7 @@ int kvm_vgic_v4_unset_forwarding(struct kvm *kvm, int virq,
 
 	WARN_ON(!(irq->hw && irq->host_irq == virq));
 	if (irq->hw) {
+		atomic_dec(&irq->target_vcpu->arch.vgic_cpu.vgic_v3.its_vpe.vlpi_count);
 		irq->hw = false;
 		ret = its_unmap_vlpi(virq);
 	}
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
