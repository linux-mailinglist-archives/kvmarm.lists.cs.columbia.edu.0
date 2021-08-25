Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 61C403F7A0C
	for <lists+kvmarm@lfdr.de>; Wed, 25 Aug 2021 18:17:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 159C24B238;
	Wed, 25 Aug 2021 12:17:49 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oi50XatKvqlG; Wed, 25 Aug 2021 12:17:44 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AA0A64B291;
	Wed, 25 Aug 2021 12:17:30 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5BA514B213
 for <kvmarm@lists.cs.columbia.edu>; Wed, 25 Aug 2021 12:17:30 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BZG7-+wWmXhk for <kvmarm@lists.cs.columbia.edu>;
 Wed, 25 Aug 2021 12:17:26 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A4EB14B259
 for <kvmarm@lists.cs.columbia.edu>; Wed, 25 Aug 2021 12:17:20 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 386A9D6E;
 Wed, 25 Aug 2021 09:17:20 -0700 (PDT)
Received: from monolith.cable.virginm.net (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE56B3F66F;
 Wed, 25 Aug 2021 09:17:18 -0700 (PDT)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 will@kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 05/39] KVM: arm64: Perform CMOs on locked memslots when
 userspace resets VCPUs
Date: Wed, 25 Aug 2021 17:17:41 +0100
Message-Id: <20210825161815.266051-6-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210825161815.266051-1-alexandru.elisei@arm.com>
References: <20210825161815.266051-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
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

Userspace resets a VCPU that has already run by means of a
KVM_ARM_VCPU_INIT ioctl. This is usually done after a VM shutdown and
before the same VM is rebooted, and during this interval the VM memory can
be modified by userspace (for example, to copy the original guest kernel
image). In this situation, KVM unmaps the entire stage 2 to trigger stage 2
faults, which ensures that the guest has the same view of memory as the
host's userspace.

Unmapping stage 2 is not an option for locked memslots, so instead do the
cache maintenance the first time a VCPU is run, similar to what KVM does
when a memslot is locked.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/include/asm/kvm_host.h |  3 ++-
 arch/arm64/kvm/mmu.c              | 13 ++++++++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index ed67f914d169..68905bd47f85 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -114,7 +114,8 @@ struct kvm_arch_memory_slot {
 
 /* kvm->arch.mmu_pending_ops flags */
 #define KVM_LOCKED_MEMSLOT_FLUSH_DCACHE	0
-#define KVM_MAX_MMU_PENDING_OPS		1
+#define KVM_LOCKED_MEMSLOT_INVAL_ICACHE	1
+#define KVM_MAX_MMU_PENDING_OPS		2
 
 struct kvm_arch {
 	struct kvm_s2_mmu mmu;
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 94fa08f3d9d3..f1f8a87550d1 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -560,8 +560,16 @@ void stage2_unmap_vm(struct kvm *kvm)
 	spin_lock(&kvm->mmu_lock);
 
 	slots = kvm_memslots(kvm);
-	kvm_for_each_memslot(memslot, slots)
+	kvm_for_each_memslot(memslot, slots) {
+		if (memslot_is_locked(memslot)) {
+			set_bit(KVM_LOCKED_MEMSLOT_FLUSH_DCACHE,
+				&kvm->arch.mmu_pending_ops);
+			set_bit(KVM_LOCKED_MEMSLOT_INVAL_ICACHE,
+				&kvm->arch.mmu_pending_ops);
+			continue;
+		}
 		stage2_unmap_memslot(kvm, memslot);
+	}
 
 	spin_unlock(&kvm->mmu_lock);
 	mmap_read_unlock(current->mm);
@@ -1281,6 +1289,9 @@ void kvm_mmu_perform_pending_ops(struct kvm *kvm)
 		}
 	}
 
+	if (test_bit(KVM_LOCKED_MEMSLOT_INVAL_ICACHE, &kvm->arch.mmu_pending_ops))
+		icache_inval_all_pou();
+
 	bitmap_zero(&kvm->arch.mmu_pending_ops, KVM_MAX_MMU_PENDING_OPS);
 
 out_unlock:
-- 
2.33.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
