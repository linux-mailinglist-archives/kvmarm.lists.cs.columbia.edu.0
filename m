Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD986BC33
	for <lists+kvmarm@lfdr.de>; Wed, 17 Jul 2019 14:22:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DA16F4A56D;
	Wed, 17 Jul 2019 08:22:45 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oWdoyRa02A-l; Wed, 17 Jul 2019 08:22:45 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BA8A24A565;
	Wed, 17 Jul 2019 08:22:44 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B05744A53C
 for <kvmarm@lists.cs.columbia.edu>; Wed, 17 Jul 2019 08:22:43 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YoINlN4jVSzf for <kvmarm@lists.cs.columbia.edu>;
 Wed, 17 Jul 2019 08:22:42 -0400 (EDT)
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id EDBF24A528
 for <kvmarm@lists.cs.columbia.edu>; Wed, 17 Jul 2019 08:22:41 -0400 (EDT)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id C6F9858E1C3A77E076A8;
 Wed, 17 Jul 2019 20:22:38 +0800 (CST)
Received: from HGHY2Y004646261.china.huawei.com (10.184.12.158) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Wed, 17 Jul 2019 20:22:31 +0800
From: Zenghui Yu <yuzenghui@huawei.com>
To: <maz@kernel.org>, <kvmarm@lists.cs.columbia.edu>,
 <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] KVM: arm/arm64: Assign pmc->idx before kvm_pmu_stop_counter()
Date: Wed, 17 Jul 2019 12:20:19 +0000
Message-ID: <1563366019-31200-1-git-send-email-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.6.4.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.184.12.158]
X-CFilter-Loop: Reflected
Cc: marc.zyngier@arm.com, linux-kernel@vger.kernel.org
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

We use "pmc->idx" and the "chained" bitmap to determine if the pmc is
chained, in kvm_pmu_pmc_is_chained().  But idx might be uninitialized
(and random) when we doing this decision, through a KVM_ARM_VCPU_INIT
ioctl -> kvm_pmu_vcpu_reset(). And the test_bit() against this random
idx will potentially hit a KASAN BUG [1].

Fix it by moving the assignment of idx before kvm_pmu_stop_counter().

[1] https://www.spinics.net/lists/kvm-arm/msg36700.html

Fixes: 80f393a23be6 ("KVM: arm/arm64: Support chained PMU counters")
Suggested-by: Andrew Murray <andrew.murray@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 virt/kvm/arm/pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
index 3dd8238..521bfdd 100644
--- a/virt/kvm/arm/pmu.c
+++ b/virt/kvm/arm/pmu.c
@@ -225,8 +225,8 @@ void kvm_pmu_vcpu_reset(struct kvm_vcpu *vcpu)
 	struct kvm_pmu *pmu = &vcpu->arch.pmu;
 
 	for (i = 0; i < ARMV8_PMU_MAX_COUNTERS; i++) {
-		kvm_pmu_stop_counter(vcpu, &pmu->pmc[i]);
 		pmu->pmc[i].idx = i;
+		kvm_pmu_stop_counter(vcpu, &pmu->pmc[i]);
 	}
 
 	bitmap_zero(vcpu->arch.pmu.chained, ARMV8_PMU_MAX_COUNTER_PAIRS);
-- 
1.8.3.1


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
