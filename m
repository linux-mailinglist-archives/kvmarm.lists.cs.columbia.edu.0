Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9F525DB2D
	for <lists+kvmarm@lfdr.de>; Fri,  4 Sep 2020 16:17:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 998554B3D7;
	Fri,  4 Sep 2020 10:17:20 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3BDeOBDB5zAT; Fri,  4 Sep 2020 10:17:20 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2CAE84B3DD;
	Fri,  4 Sep 2020 10:17:19 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 322F24B37C
 for <kvmarm@lists.cs.columbia.edu>; Fri,  4 Sep 2020 10:17:18 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KEuEkX1ds0mh for <kvmarm@lists.cs.columbia.edu>;
 Fri,  4 Sep 2020 10:17:16 -0400 (EDT)
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 4B4094B337
 for <kvmarm@lists.cs.columbia.edu>; Fri,  4 Sep 2020 10:17:16 -0400 (EDT)
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
 by Forcepoint Email with ESMTP id 99FE9A970118A91A4DC3;
 Fri,  4 Sep 2020 15:17:14 +0100 (IST)
Received: from localhost (10.52.125.29) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 4 Sep 2020
 15:17:14 +0100
Date: Fri, 4 Sep 2020 15:15:38 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 04/23] irqchip/rvid: Add PCI MSI support
Message-ID: <20200904151538.00003cff@Huawei.com>
In-Reply-To: <20200903152610.1078827-5-maz@kernel.org>
References: <20200903152610.1078827-1-maz@kernel.org>
 <20200903152610.1078827-5-maz@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
X-Originating-IP: [10.52.125.29]
X-ClientProxiedBy: lhreml743-chm.china.huawei.com (10.201.108.193) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, kvm@vger.kernel.org,
 kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
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

On Thu,  3 Sep 2020 16:25:51 +0100
Marc Zyngier <maz@kernel.org> wrote:

> Signed-off-by: Marc Zyngier <maz@kernel.org>
Few minor comments inline.

Thanks,

Jonathan

> ---
>  drivers/irqchip/irq-rvid.c | 182 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 182 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-rvid.c b/drivers/irqchip/irq-rvid.c
> index 953f654e58d4..250f95ad1a09 100644
> --- a/drivers/irqchip/irq-rvid.c
> +++ b/drivers/irqchip/irq-rvid.c
> @@ -12,12 +12,19 @@
>  #include <linux/irq.h>
>  #include <linux/irqchip.h>
>  #include <linux/irqdomain.h>
> +#include <linux/msi.h>
>  
>  #include <linux/irqchip/irq-rvic.h>
>  
>  struct rvid_data {
>  	struct fwnode_handle	*fwnode;
>  	struct irq_domain	*domain;
> +	struct irq_domain	*msi_domain;
> +	struct irq_domain	*pci_domain;
> +	unsigned long		*msi_map;
> +	struct mutex		msi_lock;
> +	u32			msi_base;
> +	u32			msi_nr;
>  };
>  
>  static struct rvid_data rvid;
> @@ -209,6 +216,177 @@ static const struct irq_domain_ops rvid_irq_domain_ops = {
>  	.deactivate	= rvid_irq_domain_deactivate,
>  };
>  
> +#ifdef CONFIG_PCI_MSI
> +/*
> + * The MSI irqchip is completely transparent. The only purpose of the
> + * corresponding irq domain is to provide the MSI allocator, and feed
> + * the allocated inputs to the main rVID irq domain for mapping at the
> + * rVIC level.
> + */
> +static struct irq_chip rvid_msi_chip = {
> +	.name			= "rvid-MSI",
> +	.irq_mask		= irq_chip_mask_parent,
> +	.irq_unmask		= irq_chip_unmask_parent,
> +	.irq_eoi		= irq_chip_eoi_parent,
> +	.irq_get_irqchip_state	= irq_chip_get_parent_state,
> +	.irq_set_irqchip_state	= irq_chip_set_parent_state,
> +	.irq_retrigger		= irq_chip_retrigger_hierarchy,
> +	.irq_set_type		= irq_chip_set_type_parent,
> +	.irq_set_affinity	= irq_chip_set_affinity_parent,
> +};
> +
> +static int rvid_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
> +				 unsigned int nr_irqs, void *arg)
> +{
> +	int ret, hwirq, i;
> +
> +	mutex_lock(&rvid.msi_lock);
> +	hwirq = bitmap_find_free_region(rvid.msi_map, rvid.msi_nr,
> +					get_count_order(nr_irqs));
> +	mutex_unlock(&rvid.msi_lock);
> +
> +	if (hwirq < 0)
> +		return -ENOSPC;
> +
> +	for (i = 0; i < nr_irqs; i++) {
> +		/* Use the rVID domain to map the input to something */
> +		struct irq_fwspec fwspec = (struct irq_fwspec) {
> +			.fwnode		= domain->parent->fwnode,
> +			.param_count	= 1,
> +			.param[0]	= rvid.msi_base + hwirq + i,
> +		};
> +
> +		ret = irq_domain_alloc_irqs_parent(domain, virq + i, 1, &fwspec);
> +		if (WARN_ON(ret))
> +			goto out;
> +
> +		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
> +					      &rvid_msi_chip, &rvid);
> +	}
> +
> +	return 0;
> +
> +out:

