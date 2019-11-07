Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id AFF80F289A
	for <lists+kvmarm@lfdr.de>; Thu,  7 Nov 2019 09:01:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 471CF4ACAB;
	Thu,  7 Nov 2019 03:01:45 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ji+h7cfkRnJH; Thu,  7 Nov 2019 03:01:45 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2682E4ACA7;
	Thu,  7 Nov 2019 03:01:44 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D570E4AC85
 for <kvmarm@lists.cs.columbia.edu>; Thu,  7 Nov 2019 03:01:42 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X-8qr7v0rqGg for <kvmarm@lists.cs.columbia.edu>;
 Thu,  7 Nov 2019 03:01:42 -0500 (EST)
Received: from Galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id E2E5F4ACAB
 for <kvmarm@lists.cs.columbia.edu>; Thu,  7 Nov 2019 03:01:41 -0500 (EST)
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
 by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
 (Exim 4.80) (envelope-from <tglx@linutronix.de>)
 id 1iScjQ-0000io-4h; Thu, 07 Nov 2019 09:01:28 +0100
Date: Thu, 7 Nov 2019 09:01:26 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Jianyong Wu <jianyong.wu@arm.com>
Subject: Re: [RFC PATCH v6 5/7] psci: Add hvc call service for ptp_kvm.
In-Reply-To: <20191024110209.21328-6-jianyong.wu@arm.com>
Message-ID: <alpine.DEB.2.21.1911070856100.1869@nanos.tec.linutronix.de>
References: <20191024110209.21328-1-jianyong.wu@arm.com>
 <20191024110209.21328-6-jianyong.wu@arm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required, ALL_TRUSTED=-1,
 SHORTCIRCUIT=-0.0001
Cc: justin.he@arm.com, kvm@vger.kernel.org, maz@kernel.org,
 richardcochran@gmail.com, yangbo.lu@nxp.com, linux-kernel@vger.kernel.org,
 sean.j.christopherson@intel.com, john.stultz@linaro.org,
 netdev@vger.kernel.org, pbonzini@redhat.com, nd@arm.com, will@kernel.org,
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

On Thu, 24 Oct 2019, Jianyong Wu wrote:

> This patch is the base of ptp_kvm for arm64.

This patch ...

> ptp_kvm modules will call hvc to get this service.
> The service offers real time and counter cycle of host for guest.
> 
> Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>
> ---
>  drivers/clocksource/arm_arch_timer.c |  2 ++
>  include/clocksource/arm_arch_timer.h |  4 ++++
>  include/linux/arm-smccc.h            | 12 ++++++++++++
>  virt/kvm/arm/psci.c                  | 22 ++++++++++++++++++++++
>  4 files changed, 40 insertions(+)
> 
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index 07e57a49d1e8..e4ad38042ef6 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -29,6 +29,7 @@
>  #include <asm/virt.h>
>  
>  #include <clocksource/arm_arch_timer.h>
> +#include <linux/clocksource_ids.h>

Same ordering issue and lack of file.
 
> diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
> index 1d68d5613dae..426d749e8cf8 100644
> --- a/include/clocksource/arm_arch_timer.h
> +++ b/include/clocksource/arm_arch_timer.h
> @@ -104,6 +104,10 @@ static inline bool arch_timer_evtstrm_available(void)
>  	return false;
>  }
>  
> +bool is_arm_arch_counter(void *unuse)

A global function in a header file? You might want to make this static
inline. And while at it please s/unuse/unused/

> +{
> +	return false;
> +}
>  #endif
>  #include <linux/linkage.h>
> diff --git a/virt/kvm/arm/psci.c b/virt/kvm/arm/psci.c
> index 0debf49bf259..339bcbafac7b 100644
> --- a/virt/kvm/arm/psci.c
> +++ b/virt/kvm/arm/psci.c
> @@ -15,6 +15,7 @@
>  #include <asm/kvm_host.h>
>  
>  #include <kvm/arm_psci.h>
> +#include <linux/clocksource_ids.h>

Sigh.
  
>  /*
>   * This is an implementation of the Power State Coordination Interface
> @@ -392,6 +393,8 @@ int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
>  	u32 func_id = smccc_get_function(vcpu);
>  	u32 val[4] = {};
>  	u32 option;
> +	u64 cycles;
> +	struct system_time_snapshot systime_snapshot;

Also here you might notice that the variables are not randomly ordered.

Thanks,

	tglx
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
