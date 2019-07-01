Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 613DE1EA15
	for <lists+kvmarm@lfdr.de>; Wed, 15 May 2019 10:25:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5A17F4A4F0;
	Wed, 15 May 2019 04:25:58 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DDSnGVoFePCt; Wed, 15 May 2019 04:25:58 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 18BF24A4CD;
	Wed, 15 May 2019 04:25:56 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 86E6D4A418
 for <kvmarm@lists.cs.columbia.edu>; Wed, 15 May 2019 04:25:54 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vwbsvcXjtCMp for <kvmarm@lists.cs.columbia.edu>;
 Wed, 15 May 2019 04:25:52 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 257344A409
 for <kvmarm@lists.cs.columbia.edu>; Wed, 15 May 2019 04:25:52 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2253B374;
 Wed, 15 May 2019 01:25:51 -0700 (PDT)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D34F3F703;
 Wed, 15 May 2019 01:25:48 -0700 (PDT)
Subject: Re: [PATCH v6 5/5] KVM: arm/arm64: support chained PMU counters
To: Andrew Murray <andrew.murray@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Marc Zyngier <marc.zyngier@arm.com>
References: <20190509153212.24187-1-andrew.murray@arm.com>
 <20190509153212.24187-6-andrew.murray@arm.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <69f7f607-2a38-41f0-63b8-0419bd5e6e9c@arm.com>
Date: Wed, 15 May 2019 09:25:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190509153212.24187-6-andrew.murray@arm.com>
Content-Language: en-US
Cc: kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

Hi Andrew,

It might be just my personal taste, but I'm not entirely sold on the
introduction of get/set_perf_event. Having both this and the concept of
getting the "canonical" pmc feels a bit redundant, or that we're
hiding/mixing stuff.

In most cases not calling the getter/setter feels simpler, see below.

On 09/05/2019 16:32, Andrew Murray wrote:
> ARMv8 provides support for chained PMU counters, where an event type
> of 0x001E is set for odd-numbered counters, the event counter will
> increment by one for each overflow of the preceding even-numbered
> counter. Let's emulate this in KVM by creating a 64 bit perf counter
> when a user chains two emulated counters together.
> 
> For chained events we only support generating an overflow interrupt
> on the high counter. We use the attributes of the low counter to
> determine the attributes of the perf event.
> 
> Suggested-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> ---
>  include/kvm/arm_pmu.h |   2 +
>  virt/kvm/arm/pmu.c    | 298 +++++++++++++++++++++++++++++++++++-------
>  2 files changed, 256 insertions(+), 44 deletions(-)
> 
> diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
> index b73f31baca52..8b434745500a 100644
> --- a/include/kvm/arm_pmu.h
> +++ b/include/kvm/arm_pmu.h
> @@ -22,6 +22,7 @@
>  #include <asm/perf_event.h>
>  
>  #define ARMV8_PMU_CYCLE_IDX		(ARMV8_PMU_MAX_COUNTERS - 1)
> +#define ARMV8_PMU_MAX_COUNTER_PAIRS	((ARMV8_PMU_MAX_COUNTERS + 1) >> 1)

Minor nit: I should have pointed that out on the previous version. To me
it would seem more obvious to use "(ARMV8_PMU_MAX_COUNTERS + 1) / 2"
rather than shifting right. Granted that anyone reading these sources
are likely to know that both are equivalent, but logically there are
half the number of counter pairs than there are counters.

