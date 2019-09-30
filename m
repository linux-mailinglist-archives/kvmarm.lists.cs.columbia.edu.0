Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 83E23C1DDF
	for <lists+kvmarm@lfdr.de>; Mon, 30 Sep 2019 11:24:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0FA1F4A705;
	Mon, 30 Sep 2019 05:24:00 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bJbKEwsgQTyZ; Mon, 30 Sep 2019 05:23:59 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F09744A700;
	Mon, 30 Sep 2019 05:23:58 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9BFA04A69D
 for <kvmarm@lists.cs.columbia.edu>; Mon, 30 Sep 2019 05:23:57 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8LTdTVlTCVKv for <kvmarm@lists.cs.columbia.edu>;
 Mon, 30 Sep 2019 05:23:56 -0400 (EDT)
Received: from inca-roads.misterjones.org (inca-roads.misterjones.org
 [213.251.177.50])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id B089B4A691
 for <kvmarm@lists.cs.columbia.edu>; Mon, 30 Sep 2019 05:23:56 -0400 (EDT)
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
 (envelope-from <maz@kernel.org>)
 id 1iEruN-0001uK-8b; Mon, 30 Sep 2019 11:23:55 +0200
To: Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH 31/35] irqchip/gic-v4.1: Eagerly vmap vPEs
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Date: Mon, 30 Sep 2019 10:23:55 +0100
From: Marc Zyngier <maz@kernel.org>
In-Reply-To: <82576f6e-3736-8069-bbf2-7744fbea9ed2@huawei.com>
References: <20190923182606.32100-1-maz@kernel.org>
 <20190923182606.32100-32-maz@kernel.org>
 <82576f6e-3736-8069-bbf2-7744fbea9ed2@huawei.com>
Message-ID: <ce8d5af19b6c62985bdfc9d57ac659f2@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: yuzenghui@huawei.com, kvmarm@lists.cs.columbia.edu,
 linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com, jason@lakedaemon.net,
 tglx@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org);
 SAEximRunCond expanded to false
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, kvmarm@lists.cs.columbia.edu,
 Jason Cooper <jason@lakedaemon.net>, linux-kernel@vger.kernel.org
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

On 2019-09-28 04:11, Zenghui Yu wrote:
> On 2019/9/24 2:26, Marc Zyngier wrote:
>> Now that we have HW-accelerated SGIs being delivered to VPEs, it
>> becomes required to map the VPEs on all ITSs instead of relying
>> on the lazy approach that we would use when using the ITS-list
>> mechanism.
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> ---
>>   drivers/irqchip/irq-gic-v3-its.c | 39 
>> +++++++++++++++++++++++++-------
>>   1 file changed, 31 insertions(+), 8 deletions(-)
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c 
>> b/drivers/irqchip/irq-gic-v3-its.c
>> index 4aae9582182b..a1e8c4c2598a 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -1417,12 +1417,31 @@ static int its_irq_set_irqchip_state(struct 
>> irq_data *d,
>>   	return 0;
>>   }
>>   +/*
>> + * Two favourable cases:
>> + *
>> + * (a) Either we have a GICv4.1, and all vPEs have to be mapped at 
>> all times
>> + *     for vSGI delivery
>> + *
>> + * (b) Or the ITSs do not use a list map, meaning that VMOVP is 
>> cheap enough
>> + *     and we're better off mapping all VPEs always
>> + *
>> + * If neither (a) nor (b) is true, then we map VLPIs on demand.
>                                                  ^^^^^
> vPEs

Yes, well caught.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
