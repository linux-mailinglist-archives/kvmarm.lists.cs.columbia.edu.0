Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 73A60F388
	for <lists+kvmarm@lfdr.de>; Tue, 30 Apr 2019 11:54:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0301B4A4EB;
	Tue, 30 Apr 2019 05:54:58 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hssn7ZtMH0iB; Tue, 30 Apr 2019 05:54:57 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 892E94A4DF;
	Tue, 30 Apr 2019 05:54:56 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 127D94A4C5
 for <kvmarm@lists.cs.columbia.edu>; Tue, 30 Apr 2019 05:54:55 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Hqfcq1TjZAj1 for <kvmarm@lists.cs.columbia.edu>;
 Tue, 30 Apr 2019 05:54:53 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9C2DC4A4A4
 for <kvmarm@lists.cs.columbia.edu>; Tue, 30 Apr 2019 05:54:53 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0429380D;
 Tue, 30 Apr 2019 02:54:53 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8FC7B3F5C1;
 Tue, 30 Apr 2019 02:54:52 -0700 (PDT)
Date: Tue, 30 Apr 2019 10:54:50 +0100
From: Andrew Murray <andrew.murray@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH v13 6/8] arm64: KVM: Enable VHE support for :G/:H perf
 event modifiers
Message-ID: <20190430095450.GF22493@e119886-lin.cambridge.arm.com>
References: <20190409192217.23459-1-andrew.murray@arm.com>
 <20190409192217.23459-7-andrew.murray@arm.com>
 <2bbd0c72-3f51-f942-d6a2-478db940445f@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2bbd0c72-3f51-f942-d6a2-478db940445f@arm.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Cc: marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

On Mon, Apr 15, 2019 at 02:43:36PM +0100, Suzuki K Poulose wrote:
> 
> 
> On 09/04/2019 20:22, Andrew Murray wrote:
> > With VHE different exception levels are used between the host (EL2) and
> > guest (EL1) with a shared exception level for userpace (EL0). We can take
> > advantage of this and use the PMU's exception level filtering to avoid
> > enabling/disabling counters in the world-switch code. Instead we just
> 
> s/Instead// ?
> 
> > modify the counter type to include or exclude EL0 at vcpu_{load,put} time.
> 
> 
> > 
> > We also ensure that trapped PMU system register writes do not re-enable
> > EL0 when reconfiguring the backing perf events.
> > 
> > This approach completely avoids blackout windows seen with !VHE.
> > 
> > Suggested-by: Christoffer Dall <christoffer.dall@arm.com>
> > Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> > Acked-by: Will Deacon <will.deacon@arm.com>
> 
> ....
> 
> > +/*
> > + * On VHE ensure that only guest events have EL0 counting enabled
> > + */
> > +void kvm_vcpu_pmu_restore_guest(struct kvm_vcpu *vcpu)
> > +{
> > +	struct kvm_cpu_context *host_ctxt;
> > +	struct kvm_host_data *host;
> > +	u32 events_guest, events_host;
> > +
> > +	if (!has_vhe())
> > +		return;
> > +
> > +	host_ctxt = vcpu->arch.host_cpu_context;
> > +	host = container_of(host_ctxt, struct kvm_host_data, host_ctxt);
> > +	events_guest = host->pmu_events.events_guest;
> > +	events_host = host->pmu_events.events_host;
> > +
> > +	kvm_vcpu_pmu_enable_el0(events_guest);
> > +	kvm_vcpu_pmu_disable_el0(events_host);
> > +}
> > +
> > +/*
> > + * On VHE ensure that only guest host have EL0 counting enabled
> 
> nit: s/guest/host/host events/
> 
> > + */
> > +void kvm_vcpu_pmu_restore_host(struct kvm_vcpu *vcpu)
> > +{
> > +	struct kvm_cpu_context *host_ctxt;
> > +	struct kvm_host_data *host;
> > +	u32 events_guest, events_host;
> > +
> > +	if (!has_vhe())
> > +		return;
> > +
> > +	host_ctxt = vcpu->arch.host_cpu_context;
> > +	host = container_of(host_ctxt, struct kvm_host_data, host_ctxt);
> > +	events_guest = host->pmu_events.events_guest;
> > +	events_host = host->pmu_events.events_host;
> > +
> > +	kvm_vcpu_pmu_enable_el0(events_host);
> > +	kvm_vcpu_pmu_disable_el0(events_guest);
> > +}
> > diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> > index 539feecda5b8..c7fa47ad2387 100644
> > --- a/arch/arm64/kvm/sys_regs.c
> > +++ b/arch/arm64/kvm/sys_regs.c
> > @@ -695,6 +695,7 @@ static bool access_pmcr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
> >   		val |= p->regval & ARMV8_PMU_PMCR_MASK;
> >   		__vcpu_sys_reg(vcpu, PMCR_EL0) = val;
> >   		kvm_pmu_handle_pmcr(vcpu, val);
> > +		kvm_vcpu_pmu_restore_guest(vcpu);
> 
> nit: I am not sure if we need to do this for PMCR accesses ? Unless
> we have modified some changes to the events (e.g, like the two instances
> below). Or am I missing something here ?

Thanks for the review.

The reason is that PMCR, via the E bit, can lead to kvm_pmu_handle_pmcr
calling kvm_pmu_enable_counter and perf_event_enable. If I recall correctly,
perf_event_enable could lead to armv8pmu_enable_event which may rewrite
config_base. However in this context (trap) we stay in the guest and may
not call kvm_vcpu_pmu_restore_{guest,host} for a while - thus the EL0 enable
bits of the underlying event may be incorrect (for example when exclude_host
is set we exclude EL0 from config_base - however as we are in the guest we
need it to be included!).

Thanks,

Andrew Murray

> 
> Otherwise:
> 
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
