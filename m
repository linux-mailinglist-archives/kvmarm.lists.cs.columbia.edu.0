Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 97BF73DAA40
	for <lists+kvmarm@lfdr.de>; Thu, 29 Jul 2021 19:33:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EB5544B105;
	Thu, 29 Jul 2021 13:33:08 -0400 (EDT)
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
	with ESMTP id xhxXicLqEghl; Thu, 29 Jul 2021 13:33:08 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A04784A023;
	Thu, 29 Jul 2021 13:33:07 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D64B84A4A0
 for <kvmarm@lists.cs.columbia.edu>; Thu, 29 Jul 2021 13:33:05 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ORxzIzaelp0q for <kvmarm@lists.cs.columbia.edu>;
 Thu, 29 Jul 2021 13:33:04 -0400 (EDT)
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com
 [209.85.219.201])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 5FFD34031F
 for <kvmarm@lists.cs.columbia.edu>; Thu, 29 Jul 2021 13:33:04 -0400 (EDT)
Received: by mail-yb1-f201.google.com with SMTP id
 f3-20020a25cf030000b029055a2303fc2dso7448038ybg.11
 for <kvmarm@lists.cs.columbia.edu>; Thu, 29 Jul 2021 10:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=0HZDrxCyGrVeJfmBDe1FADDB470ehjEc3z36rEakmo0=;
 b=Ql5V/6VPZs1NFnchmPCaB7Pl8D3FXX4cYIs50TNcfN/dopVTCpqcumZmmwJu/65ibf
 VgAuX9RURwOE2Rxuj3H1iXUMfKCfdnzqx2IcladIP2jbyOR9xA81Gg0SZqV1OEe/bwy8
 foFShfZAwjf2mks4LjUn2DLmeB8avJH00oFogsmcNl12fFUXTM6r3fJ+UhfJh7/qQumV
 F8FKdV6sYB4UeGleDOt+1B0jFEEUZp7gFaB1UOc5/RPcfFoWk78ofcWbDzve1kkB+8/f
 Aztbhi2mXAfsimusz6vHCbLtPV1970+RrPQc3Jzqpg2z9PIgvES3YMnMN4iExWhurh3y
 raMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=0HZDrxCyGrVeJfmBDe1FADDB470ehjEc3z36rEakmo0=;
 b=UvZ9OYjK4ewMDK8EZqW9on1roDywctrBbvtu90KwK7ijwvRPkeMHh2jbQC2XspNqUT
 lAZYGHQi4b7oVGQU6wn2i3SectKkJHYWDmvT1Kk0TvwLjREFO343+GNeLdFbewJqo83q
 ieZqWfsy+pNPB6C4Cc11ULZeeR1zg9LFuknGKt47/uGB2qAQuWOeUx201dCRNfjXt0m2
 r4cKdgbRuuQXTSepWtlBXf8WWyLl7ZIJA7g91QiVuQFDOCysy2JPjJfjMmixfeesTfj5
 ZX9HiyCu+EG+kzOMSWSXlhZrZfRCI9wSVgdgxAhyjI7sDm8jaJBtitWURhL0c/BeVxZs
 F2CQ==
X-Gm-Message-State: AOAM533EUoEBZi+zlUQiKllbjHWrsYtacHFbZUwBQ3PBjCxtdLJY28qI
 FOWMvLIEAzmsmQt8YbQFGn6hnOkEgEo=
X-Google-Smtp-Source: ABdhPJyqW/q033Ixa/GLVUb+Qi/lDm85QUALhkNdG4gii6eXKLltiGURavEzTkrVKxZqr5OF8qhTX0p3L8U=
X-Received: from oupton.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:404])
 (user=oupton job=sendgmr) by 2002:a25:374d:: with SMTP id
 e74mr8052534yba.130.1627579983748; 
 Thu, 29 Jul 2021 10:33:03 -0700 (PDT)
Date: Thu, 29 Jul 2021 17:32:47 +0000
Message-Id: <20210729173300.181775-1-oupton@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH v5 00/13] KVM: Add idempotent controls for migrating system
 counter state
From: Oliver Upton <oupton@google.com>
To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Cc: Marc Zyngier <maz@kernel.org>, Raghavendra Rao Anata <rananta@google.com>,
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

