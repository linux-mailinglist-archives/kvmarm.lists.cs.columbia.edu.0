Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 854EA198A68
	for <lists+kvmarm@lfdr.de>; Tue, 31 Mar 2020 05:14:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E6D594B182;
	Mon, 30 Mar 2020 23:14:08 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YGrh8-p4nQQR; Mon, 30 Mar 2020 23:14:08 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C88794B180;
	Mon, 30 Mar 2020 23:14:07 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 81E1D4B172
 for <kvmarm@lists.cs.columbia.edu>; Mon, 30 Mar 2020 23:13:10 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 44DxDWbavzNw for <kvmarm@lists.cs.columbia.edu>;
 Mon, 30 Mar 2020 23:13:07 -0400 (EDT)
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 400114B14F
 for <kvmarm@lists.cs.columbia.edu>; Mon, 30 Mar 2020 23:13:06 -0400 (EDT)
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id D69B58F96A35E84F5A46;
 Tue, 31 Mar 2020 11:12:59 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.173.222.27) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Tue, 31 Mar 2020 11:12:52 +0800
From: Zenghui Yu <yuzenghui@huawei.com>
To: <kvmarm@lists.cs.columbia.edu>
Subject: [PATCH] KVM: arm64: vgic-v3: Clear pending bit in guest memory after
 synchronization
Date: Tue, 31 Mar 2020 11:12:45 +0800
Message-ID: <20200331031245.1562-1-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Cc: maz@kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, andre.przywara@arm.com
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

When LPI support is enabled at redistributor level, VGIC will potentially
load the correspond LPI penging table and sync it into the pending_latch.
To avoid keeping the 'consumed' pending bits lying around in guest memory
(though they're not used), let's clear them after synchronization.

The similar work had been done in vgic_v3_lpi_sync_pending_status().

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 virt/kvm/arm/vgic/vgic-its.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index d53d34a33e35..905760bfa404 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -435,6 +435,7 @@ static int its_sync_lpi_pending_table(struct kvm_vcpu *vcpu)
 
 	for (i = 0; i < nr_irqs; i++) {
 		int byte_offset, bit_nr;
+		bool status;
 
 		byte_offset = intids[i] / BITS_PER_BYTE;
 		bit_nr = intids[i] % BITS_PER_BYTE;
@@ -447,22 +448,32 @@ static int its_sync_lpi_pending_table(struct kvm_vcpu *vcpu)
 			ret = kvm_read_guest_lock(vcpu->kvm,
 						  pendbase + byte_offset,
 						  &pendmask, 1);
-			if (ret) {
-				kfree(intids);
-				return ret;
-			}
+			if (ret)
+				goto out;
 			last_byte_offset = byte_offset;
 		}
 
+		status = pendmask & (1 << bit_nr);
+
 		irq = vgic_get_irq(vcpu->kvm, NULL, intids[i]);
 		raw_spin_lock_irqsave(&irq->irq_lock, flags);
-		irq->pending_latch = pendmask & (1U << bit_nr);
+		irq->pending_latch = status;
 		vgic_queue_irq_unlock(vcpu->kvm, irq, flags);
 		vgic_put_irq(vcpu->kvm, irq);
+
+		if (status) {
+			/* clear consumed data */
+			pendmask &= ~(1 << bit_nr);
+			ret = kvm_write_guest_lock(vcpu->kvm,
+						   pendbase + byte_offset,
+						   &pendmask, 1);
+			if (ret)
+				goto out;
+		}
 	}
 
+out:
 	kfree(intids);
-
 	return ret;
 }
 
-- 
2.19.1


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
