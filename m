Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id ADB42641F61
	for <lists+kvmarm@lfdr.de>; Sun,  4 Dec 2022 21:08:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id ADE874B355;
	Sun,  4 Dec 2022 15:08:20 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.788
X-Spam-Level: 
X-Spam-Status: No, score=-1.788 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, RCVD_IN_DNSWL_BLOCKED=0.001, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a7btOtOnOfR2; Sun,  4 Dec 2022 15:08:20 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D04C34B3C1;
	Sun,  4 Dec 2022 15:08:18 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0E3DA40E76
 for <kvmarm@lists.cs.columbia.edu>; Sun,  4 Dec 2022 15:08:18 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id scffav4lYdDd for <kvmarm@lists.cs.columbia.edu>;
 Sun,  4 Dec 2022 15:08:13 -0500 (EST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 6E87740298
 for <kvmarm@lists.cs.columbia.edu>; Sun,  4 Dec 2022 15:08:13 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id D35A2CE0974;
 Sun,  4 Dec 2022 20:08:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D03C433D6;
 Sun,  4 Dec 2022 20:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1670184487;
 bh=2IUepaiX4/rLisJ0SF09nBLSmvA7az6kaoTt9mpv+d8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=S1XGWycFdJAsFu9YHUFi7TqHNyh+gApmV9H0IGi5dTmdBIsuT/x9opsQ6j7Qk0bJg
 x44dZGLcIKGwvwdiS082beCzv4FrXVXqi2YFr30TmrwesElLdx1c7P5txDvyc4G8Kj
 1pZWn0sDO/3a7iauD+I4Doe7i2pMFVnTZHt/Xr2IlBMkKKoYsVlnXNHXrCWSe9uAtN
 CyjgvUYEbDFUajJlzwT9zUSxetiuELYPN3gjyOxH86qbb9ZcrMeusHTHFUl2JrGYM7
 fQKcnOCqpYZt1H/LZ9Wv5vp352qdBonUxI5iu2ftjzUyNsgy4RESDZe7E9lmgPYElv
 cp02uTfw9idtg==
Received: from sofa.misterjones.org ([185.219.108.64]
 helo=wait-a-minute.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <maz@kernel.org>) id 1p1vHR-00ARer-At;
 Sun, 04 Dec 2022 20:08:05 +0000
Date: Sun, 04 Dec 2022 20:08:00 +0000
Message-ID: <87a643szj3.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: [PATCH] KVM: arm64: Always mask CCSIDR associativity bits
In-Reply-To: <20221202091856.104868-1-akihiko.odaki@daynix.com>
References: <20221202091856.104868-1-akihiko.odaki@daynix.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: akihiko.odaki@daynix.com, linux-kernel@vger.kernel.org,
 kvmarm@lists.linux.dev, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, mathieu.poirier@linaro.org,
 oliver.upton@linux.dev, suzuki.poulose@arm.com, alexandru.elisei@arm.com,
 james.morse@arm.com, will@kernel.org, catalin.marinas@arm.com,
 asahi@lists.linux.dev, alyssa@rosenzweig.io, sven@svenpeter.dev,
 marcan@marcan.st
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>, Hector Martin <marcan@marcan.st>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Will Deacon <will@kernel.org>,
 Sven Peter <sven@svenpeter.dev>, linux-kernel@vger.kernel.org,
 asahi@lists.linux.dev, Catalin Marinas <catalin.marinas@arm.com>,
 kvmarm@lists.linux.dev, kvmarm@lists.cs.columbia.edu,
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

Hey Akihiko,

Thanks for having had a look at this. A bunch of comments below.

On Fri, 02 Dec 2022 09:18:56 +0000,
Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> 
> M2 MacBook Air has mismatched CCSIDR associativity bits among physical
> CPUs, which makes the bits a KVM vCPU sees inconsistent when migrating
> among them.

Your machine *does not* have any mismatched CCSIDR. By definition, any
CPU can have any cache hierarchy, and there is no architectural
requirement that they are all the same.

I'd rather you describe this in architectural terms, and simply point
out that KVM exposes the physical topology of the CPU the vcpu runs
on (including across migration, which is a problem), and that
userspace sees some arbitrary topology that has been sampled at boot
time. And both behaviours are a bit wrong in an asymmetric system.

This also break live migration for something that should never be a
concern of non-secure SW.

> 
> While it is possible to detect CCSIDR associativity bit mismatches and
> mask them with that condition, it requires mismatch detection and
> increases complexity. Instead, always mask the CCSIDR associativity bits
> to keep the code simple.

Given the above, this paragraph doesn't make much sense.

> 
> Also, allow the userspace to overwrite the bits with arbitrary values so
> that it can restore a vCPU state saved with an older kernel.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Suggested-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/include/asm/kvm_arm.h     |   3 +-
>  arch/arm64/include/asm/kvm_emulate.h |   4 -
>  arch/arm64/include/asm/kvm_host.h    |   4 +
>  arch/arm64/include/asm/sysreg.h      |   3 +
>  arch/arm64/kvm/sys_regs.c            | 146 ++++++++++++++-------------
>  5 files changed, 87 insertions(+), 73 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
> index 8aa8492dafc0..f69cd96a65ab 100644
> --- a/arch/arm64/include/asm/kvm_arm.h
> +++ b/arch/arm64/include/asm/kvm_arm.h
> @@ -81,11 +81,12 @@
>   * SWIO:	Turn set/way invalidates into set/way clean+invalidate
>   * PTW:		Take a stage2 fault if a stage1 walk steps in device memory
>   * TID3:	Trap EL1 reads of group 3 ID registers
> + * TID2:	Trap CCSIDR_EL1

Not only that, but also CTR_EL0, CCSIDR2_EL1, CLIDR_EL1, and
CSSELR_EL1 if the guest is using AArch64, and CCSELR if the guest is
using AArch32.

>   */
>  #define HCR_GUEST_FLAGS (HCR_TSC | HCR_TSW | HCR_TWE | HCR_TWI | HCR_VM | \
>  			 HCR_BSU_IS | HCR_FB | HCR_TACR | \
>  			 HCR_AMO | HCR_SWIO | HCR_TIDCP | HCR_RW | HCR_TLOR | \
> -			 HCR_FMO | HCR_IMO | HCR_PTW | HCR_TID3 )
> +			 HCR_FMO | HCR_IMO | HCR_PTW | HCR_TID3 | HCR_TID2)
>  #define HCR_VIRT_EXCP_MASK (HCR_VSE | HCR_VI | HCR_VF)
>  #define HCR_HOST_NVHE_FLAGS (HCR_RW | HCR_API | HCR_APK | HCR_ATA)
>  #define HCR_HOST_NVHE_PROTECTED_FLAGS (HCR_HOST_NVHE_FLAGS | HCR_TSC)
> diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
> index 9bdba47f7e14..30c4598d643b 100644
> --- a/arch/arm64/include/asm/kvm_emulate.h
> +++ b/arch/arm64/include/asm/kvm_emulate.h
> @@ -88,10 +88,6 @@ static inline void vcpu_reset_hcr(struct kvm_vcpu *vcpu)
>  	if (vcpu_el1_is_32bit(vcpu))
>  		vcpu->arch.hcr_el2 &= ~HCR_RW;
>  
> -	if (cpus_have_const_cap(ARM64_MISMATCHED_CACHE_TYPE) ||
> -	    vcpu_el1_is_32bit(vcpu))
> -		vcpu->arch.hcr_el2 |= HCR_TID2;
> -
>  	if (kvm_has_mte(vcpu->kvm))
>  		vcpu->arch.hcr_el2 |= HCR_ATA;
>  }
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 45e2136322ba..cc051cd56179 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -53,6 +53,9 @@
>  
>  #define KVM_HAVE_MMU_RWLOCK
>  
> +/* CSSELR values; used to index KVM_REG_ARM_DEMUX_ID_CCSIDR */
> +#define CSSELR_MAX 14
> +
>  /*
>   * Mode of operation configurable with kvm-arm.mode early param.
>   * See Documentation/admin-guide/kernel-parameters.txt for more information.
> @@ -266,6 +269,7 @@ struct kvm_cpu_context {
>  	struct user_fpsimd_state fp_regs;
>  
>  	u64 sys_regs[NR_SYS_REGS];
> +	u32 ccsidr[CSSELR_MAX + 1];

kvm_cpu_context is the wrong location for this stuff. We use it for
things that get actively context-switched. No such thing here, as this
is RO data as far as the guest is concerned.

Also, it would probably make some sense to only allocate this memory
if the vcpu is not using the default synthesised topology, but
something that userspace has restored.

>
>  	struct kvm_vcpu *__hyp_running_vcpu;
>  };
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 7d301700d1a9..0c5f3675b4c2 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -941,6 +941,9 @@
>  #define HFGxTR_EL2_nSMPRI_EL1_SHIFT	54
>  #define HFGxTR_EL2_nSMPRI_EL1_MASK	BIT_MASK(HFGxTR_EL2_nSMPRI_EL1_SHIFT)
>  
> +/* CCSIDR_EL1 bit definitions */
> +#define CCSIDR_EL1_ASSOCIATIVITY_BITS	GENMASK(27, 3)
> +
>  #define ARM64_FEATURE_FIELD_BITS	4
>  
>  /* Create a mask for the feature bits of the specified feature. */
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index f4a7c5abcbca..3518d021d3a0 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -84,24 +84,6 @@ void vcpu_write_sys_reg(struct kvm_vcpu *vcpu, u64 val, int reg)
>  /* 3 bits per cache level, as per CLIDR, but non-existent caches always 0 */
>  static u32 cache_levels;
>  
> -/* CSSELR values; used to index KVM_REG_ARM_DEMUX_ID_CCSIDR */
> -#define CSSELR_MAX 14
> -
> -/* Which cache CCSIDR represents depends on CSSELR value. */
> -static u32 get_ccsidr(u32 csselr)
> -{
> -	u32 ccsidr;
> -
> -	/* Make sure noone else changes CSSELR during this! */
> -	local_irq_disable();
> -	write_sysreg(csselr, csselr_el1);
> -	isb();
> -	ccsidr = read_sysreg(ccsidr_el1);
> -	local_irq_enable();
> -
> -	return ccsidr;
> -}
> -
>  /*
>   * See note at ARMv7 ARM B1.14.4 (TL;DR: S/W ops are not easily virtualized).
>   */
> @@ -1300,25 +1282,76 @@ static bool access_ccsidr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
>  		return write_to_read_only(vcpu, p, r);
>  
>  	csselr = vcpu_read_sys_reg(vcpu, CSSELR_EL1);
> -	p->regval = get_ccsidr(csselr);
> +	p->regval = vcpu->arch.ctxt.ccsidr[csselr];
>  
> -	/*
> -	 * Guests should not be doing cache operations by set/way at all, and
> -	 * for this reason, we trap them and attempt to infer the intent, so
> -	 * that we can flush the entire guest's address space at the appropriate
> -	 * time.
> -	 * To prevent this trapping from causing performance problems, let's
> -	 * expose the geometry of all data and unified caches (which are
> -	 * guaranteed to be PIPT and thus non-aliasing) as 1 set and 1 way.
> -	 * [If guests should attempt to infer aliasing properties from the
> -	 * geometry (which is not permitted by the architecture), they would
> -	 * only do so for virtually indexed caches.]
> -	 */
> -	if (!(csselr & 1)) // data or unified cache
> -		p->regval &= ~GENMASK(27, 3);