KVM's current means of saving/restoring system counters is plagued with
temporal issues. At least on ARM64 and x86, we migrate the guest's
system counter by-value through the respective guest system register
values (cntvct_el0, ia32_tsc). Restoring system counters by-value is
brittle as the state is not idempotent: the host system counter is still
oscillating between the attempted save and restore. Furthermore, VMMs
may wish to transparently live migrate guest VMs, meaning that they
include the elapsed time due to live migration blackout in the guest
system counter view. The VMM thread could be preempted for any number of
reasons (scheduler, L0 hypervisor under nested) between the time that
it calculates the desired guest counter value and when KVM actually sets
this counter state.

Despite the value-based interface that we present to userspace, KVM
actually has idempotent guest controls by way of system counter offsets.
We can avoid all of the issues associated with a value-based interface
by abstracting these offset controls in new ioctls. This series
introduces new vCPU device attributes to provide userspace access to the
vCPU's system counter offset.

Patch 1 adopts Paolo's suggestion, augmenting the KVM_{GET,SET}_CLOCK
ioctls to provide userspace with a (host_tsc, realtime) instant. This is
essential for a VMM to perform precise migration of the guest's system
counters.

Patches 2-3 add support for x86 by shoehorning the new controls into the
pre-existing synchronization heuristics.

Patches 4-5 implement a test for the new additions to
KVM_{GET,SET}_CLOCK.

Patch 6 fixes some assertions in the kvm device attribute helpers.

Patches 7-8 implement at test for the tsc offset attribute introduced in
patch 3.

Patch 9 adds a device attribute for the arm64 virtual counter-timer
offset.

Patch 10 extends the test from patch 8 to cover the arm64 virtual
counter-timer offset.

Patch 11 adds a device attribute for the arm64 physical counter-timer
offset. Currently, this is implemented as a synthetic register, forcing
the guest to trap to the host and emulating the offset in the fast exit
path. Later down the line we will have hardware with FEAT_ECV, which
allows the hypervisor to perform physical counter-timer offsetting in
hardware (CNTPOFF_EL2).

Patch 12 extends the test from patch 8 to cover the arm64 physical
counter-timer offset.

Patch 13 introduces a benchmark to measure the overhead of emulation in
patch 11.

This series was tested on both an Ampere Mt. Jade and Haswell systems.

Physical counter benchmark
--------------------------

The following data was collected by running 10000 iterations of the
benchmark test from Patch 6 on an Ampere Mt. Jade reference server, A 2S
machine with 2 80-core Ampere Altra SoCs. Measurements were collected
for both VHE and nVHE operation using the `kvm-arm.mode=` command-line
parameter.

nVHE
----

+--------------------+--------+---------+
|       Metric       | Native | Trapped |
+--------------------+--------+---------+
| Average            | 54ns   | 148ns   |
| Standard Deviation | 124ns  | 122ns   |
| 95th Percentile    | 258ns  | 348ns   |
+--------------------+--------+---------+

VHE
---

+--------------------+--------+---------+
|       Metric       | Native | Trapped |
+--------------------+--------+---------+
| Average            | 53ns   | 152ns   |
| Standard Deviation | 92ns   | 94ns    |
| 95th Percentile    | 204ns  | 307ns   |
+--------------------+--------+---------+

This series applies cleanly to kvm/queue at the following commit:

8ad5e63649ff ("KVM: Don't take mmu_lock for range invalidation unless necessary")

v1 -> v2:
  - Reimplemented as vCPU device attributes instead of a distinct ioctl.
  - Added the (realtime, host_tsc) instant support to KVM_{GET,SET}_CLOCK
  - Changed the arm64 implementation to broadcast counter
    offset values to all vCPUs in a guest. This upholds the
    architectural expectations of a consistent counter-timer across CPUs.
  - Fixed a bug with traps in VHE mode. We now configure traps on every
    transition into a guest to handle differing VMs (trapped, emulated).

v2 -> v3:
  - Added documentation for additions to KVM_{GET,SET}_CLOCK
  - Added documentation for all new vCPU attributes
  - Added documentation for suggested algorithm to migrate a guest's
    TSC(s)
  - Bug fixes throughout series
  - Rename KVM_CLOCK_REAL_TIME -> KVM_CLOCK_REALTIME

