Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 849374E4FE2
	for <lists+kvmarm@lfdr.de>; Wed, 23 Mar 2022 10:57:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2E57249F07;
	Wed, 23 Mar 2022 05:57:30 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.788
X-Spam-Level: 
X-Spam-Status: No, score=-1.788 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Afe0Xic1OIvD; Wed, 23 Mar 2022 05:57:28 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1391B4B0E1;
	Wed, 23 Mar 2022 05:57:17 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4DB9D40AEB
 for <kvmarm@lists.cs.columbia.edu>; Tue, 22 Mar 2022 19:58:38 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PnQkxXRbysea for <kvmarm@lists.cs.columbia.edu>;
 Tue, 22 Mar 2022 19:58:36 -0400 (EDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com
 [209.85.167.54])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 7DD06408F4
 for <kvmarm@lists.cs.columbia.edu>; Tue, 22 Mar 2022 19:58:36 -0400 (EDT)
Received: by mail-lf1-f54.google.com with SMTP id l20so13491lfg.12
 for <kvmarm@lists.cs.columbia.edu>; Tue, 22 Mar 2022 16:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Tlu9SL5J8R6omNurz/8ecWUmBgsP2CZL3lQ7lttJwIo=;
 b=RrfGYgXpjnJ8ez8X6CM7k+LaOf3xmCUxJSQMhdEXy4J5Q+IBIRBCH1wKcXexUWIhlT
 THFZxMbK3Rh9Ak7v5s96Wl/fIrQQocvtsSIRyNDqJzvwdHeVL3bYtldUbd4bDKf1mHEV
 kBB0PwBVITYpyD4qWwUJ7e1ADJlk7b5Z0uvoXGZudW8GwXMJpE79P4tFHsrLK+iYLY6U
 tB5jU3pv7Bu4mjv83RAWnlerAvQmfrRyxVg0GKQtsKMoaqv8lJsQ21+5+nnzyadDL9IE
 iT05UhKXjQfs1p+615uNJigSwoRkmdhO1UafP11DRN3NrO+xo4+AjJnHqBPwG/5CYSp3
 t8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Tlu9SL5J8R6omNurz/8ecWUmBgsP2CZL3lQ7lttJwIo=;
 b=ntbfoBby9gXGh4do+nYDFh390fYSK4XOykEl2blB8jgPLOL3sIBC49db2pxoxFVyF6
 LGW8z6LC0WO/DE8cUDp/67jFxgj5UQLDkI7hG2dmJcrl8BBEe3SBRuthH7Achq+yZK2E
 JxaP2RQw12znJeIrQtB6Yhek5wyIAOxJD+AwsyCZfvVsLMKIEH3x5JpFq2J+HJIFCuvJ
 0vv5EP3vnXztgW61W8pjXvkTJKiRo6cv4DwUVXWNQ7J7mopGQoUub3a2hVdLsl9wgkuN
 8cvjE91+mC/jGu/6HajIvnT66qWjOMz+c0K6BWpK+7pdg0Z0U3u9iUVPA+vu7Dl6yjCZ
 xf6g==
X-Gm-Message-State: AOAM532Il2pDe6bf7aKeDYfo3xbF0bBGdBmGM0GWtc0qCKum/ON4O0ob
 rqAlx3VOEtPddK0Tzi/iY58qhIN0caPQLtuC7h6Pcg==
X-Google-Smtp-Source: ABdhPJzAHjryVgyItrSJbyclkF/PK/xzk6cO8k9gztUg+3u5ufFEp9D+g2GXAVQOphYpNtog59blAdCJnA5c63QCI6o=
X-Received: by 2002:a05:6512:1114:b0:448:388c:b79f with SMTP id
 l20-20020a056512111400b00448388cb79fmr19983100lfg.250.1647993514765; Tue, 22
 Mar 2022 16:58:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220311002528.2230172-1-dmatlack@google.com>
 <20220311002528.2230172-21-dmatlack@google.com>
 <YjG7Zh4zwTDsO3L1@xz-m1.local>
