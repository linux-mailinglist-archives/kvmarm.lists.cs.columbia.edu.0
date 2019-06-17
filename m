Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id EB87B487A1
	for <lists+kvmarm@lfdr.de>; Mon, 17 Jun 2019 17:43:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 46AC74A51B;
	Mon, 17 Jun 2019 11:43:18 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XBFY+txc0RVZ; Mon, 17 Jun 2019 11:43:18 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D6FF04A512;
	Mon, 17 Jun 2019 11:43:16 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D69E44A50C
 for <kvmarm@lists.cs.columbia.edu>; Mon, 17 Jun 2019 11:43:15 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h1gQLt8RIxfo for <kvmarm@lists.cs.columbia.edu>;
 Mon, 17 Jun 2019 11:43:14 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6E88E4A47A
 for <kvmarm@lists.cs.columbia.edu>; Mon, 17 Jun 2019 11:43:14 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA9DF28;
 Mon, 17 Jun 2019 08:43:13 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B8813F718;
 Mon, 17 Jun 2019 08:43:13 -0700 (PDT)
Date: Mon, 17 Jun 2019 16:43:11 +0100
From: Andrew Murray <andrew.murray@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH v9 4/5] KVM: arm/arm64: remove pmc->bitmask
Message-ID: <20190617154311.GM20984@e119886-lin.cambridge.arm.com>
References: <20190612190450.7085-1-andrew.murray@arm.com>
 <20190612190450.7085-5-andrew.murray@arm.com>
 <6a8e4fdd-d8cf-f3fb-55cd-2d06805b0eb9@arm.com>
 <20190613093957.GG49779@e119886-lin.cambridge.arm.com>
 <5e18d747-1d82-8eed-ef1c-de86c5b3a7e7@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5e18d747-1d82-8eed-ef1c-de86c5b3a7e7@arm.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Cc: marc.zyngier@arm.com, kvmarm@lists.cs.columbia.edu,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On Thu, Jun 13, 2019 at 05:50:43PM +0100, Suzuki K Poulose wrote:
> 
> 
> On 13/06/2019 10:39, Andrew Murray wrote:
> > On Thu, Jun 13, 2019 at 08:30:51AM +0100, Julien Thierry wrote:
> > > Hi Andrew,
> > > 
> > > On 12/06/2019 20:04, Andrew Murray wrote:
> > > > We currently use pmc->bitmask to determine the width of the pmc - however
> > > > it's superfluous as the pmc index already describes if the pmc is a cycle
> > > > counter or event counter. The architecture clearly describes the widths of
> > > > these counters.
> > > > 
> > > > Let's remove the bitmask to simplify the code.
> > > > 
> > > > Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> > > > ---
> > > >   include/kvm/arm_pmu.h |  1 -
> > > >   virt/kvm/arm/pmu.c    | 19 +++++++++----------
> > > >   2 files changed, 9 insertions(+), 11 deletions(-)
> > > > 
> > > > diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
> > > > index b73f31baca52..2f0e28dc5a9e 100644
> > > > --- a/include/kvm/arm_pmu.h
> > > > +++ b/include/kvm/arm_pmu.h
> > > > @@ -28,7 +28,6 @@
> > > >   struct kvm_pmc {
> > > >   	u8 idx;	/* index into the pmu->pmc array */
> > > >   	struct perf_event *perf_event;
> > > > -	u64 bitmask;
> > > >   };
> > > >   struct kvm_pmu {
> > > > diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
> > > > index ae1e886d4a1a..88ce24ae0b45 100644
> > > > --- a/virt/kvm/arm/pmu.c
> > > > +++ b/virt/kvm/arm/pmu.c
> > > > @@ -47,7 +47,10 @@ u64 kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu, u64 select_idx)
> > > >   		counter += perf_event_read_value(pmc->perf_event, &enabled,
> > > >   						 &running);
> > > > -	return counter & pmc->bitmask;
> > > > +	if (select_idx != ARMV8_PMU_CYCLE_IDX)
> > > > +		counter = lower_32_bits(counter);
> > > 
> > > Shouldn't this depend on PMCR.LC as well? If PMCR.LC is clear we only
> > > want the lower 32bits of the cycle counter.
> > 
> > Yes that's correct. The hunk should look like this:
> > 
> > -       return counter & pmc->bitmask;
> > +       if (!(select_idx == ARMV8_PMU_CYCLE_IDX &&
> > +             __vcpu_sys_reg(vcpu, PMCR_EL0) & ARMV8_PMU_PMCR_LC))
> > +               counter = lower_32_bits(counter);
> > +
> > +       return counter;
> 
> May be you could add a macro :
> 
> #define vcpu_pmu_counter_is_64bit(vcpu, idx) ?

Yes I think a helper would be useful - though I'd prefer the name
'kvm_pmu_idx_is_long_cycle_counter'. This seems a little clearer as
you could otherwise argue that a chained counter is also 64 bits.

Thanks,

Andrew Murray


> 
> Cheers
> Suzuki
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
