Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E1D914C2CEA
	for <lists+kvmarm@lfdr.de>; Thu, 24 Feb 2022 14:25:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0BBCF4BEA8;
	Thu, 24 Feb 2022 08:25:15 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2A99CwFFy7ed; Thu, 24 Feb 2022 08:25:14 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 956484BFB9;
	Thu, 24 Feb 2022 08:25:13 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4C19E4BE96
 for <kvmarm@lists.cs.columbia.edu>; Thu, 24 Feb 2022 08:25:12 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FHJPveSncmj8 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 24 Feb 2022 08:25:10 -0500 (EST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A00AF4BE71
 for <kvmarm@lists.cs.columbia.edu>; Thu, 24 Feb 2022 08:25:10 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 0D360B825AC;
 Thu, 24 Feb 2022 13:25:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89057C340E9;
 Thu, 24 Feb 2022 13:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1645709107;
 bh=ghy4WLrY8wvb6Rr3yyRVAEc7K1NUtdUPKaXRp4DBEk4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Z+ZETFYs2muatikVBbhWGgjeXlaPc7dJKGWn/RPsJunh4RQB+peu08qA7rnVODXOE
 +5Ojsko/AKfdtoYA/5pn+r9VoEUtNyVoZsHfwR8vO9Lgk5dU/YfCbv4SAk5LWJ6wVt
 tn7z3DejepTGfmeyqxkxq1SRLCPyLIbBkdHxaLcQY8BgCe9xQeLW50boPhxqLNC8ov
 YciJ81Uw+Zs+6F1cXSgHD8InznQCW/EOscGptmCC2FSg5LuvOC1d1+rAa5IOEACNoW
 axh5mQIVJ81GDnHhjFqwx7kiA+veFVMpo1LU8m4Hj6jk8U/0MvepHSCkLwxaM5lHxa
 63kYxOdRRIVDQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1nNE7F-00ABpW-6B; Thu, 24 Feb 2022 13:25:05 +0000
Date: Thu, 24 Feb 2022 13:25:04 +0000
Message-ID: <87y2202y8f.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v3 06/19] KVM: arm64: Track vCPU power state using MP
 state values
In-Reply-To: <20220223041844.3984439-7-oupton@google.com>
References: <20220223041844.3984439-1-oupton@google.com>
 <20220223041844.3984439-7-oupton@google.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: oupton@google.com, kvmarm@lists.cs.columbia.edu,
 pbonzini@redhat.com, james.morse@arm.com, alexandru.elisei@arm.com,
 suzuki.poulose@arm.com, anup@brainfault.org, atishp@atishpatra.org,
 seanjc@google.com, vkuznets@redhat.com, wanpengli@tencent.com,
 jmattson@google.com, joro@8bytes.org, kvm@vger.kernel.org,
 kvm-riscv@lists.infradead.org, pshier@google.com, reijiw@google.com,
 ricarkol@google.com, rananta@google.com, jingzhangos@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
 Joerg Roedel <joro@8bytes.org>, Peter Shier <pshier@google.com>,
 kvm-riscv@lists.infradead.org, Atish Patra <atishp@atishpatra.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 kvmarm@lists.cs.columbia.edu, Jim Mattson <jmattson@google.com>
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

On Wed, 23 Feb 2022 04:18:31 +0000,
Oliver Upton <oupton@google.com> wrote:
> 
> A subsequent change to KVM will add support for additional power states.
> Store the MP state by value rather than keeping track of it as a
> boolean.
> 
> No functional change intended.
> 
> Signed-off-by: Oliver Upton <oupton@google.com>
> ---
>  arch/arm64/include/asm/kvm_host.h |  5 +++--
>  arch/arm64/kvm/arm.c              | 22 ++++++++++++----------
>  arch/arm64/kvm/psci.c             | 10 +++++-----
>  3 files changed, 20 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index cacc9efd2e70..3e8bfecaa95b 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -350,8 +350,8 @@ struct kvm_vcpu_arch {
>  		u32	mdscr_el1;
>  	} guest_debug_preserved;
>  
> -	/* vcpu power-off state */
> -	bool power_off;
> +	/* vcpu power state */
> +	u32 mp_state;

nit: why don't you just carry a kvm_mp_state structure instead of
open-coding a u32? Same size, stronger typing.

