Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A28281249DD
	for <lists+kvmarm@lfdr.de>; Wed, 18 Dec 2019 15:39:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 36AD34A7E4;
	Wed, 18 Dec 2019 09:39:10 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NvwNAx0EAh8o; Wed, 18 Dec 2019 09:39:10 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DACFB4A5A3;
	Wed, 18 Dec 2019 09:39:08 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6DB7D4A542
 for <kvmarm@lists.cs.columbia.edu>; Wed, 18 Dec 2019 09:39:08 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I-WxpjWKIb68 for <kvmarm@lists.cs.columbia.edu>;
 Wed, 18 Dec 2019 09:39:07 -0500 (EST)
Received: from inca-roads.misterjones.org (inca-roads.misterjones.org
 [213.251.177.50])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 347F44A541
 for <kvmarm@lists.cs.columbia.edu>; Wed, 18 Dec 2019 09:39:07 -0500 (EST)
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
 (envelope-from <maz@kernel.org>)
 id 1ihaTg-0002jL-Mr; Wed, 18 Dec 2019 15:39:04 +0100
To: Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v2 13/36] irqchip/gic-v4.1: Don't use the VPE proxy if
 RVPEID is set
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Date: Wed, 18 Dec 2019 14:39:04 +0000
From: Marc Zyngier <maz@kernel.org>
In-Reply-To: <8514ccbe-814a-5bdd-3791-bdd65510ce68@huawei.com>
References: <20191027144234.8395-1-maz@kernel.org>
 <20191027144234.8395-14-maz@kernel.org>
 <8514ccbe-814a-5bdd-3791-bdd65510ce68@huawei.com>
Message-ID: <762f78e917ac501629729fcf7718178c@www.loen.fr>
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

On 2019-11-01 11:05, Zenghui Yu wrote:
> Hi Marc,
>
> On 2019/10/27 22:42, Marc Zyngier wrote:
>> The infamous VPE proxy device isn't used with GICv4.1 because:
>> - we can invalidate any LPI from the DirectLPI MMIO interface
>> - the ITS and redistributors understand the life cycle of
>>    the doorbell, so we don't need to enable/disable it all
>>    the time
>> So let's escape early from the proxy related functions.
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>
> Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
>
>> ---
>>   drivers/irqchip/irq-gic-v3-its.c | 23 ++++++++++++++++++++++-
>>   1 file changed, 22 insertions(+), 1 deletion(-)
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c 
>> b/drivers/irqchip/irq-gic-v3-its.c
>> index 220d490d516e..999e61a9b2c3 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -3069,7 +3069,7 @@ static const struct irq_domain_ops 
>> its_domain_ops = {
>>   /*
>>    * This is insane.
>>    *
>> - * If a GICv4 doesn't implement Direct LPIs (which is extremely
>> + * If a GICv4.0 doesn't implement Direct LPIs (which is extremely
>>    * likely), the only way to perform an invalidate is to use a fake
>>    * device to issue an INV command, implying that the LPI has first
>>    * been mapped to some event on that device. Since this is not 
>> exactly
>> @@ -3077,9 +3077,18 @@ static const struct irq_domain_ops 
>> its_domain_ops = {
>>    * only issue an UNMAP if we're short on available slots.
>>    *
>>    * Broken by design(tm).
>> + *
>> + * GICv4.1 actually mandates that we're able to invalidate by 
>> writing to a
>> + * MMIO register. It doesn't implement the whole of DirectLPI, but 
>> that's
>> + * good enough. And most of the time, we don't even have to 
>> invalidate
>> + * anything, so that's actually pretty good!
>
> I can't understand the meaning of this last sentence. May I ask for 
> an
> explanation? :)

Yeah, reading this now, it feels pretty clumsy, and only remotely
connected to the patch.

What I'm trying to say here is that, although GICv4.1 doesn't have
the full spectrum of v4.0 DirectLPI (it only allows a subset of it),
this subset is more then enough for us. Here's the rational:

When a vPE exits from the hypervisor, we know whether we need to
request a doorbell or not (depending on whether we're blocking on
WFI or not). On GICv4.0, this translates into enabling the doorbell
interrupt, which generates an invalidation (costly). And whenever
we've taken a doorbell, or are scheduled again, we need to turn
the doorbell off (invalidation again).

With v4.1, we can just say *at exit time* whether we want doorbells
to be subsequently generated (see its_vpe_4_1_deschedule() and the
req_db parameter in the info structure). This is part of making
the vPE non-resident, so we have 0 overhead at this stage.

I'll try and update the comment here.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
