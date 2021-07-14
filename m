Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 227CB3C890C
	for <lists+kvmarm@lfdr.de>; Wed, 14 Jul 2021 18:53:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 90FF14B09A;
	Wed, 14 Jul 2021 12:53:38 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id akgQLu5BqJMF; Wed, 14 Jul 2021 12:53:38 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3E3AF4A4E1;
	Wed, 14 Jul 2021 12:53:36 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 57D804099E
 for <kvmarm@lists.cs.columbia.edu>; Wed, 14 Jul 2021 12:42:22 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OOAQYuBU824W for <kvmarm@lists.cs.columbia.edu>;
 Wed, 14 Jul 2021 12:42:20 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 02F964083E
 for <kvmarm@lists.cs.columbia.edu>; Wed, 14 Jul 2021 12:42:19 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C9F0D6E;
 Wed, 14 Jul 2021 09:42:19 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.119.32.116])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D1DAB3F7D8;
 Wed, 14 Jul 2021 09:42:18 -0700 (PDT)
From: Chase Conklin <chase.conklin@arm.com>
To: maz@kernel.org
Subject: Re: [PATCH v4 41/66] KVM: arm64: nv: Trap and emulate TLBI
 instructions from virtual EL2
Date: Wed, 14 Jul 2021 11:40:03 -0500
Message-Id: <20210714164002.84527-1-chase.conklin@arm.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210510165920.1913477-42-maz@kernel.org>
References: <20210510165920.1913477-42-maz@kernel.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 14 Jul 2021 12:53:34 -0400
Cc: kernel-team@android.com, kvm@vger.kernel.org, andre.przywara@arm.com,
 kvmarm@lists.cs.columbia.edu, jintack.lim@linaro.org,
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

