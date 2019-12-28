Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3F93312BD51
	for <lists+kvmarm@lfdr.de>; Sat, 28 Dec 2019 11:41:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C03E24A541;
	Sat, 28 Dec 2019 05:41:55 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id siBO1VSfaHZh; Sat, 28 Dec 2019 05:41:55 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C2CDF4A524;
	Sat, 28 Dec 2019 05:41:54 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id AB0854A2E7
 for <kvmarm@lists.cs.columbia.edu>; Sat, 28 Dec 2019 05:41:52 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hOrtAAfGcg-d for <kvmarm@lists.cs.columbia.edu>;
 Sat, 28 Dec 2019 05:41:51 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id C28CB4A1FA
 for <kvmarm@lists.cs.columbia.edu>; Sat, 28 Dec 2019 05:41:51 -0500 (EST)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1il9XY-0003x6-Oe; Sat, 28 Dec 2019 10:41:48 +0000
Date: Sat, 28 Dec 2019 10:41:47 +0000
From: Marc Zyngier <maz@kernel.org>
To: Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v3 28/32] KVM: arm64: GICv4.1: Add direct injection
 capability to SGI registers
Message-ID: <20191228104147.0e658aa9@why>
In-Reply-To: <c009fb1f-f4ec-22d5-ba7d-58426837c8af@huawei.com>
References: <20191224111055.11836-1-maz@kernel.org>
 <20191224111055.11836-29-maz@kernel.org>
 <c009fb1f-f4ec-22d5-ba7d-58426837c8af@huawei.com>
Organization: Approximate
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: yuzenghui@huawei.com, kvmarm@lists.cs.columbia.edu,
 linux-kernel@vger.kernel.org, eric.auger@redhat.com, james.morse@arm.com,
 julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, tglx@linutronix.de,
 jason@lakedaemon.net, lorenzo.pieralisi@arm.com, Andrew.Murray@arm.com,
 rrichter@marvell.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Jason Cooper <jason@lakedaemon.net>, linux-kernel@vger.kernel.org,
 Robert Richter <rrichter@marvell.com>, Thomas Gleixner <tglx@linutronix.de>,
 kvmarm@lists.cs.columbia.edu
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On Sat, 28 Dec 2019 17:19:36 +0800
Zenghui Yu <yuzenghui@huawei.com> wrote:

> Hi Marc,
> 
> On 2019/12/24 19:10, Marc Zyngier wrote:
> > Most of the GICv3 emulation code that deals with SGIs now has to be
> > aware of the v4.1 capabilities in order to benefit from it.
> > 
> > Add such support, keyed on the interrupt having the hw flag set and
> > being a SGI.
> > 
> > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > ---  
> 
> > diff --git a/virt/kvm/arm/vgic/vgic-mmio.c b/virt/kvm/arm/vgic/vgic-mmio.c
> > index 0d090482720d..6ebf747a7806 100644
> > --- a/virt/kvm/arm/vgic/vgic-mmio.c
> > +++ b/virt/kvm/arm/vgic/vgic-mmio.c
> > @@ -290,6 +345,20 @@ void vgic_mmio_write_cpending(struct kvm_vcpu *vcpu,  
> >   >   		raw_spin_lock_irqsave(&irq->irq_lock, flags);
> >   > +		if (irq->hw && vgic_irq_is_sgi(irq->intid)) {  
> > +			/* HW SGI? Ask the GIC to inject it */  
> 
> Shouldn't this be "Ask the GIC to clear its pending state"?

yeah, a silly copy-paste mistake, thanks for spotting this!

> Otherwise looks good!

Thanks for taking the time to review this work!

	M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
