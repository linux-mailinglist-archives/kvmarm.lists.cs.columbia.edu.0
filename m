Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0594B4EE80A
	for <lists+kvmarm@lfdr.de>; Fri,  1 Apr 2022 08:07:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 333944B250;
	Fri,  1 Apr 2022 02:07:45 -0400 (EDT)
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
	with ESMTP id jgIzl4Suj3ma; Fri,  1 Apr 2022 02:07:45 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AD7704B24D;
	Fri,  1 Apr 2022 02:07:43 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 649D74B0CE
 for <kvmarm@lists.cs.columbia.edu>; Fri,  1 Apr 2022 02:07:42 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y8Mplud6MQhE for <kvmarm@lists.cs.columbia.edu>;
 Fri,  1 Apr 2022 02:07:41 -0400 (EDT)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id EAD114B0BF
 for <kvmarm@lists.cs.columbia.edu>; Fri,  1 Apr 2022 02:07:40 -0400 (EDT)
Received: by mail-pf1-f171.google.com with SMTP id u22so1697620pfg.6
 for <kvmarm@lists.cs.columbia.edu>; Thu, 31 Mar 2022 23:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JC975jqGdiLRLhWjnwwn/6ecRehq409qPW+iVF2xd1A=;
 b=Cn4SuP2ca6r1NvKtXXPRoUEL+NpQqYzl2WXGXhPBqZmFTd4aDLo6oshsvmx/E8ItQZ
 KgFUZYCZ1GdN3k3FCagDQ+SiUpQNqtT1YuHL60bRBy/3DFiRGWTAF20RsEfRo/rE0Qcn
 8vHciwB9PPjPUBwjm/Tl/HhPo0ekFTQvwbv/OtS6sqhrwI30CUsKWeJUzuiY2FRpOHUq
 +npbZ0WY82jZE4HNfuRlpIsHts171WnpaHi1bQjxjXxUilAARNgYt0bbOakMibco81/J
 kw78FT74e3FTseHvBfswUdxNp7Zj65/cawrkc7BF7vp8Oppfwm98gdvPb7qmWh6Hah5j
 o4vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JC975jqGdiLRLhWjnwwn/6ecRehq409qPW+iVF2xd1A=;
 b=11yUkV0rcN3a8HTPTJ98iZ7mMZGVOB6+KPJ5GG7yG6K21oMHzJyzFw6xSR7gp2wcL/
 V/TXNb9xY9TNg+68HUFGbazkLGJBt6hmR1RfBuVl8Bk39vYwRAn/CN5BF2nGQmyngg+Q
 PR2haybLPMdFj13KwEWitIBeL+rfs8vMDogq8uof9yKWBA4En8E3UcfOqn5FEsSrf6y8
 FI1MijoBFNe9eexbfPWxScy2RyNMfsaD+Vv/pI57nfsj3MEQQw9nm+XGPQFn3jVdx3Dm
 VAI21LHVuPR5tRGEQ1RqO4BoJD6L1phCC5f0AxhMIStjaGelQPg/HYi/7nffk9/tdcva
 UN6g==
X-Gm-Message-State: AOAM530WD9v1yFj/jFw7Rj85xutdjltRts91mv62IHACYxb60cEsIXYC
 ObWU/a4VevPPUmZ6y7e37tfHAbNC0d5+oYd9Hf6Qkg==
X-Google-Smtp-Source: ABdhPJxtC47RWhR5tlIkYa+YMgaqWV7aGtq2N7PoQ5wJ7w4vThHNlFMC920zTOZSLcC8suY21Q9WU24t6iJG/5le+po=
X-Received: by 2002:a05:6a00:179f:b0:4fa:ecc3:a6ea with SMTP id
 s31-20020a056a00179f00b004faecc3a6eamr9306828pfg.82.1648793259671; Thu, 31
 Mar 2022 23:07:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220331213844.2894006-1-oupton@google.com>
In-Reply-To: <20220331213844.2894006-1-oupton@google.com>
From: Reiji Watanabe <reijiw@google.com>
Date: Thu, 31 Mar 2022 23:07:23 -0700
Message-ID: <CAAeT=FzmvwmXoxn41xqYJByNgGMwCRViCUP9yZ0cun13nJ43PQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: arm64: Don't split hugepages outside of MMU write
 lock
To: Oliver Upton <oupton@google.com>
Cc: kvm@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Peter Shier <pshier@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
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

Hi Oliver,

