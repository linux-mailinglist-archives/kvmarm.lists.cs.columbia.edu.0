Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4843E5035
	for <lists+kvmarm@lfdr.de>; Tue, 10 Aug 2021 02:05:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 127034B0D2;
	Mon,  9 Aug 2021 20:05:01 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WhxoDRLYGNZm; Mon,  9 Aug 2021 20:05:00 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1B5364B0D7;
	Mon,  9 Aug 2021 20:04:57 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DD50E4B0C7
 for <kvmarm@lists.cs.columbia.edu>; Mon,  9 Aug 2021 20:04:55 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kA564ZfMlhfg for <kvmarm@lists.cs.columbia.edu>;
 Mon,  9 Aug 2021 20:04:51 -0400 (EDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com
 [209.85.167.51])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 6D354404F8
 for <kvmarm@lists.cs.columbia.edu>; Mon,  9 Aug 2021 20:04:51 -0400 (EDT)
Received: by mail-lf1-f51.google.com with SMTP id z20so476539lfd.2
 for <kvmarm@lists.cs.columbia.edu>; Mon, 09 Aug 2021 17:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tfgnvia9bhtFcWQg+6QIhSvfTwR0SecrlC0psAaPUJM=;
 b=YcoZnYHnJR0j6OfE2Q111pTfgMM2XYw5tZ1HXZlY9djjH7FBTqXN0tWuHbPIhhiaD3
 ylfUTDihwoeTQNTMsJDgQoq5TyD03kKOGO6bpgAFJWIzx3oz0Lp9C/WT7aW+m9lGISJh
 FdR7GEIAEoAvyNl1eUhRv1Vf4efcHMB9PIG2AOr4fZoAMgnF/5nGnzrGyPbMAqZuTGa5
 jFqZOAX9MzpNLR/SHw/pefvTaDhtxdvbcqRRdy4JsCGjTqoqMWt8Zm6lgxyrsaLZGFp5
 D9iPwPvsnEv8JtJDFFDe/vkPXGWWVyqSF06C7RVHdaUqQu5PRNkRb29ms5ECPa8E4V6f
 0EYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tfgnvia9bhtFcWQg+6QIhSvfTwR0SecrlC0psAaPUJM=;
 b=UhGu65tqYonxnLkj4yItDnWDCT1sePNgeBY9iPMm+E3rAScTud8ioL3XcsjkeTEFRl
 yTp4InNWWZ3RDQBsTcjlCAKu0m27MahoK6HPyOpzimqhUEr21UojZAHMuN5Hz87d4yg0
 0pmI42fEzU7yrdoOJJZCa1VKWR9WWYDDxxK3pUOn9nOuOWe7T6m1bCIUbrqG9TCSiZz9
 60GBiLXigUtJ0re4R8pGFr93n/XJq7yR2NvTzHUKqacx1lSEY4MHEiFVVdOQh7C9SkQv
 4O+KdUEK+RPC7A5ZBd+oKf89fprqjNWjq71RZpIFSyg89peHJY/4MAj7s1vmvvY1ugIt
 R1iA==
X-Gm-Message-State: AOAM533wdR4WcgtH3habwGASN0DLk2xciuHFsnnP8A5P5p+/LB0gwtWF
 3+HgnAxyvyiq7z+wR+0ByXvlTI4ng8WWfkOMQ3hn4A==
X-Google-Smtp-Source: ABdhPJxsIzr/4rGMJmdeT8OQd21bYuQu+LPC3VNK01JmxBPugVic9SDMpmYmwTnX1Zf01tRLm21WNr2mxSwUfxcra3g=
X-Received: by 2002:ac2:429a:: with SMTP id m26mr19513903lfh.80.1628553889715; 
 Mon, 09 Aug 2021 17:04:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210804085819.846610-1-oupton@google.com>
 <CAOQ_QsiVNS==c-ahnKN6Jja_+FfkWEmDnQPoP9sdNWBc1m2gsg@mail.gmail.com>
 <CAOQ_Qsh9wzP301xdfbwBcFXHBoYkf9PCY-+mrfmfwVWL4UexGw@mail.gmail.com>
In-Reply-To: <CAOQ_Qsh9wzP301xdfbwBcFXHBoYkf9PCY-+mrfmfwVWL4UexGw@mail.gmail.com>
From: Oliver Upton <oupton@google.com>
Date: Mon, 9 Aug 2021 17:04:38 -0700
Message-ID: <CAOQ_QsgkB32rgfr7=X8XNyXe2Vw3arFjo6umvgDfTLQgjU4i2A@mail.gmail.com>
Subject: Re: [PATCH v6 00/21] KVM: Add idempotent controls for migrating
 system counter state
