Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5933050999
	for <lists+kvmarm@lfdr.de>; Mon, 24 Jun 2019 13:17:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E6D394A51C;
	Mon, 24 Jun 2019 07:17:02 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IMFmzLNgmdOk; Mon, 24 Jun 2019 07:17:02 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6F21B4A4E5;
	Mon, 24 Jun 2019 07:17:00 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2008E4A4A3
 for <kvmarm@lists.cs.columbia.edu>; Mon, 24 Jun 2019 07:16:59 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hy82985n6a-Z for <kvmarm@lists.cs.columbia.edu>;
 Mon, 24 Jun 2019 07:16:56 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4EBAA4A49F
 for <kvmarm@lists.cs.columbia.edu>; Mon, 24 Jun 2019 07:16:56 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ECE932B;
 Mon, 24 Jun 2019 04:16:55 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C8F53F718;
 Mon, 24 Jun 2019 04:16:54 -0700 (PDT)
Date: Mon, 24 Jun 2019 12:16:52 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH 01/59] KVM: arm64: Migrate _elx sysreg accessors to
 msr_s/mrs_s
Message-ID: <20190624111650.GJ2790@e103592.cambridge.arm.com>
References: <20190621093843.220980-1-marc.zyngier@arm.com>
 <20190621093843.220980-2-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190621093843.220980-2-marc.zyngier@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: kvm@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>,
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

On Fri, Jun 21, 2019 at 10:37:45AM +0100, Marc Zyngier wrote:
> From: Dave Martin <Dave.Martin@arm.com>
> 
> Currently, the {read,write}_sysreg_el*() accessors for accessing
> particular ELs' sysregs in the presence of VHE rely on some local
> hacks and define their system register encodings in a way that is
> inconsistent with the core definitions in <asm/sysreg.h>.
> 
> As a result, it is necessary to add duplicate definitions for any
> system register that already needs a definition in sysreg.h for
> other reasons.
> 
> This is a bit of a maintenance headache, and the reasons for the
> _el*() accessors working the way they do is a bit historical.
> 
> This patch gets rid of the shadow sysreg definitions in
> <asm/kvm_hyp.h>, converts the _el*() accessors to use the core
> __msr_s/__mrs_s interface, and converts all call sites to use the
> standard sysreg #define names (i.e., upper case, with SYS_ prefix).
> 
> This patch will conflict heavily anyway, so the opportunity taken
> to clean up some bad whitespace in the context of the changes is
> taken.

FWIW, "opportunity taken ... is taken".

Anway, Ack, thanks to you and Sudeep for keeping this alive.

Cheers
---Dave

