Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 58A6E4C2B50
	for <lists+kvmarm@lfdr.de>; Thu, 24 Feb 2022 12:59:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7F8AD4BFF2;
	Thu, 24 Feb 2022 06:59:03 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 required=6.1 tests=[BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id siNRd0VByWCD; Thu, 24 Feb 2022 06:59:03 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A708F4BFD7;
	Thu, 24 Feb 2022 06:59:01 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 745A44BF94
 for <kvmarm@lists.cs.columbia.edu>; Thu, 24 Feb 2022 06:59:00 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uiB-yGCFmOZr for <kvmarm@lists.cs.columbia.edu>;
 Thu, 24 Feb 2022 06:58:58 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A7F084BF90
 for <kvmarm@lists.cs.columbia.edu>; Thu, 24 Feb 2022 06:58:58 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0387106F;
 Thu, 24 Feb 2022 03:58:57 -0800 (PST)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B67193F66F;
 Thu, 24 Feb 2022 03:58:53 -0800 (PST)
Date: Thu, 24 Feb 2022 11:59:18 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v6 39/64] KVM: arm64: nv: Set a handler for the system
 instruction traps
Message-ID: <YhdzFk75J/dFW0Tl@monolith.localdoman>
References: <20220128121912.509006-1-maz@kernel.org>
 <20220128121912.509006-40-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220128121912.509006-40-maz@kernel.org>
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