To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Raghavendra Rao Anata <rananta@google.com>,
 Peter Shier <pshier@google.com>, Sean Christopherson <seanjc@google.com>,
 David Matlack <dmatlack@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 linux-arm-kernel@lists.infradead.org, Jim Mattson <jmattson@google.com>
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

On Wed, Aug 4, 2021 at 3:03 PM Oliver Upton <oupton@google.com> wrote:
>
> On Wed, Aug 4, 2021 at 4:05 AM Oliver Upton <oupton@google.com> wrote:
> >
> > On Wed, Aug 4, 2021 at 1:58 AM Oliver Upton <oupton@google.com> wrote:
> > >
> > > KVM's current means of saving/restoring system counters is plagued with
> > > temporal issues. At least on ARM64 and x86, we migrate the guest's
> > > system counter by-value through the respective guest system register
> > > values (cntvct_el0, ia32_tsc). Restoring system counters by-value is
> > > brittle as the state is not idempotent: the host system counter is still
> > > oscillating between the attempted save and restore. Furthermore, VMMs
> > > may wish to transparently live migrate guest VMs, meaning that they
> > > include the elapsed time due to live migration blackout in the guest
> > > system counter view. The VMM thread could be preempted for any number of
> > > reasons (scheduler, L0 hypervisor under nested) between the time that
> > > it calculates the desired guest counter value and when KVM actually sets
> > > this counter state.
> > >
> > > Despite the value-based interface that we present to userspace, KVM
> > > actually has idempotent guest controls by way of system counter offsets.
> > > We can avoid all of the issues associated with a value-based interface
> > > by abstracting these offset controls in new ioctls. This series
> > > introduces new vCPU device attributes to provide userspace access to the
> > > vCPU's system counter offset.
> > >
> > > Patch 1 addresses a possible race in KVM_GET_CLOCK where
> > > use_master_clock is read outside of the pvclock_gtod_sync_lock.
> > >
> > > Patch 2 adopts Paolo's suggestion, augmenting the KVM_{GET,SET}_CLOCK
> > > ioctls to provide userspace with a (host_tsc, realtime) instant. This is
> > > essential for a VMM to perform precise migration of the guest's system
> > > counters.
> > >
> > > Patches 3-4 are some preparatory changes for exposing the TSC offset to
> > > userspace. Patch 5 provides a vCPU attribute to provide userspace access
> > > to the TSC offset.
> > >
> > > Patches 6-7 implement a test for the new additions to
> > > KVM_{GET,SET}_CLOCK.
> > >
> > > Patch 8 fixes some assertions in the kvm device attribute helpers.
> > >
> > > Patches 9-10 implement at test for the tsc offset attribute introduced in
> > > patch 5.

Paolo,

Is there anything else you're waiting to see for the x86 portion of
this series after addressing Sean's comments? There's some work
remaining on the arm64 side, though I believe the two architectures
are now disjoint for this series.

--
Thanks,
Oliver

