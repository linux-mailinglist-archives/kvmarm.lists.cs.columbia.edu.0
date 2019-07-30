Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 02EA37AED9
	for <lists+kvmarm@lfdr.de>; Tue, 30 Jul 2019 19:04:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6925E4A557;
	Tue, 30 Jul 2019 13:04:18 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id izyGvIsaxXLF; Tue, 30 Jul 2019 13:04:18 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E5F294A558;
	Tue, 30 Jul 2019 13:04:16 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 903DF4A54D
 for <kvmarm@lists.cs.columbia.edu>; Tue, 30 Jul 2019 13:04:16 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uNfO19GQUb9D for <kvmarm@lists.cs.columbia.edu>;
 Tue, 30 Jul 2019 13:04:14 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CF1384A51F
 for <kvmarm@lists.cs.columbia.edu>; Tue, 30 Jul 2019 13:04:14 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52C48344;
 Tue, 30 Jul 2019 10:04:14 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9EC923F694;
 Tue, 30 Jul 2019 10:04:12 -0700 (PDT)
Date: Tue, 30 Jul 2019 18:04:07 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v3 00/10] KVM: arm/arm64: vgic: ITS translation cache
Message-ID: <20190730180407.21a9d81a@donnerap.cambridge.arm.com>
In-Reply-To: <20190725153543.24386-1-maz@kernel.org>
References: <20190725153543.24386-1-maz@kernel.org>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>, "Raslan,
 KarimAllah" <karahmed@amazon.de>, "Saidi, 
 Ali" <alisaidi@amazon.com>, linux-arm-kernel@lists.infradead.org,
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

On Thu, 25 Jul 2019 16:35:33 +0100
Marc Zyngier <maz@kernel.org> wrote:

Hi,

> From: Marc Zyngier <marc.zyngier@arm.com>
> 
> It recently became apparent[1] that our LPI injection path is not as
> efficient as it could be when injecting interrupts coming from a VFIO
> assigned device.
> 
> Although the proposed patch wasn't 100% correct, it outlined at least
> two issues:
> 
> (1) Injecting an LPI from VFIO always results in a context switch to a
>     worker thread: no good
> 
> (2) We have no way of amortising the cost of translating a DID+EID pair
>     to an LPI number
> 
> The reason for (1) is that we may sleep when translating an LPI, so we
> do need a context process. A way to fix that is to implement a small
> LPI translation cache that could be looked up from an atomic
> context. It would also solve (2).
> 
> This is what this small series proposes. It implements a very basic
> LRU cache of pre-translated LPIs, which gets used to implement
> kvm_arch_set_irq_inatomic. The size of the cache is currently
> hard-coded at 16 times the number of vcpus, a number I have picked
> under the influence of Ali Saidi. If that's not enough for you, blame
> me, though.
> 
> Does it work? well, it doesn't crash, and is thus perfect. More
> seriously, I don't really have a way to benchmark it directly, so my
> observations are only indirect:
> 
> On a TX2 system, I run a 4 vcpu VM with an Ethernet interface passed
> to it directly. From the host, I inject interrupts using debugfs. In
> parallel, I look at the number of context switch, and the number of
> interrupts on the host. Without this series, I get the same number for
> both IRQ and CS (about half a million of each per second is pretty
> easy to reach). With this series, the number of context switches drops
> to something pretty small (in the low 2k), while the number of
> interrupts stays the same.
> 
> Yes, this is a pretty rubbish benchmark, what did you expect? ;-)
> 
> Andre did run some benchmarks of his own, with some rather positive
> results[2]. So I'm putting this out for people with real workloads to
> try out and report what they see.

And I gave this series a try, on top of 5.3-rc2, with Robin's patch [3] to
fix a VFIO IRQ breakage.
The results were very similar, though at least one performance number was
slightly worse than compared to this series on top of v5.2.
But nevertheless there is still the big improvement compared to the
baseline without this series, so:

(for the whole series):
Tested-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre.

[3] http://lists.infradead.org/pipermail/linux-arm-kernel/2019-July/669468.html

> [1] https://lore.kernel.org/lkml/1552833373-19828-1-git-send-email-yuzenghui@huawei.com/
> [2] https://www.spinics.net/lists/arm-kernel/msg742655.html
> 
> * From v2:
> 
>   - Added invalidation on turning the ITS off
>   - Added invalidation on MAPC with V=0
>   - Added Rb's from Eric
> 
> * From v1:
> 
>   - Fixed race on allocation, where the same LPI could be cached multiple times
>   - Now invalidate the cache on vgic teardown, avoiding memory leaks
>   - Change patch split slightly, general reshuffling
>   - Small cleanups here and there
>   - Rebased on 5.2-rc4
> 
> Marc Zyngier (10):
>   KVM: arm/arm64: vgic: Add LPI translation cache definition
>   KVM: arm/arm64: vgic: Add __vgic_put_lpi_locked primitive
>   KVM: arm/arm64: vgic-its: Add MSI-LPI translation cache invalidation
>   KVM: arm/arm64: vgic-its: Invalidate MSI-LPI translation cache on
>     specific commands
>   KVM: arm/arm64: vgic-its: Invalidate MSI-LPI translation cache on
>     disabling LPIs
>   KVM: arm/arm64: vgic-its: Invalidate MSI-LPI translation cache on ITS
>     disable
>   KVM: arm/arm64: vgic-its: Invalidate MSI-LPI translation cache on vgic
>     teardown
>   KVM: arm/arm64: vgic-its: Cache successful MSI->LPI translation
>   KVM: arm/arm64: vgic-its: Check the LPI translation cache on MSI
>     injection
>   KVM: arm/arm64: vgic-irqfd: Implement kvm_arch_set_irq_inatomic
> 
>  include/kvm/arm_vgic.h           |   3 +
>  virt/kvm/arm/vgic/vgic-init.c    |   5 +
>  virt/kvm/arm/vgic/vgic-irqfd.c   |  36 +++++-
>  virt/kvm/arm/vgic/vgic-its.c     | 207 +++++++++++++++++++++++++++++++
>  virt/kvm/arm/vgic/vgic-mmio-v3.c |   4 +-
>  virt/kvm/arm/vgic/vgic.c         |  26 ++--
>  virt/kvm/arm/vgic/vgic.h         |   5 +
>  7 files changed, 270 insertions(+), 16 deletions(-)
> 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