On Thu, Mar 31, 2022 at 2:38 PM Oliver Upton <oupton@google.com> wrote:
>
> It is possible to take a stage-2 permission fault on a page larger than
> PAGE_SIZE. For example, when running a guest backed by 2M HugeTLB, KVM
> eagerly maps at the largest possible block size. When dirty logging is
> enabled on a memslot, KVM does *not* eagerly split these 2M stage-2
> mappings and instead clears the write bit on the pte.
>
> Since dirty logging is always performed at PAGE_SIZE granularity, KVM
> lazily splits these 2M block mappings down to PAGE_SIZE in the stage-2
> fault handler. This operation must be done under the write lock. Since
> commit f783ef1c0e82 ("KVM: arm64: Add fast path to handle permission
> relaxation during dirty logging"), the stage-2 fault handler
> conditionally takes the read lock on permission faults with dirty
> logging enabled. To that end, it is possible to split a 2M block mapping
> while only holding the read lock.
>
> The problem is demonstrated by running kvm_page_table_test with 2M
> anonymous HugeTLB, which splats like so:
>
>   WARNING: CPU: 5 PID: 15276 at arch/arm64/kvm/hyp/pgtable.c:153 stage2_map_walk_leaf+0x124/0x158
>
>   [...]
>
>   Call trace:
>   stage2_map_walk_leaf+0x124/0x158
>   stage2_map_walker+0x5c/0xf0
>   __kvm_pgtable_walk+0x100/0x1d4
>   __kvm_pgtable_walk+0x140/0x1d4
>   __kvm_pgtable_walk+0x140/0x1d4
>   kvm_pgtable_walk+0xa0/0xf8
>   kvm_pgtable_stage2_map+0x15c/0x198
>   user_mem_abort+0x56c/0x838
>   kvm_handle_guest_abort+0x1fc/0x2a4
>   handle_exit+0xa4/0x120
>   kvm_arch_vcpu_ioctl_run+0x200/0x448
>   kvm_vcpu_ioctl+0x588/0x664
>   __arm64_sys_ioctl+0x9c/0xd4
>   invoke_syscall+0x4c/0x144
>   el0_svc_common+0xc4/0x190
>   do_el0_svc+0x30/0x8c
>   el0_svc+0x28/0xcc
>   el0t_64_sync_handler+0x84/0xe4
>   el0t_64_sync+0x1a4/0x1a8
>
> Fix the issue by only acquiring the read lock if the guest faulted on a
> PAGE_SIZE granule w/ dirty logging enabled. Since it is possible for the
> faulting IPA to get collapsed into a larger block mapping until the read
> lock is acquired, retry the faulting instruction any time that the fault
> cannot be fixed by relaxing permissions. In so doing, the fault handler
> will acquire the write lock for the subsequent fault on a larger
> PAGE_SIZE mapping and split the block safely behind the write lock.
>
> Fixes: f783ef1c0e82 ("KVM: arm64: Add fast path to handle permission relaxation during dirty logging")
> Cc: Jing Zhang <jingzhangos@google.com>
> Signed-off-by: Oliver Upton <oupton@google.com>
> ---
>
> Applies cleanly to kvmarm/fixes at the following commit:
>
>   8872d9b3e35a ("KVM: arm64: Drop unneeded minor version check from PSCI v1.x handler")
>
> Tested the patch by running KVM selftests. Additionally, I did 10
> iterations of the kvm_page_table_test with 2M anon HugeTLB memory.
>
> It is expected that this patch will cause fault serialization in the
> pathological case where all vCPUs are faulting on the same granule of
> memory, as every vCPU will attempt to acquire the write lock. The only
> safe way to cure this contention is to dissolve pages eagerly outside of
> the stage-2 fault handler (like x86).
>
>  arch/arm64/kvm/mmu.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 0d19259454d8..9384325bf3df 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -1079,7 +1079,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>         gfn_t gfn;
>         kvm_pfn_t pfn;
>         bool logging_active = memslot_is_logging(memslot);
> -       bool logging_perm_fault = false;
> +       bool use_read_lock = false;
>         unsigned long fault_level = kvm_vcpu_trap_get_fault_level(vcpu);
>         unsigned long vma_pagesize, fault_granule;
>         enum kvm_pgtable_prot prot = KVM_PGTABLE_PROT_R;
> @@ -1114,7 +1114,8 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>         if (logging_active) {
>                 force_pte = true;
>                 vma_shift = PAGE_SHIFT;
> -               logging_perm_fault = (fault_status == FSC_PERM && write_fault);
> +               use_read_lock = (fault_status == FSC_PERM && write_fault &&
> +                                fault_granule == PAGE_SIZE);
>         } else {
>                 vma_shift = get_vma_page_shift(vma, hva);
>         }
> @@ -1218,7 +1219,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>          * logging dirty logging, only acquire read lock for permission
>          * relaxation.
>          */
> -       if (logging_perm_fault)
> +       if (use_read_lock)
>                 read_lock(&kvm->mmu_lock);
>         else
>                 write_lock(&kvm->mmu_lock);
> @@ -1267,10 +1268,24 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>          */
>         if (fault_status == FSC_PERM && vma_pagesize == fault_granule) {
>                 ret = kvm_pgtable_stage2_relax_perms(pgt, fault_ipa, prot);

When use_read_lock is set to true, it appears the above condition will
become always true (since fault_granule is PAGE_SIZE and force_pte
is true in this case).  So, I don't think the following "else" changes
really make any difference.  (Or am I overlooking something?)
Looking at the code, I doubt that even the original (before the regression)
code detects the case that is described in the comment below in the
first place.

Thanks,
Reiji

> -       } else {
> +       } else if (!use_read_lock) {
>                 ret = kvm_pgtable_stage2_map(pgt, fault_ipa, vma_pagesize,
>                                              __pfn_to_phys(pfn), prot,
>                                              memcache);
> +
> +       /*
> +        * The read lock is taken if the FSC indicates that the guest faulted on
> +        * a PAGE_SIZE granule. It is possible that the stage-2 fault raced with
> +        * a map operation that collapsed the faulted address into a larger
> +        * block mapping.
> +        *
> +        * Since KVM splits mappings down to PAGE_SIZE when dirty logging is
> +        * enabled, it is necessary to hold the write lock for faults where
> +        * fault_granule > PAGE_SIZE. Retry the faulting instruction and acquire
> +        * the write lock on the next exit.
> +        */
> +       } else {
> +               ret = -EAGAIN;
>         }
>
>         /* Mark the page dirty only if the fault is handled successfully */
> @@ -1280,7 +1295,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>         }
>
>  out_unlock:
> -       if (logging_perm_fault)
> +       if (use_read_lock)
>                 read_unlock(&kvm->mmu_lock);
>         else
>                 write_unlock(&kvm->mmu_lock);
> --
> 2.35.1.1094.g7c7d902a7c-goog
>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
