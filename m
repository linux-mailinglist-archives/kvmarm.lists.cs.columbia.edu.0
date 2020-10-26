Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 285CC298E9F
	for <lists+kvmarm@lfdr.de>; Mon, 26 Oct 2020 14:56:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D01804B503;
	Mon, 26 Oct 2020 09:56:08 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1I4OAA06rQ+i; Mon, 26 Oct 2020 09:56:08 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 74C044B342;
	Mon, 26 Oct 2020 09:56:07 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0DCE54B257
 for <kvmarm@lists.cs.columbia.edu>; Mon, 26 Oct 2020 09:56:06 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id voliRoHN6hwg for <kvmarm@lists.cs.columbia.edu>;
 Mon, 26 Oct 2020 09:56:04 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8A7E44B328
 for <kvmarm@lists.cs.columbia.edu>; Mon, 26 Oct 2020 09:56:04 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43EB530E;
 Mon, 26 Oct 2020 06:56:04 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.56.187])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 949C03F68F;
 Mon, 26 Oct 2020 06:56:02 -0700 (PDT)
Date: Mon, 26 Oct 2020 13:55:59 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 02/11] KVM: arm64: Move kvm_vcpu_trap_il_is32bit into
 kvm_skip_instr32()
Message-ID: <20201026135559.GD12454@C02TD0UTHF1T.local>
References: <20201026133450.73304-1-maz@kernel.org>
 <20201026133450.73304-3-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201026133450.73304-3-maz@kernel.org>
Cc: Will Deacon <will@kernel.org>, kernel-team@android.com,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 kvm@vger.kernel.org
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

On Mon, Oct 26, 2020 at 01:34:41PM +0000, Marc Zyngier wrote:
> There is no need to feed the result of kvm_vcpu_trap_il_is32bit()
> to kvm_skip_instr(), as only AArch32 has a variable lenght ISA, and

Typo: s/lenght/length/

If there are more typos in the series, I'll ignore them. I assume you
know how to drive your favourite spellchecker. ;)

