Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 32C1F18BAF6
	for <lists+kvmarm@lfdr.de>; Thu, 19 Mar 2020 16:21:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AC4D14B099;
	Thu, 19 Mar 2020 11:21:49 -0400 (EDT)
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
	with ESMTP id BvSpv7FThXTl; Thu, 19 Mar 2020 11:21:49 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 608354B08E;
	Thu, 19 Mar 2020 11:21:48 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EFC6B4B082
 for <kvmarm@lists.cs.columbia.edu>; Thu, 19 Mar 2020 11:21:46 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BXb0Njo3sMwV for <kvmarm@lists.cs.columbia.edu>;
 Thu, 19 Mar 2020 11:21:45 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id BBF6E4A4BE
 for <kvmarm@lists.cs.columbia.edu>; Thu, 19 Mar 2020 11:21:45 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A324B20658;
 Thu, 19 Mar 2020 15:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1584631304;
 bh=F6q5btvbklLUG07V2Lwbtfvpc+8jDG0/MxA3HQ9VDtM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=JPA1J07If5eZNL6QR32IQDwuMxW4CIFSKTHedniqtt3qhjXMQhUB0dICE2zwCdK9P
 nGKPdsozIqPbRjniOwNbVCEGMzJgiYD4vsaMD870QC6D5Dy5d4Zif2wVhbSZOrHljp
 Z+KtwSGLZYHEmw+7UEHx938eVIzH5NvTBxnGMKsg=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jEwzO-00E0De-PQ; Thu, 19 Mar 2020 15:21:42 +0000
MIME-Version: 1.0
Date: Thu, 19 Mar 2020 15:21:42 +0000
From: Marc Zyngier <maz@kernel.org>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v5 23/23] KVM: arm64: GICv4.1: Expose HW-based SGIs in
 debugfs
In-Reply-To: <4cb4c3d4-7b02-bb77-cd7a-c185346b6a2f@redhat.com>
References: <20200304203330.4967-1-maz@kernel.org>
 <20200304203330.4967-24-maz@kernel.org>
 <4cb4c3d4-7b02-bb77-cd7a-c185346b6a2f@redhat.com>
Message-ID: <45c282bddd43420024633943c1befac3@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: eric.auger@redhat.com, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com, jason@lakedaemon.net,
 rrichter@marvell.com, tglx@linutronix.de, yuzenghui@huawei.com,
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

Hi Eric,

On 2020-03-19 15:05, Auger Eric wrote:
> Hi Marc,
> 
> On 3/4/20 9:33 PM, Marc Zyngier wrote:
>> The vgic-state debugfs file could do with showing the pending state
>> of the HW-backed SGIs. Plug it into the low-level code.
>> 
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> ---
>>  virt/kvm/arm/vgic/vgic-debug.c | 14 +++++++++++++-
>>  1 file changed, 13 insertions(+), 1 deletion(-)
>> 
>> diff --git a/virt/kvm/arm/vgic/vgic-debug.c 
>> b/virt/kvm/arm/vgic/vgic-debug.c
>> index cc12fe9b2df3..b13a9e3f99dd 100644
>> --- a/virt/kvm/arm/vgic/vgic-debug.c
>> +++ b/virt/kvm/arm/vgic/vgic-debug.c
>> @@ -178,6 +178,8 @@ static void print_irq_state(struct seq_file *s, 
>> struct vgic_irq *irq,
>>  			    struct kvm_vcpu *vcpu)
>>  {
>>  	char *type;
>> +	bool pending;
> nit: can be directly initialized to irq->pending_latch
>> +
>>  	if (irq->intid < VGIC_NR_SGIS)
>>  		type = "SGI";
>>  	else if (irq->intid < VGIC_NR_PRIVATE_IRQS)
>> @@ -190,6 +192,16 @@ static void print_irq_state(struct seq_file *s, 
>> struct vgic_irq *irq,
>>  	if (irq->intid ==0 || irq->intid == VGIC_NR_PRIVATE_IRQS)
>>  		print_header(s, irq, vcpu);
>> 
>> +	pending = irq->pending_latch;
>> +	if (irq->hw && vgic_irq_is_sgi(irq->intid)) {
>> +		int err;
>> +
>> +		err = irq_get_irqchip_state(irq->host_irq,
>> +					    IRQCHIP_STATE_PENDING,
>> +					    &pending);
>> +		WARN_ON_ONCE(err);
>> +	}
>> +
>>  	seq_printf(s, "       %s %4d "
>>  		      "    %2d "
>>  		      "%d%d%d%d%d%d%d "
>> @@ -201,7 +213,7 @@ static void print_irq_state(struct seq_file *s, 
>> struct vgic_irq *irq,
>>  		      "\n",
>>  			type, irq->intid,
>>  			(irq->target_vcpu) ? irq->target_vcpu->vcpu_id : -1,
>> -			irq->pending_latch,
>> +			pending,
>>  			irq->line_level,
>>  			irq->active,
>>  			irq->enabled,
>> 
> The patch looks good to me but I am now lost about how we retrieve the
> pending stat of other hw mapped interrupts. Looks we use
> irq->pending_latch always. Is that correct?

Correct. GICv4.0 doesn't give us an architectural way to look at the
vLPI pending state (there isn't even a guarantee about when the GIC
will stop writing to memory, if it ever does).

With GICv4.1, you can introspect the HW state for SGIs. You can also
look at the vLPI state by peeking at the virtual pending table, but
you'd need to unmap the VPE first, which I obviously don't want to do
for this debug interface, specially as it can be used whilst the guest
is up and running.

In the future, we'll have to implement that in order to support guest
save/restore from a GICv4.1 system. I haven't given much thought to it
though.

> For the patch:
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
