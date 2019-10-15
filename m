Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id F2928D72AC
	for <lists+kvmarm@lfdr.de>; Tue, 15 Oct 2019 12:00:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6E3CC4A9D8;
	Tue, 15 Oct 2019 06:00:12 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DWyEtdFP7J9P; Tue, 15 Oct 2019 06:00:12 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 58CB14A9D1;
	Tue, 15 Oct 2019 06:00:07 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1C8944A9BE
 for <kvmarm@lists.cs.columbia.edu>; Tue, 15 Oct 2019 06:00:06 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5A033BAZiqQn for <kvmarm@lists.cs.columbia.edu>;
 Tue, 15 Oct 2019 06:00:04 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 185244A9BA
 for <kvmarm@lists.cs.columbia.edu>; Tue, 15 Oct 2019 06:00:04 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7936D28;
 Tue, 15 Oct 2019 03:00:03 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E89133F68E;
 Tue, 15 Oct 2019 03:00:02 -0700 (PDT)
Date: Tue, 15 Oct 2019 11:00:01 +0100
From: Andrew Murray <andrew.murray@arm.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v3 4/4] KVM: arm64: pmu: Reset sample period on overflow
 handling
Message-ID: <20191015100000.GT42880@e119886-lin.cambridge.arm.com>
References: <20191011123954.31378-1-maz@kernel.org>
 <20191011123954.31378-5-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191011123954.31378-5-maz@kernel.org>
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

On Fri, Oct 11, 2019 at 01:39:54PM +0100, Marc Zyngier wrote:
> The PMU emulation code uses the perf event sample period to trigger
> the overflow detection. This works fine  for the *first* overflow
> handling, but results in a huge number of interrupts on the host,
> unrelated to the number of interrupts handled in the guest (a x20
> factor is pretty common for the cycle counter). On a slow system
> (such as a SW model), this can result in the guest only making
> forward progress at a glacial pace.
> 
> It turns out that the clue is in the name. The sample period is
> exactly that: a period. And once the an overflow has occured,
> the following period should be the full width of the associated
> counter, instead of whatever the guest had initially programed.
> 
> Reset the sample period to the architected value in the overflow
> handler, which now results in a number of host interrupts that is
> much closer to the number of interrupts in the guest.
> 
> Fixes: b02386eb7dac ("arm64: KVM: Add PMU overflow interrupt routing")
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---

Reviewed-by: Andrew Murray <andrew.murray@arm.com>

>  virt/kvm/arm/pmu.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
> index f291d4ac3519..8731dfeced8b 100644
> --- a/virt/kvm/arm/pmu.c
> +++ b/virt/kvm/arm/pmu.c
> @@ -8,6 +8,7 @@
>  #include <linux/kvm.h>
>  #include <linux/kvm_host.h>
>  #include <linux/perf_event.h>
> +#include <linux/perf/arm_pmu.h>
>  #include <linux/uaccess.h>
>  #include <asm/kvm_emulate.h>
>  #include <kvm/arm_pmu.h>
> @@ -442,8 +443,25 @@ static void kvm_pmu_perf_overflow(struct perf_event *perf_event,
>  				  struct pt_regs *regs)
>  {
>  	struct kvm_pmc *pmc = perf_event->overflow_handler_context;
> +	struct arm_pmu *cpu_pmu = to_arm_pmu(perf_event->pmu);
>  	struct kvm_vcpu *vcpu = kvm_pmc_to_vcpu(pmc);
>  	int idx = pmc->idx;
> +	u64 period;
> +
> +	cpu_pmu->pmu.stop(perf_event, PERF_EF_UPDATE);
> +
> +	/*
> +	 * Reset the sample period to the architectural limit,
> +	 * i.e. the point where the counter overflows.
> +	 */
> +	period = -(local64_read(&perf_event->count));
> +
> +	if (!kvm_pmu_idx_is_64bit(vcpu, pmc->idx))
> +		period &= GENMASK(31, 0);
> +
> +	local64_set(&perf_event->hw.period_left, 0);
> +	perf_event->attr.sample_period = period;
> +	perf_event->hw.sample_period = period;
>  
>  	__vcpu_sys_reg(vcpu, PMOVSSET_EL0) |= BIT(idx);
>  
> @@ -451,6 +469,8 @@ static void kvm_pmu_perf_overflow(struct perf_event *perf_event,
>  		kvm_make_request(KVM_REQ_IRQ_PENDING, vcpu);
>  		kvm_vcpu_kick(vcpu);
>  	}
> +
> +	cpu_pmu->pmu.start(perf_event, PERF_EF_RELOAD);
>  }
>  
>  /**
> -- 
> 2.20.1
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
