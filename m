Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4C95D584D93
	for <lists+kvmarm@lfdr.de>; Fri, 29 Jul 2022 10:43:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4F4384C549;
	Fri, 29 Jul 2022 04:43:21 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HhRPRiFM3k+A; Fri, 29 Jul 2022 04:43:21 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8FD184C534;
	Fri, 29 Jul 2022 04:43:19 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3A6964C528
 for <kvmarm@lists.cs.columbia.edu>; Fri, 29 Jul 2022 04:43:18 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id raJPC1QPiPUS for <kvmarm@lists.cs.columbia.edu>;
 Fri, 29 Jul 2022 04:43:16 -0400 (EDT)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 7DFBA4C50E
 for <kvmarm@lists.cs.columbia.edu>; Fri, 29 Jul 2022 04:43:16 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id DB2CDB826E4;
 Fri, 29 Jul 2022 08:43:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68ED6C433C1;
 Fri, 29 Jul 2022 08:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1659084193;
 bh=jPbZkgYa9GkfB5ysi5xuqeGsMQ+Nwk3bXeJINmKXVbo=;
 h=From:To:Cc:Subject:Date:From;
 b=gdbFf70kwmxvgW/y1pRVmGXUStAjirfsr27k/irKK9kn6YqUvY5rRh9ys82+w5mIe
 sqGK6d188hAH75Iprr77vyP8O6Io3IsZb7srnzTiF80T3UL1CrIZLUL3Pi7JJggH/h
 LBVFOguIDvnbHmHoyCwHu7tOg3fZe6Q5fWcRxTmTT1vQU9dLYFIj8tDbA6kCIL+Bfk
 HW723Hd9d+Mh/LhaqNWLxcCyBAwl4ep7RSDEgC11q+HBMi9OePS8Om+A4Nm9xHRsbS
 tKaCzjBfPiH03GlbtfRLieocJCipYYUHoNyvWMBNAons9ZiWofYcr341apwcEDwzZQ
 3Np9N82ZbI/0g==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <maz@kernel.org>) id 1oHLaQ-00Aq9G-Ul;
 Fri, 29 Jul 2022 09:43:11 +0100
From: Marc Zyngier <maz@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: [GIT PULL] KVM/arm64 updates for 5.20
Date: Fri, 29 Jul 2022 09:43:08 +0100
Message-Id: <20220729084308.1881661-1-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: pbonzini@redhat.com, andreyknvl@google.com, tabba@google.com,
 kaleshsingh@google.com, madvenka@linux.microsoft.com, broonie@kernel.org,
 mark.rutland@arm.com, masahiroy@kernel.org, oliver.upton@linux.dev,
 qperret@google.com, reijiw@google.com, ricarkol@google.com, will@kernel.org,
 james.morse@arm.com, suzuki.poulose@arm.com, alexandru.elisei@arm.com,
 linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, kvm@vger.kernel.org,
 Andrey Konovalov <andreyknvl@google.com>,
 Masahiro Yamada <masahiroy@kernel.org>,
 "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
 Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu
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

Paolo,

Here's the bulk of the KVM/arm64 updates for 5.20. Major feature is
the new unwinder for the nVHE modes. The rest is mostly rewriting some
unloved aspects of the arm64 port (sysregs, flags). Further details in
the tag description.

Note that this PR contains a shared branch with the arm64 tree
containing some of the stacktrace updates. There is also a minor
conflict with your tree in one of the selftests, already resolved in
-next.

Please pull,

	M.

