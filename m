Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 83E6F23CDDC
	for <lists+kvmarm@lfdr.de>; Wed,  5 Aug 2020 19:57:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3411E4B441;
	Wed,  5 Aug 2020 13:57:20 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ESmR9cJFo72b; Wed,  5 Aug 2020 13:57:18 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 858814B587;
	Wed,  5 Aug 2020 13:57:17 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 698EC4B4FB
 for <kvmarm@lists.cs.columbia.edu>; Wed,  5 Aug 2020 13:57:16 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rb8Z87mcDh3a for <kvmarm@lists.cs.columbia.edu>;
 Wed,  5 Aug 2020 13:57:15 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D0B6E4B441
 for <kvmarm@lists.cs.columbia.edu>; Wed,  5 Aug 2020 13:57:14 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 521BF2173E;
 Wed,  5 Aug 2020 17:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1596650233;
 bh=juxLV+E099RYtCa22t1sG7pfJtqygQtV/DctUYidP+8=;
 h=From:To:Cc:Subject:Date:From;
 b=fknGdJhK+d4oiugSSghMjrgTAQf3oBOGIkhxZU5vcURpee/7rXEI+huuFVUTisMKj
 rGTKnkZ2rvdlOxU+m28rcLEOSM9F81K05R5gaeuAOZeUPIdrO+c8WPhgH+actxu8Ny
 ildEsE/4ODjIWwfxcSi3alrx4Agvgi5NLh72wHLA=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1k3Nf5-0004w9-Pn; Wed, 05 Aug 2020 18:57:11 +0100
From: Marc Zyngier <maz@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: [GIT PULL] KVM/arm64 updates for 5.9
Date: Wed,  5 Aug 2020 18:56:04 +0100
Message-Id: <20200805175700.62775-1-maz@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: pbonzini@redhat.com, graf@amazon.com,
 alexandru.elisei@arm.com, ascull@google.com, catalin.marinas@arm.com,
 christoffer.dall@arm.com, dbrazdil@google.com, eric.auger@redhat.com,
 gshan@redhat.com, james.morse@arm.com, mark.rutland@arm.com,
 richard.peng@oppo.com, qperret@google.com, will@kernel.org,
 julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Peng Hao <richard.peng@oppo.com>, kernel-team@android.com,
 kvm@vger.kernel.org, Will Deacon <will@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Alexander Graf <graf@amazon.com>,
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

Hi Paolo,

This is the bulk of the 5.9 patches for KVM/arm64. It is a pretty busy
merge window for us this time, thanks to the ongoing Protected KVM
work. We have changes all over the map, but the most important piece
probably is the way we now build the EL2 code on non-VHE systems. On
top of giving us better control over what gets pulled in there, it
allowed us to enable instrumentation on VHE systems.

The rest is a mixed bag of new features (TTL TLB invalidation, Pointer
Auth on non-VHE), preliminary patches for NV, some early MMU rework
before the 5.10 onslaught, and tons of cleanups.

A few things to notice:

- We share a branch with the arm64 tree, which has gone in already.

- There are a number of known conflicts with Sean's MMU cache rework,
  as well as the late fixes that went in 5.8. The conflicts are pretty
  simple to resolve, and -next has the right resolutions already.

Please pull,

	M.

