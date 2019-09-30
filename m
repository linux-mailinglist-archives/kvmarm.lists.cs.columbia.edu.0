Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 52F63C1DCD
	for <lists+kvmarm@lfdr.de>; Mon, 30 Sep 2019 11:20:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 974CD4A70A;
	Mon, 30 Sep 2019 05:20:13 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aewkL76CFw5g; Mon, 30 Sep 2019 05:20:13 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 86F3A4A705;
	Mon, 30 Sep 2019 05:20:12 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 282344A6B0
 for <kvmarm@lists.cs.columbia.edu>; Mon, 30 Sep 2019 05:20:11 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gM71xT4QW6+t for <kvmarm@lists.cs.columbia.edu>;
 Mon, 30 Sep 2019 05:20:09 -0400 (EDT)
Received: from inca-roads.misterjones.org (inca-roads.misterjones.org
 [213.251.177.50])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id DB1E14A69D
 for <kvmarm@lists.cs.columbia.edu>; Mon, 30 Sep 2019 05:20:09 -0400 (EDT)
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
 (envelope-from <maz@kernel.org>)
 id 1iErqf-0001rF-5T; Mon, 30 Sep 2019 11:20:05 +0200
To: Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH 20/35] irqchip/gic-v4.1: Allow direct invalidation of VLPIs
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Date: Mon, 30 Sep 2019 10:20:05 +0100
From: Marc Zyngier <maz@kernel.org>
In-Reply-To: <db01f956-bc53-b8a5-9406-15b889d717f0@huawei.com>
References: <20190923182606.32100-1-maz@kernel.org>
 <20190923182606.32100-21-maz@kernel.org>
 <db01f956-bc53-b8a5-9406-15b889d717f0@huawei.com>
Message-ID: <1c96d38da22a97b1fda94a940b60e345@www.loen.fr>
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

On 2019-09-28 03:02, Zenghui Yu wrote:
> On 2019/9/24 2:25, Marc Zyngier wrote:
>> Just like for INVALL, GICv4.1 has grown a VPE-aware INVLPI register.
>> Let's plumb it in and make use of the DirectLPI code in that case.
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> ---
>>   drivers/irqchip/irq-gic-v3-its.c   | 19 +++++++++++++++++--
>>   include/linux/irqchip/arm-gic-v3.h |  1 +
>>   2 files changed, 18 insertions(+), 2 deletions(-)
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c 
>> b/drivers/irqchip/irq-gic-v3-its.c
>> index b791c9beddf2..34595a7fcccb 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -1200,13 +1200,27 @@ static void wait_for_syncr(void __iomem 
>> *rdbase)
>>   static void direct_lpi_inv(struct irq_data *d)
>>   {
>> +	struct its_vlpi_map *map = get_vlpi_map(d);
>>   	struct its_collection *col;
>>   	void __iomem *rdbase;
>> +	u64 val;
>> +
>> +	if (map) {
>> +		struct its_device *its_dev = irq_data_get_irq_chip_data(d);
>> +
>> +		WARN_ON(!is_v4_1(its_dev->its));
>> +
>> +		val  = GICR_INVLPIR_V;
>> +		val |= FIELD_PREP(GICR_INVLPIR_VPEID, map->vpe->vpe_id);
>> +		val |= FIELD_PREP(GICR_INVLPIR_INTID, map->vintid);
>> +	} else {
>> +		val = d->hwirq;
>> +	}
>>
>>   	/* Target the redistributor this LPI is currently routed to */
>>   	col = irq_to_col(d);
>
> I think irq_to_col() may not work when GICv4.1 VLPIs are involved in.
>
> irq_to_col() gives us col_map[event] as the target redistributor,
> but the correct one for VLPIs should be 
> vlpi_maps[event]->vpe->col_idx.
> These two are not always pointing to the same physical RD.
> For example, if guest issues a MOVI against a VLPI, we will update 
> the
> corresponding vlpi_map->vpe and issue a VMOVI on ITS... but leave the
> col_map[event] unchanged.
>
> col_map[event] usually describes the physical LPI's CPU affinity, but
> when this physical LPI serves as something which the VLPI is backed 
> by,
> we take really little care of it.  Did I miss something here?

You didn't miss anything, and this is indeed another pretty bad bug.
The collection mapping is completely unused when the LPI becomes a
VLPI, and it is only the vpe->col_id that matters (which gets updated
on VMOVP).

This shows that irq_to_col() is the wrong abstraction, and what we're
interested is something that is more like 'irq to cpuid', allowing us
to directly point to the right distributor.

Please see the patch I just pushed[1], which does that.

Thanks,

         M.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/commit/?h=irq/gic-v4.1-devel&id=aff363113eb26b6840136b69c2c7db2ea691db20
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
