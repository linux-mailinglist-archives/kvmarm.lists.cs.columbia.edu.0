Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 95FC254FD35
	for <lists+kvmarm@lfdr.de>; Fri, 17 Jun 2022 21:08:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B407E4B35C;
	Fri, 17 Jun 2022 15:08:19 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.788
X-Spam-Level: 
X-Spam-Status: No, score=-1.788 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sPrv4KFKAwEN; Fri, 17 Jun 2022 15:08:19 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 628FF4B368;
	Fri, 17 Jun 2022 15:08:18 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 99F294B355
 for <kvmarm@lists.cs.columbia.edu>; Fri, 17 Jun 2022 15:08:16 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n341xLbPVDjU for <kvmarm@lists.cs.columbia.edu>;
 Fri, 17 Jun 2022 15:08:15 -0400 (EDT)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 4EDD44B2B7
 for <kvmarm@lists.cs.columbia.edu>; Fri, 17 Jun 2022 15:08:15 -0400 (EDT)
Received: by mail-pl1-f172.google.com with SMTP id d13so4605163plh.13
 for <kvmarm@lists.cs.columbia.edu>; Fri, 17 Jun 2022 12:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=uB0b6hpqrvA0NdvpqDc3+KG+jsoq75SGLCiJdjbvtUI=;
 b=LoSF6QNFPJGjJTaTHvNbHyNPmHL6mkmmGl4VDFClefMiTEuKP/kmXoogD6l3T6x7c3
 m5mYJslmTE3eioEdI+iiZQIM61aZ3kDYVVvLYNxG3DNwxo/jof6o292jKrUuqnSIA58c
 iA89c8LI1mJi/nwuqymE7uuaRROqgZVH4VUa8CXSRZG9fp0Wnt078P2gCaFJzD4VA5Qv
 KiwG8FM77FoYiebg4awvCexTN/JkHeRrCHZXPZgbw3BKE2lv9N7bBmQ8lGlsW37wYicJ
 ybevYz44sZ8YDv5BYbK5ROoYd5qEoUN6zxqM2iZiTtrahQtXNfM/BDPJHEeRTf5ScTjm
 fCdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=uB0b6hpqrvA0NdvpqDc3+KG+jsoq75SGLCiJdjbvtUI=;
 b=wJczIkBtUUlr/LFMvGh7cVjOKN0LnNriqhiRKySHe7oLWxDoJWtRgWPPOteh+1uyID
 Z138jISptfXu1e7eUDf80nz1HtMrH+F/2oQvc/78RWDihC3S0ASRXX4yZmB1Xu9uqv9p
 OS1q16FRF0dtjCJnDvi5u9+i+iTBAuwyhyPMjOCr/HUg5tdAph2BCRmLsPzTgJlRBXUJ
 ub8tq1mThLRk8jwNJ+nVuQjbMvFR4Er+dem0MkYgx7YD5ahu65jbuFUA9U1lKUsHI6Tq
 5kMERQ3k+1whOvagTwMPqJw7rYAeVZnsvUjkP385xtAKBnLEMfL9CgjRxbuQ4xS9h7hP
 jBbA==
X-Gm-Message-State: AJIora9QaPaR1Sb+deuiEPTbm9TkFV9VX2dFgMRXsV7yPkx7ghy5aK5+
 aM5W2+OyP4KybYtdhxUNb27lmA==
X-Google-Smtp-Source: AGRyM1uytD8pUpVZ6ppSLJmy5+UzgSrMMv7h6mTrdxzsII3ZerEb3Vt+CJ3Bfqc0irgqXuQ63oiVlg==
X-Received: by 2002:a17:90a:5309:b0:1ec:82a1:3b86 with SMTP id
 x9-20020a17090a530900b001ec82a13b86mr1640696pjh.54.1655492894120; 
 Fri, 17 Jun 2022 12:08:14 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com.
 [35.230.65.123]) by smtp.gmail.com with ESMTPSA id
 y10-20020a170902d64a00b0015e8d4eb2c5sm3894250plh.271.2022.06.17.12.08.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jun 2022 12:08:13 -0700 (PDT)
