Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B3C7830794B
	for <lists+kvmarm@lfdr.de>; Thu, 28 Jan 2021 16:17:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2FBBD4B17D;
	Thu, 28 Jan 2021 10:17:37 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7B9lbaeunUbQ; Thu, 28 Jan 2021 10:17:37 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DD5EB4B187;
	Thu, 28 Jan 2021 10:17:35 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 888714B0F2
 for <kvmarm@lists.cs.columbia.edu>; Thu, 28 Jan 2021 10:17:34 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id btVCFO17tp4n for <kvmarm@lists.cs.columbia.edu>;
 Thu, 28 Jan 2021 10:17:33 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 511B64B0E4
 for <kvmarm@lists.cs.columbia.edu>; Thu, 28 Jan 2021 10:17:33 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BED061396;
 Thu, 28 Jan 2021 07:17:32 -0800 (PST)
Received: from slackpad.fritz.box (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 81AA63F7C3;
 Thu, 28 Jan 2021 07:17:31 -0800 (PST)
Date: Thu, 28 Jan 2021 15:16:43 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 1/2] KVM: arm64: Turn kvm_arm_support_pmu_v3() into a
 static key
Message-ID: <20210128151643.6e2c3668@slackpad.fritz.box>
In-Reply-To: <20210126151521.2958688-2-maz@kernel.org>
References: <20210126151521.2958688-1-maz@kernel.org>
 <20210126151521.2958688-2-maz@kernel.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Cc: linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
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

On Tue, 26 Jan 2021 15:15:20 +0000
Marc Zyngier <maz@kernel.org> wrote:

Hi Marc,

> We currently find out about the presence of a HW PMU (or the handling
> of that PMU by perf, which amounts to the same thing) in a fairly
> roundabout way, by checking the number of counters available to perf.
> That's good enough for now, but we will soon need to find about about
> that on paths where perf is out of reach (in the world switch).
> 
> Instead, let's turn kvm_arm_support_pmu_v3() into a static key.

I am sure the pesky build bot has told you about it already, but this
fails when ARM_PMU is not defined, as perf_num_counters() is not
defined. It's  bit nasty, since it's a generic function, so we
can't easily stub it in its original header.

Shall we find a place somewhere in arch/arm64 and provide a stub
implementation there, #ifndef CONFIG_ARM_PMU? Sounds ugly, though.

Or something else entirely?

Cheers,
Andre

> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/kvm/perf.c     | 10 ++++++++++
>  arch/arm64/kvm/pmu-emul.c | 10 ----------
>  include/kvm/arm_pmu.h     |  9 +++++++--
>  3 files changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/kvm/perf.c b/arch/arm64/kvm/perf.c
> index d45b8b9a4415..198fa4266b2d 100644
> --- a/arch/arm64/kvm/perf.c
> +++ b/arch/arm64/kvm/perf.c
> @@ -11,6 +11,8 @@
>  
>  #include <asm/kvm_emulate.h>
>  
> +DEFINE_STATIC_KEY_FALSE(kvm_arm_pmu_available);
> +
>  static int kvm_is_in_guest(void)
>  {
>          return kvm_get_running_vcpu() != NULL;
> @@ -48,6 +50,14 @@ static struct perf_guest_info_callbacks kvm_guest_cbs = {
>  
>  int kvm_perf_init(void)
>  {
> +	/*
> +	 * Check if HW_PERF_EVENTS are supported by checking the number of
> +	 * hardware performance counters. This could ensure the presence of
> +	 * a physical PMU and CONFIG_PERF_EVENT is selected.
> +	 */
> +	if (perf_num_counters() > 0)
> +		static_branch_enable(&kvm_arm_pmu_available);
> +
>  	return perf_register_guest_info_callbacks(&kvm_guest_cbs);
>  }
>  
> diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
> index 4ad66a532e38..44d500706ab9 100644
> --- a/arch/arm64/kvm/pmu-emul.c
> +++ b/arch/arm64/kvm/pmu-emul.c
> @@ -813,16 +813,6 @@ u64 kvm_pmu_get_pmceid(struct kvm_vcpu *vcpu, bool pmceid1)
>  	return val & mask;
>  }
>  
> -bool kvm_arm_support_pmu_v3(void)
> -{
> -	/*
> -	 * Check if HW_PERF_EVENTS are supported by checking the number of
> -	 * hardware performance counters. This could ensure the presence of
> -	 * a physical PMU and CONFIG_PERF_EVENT is selected.
> -	 */
> -	return (perf_num_counters() > 0);
> -}
> -
>  int kvm_arm_pmu_v3_enable(struct kvm_vcpu *vcpu)
>  {
>  	if (!kvm_vcpu_has_pmu(vcpu))
> diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
> index 8dcb3e1477bc..6fd3cda608e4 100644
> --- a/include/kvm/arm_pmu.h
> +++ b/include/kvm/arm_pmu.h
> @@ -13,6 +13,13 @@
>  #define ARMV8_PMU_CYCLE_IDX		(ARMV8_PMU_MAX_COUNTERS - 1)
>  #define ARMV8_PMU_MAX_COUNTER_PAIRS	((ARMV8_PMU_MAX_COUNTERS + 1) >> 1)
>  
> +DECLARE_STATIC_KEY_FALSE(kvm_arm_pmu_available);
> +
> +static __always_inline bool kvm_arm_support_pmu_v3(void)
> +{
> +	return static_branch_likely(&kvm_arm_pmu_available);
> +}
> +
>  #ifdef CONFIG_HW_PERF_EVENTS
>  
>  struct kvm_pmc {
> @@ -47,7 +54,6 @@ void kvm_pmu_software_increment(struct kvm_vcpu *vcpu, u64 val);
>  void kvm_pmu_handle_pmcr(struct kvm_vcpu *vcpu, u64 val);
>  void kvm_pmu_set_counter_event_type(struct kvm_vcpu *vcpu, u64 data,
>  				    u64 select_idx);
> -bool kvm_arm_support_pmu_v3(void);
>  int kvm_arm_pmu_v3_set_attr(struct kvm_vcpu *vcpu,
>  			    struct kvm_device_attr *attr);
>  int kvm_arm_pmu_v3_get_attr(struct kvm_vcpu *vcpu,
> @@ -87,7 +93,6 @@ static inline void kvm_pmu_software_increment(struct kvm_vcpu *vcpu, u64 val) {}
>  static inline void kvm_pmu_handle_pmcr(struct kvm_vcpu *vcpu, u64 val) {}
>  static inline void kvm_pmu_set_counter_event_type(struct kvm_vcpu *vcpu,
>  						  u64 data, u64 select_idx) {}
> -static inline bool kvm_arm_support_pmu_v3(void) { return false; }
>  static inline int kvm_arm_pmu_v3_set_attr(struct kvm_vcpu *vcpu,
>  					  struct kvm_device_attr *attr)
>  {

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
