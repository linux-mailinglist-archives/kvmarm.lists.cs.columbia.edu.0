Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEAB124948
	for <lists+kvmarm@lfdr.de>; Wed, 18 Dec 2019 15:18:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A84764A59B;
	Wed, 18 Dec 2019 09:18:31 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Bz5bUplyv0br; Wed, 18 Dec 2019 09:18:31 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 826CC4A4A0;
	Wed, 18 Dec 2019 09:18:30 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A65A24A524
 for <kvmarm@lists.cs.columbia.edu>; Wed, 18 Dec 2019 09:18:28 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VPZt1cAF+xrN for <kvmarm@lists.cs.columbia.edu>;
 Wed, 18 Dec 2019 09:18:27 -0500 (EST)
Received: from inca-roads.misterjones.org (inca-roads.misterjones.org
 [213.251.177.50])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 7A0C54A3A3
 for <kvmarm@lists.cs.columbia.edu>; Wed, 18 Dec 2019 09:18:27 -0500 (EST)
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
 (envelope-from <maz@kernel.org>)
 id 1iha9g-0002Dh-1A; Wed, 18 Dec 2019 15:18:24 +0100
To: Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v2 19/36] irqchip/gic-v4.1: Add VPE INVALL callback
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Date: Wed, 18 Dec 2019 14:18:23 +0000
From: Marc Zyngier <maz@kernel.org>
In-Reply-To: <28e29c2d-a35a-6a67-c65d-7ab61d33b21b@huawei.com>
References: <20191027144234.8395-1-maz@kernel.org>
 <20191027144234.8395-20-maz@kernel.org>
 <28e29c2d-a35a-6a67-c65d-7ab61d33b21b@huawei.com>
Message-ID: <54ec5b97e909e4da85064c66fb2a1348@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: yuzenghui@huawei.com, kvmarm@lists.cs.columbia.edu,
 linux-kernel@vger.kernel.org, eric.auger@redhat.com, james.morse@arm.com,
 julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, tglx@linutronix.de,
 jason@lakedaemon.net, lorenzo.pieralisi@arm.com, andrew.murray@arm.com,
 jnair@marvell.com, rrichter@marvell.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org);
 SAEximRunCond expanded to false
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

[Old email, doing some v3 cleanup]

On 2019-11-01 11:51, Zenghui Yu wrote:
> Hi Marc,
>
> On 2019/10/27 22:42, Marc Zyngier wrote:
>> GICv4.1 redistributors have a VPE-aware INVALL register. Progress!
>> We can now emulate a guest-requested INVALL without emiting a
>> VINVALL command.
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>
> Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
>
>> ---
>>   drivers/irqchip/irq-gic-v3-its.c   | 14 ++++++++++++++
>>   include/linux/irqchip/arm-gic-v3.h |  3 +++
>>   2 files changed, 17 insertions(+)
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c 
>> b/drivers/irqchip/irq-gic-v3-its.c
>> index f7effd453729..10bd156aa042 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -3511,6 +3511,19 @@ static void its_vpe_4_1_deschedule(struct 
>> its_vpe *vpe,
>>   	}
>>   }
>>   +static void its_vpe_4_1_invall(struct its_vpe *vpe)
>> +{
>> +	void __iomem *rdbase;
>> +	u64 val;
>> +
>> +	val  = GICR_INVLPIR_V;
>> +	val |= FIELD_PREP(GICR_INVLPIR_VPEID, vpe->vpe_id);
>
> Can we use GICR_INVALL_V/VPEID instead, and ...
>
>> +
>> +	/* Target the redistributor this vPE is currently known on */
>> +	rdbase = per_cpu_ptr(gic_rdists->rdist, vpe->col_idx)->rd_base;
>> +	gic_write_lpir(val, rdbase + GICR_INVALLR);
>> +}
>> +
>>   static int its_vpe_4_1_set_vcpu_affinity(struct irq_data *d, void 
>> *vcpu_info)
>>   {
>>   	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
>> @@ -3526,6 +3539,7 @@ static int 
>> its_vpe_4_1_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
>>   		return 0;
>>
>>   	case INVALL_VPE:
>> +		its_vpe_4_1_invall(vpe);
>>   		return 0;
>>
>>   	default:
>> diff --git a/include/linux/irqchip/arm-gic-v3.h 
>> b/include/linux/irqchip/arm-gic-v3.h
>> index 6fd89d77b2b2..b69f60792554 100644
>> --- a/include/linux/irqchip/arm-gic-v3.h
>> +++ b/include/linux/irqchip/arm-gic-v3.h
>> @@ -247,6 +247,9 @@
>>   #define GICR_TYPER_COMMON_LPI_AFF	GENMASK_ULL(25, 24)
>>   #define GICR_TYPER_AFFINITY		GENMASK_ULL(63, 32)
>>   +#define GICR_INVLPIR_VPEID		GENMASK_ULL(47, 32)
>> +#define GICR_INVLPIR_V			GENMASK_ULL(63, 63)
>> +
>
> ... define them here:
>
> #define GICR_INVALL_VPEID		GICR_INVLPIR_VPEID
> #define GICR_INVALL_V			GICR_INVLPIR_V

Yes, that's a sensible things to do. I'll squash that in my rebased 
series.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
