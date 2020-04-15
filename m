Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1E36A1A943F
	for <lists+kvmarm@lfdr.de>; Wed, 15 Apr 2020 09:29:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 901954B1E2;
	Wed, 15 Apr 2020 03:29:21 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ID0wVepCRYxB; Wed, 15 Apr 2020 03:29:21 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 62D464B15B;
	Wed, 15 Apr 2020 03:29:20 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7B8F54B0D0
 for <kvmarm@lists.cs.columbia.edu>; Wed, 15 Apr 2020 03:29:19 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f14D59HQpkxi for <kvmarm@lists.cs.columbia.edu>;
 Wed, 15 Apr 2020 03:29:18 -0400 (EDT)
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 775174A3B4
 for <kvmarm@lists.cs.columbia.edu>; Wed, 15 Apr 2020 03:29:17 -0400 (EDT)
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 2FA05A3C4D514F23AA5D;
 Wed, 15 Apr 2020 15:29:14 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.173.222.27) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Wed, 15 Apr 2020 15:29:08 +0800
From: Zenghui Yu <yuzenghui@huawei.com>
To: <kvmarm@lists.cs.columbia.edu>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH RFC] KVM: arm64: Sidestep stage2_unmap_vm() on vcpu reset when
 S2FWB is supported
Date: Wed, 15 Apr 2020 15:28:35 +0800
Message-ID: <20200415072835.1164-1-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Cc: Marc
 Zyngier <maz@kernel.org>
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

stage2_unmap_vm() was introduced to unmap user RAM region in the stage2
page table to make the caches coherent. E.g., a guest reboot with stage1
MMU disabled will access memory using non-cacheable attributes. If the
RAM and caches are not coherent at this stage, some evicted dirty cache
line may go and corrupt guest data in RAM.

Since ARMv8.4, S2FWB feature is mandatory and KVM will take advantage
of it to configure the stage2 page table and the attributes of memory
access. So we ensure that guests always access memory using cacheable
attributes and thus, the caches always be coherent.

So on CPUs that support S2FWB, we can safely reset the vcpu without a
heavy stage2 unmapping.

Cc: Marc Zyngier <maz@kernel.org>
Cc: Christoffer Dall <christoffer.dall@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Julien Thierry <julien.thierry.kdev@gmail.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---

If this is correct, there should be a great performance improvement on
a guest reboot (or reset) on systems support S2FWB. But I'm afraid that
I've missed some points here, so please comment!

The commit 957db105c997 ("arm/arm64: KVM: Introduce stage2_unmap_vm")
was merged about six years ago and I failed to track its histroy and
intention. Instead of a whole stage2 unmapping, something like
stage2_flush_vm() looks enough to me. But again, I'm unsure...

Thanks for having a look!

 virt/kvm/arm/arm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 48d0ec44ad77..e6378162cdef 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -983,8 +983,11 @@ static int kvm_arch_vcpu_ioctl_vcpu_init(struct kvm_vcpu *vcpu,
 	/*
 	 * Ensure a rebooted VM will fault in RAM pages and detect if the
 	 * guest MMU is turned off and flush the caches as needed.
+	 *
+	 * S2FWB enforces all memory accesses to RAM being cacheable, we
+	 * ensure that the cache is always coherent.
 	 */
-	if (vcpu->arch.has_run_once)
+	if (vcpu->arch.has_run_once && !cpus_have_const_cap(ARM64_HAS_STAGE2_FWB))
 		stage2_unmap_vm(vcpu->kvm);
 
 	vcpu_reset_hcr(vcpu);
-- 
2.19.1


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
