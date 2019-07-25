Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 66B2375431
	for <lists+kvmarm@lfdr.de>; Thu, 25 Jul 2019 18:38:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1A6124A5FE;
	Thu, 25 Jul 2019 12:38:17 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.202
X-Spam-Level: 
X-Spam-Status: No, score=-4.202 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5, SPF_HELO_PASS=-0.001]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KSsf6r9r-Caq; Thu, 25 Jul 2019 12:38:17 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BBC354A5FD;
	Thu, 25 Jul 2019 12:38:15 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3C09B4A5B4
 for <kvmarm@lists.cs.columbia.edu>; Thu, 25 Jul 2019 12:38:14 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zJHgRj5tflVl for <kvmarm@lists.cs.columbia.edu>;
 Thu, 25 Jul 2019 12:38:13 -0400 (EDT)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 18D034A5A0
 for <kvmarm@lists.cs.columbia.edu>; Thu, 25 Jul 2019 12:38:13 -0400 (EDT)
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6109AC065138;
 Thu, 25 Jul 2019 16:38:12 +0000 (UTC)
Received: from [10.36.116.102] (ovpn-116-102.ams2.redhat.com [10.36.116.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6FD0563F67;
 Thu, 25 Jul 2019 16:38:09 +0000 (UTC)
Subject: Re: [PATCH v3 09/10] KVM: arm/arm64: vgic-its: Check the LPI
 translation cache on MSI injection
To: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org
References: <20190725153543.24386-1-maz@kernel.org>
 <20190725153543.24386-10-maz@kernel.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <01a5da1f-86ec-9497-7c4e-7c046404cf36@redhat.com>
Date: Thu, 25 Jul 2019 18:38:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190725153543.24386-10-maz@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Thu, 25 Jul 2019 16:38:12 +0000 (UTC)
Cc: Marc Zyngier <marc.zyngier@arm.com>,
 Andre Przywara <Andre.Przywara@arm.com>, "Raslan,
 KarimAllah" <karahmed@amazon.de>, "Saidi, Ali" <alisaidi@amazon.com>
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

On 7/25/19 5:35 PM, Marc Zyngier wrote:
> From: Marc Zyngier <marc.zyngier@arm.com>
> 
> When performing an MSI injection, let's first check if the translation
> is already in the cache. If so, let's inject it quickly without
> going through the whole translation process.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
>  virt/kvm/arm/vgic/vgic-its.c | 36 ++++++++++++++++++++++++++++++++++++
>  virt/kvm/arm/vgic/vgic.h     |  1 +
>  2 files changed, 37 insertions(+)
> 
> diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
> index e61d3ea0ab40..2be6b66b3856 100644
> --- a/virt/kvm/arm/vgic/vgic-its.c
> +++ b/virt/kvm/arm/vgic/vgic-its.c
> @@ -566,6 +566,20 @@ static struct vgic_irq *__vgic_its_check_cache(struct vgic_dist *dist,
>  	return NULL;
>  }
>  
> +static struct vgic_irq *vgic_its_check_cache(struct kvm *kvm, phys_addr_t db,
> +					     u32 devid, u32 eventid)
> +{
> +	struct vgic_dist *dist = &kvm->arch.vgic;
> +	struct vgic_irq *irq;
> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave(&dist->lpi_list_lock, flags);
> +	irq = __vgic_its_check_cache(dist, db, devid, eventid);
> +	raw_spin_unlock_irqrestore(&dist->lpi_list_lock, flags);
> +
> +	return irq;
> +}
> +
>  static void vgic_its_cache_translation(struct kvm *kvm, struct vgic_its *its,
>  				       u32 devid, u32 eventid,
>  				       struct vgic_irq *irq)
> @@ -725,6 +739,25 @@ static int vgic_its_trigger_msi(struct kvm *kvm, struct vgic_its *its,
>  	return 0;
>  }
>  
> +int vgic_its_inject_cached_translation(struct kvm *kvm, struct kvm_msi *msi)
> +{
> +	struct vgic_irq *irq;
> +	unsigned long flags;
> +	phys_addr_t db;
> +
> +	db = (u64)msi->address_hi << 32 | msi->address_lo;
> +	irq = vgic_its_check_cache(kvm, db, msi->devid, msi->data);
> +
> +	if (!irq)
> +		return -1;
> +
> +	raw_spin_lock_irqsave(&irq->irq_lock, flags);
> +	irq->pending_latch = true;
> +	vgic_queue_irq_unlock(kvm, irq, flags);
> +
> +	return 0;
> +}
> +
>  /*
>   * Queries the KVM IO bus framework to get the ITS pointer from the given
>   * doorbell address.
> @@ -736,6 +769,9 @@ int vgic_its_inject_msi(struct kvm *kvm, struct kvm_msi *msi)
>  	struct vgic_its *its;
>  	int ret;
>  
> +	if (!vgic_its_inject_cached_translation(kvm, msi))
> +		return 1;
> +
>  	its = vgic_msi_to_its(kvm, msi);
>  	if (IS_ERR(its))
>  		return PTR_ERR(its);
> diff --git a/virt/kvm/arm/vgic/vgic.h b/virt/kvm/arm/vgic/vgic.h
> index 09908b80fb1e..db308a62b34d 100644
> --- a/virt/kvm/arm/vgic/vgic.h
> +++ b/virt/kvm/arm/vgic/vgic.h
> @@ -306,6 +306,7 @@ int vgic_copy_lpi_list(struct kvm *kvm, struct kvm_vcpu *vcpu, u32 **intid_ptr);
>  int vgic_its_resolve_lpi(struct kvm *kvm, struct vgic_its *its,
>  			 u32 devid, u32 eventid, struct vgic_irq **irq);
>  struct vgic_its *vgic_msi_to_its(struct kvm *kvm, struct kvm_msi *msi);
> +int vgic_its_inject_cached_translation(struct kvm *kvm, struct kvm_msi *msi);
>  void vgic_lpi_translation_cache_init(struct kvm *kvm);
>  void vgic_lpi_translation_cache_destroy(struct kvm *kvm);
>  void vgic_its_invalidate_cache(struct kvm *kvm);
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
