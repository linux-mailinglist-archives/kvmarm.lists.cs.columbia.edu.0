Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 420D310DD46
	for <lists+kvmarm@lfdr.de>; Sat, 30 Nov 2019 10:29:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AD1DD4AEF1;
	Sat, 30 Nov 2019 04:29:54 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IYgVCYpUXYkA; Sat, 30 Nov 2019 04:29:54 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9A5924AEDA;
	Sat, 30 Nov 2019 04:29:53 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3702C4AED0
 for <kvmarm@lists.cs.columbia.edu>; Sat, 30 Nov 2019 04:29:52 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UIyF4ne7ZT5H for <kvmarm@lists.cs.columbia.edu>;
 Sat, 30 Nov 2019 04:29:50 -0500 (EST)
Received: from huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 8DCEE4ACC4
 for <kvmarm@lists.cs.columbia.edu>; Sat, 30 Nov 2019 04:29:50 -0500 (EST)
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.54])
 by Forcepoint Email with ESMTP id 8AF326C3FE04F1522288;
 Sat, 30 Nov 2019 17:29:45 +0800 (CST)
Received: from dggeme766-chm.china.huawei.com (10.3.19.112) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 30 Nov 2019 17:29:44 +0800
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 dggeme766-chm.china.huawei.com (10.3.19.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Sat, 30 Nov 2019 17:29:45 +0800
Received: from dggeme763-chm.china.huawei.com ([10.6.66.36]) by
 dggeme763-chm.china.huawei.com ([10.6.66.36]) with mapi id 15.01.1713.004;
 Sat, 30 Nov 2019 17:29:44 +0800
From: linmiaohe <linmiaohe@huawei.com>
To: "maz@kernel.org" <maz@kernel.org>, "james.morse@arm.com"
 <james.morse@arm.com>, "julien.thierry.kdev@gmail.com"
 <julien.thierry.kdev@gmail.com>, "suzuki.poulose@arm.com"
 <suzuki.poulose@arm.com>, "christoffer.dall@arm.com"
 <christoffer.dall@arm.com>, "catalin.marinas@arm.com"
 <catalin.marinas@arm.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "will@kernel.org"
 <will@kernel.org>, "andre.przywara@arm.com" <andre.przywara@arm.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>
Subject: Re: [PATCH] KVM: arm: fix missing free_percpu_irq in
 kvm_timer_hyp_init()
Thread-Topic: [PATCH] KVM: arm: fix missing free_percpu_irq in
 kvm_timer_hyp_init()
Thread-Index: AdWnUfxPfkqh2LUwSkWjIhnvKAeisg==
Date: Sat, 30 Nov 2019 09:29:44 +0000
Message-ID: <c7c89488701c4340be6ec8de468c30ea@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.184.189.20]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

friendly ping ...
> From: Miaohe Lin <linmiaohe@huawei.com>
>
> When host_ptimer_irq request irq resource failed, we forget to release the host_vtimer_irq resource already requested.
> Fix this missing irq release and other similar scenario.
>
> Fixes: 9e01dc76be6a ("KVM: arm/arm64: arch_timer: Assign the phys timer on VHE systems")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  virt/kvm/arm/arch_timer.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c index f182b2380345..73867f97040c 100644
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
>  			kvm_err("kvm_arch_timer: can't request ptimer interrupt %d (%d)\n",
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
> +out_free_vtimer_irq:
>  	free_percpu_irq(host_vtimer_irq, kvm_get_running_vcpus());
> +
>  	return err;
>  }
>  
> --
> 2.19.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
