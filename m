Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D40C73D34C
	for <lists+kvmarm@lfdr.de>; Tue, 11 Jun 2019 19:04:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 820D94A545;
	Tue, 11 Jun 2019 13:04:06 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2MK24HiF96qX; Tue, 11 Jun 2019 13:04:05 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 55C2B4A53E;
	Tue, 11 Jun 2019 13:04:05 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 881184A507
 for <kvmarm@lists.cs.columbia.edu>; Tue, 11 Jun 2019 13:04:04 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0GDSxeXwz1uG for <kvmarm@lists.cs.columbia.edu>;
 Tue, 11 Jun 2019 13:04:03 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 14C7E4A505
 for <kvmarm@lists.cs.columbia.edu>; Tue, 11 Jun 2019 13:04:03 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C54CC11B3;
 Tue, 11 Jun 2019 10:04:02 -0700 (PDT)
Received: from filthy-habits.cambridge.arm.com
 (filthy-habits.cambridge.arm.com [10.1.197.61])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 56A513F73C;
 Tue, 11 Jun 2019 10:04:01 -0700 (PDT)
From: Marc Zyngier <marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: [PATCH v2 9/9] KVM: arm/arm64: vgic-irqfd: Implement
 kvm_arch_set_irq_inatomic
Date: Tue, 11 Jun 2019 18:03:36 +0100
Message-Id: <20190611170336.121706-10-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611170336.121706-1-marc.zyngier@arm.com>
References: <20190611170336.121706-1-marc.zyngier@arm.com>
MIME-Version: 1.0
Cc: "Raslan, KarimAllah" <karahmed@amazon.de>, "Saidi,
 Ali" <alisaidi@amazon.com>
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
