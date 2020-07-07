Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A75F2217491
	for <lists+kvmarm@lfdr.de>; Tue,  7 Jul 2020 18:59:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B306D4B128;
	Tue,  7 Jul 2020 12:59:39 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UBYo8FchJAsu; Tue,  7 Jul 2020 12:59:39 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 59E824B10F;
	Tue,  7 Jul 2020 12:59:38 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CEC8A4B0FE
 for <kvmarm@lists.cs.columbia.edu>; Tue,  7 Jul 2020 12:59:36 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X67k8SnlDSmx for <kvmarm@lists.cs.columbia.edu>;
 Tue,  7 Jul 2020 12:59:35 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 65B354B0F2
 for <kvmarm@lists.cs.columbia.edu>; Tue,  7 Jul 2020 12:59:35 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5CC841FB;
 Tue,  7 Jul 2020 09:59:34 -0700 (PDT)
Received: from [192.168.0.110] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 252CD3F68F;
 Tue,  7 Jul 2020 09:59:32 -0700 (PDT)
Subject: Re: [PATCH v3 16/17] KVM: arm64: timers: Rename
 kvm_timer_sync_hwstate to kvm_timer_sync_user
To: Marc Zyngier <maz@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
References: <20200706125425.1671020-1-maz@kernel.org>
 <20200706125425.1671020-17-maz@kernel.org>
From: Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <1f175416-5f2f-7e76-9a59-ce540d3823b9@arm.com>
Date: Tue, 7 Jul 2020 18:00:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200706125425.1671020-17-maz@kernel.org>
Content-Language: en-US
Cc: kernel-team@android.com, Andre Przywara <andre.przywara@arm.com>,
 Dave Martin <Dave.Martin@arm.com>, George Cherian <gcherian@marvell.com>,
 "Zengtao \(B\)" <prime.zeng@hisilicon.com>, Will Deacon <will@kernel.org>
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

On 7/6/20 1:54 PM, Marc Zyngier wrote:
> kvm_timer_sync_hwstate() has nothing to do with the timer HW state,
> but more to do with the state of a userspace interrupt controller.
> Change the suffix from _hwstate to_user, in keeping with the rest
> of the code.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/kvm/arch_timer.c  | 2 +-
>  arch/arm64/kvm/arm.c         | 4 ++--
>  include/kvm/arm_arch_timer.h | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/kvm/arch_timer.c b/arch/arm64/kvm/arch_timer.c
> index a1fe0ea3254e..33d85a504720 100644
> --- a/arch/arm64/kvm/arch_timer.c
> +++ b/arch/arm64/kvm/arch_timer.c
> @@ -615,7 +615,7 @@ static void unmask_vtimer_irq_user(struct kvm_vcpu *vcpu)
>  	}
>  }
>  
> -void kvm_timer_sync_hwstate(struct kvm_vcpu *vcpu)
> +void kvm_timer_sync_user(struct kvm_vcpu *vcpu)
>  {
>  	struct arch_timer_cpu *timer = vcpu_timer(vcpu);
>  
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index beb0e68cccaa..e52f2b2305b5 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -723,7 +723,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>  			isb(); /* Ensure work in x_flush_hwstate is committed */
>  			kvm_pmu_sync_hwstate(vcpu);
>  			if (static_branch_unlikely(&userspace_irqchip_in_use))
> -				kvm_timer_sync_hwstate(vcpu);
> +				kvm_timer_sync_user(vcpu);
>  			kvm_vgic_sync_hwstate(vcpu);
>  			local_irq_enable();
>  			preempt_enable();
> @@ -768,7 +768,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>  		 * timer virtual interrupt state.
>  		 */
>  		if (static_branch_unlikely(&userspace_irqchip_in_use))
> -			kvm_timer_sync_hwstate(vcpu);
> +			kvm_timer_sync_user(vcpu);
>  
>  		kvm_arch_vcpu_ctxsync_fp(vcpu);
>  
> diff --git a/include/kvm/arm_arch_timer.h b/include/kvm/arm_arch_timer.h
> index d120e6c323e7..a821dd1df0cf 100644
> --- a/include/kvm/arm_arch_timer.h
> +++ b/include/kvm/arm_arch_timer.h
> @@ -71,7 +71,7 @@ int kvm_timer_hyp_init(bool);
>  int kvm_timer_enable(struct kvm_vcpu *vcpu);
>  int kvm_timer_vcpu_reset(struct kvm_vcpu *vcpu);
>  void kvm_timer_vcpu_init(struct kvm_vcpu *vcpu);
> -void kvm_timer_sync_hwstate(struct kvm_vcpu *vcpu);
> +void kvm_timer_sync_user(struct kvm_vcpu *vcpu);
>  bool kvm_timer_should_notify_user(struct kvm_vcpu *vcpu);
>  void kvm_timer_update_run(struct kvm_vcpu *vcpu);
>  void kvm_timer_vcpu_terminate(struct kvm_vcpu *vcpu);

This patch makes sense to me. All throughout arm64 KVM we use hwstate for hardware
registers, for both the vgic and the pmu. On top of that, the function calls
unmask_vtimer_irq_*user*() (emphasis added):

Reviewed-by: Alexandru Elisei <alexandru.elisei@arm.com>

Thanks,
Alex
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
