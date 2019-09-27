Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8C81EBFF96
	for <lists+kvmarm@lfdr.de>; Fri, 27 Sep 2019 09:04:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 050F94A75A;
	Fri, 27 Sep 2019 03:04:12 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HEo1kE+I65IH; Fri, 27 Sep 2019 03:04:11 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id ED6D94A759;
	Fri, 27 Sep 2019 03:04:10 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 561D54A750
 for <kvmarm@lists.cs.columbia.edu>; Fri, 27 Sep 2019 03:04:10 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CJCu5dPT06jm for <kvmarm@lists.cs.columbia.edu>;
 Fri, 27 Sep 2019 03:04:09 -0400 (EDT)
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D31A64A71D
 for <kvmarm@lists.cs.columbia.edu>; Fri, 27 Sep 2019 03:04:08 -0400 (EDT)
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 5CA93AB8D235F5ACECF8;
 Fri, 27 Sep 2019 15:04:02 +0800 (CST)
Received: from [127.0.0.1] (10.184.12.158) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Fri, 27 Sep 2019
 15:03:53 +0800
Subject: Re: [PATCH 03/35] irqchip/gic-v3-its: Allow LPI invalidation via the
 DirectLPI interface
To: Marc Zyngier <maz@kernel.org>, <kvmarm@lists.cs.columbia.edu>,
 <linux-kernel@vger.kernel.org>
References: <20190923182606.32100-1-maz@kernel.org>
 <20190923182606.32100-4-maz@kernel.org>
 <92ff82ca-ebcb-8f5f-5063-313f65bbc5e3@huawei.com>
 <22202880-9a99-f0d9-4737-6112d60b30a6@kernel.org>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <9399fbe3-5293-d34f-712e-3bf62680fda4@huawei.com>
Date: Fri, 27 Sep 2019 14:59:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <22202880-9a99-f0d9-4737-6112d60b30a6@kernel.org>
Content-Language: en-US
X-Originating-IP: [10.184.12.158]
X-CFilter-Loop: Reflected
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Jason Cooper <jason@lakedaemon.net>
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

On 2019/9/27 0:17, Marc Zyngier wrote:
> On 26/09/2019 15:57, Zenghui Yu wrote:
>> Hi Marc,
>>
>> I get one kernel panic with this patch on D05.
> 
> Can you please try this (completely untested for now) on top of the
> whole series? I'll otherwise give it a go next week.

Yes, it helps. At least I don't see panic any more. Without this change,
the host would get crashed as long as the VM is started.


Thanks,
zenghui

> 
> Thanks,
> 
> 	M.
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index bc55327406b7..9d24236d1257 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -3461,15 +3461,16 @@ static void its_vpe_send_cmd(struct its_vpe *vpe,
>   
>   static void its_vpe_send_inv(struct irq_data *d)
>   {
> +	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
> +
>   	if (gic_rdists->has_direct_lpi) {
> -		/*
> -		 * Don't mess about. Generating the invalidation is easily
> -		 * done by using the parent irq_data, just like below.
> -		 */
> -		direct_lpi_inv(d->parent_data);
> -	} else {
> -		struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
> +		void __iomem *rdbase;
>   
> +		/* Target the redistributor this VPE is currently known on */
> +		rdbase = per_cpu_ptr(gic_rdists->rdist, vpe->col_idx)->rd_base;
> +		gic_write_lpir(d->parent_data->hwirq, rdbase + GICR_INVLPIR);
> +		wait_for_syncr(rdbase);
> +	} else {
>   		its_vpe_send_cmd(vpe, its_send_inv);
>   	}
>   }
> 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
