Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A8D174B649E
	for <lists+kvmarm@lfdr.de>; Tue, 15 Feb 2022 08:47:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D2CD340DE6;
	Tue, 15 Feb 2022 02:47:00 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.911
X-Spam-Level: 
X-Spam-Status: No, score=0.911 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bQK1IMHp5b6P; Tue, 15 Feb 2022 02:47:00 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 19A7740AFA;
	Tue, 15 Feb 2022 02:46:59 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6A7F5405C6
 for <kvmarm@lists.cs.columbia.edu>; Tue, 15 Feb 2022 02:46:57 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DVZIr64RY0pS for <kvmarm@lists.cs.columbia.edu>;
 Tue, 15 Feb 2022 02:46:55 -0500 (EST)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com
 [209.85.217.54])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id BDE0440096
 for <kvmarm@lists.cs.columbia.edu>; Tue, 15 Feb 2022 02:46:55 -0500 (EST)
Received: by mail-vs1-f54.google.com with SMTP id u10so8714780vsu.13
 for <kvmarm@lists.cs.columbia.edu>; Mon, 14 Feb 2022 23:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eFoNEisdPG0dbS3LdfnCPDYJYfO7ES16trqWvkiDFA0=;
 b=Mpn032wVYFa+EUHXETGUH4dILdZTINbNynpPwfXqI9BkzLgBYujfAXpbFSzES2kltQ
 7PbTk03Zpst0+HkcP/ymPK1uEVo4zv626wEReivNL8g5mbFS7TOW71dXS+f97xq8N3hd
 6vHfqf+wfQ1MEGENGF1KQd8ez47z96cAR+fO1uz9IK2n/OO/0/ltqpcGUnkbKnzk+Fi+
 K5mDiBJ2ndCmqo22LOIbcHt3dLnXMKPhBBFbm23GwfG5f4XraUuX253loVWMUvtuMR1j
 gZAtKDBAtUFKUta1JYPZXQ7Hsho/yIHiHmf6SuGMvi/Jo6iRYcjM7rD55nL/meuYwIyD
 pD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eFoNEisdPG0dbS3LdfnCPDYJYfO7ES16trqWvkiDFA0=;
 b=Kz11XSnBsfDLP+s7Qfh1rjfLrKzXnwp5RfOIIh3tXd9TePtswNCKsW8rEppK4Hy1Tc
 XN+Jcho4MVMPAtKjZ1Mn4dzldc9E49+LkknLtf2tJ2+K92gOgiCNXoha5yjqa78pf2kM
 /1u5i6tmeyqtSdpxM6j9onv+Zu4YpHKYyjagkPVqzqjYc60p4O5JNF7wwYmSPbuc1Px1
 83c2x0/SPoxf6Pwi2zCDBe2rmTE4qccI3WpdzShy5NUFG6Q9VS6WxJrk6xQQ3fIaHK9w
 2Q6vsOQ7GDGLnnHDAf1ZQBO1jgeziqssX8Sp+j1rPhbtbgnPumK+RqM3m7hOXLIkKsEq
 GnIQ==
X-Gm-Message-State: AOAM531/qDNRZKN2W98eKi1f89YvzHR6cnR6+kSHORzxfiNnHTZOqXrf
 mQxKJwMXNVg9y7XZzdtvb2h+dTt4hDD+GAGKJNpJmg==
X-Google-Smtp-Source: ABdhPJw3tCRGBU/11/ykXrA3x1O+3nlxWcHBiWVrCNUhRcONDlIVoiJRBHwhkQVbVRXm7m4h7mfwszOUF4ScN2/zo6I=
X-Received: by 2002:a67:ed58:: with SMTP id m24mr978419vsp.56.1644911214856;
 Mon, 14 Feb 2022 23:46:54 -0800 (PST)
MIME-Version: 1.0
References: <20211117153842.302159-1-alexandru.elisei@arm.com>
 <20211117153842.302159-4-alexandru.elisei@arm.com>
