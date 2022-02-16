Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 062E94B8D85
	for <lists+kvmarm@lfdr.de>; Wed, 16 Feb 2022 17:12:24 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A49EA49EED;
	Wed, 16 Feb 2022 11:12:23 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.8
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, URIBL_BLOCKED=0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R4eOlvHlKkwu; Wed, 16 Feb 2022 11:12:23 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 59B2D49DED;
	Wed, 16 Feb 2022 11:12:21 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6B704411C7
 for <kvmarm@lists.cs.columbia.edu>; Wed, 16 Feb 2022 11:12:19 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MDdoZU2gJf6k for <kvmarm@lists.cs.columbia.edu>;
 Wed, 16 Feb 2022 11:12:16 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CFD9A408BA
 for <kvmarm@lists.cs.columbia.edu>; Wed, 16 Feb 2022 11:12:16 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 488D1D6E;
 Wed, 16 Feb 2022 08:12:16 -0800 (PST)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8FA203F70D;
 Wed, 16 Feb 2022 08:12:12 -0800 (PST)
Date: Wed, 16 Feb 2022 16:12:26 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v6 34/64] KVM: arm64: nv: Support multiple nested Stage-2
 mmu structures
Message-ID: <Yg0iN/Ho020rCyg3@monolith.localdoman>
References: <20220128121912.509006-1-maz@kernel.org>
 <20220128121912.509006-35-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220128121912.509006-35-maz@kernel.org>
Cc: kernel-team@android.com, kvm@vger.kernel.org,
 Andre Przywara <andre.przywara@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Chase Conklin <chase.conklin@arm.com>, kvmarm@lists.cs.columbia.edu,
 mihai.carabas@oracle.com,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 "Russell King \(Oracle\)" <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org
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

Hi,

The code looks correct to me. Questions about stuff I don't understand and
nitpicks follow.

On Fri, Jan 28, 2022 at 12:18:42PM +0000, Marc Zyngier wrote:
> Add Stage-2 mmu data structures for virtual EL2 and for nested guests.
> We don't yet populate shadow Stage-2 page tables, but we now have a
> framework for getting to a shadow Stage-2 pgd.
> 
> We allocate twice the number of vcpus as Stage-2 mmu structures because
> that's sufficient for each vcpu running two translation regimes without
> having to flush the Stage-2 page tables.

That still leaves room for interpretation. Why is running two translation
regimes per VCPU the target for the allocation? Is it because it's a nice
number? Is it because KVM only supports two translation regimes per VCPU and
going beyond that will make it impossible to run the VM? Is it because, in
practice, KVM doesn't expect most people to run more than that? Is it because
KVM doesn't recommend or hasn't been tested with running more than that?