>  
>  #ifdef CONFIG_KVM_ARM_PMU
>  
> @@ -34,6 +35,7 @@ struct kvm_pmc {
>  struct kvm_pmu {
>  	int irq_num;
>  	struct kvm_pmc pmc[ARMV8_PMU_MAX_COUNTERS];
> +	DECLARE_BITMAP(chained, ARMV8_PMU_MAX_COUNTER_PAIRS);
>  	bool ready;
>  	bool created;
>  	bool irq_level;
> diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
> index ae1e886d4a1a..6cdd9746f071 100644
> --- a/virt/kvm/arm/pmu.c
> +++ b/virt/kvm/arm/pmu.c
> @@ -25,6 +25,138 @@
>  #include <kvm/arm_vgic.h>
>  
>  static void kvm_pmu_create_perf_event(struct kvm_vcpu *vcpu, u64 select_idx);
> +
> +#define PERF_ATTR_CFG1_KVM_PMU_CHAINED 0x1
> +
> +static struct kvm_vcpu *kvm_pmc_to_vcpu(struct kvm_pmc *pmc)
> +{
> +	struct kvm_pmu *pmu;
> +	struct kvm_vcpu_arch *vcpu_arch;
> +
> +	pmc -= pmc->idx;
> +	pmu = container_of(pmc, struct kvm_pmu, pmc[0]);
> +	vcpu_arch = container_of(pmu, struct kvm_vcpu_arch, pmu);
> +	return container_of(vcpu_arch, struct kvm_vcpu, arch);
> +}
> +
> +/**
> + * kvm_pmu_pmc_is_chained - determine if the pmc is chained
> + * @pmc: The PMU counter pointer
> + */
> +static bool kvm_pmu_pmc_is_chained(struct kvm_pmc *pmc)
> +{
> +	struct kvm_vcpu *vcpu = kvm_pmc_to_vcpu(pmc);
> +
> +	return test_bit(pmc->idx >> 1, vcpu->arch.pmu.chained);
> +}
> +
> +/**
> + * kvm_pmu_pmc_is_high_counter - determine if select_idx is a high/low counter
> + * @select_idx: The counter index
> + */
> +static bool kvm_pmu_pmc_is_high_counter(u64 select_idx)
> +{
> +	return select_idx & 0x1;
> +}
> +
> +/**
> + * kvm_pmu_get_canonical_pmc - obtain the canonical pmc
> + * @pmc: The PMU counter pointer
> + *
> + * When a pair of PMCs are chained together we use the low counter (canonical)
> + * to hold the underlying perf event.
> + */
> +static struct kvm_pmc *kvm_pmu_get_canonical_pmc(struct kvm_pmc *pmc)
> +{
> +	if (kvm_pmu_pmc_is_chained(pmc) &&
> +	    kvm_pmu_pmc_is_high_counter(pmc->idx))
> +		return pmc - 1;
> +
> +	return pmc;
> +}
> +
> +/**
> + * kvm_pmu_idx_has_chain_evtype - determine if the event type is chain
> + * @vcpu: The vcpu pointer
> + * @select_idx: The counter index
> + */
> +static bool kvm_pmu_idx_has_chain_evtype(struct kvm_vcpu *vcpu, u64 select_idx)
> +{
> +	u64 eventsel, reg;
> +
> +	select_idx |= 0x1;
> +
> +	if (select_idx == ARMV8_PMU_CYCLE_IDX)
> +		return false;
> +
> +	reg = PMEVTYPER0_EL0 + select_idx;
> +	eventsel = __vcpu_sys_reg(vcpu, reg) & ARMV8_PMU_EVTYPE_EVENT;
> +
> +	return armv8pmu_evtype_is_chain(eventsel);
> +}
> +
> +/**
> + * kvm_pmu_get_perf_event - obtain a perf event from a pmc
> + * @pmc: The PMU counter pointer
> + *
> + * When a pair of PMCs are chained together we obtain the perf event in
> + * the canonical counter.
> + */
> +static struct perf_event *kvm_pmu_get_perf_event(struct kvm_pmc *pmc)
> +{
> +	return kvm_pmu_get_canonical_pmc(pmc)->perf_event;
> +}
> +
> +/**
> + * kvm_pmu_set_perf_event - set a perf event to a pmc
> + * @pmc: The PMU counter pointer
> + * @perf_event: The perf event
> + *
> + * When a pair of PMCs are chained together we set the perf event in
> + * the canonical counter.
> + */
> +static void kvm_pmu_set_perf_event(struct kvm_pmc *pmc,
> +				   struct perf_event *perf_event)
> +{
> +	kvm_pmu_get_canonical_pmc(pmc)->perf_event = perf_event;
> +}
> +
> +/**
> + * kvm_pmu_get_pair_counter_value - get PMU counter value
> + * @vcpu: The vcpu pointer
> + * @pmc: The PMU counter pointer
> + */
> +static u64 kvm_pmu_get_pair_counter_value(struct kvm_vcpu *vcpu,
> +					  struct kvm_pmc *pmc)
> +{
> +	u64 counter, counter_high, reg, enabled, running;
> +	struct perf_event *perf_event = kvm_pmu_get_perf_event(pmc);
> +
> +	if (kvm_pmu_pmc_is_chained(pmc)) {
> +		pmc = kvm_pmu_get_canonical_pmc(pmc);
> +		reg = PMEVCNTR0_EL0 + pmc->idx;
> +
> +		counter = __vcpu_sys_reg(vcpu, reg);
> +		counter_high = __vcpu_sys_reg(vcpu, reg + 1);
> +
> +		counter = lower_32_bits(counter) | (counter_high << 32);
> +	} else {
> +		reg = (pmc->idx == ARMV8_PMU_CYCLE_IDX)
> +		      ? PMCCNTR_EL0 : PMEVCNTR0_EL0 + pmc->idx;
> +		counter = __vcpu_sys_reg(vcpu, reg);
> +	}
> +
> +	/*
> +	 * The real counter value is equal to the value of counter register plus
> +	 * the value perf event counts.
> +	 */
> +	if (perf_event)

We don't reference the perf_event before this point and pmc is set to
the counter that holds the perf event. You could just use
"pmc->perf_event" here.

> +		counter += perf_event_read_value(perf_event, &enabled,
> +						 &running);
> +
> +	return counter;
> +}
> +
>  /**
>   * kvm_pmu_get_counter_value - get PMU counter value
>   * @vcpu: The vcpu pointer
> @@ -32,20 +164,15 @@ static void kvm_pmu_create_perf_event(struct kvm_vcpu *vcpu, u64 select_idx);
>   */
>  u64 kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu, u64 select_idx)
>  {
> -	u64 counter, reg, enabled, running;
> +	u64 counter;
>  	struct kvm_pmu *pmu = &vcpu->arch.pmu;
>  	struct kvm_pmc *pmc = &pmu->pmc[select_idx];
>  
> -	reg = (select_idx == ARMV8_PMU_CYCLE_IDX)
> -	      ? PMCCNTR_EL0 : PMEVCNTR0_EL0 + select_idx;
> -	counter = __vcpu_sys_reg(vcpu, reg);
> +	counter = kvm_pmu_get_pair_counter_value(vcpu, pmc);
>  
> -	/* The real counter value is equal to the value of counter register plus
> -	 * the value perf event counts.
> -	 */
> -	if (pmc->perf_event)
> -		counter += perf_event_read_value(pmc->perf_event, &enabled,
> -						 &running);
> +	if (kvm_pmu_pmc_is_chained(pmc) &&
> +	    kvm_pmu_pmc_is_high_counter(select_idx))
> +		counter >>= 32;
>  
>  	return counter & pmc->bitmask;
>  }
> @@ -74,10 +201,12 @@ void kvm_pmu_set_counter_value(struct kvm_vcpu *vcpu, u64 select_idx, u64 val)
>   */
>  static void kvm_pmu_release_perf_event(struct kvm_pmc *pmc)
>  {
> -	if (pmc->perf_event) {
> -		perf_event_disable(pmc->perf_event);
> -		perf_event_release_kernel(pmc->perf_event);
> -		pmc->perf_event = NULL;
> +	struct perf_event *perf_event = kvm_pmu_get_perf_event(pmc);
> +
> +	if (perf_event) {
> +		perf_event_disable(perf_event);
> +		perf_event_release_kernel(perf_event);
> +		kvm_pmu_set_perf_event(pmc, NULL);
>  	}
>  }
>  
> @@ -89,15 +218,27 @@ static void kvm_pmu_release_perf_event(struct kvm_pmc *pmc)
>   */
>  static void kvm_pmu_stop_counter(struct kvm_vcpu *vcpu, struct kvm_pmc *pmc)
>  {
> -	u64 counter, reg;
> +	u64 counter, counter_low, counter_high, reg;
>  
> -	if (pmc->perf_event) {
> +	if (!kvm_pmu_get_perf_event(pmc))
> +		return;
> +
> +	if (kvm_pmu_pmc_is_chained(pmc)) {
> +		pmc = kvm_pmu_get_canonical_pmc(pmc);
> +		counter_low = kvm_pmu_get_counter_value(vcpu, pmc->idx);
> +		counter_high = kvm_pmu_get_counter_value(vcpu, pmc->idx + 1);
> +
> +		reg = PMEVCNTR0_EL0 + pmc->idx;
> +		__vcpu_sys_reg(vcpu, reg) = counter_low;
> +		__vcpu_sys_reg(vcpu, reg + 1) = counter_high;
> +	} else {


What about:

	pmc = kvm_pmu_get_canonical_pmc(pmc);
	if (!pmc->perf_event)
		return;

	counter = kvm_pmu_get_counter_value(vcpu, pmc->idx);
	if (kvm_pmu_pmc_is_chained(pmc)) {
		reg = PMEVCNTR0_EL0 + pmc->idx;

		/* Also update high part of the counter */
		__vcpu_sys_reg(vcpu, reg + 1) = kvm_pmu_get_counter_value(vcpu,
pmc->idx + 1);
	} else {
		reg = (pmc->idx == ARMV8_PMU_CYCLE_IDX ? PMCCNTR_EL0 : PMEVCNTR0_EL0 +
pmc->idx);
	}

	/* Update counter register */
	__vcpu_sys_reg(vcpu, reg) = counter;
	kvm_pmu_release_perf_event(pmc);

>  		counter = kvm_pmu_get_counter_value(vcpu, pmc->idx);
>  		reg = (pmc->idx == ARMV8_PMU_CYCLE_IDX)
>  		       ? PMCCNTR_EL0 : PMEVCNTR0_EL0 + pmc->idx;
>  		__vcpu_sys_reg(vcpu, reg) = counter;
> -		kvm_pmu_release_perf_event(pmc);
>  	}
> +
> +	kvm_pmu_release_perf_event(pmc);
>  }
>  
>  /**
> @@ -115,6 +256,8 @@ void kvm_pmu_vcpu_reset(struct kvm_vcpu *vcpu)
>  		pmu->pmc[i].idx = i;
>  		pmu->pmc[i].bitmask = 0xffffffffUL;
>  	}
> +
> +	bitmap_zero(vcpu->arch.pmu.chained, ARMV8_PMU_MAX_COUNTER_PAIRS);
>  }
>  
>  /**
> @@ -154,6 +297,7 @@ void kvm_pmu_enable_counter_mask(struct kvm_vcpu *vcpu, u64 val)
>  	int i;
>  	struct kvm_pmu *pmu = &vcpu->arch.pmu;
>  	struct kvm_pmc *pmc;
> +	struct perf_event *perf_event;
>  
>  	if (!(__vcpu_sys_reg(vcpu, PMCR_EL0) & ARMV8_PMU_PMCR_E) || !val)
>  		return;
> @@ -163,9 +307,21 @@ void kvm_pmu_enable_counter_mask(struct kvm_vcpu *vcpu, u64 val)
>  			continue;
>  
>  		pmc = &pmu->pmc[i];
> -		if (pmc->perf_event) {
> -			perf_event_enable(pmc->perf_event);
> -			if (pmc->perf_event->state != PERF_EVENT_STATE_ACTIVE)
> +
> +		/*
> +		 * For high counters of chained events we must recreate the
> +		 * perf event with the long (64bit) attribute set.
> +		 */
> +		if (kvm_pmu_pmc_is_chained(pmc) &&
> +		    kvm_pmu_pmc_is_high_counter(i)) {
> +			kvm_pmu_create_perf_event(vcpu, i);
> +			continue;
> +		}
> +
> +		perf_event = kvm_pmu_get_perf_event(&pmu->pmc[i]);

Again, here we know that "pmu->pmc[i]" is a canonical counter.
"pmu->pmc[i].perf_event" is sufficient.

> +		if (perf_event) {
> +			perf_event_enable(perf_event);
> +			if (perf_event->state != PERF_EVENT_STATE_ACTIVE)
>  				kvm_debug("fail to enable perf event\n");
>  		}
>  	}
> @@ -183,6 +339,7 @@ void kvm_pmu_disable_counter_mask(struct kvm_vcpu *vcpu, u64 val)
>  	int i;
>  	struct kvm_pmu *pmu = &vcpu->arch.pmu;
>  	struct kvm_pmc *pmc;
> +	struct perf_event *perf_event;
>  
>  	if (!val)
>  		return;
> @@ -192,8 +349,20 @@ void kvm_pmu_disable_counter_mask(struct kvm_vcpu *vcpu, u64 val)
>  			continue;
>  
>  		pmc = &pmu->pmc[i];
> -		if (pmc->perf_event)
> -			perf_event_disable(pmc->perf_event);
> +
> +		/*
> +		 * For high counters of chained events we must recreate the
> +		 * perf event with the long (64bit) attribute unset.
> +		 */
> +		if (kvm_pmu_pmc_is_chained(pmc) &&
> +		    kvm_pmu_pmc_is_high_counter(i)) {
> +			kvm_pmu_create_perf_event(vcpu, i);
> +			continue;
> +		}
> +
> +		perf_event = kvm_pmu_get_perf_event(&pmu->pmc[i]);

Same thing.

> +		if (perf_event)
> +			perf_event_disable(perf_event);
>  	}
>  }
>  
> @@ -281,17 +450,6 @@ void kvm_pmu_sync_hwstate(struct kvm_vcpu *vcpu)
>  	kvm_pmu_update_state(vcpu);
>  }
>  
> -static inline struct kvm_vcpu *kvm_pmc_to_vcpu(struct kvm_pmc *pmc)
> -{
> -	struct kvm_pmu *pmu;
> -	struct kvm_vcpu_arch *vcpu_arch;
> -
> -	pmc -= pmc->idx;
> -	pmu = container_of(pmc, struct kvm_pmu, pmc[0]);
> -	vcpu_arch = container_of(pmu, struct kvm_vcpu_arch, pmu);
> -	return container_of(vcpu_arch, struct kvm_vcpu, arch);
> -}
> -
>  /**
>   * When the perf event overflows, set the overflow status and inform the vcpu.
>   */
> @@ -389,13 +547,20 @@ static bool kvm_pmu_counter_is_enabled(struct kvm_vcpu *vcpu, u64 select_idx)
>  static void kvm_pmu_create_perf_event(struct kvm_vcpu *vcpu, u64 select_idx)
>  {
>  	struct kvm_pmu *pmu = &vcpu->arch.pmu;
> -	struct kvm_pmc *pmc = &pmu->pmc[select_idx];
> +	struct kvm_pmc *pmc;
>  	struct perf_event *event;
>  	struct perf_event_attr attr;
>  	u64 eventsel, counter, reg, data;
>  
> -	reg = (select_idx == ARMV8_PMU_CYCLE_IDX)
> -	      ? PMCCFILTR_EL0 : PMEVTYPER0_EL0 + select_idx;
> +	/*
> +	 * For chained counters the event type and filtering attributes are
> +	 * obtained from the low/even counter. We also use this counter to
> +	 * determine if the event is enabled/disabled.
> +	 */
> +	pmc = kvm_pmu_get_canonical_pmc(&pmu->pmc[select_idx]);
> +
> +	reg = (pmc->idx == ARMV8_PMU_CYCLE_IDX)
> +	      ? PMCCFILTR_EL0 : PMEVTYPER0_EL0 + pmc->idx;
>  	data = __vcpu_sys_reg(vcpu, reg);
>  
>  	kvm_pmu_stop_counter(vcpu, pmc);
> @@ -403,34 +568,77 @@ static void kvm_pmu_create_perf_event(struct kvm_vcpu *vcpu, u64 select_idx)
>  
>  	/* Software increment event does't need to be backed by a perf event */
>  	if (eventsel == ARMV8_PMUV3_PERFCTR_SW_INCR &&
> -	    select_idx != ARMV8_PMU_CYCLE_IDX)
> +	    pmc->idx != ARMV8_PMU_CYCLE_IDX)
>  		return;
>  
>  	memset(&attr, 0, sizeof(struct perf_event_attr));
>  	attr.type = PERF_TYPE_RAW;
>  	attr.size = sizeof(attr);
>  	attr.pinned = 1;
> -	attr.disabled = !kvm_pmu_counter_is_enabled(vcpu, select_idx);
> +	attr.disabled = !kvm_pmu_counter_is_enabled(vcpu, pmc->idx);
>  	attr.exclude_user = data & ARMV8_PMU_EXCLUDE_EL0 ? 1 : 0;
>  	attr.exclude_kernel = data & ARMV8_PMU_EXCLUDE_EL1 ? 1 : 0;
>  	attr.exclude_hv = 1; /* Don't count EL2 events */
>  	attr.exclude_host = 1; /* Don't count host events */
> -	attr.config = (select_idx == ARMV8_PMU_CYCLE_IDX) ?
> +	attr.config = (pmc->idx == ARMV8_PMU_CYCLE_IDX) ?
>  		ARMV8_PMUV3_PERFCTR_CPU_CYCLES : eventsel;
>  
> -	counter = kvm_pmu_get_counter_value(vcpu, select_idx);
> -	/* The initial sample period (overflow count) of an event. */
> -	attr.sample_period = (-counter) & pmc->bitmask;
> +	counter = kvm_pmu_get_pair_counter_value(vcpu, pmc);
>  
> -	event = perf_event_create_kernel_counter(&attr, -1, current,
> +	if (kvm_pmu_idx_has_chain_evtype(vcpu, pmc->idx)) {
> +		/**
> +		 * The initial sample period (overflow count) of an event. For
> +		 * chained counters we only support overflow interrupts on the
> +		 * high counter.
> +		 */
> +		attr.sample_period = (-counter) & 0xffffffffffffffffUL;
> +		event = perf_event_create_kernel_counter(&attr, -1, current,
> +							 kvm_pmu_perf_overflow,
> +							 pmc + 1);
> +
> +		if (kvm_pmu_counter_is_enabled(vcpu, pmc->idx + 1))
> +			attr.config1 |= PERF_ATTR_CFG1_KVM_PMU_CHAINED;
> +	} else {
> +		/* The initial sample period (overflow count) of an event. */
> +		attr.sample_period = (-counter) & pmc->bitmask;
> +		event = perf_event_create_kernel_counter(&attr, -1, current,
>  						 kvm_pmu_perf_overflow, pmc);
> +	}
> +
>  	if (IS_ERR(event)) {
>  		pr_err_once("kvm: pmu event creation failed %ld\n",
>  			    PTR_ERR(event));
>  		return;
>  	}
>  
> -	pmc->perf_event = event;
> +	kvm_pmu_set_perf_event(pmc, event);

You set pmc to a canonical counter at the begining of the function, so
you could do `pmc->perf_event = event`.

> +}
> +
> +/**
> + * kvm_pmu_update_pmc_chained - update chained bitmap
> + * @vcpu: The vcpu pointer
> + * @select_idx: The number of selected counter
> + *
> + * Update the chained bitmap based on the event type written in the
> + * typer register.
> + */
> +static void kvm_pmu_update_pmc_chained(struct kvm_vcpu *vcpu, u64 select_idx)
> +{
> +	struct kvm_pmu *pmu = &vcpu->arch.pmu;
> +	struct kvm_pmc *pmc = &pmu->pmc[select_idx];
> +
> +	if (kvm_pmu_idx_has_chain_evtype(vcpu, pmc->idx)) {
> +		/*
> +		 * During promotion from !chained to chained we must ensure
> +		 * the adjacent counter is stopped and its event destroyed
> +		 */
> +		if (!kvm_pmu_pmc_is_chained(pmc))
> +			kvm_pmu_stop_counter(vcpu, pmc);
> +
> +		set_bit(pmc->idx >> 1, vcpu->arch.pmu.chained);
> +	} else {
> +		clear_bit(pmc->idx >> 1, vcpu->arch.pmu.chained);
> +	}
>  }
>  
>  /**
> @@ -452,6 +660,8 @@ void kvm_pmu_set_counter_event_type(struct kvm_vcpu *vcpu, u64 data,
>  	      ? PMCCFILTR_EL0 : PMEVTYPER0_EL0 + select_idx;
>  
>  	__vcpu_sys_reg(vcpu, reg) = event_type;
> +
> +	kvm_pmu_update_pmc_chained(vcpu, select_idx);
>  	kvm_pmu_create_perf_event(vcpu, select_idx);
>  }
>  
> 

Thanks,

-- 
Julien Thierry
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