The following changes since commit 9ebcfadb0610322ac537dd7aa5d9cbc2b2894c68:

  Linux 5.8-rc3 (2020-06-28 15:00:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kvmarm-5.9

for you to fetch changes up to 16314874b12b451bd5a1df86bcb69745eb487502:

  Merge branch 'kvm-arm64/misc-5.9' into kvmarm-master/next (2020-07-30 16:13:04 +0100)

----------------------------------------------------------------
KVM/arm64 updates for Linux 5.9:

- Split the VHE and nVHE hypervisor code bases, build the EL2 code
  separately, allowing for the VHE code to now be built with instrumentation

- Level-based TLB invalidation support

- Restructure of the vcpu register storage to accomodate the NV code

- Pointer Authentication available for guests on nVHE hosts

- Simplification of the system register table parsing

- MMU cleanups and fixes

- A number of post-32bit cleanups and other fixes

----------------------------------------------------------------
Alexander Graf (2):
      KVM: arm64: vgic-its: Change default outer cacheability for {PEND, PROP}BASER
      KVM: arm: Add trace name for ARM_NISV

Andrew Scull (3):
      arm64: kvm: Remove kern_hyp_va from get_vcpu_ptr
      KVM: arm64: Handle calls to prefixed hyp functions
      KVM: arm64: Move hyp-init.S to nVHE

Christoffer Dall (1):
      KVM: arm64: Factor out stage 2 page table data from struct kvm

David Brazdil (16):
      KVM: arm64: Fix symbol dependency in __hyp_call_panic_nvhe
      KVM: arm64: Move __smccc_workaround_1_smc to .rodata
      KVM: arm64: Add build rules for separate VHE/nVHE object files
      KVM: arm64: Use build-time defines in has_vhe()
      KVM: arm64: Build hyp-entry.S separately for VHE/nVHE
      KVM: arm64: Duplicate hyp/tlb.c for VHE/nVHE
      KVM: arm64: Split hyp/switch.c to VHE/nVHE
      KVM: arm64: Split hyp/debug-sr.c to VHE/nVHE
      KVM: arm64: Split hyp/sysreg-sr.c to VHE/nVHE
      KVM: arm64: Duplicate hyp/timer-sr.c for VHE/nVHE
      KVM: arm64: Compile remaining hyp/ files for both VHE/nVHE
      KVM: arm64: Remove __hyp_text macro, use build rules instead
      KVM: arm64: Lift instrumentation restrictions on VHE
      KVM: arm64: Make nVHE ASLR conditional on RANDOMIZE_BASE
      KVM: arm64: Substitute RANDOMIZE_BASE for HARDEN_EL2_VECTORS
      KVM: arm64: Ensure that all nVHE hyp code is in .hyp.text

Gavin Shan (1):
      KVM: arm64: Rename HSR to ESR

James Morse (5):
      KVM: arm64: Drop the target_table[] indirection
      KVM: arm64: Tolerate an empty target_table list
      KVM: arm64: Move ACTLR_EL1 emulation to the sys_reg_descs array
      KVM: arm64: Remove target_table from exit handlers
      KVM: arm64: Remove the target table

Marc Zyngier (31):
      KVM: arm64: Enable Address Authentication at EL2 if available
      KVM: arm64: Allow ARM64_PTR_AUTH when ARM64_VHE=n
      KVM: arm64: Allow PtrAuth to be enabled from userspace on non-VHE systems
      KVM: arm64: Check HCR_EL2 instead of shadow copy to swap PtrAuth registers
      KVM: arm64: Simplify PtrAuth alternative patching
      KVM: arm64: Allow in-atomic injection of SPIs
      arm64: Detect the ARMv8.4 TTL feature
      arm64: Document SW reserved PTE/PMD bits in Stage-2 descriptors
      arm64: Add level-hinted TLB invalidation helper
      Merge branch 'kvm-arm64/ttl-for-arm64' into HEAD
      KVM: arm64: Use TTL hint in when invalidating stage-2 translations
      KVM: arm64: Introduce accessor for ctxt->sys_reg
      KVM: arm64: hyp: Use ctxt_sys_reg/__vcpu_sys_reg instead of raw sys_regs access
      KVM: arm64: sve: Use __vcpu_sys_reg() instead of raw sys_regs access
      KVM: arm64: pauth: Use ctxt_sys_reg() instead of raw sys_regs access
      KVM: arm64: debug: Drop useless vpcu parameter
      KVM: arm64: Make struct kvm_regs userspace-only
      KVM: arm64: Move ELR_EL1 to the system register array
      KVM: arm64: Move SP_EL1 to the system register array
      KVM: arm64: Disintegrate SPSR array
      KVM: arm64: Move SPSR_EL1 to the system register array
      KVM: arm64: timers: Rename kvm_timer_sync_hwstate to kvm_timer_sync_user
      KVM: arm64: timers: Move timer registers to the sys_regs file
      KVM: arm64: Don't use has_vhe() for CHOOSE_HYP_SYM()
      Merge branch 'kvm-arm64/el2-obj-v4.1' into kvmarm-master/next-WIP
      Merge branch 'kvm-arm64/pre-nv-5.9' into kvmarm-master/next-WIP
      Merge branch 'kvm-arm64/ptrauth-nvhe' into kvmarm-master/next-WIP
      Merge branch 'kvm-arm64/target-table-no-more' into kvmarm-master/next-WIP
      Merge branch 'kvm-arm64/misc-5.9' into kvmarm-master/next-WIP
      Merge branch 'kvm-arm64/el2-obj-v4.1' into kvmarm-master/next
      Merge branch 'kvm-arm64/misc-5.9' into kvmarm-master/next

Peng Hao (1):
      KVM: arm64: Drop long gone function parameter documentation

Will Deacon (4):
      KVM: arm64: Rename kvm_vcpu_dabt_isextabt()
      KVM: arm64: Handle data and instruction external aborts the same way
      KVM: arm64: Don't skip cache maintenance for read-only memslots
      KVM: arm64: Move S1PTW S2 fault logic out of io_mem_abort()

 arch/arm64/Kconfig                                 |  20 +-
 arch/arm64/include/asm/cpucaps.h                   |   3 +-
 arch/arm64/include/asm/kvm_asm.h                   |  75 +-
 arch/arm64/include/asm/kvm_coproc.h                |   8 -
 arch/arm64/include/asm/kvm_emulate.h               |  75 +-
 arch/arm64/include/asm/kvm_host.h                  |  94 ++-
 arch/arm64/include/asm/kvm_hyp.h                   |  15 +-
 arch/arm64/include/asm/kvm_mmu.h                   |  16 +-
 arch/arm64/include/asm/kvm_ptrauth.h               |  34 +-
 arch/arm64/include/asm/mmu.h                       |   7 -
 arch/arm64/include/asm/pgtable-hwdef.h             |   2 +
 arch/arm64/include/asm/stage2_pgtable.h            |   9 +
 arch/arm64/include/asm/sysreg.h                    |   1 +
 arch/arm64/include/asm/tlbflush.h                  |  45 +
 arch/arm64/include/asm/virt.h                      |  13 +-
 arch/arm64/kernel/asm-offsets.c                    |   3 +-
 arch/arm64/kernel/cpu_errata.c                     |   4 +-
 arch/arm64/kernel/cpufeature.c                     |  11 +
 arch/arm64/kernel/image-vars.h                     |  54 ++
 arch/arm64/kvm/Kconfig                             |   2 +-
 arch/arm64/kvm/Makefile                            |   4 +-
 arch/arm64/kvm/arch_timer.c                        | 157 +++-
 arch/arm64/kvm/arm.c                               |  57 +-
 arch/arm64/kvm/fpsimd.c                            |   6 +-
 arch/arm64/kvm/guest.c                             |  79 +-
 arch/arm64/kvm/handle_exit.c                       |  32 +-
 arch/arm64/kvm/hyp/Makefile                        |  24 +-
 arch/arm64/kvm/hyp/aarch32.c                       |   8 +-
 arch/arm64/kvm/hyp/entry.S                         |   4 +-
 arch/arm64/kvm/hyp/fpsimd.S                        |   1 -
 arch/arm64/kvm/hyp/hyp-entry.S                     |  21 +-
 .../kvm/hyp/{debug-sr.c => include/hyp/debug-sr.h} |  88 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h            | 511 +++++++++++
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h         | 193 +++++
 arch/arm64/kvm/hyp/nvhe/Makefile                   |  62 ++
 arch/arm64/kvm/hyp/nvhe/debug-sr.c                 |  77 ++
 arch/arm64/kvm/{ => hyp/nvhe}/hyp-init.S           |   5 +
 arch/arm64/kvm/hyp/nvhe/switch.c                   | 272 ++++++
 arch/arm64/kvm/hyp/nvhe/sysreg-sr.c                |  46 +
 arch/arm64/kvm/hyp/{ => nvhe}/timer-sr.c           |   6 +-
 arch/arm64/kvm/hyp/nvhe/tlb.c                      | 154 ++++
 arch/arm64/kvm/hyp/smccc_wa.S                      |  32 +
 arch/arm64/kvm/hyp/switch.c                        | 936 ---------------------
 arch/arm64/kvm/hyp/sysreg-sr.c                     | 333 --------
 arch/arm64/kvm/hyp/tlb.c                           | 242 ------
 arch/arm64/kvm/hyp/vgic-v2-cpuif-proxy.c           |   4 +-
 arch/arm64/kvm/hyp/vgic-v3-sr.c                    | 134 ++-
 arch/arm64/kvm/hyp/vhe/Makefile                    |  11 +
 arch/arm64/kvm/hyp/vhe/debug-sr.c                  |  26 +
 arch/arm64/kvm/hyp/vhe/switch.c                    | 219 +++++
 arch/arm64/kvm/hyp/vhe/sysreg-sr.c                 | 114 +++
 arch/arm64/kvm/hyp/vhe/timer-sr.c                  |  12 +
 arch/arm64/kvm/hyp/vhe/tlb.c                       | 162 ++++
 arch/arm64/kvm/inject_fault.c                      |   2 +-
 arch/arm64/kvm/mmio.c                              |   6 -
 arch/arm64/kvm/mmu.c                               | 311 ++++---
 arch/arm64/kvm/regmap.c                            |  37 +-
 arch/arm64/kvm/reset.c                             |  23 +-
 arch/arm64/kvm/sys_regs.c                          | 207 ++---
 arch/arm64/kvm/sys_regs_generic_v8.c               |  96 ---
 arch/arm64/kvm/trace_arm.h                         |   8 +-
 arch/arm64/kvm/va_layout.c                         |   2 +-
 arch/arm64/kvm/vgic/vgic-irqfd.c                   |  24 +-
 arch/arm64/kvm/vgic/vgic-its.c                     |   3 +-
 arch/arm64/kvm/vgic/vgic-mmio-v3.c                 |   2 +-
 include/kvm/arm_arch_timer.h                       |  13 +-
 include/trace/events/kvm.h                         |   2 +-
 scripts/kallsyms.c                                 |   1 +
 68 files changed, 2883 insertions(+), 2377 deletions(-)
 rename arch/arm64/kvm/hyp/{debug-sr.c => include/hyp/debug-sr.h} (66%)
 create mode 100644 arch/arm64/kvm/hyp/include/hyp/switch.h
 create mode 100644 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
 create mode 100644 arch/arm64/kvm/hyp/nvhe/Makefile
 create mode 100644 arch/arm64/kvm/hyp/nvhe/debug-sr.c
 rename arch/arm64/kvm/{ => hyp/nvhe}/hyp-init.S (95%)
 create mode 100644 arch/arm64/kvm/hyp/nvhe/switch.c
 create mode 100644 arch/arm64/kvm/hyp/nvhe/sysreg-sr.c
 rename arch/arm64/kvm/hyp/{ => nvhe}/timer-sr.c (84%)
 create mode 100644 arch/arm64/kvm/hyp/nvhe/tlb.c
 create mode 100644 arch/arm64/kvm/hyp/smccc_wa.S
 delete mode 100644 arch/arm64/kvm/hyp/switch.c
 delete mode 100644 arch/arm64/kvm/hyp/sysreg-sr.c
 delete mode 100644 arch/arm64/kvm/hyp/tlb.c
 create mode 100644 arch/arm64/kvm/hyp/vhe/Makefile
 create mode 100644 arch/arm64/kvm/hyp/vhe/debug-sr.c
 create mode 100644 arch/arm64/kvm/hyp/vhe/switch.c
 create mode 100644 arch/arm64/kvm/hyp/vhe/sysreg-sr.c
 create mode 100644 arch/arm64/kvm/hyp/vhe/timer-sr.c
 create mode 100644 arch/arm64/kvm/hyp/vhe/tlb.c
 delete mode 100644 arch/arm64/kvm/sys_regs_generic_v8.c
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