I missed this on previous patch, but doesn't the error path need to undo the
irq_domain_alloc_irqs_parent part? irq_domain_free_irqs_parent()


> +	mutex_lock(&rvid.msi_lock);
> +	bitmap_release_region(rvid.msi_map, hwirq, get_count_order(nr_irqs));
> +	mutex_unlock(&rvid.msi_lock);
> +
> +	return ret;
> +}
> +
> +static void rvid_msi_domain_free(struct irq_domain *domain, unsigned int virq,
> +				 unsigned int nr_irqs)
> +{
> +	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
> +	irq_hw_number_t hwirq = d->hwirq;
> +
> +	/* This is a bit cheeky, but hey, recursion never hurt anyone... */
> +	rvid_irq_domain_free(domain, virq, nr_irqs);
> +
> +	mutex_lock(&rvid.msi_lock);
> +	bitmap_release_region(rvid.msi_map, hwirq, get_count_order(nr_irqs));
> +	mutex_unlock(&rvid.msi_lock);
> +}
> +
> +static struct irq_domain_ops rvid_msi_domain_ops = {
> +	.alloc		= rvid_msi_domain_alloc,
> +	.free		= rvid_msi_domain_free,
> +};
> +
> +/*
> + * The PCI irq chip only provides the minimal stuff, as most of the
> + * other methods will be provided as defaults.
> + */
> +static void rvid_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
> +{
> +	/* Random address, the rVID doesn't really have a doorbell */
> +	msg->address_hi = 0;
> +	msg->address_lo = 0xba5e0000;
> +
> +	/*
> +	 * We are called from the PCI domain, and what we program in
> +	 * the device is the rVID input pin, which is located two
> +	 * levels down in the interrupt chain (PCI -> MSI -> rVID).
> +	 */
> +	msg->data = data->parent_data->parent_data->hwirq;
> +}
> +
> +static void rvid_pci_mask(struct irq_data *d)
> +{
> +	pci_msi_mask_irq(d);
> +	irq_chip_mask_parent(d);
> +}
> +
> +static void rvid_pci_unmask(struct irq_data *d)
> +{
> +	pci_msi_unmask_irq(d);
> +	irq_chip_unmask_parent(d);
> +}
> +
> +static struct irq_chip rvid_pci_chip = {
> +	.name			= "PCI-MSI",
> +	.irq_mask		= rvid_pci_mask,
> +	.irq_unmask		= rvid_pci_unmask,
> +	.irq_eoi		= irq_chip_eoi_parent,
> +	.irq_compose_msi_msg	= rvid_compose_msi_msg,
> +	.irq_write_msi_msg	= pci_msi_domain_write_msg,
> +};
> +
> +static struct msi_domain_info rvid_pci_domain_info = {
> +	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
> +		   MSI_FLAG_PCI_MSIX | MSI_FLAG_MULTI_PCI_MSI),
> +	.chip	= &rvid_pci_chip,
> +};
> +
> +static void __init rvid_msi_setup(struct device_node *np)
> +{
> +	if (!of_property_read_bool(np, "msi-controller"))
> +		return;
> +
> +	if (of_property_read_u32_index(np, "msi-range", 0, &rvid.msi_base) ||
> +	    of_property_read_u32_index(np, "msi-range", 1, &rvid.msi_nr)) {

Looks like msi-range isn't defined in any existing bindings, or my grep
fu is broken today.

> +		pr_err("Invalid or missing msi-range\n");
> +		return;
> +	}
> +
> +	mutex_init(&rvid.msi_lock);
> +
> +	rvid.msi_map = bitmap_alloc(rvid.msi_nr, GFP_KERNEL | __GFP_ZERO);

bitmap_zalloc()

> +	if (!rvid.msi_map)
> +		return;
> +
> +	rvid.msi_domain = irq_domain_create_hierarchy(rvid.domain, 0, 0,
> +						      rvid.fwnode,
> +						      &rvid_msi_domain_ops,
> +						      &rvid);
> +	if (!rvid.msi_domain) {
> +		pr_err("Failed to allocate MSI domain\n");
> +		goto out;
> +	}
> +
> +	irq_domain_update_bus_token(rvid.msi_domain, DOMAIN_BUS_NEXUS);
> +
> +	rvid.pci_domain = pci_msi_create_irq_domain(rvid.domain->fwnode,
> +						    &rvid_pci_domain_info,
> +						    rvid.msi_domain);
> +	if (!rvid.pci_domain) {
> +		pr_err("Failed to allocate PCI domain\n");
> +		goto out;
> +	}
> +
> +	pr_info("MSIs available as inputs [%d:%d]\n",
> +		rvid.msi_base, rvid.msi_base + rvid.msi_nr - 1);
> +	return;
> +
> +out:
> +	if (rvid.msi_domain)
> +		irq_domain_remove(rvid.msi_domain);
> +	kfree(rvid.msi_map);
> +}
> +#else
> +static inline void rvid_msi_setup(struct device_node *np) {}
> +#endif
> +
>  static int __init rvid_init(struct device_node *node,
>  			    struct device_node *parent)
>  {
> @@ -253,6 +431,10 @@ static int __init rvid_init(struct device_node *node,
>  		return -ENOMEM;
>  	}
>  
> +	irq_domain_update_bus_token(rvid.domain, DOMAIN_BUS_WIRED);
> +
> +	rvid_msi_setup(node);
> +
>  	return 0;
>  }
>  


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
