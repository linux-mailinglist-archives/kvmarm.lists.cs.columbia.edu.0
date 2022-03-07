Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 075CD4D039B
	for <lists+kvmarm@lfdr.de>; Mon,  7 Mar 2022 17:00:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5FA9A4B1FB;
	Mon,  7 Mar 2022 11:00:56 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 required=6.1 tests=[BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IWTzGysttDCp; Mon,  7 Mar 2022 11:00:56 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A3F394B1EC;
	Mon,  7 Mar 2022 11:00:54 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EEB2C4B1C4
 for <kvmarm@lists.cs.columbia.edu>; Mon,  7 Mar 2022 11:00:52 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YpVwM8ILmQlg for <kvmarm@lists.cs.columbia.edu>;
 Mon,  7 Mar 2022 11:00:51 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 45D334B19F
 for <kvmarm@lists.cs.columbia.edu>; Mon,  7 Mar 2022 11:00:51 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4339152B;
 Mon,  7 Mar 2022 08:00:50 -0800 (PST)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B3BD63F766;
 Mon,  7 Mar 2022 08:00:47 -0800 (PST)
Date: Mon, 7 Mar 2022 16:01:09 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v6 44/64] KVM: arm64: nv: Add handling of EL2-specific
 timer registers
Message-ID: <YiYp8LIutmtfQiqg@monolith.localdoman>
References: <20220128121912.509006-1-maz@kernel.org>
 <20220128121912.509006-45-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220128121912.509006-45-maz@kernel.org>
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

