Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id AA0F5264532
	for <lists+kvmarm@lfdr.de>; Thu, 10 Sep 2020 13:12:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 435484B3CD;
	Thu, 10 Sep 2020 07:12:36 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PuMZ2sEkcBj2; Thu, 10 Sep 2020 07:12:36 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C58D24B35A;
	Thu, 10 Sep 2020 07:12:34 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7ECE64B31E
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Sep 2020 07:12:33 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uYqu3ArnMmQi for <kvmarm@lists.cs.columbia.edu>;
 Thu, 10 Sep 2020 07:12:32 -0400 (EDT)
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id E77A04B2BC
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Sep 2020 07:12:31 -0400 (EDT)
Received: by mail-wm1-f66.google.com with SMTP id z9so5394100wmk.1
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Sep 2020 04:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=qu8JH/be0rcbIWaaAUE3igFaIOUou49hkjsJpPAPR90=;
 b=AA84R5regpZTTXFRpYdM+Or0tNH+fSOtcqP2pbugiGih/zhtRpJQ9cnshBMxr/2NFT
 FkZa3oj1Xp06SJZG9wz5iZrx1xBELEnEKGxVH1OlRfHsL0dtvMMG2hk7s6PB8W+kvyir
 sX9ek/eZRCmuRjUkFR4kKFs7iBNH565OLxk5AwZyOaq9Qz381ztlKjBTf7fJvXjDMtUv
 k1mlUwbXnd1c0vx4qoZAdUmGXUdFF9d3I2xnTUUYMiE3r4QfZxZNnlyJVqBmH4suoSEl
 a1udckqFeJUhnzcnBF+GizdyEJvpBbXbmvGn+XytRvONjxBJByJ66ZY3U9h6PWwIDfMo
 1qZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=qu8JH/be0rcbIWaaAUE3igFaIOUou49hkjsJpPAPR90=;
 b=ttgdQsMTadQ9p1eLK40ELrIkuj8wsC/neQPoj9hBmhcnVJUeJLlGHAJGnyhCoYxyU5
 WzxzSLNuOab9KDPd2GVE1Y3PQnHIoZIijQ4s9pG0PLze3tYJ3Tr7t9dnPVXNxvkrSpO/
 lZ4NAdI2wvUa+HiPwNeuCFyTdGzFc2c+OzT+S7YOn1i4Ou+8FyE7QUh2ovRhtopsRZu+
 z/iwYQgIpI3fG783QNejiTCZhGDX9rlKflRwG5tJx6H/rtKlQ9idyYiP3yXbMpbwp5OQ
 D6BzB87szFghkjik4UV3NB99cxHSyIU1vNhgmB+WbnhiCFpjPkI6woQsbW1HO6Xga6ss
 pSqA==
X-Gm-Message-State: AOAM5325R6fW6n+rOGBwR/ZAjz5VjEp6Ar61YdT1r6yCqZA7H9HHgpv9
 Q1sVJBNu5rpcjTOAhx0KwO7gXQ==
X-Google-Smtp-Source: ABdhPJxbK5saNRK5bQpLtP1bvSvZb92KMkAB9oGsS0A6wEs9jJX9P12KvSs4xOamCVaMq+VkbnZhCQ==
X-Received: by 2002:a1c:4886:: with SMTP id v128mr8080271wma.139.1599736350622; 
 Thu, 10 Sep 2020 04:12:30 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:109:4a0f:cfff:fe4a:6363])
 by smtp.gmail.com with ESMTPSA id t15sm2953444wmj.15.2020.09.10.04.12.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2020 04:12:30 -0700 (PDT)
Date: Thu, 10 Sep 2020 12:12:25 +0100
From: Andrew Scull <ascull@google.com>
To: David Brazdil <dbrazdil@google.com>
Subject: Re: [PATCH v2 03/10] kvm: arm64: Remove __hyp_this_cpu_read
Message-ID: <20200910111225.GC93664@google.com>
References: <20200903091712.46456-1-dbrazdil@google.com>
 <20200903091712.46456-4-dbrazdil@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200903091712.46456-4-dbrazdil@google.com>
Cc: linux-arch@vger.kernel.org, kernel-team@android.com,
 Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, Tejun Heo <tj@kernel.org>,
 Dennis Zhou <dennis@kernel.org>, Christoph Lameter <cl@linux.com>,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu
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

