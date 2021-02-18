Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 837F831ED6B
	for <lists+kvmarm@lfdr.de>; Thu, 18 Feb 2021 18:41:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 15F474B3BA;
	Thu, 18 Feb 2021 12:41:05 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q4CHgon0Uqtq; Thu, 18 Feb 2021 12:41:04 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CE9FA4B38A;
	Thu, 18 Feb 2021 12:41:03 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BE53C4B340
 for <kvmarm@lists.cs.columbia.edu>; Thu, 18 Feb 2021 12:41:01 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eZjl4c5dGmYT for <kvmarm@lists.cs.columbia.edu>;
 Thu, 18 Feb 2021 12:41:00 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 679E74B338
 for <kvmarm@lists.cs.columbia.edu>; Thu, 18 Feb 2021 12:41:00 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE2691FB;
 Thu, 18 Feb 2021 09:40:59 -0800 (PST)
Received: from [192.168.0.110] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23B873F694;
 Thu, 18 Feb 2021 09:40:59 -0800 (PST)
Subject: Re: [PATCH v2 2/2] KVM: arm64: Don't access PMSELR_EL0/PMUSERENR_EL0
 when no PMU is available
To: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu
References: <20210209114844.3278746-1-maz@kernel.org>
 <20210209114844.3278746-3-maz@kernel.org>
From: Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <29f59d2d-af94-ae53-4ba2-51f9d30017e5@arm.com>
Date: Thu, 18 Feb 2021 17:41:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210209114844.3278746-3-maz@kernel.org>
Content-Language: en-US
Cc: Andre Przywara <andre.przywara@arm.com>, kernel-team@android.com
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

On 2/9/21 11:48 AM, Marc Zyngier wrote:
> When running under a nesting hypervisor, it isn't guaranteed that
> the virtual HW will include a PMU. In which case, let's not try
> to access the PMU registers in the world switch, as that'd be
> deadly.
>
> Reported-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/kernel/image-vars.h          | 3 +++
>  arch/arm64/kvm/hyp/include/hyp/switch.h | 9 ++++++---
>  2 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
> index f676243abac6..32af3c865700 100644
> --- a/arch/arm64/kernel/image-vars.h
> +++ b/arch/arm64/kernel/image-vars.h
> @@ -102,6 +102,9 @@ KVM_NVHE_ALIAS(__stop___kvm_ex_table);
>  /* Array containing bases of nVHE per-CPU memory regions. */
>  KVM_NVHE_ALIAS(kvm_arm_hyp_percpu_base);
>  
> +/* PMU available static key */
> +KVM_NVHE_ALIAS(kvm_arm_pmu_available);
> +
>  #endif /* CONFIG_KVM */
>  
>  #endif /* __ARM64_KERNEL_IMAGE_VARS_H */
> diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
> index 84473574c2e7..75c0faa3b791 100644
> --- a/arch/arm64/kvm/hyp/include/hyp/switch.h
> +++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
> @@ -90,15 +90,18 @@ static inline void __activate_traps_common(struct kvm_vcpu *vcpu)
>  	 * counter, which could make a PMXEVCNTR_EL0 access UNDEF at
>  	 * EL1 instead of being trapped to EL2.
>  	 */
> -	write_sysreg(0, pmselr_el0);
> -	write_sysreg(ARMV8_PMU_USERENR_MASK, pmuserenr_el0);
> +	if (kvm_arm_support_pmu_v3()) {
> +		write_sysreg(0, pmselr_el0);
> +		write_sysreg(ARMV8_PMU_USERENR_MASK, pmuserenr_el0);
> +	}
>  	write_sysreg(vcpu->arch.mdcr_el2, mdcr_el2);
>  }
>  
>  static inline void __deactivate_traps_common(void)
>  {
>  	write_sysreg(0, hstr_el2);
> -	write_sysreg(0, pmuserenr_el0);
> +	if (kvm_arm_support_pmu_v3())
> +		write_sysreg(0, pmuserenr_el0);
>  }
>  
>  static inline void ___activate_traps(struct kvm_vcpu *vcpu)

It looks to me like this indeed fixes the issue with accessing PMU registers even
if the PMU is not present. Found another instance in the world switch where the
PMU is accessed, in __kvm_vcpu_run() in the nvhe code, but in that case the
registers were accessed only if there were events that needed to be context
switched. No PMU on the host, no PMU on the guest and no events for either, so
that looks fine to me:

Reviewed-by: Alexandru Elisei <alexandru.elisei@arm.com>

Thanks,

Alex

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
