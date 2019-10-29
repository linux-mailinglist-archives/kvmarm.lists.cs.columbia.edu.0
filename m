Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 381D1E81FA
	for <lists+kvmarm@lfdr.de>; Tue, 29 Oct 2019 08:20:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D48564A95E;
	Tue, 29 Oct 2019 03:20:35 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XlABoh3WLxYb; Tue, 29 Oct 2019 03:20:35 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C0E404A49C;
	Tue, 29 Oct 2019 03:20:34 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 27ED14A534
 for <kvmarm@lists.cs.columbia.edu>; Tue, 29 Oct 2019 03:20:32 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yhMrCwpGak4Y for <kvmarm@lists.cs.columbia.edu>;
 Tue, 29 Oct 2019 03:20:31 -0400 (EDT)
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id C83D34A49C
 for <kvmarm@lists.cs.columbia.edu>; Tue, 29 Oct 2019 03:20:30 -0400 (EDT)
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 453D89AEB92ADC6E058B;
 Tue, 29 Oct 2019 15:20:27 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.173.222.27) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Tue, 29 Oct 2019 15:20:17 +0800
From: Zenghui Yu <yuzenghui@huawei.com>
To: <maz@kernel.org>, <eric.auger@redhat.com>, <james.morse@arm.com>,
 <julien.thierry.kdev@gmail.com>, <suzuki.poulose@arm.com>
Subject: [PATCH 3/3] KVM: arm/arm64: vgic: Don't rely on the wrong pending
 table
Date: Tue, 29 Oct 2019 15:19:19 +0800
Message-ID: <20191029071919.177-4-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
In-Reply-To: <20191029071919.177-1-yuzenghui@huawei.com>
References: <20191029071919.177-1-yuzenghui@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Cc: kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
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

It's possible that two LPIs locate in the same "byte_offset" but target
two different vcpus, where their pending status are indicated by two
different pending tables.  In such a scenario, using last_byte_offset
optimization will lead KVM relying on the wrong pending table entry.
Let us use last_ptr instead, which can be treated as a byte index into
a pending table and also, can be vcpu specific.

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---

If this patch has done the right thing, we can even add the:

Fixes: 280771252c1b ("KVM: arm64: vgic-v3: KVM_DEV_ARM_VGIC_SAVE_PENDING_TABLES")

But to be honest, I'm not clear about what has this patch actually fixed.
Pending tables should contain all zeros before we flush vgic_irq's pending
status into guest's RAM (thinking that guest should never write anything
into it). So the pending table entry we've read from the guest memory
seems always be zero. And we will always do the right thing even if we
rely on the wrong pending table entry.

I think I must have some misunderstanding here... Please fix me.

 virt/kvm/arm/vgic/vgic-v3.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-v3.c b/virt/kvm/arm/vgic/vgic-v3.c
index 5ef93e5041e1..7cd2e2f81513 100644
--- a/virt/kvm/arm/vgic/vgic-v3.c
+++ b/virt/kvm/arm/vgic/vgic-v3.c
@@ -363,8 +363,8 @@ int vgic_v3_lpi_sync_pending_status(struct kvm *kvm, struct vgic_irq *irq)
 int vgic_v3_save_pending_tables(struct kvm *kvm)
 {
 	struct vgic_dist *dist = &kvm->arch.vgic;
-	int last_byte_offset = -1;
 	struct vgic_irq *irq;
+	gpa_t last_ptr = -1;
 	int ret;
 	u8 val;
 
@@ -384,11 +384,11 @@ int vgic_v3_save_pending_tables(struct kvm *kvm)
 		bit_nr = irq->intid % BITS_PER_BYTE;
 		ptr = pendbase + byte_offset;
 
-		if (byte_offset != last_byte_offset) {
+		if (ptr != last_ptr) {
 			ret = kvm_read_guest_lock(kvm, ptr, &val, 1);
 			if (ret)
 				return ret;
-			last_byte_offset = byte_offset;
+			last_ptr = ptr;
 		}
 
 		stored = val & (1U << bit_nr);
-- 
2.19.1


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
