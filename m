Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D422B132209
	for <lists+kvmarm@lfdr.de>; Tue,  7 Jan 2020 10:16:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 566A54AF13;
	Tue,  7 Jan 2020 04:16:15 -0500 (EST)
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
	with ESMTP id Sr2fQVVoU7Xo; Tue,  7 Jan 2020 04:16:15 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1CDED4AF0A;
	Tue,  7 Jan 2020 04:16:14 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 889A34AF05
 for <kvmarm@lists.cs.columbia.edu>; Tue,  7 Jan 2020 04:16:12 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g1RbNuUFXODM for <kvmarm@lists.cs.columbia.edu>;
 Tue,  7 Jan 2020 04:16:11 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 4CBBA4AF03
 for <kvmarm@lists.cs.columbia.edu>; Tue,  7 Jan 2020 04:16:11 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 38B2920656;
 Tue,  7 Jan 2020 09:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1578388570;
 bh=hdFiCaeaNP79bTue6oK3n76q0rsZ9EjJ5bhLkJslDM8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=w0RyRqrDUQlTP1euuzRbIXeNZRqGkpwEvpAwzpKbuY7InKXmxbL20omILRfsrnFEE
 dmpIx2rlolza0oax2ce89zyFWA/z/y+UOPTguSQ71+j07OjmMHTYj6FxIzEnx7PEMB
 3ZN7lXAqfL6LFrKu9dIQLSmHfd7BX9aduw+3immQ=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1ioky8-0000iX-HV; Tue, 07 Jan 2020 09:16:08 +0000
MIME-Version: 1.0
Date: Tue, 07 Jan 2020 09:16:08 +0000
From: Marc Zyngier <maz@kernel.org>
To: Jianyong Wu <jianyong.wu@arm.com>
Subject: Re: [RFC PATCH v9 6/8] psci: Add hvc call service for ptp_kvm.
In-Reply-To: <20191210034026.45229-7-jianyong.wu@arm.com>
References: <20191210034026.45229-1-jianyong.wu@arm.com>
 <20191210034026.45229-7-jianyong.wu@arm.com>
Message-ID: <7383dc06897bba253f174cd21a19b5c0@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.8
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: jianyong.wu@arm.com, netdev@vger.kernel.org,
 yangbo.lu@nxp.com, john.stultz@linaro.org, tglx@linutronix.de,
 pbonzini@redhat.com, sean.j.christopherson@intel.com, richardcochran@gmail.com,
 Mark.Rutland@arm.com, will@kernel.org, suzuki.poulose@arm.com,
 steven.price@arm.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org, Steve.Capper@arm.com, Kaly.Xin@arm.com, justin.he@arm.com,
 nd@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: justin.he@arm.com, kvm@vger.kernel.org, netdev@vger.kernel.org,
 richardcochran@gmail.com, linux-kernel@vger.kernel.org,
 sean.j.christopherson@intel.com, steven.price@arm.com, john.stultz@linaro.org,
 yangbo.lu@nxp.com, pbonzini@redhat.com, tglx@linutronix.de, nd@arm.com,
 will@kernel.org, kvmarm@lists.cs.columbia.edu,
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

On 2019-12-10 03:40, Jianyong Wu wrote:
> ptp_kvm modules will call hvc to get this service.
> The service offers real time and counter cycle of host for guest.
> 
> Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>
> ---
>  include/linux/arm-smccc.h | 12 ++++++++++++
>  virt/kvm/arm/psci.c       | 22 ++++++++++++++++++++++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
> index 6f82c87308ed..aafb6bac167d 100644
> --- a/include/linux/arm-smccc.h
> +++ b/include/linux/arm-smccc.h
> @@ -94,6 +94,7 @@
> 
>  /* KVM "vendor specific" services */
>  #define ARM_SMCCC_KVM_FUNC_FEATURES		0
> +#define ARM_SMCCC_KVM_PTP			1
>  #define ARM_SMCCC_KVM_FUNC_FEATURES_2		127
>  #define ARM_SMCCC_KVM_NUM_FUNCS			128
> 
> @@ -103,6 +104,17 @@
>  			   ARM_SMCCC_OWNER_VENDOR_HYP,			\
>  			   ARM_SMCCC_KVM_FUNC_FEATURES)
> 
> +/*
> + * This ID used for virtual ptp kvm clock and it will pass second 
> value
> + * and nanosecond value of host real time and system counter by vcpu
> + * register to guest.
> + */
> +#define ARM_SMCCC_VENDOR_HYP_KVM_PTP_FUNC_ID				\
> +	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,				\
> +			   ARM_SMCCC_SMC_32,				\
> +			   ARM_SMCCC_OWNER_VENDOR_HYP,			\
> +			   ARM_SMCCC_KVM_PTP)
> +

