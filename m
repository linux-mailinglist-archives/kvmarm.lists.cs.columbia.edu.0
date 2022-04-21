Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7E746509D19
	for <lists+kvmarm@lfdr.de>; Thu, 21 Apr 2022 12:06:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B7D984B2B8;
	Thu, 21 Apr 2022 06:06:09 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 required=6.1 tests=[BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l0a2ZH4OV4YI; Thu, 21 Apr 2022 06:06:09 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6D8B94B2A1;
	Thu, 21 Apr 2022 06:06:08 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7D7B84B3D6
 for <kvmarm@lists.cs.columbia.edu>; Thu, 21 Apr 2022 06:06:06 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BuOVSolPtj9C for <kvmarm@lists.cs.columbia.edu>;
 Thu, 21 Apr 2022 06:06:04 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EA16C4B34B
 for <kvmarm@lists.cs.columbia.edu>; Thu, 21 Apr 2022 06:06:03 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 309A91477;
 Thu, 21 Apr 2022 03:06:03 -0700 (PDT)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A6B823F766;
 Thu, 21 Apr 2022 03:06:01 -0700 (PDT)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: catalin.marinas@arm.com, will@kernel.org,
 linux-arm-kernel@lists.infradead.org, maz@kernel.org, james.morse@arm.com,
 suzuki.poulose@arm.com, kvmarm@lists.cs.columbia.edu, mark.rutland@arm.com
Subject: [PATCH v2 0/5] arm64: Treat ESR_ELx as a 64-bit register
Date: Thu, 21 Apr 2022 11:05:42 +0100
Message-Id: <20220421100547.873761-1-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
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

The ESR_EL{1,2} registers were originally 32-bit, then were extended to
64-bit with the upper 32 bits RES0, and in ARM DDI 0487H.a the FEAT_LS64
feature was added which now makes use of the upper bits. This series aims
to teach Linux to treat it consistently as a 64-bit register with the goal
of making it easier to add support in the future for features that use the
upper 32 bits.

Patches #1 ("arm64: Make ESR_ELx_xVC_IMM_MASK compatible with assembly")
and #2 ("arm64: compat: Do not treat syscall number as ESR_ELx for a bad
syscall") are fixes for some minor issues which I found while working on
changing ESR_ELx to 64-bit.

Patches #3 ("arm64: Treat ESR_ELx as a 64bit register") and #4 ("KVM:
arm64: Treat ESR_EL2 as a 64-bit register") are where the ESR_ELx registers
are changed to 64-bit. I chose to make the KVM changes a separate patch
because KVM prefers to use u64 for the registers.

And in patch #5 ("KVM: arm64: uapi: Add kvm_debug_exit_arch.hsr_high") I
add a new field to the user API struct kvm_debug_exit_arch that represents
the higher 32 bits, and a flag to go with it (details in the patch).

Tested by running ltp for about a day and kvm-unit-tests on a rockpro64.

Changes in v2:

* Added the KVM_DEBUG_ARCH_HSR_HIGH_VALID kvm_run flag to patch #5 ("KVM:
  arm64: uapi: Add kvm_debug_exit_arch.hsr_high"), and updated the commit
  message to match (Marc)
* Rebased on top of v5.18-rc3.

Alexandru Elisei (5):
  arm64: Make ESR_ELx_xVC_IMM_MASK compatible with assembly
  arm64: compat: Do not treat syscall number as ESR_ELx for a bad
    syscall
  arm64: Treat ESR_ELx as a 64-bit register
  KVM: arm64: Treat ESR_EL2 as a 64-bit register
  KVM: arm64: uapi: Add kvm_debug_exit_arch.hsr_high

 arch/arm64/include/asm/debug-monitors.h |  4 +-
 arch/arm64/include/asm/esr.h            |  8 +--
 arch/arm64/include/asm/exception.h      | 28 +++++-----
 arch/arm64/include/asm/kvm_emulate.h    |  6 +--
 arch/arm64/include/asm/kvm_host.h       |  2 +-
 arch/arm64/include/asm/kvm_ras.h        |  2 +-
 arch/arm64/include/asm/system_misc.h    |  4 +-
 arch/arm64/include/asm/traps.h          | 12 ++---
 arch/arm64/include/uapi/asm/kvm.h       |  2 +
 arch/arm64/kernel/debug-monitors.c      | 12 ++---
 arch/arm64/kernel/entry-common.c        |  6 +--
 arch/arm64/kernel/fpsimd.c              |  6 +--
 arch/arm64/kernel/hw_breakpoint.c       |  4 +-
 arch/arm64/kernel/kgdb.c                |  6 +--
 arch/arm64/kernel/probes/kprobes.c      |  4 +-
 arch/arm64/kernel/probes/uprobes.c      |  4 +-
 arch/arm64/kernel/sys_compat.c          |  2 +-
 arch/arm64/kernel/traps.c               | 66 +++++++++++------------
 arch/arm64/kvm/handle_exit.c            | 16 +++---
 arch/arm64/kvm/hyp/include/hyp/switch.h |  2 +-
 arch/arm64/kvm/hyp/nvhe/sys_regs.c      |  2 +-
 arch/arm64/kvm/hyp/vgic-v3-sr.c         |  4 +-
 arch/arm64/kvm/inject_fault.c           |  4 +-
 arch/arm64/kvm/sys_regs.c               |  4 +-
 arch/arm64/mm/fault.c                   | 70 ++++++++++++-------------
 25 files changed, 142 insertions(+), 138 deletions(-)

-- 
2.36.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