See my early comment about not allocating that memory if we get a
chance to always return the default view.

>  	return true;
>  }
>  
> +static bool is_valid_cache(u32 val)
> +{
> +	u32 level, ctype;
> +
> +	if (val >= CSSELR_MAX)
> +		return false;
> +
> +	/* Bottom bit is Instruction or Data bit.  Next 3 bits are level. */
> +	level = (val >> 1);
> +	ctype = (cache_levels >> (level * 3)) & 7;

Err, I didn't expect this, see below.

> +
> +	switch (ctype) {
> +	case 0: /* No cache */
> +		return false;
> +	case 1: /* Instruction cache only */
> +		return (val & 1);
> +	case 2: /* Data cache only */
> +	case 4: /* Unified cache */
> +		return !(val & 1);
> +	case 3: /* Separate instruction and data caches */
> +		return true;
> +	default: /* Reserved: we can't know instruction or data. */
> +		return false;
> +	}
> +}
> +
> +static void reset_ccsidr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
> +{
> +	u32 ccsidr;
> +	int i;
> +
> +	/* Make sure noone else changes CSSELR during this! */
> +	local_irq_disable();
> +
> +	for (i = 0; i < CSSELR_MAX; i++) {
> +		if (!is_valid_cache(i))
> +			continue;

So you still base the default guest topology on the HW one. This
wasn't what I had in mind. I really want KVM to expose something that
is totally decoupled from the HW topology.

I was thinking of a very basic two level hierarchy:

- L0 instruction
- L0 data
- L1 unified

with everything being one set, one way. And that's it.

The advantage of such a hierarchy is that it works with both
situations where CLIDR_EL1.LoC==0 or CLIDR_EL1.{LoUU,LoUIS}={0,0} and
those that are less able, as long as CLIDR_EL1 and CTR_EL0 don't
over-promise.

Of course, it means that you need to make CLIDR_EL1 consistent with
this hierarchy while respecting what the HW offers.

> +
> +		/* Which cache CCSIDR represents depends on CSSELR value. */
> +		write_sysreg(i, csselr_el1);
> +		isb();
> +		ccsidr = read_sysreg(ccsidr_el1);
> +
> +		/*
> +		 * Guests should not be doing cache operations by set/way at
> +		 * all, and for this reason, we trap them and attempt to infer
> +		 * the intent, so that we can flush the entire guest's address
> +		 * space at the appropriate time.
> +		 * To prevent this trapping from causing performance problems,
> +		 * let's expose the geometry of all data and unified caches
> +		 * (which are guaranteed to be PIPT and thus non-aliasing) as
> +		 * 1 set and 1 way.
> +		 * [If guests should attempt to infer aliasing properties from
> +		 * the geometry (which is not permitted by the architecture),
> +		 * they would only do so for virtually indexed caches.]
> +		 *
> +		 * This also make sure vCPU see the consistent geometry even if
> +		 * it migrates among phyiscal CPUs with different geometries.
> +		 */
> +		vcpu->arch.ctxt.ccsidr[i] = ccsidr & ~CCSIDR_EL1_ASSOCIATIVITY_BITS;
> +	}
> +
> +	local_irq_enable();
> +}
> +
>  static unsigned int mte_visibility(const struct kvm_vcpu *vcpu,
>  				   const struct sys_reg_desc *rd)
>  {
> @@ -1603,7 +1636,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>  
>  	{ SYS_DESC(SYS_CNTKCTL_EL1), NULL, reset_val, CNTKCTL_EL1, 0},
>  
> -	{ SYS_DESC(SYS_CCSIDR_EL1), access_ccsidr },
> +	{ SYS_DESC(SYS_CCSIDR_EL1), access_ccsidr, reset_ccsidr },

You also need to handle CCSIDR2_EL1/CCSIDR2 and make them UNDEF. This
probably also mean you need to mask out FEAT_CCIDX from the relevant
ID registers.

>  	{ SYS_DESC(SYS_CLIDR_EL1), access_clidr },

CLIDR_EL1 needs some extra love to return something that is consistent
with whatever has been restored. Which mean it must now be handled as
something userspace can write to. There is also some subtleties around
the handling of MTE caches (I think we can make that "Unified
Allocation Tag and Data cache, Allocation Tags and Data in separate
lines.").

I appreciate this is probably a bit (a lot?) more than what you had in
mind, but please hang in there. We'll help you along the way. And if
anything seem odd, please shout. I'll do my best to make it clearer.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
