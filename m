Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E3A30379187
	for <lists+kvmarm@lfdr.de>; Mon, 10 May 2021 16:54:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 52BD84B385;
	Mon, 10 May 2021 10:54:42 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Amj2lZZ6lgL0; Mon, 10 May 2021 10:54:42 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9EA3B4B2C8;
	Mon, 10 May 2021 10:54:40 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D24884B2A3
 for <kvmarm@lists.cs.columbia.edu>; Mon, 10 May 2021 10:54:38 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iH05a4Pdx6A3 for <kvmarm@lists.cs.columbia.edu>;
 Mon, 10 May 2021 10:54:37 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 20B1B4B2A0
 for <kvmarm@lists.cs.columbia.edu>; Mon, 10 May 2021 10:54:37 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7908A15BE;
 Mon, 10 May 2021 07:54:36 -0700 (PDT)
Received: from [192.168.0.110] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 422713F719;
 Mon, 10 May 2021 07:54:35 -0700 (PDT)
Subject: Re: [PATCH 1/2] KVM: arm64: Move __adjust_pc out of line
To: Marc Zyngier <maz@kernel.org>, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
References: <20210510094915.1909484-1-maz@kernel.org>
 <20210510094915.1909484-2-maz@kernel.org>
From: Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <01c646f1-e342-b9fc-39b3-e8649862b4ac@arm.com>
Date: Mon, 10 May 2021 15:55:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210510094915.1909484-2-maz@kernel.org>
Content-Language: en-US
Cc: kernel-team@android.com, stable@vger.kernel.org
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

On 5/10/21 10:49 AM, Marc Zyngier wrote:
> In order to make it easy to call __adjust_pc() from the EL1 code
> (in the case of nVHE), rename it to __kvm_adjust_pc() and move
> it out of line.
>
> No expected functional change.

It does look to me like they're functionally identical. Minor comments below.

>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: stable@vger.kernel.org # 5.11
> ---
>  arch/arm64/include/asm/kvm_asm.h           |  2 ++
>  arch/arm64/kvm/hyp/exception.c             | 18 +++++++++++++++++-
>  arch/arm64/kvm/hyp/include/hyp/adjust_pc.h | 18 ------------------
>  arch/arm64/kvm/hyp/nvhe/switch.c           |  2 +-
>  arch/arm64/kvm/hyp/vhe/switch.c            |  2 +-
>  5 files changed, 21 insertions(+), 21 deletions(-)
>
> diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> index cf8df032b9c3..d5b11037401d 100644
> --- a/arch/arm64/include/asm/kvm_asm.h
> +++ b/arch/arm64/include/asm/kvm_asm.h
> @@ -201,6 +201,8 @@ extern void __kvm_timer_set_cntvoff(u64 cntvoff);
>  
>  extern int __kvm_vcpu_run(struct kvm_vcpu *vcpu);
>  
> +extern void __kvm_adjust_pc(struct kvm_vcpu *vcpu);

It looks pretty strange to have the file
arch/arm64/kvm/hyp/include/hyp/adjust_pc.h, but the function __kvm_adjust_pc() in
another header. I guess this was done because arch/arm64/kvm/arm.c will use the
function in the next patch. I was thinking that maybe renaming
adjust_pc.h->skip_instr.h would make more sense, what do you think? I can send a
patch on top of this series with the rename if you prefer.

