Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0178310DC2E
	for <lists+kvmarm@lfdr.de>; Sat, 30 Nov 2019 03:45:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 64C224AEAF;
	Fri, 29 Nov 2019 21:45:37 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EAL8+-WZ6lg6; Fri, 29 Nov 2019 21:45:37 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 43CE24AEA0;
	Fri, 29 Nov 2019 21:45:36 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id AD8E14ACEE
 for <kvmarm@lists.cs.columbia.edu>; Fri, 29 Nov 2019 21:45:34 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id itDmgHB7+Ust for <kvmarm@lists.cs.columbia.edu>;
 Fri, 29 Nov 2019 21:45:33 -0500 (EST)
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 6AE2F4A4F6
 for <kvmarm@lists.cs.columbia.edu>; Fri, 29 Nov 2019 21:45:32 -0500 (EST)
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 96812B9628629FE8062D;
 Sat, 30 Nov 2019 10:45:25 +0800 (CST)
Received: from huawei.com (10.175.105.18) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Sat, 30 Nov 2019
 10:45:17 +0800
From: linmiaohe <linmiaohe@huawei.com>
To: <maz@kernel.org>, <pbonzini@redhat.com>, <rkrcmar@redhat.com>,
 <james.morse@arm.com>, <julien.thierry.kdev@gmail.com>,
 <suzuki.poulose@arm.com>, <christoffer.dall@arm.com>,
 <catalin.marinas@arm.com>, <eric.auger@redhat.com>,
 <gregkh@linuxfoundation.org>, <will@kernel.org>, <andre.przywara@arm.com>,
 <tglx@linutronix.de>
Subject: [PATCH v3] KVM: vgic: Use wrapper function to lock/unlock all vcpus
 in kvm_vgic_create()
Date: Sat, 30 Nov 2019 10:45:18 +0800
Message-ID: <1575081918-11401-1-git-send-email-linmiaohe@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.175.105.18]
X-CFilter-Loop: Reflected
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, steven.price@arm.com,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

From: Miaohe Lin <linmiaohe@huawei.com>

Use wrapper function lock_all_vcpus()/unlock_all_vcpus()
in kvm_vgic_create() to remove duplicated code dealing
with locking and unlocking all vcpus in a vm.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Steven Price <steven.price@arm.com>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
-v2:
	Fix some spelling mistake in patch title and commit log.
-v3:
	Remove the comment that no longer makes sense.
---
 virt/kvm/arm/vgic/vgic-init.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-init.c b/virt/kvm/arm/vgic/vgic-init.c
index b3c5de48064c..22ff73ecac80 100644
--- a/virt/kvm/arm/vgic/vgic-init.c
+++ b/virt/kvm/arm/vgic/vgic-init.c
@@ -70,7 +70,7 @@ void kvm_vgic_early_init(struct kvm *kvm)
  */
 int kvm_vgic_create(struct kvm *kvm, u32 type)
 {
-	int i, vcpu_lock_idx = -1, ret;
+	int i, ret;
 	struct kvm_vcpu *vcpu;
 
 	if (irqchip_in_kernel(kvm))
@@ -86,17 +86,9 @@ int kvm_vgic_create(struct kvm *kvm, u32 type)
 		!kvm_vgic_global_state.can_emulate_gicv2)
 		return -ENODEV;
 
-	/*
-	 * Any time a vcpu is run, vcpu_load is called which tries to grab the
-	 * vcpu->mutex.  By grabbing the vcpu->mutex of all VCPUs we ensure
-	 * that no other VCPUs are run while we create the vgic.
-	 */
 	ret = -EBUSY;
-	kvm_for_each_vcpu(i, vcpu, kvm) {
-		if (!mutex_trylock(&vcpu->mutex))
-			goto out_unlock;
-		vcpu_lock_idx = i;
-	}
+	if (!lock_all_vcpus(kvm))
+		return ret;
 
 	kvm_for_each_vcpu(i, vcpu, kvm) {
 		if (vcpu->arch.has_run_once)
@@ -125,10 +117,7 @@ int kvm_vgic_create(struct kvm *kvm, u32 type)
 		INIT_LIST_HEAD(&kvm->arch.vgic.rd_regions);
 
 out_unlock:
-	for (; vcpu_lock_idx >= 0; vcpu_lock_idx--) {
-		vcpu = kvm_get_vcpu(kvm, vcpu_lock_idx);
-		mutex_unlock(&vcpu->mutex);
-	}
+	unlock_all_vcpus(kvm);
 	return ret;
 }
 
-- 
2.19.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
