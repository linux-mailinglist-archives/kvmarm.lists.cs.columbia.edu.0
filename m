Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 269004D01F9
	for <lists+kvmarm@lfdr.de>; Mon,  7 Mar 2022 15:52:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 70B134B27B;
	Mon,  7 Mar 2022 09:52:33 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 required=6.1 tests=[BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JUDZEZWEs+E6; Mon,  7 Mar 2022 09:52:33 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1A27E4B201;
	Mon,  7 Mar 2022 09:52:31 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DAC9B4B0BA
 for <kvmarm@lists.cs.columbia.edu>; Mon,  7 Mar 2022 09:52:29 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IrueEmQz0+Ed for <kvmarm@lists.cs.columbia.edu>;
 Mon,  7 Mar 2022 09:52:27 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 98F774B0B9
 for <kvmarm@lists.cs.columbia.edu>; Mon,  7 Mar 2022 09:52:27 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ECB4E113E;
 Mon,  7 Mar 2022 06:52:26 -0800 (PST)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C1CC3F66F;
 Mon,  7 Mar 2022 06:52:22 -0800 (PST)
Date: Mon, 7 Mar 2022 14:52:44 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v6 43/64] KVM: arm64: nv: arch_timer: Support hyp timer
 emulation
Message-ID: <YiYcLIhdo5fQFbSA@monolith.localdoman>
References: <20220128121912.509006-1-maz@kernel.org>
 <20220128121912.509006-44-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220128121912.509006-44-maz@kernel.org>
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

I was under the impression that KVM's nested virtualization doesn't support
AArch32 in the guest, why is the subject about hyp mode aarch32 timers?