On Fri, Jan 28, 2022 at 12:18:52PM +0000, Marc Zyngier wrote:
> Add the required handling for EL2 and EL02 registers, as
> well as EL1 registers used in the E2H context.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/include/asm/sysreg.h |  6 +++
>  arch/arm64/kvm/sys_regs.c       | 87 +++++++++++++++++++++++++++++++++
>  2 files changed, 93 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 41c3603a3f29..ff6d3af8ed34 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -626,6 +626,12 @@
>  
>  #define SYS_CNTVOFF_EL2			sys_reg(3, 4, 14, 0, 3)
>  #define SYS_CNTHCTL_EL2			sys_reg(3, 4, 14, 1, 0)
> +#define SYS_CNTHP_TVAL_EL2		sys_reg(3, 4, 14, 2, 0)
> +#define SYS_CNTHP_CTL_EL2		sys_reg(3, 4, 14, 2, 1)
> +#define SYS_CNTHP_CVAL_EL2		sys_reg(3, 4, 14, 2, 2)
> +#define SYS_CNTHV_TVAL_EL2		sys_reg(3, 4, 14, 3, 0)
> +#define SYS_CNTHV_CTL_EL2		sys_reg(3, 4, 14, 3, 1)
> +#define SYS_CNTHV_CVAL_EL2		sys_reg(3, 4, 14, 3, 2)
>  
>  /* VHE encodings for architectural EL0/1 system registers */
>  #define SYS_SCTLR_EL12			sys_reg(3, 5, 1, 0, 0)
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index bbc58930a5eb..f2452e76156c 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -1274,20 +1274,92 @@ static bool access_arch_timer(struct kvm_vcpu *vcpu,
>  
>  	switch (reg) {
>  	case SYS_CNTP_TVAL_EL0:
> +		if (vcpu_is_el2(vcpu) && vcpu_el2_e2h_is_set(vcpu))

According to ARM DDI 0487G.a, page D13-4157, if PSTATE is EL0 then accesses are
also redirected to CNTHP_TVAL_EL2 (under certain conditions).

> +			tmr = TIMER_HPTIMER;
> +		else
> +			tmr = TIMER_PTIMER;

What happens when the guest hypervisor has enabled traps for this register?
Shouldn't those also be forwarded?

> +		treg = TIMER_REG_TVAL;
> +		break;
> +
>  	case SYS_AARCH32_CNTP_TVAL:
> +	case SYS_CNTP_TVAL_EL02:

Shouldn't KVM inject an undefined exception if PSTATE is EL2 and virtual
HCR_EL2.E2H = 0? Shouldn't KVM forward the trap if PSTATE is EL1 and virtual
HCR_EL2.NV = 1? The same applies to all EL02 encodings.

>  		tmr = TIMER_PTIMER;
>  		treg = TIMER_REG_TVAL;
>  		break;
> +
> +	case SYS_CNTV_TVAL_EL02:
> +		tmr = TIMER_VTIMER;
> +		treg = TIMER_REG_TVAL;
> +		break;
> +
> +	case SYS_CNTHP_TVAL_EL2:
> +		tmr = TIMER_HPTIMER;
> +		treg = TIMER_REG_TVAL;
> +		break;
> +
> +	case SYS_CNTHV_TVAL_EL2:
> +		tmr = TIMER_HVTIMER;
> +		treg = TIMER_REG_TVAL;

Shouldn't KVM inject an undefined exception if guest PSTATE is EL1 and virtual
HCR_EL2.NV = 0? Shouldn't KVM forward the trap if PSTATE is EL1 and
HCR_EL2.NV = 1? Same for the other _EL2 registers.

Thanks,
Alex

> +		break;
> +
>  	case SYS_CNTP_CTL_EL0:
> +		if (vcpu_is_el2(vcpu) && vcpu_el2_e2h_is_set(vcpu))
> +			tmr = TIMER_HPTIMER;
> +		else
> +			tmr = TIMER_PTIMER;
> +		treg = TIMER_REG_CTL;
> +		break;
> +
>  	case SYS_AARCH32_CNTP_CTL:
> +	case SYS_CNTP_CTL_EL02:
>  		tmr = TIMER_PTIMER;
>  		treg = TIMER_REG_CTL;
>  		break;
> +
> +	case SYS_CNTV_CTL_EL02:
> +		tmr = TIMER_VTIMER;
> +		treg = TIMER_REG_CTL;
> +		break;
> +
> +	case SYS_CNTHP_CTL_EL2:
> +		tmr = TIMER_HPTIMER;
> +		treg = TIMER_REG_CTL;
> +		break;
> +
> +	case SYS_CNTHV_CTL_EL2:
> +		tmr = TIMER_HVTIMER;
> +		treg = TIMER_REG_CTL;
> +		break;
> +
>  	case SYS_CNTP_CVAL_EL0:
> +		if (vcpu_is_el2(vcpu) && vcpu_el2_e2h_is_set(vcpu))
> +			tmr = TIMER_HPTIMER;
> +		else
> +			tmr = TIMER_PTIMER;
> +		treg = TIMER_REG_CVAL;
> +		break;
> +
>  	case SYS_AARCH32_CNTP_CVAL:
> +	case SYS_CNTP_CVAL_EL02:
>  		tmr = TIMER_PTIMER;
>  		treg = TIMER_REG_CVAL;
>  		break;
> +
> +	case SYS_CNTV_CVAL_EL02:
> +		tmr = TIMER_VTIMER;
> +		treg = TIMER_REG_CVAL;
> +		break;
> +
> +	case SYS_CNTHP_CVAL_EL2:
> +		tmr = TIMER_HPTIMER;
> +		treg = TIMER_REG_CVAL;
> +		break;
> +
> +	case SYS_CNTHV_CVAL_EL2:
> +		tmr = TIMER_HVTIMER;
> +		treg = TIMER_REG_CVAL;
> +		break;
> +
>  	case SYS_CNTVOFF_EL2:
>  		tmr = TIMER_VTIMER;
>  		treg = TIMER_REG_VOFF;
> @@ -2220,6 +2292,13 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>  	{ SYS_DESC(SYS_CNTVOFF_EL2), access_arch_timer },
>  	EL2_REG(CNTHCTL_EL2, access_rw, reset_val, 0),
>  
> +	{ SYS_DESC(SYS_CNTHP_TVAL_EL2), access_arch_timer },
> +	{ SYS_DESC(SYS_CNTHP_CTL_EL2), access_arch_timer },
> +	{ SYS_DESC(SYS_CNTHP_CVAL_EL2), access_arch_timer },
> +	{ SYS_DESC(SYS_CNTHV_TVAL_EL2), access_arch_timer },
> +	{ SYS_DESC(SYS_CNTHV_CTL_EL2), access_arch_timer },
> +	{ SYS_DESC(SYS_CNTHV_CVAL_EL2), access_arch_timer },
> +
>  	EL12_REG(SCTLR, access_vm_reg, reset_val, 0x00C50078),
>  	EL12_REG(CPACR, access_rw, reset_val, 0),
>  	EL12_REG(TTBR0, access_vm_reg, reset_unknown, 0),
> @@ -2237,6 +2316,14 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>  	EL12_REG(CONTEXTIDR, access_vm_reg, reset_val, 0),
>  	EL12_REG(CNTKCTL, access_rw, reset_val, 0),
>  
> +	{ SYS_DESC(SYS_CNTP_TVAL_EL02), access_arch_timer },
> +	{ SYS_DESC(SYS_CNTP_CTL_EL02), access_arch_timer },
> +	{ SYS_DESC(SYS_CNTP_CVAL_EL02), access_arch_timer },
> +
> +	{ SYS_DESC(SYS_CNTV_TVAL_EL02), access_arch_timer },
> +	{ SYS_DESC(SYS_CNTV_CTL_EL02), access_arch_timer },
> +	{ SYS_DESC(SYS_CNTV_CVAL_EL02), access_arch_timer },
> +
>  	EL2_REG(SP_EL2, NULL, reset_unknown, 0),
>  };
>  
> -- 
> 2.30.2
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
