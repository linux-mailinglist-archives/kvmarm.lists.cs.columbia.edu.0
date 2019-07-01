Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E10B437A37
	for <lists+kvmarm@lfdr.de>; Thu,  6 Jun 2019 18:55:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 94FD94A4E9;
	Thu,  6 Jun 2019 12:55:18 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JeEYUEjoAC5x; Thu,  6 Jun 2019 12:55:16 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5C3154A502;
	Thu,  6 Jun 2019 12:55:16 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 364404A4F1
 for <kvmarm@lists.cs.columbia.edu>; Thu,  6 Jun 2019 12:55:15 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zvKzOZBwnjpw for <kvmarm@lists.cs.columbia.edu>;
 Thu,  6 Jun 2019 12:55:14 -0400 (EDT)
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E6A294A4EC
 for <kvmarm@lists.cs.columbia.edu>; Thu,  6 Jun 2019 12:55:13 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6ABCB15BF;
 Thu,  6 Jun 2019 09:55:13 -0700 (PDT)
Received: from filthy-habits.cambridge.arm.com
 (filthy-habits.cambridge.arm.com [10.1.197.61])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9DE243F690;
 Thu,  6 Jun 2019 09:55:11 -0700 (PDT)
From: Marc Zyngier <marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: [PATCH 4/8] KVM: arm/arm64: vgic-its: Add kvm parameter to
 vgic_its_free_collection
Date: Thu,  6 Jun 2019 17:54:51 +0100
Message-Id: <20190606165455.162478-5-marc.zyngier@arm.com>
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

As we are going to perform some VM-wide operations when freeing
a collection, add the kvm pointer to vgic_its_free_collection.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/vgic/vgic-its.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index bc370b6c5afa..f637edd77e1f 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -885,7 +885,8 @@ static int vgic_its_alloc_collection(struct vgic_its *its,
 	return 0;
 }
 
-static void vgic_its_free_collection(struct vgic_its *its, u32 coll_id)
+static void vgic_its_free_collection(struct kvm *kvm,
+				     struct vgic_its *its, u32 coll_id)
 {
 	struct its_collection *collection;
 	struct its_device *device;
@@ -974,7 +975,7 @@ static int vgic_its_cmd_handle_mapi(struct kvm *kvm, struct vgic_its *its,
 	ite = vgic_its_alloc_ite(device, collection, event_id);
 	if (IS_ERR(ite)) {
 		if (new_coll)
-			vgic_its_free_collection(its, coll_id);
+			vgic_its_free_collection(kvm, its, coll_id);
 		return PTR_ERR(ite);
 	}
 
@@ -984,7 +985,7 @@ static int vgic_its_cmd_handle_mapi(struct kvm *kvm, struct vgic_its *its,
 	irq = vgic_add_lpi(kvm, lpi_nr, vcpu);
 	if (IS_ERR(irq)) {
 		if (new_coll)
-			vgic_its_free_collection(its, coll_id);
+			vgic_its_free_collection(kvm, its, coll_id);
 		its_free_ite(kvm, ite);
 		return PTR_ERR(irq);
 	}
@@ -1025,7 +1026,7 @@ static void vgic_its_free_collection_list(struct kvm *kvm, struct vgic_its *its)
 	struct its_collection *cur, *temp;
 
 	list_for_each_entry_safe(cur, temp, &its->collection_list, coll_list)
-		vgic_its_free_collection(its, cur->collection_id);
+		vgic_its_free_collection(kvm, its, cur->collection_id);
 }
 
 /* Must be called with its_lock mutex held */
@@ -1110,7 +1111,7 @@ static int vgic_its_cmd_handle_mapc(struct kvm *kvm, struct vgic_its *its,
 		return E_ITS_MAPC_PROCNUM_OOR;
 
 	if (!valid) {
-		vgic_its_free_collection(its, coll_id);
+		vgic_its_free_collection(kvm, its, coll_id);
 	} else {
 		collection = find_collection(its, coll_id);
 
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
