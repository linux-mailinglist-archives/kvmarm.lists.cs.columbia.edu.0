Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 38BB24549FC
	for <lists+kvmarm@lfdr.de>; Wed, 17 Nov 2021 16:37:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DBDF14B130;
	Wed, 17 Nov 2021 10:37:20 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dEc2FfqUytF9; Wed, 17 Nov 2021 10:37:19 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 05C554B16E;
	Wed, 17 Nov 2021 10:37:19 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2FD224B149
 for <kvmarm@lists.cs.columbia.edu>; Wed, 17 Nov 2021 10:37:18 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vFnru4coFsYA for <kvmarm@lists.cs.columbia.edu>;
 Wed, 17 Nov 2021 10:37:16 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D2E424B17C
 for <kvmarm@lists.cs.columbia.edu>; Wed, 17 Nov 2021 10:37:13 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 260951FB;
 Wed, 17 Nov 2021 07:37:13 -0800 (PST)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E2C73F5A1;
 Wed, 17 Nov 2021 07:37:11 -0800 (PST)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 will@kernel.org, mark.rutland@arm.com
Subject: [RFC PATCH v5 06/38] KVM: arm64: Delay tag scrubbing for locked
 memslots until a VCPU runs
Date: Wed, 17 Nov 2021 15:38:10 +0000
Message-Id: <20211117153842.302159-7-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211117153842.302159-1-alexandru.elisei@arm.com>
References: <20211117153842.302159-1-alexandru.elisei@arm.com>
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

When an MTE-enabled guest first accesses a physical page, that page must be
scrubbed for tags. This is normally done by KVM on a translation fault, but
with locked memslots we will not get translation faults. So far, this has
been handled by forbidding userspace to enable the MTE capability after
locking a memslot.

Remove this constraint by deferring tag cleaning until the first VCPU is
run, similar to how KVM handles cache maintenance operations.

When userspace resets a VCPU, KVM again performs cache maintenance
operations on locked memslots because userspace might have modified the
guest memory. Clean the tags the next time a VCPU is run for the same
reason.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/include/asm/kvm_host.h |  7 ++-
 arch/arm64/include/asm/kvm_mmu.h  |  2 +-
 arch/arm64/kvm/arm.c              | 29 ++--------
 arch/arm64/kvm/mmu.c              | 95 ++++++++++++++++++++++++++-----
 4 files changed, 91 insertions(+), 42 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 5f49a27ce289..0ebdef158020 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -114,9 +114,10 @@ struct kvm_arch_memory_slot {
 };
 
 /* kvm->arch.mmu_pending_ops flags */
