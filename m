Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D4298E81F8
	for <lists+kvmarm@lfdr.de>; Tue, 29 Oct 2019 08:20:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7FBDD4A94D;
	Tue, 29 Oct 2019 03:20:32 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7KwXV5TneZbY; Tue, 29 Oct 2019 03:20:31 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8412A4A982;
	Tue, 29 Oct 2019 03:20:31 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C7A304A49C
 for <kvmarm@lists.cs.columbia.edu>; Tue, 29 Oct 2019 03:20:29 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hpErgCx+HPdM for <kvmarm@lists.cs.columbia.edu>;
 Tue, 29 Oct 2019 03:20:28 -0400 (EDT)
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 43FE84A52E
 for <kvmarm@lists.cs.columbia.edu>; Tue, 29 Oct 2019 03:20:27 -0400 (EDT)
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 30CC6DC6489742B8CF4A;
 Tue, 29 Oct 2019 15:20:22 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.173.222.27) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Tue, 29 Oct 2019 15:20:16 +0800
From: Zenghui Yu <yuzenghui@huawei.com>
To: <maz@kernel.org>, <eric.auger@redhat.com>, <james.morse@arm.com>,
 <julien.thierry.kdev@gmail.com>, <suzuki.poulose@arm.com>
Subject: [PATCH 1/3] KVM: arm/arm64: vgic: Remove the declaration of
 kvm_send_userspace_msi()
Date: Tue, 29 Oct 2019 15:19:17 +0800
Message-ID: <20191029071919.177-2-yuzenghui@huawei.com>
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

The callsite of kvm_send_userspace_msi() is currently arch agnostic.
There seems no reason to keep an extra declaration of it in arm_vgic.h
(we already have one in include/linux/kvm_host.h).

Remove it.

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 include/kvm/arm_vgic.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index af4f09c02bf1..0fb240ec0a2a 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -378,8 +378,6 @@ static inline int kvm_vgic_get_max_vcpus(void)
 	return kvm_vgic_global_state.max_gic_vcpus;
 }
 
-int kvm_send_userspace_msi(struct kvm *kvm, struct kvm_msi *msi);
-
 /**
  * kvm_vgic_setup_default_irq_routing:
  * Setup a default flat gsi routing table mapping all SPIs
-- 
2.19.1


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