Date: Fri, 17 Jun 2022 19:08:10 +0000
From: Sean Christopherson <seanjc@google.com>
To: David Matlack <dmatlack@google.com>
Subject: Re: [PATCH v6 22/22] KVM: x86/mmu: Extend Eager Page Splitting to
 nested MMUs
Message-ID: <YqzRGj6ryBZfGBSl@google.com>
References: <20220516232138.1783324-1-dmatlack@google.com>
 <20220516232138.1783324-23-dmatlack@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220516232138.1783324-23-dmatlack@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
 "open list:KERNEL VIRTUAL MACHINE FOR MIPS \(KVM/mips\)"
 <kvm@vger.kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 "open list:KERNEL VIRTUAL MACHINE FOR MIPS \(KVM/mips\)"
 <linux-mips@vger.kernel.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 "open list:KERNEL VIRTUAL MACHINE FOR RISC-V \(KVM/riscv\)"
 <kvm-riscv@lists.infradead.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Ben Gardon <bgardon@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 maciej.szmigiero@oracle.com,
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

On Mon, May 16, 2022, David Matlack wrote:
> +	/*
> +	 * Memory cache used to allocate pte_list_desc structs while splitting
> +	 * huge pages. In the worst case, to split one huge page, 512
> +	 * pte_list_desc structs are needed to add each lower level leaf sptep
> +	 * to the rmap plus 1 to extend the parent_ptes rmap of the lower level
> +	 * page table.
> +	 *
> +	 * Protected by kvm->slots_lock.
> +	 */
> +#define SPLIT_DESC_CACHE_CAPACITY 513

I would strongly prefer to programmaticaly define this (note that SPTE_ENT_PER_PAGE
doesn't yet exist in kvm/queue, but hopefully will by the time you rebase; it's
PT64_ENT_PER_PAGE at the moment).  And I think we should define the min number of
objects separately from the capacity (see below).

	/*
	 * Memory cache used to allocate pte_list_desc structs while splitting
	 * huge pages.  In the worst case, to split one huge page, a struct will
	 * be needed to rmap every possible new child SPTE, plus one to extend
	 * the parent_ptes rmap of the newly create page table.
	 */
#define SPLIT_DESC_CACHE_MIN_NR_OBJECTS (SPTE_ENT_PER_PAGE + 1)

> +	struct kvm_mmu_memory_cache split_desc_cache;
>  };
>  

...

> +static int topup_split_caches(struct kvm *kvm)
> +{
> +     int r;
> +
> +     lockdep_assert_held(&kvm->slots_lock);
> +
> +     r = __kvm_mmu_topup_memory_cache(&kvm->arch.split_desc_cache,
> +                                      SPLIT_DESC_CACHE_CAPACITY,
> +                                      SPLIT_DESC_CACHE_CAPACITY);

min==capacity will be inefficient as consuming just one object from the cache
will force KVM to drop mmu_lock and topup the cache.

2*min seems like the logical choice.  Presumably it's common to need all 513
objects when splitting a page, so that at least lets KVM handle two huge pages
without having to drop mmu_lock.

> +     if (r)
> +             return r;
> +
> +     r = kvm_mmu_topup_memory_cache(&kvm->arch.split_page_header_cache, 1);
> +     if (r)
> +             return r;
> +
> +     return kvm_mmu_topup_memory_cache(&kvm->arch.split_shadow_page_cache, 1);
> +}

...

> @@ -6097,15 +6106,252 @@ void kvm_mmu_slot_remove_write_access(struct kvm *kvm,
>  		kvm_arch_flush_remote_tlbs_memslot(kvm, memslot);
>  }
>  
> +void free_split_caches(struct kvm *kvm)

This should be prefixed with kvm_mmu_, and since it's short, make it more explicit:

void kvm_mmu_free_eager_page_split_caches(struct kvm *kvm)