> this helper can equally be called from kvm_skip_instr32(), reducing
> the complexity at all the call sites.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Looks nice!

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/include/asm/kvm_emulate.h | 8 ++++----
>  arch/arm64/kvm/handle_exit.c         | 6 +++---
>  arch/arm64/kvm/hyp/aarch32.c         | 4 ++--
>  arch/arm64/kvm/mmio.c                | 2 +-
>  arch/arm64/kvm/mmu.c                 | 2 +-
>  arch/arm64/kvm/sys_regs.c            | 2 +-
>  6 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
> index 5ef2669ccd6c..0864f425547d 100644
> --- a/arch/arm64/include/asm/kvm_emulate.h
> +++ b/arch/arm64/include/asm/kvm_emulate.h
> @@ -26,7 +26,7 @@ unsigned long vcpu_read_spsr32(const struct kvm_vcpu *vcpu);
>  void vcpu_write_spsr32(struct kvm_vcpu *vcpu, unsigned long v);
>  
>  bool kvm_condition_valid32(const struct kvm_vcpu *vcpu);
> -void kvm_skip_instr32(struct kvm_vcpu *vcpu, bool is_wide_instr);
> +void kvm_skip_instr32(struct kvm_vcpu *vcpu);
>  
>  void kvm_inject_undefined(struct kvm_vcpu *vcpu);
>  void kvm_inject_vabt(struct kvm_vcpu *vcpu);
> @@ -472,10 +472,10 @@ static inline unsigned long vcpu_data_host_to_guest(struct kvm_vcpu *vcpu,
>  	return data;		/* Leave LE untouched */
>  }
>  
> -static __always_inline void kvm_skip_instr(struct kvm_vcpu *vcpu, bool is_wide_instr)
> +static __always_inline void kvm_skip_instr(struct kvm_vcpu *vcpu)
>  {
>  	if (vcpu_mode_is_32bit(vcpu)) {
> -		kvm_skip_instr32(vcpu, is_wide_instr);
> +		kvm_skip_instr32(vcpu);
>  	} else {
>  		*vcpu_pc(vcpu) += 4;
>  		*vcpu_cpsr(vcpu) &= ~PSR_BTYPE_MASK;
> @@ -494,7 +494,7 @@ static __always_inline void __kvm_skip_instr(struct kvm_vcpu *vcpu)
>  	*vcpu_pc(vcpu) = read_sysreg_el2(SYS_ELR);
>  	vcpu_gp_regs(vcpu)->pstate = read_sysreg_el2(SYS_SPSR);
>  
> -	kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
> +	kvm_skip_instr(vcpu);
>  
>  	write_sysreg_el2(vcpu_gp_regs(vcpu)->pstate, SYS_SPSR);
>  	write_sysreg_el2(*vcpu_pc(vcpu), SYS_ELR);
> diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
> index 79a720657c47..30bf8e22df54 100644
> --- a/arch/arm64/kvm/handle_exit.c
> +++ b/arch/arm64/kvm/handle_exit.c
> @@ -61,7 +61,7 @@ static int handle_smc(struct kvm_vcpu *vcpu)
>  	 * otherwise return to the same address...
>  	 */
>  	vcpu_set_reg(vcpu, 0, ~0UL);
> -	kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
> +	kvm_skip_instr(vcpu);
>  	return 1;
>  }
>  
> @@ -100,7 +100,7 @@ static int kvm_handle_wfx(struct kvm_vcpu *vcpu)
>  		kvm_clear_request(KVM_REQ_UNHALT, vcpu);
>  	}
>  
> -	kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
> +	kvm_skip_instr(vcpu);
>  
>  	return 1;
>  }
> @@ -221,7 +221,7 @@ static int handle_trap_exceptions(struct kvm_vcpu *vcpu)
>  	 * that fail their condition code check"
>  	 */
>  	if (!kvm_condition_valid(vcpu)) {
> -		kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
> +		kvm_skip_instr(vcpu);
>  		handled = 1;
>  	} else {
>  		exit_handle_fn exit_handler;
> diff --git a/arch/arm64/kvm/hyp/aarch32.c b/arch/arm64/kvm/hyp/aarch32.c
> index ae56d8a4b382..f98cbe2626a1 100644
> --- a/arch/arm64/kvm/hyp/aarch32.c
> +++ b/arch/arm64/kvm/hyp/aarch32.c
> @@ -123,13 +123,13 @@ static void kvm_adjust_itstate(struct kvm_vcpu *vcpu)
>   * kvm_skip_instr - skip a trapped instruction and proceed to the next
>   * @vcpu: The vcpu pointer
>   */
> -void kvm_skip_instr32(struct kvm_vcpu *vcpu, bool is_wide_instr)
> +void kvm_skip_instr32(struct kvm_vcpu *vcpu)
>  {
>  	u32 pc = *vcpu_pc(vcpu);
>  	bool is_thumb;
>  
>  	is_thumb = !!(*vcpu_cpsr(vcpu) & PSR_AA32_T_BIT);
> -	if (is_thumb && !is_wide_instr)
> +	if (is_thumb && !kvm_vcpu_trap_il_is32bit(vcpu))
>  		pc += 2;
>  	else
>  		pc += 4;
> diff --git a/arch/arm64/kvm/mmio.c b/arch/arm64/kvm/mmio.c
> index 6a2826f1bf5e..7e8eb32ae7d2 100644
> --- a/arch/arm64/kvm/mmio.c
> +++ b/arch/arm64/kvm/mmio.c
> @@ -115,7 +115,7 @@ int kvm_handle_mmio_return(struct kvm_vcpu *vcpu)
>  	 * The MMIO instruction is emulated and should not be re-executed
>  	 * in the guest.
>  	 */
> -	kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
> +	kvm_skip_instr(vcpu);
>  
>  	return 0;
>  }
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 19aacc7d64de..080917c3f960 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -1001,7 +1001,7 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
>  		 * cautious, and skip the instruction.
>  		 */
>  		if (kvm_is_error_hva(hva) && kvm_vcpu_dabt_is_cm(vcpu)) {
> -			kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
> +			kvm_skip_instr(vcpu);
>  			ret = 1;
>  			goto out_unlock;
>  		}
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index d9117bc56237..894e800d6c61 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -2199,7 +2199,7 @@ static void perform_access(struct kvm_vcpu *vcpu,
>  
>  	/* Skip instruction if instructed so */
>  	if (likely(r->access(vcpu, params, r)))
> -		kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
> +		kvm_skip_instr(vcpu);
>  }
>  
>  /*
> -- 
> 2.28.0
> 
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
