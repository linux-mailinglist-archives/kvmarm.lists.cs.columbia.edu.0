Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBC851BB52
	for <lists+kvmarm@lfdr.de>; Thu,  5 May 2022 11:00:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CB31E4B2A7;
	Thu,  5 May 2022 05:00:54 -0400 (EDT)
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
	with ESMTP id N666qMo-3x7n; Thu,  5 May 2022 05:00:54 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3B8EE4B2AB;
	Thu,  5 May 2022 05:00:53 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 417B44B1C4
 for <kvmarm@lists.cs.columbia.edu>; Thu,  5 May 2022 05:00:52 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ngFrc27a1sa2 for <kvmarm@lists.cs.columbia.edu>;
 Thu,  5 May 2022 05:00:50 -0400 (EDT)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id B322149EAE
 for <kvmarm@lists.cs.columbia.edu>; Thu,  5 May 2022 05:00:50 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 51691B82C06;
 Thu,  5 May 2022 09:00:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7DA4C385A4;
 Thu,  5 May 2022 09:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1651741248;
 bh=BUsf1fIBA5aADpS52qetD4YREZhe1FozuBh6BsYEu7c=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=goXc0i14lR9YAn3HJ4tfoakLg46AJ4YZS4v8sbHeuQfaS/6w3fHCNA/y+Y+9LuA92
 7OM92QJS0oDyn+5v1krPWLV+s7d8F1Plji+DnMG6f55SN2FM12x6g6WAjpIOpY0wM6
 9TfNTq2kUlBX8DhC7Px3gv894nv7e/DvllPq/ISnEwCyMntkhYOr9m7v5eYLbwyApT
 KUVwKhqAlFN0RvkUga9lWVw1ejuEgdojJsqMQJl+OAvPPPLnAfN77dSBPj/GA3MymO
 RLce47WB+lD63pw1Y8dAOgHXSZWP0LtTEoETwxgB85ch+jBVjMsSYTgJvgWk8S4VdQ
 b4wCw7N6YhPdQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1nmXLo-0099qZ-Np; Thu, 05 May 2022 10:00:45 +0100
Date: Thu, 05 May 2022 10:00:44 +0100
Message-ID: <871qx88ibn.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Fuad Tabba <tabba@google.com>
Subject: Re: [PATCH v1 2/3] KVM: arm64: Pass pmu events to hyp via vcpu
In-Reply-To: <20220408084052.3310931-3-tabba@google.com>
References: <20220408084052.3310931-1-tabba@google.com>
 <20220408084052.3310931-3-tabba@google.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: tabba@google.com, kvmarm@lists.cs.columbia.edu,
 will@kernel.org, qperret@google.com, james.morse@arm.com,
 alexandru.elisei@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com,
 drjones@redhat.com, linux-arm-kernel@lists.infradead.org,
 kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, catalin.marinas@arm.com, will@kernel.org,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

On Fri, 08 Apr 2022 09:40:51 +0100,
Fuad Tabba <tabba@google.com> wrote:
> 
> Instead of accessing hyp data, pass the pmu events of the current
> cpu to hyp via the loaded vcpu.

This really deserves a more thorough explanation. What this is doing
is moving the part of the shared memory between EL1 and EL2 into each
vcpu, effectively multiplying the memory usage by the number of vcpus
in the system.

It isn't a big deal (what are 64 bits between friends?), but this is
definitely worth calling out.

