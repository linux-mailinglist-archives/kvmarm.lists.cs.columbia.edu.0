Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3924B1F5659
	for <lists+kvmarm@lfdr.de>; Wed, 10 Jun 2020 15:59:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B03DF4B219;
	Wed, 10 Jun 2020 09:59:35 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FKk7gpFEmyh9; Wed, 10 Jun 2020 09:59:35 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A85B84B20F;
	Wed, 10 Jun 2020 09:59:34 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E6B704B208
 for <kvmarm@lists.cs.columbia.edu>; Wed, 10 Jun 2020 09:59:33 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9Sd0U-XOn12E for <kvmarm@lists.cs.columbia.edu>;
 Wed, 10 Jun 2020 09:59:32 -0400 (EDT)
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 5B6064B206
 for <kvmarm@lists.cs.columbia.edu>; Wed, 10 Jun 2020 09:59:32 -0400 (EDT)
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 95CC8DAAEE057B21A14B;
 Wed, 10 Jun 2020 21:59:28 +0800 (CST)
Received: from [10.173.222.27] (10.173.222.27) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Wed, 10 Jun 2020 21:59:20 +0800
Subject: Re: [PATCH] irqchip/gic-v4.1: Use readx_poll_timeout_atomic() to fix
 sleep in atomic
To: <maz@kernel.org>
References: <20200605052345.1494-1-yuzenghui@huawei.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <4a9822bd-0362-7ffe-6e56-3f05a7816d9e@huawei.com>
Date: Wed, 10 Jun 2020 21:59:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200605052345.1494-1-yuzenghui@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Cc: jason@lakedaemon.net, linux-kernel@vger.kernel.org, tglx@linutronix.de,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

Sorry to ping you in the merge window, but ...

On 2020/6/5 13:23, Zenghui Yu wrote:
> readx_poll_timeout() can sleep if @sleep_us is specified by the caller,
> and is therefore unsafe to be used inside the atomic context, which is
> this case when we use it to poll the GICR_VPENDBASER.Dirty bit in
> irq_set_vcpu_affinity() callback.

this seems like an urgent thing to me. Without this patch, CPUs are
easily to get stuck on my board with GICv4.1 enabled. So it'd be good if
you can have a look and take this as a fix (if it is correct).


Thanks,
Zenghui

> 
> Let's convert to its atomic version instead which helps to get the v4.1
> board back to life!
> 
> Fixes: 96806229ca03 ("irqchip/gic-v4.1: Add support for VPENDBASER's Dirty+Valid signaling")
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
>   drivers/irqchip/irq-gic-v3-its.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index cd685f521c77..6a5a87fc4601 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -3797,10 +3797,10 @@ static void its_wait_vpt_parse_complete(void)
>   	if (!gic_rdists->has_vpend_valid_dirty)
>   		return;
>   
> -	WARN_ON_ONCE(readq_relaxed_poll_timeout(vlpi_base + GICR_VPENDBASER,
> -						val,
> -						!(val & GICR_VPENDBASER_Dirty),
> -						10, 500));
> +	WARN_ON_ONCE(readq_relaxed_poll_timeout_atomic(vlpi_base + GICR_VPENDBASER,
> +						       val,
> +						       !(val & GICR_VPENDBASER_Dirty),
> +						       10, 500));
>   }
>   
>   static void its_vpe_schedule(struct its_vpe *vpe)
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
