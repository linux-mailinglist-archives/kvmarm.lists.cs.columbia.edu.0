Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4526F1AA3A6
	for <lists+kvmarm@lfdr.de>; Wed, 15 Apr 2020 15:16:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AD4DB4B182;
	Wed, 15 Apr 2020 09:16:03 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KQv7UP11cail; Wed, 15 Apr 2020 09:16:03 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4D9B04B14F;
	Wed, 15 Apr 2020 09:16:02 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 719574B13A
 for <kvmarm@lists.cs.columbia.edu>; Wed, 15 Apr 2020 09:16:00 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XZ17iz0e3+pn for <kvmarm@lists.cs.columbia.edu>;
 Wed, 15 Apr 2020 09:15:59 -0400 (EDT)
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 4B9454B10B
 for <kvmarm@lists.cs.columbia.edu>; Wed, 15 Apr 2020 09:15:58 -0400 (EDT)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id BB3737813D41CBFCD8A4;
 Wed, 15 Apr 2020 21:15:52 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Wed, 15 Apr 2020
 21:15:43 +0800
Subject: Re: [PATCH 1/3] KVM: arm: vgic: Synchronize the whole guest on
 GIC{D,R}_I{S,C}ACTIVER read
To: Marc Zyngier <maz@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <kvmarm@lists.cs.columbia.edu>, <kvm@vger.kernel.org>
References: <20200414103517.2824071-1-maz@kernel.org>
 <20200414103517.2824071-2-maz@kernel.org>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <190b57e6-0ac5-63bb-57d8-5bab2aea0b2c@huawei.com>
Date: Wed, 15 Apr 2020 21:15:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200414103517.2824071-2-maz@kernel.org>
Content-Language: en-US
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Cc: Julien Grall <julien@xen.org>, Andre Przywara <Andre.Przywara@arm.com>
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

On 2020/4/14 18:35, Marc Zyngier wrote:
> When a guest tries to read the active state of its interrupts,
> we currently just return whatever state we have in memory. This
> means that if such an interrupt lives in a List Register on another
> CPU, we fail to obsertve the latest active state for this interrupt.
> 
> In order to remedy this, stop all the other vcpus so that they exit
> and we can observe the most recent value for the state.
> 
> Reported-by: Julien Grall <julien@xen.org>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>   virt/kvm/arm/vgic/vgic-mmio-v2.c |   4 +-
>   virt/kvm/arm/vgic/vgic-mmio-v3.c |   4 +-
>   virt/kvm/arm/vgic/vgic-mmio.c    | 100 ++++++++++++++++++++-----------
>   virt/kvm/arm/vgic/vgic-mmio.h    |   3 +
>   4 files changed, 71 insertions(+), 40 deletions(-)
> 
> diff --git a/virt/kvm/arm/vgic/vgic-mmio-v2.c b/virt/kvm/arm/vgic/vgic-mmio-v2.c
> index 5945f062d749..d63881f60e1a 100644
> --- a/virt/kvm/arm/vgic/vgic-mmio-v2.c
> +++ b/virt/kvm/arm/vgic/vgic-mmio-v2.c
> @@ -422,11 +422,11 @@ static const struct vgic_register_region vgic_v2_dist_registers[] = {
>   		VGIC_ACCESS_32bit),
>   	REGISTER_DESC_WITH_BITS_PER_IRQ(GIC_DIST_ACTIVE_SET,
>   		vgic_mmio_read_active, vgic_mmio_write_sactive,
> -		NULL, vgic_mmio_uaccess_write_sactive, 1,
> +		vgic_uaccess_read_active, vgic_mmio_uaccess_write_sactive, 1,
>   		VGIC_ACCESS_32bit),
>   	REGISTER_DESC_WITH_BITS_PER_IRQ(GIC_DIST_ACTIVE_CLEAR,
>   		vgic_mmio_read_active, vgic_mmio_write_cactive,
> -		NULL, vgic_mmio_uaccess_write_cactive, 1,
> +		vgic_uaccess_read_active, vgic_mmio_uaccess_write_cactive, 1,
>   		VGIC_ACCESS_32bit),
>   	REGISTER_DESC_WITH_BITS_PER_IRQ(GIC_DIST_PRI,
>   		vgic_mmio_read_priority, vgic_mmio_write_priority, NULL, NULL,
> diff --git a/virt/kvm/arm/vgic/vgic-mmio-v3.c b/virt/kvm/arm/vgic/vgic-mmio-v3.c
> index e72dcc454247..77c8ba1a2535 100644
> --- a/virt/kvm/arm/vgic/vgic-mmio-v3.c
> +++ b/virt/kvm/arm/vgic/vgic-mmio-v3.c
> @@ -553,11 +553,11 @@ static const struct vgic_register_region vgic_v3_dist_registers[] = {
>   		VGIC_ACCESS_32bit),
>   	REGISTER_DESC_WITH_BITS_PER_IRQ_SHARED(GICD_ISACTIVER,
>   		vgic_mmio_read_active, vgic_mmio_write_sactive,
> -		NULL, vgic_mmio_uaccess_write_sactive, 1,
> +		vgic_uaccess_read_active, vgic_mmio_uaccess_write_sactive, 1,
>   		VGIC_ACCESS_32bit),
>   	REGISTER_DESC_WITH_BITS_PER_IRQ_SHARED(GICD_ICACTIVER,
>   		vgic_mmio_read_active, vgic_mmio_write_cactive,
> -		NULL, vgic_mmio_uaccess_write_cactive,
> +		vgic_uaccess_read_active, vgic_mmio_uaccess_write_cactive,
>   		1, VGIC_ACCESS_32bit),
>   	REGISTER_DESC_WITH_BITS_PER_IRQ_SHARED(GICD_IPRIORITYR,
>   		vgic_mmio_read_priority, vgic_mmio_write_priority, NULL, NULL,

Shouldn't we also set this uaccess_read cb for GICR_I{S,C}ACTIVER0?


Thanks,
Zenghui

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
