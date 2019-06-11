Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C297E3D347
	for <lists+kvmarm@lfdr.de>; Tue, 11 Jun 2019 19:03:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 692214A527;
	Tue, 11 Jun 2019 13:03:59 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FoI8SLxGKe7k; Tue, 11 Jun 2019 13:03:58 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D2B334A52A;
	Tue, 11 Jun 2019 13:03:57 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BD55F4A4F9
 for <kvmarm@lists.cs.columbia.edu>; Tue, 11 Jun 2019 13:03:56 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LPRXz3HKgrXT for <kvmarm@lists.cs.columbia.edu>;
 Tue, 11 Jun 2019 13:03:55 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BD3D94A50A
 for <kvmarm@lists.cs.columbia.edu>; Tue, 11 Jun 2019 13:03:54 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E275ED1;
 Tue, 11 Jun 2019 10:03:54 -0700 (PDT)
Received: from filthy-habits.cambridge.arm.com
 (filthy-habits.cambridge.arm.com [10.1.197.61])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F32953F73C;
 Tue, 11 Jun 2019 10:03:52 -0700 (PDT)
From: Marc Zyngier <marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: [PATCH v2 4/9] KVM: arm/arm64: vgic-its: Invalidate MSI-LPI
 translation cache on specific commands
Date: Tue, 11 Jun 2019 18:03:31 +0100
Message-Id: <20190611170336.121706-5-marc.zyngier@arm.com>
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

The LPI translation cache needs to be discarded when an ITS command
may affect the translation of an LPI (DISCARD and MAPD with V=0) or
the routing of an LPI to a redistributor with disabled LPIs (MOVI,
MOVALL).

We decide to perform a full invalidation of the cache, irrespective
of the LPI that is affected. Commands are supposed to be rare enough
that it doesn't matter.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/vgic/vgic-its.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index 9b6b66204b97..5254bb762e1b 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -733,6 +733,8 @@ static int vgic_its_cmd_handle_discard(struct kvm *kvm, struct vgic_its *its,
 		 * don't bother here since we clear the ITTE anyway and the
 		 * pending state is a property of the ITTE struct.
 		 */
+		vgic_its_invalidate_cache(kvm);
+
 		its_free_ite(kvm, ite);
 		return 0;
 	}
@@ -768,6 +770,8 @@ static int vgic_its_cmd_handle_movi(struct kvm *kvm, struct vgic_its *its,
 	ite->collection = collection;
 	vcpu = kvm_get_vcpu(kvm, collection->target_addr);
 
+	vgic_its_invalidate_cache(kvm);
+
 	return update_affinity(ite->irq, vcpu);
 }
 
@@ -996,6 +1000,8 @@ static void vgic_its_free_device(struct kvm *kvm, struct its_device *device)
 	list_for_each_entry_safe(ite, temp, &device->itt_head, ite_list)
 		its_free_ite(kvm, ite);
 
+	vgic_its_invalidate_cache(kvm);
+
 	list_del(&device->dev_list);
 	kfree(device);
 }
@@ -1249,6 +1255,8 @@ static int vgic_its_cmd_handle_movall(struct kvm *kvm, struct vgic_its *its,
 		vgic_put_irq(kvm, irq);
 	}
 
+	vgic_its_invalidate_cache(kvm);
+
 	kfree(intids);
 	return 0;
 }
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
