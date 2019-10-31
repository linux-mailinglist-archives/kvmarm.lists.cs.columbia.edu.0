Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A1E77EAC53
	for <lists+kvmarm@lfdr.de>; Thu, 31 Oct 2019 10:08:24 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 20C9B4AC90;
	Thu, 31 Oct 2019 05:08:24 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fkbZqD5Tg8vQ; Thu, 31 Oct 2019 05:08:24 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D333E4A956;
	Thu, 31 Oct 2019 05:08:22 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 298CE4A591
 for <kvmarm@lists.cs.columbia.edu>; Thu, 31 Oct 2019 05:08:21 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qShgfqZ+l0ql for <kvmarm@lists.cs.columbia.edu>;
 Thu, 31 Oct 2019 05:08:19 -0400 (EDT)
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id BF61C4A3BF
 for <kvmarm@lists.cs.columbia.edu>; Thu, 31 Oct 2019 05:08:18 -0400 (EDT)
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id CA2A9A5AD9A00E4AB6C7;
 Thu, 31 Oct 2019 17:08:14 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Thu, 31 Oct 2019
 17:08:06 +0800
Subject: Re: [PATCH v2 06/36] irqchip/gic-v3-its: Kill its->device_ids and use
 TYPER copy instead
To: Marc Zyngier <maz@kernel.org>
References: <20191027144234.8395-1-maz@kernel.org>
 <20191027144234.8395-7-maz@kernel.org>
 <603e60d8-b2a5-74a4-6d32-8277aa0e39c1@huawei.com>
 <86imo5xqoh.wl-maz@kernel.org>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <7439499b-1626-51a5-2f67-e79e7fdbcdf9@huawei.com>
Date: Thu, 31 Oct 2019 17:08:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <86imo5xqoh.wl-maz@kernel.org>
Content-Language: en-US
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Jason Cooper <jason@lakedaemon.net>, linux-kernel@vger.kernel.org,
 Robert Richter <rrichter@marvell.com>, Jayachandran C <jnair@marvell.com>,
 Thomas Gleixner <tglx@linutronix.de>, kvmarm@lists.cs.columbia.edu
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

On 2019/10/31 16:30, Marc Zyngier wrote:
> Hi Zenghui,
> 
> On Thu, 31 Oct 2019 06:33:23 +0000,
> Zenghui Yu <yuzenghui@huawei.com> wrote:
>>
>> Hi Marc,
>>
>> On 2019/10/27 22:42, Marc Zyngier wrote:
>>> Now that we have a copy of TYPER in the ITS structure, rely on this
>>> to provide the same service as its->device_ids, which gets axed.
>>> Errata workarounds are now updating the cached fields instead of
>>> requiring a separate field in the ITS structure.
>>>
>>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>>
>> Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
> 
> Thanks for that.
> 
>>
>>> ---
>>>    drivers/irqchip/irq-gic-v3-its.c   | 24 +++++++++++++-----------
>>>    include/linux/irqchip/arm-gic-v3.h |  2 +-
>>>    2 files changed, 14 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>>> index 3b046181ddfc..6c91c7feadf3 100644
>>> --- a/drivers/irqchip/irq-gic-v3-its.c
>>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>>> @@ -109,7 +109,6 @@ struct its_node {
>>>    	struct list_head	its_device_list;
>>>    	u64			flags;
>>>    	unsigned long		list_nr;
>>> -	u32			device_ids;
>>>    	int			numa_node;
>>>    	unsigned int		msi_domain_flags;
>>>    	u32			pre_its_base; /* for Socionext Synquacer */
>>> @@ -117,6 +116,7 @@ struct its_node {
>>>    };
>>>      #define is_v4(its)		(!!((its)->typer &
>>> GITS_TYPER_VLPIS))
>>> +#define device_ids(its)		(FIELD_GET(GITS_TYPER_DEVBITS, (its)->typer) + 1)
>>>      #define ITS_ITT_ALIGN		SZ_256
>>>    @@ -1938,9 +1938,9 @@ static bool its_parse_indirect_baser(struct
>>> its_node *its,
>>>    	if (new_order >= MAX_ORDER) {
>>>    		new_order = MAX_ORDER - 1;
>>>    		ids = ilog2(PAGE_ORDER_TO_SIZE(new_order) / (int)esz);
>>> -		pr_warn("ITS@%pa: %s Table too large, reduce ids %u->%u\n",
>>> +		pr_warn("ITS@%pa: %s Table too large, reduce ids %llu->%u\n",
>>>    			&its->phys_base, its_base_type_string[type],
>>> -			its->device_ids, ids);
>>> +			device_ids(its), ids);
>>
>> But this pr_warn() looks a bit odd. The table type is chosen from
>> its_base_type_string[], but ids is always Devbits (+1)?
> 
> This is a bit of a shortcut, I agree. But the device table practically
> is the only one where we can run out of space if the ITS doesn't
> support two level tables. All the other tables are very small, being
> limited by the number of CPUs (collections) or a small ID space
> (vPEs).

Make sense. Thanks for the clarification.


Zenghui

> 
> So while this is a bit ugly, I don't thing it is not too concerning.
> 
> Thanks,
> 
> 	M.
> 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
