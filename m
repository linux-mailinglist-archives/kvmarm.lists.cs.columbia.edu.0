Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id DDDE33E5910
	for <lists+kvmarm@lfdr.de>; Tue, 10 Aug 2021 13:27:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 52D3D4A4A4;
	Tue, 10 Aug 2021 07:27:59 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZjqEo9BWarbx; Tue, 10 Aug 2021 07:27:59 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4462840FC7;
	Tue, 10 Aug 2021 07:27:55 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DEDE34A1FA
 for <kvmarm@lists.cs.columbia.edu>; Tue, 10 Aug 2021 07:27:53 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OZoF4Q73v0b4 for <kvmarm@lists.cs.columbia.edu>;
 Tue, 10 Aug 2021 07:27:52 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 7089740FC7
 for <kvmarm@lists.cs.columbia.edu>; Tue, 10 Aug 2021 07:27:52 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5330760EBB;
 Tue, 10 Aug 2021 11:27:51 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1mDPvB-0042lI-6W; Tue, 10 Aug 2021 12:27:49 +0100
Date: Tue, 10 Aug 2021 12:27:48 +0100
Message-ID: <878s19bkuj.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v6 19/21] KVM: arm64: Emulate physical counter offsetting
 on non-ECV systems
In-Reply-To: <20210804085819.846610-20-oupton@google.com>
References: <20210804085819.846610-1-oupton@google.com>
 <20210804085819.846610-20-oupton@google.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: oupton@google.com, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, pbonzini@redhat.com, seanjc@google.com,
 pshier@google.com, jmattson@google.com, dmatlack@google.com,
 ricarkol@google.com, jingzhangos@google.com, rananta@google.com,
 james.morse@arm.com, alexandru.elisei@arm.com, suzuki.poulose@arm.com,
 linux-arm-kernel@lists.infradead.org, drjones@redhat.com, will@kernel.org,
 catalin.marinas@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Catalin Marinas <catalin.marinas@arm.com>, kvm@vger.kernel.org,
 Will Deacon <will@kernel.org>, Sean Christopherson <seanjc@google.com>,
 Peter Shier <pshier@google.com>, Raghavendra Rao Anata <rananta@google.com>,
 David Matlack <dmatlack@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
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

On Wed, 04 Aug 2021 09:58:17 +0100,
Oliver Upton <oupton@google.com> wrote:
> 
> Unfortunately, ECV hasn't yet arrived in any tangible hardware. At the
> same time, controlling the guest view of the physical counter-timer is
> useful. Support guest counter-timer offsetting on non-ECV systems by
> trapping guest accesses to the physical counter-timer. Emulate reads of
> the physical counter in the fast exit path.
> 
> Signed-off-by: Oliver Upton <oupton@google.com>
> ---
>  arch/arm64/include/asm/sysreg.h         |  1 +
>  arch/arm64/kvm/arch_timer.c             | 53 +++++++++++++++----------
>  arch/arm64/kvm/hyp/include/hyp/switch.h | 29 ++++++++++++++
>  arch/arm64/kvm/hyp/nvhe/timer-sr.c      | 11 ++++-
>  4 files changed, 70 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index c34672aa65b9..e49790ae5da4 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -505,6 +505,7 @@
>  #define SYS_AMEVCNTR0_MEM_STALL		SYS_AMEVCNTR0_EL0(3)
>  
>  #define SYS_CNTFRQ_EL0			sys_reg(3, 3, 14, 0, 0)
> +#define SYS_CNTPCT_EL0			sys_reg(3, 3, 14, 0, 1)
>  
>  #define SYS_CNTP_TVAL_EL0		sys_reg(3, 3, 14, 2, 0)
>  #define SYS_CNTP_CTL_EL0		sys_reg(3, 3, 14, 2, 1)
> diff --git a/arch/arm64/kvm/arch_timer.c b/arch/arm64/kvm/arch_timer.c
> index 9ead94aa867d..b7cb63acf2a0 100644
> --- a/arch/arm64/kvm/arch_timer.c
> +++ b/arch/arm64/kvm/arch_timer.c
> @@ -51,7 +51,7 @@ static void kvm_arm_timer_write(struct kvm_vcpu *vcpu,
>  static u64 kvm_arm_timer_read(struct kvm_vcpu *vcpu,
>  			      struct arch_timer_context *timer,
>  			      enum kvm_arch_timer_regs treg);
> -static void kvm_timer_enable_traps_vhe(void);
> +static void kvm_timer_enable_traps_vhe(struct kvm_vcpu *vcpu);
>  
>  u32 timer_get_ctl(struct arch_timer_context *ctxt)
>  {
> @@ -175,6 +175,12 @@ static void timer_set_guest_offset(struct arch_timer_context *ctxt, u64 offset)
>  	}
>  }
>  
> +static bool ptimer_emulation_required(struct kvm_vcpu *vcpu)
> +{
> +	return timer_get_offset(vcpu_ptimer(vcpu)) &&
> +			!cpus_have_const_cap(ARM64_ECV);

What Andrew said! :-)