All of this depends on patches that have never need posted to any ML, 
and
just linger in Will's tree. You need to pick them up and post them as 
part
of this series so that they can at least be reviewed.

>  #ifndef __ASSEMBLY__
> 
>  #include <linux/linkage.h>
> diff --git a/virt/kvm/arm/psci.c b/virt/kvm/arm/psci.c
> index 0debf49bf259..682d892d6717 100644
> --- a/virt/kvm/arm/psci.c
> +++ b/virt/kvm/arm/psci.c
> @@ -9,6 +9,7 @@
>  #include <linux/kvm_host.h>
>  #include <linux/uaccess.h>
>  #include <linux/wait.h>
> +#include <linux/clocksource_ids.h>
> 
>  #include <asm/cputype.h>
>  #include <asm/kvm_emulate.h>
> @@ -389,6 +390,8 @@ static int kvm_psci_call(struct kvm_vcpu *vcpu)
> 
>  int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
>  {
> +	struct system_time_snapshot systime_snapshot;
> +	u64 cycles;
>  	u32 func_id = smccc_get_function(vcpu);
>  	u32 val[4] = {};
>  	u32 option;
> @@ -431,6 +434,25 @@ int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
>  	case ARM_SMCCC_VENDOR_HYP_KVM_FEATURES_FUNC_ID:
>  		val[0] = BIT(ARM_SMCCC_KVM_FUNC_FEATURES);
>  		break;
> +	/*
> +	 * This will used for virtual ptp kvm clock. three
> +	 * values will be passed back.
> +	 * reg0 stores high 32-bit host ktime;
> +	 * reg1 stores low 32-bit host ktime;
> +	 * reg2 stores high 32-bit difference of host cycles and cntvoff;
> +	 * reg3 stores low 32-bit difference of host cycles and cntvoff.

That's either two or four values, and not three as you claim above.

Also, I fail to understand the meaning of the host cycle vs cntvoff
comparison. This is something that guest can perform on its own
(it has access to both physical and virtual timers, and can compute
cntvoff without intervention of the hypervisor).

Finally, how does it work with nested virt, where cntvoff is for the
the vEL2 guest?

> +	 */
> +	case ARM_SMCCC_VENDOR_HYP_KVM_PTP_FUNC_ID:
> +		ktime_get_snapshot(&systime_snapshot);
> +		if (systime_snapshot.cs_id != CSID_ARM_ARCH_COUNTER)
> +			return kvm_psci_call(vcpu);

What does this mean? Calling PSCI because you've failed to identify
the clock source? What result do you expect from this? Hint: this
isn't a PSCI call.

Cosmetic comments below:

> +		val[0] = systime_snapshot.real >> 32;

val[0] = upper_32_bits(systime_snapshot.real);

> +		val[1] = systime_snapshot.real << 32 >> 32;

val[1] = lower_32_bits(systime_snapshot.real);

> +		cycles = systime_snapshot.cycles -
> +			 vcpu_vtimer(vcpu)->cntvoff;

On a single line please.

> +		val[2] = cycles >> 32;
> +		val[3] = cycles << 32 >> 32;

Same as above.

> +		break;
>  	default:
>  		return kvm_psci_call(vcpu);
>  	}

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