-#define KVM_LOCKED_MEMSLOT_FLUSH_DCACHE	0
-#define KVM_LOCKED_MEMSLOT_INVAL_ICACHE	1
-#define KVM_MAX_MMU_PENDING_OPS		2
+#define KVM_LOCKED_MEMSLOT_FLUSH_DCACHE		0
+#define KVM_LOCKED_MEMSLOT_INVAL_ICACHE		1
+#define KVM_LOCKED_MEMSLOT_SANITISE_TAGS	2
+#define KVM_MAX_MMU_PENDING_OPS			3
 
 struct kvm_arch {
 	struct kvm_s2_mmu mmu;
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index cbf57c474fea..2d2f902000b3 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -222,7 +222,7 @@ int kvm_mmu_unlock_memslot(struct kvm *kvm, u64 slot, u64 flags);
 #define kvm_mmu_has_pending_ops(kvm)	\
 	(!bitmap_empty(&(kvm)->arch.mmu_pending_ops, KVM_MAX_MMU_PENDING_OPS))
 
-void kvm_mmu_perform_pending_ops(struct kvm *kvm);
+int kvm_mmu_perform_pending_ops(struct kvm *kvm);
 
 static inline unsigned int kvm_get_vmid_bits(void)
 {
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 96ed48455cdd..13f3af1f2e78 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -106,25 +106,6 @@ static int kvm_lock_user_memory_region_ioctl(struct kvm *kvm,
 	}
 }
 
-static bool kvm_arm_has_locked_memslots(struct kvm *kvm)
-{
-	struct kvm_memslots *slots = kvm_memslots(kvm);
-	struct kvm_memory_slot *memslot;
-	bool has_locked_memslots = false;
-	int idx;
-
-	idx = srcu_read_lock(&kvm->srcu);
-	kvm_for_each_memslot(memslot, slots) {
-		if (memslot->arch.flags & KVM_MEMSLOT_LOCK_MASK) {
-			has_locked_memslots = true;
-			break;
-		}
-	}
-	srcu_read_unlock(&kvm->srcu, idx);
-
-	return has_locked_memslots;
-}
-
 int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 			    struct kvm_enable_cap *cap)
 {
@@ -139,8 +120,7 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 		break;
 	case KVM_CAP_ARM_MTE:
 		mutex_lock(&kvm->lock);
-		if (!system_supports_mte() || kvm->created_vcpus ||
-		    (kvm_arm_lock_memslot_supported() && kvm_arm_has_locked_memslots(kvm))) {
+		if (!system_supports_mte() || kvm->created_vcpus) {
 			r = -EINVAL;
 		} else {
 			r = 0;
@@ -870,8 +850,11 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 	if (unlikely(!kvm_vcpu_initialized(vcpu)))
 		return -ENOEXEC;
 
-	if (unlikely(kvm_mmu_has_pending_ops(vcpu->kvm)))
-		kvm_mmu_perform_pending_ops(vcpu->kvm);
+	if (unlikely(kvm_mmu_has_pending_ops(vcpu->kvm))) {
+		ret = kvm_mmu_perform_pending_ops(vcpu->kvm);
+		if (ret)
+			return ret;
+	}
 
 	ret = kvm_vcpu_first_run_init(vcpu);
 	if (ret)
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 188064c5839c..2491e73e3d31 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -613,6 +613,15 @@ void stage2_unmap_vm(struct kvm *kvm)
 				&kvm->arch.mmu_pending_ops);
 			set_bit(KVM_LOCKED_MEMSLOT_INVAL_ICACHE,
 				&kvm->arch.mmu_pending_ops);
+			/*
+			 * stage2_unmap_vm() is called after a VCPU has run, at
+			 * which point the state of the MTE cap (either enabled
+			 * or disabled) is final.
+			 */
+			if (kvm_has_mte(kvm)) {
+				set_bit(KVM_LOCKED_MEMSLOT_SANITISE_TAGS,
+					&kvm->arch.mmu_pending_ops);
+			}
 			continue;
 		}
 		stage2_unmap_memslot(kvm, memslot);
@@ -956,6 +965,55 @@ static int sanitise_mte_tags(struct kvm *kvm, kvm_pfn_t pfn,
 	return 0;
 }
 
+static int sanitise_mte_tags_memslot(struct kvm *kvm,
+				     struct kvm_memory_slot *memslot)
+{
+	unsigned long hva, slot_size, slot_end;
+	struct kvm_memory_slot_page *entry;
+	struct page *page;
+	int ret = 0;
+
+	hva = memslot->userspace_addr;
+	slot_size = memslot->npages << PAGE_SHIFT;
+	slot_end = hva + slot_size;
+
+	/* First check that the VMAs spanning the memslot are not shared... */
+	do {
+		struct vm_area_struct *vma;
+
+		vma = find_vma_intersection(current->mm, hva, slot_end);
+		/* The VMAs spanning the memslot must be contiguous. */
+		if (!vma) {
+			ret = -EFAULT;
+			goto out;
+		}
+		/*
+		 * VM_SHARED mappings are not allowed with MTE to avoid races
+		 * when updating the PG_mte_tagged page flag, see
+		 * sanitise_mte_tags for more details.
+		 */
+		if (vma->vm_flags & VM_SHARED) {
+			ret = -EFAULT;
+			goto out;
+		}
+		hva = min(slot_end, vma->vm_end);
+	} while (hva < slot_end);
+
+	/* ... then clear the tags. */
+	list_for_each_entry(entry, &memslot->arch.pages.list, list) {
+		page = entry->page;
+		if (!test_bit(PG_mte_tagged, &page->flags)) {
+			mte_clear_page_tags(page_address(page));
+			set_bit(PG_mte_tagged, &page->flags);
+		}
+	}
+
+out:
+	mmap_read_unlock(current->mm);
+
+	return ret;
+}
+
 static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 			  struct kvm_memory_slot *memslot, unsigned long hva,
 			  unsigned long fault_status)
