Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 614DD3E59F0
	for <lists+kvmarm@lfdr.de>; Tue, 10 Aug 2021 14:31:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BAA7D4A4E5;
	Tue, 10 Aug 2021 08:31:01 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pB1WJDu7zalA; Tue, 10 Aug 2021 08:31:01 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D19504A3A3;
	Tue, 10 Aug 2021 08:30:57 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4361640CC5
 for <kvmarm@lists.cs.columbia.edu>; Tue, 10 Aug 2021 08:30:56 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TbrWyMEgK7yi for <kvmarm@lists.cs.columbia.edu>;
 Tue, 10 Aug 2021 08:30:55 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 1EFCF407ED
 for <kvmarm@lists.cs.columbia.edu>; Tue, 10 Aug 2021 08:30:55 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 05FEA60F56;
 Tue, 10 Aug 2021 12:30:54 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1mDQuC-0043Ku-4Q; Tue, 10 Aug 2021 13:30:52 +0100
Date: Tue, 10 Aug 2021 13:30:51 +0100
Message-ID: <877dgtbhxg.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v6 00/21] KVM: Add idempotent controls for migrating
 system counter state
In-Reply-To: <CAOQ_QsgkB32rgfr7=X8XNyXe2Vw3arFjo6umvgDfTLQgjU4i2A@mail.gmail.com>
References: <20210804085819.846610-1-oupton@google.com>
 <CAOQ_QsiVNS==c-ahnKN6Jja_+FfkWEmDnQPoP9sdNWBc1m2gsg@mail.gmail.com>
 <CAOQ_Qsh9wzP301xdfbwBcFXHBoYkf9PCY-+mrfmfwVWL4UexGw@mail.gmail.com>
 <CAOQ_QsgkB32rgfr7=X8XNyXe2Vw3arFjo6umvgDfTLQgjU4i2A@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: oupton@google.com, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, pbonzini@redhat.com, seanjc@google.com,
 pshier@google.com, jmattson@google.com, dmatlack@google.com,
 ricarkol@google.com, jingzhangos@google.com, rananta@google.com,
 james.morse@arm.com, Alexandru.Elisei@arm.com, suzuki.poulose@arm.com,
 linux-arm-kernel@lists.infradead.org, drjones@redhat.com, will@kernel.org,
 catalin.marinas@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Catalin Marinas <catalin.marinas@arm.com>, kvm@vger.kernel.org,
 Will Deacon <will@kernel.org>, Sean Christopherson <seanjc@google.com>,
 Peter Shier <pshier@google.com>, Raghavendra Rao Anata <rananta@google.com>,
 David Matlack <dmatlack@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 Jim Mattson <jmattson@google.com>
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

On Tue, 10 Aug 2021 01:04:38 +0100,
Oliver Upton <oupton@google.com> wrote:
> 
> On Wed, Aug 4, 2021 at 3:03 PM Oliver Upton <oupton@google.com> wrote:
> >
> > On Wed, Aug 4, 2021 at 4:05 AM Oliver Upton <oupton@google.com> wrote:
> > >
> > > On Wed, Aug 4, 2021 at 1:58 AM Oliver Upton <oupton@google.com> wrote:
> > > >
> > > > KVM's current means of saving/restoring system counters is plagued with
> > > > temporal issues. At least on ARM64 and x86, we migrate the guest's
> > > > system counter by-value through the respective guest system register
> > > > values (cntvct_el0, ia32_tsc). Restoring system counters by-value is
> > > > brittle as the state is not idempotent: the host system counter is still
> > > > oscillating between the attempted save and restore. Furthermore, VMMs
> > > > may wish to transparently live migrate guest VMs, meaning that they
> > > > include the elapsed time due to live migration blackout in the guest
> > > > system counter view. The VMM thread could be preempted for any number of
> > > > reasons (scheduler, L0 hypervisor under nested) between the time that
> > > > it calculates the desired guest counter value and when KVM actually sets
> > > > this counter state.
> > > >
> > > > Despite the value-based interface that we present to userspace, KVM
> > > > actually has idempotent guest controls by way of system counter offsets.
> > > > We can avoid all of the issues associated with a value-based interface
> > > > by abstracting these offset controls in new ioctls. This series
> > > > introduces new vCPU device attributes to provide userspace access to the
> > > > vCPU's system counter offset.
> > > >
> > > > Patch 1 addresses a possible race in KVM_GET_CLOCK where
> > > > use_master_clock is read outside of the pvclock_gtod_sync_lock.
> > > >
> > > > Patch 2 adopts Paolo's suggestion, augmenting the KVM_{GET,SET}_CLOCK
> > > > ioctls to provide userspace with a (host_tsc, realtime) instant. This is
> > > > essential for a VMM to perform precise migration of the guest's system
> > > > counters.
> > > >
> > > > Patches 3-4 are some preparatory changes for exposing the TSC offset to
> > > > userspace. Patch 5 provides a vCPU attribute to provide userspace access
> > > > to the TSC offset.
> > > >
> > > > Patches 6-7 implement a test for the new additions to
> > > > KVM_{GET,SET}_CLOCK.
> > > >
> > > > Patch 8 fixes some assertions in the kvm device attribute helpers.
> > > >
> > > > Patches 9-10 implement at test for the tsc offset attribute introduced in
> > > > patch 5.
> 
> Paolo,
> 
> Is there anything else you're waiting to see for the x86 portion of
> this series after addressing Sean's comments? There's some work
> remaining on the arm64 side, though I believe the two architectures
> are now disjoint for this series.

I think at this stage it would make sense to split the series in two
and drive them independently.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