On Thu, Sep 03, 2020 at 11:17:05AM +0200, 'David Brazdil' via kernel-team wrote:
> this_cpu_ptr is meant for use in kernel proper because it selects between
> TPIDR_EL1/2 based on nVHE/VHE. __hyp_this_cpu_ptr was used in hyp to always
> select TPIDR_EL2. Unify all users behind this_cpu_ptr and friends by
> selecting _EL2 register under __KVM_NVHE_HYPERVISOR__.
> 
> Under CONFIG_DEBUG_PREEMPT, the kernel helpers perform a preemption check
> which is omitted by the hyp helpers. Preserve the behavior for nVHE by
> overriding the corresponding macros under __KVM_NVHE_HYPERVISOR__. Extend
> the checks into VHE hyp code.
> 
> Signed-off-by: David Brazdil <dbrazdil@google.com>
> ---
>  arch/arm64/include/asm/kvm_asm.h          | 20 --------------
>  arch/arm64/include/asm/percpu.h           | 33 +++++++++++++++++++++--
>  arch/arm64/kvm/hyp/include/hyp/debug-sr.h |  4 +--
>  arch/arm64/kvm/hyp/include/hyp/switch.h   |  8 +++---
>  arch/arm64/kvm/hyp/nvhe/switch.c          |  2 +-
>  arch/arm64/kvm/hyp/vhe/switch.c           |  2 +-
>  arch/arm64/kvm/hyp/vhe/sysreg-sr.c        |  4 +--
>  7 files changed, 41 insertions(+), 32 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> index 6f98fbd0ac81..9149079f0269 100644
> --- a/arch/arm64/include/asm/kvm_asm.h
> +++ b/arch/arm64/include/asm/kvm_asm.h
> @@ -149,26 +149,6 @@ extern char __smccc_workaround_1_smc[__SMCCC_WORKAROUND_1_SMC_SZ];
>  		addr;							\
>  	})
>  
> -/*
> - * Home-grown __this_cpu_{ptr,read} variants that always work at HYP,
> - * provided that sym is really a *symbol* and not a pointer obtained from
> - * a data structure. As for SHIFT_PERCPU_PTR(), the creative casting keeps
> - * sparse quiet.
> - */
> -#define __hyp_this_cpu_ptr(sym)						\
> -	({								\
> -		void *__ptr;						\
> -		__verify_pcpu_ptr(&sym);				\
> -		__ptr = hyp_symbol_addr(sym);				\
> -		__ptr += read_sysreg(tpidr_el2);			\
> -		(typeof(sym) __kernel __force *)__ptr;			\
> -	 })
> -
> -#define __hyp_this_cpu_read(sym)					\
> -	({								\
> -		*__hyp_this_cpu_ptr(sym);				\
> -	 })
> -
>  #define __KVM_EXTABLE(from, to)						\
>  	"	.pushsection	__kvm_ex_table, \"a\"\n"		\
>  	"	.align		3\n"					\
> diff --git a/arch/arm64/include/asm/percpu.h b/arch/arm64/include/asm/percpu.h
> index 0b6409b89e5e..b4008331475b 100644
> --- a/arch/arm64/include/asm/percpu.h
> +++ b/arch/arm64/include/asm/percpu.h
> @@ -19,7 +19,21 @@ static inline void set_my_cpu_offset(unsigned long off)
>  			:: "r" (off) : "memory");
>  }
>  
> -static inline unsigned long __my_cpu_offset(void)
> +static inline unsigned long __hyp_my_cpu_offset(void)
> +{
> +	unsigned long off;
> +
> +	/*
> +	 * We want to allow caching the value, so avoid using volatile and
> +	 * instead use a fake stack read to hazard against barrier().
> +	 */
> +	asm("mrs %0, tpidr_el2" : "=r" (off) :
> +		"Q" (*(const unsigned long *)current_stack_pointer));
> +
> +	return off;
> +}
> +
> +static inline unsigned long __kern_my_cpu_offset(void)
>  {
>  	unsigned long off;
>  
> @@ -35,7 +49,12 @@ static inline unsigned long __my_cpu_offset(void)
>  
>  	return off;
>  }
> -#define __my_cpu_offset __my_cpu_offset()
> +
> +#ifdef __KVM_NVHE_HYPERVISOR__
> +#define __my_cpu_offset __hyp_my_cpu_offset()

Is there a benefit to this being used for __KVM_VHE_HYPERVISOR__ too
since that is "hyp" too and doesn't need the alternative since it will
always pick EL2?

