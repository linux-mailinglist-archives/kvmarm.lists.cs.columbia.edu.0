Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 988CD27A96
	for <lists+kvmarm@lfdr.de>; Thu, 23 May 2019 12:35:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 812944A4EE;
	Thu, 23 May 2019 06:35:26 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dNOBKEkDS3dC; Thu, 23 May 2019 06:35:26 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3FD214A369;
	Thu, 23 May 2019 06:35:25 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 36E614A369
 for <kvmarm@lists.cs.columbia.edu>; Thu, 23 May 2019 06:35:23 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KoQbTZ1xu0sH for <kvmarm@lists.cs.columbia.edu>;
 Thu, 23 May 2019 06:35:21 -0400 (EDT)
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 94FC34A319
 for <kvmarm@lists.cs.columbia.edu>; Thu, 23 May 2019 06:35:21 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3737341;
 Thu, 23 May 2019 03:35:20 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CECA73F718;
 Thu, 23 May 2019 03:35:18 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: kvmarm@lists.cs.columbia.edu,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 00/15] arm64: KVM: add SPE profiling support for guest
Date: Thu, 23 May 2019 11:34:47 +0100
Message-Id: <20190523103502.25925-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
Cc: kvm@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
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

Hi,

This series implements support for allowing KVM guests to use the Arm
Statistical Profiling Extension (SPE).

The patches are also available on a branch[1]. The last two extra
patches are for the kvmtool if someone wants to play with it.

Regards,
Sudeep

v1->v2:
	- Rebased on v5.2-rc1
	- Adjusted sysreg_elx_s macros with merged clang build support

[1] git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git kvm_spe

Sudeep Holla (15):
  KVM: arm64: add {read,write}_sysreg_elx_s versions for new registers
  dt-bindings: ARM SPE: highlight the need for PPI partitions on
    heterogeneous systems
  arm64: KVM: reset E2PB correctly in MDCR_EL2 when exiting the
    guest(VHE)
  arm64: KVM: define SPE data structure for each vcpu
  arm64: KVM: add access handler for SPE system registers
  arm64: KVM/VHE: enable the use PMSCR_EL12 on VHE systems
  arm64: KVM: split debug save restore across vm/traps activation
  arm64: KVM/debug: drop pmscr_el1 and use sys_regs[PMSCR_EL1] in
    kvm_cpu_context
  arm64: KVM: add support to save/restore SPE profiling buffer controls
  arm64: KVM: enable conditional save/restore full SPE profiling buffer
    controls
  arm64: KVM/debug: trap all accesses to SPE controls at EL1
  KVM: arm64: add a new vcpu device control group for SPEv1
  KVM: arm64: enable SPE support
  KVMTOOL: update_headers: Sync kvm UAPI headers with linux v5.2-rc1
  KVMTOOL: kvm: add a vcpu feature for SPEv1 support

 .../devicetree/bindings/arm/spe-pmu.txt       |   5 +-
 Documentation/virtual/kvm/devices/vcpu.txt    |  28 +++
 arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts    | 185 +++++++++++-------
 arch/arm64/configs/defconfig                  |   6 +
 arch/arm64/include/asm/kvm_host.h             |  19 +-
 arch/arm64/include/asm/kvm_hyp.h              |  26 ++-
 arch/arm64/include/uapi/asm/kvm.h             |   4 +
 arch/arm64/kvm/Kconfig                        |   7 +
 arch/arm64/kvm/Makefile                       |   1 +
 arch/arm64/kvm/guest.c                        |   9 +
 arch/arm64/kvm/hyp/debug-sr.c                 |  98 +++++++---
 arch/arm64/kvm/hyp/switch.c                   |  18 +-
 arch/arm64/kvm/reset.c                        |   3 +
 arch/arm64/kvm/sys_regs.c                     |  35 ++++
 include/kvm/arm_spe.h                         |  71 +++++++
 include/uapi/linux/kvm.h                      |   1 +
 virt/kvm/arm/arm.c                            |   5 +
 virt/kvm/arm/spe.c                            | 163 +++++++++++++++
 18 files changed, 570 insertions(+), 114 deletions(-)
 create mode 100644 include/kvm/arm_spe.h
 create mode 100644 virt/kvm/arm/spe.c

--
2.17.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
