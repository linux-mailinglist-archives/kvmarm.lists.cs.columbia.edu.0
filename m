Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8D34737138B
	for <lists+kvmarm@lfdr.de>; Mon,  3 May 2021 12:17:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 05BAD4B45F;
	Mon,  3 May 2021 06:17:32 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p3YXFPJUZ8rA; Mon,  3 May 2021 06:17:31 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8F4B54B44C;
	Mon,  3 May 2021 06:17:30 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6A0794B431
 for <kvmarm@lists.cs.columbia.edu>; Mon,  3 May 2021 06:17:29 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iv9zR64C1oUb for <kvmarm@lists.cs.columbia.edu>;
 Mon,  3 May 2021 06:17:28 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 29FC24B343
 for <kvmarm@lists.cs.columbia.edu>; Mon,  3 May 2021 06:17:28 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2C3DB610E6;
 Mon,  3 May 2021 10:17:27 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=wait-a-minute.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1ldVdk-00AX3n-VA; Mon, 03 May 2021 11:17:25 +0100
Date: Mon, 03 May 2021 11:17:23 +0100
Message-ID: <87bl9sunnw.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Vikram Sethi <vsethi@nvidia.com>
Subject: Re: [RFC 1/2] vfio/pci: keep the prefetchable attribute of a BAR
 region in VMA
In-Reply-To: <BL0PR12MB25329EF5DFA7BBAA732064A7BD5C9@BL0PR12MB2532.namprd12.prod.outlook.com>
References: <20210429162906.32742-1-sdonthineni@nvidia.com>
 <20210429162906.32742-2-sdonthineni@nvidia.com>
 <20210429122840.4f98f78e@redhat.com>
 <470360a7-0242-9ae5-816f-13608f957bf6@nvidia.com>
 <20210429134659.321a5c3c@redhat.com>
 <e3d7fda8-5263-211c-3686-f699765ab715@nvidia.com>
 <87czucngdc.wl-maz@kernel.org>
 <1edb2c4e-23f0-5730-245b-fc6d289951e1@nvidia.com>
 <878s4zokll.wl-maz@kernel.org>
 <BL0PR12MB2532CC436EBF626966B15994BD5E9@BL0PR12MB2532.namprd12.prod.outlook.com>
 <87eeeqvm1d.wl-maz@kernel.org>
 <BL0PR12MB25329EF5DFA7BBAA732064A7BD5C9@BL0PR12MB2532.namprd12.prod.outlook.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: vsethi@nvidia.com, sdonthineni@nvidia.com,
 alex.williamson@redhat.com, will@kernel.org, catalin.marinas@arm.com,
 christoffer.dall@arm.com, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, jsequeira@nvidia.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Sequeira <jsequeira@nvidia.com>, Will Deacon <will@kernel.org>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

Hi Vikram,

On Sun, 02 May 2021 18:56:31 +0100,
Vikram Sethi <vsethi@nvidia.com> wrote:
> 
> Hi Marc, 
> 
> > From: Marc Zyngier <maz@kernel.org>
> > Hi Vikram,
> > 
>  
> > The problem I see is that we have VM and userspace being written in terms
> > of Write-Combine, which is:
> > 
> > - loosely defined even on x86
> > 
> > - subject to interpretations in the way it maps to PCI
> > 
> > - has no direct equivalent in the ARMv8 collection of memory
> >   attributes (and Normal_NC comes with speculation capabilities which
> >   strikes me as extremely undesirable on arbitrary devices)
> 
> If speculation with Normal NC to prefetchable BARs in devices was a
> problem, those devices would already be broken in baremetal with
> ioremap_wc on arm64, and we would need quirks there to not do Normal
> NC for them but Device GRE, and if such a quirk was needed on
> baremetal, it could be picked up by vfio/KVM as well. But we haven't
> seen any broken devices doing wc on baremetal on ARM64, have we?

The lack of evidence does not equate to a proof, and your devices not
misbehaving doesn't mean it is the right thing, specially when we have
such a wide range of CPU and interconnect implementation. Which is why
I really want an answer at the architecture level. Not a "it works for
me" type of answer.

Furthermore, as I replied to Shanker in a separate email, what
Linux/arm64 does is pretty much irrelevant. KVM/arm64 implements the
ARMv8 architecture, and it is at that level that we need to solve the
problem.

If, by enumerating the properties of Prefetchable, you can show that
they are a strict superset of Normal_NC, I'm on board. I haven't seen
such an enumeration so far.

> I know we have tested NICs write combining on arm64 in baremetal, as
> well as GPU and NVMe CMB without issues.
> 
> Further, I don't see why speculation to non cacheble would be an
> issue if prefetch without side effects is allowed by the device,
> which is what a prefetchable BAR is.
> If it is an issue for a device I would consider that a bug already needing a quirk in
> Baremetal/host kernel already. 
> From PCI spec " A prefetchable address range may have write side effects, 
> but it may not have read side effects."

Right, so we have made a small step in the direction of mapping
"prefetchable" onto "Normal_NC", thanks for that. What about all the
other properties (unaligned accesses, ordering, gathering)?

> > How do we translate this into something consistent? I'd like to see an actual
> > description of what we *really* expect from WC on prefetchable PCI regions,
> > turn that into a documented definition agreed across architectures, and then
> > we can look at implementing it with one memory type or another on arm64.
> > 
> > Because once we expose that memory type at S2 for KVM guests, it
> > becomes ABI and there is no turning back. So I want to get it right once and
> > for all.
> > 
> I agree that we need a precise definition for the Linux ioremap_wc
> API wrt what drivers (kernel and userspace) can expect and whether
> memset/memcpy is expected to work or not and whether aligned
> accesses are a requirement.
> To the extent ABI is set, I would think that the ABI is also already
> set in the host kernel for arm64 WC = Normal NC, so why should that
> not also be the ABI for same driver in VMs.

KVM is an implementation of the ARM architecture, and doesn't really
care about what WC is. If we come to the conclusion that Normal_NC is
the natural match for Prefetchable attributes, than we're good and we
can have Normal_NC being set by userspace, or even VFIO. But I don't
want to set it only because "it works when bare-metal Linux uses it".
Remember KVM doesn't only run Linux as guests.

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