In-Reply-To: <20211117153842.302159-4-alexandru.elisei@arm.com>
From: Reiji Watanabe <reijiw@google.com>
Date: Mon, 14 Feb 2022 23:46:38 -0800
Message-ID: <CAAeT=FxwoHvrBtQM2r_s6UnMtBewQ8RRpN3k2zeBW7SpFdj32w@mail.gmail.com>
Subject: Re: [RFC PATCH v5 03/38] KVM: arm64: Implement the memslot
 lock/unlock functionality
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu, Linux ARM <linux-arm-kernel@lists.infradead.org>
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

Hi Alex,

On Wed, Nov 17, 2021 at 7:37 AM Alexandru Elisei
<alexandru.elisei@arm.com> wrote:
>
> Pin memory in the process address space and map it in the stage 2 tables as
> a result of userspace enabling the KVM_CAP_ARM_LOCK_USER_MEMORY_REGION
> capability; and unpin it from the process address space when the capability
> is used with the KVM_ARM_LOCK_USER_MEMORY_REGION_FLAGS_UNLOCK flag.
>
> The current implementation has two drawbacks which will be fixed in future
> patches:
>
> - The dcache maintenance is done when the memslot is locked, which means
>   that it is possible that memory changes made by userspace after the ioctl
>   completes won't be visible to a guest running with the MMU off.
>
> - Tag scrubbing is done when the memslot is locked. If the MTE capability
>   is enabled after the ioctl, the guest will be able to access unsanitised
>   pages. This is prevented by forbidding userspace to enable the MTE
>   capability if any memslots are locked.
>
> Only PAGE_SIZE mappings are supported at stage 2.
>
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> ---
>  Documentation/virt/kvm/api.rst    |   4 +-
>  arch/arm64/include/asm/kvm_host.h |  11 ++
>  arch/arm64/kvm/arm.c              |  22 +++-
>  arch/arm64/kvm/mmu.c              | 204 ++++++++++++++++++++++++++++--
>  4 files changed, 226 insertions(+), 15 deletions(-)
>
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 16aa59eae3d9..0ac12a730013 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6979,8 +6979,8 @@ write permissions are specified for a memslot which logs dirty pages.
>
>  Enabling this capability causes the memory pinned when locking the memslot
>  specified in args[0] to be unpinned, or, optionally, all memslots to be
> -unlocked. The IPA range is not unmapped from stage 2.
> ->>>>>>> 56641eee289e (KVM: arm64: Add lock/unlock memslot user API)
> +unlocked. The IPA range is not unmapped from stage 2. It is considered an error
> +to attempt to unlock a memslot which is not locked.
>
>  8. Other capabilities.
>  ======================
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 733621e41900..7fd70ad90c16 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -99,7 +99,18 @@ struct kvm_s2_mmu {
>         struct kvm_arch *arch;
>  };
>
> +#define KVM_MEMSLOT_LOCK_READ          (1 << 0)
> +#define KVM_MEMSLOT_LOCK_WRITE         (1 << 1)
> +#define KVM_MEMSLOT_LOCK_MASK          0x3
> +
> +struct kvm_memory_slot_page {
> +       struct list_head list;
> +       struct page *page;
> +};
> +
>  struct kvm_arch_memory_slot {
> +       struct kvm_memory_slot_page pages;
> +       u32 flags;
>  };
>
>  struct kvm_arch {
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index d49905d18cee..b9b8b43835e3 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -106,6 +106,25 @@ static int kvm_lock_user_memory_region_ioctl(struct kvm *kvm,
>         }
>  }
>
> +static bool kvm_arm_has_locked_memslots(struct kvm *kvm)
> +{
> +       struct kvm_memslots *slots = kvm_memslots(kvm);
> +       struct kvm_memory_slot *memslot;
> +       bool has_locked_memslots = false;
> +       int idx;
> +
> +       idx = srcu_read_lock(&kvm->srcu);
> +       kvm_for_each_memslot(memslot, slots) {
> +               if (memslot->arch.flags & KVM_MEMSLOT_LOCK_MASK) {
> +                       has_locked_memslots = true;
> +                       break;
> +               }
> +       }
> +       srcu_read_unlock(&kvm->srcu, idx);
> +
> +       return has_locked_memslots;
> +}
> +
>  int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
>                             struct kvm_enable_cap *cap)
>  {
> @@ -120,7 +139,8 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
>                 break;
>         case KVM_CAP_ARM_MTE:
>                 mutex_lock(&kvm->lock);
> -               if (!system_supports_mte() || kvm->created_vcpus) {
> +               if (!system_supports_mte() || kvm->created_vcpus ||
> +                   (kvm_arm_lock_memslot_supported() && kvm_arm_has_locked_memslots(kvm))) {
>                         r = -EINVAL;
>                 } else {
>                         r = 0;
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index f65bcbc9ae69..b0a8e61315e4 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -72,6 +72,11 @@ static bool memslot_is_logging(struct kvm_memory_slot *memslot)
>         return memslot->dirty_bitmap && !(memslot->flags & KVM_MEM_READONLY);
>  }
>
> +static bool memslot_is_locked(struct kvm_memory_slot *memslot)
> +{
> +       return memslot->arch.flags & KVM_MEMSLOT_LOCK_MASK;
> +}
> +
>  /**
>   * kvm_flush_remote_tlbs() - flush all VM TLB entries for v7/8
>   * @kvm:       pointer to kvm structure.
> @@ -769,6 +774,10 @@ static bool fault_supports_stage2_huge_mapping(struct kvm_memory_slot *memslot,
>         if (map_size == PAGE_SIZE)
>                 return true;
>
> +       /* Allow only PAGE_SIZE mappings for locked memslots */
> +       if (memslot_is_locked(memslot))
> +               return false;
> +
>         size = memslot->npages * PAGE_SIZE;
>
>         gpa_start = memslot->base_gfn << PAGE_SHIFT;
> @@ -1296,6 +1305,159 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
>         return ret;
>  }
>
> +static int try_rlimit_memlock(unsigned long npages)
> +{
> +       unsigned long lock_limit;
> +       bool has_lock_cap;
> +       int ret = 0;
> +
> +       has_lock_cap = capable(CAP_IPC_LOCK);
> +       if (has_lock_cap)
> +               goto out;
> +
> +       lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> +
> +       mmap_read_lock(current->mm);
> +       if (npages + current->mm->locked_vm > lock_limit)
> +               ret = -ENOMEM;
> +       mmap_read_unlock(current->mm);
> +
> +out:
> +       return ret;
> +}
> +
> +static void unpin_memslot_pages(struct kvm_memory_slot *memslot, bool writable)
> +{
> +       struct kvm_memory_slot_page *entry, *tmp;
> +
> +       list_for_each_entry_safe(entry, tmp, &memslot->arch.pages.list, list) {
> +               if (writable)
> +                       set_page_dirty_lock(entry->page);
> +               unpin_user_page(entry->page);
> +               kfree(entry);
> +       }
> +}

Shouldn't this be done when the memslot is deleted ?
(Or should the locked memslot be prevented from deleting ?)

> +
> +static int lock_memslot(struct kvm *kvm, struct kvm_memory_slot *memslot,
> +                       u64 flags)
> +{
> +       struct kvm_mmu_memory_cache cache = { 0, __GFP_ZERO, NULL, };
> +       struct kvm_memory_slot_page *page_entry;
> +       bool writable = flags & KVM_ARM_LOCK_MEM_WRITE;
> +       enum kvm_pgtable_prot prot = KVM_PGTABLE_PROT_R;
> +       struct kvm_pgtable *pgt = kvm->arch.mmu.pgt;
> +       struct vm_area_struct *vma;
> +       unsigned long npages = memslot->npages;
> +       unsigned int pin_flags = FOLL_LONGTERM;
> +       unsigned long i, hva, ipa, mmu_seq;
> +       int ret;
> +
> +       ret = try_rlimit_memlock(npages);

Even if the memory for the hva described by the memslot is already
'locked' by mlock or etc, is this checking needed ?


> +       if (ret)
> +               return -ENOMEM;
> +
> +       INIT_LIST_HEAD(&memslot->arch.pages.list);
> +
> +       if (writable) {
> +               prot |= KVM_PGTABLE_PROT_W;
> +               pin_flags |= FOLL_WRITE;

The lock flag is just for stage 2 mapping, correct ?
I wonder if it is appropriate for KVM to set 'pin_flags', which is
passed to pin_user_pages(), based on the lock flag.

> +       }
> +
> +       hva = memslot->userspace_addr;
> +       ipa = memslot->base_gfn << PAGE_SHIFT;
> +
> +       mmu_seq = kvm->mmu_notifier_seq;
> +       smp_rmb();
> +
> +       for (i = 0; i < npages; i++) {
> +               page_entry = kzalloc(sizeof(*page_entry), GFP_KERNEL);
> +               if (!page_entry) {
> +                       unpin_memslot_pages(memslot, writable);
> +                       ret = -ENOMEM;
> +                       goto out_err;

Nit: It seems we can call unpin_memslot_pages() from 'out_err'
instead of calling it from each of the error cases.

> +               }
> +
> +               mmap_read_lock(current->mm);
> +               ret = pin_user_pages(hva, 1, pin_flags, &page_entry->page, &vma);
> +               if (ret != 1) {
> +                       mmap_read_unlock(current->mm);
> +                       unpin_memslot_pages(memslot, writable);
> +                       ret = -ENOMEM;
> +                       goto out_err;
> +               }
> +               if (kvm_has_mte(kvm)) {
> +                       if (vma->vm_flags & VM_SHARED) {
> +                               ret = -EFAULT;
> +                       } else {
> +                               ret = sanitise_mte_tags(kvm,
> +                                       page_to_pfn(page_entry->page),
> +                                       PAGE_SIZE);
> +                       }
> +                       if (ret) {
> +                               mmap_read_unlock(current->mm);
> +                               goto out_err;
> +                       }
> +               }
> +               mmap_read_unlock(current->mm);
> +
> +               ret = kvm_mmu_topup_memory_cache(&cache, kvm_mmu_cache_min_pages(kvm));
> +               if (ret) {
> +                       unpin_memslot_pages(memslot, writable);
> +                       goto out_err;
> +               }
> +
> +               spin_lock(&kvm->mmu_lock);
> +               if (mmu_notifier_retry(kvm, mmu_seq)) {
> +                       spin_unlock(&kvm->mmu_lock);
> +                       unpin_memslot_pages(memslot, writable);
> +                       ret = -EAGAIN;
> +                       goto out_err;
> +               }
> +
> +               ret = kvm_pgtable_stage2_map(pgt, ipa, PAGE_SIZE,
> +                                            page_to_phys(page_entry->page),
> +                                            prot, &cache);
> +               spin_unlock(&kvm->mmu_lock);
> +
> +               if (ret) {
> +                       kvm_pgtable_stage2_unmap(pgt, memslot->base_gfn << PAGE_SHIFT,
> +                                                i << PAGE_SHIFT);
> +                       unpin_memslot_pages(memslot, writable);
> +                       goto out_err;
> +               }
> +               list_add(&page_entry->list, &memslot->arch.pages.list);
> +
> +               hva += PAGE_SIZE;
> +               ipa += PAGE_SIZE;
> +       }
> +
> +
> +       /*
> +        * Even though we've checked the limit at the start, we can still exceed
> +        * it if userspace locked other pages in the meantime or if the
> +        * CAP_IPC_LOCK capability has been revoked.
> +        */
> +       ret = account_locked_vm(current->mm, npages, true);
> +       if (ret) {
> +               kvm_pgtable_stage2_unmap(pgt, memslot->base_gfn << PAGE_SHIFT,
> +                                        npages << PAGE_SHIFT);
> +               unpin_memslot_pages(memslot, writable);
> +               goto out_err;
> +       }
> +
> +       memslot->arch.flags = KVM_MEMSLOT_LOCK_READ;
> +       if (writable)
> +               memslot->arch.flags |= KVM_MEMSLOT_LOCK_WRITE;
> +
> +       kvm_mmu_free_memory_cache(&cache);
> +
> +       return 0;
> +
> +out_err:
> +       kvm_mmu_free_memory_cache(&cache);
> +       return ret;
> +}
> +
>  int kvm_mmu_lock_memslot(struct kvm *kvm, u64 slot, u64 flags)
>  {
>         struct kvm_memory_slot *memslot;
> @@ -1325,7 +1487,12 @@ int kvm_mmu_lock_memslot(struct kvm *kvm, u64 slot, u64 flags)
>                 goto out_unlock_slots;
>         }
>
> -       ret = -EINVAL;
> +       if (memslot_is_locked(memslot)) {
> +               ret = -EBUSY;
> +               goto out_unlock_slots;
> +       }
> +
> +       ret = lock_memslot(kvm, memslot, flags);
>
>  out_unlock_slots:
>         mutex_unlock(&kvm->slots_lock);
> @@ -1335,11 +1502,22 @@ int kvm_mmu_lock_memslot(struct kvm *kvm, u64 slot, u64 flags)
>         return ret;
>  }
>
> +static void unlock_memslot(struct kvm *kvm, struct kvm_memory_slot *memslot)
> +{
> +       bool writable = memslot->arch.flags & KVM_MEMSLOT_LOCK_WRITE;
> +       unsigned long npages = memslot->npages;
> +
> +       unpin_memslot_pages(memslot, writable);
> +       account_locked_vm(current->mm, npages, false);
> +
> +       memslot->arch.flags &= ~KVM_MEMSLOT_LOCK_MASK;
> +}

