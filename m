Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1C42C01D3
	for <lists+kvmarm@lfdr.de>; Mon, 23 Nov 2020 10:01:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E944D4B99A;
	Mon, 23 Nov 2020 04:01:12 -0500 (EST)
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
	with ESMTP id CmKXUhqJrASe; Mon, 23 Nov 2020 04:01:12 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6A8E24B6C4;
	Mon, 23 Nov 2020 04:01:11 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 99F024B598
 for <kvmarm@lists.cs.columbia.edu>; Mon, 23 Nov 2020 04:01:09 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OdxYtETsKk4w for <kvmarm@lists.cs.columbia.edu>;
 Mon, 23 Nov 2020 04:01:08 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 54B934B2D2
 for <kvmarm@lists.cs.columbia.edu>; Mon, 23 Nov 2020 04:01:08 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E52CE212CC;
 Mon, 23 Nov 2020 09:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606122067;
 bh=ch1J/XrZOhgNgEVG3DSB00XE9M7T2SbWIBz6UFzeLT4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=y6oAcMVl/WqXYapvvflctl97B4hdr4zuEHwneI3cqJSVGZboMACiuGvtSyUsDeTha
 ReGj1hPITRiAkErHjPCbJ+32/NvWLtujjxigtmDZcMYawKtIl0MLhX5XUKqkFre5gI
 HQeRBl/0B5Z/935y3h5u222iEpKG/0t1mKricXhA=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1kh7ia-00CrUx-M0; Mon, 23 Nov 2020 09:01:04 +0000
MIME-Version: 1.0
Date: Mon, 23 Nov 2020 09:01:04 +0000
From: Marc Zyngier <maz@kernel.org>
To: Shenming Lu <lushenming@huawei.com>
Subject: Re: [RFC PATCH v1 1/4] irqchip/gic-v4.1: Plumb get_irqchip_state VLPI
 callback
In-Reply-To: <20201123065410.1915-2-lushenming@huawei.com>
References: <20201123065410.1915-1-lushenming@huawei.com>
 <20201123065410.1915-2-lushenming@huawei.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <f64703b618a2ebc6c6f5c423e2b779c6@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: lushenming@huawei.com, james.morse@arm.com,
 julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, eric.auger@redhat.com,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org, christoffer.dall@arm.com,
 alex.williamson@redhat.com, kwankhede@nvidia.com, cohuck@redhat.com,
 cjia@nvidia.com, wanghaibin.wang@huawei.com, yuzenghui@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Neo Jia <cjia@nvidia.com>, kvm@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Kirti Wankhede <kwankhede@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvmarm@lists.cs.columbia.edu,
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

On 2020-11-23 06:54, Shenming Lu wrote:
> From: Zenghui Yu <yuzenghui@huawei.com>
> 
> Up to now, the irq_get_irqchip_state() callback of its_irq_chip
> leaves unimplemented since there is no architectural way to get
> the VLPI's pending state before GICv4.1. Yeah, there has one in
> v4.1 for VLPIs.
> 
> With GICv4.1, after unmapping the vPE, which cleans and invalidates
> any caching of the VPT, we can get the VLPI's pending state by

This is a crucial note: without this unmapping and invalidation,
the pending bits are not generally accessible (they could be cached
in a GIC private structure, cache or otherwise).

> peeking at the VPT. So we implement the irq_get_irqchip_state()
> callback of its_irq_chip to do it.
> 
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> Signed-off-by: Shenming Lu <lushenming@huawei.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 38 ++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c 
> b/drivers/irqchip/irq-gic-v3-its.c
> index 0fec31931e11..287003cacac7 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -1695,6 +1695,43 @@ static void its_irq_compose_msi_msg(struct
> irq_data *d, struct msi_msg *msg)
>  	iommu_dma_compose_msi_msg(irq_data_get_msi_desc(d), msg);
>  }
> 
> +static bool its_peek_vpt(struct its_vpe *vpe, irq_hw_number_t hwirq)
> +{
> +	int mask = hwirq % BITS_PER_BYTE;

nit: this isn't a mask, but a shift instead. BIT(hwirq % BPB) would give
you a mask.

> +	void *va;
> +	u8 *pt;
> +
> +	va = page_address(vpe->vpt_page);
> +	pt = va + hwirq / BITS_PER_BYTE;
> +
> +	return !!(*pt & (1U << mask));
> +}
> +
> +static int its_irq_get_irqchip_state(struct irq_data *d,
> +				     enum irqchip_irq_state which, bool *val)
> +{
> +	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
> +	struct its_vlpi_map *map = get_vlpi_map(d);
> +
> +	if (which != IRQCHIP_STATE_PENDING)
> +		return -EINVAL;
> +
> +	/* not intended for physical LPI's pending state */
> +	if (!map)
> +		return -EINVAL;
> +
> +	/*
> +	 * In GICv4.1, a VMAPP with {V,Alloc}=={0,1} cleans and invalidates
> +	 * any caching of the VPT associated with the vPEID held in the GIC.
> +	 */
> +	if (!is_v4_1(its_dev->its) || atomic_read(&map->vpe->vmapp_count))

It isn't clear to me what prevents this from racing against a mapping of
the VPE. Actually, since we only hold the LPI irqdesc lock, I'm pretty 
sure
nothing prevents it.

> +		return -EACCES;

I can sort of buy EACCESS for a VPE that is currently mapped, but a 
non-4.1
ITS should definitely return EINVAL.

> +
> +	*val = its_peek_vpt(map->vpe, map->vintid);
> +
> +	return 0;
> +}
> +
>  static int its_irq_set_irqchip_state(struct irq_data *d,
>  				     enum irqchip_irq_state which,
>  				     bool state)
> @@ -1975,6 +2012,7 @@ static struct irq_chip its_irq_chip = {
>  	.irq_eoi		= irq_chip_eoi_parent,
>  	.irq_set_affinity	= its_set_affinity,
>  	.irq_compose_msi_msg	= its_irq_compose_msi_msg,
> +	.irq_get_irqchip_state	= its_irq_get_irqchip_state,

My biggest issue with this is that it isn't a reliable interface.
It happens to work in the context of KVM, because you make sure it
is called at the right time, but that doesn't make it safe in general
(anyone with the interrupt number is allowed to call this at any time).

Is there a problem with poking at the VPT page from the KVM side?
The code should be exactly the same (maybe simpler even), and at least
you'd be guaranteed to be in the correct context.

>  	.irq_set_irqchip_state	= its_irq_set_irqchip_state,
>  	.irq_retrigger		= its_irq_retrigger,
>  	.irq_set_vcpu_affinity	= its_irq_set_vcpu_affinity,

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