>  
>  	/* Don't run the guest (internal implementation need) */
>  	bool pause;
> @@ -800,5 +800,6 @@ static inline void kvm_hyp_reserve(void) { }
>  #endif
>  
>  void kvm_arm_vcpu_power_off(struct kvm_vcpu *vcpu);
> +bool kvm_arm_vcpu_powered_off(struct kvm_vcpu *vcpu);
>  
>  #endif /* __ARM64_KVM_HOST_H__ */
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 07c6a176cdcc..b4987b891f38 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -428,18 +428,20 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
>  
>  void kvm_arm_vcpu_power_off(struct kvm_vcpu *vcpu)
>  {
> -	vcpu->arch.power_off = true;
> +	vcpu->arch.mp_state = KVM_MP_STATE_STOPPED;
>  	kvm_make_request(KVM_REQ_SLEEP, vcpu);
>  	kvm_vcpu_kick(vcpu);
>  }
>  
> +bool kvm_arm_vcpu_powered_off(struct kvm_vcpu *vcpu)
> +{
> +	return vcpu->arch.mp_state == KVM_MP_STATE_STOPPED;

nit: if we're fully embracing the MP_STATE concept, just renamed this
to kvm_arm_vcpu_stopped().

> +}
> +
>  int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
>  				    struct kvm_mp_state *mp_state)
>  {
> -	if (vcpu->arch.power_off)
> -		mp_state->mp_state = KVM_MP_STATE_STOPPED;
> -	else
> -		mp_state->mp_state = KVM_MP_STATE_RUNNABLE;
> +	mp_state->mp_state = vcpu->arch.mp_state;
>
>  	return 0;
>  }
> @@ -451,7 +453,7 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
>  
>  	switch (mp_state->mp_state) {
>  	case KVM_MP_STATE_RUNNABLE:
> -		vcpu->arch.power_off = false;
> +		vcpu->arch.mp_state = mp_state->mp_state;
>  		break;
>  	case KVM_MP_STATE_STOPPED:
>  		kvm_arm_vcpu_power_off(vcpu);
> @@ -474,7 +476,7 @@ int kvm_arch_vcpu_runnable(struct kvm_vcpu *v)
>  {
>  	bool irq_lines = *vcpu_hcr(v) & (HCR_VI | HCR_VF);
>  	return ((irq_lines || kvm_vgic_vcpu_pending_irq(v))
> -		&& !v->arch.power_off && !v->arch.pause);
> +		&& !kvm_arm_vcpu_powered_off(v) && !v->arch.pause);
>  }
>  
>  bool kvm_arch_vcpu_in_kernel(struct kvm_vcpu *vcpu)
> @@ -668,10 +670,10 @@ static void vcpu_req_sleep(struct kvm_vcpu *vcpu)
>  	struct rcuwait *wait = kvm_arch_vcpu_get_wait(vcpu);
>  
>  	rcuwait_wait_event(wait,
> -			   (!vcpu->arch.power_off) &&(!vcpu->arch.pause),
> +			   (!kvm_arm_vcpu_powered_off(vcpu)) && (!vcpu->arch.pause),
>  			   TASK_INTERRUPTIBLE);
>  
> -	if (vcpu->arch.power_off || vcpu->arch.pause) {
> +	if (kvm_arm_vcpu_powered_off(vcpu) || vcpu->arch.pause) {
>  		/* Awaken to handle a signal, request we sleep again later. */
>  		kvm_make_request(KVM_REQ_SLEEP, vcpu);
>  	}
> @@ -1181,7 +1183,7 @@ static int kvm_arch_vcpu_ioctl_vcpu_init(struct kvm_vcpu *vcpu,
>  	if (test_bit(KVM_ARM_VCPU_POWER_OFF, vcpu->arch.features))
>  		kvm_arm_vcpu_power_off(vcpu);
>  	else
> -		vcpu->arch.power_off = false;
> +		vcpu->arch.mp_state = KVM_MP_STATE_RUNNABLE;
>  
>  	return 0;
>  }
> diff --git a/arch/arm64/kvm/psci.c b/arch/arm64/kvm/psci.c
> index e3f93b7f8d38..77a00913cdfd 100644
> --- a/arch/arm64/kvm/psci.c
> +++ b/arch/arm64/kvm/psci.c
> @@ -97,7 +97,7 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
>  	 */
>  	if (!vcpu)
>  		return PSCI_RET_INVALID_PARAMS;
> -	if (!vcpu->arch.power_off) {
> +	if (!kvm_arm_vcpu_powered_off(vcpu)) {
>  		if (kvm_psci_version(source_vcpu) != KVM_ARM_PSCI_0_1)
>  			return PSCI_RET_ALREADY_ON;
>  		else
> @@ -122,11 +122,11 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
>  
>  	/*
>  	 * Make sure the reset request is observed if the change to
> -	 * power_off is observed.
> +	 * mp_state is observed.

You want to expand this comment a bit, as this is not strictly a
binary state anymore.

>  	 */
>  	smp_wmb();
>  
> -	vcpu->arch.power_off = false;
> +	vcpu->arch.mp_state = KVM_MP_STATE_RUNNABLE;
>  	kvm_vcpu_wake_up(vcpu);
>  
>  	return PSCI_RET_SUCCESS;
> @@ -164,7 +164,7 @@ static unsigned long kvm_psci_vcpu_affinity_info(struct kvm_vcpu *vcpu)
>  		mpidr = kvm_vcpu_get_mpidr_aff(tmp);
>  		if ((mpidr & target_affinity_mask) == target_affinity) {
>  			matching_cpus++;
> -			if (!tmp->arch.power_off)
> +			if (!kvm_arm_vcpu_powered_off(tmp))
>  				return PSCI_0_2_AFFINITY_LEVEL_ON;
>  		}
>  	}
> @@ -190,7 +190,7 @@ static void kvm_prepare_system_event(struct kvm_vcpu *vcpu, u32 type)
>  	 * re-initialized.
>  	 */
>  	kvm_for_each_vcpu(i, tmp, vcpu->kvm)
> -		tmp->arch.power_off = true;
> +		tmp->arch.mp_state = KVM_MP_STATE_STOPPED;
>  	kvm_make_all_cpus_request(vcpu->kvm, KVM_REQ_SLEEP);
>  
>  	memset(&vcpu->run->system_event, 0, sizeof(vcpu->run->system_event));

You also may want to initialise the mp_state to RUNNABLE by default in
kvm_arch_vcpu_create(). We are currently relying on power_off to be
false thanks to the vcpu struct being zeroed, but we may as well make
it clearer (RUNNABLE is also 0, so there is no actual bug here).

Otherwise, looks good.

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