In-Reply-To: <YjG7Zh4zwTDsO3L1@xz-m1.local>
From: David Matlack <dmatlack@google.com>
Date: Tue, 22 Mar 2022 16:58:08 -0700
Message-ID: <CALzav=fRFzbGEVhdMSwhX1Gs1++DGW6MOWvKzeQ-RTtLsus=SQ@mail.gmail.com>
Subject: Re: [PATCH v2 20/26] KVM: x86/mmu: Extend Eager Page Splitting to the
 shadow MMU
To: Peter Xu <peterx@redhat.com>
X-Mailman-Approved-At: Wed, 23 Mar 2022 05:57:13 -0400
Cc: Marc Zyngier <maz@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
 "open list:KERNEL VIRTUAL MACHINE FOR MIPS \(KVM/mips\)"
 <kvm@vger.kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
 "open list:KERNEL VIRTUAL MACHINE FOR MIPS \(KVM/mips\)"
 <linux-mips@vger.kernel.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 "open list:KERNEL VIRTUAL MACHINE FOR RISC-V \(KVM/riscv\)"
 <kvm-riscv@lists.infradead.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Ben Gardon <bgardon@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 "moderated list:KERNEL VIRTUAL MACHINE FOR ARM64 \(KVM/arm64\)"
 <kvmarm@lists.cs.columbia.edu>, Peter Feiner <pfeiner@google.com>
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