> +#else
> +#define __my_cpu_offset __kern_my_cpu_offset()
> +#endif
>  
>  #define PERCPU_RW_OPS(sz)						\
>  static inline unsigned long __percpu_read_##sz(void *ptr)		\
> @@ -227,4 +246,14 @@ PERCPU_RET_OP(add, add, ldadd)
>  
>  #include <asm-generic/percpu.h>
>  
> +/* Redefine macros for nVHE hyp under DEBUG_PREEMPT to avoid its dependencies. */
> +#if defined(__KVM_NVHE_HYPERVISOR__) && defined(CONFIG_DEBUG_PREEMPT)
> +#undef	this_cpu_ptr
> +#define	this_cpu_ptr		raw_cpu_ptr
> +#undef	__this_cpu_read
> +#define	__this_cpu_read		raw_cpu_read
> +#undef	__this_cpu_write
> +#define	__this_cpu_write	raw_cpu_write
> +#endif

This is an incomplete cherry-picked list of macros that are redefined to
remove the call to __this_cpu_preempt_check that would result in a
linker failure since that symbol is not defined for nVHE hyp.

I remember there being some dislike of truely defining that symbol with
an nVHE hyp implementation but I can't see why. Yes, nVHE hyp is always
has preemption disabled so the implementation is just an empty function
but why is is preferrable to redefine some of these macros instead?

