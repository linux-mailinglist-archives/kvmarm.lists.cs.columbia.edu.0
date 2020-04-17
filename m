Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A1AC51ADC13
	for <lists+kvmarm@lfdr.de>; Fri, 17 Apr 2020 13:22:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 259214B28A;
	Fri, 17 Apr 2020 07:22:17 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VqpGDjMgFVnP; Fri, 17 Apr 2020 07:22:17 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E86EB4B20C;
	Fri, 17 Apr 2020 07:22:15 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C458D4B11B
 for <kvmarm@lists.cs.columbia.edu>; Fri, 17 Apr 2020 07:22:14 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J++xyK2qHJyg for <kvmarm@lists.cs.columbia.edu>;
 Fri, 17 Apr 2020 07:22:13 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7CE4F4B115
 for <kvmarm@lists.cs.columbia.edu>; Fri, 17 Apr 2020 07:22:13 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A059C14;
 Fri, 17 Apr 2020 04:22:13 -0700 (PDT)
Received: from [192.168.0.14] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA5BB3F6C4;
 Fri, 17 Apr 2020 04:22:11 -0700 (PDT)
Subject: Re: [PATCH v2 4/6] KVM: arm: vgic-v2: Only use the virtual state when
 userspace accesses pending bits
To: Marc Zyngier <maz@kernel.org>
References: <20200417083319.3066217-1-maz@kernel.org>
 <20200417083319.3066217-5-maz@kernel.org>
From: James Morse <james.morse@arm.com>
Message-ID: <4133d5f2-ed0e-9c4a-8a66-953fb6bf6e70@arm.com>
Date: Fri, 17 Apr 2020 12:22:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200417083319.3066217-5-maz@kernel.org>
Content-Language: en-GB
Cc: Julien Grall <julien@xen.org>, kvm@vger.kernel.org,
 Andre Przywara <Andre.Przywara@arm.com>, kvmarm@lists.cs.columbia.edu,
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

Hi Marc,

On 17/04/2020 09:33, Marc Zyngier wrote:
> There is no point in accessing the HW when writing to any of the
> ISPENDR/ICPENDR registers from userspace, as only the guest should
> be allowed to change the HW state.
> 
> Introduce new userspace-specific accessors that deal solely with
> the virtual state. Note that the API differs from that of GICv3,
> where userspace exclusively uses ISPENDR to set the state. Too
> bad we can't reuse it.

> diff --git a/virt/kvm/arm/vgic/vgic-mmio-v2.c b/virt/kvm/arm/vgic/vgic-mmio-v2.c
> index f51c6e939c76..a016f07adc28 100644
> --- a/virt/kvm/arm/vgic/vgic-mmio-v2.c
> +++ b/virt/kvm/arm/vgic/vgic-mmio-v2.c
> @@ -417,10 +417,12 @@ static const struct vgic_register_region vgic_v2_dist_registers[] = {
>  		NULL, vgic_uaccess_write_cenable, 1,
>  		VGIC_ACCESS_32bit),
>  	REGISTER_DESC_WITH_BITS_PER_IRQ(GIC_DIST_PENDING_SET,
> -		vgic_mmio_read_pending, vgic_mmio_write_spending, NULL, NULL, 1,
> +		vgic_mmio_read_pending, vgic_mmio_write_spending,
> +		NULL, vgic_uaccess_write_spending, 1,
>  		VGIC_ACCESS_32bit),

vgic_mmio_write_spending() has some homebrew detection for is_uaccess, which causes
vgic_hw_irq_spending() to do nothing. Isn't that now dead-code with this change?


> diff --git a/virt/kvm/arm/vgic/vgic-mmio.c b/virt/kvm/arm/vgic/vgic-mmio.c
> index 6e30034d1464..f1927ae02d2e 100644
> --- a/virt/kvm/arm/vgic/vgic-mmio.c
> +++ b/virt/kvm/arm/vgic/vgic-mmio.c
> @@ -321,6 +321,27 @@ void vgic_mmio_write_spending(struct kvm_vcpu *vcpu,

> +int vgic_uaccess_write_spending(struct kvm_vcpu *vcpu,
> +				gpa_t addr, unsigned int len,
> +				unsigned long val)
> +{
> +	u32 intid = VGIC_ADDR_TO_INTID(addr, 1);
> +	int i;
> +	unsigned long flags;
> +
> +	for_each_set_bit(i, &val, len * 8) {
> +		struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, vcpu, intid + i);

vgic_mmio_write_spending() has:
|	/* GICD_ISPENDR0 SGI bits are WI *

and bales out early. Is GIC_DIST_PENDING_SET the same register?
(If so, shouldn't that be true for PPI too?)


> +		raw_spin_lock_irqsave(&irq->irq_lock, flags);
> +		irq->pending_latch = true;
> +		vgic_queue_irq_unlock(vcpu->kvm, irq, flags);
> +
> +		vgic_put_irq(vcpu->kvm, irq);
> +	}
> +
> +	return 0;
> +}

> @@ -390,6 +411,26 @@ void vgic_mmio_write_cpending(struct kvm_vcpu *vcpu,

> +int vgic_uaccess_write_cpending(struct kvm_vcpu *vcpu,
> +				gpa_t addr, unsigned int len,
> +				unsigned long val)
> +{
> +	u32 intid = VGIC_ADDR_TO_INTID(addr, 1);
> +	int i;
> +	unsigned long flags;
> +
> +	for_each_set_bit(i, &val, len * 8) {
> +		struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, vcpu, intid + i);

Same dumb question about GICD_ICPENDR0!?

> +		raw_spin_lock_irqsave(&irq->irq_lock, flags);
> +		irq->pending_latch = false;
> +		raw_spin_unlock_irqrestore(&irq->irq_lock, flags);
> +
> +		vgic_put_irq(vcpu->kvm, irq);
> +	}
> +
> +	return 0;
> +}


Thanks,

James
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
