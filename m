Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D191C162356
	for <lists+kvmarm@lfdr.de>; Tue, 18 Feb 2020 10:27:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4DF934AEBD;
	Tue, 18 Feb 2020 04:27:52 -0500 (EST)
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
	with ESMTP id IFwhCMmQFksO; Tue, 18 Feb 2020 04:27:52 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B62794AF6E;
	Tue, 18 Feb 2020 04:27:50 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0078E4AF65
 for <kvmarm@lists.cs.columbia.edu>; Tue, 18 Feb 2020 04:27:50 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ixdcVzKweXiz for <kvmarm@lists.cs.columbia.edu>;
 Tue, 18 Feb 2020 04:27:48 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id EDBDC4AF64
 for <kvmarm@lists.cs.columbia.edu>; Tue, 18 Feb 2020 04:27:47 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A8FD9206EF;
 Tue, 18 Feb 2020 09:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1582018066;
 bh=JfpnX0/9AXLX0SUbepC6ix94WfC2VqtqT6BShq+yOfY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=i1haDJBjVgMh5Z7iwcxqIPg/WGXs7z0EMLSEMdnH/za4diZ8awNNMtjwGtabI/lIp
 VqU2FVFh4bDIRMvJpSNwBU0pVTDG/F9SEdf0JMsf1n237Pn+/e0cHW7rCudfCcUM3F
 UNa9nlJINV2tawUiRWnD29FGW09j4zoy/Fj888bY=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1j3zAP-006BEh-0t; Tue, 18 Feb 2020 09:27:45 +0000
MIME-Version: 1.0
Date: Tue, 18 Feb 2020 09:27:44 +0000
From: Marc Zyngier <maz@kernel.org>
To: Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v4 08/20] irqchip/gic-v4.1: Plumb get/set_irqchip_state
 SGI callbacks
In-Reply-To: <4b7f71f1-5e7f-e6af-f47d-7ed0d3a8739f@huawei.com>
References: <20200214145736.18550-1-maz@kernel.org>
 <20200214145736.18550-9-maz@kernel.org>
 <4b7f71f1-5e7f-e6af-f47d-7ed0d3a8739f@huawei.com>
Message-ID: <75597af0d2373ac4d92d8162a1338cbb@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: yuzenghui@huawei.com, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com, jason@lakedaemon.net,
 rrichter@marvell.com, tglx@linutronix.de, eric.auger@redhat.com,
 james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Jason Cooper <jason@lakedaemon.net>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Robert Richter <rrichter@marvell.com>,
 Thomas Gleixner <tglx@linutronix.de>, kvmarm@lists.cs.columbia.edu,
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

Hi Zenghui,