> +
>  extern u64 __vgic_v3_get_gic_config(void);
>  extern u64 __vgic_v3_read_vmcr(void);
>  extern void __vgic_v3_write_vmcr(u32 vmcr);
> diff --git a/arch/arm64/kvm/hyp/exception.c b/arch/arm64/kvm/hyp/exception.c
> index 73629094f903..0812a496725f 100644
> --- a/arch/arm64/kvm/hyp/exception.c
> +++ b/arch/arm64/kvm/hyp/exception.c
> @@ -296,7 +296,7 @@ static void enter_exception32(struct kvm_vcpu *vcpu, u32 mode, u32 vect_offset)
>  	*vcpu_pc(vcpu) = vect_offset;
>  }
>  
> -void kvm_inject_exception(struct kvm_vcpu *vcpu)
> +static void kvm_inject_exception(struct kvm_vcpu *vcpu)
>  {
>  	if (vcpu_el1_is_32bit(vcpu)) {
>  		switch (vcpu->arch.flags & KVM_ARM64_EXCEPT_MASK) {
> @@ -329,3 +329,19 @@ void kvm_inject_exception(struct kvm_vcpu *vcpu)
>  		}
>  	}
>  }
> +
> +/*
> + * Adjust the guest PC on entry, depending on flags provided by EL1

This is also called by the VHE code running at EL2, but the comment is reworded in
the next patch, so it doesn't really matter, and keeping the diff a straight move
makes it easier to read.

> + * for the purpose of emulation (MMIO, sysreg) or exception injection.
> + */
> +void __kvm_adjust_pc(struct kvm_vcpu *vcpu)
> +{
> +	if (vcpu->arch.flags & KVM_ARM64_PENDING_EXCEPTION) {
> +		kvm_inject_exception(vcpu);
> +		vcpu->arch.flags &= ~(KVM_ARM64_PENDING_EXCEPTION |
> +				      KVM_ARM64_EXCEPT_MASK);
> +	} else 	if (vcpu->arch.flags & KVM_ARM64_INCREMENT_PC) {
> +		kvm_skip_instr(vcpu);
> +		vcpu->arch.flags &= ~KVM_ARM64_INCREMENT_PC;
> +	}
> +}
> diff --git a/arch/arm64/kvm/hyp/include/hyp/adjust_pc.h b/arch/arm64/kvm/hyp/include/hyp/adjust_pc.h
> index 61716359035d..4fdfeabefeb4 100644
> --- a/arch/arm64/kvm/hyp/include/hyp/adjust_pc.h
> +++ b/arch/arm64/kvm/hyp/include/hyp/adjust_pc.h
> @@ -13,8 +13,6 @@
>  #include <asm/kvm_emulate.h>
>  #include <asm/kvm_host.h>
>  
> -void kvm_inject_exception(struct kvm_vcpu *vcpu);
> -
>  static inline void kvm_skip_instr(struct kvm_vcpu *vcpu)
>  {
>  	if (vcpu_mode_is_32bit(vcpu)) {
> @@ -43,22 +41,6 @@ static inline void __kvm_skip_instr(struct kvm_vcpu *vcpu)
>  	write_sysreg_el2(*vcpu_pc(vcpu), SYS_ELR);
>  }
>  
> -/*
> - * Adjust the guest PC on entry, depending on flags provided by EL1
> - * for the purpose of emulation (MMIO, sysreg) or exception injection.
> - */
> -static inline void __adjust_pc(struct kvm_vcpu *vcpu)
> -{
> -	if (vcpu->arch.flags & KVM_ARM64_PENDING_EXCEPTION) {
> -		kvm_inject_exception(vcpu);
> -		vcpu->arch.flags &= ~(KVM_ARM64_PENDING_EXCEPTION |
> -				      KVM_ARM64_EXCEPT_MASK);
> -	} else 	if (vcpu->arch.flags & KVM_ARM64_INCREMENT_PC) {
> -		kvm_skip_instr(vcpu);
> -		vcpu->arch.flags &= ~KVM_ARM64_INCREMENT_PC;
> -	}
> -}
> -
>  /*
>   * Skip an instruction while host sysregs are live.
>   * Assumes host is always 64-bit.
> diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
> index e9f6ea704d07..b8ac123c3419 100644
> --- a/arch/arm64/kvm/hyp/nvhe/switch.c
> +++ b/arch/arm64/kvm/hyp/nvhe/switch.c
> @@ -201,7 +201,7 @@ int __kvm_vcpu_run(struct kvm_vcpu *vcpu)
>  	 */
>  	__debug_save_host_buffers_nvhe(vcpu);
>  
> -	__adjust_pc(vcpu);
> +	__kvm_adjust_pc(vcpu);
>  
>  	/*
>  	 * We must restore the 32-bit state before the sysregs, thanks
> diff --git a/arch/arm64/kvm/hyp/vhe/switch.c b/arch/arm64/kvm/hyp/vhe/switch.c
> index 7b8f7db5c1ed..3eafed0431f5 100644
> --- a/arch/arm64/kvm/hyp/vhe/switch.c
> +++ b/arch/arm64/kvm/hyp/vhe/switch.c
> @@ -132,7 +132,7 @@ static int __kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu)
>  	__load_guest_stage2(vcpu->arch.hw_mmu);
>  	__activate_traps(vcpu);
>  
> -	__adjust_pc(vcpu);
> +	__kvm_adjust_pc(vcpu);

With the function now moved to kvm_asm.h, the header include adjust_pc.h is not
needed. Same for the nvhe version of switch.c.

Thanks,

Alex

>  
>  	sysreg_restore_guest_state_vhe(guest_ctxt);
>  	__debug_switch_to_guest(vcpu);
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
