Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B5E0ED429E
	for <lists+kvmarm@lfdr.de>; Fri, 11 Oct 2019 16:19:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0E7394A88B;
	Fri, 11 Oct 2019 10:19:40 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SbNtuxA4TES9; Fri, 11 Oct 2019 10:19:39 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D33504A858;
	Fri, 11 Oct 2019 10:19:38 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 419394A746
 for <kvmarm@lists.cs.columbia.edu>; Fri, 11 Oct 2019 10:19:38 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jHKEeSYYpPxD for <kvmarm@lists.cs.columbia.edu>;
 Fri, 11 Oct 2019 10:19:37 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 16F5A4A685
 for <kvmarm@lists.cs.columbia.edu>; Fri, 11 Oct 2019 10:19:37 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65DEE142F;
 Fri, 11 Oct 2019 07:19:36 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D16173F68E;
 Fri, 11 Oct 2019 07:19:35 -0700 (PDT)
Date: Fri, 11 Oct 2019 15:19:34 +0100
From: Andrew Murray <andrew.murray@arm.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v3 3/4] KVM: arm64: pmu: Set the CHAINED attribute before
 creating the in-kernel event
Message-ID: <20191011141933.GQ42880@e119886-lin.cambridge.arm.com>
References: <20191011123954.31378-1-maz@kernel.org>
 <20191011123954.31378-4-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191011123954.31378-4-maz@kernel.org>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Cc: kvm@vger.kernel.org, Will Deacon <will@kernel.org>,
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

On Fri, Oct 11, 2019 at 01:39:53PM +0100, Marc Zyngier wrote:
> The current convention for KVM to request a chained event from the
> host PMU is to set bit[0] in attr.config1 (PERF_ATTR_CFG1_KVM_PMU_CHAINED).
> 
> But as it turns out, this bit gets set *after* we create the kernel
> event that backs our virtual counter, meaning that we never get
> a 64bit counter.
> 
> Moving the setting to an earlier point solves the problem.
> 
> Fixes: 80f393a23be6 ("KVM: arm/arm64: Support chained PMU counters")
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Reviewed-by: Andrew Murray <andrew.murray@arm.com>

> ---
>  virt/kvm/arm/pmu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
> index c30c3a74fc7f..f291d4ac3519 100644
> --- a/virt/kvm/arm/pmu.c
> +++ b/virt/kvm/arm/pmu.c
> @@ -569,12 +569,12 @@ static void kvm_pmu_create_perf_event(struct kvm_vcpu *vcpu, u64 select_idx)
>  		 * high counter.
>  		 */
>  		attr.sample_period = (-counter) & GENMASK(63, 0);
> +		if (kvm_pmu_counter_is_enabled(vcpu, pmc->idx + 1))
> +			attr.config1 |= PERF_ATTR_CFG1_KVM_PMU_CHAINED;
> +
>  		event = perf_event_create_kernel_counter(&attr, -1, current,
>  							 kvm_pmu_perf_overflow,
>  							 pmc + 1);
> -
> -		if (kvm_pmu_counter_is_enabled(vcpu, pmc->idx + 1))
> -			attr.config1 |= PERF_ATTR_CFG1_KVM_PMU_CHAINED;
>  	} else {
>  		/* The initial sample period (overflow count) of an event. */
>  		if (kvm_pmu_idx_is_64bit(vcpu, pmc->idx))
> -- 
> 2.20.1
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
