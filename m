Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2454274E30
	for <lists+kvmarm@lfdr.de>; Thu, 25 Jul 2019 14:33:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AAC244A5BE;
	Thu, 25 Jul 2019 08:33:52 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.202
X-Spam-Level: 
X-Spam-Status: No, score=-4.202 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5, SPF_HELO_PASS=-0.001]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZxwXsNwP0-Af; Thu, 25 Jul 2019 08:33:52 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6D31A4A5A0;
	Thu, 25 Jul 2019 08:33:51 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D01454A57D
 for <kvmarm@lists.cs.columbia.edu>; Thu, 25 Jul 2019 08:33:50 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K1iyPtt0yC9I for <kvmarm@lists.cs.columbia.edu>;
 Thu, 25 Jul 2019 08:33:49 -0400 (EDT)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 7C8844A57A
 for <kvmarm@lists.cs.columbia.edu>; Thu, 25 Jul 2019 08:33:49 -0400 (EDT)
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BB266330265;
 Thu, 25 Jul 2019 12:33:48 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 20C8160606;
 Thu, 25 Jul 2019 12:33:46 +0000 (UTC)
Date: Thu, 25 Jul 2019 14:33:44 +0200
From: Andrew Jones <drjones@redhat.com>
To: Alexander Graf <graf@amazon.com>
Subject: Re: [PATCH kvm-unit-tests v2] arm: Add PL031 test
Message-ID: <20190725123344.4lmeopzyl4jdnsp7@kamzik.brq.redhat.com>
References: <20190712091938.492-1-graf@amazon.com>
 <20190715164235.z2xar7nqi5guqfuf@kamzik.brq.redhat.com>
 <02a38777-3ec0-0354-8d49-d8ce337e5660@amazon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <02a38777-3ec0-0354-8d49-d8ce337e5660@amazon.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Thu, 25 Jul 2019 12:33:48 +0000 (UTC)
Cc: kvm@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
 Andre Przywara <andre.przywara@arm.com>, Paolo Bonzini <pbonzini@redhat.com>,
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

On Thu, Jul 25, 2019 at 02:12:19PM +0200, Alexander Graf wrote:
> 
> 
> On 15.07.19 18:42, Andrew Jones wrote:
> > On Fri, Jul 12, 2019 at 11:19:38AM +0200, Alexander Graf wrote:
> > > This patch adds a unit test for the PL031 RTC that is used in the virt machine.
> > > It just pokes basic functionality. I've mostly written it to familiarize myself
> > > with the device, but I suppose having the test around does not hurt, as it also
> > > exercises the GIC SPI interrupt path.
> > > 
> > > Signed-off-by: Alexander Graf <graf@amazon.com>
> > > 
> > > ---
> > > 
> > > v1 -> v2:
> > > 
> > >    - Use FDT to find base, irq and existence
> > >    - Put isb after timer read
> > >    - Use dist_base for gicv3
> > > ---
> > >   arm/Makefile.common |   1 +
> > >   arm/pl031.c         | 265 ++++++++++++++++++++++++++++++++++++++++++++
> > >   lib/arm/asm/gic.h   |   1 +
> > >   3 files changed, 267 insertions(+)
> > >   create mode 100644 arm/pl031.c
> > > 
> > > diff --git a/arm/Makefile.common b/arm/Makefile.common
> > > index f0c4b5d..b8988f2 100644
> > > --- a/arm/Makefile.common
> > > +++ b/arm/Makefile.common
> > > @@ -11,6 +11,7 @@ tests-common += $(TEST_DIR)/pmu.flat
> > >   tests-common += $(TEST_DIR)/gic.flat
> > >   tests-common += $(TEST_DIR)/psci.flat
> > >   tests-common += $(TEST_DIR)/sieve.flat
> > > +tests-common += $(TEST_DIR)/pl031.flat
> > 
> > Makefile.common is for both arm32 and arm64, but this code is only
> > compilable on arm64. As there's no reason for it to be arm64 only,
> > then ideally we'd modify the code to allow compiling and running
> > on both, but otherwise we need to move this to Makefile.arm64.
> 
> D'oh. Sorry, I completely missed that bit. Of course we want to test on
> 32bit ARM as well! I'll fix it up :).
> 
> 
> [...]
> 
> > > +static int rtc_fdt_init(void)
> > > +{
> > > +	const struct fdt_property *prop;
> > > +	const void *fdt = dt_fdt();
> > > +	int node, len;
> > > +	u32 *data;
> > > +
> > > +	node = fdt_node_offset_by_compatible(fdt, -1, "arm,pl031");
> > > +	if (node < 0)
> > > +		return -1;
> > > +
> > > +	prop = fdt_get_property(fdt, node, "interrupts", &len);
> > > +	assert(prop && len == (3 * sizeof(u32)));
> > > +	data = (u32 *)prop->data;
> > > +	assert(data[0] == 0); /* SPI */
> > > +	pl031_irq = SPI(fdt32_to_cpu(data[1]));
> > 
> > Nit: Ideally we'd add some more devicetree API to get interrupts. With
> > that, and the existing devicetree API, we could remove all low-level fdt
> > related code in this function.
> 
> Well, we probably want some really high level fdt API that can traverse reg
> properly to map bus regs into physical addresses. As long as we don't have
> all that magic,

We do have much of that magic already. Skim through lib/devicetree.h to
see what's available.

> I see little point in inventing anything that looks more
> sophisticated but doesn't actually take the difficult problems into account
> :).

Well, for this case, the "interrupts" decoding isn't difficult and could
be shared among other devices if we added it to devicetree.c. And the
reg decoding below to get the base address is already supported by the
devicetree API.

All that said, it's just a nit that I won't insist on though, because it's
hard enough to get unit test contributors without asking that they also
contribute to the framework.

> 
> > 
> > > +
> > > +	prop = fdt_get_property(fdt, node, "reg", &len);
> > > +	assert(prop && len == (2 * sizeof(u64)));
> > > +	data = (u32 *)prop->data;
> > > +	pl031 = (void*)((ulong)fdt32_to_cpu(data[0]) << 32 | fdt32_to_cpu(data[1]));
> > 
> > This works because we currently ID map all the physical memory. I usually
> > try to remember to use an ioremap in these cases anyway though.
> 
> Great idea - it allows me to get rid of a bit of casting too.
>

Thanks,
drew
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