> > > Patches 11-12 lay the groundwork for patch 13, which exposes CNTVOFF_EL2
> > > through the ONE_REG interface.
> > >
> > > Patches 14-15 add test cases for userspace manipulation of the virtual
> > > counter-timer.
> > >
> > > Patches 16-17 add a vCPU attribute to adjust the host-guest offset of an
> > > ARM vCPU, but only implements support for ECV hosts. Patches 18-19 add
> > > support for non-ECV hosts by emulating physical counter offsetting.
> > >
> > > Patch 20 adds test cases for adjusting the host-guest offset, and
> > > finally patch 21 adds a test to measure the emulation overhead of
> > > CNTPCT_EL2.
> > >
> > > This series was tested on both an Ampere Mt. Jade and Haswell systems.
> > > Unfortunately, the ECV portions of this series are untested, as there is
> > > no ECV-capable hardware and the ARM fast models only partially implement
> > > ECV.
> >
> > Small correction: I was only using the foundation model. Apparently
> > the AEM FVP provides full ECV support.
>
> Ok. I've now tested this series on the FVP Base RevC fast model@v8.6 +
> ECV=2. Passes on VHE, fails on nVHE.
>
> I'll respin this series with the fix for nVHE+ECV soon.
>
> --
> Thanks,
> Oliver
>
> >
> > >
> > > Physical counter benchmark
> > > --------------------------
> > >
> > > The following data was collected by running 10000 iterations of the
> > > benchmark test from Patch 21 on an Ampere Mt. Jade reference server, A 2S
> > > machine with 2 80-core Ampere Altra SoCs. Measurements were collected
> > > for both VHE and nVHE operation using the `kvm-arm.mode=` command-line
> > > parameter.
> > >
> > > nVHE
> > > ----
> > >
> > > +--------------------+--------+---------+
> > > |       Metric       | Native | Trapped |
> > > +--------------------+--------+---------+
> > > | Average            | 54ns   | 148ns   |
> > > | Standard Deviation | 124ns  | 122ns   |
> > > | 95th Percentile    | 258ns  | 348ns   |
> > > +--------------------+--------+---------+
> > >
> > > VHE
> > > ---
> > >
> > > +--------------------+--------+---------+
> > > |       Metric       | Native | Trapped |
> > > +--------------------+--------+---------+
> > > | Average            | 53ns   | 152ns   |
> > > | Standard Deviation | 92ns   | 94ns    |
> > > | 95th Percentile    | 204ns  | 307ns   |
> > > +--------------------+--------+---------+
> > >
> > > This series applies cleanly to kvm/queue at the following commit:
> > >
> > > 6cd974485e25 ("KVM: selftests: Add a test of an unbacked nested PI descriptor")
> > >
> > > v1 -> v2:
> > >   - Reimplemented as vCPU device attributes instead of a distinct ioctl.
> > >   - Added the (realtime, host_tsc) instant support to KVM_{GET,SET}_CLOCK
> > >   - Changed the arm64 implementation to broadcast counter
> > >     offset values to all vCPUs in a guest. This upholds the
> > >     architectural expectations of a consistent counter-timer across CPUs.
> > >   - Fixed a bug with traps in VHE mode. We now configure traps on every
> > >     transition into a guest to handle differing VMs (trapped, emulated).
> > >
> > > v2 -> v3:
> > >   - Added documentation for additions to KVM_{GET,SET}_CLOCK
> > >   - Added documentation for all new vCPU attributes
> > >   - Added documentation for suggested algorithm to migrate a guest's
> > >     TSC(s)
> > >   - Bug fixes throughout series
> > >   - Rename KVM_CLOCK_REAL_TIME -> KVM_CLOCK_REALTIME
> > >
> > > v3 -> v4:
> > >   - Added patch to address incorrect device helper assertions (Drew)
> > >   - Carried Drew's r-b tags where appropriate
> > >   - x86 selftest cleanup
> > >   - Removed stale kvm_timer_init_vhe() function
> > >   - Removed unnecessary GUEST_DONE() from selftests
> > >
> > > v4 -> v5:
> > >   - Fix typo in TSC migration algorithm
> > >   - Carry more of Drew's r-b tags
> > >   - clean up run loop logic in counter emulation benchmark (missed from
> > >     Drew's comments on v3)
> > >
> > > v5 -> v6:
> > >   - Add fix for race in KVM_GET_CLOCK (Sean)
> > >   - Fix 32-bit build issues in series + use of uninitialized host tsc
> > >     value (Sean)
> > >   - General style cleanups
> > >   - Rework ARM virtual counter offsetting to match guest behavior. Use
> > >     the ONE_REG interface instead of a VM attribute (Marc)
> > >   - Maintain a single host-guest counter offset, which applies to both
> > >     physical and virtual counters
> > >   - Dropped some of Drew's r-b tags due to nontrivial patch changes
> > >     (sorry for the churn!)
> > >
> > > v1: https://lore.kernel.org/kvm/20210608214742.1897483-1-oupton@google.com/
> > > v2: https://lore.kernel.org/r/20210716212629.2232756-1-oupton@google.com
> > > v3: https://lore.kernel.org/r/20210719184949.1385910-1-oupton@google.com
> > > v4: https://lore.kernel.org/r/20210729001012.70394-1-oupton@google.com
> > > v5: https://lore.kernel.org/r/20210729173300.181775-1-oupton@google.com
> > >
> > > Oliver Upton (21):
> > >   KVM: x86: Fix potential race in KVM_GET_CLOCK
> > >   KVM: x86: Report host tsc and realtime values in KVM_GET_CLOCK
> > >   KVM: x86: Take the pvclock sync lock behind the tsc_write_lock
> > >   KVM: x86: Refactor tsc synchronization code
> > >   KVM: x86: Expose TSC offset controls to userspace
> > >   tools: arch: x86: pull in pvclock headers
> > >   selftests: KVM: Add test for KVM_{GET,SET}_CLOCK
> > >   selftests: KVM: Fix kvm device helper ioctl assertions
> > >   selftests: KVM: Add helpers for vCPU device attributes
> > >   selftests: KVM: Introduce system counter offset test
> > >   KVM: arm64: Refactor update_vtimer_cntvoff()
> > >   KVM: arm64: Separate guest/host counter offset values
> > >   KVM: arm64: Allow userspace to configure a vCPU's virtual offset
> > >   selftests: KVM: Add helper to check for register presence
> > >   selftests: KVM: Add support for aarch64 to system_counter_offset_test
> > >   arm64: cpufeature: Enumerate support for Enhanced Counter
> > >     Virtualization
> > >   KVM: arm64: Allow userspace to configure a guest's counter-timer
> > >     offset
> > >   KVM: arm64: Configure timer traps in vcpu_load() for VHE
> > >   KVM: arm64: Emulate physical counter offsetting on non-ECV systems
> > >   selftests: KVM: Test physical counter offsetting
> > >   selftests: KVM: Add counter emulation benchmark
> > >
> > >  Documentation/virt/kvm/api.rst                |  52 ++-
> > >  Documentation/virt/kvm/devices/vcpu.rst       |  85 ++++
> > >  Documentation/virt/kvm/locking.rst            |  11 +
> > >  arch/arm64/include/asm/kvm_asm.h              |   2 +
> > >  arch/arm64/include/asm/sysreg.h               |   5 +
> > >  arch/arm64/include/uapi/asm/kvm.h             |   2 +
> > >  arch/arm64/kernel/cpufeature.c                |  10 +
> > >  arch/arm64/kvm/arch_timer.c                   | 224 ++++++++++-
> > >  arch/arm64/kvm/arm.c                          |   4 +-
> > >  arch/arm64/kvm/guest.c                        |   6 +-
> > >  arch/arm64/kvm/hyp/include/hyp/switch.h       |  29 ++
> > >  arch/arm64/kvm/hyp/nvhe/hyp-main.c            |   6 +
> > >  arch/arm64/kvm/hyp/nvhe/timer-sr.c            |  16 +-
> > >  arch/arm64/kvm/hyp/vhe/timer-sr.c             |   5 +
> > >  arch/arm64/tools/cpucaps                      |   1 +
> > >  arch/x86/include/asm/kvm_host.h               |   4 +
> > >  arch/x86/include/uapi/asm/kvm.h               |   4 +
> > >  arch/x86/kvm/x86.c                            | 364 +++++++++++++-----
> > >  include/clocksource/arm_arch_timer.h          |   1 +
> > >  include/kvm/arm_arch_timer.h                  |   6 +-
> > >  include/uapi/linux/kvm.h                      |   7 +-
> > >  tools/arch/x86/include/asm/pvclock-abi.h      |  48 +++
> > >  tools/arch/x86/include/asm/pvclock.h          | 103 +++++
> > >  tools/testing/selftests/kvm/.gitignore        |   3 +
> > >  tools/testing/selftests/kvm/Makefile          |   4 +
> > >  .../kvm/aarch64/counter_emulation_benchmark.c | 207 ++++++++++
> > >  .../selftests/kvm/include/aarch64/processor.h |  24 ++
> > >  .../testing/selftests/kvm/include/kvm_util.h  |  13 +
> > >  tools/testing/selftests/kvm/lib/kvm_util.c    |  63 ++-
> > >  .../kvm/system_counter_offset_test.c          | 211 ++++++++++
> > >  .../selftests/kvm/x86_64/kvm_clock_test.c     | 204 ++++++++++
> > >  31 files changed, 1581 insertions(+), 143 deletions(-)
> > >  create mode 100644 tools/arch/x86/include/asm/pvclock-abi.h
> > >  create mode 100644 tools/arch/x86/include/asm/pvclock.h
> > >  create mode 100644 tools/testing/selftests/kvm/aarch64/counter_emulation_benchmark.c
> > >  create mode 100644 tools/testing/selftests/kvm/system_counter_offset_test.c
> > >  create mode 100644 tools/testing/selftests/kvm/x86_64/kvm_clock_test.c
> > >
> > > --
> > > 2.32.0.605.g8dce9f2422-goog
> > >
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
