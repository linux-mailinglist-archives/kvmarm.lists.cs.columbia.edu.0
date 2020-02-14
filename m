Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5384215D699
	for <lists+kvmarm@lfdr.de>; Fri, 14 Feb 2020 12:36:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C4E594ACF4;
	Fri, 14 Feb 2020 06:36:28 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lzM1YSGdt1iE; Fri, 14 Feb 2020 06:36:28 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8711F4ACBE;
	Fri, 14 Feb 2020 06:36:27 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 809BE4AC84
 for <kvmarm@lists.cs.columbia.edu>; Fri, 14 Feb 2020 06:36:26 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wlH1JmLUH5-A for <kvmarm@lists.cs.columbia.edu>;
 Fri, 14 Feb 2020 06:36:25 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 26B564A536
 for <kvmarm@lists.cs.columbia.edu>; Fri, 14 Feb 2020 06:36:25 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A64C01FB;
 Fri, 14 Feb 2020 03:36:24 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A47E93F68F;
 Fri, 14 Feb 2020 03:36:23 -0800 (PST)
Date: Fri, 14 Feb 2020 11:36:07 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2] kvm: arm: VGIC: Fix interrupt group enablement
Message-ID: <20200214113607.39854c81@donnerap.cambridge.arm.com>
In-Reply-To: <e2426986ebc9be4e14eb99028b28a43e@www.loen.fr>
References: <20191122185142.65477-1-andre.przywara@arm.com>
 <e2426986ebc9be4e14eb99028b28a43e@www.loen.fr>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Cc: linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
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

On Mon, 25 Nov 2019 10:55:01 +0000
Marc Zyngier <maz@kernel.org> wrote:

Hi Marc,

dug this out of my inbox, sorry for warming this up.

> On 2019-11-22 18:51, Andre Przywara wrote:
> > Hi Marc,
> >
> > this is still a bit rough, and only briefly tested, but I wanted to
> > hear your opinion on the general approach (using a second list in
> > addition to the ap_list). Some ugly bits come from the fact that the
> > two lists are not that different, so we have to consider both of them
> > at times. This is what I wanted to avoid with just one list that gets
> > filtered on the fly.
> > Or I am just stupid and don't see how it can be done properly ;-)  
> 
> I don't know about that, but I think there is a better way.
> 
> You have essentially two sets of pending interrupts:
> 
> 1) those that are enabled and group-enabled, that end up in the AP list
> 2) those that are either disabled and/or group-disabled
> 
> Today, (2) are not on any list.

For a reason: because we don't really care about them. And so far they would only become interesting on an *individual* interrupt base, and our VGIC routines can deal very well with that.

> What I'm suggesting is that we create
> a list for these interrupts that cannot be forwarded.

So the problem with that is that a list would need a list lock, and this is where things get hairy:
- Either we introduce a separate disabled_list lock, adding to the nightmare of lock hierarchy we already have. I don't think that's really justifiable just because of group0 IRQs.
- We piggy-back on an existing lock, like the ap_list_lock. The problem with that is that vgic_queue_irq_unlock takes and drops that lock, so we can't just iterate over this disabled list while holding that lock, and feed each IRQ to vgic_queue_irq_unlock() easily.
One solution I was thinking about was something like:
while (!list_empty(disabled_list)) {
	spin_lock(ap_list_lock);
	irq = remove_first_entry(disabled_list);
	spin_unlock(ap_list_lock);

	lock_irq(irq);
	/* re-check? */
	vgic_queue_irq_unlock(irq);
}

Does that sound feasible? It's not really efficient nor nice, but I am not sure we care so much about this since we assume group enablement is rather rare.

Cheers,
Andre

> Then enabling an interrupt or a group is a matter of moving pending
> interrupts from one list to another. And I think most of the logic
> can be hidden in vgic_queue_irq_unlock().
> 
>          M.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