> +}
> +
>  u64 kvm_phys_timer_read(void)
>  {
>  	return timecounter->cc->read(timecounter->cc);
> @@ -184,8 +190,13 @@ static void get_timer_map(struct kvm_vcpu *vcpu, struct timer_map *map)
>  {
>  	if (has_vhe()) {
>  		map->direct_vtimer = vcpu_vtimer(vcpu);
> -		map->direct_ptimer = vcpu_ptimer(vcpu);
> -		map->emul_ptimer = NULL;
> +		if (!ptimer_emulation_required(vcpu)) {
> +			map->direct_ptimer = vcpu_ptimer(vcpu);
> +			map->emul_ptimer = NULL;
> +		} else {
> +			map->direct_ptimer = NULL;
> +			map->emul_ptimer = vcpu_ptimer(vcpu);
> +		}
>  	} else {
>  		map->direct_vtimer = vcpu_vtimer(vcpu);
>  		map->direct_ptimer = NULL;
> @@ -671,7 +682,7 @@ void kvm_timer_vcpu_load(struct kvm_vcpu *vcpu)
>  		timer_emulate(map.emul_ptimer);
>  
>  	if (has_vhe())
> -		kvm_timer_enable_traps_vhe();
> +		kvm_timer_enable_traps_vhe(vcpu);
>  }
>  
>  bool kvm_timer_should_notify_user(struct kvm_vcpu *vcpu)
> @@ -1392,22 +1403,29 @@ int kvm_timer_enable(struct kvm_vcpu *vcpu)
>   * The host kernel runs at EL2 with HCR_EL2.TGE == 1,
>   * and this makes those bits have no effect for the host kernel execution.
>   */
> -static void kvm_timer_enable_traps_vhe(void)
> +static void kvm_timer_enable_traps_vhe(struct kvm_vcpu *vcpu)
>  {
>  	/* When HCR_EL2.E2H ==1, EL1PCEN and EL1PCTEN are shifted by 10 */
>  	u32 cnthctl_shift = 10;
> -	u64 val;
> +	u64 val, mask;
> +
> +	mask = CNTHCTL_EL1PCEN << cnthctl_shift;
> +	mask |= CNTHCTL_EL1PCTEN << cnthctl_shift;
>  
> -	/*
> -	 * VHE systems allow the guest direct access to the EL1 physical
> -	 * timer/counter.
> -	 */
>  	val = read_sysreg(cnthctl_el2);
> -	val |= (CNTHCTL_EL1PCEN << cnthctl_shift);
> -	val |= (CNTHCTL_EL1PCTEN << cnthctl_shift);
>  
>  	if (cpus_have_const_cap(ARM64_ECV))
>  		val |= CNTHCTL_ECV;
> +
> +	/*
> +	 * VHE systems allow the guest direct access to the EL1 physical
> +	 * timer/counter if offsetting isn't requested on a non-ECV system.
> +	 */
> +	if (ptimer_emulation_required(vcpu))
> +		val &= ~mask;
> +	else
> +		val |= mask;
> +
>  	write_sysreg(val, cnthctl_el2);
>  }
>  
> @@ -1462,9 +1480,6 @@ static int kvm_arm_timer_set_attr_offset(struct kvm_vcpu *vcpu,
>  	u64 __user *uaddr = (u64 __user *)(long)attr->addr;
>  	u64 offset;
>  
> -	if (!cpus_have_const_cap(ARM64_ECV))
> -		return -ENXIO;
> -
>  	if (get_user(offset, uaddr))
>  		return -EFAULT;
>  
> @@ -1513,9 +1528,6 @@ static int kvm_arm_timer_get_attr_offset(struct kvm_vcpu *vcpu,
>  	u64 __user *uaddr = (u64 __user *)(long)attr->addr;
>  	u64 offset;
>  
> -	if (!cpus_have_const_cap(ARM64_ECV))
> -		return -ENXIO;
> -
>  	offset = timer_get_offset(vcpu_ptimer(vcpu));
>  	return put_user(offset, uaddr);
>  }
> @@ -1539,11 +1551,8 @@ int kvm_arm_timer_has_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
>  	switch (attr->attr) {
>  	case KVM_ARM_VCPU_TIMER_IRQ_VTIMER:
>  	case KVM_ARM_VCPU_TIMER_IRQ_PTIMER:
> -		return 0;
>  	case KVM_ARM_VCPU_TIMER_OFFSET:
> -		if (cpus_have_const_cap(ARM64_ECV))
> -			return 0;
> -		break;
> +		return 0;
>  	}
>  
>  	return -ENXIO;
> diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
> index e4a2f295a394..abd3813a709e 100644
> --- a/arch/arm64/kvm/hyp/include/hyp/switch.h
> +++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
> @@ -15,6 +15,7 @@
>  #include <linux/jump_label.h>
>  #include <uapi/linux/psci.h>
>  
> +#include <kvm/arm_arch_timer.h>
>  #include <kvm/arm_psci.h>
>  
>  #include <asm/barrier.h>
> @@ -405,6 +406,31 @@ static inline bool __hyp_handle_ptrauth(struct kvm_vcpu *vcpu)
>  	return true;
>  }
>  
> +static inline u64 __timer_read_cntpct(struct kvm_vcpu *vcpu)
> +{
> +	return __arch_counter_get_cntpct() - vcpu_ptimer(vcpu)->host_offset;
> +}
> +
> +static inline bool __hyp_handle_counter(struct kvm_vcpu *vcpu)
> +{
> +	u32 sysreg;
> +	int rt;
> +	u64 rv;

You could start with a

	if (cpus_have_final_cap(ARM64_ECV))
		return false;

which will speed-up the exit on ECV-capable systems.

> +
> +	if (kvm_vcpu_trap_get_class(vcpu) != ESR_ELx_EC_SYS64)
> +		return false;
> +
> +	sysreg = esr_sys64_to_sysreg(kvm_vcpu_get_esr(vcpu));
> +	if (sysreg != SYS_CNTPCT_EL0)
> +		return false;

You also want to check for CNTPCTSS_EL0 which will also be caught by
this trap.

> +
> +	rt = kvm_vcpu_sys_get_rt(vcpu);
> +	rv = __timer_read_cntpct(vcpu);
> +	vcpu_set_reg(vcpu, rt, rv);
> +	__kvm_skip_instr(vcpu);
> +	return true;
> +}
> +
>  /*
>   * Return true when we were able to fixup the guest exit and should return to
>   * the guest, false when we should restore the host state and return to the
> @@ -439,6 +465,9 @@ static inline bool fixup_guest_exit(struct kvm_vcpu *vcpu, u64 *exit_code)
>  	if (*exit_code != ARM_EXCEPTION_TRAP)
>  		goto exit;
>  
> +	if (__hyp_handle_counter(vcpu))
> +		goto guest;
> +
>  	if (cpus_have_final_cap(ARM64_WORKAROUND_CAVIUM_TX2_219_TVM) &&
>  	    kvm_vcpu_trap_get_class(vcpu) == ESR_ELx_EC_SYS64 &&
>  	    handle_tx2_tvm(vcpu))
> diff --git a/arch/arm64/kvm/hyp/nvhe/timer-sr.c b/arch/arm64/kvm/hyp/nvhe/timer-sr.c
> index 5b8b4cd02506..67236c2e0ba7 100644
> --- a/arch/arm64/kvm/hyp/nvhe/timer-sr.c
> +++ b/arch/arm64/kvm/hyp/nvhe/timer-sr.c
> @@ -44,10 +44,17 @@ void __timer_enable_traps(struct kvm_vcpu *vcpu)
>  
>  	/*
>  	 * Disallow physical timer access for the guest
> -	 * Physical counter access is allowed
>  	 */
>  	val = read_sysreg(cnthctl_el2);
>  	val &= ~CNTHCTL_EL1PCEN;
> -	val |= CNTHCTL_EL1PCTEN;
> +
> +	/*
> +	 * Disallow physical counter access for the guest if offsetting is
> +	 * requested on a non-ECV system.
> +	 */
> +	if (vcpu_ptimer(vcpu)->host_offset && !cpus_have_const_cap(ARM64_ECV))
> +		val &= ~CNTHCTL_EL1PCTEN;
> +	else
> +		val |= CNTHCTL_EL1PCTEN;
>  	write_sysreg(val, cnthctl_el2);
>  }

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
