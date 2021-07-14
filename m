Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA873C87EC
	for <lists+kvmarm@lfdr.de>; Wed, 14 Jul 2021 17:47:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9EA3849E8C;
	Wed, 14 Jul 2021 11:47:14 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4BmJrIxPn7lf; Wed, 14 Jul 2021 11:47:14 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4E6A9402BD;
	Wed, 14 Jul 2021 11:47:13 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3515B402BD
 for <kvmarm@lists.cs.columbia.edu>; Wed, 14 Jul 2021 11:47:12 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dRCNCYBtR8Y7 for <kvmarm@lists.cs.columbia.edu>;
 Wed, 14 Jul 2021 11:47:10 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9675C40152
 for <kvmarm@lists.cs.columbia.edu>; Wed, 14 Jul 2021 11:47:10 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D548131B;
 Wed, 14 Jul 2021 08:47:09 -0700 (PDT)
Received: from [192.168.0.110] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BDFB03F7D8;
 Wed, 14 Jul 2021 08:47:06 -0700 (PDT)
Subject: Re: [PATCH 1/3] KVM: arm64: Narrow PMU sysreg reset values to
 architectural requirements
To: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu
References: <20210713135900.1473057-1-maz@kernel.org>
 <20210713135900.1473057-2-maz@kernel.org>
From: Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <ae510501-0410-47b1-77f3-cb83d3b1fa9e@arm.com>
Date: Wed, 14 Jul 2021 16:48:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210713135900.1473057-2-maz@kernel.org>
Content-Language: en-US
Cc: kernel-team@android.com, Robin Murphy <robin.murphy@arm.com>
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

On 7/13/21 2:58 PM, Marc Zyngier wrote:
> A number of the PMU sysregs expose reset values that are not in
> compliant with the architecture (set bits in the RES0 ranges,
> for example).
>
> This in turn has the effect that we need to pointlessly mask
> some register when using them.
>
> Let's start by making sure we don't have illegal values in the
> shadow registers at reset time. This affects all the registers
> that dedicate one bit per counter, the counters themselves,
> PMEVTYPERn_EL0 and PMSELR_EL0.
>
> Reported-by: Alexandre Chartre <alexandre.chartre@oracle.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/kvm/sys_regs.c | 46 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 43 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index f6f126eb6ac1..95ccb8f45409 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -603,6 +603,44 @@ static unsigned int pmu_visibility(const struct kvm_vcpu *vcpu,
>  	return REG_HIDDEN;
>  }
>  
> +static void reset_pmu_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
> +{
> +	u64 n, mask;
> +
> +	/* No PMU available, any PMU reg may UNDEF... */
> +	if (!kvm_arm_support_pmu_v3())
> +		return;
> +
> +	n = read_sysreg(pmcr_el0) >> ARMV8_PMU_PMCR_N_SHIFT;

Isn't this going to cause a lot of unnecessary traps with NV? Is that going to be
a problem? Because at the moment I can't think of an elegant way to avoid it,
other than special casing PMCR_EL0 in kvm_reset_sys_regs() and using here
__vcpu_sys_reg(vcpu, PMCR_EL0). Or, even better, using
kvm_pmu_valid_counter_mask(vcpu), since this is identical to what that function does.

> +	n &= ARMV8_PMU_PMCR_N_MASK;
> +
> +	reset_unknown(vcpu, r);
> +
> +	mask = BIT(ARMV8_PMU_CYCLE_IDX);

PMSWINC_EL0 has bit 31 RES0. Other than that, looked at all the PMU registers and
everything looks correct to me.

Thanks,

Alex

> +	if (n)
> +		mask |= GENMASK(n - 1, 0);
> +
> +	__vcpu_sys_reg(vcpu, r->reg) &= mask;
> +}
> +
> +static void reset_pmevcntr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
> +{
> +	reset_unknown(vcpu, r);
> +	__vcpu_sys_reg(vcpu, r->reg) &= GENMASK(31, 0);
> +}
> +
> +static void reset_pmevtyper(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
> +{
> +	reset_unknown(vcpu, r);
> +	__vcpu_sys_reg(vcpu, r->reg) &= ARMV8_PMU_EVTYPE_MASK;
> +}
> +
> +static void reset_pmselr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
> +{
> +	reset_unknown(vcpu, r);
> +	__vcpu_sys_reg(vcpu, r->reg) &= ARMV8_PMU_COUNTER_MASK;
> +}
> +
>  static void reset_pmcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
>  {
>  	u64 pmcr, val;
> @@ -944,16 +982,18 @@ static bool access_pmuserenr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
>  	  trap_wcr, reset_wcr, 0, 0,  get_wcr, set_wcr }
>  
>  #define PMU_SYS_REG(r)						\
> -	SYS_DESC(r), .reset = reset_unknown, .visibility = pmu_visibility
> +	SYS_DESC(r), .reset = reset_pmu_reg, .visibility = pmu_visibility
>  
>  /* Macro to expand the PMEVCNTRn_EL0 register */
>  #define PMU_PMEVCNTR_EL0(n)						\
>  	{ PMU_SYS_REG(SYS_PMEVCNTRn_EL0(n)),				\
> +	  .reset = reset_pmevcntr,					\
>  	  .access = access_pmu_evcntr, .reg = (PMEVCNTR0_EL0 + n), }
>  
>  /* Macro to expand the PMEVTYPERn_EL0 register */
>  #define PMU_PMEVTYPER_EL0(n)						\
>  	{ PMU_SYS_REG(SYS_PMEVTYPERn_EL0(n)),				\
> +	  .reset = reset_pmevtyper,					\
>  	  .access = access_pmu_evtyper, .reg = (PMEVTYPER0_EL0 + n), }
>  
>  static bool undef_access(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
> @@ -1595,13 +1635,13 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>  	{ PMU_SYS_REG(SYS_PMSWINC_EL0),
>  	  .access = access_pmswinc, .reg = PMSWINC_EL0 },
>  	{ PMU_SYS_REG(SYS_PMSELR_EL0),
> -	  .access = access_pmselr, .reg = PMSELR_EL0 },
> +	  .access = access_pmselr, .reset = reset_pmselr, .reg = PMSELR_EL0 },
>  	{ PMU_SYS_REG(SYS_PMCEID0_EL0),
>  	  .access = access_pmceid, .reset = NULL },
>  	{ PMU_SYS_REG(SYS_PMCEID1_EL0),
>  	  .access = access_pmceid, .reset = NULL },
>  	{ PMU_SYS_REG(SYS_PMCCNTR_EL0),
> -	  .access = access_pmu_evcntr, .reg = PMCCNTR_EL0 },
> +	  .access = access_pmu_evcntr, .reset = reset_unknown, .reg = PMCCNTR_EL0 },
>  	{ PMU_SYS_REG(SYS_PMXEVTYPER_EL0),
>  	  .access = access_pmu_evtyper, .reset = NULL },
>  	{ PMU_SYS_REG(SYS_PMXEVCNTR_EL0),
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
