Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E3BB1141D12
	for <lists+kvmarm@lfdr.de>; Sun, 19 Jan 2020 10:07:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 64BC34AEB3;
	Sun, 19 Jan 2020 04:07:05 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LxFCiL4niYLY; Sun, 19 Jan 2020 04:07:05 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 41D734AEA0;
	Sun, 19 Jan 2020 04:07:04 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DC19C4AE95
 for <kvmarm@lists.cs.columbia.edu>; Sun, 19 Jan 2020 04:07:02 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cHBkSnvKlU4u for <kvmarm@lists.cs.columbia.edu>;
 Sun, 19 Jan 2020 04:07:00 -0500 (EST)
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 941DB4A536
 for <kvmarm@lists.cs.columbia.edu>; Sun, 19 Jan 2020 04:07:00 -0500 (EST)
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 0ECFB4E55211167F5BDE;
 Sun, 19 Jan 2020 17:06:55 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.173.222.27) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Sun, 19 Jan 2020 17:06:45 +0800
From: Zenghui Yu <yuzenghui@huawei.com>
To: <maz@kernel.org>
Subject: [PATCH] KVM: arm/arm64: vgic: Drop the kvm_vgic_register_mmio_region()
Date: Sun, 19 Jan 2020 17:06:04 +0800
Message-ID: <20200119090604.398-1-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
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

kvm_vgic_register_mmio_region() was introduced in commit 4493b1c4866a
("KVM: arm/arm64: vgic-new: Add MMIO handling framework") but never
used, and even never implemented. Remove it to avoid confusing readers.

Reported-by: Haibin Wang <wanghaibin.wang@huawei.com>
Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 virt/kvm/arm/vgic/vgic-mmio.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-mmio.h b/virt/kvm/arm/vgic/vgic-mmio.h
index 836f418f1ee8..5af2aefad435 100644
--- a/virt/kvm/arm/vgic/vgic-mmio.h
+++ b/virt/kvm/arm/vgic/vgic-mmio.h
@@ -98,11 +98,6 @@ extern struct kvm_io_device_ops kvm_io_gic_ops;
 		.uaccess_write = uwr,					\
 	}
 
-int kvm_vgic_register_mmio_region(struct kvm *kvm, struct kvm_vcpu *vcpu,
-				  struct vgic_register_region *reg_desc,
-				  struct vgic_io_device *region,
-				  int nr_irqs, bool offset_private);
-
 unsigned long vgic_data_mmio_bus_to_host(const void *val, unsigned int len);
 
 void vgic_data_host_to_mmio_bus(void *buf, unsigned int len,
-- 
2.19.1


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