On Fri, Jan 28, 2022 at 12:18:51PM +0000, Marc Zyngier wrote:
> From: Christoffer Dall <christoffer.dall@arm.com>
> 
> Emulating EL2 also means emulating the EL2 timers. To do so, we expand
> our timer framework to deal with at most 4 timers. At any given time,
> two timers are using the HW timers, and the two others are purely
> emulated.
> 
> The role of deciding which is which at any given time is left to a
> mapping function which is called every time we need to make such a
> decision.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
> [maz: added CNTVOFF support, general reworking for v4.8]
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/include/asm/kvm_host.h |   4 +
>  arch/arm64/kvm/arch_timer.c       | 165 ++++++++++++++++++++++++++++--
>  arch/arm64/kvm/sys_regs.c         |   7 +-
>  arch/arm64/kvm/trace_arm.h        |   6 +-
>  arch/arm64/kvm/vgic/vgic.c        |  15 +++
>  include/kvm/arm_arch_timer.h      |   8 +-
>  include/kvm/arm_vgic.h            |   1 +
>  7 files changed, 194 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 0b887364f994..03833eca3307 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -285,6 +285,10 @@ enum vcpu_sysreg {
>  	TPIDR_EL2,	/* EL2 Software Thread ID Register */
>  	CNTHCTL_EL2,	/* Counter-timer Hypervisor Control register */
>  	SP_EL2,		/* EL2 Stack Pointer */
> +	CNTHP_CTL_EL2,
> +	CNTHP_CVAL_EL2,
> +	CNTHV_CTL_EL2,
> +	CNTHV_CVAL_EL2,
>  
>  	NR_SYS_REGS	/* Nothing after this line! */
>  };
> diff --git a/arch/arm64/kvm/arch_timer.c b/arch/arm64/kvm/arch_timer.c
> index 6e542e2eae32..5e4f93605d36 100644
> --- a/arch/arm64/kvm/arch_timer.c
> +++ b/arch/arm64/kvm/arch_timer.c
> @@ -16,6 +16,7 @@
>  #include <asm/arch_timer.h>
>  #include <asm/kvm_emulate.h>
>  #include <asm/kvm_hyp.h>
> +#include <asm/kvm_nested.h>
>  
>  #include <kvm/arm_vgic.h>
>  #include <kvm/arm_arch_timer.h>
> @@ -40,6 +41,16 @@ static const struct kvm_irq_level default_vtimer_irq = {
>  	.level	= 1,
>  };
>  
> +static const struct kvm_irq_level default_hptimer_irq = {
> +	.irq	= 26,
> +	.level	= 1,
> +};
> +
> +static const struct kvm_irq_level default_hvtimer_irq = {
> +	.irq	= 28,
> +	.level	= 1,
> +};
> +
>  static bool kvm_timer_irq_can_fire(struct arch_timer_context *timer_ctx);
>  static void kvm_timer_update_irq(struct kvm_vcpu *vcpu, bool new_level,
>  				 struct arch_timer_context *timer_ctx);
> @@ -51,6 +62,11 @@ static void kvm_arm_timer_write(struct kvm_vcpu *vcpu,
>  static u64 kvm_arm_timer_read(struct kvm_vcpu *vcpu,
>  			      struct arch_timer_context *timer,
>  			      enum kvm_arch_timer_regs treg);
> +static bool kvm_arch_timer_get_input_level(int vintid);
> +
> +static struct irq_ops arch_timer_irq_ops = {
> +	.get_input_level = kvm_arch_timer_get_input_level,
> +};
>  
>  u32 timer_get_ctl(struct arch_timer_context *ctxt)
>  {
> @@ -61,6 +77,10 @@ u32 timer_get_ctl(struct arch_timer_context *ctxt)
>  		return __vcpu_sys_reg(vcpu, CNTV_CTL_EL0);
>  	case TIMER_PTIMER:
>  		return __vcpu_sys_reg(vcpu, CNTP_CTL_EL0);
> +	case TIMER_HVTIMER:
> +		return __vcpu_sys_reg(vcpu, CNTHV_CTL_EL2);
> +	case TIMER_HPTIMER:
> +		return __vcpu_sys_reg(vcpu, CNTHP_CTL_EL2);
>  	default:
>  		WARN_ON(1);
>  		return 0;
> @@ -76,6 +96,10 @@ u64 timer_get_cval(struct arch_timer_context *ctxt)
>  		return __vcpu_sys_reg(vcpu, CNTV_CVAL_EL0);
>  	case TIMER_PTIMER:
>  		return __vcpu_sys_reg(vcpu, CNTP_CVAL_EL0);
> +	case TIMER_HVTIMER:
> +		return __vcpu_sys_reg(vcpu, CNTHV_CVAL_EL2);
> +	case TIMER_HPTIMER:
> +		return __vcpu_sys_reg(vcpu, CNTHP_CVAL_EL2);
>  	default:
>  		WARN_ON(1);
>  		return 0;
> @@ -105,6 +129,12 @@ static void timer_set_ctl(struct arch_timer_context *ctxt, u32 ctl)
>  	case TIMER_PTIMER:
>  		__vcpu_sys_reg(vcpu, CNTP_CTL_EL0) = ctl;
>  		break;
> +	case TIMER_HVTIMER:
> +		__vcpu_sys_reg(vcpu, CNTHV_CTL_EL2) = ctl;
> +		break;
> +	case TIMER_HPTIMER:
> +		__vcpu_sys_reg(vcpu, CNTHP_CTL_EL2) = ctl;
> +		break;
>  	default:
>  		WARN_ON(1);
>  	}
> @@ -121,6 +151,12 @@ static void timer_set_cval(struct arch_timer_context *ctxt, u64 cval)
>  	case TIMER_PTIMER:
>  		__vcpu_sys_reg(vcpu, CNTP_CVAL_EL0) = cval;
>  		break;
> +	case TIMER_HVTIMER:
> +		__vcpu_sys_reg(vcpu, CNTHV_CVAL_EL2) = cval;
> +		break;
> +	case TIMER_HPTIMER:
> +		__vcpu_sys_reg(vcpu, CNTHP_CVAL_EL2) = cval;
> +		break;
>  	default:
>  		WARN_ON(1);
>  	}
> @@ -146,13 +182,27 @@ u64 kvm_phys_timer_read(void)
>  
>  static void get_timer_map(struct kvm_vcpu *vcpu, struct timer_map *map)
>  {
> -	if (has_vhe()) {
> +	if (vcpu_has_nv(vcpu)) {
> +		if (is_hyp_ctxt(vcpu)) {
> +			map->direct_vtimer = vcpu_hvtimer(vcpu);
> +			map->direct_ptimer = vcpu_hptimer(vcpu);
> +			map->emul_vtimer = vcpu_vtimer(vcpu);
> +			map->emul_ptimer = vcpu_ptimer(vcpu);
> +		} else {
> +			map->direct_vtimer = vcpu_vtimer(vcpu);
> +			map->direct_ptimer = vcpu_ptimer(vcpu);
> +			map->emul_vtimer = vcpu_hvtimer(vcpu);
> +			map->emul_ptimer = vcpu_hptimer(vcpu);
> +		}

It would be nice to explain why when the guest is running in virtual EL2, the
hp/hv timers are passthrough, while when the guest is in virtual EL1, the
virtual and physical timers are passthrough. I suppose it's because at EL2, the
guest is expected to use the hp/hv timers, and at EL1 the virtual and physical
timers, right?

> +	} else if (has_vhe()) {
>  		map->direct_vtimer = vcpu_vtimer(vcpu);
>  		map->direct_ptimer = vcpu_ptimer(vcpu);
> +		map->emul_vtimer = NULL;
>  		map->emul_ptimer = NULL;
>  	} else {
>  		map->direct_vtimer = vcpu_vtimer(vcpu);
>  		map->direct_ptimer = NULL;
> +		map->emul_vtimer = NULL;
>  		map->emul_ptimer = vcpu_ptimer(vcpu);
>  	}
>  
> @@ -325,9 +375,11 @@ static bool kvm_timer_should_fire(struct arch_timer_context *timer_ctx)
>  
>  		switch (index) {
>  		case TIMER_VTIMER:
> +		case TIMER_HVTIMER:
>  			cnt_ctl = read_sysreg_el0(SYS_CNTV_CTL);
>  			break;
>  		case TIMER_PTIMER:
> +		case TIMER_HPTIMER:
>  			cnt_ctl = read_sysreg_el0(SYS_CNTP_CTL);
>  			break;
>  		case NR_KVM_TIMERS:
> @@ -358,6 +410,7 @@ bool kvm_timer_is_pending(struct kvm_vcpu *vcpu)
>  
>  	return kvm_timer_should_fire(map.direct_vtimer) ||
>  	       kvm_timer_should_fire(map.direct_ptimer) ||
> +	       kvm_timer_should_fire(map.emul_vtimer) ||
>  	       kvm_timer_should_fire(map.emul_ptimer);
>  }
>  
> @@ -438,6 +491,7 @@ static void timer_save_state(struct arch_timer_context *ctx)
>  
>  	switch (index) {
>  	case TIMER_VTIMER:
> +	case TIMER_HVTIMER:
>  		timer_set_ctl(ctx, read_sysreg_el0(SYS_CNTV_CTL));
>  		timer_set_cval(ctx, read_sysreg_el0(SYS_CNTV_CVAL));
>  
> @@ -447,6 +501,7 @@ static void timer_save_state(struct arch_timer_context *ctx)
>  
>  		break;
>  	case TIMER_PTIMER:
> +	case TIMER_HPTIMER:
>  		timer_set_ctl(ctx, read_sysreg_el0(SYS_CNTP_CTL));
>  		timer_set_cval(ctx, read_sysreg_el0(SYS_CNTP_CVAL));
>  
> @@ -484,6 +539,7 @@ static void kvm_timer_blocking(struct kvm_vcpu *vcpu)
>  	 */
>  	if (!kvm_timer_irq_can_fire(map.direct_vtimer) &&
>  	    !kvm_timer_irq_can_fire(map.direct_ptimer) &&
> +	    !kvm_timer_irq_can_fire(map.emul_vtimer) &&
>  	    !kvm_timer_irq_can_fire(map.emul_ptimer))
>  		return;
>  
> @@ -517,11 +573,13 @@ static void timer_restore_state(struct arch_timer_context *ctx)
>  
>  	switch (index) {
>  	case TIMER_VTIMER:
> +	case TIMER_HVTIMER:
>  		write_sysreg_el0(timer_get_cval(ctx), SYS_CNTV_CVAL);
>  		isb();
>  		write_sysreg_el0(timer_get_ctl(ctx), SYS_CNTV_CTL);
>  		break;
>  	case TIMER_PTIMER:
> +	case TIMER_HPTIMER:
>  		write_sysreg_el0(timer_get_cval(ctx), SYS_CNTP_CVAL);
>  		isb();
>  		write_sysreg_el0(timer_get_ctl(ctx), SYS_CNTP_CTL);
> @@ -598,6 +656,42 @@ static void kvm_timer_vcpu_load_nogic(struct kvm_vcpu *vcpu)
>  		enable_percpu_irq(host_vtimer_irq, host_vtimer_irq_flags);
>  }
>  
> +static void kvm_timer_vcpu_load_nested_switch(struct kvm_vcpu *vcpu,
> +					      struct timer_map *map)
> +{
> +	int hw, ret;
> +
> +	if (!irqchip_in_kernel(vcpu->kvm))
> +		return;
> +
> +	/*
> +	 * We only ever unmap the vtimer irq on a VHE system that runs nested
> +	 * virtualization, in which case we have both a valid emul_vtimer,
> +	 * emul_ptimer, direct_vtimer, and direct_ptimer.
> +	 *
> +	 * Since this is called from kvm_timer_vcpu_load(), a change between
> +	 * vEL2 and vEL1/0 will have just happened, and the timer_map will

I can think of at least two cases when the above doesn't hold:

- when a VCPU resets another VCPU.
- when the guest changes the value of the HCR_EL2.E2H field.

> +	 * represent this, and therefore we switch the emul/direct mappings
> +	 * below.
> +	 */
> +	hw = kvm_vgic_get_map(vcpu, map->direct_vtimer->irq.irq);
> +	if (hw < 0) {

Looking at kvm_vgic_get_map(), it returns -1 when the interrupt is not directly
directly mapped to a physical interrupt. This only happens when the VCPU has
transitioned from EL2 to EL1 or viceversa between a vcpu put/load pair. I think
it would make the code a lot more understandable if it's wrapped in the helper
function, something like kvm_timer_context_switched() or something like that.

Thanks,
Alex

> +		kvm_vgic_unmap_phys_irq(vcpu, map->emul_vtimer->irq.irq);
> +		kvm_vgic_unmap_phys_irq(vcpu, map->emul_ptimer->irq.irq);
> +
> +		ret = kvm_vgic_map_phys_irq(vcpu,
> +					    map->direct_vtimer->host_timer_irq,
> +					    map->direct_vtimer->irq.irq,
> +					    &arch_timer_irq_ops);
> +		WARN_ON_ONCE(ret);
> +		ret = kvm_vgic_map_phys_irq(vcpu,
> +					    map->direct_ptimer->host_timer_irq,
> +					    map->direct_ptimer->irq.irq,
> +					    &arch_timer_irq_ops);
> +		WARN_ON_ONCE(ret);
> +	}
> +}
> +
>  void kvm_timer_vcpu_load(struct kvm_vcpu *vcpu)
>  {
>  	struct arch_timer_cpu *timer = vcpu_timer(vcpu);
> @@ -609,6 +703,9 @@ void kvm_timer_vcpu_load(struct kvm_vcpu *vcpu)
>  	get_timer_map(vcpu, &map);
>  
>  	if (static_branch_likely(&has_gic_active_state)) {
> +		if (vcpu_has_nv(vcpu))
> +			kvm_timer_vcpu_load_nested_switch(vcpu, &map);
> +
>  		kvm_timer_vcpu_load_gic(map.direct_vtimer);
>  		if (map.direct_ptimer)
>  			kvm_timer_vcpu_load_gic(map.direct_ptimer);
> @@ -624,6 +721,8 @@ void kvm_timer_vcpu_load(struct kvm_vcpu *vcpu)
>  	if (map.direct_ptimer)
>  		timer_restore_state(map.direct_ptimer);
>  
> +	if (map.emul_vtimer)
> +		timer_emulate(map.emul_vtimer);
>  	if (map.emul_ptimer)
>  		timer_emulate(map.emul_ptimer);
>  }
> @@ -668,6 +767,8 @@ void kvm_timer_vcpu_put(struct kvm_vcpu *vcpu)
>  	 * In any case, we re-schedule the hrtimer for the physical timer when
>  	 * coming back to the VCPU thread in kvm_timer_vcpu_load().
>  	 */
> +	if (map.emul_vtimer)
> +		soft_timer_cancel(&map.emul_vtimer->hrtimer);
>  	if (map.emul_ptimer)
>  		soft_timer_cancel(&map.emul_ptimer->hrtimer);
>  
> @@ -728,10 +829,14 @@ int kvm_timer_vcpu_reset(struct kvm_vcpu *vcpu)
>  	 */
>  	timer_set_ctl(vcpu_vtimer(vcpu), 0);
>  	timer_set_ctl(vcpu_ptimer(vcpu), 0);
> +	timer_set_ctl(vcpu_hvtimer(vcpu), 0);
> +	timer_set_ctl(vcpu_hptimer(vcpu), 0);
>  
>  	if (timer->enabled) {
>  		kvm_timer_update_irq(vcpu, false, vcpu_vtimer(vcpu));
>  		kvm_timer_update_irq(vcpu, false, vcpu_ptimer(vcpu));
> +		kvm_timer_update_irq(vcpu, false, vcpu_hvtimer(vcpu));
> +		kvm_timer_update_irq(vcpu, false, vcpu_hptimer(vcpu));
>  
>  		if (irqchip_in_kernel(vcpu->kvm)) {
>  			kvm_vgic_reset_mapped_irq(vcpu, map.direct_vtimer->irq.irq);
> @@ -740,6 +845,8 @@ int kvm_timer_vcpu_reset(struct kvm_vcpu *vcpu)
>  		}
>  	}
>  
> +	if (map.emul_vtimer)
> +		soft_timer_cancel(&map.emul_vtimer->hrtimer);
>  	if (map.emul_ptimer)
>  		soft_timer_cancel(&map.emul_ptimer->hrtimer);
>  
> @@ -770,30 +877,47 @@ void kvm_timer_vcpu_init(struct kvm_vcpu *vcpu)
>  	struct arch_timer_cpu *timer = vcpu_timer(vcpu);
>  	struct arch_timer_context *vtimer = vcpu_vtimer(vcpu);
>  	struct arch_timer_context *ptimer = vcpu_ptimer(vcpu);
> +	struct arch_timer_context *hvtimer = vcpu_hvtimer(vcpu);
> +	struct arch_timer_context *hptimer = vcpu_hptimer(vcpu);
>  
>  	vtimer->vcpu = vcpu;
>  	ptimer->vcpu = vcpu;
> +	hvtimer->vcpu = vcpu;
> +	hptimer->vcpu = vcpu;
>  
>  	/* Synchronize cntvoff across all vtimers of a VM. */
>  	update_vtimer_cntvoff(vcpu, kvm_phys_timer_read());
>  	timer_set_offset(ptimer, 0);
> +	timer_set_offset(hvtimer, 0);
> +	timer_set_offset(hptimer, 0);
>  
>  	hrtimer_init(&timer->bg_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
>  	timer->bg_timer.function = kvm_bg_timer_expire;
>  
>  	hrtimer_init(&vtimer->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
>  	hrtimer_init(&ptimer->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
> +	hrtimer_init(&hvtimer->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
> +	hrtimer_init(&hptimer->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
> +
>  	vtimer->hrtimer.function = kvm_hrtimer_expire;
>  	ptimer->hrtimer.function = kvm_hrtimer_expire;
> +	hvtimer->hrtimer.function = kvm_hrtimer_expire;
> +	hptimer->hrtimer.function = kvm_hrtimer_expire;
>  
>  	vtimer->irq.irq = default_vtimer_irq.irq;
>  	ptimer->irq.irq = default_ptimer_irq.irq;
> +	hvtimer->irq.irq = default_hvtimer_irq.irq;
> +	hptimer->irq.irq = default_hptimer_irq.irq;
>  
>  	vtimer->host_timer_irq = host_vtimer_irq;
>  	ptimer->host_timer_irq = host_ptimer_irq;
> +	hvtimer->host_timer_irq = host_vtimer_irq;
> +	hptimer->host_timer_irq = host_ptimer_irq;
>  
>  	vtimer->host_timer_irq_flags = host_vtimer_irq_flags;
>  	ptimer->host_timer_irq_flags = host_ptimer_irq_flags;
> +	hvtimer->host_timer_irq_flags = host_vtimer_irq_flags;
> +	hptimer->host_timer_irq_flags = host_ptimer_irq_flags;
>  }
>  
>  static void kvm_timer_init_interrupt(void *info)
> @@ -900,6 +1024,10 @@ static u64 kvm_arm_timer_read(struct kvm_vcpu *vcpu,
>  		val = kvm_phys_timer_read() - timer_get_offset(timer);
>  		break;
>  
> +	case TIMER_REG_VOFF:
> +		val = timer_get_offset(timer);
> +		break;
> +
>  	default:
>  		BUG();
>  	}
> @@ -942,6 +1070,10 @@ static void kvm_arm_timer_write(struct kvm_vcpu *vcpu,
>  		timer_set_cval(timer, val);
>  		break;
>  
> +	case TIMER_REG_VOFF:
> +		timer_set_offset(timer, val);
> +		break;
> +
>  	default:
>  		BUG();
>  	}
> @@ -1040,10 +1172,6 @@ static const struct irq_domain_ops timer_domain_ops = {
>  	.free	= timer_irq_domain_free,
>  };
>  
> -static struct irq_ops arch_timer_irq_ops = {
> -	.get_input_level = kvm_arch_timer_get_input_level,
> -};
> -
>  static void kvm_irq_fixup_flags(unsigned int virq, u32 *flags)
>  {
>  	*flags = irq_get_trigger_type(virq);
> @@ -1188,7 +1316,7 @@ void kvm_timer_vcpu_terminate(struct kvm_vcpu *vcpu)
>  
>  static bool timer_irqs_are_valid(struct kvm_vcpu *vcpu)
>  {
> -	int vtimer_irq, ptimer_irq, ret;
> +	int vtimer_irq, ptimer_irq, hvtimer_irq, hptimer_irq, ret;
>  	unsigned long i;
>  
>  	vtimer_irq = vcpu_vtimer(vcpu)->irq.irq;
> @@ -1201,16 +1329,28 @@ static bool timer_irqs_are_valid(struct kvm_vcpu *vcpu)
>  	if (ret)
>  		return false;
>  
> +	hvtimer_irq = vcpu_hvtimer(vcpu)->irq.irq;
> +	ret = kvm_vgic_set_owner(vcpu, hvtimer_irq, vcpu_hvtimer(vcpu));
> +	if (ret)
> +		return false;
> +
> +	hptimer_irq = vcpu_hptimer(vcpu)->irq.irq;
> +	ret = kvm_vgic_set_owner(vcpu, hptimer_irq, vcpu_hptimer(vcpu));
> +	if (ret)
> +		return false;
> +
>  	kvm_for_each_vcpu(i, vcpu, vcpu->kvm) {
>  		if (vcpu_vtimer(vcpu)->irq.irq != vtimer_irq ||
> -		    vcpu_ptimer(vcpu)->irq.irq != ptimer_irq)
> +		    vcpu_ptimer(vcpu)->irq.irq != ptimer_irq ||
> +		    vcpu_hvtimer(vcpu)->irq.irq != hvtimer_irq ||
> +		    vcpu_hptimer(vcpu)->irq.irq != hptimer_irq)
>  			return false;
>  	}
>  
>  	return true;
>  }
>  
> -bool kvm_arch_timer_get_input_level(int vintid)
> +static bool kvm_arch_timer_get_input_level(int vintid)
>  {
>  	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
>  	struct arch_timer_context *timer;
> @@ -1219,6 +1359,10 @@ bool kvm_arch_timer_get_input_level(int vintid)
>  		timer = vcpu_vtimer(vcpu);
>  	else if (vintid == vcpu_ptimer(vcpu)->irq.irq)
>  		timer = vcpu_ptimer(vcpu);
> +	else if (vintid == vcpu_hvtimer(vcpu)->irq.irq)
> +		timer = vcpu_hvtimer(vcpu);
> +	else if (vintid == vcpu_hptimer(vcpu)->irq.irq)
> +		timer = vcpu_hptimer(vcpu);
>  	else
>  		BUG();
>  
> @@ -1301,6 +1445,7 @@ static void set_timer_irqs(struct kvm *kvm, int vtimer_irq, int ptimer_irq)
>  	kvm_for_each_vcpu(i, vcpu, kvm) {
>  		vcpu_vtimer(vcpu)->irq.irq = vtimer_irq;
>  		vcpu_ptimer(vcpu)->irq.irq = ptimer_irq;
> +		/* TODO: Add support for hv/hp timers */
>  	}
>  }
>  
> @@ -1311,6 +1456,8 @@ int kvm_arm_timer_set_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
>  	struct arch_timer_context *ptimer = vcpu_ptimer(vcpu);
>  	int irq;
>  
> +	/* TODO: Add support for hv/hp timers */
> +
>  	if (!irqchip_in_kernel(vcpu->kvm))
>  		return -EINVAL;
>  
> @@ -1343,6 +1490,8 @@ int kvm_arm_timer_get_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
>  	struct arch_timer_context *timer;
>  	int irq;
>  
> +	/* TODO: Add support for hv/hp timers */
> +
>  	switch (attr->attr) {
>  	case KVM_ARM_VCPU_TIMER_IRQ_VTIMER:
>  		timer = vcpu_vtimer(vcpu);
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index d7441b8ba406..bbc58930a5eb 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -1288,6 +1288,11 @@ static bool access_arch_timer(struct kvm_vcpu *vcpu,
>  		tmr = TIMER_PTIMER;
>  		treg = TIMER_REG_CVAL;
>  		break;
> +	case SYS_CNTVOFF_EL2:
> +		tmr = TIMER_VTIMER;
> +		treg = TIMER_REG_VOFF;
> +		break;
> +
>  	default:
>  		BUG();
>  	}
> @@ -2212,7 +2217,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>  	EL2_REG(CONTEXTIDR_EL2, access_rw, reset_val, 0),
>  	EL2_REG(TPIDR_EL2, access_rw, reset_val, 0),
>  
> -	EL2_REG(CNTVOFF_EL2, access_rw, reset_val, 0),
> +	{ SYS_DESC(SYS_CNTVOFF_EL2), access_arch_timer },
>  	EL2_REG(CNTHCTL_EL2, access_rw, reset_val, 0),
>  
>  	EL12_REG(SCTLR, access_vm_reg, reset_val, 0x00C50078),
> diff --git a/arch/arm64/kvm/trace_arm.h b/arch/arm64/kvm/trace_arm.h
> index f3e46a976125..6ce5c025218d 100644
> --- a/arch/arm64/kvm/trace_arm.h
> +++ b/arch/arm64/kvm/trace_arm.h
> @@ -206,6 +206,7 @@ TRACE_EVENT(kvm_get_timer_map,
>  		__field(	unsigned long,		vcpu_id	)
>  		__field(	int,			direct_vtimer	)
>  		__field(	int,			direct_ptimer	)
> +		__field(	int,			emul_vtimer	)
>  		__field(	int,			emul_ptimer	)
>  	),
>  
> @@ -214,14 +215,17 @@ TRACE_EVENT(kvm_get_timer_map,
>  		__entry->direct_vtimer		= arch_timer_ctx_index(map->direct_vtimer);
>  		__entry->direct_ptimer =
>  			(map->direct_ptimer) ? arch_timer_ctx_index(map->direct_ptimer) : -1;
> +		__entry->emul_vtimer =
> +			(map->emul_vtimer) ? arch_timer_ctx_index(map->emul_vtimer) : -1;
>  		__entry->emul_ptimer =
>  			(map->emul_ptimer) ? arch_timer_ctx_index(map->emul_ptimer) : -1;
>  	),
>  
> -	TP_printk("VCPU: %ld, dv: %d, dp: %d, ep: %d",
> +	TP_printk("VCPU: %ld, dv: %d, dp: %d, ev: %d, ep: %d",
>  		  __entry->vcpu_id,
>  		  __entry->direct_vtimer,
>  		  __entry->direct_ptimer,
> +		  __entry->emul_vtimer,
>  		  __entry->emul_ptimer)
>  );
>  
> diff --git a/arch/arm64/kvm/vgic/vgic.c b/arch/arm64/kvm/vgic/vgic.c
> index 9b98876a8a93..e7fe0447af08 100644
> --- a/arch/arm64/kvm/vgic/vgic.c
> +++ b/arch/arm64/kvm/vgic/vgic.c
> @@ -573,6 +573,21 @@ int kvm_vgic_unmap_phys_irq(struct kvm_vcpu *vcpu, unsigned int vintid)
>  	return 0;
>  }
>  
> +int kvm_vgic_get_map(struct kvm_vcpu *vcpu, unsigned int vintid)
> +{
> +	struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, vcpu, vintid);
> +	unsigned long flags;
> +	int ret = -1;
> +
> +	raw_spin_lock_irqsave(&irq->irq_lock, flags);
> +	if (irq->hw)
> +		ret = irq->hwintid;
> +	raw_spin_unlock_irqrestore(&irq->irq_lock, flags);
> +
> +	vgic_put_irq(vcpu->kvm, irq);
> +	return ret;
> +}
> +
>  /**
>   * kvm_vgic_set_owner - Set the owner of an interrupt for a VM
>   *
> diff --git a/include/kvm/arm_arch_timer.h b/include/kvm/arm_arch_timer.h
> index 51c19381108c..0a76dac8cb6a 100644
> --- a/include/kvm/arm_arch_timer.h
> +++ b/include/kvm/arm_arch_timer.h
> @@ -13,6 +13,8 @@
>  enum kvm_arch_timers {
>  	TIMER_PTIMER,
>  	TIMER_VTIMER,
> +	TIMER_HVTIMER,
> +	TIMER_HPTIMER,
>  	NR_KVM_TIMERS
>  };
>  
> @@ -21,6 +23,7 @@ enum kvm_arch_timer_regs {
>  	TIMER_REG_CVAL,
>  	TIMER_REG_TVAL,
>  	TIMER_REG_CTL,
> +	TIMER_REG_VOFF,
>  };
>  
>  struct arch_timer_context {
> @@ -47,6 +50,7 @@ struct arch_timer_context {
>  struct timer_map {
>  	struct arch_timer_context *direct_vtimer;
>  	struct arch_timer_context *direct_ptimer;
> +	struct arch_timer_context *emul_vtimer;
>  	struct arch_timer_context *emul_ptimer;
>  };
>  
> @@ -85,12 +89,12 @@ void kvm_timer_vcpu_put(struct kvm_vcpu *vcpu);
>  
>  void kvm_timer_init_vhe(void);
>  
> -bool kvm_arch_timer_get_input_level(int vintid);
> -
>  #define vcpu_timer(v)	(&(v)->arch.timer_cpu)
>  #define vcpu_get_timer(v,t)	(&vcpu_timer(v)->timers[(t)])
>  #define vcpu_vtimer(v)	(&(v)->arch.timer_cpu.timers[TIMER_VTIMER])
>  #define vcpu_ptimer(v)	(&(v)->arch.timer_cpu.timers[TIMER_PTIMER])
> +#define vcpu_hvtimer(v)	(&(v)->arch.timer_cpu.timers[TIMER_HVTIMER])
> +#define vcpu_hptimer(v)	(&(v)->arch.timer_cpu.timers[TIMER_HPTIMER])
>  
>  #define arch_timer_ctx_index(ctx)	((ctx) - vcpu_timer((ctx)->vcpu)->timers)
>  
> diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
> index bb30a6803d9f..17b651890d22 100644
> --- a/include/kvm/arm_vgic.h
> +++ b/include/kvm/arm_vgic.h
> @@ -375,6 +375,7 @@ int kvm_vgic_inject_irq(struct kvm *kvm, int cpuid, unsigned int intid,
>  int kvm_vgic_map_phys_irq(struct kvm_vcpu *vcpu, unsigned int host_irq,
>  			  u32 vintid, struct irq_ops *ops);
>  int kvm_vgic_unmap_phys_irq(struct kvm_vcpu *vcpu, unsigned int vintid);
> +int kvm_vgic_get_map(struct kvm_vcpu *vcpu, unsigned int vintid);
>  bool kvm_vgic_map_is_active(struct kvm_vcpu *vcpu, unsigned int vintid);
>  
>  int kvm_vgic_vcpu_pending_irq(struct kvm_vcpu *vcpu);
> -- 
> 2.30.2
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