> 
> Co-developed-by: Christoffer Dall <christoffer.dall@arm.com>
> Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/include/asm/kvm_host.h   |  29 +++++
>  arch/arm64/include/asm/kvm_mmu.h    |   9 ++
>  arch/arm64/include/asm/kvm_nested.h |   7 +
>  arch/arm64/kvm/arm.c                |  16 ++-
>  arch/arm64/kvm/mmu.c                |  29 +++--
>  arch/arm64/kvm/nested.c             | 195 ++++++++++++++++++++++++++++
>  6 files changed, 275 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index fa253f08e0fd..a15183d0e1bf 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -101,14 +101,43 @@ struct kvm_s2_mmu {
>  	int __percpu *last_vcpu_ran;
>  
>  	struct kvm_arch *arch;
> +
> +	/*
> +	 * For a shadow stage-2 MMU, the virtual vttbr programmed by the guest
> +	 * hypervisor.  Unused for kvm_arch->mmu. Set to 1 when the structure
> +	 * contains no valid information.

I think the comment contradicts itself: 1 is a valid hardware value for
VTTBR_EL2 (VMID = 0, BADDR = 0, CnP = 1), so either this is not the VTTBR
programmed by the guest hypervisor, or treating the value 1 as invalid is
incorrect.

Seeing how this is only used to hold vmid+baddr, maybe it's worth considering
renaming the field to vmid_baddr to avoid confusion about what it means.

> +	 */
> +	u64	vttbr;
> +
> +	/* true when this represents a nested context where virtual HCR_EL2.VM == 1 */
> +	bool	nested_stage2_enabled;
> +
> +	/*
> +	 *  0: Nobody is currently using this, check vttbr for validity
> +	 * >0: Somebody is actively using this.
> +	 */
> +	atomic_t refcnt;
>  };
>  
> +static inline bool kvm_s2_mmu_valid(struct kvm_s2_mmu *mmu)
> +{
> +	return !(mmu->vttbr & 1);
> +}
> +
>  struct kvm_arch_memory_slot {
>  };
>  
>  struct kvm_arch {
>  	struct kvm_s2_mmu mmu;
>  
> +	/*
> +	 * Stage 2 paging stage for VMs with nested virtual using a virtual
                          ^^^^^
Is that correct or was it supposed to say "state"? Also, "[..] VMS with nested
virtual using [..]" sounds wrongs to me.

> +	 * VMID.
> +	 */
> +	struct kvm_s2_mmu *nested_mmus;
> +	size_t nested_mmus_size;
> +	int nested_mmus_next;
> +
>  	/* VTCR_EL2 value for this VM */
>  	u64    vtcr;
>  
> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
> index 1b314b2a69bc..0750d022bbf8 100644
> --- a/arch/arm64/include/asm/kvm_mmu.h
> +++ b/arch/arm64/include/asm/kvm_mmu.h
> @@ -116,6 +116,7 @@ alternative_cb_end
>  #include <asm/cacheflush.h>
>  #include <asm/mmu_context.h>
>  #include <asm/kvm_emulate.h>
> +#include <asm/kvm_nested.h>
>  
>  void kvm_update_va_mask(struct alt_instr *alt,
>  			__le32 *origptr, __le32 *updptr, int nr_inst);
> @@ -161,6 +162,7 @@ int create_hyp_exec_mappings(phys_addr_t phys_addr, size_t size,
>  			     void **haddr);
>  void free_hyp_pgds(void);
>  
> +void kvm_unmap_stage2_range(struct kvm_s2_mmu *mmu, phys_addr_t start, u64 size);
>  void stage2_unmap_vm(struct kvm *kvm);
>  int kvm_init_stage2_mmu(struct kvm *kvm, struct kvm_s2_mmu *mmu);
>  void kvm_free_stage2_pgd(struct kvm_s2_mmu *mmu);
> @@ -296,5 +298,12 @@ static inline struct kvm *kvm_s2_mmu_to_kvm(struct kvm_s2_mmu *mmu)
>  {
>  	return container_of(mmu->arch, struct kvm, arch);
>  }
> +
> +static inline u64 get_vmid(u64 vttbr)
> +{
> +	return (vttbr & VTTBR_VMID_MASK(kvm_get_vmid_bits())) >>
> +		VTTBR_VMID_SHIFT;
> +}
> +
>  #endif /* __ASSEMBLY__ */
>  #endif /* __ARM64_KVM_MMU_H__ */
> diff --git a/arch/arm64/include/asm/kvm_nested.h b/arch/arm64/include/asm/kvm_nested.h
> index 7d398510fd9d..8bb7159f2b6b 100644
> --- a/arch/arm64/include/asm/kvm_nested.h
> +++ b/arch/arm64/include/asm/kvm_nested.h
> @@ -65,6 +65,13 @@ static inline u64 translate_cnthctl_el2_to_cntkctl_el1(u64 cnthctl)
>  		(cnthctl & (CNTHCTL_EVNTI | CNTHCTL_EVNTDIR | CNTHCTL_EVNTEN)));
>  }
>  
> +extern void kvm_init_nested(struct kvm *kvm);
> +extern int kvm_vcpu_init_nested(struct kvm_vcpu *vcpu);
> +extern void kvm_init_nested_s2_mmu(struct kvm_s2_mmu *mmu);
> +extern struct kvm_s2_mmu *lookup_s2_mmu(struct kvm *kvm, u64 vttbr, u64 hcr);
> +extern void kvm_vcpu_load_hw_mmu(struct kvm_vcpu *vcpu);
> +extern void kvm_vcpu_put_hw_mmu(struct kvm_vcpu *vcpu);
> +
>  int handle_wfx_nested(struct kvm_vcpu *vcpu, bool is_wfe);
>  extern bool __forward_traps(struct kvm_vcpu *vcpu, unsigned int reg,
>  			    u64 control_bit);
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 06ca11e90482..14f85f1e15b2 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -37,6 +37,7 @@
>  #include <asm/kvm_arm.h>
>  #include <asm/kvm_asm.h>
>  #include <asm/kvm_mmu.h>
> +#include <asm/kvm_nested.h>
>  #include <asm/kvm_emulate.h>
>  #include <asm/sections.h>
>  
> @@ -146,6 +147,8 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>  	if (ret)
>  		return ret;
>  
> +	kvm_init_nested(kvm);
> +
>  	ret = kvm_share_hyp(kvm, kvm + 1);
>  	if (ret)
>  		goto out_free_stage2_pgd;
> @@ -375,6 +378,9 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
>  	struct kvm_s2_mmu *mmu;
>  	int *last_ran;
>  
> +	if (vcpu_has_nv(vcpu))
> +		kvm_vcpu_load_hw_mmu(vcpu);
> +
>  	mmu = vcpu->arch.hw_mmu;
>  	last_ran = this_cpu_ptr(mmu->last_vcpu_ran);
>  
> @@ -423,6 +429,9 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
>  	kvm_vgic_put(vcpu);
>  	kvm_vcpu_pmu_restore_host(vcpu);
>  
> +	if (vcpu_has_nv(vcpu))
> +		kvm_vcpu_put_hw_mmu(vcpu);
> +
>  	vcpu->cpu = -1;
>  }
>  
> @@ -1122,8 +1131,13 @@ static int kvm_vcpu_set_target(struct kvm_vcpu *vcpu,
>  
>  	vcpu->arch.target = phys_target;
>  
> +	/* Prepare for nested if required */
> +	ret = kvm_vcpu_init_nested(vcpu);
> +
>  	/* Now we know what it is, we can reset it. */
> -	ret = kvm_reset_vcpu(vcpu);
> +	if (!ret)
> +		ret = kvm_reset_vcpu(vcpu);
> +
>  	if (ret) {
>  		vcpu->arch.target = -1;
>  		bitmap_zero(vcpu->arch.features, KVM_VCPU_MAX_FEATURES);
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index bc2aba953299..55525fd5743d 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -162,7 +162,7 @@ static void invalidate_icache_guest_page(void *va, size_t size)
>   * does.
>   */
>  /**
> - * unmap_stage2_range -- Clear stage2 page table entries to unmap a range
> + * __unmap_stage2_range -- Clear stage2 page table entries to unmap a range
>   * @mmu:   The KVM stage-2 MMU pointer
>   * @start: The intermediate physical base address of the range to unmap
>   * @size:  The size of the area to unmap
> @@ -185,7 +185,7 @@ static void __unmap_stage2_range(struct kvm_s2_mmu *mmu, phys_addr_t start, u64
>  				   may_block));
>  }
>  
> -static void unmap_stage2_range(struct kvm_s2_mmu *mmu, phys_addr_t start, u64 size)
> +void kvm_unmap_stage2_range(struct kvm_s2_mmu *mmu, phys_addr_t start, u64 size)
>  {
>  	__unmap_stage2_range(mmu, start, size, true);
>  }
> @@ -628,7 +628,20 @@ int kvm_init_stage2_mmu(struct kvm *kvm, struct kvm_s2_mmu *mmu)
>  	int cpu, err;
>  	struct kvm_pgtable *pgt;
>  
> +	/*
> +	 * If we already have our page tables in place, and that the
> +	 * MMU context is the canonical one, we have a bug somewhere,
> +	 * as this is only supposed to ever happen once per VM.
> +	 *
> +	 * Otherwise, we're building nested page tables, and that's
> +	 * probably because userspace called KVM_ARM_VCPU_INIT more
> +	 * than once on the same vcpu. Since that's actually legal,
> +	 * don't kick a fuss and leave gracefully.
> +	 */
>  	if (mmu->pgt != NULL) {
> +		if (&kvm->arch.mmu != mmu)
> +			return 0;
> +
>  		kvm_err("kvm_arch already initialized?\n");
>  		return -EINVAL;
>  	}
> @@ -654,6 +667,9 @@ int kvm_init_stage2_mmu(struct kvm *kvm, struct kvm_s2_mmu *mmu)
>  	mmu->pgt = pgt;
>  	mmu->pgd_phys = __pa(pgt->pgd);
>  	WRITE_ONCE(mmu->vmid.vmid_gen, 0);
> +
> +	kvm_init_nested_s2_mmu(mmu);

Might make the code self documenting if kvm_init_nested_s2_mmu() was called only
if mmu != &kvm->arch.mmu (we already have a similar check a few lines above).
Again, not a big deal and doesn't affect correctness.

> +
>  	return 0;
>  
>  out_destroy_pgtable:
> @@ -699,7 +715,7 @@ static void stage2_unmap_memslot(struct kvm *kvm,
>  
>  		if (!(vma->vm_flags & VM_PFNMAP)) {
>  			gpa_t gpa = addr + (vm_start - memslot->userspace_addr);
> -			unmap_stage2_range(&kvm->arch.mmu, gpa, vm_end - vm_start);
> +			kvm_unmap_stage2_range(&kvm->arch.mmu, gpa, vm_end - vm_start);
>  		}
>  		hva = vm_end;
>  	} while (hva < reg_end);
> @@ -1681,11 +1697,6 @@ void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen)
>  {
>  }
>  
> -void kvm_arch_flush_shadow_all(struct kvm *kvm)
> -{
> -	kvm_free_stage2_pgd(&kvm->arch.mmu);
> -}
> -
>  void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
>  				   struct kvm_memory_slot *slot)
>  {
> @@ -1693,7 +1704,7 @@ void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
>  	phys_addr_t size = slot->npages << PAGE_SHIFT;
>  
>  	spin_lock(&kvm->mmu_lock);
> -	unmap_stage2_range(&kvm->arch.mmu, gpa, size);
> +	kvm_unmap_stage2_range(&kvm->arch.mmu, gpa, size);
>  	spin_unlock(&kvm->mmu_lock);
>  }
>  
> diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
> index 254152cd791e..bfa2b9229173 100644
> --- a/arch/arm64/kvm/nested.c
> +++ b/arch/arm64/kvm/nested.c
> @@ -7,12 +7,189 @@
>  #include <linux/kvm.h>
>  #include <linux/kvm_host.h>
>  
> +#include <asm/kvm_arm.h>
>  #include <asm/kvm_emulate.h>
> +#include <asm/kvm_mmu.h>
>  #include <asm/kvm_nested.h>
>  #include <asm/sysreg.h>
>  
>  #include "sys_regs.h"
>  
> +void kvm_init_nested(struct kvm *kvm)
> +{
> +	kvm->arch.nested_mmus = NULL;
> +	kvm->arch.nested_mmus_size = 0;
> +}
> +
> +int kvm_vcpu_init_nested(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm *kvm = vcpu->kvm;
> +	struct kvm_s2_mmu *tmp;
> +	int num_mmus;
> +	int ret = -ENOMEM;
> +
> +	if (!test_bit(KVM_ARM_VCPU_HAS_EL2, vcpu->arch.features))
> +		return 0;
> +
> +	if (!cpus_have_final_cap(ARM64_HAS_NESTED_VIRT))
> +		return -EINVAL;
> +
> +	mutex_lock(&kvm->lock);
> +
> +	/*
> +	 * Let's treat memory allocation failures as benign: If we fail to
> +	 * allocate anything, return an error and keep the allocated array
> +	 * alive. Userspace may try to recover by intializing the vcpu
> +	 * again, and there is no reason to affect the whole VM for this.
> +	 */
> +	num_mmus = atomic_read(&kvm->online_vcpus) * 2;
> +	tmp = krealloc(kvm->arch.nested_mmus,
> +		       num_mmus * sizeof(*kvm->arch.nested_mmus),
> +		       GFP_KERNEL_ACCOUNT | __GFP_ZERO);
> +	if (tmp) {
> +		/*
> +		 * If we went through a realocation, adjust the MMU
> +		 * back-pointers in the previously initialised
> +		 * pg_table structures.
> +		 */
> +		if (kvm->arch.nested_mmus != tmp) {
> +			int i;
> +
> +			for (i = 0; i < num_mmus - 2; i++)
> +				tmp[i].pgt->mmu = &tmp[i];
> +		}
> +
> +		if (kvm_init_stage2_mmu(kvm, &tmp[num_mmus - 1]) ||
> +		    kvm_init_stage2_mmu(kvm, &tmp[num_mmus - 2])) {
> +			kvm_free_stage2_pgd(&tmp[num_mmus - 1]);
> +			kvm_free_stage2_pgd(&tmp[num_mmus - 2]);
> +		} else {
> +			kvm->arch.nested_mmus_size = num_mmus;
> +			ret = 0;
> +		}
> +
> +		kvm->arch.nested_mmus = tmp;
> +	}
> +
> +	mutex_unlock(&kvm->lock);
> +	return ret;
> +}
> +
> +/* Must be called with kvm->lock held */
> +struct kvm_s2_mmu *lookup_s2_mmu(struct kvm *kvm, u64 vttbr, u64 hcr)
> +{
> +	bool nested_stage2_enabled = hcr & HCR_VM;
> +	int i;
> +
> +	/* Don't consider the CnP bit for the vttbr match */
> +	vttbr = vttbr & ~VTTBR_CNP_BIT;
> +
> +	/*
> +	 * Two possibilities when looking up a S2 MMU context:
> +	 *
> +	 * - either S2 is enabled in the guest, and we need a context that
> +         *   is S2-enabled and matches the full VTTBR (VMID+BADDR), which
> +         *   makes it safe from a TLB conflict perspective (a broken guest
> +         *   won't be able to generate them),
> +	 *
> +	 * - or S2 is disabled, and we need a context that is S2-disabled
> +         *   and matches the VMID only, as all TLBs are tagged by VMID even
> +         *   if S2 translation is disabled.
> +	 */
> +	for (i = 0; i < kvm->arch.nested_mmus_size; i++) {
> +		struct kvm_s2_mmu *mmu = &kvm->arch.nested_mmus[i];
> +
> +		if (!kvm_s2_mmu_valid(mmu))
> +			continue;
> +
> +		if (nested_stage2_enabled &&
> +		    mmu->nested_stage2_enabled &&
> +		    vttbr == mmu->vttbr)
> +			return mmu;
> +
> +		if (!nested_stage2_enabled &&
> +		    !mmu->nested_stage2_enabled &&
> +		    get_vmid(vttbr) == get_vmid(mmu->vttbr))
> +			return mmu;
> +	}
> +	return NULL;
> +}
> +
> +static struct kvm_s2_mmu *get_s2_mmu_nested(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm *kvm = vcpu->kvm;
> +	u64 vttbr = vcpu_read_sys_reg(vcpu, VTTBR_EL2);
> +	u64 hcr= vcpu_read_sys_reg(vcpu, HCR_EL2);
> +	struct kvm_s2_mmu *s2_mmu;
> +	int i;
> +
> +	s2_mmu = lookup_s2_mmu(kvm, vttbr, hcr);
> +	if (s2_mmu)
> +		goto out;
> +
> +	/*
> +	 * Make sure we don't always search from the same point, or we
> +	 * will always reuse a potentially active context, leaving
> +	 * free contexts unused.
> +	 */
> +	for (i = kvm->arch.nested_mmus_next;
> +	     i < (kvm->arch.nested_mmus_size + kvm->arch.nested_mmus_next);
> +	     i++) {
> +		s2_mmu = &kvm->arch.nested_mmus[i % kvm->arch.nested_mmus_size];
> +
> +		if (atomic_read(&s2_mmu->refcnt) == 0)
> +			break;
> +	}
> +	BUG_ON(atomic_read(&s2_mmu->refcnt)); /* We have struct MMUs to spare */
> +
> +	/* Set the scene for the next search */
> +	kvm->arch.nested_mmus_next = (i + 1) % kvm->arch.nested_mmus_size;
> +
> +	if (kvm_s2_mmu_valid(s2_mmu)) {
> +		/* Clear the old state */
> +		kvm_unmap_stage2_range(s2_mmu, 0, kvm_phys_size(kvm));
> +		if (s2_mmu->vmid.vmid_gen)
> +			kvm_call_hyp(__kvm_tlb_flush_vmid, s2_mmu);
> +	}
> +
> +	/*
> +	 * The virtual VMID (modulo CnP) will be used as a key when matching
> +	 * an existing kvm_s2_mmu.
> +	 */
> +	s2_mmu->vttbr = vttbr & ~VTTBR_CNP_BIT;
> +	s2_mmu->nested_stage2_enabled = hcr & HCR_VM;
> +
> +out:
> +	atomic_inc(&s2_mmu->refcnt);
> +	return s2_mmu;
> +}
> +
> +void kvm_init_nested_s2_mmu(struct kvm_s2_mmu *mmu)
> +{
> +	mmu->vttbr = 1;
> +	mmu->nested_stage2_enabled = false;
> +	atomic_set(&mmu->refcnt, 0);
> +}
> +
> +void kvm_vcpu_load_hw_mmu(struct kvm_vcpu *vcpu)
> +{
> +	if (is_hyp_ctxt(vcpu)) {
> +		vcpu->arch.hw_mmu = &vcpu->kvm->arch.mmu;
> +	} else {
> +		spin_lock(&vcpu->kvm->mmu_lock);
> +		vcpu->arch.hw_mmu = get_s2_mmu_nested(vcpu);
> +		spin_unlock(&vcpu->kvm->mmu_lock);
> +	}
> +}
> +
> +void kvm_vcpu_put_hw_mmu(struct kvm_vcpu *vcpu)
> +{
> +	if (vcpu->arch.hw_mmu != &vcpu->kvm->arch.mmu) {
> +		atomic_dec(&vcpu->arch.hw_mmu->refcnt);
> +		vcpu->arch.hw_mmu = NULL;
> +	}
> +}
> +
>  /*
>   * Inject wfx to the virtual EL2 if this is not from the virtual EL2 and
>   * the virtual HCR_EL2.TWX is set. Otherwise, let the host hypervisor
> @@ -31,6 +208,24 @@ int handle_wfx_nested(struct kvm_vcpu *vcpu, bool is_wfe)
>  	return -EINVAL;
>  }
>  
> +void kvm_arch_flush_shadow_all(struct kvm *kvm)
> +{
> +	int i;
> +
> +	for (i = 0; i < kvm->arch.nested_mmus_size; i++) {
> +		struct kvm_s2_mmu *mmu = &kvm->arch.nested_mmus[i];
> +
> +		WARN_ON(atomic_read(&mmu->refcnt));
> +
> +		if (!atomic_read(&mmu->refcnt))
> +			kvm_free_stage2_pgd(mmu);
> +	}
> +	kfree(kvm->arch.nested_mmus);
> +	kvm->arch.nested_mmus = NULL;
> +	kvm->arch.nested_mmus_size = 0;
> +	kvm_free_stage2_pgd(&kvm->arch.mmu);
> +}
> +

The code above looks good.

Thanks,
Alex

>  /*
>   * Our emulated CPU doesn't support all the possible features. For the
>   * sake of simplicity (and probably mental sanity), wipe out a number
> -- 
> 2.30.2
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