> +
>  #endif /* __ASM_PERCPU_H */
> diff --git a/arch/arm64/kvm/hyp/include/hyp/debug-sr.h b/arch/arm64/kvm/hyp/include/hyp/debug-sr.h
> index 5e28ea6aa097..4ebe9f558f3a 100644
> --- a/arch/arm64/kvm/hyp/include/hyp/debug-sr.h
> +++ b/arch/arm64/kvm/hyp/include/hyp/debug-sr.h
> @@ -135,7 +135,7 @@ static inline void __debug_switch_to_guest_common(struct kvm_vcpu *vcpu)
>  	if (!(vcpu->arch.flags & KVM_ARM64_DEBUG_DIRTY))
>  		return;
>  
> -	host_ctxt = &__hyp_this_cpu_ptr(kvm_host_data)->host_ctxt;
> +	host_ctxt = &this_cpu_ptr(&kvm_host_data)->host_ctxt;
>  	guest_ctxt = &vcpu->arch.ctxt;
>  	host_dbg = &vcpu->arch.host_debug_state.regs;
>  	guest_dbg = kern_hyp_va(vcpu->arch.debug_ptr);
> @@ -154,7 +154,7 @@ static inline void __debug_switch_to_host_common(struct kvm_vcpu *vcpu)
>  	if (!(vcpu->arch.flags & KVM_ARM64_DEBUG_DIRTY))
>  		return;
>  
> -	host_ctxt = &__hyp_this_cpu_ptr(kvm_host_data)->host_ctxt;
> +	host_ctxt = &this_cpu_ptr(&kvm_host_data)->host_ctxt;
>  	guest_ctxt = &vcpu->arch.ctxt;
>  	host_dbg = &vcpu->arch.host_debug_state.regs;
>  	guest_dbg = kern_hyp_va(vcpu->arch.debug_ptr);
> diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
> index 5b6b8fa00f0a..f150407fa798 100644
> --- a/arch/arm64/kvm/hyp/include/hyp/switch.h
> +++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
> @@ -386,7 +386,7 @@ static inline bool __hyp_handle_ptrauth(struct kvm_vcpu *vcpu)
>  	    !esr_is_ptrauth_trap(kvm_vcpu_get_esr(vcpu)))
>  		return false;
>  
> -	ctxt = &__hyp_this_cpu_ptr(kvm_host_data)->host_ctxt;
> +	ctxt = &this_cpu_ptr(&kvm_host_data)->host_ctxt;
>  	__ptrauth_save_key(ctxt, APIA);
>  	__ptrauth_save_key(ctxt, APIB);
>  	__ptrauth_save_key(ctxt, APDA);
> @@ -495,7 +495,7 @@ static inline void __set_guest_arch_workaround_state(struct kvm_vcpu *vcpu)
>  	 * guest wants it disabled, so be it...
>  	 */
>  	if (__needs_ssbd_off(vcpu) &&
> -	    __hyp_this_cpu_read(arm64_ssbd_callback_required))
> +	    __this_cpu_read(arm64_ssbd_callback_required))
>  		arm_smccc_1_1_smc(ARM_SMCCC_ARCH_WORKAROUND_2, 0, NULL);
>  #endif
>  }
> @@ -507,7 +507,7 @@ static inline void __set_host_arch_workaround_state(struct kvm_vcpu *vcpu)
>  	 * If the guest has disabled the workaround, bring it back on.
>  	 */
>  	if (__needs_ssbd_off(vcpu) &&
> -	    __hyp_this_cpu_read(arm64_ssbd_callback_required))
> +	    __this_cpu_read(arm64_ssbd_callback_required))
>  		arm_smccc_1_1_smc(ARM_SMCCC_ARCH_WORKAROUND_2, 1, NULL);
>  #endif
>  }
> @@ -521,7 +521,7 @@ static inline void __kvm_unexpected_el2_exception(void)
>  
>  	entry = hyp_symbol_addr(__start___kvm_ex_table);
>  	end = hyp_symbol_addr(__stop___kvm_ex_table);
> -	host_ctxt = &__hyp_this_cpu_ptr(kvm_host_data)->host_ctxt;
> +	host_ctxt = &this_cpu_ptr(&kvm_host_data)->host_ctxt;
>  
>  	while (entry < end) {
>  		addr = (unsigned long)&entry->insn + entry->insn;
> diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
> index 0970442d2dbc..cc4f8e790fb3 100644
> --- a/arch/arm64/kvm/hyp/nvhe/switch.c
> +++ b/arch/arm64/kvm/hyp/nvhe/switch.c
> @@ -175,7 +175,7 @@ int __kvm_vcpu_run(struct kvm_vcpu *vcpu)
>  
>  	vcpu = kern_hyp_va(vcpu);
>  
> -	host_ctxt = &__hyp_this_cpu_ptr(kvm_host_data)->host_ctxt;
> +	host_ctxt = &this_cpu_ptr(&kvm_host_data)->host_ctxt;
>  	host_ctxt->__hyp_running_vcpu = vcpu;
>  	guest_ctxt = &vcpu->arch.ctxt;
>  
> diff --git a/arch/arm64/kvm/hyp/vhe/switch.c b/arch/arm64/kvm/hyp/vhe/switch.c
> index c1da4f86ccac..575e8054f116 100644
> --- a/arch/arm64/kvm/hyp/vhe/switch.c
> +++ b/arch/arm64/kvm/hyp/vhe/switch.c
> @@ -108,7 +108,7 @@ static int __kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu)
>  	struct kvm_cpu_context *guest_ctxt;
>  	u64 exit_code;
>  
> -	host_ctxt = &__hyp_this_cpu_ptr(kvm_host_data)->host_ctxt;
> +	host_ctxt = &this_cpu_ptr(&kvm_host_data)->host_ctxt;
>  	host_ctxt->__hyp_running_vcpu = vcpu;
>  	guest_ctxt = &vcpu->arch.ctxt;
>  
> diff --git a/arch/arm64/kvm/hyp/vhe/sysreg-sr.c b/arch/arm64/kvm/hyp/vhe/sysreg-sr.c
> index 996471e4c138..2a0b8c88d74f 100644
> --- a/arch/arm64/kvm/hyp/vhe/sysreg-sr.c
> +++ b/arch/arm64/kvm/hyp/vhe/sysreg-sr.c
> @@ -66,7 +66,7 @@ void kvm_vcpu_load_sysregs_vhe(struct kvm_vcpu *vcpu)
>  	struct kvm_cpu_context *guest_ctxt = &vcpu->arch.ctxt;
>  	struct kvm_cpu_context *host_ctxt;
>  
> -	host_ctxt = &__hyp_this_cpu_ptr(kvm_host_data)->host_ctxt;
> +	host_ctxt = &this_cpu_ptr(&kvm_host_data)->host_ctxt;
>  	__sysreg_save_user_state(host_ctxt);
>  
>  	/*
> @@ -100,7 +100,7 @@ void kvm_vcpu_put_sysregs_vhe(struct kvm_vcpu *vcpu)
>  	struct kvm_cpu_context *guest_ctxt = &vcpu->arch.ctxt;
>  	struct kvm_cpu_context *host_ctxt;
>  
> -	host_ctxt = &__hyp_this_cpu_ptr(kvm_host_data)->host_ctxt;
> +	host_ctxt = &this_cpu_ptr(&kvm_host_data)->host_ctxt;
>  	deactivate_traps_vhe_put();
>  
>  	__sysreg_save_el1_state(guest_ctxt);
> -- 
> 2.28.0.402.g5ffc5be6b7-goog
> 
> -- 
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