> The change exposes a few system registers that have no sysreg.h
> definition, due to msr_s/mrs_s being used in place of msr/mrs:
> additions are made in order to fill in the gaps.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Christoffer Dall <christoffer.dall@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Link: https://www.spinics.net/lists/kvm-arm/msg31717.html
> [Rebased to v4.21-rc1]
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> [Rebased to v5.2-rc5, changelog updates]
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/include/asm/kvm_hyp.h           | 13 ++--
>  arch/arm64/include/asm/kvm_emulate.h     | 16 ++---
>  arch/arm64/include/asm/kvm_hyp.h         | 50 ++-------------
>  arch/arm64/include/asm/sysreg.h          | 35 ++++++++++-
>  arch/arm64/kvm/hyp/switch.c              | 14 ++---
>  arch/arm64/kvm/hyp/sysreg-sr.c           | 78 ++++++++++++------------
>  arch/arm64/kvm/hyp/tlb.c                 | 12 ++--
>  arch/arm64/kvm/hyp/vgic-v2-cpuif-proxy.c |  2 +-
>  arch/arm64/kvm/regmap.c                  |  4 +-
>  arch/arm64/kvm/sys_regs.c                | 56 ++++++++---------
>  virt/kvm/arm/arch_timer.c                | 24 ++++----
>  11 files changed, 148 insertions(+), 156 deletions(-)
> 
> diff --git a/arch/arm/include/asm/kvm_hyp.h b/arch/arm/include/asm/kvm_hyp.h
> index 87bcd18df8d5..059224fb14db 100644
> --- a/arch/arm/include/asm/kvm_hyp.h
> +++ b/arch/arm/include/asm/kvm_hyp.h
> @@ -93,13 +93,14 @@
>  #define VFP_FPEXC	__ACCESS_VFP(FPEXC)
>  
>  /* AArch64 compatibility macros, only for the timer so far */
> -#define read_sysreg_el0(r)		read_sysreg(r##_el0)
> -#define write_sysreg_el0(v, r)		write_sysreg(v, r##_el0)
> +#define read_sysreg_el0(r)		read_sysreg(r##_EL0)
> +#define write_sysreg_el0(v, r)		write_sysreg(v, r##_EL0)
> +
> +#define SYS_CNTP_CTL_EL0		CNTP_CTL
> +#define SYS_CNTP_CVAL_EL0		CNTP_CVAL
> +#define SYS_CNTV_CTL_EL0		CNTV_CTL
> +#define SYS_CNTV_CVAL_EL0		CNTV_CVAL
>  
> -#define cntp_ctl_el0			CNTP_CTL
> -#define cntp_cval_el0			CNTP_CVAL
> -#define cntv_ctl_el0			CNTV_CTL
> -#define cntv_cval_el0			CNTV_CVAL
>  #define cntvoff_el2			CNTVOFF
>  #define cnthctl_el2			CNTHCTL
>  
> diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
> index 613427fafff9..39ffe41855bc 100644
> --- a/arch/arm64/include/asm/kvm_emulate.h
> +++ b/arch/arm64/include/asm/kvm_emulate.h
> @@ -137,7 +137,7 @@ static inline unsigned long *__vcpu_elr_el1(const struct kvm_vcpu *vcpu)
>  static inline unsigned long vcpu_read_elr_el1(const struct kvm_vcpu *vcpu)
>  {
>  	if (vcpu->arch.sysregs_loaded_on_cpu)
> -		return read_sysreg_el1(elr);
> +		return read_sysreg_el1(SYS_ELR);
>  	else
>  		return *__vcpu_elr_el1(vcpu);
>  }
> @@ -145,7 +145,7 @@ static inline unsigned long vcpu_read_elr_el1(const struct kvm_vcpu *vcpu)
>  static inline void vcpu_write_elr_el1(const struct kvm_vcpu *vcpu, unsigned long v)
>  {
>  	if (vcpu->arch.sysregs_loaded_on_cpu)
> -		write_sysreg_el1(v, elr);
> +		write_sysreg_el1(v, SYS_ELR);
>  	else
>  		*__vcpu_elr_el1(vcpu) = v;
>  }
> @@ -197,7 +197,7 @@ static inline unsigned long vcpu_read_spsr(const struct kvm_vcpu *vcpu)
>  		return vcpu_read_spsr32(vcpu);
>  
>  	if (vcpu->arch.sysregs_loaded_on_cpu)
> -		return read_sysreg_el1(spsr);
> +		return read_sysreg_el1(SYS_SPSR);
>  	else
>  		return vcpu_gp_regs(vcpu)->spsr[KVM_SPSR_EL1];
>  }
> @@ -210,7 +210,7 @@ static inline void vcpu_write_spsr(struct kvm_vcpu *vcpu, unsigned long v)
>  	}
>  
>  	if (vcpu->arch.sysregs_loaded_on_cpu)
> -		write_sysreg_el1(v, spsr);
> +		write_sysreg_el1(v, SYS_SPSR);
>  	else
>  		vcpu_gp_regs(vcpu)->spsr[KVM_SPSR_EL1] = v;
>  }
> @@ -462,13 +462,13 @@ static inline void kvm_skip_instr(struct kvm_vcpu *vcpu, bool is_wide_instr)
>   */
>  static inline void __hyp_text __kvm_skip_instr(struct kvm_vcpu *vcpu)
>  {
> -	*vcpu_pc(vcpu) = read_sysreg_el2(elr);
> -	vcpu->arch.ctxt.gp_regs.regs.pstate = read_sysreg_el2(spsr);
> +	*vcpu_pc(vcpu) = read_sysreg_el2(SYS_ELR);
> +	vcpu->arch.ctxt.gp_regs.regs.pstate = read_sysreg_el2(SYS_SPSR);
>  
>  	kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
>  
> -	write_sysreg_el2(vcpu->arch.ctxt.gp_regs.regs.pstate, spsr);
> -	write_sysreg_el2(*vcpu_pc(vcpu), elr);
> +	write_sysreg_el2(vcpu->arch.ctxt.gp_regs.regs.pstate, SYS_SPSR);
> +	write_sysreg_el2(*vcpu_pc(vcpu), SYS_ELR);
>  }
>  
>  #endif /* __ARM64_KVM_EMULATE_H__ */
> diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
> index 09fe8bd15f6e..ce99c2daff04 100644
> --- a/arch/arm64/include/asm/kvm_hyp.h
> +++ b/arch/arm64/include/asm/kvm_hyp.h
> @@ -29,7 +29,7 @@
>  #define read_sysreg_elx(r,nvh,vh)					\
>  	({								\
>  		u64 reg;						\
> -		asm volatile(ALTERNATIVE("mrs %0, " __stringify(r##nvh),\
> +		asm volatile(ALTERNATIVE(__mrs_s("%0", r##nvh),	\
>  					 __mrs_s("%0", r##vh),		\
>  					 ARM64_HAS_VIRT_HOST_EXTN)	\
>  			     : "=r" (reg));				\
> @@ -39,7 +39,7 @@
>  #define write_sysreg_elx(v,r,nvh,vh)					\
>  	do {								\
>  		u64 __val = (u64)(v);					\
> -		asm volatile(ALTERNATIVE("msr " __stringify(r##nvh) ", %x0",\
> +		asm volatile(ALTERNATIVE(__msr_s(r##nvh, "%x0"),	\
>  					 __msr_s(r##vh, "%x0"),		\
>  					 ARM64_HAS_VIRT_HOST_EXTN)	\
>  					 : : "rZ" (__val));		\
> @@ -48,55 +48,15 @@
>  /*
>   * Unified accessors for registers that have a different encoding
>   * between VHE and non-VHE. They must be specified without their "ELx"
> - * encoding.
> + * encoding, but with the SYS_ prefix, as defined in asm/sysreg.h.
>   */
> -#define read_sysreg_el2(r)						\
> -	({								\
> -		u64 reg;						\
> -		asm volatile(ALTERNATIVE("mrs %0, " __stringify(r##_EL2),\
> -					 "mrs %0, " __stringify(r##_EL1),\
> -					 ARM64_HAS_VIRT_HOST_EXTN)	\
> -			     : "=r" (reg));				\
> -		reg;							\
> -	})
> -
> -#define write_sysreg_el2(v,r)						\
> -	do {								\
> -		u64 __val = (u64)(v);					\
> -		asm volatile(ALTERNATIVE("msr " __stringify(r##_EL2) ", %x0",\
> -					 "msr " __stringify(r##_EL1) ", %x0",\
> -					 ARM64_HAS_VIRT_HOST_EXTN)	\
> -					 : : "rZ" (__val));		\
> -	} while (0)
>  
>  #define read_sysreg_el0(r)	read_sysreg_elx(r, _EL0, _EL02)
>  #define write_sysreg_el0(v,r)	write_sysreg_elx(v, r, _EL0, _EL02)
>  #define read_sysreg_el1(r)	read_sysreg_elx(r, _EL1, _EL12)
>  #define write_sysreg_el1(v,r)	write_sysreg_elx(v, r, _EL1, _EL12)
> -
> -/* The VHE specific system registers and their encoding */
> -#define sctlr_EL12              sys_reg(3, 5, 1, 0, 0)
> -#define cpacr_EL12              sys_reg(3, 5, 1, 0, 2)
> -#define ttbr0_EL12              sys_reg(3, 5, 2, 0, 0)
> -#define ttbr1_EL12              sys_reg(3, 5, 2, 0, 1)
> -#define tcr_EL12                sys_reg(3, 5, 2, 0, 2)
> -#define afsr0_EL12              sys_reg(3, 5, 5, 1, 0)
> -#define afsr1_EL12              sys_reg(3, 5, 5, 1, 1)
> -#define esr_EL12                sys_reg(3, 5, 5, 2, 0)
> -#define far_EL12                sys_reg(3, 5, 6, 0, 0)
> -#define mair_EL12               sys_reg(3, 5, 10, 2, 0)
> -#define amair_EL12              sys_reg(3, 5, 10, 3, 0)
> -#define vbar_EL12               sys_reg(3, 5, 12, 0, 0)
> -#define contextidr_EL12         sys_reg(3, 5, 13, 0, 1)
> -#define cntkctl_EL12            sys_reg(3, 5, 14, 1, 0)
> -#define cntp_tval_EL02          sys_reg(3, 5, 14, 2, 0)
> -#define cntp_ctl_EL02           sys_reg(3, 5, 14, 2, 1)
> -#define cntp_cval_EL02          sys_reg(3, 5, 14, 2, 2)
> -#define cntv_tval_EL02          sys_reg(3, 5, 14, 3, 0)
> -#define cntv_ctl_EL02           sys_reg(3, 5, 14, 3, 1)
> -#define cntv_cval_EL02          sys_reg(3, 5, 14, 3, 2)
> -#define spsr_EL12               sys_reg(3, 5, 4, 0, 0)
> -#define elr_EL12                sys_reg(3, 5, 4, 0, 1)
> +#define read_sysreg_el2(r)	read_sysreg_elx(r, _EL2, _EL1)
> +#define write_sysreg_el2(v,r)	write_sysreg_elx(v, r, _EL2, _EL1)
>  
>  /**
>   * hyp_alternate_select - Generates patchable code sequences that are
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 902d75b60914..434cf53d527b 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -202,6 +202,9 @@
>  #define SYS_APGAKEYLO_EL1		sys_reg(3, 0, 2, 3, 0)
>  #define SYS_APGAKEYHI_EL1		sys_reg(3, 0, 2, 3, 1)
>  
> +#define SYS_SPSR_EL1			sys_reg(3, 0, 4, 0, 0)
> +#define SYS_ELR_EL1			sys_reg(3, 0, 4, 0, 1)
> +
>  #define SYS_ICC_PMR_EL1			sys_reg(3, 0, 4, 6, 0)
>  
>  #define SYS_AFSR0_EL1			sys_reg(3, 0, 5, 1, 0)
> @@ -393,6 +396,9 @@
>  #define SYS_CNTP_CTL_EL0		sys_reg(3, 3, 14, 2, 1)
>  #define SYS_CNTP_CVAL_EL0		sys_reg(3, 3, 14, 2, 2)
>  
> +#define SYS_CNTV_CTL_EL0		sys_reg(3, 3, 14, 3, 1)
> +#define SYS_CNTV_CVAL_EL0		sys_reg(3, 3, 14, 3, 2)
> +
>  #define SYS_AARCH32_CNTP_TVAL		sys_reg(0, 0, 14, 2, 0)
>  #define SYS_AARCH32_CNTP_CTL		sys_reg(0, 0, 14, 2, 1)
>  #define SYS_AARCH32_CNTP_CVAL		sys_reg(0, 2, 0, 14, 0)
> @@ -403,14 +409,17 @@
>  #define __TYPER_CRm(n)			(0xc | (((n) >> 3) & 0x3))
>  #define SYS_PMEVTYPERn_EL0(n)		sys_reg(3, 3, 14, __TYPER_CRm(n), __PMEV_op2(n))
>  
> -#define SYS_PMCCFILTR_EL0		sys_reg (3, 3, 14, 15, 7)
> +#define SYS_PMCCFILTR_EL0		sys_reg(3, 3, 14, 15, 7)
>  
>  #define SYS_ZCR_EL2			sys_reg(3, 4, 1, 2, 0)
> -
>  #define SYS_DACR32_EL2			sys_reg(3, 4, 3, 0, 0)
> +#define SYS_SPSR_EL2			sys_reg(3, 4, 4, 0, 0)
> +#define SYS_ELR_EL2			sys_reg(3, 4, 4, 0, 1)
>  #define SYS_IFSR32_EL2			sys_reg(3, 4, 5, 0, 1)
> +#define SYS_ESR_EL2			sys_reg(3, 4, 5, 2, 0)
>  #define SYS_VSESR_EL2			sys_reg(3, 4, 5, 2, 3)
>  #define SYS_FPEXC32_EL2			sys_reg(3, 4, 5, 3, 0)
> +#define SYS_FAR_EL2			sys_reg(3, 4, 6, 0, 0)
>  
>  #define SYS_VDISR_EL2			sys_reg(3, 4, 12, 1,  1)
>  #define __SYS__AP0Rx_EL2(x)		sys_reg(3, 4, 12, 8, x)
> @@ -455,7 +464,29 @@
>  #define SYS_ICH_LR15_EL2		__SYS__LR8_EL2(7)
>  
>  /* VHE encodings for architectural EL0/1 system registers */
> +#define SYS_SCTLR_EL12			sys_reg(3, 5, 1, 0, 0)
> +#define SYS_CPACR_EL12			sys_reg(3, 5, 1, 0, 2)
>  #define SYS_ZCR_EL12			sys_reg(3, 5, 1, 2, 0)
> +#define SYS_TTBR0_EL12			sys_reg(3, 5, 2, 0, 0)
> +#define SYS_TTBR1_EL12			sys_reg(3, 5, 2, 0, 1)
> +#define SYS_TCR_EL12			sys_reg(3, 5, 2, 0, 2)
> +#define SYS_SPSR_EL12			sys_reg(3, 5, 4, 0, 0)
> +#define SYS_ELR_EL12			sys_reg(3, 5, 4, 0, 1)
> +#define SYS_AFSR0_EL12			sys_reg(3, 5, 5, 1, 0)
> +#define SYS_AFSR1_EL12			sys_reg(3, 5, 5, 1, 1)
> +#define SYS_ESR_EL12			sys_reg(3, 5, 5, 2, 0)
> +#define SYS_FAR_EL12			sys_reg(3, 5, 6, 0, 0)
> +#define SYS_MAIR_EL12			sys_reg(3, 5, 10, 2, 0)
> +#define SYS_AMAIR_EL12			sys_reg(3, 5, 10, 3, 0)
> +#define SYS_VBAR_EL12			sys_reg(3, 5, 12, 0, 0)
> +#define SYS_CONTEXTIDR_EL12		sys_reg(3, 5, 13, 0, 1)
> +#define SYS_CNTKCTL_EL12		sys_reg(3, 5, 14, 1, 0)
> +#define SYS_CNTP_TVAL_EL02		sys_reg(3, 5, 14, 2, 0)
> +#define SYS_CNTP_CTL_EL02		sys_reg(3, 5, 14, 2, 1)
> +#define SYS_CNTP_CVAL_EL02		sys_reg(3, 5, 14, 2, 2)
> +#define SYS_CNTV_TVAL_EL02		sys_reg(3, 5, 14, 3, 0)
> +#define SYS_CNTV_CTL_EL02		sys_reg(3, 5, 14, 3, 1)
> +#define SYS_CNTV_CVAL_EL02		sys_reg(3, 5, 14, 3, 2)
>  
>  /* Common SCTLR_ELx flags. */
>  #define SCTLR_ELx_DSSBS	(_BITUL(44))
> diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
> index 8799e0c267d4..7b55c11b30fb 100644
> --- a/arch/arm64/kvm/hyp/switch.c
> +++ b/arch/arm64/kvm/hyp/switch.c
> @@ -295,7 +295,7 @@ static bool __hyp_text __populate_fault_info(struct kvm_vcpu *vcpu)
>  	if (ec != ESR_ELx_EC_DABT_LOW && ec != ESR_ELx_EC_IABT_LOW)
>  		return true;
>  
> -	far = read_sysreg_el2(far);
> +	far = read_sysreg_el2(SYS_FAR);
>  
>  	/*
>  	 * The HPFAR can be invalid if the stage 2 fault did not
> @@ -412,7 +412,7 @@ static bool __hyp_text __hyp_handle_fpsimd(struct kvm_vcpu *vcpu)
>  static bool __hyp_text fixup_guest_exit(struct kvm_vcpu *vcpu, u64 *exit_code)
>  {
>  	if (ARM_EXCEPTION_CODE(*exit_code) != ARM_EXCEPTION_IRQ)
> -		vcpu->arch.fault.esr_el2 = read_sysreg_el2(esr);
> +		vcpu->arch.fault.esr_el2 = read_sysreg_el2(SYS_ESR);
>  
>  	/*
>  	 * We're using the raw exception code in order to only process
> @@ -708,8 +708,8 @@ static void __hyp_text __hyp_call_panic_nvhe(u64 spsr, u64 elr, u64 par,
>  	asm volatile("ldr %0, =__hyp_panic_string" : "=r" (str_va));
>  
>  	__hyp_do_panic(str_va,
> -		       spsr,  elr,
> -		       read_sysreg(esr_el2),   read_sysreg_el2(far),
> +		       spsr, elr,
> +		       read_sysreg(esr_el2), read_sysreg_el2(SYS_FAR),
>  		       read_sysreg(hpfar_el2), par, vcpu);
>  }
>  
> @@ -724,15 +724,15 @@ static void __hyp_call_panic_vhe(u64 spsr, u64 elr, u64 par,
>  
>  	panic(__hyp_panic_string,
>  	      spsr,  elr,
> -	      read_sysreg_el2(esr),   read_sysreg_el2(far),
> +	      read_sysreg_el2(SYS_ESR),   read_sysreg_el2(SYS_FAR),
>  	      read_sysreg(hpfar_el2), par, vcpu);
>  }
>  NOKPROBE_SYMBOL(__hyp_call_panic_vhe);
>  
>  void __hyp_text __noreturn hyp_panic(struct kvm_cpu_context *host_ctxt)
>  {
> -	u64 spsr = read_sysreg_el2(spsr);
> -	u64 elr = read_sysreg_el2(elr);
> +	u64 spsr = read_sysreg_el2(SYS_SPSR);
> +	u64 elr = read_sysreg_el2(SYS_ELR);
>  	u64 par = read_sysreg(par_el1);
>  
>  	if (!has_vhe())
> diff --git a/arch/arm64/kvm/hyp/sysreg-sr.c b/arch/arm64/kvm/hyp/sysreg-sr.c
> index c52a8451637c..62866a68e852 100644
> --- a/arch/arm64/kvm/hyp/sysreg-sr.c
> +++ b/arch/arm64/kvm/hyp/sysreg-sr.c
> @@ -54,33 +54,33 @@ static void __hyp_text __sysreg_save_user_state(struct kvm_cpu_context *ctxt)
>  static void __hyp_text __sysreg_save_el1_state(struct kvm_cpu_context *ctxt)
>  {
>  	ctxt->sys_regs[CSSELR_EL1]	= read_sysreg(csselr_el1);
> -	ctxt->sys_regs[SCTLR_EL1]	= read_sysreg_el1(sctlr);
> +	ctxt->sys_regs[SCTLR_EL1]	= read_sysreg_el1(SYS_SCTLR);
>  	ctxt->sys_regs[ACTLR_EL1]	= read_sysreg(actlr_el1);
> -	ctxt->sys_regs[CPACR_EL1]	= read_sysreg_el1(cpacr);
> -	ctxt->sys_regs[TTBR0_EL1]	= read_sysreg_el1(ttbr0);
> -	ctxt->sys_regs[TTBR1_EL1]	= read_sysreg_el1(ttbr1);
> -	ctxt->sys_regs[TCR_EL1]		= read_sysreg_el1(tcr);
> -	ctxt->sys_regs[ESR_EL1]		= read_sysreg_el1(esr);
> -	ctxt->sys_regs[AFSR0_EL1]	= read_sysreg_el1(afsr0);
> -	ctxt->sys_regs[AFSR1_EL1]	= read_sysreg_el1(afsr1);
> -	ctxt->sys_regs[FAR_EL1]		= read_sysreg_el1(far);
> -	ctxt->sys_regs[MAIR_EL1]	= read_sysreg_el1(mair);
> -	ctxt->sys_regs[VBAR_EL1]	= read_sysreg_el1(vbar);
> -	ctxt->sys_regs[CONTEXTIDR_EL1]	= read_sysreg_el1(contextidr);
> -	ctxt->sys_regs[AMAIR_EL1]	= read_sysreg_el1(amair);
> -	ctxt->sys_regs[CNTKCTL_EL1]	= read_sysreg_el1(cntkctl);
> +	ctxt->sys_regs[CPACR_EL1]	= read_sysreg_el1(SYS_CPACR);
> +	ctxt->sys_regs[TTBR0_EL1]	= read_sysreg_el1(SYS_TTBR0);
> +	ctxt->sys_regs[TTBR1_EL1]	= read_sysreg_el1(SYS_TTBR1);
> +	ctxt->sys_regs[TCR_EL1]		= read_sysreg_el1(SYS_TCR);
> +	ctxt->sys_regs[ESR_EL1]		= read_sysreg_el1(SYS_ESR);
> +	ctxt->sys_regs[AFSR0_EL1]	= read_sysreg_el1(SYS_AFSR0);
> +	ctxt->sys_regs[AFSR1_EL1]	= read_sysreg_el1(SYS_AFSR1);
> +	ctxt->sys_regs[FAR_EL1]		= read_sysreg_el1(SYS_FAR);
> +	ctxt->sys_regs[MAIR_EL1]	= read_sysreg_el1(SYS_MAIR);
> +	ctxt->sys_regs[VBAR_EL1]	= read_sysreg_el1(SYS_VBAR);
> +	ctxt->sys_regs[CONTEXTIDR_EL1]	= read_sysreg_el1(SYS_CONTEXTIDR);
> +	ctxt->sys_regs[AMAIR_EL1]	= read_sysreg_el1(SYS_AMAIR);
> +	ctxt->sys_regs[CNTKCTL_EL1]	= read_sysreg_el1(SYS_CNTKCTL);
>  	ctxt->sys_regs[PAR_EL1]		= read_sysreg(par_el1);
>  	ctxt->sys_regs[TPIDR_EL1]	= read_sysreg(tpidr_el1);
>  
>  	ctxt->gp_regs.sp_el1		= read_sysreg(sp_el1);
> -	ctxt->gp_regs.elr_el1		= read_sysreg_el1(elr);
> -	ctxt->gp_regs.spsr[KVM_SPSR_EL1]= read_sysreg_el1(spsr);
> +	ctxt->gp_regs.elr_el1		= read_sysreg_el1(SYS_ELR);
> +	ctxt->gp_regs.spsr[KVM_SPSR_EL1]= read_sysreg_el1(SYS_SPSR);
>  }
>  
>  static void __hyp_text __sysreg_save_el2_return_state(struct kvm_cpu_context *ctxt)
>  {
> -	ctxt->gp_regs.regs.pc		= read_sysreg_el2(elr);
> -	ctxt->gp_regs.regs.pstate	= read_sysreg_el2(spsr);
> +	ctxt->gp_regs.regs.pc		= read_sysreg_el2(SYS_ELR);
> +	ctxt->gp_regs.regs.pstate	= read_sysreg_el2(SYS_SPSR);
>  
>  	if (cpus_have_const_cap(ARM64_HAS_RAS_EXTN))
>  		ctxt->sys_regs[DISR_EL1] = read_sysreg_s(SYS_VDISR_EL2);
> @@ -120,35 +120,35 @@ static void __hyp_text __sysreg_restore_common_state(struct kvm_cpu_context *ctx
>  
>  static void __hyp_text __sysreg_restore_user_state(struct kvm_cpu_context *ctxt)
>  {
> -	write_sysreg(ctxt->sys_regs[TPIDR_EL0],	  	tpidr_el0);
> -	write_sysreg(ctxt->sys_regs[TPIDRRO_EL0], 	tpidrro_el0);
> +	write_sysreg(ctxt->sys_regs[TPIDR_EL0],		tpidr_el0);
> +	write_sysreg(ctxt->sys_regs[TPIDRRO_EL0],	tpidrro_el0);
>  }
>  
>  static void __hyp_text __sysreg_restore_el1_state(struct kvm_cpu_context *ctxt)
>  {
>  	write_sysreg(ctxt->sys_regs[MPIDR_EL1],		vmpidr_el2);
>  	write_sysreg(ctxt->sys_regs[CSSELR_EL1],	csselr_el1);
> -	write_sysreg_el1(ctxt->sys_regs[SCTLR_EL1],	sctlr);
> -	write_sysreg(ctxt->sys_regs[ACTLR_EL1],	  	actlr_el1);
> -	write_sysreg_el1(ctxt->sys_regs[CPACR_EL1],	cpacr);
> -	write_sysreg_el1(ctxt->sys_regs[TTBR0_EL1],	ttbr0);
> -	write_sysreg_el1(ctxt->sys_regs[TTBR1_EL1],	ttbr1);
> -	write_sysreg_el1(ctxt->sys_regs[TCR_EL1],	tcr);
> -	write_sysreg_el1(ctxt->sys_regs[ESR_EL1],	esr);
> -	write_sysreg_el1(ctxt->sys_regs[AFSR0_EL1],	afsr0);
> -	write_sysreg_el1(ctxt->sys_regs[AFSR1_EL1],	afsr1);
> -	write_sysreg_el1(ctxt->sys_regs[FAR_EL1],	far);
> -	write_sysreg_el1(ctxt->sys_regs[MAIR_EL1],	mair);
> -	write_sysreg_el1(ctxt->sys_regs[VBAR_EL1],	vbar);
> -	write_sysreg_el1(ctxt->sys_regs[CONTEXTIDR_EL1],contextidr);
> -	write_sysreg_el1(ctxt->sys_regs[AMAIR_EL1],	amair);
> -	write_sysreg_el1(ctxt->sys_regs[CNTKCTL_EL1], 	cntkctl);
> +	write_sysreg_el1(ctxt->sys_regs[SCTLR_EL1],	SYS_SCTLR);
> +	write_sysreg(ctxt->sys_regs[ACTLR_EL1],		actlr_el1);
> +	write_sysreg_el1(ctxt->sys_regs[CPACR_EL1],	SYS_CPACR);
> +	write_sysreg_el1(ctxt->sys_regs[TTBR0_EL1],	SYS_TTBR0);
> +	write_sysreg_el1(ctxt->sys_regs[TTBR1_EL1],	SYS_TTBR1);
> +	write_sysreg_el1(ctxt->sys_regs[TCR_EL1],	SYS_TCR);
> +	write_sysreg_el1(ctxt->sys_regs[ESR_EL1],	SYS_ESR);
> +	write_sysreg_el1(ctxt->sys_regs[AFSR0_EL1],	SYS_AFSR0);
> +	write_sysreg_el1(ctxt->sys_regs[AFSR1_EL1],	SYS_AFSR1);
> +	write_sysreg_el1(ctxt->sys_regs[FAR_EL1],	SYS_FAR);
> +	write_sysreg_el1(ctxt->sys_regs[MAIR_EL1],	SYS_MAIR);
> +	write_sysreg_el1(ctxt->sys_regs[VBAR_EL1],	SYS_VBAR);
> +	write_sysreg_el1(ctxt->sys_regs[CONTEXTIDR_EL1],SYS_CONTEXTIDR);
> +	write_sysreg_el1(ctxt->sys_regs[AMAIR_EL1],	SYS_AMAIR);
> +	write_sysreg_el1(ctxt->sys_regs[CNTKCTL_EL1],	SYS_CNTKCTL);
>  	write_sysreg(ctxt->sys_regs[PAR_EL1],		par_el1);
>  	write_sysreg(ctxt->sys_regs[TPIDR_EL1],		tpidr_el1);
>  
>  	write_sysreg(ctxt->gp_regs.sp_el1,		sp_el1);
> -	write_sysreg_el1(ctxt->gp_regs.elr_el1,		elr);
> -	write_sysreg_el1(ctxt->gp_regs.spsr[KVM_SPSR_EL1],spsr);
> +	write_sysreg_el1(ctxt->gp_regs.elr_el1,		SYS_ELR);
> +	write_sysreg_el1(ctxt->gp_regs.spsr[KVM_SPSR_EL1],SYS_SPSR);
>  }
>  
>  static void __hyp_text
> @@ -171,8 +171,8 @@ __sysreg_restore_el2_return_state(struct kvm_cpu_context *ctxt)
>  	if (!(mode & PSR_MODE32_BIT) && mode >= PSR_MODE_EL2t)
>  		pstate = PSR_MODE_EL2h | PSR_IL_BIT;
>  
> -	write_sysreg_el2(ctxt->gp_regs.regs.pc,		elr);
> -	write_sysreg_el2(pstate,			spsr);
> +	write_sysreg_el2(ctxt->gp_regs.regs.pc,		SYS_ELR);
> +	write_sysreg_el2(pstate,			SYS_SPSR);
>  
>  	if (cpus_have_const_cap(ARM64_HAS_RAS_EXTN))
>  		write_sysreg_s(ctxt->sys_regs[DISR_EL1], SYS_VDISR_EL2);
> diff --git a/arch/arm64/kvm/hyp/tlb.c b/arch/arm64/kvm/hyp/tlb.c
> index 76c30866069e..32a782bb00be 100644
> --- a/arch/arm64/kvm/hyp/tlb.c
> +++ b/arch/arm64/kvm/hyp/tlb.c
> @@ -44,12 +44,12 @@ static void __hyp_text __tlb_switch_to_guest_vhe(struct kvm *kvm,
>  		 * in the TCR_EL1 register. We also need to prevent it to
>  		 * allocate IPA->PA walks, so we enable the S1 MMU...
>  		 */
> -		val = cxt->tcr = read_sysreg_el1(tcr);
> +		val = cxt->tcr = read_sysreg_el1(SYS_TCR);
>  		val |= TCR_EPD1_MASK | TCR_EPD0_MASK;
> -		write_sysreg_el1(val, tcr);
> -		val = cxt->sctlr = read_sysreg_el1(sctlr);
> +		write_sysreg_el1(val, SYS_TCR);
> +		val = cxt->sctlr = read_sysreg_el1(SYS_SCTLR);
>  		val |= SCTLR_ELx_M;
> -		write_sysreg_el1(val, sctlr);
> +		write_sysreg_el1(val, SYS_SCTLR);
>  	}
>  
>  	/*
> @@ -96,8 +96,8 @@ static void __hyp_text __tlb_switch_to_host_vhe(struct kvm *kvm,
>  
>  	if (cpus_have_const_cap(ARM64_WORKAROUND_1165522)) {
>  		/* Restore the registers to what they were */
> -		write_sysreg_el1(cxt->tcr, tcr);
> -		write_sysreg_el1(cxt->sctlr, sctlr);
> +		write_sysreg_el1(cxt->tcr, SYS_TCR);
> +		write_sysreg_el1(cxt->sctlr, SYS_SCTLR);
>  	}
>  
>  	local_irq_restore(cxt->flags);
> diff --git a/arch/arm64/kvm/hyp/vgic-v2-cpuif-proxy.c b/arch/arm64/kvm/hyp/vgic-v2-cpuif-proxy.c
> index 9cbdd034a563..4cd32c856110 100644
> --- a/arch/arm64/kvm/hyp/vgic-v2-cpuif-proxy.c
> +++ b/arch/arm64/kvm/hyp/vgic-v2-cpuif-proxy.c
> @@ -27,7 +27,7 @@
>  static bool __hyp_text __is_be(struct kvm_vcpu *vcpu)
>  {
>  	if (vcpu_mode_is_32bit(vcpu))
> -		return !!(read_sysreg_el2(spsr) & PSR_AA32_E_BIT);
> +		return !!(read_sysreg_el2(SYS_SPSR) & PSR_AA32_E_BIT);
>  
>  	return !!(read_sysreg(SCTLR_EL1) & SCTLR_ELx_EE);
>  }
> diff --git a/arch/arm64/kvm/regmap.c b/arch/arm64/kvm/regmap.c
> index 7a5173ea2276..5dd110b384e4 100644
> --- a/arch/arm64/kvm/regmap.c
> +++ b/arch/arm64/kvm/regmap.c
> @@ -163,7 +163,7 @@ unsigned long vcpu_read_spsr32(const struct kvm_vcpu *vcpu)
>  
>  	switch (spsr_idx) {
>  	case KVM_SPSR_SVC:
> -		return read_sysreg_el1(spsr);
> +		return read_sysreg_el1(SYS_SPSR);
>  	case KVM_SPSR_ABT:
>  		return read_sysreg(spsr_abt);
>  	case KVM_SPSR_UND:
> @@ -188,7 +188,7 @@ void vcpu_write_spsr32(struct kvm_vcpu *vcpu, unsigned long v)
>  
>  	switch (spsr_idx) {
>  	case KVM_SPSR_SVC:
> -		write_sysreg_el1(v, spsr);
> +		write_sysreg_el1(v, SYS_SPSR);
>  	case KVM_SPSR_ABT:
>  		write_sysreg(v, spsr_abt);
>  	case KVM_SPSR_UND:
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 857b226bcdde..adb8a7e9c8e4 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -92,24 +92,24 @@ u64 vcpu_read_sys_reg(const struct kvm_vcpu *vcpu, int reg)
>  	 */
>  	switch (reg) {
>  	case CSSELR_EL1:	return read_sysreg_s(SYS_CSSELR_EL1);
> -	case SCTLR_EL1:		return read_sysreg_s(sctlr_EL12);
> +	case SCTLR_EL1:		return read_sysreg_s(SYS_SCTLR_EL12);
>  	case ACTLR_EL1:		return read_sysreg_s(SYS_ACTLR_EL1);
> -	case CPACR_EL1:		return read_sysreg_s(cpacr_EL12);
> -	case TTBR0_EL1:		return read_sysreg_s(ttbr0_EL12);
> -	case TTBR1_EL1:		return read_sysreg_s(ttbr1_EL12);
> -	case TCR_EL1:		return read_sysreg_s(tcr_EL12);
> -	case ESR_EL1:		return read_sysreg_s(esr_EL12);
> -	case AFSR0_EL1:		return read_sysreg_s(afsr0_EL12);
> -	case AFSR1_EL1:		return read_sysreg_s(afsr1_EL12);
> -	case FAR_EL1:		return read_sysreg_s(far_EL12);
> -	case MAIR_EL1:		return read_sysreg_s(mair_EL12);
> -	case VBAR_EL1:		return read_sysreg_s(vbar_EL12);
> -	case CONTEXTIDR_EL1:	return read_sysreg_s(contextidr_EL12);
> +	case CPACR_EL1:		return read_sysreg_s(SYS_CPACR_EL12);
> +	case TTBR0_EL1:		return read_sysreg_s(SYS_TTBR0_EL12);
> +	case TTBR1_EL1:		return read_sysreg_s(SYS_TTBR1_EL12);
> +	case TCR_EL1:		return read_sysreg_s(SYS_TCR_EL12);
> +	case ESR_EL1:		return read_sysreg_s(SYS_ESR_EL12);
> +	case AFSR0_EL1:		return read_sysreg_s(SYS_AFSR0_EL12);
> +	case AFSR1_EL1:		return read_sysreg_s(SYS_AFSR1_EL12);
> +	case FAR_EL1:		return read_sysreg_s(SYS_FAR_EL12);
> +	case MAIR_EL1:		return read_sysreg_s(SYS_MAIR_EL12);
> +	case VBAR_EL1:		return read_sysreg_s(SYS_VBAR_EL12);
> +	case CONTEXTIDR_EL1:	return read_sysreg_s(SYS_CONTEXTIDR_EL12);
>  	case TPIDR_EL0:		return read_sysreg_s(SYS_TPIDR_EL0);
>  	case TPIDRRO_EL0:	return read_sysreg_s(SYS_TPIDRRO_EL0);
>  	case TPIDR_EL1:		return read_sysreg_s(SYS_TPIDR_EL1);
> -	case AMAIR_EL1:		return read_sysreg_s(amair_EL12);
> -	case CNTKCTL_EL1:	return read_sysreg_s(cntkctl_EL12);
> +	case AMAIR_EL1:		return read_sysreg_s(SYS_AMAIR_EL12);
> +	case CNTKCTL_EL1:	return read_sysreg_s(SYS_CNTKCTL_EL12);
>  	case PAR_EL1:		return read_sysreg_s(SYS_PAR_EL1);
>  	case DACR32_EL2:	return read_sysreg_s(SYS_DACR32_EL2);
>  	case IFSR32_EL2:	return read_sysreg_s(SYS_IFSR32_EL2);
> @@ -135,24 +135,24 @@ void vcpu_write_sys_reg(struct kvm_vcpu *vcpu, u64 val, int reg)
>  	 */
>  	switch (reg) {
>  	case CSSELR_EL1:	write_sysreg_s(val, SYS_CSSELR_EL1);	return;
> -	case SCTLR_EL1:		write_sysreg_s(val, sctlr_EL12);	return;
> +	case SCTLR_EL1:		write_sysreg_s(val, SYS_SCTLR_EL12);	return;
>  	case ACTLR_EL1:		write_sysreg_s(val, SYS_ACTLR_EL1);	return;
> -	case CPACR_EL1:		write_sysreg_s(val, cpacr_EL12);	return;
> -	case TTBR0_EL1:		write_sysreg_s(val, ttbr0_EL12);	return;
> -	case TTBR1_EL1:		write_sysreg_s(val, ttbr1_EL12);	return;
> -	case TCR_EL1:		write_sysreg_s(val, tcr_EL12);		return;
> -	case ESR_EL1:		write_sysreg_s(val, esr_EL12);		return;
> -	case AFSR0_EL1:		write_sysreg_s(val, afsr0_EL12);	return;
> -	case AFSR1_EL1:		write_sysreg_s(val, afsr1_EL12);	return;
> -	case FAR_EL1:		write_sysreg_s(val, far_EL12);		return;
> -	case MAIR_EL1:		write_sysreg_s(val, mair_EL12);		return;
> -	case VBAR_EL1:		write_sysreg_s(val, vbar_EL12);		return;
> -	case CONTEXTIDR_EL1:	write_sysreg_s(val, contextidr_EL12);	return;
> +	case CPACR_EL1:		write_sysreg_s(val, SYS_CPACR_EL12);	return;
> +	case TTBR0_EL1:		write_sysreg_s(val, SYS_TTBR0_EL12);	return;
> +	case TTBR1_EL1:		write_sysreg_s(val, SYS_TTBR1_EL12);	return;
> +	case TCR_EL1:		write_sysreg_s(val, SYS_TCR_EL12);	return;
> +	case ESR_EL1:		write_sysreg_s(val, SYS_ESR_EL12);	return;
> +	case AFSR0_EL1:		write_sysreg_s(val, SYS_AFSR0_EL12);	return;
> +	case AFSR1_EL1:		write_sysreg_s(val, SYS_AFSR1_EL12);	return;
> +	case FAR_EL1:		write_sysreg_s(val, SYS_FAR_EL12);	return;
> +	case MAIR_EL1:		write_sysreg_s(val, SYS_MAIR_EL12);	return;
> +	case VBAR_EL1:		write_sysreg_s(val, SYS_VBAR_EL12);	return;
> +	case CONTEXTIDR_EL1:	write_sysreg_s(val, SYS_CONTEXTIDR_EL12); return;
>  	case TPIDR_EL0:		write_sysreg_s(val, SYS_TPIDR_EL0);	return;
>  	case TPIDRRO_EL0:	write_sysreg_s(val, SYS_TPIDRRO_EL0);	return;
>  	case TPIDR_EL1:		write_sysreg_s(val, SYS_TPIDR_EL1);	return;
> -	case AMAIR_EL1:		write_sysreg_s(val, amair_EL12);	return;
> -	case CNTKCTL_EL1:	write_sysreg_s(val, cntkctl_EL12);	return;
> +	case AMAIR_EL1:		write_sysreg_s(val, SYS_AMAIR_EL12);	return;
> +	case CNTKCTL_EL1:	write_sysreg_s(val, SYS_CNTKCTL_EL12);	return;
>  	case PAR_EL1:		write_sysreg_s(val, SYS_PAR_EL1);	return;
>  	case DACR32_EL2:	write_sysreg_s(val, SYS_DACR32_EL2);	return;
>  	case IFSR32_EL2:	write_sysreg_s(val, SYS_IFSR32_EL2);	return;
> diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
> index 05ddb6293b79..089441a07ed7 100644
> --- a/virt/kvm/arm/arch_timer.c
> +++ b/virt/kvm/arm/arch_timer.c
> @@ -237,10 +237,10 @@ static bool kvm_timer_should_fire(struct arch_timer_context *timer_ctx)
>  
>  		switch (index) {
>  		case TIMER_VTIMER:
> -			cnt_ctl = read_sysreg_el0(cntv_ctl);
> +			cnt_ctl = read_sysreg_el0(SYS_CNTV_CTL);
>  			break;
>  		case TIMER_PTIMER:
> -			cnt_ctl = read_sysreg_el0(cntp_ctl);
> +			cnt_ctl = read_sysreg_el0(SYS_CNTP_CTL);
>  			break;
>  		case NR_KVM_TIMERS:
>  			/* GCC is braindead */
> @@ -349,20 +349,20 @@ static void timer_save_state(struct arch_timer_context *ctx)
>  
>  	switch (index) {
>  	case TIMER_VTIMER:
> -		ctx->cnt_ctl = read_sysreg_el0(cntv_ctl);
> -		ctx->cnt_cval = read_sysreg_el0(cntv_cval);
> +		ctx->cnt_ctl = read_sysreg_el0(SYS_CNTV_CTL);
> +		ctx->cnt_cval = read_sysreg_el0(SYS_CNTV_CVAL);
>  
>  		/* Disable the timer */
> -		write_sysreg_el0(0, cntv_ctl);
> +		write_sysreg_el0(0, SYS_CNTV_CTL);
>  		isb();
>  
>  		break;
>  	case TIMER_PTIMER:
> -		ctx->cnt_ctl = read_sysreg_el0(cntp_ctl);
> -		ctx->cnt_cval = read_sysreg_el0(cntp_cval);
> +		ctx->cnt_ctl = read_sysreg_el0(SYS_CNTP_CTL);
> +		ctx->cnt_cval = read_sysreg_el0(SYS_CNTP_CVAL);
>  
>  		/* Disable the timer */
> -		write_sysreg_el0(0, cntp_ctl);
> +		write_sysreg_el0(0, SYS_CNTP_CTL);
>  		isb();
>  
>  		break;
> @@ -428,14 +428,14 @@ static void timer_restore_state(struct arch_timer_context *ctx)
>  
>  	switch (index) {
>  	case TIMER_VTIMER:
> -		write_sysreg_el0(ctx->cnt_cval, cntv_cval);
> +		write_sysreg_el0(ctx->cnt_cval, SYS_CNTV_CVAL);
>  		isb();
> -		write_sysreg_el0(ctx->cnt_ctl, cntv_ctl);
> +		write_sysreg_el0(ctx->cnt_ctl, SYS_CNTV_CTL);
>  		break;
>  	case TIMER_PTIMER:
> -		write_sysreg_el0(ctx->cnt_cval, cntp_cval);
> +		write_sysreg_el0(ctx->cnt_cval, SYS_CNTP_CVAL);
>  		isb();
> -		write_sysreg_el0(ctx->cnt_ctl, cntp_ctl);
> +		write_sysreg_el0(ctx->cnt_ctl, SYS_CNTP_CTL);
>  		break;
>  	case NR_KVM_TIMERS:
>  		BUG();
> -- 
> 2.20.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
