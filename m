Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8115D114F87
	for <lists+kvmarm@lfdr.de>; Fri,  6 Dec 2019 11:56:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 046394AF48;
	Fri,  6 Dec 2019 05:56:39 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x7DZdtwTiw+1; Fri,  6 Dec 2019 05:56:38 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id ED4AD4AF3A;
	Fri,  6 Dec 2019 05:56:37 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 804E54AF33
 for <kvmarm@lists.cs.columbia.edu>; Fri,  6 Dec 2019 05:56:36 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mRtXB+HPJGoY for <kvmarm@lists.cs.columbia.edu>;
 Fri,  6 Dec 2019 05:56:35 -0500 (EST)
Received: from inca-roads.misterjones.org (inca-roads.misterjones.org
 [213.251.177.50])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 5F9624AF2B
 for <kvmarm@lists.cs.columbia.edu>; Fri,  6 Dec 2019 05:56:35 -0500 (EST)
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
 (envelope-from <maz@kernel.org>)
 id 1idBHd-0001CF-6Z; Fri, 06 Dec 2019 11:56:25 +0100
To: linmiaohe <linmiaohe@huawei.com>
Subject: Re: [PATCH] KVM: arm: fix missing =?UTF-8?Q?free=5Fpercpu=5Firq?=
 =?UTF-8?Q?=20in=20kvm=5Ftimer=5Fhyp=5Finit=28=29?=
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Date: Fri, 06 Dec 2019 10:56:24 +0000
From: Marc Zyngier <maz@kernel.org>
In-Reply-To: <1574476229-15448-1-git-send-email-linmiaohe@huawei.com>
References: <1574476229-15448-1-git-send-email-linmiaohe@huawei.com>
Message-ID: <96f07f61e3356c942ce934f81efc4a94@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: linmiaohe@huawei.com, pbonzini@redhat.com,
 rkrcmar@redhat.com, james.morse@arm.com, julien.thierry.kdev@gmail.com,
 suzuki.poulose@arm.com, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On 2019-11-23 02:30, linmiaohe wrote:
> From: Miaohe Lin <linmiaohe@huawei.com>
>
> When host_ptimer_irq request irq resource failed, we forget
> to release the host_vtimer_irq resource already requested.
> Fix this missing irq release and other similar scenario.

That's really not a big deal, as nothing but KVM can use the
timers anyway, but I guess it doesn't hurt to be correct.

>
> Fixes: 9e01dc76be6a ("KVM: arm/arm64: arch_timer: Assign the phys
> timer on VHE systems")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  virt/kvm/arm/arch_timer.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
> index f182b2380345..73867f97040c 100644
> --- a/virt/kvm/arm/arch_timer.c
> +++ b/virt/kvm/arm/arch_timer.c
> @@ -935,7 +935,7 @@ int kvm_timer_hyp_init(bool has_gic)
>  					    kvm_get_running_vcpus());
>  		if (err) {
>  			kvm_err("kvm_arch_timer: error setting vcpu affinity\n");
> -			goto out_free_irq;
> +			goto out_free_vtimer_irq;
>  		}
>
>  		static_branch_enable(&has_gic_active_state);
> @@ -960,7 +960,7 @@ int kvm_timer_hyp_init(bool has_gic)
>  		if (err) {
>  			kvm_err("kvm_arch_timer: can't request ptimer interrupt %d 
> (%d)\n",
>  				host_ptimer_irq, err);
> -			return err;
> +			goto out_disable_gic_state;
>  		}
>
>  		if (has_gic) {
> @@ -968,7 +968,7 @@ int kvm_timer_hyp_init(bool has_gic)
>  						    kvm_get_running_vcpus());
>  			if (err) {
>  				kvm_err("kvm_arch_timer: error setting vcpu affinity\n");
> -				goto out_free_irq;
> +				goto out_free_ptimer_irq;
>  			}
>  		}
>
> @@ -977,15 +977,22 @@ int kvm_timer_hyp_init(bool has_gic)
>  		kvm_err("kvm_arch_timer: invalid physical timer IRQ: %d\n",
>  			info->physical_irq);
>  		err = -ENODEV;
> -		goto out_free_irq;
> +		goto out_disable_gic_state;
>  	}
>
>  	cpuhp_setup_state(CPUHP_AP_KVM_ARM_TIMER_STARTING,
>  			  "kvm/arm/timer:starting", kvm_timer_starting_cpu,
>  			  kvm_timer_dying_cpu);
>  	return 0;
> -out_free_irq:
> +
> +out_free_ptimer_irq:
> +	free_percpu_irq(host_ptimer_irq, kvm_get_running_vcpus());
> +out_disable_gic_state:
> +	if (has_gic)
> +		static_branch_disable(&has_gic_active_state);

Given that we're failing the init of KVM, this is totally
superfluous. Also, this state is still valid, no matter
what happens (the GIC is not going away from under our feet).

> +out_free_vtimer_irq:
>  	free_percpu_irq(host_vtimer_irq, kvm_get_running_vcpus());
> +
>  	return err;
>  }

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
