Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C91492B1D68
	for <lists+kvmarm@lfdr.de>; Fri, 13 Nov 2020 15:28:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5A40D4BD66;
	Fri, 13 Nov 2020 09:28:35 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Huw5eeWkraPX; Fri, 13 Nov 2020 09:28:34 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AD0B64BD82;
	Fri, 13 Nov 2020 09:28:33 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 982374BC42
 for <kvmarm@lists.cs.columbia.edu>; Fri, 13 Nov 2020 09:28:31 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F-mSFYqYGT2X for <kvmarm@lists.cs.columbia.edu>;
 Fri, 13 Nov 2020 09:28:28 -0500 (EST)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 7B7B74BBB5
 for <kvmarm@lists.cs.columbia.edu>; Fri, 13 Nov 2020 09:28:28 -0500 (EST)
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CXgmp1RSpzkhGF;
 Fri, 13 Nov 2020 22:28:10 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.174.185.179) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Fri, 13 Nov 2020 22:28:14 +0800
From: Zenghui Yu <yuzenghui@huawei.com>
To: <kvmarm@lists.cs.columbia.edu>, <maz@kernel.org>
Subject: [PATCH 1/2] KVM: arm64: vgic: Forbid invalid userspace Redistributor
 accesses
Date: Fri, 13 Nov 2020 22:28:00 +0800
Message-ID: <20201113142801.1659-2-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
In-Reply-To: <20201113142801.1659-1-yuzenghui@huawei.com>
References: <20201113142801.1659-1-yuzenghui@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.185.179]
X-CFilter-Loop: Reflected
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

It's expected that users will access registers in the redistributor *if*
the RD has been initialized properly. Unfortunately userspace can be bogus
enough to access registers before setting the RD base address, and KVM
implicitly allows it (we handle the access anyway, regardless of whether
the base address is set).

Bad thing happens when we're handling the user read of GICR_TYPER. We end
up with an oops when deferencing the unset rdreg...

	gpa_t last_rdist_typer = rdreg->base + GICR_TYPER +
			(rdreg->free_index - 1) * KVM_VGIC_V3_REDIST_SIZE;

Fix this issue by informing userspace what had gone wrong (-ENXIO).

Reported-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 arch/arm64/kvm/vgic/vgic-mmio-v3.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
index 52d6f24f65dc..30e370585a27 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
@@ -1040,11 +1040,15 @@ int vgic_v3_dist_uaccess(struct kvm_vcpu *vcpu, bool is_write,
 int vgic_v3_redist_uaccess(struct kvm_vcpu *vcpu, bool is_write,
 			   int offset, u32 *val)
 {
+	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
 	struct vgic_io_device rd_dev = {
 		.regions = vgic_v3_rd_registers,
 		.nr_regions = ARRAY_SIZE(vgic_v3_rd_registers),
 	};
 
+	if (IS_VGIC_ADDR_UNDEF(vgic_cpu->rd_iodev.base_addr))
+		return -ENXIO;
+
 	return vgic_uaccess(vcpu, &rd_dev, is_write, offset, val);
 }
 
-- 
2.19.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