> +{
> +	lockdep_assert_held(&kvm->slots_lock);
> +
> +	kvm_mmu_free_memory_cache(&kvm->arch.split_desc_cache);
> +	kvm_mmu_free_memory_cache(&kvm->arch.split_page_header_cache);
> +	kvm_mmu_free_memory_cache(&kvm->arch.split_shadow_page_cache);
> +}
> +

...

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 04812eaaf61b..4fe018ddd1cd 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -12197,6 +12197,12 @@ static void kvm_mmu_slot_apply_flags(struct kvm *kvm,
>  		 * page faults will create the large-page sptes.
>  		 */
>  		kvm_mmu_zap_collapsible_sptes(kvm, new);
> +
> +		/*
> +		 * Free any memory left behind by eager page splitting. Ignore
> +		 * the module parameter since userspace might have changed it.
> +		 */
> +		free_split_caches(kvm);

Freeing the caches only in kvm_mmu_slot_apply_flags() will leak memory, and the
kmem_cache code will yell about objects being in the cache when the global caches
are destroyed by mmu_destroy_caches().  When KVM destroys a VM, it directly frees
the memslots without updating struct kvm_memslots; see kvm_free_memslot().

kvm_mmu_uninit_vm() is probably the best landing spot even though it's called
before memslots are freed.  The VM is unreachable so nothing can be triggerring
page splitting.

All that said, I don't know that I agree that kvm_mmu_slot_apply_flags() is the
right place to free the caches.  I agree that _most_ use cases will toggle dirty
logging on all memslots, but I don't know that that holds true for _all_ use
cases as dirty logging is used for things other than live migration.

Even if we expand the capacity of the pte_list_desc cache (see below), at worst,
it's still less than 16kb of memory per VM, i.e. quite small.  And if the host is
under memory pressure, KVM really should purge the caches in mmu_shrink_scan().

I know we proposed dropping mmu_shrink_scan(), but the more I think about that,
the more I think that an outright drop is wrong.  The real issue is that KVM as
quite literally the dumbest possible "algorithm" for zapping possibly-in-use
shadow pages, and doesn't target the zapping to fit the cgroup that's under
pressure.

So for this, IMO rather than assume that freeing the caches when any memslot
disables dirty logging, I think it makes sense to initially keep the caches and
only free them at VM destruction.  Then in follow-up patches, if we want, free
the caches in the mmu_shrink_scan(), and/or add a function hook for toggling
eager_page_split to topup/free the caches accordingly.  That gives userspace
explicit control over when the caches are purged, and does the logical thing of
freeing the caches when eager_page_split is disabled.

>  	} else {
>  		/*
>  		 * Initially-all-set does not require write protecting any page,
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index f94f72bbd2d3..17fc9247504d 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -1336,6 +1336,7 @@ void kvm_flush_remote_tlbs(struct kvm *kvm);
>  
>  #ifdef KVM_ARCH_NR_OBJS_PER_MEMORY_CACHE
>  int kvm_mmu_topup_memory_cache(struct kvm_mmu_memory_cache *mc, int min);
> +int __kvm_mmu_topup_memory_cache(struct kvm_mmu_memory_cache *mc, int capacity, int min);
>  int kvm_mmu_memory_cache_nr_free_objects(struct kvm_mmu_memory_cache *mc);
>  void kvm_mmu_free_memory_cache(struct kvm_mmu_memory_cache *mc);
>  void *kvm_mmu_memory_cache_alloc(struct kvm_mmu_memory_cache *mc);
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 5e2e75014256..b9573e958a03 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -369,7 +369,7 @@ static inline void *mmu_memory_cache_alloc_obj(struct kvm_mmu_memory_cache *mc,
>  		return (void *)__get_free_page(gfp_flags);
>  }
>  
> -static int __kvm_mmu_topup_memory_cache(struct kvm_mmu_memory_cache *mc, int capacity, int min)
> +int __kvm_mmu_topup_memory_cache(struct kvm_mmu_memory_cache *mc, int capacity, int min)

+1 to Ricardo's feedback, expose this function in patch 21.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