On Fri, Jan 28, 2022 at 12:18:47PM +0000, Marc Zyngier wrote:
> From: Jintack Lim <jintack.lim@linaro.org>
> 
> When HCR.NV bit is set, execution of the EL2 translation regime address
> aranslation instructions and TLB maintenance instructions are trapped to
> EL2. In addition, execution of the EL1 translation regime address
> aranslation instructions and TLB maintenance instructions that are only
> accessible from EL2 and above are trapped to EL2. In these cases,
> ESR_EL2.EC will be set to 0x18.
> 
> Rework the system instruction emulation framework to handle potentially
> all system instruction traps other than MSR/MRS instructions. Those
> system instructions would be AT and TLBI instructions controlled by
> HCR_EL2.NV, AT, and TTLB bits.
> 
> Signed-off-by: Jintack Lim <jintack.lim@linaro.org>
> [maz: squashed two patches together, redispatched various bits around]
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/include/asm/kvm_host.h |  4 +--
>  arch/arm64/kvm/handle_exit.c      |  2 +-
>  arch/arm64/kvm/sys_regs.c         | 48 +++++++++++++++++++++++++------
>  3 files changed, 42 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index a15183d0e1bf..0b887364f994 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -407,7 +407,7 @@ struct kvm_vcpu_arch {
>  	/*
>  	 * Guest registers we preserve during guest debugging.
>  	 *
> -	 * These shadow registers are updated by the kvm_handle_sys_reg
> +	 * These shadow registers are updated by the kvm_handle_sys
>  	 * trap handler if the guest accesses or updates them while we
>  	 * are using guest debug.
>  	 */
> @@ -724,7 +724,7 @@ int kvm_handle_cp14_32(struct kvm_vcpu *vcpu);
>  int kvm_handle_cp14_64(struct kvm_vcpu *vcpu);
>  int kvm_handle_cp15_32(struct kvm_vcpu *vcpu);
>  int kvm_handle_cp15_64(struct kvm_vcpu *vcpu);
> -int kvm_handle_sys_reg(struct kvm_vcpu *vcpu);
> +int kvm_handle_sys(struct kvm_vcpu *vcpu);
>  
>  void kvm_reset_sys_regs(struct kvm_vcpu *vcpu);
>  
> diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
> index 867de65eb766..d135fc7e6883 100644
> --- a/arch/arm64/kvm/handle_exit.c
> +++ b/arch/arm64/kvm/handle_exit.c
> @@ -236,7 +236,7 @@ static exit_handle_fn arm_exit_handlers[] = {
>  	[ESR_ELx_EC_SMC32]	= handle_smc,
>  	[ESR_ELx_EC_HVC64]	= handle_hvc,
>  	[ESR_ELx_EC_SMC64]	= handle_smc,
> -	[ESR_ELx_EC_SYS64]	= kvm_handle_sys_reg,
> +	[ESR_ELx_EC_SYS64]	= kvm_handle_sys,
>  	[ESR_ELx_EC_SVE]	= handle_sve,
>  	[ESR_ELx_EC_ERET]	= kvm_handle_eret,
>  	[ESR_ELx_EC_IABT_LOW]	= kvm_handle_guest_abort,
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 5e8876177ce6..f669618f966b 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -1771,10 +1771,6 @@ static bool access_spsr_el2(struct kvm_vcpu *vcpu,
>   * more demanding guest...
>   */
>  static const struct sys_reg_desc sys_reg_descs[] = {
> -	{ SYS_DESC(SYS_DC_ISW), access_dcsw },
> -	{ SYS_DESC(SYS_DC_CSW), access_dcsw },
> -	{ SYS_DESC(SYS_DC_CISW), access_dcsw },
> -
>  	DBG_BCR_BVR_WCR_WVR_EL1(0),
>  	DBG_BCR_BVR_WCR_WVR_EL1(1),
>  	{ SYS_DESC(SYS_MDCCINT_EL1), trap_debug_regs, reset_val, MDCCINT_EL1, 0 },
> @@ -2240,6 +2236,14 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>  	EL2_REG(SP_EL2, NULL, reset_unknown, 0),
>  };
>  
> +#define SYS_INSN_TO_DESC(insn, access_fn, forward_fn)	\
> +	{ SYS_DESC((insn)), (access_fn), NULL, 0, 0, NULL, NULL, (forward_fn) }

This macro looks out of place: it's not used anywhere in this patch, and the
next patch deletes it.

> +static struct sys_reg_desc sys_insn_descs[] = {
> +	{ SYS_DESC(SYS_DC_ISW), access_dcsw },
> +	{ SYS_DESC(SYS_DC_CSW), access_dcsw },
> +	{ SYS_DESC(SYS_DC_CISW), access_dcsw },
> +};
> +
>  static bool trap_dbgdidr(struct kvm_vcpu *vcpu,
>  			struct sys_reg_params *p,
>  			const struct sys_reg_desc *r)
> @@ -2786,6 +2790,24 @@ static int emulate_sys_reg(struct kvm_vcpu *vcpu,
>  	return 1;
>  }
>  
> +static int emulate_sys_instr(struct kvm_vcpu *vcpu, struct sys_reg_params *p)
> +{
> +	const struct sys_reg_desc *r;
> +
> +	/* Search from the system instruction table. */
> +	r = find_reg(p, sys_insn_descs, ARRAY_SIZE(sys_insn_descs));
> +
> +	if (likely(r)) {
> +		perform_access(vcpu, p, r);
> +	} else {
> +		kvm_err("Unsupported guest sys instruction at: %lx\n",
> +			*vcpu_pc(vcpu));
> +		print_sys_reg_instr(p);
> +		kvm_inject_undefined(vcpu);
> +	}
> +	return 1;
> +}
> +
>  /**
>   * kvm_reset_sys_regs - sets system registers to reset value
>   * @vcpu: The VCPU pointer
> @@ -2803,10 +2825,11 @@ void kvm_reset_sys_regs(struct kvm_vcpu *vcpu)
>  }
>  
>  /**
> - * kvm_handle_sys_reg -- handles a mrs/msr trap on a guest sys_reg access
> + * kvm_handle_sys-- handles a system instruction or mrs/msr instruction trap
> +		    on a guest execution
>   * @vcpu: The VCPU pointer
>   */
> -int kvm_handle_sys_reg(struct kvm_vcpu *vcpu)
> +int kvm_handle_sys(struct kvm_vcpu *vcpu)
>  {
>  	struct sys_reg_params params;
>  	unsigned long esr = kvm_vcpu_get_esr(vcpu);
> @@ -2818,10 +2841,16 @@ int kvm_handle_sys_reg(struct kvm_vcpu *vcpu)
>  	params = esr_sys64_to_params(esr);
>  	params.regval = vcpu_get_reg(vcpu, Rt);
>  
> -	ret = emulate_sys_reg(vcpu, &params);
> +	if (params.Op0 == 1) {
> +		/* System instructions */
> +		ret = emulate_sys_instr(vcpu, &params);
> +	} else {

This doesn't look right: according to ARM DDI 0487G.a, page C5-393, Op0 =
{0,2} represents instruction classes different from system register
accesses, yet KVM puts them in the same bucket as system register traps.

May I suggest this change:

	if (params.Op0 == 3) {
		/* do emulate_sys_reg() */
	} else {
		/* do emulate_sys_instr() */
	}

Thanks,
Alex

> +		/* MRS/MSR instructions */
> +		ret = emulate_sys_reg(vcpu, &params);
> +		if (!params.is_write)
> +			vcpu_set_reg(vcpu, Rt, params.regval);
> +	}
>  
> -	if (!params.is_write)
> -		vcpu_set_reg(vcpu, Rt, params.regval);
>  	return ret;
>  }
>  
> @@ -3237,6 +3266,7 @@ void kvm_sys_reg_table_init(void)
>  	BUG_ON(check_sysreg_table(cp15_regs, ARRAY_SIZE(cp15_regs), true));
>  	BUG_ON(check_sysreg_table(cp15_64_regs, ARRAY_SIZE(cp15_64_regs), true));
>  	BUG_ON(check_sysreg_table(invariant_sys_regs, ARRAY_SIZE(invariant_sys_regs), false));
> +	BUG_ON(check_sysreg_table(sys_insn_descs, ARRAY_SIZE(sys_insn_descs), false));
>  
>  	/* We abuse the reset function to overwrite the table itself. */
>  	for (i = 0; i < ARRAY_SIZE(invariant_sys_regs); i++)
> -- 
> 2.30.2
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