@@ -1325,14 +1383,29 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
  * - Stage 2 tables cannot be freed from under us as long as at least one VCPU
  *   is live, which means that the VM will be live.
  */
-void kvm_mmu_perform_pending_ops(struct kvm *kvm)
+int kvm_mmu_perform_pending_ops(struct kvm *kvm)
 {
 	struct kvm_memory_slot *memslot;
+	int ret = 0;
 
 	mutex_lock(&kvm->slots_lock);
 	if (!kvm_mmu_has_pending_ops(kvm))
 		goto out_unlock;
 
+	if (kvm_has_mte(kvm) &&
+	    (test_bit(KVM_LOCKED_MEMSLOT_SANITISE_TAGS, &kvm->arch.mmu_pending_ops))) {
+		kvm_for_each_memslot(memslot, kvm_memslots(kvm)) {
+			if (!memslot_is_locked(memslot))
+				continue;
+			mmap_read_lock(current->mm);
+			ret = sanitise_mte_tags_memslot(kvm, memslot);
+			mmap_read_unlock(current->mm);
+			if (ret)
+				goto out_unlock;
+		}
+		clear_bit(KVM_LOCKED_MEMSLOT_SANITISE_TAGS, &kvm->arch.mmu_pending_ops);
+	}
+
 	if (test_bit(KVM_LOCKED_MEMSLOT_FLUSH_DCACHE, &kvm->arch.mmu_pending_ops)) {
 		kvm_for_each_memslot(memslot, kvm_memslots(kvm)) {
 			if (!memslot_is_locked(memslot))
@@ -1349,7 +1422,7 @@ void kvm_mmu_perform_pending_ops(struct kvm *kvm)
 
 out_unlock:
 	mutex_unlock(&kvm->slots_lock);
-	return;
+	return ret;
 }
 
 static int try_rlimit_memlock(unsigned long npages)
@@ -1443,19 +1516,6 @@ static int lock_memslot(struct kvm *kvm, struct kvm_memory_slot *memslot,
 			ret = -ENOMEM;
 			goto out_err;
 		}
-		if (kvm_has_mte(kvm)) {
-			if (vma->vm_flags & VM_SHARED) {
-				ret = -EFAULT;
-			} else {
-				ret = sanitise_mte_tags(kvm,
-					page_to_pfn(page_entry->page),
-					PAGE_SIZE);
-			}
-			if (ret) {
-				mmap_read_unlock(current->mm);
-				goto out_err;
-			}
-		}
 		mmap_read_unlock(current->mm);
 
 		ret = kvm_mmu_topup_memory_cache(&cache, kvm_mmu_cache_min_pages(kvm));
@@ -1508,6 +1568,11 @@ static int lock_memslot(struct kvm *kvm, struct kvm_memory_slot *memslot,
 		memslot->arch.flags |= KVM_MEMSLOT_LOCK_WRITE;
 
 	set_bit(KVM_LOCKED_MEMSLOT_FLUSH_DCACHE, &kvm->arch.mmu_pending_ops);
+	/*
+	 * MTE might be enabled after we lock the memslot, set it here
+	 * unconditionally.
+	 */
+	set_bit(KVM_LOCKED_MEMSLOT_SANITISE_TAGS, &kvm->arch.mmu_pending_ops);
 
 	kvm_mmu_free_memory_cache(&cache);
 
-- 
2.33.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
