Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA8115DA91
	for <lists+kvmarm@lfdr.de>; Fri, 14 Feb 2020 16:21:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E27BF4AEA0;
	Fri, 14 Feb 2020 10:21:10 -0500 (EST)
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
	with ESMTP id tad9LqBnb2KW; Fri, 14 Feb 2020 10:21:10 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D065A4AEAB;
	Fri, 14 Feb 2020 10:21:09 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 198774AE9E
 for <kvmarm@lists.cs.columbia.edu>; Fri, 14 Feb 2020 10:21:08 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yre4pttwXmKE for <kvmarm@lists.cs.columbia.edu>;
 Fri, 14 Feb 2020 10:21:07 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 04B444AEA0
 for <kvmarm@lists.cs.columbia.edu>; Fri, 14 Feb 2020 10:21:07 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2B7522465D;
 Fri, 14 Feb 2020 15:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581693666;
 bh=C26s2HRE+wPz1uugU5+btkXiJRVLhTEvqGNwYSzqZE8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VDN01hxRKiUm11geARc6hVKNzTiMZ+UWfmV4hI21kVM+UZPfTNpMRRkajaeagMdLj
 LGKBV9jZ3Mll55RLXrhdlZBtEGVIVyx4EmeVvv+3qcba1Kz0sr8S7Xrartj6bsoXy7
 F6ZCCAug3uy4ZzP+uc6yenbV7zG2FdLtRj4UXuG4=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1j2cPo-0057sw-AH; Fri, 14 Feb 2020 14:58:00 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 17/20] KVM: arm64: GICv4.1: Plumb SGI implementation
 selection in the distributor
Date: Fri, 14 Feb 2020 14:57:33 +0000
Message-Id: <20200214145736.18550-18-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214145736.18550-1-maz@kernel.org>
References: <20200214145736.18550-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com, jason@lakedaemon.net,
 rrichter@marvell.com, tglx@linutronix.de, yuzenghui@huawei.com,
 eric.auger@redhat.com, james.morse@arm.com, julien.thierry.kdev@gmail.com,
 suzuki.poulose@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Jason Cooper <jason@lakedaemon.net>, Robert Richter <rrichter@marvell.com>,
 Thomas Gleixner <tglx@linutronix.de>
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

The GICv4.1 architecture gives the hypervisor the option to let
the guest choose whether it wants the good old SGIs with an
active state, or the new, HW-based ones that do not have one.

For this, plumb the configuration of SGIs into the GICv3 MMIO
handling, present the GICD_TYPER2.nASSGIcap to the guest,
and handle the GICD_CTLR.nASSGIreq setting.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 virt/kvm/arm/vgic/vgic-mmio-v3.c | 48 ++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-mmio-v3.c b/virt/kvm/arm/vgic/vgic-mmio-v3.c
index de89da76a379..442f3b8c2559 100644
--- a/virt/kvm/arm/vgic/vgic-mmio-v3.c
+++ b/virt/kvm/arm/vgic/vgic-mmio-v3.c
@@ -3,6 +3,7 @@
  * VGICv3 MMIO handling functions
  */
 
+#include <linux/bitfield.h>
 #include <linux/irqchip/arm-gic-v3.h>
 #include <linux/kvm.h>
 #include <linux/kvm_host.h>
@@ -70,6 +71,8 @@ static unsigned long vgic_mmio_read_v3_misc(struct kvm_vcpu *vcpu,
 		if (vgic->enabled)
 			value |= GICD_CTLR_ENABLE_SS_G1;
 		value |= GICD_CTLR_ARE_NS | GICD_CTLR_DS;
+		if (kvm_vgic_global_state.has_gicv4_1 && vgic->nassgireq)
+			value |= GICD_CTLR_nASSGIreq;
 		break;
 	case GICD_TYPER:
 		value = vgic->nr_spis + VGIC_NR_PRIVATE_IRQS;
@@ -81,6 +84,10 @@ static unsigned long vgic_mmio_read_v3_misc(struct kvm_vcpu *vcpu,
 			value |= (INTERRUPT_ID_BITS_SPIS - 1) << 19;
 		}
 		break;
+	case GICD_TYPER2:
+		if (kvm_vgic_global_state.has_gicv4_1)
+			value = GICD_TYPER2_nASSGIcap;
+		break;
 	case GICD_IIDR:
 		value = (PRODUCT_ID_KVM << GICD_IIDR_PRODUCT_ID_SHIFT) |
 			(vgic->implementation_rev << GICD_IIDR_REVISION_SHIFT) |
@@ -98,17 +105,43 @@ static void vgic_mmio_write_v3_misc(struct kvm_vcpu *vcpu,
 				    unsigned long val)
 {
 	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
-	bool was_enabled = dist->enabled;
 
 	switch (addr & 0x0c) {
-	case GICD_CTLR:
+	case GICD_CTLR: {
+		bool was_enabled, is_hwsgi;
+
+		mutex_lock(&vcpu->kvm->lock);
+
+		was_enabled = dist->enabled;
+		is_hwsgi = dist->nassgireq;
+
 		dist->enabled = val & GICD_CTLR_ENABLE_SS_G1;
 
+		/* Not a GICv4.1? No HW SGIs */
+		if (!kvm_vgic_global_state.has_gicv4_1)
+			val &= ~GICD_CTLR_nASSGIreq;
+
+		/* Dist stays enabled? nASSGIreq is RO */
+		if (was_enabled && dist->enabled) {
+			val &= ~GICD_CTLR_nASSGIreq;
+			val |= FIELD_PREP(GICD_CTLR_nASSGIreq, is_hwsgi);
+		}
+
+		/* Switching HW SGIs? */
+		dist->nassgireq = val & GICD_CTLR_nASSGIreq;
+		if (is_hwsgi != dist->nassgireq)
+			vgic_v4_configure_vsgis(vcpu->kvm);
+
 		if (!was_enabled && dist->enabled)
 			vgic_kick_vcpus(vcpu->kvm);
+
+		mutex_unlock(&vcpu->kvm->lock);
 		break;
+	}
 	case GICD_TYPER:
+	case GICD_TYPER2:
 	case GICD_IIDR:
+		/* This is at best for documentation purposes... */
 		return;
 	}
 }
@@ -117,10 +150,21 @@ static int vgic_mmio_uaccess_write_v3_misc(struct kvm_vcpu *vcpu,
 					   gpa_t addr, unsigned int len,
 					   unsigned long val)
 {
+	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
+
 	switch (addr & 0x0c) {
 	case GICD_IIDR:
 		if (val != vgic_mmio_read_v3_misc(vcpu, addr, len))
 			return -EINVAL;
+		return 0;
+	case GICD_CTLR:
+		/* Not a GICv4.1? No HW SGIs */
+		if (!kvm_vgic_global_state.has_gicv4_1)
+			val &= ~GICD_CTLR_nASSGIreq;
+
+		dist->enabled = val & GICD_CTLR_ENABLE_SS_G1;
+		dist->nassgireq = val & GICD_CTLR_nASSGIreq;
+		return 0;
 	}
 
 	vgic_mmio_write_v3_misc(vcpu, addr, len, val);
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
