Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4781737A3C
	for <lists+kvmarm@lfdr.de>; Thu,  6 Jun 2019 18:55:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EF3DE4A4EA;
	Thu,  6 Jun 2019 12:55:24 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OBv9vcza32L2; Thu,  6 Jun 2019 12:55:23 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CD5DC4A506;
	Thu,  6 Jun 2019 12:55:23 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3FAB34A4E1
 for <kvmarm@lists.cs.columbia.edu>; Thu,  6 Jun 2019 12:55:23 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hC5ucFlbEJ9y for <kvmarm@lists.cs.columbia.edu>;
 Thu,  6 Jun 2019 12:55:22 -0400 (EDT)
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EF5CA4A515
 for <kvmarm@lists.cs.columbia.edu>; Thu,  6 Jun 2019 12:55:21 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 988431713;
 Thu,  6 Jun 2019 09:55:21 -0700 (PDT)
Received: from filthy-habits.cambridge.arm.com
 (filthy-habits.cambridge.arm.com [10.1.197.61])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB8453F690;
 Thu,  6 Jun 2019 09:55:19 -0700 (PDT)
From: Marc Zyngier <marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: [PATCH 8/8] KVM: arm/arm64: vgic-irqfd: Implement
 kvm_arch_set_irq_inatomic
Date: Thu,  6 Jun 2019 17:54:55 +0100
Message-Id: <20190606165455.162478-9-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190606165455.162478-1-marc.zyngier@arm.com>
References: <20190606165455.162478-1-marc.zyngier@arm.com>
MIME-Version: 1.0
Cc: "Raslan, KarimAllah" <karahmed@amazon.de>
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

Now that we have a cache of MSI->LPI translations, it is pretty
easy to implement kvm_arch_set_irq_inatomic (this cache can be
parsed without sleeping).

Hopefully, this will improve some LPI-heavy workloads.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/vgic/vgic-irqfd.c | 36 ++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-irqfd.c b/virt/kvm/arm/vgic/vgic-irqfd.c
index 99e026d2dade..9f203ed8c8f3 100644
--- a/virt/kvm/arm/vgic/vgic-irqfd.c
+++ b/virt/kvm/arm/vgic/vgic-irqfd.c
@@ -77,6 +77,15 @@ int kvm_set_routing_entry(struct kvm *kvm,
 	return r;
 }
 
+static void kvm_populate_msi(struct kvm_kernel_irq_routing_entry *e,
+			     struct kvm_msi *msi)
+{
+	msi->address_lo = e->msi.address_lo;
+	msi->address_hi = e->msi.address_hi;
+	msi->data = e->msi.data;
+	msi->flags = e->msi.flags;
+	msi->devid = e->msi.devid;
+}
 /**
  * kvm_set_msi: inject the MSI corresponding to the
  * MSI routing entry
@@ -90,21 +99,36 @@ int kvm_set_msi(struct kvm_kernel_irq_routing_entry *e,
 {
 	struct kvm_msi msi;
 
-	msi.address_lo = e->msi.address_lo;
-	msi.address_hi = e->msi.address_hi;
-	msi.data = e->msi.data;
-	msi.flags = e->msi.flags;
-	msi.devid = e->msi.devid;
-
 	if (!vgic_has_its(kvm))
 		return -ENODEV;
 
 	if (!level)
 		return -1;
 
+	kvm_populate_msi(e, &msi);
 	return vgic_its_inject_msi(kvm, &msi);
 }
 
+/**
+ * kvm_arch_set_irq_inatomic: fast-path for irqfd injection
+ *
+ * Currently only direct MSI injecton is supported.
+ */
+int kvm_arch_set_irq_inatomic(struct kvm_kernel_irq_routing_entry *e,
+			      struct kvm *kvm, int irq_source_id, int level,
+			      bool line_status)
+{
+	if (e->type == KVM_IRQ_ROUTING_MSI && vgic_has_its(kvm) && level) {
+		struct kvm_msi msi;
+
+		kvm_populate_msi(e, &msi);
+		if (!vgic_its_inject_cached_translation(kvm, &msi))
+			return 0;
+	}
+
+	return -EWOULDBLOCK;
+}
+
 int kvm_vgic_setup_default_irq_routing(struct kvm *kvm)
 {
 	struct kvm_irq_routing_entry *entries;
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