(On Wed, Mar 16, 2022 at 3:27 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Fri, Mar 11, 2022 at 12:25:22AM +0000, David Matlack wrote:
> > Extend KVM's eager page splitting to also split huge pages that are
> > mapped by the shadow MMU. Specifically, walk through the rmap splitting
> > all 1GiB pages to 2MiB pages, and splitting all 2MiB pages to 4KiB
> > pages.
> >
> > Splitting huge pages mapped by the shadow MMU requries dealing with some
> > extra complexity beyond that of the TDP MMU:
> >
> > (1) The shadow MMU has a limit on the number of shadow pages that are
> >     allowed to be allocated. So, as a policy, Eager Page Splitting
> >     refuses to split if there are KVM_MIN_FREE_MMU_PAGES or fewer
> >     pages available.
> >
> > (2) Huge pages may be mapped by indirect shadow pages which have the
> >     possibility of being unsync. As a policy we opt not to split such
> >     pages as their translation may no longer be valid.
> >
> > (3) Splitting a huge page may end up re-using an existing lower level
> >     shadow page tables. This is unlike the TDP MMU which always allocates
> >     new shadow page tables when splitting.  This commit does *not*
> >     handle such aliasing and opts not to split such huge pages.
> >
> > (4) When installing the lower level SPTEs, they must be added to the
> >     rmap which may require allocating additional pte_list_desc structs.
> >     This commit does *not* handle such cases and instead opts to leave
> >     such lower-level SPTEs non-present. In this situation TLBs must be
> >     flushed before dropping the MMU lock as a portion of the huge page
> >     region is being unmapped.
> >
> > Suggested-by: Peter Feiner <pfeiner@google.com>
> > [ This commit is based off of the original implementation of Eager Page
> >   Splitting from Peter in Google's kernel from 2016. ]
> > Signed-off-by: David Matlack <dmatlack@google.com>
> > ---
> >  .../admin-guide/kernel-parameters.txt         |   3 -
> >  arch/x86/kvm/mmu/mmu.c                        | 307 ++++++++++++++++++
> >  2 files changed, 307 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 05161afd7642..495f6ac53801 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -2360,9 +2360,6 @@
> >                       the KVM_CLEAR_DIRTY ioctl, and only for the pages being
> >                       cleared.
> >
> > -                     Eager page splitting currently only supports splitting
> > -                     huge pages mapped by the TDP MMU.
> > -
> >                       Default is Y (on).
> >
> >       kvm.enable_vmware_backdoor=[KVM] Support VMware backdoor PV interface.
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index 926ddfaa9e1a..dd56b5b9624f 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -727,6 +727,11 @@ static void mmu_free_memory_caches(struct kvm_vcpu *vcpu)
> >
> >  static struct pte_list_desc *mmu_alloc_pte_list_desc(struct kvm_mmu_memory_cache *cache)
> >  {
> > +     static const gfp_t gfp_nocache = GFP_ATOMIC | __GFP_ACCOUNT | __GFP_ZERO;
> > +
> > +     if (WARN_ON_ONCE(!cache))
> > +             return kmem_cache_alloc(pte_list_desc_cache, gfp_nocache);
> > +
>
> I also think this is not proper to be added into this patch.  Maybe it'll
> be more suitable for the rmap_add() rework patch previously, or maybe it
> can be dropped directly if it should never trigger at all. Then we die hard
> at below when referencing it.

I can drop this, Ben suggested the same. cache should really never be
NULL so there's no need for this backup code.

>
> >       return kvm_mmu_memory_cache_alloc(cache);
> >  }
> >
> > @@ -743,6 +748,28 @@ static gfn_t kvm_mmu_page_get_gfn(struct kvm_mmu_page *sp, int index)
> >       return sp->gfn + (index << ((sp->role.level - 1) * PT64_LEVEL_BITS));
> >  }
> >
> > +static gfn_t sptep_to_gfn(u64 *sptep)
> > +{
> > +     struct kvm_mmu_page *sp = sptep_to_sp(sptep);
> > +
> > +     return kvm_mmu_page_get_gfn(sp, sptep - sp->spt);
> > +}
> > +
> > +static unsigned int kvm_mmu_page_get_access(struct kvm_mmu_page *sp, int index)
> > +{
> > +     if (!sp->role.direct)
> > +             return sp->shadowed_translation[index].access;
> > +
> > +     return sp->role.access;
> > +}
> > +
> > +static unsigned int sptep_to_access(u64 *sptep)
> > +{
> > +     struct kvm_mmu_page *sp = sptep_to_sp(sptep);
> > +
> > +     return kvm_mmu_page_get_access(sp, sptep - sp->spt);
> > +}
> > +
> >  static void kvm_mmu_page_set_gfn_access(struct kvm_mmu_page *sp, int index,
> >                                       gfn_t gfn, u32 access)
> >  {
> > @@ -912,6 +939,9 @@ static int pte_list_add(struct kvm_mmu_memory_cache *cache, u64 *spte,
> >       return count;
> >  }
> >
> > +static struct kvm_rmap_head *gfn_to_rmap(gfn_t gfn, int level,
> > +                                      const struct kvm_memory_slot *slot);
> > +
> >  static void
> >  pte_list_desc_remove_entry(struct kvm_rmap_head *rmap_head,
> >                          struct pte_list_desc *desc, int i,
> > @@ -2125,6 +2155,23 @@ static struct kvm_mmu_page *__kvm_mmu_find_shadow_page(struct kvm *kvm,
> >       return sp;
> >  }
> >
> > +static struct kvm_mmu_page *kvm_mmu_find_direct_sp(struct kvm *kvm, gfn_t gfn,
> > +                                                union kvm_mmu_page_role role)
> > +{
> > +     struct kvm_mmu_page *sp;
> > +     LIST_HEAD(invalid_list);
> > +
> > +     BUG_ON(!role.direct);
> > +
> > +     sp = __kvm_mmu_find_shadow_page(kvm, gfn, role, &invalid_list);
> > +
> > +     /* Direct SPs are never unsync. */
> > +     WARN_ON_ONCE(sp && sp->unsync);
> > +
> > +     kvm_mmu_commit_zap_page(kvm, &invalid_list);
> > +     return sp;
> > +}
> > +
> >  /*
> >   * Looks up an existing SP for the given gfn and role if one exists. The
> >   * return SP is guaranteed to be synced.
> > @@ -6063,12 +6110,266 @@ void kvm_mmu_slot_remove_write_access(struct kvm *kvm,
> >               kvm_arch_flush_remote_tlbs_memslot(kvm, memslot);
> >  }
> >
> > +static int prepare_to_split_huge_page(struct kvm *kvm,
> > +                                   const struct kvm_memory_slot *slot,
> > +                                   u64 *huge_sptep,
> > +                                   struct kvm_mmu_page **spp,
> > +                                   bool *flush,
> > +                                   bool *dropped_lock)
> > +{
> > +     int r = 0;
> > +
> > +     *dropped_lock = false;
> > +
> > +     if (kvm_mmu_available_pages(kvm) <= KVM_MIN_FREE_MMU_PAGES)
> > +             return -ENOSPC;
> > +
> > +     if (need_resched() || rwlock_needbreak(&kvm->mmu_lock))
> > +             goto drop_lock;
> > +
>
> Not immediately clear on whether there'll be case that *spp is set within
> the current function.  Some sanity check might be nice?

Sorry I'm not sure what you mean here. What kind of sanity check did
you have in mind?

>
> > +     *spp = kvm_mmu_alloc_direct_sp_for_split(true);
> > +     if (r)
> > +             goto drop_lock;
> > +
> > +     return 0;
> > +
> > +drop_lock:
> > +     if (*flush)
> > +             kvm_arch_flush_remote_tlbs_memslot(kvm, slot);
> > +
> > +     *flush = false;
> > +     *dropped_lock = true;
> > +
> > +     write_unlock(&kvm->mmu_lock);
> > +     cond_resched();
> > +     *spp = kvm_mmu_alloc_direct_sp_for_split(false);
> > +     if (!*spp)
> > +             r = -ENOMEM;
> > +     write_lock(&kvm->mmu_lock);
> > +
> > +     return r;
> > +}
> > +
> > +static struct kvm_mmu_page *kvm_mmu_get_sp_for_split(struct kvm *kvm,
> > +                                                  const struct kvm_memory_slot *slot,
> > +                                                  u64 *huge_sptep,
> > +                                                  struct kvm_mmu_page **spp)
> > +{
> > +     struct kvm_mmu_page *split_sp;
> > +     union kvm_mmu_page_role role;
> > +     unsigned int access;
> > +     gfn_t gfn;
> > +
> > +     gfn = sptep_to_gfn(huge_sptep);
> > +     access = sptep_to_access(huge_sptep);
> > +
> > +     /*
> > +      * Huge page splitting always uses direct shadow pages since we are
> > +      * directly mapping the huge page GFN region with smaller pages.
> > +      */
> > +     role = kvm_mmu_child_role(huge_sptep, true, access);
> > +     split_sp = kvm_mmu_find_direct_sp(kvm, gfn, role);
> > +
> > +     /*
> > +      * Opt not to split if the lower-level SP already exists. This requires
> > +      * more complex handling as the SP may be already partially filled in
> > +      * and may need extra pte_list_desc structs to update parent_ptes.
> > +      */
> > +     if (split_sp)
> > +             return NULL;
>
> This smells tricky..
>
> Firstly we're trying to lookup the existing SPs that has shadowed this huge
> page in split way, with the access bits fetched from the shadow cache (so
> without hugepage nx effect).

Yeah this is tricky for sure.

For direct shadow pages, sp->role.access is always the guest access
permissions being shadowed (or ACC_ALL for situations where there is
no shadowing, e.g. __direct_map() and the TDP MMU). That's why we use
shadow translation cache to lookup up an existing SP or creating a new
SP, rather than taking the access permissions from the huge SPTE
itself (which may have KVM-specific policies applied such as HugePage
NX, access tracking, etc.). In other words, we want to look up
existing SPs in the same exact way that the fault handler looks them
up.

> However could the pages be mapped with
> different permissions from the currently hugely mapped page?

Yes, I think there can be some differences, such as:

 - The child SPTEs may have execute permission granted due to HugePage
NX while the huge page does not.
 - The child SPTEs may be in a different access tracking state than
the huge page.

There may be others. But no matter what, the same differences are
possible when we split a huge page during a fault, which leads me to
conclude it is safe.

>
> IIUC all these is for the fact that we can't allocate pte_list_desc and we
> want to make sure we won't make the pte list to be >1.
>
> But I also see that the pte_list check below...
>
> > +
> > +     swap(split_sp, *spp);
> > +     init_shadow_page(kvm, split_sp, slot, gfn, role);
> > +     trace_kvm_mmu_get_page(split_sp, true);
> > +
> > +     return split_sp;
> > +}
> > +
> > +static int kvm_mmu_split_huge_page(struct kvm *kvm,
> > +                                const struct kvm_memory_slot *slot,
> > +                                u64 *huge_sptep, struct kvm_mmu_page **spp,
> > +                                bool *flush)
> > +
> > +{
> > +     struct kvm_mmu_page *split_sp;
> > +     u64 huge_spte, split_spte;
> > +     int split_level, index;
> > +     unsigned int access;
> > +     u64 *split_sptep;
> > +     gfn_t split_gfn;
> > +
> > +     split_sp = kvm_mmu_get_sp_for_split(kvm, slot, huge_sptep, spp);
> > +     if (!split_sp)
> > +             return -EOPNOTSUPP;
> > +
> > +     /*
> > +      * Since we did not allocate pte_list_desc_structs for the split, we
> > +      * cannot add a new parent SPTE to parent_ptes. This should never happen
> > +      * in practice though since this is a fresh SP.
> > +      *
> > +      * Note, this makes it safe to pass NULL to __link_shadow_page() below.
> > +      */
> > +     if (WARN_ON_ONCE(split_sp->parent_ptes.val))
> > +             return -EINVAL;
> > +
> > +     huge_spte = READ_ONCE(*huge_sptep);
> > +
> > +     split_level = split_sp->role.level;
> > +     access = split_sp->role.access;
> > +
> > +     for (index = 0; index < PT64_ENT_PER_PAGE; index++) {
> > +             split_sptep = &split_sp->spt[index];
> > +             split_gfn = kvm_mmu_page_get_gfn(split_sp, index);
> > +
> > +             BUG_ON(is_shadow_present_pte(*split_sptep));
> > +
> > +             /*
> > +              * Since we did not allocate pte_list_desc structs for the
> > +              * split, we can't add a new SPTE that maps this GFN.
> > +              * Skipping this SPTE means we're only partially mapping the
> > +              * huge page, which means we'll need to flush TLBs before
> > +              * dropping the MMU lock.
> > +              *
> > +              * Note, this make it safe to pass NULL to __rmap_add() below.
> > +              */
> > +             if (gfn_to_rmap(split_gfn, split_level, slot)->val) {
> > +                     *flush = true;
> > +                     continue;
> > +             }
>
> ... here.
>
> IIUC this check should already be able to cover all the cases and it's
> accurate on the fact that we don't want to grow any rmap to >1 len.
>
> > +
> > +             split_spte = make_huge_page_split_spte(
> > +                             huge_spte, split_level + 1, index, access);
> > +
> > +             mmu_spte_set(split_sptep, split_spte);
> > +             __rmap_add(kvm, NULL, slot, split_sptep, split_gfn, access);
>
> __rmap_add() with a NULL cache pointer is weird.. same as
> __link_shadow_page() below.
>
> I'll stop here for now I guess.. Have you considered having rmap allocation
> ready altogether, rather than making this intermediate step but only add
> that later?  Because all these look hackish to me..  It's also possible
> that I missed something important, if so please shoot.
>
> Thanks,
>
> > +     }
> > +
> > +     /*
> > +      * Replace the huge spte with a pointer to the populated lower level
> > +      * page table. Since we are making this change without a TLB flush vCPUs
> > +      * will see a mix of the split mappings and the original huge mapping,
> > +      * depending on what's currently in their TLB. This is fine from a
> > +      * correctness standpoint since the translation will either be identical
> > +      * or non-present. To account for non-present mappings, the TLB will be
> > +      * flushed prior to dropping the MMU lock.
> > +      */
> > +     __drop_large_spte(kvm, huge_sptep, false);
> > +     __link_shadow_page(NULL, huge_sptep, split_sp);
> > +
> > +     return 0;
> > +}
>
> --
> Peter Xu
>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
