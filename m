Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A7F45260FBD
	for <lists+kvmarm@lfdr.de>; Tue,  8 Sep 2020 12:28:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 41EC84B5B3;
	Tue,  8 Sep 2020 06:28:21 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oHW5BKWzFoIS; Tue,  8 Sep 2020 06:28:21 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 35E384B5A6;
	Tue,  8 Sep 2020 06:28:20 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E18084B59F
 for <kvmarm@lists.cs.columbia.edu>; Tue,  8 Sep 2020 06:28:18 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M7PXw+fxcdLN for <kvmarm@lists.cs.columbia.edu>;
 Tue,  8 Sep 2020 06:28:17 -0400 (EDT)
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EC69B4B59C
 for <kvmarm@lists.cs.columbia.edu>; Tue,  8 Sep 2020 06:28:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599560897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BognJb/bGGBUr0km+Byb87HBFXxsJycPQ/KwVZJJVBs=;
 b=CFUxHo2ehAv7piS7SWHE2f7mahXd5jwrtASDfwKgfemkbrpgXZnIx7Qdd3rIckZG8tNSQ0
 Ms/QPghl/hSuKZUt7tnt4gvyYzOAmkB1DGb0Xvy4i/SvSQt+eDleVE1TSJbzdW6Cc9a9Uj
 EHjcexOJ3Nqx7ABxqpe1zr3FF0Ln09A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-avFPdqsDM22Kl8y2G5QsRA-1; Tue, 08 Sep 2020 06:28:14 -0400
X-MC-Unique: avFPdqsDM22Kl8y2G5QsRA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B23A1074642;
 Tue,  8 Sep 2020 10:28:12 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 933FD10013C4;
 Tue,  8 Sep 2020 10:28:10 +0000 (UTC)
Date: Tue, 8 Sep 2020 12:28:07 +0200
From: Andrew Jones <drjones@redhat.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v3 5/5] KVM: arm64: Document PMU filtering API
Message-ID: <20200908102807.alzosskf3wre4bmd@kamzik.brq.redhat.com>
References: <20200908075830.1161921-1-maz@kernel.org>
 <20200908075830.1161921-6-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200908075830.1161921-6-maz@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: kvm@vger.kernel.org, kernel-team@android.com, graf@amazon.com,
 Robin Murphy <robin.murphy@arm.com>, kvmarm@lists.cs.columbia.edu,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On Tue, Sep 08, 2020 at 08:58:30AM +0100, Marc Zyngier wrote:
> Add a small blurb describing how the event filtering API gets used.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  Documentation/virt/kvm/devices/vcpu.rst | 46 +++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/Documentation/virt/kvm/devices/vcpu.rst b/Documentation/virt/kvm/devices/vcpu.rst
> index ca374d3fe085..203b91e93151 100644
> --- a/Documentation/virt/kvm/devices/vcpu.rst
> +++ b/Documentation/virt/kvm/devices/vcpu.rst
> @@ -55,6 +55,52 @@ Request the initialization of the PMUv3.  If using the PMUv3 with an in-kernel
>  virtual GIC implementation, this must be done after initializing the in-kernel
>  irqchip.
>  
> +1.3 ATTRIBUTE: KVM_ARM_VCPU_PMU_V3_FILTER
> +---------------------------------------

Need a couple more '--'

> +
> +:Parameters: in kvm_device_attr.addr the address for a PMU event filter is a
> +             pointer to a struct kvm_pmu_event_filter
> +
> +:Returns:
> +
> +	 =======  ======================================================
> +	 -ENODEV: PMUv3 not supported or GIC not initialized
> +	 -ENXIO:  PMUv3 not properly configured or in-kernel irqchip not
> +	 	  configured as required prior to calling this attribute
> +	 -EBUSY:  PMUv3 already initialized
> +	 -EINVAL: Invalid filter range
> +	 =======  ======================================================
> +
> +Request the installation of a PMU event filter describe as follows:

described

> +
> +struct kvm_pmu_event_filter {
> +	__u16	base_event;
> +	__u16	nevents;
> +
> +#define KVM_PMU_EVENT_ALLOW	0
> +#define KVM_PMU_EVENT_DENY	1
> +
> +	__u8	action;
> +	__u8	pad[3];
> +};
> +
> +A filter range is defined as the range [@base_event, @base_event + @nevents[,

closing ] is reversed, and should it be [] or [) ?

> +together with an @action (KVM_PMU_EVENT_ALLOW or KVM_PMU_EVENT_DENY). The
> +first registered range defines the global policy (global ALLOW if the first
> +@action is DENY, global DENY if the first @action is ALLOW). Multiple ranges
> +can be programmed, and must fit within the event space defined by the PMU
> +architecture (10 bits on ARMv8.0, 16 bits from ARMv8.1 onwards).
> +
> +Note: "Cancelling" a filter by registering the opposite action for the same
> +range doesn't change the default action. For example, installing an ALLOW
> +filter for event range [0:10] as the first filter and then applying a DENY

[) ?

> +action for the same range will leave the whole range as disabled.
> +
> +Restrictions: Event 0 (SW_INCR) is never filtered, as it doesn't count a
> +hardware event. Filtering event 0x1E (CHAIN) has no effect either, as it
> +isn't strictly speaking an event. Filtering the cycle counter is possible
> +using event 0x11 (CPU_CYCLES).
> +
>  
>  2. GROUP: KVM_ARM_VCPU_TIMER_CTRL
>  =================================
> -- 
> 2.28.0
> 
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
> 

Otherwise

Reviewed-by: Andrew Jones <drjones@redhat.com>

Thanks,
drew

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
