Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id F28881BF5AE
	for <lists+kvmarm@lfdr.de>; Thu, 30 Apr 2020 12:38:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8D0944B54A;
	Thu, 30 Apr 2020 06:38:38 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xoLhfnbQD5yE; Thu, 30 Apr 2020 06:38:38 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3F9FA4B3E4;
	Thu, 30 Apr 2020 06:38:37 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 39FE24B392
 for <kvmarm@lists.cs.columbia.edu>; Thu, 30 Apr 2020 06:38:35 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pYGtVEzsMJwo for <kvmarm@lists.cs.columbia.edu>;
 Thu, 30 Apr 2020 06:38:34 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E05304B390
 for <kvmarm@lists.cs.columbia.edu>; Thu, 30 Apr 2020 06:38:33 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 714731063;
 Thu, 30 Apr 2020 03:38:33 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C3A5D3F68F;
 Thu, 30 Apr 2020 03:38:31 -0700 (PDT)
Date: Thu, 30 Apr 2020 11:38:28 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] KVM: arm64: Save/restore sp_el0 as part of __guest_enter
Message-ID: <20200430103828.GC39784@C02TD0UTHF1T.local>
References: <20200425094321.162752-1-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200425094321.162752-1-maz@kernel.org>
Cc: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu
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

On Sat, Apr 25, 2020 at 10:43:21AM +0100, Marc Zyngier wrote:
> We currently save/restore sp_el0 in C code. This is a bit unsafe,
> as a lot of the C code expects 'current' to be accessible from
> there (and the opportunity to run kernel code in HYP is specially
> great with VHE).
> 
> Instead, let's move the save/restore of sp_el0 to the assembly
> code (in __guest_enter), making sure that sp_el0 is correct
> very early on when we exit the guest, and is preserved as long
> as possible to its host value when we enter the guest.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Makes sense to me in principle, but I haven't reviewed the code in
detail:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/kvm/hyp/entry.S     | 23 +++++++++++++++++++++++
>  arch/arm64/kvm/hyp/sysreg-sr.c | 17 +++--------------
>  2 files changed, 26 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp/entry.S b/arch/arm64/kvm/hyp/entry.S
> index d22d0534dd600..90186cf6473e0 100644
> --- a/arch/arm64/kvm/hyp/entry.S
> +++ b/arch/arm64/kvm/hyp/entry.S
> @@ -18,6 +18,7 @@
>  
>  #define CPU_GP_REG_OFFSET(x)	(CPU_GP_REGS + x)
>  #define CPU_XREG_OFFSET(x)	CPU_GP_REG_OFFSET(CPU_USER_PT_REGS + 8*x)
> +#define CPU_SP_EL0_OFFSET	(CPU_XREG_OFFSET(30) + 8)
>  
>  	.text
>  	.pushsection	.hyp.text, "ax"
> @@ -47,6 +48,16 @@
>  	ldp	x29, lr,  [\ctxt, #CPU_XREG_OFFSET(29)]
>  .endm
>  
> +.macro save_sp_el0 ctxt, tmp
> +	mrs	\tmp,	sp_el0
> +	str	\tmp,	[\ctxt, #CPU_SP_EL0_OFFSET]
> +.endm
> +
> +.macro restore_sp_el0 ctxt, tmp
> +	ldr	\tmp,	  [\ctxt, #CPU_SP_EL0_OFFSET]
> +	msr	sp_el0, \tmp
> +.endm
> +
>  /*
>   * u64 __guest_enter(struct kvm_vcpu *vcpu,
>   *		     struct kvm_cpu_context *host_ctxt);
> @@ -60,6 +71,9 @@ SYM_FUNC_START(__guest_enter)
>  	// Store the host regs
>  	save_callee_saved_regs x1
>  
> +	// Save the host's sp_el0
> +	save_sp_el0	x1, x2
> +
>  	// Now the host state is stored if we have a pending RAS SError it must
>  	// affect the host. If any asynchronous exception is pending we defer
>  	// the guest entry. The DSB isn't necessary before v8.2 as any SError
> @@ -83,6 +97,9 @@ alternative_else_nop_endif
>  	// when this feature is enabled for kernel code.
>  	ptrauth_switch_to_guest x29, x0, x1, x2
>  
> +	// Restore the guest's sp_el0
> +	restore_sp_el0 x29, x0
> +
>  	// Restore guest regs x0-x17
>  	ldp	x0, x1,   [x29, #CPU_XREG_OFFSET(0)]
>  	ldp	x2, x3,   [x29, #CPU_XREG_OFFSET(2)]
> @@ -130,6 +147,9 @@ SYM_INNER_LABEL(__guest_exit, SYM_L_GLOBAL)
>  	// Store the guest regs x18-x29, lr
>  	save_callee_saved_regs x1
>  
> +	// Store the guest's sp_el0
> +	save_sp_el0	x1, x2
> +
>  	get_host_ctxt	x2, x3
>  
>  	// Macro ptrauth_switch_to_guest format:
> @@ -139,6 +159,9 @@ SYM_INNER_LABEL(__guest_exit, SYM_L_GLOBAL)
>  	// when this feature is enabled for kernel code.
>  	ptrauth_switch_to_host x1, x2, x3, x4, x5
>  
> +	// Restore the hosts's sp_el0
> +	restore_sp_el0 x2, x3
> +
>  	// Now restore the host regs
>  	restore_callee_saved_regs x2
>  
> diff --git a/arch/arm64/kvm/hyp/sysreg-sr.c b/arch/arm64/kvm/hyp/sysreg-sr.c
> index 75b1925763f16..6d2df9fe0b5d2 100644
> --- a/arch/arm64/kvm/hyp/sysreg-sr.c
> +++ b/arch/arm64/kvm/hyp/sysreg-sr.c
> @@ -15,8 +15,9 @@
>  /*
>   * Non-VHE: Both host and guest must save everything.
>   *
> - * VHE: Host and guest must save mdscr_el1 and sp_el0 (and the PC and pstate,
> - * which are handled as part of the el2 return state) on every switch.
> + * VHE: Host and guest must save mdscr_el1 and sp_el0 (and the PC and
> + * pstate, which are handled as part of the el2 return state) on every
> + * switch (sp_el0 is being dealt with in the assembly code).
>   * tpidr_el0 and tpidrro_el0 only need to be switched when going
>   * to host userspace or a different VCPU.  EL1 registers only need to be
>   * switched when potentially going to run a different VCPU.  The latter two
> @@ -26,12 +27,6 @@
>  static void __hyp_text __sysreg_save_common_state(struct kvm_cpu_context *ctxt)
>  {
>  	ctxt->sys_regs[MDSCR_EL1]	= read_sysreg(mdscr_el1);
> -
> -	/*
> -	 * The host arm64 Linux uses sp_el0 to point to 'current' and it must
> -	 * therefore be saved/restored on every entry/exit to/from the guest.
> -	 */
> -	ctxt->gp_regs.regs.sp		= read_sysreg(sp_el0);
>  }
>  
>  static void __hyp_text __sysreg_save_user_state(struct kvm_cpu_context *ctxt)
> @@ -99,12 +94,6 @@ NOKPROBE_SYMBOL(sysreg_save_guest_state_vhe);
>  static void __hyp_text __sysreg_restore_common_state(struct kvm_cpu_context *ctxt)
>  {
>  	write_sysreg(ctxt->sys_regs[MDSCR_EL1],	  mdscr_el1);
> -
> -	/*
> -	 * The host arm64 Linux uses sp_el0 to point to 'current' and it must
> -	 * therefore be saved/restored on every entry/exit to/from the guest.
> -	 */
> -	write_sysreg(ctxt->gp_regs.regs.sp,	  sp_el0);
>  }
>  
>  static void __hyp_text __sysreg_restore_user_state(struct kvm_cpu_context *ctxt)
> -- 
> 2.26.2
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
