Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id F22BCEC252
	for <lists+kvmarm@lfdr.de>; Fri,  1 Nov 2019 12:52:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 773B94ACDA;
	Fri,  1 Nov 2019 07:52:14 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 88hi6oJHuHXe; Fri,  1 Nov 2019 07:52:14 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4D6FB4ACD3;
	Fri,  1 Nov 2019 07:52:13 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DE70C4ACC6
 for <kvmarm@lists.cs.columbia.edu>; Fri,  1 Nov 2019 07:52:11 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P3NBuCqJHmFs for <kvmarm@lists.cs.columbia.edu>;
 Fri,  1 Nov 2019 07:52:10 -0400 (EDT)
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 67F0F4ACC4
 for <kvmarm@lists.cs.columbia.edu>; Fri,  1 Nov 2019 07:52:10 -0400 (EDT)
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id E978E5D73C6E77742B42;
 Fri,  1 Nov 2019 19:52:05 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Fri, 1 Nov 2019
 19:51:56 +0800
Subject: Re: [PATCH v2 19/36] irqchip/gic-v4.1: Add VPE INVALL callback
To: Marc Zyngier <maz@kernel.org>, <kvmarm@lists.cs.columbia.edu>,
 <linux-kernel@vger.kernel.org>
References: <20191027144234.8395-1-maz@kernel.org>
 <20191027144234.8395-20-maz@kernel.org>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <28e29c2d-a35a-6a67-c65d-7ab61d33b21b@huawei.com>
Date: Fri, 1 Nov 2019 19:51:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191027144234.8395-20-maz@kernel.org>
Content-Language: en-US
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Jason Cooper <jason@lakedaemon.net>, Robert Richter <rrichter@marvell.com>,
 Jayachandran C <jnair@marvell.com>, Thomas Gleixner <tglx@linutronix.de>
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

On 2019/10/27 22:42, Marc Zyngier wrote:
> GICv4.1 redistributors have a VPE-aware INVALL register. Progress!
> We can now emulate a guest-requested INVALL without emiting a
> VINVALL command.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>

> ---
>   drivers/irqchip/irq-gic-v3-its.c   | 14 ++++++++++++++
>   include/linux/irqchip/arm-gic-v3.h |  3 +++
>   2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index f7effd453729..10bd156aa042 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -3511,6 +3511,19 @@ static void its_vpe_4_1_deschedule(struct its_vpe *vpe,
>   	}
>   }
>   
> +static void its_vpe_4_1_invall(struct its_vpe *vpe)
> +{
> +	void __iomem *rdbase;
> +	u64 val;
> +
> +	val  = GICR_INVLPIR_V;
> +	val |= FIELD_PREP(GICR_INVLPIR_VPEID, vpe->vpe_id);

Can we use GICR_INVALL_V/VPEID instead, and ...

> +
> +	/* Target the redistributor this vPE is currently known on */
> +	rdbase = per_cpu_ptr(gic_rdists->rdist, vpe->col_idx)->rd_base;
> +	gic_write_lpir(val, rdbase + GICR_INVALLR);
> +}
> +
>   static int its_vpe_4_1_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
>   {
>   	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
> @@ -3526,6 +3539,7 @@ static int its_vpe_4_1_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
>   		return 0;
>   
>   	case INVALL_VPE:
> +		its_vpe_4_1_invall(vpe);
>   		return 0;
>   
>   	default:
> diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
> index 6fd89d77b2b2..b69f60792554 100644
> --- a/include/linux/irqchip/arm-gic-v3.h
> +++ b/include/linux/irqchip/arm-gic-v3.h
> @@ -247,6 +247,9 @@
>   #define GICR_TYPER_COMMON_LPI_AFF	GENMASK_ULL(25, 24)
>   #define GICR_TYPER_AFFINITY		GENMASK_ULL(63, 32)
>   
> +#define GICR_INVLPIR_VPEID		GENMASK_ULL(47, 32)
> +#define GICR_INVLPIR_V			GENMASK_ULL(63, 63)
> +

... define them here:

#define GICR_INVALL_VPEID		GICR_INVLPIR_VPEID
#define GICR_INVALL_V			GICR_INVLPIR_V


Thanks,
Zenghui

>   #define GIC_V3_REDIST_SIZE		0x20000
>   
>   #define LPI_PROP_GROUP1			(1 << 1)
> 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