What if the memslot was locked with read only but the memslot
has read/write permission set ?  Shouldn't the stage 2 mapping
updated if KVM allows for the scenario ?

Thanks,
Reiji


> +
>  int kvm_mmu_unlock_memslot(struct kvm *kvm, u64 slot, u64 flags)
>  {
>         bool unlock_all = flags & KVM_ARM_UNLOCK_MEM_ALL;
>         struct kvm_memory_slot *memslot;
> -       int ret;
> +       int ret = 0;
>
>         if (!unlock_all && slot >= KVM_MEM_SLOTS_NUM)
>                 return -EINVAL;
> @@ -1347,18 +1525,20 @@ int kvm_mmu_unlock_memslot(struct kvm *kvm, u64 slot, u64 flags)
>         mutex_lock(&kvm->slots_lock);
>
>         if (unlock_all) {
> -               ret = -EINVAL;
> -               goto out_unlock_slots;
> -       }
> -
> -       memslot = id_to_memslot(kvm_memslots(kvm), slot);
> -       if (!memslot) {
> -               ret = -EINVAL;
> -               goto out_unlock_slots;
> +               kvm_for_each_memslot(memslot, kvm_memslots(kvm)) {
> +                       if (!memslot_is_locked(memslot))
> +                               continue;
> +                       unlock_memslot(kvm, memslot);
> +               }
> +       } else {
> +               memslot = id_to_memslot(kvm_memslots(kvm), slot);
> +               if (!memslot || !memslot_is_locked(memslot)) {
> +                       ret = -EINVAL;
> +                       goto out_unlock_slots;
> +               }
> +               unlock_memslot(kvm, memslot);
>         }
>
> -       ret = -EINVAL;
> -
>  out_unlock_slots:
>         mutex_unlock(&kvm->slots_lock);
>         return ret;
> --
> 2.33.1
>
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