On Mon, 10 May 2021 17:58:55 +0100, Marc Zyngier <maz@kernel.org> wrote:
> When supporting nested virtualization a guest hypervisor executing TLBI
> instructions must be trapped and emulated by the host hypervisor,
> because the guest hypervisor can only affect physical TLB entries
> relating to its own execution environment (virtual EL2 in EL1) but not
> to the nested guests as required by the semantics of the instructions
> and TLBI instructions might also result in updates (invalidations) to
> shadow page tables.
>
> This patch does several things.
>
> 1. List and define all TLBI system instructions to emulate.
>
> 2. Emulate TLBI ALLE2(IS) instruction executed in the virtual EL2. Since
> we emulate the virtual EL2 in the EL1, we invalidate EL1&0 regime stage
> 1 TLB entries with setting vttbr_el2 having the VMID of the virtual EL2.
>
> 3. Emulate TLBI VAE2* instruction executed in the virtual EL2. Based on the
> same principle as TLBI ALLE2 instruction, we can simply emulate those
> instructions by executing corresponding VAE1* instructions with the
> virtual EL2's VMID assigned by the host hypervisor.
>
> Note that we are able to emulate TLBI ALLE2IS precisely by only
> invalidating stage 1 TLB entries via TLBI VMALL1IS instruction, but to
> make it simeple, we reuse the existing function, __kvm_tlb_flush_vmid(),
> which invalidates both of stage 1 and 2 TLB entries.
>
> 4. TLBI ALLE1(IS) instruction invalidates all EL1&0 regime stage 1 and 2
> TLB entries (on all PEs in the same Inner Shareable domain). To emulate
> these instructions, we first need to clear all the mappings in the
> shadow page tables since executing those instructions implies the change
> of mappings in the stage 2 page tables maintained by the guest
> hypervisor.  We then need to invalidate all EL1&0 regime stage 1 and 2
> TLB entries of all VMIDs, which are assigned by the host hypervisor, for
> this VM.
>
> 5. Based on the same principle as TLBI ALLE1(IS) emulation, we clear the
> mappings in the shadow stage-2 page tables and invalidate TLB entries.
> But this time we do it only for the current VMID from the guest
> hypervisor's perspective, not for all VMIDs.
>
> 6. Based on the same principle as TLBI ALLE1(IS) and TLBI VMALLS12E1(IS)
> emulation, we clear the mappings in the shadow stage-2 page tables and
> invalidate TLB entries. We do it only for one mapping for the current
> VMID from the guest hypervisor's view.
>
> 7. Forward system instruction traps to the virtual EL2 if a
> corresponding bit in the virtual HCR_EL2 is set.
>
> 8. Even though a guest hypervisor can execute TLBI instructions that are
> accesible at EL1 without trap, it's wrong; All those TLBI instructions
> work based on current VMID, and when running a guest hypervisor current
> VMID is the one for itself, not the one from the virtual vttbr_el2. So
> letting a guest hypervisor execute those TLBI instructions results in
> invalidating its own TLB entries and leaving invalid TLB entries
> unhandled.
>
> Therefore we trap and emulate those TLBI instructions. The emulation is
> simple; we find a shadow VMID mapped to the virtual vttbr_el2, set it in
> the physical vttbr_el2, then execute the same instruction in EL2.
>
> We don't set HCR_EL2.TTLB bit yet.
>
>   [ Changes performed by Marc Zynger:
>
>     The TLBI handling code more or less directly execute the same
>     instruction that has been trapped (with an EL2->EL1 conversion
>     in the case of an EL2 TLBI), but that's unfortunately not enough:
>
>     - TLBIs must be upgraded to the Inner Shareable domain to account
>       for vcpu migration, just like we already have with HCR_EL2.FB.
>
>     - The DSB instruction that synchronises these must thus be on
>       the Inner Shareable domain as well.
>
>     - Prior to executing the TLBI, we need another DSB ISHST to make
>       sure that the update to the page tables is now visible.
>
>       Ordering of system instructions fixed
>
>     - The current TLB invalidation code is pretty buggy, as it assume a
>       page mapping. On the contrary, it is likely that TLB invalidation
>       will cover more than a single page, and the size should be decided
>       by the guests configuration (and not the host's).
>
>       Since we don't cache the guest mapping sizes in the shadow PT yet,
>       let's assume the worse case (a block mapping) and invalidate that.
>
>       Take this opportunity to fix the decoding of the parameter (it
>       isn't a straight IPA).
>
>     - In general, we always emulate local TBL invalidations as being
>       as upgraded to the Inner Shareable domain so that we can easily
>       deal with vcpu migration. This is consistent with the fact that
>       we set HCR_EL2.FB when running non-nested VMs.
>
>       So let's emulate TLBI ALLE2 as ALLE2IS.
>   ]
>
>   [ Changes performed by Christoffer Dall:
>
>     Sometimes when we are invalidating the TLB for a certain S2 MMU
>     context, this context can also have EL2 context associated with it
>     and we have to invalidate this too.
>   ]
>
> Signed-off-by: Jintack Lim <jintack.lim@linaro.org>
> Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/include/asm/kvm_asm.h |   2 +
>  arch/arm64/include/asm/sysreg.h  |  36 ++++++
>  arch/arm64/kvm/hyp/vhe/switch.c  |   8 +-
>  arch/arm64/kvm/hyp/vhe/tlb.c     |  81 ++++++++++++
>  arch/arm64/kvm/mmu.c             |  18 ++-
>  arch/arm64/kvm/sys_regs.c        | 212 +++++++++++++++++++++++++++++++
>  6 files changed, 352 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> index c61d52c51e43..22cab61ed15c 100644
> --- a/arch/arm64/include/asm/kvm_asm.h
> +++ b/arch/arm64/include/asm/kvm_asm.h
> @@ -196,6 +196,8 @@ extern void __kvm_flush_cpu_context(struct kvm_s2_mmu *mmu);
>  extern void __kvm_tlb_flush_vmid_ipa(struct kvm_s2_mmu *mmu, phys_addr_t ipa,
>  				     int level);
>  extern void __kvm_tlb_flush_vmid(struct kvm_s2_mmu *mmu);
> +extern void __kvm_tlb_vae2is(struct kvm_s2_mmu *mmu, u64 va, u64 sys_encoding);
> +extern void __kvm_tlb_el1_instr(struct kvm_s2_mmu *mmu, u64 val, u64 sys_encoding);
>
>  extern void __kvm_timer_set_cntvoff(u64 cntvoff);
>  extern void __kvm_at_s1e01(struct kvm_vcpu *vcpu, u32 op, u64 vaddr);
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 625c040e4f72..d5724eccfc5d 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -668,6 +668,42 @@
>  #define OP_AT_S12E0R	sys_insn(AT_Op0, 4, AT_CRn, 8, 6)
>  #define OP_AT_S12E0W	sys_insn(AT_Op0, 4, AT_CRn, 8, 7)
>
> +/* TLBI instructions */
> +#define TLBI_Op0	1
> +#define TLBI_Op1_EL1	0	/* Accessible from EL1 or higher */
> +#define TLBI_Op1_EL2	4	/* Accessible from EL2 or higher */
> +#define TLBI_CRn	8
> +#define tlbi_insn_el1(CRm, Op2)	sys_insn(TLBI_Op0, TLBI_Op1_EL1, TLBI_CRn, (CRm), (Op2))
> +#define tlbi_insn_el2(CRm, Op2)	sys_insn(TLBI_Op0, TLBI_Op1_EL2, TLBI_CRn, (CRm), (Op2))
> +
> +#define OP_TLBI_VMALLE1IS	tlbi_insn_el1(3, 0)
> +#define OP_TLBI_VAE1IS		tlbi_insn_el1(3, 1)
> +#define OP_TLBI_ASIDE1IS	tlbi_insn_el1(3, 2)
> +#define OP_TLBI_VAAE1IS		tlbi_insn_el1(3, 3)
> +#define OP_TLBI_VALE1IS		tlbi_insn_el1(3, 5)
> +#define OP_TLBI_VAALE1IS	tlbi_insn_el1(3, 7)
> +#define OP_TLBI_VMALLE1		tlbi_insn_el1(7, 0)
> +#define OP_TLBI_VAE1		tlbi_insn_el1(7, 1)
> +#define OP_TLBI_ASIDE1		tlbi_insn_el1(7, 2)
> +#define OP_TLBI_VAAE1		tlbi_insn_el1(7, 3)
> +#define OP_TLBI_VALE1		tlbi_insn_el1(7, 5)
> +#define OP_TLBI_VAALE1		tlbi_insn_el1(7, 7)
> +
> +#define OP_TLBI_IPAS2E1IS	tlbi_insn_el2(0, 1)
> +#define OP_TLBI_IPAS2LE1IS	tlbi_insn_el2(0, 5)
> +#define OP_TLBI_ALLE2IS		tlbi_insn_el2(3, 0)
> +#define OP_TLBI_VAE2IS		tlbi_insn_el2(3, 1)
> +#define OP_TLBI_ALLE1IS		tlbi_insn_el2(3, 4)
> +#define OP_TLBI_VALE2IS		tlbi_insn_el2(3, 5)
> +#define OP_TLBI_VMALLS12E1IS	tlbi_insn_el2(3, 6)
> +#define OP_TLBI_IPAS2E1		tlbi_insn_el2(4, 1)
> +#define OP_TLBI_IPAS2LE1	tlbi_insn_el2(4, 5)
> +#define OP_TLBI_ALLE2		tlbi_insn_el2(7, 0)
> +#define OP_TLBI_VAE2		tlbi_insn_el2(7, 1)
> +#define OP_TLBI_ALLE1		tlbi_insn_el2(7, 4)
> +#define OP_TLBI_VALE2		tlbi_insn_el2(7, 5)
> +#define OP_TLBI_VMALLS12E1	tlbi_insn_el2(7, 6)
> +
>  /* Common SCTLR_ELx flags. */
>  #define SCTLR_ELx_DSSBS	(BIT(44))
>  #define SCTLR_ELx_ATA	(BIT(43))
> diff --git a/arch/arm64/kvm/hyp/vhe/switch.c b/arch/arm64/kvm/hyp/vhe/switch.c
> index 7715b8254a76..b53de6863972 100644
> --- a/arch/arm64/kvm/hyp/vhe/switch.c
> +++ b/arch/arm64/kvm/hyp/vhe/switch.c
> @@ -46,7 +46,7 @@ static void __activate_traps(struct kvm_vcpu *vcpu)
>  			 * the EL1 virtual memory control register accesses
>  			 * as well as the AT S1 operations.
>  			 */
> -			hcr |= HCR_TVM | HCR_TRVM | HCR_AT | HCR_NV1;
> +			hcr |= HCR_TVM | HCR_TRVM | HCR_AT | HCR_TTLB | HCR_NV1;
>  		} else {
>  			/*
>  			 * For a guest hypervisor on v8.1 (VHE), allow to
> @@ -72,11 +72,11 @@ static void __activate_traps(struct kvm_vcpu *vcpu)
>
>  			/*
>  			 * If we're using the EL1 translation regime
> -			 * (TGE clear), then ensure that AT S1 ops are
> -			 * trapped too.
> +			 * (TGE clear), then ensure that AT S1 and
> +			 * TLBI E1 ops are trapped too.
>  			 */
>  			if (!vcpu_el2_tge_is_set(vcpu))
> -				hcr |= HCR_AT;
> +				hcr |= HCR_AT | HCR_TTLB;
>  		}
>  	}
>
> diff --git a/arch/arm64/kvm/hyp/vhe/tlb.c b/arch/arm64/kvm/hyp/vhe/tlb.c
> index 66f17349f0c3..001ac9f2f1b5 100644
> --- a/arch/arm64/kvm/hyp/vhe/tlb.c
> +++ b/arch/arm64/kvm/hyp/vhe/tlb.c
> @@ -161,3 +161,84 @@ void __kvm_flush_vm_context(void)
>
>  	dsb(ish);
>  }
> +
> +void __kvm_tlb_vae2is(struct kvm_s2_mmu *mmu, u64 va, u64 sys_encoding)
> +{
> +	struct tlb_inv_context cxt;
> +
> +	dsb(ishst);
> +
> +	/* Switch to requested VMID */
> +	__tlb_switch_to_guest(mmu, &cxt);
> +
> +	/*
> +	 * Execute the EL1 version of TLBI VAE2* instruction, forcing
> +	 * an upgrade to the Inner Shareable domain in order to
> +	 * perform the invalidation on all CPUs.
> +	 */
> +	switch (sys_encoding) {
> +	case OP_TLBI_VAE2:
> +	case OP_TLBI_VAE2IS:
> +		__tlbi(vae1is, va);
> +		break;
> +	case OP_TLBI_VALE2:
> +	case OP_TLBI_VALE2IS:
> +		__tlbi(vale1is, va);
> +		break;
> +	default:
> +		break;
> +	}
> +	dsb(ish);
> +	isb();
> +
> +	__tlb_switch_to_host(&cxt);
> +}
> +
> +void __kvm_tlb_el1_instr(struct kvm_s2_mmu *mmu, u64 val, u64 sys_encoding)
> +{
> +	struct tlb_inv_context cxt;
> +
> +	dsb(ishst);
> +
> +	/* Switch to requested VMID */
> +	__tlb_switch_to_guest(mmu, &cxt);
> +
> +	/*
> +	 * Execute the same instruction as the guest hypervisor did,
> +	 * expanding the scope of local TLB invalidations to the Inner
> +	 * Shareable domain so that it takes place on all CPUs. This
> +	 * is equivalent to having HCR_EL2.FB set.
> +	 */
> +	switch (sys_encoding) {
> +	case OP_TLBI_VMALLE1:
> +	case OP_TLBI_VMALLE1IS:
> +		__tlbi(vmalle1is);
> +		break;
> +	case OP_TLBI_VAE1:
> +	case OP_TLBI_VAE1IS:
> +		__tlbi(vae1is, val);
> +		break;
> +	case OP_TLBI_ASIDE1:
> +	case OP_TLBI_ASIDE1IS:
> +		__tlbi(aside1is, val);
> +		break;
> +	case OP_TLBI_VAAE1:
> +	case OP_TLBI_VAAE1IS:
> +		__tlbi(vaae1is, val);
> +		break;
> +	case OP_TLBI_VALE1:
> +	case OP_TLBI_VALE1IS:
> +		__tlbi(vale1is, val);
> +		break;
> +	case OP_TLBI_VAALE1:
> +	case OP_TLBI_VAALE1IS:
> +		__tlbi(vaale1is, val);
> +		break;
> +	default:
> +		break;
> +	}
> +	dsb(ish);
> +	isb();
> +
> +	__tlb_switch_to_host(&cxt);
> +}
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index fddcbe200573..91cadd8ed57e 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -80,7 +80,23 @@ static bool memslot_is_logging(struct kvm_memory_slot *memslot)
>   */
>  void kvm_flush_remote_tlbs(struct kvm *kvm)
>  {
> -	kvm_call_hyp(__kvm_tlb_flush_vmid, &kvm->arch.mmu);
> +	struct kvm_s2_mmu *mmu = &kvm->arch.mmu;
> +
> +	if (mmu == &kvm->arch.mmu) {
> +		/*
> +		 * For a normal (i.e. non-nested) guest, flush entries for the
> +		 * given VMID *
> +		 */
> +		kvm_call_hyp(__kvm_tlb_flush_vmid, mmu);
> +	} else {
> +		/*
> +		 * When supporting nested virtualization, we can have multiple
> +		 * VMIDs in play for each VCPU in the VM, so it's really not
> +		 * worth it to try to quiesce the system and flush all the
> +		 * VMIDs that may be in use, instead just nuke the whole thing.
> +		 */
> +		kvm_call_hyp(__kvm_flush_vm_context);
> +	}
>  }
>
>  static bool kvm_is_device_pfn(unsigned long pfn)
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 9d9108e9fcf7..01df2c16c23b 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -1630,6 +1630,11 @@ static bool forward_at_traps(struct kvm_vcpu *vcpu)
>  	return forward_traps(vcpu, HCR_AT);
>  }
>
> +static bool forward_ttlb_traps(struct kvm_vcpu *vcpu)
> +{
> +	return forward_traps(vcpu, HCR_TTLB);
> +}
> +
>  static bool access_elr(struct kvm_vcpu *vcpu,
>  		       struct sys_reg_params *p,
>  		       const struct sys_reg_desc *r)
> @@ -2268,6 +2273,185 @@ static bool handle_s12w(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
>  	return handle_s12(vcpu, p, r, true);
>  }
>
> +static bool handle_alle2is(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
> +			   const struct sys_reg_desc *r)
> +{
> +	/*
> +	 * To emulate invalidating all EL2 regime stage 1 TLB entries for all
> +	 * PEs, executing TLBI VMALLE1IS is enough. But reuse the existing
> +	 * interface for the simplicity; invalidating stage 2 entries doesn't
> +	 * affect the correctness.
> +	 */
> +	__kvm_tlb_flush_vmid(&vcpu->kvm->arch.mmu);
> +	return true;
> +}
> +
> +static bool handle_vae2is(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
> +			  const struct sys_reg_desc *r)
> +{
> +	int sys_encoding = sys_insn(p->Op0, p->Op1, p->CRn, p->CRm, p->Op2);
> +
> +	/*
> +	 * Based on the same principle as TLBI ALLE2 instruction
> +	 * emulation, we emulate TLBI VAE2* instructions by executing
> +	 * corresponding TLBI VAE1* instructions with the virtual
> +	 * EL2's VMID assigned by the host hypervisor.
> +	 */
> +	__kvm_tlb_vae2is(&vcpu->kvm->arch.mmu, p->regval, sys_encoding);
> +	return true;
> +}
> +
> +static bool handle_alle1is(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
> +			   const struct sys_reg_desc *r)
> +{
> +	struct kvm_s2_mmu *mmu = &vcpu->kvm->arch.mmu;
> +	spin_lock(&vcpu->kvm->mmu_lock);
> +
> +	/*
> +	 * Clear all mappings in the shadow page tables and invalidate the stage
> +	 * 1 and 2 TLB entries via kvm_tlb_flush_vmid_ipa().
> +	 */
> +	kvm_nested_s2_clear(vcpu->kvm);
> +
> +	if (mmu->vmid.vmid_gen) {
> +		/*
> +		 * Invalidate the stage 1 and 2 TLB entries for the host OS
> +		 * in a VM only if there is one.
> +		 */
> +		__kvm_tlb_flush_vmid(mmu);
> +	}
> +
> +	spin_unlock(&vcpu->kvm->mmu_lock);
> +
> +	return true;
> +}
> +
> +static bool handle_vmalls12e1is(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
> +				const struct sys_reg_desc *r)
> +{
> +	u64 vttbr = vcpu_read_sys_reg(vcpu, VTTBR_EL2);
> +	struct kvm_s2_mmu *mmu;
> +
> +	spin_lock(&vcpu->kvm->mmu_lock);
> +
> +	mmu = lookup_s2_mmu(vcpu->kvm, vttbr, HCR_VM);
> +	if (mmu)
> +		kvm_unmap_stage2_range(mmu, 0, kvm_phys_size(vcpu->kvm));
> +
> +	mmu = lookup_s2_mmu(vcpu->kvm, vttbr, 0);
> +	if (mmu)
> +		kvm_unmap_stage2_range(mmu, 0, kvm_phys_size(vcpu->kvm));
> +
> +	spin_unlock(&vcpu->kvm->mmu_lock);
> +
> +	return true;
> +}
> +
> +static bool handle_ipas2e1is(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
> +			     const struct sys_reg_desc *r)
> +{
> +	u64 vttbr = vcpu_read_sys_reg(vcpu, VTTBR_EL2);
> +	u64 vtcr = vcpu_read_sys_reg(vcpu, VTCR_EL2);
> +	struct kvm_s2_mmu *mmu;
> +	u64 base_addr;
> +	int max_size;
> +
> +	/*
> +	 * We drop a number of things from the supplied value:
> +	 *
> +	 * - NS bit: we're non-secure only.
> +	 *
> +	 * - TTL field: We already have the granule size from the
> +	 *   VTCR_EL2.TG0 field, and the level is only relevant to the
> +	 *   guest's S2PT.
> +	 *
> +	 * - IPA[51:48]: We don't support 52bit IPA just yet...
> +	 *
> +	 * And of course, adjust the IPA to be on an actual address.
> +	 */
> +	base_addr = (p->regval & GENMASK_ULL(35, 0)) << 12;
> +
> +	/* Compute the maximum extent of the invalidation */
> +	switch ((vtcr & VTCR_EL2_TG0_MASK)) {
> +	case VTCR_EL2_TG0_4K:
> +		max_size = SZ_1G;
> +		break;
> +	case VTCR_EL2_TG0_16K:
> +		max_size = SZ_32M;
> +		break;
> +	case VTCR_EL2_TG0_64K:
> +		/*
> +		 * No, we do not support 52bit IPA in nested yet. Once
> +		 * we do, this should be 4TB.
> +		 */
> +		/* FIXME: remove the 52bit PA support from the IDregs */
> +		max_size = SZ_512M;
> +		break;
> +	default:
> +		BUG();
> +	}
> +
> +	spin_lock(&vcpu->kvm->mmu_lock);
> +
> +	mmu = lookup_s2_mmu(vcpu->kvm, vttbr, HCR_VM);
> +	if (mmu)
> +		kvm_unmap_stage2_range(mmu, base_addr, max_size);

Hi Marc,

I'm noticing a hang while an L2 is booting. From what I can tell, the
L0 is issuing TLBIs to the wrong VMID, so the L2 is getting stuck
taking the same abort repeatedly.

It seems that kvm_unmap_stage2_range doesn't perform the invalidations
using the mmu passed to it here. Instead, it uses the passed mmu to
get back the kvm before passing that to stage2_apply_range which gets
its mmu from kvm->arch.mmu. This has the effect of applying
invalidations intended for the nested stage-2 of the L2 onto the
stage-2 for the L1.

It also turns out that for the L2, the mmu != mmu->pgt->mmu. This is
because pgt->mmu is always set to &kvm->arch.mmu by
kvm_pgtable_stage2_init_flags. This too will cause the VMID for the
TLBI to be incorrect because the stage2_unmap_walker gets its mmu from
the pgt passed to it.

From what I can tell, neither of these will cause a hang if the TLBs
don't cache permission faults. If the TLBs behave this way, the I
believe the flow looks like

1.  L2 takes a stage-2 permission fault
2.  L0 forwards the fault to L1
3.  L1 fixes the permissions in the PTE and issues TLBIs
4.  L0 incorrectly emulates the TLBIs, both by not clearing the entry
    in the shadow tables and by executing its TLBIs using L1's VMID
5.  L1 ERETs to L2, emulated by L0
6.  L2 takes permission fault (again). Had the emulation in #4 cleared
    and TLBI'd the shadow entry, this would have been a translation
    fault
7.  L0 walks L1's stage-2 tables for L2 and determines that there is
    no nested fault (because L1 fixed its stage-2 tables in #3)
8.  Because L0 thinks it's responsible for the fault, it fixes the
    fault in L2's stage-2 tables and issues TLBI using L1's VMID
9.  L0 ERETs to L2
10. L2 doesn't take a permission fault (entry not cached in TLBs) and
    makes forward progress

If the TLBs do cache permission faults, instead of the L2 making
progress in #10, it instead traps back to L0, which attempts to fix
the permission fault, issues a TLBI with the L1's VMID, and ERETs back
to the L2, which traps to the L0 again.

I attempted working around this by passing the mmu through
kvm_stage2_apply_range and kvm_pgtable_stage2_init_flags.
Unfortunately, that doesn't work for kvm_pgtable_stage2_init_flags
because the mmu may change addresses (making pgd->mmu point to
garbage) when the nested mmus are reallocated in kvm_vcpu_init_nested.

Do you have an idea of how to work around this? I'm happy to share my
busted workaround if that helps.

Thanks,
Chase

> +
> +	mmu = lookup_s2_mmu(vcpu->kvm, vttbr, 0);
> +	if (mmu)
> +		kvm_unmap_stage2_range(mmu, base_addr, max_size);
> +
> +	spin_unlock(&vcpu->kvm->mmu_lock);
> +
> +	return true;
> +}
> +
> +static bool handle_tlbi_el1(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
> +			    const struct sys_reg_desc *r)
> +{
> +	u32 sys_encoding = sys_insn(p->Op0, p->Op1, p->CRn, p->CRm, p->Op2);
> +
> +	/*
> +	 * If we're here, this is because we've trapped on a EL1 TLBI
> +	 * instruction that affects the EL1 translation regime while
> +	 * we're running in a context that doesn't allow us to let the
> +	 * HW do its thing (aka vEL2):
> +	 *
> +	 * - HCR_EL2.E2H == 0 : a non-VHE guest
> +	 * - HCR_EL2.{E2H,TGE} == { 1, 0 } : a VHE guest in guest mode
> +	 *
> +	 * We don't expect these helpers to ever be called when running
> +	 * in a vEL1 context.
> +	 */
> +
> +	WARN_ON(!vcpu_mode_el2(vcpu));
> +
> +	mutex_lock(&vcpu->kvm->lock);
> +
> +	if ((__vcpu_sys_reg(vcpu, HCR_EL2) & (HCR_E2H | HCR_TGE)) != (HCR_E2H | HCR_TGE)) {
> +		u64 virtual_vttbr = vcpu_read_sys_reg(vcpu, VTTBR_EL2);
> +		struct kvm_s2_mmu *mmu;
> +
> +		mmu = lookup_s2_mmu(vcpu->kvm, virtual_vttbr, HCR_VM);
> +		if (mmu)
> +			__kvm_tlb_el1_instr(mmu, p->regval, sys_encoding);
> +
> +		mmu = lookup_s2_mmu(vcpu->kvm, virtual_vttbr, 0);
> +		if (mmu)
> +			__kvm_tlb_el1_instr(mmu, p->regval, sys_encoding);
> +	} else {
> +		/*
> +		 * ARMv8.4-NV allows the guest to change TGE behind
> +		 * our back, so we always trap EL1 TLBIs from vEL2...
> +		 */
> +		__kvm_tlb_el1_instr(&vcpu->kvm->arch.mmu, p->regval, sys_encoding);
> +	}
> +
> +	mutex_unlock(&vcpu->kvm->lock);
> +
> +	return true;
> +}
> +
>  /*
>   * AT instruction emulation
>   *
> @@ -2350,12 +2534,40 @@ static struct sys_reg_desc sys_insn_descs[] = {
>  	{ SYS_DESC(SYS_DC_CSW), access_dcsw },
>  	{ SYS_DESC(SYS_DC_CISW), access_dcsw },
>
> +	SYS_INSN_TO_DESC(TLBI_VMALLE1IS, handle_tlbi_el1, forward_ttlb_traps),
> +	SYS_INSN_TO_DESC(TLBI_VAE1IS, handle_tlbi_el1, forward_ttlb_traps),
> +	SYS_INSN_TO_DESC(TLBI_ASIDE1IS, handle_tlbi_el1, forward_ttlb_traps),
> +	SYS_INSN_TO_DESC(TLBI_VAAE1IS, handle_tlbi_el1, forward_ttlb_traps),
> +	SYS_INSN_TO_DESC(TLBI_VALE1IS, handle_tlbi_el1, forward_ttlb_traps),
> +	SYS_INSN_TO_DESC(TLBI_VAALE1IS, handle_tlbi_el1, forward_ttlb_traps),
> +	SYS_INSN_TO_DESC(TLBI_VMALLE1, handle_tlbi_el1, forward_ttlb_traps),
> +	SYS_INSN_TO_DESC(TLBI_VAE1, handle_tlbi_el1, forward_ttlb_traps),
> +	SYS_INSN_TO_DESC(TLBI_ASIDE1, handle_tlbi_el1, forward_ttlb_traps),
> +	SYS_INSN_TO_DESC(TLBI_VAAE1, handle_tlbi_el1, forward_ttlb_traps),
> +	SYS_INSN_TO_DESC(TLBI_VALE1, handle_tlbi_el1, forward_ttlb_traps),
> +	SYS_INSN_TO_DESC(TLBI_VAALE1, handle_tlbi_el1, forward_ttlb_traps),
> +
>  	SYS_INSN_TO_DESC(AT_S1E2R, handle_s1e2, forward_nv_traps),
>  	SYS_INSN_TO_DESC(AT_S1E2W, handle_s1e2, forward_nv_traps),
>  	SYS_INSN_TO_DESC(AT_S12E1R, handle_s12r, forward_nv_traps),
>  	SYS_INSN_TO_DESC(AT_S12E1W, handle_s12w, forward_nv_traps),
>  	SYS_INSN_TO_DESC(AT_S12E0R, handle_s12r, forward_nv_traps),
>  	SYS_INSN_TO_DESC(AT_S12E0W, handle_s12w, forward_nv_traps),
> +
> +	SYS_INSN_TO_DESC(TLBI_IPAS2E1IS, handle_ipas2e1is, forward_nv_traps),
> +	SYS_INSN_TO_DESC(TLBI_IPAS2LE1IS, handle_ipas2e1is, forward_nv_traps),
> +	SYS_INSN_TO_DESC(TLBI_ALLE2IS, handle_alle2is, forward_nv_traps),
> +	SYS_INSN_TO_DESC(TLBI_VAE2IS, handle_vae2is, forward_nv_traps),
> +	SYS_INSN_TO_DESC(TLBI_ALLE1IS, handle_alle1is, forward_nv_traps),
> +	SYS_INSN_TO_DESC(TLBI_VALE2IS, handle_vae2is, forward_nv_traps),
> +	SYS_INSN_TO_DESC(TLBI_VMALLS12E1IS, handle_vmalls12e1is, forward_nv_traps),
> +	SYS_INSN_TO_DESC(TLBI_IPAS2E1, handle_ipas2e1is, forward_nv_traps),
> +	SYS_INSN_TO_DESC(TLBI_IPAS2LE1, handle_ipas2e1is, forward_nv_traps),
> +	SYS_INSN_TO_DESC(TLBI_ALLE2, handle_alle2is, forward_nv_traps),
> +	SYS_INSN_TO_DESC(TLBI_VAE2, handle_vae2is, forward_nv_traps),
> +	SYS_INSN_TO_DESC(TLBI_ALLE1, handle_alle1is, forward_nv_traps),
> +	SYS_INSN_TO_DESC(TLBI_VALE2, handle_vae2is, forward_nv_traps),
> +	SYS_INSN_TO_DESC(TLBI_VMALLS12E1, handle_vmalls12e1is, forward_nv_traps),
>  };
>
>  static bool trap_dbgdidr(struct kvm_vcpu *vcpu,
> -- 
> 2.29.2


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