On 2020-02-18 07:00, Zenghui Yu wrote:
> Hi Marc,
> 
> On 2020/2/14 22:57, Marc Zyngier wrote:
>> To implement the get/set_irqchip_state callbacks (limited to the
>> PENDING state), we have to use a particular set of hacks:
>> 
>> - Reading the pending state is done by using a pair of new 
>> redistributor
>>    registers (GICR_VSGIR, GICR_VSGIPENDR), which allow the 16 
>> interrupts
>>    state to be retrieved.
>> - Setting the pending state is done by generating it as we'd otherwise 
>> do
>>    for a guest (writing to GITS_SGIR)
>> - Clearing the pending state is done by emiting a VSGI command with 
>> the
>>    "clear" bit set.
>> 
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> ---
>>   drivers/irqchip/irq-gic-v3-its.c   | 56 
>> ++++++++++++++++++++++++++++++
>>   include/linux/irqchip/arm-gic-v3.h | 14 ++++++++
>>   2 files changed, 70 insertions(+)
>> 
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c 
>> b/drivers/irqchip/irq-gic-v3-its.c
>> index 1e448d9a16ea..a9753435c4ff 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -3915,11 +3915,67 @@ static int its_sgi_set_affinity(struct 
>> irq_data *d,
>>   	return -EINVAL;
>>   }
>>   +static int its_sgi_set_irqchip_state(struct irq_data *d,
>> +				     enum irqchip_irq_state which,
>> +				     bool state)
>> +{
>> +	if (which != IRQCHIP_STATE_PENDING)
>> +		return -EINVAL;
>> +
>> +	if (state) {
>> +		struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
>> +		struct its_node *its = find_4_1_its();
>> +		u64 val;
>> +
>> +		val  = FIELD_PREP(GITS_SGIR_VPEID, vpe->vpe_id);
>> +		val |= FIELD_PREP(GITS_SGIR_VINTID, d->hwirq);
>> +		writeq_relaxed(val, its->sgir_base + GITS_SGIR - SZ_128K);
>> +	} else {
>> +		its_configure_sgi(d, true);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int its_sgi_get_irqchip_state(struct irq_data *d,
>> +				     enum irqchip_irq_state which, bool *val)
>> +{
>> +	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
>> +	void __iomem *base = gic_data_rdist_cpu(vpe->col_idx)->rd_base + 
>> SZ_128K;
> 
> There might be a race on reading the 'vpe->col_idx' against a 
> concurrent
> vPE schedule (col_idx will be modified in its_vpe_set_affinity)? Will 
> we
> end up accessing the GICR_VSGI* registers of the old redistributor,
> while the vPE is now resident on the new one? Or is it harmful?

Very well spotted. There is a potential problem if old and new RDs are 
not part
of the same CommonLPIAff group.

> The same question for direct_lpi_inv(), where 'vpe->col_idx' will be
> used in irq_to_cpuid().

Same problem indeed. We need to ensure that no VMOVP operation can occur 
whilst
we use col_idx to access a redistributor. This means a vPE lock of some 
sort
that will protect the affinity.

But I think there is a slightly more general problem here, which we 
failed to
see initially: the same issue exists for physical LPIs, as col_map[] can 
be
updated (its_set_affinity()) in parallel with a direct invalidate.

The good old invalidation through the ITS does guarantee that the two 
operation
don't overlap, but direct invalidation breaks it.

Let me have a think about it.

> 
>> +	u32 count = 1000000;	/* 1s! */
>> +	u32 status;
>> +
>> +	if (which != IRQCHIP_STATE_PENDING)
>> +		return -EINVAL;
>> +
>> +	writel_relaxed(vpe->vpe_id, base + GICR_VSGIR);
>> +	do {
>> +		status = readl_relaxed(base + GICR_VSGIPENDR);
>> +		if (!(status & GICR_VSGIPENDR_BUSY))
>> +			goto out;
>> +
>> +		count--;
>> +		if (!count) {
>> +			pr_err_ratelimited("Unable to get SGI status\n");
>> +			goto out;
>> +		}
>> +		cpu_relax();
>> +		udelay(1);
>> +	} while(count);
>> +
>> +out:
>> +	*val = !!(status & (1 << d->hwirq));
>> +
>> +	return 0;
>> +}
>> +
>>   static struct irq_chip its_sgi_irq_chip = {
>>   	.name			= "GICv4.1-sgi",
>>   	.irq_mask		= its_sgi_mask_irq,
>>   	.irq_unmask		= its_sgi_unmask_irq,
>>   	.irq_set_affinity	= its_sgi_set_affinity,
>> +	.irq_set_irqchip_state	= its_sgi_set_irqchip_state,
>> +	.irq_get_irqchip_state	= its_sgi_get_irqchip_state,
>>   };
>>     static int its_sgi_irq_domain_alloc(struct irq_domain *domain,
>> diff --git a/include/linux/irqchip/arm-gic-v3.h 
>> b/include/linux/irqchip/arm-gic-v3.h
>> index a89578884263..64da945486ac 100644
>> --- a/include/linux/irqchip/arm-gic-v3.h
>> +++ b/include/linux/irqchip/arm-gic-v3.h
>> @@ -345,6 +345,15 @@
>>   #define GICR_VPENDBASER_4_1_VGRP1EN	(1ULL << 58)
>>   #define GICR_VPENDBASER_4_1_VPEID	GENMASK_ULL(15, 0)
>>   +#define GICR_VSGIR			0x0080
>> +
>> +#define GICR_VSGIR_VPEID		GENMASK(15, 0)
>> +
>> +#define GICR_VSGIPENDR			0x0088
>> +
>> +#define GICR_VSGIPENDR_BUSY		(1U << 31)
>> +#define GICR_VSGIPENDR_PENDING		GENMASK(15, 0)
>> +
>>   /*
>>    * ITS registers, offsets from ITS_base
>>    */
>> @@ -368,6 +377,11 @@
>>     #define GITS_TRANSLATER			0x10040
>>   +#define GITS_SGIR			0x20020
>> +
>> +#define GITS_SGIR_VPEID			GENMASK_ULL(47, 32)
>> +#define GITS_SGIR_VINTID		GENMASK_ULL(7, 0)
> 
> The spec says vINTID field is [3:0] of the GITS_SGIR.

Indeed, well spotted again!

Thanks,

          M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