> 
> No functional change intended.
> 
> Signed-off-by: Fuad Tabba <tabba@google.com>
> ---
>  arch/arm64/include/asm/kvm_host.h |  8 ++------
>  arch/arm64/kvm/arm.c              |  2 +-
>  arch/arm64/kvm/hyp/nvhe/switch.c  | 20 ++++++--------------
>  arch/arm64/kvm/pmu.c              | 22 +++++++++++++---------
>  include/kvm/arm_pmu.h             |  6 ++++++
>  5 files changed, 28 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 0e96087885fe..b5cdfb6cb9c7 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -244,14 +244,8 @@ struct kvm_cpu_context {
>  	struct kvm_vcpu *__hyp_running_vcpu;
>  };
>  
> -struct kvm_pmu_events {
> -	u32 events_host;
> -	u32 events_guest;
> -};
> -
>  struct kvm_host_data {
>  	struct kvm_cpu_context host_ctxt;
> -	struct kvm_pmu_events pmu_events;
>  };
>  
>  struct kvm_host_psci_config {
> @@ -728,6 +722,7 @@ void kvm_set_sei_esr(struct kvm_vcpu *vcpu, u64 syndrome);
>  struct kvm_vcpu *kvm_mpidr_to_vcpu(struct kvm *kvm, unsigned long mpidr);
>  
>  DECLARE_KVM_HYP_PER_CPU(struct kvm_host_data, kvm_host_data);
> +DECLARE_PER_CPU(struct kvm_pmu_events, kvm_pmu_events);
>  
>  static inline void kvm_init_host_cpu_context(struct kvm_cpu_context *cpu_ctxt)
>  {
> @@ -781,6 +776,7 @@ void kvm_arch_vcpu_put_debug_state_flags(struct kvm_vcpu *vcpu);
>  void kvm_set_pmu_events(u32 set, struct perf_event_attr *attr);
>  void kvm_clr_pmu_events(u32 clr);
>  
> +void kvm_vcpu_pmu_load(struct kvm_vcpu *vcpu);
>  void kvm_vcpu_pmu_restore_guest(struct kvm_vcpu *vcpu);
>  void kvm_vcpu_pmu_restore_host(struct kvm_vcpu *vcpu);
>  #else
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index ba9165e84396..e6f76d843558 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -400,7 +400,7 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
>  	if (has_vhe())
>  		kvm_vcpu_load_sysregs_vhe(vcpu);
>  	kvm_arch_vcpu_load_fp(vcpu);
> -	kvm_vcpu_pmu_restore_guest(vcpu);
> +	kvm_vcpu_pmu_load(vcpu);
>  	if (kvm_arm_is_pvtime_enabled(&vcpu->arch))
>  		kvm_make_request(KVM_REQ_RECORD_STEAL, vcpu);
>  
> diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
> index 6410d21d8695..ff7b29fb9787 100644
> --- a/arch/arm64/kvm/hyp/nvhe/switch.c
> +++ b/arch/arm64/kvm/hyp/nvhe/switch.c
> @@ -123,13 +123,9 @@ static void __hyp_vgic_restore_state(struct kvm_vcpu *vcpu)
>  /**
>   * Disable host events, enable guest events
>   */
> -static bool __pmu_switch_to_guest(struct kvm_cpu_context *host_ctxt)
> +static bool __pmu_switch_to_guest(struct kvm_vcpu *vcpu)
>  {
> -	struct kvm_host_data *host;
> -	struct kvm_pmu_events *pmu;
> -
> -	host = container_of(host_ctxt, struct kvm_host_data, host_ctxt);
> -	pmu = &host->pmu_events;
> +	struct kvm_pmu_events *pmu = &vcpu->arch.pmu.events;
>  
>  	if (pmu->events_host)
>  		write_sysreg(pmu->events_host, pmcntenclr_el0);
> @@ -143,13 +139,9 @@ static bool __pmu_switch_to_guest(struct kvm_cpu_context *host_ctxt)
>  /**
>   * Disable guest events, enable host events
>   */
> -static void __pmu_switch_to_host(struct kvm_cpu_context *host_ctxt)
> +static void __pmu_switch_to_host(struct kvm_vcpu *vcpu)
>  {
> -	struct kvm_host_data *host;
> -	struct kvm_pmu_events *pmu;
> -
> -	host = container_of(host_ctxt, struct kvm_host_data, host_ctxt);
> -	pmu = &host->pmu_events;
> +	struct kvm_pmu_events *pmu = &vcpu->arch.pmu.events;
>  
>  	if (pmu->events_guest)
>  		write_sysreg(pmu->events_guest, pmcntenclr_el0);
> @@ -274,7 +266,7 @@ int __kvm_vcpu_run(struct kvm_vcpu *vcpu)
>  	host_ctxt->__hyp_running_vcpu = vcpu;
>  	guest_ctxt = &vcpu->arch.ctxt;
>  
> -	pmu_switch_needed = __pmu_switch_to_guest(host_ctxt);
> +	pmu_switch_needed = __pmu_switch_to_guest(vcpu);
>  
>  	__sysreg_save_state_nvhe(host_ctxt);
>  	/*
> @@ -336,7 +328,7 @@ int __kvm_vcpu_run(struct kvm_vcpu *vcpu)
>  	__debug_restore_host_buffers_nvhe(vcpu);
>  
>  	if (pmu_switch_needed)
> -		__pmu_switch_to_host(host_ctxt);
> +		__pmu_switch_to_host(vcpu);
>  
>  	/* Returning to host will clear PSR.I, remask PMR if needed */
>  	if (system_uses_irq_prio_masking())
> diff --git a/arch/arm64/kvm/pmu.c b/arch/arm64/kvm/pmu.c
> index 310d47c9990f..8f722692fb58 100644
> --- a/arch/arm64/kvm/pmu.c
> +++ b/arch/arm64/kvm/pmu.c
> @@ -5,7 +5,8 @@
>   */
>  #include <linux/kvm_host.h>
>  #include <linux/perf_event.h>
> -#include <asm/kvm_hyp.h>
> +
> +DEFINE_PER_CPU(struct kvm_pmu_events, kvm_pmu_events);
>  
>  /*
>   * Given the perf event attributes and system type, determine
> @@ -27,12 +28,7 @@ static bool kvm_pmu_switch_needed(struct perf_event_attr *attr)
>  
>  static struct kvm_pmu_events *get_kvm_pmu_events(void)
>  {
> -	struct kvm_host_data *ctx = this_cpu_ptr_hyp_sym(kvm_host_data);
> -
> -	if (!ctx)
> -		return NULL;
> -
> -	return &ctx->pmu_events;
> +	return this_cpu_ptr(&kvm_pmu_events);
>  }
>  
>  /*
> @@ -43,7 +39,7 @@ void kvm_set_pmu_events(u32 set, struct perf_event_attr *attr)
>  {
>  	struct kvm_pmu_events *pmu = get_kvm_pmu_events();
>  
> -	if (!kvm_arm_support_pmu_v3() || !pmu || !kvm_pmu_switch_needed(attr))
> +	if (!kvm_arm_support_pmu_v3() || !kvm_pmu_switch_needed(attr))
>  		return;
>  
>  	if (!attr->exclude_host)
> @@ -59,7 +55,7 @@ void kvm_clr_pmu_events(u32 clr)
>  {
>  	struct kvm_pmu_events *pmu = get_kvm_pmu_events();
>  
> -	if (!kvm_arm_support_pmu_v3() || !pmu)
> +	if (!kvm_arm_support_pmu_v3())
>  		return;
>  
>  	pmu->events_host &= ~clr;
> @@ -213,3 +209,11 @@ void kvm_vcpu_pmu_restore_host(struct kvm_vcpu *vcpu)
>  	kvm_vcpu_pmu_enable_el0(events_host);
>  	kvm_vcpu_pmu_disable_el0(events_guest);
>  }
> +
> +void kvm_vcpu_pmu_load(struct kvm_vcpu *vcpu)
> +{
> +	kvm_vcpu_pmu_restore_guest(vcpu);
> +
> +	if (kvm_arm_support_pmu_v3() && !has_vhe())
> +		vcpu->arch.pmu.events = *get_kvm_pmu_events();

What guarantees do you have that the structure isn't updated between
load() and the point where the data is used? For example, can an
interrupt enable or disable a counter behind our back? I have the
feeling it can happen.

> +}
> diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
> index 20193416d214..0b3898e0313f 100644
> --- a/include/kvm/arm_pmu.h
> +++ b/include/kvm/arm_pmu.h
> @@ -20,6 +20,11 @@ struct kvm_pmc {
>  	struct perf_event *perf_event;
>  };
>  
> +struct kvm_pmu_events {
> +	u32 events_host;
> +	u32 events_guest;
> +};
> +
>  struct kvm_pmu {
>  	int irq_num;
>  	struct kvm_pmc pmc[ARMV8_PMU_MAX_COUNTERS];
> @@ -27,6 +32,7 @@ struct kvm_pmu {
>  	bool created;
>  	bool irq_level;
>  	struct irq_work overflow_work;
> +	struct kvm_pmu_events events;

This makes be realise that the packing of this structure is absolutely
awful, and that has ripple effects in the vcpu struct.

Can you please reorganise the struct so that irq_num, created and
irq_level are at the end?

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