The following changes since commit a111daf0c53ae91e71fd2bfe7497862d14132e3e:

  Linux 5.19-rc3 (2022-06-19 15:06:47 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kvmarm-5.20

for you to fetch changes up to 0982c8d859f8f7022b9fd44d421c7ec721bb41f9:

  Merge branch kvm-arm64/nvhe-stacktrace into kvmarm-master/next (2022-07-27 18:33:27 +0100)

----------------------------------------------------------------
KVM/arm64 updates for 5.20:

- Unwinder implementations for both nVHE modes (classic and
  protected), complete with an overflow stack

- Rework of the sysreg access from userspace, with a complete
  rewrite of the vgic-v3 view to allign with the rest of the
  infrastructure

- Disagregation of the vcpu flags in separate sets to better track
  their use model.

- A fix for the GICv2-on-v3 selftest

- A small set of cosmetic fixes

----------------------------------------------------------------
Andrey Konovalov (2):
      arm64: kasan: do not instrument stacktrace.c
      arm64: stacktrace: use non-atomic __set_bit

Kalesh Singh (18):
      KVM: arm64: Fix hypervisor address symbolization
      arm64: stacktrace: Add shared header for common stack unwinding code
      arm64: stacktrace: Factor out on_accessible_stack_common()
      arm64: stacktrace: Factor out unwind_next_common()
      arm64: stacktrace: Handle frame pointer from different address spaces
      arm64: stacktrace: Factor out common unwind()
      arm64: stacktrace: Add description of stacktrace/common.h
      KVM: arm64: On stack overflow switch to hyp overflow_stack
      KVM: arm64: Stub implementation of non-protected nVHE HYP stack unwinder
      KVM: arm64: Prepare non-protected nVHE hypervisor stacktrace
      KVM: arm64: Implement non-protected nVHE hyp stack unwinder
      KVM: arm64: Introduce hyp_dump_backtrace()
      KVM: arm64: Add PROTECTED_NVHE_STACKTRACE Kconfig
      KVM: arm64: Allocate shared pKVM hyp stacktrace buffers
      KVM: arm64: Stub implementation of pKVM HYP stack unwinder
      KVM: arm64: Save protected-nVHE (pKVM) hyp stacktrace
      KVM: arm64: Implement protected nVHE hyp stack unwinder
      KVM: arm64: Introduce pkvm_dump_backtrace()

Madhavan T. Venkataraman (2):
      arm64: Split unwind_init()
      arm64: Copy the task argument to unwind_state

Marc Zyngier (47):
      KVM: arm64: Drop FP_FOREIGN_STATE from the hypervisor code
      KVM: arm64: Move FP state ownership from flag to a tristate
      KVM: arm64: Add helpers to manipulate vcpu flags among a set
      KVM: arm64: Add three sets of flags to the vcpu state
      KVM: arm64: Move vcpu configuration flags into their own set
      KVM: arm64: Move vcpu PC/Exception flags to the input flag set
      KVM: arm64: Move vcpu debug/SPE/TRBE flags to the input flag set
      KVM: arm64: Move vcpu SVE/SME flags to the state flag set
      KVM: arm64: Move vcpu ON_UNSUPPORTED_CPU flag to the state flag set
      KVM: arm64: Move vcpu WFIT flag to the state flag set
      KVM: arm64: Kill unused vcpu flags field
      KVM: arm64: Convert vcpu sysregs_loaded_on_cpu to a state flag
      KVM: arm64: Warn when PENDING_EXCEPTION and INCREMENT_PC are set together
      KVM: arm64: Add build-time sanity checks for flags
      KVM: arm64: Reduce the size of the vcpu flag members
      KVM: arm64: Document why pause cannot be turned into a flag
      KVM: arm64: Move the handling of !FP outside of the fast path
      Merge branch kvm-arm64/burn-the-flags into kvmarm-master/next
      KVM: arm64: selftests: Add support for GICv2 on v3
      Merge branch kvm-arm64/misc-5.20 into kvmarm-master/next
      KVM: arm64: Add get_reg_by_id() as a sys_reg_desc retrieving helper
      KVM: arm64: Reorder handling of invariant sysregs from userspace
      KVM: arm64: Introduce generic get_user/set_user helpers for system registers
      KVM: arm64: Rely on index_to_param() for size checks on userspace access
      KVM: arm64: Consolidate sysreg userspace accesses
      KVM: arm64: Get rid of reg_from/to_user()
      KVM: arm64: vgic-v3: Simplify vgic_v3_has_cpu_sysregs_attr()
      KVM: arm64: vgic-v3: Push user access into vgic_v3_cpu_sysregs_uaccess()
      KVM: arm64: vgic-v3: Make the userspace accessors use sysreg API
      KVM: arm64: vgic-v3: Convert userspace accessors over to FIELD_GET/FIELD_PREP
      KVM: arm64: vgic-v3: Use u32 to manage the line level from userspace
      KVM: arm64: vgic-v3: Consolidate userspace access for MMIO registers
      KVM: arm64: vgic-v2: Consolidate userspace access for MMIO registers
      KVM: arm64: vgic: Use {get,put}_user() instead of copy_{from.to}_user
      KVM: arm64: vgic-v2: Add helper for legacy dist/cpuif base address setting
      KVM: arm64: vgic: Consolidate userspace access for base address setting
      KVM: arm64: vgic: Tidy-up calls to vgic_{get,set}_common_attr()
      KVM: arm64: Get rid of find_reg_by_id()
      KVM: arm64: Descope kvm_arm_sys_reg_{get,set}_reg()
      KVM: arm64: Get rid or outdated comments
      Merge branch kvm-arm64/sysreg-cleanup-5.20 into kvmarm-master/next
      KVM: arm64: Move PROTECTED_NVHE_STACKTRACE around
      KVM: arm64: Move nVHE stacktrace unwinding into its own compilation unit
      KVM: arm64: Make unwind()/on_accessible_stack() per-unwinder functions
      KVM: arm64: Move nVHE-only helpers into kvm/stacktrace.c
      arm64: Update 'unwinder howto'
      Merge branch kvm-arm64/nvhe-stacktrace into kvmarm-master/next

Masahiro Yamada (2):
      KVM: arm64: nvhe: Rename confusing obj-y
      KVM: arm64: nvhe: Add intermediates to 'targets' instead of extra-y

Oliver Upton (1):
      KVM: arm64: Don't open code ARRAY_SIZE()

Quentin Perret (1):
      KVM: arm64: Don't return from void function

 arch/arm64/include/asm/kvm_asm.h                |  16 +
 arch/arm64/include/asm/kvm_emulate.h            |  11 +-
 arch/arm64/include/asm/kvm_host.h               | 205 ++++++++---
 arch/arm64/include/asm/memory.h                 |   8 +
 arch/arm64/include/asm/stacktrace.h             |  62 +---
 arch/arm64/include/asm/stacktrace/common.h      | 199 ++++++++++
 arch/arm64/include/asm/stacktrace/nvhe.h        |  55 +++
 arch/arm64/kernel/Makefile                      |   5 +
 arch/arm64/kernel/stacktrace.c                  | 184 +++++-----
 arch/arm64/kvm/Kconfig                          |  13 +
 arch/arm64/kvm/Makefile                         |   2 +-
 arch/arm64/kvm/arch_timer.c                     |   2 +-
 arch/arm64/kvm/arm.c                            |  25 +-
 arch/arm64/kvm/debug.c                          |  25 +-
 arch/arm64/kvm/fpsimd.c                         |  39 +-
 arch/arm64/kvm/handle_exit.c                    |  10 +-
 arch/arm64/kvm/hyp/exception.c                  |  23 +-
 arch/arm64/kvm/hyp/include/hyp/debug-sr.h       |   6 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h         |  24 +-
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h      |   4 +-
 arch/arm64/kvm/hyp/nvhe/Makefile                |  14 +-
 arch/arm64/kvm/hyp/nvhe/debug-sr.c              |   8 +-
 arch/arm64/kvm/hyp/nvhe/host.S                  |   9 +-
 arch/arm64/kvm/hyp/nvhe/stacktrace.c            | 160 ++++++++
 arch/arm64/kvm/hyp/nvhe/switch.c                |  14 +-
 arch/arm64/kvm/hyp/nvhe/sys_regs.c              |   4 +-
 arch/arm64/kvm/hyp/vhe/switch.c                 |   6 +-
 arch/arm64/kvm/hyp/vhe/sysreg-sr.c              |   4 +-
 arch/arm64/kvm/inject_fault.c                   |  17 +-
 arch/arm64/kvm/reset.c                          |   6 +-
 arch/arm64/kvm/stacktrace.c                     | 218 +++++++++++
 arch/arm64/kvm/sys_regs.c                       | 294 ++++++---------
 arch/arm64/kvm/sys_regs.h                       |  18 +-
 arch/arm64/kvm/vgic-sys-reg-v3.c                | 462 ++++++++++++++----------
 arch/arm64/kvm/vgic/vgic-kvm-device.c           | 342 ++++++++----------
 arch/arm64/kvm/vgic/vgic-mmio-v3.c              |  10 +-
 arch/arm64/kvm/vgic/vgic-mmio.c                 |   6 +-
 arch/arm64/kvm/vgic/vgic-mmio.h                 |   4 +-
 arch/arm64/kvm/vgic/vgic.h                      |   9 +-
 include/kvm/arm_vgic.h                          |   2 +-
 tools/testing/selftests/kvm/aarch64/vgic_init.c |  13 +-
 41 files changed, 1588 insertions(+), 950 deletions(-)
 create mode 100644 arch/arm64/include/asm/stacktrace/common.h
 create mode 100644 arch/arm64/include/asm/stacktrace/nvhe.h
 create mode 100644 arch/arm64/kvm/hyp/nvhe/stacktrace.c
 create mode 100644 arch/arm64/kvm/stacktrace.c
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