v3 -> v4:
  - Added patch to address incorrect device helper assertions (Drew)
  - Carried Drew's r-b tags where appropriate
  - x86 selftest cleanup
  - Removed stale kvm_timer_init_vhe() function
  - Removed unnecessary GUEST_DONE() from selftests

v4 -> v5:
  - Fix typo in TSC migration algorithm
  - Carry more of Drew's r-b tags
  - clean up run loop logic in counter emulation benchmark (missed from
    Drew's comments on v3)

v1: https://lore.kernel.org/kvm/20210608214742.1897483-1-oupton@google.com/
v2: https://lore.kernel.org/r/20210716212629.2232756-1-oupton@google.com
v3: https://lore.kernel.org/r/20210719184949.1385910-1-oupton@google.com
v4: https://lore.kernel.org/r/20210729001012.70394-1-oupton@google.com

Oliver Upton (13):
  KVM: x86: Report host tsc and realtime values in KVM_GET_CLOCK
  KVM: x86: Refactor tsc synchronization code
  KVM: x86: Expose TSC offset controls to userspace
  tools: arch: x86: pull in pvclock headers
  selftests: KVM: Add test for KVM_{GET,SET}_CLOCK
  selftests: KVM: Fix kvm device helper ioctl assertions
  selftests: KVM: Add helpers for vCPU device attributes
  selftests: KVM: Introduce system counter offset test
  KVM: arm64: Allow userspace to configure a vCPU's virtual offset
  selftests: KVM: Add support for aarch64 to system_counter_offset_test
  KVM: arm64: Provide userspace access to the physical counter offset
  selftests: KVM: Test physical counter offsetting
  selftests: KVM: Add counter emulation benchmark

 Documentation/virt/kvm/api.rst                |  42 +-
 Documentation/virt/kvm/devices/vcpu.rst       | 101 +++++
 Documentation/virt/kvm/locking.rst            |  11 +
 arch/arm64/include/asm/kvm_host.h             |   1 +
 arch/arm64/include/asm/kvm_hyp.h              |   2 -
 arch/arm64/include/asm/sysreg.h               |   1 +
 arch/arm64/include/uapi/asm/kvm.h             |   2 +
 arch/arm64/kvm/arch_timer.c                   | 140 ++++--
 arch/arm64/kvm/arm.c                          |   4 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h       |  23 +
 arch/arm64/kvm/hyp/include/hyp/timer-sr.h     |  26 ++
 arch/arm64/kvm/hyp/nvhe/switch.c              |   2 -
 arch/arm64/kvm/hyp/nvhe/timer-sr.c            |  21 +-
 arch/arm64/kvm/hyp/vhe/timer-sr.c             |  27 ++
 arch/x86/include/asm/kvm_host.h               |   4 +
 arch/x86/include/uapi/asm/kvm.h               |   4 +
 arch/x86/kvm/x86.c                            | 422 ++++++++++++++----
 include/kvm/arm_arch_timer.h                  |   2 -
 include/uapi/linux/kvm.h                      |   7 +-
 tools/arch/x86/include/asm/pvclock-abi.h      |  48 ++
 tools/arch/x86/include/asm/pvclock.h          | 103 +++++
 tools/testing/selftests/kvm/.gitignore        |   3 +
 tools/testing/selftests/kvm/Makefile          |   4 +
 .../kvm/aarch64/counter_emulation_benchmark.c | 207 +++++++++
 .../selftests/kvm/include/aarch64/processor.h |  24 +
 .../testing/selftests/kvm/include/kvm_util.h  |  11 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |  44 +-
 .../kvm/system_counter_offset_test.c          | 205 +++++++++
 .../selftests/kvm/x86_64/kvm_clock_test.c     | 204 +++++++++
 29 files changed, 1537 insertions(+), 158 deletions(-)
 create mode 100644 arch/arm64/kvm/hyp/include/hyp/timer-sr.h
 create mode 100644 tools/arch/x86/include/asm/pvclock-abi.h
 create mode 100644 tools/arch/x86/include/asm/pvclock.h
 create mode 100644 tools/testing/selftests/kvm/aarch64/counter_emulation_benchmark.c
 create mode 100644 tools/testing/selftests/kvm/system_counter_offset_test.c
 create mode 100644 tools/testing/selftests/kvm/x86_64/kvm_clock_test.c

-- 
2.32.0.432.gabb21c7263-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
