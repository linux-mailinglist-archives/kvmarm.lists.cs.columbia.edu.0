Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B6F27108C57
	for <lists+kvmarm@lfdr.de>; Mon, 25 Nov 2019 11:55:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3CDCE4AEA7;
	Mon, 25 Nov 2019 05:55:08 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mK2muqFAdgcu; Mon, 25 Nov 2019 05:55:08 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 220E64ACBE;
	Mon, 25 Nov 2019 05:55:07 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D768D4AC77
 for <kvmarm@lists.cs.columbia.edu>; Mon, 25 Nov 2019 05:55:05 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oE2hUzq4Z4Ln for <kvmarm@lists.cs.columbia.edu>;
 Mon, 25 Nov 2019 05:55:04 -0500 (EST)
Received: from inca-roads.misterjones.org (inca-roads.misterjones.org
 [213.251.177.50])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 8EED94A97D
 for <kvmarm@lists.cs.columbia.edu>; Mon, 25 Nov 2019 05:55:04 -0500 (EST)
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
 (envelope-from <maz@kernel.org>)
 id 1iZC1G-0007GU-5V; Mon, 25 Nov 2019 11:55:02 +0100
To: Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH v2] kvm: arm: VGIC: Fix interrupt group enablement
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Date: Mon, 25 Nov 2019 10:55:01 +0000
From: Marc Zyngier <maz@kernel.org>
In-Reply-To: <20191122185142.65477-1-andre.przywara@arm.com>
References: <20191122185142.65477-1-andre.przywara@arm.com>
Message-ID: <e2426986ebc9be4e14eb99028b28a43e@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: andre.przywara@arm.com, julien.thierry.kdev@gmail.com,
 suzuki.poulose@arm.com, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org);
 SAEximRunCond expanded to false
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On 2019-11-22 18:51, Andre Przywara wrote:
> Hi Marc,
>
> this is still a bit rough, and only briefly tested, but I wanted to
> hear your opinion on the general approach (using a second list in
> addition to the ap_list). Some ugly bits come from the fact that the
> two lists are not that different, so we have to consider both of them
> at times. This is what I wanted to avoid with just one list that gets
> filtered on the fly.
> Or I am just stupid and don't see how it can be done properly ;-)

I don't know about that, but I think there is a better way.

You have essentially two sets of pending interrupts:

1) those that are enabled and group-enabled, that end up in the AP list
2) those that are either disabled and/or group-disabled

Today, (2) are not on any list. What I'm suggesting is that we create
a list for these interrupts that cannot be forwarded.

Then enabling an interrupt or a group is a matter of moving pending
interrupts from one list to another. And I think most of the logic
can be hidden in vgic_queue_irq_unlock().

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
