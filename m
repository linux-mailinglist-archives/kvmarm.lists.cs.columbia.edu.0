Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 09E1B2D7A52
	for <lists+kvmarm@lfdr.de>; Fri, 11 Dec 2020 17:00:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 909744B311;
	Fri, 11 Dec 2020 11:00:17 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zcpbeiPTgbGm; Fri, 11 Dec 2020 11:00:17 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 36BB14B2F8;
	Fri, 11 Dec 2020 11:00:16 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3BBD04B2BE
 for <kvmarm@lists.cs.columbia.edu>; Fri, 11 Dec 2020 11:00:15 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yINzhw+DkP7j for <kvmarm@lists.cs.columbia.edu>;
 Fri, 11 Dec 2020 11:00:13 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 524384B28C
 for <kvmarm@lists.cs.columbia.edu>; Fri, 11 Dec 2020 11:00:13 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1BFB31B;
 Fri, 11 Dec 2020 08:00:12 -0800 (PST)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.195.35])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE6493F66B;
 Fri, 11 Dec 2020 08:00:10 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Marc Zyngier <maz@kernel.org>
Subject: [PATCH v4 0/5] ARM: arm64: Add SMCCC TRNG entropy service
Date: Fri, 11 Dec 2020 16:00:00 +0000
Message-Id: <20201211160005.187336-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Theodore Ts'o <tytso@mit.edu>, Linus Walleij <linus.walleij@linaro.org>,
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Sudeep Holla <sudeep.holla@arm.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
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

a small update to v3, fixing the rare build issue the kernel test robot
pointed out, and changing the priority of the SMCCC vs. RNDR call in
the arm64 patch, as per discussion with Ard.
Adding tags on the way. Changelog below.

Cheers,
Andre
==============================

The ARM architected TRNG firmware interface, described in ARM spec
DEN0098[1], defines an ARM SMCCC based interface to a true random number
generator, provided by firmware.

This series collects all the patches implementing this in various
places: as a user feeding into the ARCH_RANDOM pool, both for ARM and
arm64, and as a service provider for KVM guests.

Patch 1 introduces the interface definition used by all three entities.
Patch 2 prepares the Arm SMCCC firmware driver to probe for the
interface. This patch is needed to avoid a later dependency on *two*
patches (there might be a better solution to this problem).

Patch 3 implements the ARM part, patch 4 is the arm64 version.
The final patch 5 adds support to provide random numbers to KVM guests.

This was tested on:
- QEMU -kernel (no SMCCC, regression test)
- Juno w/ prototype of the h/w Trusted RNG support
- mainline KVM (SMCCC, but no TRNG: regression test)
- ARM and arm64 KVM guests, using the KVM service in patch 5/5

Based on arm64/for-next/core, please let me know if I should rebased on
something else. A git repo is accessible at:
https://gitlab.arm.com/linux-arm/linux-ap/-/commits/smccc-trng/v4/

Cheers,
Andre

[1] https://developer.arm.com/documentation/den0098/latest/

Changelog v3 ... v4:
- include cache.h to always have __ro_after_init defined
- change order of SMCCC call vs. RNDR call in arm64's archrandom.h
- adding LinusW's R-b: tags

Changelog v2 ... v3:
- ARM: fix compilation with randconfig
- arm64: use SMCCC call also in arch_get_random_seed_long_early()
- KVM: comment on return value usage
- KVM: use more interesting UUID (enjoy, Marc!)
- KVM: use bitmaps instead of open coded long arrays
- KVM: drop direct usage of arch_get_random() interface

Changelog "v1" ... v2:
- trigger ARCH_RANDOM initialisation from the SMCCC firmware driver
- use a single bool in smccc.c to hold the initialisation state for arm64
- handle endianess correctly in the KVM provider

Andre Przywara (2):
  firmware: smccc: Introduce SMCCC TRNG framework
  arm64: Add support for SMCCC TRNG entropy source

Ard Biesheuvel (3):
  firmware: smccc: Add SMCCC TRNG function call IDs
  ARM: implement support for SMCCC TRNG entropy source
  KVM: arm64: implement the TRNG hypervisor call

 arch/arm/Kconfig                    |  4 ++
 arch/arm/include/asm/archrandom.h   | 74 +++++++++++++++++++++++++
 arch/arm64/include/asm/archrandom.h | 82 ++++++++++++++++++++++++----
 arch/arm64/include/asm/kvm_host.h   |  2 +
 arch/arm64/kvm/Makefile             |  2 +-
 arch/arm64/kvm/hypercalls.c         |  6 ++
 arch/arm64/kvm/trng.c               | 85 +++++++++++++++++++++++++++++
 drivers/firmware/smccc/smccc.c      |  6 ++
 include/linux/arm-smccc.h           | 31 +++++++++++
 9 files changed, 281 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm/include/asm/archrandom.h
 create mode 100644 arch/arm64/kvm/trng.c

-- 
2.17.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
