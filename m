Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4A13311F72E
	for <lists+kvmarm@lfdr.de>; Sun, 15 Dec 2019 11:28:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7F6604A5A6;
	Sun, 15 Dec 2019 05:28:18 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 1.82
X-Spam-Level: *
X-Spam-Status: No, score=1.82 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, MISSING_HEADERS=1.021]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Tuq0AC16m-yd; Sun, 15 Dec 2019 05:28:18 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2294D4A51F;
	Sun, 15 Dec 2019 05:28:17 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id AD0D54A521
 for <kvmarm@lists.cs.columbia.edu>; Sun, 15 Dec 2019 05:28:15 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZT+l77Z9u+qq for <kvmarm@lists.cs.columbia.edu>;
 Sun, 15 Dec 2019 05:28:14 -0500 (EST)
Received: from inca-roads.misterjones.org (inca-roads.misterjones.org
 [213.251.177.50])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 360AA4A51F
 for <kvmarm@lists.cs.columbia.edu>; Sun, 15 Dec 2019 05:28:14 -0500 (EST)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why)
 by cheepnis.misterjones.org with esmtpsa (TLSv1.2:AES256-GCM-SHA384:256)
 (Exim 4.80) (envelope-from <maz@kernel.org>)
 id 1igR7x-0007eF-3A; Sun, 15 Dec 2019 11:27:53 +0100
Date: Sun, 15 Dec 2019 10:27:51 +0000
From: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 1/7] KVM: Pass mmu_notifier_range down to
 kvm_unmap_hva_range()
Message-ID: <20191215102751.197b7d81@why>
In-Reply-To: <20191213182503.14460-2-maz@kernel.org>
References: <20191213182503.14460-1-maz@kernel.org>
 <20191213182503.14460-2-maz@kernel.org>
Organization: Approximate
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: kvm-ppc@vger.kernel.org, wanpengli@tencent.com,
 kvm@vger.kernel.org, jhogan@kernel.org, joro@8bytes.org,
 linux-mips@vger.kernel.org, sean.j.christopherson@intel.com, paulus@ozlabs.org,
 linux-arm-kernel@lists.infradead.org, pbonzini@redhat.com, vkuznets@redhat.com,
 kvmarm@lists.cs.columbia.edu, jmattson@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org);
 SAEximRunCond expanded to false
Cc: Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
 James Hogan <jhogan@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 linux-mips@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@ozlabs.org>,
 Sean Christopherson <sean.j.christopherson@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 Jim Mattson <jmattson@google.com>
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

On Fri, 13 Dec 2019 18:24:57 +0000
Marc Zyngier <maz@kernel.org> wrote:

> kvm_unmap_hva_range() is currently passed both start and end
> fields from the mmu_notifier_range structure. As this struct
> now contains important information about the reason of the
> unmap (the event field), replace the start/end parameters
> with the range struct, and update all architectures.
> 
> No functionnal change.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm/include/asm/kvm_host.h     | 2 +-
>  arch/arm64/include/asm/kvm_host.h   | 2 +-
>  arch/mips/include/asm/kvm_host.h    | 2 +-
>  arch/mips/kvm/mmu.c                 | 6 ++++--
>  arch/powerpc/include/asm/kvm_host.h | 2 +-
>  arch/powerpc/kvm/book3s.c           | 5 +++--
>  arch/powerpc/kvm/e500_mmu_host.c    | 4 ++--
>  arch/x86/include/asm/kvm_host.h     | 3 ++-
>  arch/x86/kvm/mmu/mmu.c              | 5 +++--
>  arch/x86/kvm/x86.c                  | 4 ++--
>  include/linux/kvm_host.h            | 2 +-
>  virt/kvm/arm/mmu.c                  | 8 ++++----
>  virt/kvm/kvm_main.c                 | 7 +++----
>  13 files changed, 28 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
> index 556cd818eccf..621c71594499 100644
> --- a/arch/arm/include/asm/kvm_host.h
> +++ b/arch/arm/include/asm/kvm_host.h
> @@ -276,7 +276,7 @@ int __kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
>  
>  #define KVM_ARCH_WANT_MMU_NOTIFIER
>  int kvm_unmap_hva_range(struct kvm *kvm,
> -			unsigned long start, unsigned long end);
> +			const struct mmu_notifier_range *range);
>  int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
>  
>  unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu);
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index c61260cf63c5..dd850f5e81e3 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -441,7 +441,7 @@ int __kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
>  
>  #define KVM_ARCH_WANT_MMU_NOTIFIER
>  int kvm_unmap_hva_range(struct kvm *kvm,
> -			unsigned long start, unsigned long end);
> +			const struct mmu_notifier_range *range);
>  int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
>  int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end);
>  int kvm_test_age_hva(struct kvm *kvm, unsigned long hva);
> diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
> index 41204a49cf95..0ed065870f1b 100644
> --- a/arch/mips/include/asm/kvm_host.h
> +++ b/arch/mips/include/asm/kvm_host.h
> @@ -935,7 +935,7 @@ enum kvm_mips_fault_result kvm_trap_emul_gva_fault(struct kvm_vcpu *vcpu,
>  
>  #define KVM_ARCH_WANT_MMU_NOTIFIER
>  int kvm_unmap_hva_range(struct kvm *kvm,
> -			unsigned long start, unsigned long end);
> +			const struct mmu_notifier_range *range);
>  int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
>  int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end);
>  int kvm_test_age_hva(struct kvm *kvm, unsigned long hva);
> diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
> index 7dad7a293eae..32ef868258b9 100644
> --- a/arch/mips/kvm/mmu.c
> +++ b/arch/mips/kvm/mmu.c
> @@ -518,9 +518,11 @@ static int kvm_unmap_hva_handler(struct kvm *kvm, gfn_t gfn, gfn_t gfn_end,
>  	return 1;
>  }
>  
> -int kvm_unmap_hva_range(struct kvm *kvm, unsigned long start, unsigned long end)
> +int kvm_unmap_hva_range(struct kvm *kvm,
> +			const struct mmu_notifier_range *range)
>  {
> -	handle_hva_to_gpa(kvm, start, end, &kvm_unmap_hva_handler, NULL);
> +	handle_hva_to_gpa(kvm, range->start, range->end,
> +			  &kvm_unmap_hva_handler, NULL);
>  
>  	kvm_mips_callbacks->flush_shadow_all(kvm);
>  	return 0;
> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
> index 0a398f2321c2..8cef585e0abe 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -58,7 +58,7 @@
>  #define KVM_ARCH_WANT_MMU_NOTIFIER
>  
>  extern int kvm_unmap_hva_range(struct kvm *kvm,
> -			       unsigned long start, unsigned long end);
> +			       const struct mmu_notifier_range *range);
>  extern int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end);
>  extern int kvm_test_age_hva(struct kvm *kvm, unsigned long hva);
>  extern int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
> diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
> index 58a59ee998e2..a1529a0dd656 100644
> --- a/arch/powerpc/kvm/book3s.c
> +++ b/arch/powerpc/kvm/book3s.c
> @@ -842,9 +842,10 @@ void kvmppc_core_commit_memory_region(struct kvm *kvm,
>  	kvm->arch.kvm_ops->commit_memory_region(kvm, mem, old, new, change);
>  }
>  
> -int kvm_unmap_hva_range(struct kvm *kvm, unsigned long start, unsigned long end)
> +int kvm_unmap_hva_range(struct kvm *kvm,
> +			const struct mmu_notifier_range *range)
>  {
> -	return kvm->arch.kvm_ops->unmap_hva_range(kvm, start, end);
> +	return kvm->arch.kvm_ops->unmap_hva_range(kvm, range->start, range->end);
>  }
>  
>  int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end)
> diff --git a/arch/powerpc/kvm/e500_mmu_host.c b/arch/powerpc/kvm/e500_mmu_host.c
> index 425d13806645..5a7211901063 100644
> --- a/arch/powerpc/kvm/e500_mmu_host.c
> +++ b/arch/powerpc/kvm/e500_mmu_host.c
> @@ -734,10 +734,10 @@ static int kvm_unmap_hva(struct kvm *kvm, unsigned long hva)
>  	return 0;
>  }
>  
> -int kvm_unmap_hva_range(struct kvm *kvm, unsigned long start, unsigned long end)
> +int kvm_unmap_hva_range(struct kvm *kvm, const struct mmu_notifier_range *range)
>  {
>  	/* kvm_unmap_hva flushes everything anyways */
> -	kvm_unmap_hva(kvm, start);
> +	kvm_unmap_hva(kvm, range->start);
>  
>  	return 0;
>  }
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index b79cd6aa4075..c479fa845d72 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1569,7 +1569,8 @@ asmlinkage void kvm_spurious_fault(void);
>  	_ASM_EXTABLE(666b, 667b)
>  
>  #define KVM_ARCH_WANT_MMU_NOTIFIER
> -int kvm_unmap_hva_range(struct kvm *kvm, unsigned long start, unsigned long end);
> +int kvm_unmap_hva_range(struct kvm *kvm,
> +			const struct mmu_notifier_range *range);
>  int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end);
>  int kvm_test_age_hva(struct kvm *kvm, unsigned long hva);
>  int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 6f92b40d798c..86831be07c17 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -2040,9 +2040,10 @@ static int kvm_handle_hva(struct kvm *kvm, unsigned long hva,
>  	return kvm_handle_hva_range(kvm, hva, hva + 1, data, handler);
>  }
>  
> -int kvm_unmap_hva_range(struct kvm *kvm, unsigned long start, unsigned long end)
> +int kvm_unmap_hva_range(struct kvm *kvm,
> +			const struct mmu_notifier_range *range);
>  {
> -	return kvm_handle_hva_range(kvm, start, end, 0, kvm_unmap_rmapp);
> +	return kvm_handle_hva_range(kvm, range->start, range->end, 0, kvm_unmap_rmapp);
>  }

As kindly pointed out by the kbuild robot, this doesn't even compile...
I've fixed it locally, incorporating Suzuki's feedback at the same time.

	M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
