Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 802E727BEE7
	for <lists+kvmarm@lfdr.de>; Tue, 29 Sep 2020 10:11:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E71894B2E0;
	Tue, 29 Sep 2020 04:11:34 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k28BNWcQdGyT; Tue, 29 Sep 2020 04:11:34 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8D4414B274;
	Tue, 29 Sep 2020 04:11:33 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D4B214B22A
 for <kvmarm@lists.cs.columbia.edu>; Tue, 29 Sep 2020 04:11:31 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FfUGOtaJTpTP for <kvmarm@lists.cs.columbia.edu>;
 Tue, 29 Sep 2020 04:11:30 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9BFB64B207
 for <kvmarm@lists.cs.columbia.edu>; Tue, 29 Sep 2020 04:11:30 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6A57D20897;
 Tue, 29 Sep 2020 08:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601367089;
 bh=2QtfuAN12D0f3UZ6nHo4OKWmNd0W3GooleNYU97QzbA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Iz4qozHvccRRoCfKpWtAi3one5bCCu9wDBlO5CNB9ckO/Fox3MisSb7/8ncL/jGos
 +F6tdhPl8lDIV1AJg22Hwi93YXUT3yRnyJfRf7Wdkq1+SHFP6ZLLvt1sdy1OX86YWi
 OGClXcTR2HkrGNny0R+wm8cF2O6tYAKgcf2Kg738=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1kNAjP-00FiPB-JV; Tue, 29 Sep 2020 09:11:27 +0100
MIME-Version: 1.0
Date: Tue, 29 Sep 2020 09:11:27 +0100
From: Marc Zyngier <maz@kernel.org>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Subject: Re: [PATCH v7 5/7] KVM: arm64: pmu: Make overflow handler NMI safe
In-Reply-To: <20200924110706.254996-6-alexandru.elisei@arm.com>
References: <20200924110706.254996-1-alexandru.elisei@arm.com>
 <20200924110706.254996-6-alexandru.elisei@arm.com>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <14a0562fee95d5c7aa5bc6b67d213858@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: alexandru.elisei@arm.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 mark.rutland@arm.com, sumit.garg@linaro.org, swboyd@chromium.org,
 catalin.marinas@arm.com, will@kernel.org, julien.thierry@arm.com,
 julien.thierry.kdev@gmail.com, marc.zyngier@arm.com, will.deacon@arm.com,
 james.morse@arm.com, suzuki.poulose@arm.com, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: sumit.garg@linaro.org, kvm@vger.kernel.org,
 Marc Zyngier <marc.zyngier@arm.com>, catalin.marinas@arm.com,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 swboyd@chromium.org, will@kernel.org, kvmarm@lists.cs.columbia.edu,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On 2020-09-24 12:07, Alexandru Elisei wrote:
> From: Julien Thierry <julien.thierry@arm.com>
> 
> kvm_vcpu_kick() is not NMI safe. When the overflow handler is called 
> from
> NMI context, defer waking the vcpu to an irq_work queue.
> 
> A vcpu can be freed while it's not running by kvm_destroy_vm(). Prevent
> running the irq_work for a non-existent vcpu by calling irq_work_sync() 
> on
> the PMU destroy path.
> 
> Cc: Julien Thierry <julien.thierry.kdev@gmail.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Suzuki K Pouloze <suzuki.poulose@arm.com>
> Cc: kvm@vger.kernel.org
> Cc: kvmarm@lists.cs.columbia.edu
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Tested-by: Sumit Garg <sumit.garg@linaro.org> (Developerbox)
> [Alexandru E.: Added irq_work_sync()]
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> ---
> I suggested in v6 that I will add an irq_work_sync() to
> kvm_pmu_vcpu_reset(). It turns out it's not necessary: a vcpu reset is 
> done
> by the vcpu being reset with interrupts enabled, which means all the 
> work
> has had a chance to run before the reset takes place.

I don't understand your argument about interrupts being enabled. The 
real
reason for not needing any synchronization is that all that the queued 
work
does is to kick the vcpu. Given that the vcpu is resetting, no amount of
kicking is going to change anything (it is already outside of the 
guest).

Things are obviously different on destroy, where the vcpu is actively 
going
away and we need to make sure we don't use stale data.

> 
>  arch/arm64/kvm/pmu-emul.c | 26 +++++++++++++++++++++++++-
>  include/kvm/arm_pmu.h     |  1 +
>  2 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
> index f0d0312c0a55..81916e360b1e 100644
> --- a/arch/arm64/kvm/pmu-emul.c
> +++ b/arch/arm64/kvm/pmu-emul.c
> @@ -269,6 +269,7 @@ void kvm_pmu_vcpu_destroy(struct kvm_vcpu *vcpu)
> 
>  	for (i = 0; i < ARMV8_PMU_MAX_COUNTERS; i++)
>  		kvm_pmu_release_perf_event(&pmu->pmc[i]);
> +	irq_work_sync(&vcpu->arch.pmu.overflow_work);
>  }
> 
>  u64 kvm_pmu_valid_counter_mask(struct kvm_vcpu *vcpu)
> @@ -433,6 +434,22 @@ void kvm_pmu_sync_hwstate(struct kvm_vcpu *vcpu)
>  	kvm_pmu_update_state(vcpu);
>  }
> 
> +/**
> + * When perf interrupt is an NMI, we cannot safely notify the vcpu
> corresponding
> + * to the event.
> + * This is why we need a callback to do it once outside of the NMI 
> context.
> + */
> +static void kvm_pmu_perf_overflow_notify_vcpu(struct irq_work *work)
> +{
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_pmu *pmu;
> +
> +	pmu = container_of(work, struct kvm_pmu, overflow_work);
> +	vcpu = kvm_pmc_to_vcpu(pmu->pmc);
> +
> +	kvm_vcpu_kick(vcpu);
> +}
> +
>  /**
>   * When the perf event overflows, set the overflow status and inform 
> the vcpu.
>   */
> @@ -465,7 +482,11 @@ static void kvm_pmu_perf_overflow(struct
> perf_event *perf_event,
> 
>  	if (kvm_pmu_overflow_status(vcpu)) {
>  		kvm_make_request(KVM_REQ_IRQ_PENDING, vcpu);
> -		kvm_vcpu_kick(vcpu);
> +
> +		if (!in_nmi())
> +			kvm_vcpu_kick(vcpu);
> +		else
> +			irq_work_queue(&vcpu->arch.pmu.overflow_work);
>  	}
> 
>  	cpu_pmu->pmu.start(perf_event, PERF_EF_RELOAD);
> @@ -764,6 +785,9 @@ static int kvm_arm_pmu_v3_init(struct kvm_vcpu 
> *vcpu)
>  			return ret;
>  	}
> 
> +	init_irq_work(&vcpu->arch.pmu.overflow_work,
> +		      kvm_pmu_perf_overflow_notify_vcpu);
> +
>  	vcpu->arch.pmu.created = true;
>  	return 0;
>  }
> diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
> index 6db030439e29..dbf4f08d42e5 100644
> --- a/include/kvm/arm_pmu.h
> +++ b/include/kvm/arm_pmu.h
> @@ -27,6 +27,7 @@ struct kvm_pmu {
>  	bool ready;
>  	bool created;
>  	bool irq_level;
> +	struct irq_work overflow_work;

Nit: placing this new field right after the pmc array would avoid 
creating
an unnecessary padding in the structure. Not a big deal, and definitely
something we can sort out when applying the patch.

>  };
> 
>  #define kvm_arm_pmu_v3_ready(v)		((v)->arch.pmu.ready)

Reviewed-by: Marc Zyngier <maz@kernel.org>

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
