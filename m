Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D76A31895E9
	for <lists+kvmarm@lfdr.de>; Wed, 18 Mar 2020 07:35:24 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 540224B099;
	Wed, 18 Mar 2020 02:35:24 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZhT7TzO1IKxG; Wed, 18 Mar 2020 02:35:24 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 229004B08E;
	Wed, 18 Mar 2020 02:35:23 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4D9AF4A51D
 for <kvmarm@lists.cs.columbia.edu>; Wed, 18 Mar 2020 02:35:22 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YBNZZGwjpgek for <kvmarm@lists.cs.columbia.edu>;
 Wed, 18 Mar 2020 02:35:20 -0400 (EDT)
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 5638B4A2E5
 for <kvmarm@lists.cs.columbia.edu>; Wed, 18 Mar 2020 02:35:20 -0400 (EDT)
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 687BA464783BCDA51C81;
 Wed, 18 Mar 2020 14:35:13 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Wed, 18 Mar 2020
 14:35:07 +0800
Subject: Re: [PATCH v5 20/23] KVM: arm64: GICv4.1: Plumb SGI implementation
 selection in the distributor
To: Marc Zyngier <maz@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <kvmarm@lists.cs.columbia.edu>, <kvm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
References: <20200304203330.4967-1-maz@kernel.org>
 <20200304203330.4967-21-maz@kernel.org>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <72832f51-bbde-8502-3e03-189ac20a0143@huawei.com>
Date: Wed, 18 Mar 2020 14:34:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200304203330.4967-21-maz@kernel.org>
Content-Language: en-US
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Jason Cooper <jason@lakedaemon.net>, Robert Richter <rrichter@marvell.com>,
 Thomas Gleixner <tglx@linutronix.de>
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

Hi Marc,

On 2020/3/5 4:33, Marc Zyngier wrote:
> The GICv4.1 architecture gives the hypervisor the option to let
> the guest choose whether it wants the good old SGIs with an
> active state, or the new, HW-based ones that do not have one.
> 
> For this, plumb the configuration of SGIs into the GICv3 MMIO
> handling, present the GICD_TYPER2.nASSGIcap to the guest,
> and handle the GICD_CTLR.nASSGIreq setting.
> 
> In order to be able to deal with the restore of a guest, also
> apply the GICD_CTLR.nASSGIreq setting at first run so that we
> can move the restored SGIs to the HW if that's what the guest
> had selected in a previous life.

I'm okay with the restore path.  But it seems that we still fail to
save the pending state of vSGI - software pending_latch of HW-based
vSGIs will not be updated (and always be false) because we directly
inject them through ITS, so vgic_v3_uaccess_read_pending() can't
tell the correct pending state to user-space (the correct one should
be latched in HW).

It would be good if we can sync the hardware state into pending_latch
at an appropriate time (just before save), but not sure if we can...

> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>   virt/kvm/arm/vgic/vgic-mmio-v3.c | 48 ++++++++++++++++++++++++++++++--
>   virt/kvm/arm/vgic/vgic-v3.c      |  2 ++
>   2 files changed, 48 insertions(+), 2 deletions(-)
> 
> diff --git a/virt/kvm/arm/vgic/vgic-mmio-v3.c b/virt/kvm/arm/vgic/vgic-mmio-v3.c
> index de89da76a379..442f3b8c2559 100644
> --- a/virt/kvm/arm/vgic/vgic-mmio-v3.c
> +++ b/virt/kvm/arm/vgic/vgic-mmio-v3.c
> @@ -3,6 +3,7 @@
>    * VGICv3 MMIO handling functions
>    */
>   
> +#include <linux/bitfield.h>
>   #include <linux/irqchip/arm-gic-v3.h>
>   #include <linux/kvm.h>
>   #include <linux/kvm_host.h>
> @@ -70,6 +71,8 @@ static unsigned long vgic_mmio_read_v3_misc(struct kvm_vcpu *vcpu,
>   		if (vgic->enabled)
>   			value |= GICD_CTLR_ENABLE_SS_G1;
>   		value |= GICD_CTLR_ARE_NS | GICD_CTLR_DS;
> +		if (kvm_vgic_global_state.has_gicv4_1 && vgic->nassgireq)

Looking at how we handle the GICD_CTLR.nASSGIreq setting, I think
"nassgireq==true" already indicates "has_gicv4_1==true".  So this
can be simplified.

But I wonder that should we use nassgireq to *only* keep track what
the guest had written into the GICD_CTLR.nASSGIreq.  If not, we may
lose the guest-request bit after migration among hosts with different
has_gicv4_1 settings.


The remaining patches all look good to me :-). I will wait for you to
confirm these two concerns.


