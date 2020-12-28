Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D45702E3611
	for <lists+kvmarm@lfdr.de>; Mon, 28 Dec 2020 11:50:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8A56C4B20F;
	Mon, 28 Dec 2020 05:50:15 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6Q8lo91nuboT; Mon, 28 Dec 2020 05:50:14 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8732A4B147;
	Mon, 28 Dec 2020 05:50:11 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D9A3B4B210
 for <kvmarm@lists.cs.columbia.edu>; Mon, 28 Dec 2020 05:50:08 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bLXkxjeKuYdN for <kvmarm@lists.cs.columbia.edu>;
 Mon, 28 Dec 2020 05:50:05 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 8C9594B1EA
 for <kvmarm@lists.cs.columbia.edu>; Mon, 28 Dec 2020 05:50:05 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4A88A2242A;
 Mon, 28 Dec 2020 10:50:04 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1ktq6E-0048wX-1h; Mon, 28 Dec 2020 10:50:02 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.cs.columbia.edu
Subject: [PATCH 00/17] arm64: Early CPU feature override,
 and an application to VHE
Date: Mon, 28 Dec 2020 10:49:41 +0000
Message-Id: <20201228104958.1848833-1-maz@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, catalin.marinas@arm.com, will@kernel.org,
 mark.rutland@arm.com, dbrazdil@google.com, alexandru.elisei@arm.com,
 ardb@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com,
 suzuki.poulose@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>
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

It recently came to light that there is a need to be able to override
some CPU features very early on, before the kernel is fully up and
running. The reasons for this range from specific feature support
(such as using Protected KVM on VHE HW, which is the main motivation
for this work) to errata workaround (a feature is broken on a CPU and
needs to be turned off, or rather not enabled).

This series tries to offer a limited framework for this kind of
problems, by allowing a set of options to be passed on the
command-line and altering the feature set that the cpufeature
subsystem exposes to the rest of the kernel. Note that this doesn't
change anything for code that directly uses the CPU ID registers.

The series completely changes the way a VHE-capable arm64 boots, by
*always* booting non-VHE first, and then upgrading to VHE when deemed
capable. Although this sounds scary, this is actually simple to
implement (and I wish I had though of it five years ago). The "upgrade
to VHE" path is then conditioned on the VHE feature not being disabled
from the command-line.

Said command-line parsing borrows a lot from the kaslr code, and
subsequently allows the "nokaslr" option to be moved to the new
infrastructure (though it all looks a bit... odd).

This has been tested on multiple VHE and non-VHE systems.

Marc Zyngier (17):
  arm64: Fix labels in el2_setup macros
  arm64: Fix outdated TCR setup comment
  arm64: Turn the MMU-on sequence into a macro
  arm64: Provide an 'upgrade to VHE' stub hypercall
  arm64: Initialise as nVHE before switching to VHE
  arm64: Move VHE-specific SPE setup to mutate_to_vhe()
  arm64: Simplify init_el2_state to be non-VHE only
  arm64: Move SCTLR_EL1 initialisation to EL-agnostic code
  arm64: cpufeature: Add global feature override facility
  arm64: Extract early FDT mapping from kaslr_early_init()
  arm64: cpufeature: Add an early command-line cpufeature override
    facility
  arm64: Allow ID_AA64MMFR1_EL1.VH to be overridden from the command
    line
  arm64: Honor VHE being disabled from the command-line
  arm64: Add an aliasing facility for the idreg override
  arm64: Make kvm-arm.mode={nvhe,protected} an alias of
    id_aa64mmfr1.vh=0
  KVM: arm64: Document HVC_VHE_RESTART stub hypercall
  arm64: Move "nokaslr" over to the early cpufeature infrastructure

 .../admin-guide/kernel-parameters.txt         |   3 +
 Documentation/virt/kvm/arm/hyp-abi.rst        |   9 +
 arch/arm64/include/asm/assembler.h            |  17 ++
 arch/arm64/include/asm/cpufeature.h           |   5 +
 arch/arm64/include/asm/el2_setup.h            |  60 +++----
 arch/arm64/include/asm/setup.h                |  11 ++
 arch/arm64/include/asm/virt.h                 |   7 +-
 arch/arm64/kernel/Makefile                    |   2 +-
 arch/arm64/kernel/cpufeature.c                |  32 +++-
 arch/arm64/kernel/head.S                      |  71 ++------
 arch/arm64/kernel/hyp-stub.S                  | 117 ++++++++++++-
 arch/arm64/kernel/idreg-override.c            | 161 ++++++++++++++++++
 arch/arm64/kernel/kaslr.c                     |  44 +----
 arch/arm64/kernel/setup.c                     |  15 ++
 arch/arm64/kvm/arm.c                          |   3 +
 arch/arm64/kvm/hyp/nvhe/hyp-init.S            |   2 +-
 arch/arm64/mm/proc.S                          |  16 +-
 17 files changed, 415 insertions(+), 160 deletions(-)
 create mode 100644 arch/arm64/include/asm/setup.h
 create mode 100644 arch/arm64/kernel/idreg-override.c

-- 
2.29.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
