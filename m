Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id CB5D51903A6
	for <lists+kvmarm@lfdr.de>; Tue, 24 Mar 2020 03:43:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5C29C4B09E;
	Mon, 23 Mar 2020 22:43:29 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s4my3MQbh5cn; Mon, 23 Mar 2020 22:43:29 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 39A8D4A4E5;
	Mon, 23 Mar 2020 22:43:28 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 60D2D4A4E5
 for <kvmarm@lists.cs.columbia.edu>; Mon, 23 Mar 2020 22:43:26 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nRYWt4zZlsW4 for <kvmarm@lists.cs.columbia.edu>;
 Mon, 23 Mar 2020 22:43:24 -0400 (EDT)
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 977A24A4CD
 for <kvmarm@lists.cs.columbia.edu>; Mon, 23 Mar 2020 22:43:24 -0400 (EDT)
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 89E47BFAA9A5134BBF4F;
 Tue, 24 Mar 2020 10:43:20 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Tue, 24 Mar 2020
 10:43:10 +0800
Subject: Re: [PATCH v6 14/23] irqchip/gic-v4.1: Add VSGI allocation/teardown
To: Marc Zyngier <maz@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <kvmarm@lists.cs.columbia.edu>, <kvm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
References: <20200320182406.23465-1-maz@kernel.org>
 <20200320182406.23465-15-maz@kernel.org>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <f778d757-0312-5412-668c-db9aee889cf0@huawei.com>
Date: Tue, 24 Mar 2020 10:43:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200320182406.23465-15-maz@kernel.org>
Content-Language: en-US
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>
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

On 2020/3/21 2:23, Marc Zyngier wrote:
> Allocate per-VPE SGIs when initializing the GIC-specific part of the
> VPE data structure.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
> Link: https://lore.kernel.org/r/20200304203330.4967-15-maz@kernel.org
> ---
>   drivers/irqchip/irq-gic-v3-its.c   |  2 +-
>   drivers/irqchip/irq-gic-v4.c       | 68 +++++++++++++++++++++++++++++-
>   include/linux/irqchip/arm-gic-v4.h |  4 +-
>   3 files changed, 71 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 15250faa9ef7..7ad46ff5f0b9 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -4053,7 +4053,7 @@ static int its_sgi_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
>   	struct its_cmd_info *info = vcpu_info;
>   
>   	switch (info->cmd_type) {
> -	case PROP_UPDATE_SGI:
> +	case PROP_UPDATE_VSGI:
>   		vpe->sgi_config[d->hwirq].priority = info->priority;
>   		vpe->sgi_config[d->hwirq].group = info->group;
>   		its_configure_sgi(d, false);

[...]

> @@ -103,7 +105,7 @@ enum its_vcpu_info_cmd_type {
>   	SCHEDULE_VPE,
>   	DESCHEDULE_VPE,
>   	INVALL_VPE,
> -	PROP_UPDATE_SGI,
> +	PROP_UPDATE_VSGI,
>   };
>   
>   struct its_cmd_info {

As Eric pointed out, this belongs to patch #12.


Thanks,
Zenghui

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