Thanks,
Zenghui

> +			value |= GICD_CTLR_nASSGIreq;
>   		break;
>   	case GICD_TYPER:
>   		value = vgic->nr_spis + VGIC_NR_PRIVATE_IRQS;
> @@ -81,6 +84,10 @@ static unsigned long vgic_mmio_read_v3_misc(struct kvm_vcpu *vcpu,
>   			value |= (INTERRUPT_ID_BITS_SPIS - 1) << 19;
>   		}
>   		break;
> +	case GICD_TYPER2:
> +		if (kvm_vgic_global_state.has_gicv4_1)
> +			value = GICD_TYPER2_nASSGIcap;
> +		break;
>   	case GICD_IIDR:
>   		value = (PRODUCT_ID_KVM << GICD_IIDR_PRODUCT_ID_SHIFT) |
>   			(vgic->implementation_rev << GICD_IIDR_REVISION_SHIFT) |
> @@ -98,17 +105,43 @@ static void vgic_mmio_write_v3_misc(struct kvm_vcpu *vcpu,
>   				    unsigned long val)
>   {
>   	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
> -	bool was_enabled = dist->enabled;
>   
>   	switch (addr & 0x0c) {
> -	case GICD_CTLR:
> +	case GICD_CTLR: {
> +		bool was_enabled, is_hwsgi;
> +
> +		mutex_lock(&vcpu->kvm->lock);
> +
> +		was_enabled = dist->enabled;
> +		is_hwsgi = dist->nassgireq;
> +
>   		dist->enabled = val & GICD_CTLR_ENABLE_SS_G1;
>   
> +		/* Not a GICv4.1? No HW SGIs */
> +		if (!kvm_vgic_global_state.has_gicv4_1)
> +			val &= ~GICD_CTLR_nASSGIreq;
> +
> +		/* Dist stays enabled? nASSGIreq is RO */
> +		if (was_enabled && dist->enabled) {
> +			val &= ~GICD_CTLR_nASSGIreq;
> +			val |= FIELD_PREP(GICD_CTLR_nASSGIreq, is_hwsgi);
> +		}
> +
> +		/* Switching HW SGIs? */
> +		dist->nassgireq = val & GICD_CTLR_nASSGIreq;
> +		if (is_hwsgi != dist->nassgireq)
> +			vgic_v4_configure_vsgis(vcpu->kvm);
> +
>   		if (!was_enabled && dist->enabled)
>   			vgic_kick_vcpus(vcpu->kvm);
> +
> +		mutex_unlock(&vcpu->kvm->lock);
>   		break;
> +	}
>   	case GICD_TYPER:
> +	case GICD_TYPER2:
>   	case GICD_IIDR:
> +		/* This is at best for documentation purposes... */
>   		return;
>   	}
>   }
> @@ -117,10 +150,21 @@ static int vgic_mmio_uaccess_write_v3_misc(struct kvm_vcpu *vcpu,
>   					   gpa_t addr, unsigned int len,
>   					   unsigned long val)
>   {
> +	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
> +
>   	switch (addr & 0x0c) {
>   	case GICD_IIDR:
>   		if (val != vgic_mmio_read_v3_misc(vcpu, addr, len))
>   			return -EINVAL;
> +		return 0;
> +	case GICD_CTLR:
> +		/* Not a GICv4.1? No HW SGIs */
> +		if (!kvm_vgic_global_state.has_gicv4_1)
> +			val &= ~GICD_CTLR_nASSGIreq;
> +
> +		dist->enabled = val & GICD_CTLR_ENABLE_SS_G1;
> +		dist->nassgireq = val & GICD_CTLR_nASSGIreq;
> +		return 0;
>   	}
>   
>   	vgic_mmio_write_v3_misc(vcpu, addr, len, val);
> diff --git a/virt/kvm/arm/vgic/vgic-v3.c b/virt/kvm/arm/vgic/vgic-v3.c
> index 1bc09b523486..2c9fc13e2c59 100644
> --- a/virt/kvm/arm/vgic/vgic-v3.c
> +++ b/virt/kvm/arm/vgic/vgic-v3.c
> @@ -540,6 +540,8 @@ int vgic_v3_map_resources(struct kvm *kvm)
>   		goto out;
>   	}
>   
> +	if (kvm_vgic_global_state.has_gicv4_1)
> +		vgic_v4_configure_vsgis(kvm);
>   	dist->ready = true;
>   
>   out:
> 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
