Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED82A035D
	for <lists+kvmarm@lfdr.de>; Wed, 28 Aug 2019 15:38:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8179E4A5AA;
	Wed, 28 Aug 2019 09:38:54 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b9B7+r3woQua; Wed, 28 Aug 2019 09:38:54 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 148F24A557;
	Wed, 28 Aug 2019 09:38:53 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7EB754A559
 for <kvmarm@lists.cs.columbia.edu>; Wed, 28 Aug 2019 09:38:52 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NoPqnvib+5vx for <kvmarm@lists.cs.columbia.edu>;
 Wed, 28 Aug 2019 09:38:50 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 937CF4A520
 for <kvmarm@lists.cs.columbia.edu>; Wed, 28 Aug 2019 09:38:50 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14E4628;
 Wed, 28 Aug 2019 06:38:50 -0700 (PDT)
Received: from e121566-lin.cambridge.arm.com (e121566-lin.cambridge.arm.com
 [10.1.196.217])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E8D313F246;
 Wed, 28 Aug 2019 06:38:48 -0700 (PDT)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: kvm@vger.kernel.org,
	kvmarm@lists.cs.columbia.edu
Subject: [kvm-unit-tests RFC PATCH 00/16] arm64: Run at EL2
Date: Wed, 28 Aug 2019 14:38:15 +0100
Message-Id: <1566999511-24916-1-git-send-email-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.7.4
Cc: maz@kernel.org, andre.przywara@arm.com, pbonzini@redhat.com
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

ARMv8.3 added support for nested virtualization, which makes it possible
for a hypervisor to run another hypervisor as a guest. Support for nested
virtualization is being worked on in KVM [1].

This patch series aims to make it possible for kvm-unit-tests to run at EL2
under KVM. The focus has been on having all the infrastructure in place to
run at EL2, and not on adding comprehensive tests for this Exception Level.
All existing tests that fulfill KVM's requirements for a nested guest (the
architecture is arm64 and they use GICv3) will be able to be run at EL2.

To keep the changes minimal, kvm-unit-tests will run with VHE enabled when
it detects that has been booted at EL2. Functions for enabling and
disabling VHE have been added, with the aim to let the user specify to
disable VHE for a given test via command-line parameters. At the moment,
only the timer test has been modified to run with VHE disabled.

The series are firmly an RFC because:
* The patches that implement KVM nested support are themselves in the RFC
  phase.
* Some tests don't complete because of bugs in the current version of the
  KVM patches. Where appropriate, I will provide fixes to allow the tests
  to finish, however those fixes are my own have not been reviewed in any
  way. Use at your own risk.

To run the tests, one obviously needs KVM with nested virtualization
support from [2]. These patches have been tested from commit
78c66132035c ("arm64: KVM: nv: Allow userspace to request
KVM_ARM_VCPU_NESTED_VIRT"), on top of which the following patches have been
cherry-picked from upstream Linux:
* b4a1583abc83 ("KVM: arm/arm64: Fix emulated ptimer irq injection")
* 16e604a437c8 ("KVM: arm/arm64: vgic: Reevaluate level sensitive
  interrupts on enable")

Without those two patches some timer tests will fail.

A version of kvmtool that knows about nested virtualization is also
needed [3]. The kvmtool --nested parameter is required for releasing a
guest at EL2. For example, to run the newly added selftest-el2 test:

lkvm -f selftest.flat -c 2 -m 128 -p el2 --nested --console serial \
	--irqchip gicv3

Summary of the patches:
* Patches 1-10 are various fixes or enhancements and can be merged without
  the rest of the series.
* Patches 11-13 add support for running at EL2. A basic selftest-el2 test
  is added that targets EL2.
* Patches 14-16 add support for disabling VHE. The timer and selftest-el2
  tests are modified to use this feature.

[1] https://www.spinics.net/lists/arm-kernel/msg736687.html
[2] git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/nv-wip-5.2-rc5
[3] git://linux-arm.org/kvmtool.git nv/nv-wip-5.2-rc5

Alexandru Elisei (16):
  arm: selftest.c: Remove redundant check for Exception Level
  arm/arm64: psci: Don't run C code without stack or vectors
  lib: arm/arm64: Add missing include for alloc_page.h in pgtable.h
  arm/arm64: selftest: Add prefetch abort test
  arm64: timer: Write to ICENABLER to disable timer IRQ
  arm64: timer: EOIR the interrupt after masking the timer
  arm64: timer: Test behavior when timer disabled or masked
  lib: arm/arm64: Refuse to disable the MMU with non-identity stack
    pointer
  lib: arm/arm64: Invalidate TLB before enabling MMU
  lib: Add UL and ULL definitions to linux/const.h
  lib: arm64: Run existing tests at EL2
  arm64: timer: Add test for EL2 timers
  arm64: selftest: Add basic test for EL2
  lib: arm64: Add support for disabling and re-enabling VHE
  arm64: selftest: Expand EL2 test to disable and re-enable VHE
  arm64: timer: Run tests with VHE disabled

 lib/linux/const.h             |   7 +-
 lib/arm/asm/gic-v3.h          |   1 +
 lib/arm/asm/gic.h             |   1 +
 lib/arm/asm/pgtable.h         |   1 +
 lib/arm/asm/processor.h       |   8 +
 lib/arm/asm/psci.h            |   1 +
 lib/arm64/asm/esr.h           |   5 +
 lib/arm64/asm/mmu.h           |  11 +-
 lib/arm64/asm/pgtable-hwdef.h |  55 +++++--
 lib/arm64/asm/pgtable.h       |   1 +
 lib/arm64/asm/processor.h     |  53 +++++++
 lib/arm64/asm/sysreg.h        |  28 ++++
 lib/arm/mmu.c                 |   5 +-
 lib/arm/processor.c           |  11 ++
 lib/arm/psci.c                |  43 +++++-
 lib/arm/setup.c               |   6 +
 lib/arm64/processor.c         |  69 ++++++++-
 arm/cstart.S                  |  11 ++
 arm/cstart64.S                | 221 ++++++++++++++++++++++++++-
 arm/micro-bench.c             |  17 ++-
 arm/psci.c                    |   5 +-
 arm/selftest.c                | 175 ++++++++++++++++++++--
 arm/timer.c                   | 340 +++++++++++++++++++++++++++++++++++++-----
 arm/unittests.cfg             |   8 +
 24 files changed, 1010 insertions(+), 73 deletions(-)

-- 
2.7.4

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
