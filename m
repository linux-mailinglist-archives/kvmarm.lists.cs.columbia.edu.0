Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8D24AC3B9
	for <lists+kvmarm@lfdr.de>; Mon,  7 Feb 2022 16:33:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E343649EF3;
	Mon,  7 Feb 2022 10:33:35 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.8
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, URIBL_BLOCKED=0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8ImQWGYcflnX; Mon,  7 Feb 2022 10:33:35 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 07EE74291D;
	Mon,  7 Feb 2022 10:33:34 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1FF4640BED
 for <kvmarm@lists.cs.columbia.edu>; Mon,  7 Feb 2022 10:33:33 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mdnR6AsYXb5x for <kvmarm@lists.cs.columbia.edu>;
 Mon,  7 Feb 2022 10:33:29 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2A54A408AB
 for <kvmarm@lists.cs.columbia.edu>; Mon,  7 Feb 2022 10:33:29 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74B881396;
 Mon,  7 Feb 2022 07:33:28 -0800 (PST)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DC8C3F70D;
 Mon,  7 Feb 2022 07:33:24 -0800 (PST)
Date: Mon, 7 Feb 2022 15:33:35 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v6 24/64] KVM: arm64: nv: Respect the virtual HCR_EL2.NV
 bit setting
Message-ID: <YgE7z9Q/oKTCR6mY@monolith.localdoman>
References: <20220128121912.509006-1-maz@kernel.org>
 <20220128121912.509006-25-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220128121912.509006-25-maz@kernel.org>
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

Hi Marc,

On Fri, Jan 28, 2022 at 12:18:32PM +0000, Marc Zyngier wrote:
> From: Jintack Lim <jintack.lim@linaro.org>
> 
> Forward traps due to HCR_EL2.NV bit to the virtual EL2 if they are not
> coming from the virtual EL2 and the virtual HCR_EL2.NV bit is set.
> 
> In addition to EL2 register accesses, setting NV bit will also make EL12
> register accesses trap to EL2. To emulate this for the virtual EL2,
> forword traps due to EL12 register accessses to the virtual EL2 if the
> virtual HCR_EL2.NV bit is set.

The patch also adds handling for the HCR_EL2.TSC bit. It might prove useful for
the commit subject and message to reflect that.

Also, HCR_EL2.NV also enables trapping of accesses to the *_EL02, *_EL2 and
SP_EL1 registers, or trapping the execution of the ERET, ERETAA, ERETAB,
and of certain AT and TLB maintenance instructions.  I don't see those
mentioned anywhere.

IMO, the commit message should be reworded to say exactly is being forwarded,
because as it stands it is very misleading.

> 
> This is for recursive nested virtualization.
> 
> Signed-off-by: Jintack Lim <jintack.lim@linaro.org>
> [Moved code to emulate-nested.c]

What goes in emulate-nested.c and what goes in nested.c?

> Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/include/asm/kvm_arm.h    |  1 +
>  arch/arm64/include/asm/kvm_nested.h |  2 ++
>  arch/arm64/kvm/emulate-nested.c     | 27 +++++++++++++++++++++++++++
>  arch/arm64/kvm/handle_exit.c        |  7 +++++++
>  arch/arm64/kvm/sys_regs.c           | 21 +++++++++++++++++++++
>  5 files changed, 58 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
> index 5acb153a82c8..8043827e7dc0 100644
> --- a/arch/arm64/include/asm/kvm_arm.h
> +++ b/arch/arm64/include/asm/kvm_arm.h
> @@ -20,6 +20,7 @@
>  #define HCR_AMVOFFEN	(UL(1) << 51)
>  #define HCR_FIEN	(UL(1) << 47)
>  #define HCR_FWB		(UL(1) << 46)
> +#define HCR_NV		(UL(1) << 42)
>  #define HCR_API		(UL(1) << 41)
>  #define HCR_APK		(UL(1) << 40)
>  #define HCR_TEA		(UL(1) << 37)
> diff --git a/arch/arm64/include/asm/kvm_nested.h b/arch/arm64/include/asm/kvm_nested.h
> index 79d382fa02ea..37ff6458296d 100644
> --- a/arch/arm64/include/asm/kvm_nested.h
> +++ b/arch/arm64/include/asm/kvm_nested.h
> @@ -66,5 +66,7 @@ static inline u64 translate_cnthctl_el2_to_cntkctl_el1(u64 cnthctl)
>  }
>  
>  int handle_wfx_nested(struct kvm_vcpu *vcpu, bool is_wfe);
> +extern bool forward_traps(struct kvm_vcpu *vcpu, u64 control_bit);
> +extern bool forward_nv_traps(struct kvm_vcpu *vcpu);
>  
>  #endif /* __ARM64_KVM_NESTED_H */
> diff --git a/arch/arm64/kvm/emulate-nested.c b/arch/arm64/kvm/emulate-nested.c
> index f52cd4458947..7dd98d6e96e0 100644
> --- a/arch/arm64/kvm/emulate-nested.c
> +++ b/arch/arm64/kvm/emulate-nested.c
> @@ -13,6 +13,26 @@
>  
>  #include "trace.h"
>  
> +bool forward_traps(struct kvm_vcpu *vcpu, u64 control_bit)
> +{
> +	bool control_bit_set;
> +
> +	if (!vcpu_has_nv(vcpu))
> +		return false;
> +
> +	control_bit_set = __vcpu_sys_reg(vcpu, HCR_EL2) & control_bit;
> +	if (!vcpu_is_el2(vcpu) && control_bit_set) {
> +		kvm_inject_nested_sync(vcpu, kvm_vcpu_get_esr(vcpu));
> +		return true;
> +	}
> +	return false;
> +}
> +
> +bool forward_nv_traps(struct kvm_vcpu *vcpu)
> +{
> +	return forward_traps(vcpu, HCR_NV);
> +}
> +
>  static u64 kvm_check_illegal_exception_return(struct kvm_vcpu *vcpu, u64 spsr)
>  {
>  	u64 mode = spsr & PSR_MODE_MASK;
> @@ -49,6 +69,13 @@ void kvm_emulate_nested_eret(struct kvm_vcpu *vcpu)
>  	u64 spsr, elr, mode;
>  	bool direct_eret;
>  
> +	/*
> +	 * Forward this trap to the virtual EL2 if the virtual
> +	 * HCR_EL2.NV bit is set and this is coming from !EL2.
> +	 */

I was under the impression that Documentation/process/coding-style.rst frowns
upon explaining what a function does. forward_traps() is small and simple, I
think the comment is not needed for understanding what the function does.

> +	if (forward_nv_traps(vcpu))
> +		return;
> +
>  	/*
>  	 * Going through the whole put/load motions is a waste of time
>  	 * if this is a VHE guest hypervisor returning to its own
> diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
> index a5c698f188d6..867de65eb766 100644
> --- a/arch/arm64/kvm/handle_exit.c
> +++ b/arch/arm64/kvm/handle_exit.c
> @@ -64,6 +64,13 @@ static int handle_smc(struct kvm_vcpu *vcpu)
>  {
>  	int ret;
>  
> +	/*
> +	 * Forward this trapped smc instruction to the virtual EL2 if
> +	 * the guest has asked for it.
> +	 */
> +	if (forward_traps(vcpu, HCR_TSC))

Like I've said, this part is not mentioned in the commit message at all.

> +		return 1;
> +
>  	/*
>  	 * "If an SMC instruction executed at Non-secure EL1 is
>  	 * trapped to EL2 because HCR_EL2.TSC is 1, the exception is a
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 7f074a7f6eb3..ccd063d6cb69 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -267,10 +267,19 @@ static u32 get_ccsidr(u32 csselr)
>  	return ccsidr;
>  }
>  
> +static bool el12_reg(struct sys_reg_params *p)
> +{
> +	/* All *_EL12 registers have Op1=5. */
> +	return (p->Op1 == 5);
> +}
> +
>  static bool access_rw(struct kvm_vcpu *vcpu,
>  		      struct sys_reg_params *p,
>  		      const struct sys_reg_desc *r)
>  {
> +	if (el12_reg(p) && forward_nv_traps(vcpu))
> +		return false;
> +
>  	if (p->is_write)
>  		vcpu_write_sys_reg(vcpu, p->regval, r->reg);
>  	else
> @@ -339,6 +348,9 @@ static bool access_vm_reg(struct kvm_vcpu *vcpu,
>  	bool was_enabled = vcpu_has_cache_enabled(vcpu);
>  	u64 val, mask, shift;
>  
> +	if (el12_reg(p) && forward_nv_traps(vcpu))
> +		return false;
> +
>  	/* We don't expect TRVM on the host */
>  	BUG_ON(!vcpu_is_el2(vcpu) && !p->is_write);
>  
> @@ -1654,6 +1666,9 @@ static bool access_elr(struct kvm_vcpu *vcpu,
>  		       struct sys_reg_params *p,
>  		       const struct sys_reg_desc *r)
>  {
> +	if (el12_reg(p) && forward_nv_traps(vcpu))

ELR_EL2 has Op1 = 4, and ELR_EL1 has Op1 = 0, and as far as I can tell there are
no _EL12 variants. Why use el12_reg() here when it always returns false?

> +		return false;
> +
>  	if (p->is_write)
>  		vcpu_write_sys_reg(vcpu, p->regval, ELR_EL1);
>  	else
> @@ -1666,6 +1681,9 @@ static bool access_spsr(struct kvm_vcpu *vcpu,
>  			struct sys_reg_params *p,
>  			const struct sys_reg_desc *r)
>  {
> +	if (el12_reg(p) && forward_nv_traps(vcpu))
> +		return false;
> +
>  	if (p->is_write)
>  		__vcpu_sys_reg(vcpu, SPSR_EL1) = p->regval;
>  	else
> @@ -1678,6 +1696,9 @@ static bool access_spsr_el2(struct kvm_vcpu *vcpu,
>  			    struct sys_reg_params *p,
>  			    const struct sys_reg_desc *r)
>  {
> +	if (el12_reg(p) && forward_nv_traps(vcpu))
> +		return false;

spsr_el2 is an EL2 register, and el12_reg() always returns false (Op1 = 5).
Shouldn't that check be only:

		if (forward_nv_traps(vcpu))
			return false;

Thanks,
Alex

> +
>  	if (p->is_write)
>  		vcpu_write_sys_reg(vcpu, p->regval, SPSR_EL2);
>  	else
> -- 
> 2.30.2
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
