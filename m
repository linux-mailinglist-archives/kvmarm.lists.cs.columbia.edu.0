Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5C4190B0E
	for <lists+kvmarm@lfdr.de>; Tue, 24 Mar 2020 11:34:06 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AABAA4B0B2;
	Tue, 24 Mar 2020 06:34:05 -0400 (EDT)
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
	with ESMTP id TvK3B3M63XvW; Tue, 24 Mar 2020 06:34:04 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AFEDF4B099;
	Tue, 24 Mar 2020 06:34:03 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0CDF44B08D
 for <kvmarm@lists.cs.columbia.edu>; Tue, 24 Mar 2020 06:34:03 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZNUA07749SbV for <kvmarm@lists.cs.columbia.edu>;
 Tue, 24 Mar 2020 06:34:01 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 862174A4C0
 for <kvmarm@lists.cs.columbia.edu>; Tue, 24 Mar 2020 06:34:01 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4549620775;
 Tue, 24 Mar 2020 10:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1585046040;
 bh=bYlBEjd/f1p/2lpvFc3jhEpDR9HQLFUZ/kLJ31B5CWc=;
 h=From:To:Cc:Subject:Date:From;
 b=0RrKWVxxqJHLXM6u84gaBr9v6otD8EJJEHV2pLdXJW4KlWoISLAFAHD93FfrSI5eY
 +a19wUmSXRSfxWF0VILZPLNuekrclWG2p4pGHE/dey82+f2/S6Ax8ZVyzVv5LCTxXE
 Rs5Xr4f7CNlNaJmR6827T9uEjKOg0d4sEVtLFMW0=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jGgsg-00FE8V-FA; Tue, 24 Mar 2020 10:33:58 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: [PATCH v2 0/7] Removing support for 32bit KVM/arm host
Date: Tue, 24 Mar 2020 10:33:43 +0000
Message-Id: <20200324103350.138077-1-maz@kernel.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, olof@lixom.net,
 arnd@arndb.de, will@kernel.org, vladimir.murzin@arm.com,
 catalin.marinas@arm.com, linus.walleij@linaro.org, christoffer.dall@arm.com,
 james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
 pbonzini@redhat.com, qperret@google.com, linux@arm.linux.org.uk,
 stefan@agner.ch, jan.kiszka@siemens.com, krzk@kernel.org,
 b.zolnierkie@samsung.com, m.szyprowski@samsung.com, takashi@yoshi.email,
 daniel@makrotopia.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Takashi Yoshi <takashi@yoshi.email>, Russell King <linux@arm.linux.org.uk>,
 Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Linus Walleij <linus.walleij@linaro.org>, Daniel Golle <daniel@makrotopia.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>,
 Olof Johansson <olof@lixom.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Will Deacon <will@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>
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

KVM/arm was merged just over 7 years ago, and has lived a very quiet
life so far. It mostly works if you're prepared to deal with its
limitations, it has been a good prototype for the arm64 version,
but it suffers a few problems:

- It is incomplete (no debug support, no PMU)
- It hasn't followed any of the architectural evolutions
- It has zero^W very few users (I don't count myself here)
- It is more and more getting in the way of new arm64 developments

There has been quite a bit of discussion (see [1]) on whether we were
depriving users of something they were depending on. Most people
didn't object, and actually supported the removal. A few people *did*
object to the removal:

- Takashi uses it on a regular basis for developments
- Daniel uses it as well, although he doesn't depend on it
- Marek and Bartlomiej said that Samsung use it internally, without
  any description of their usage model

Alghouth I can really sympathetize with people above, I still don't
think we should keep the 32bit port artificially alive for the sake of
it, specially considering that the whole of the 32bit architecture is
in best effort, maintenance mode. I'd rather drop KVM support now,
while it is still in a decent shape, rather than seeing it bit-rot
like it happened for ia64. I also plan to keep maintaining it in the
various stable kernels, up to (and including) 5.6.

To reiterate: 32bit guest support for arm64 stays, of course. Only
32bit host goes. Once this is merged, I plan to move virt/kvm/arm to
arm64, and cleanup all the now unnecessary abstractions.

The patches have been generated with the -D option to avoid spamming
everyone with huge diffs, and there is a kvm-arm/goodbye branch in
my kernel.org repository.

* From v1:
  - Rebased on top of kvmarm/next
  - Simplified the HYP vector replacement code
  - Updated the MAINTAINERS file
  - Collected Acks

[1] https://lore.kernel.org/linux-arm-kernel/20200210141324.21090-1-maz@kernel.org/

Marc Zyngier (7):
  arm: Unplug KVM from the build system
  arm: Remove KVM from config files
  arm: Remove 32bit KVM host support
  arm: Remove HYP/Stage-2 page-table support
  arm: Remove GICv3 vgic compatibility macros
  arm: Remove the ability to set HYP vectors outside of the decompressor
  MAINTAINERS: RIP KVM/arm

 Documentation/virt/kvm/arm/hyp-abi.rst |    5 +
 MAINTAINERS                            |    5 +-
 arch/arm/Kconfig                       |    2 -
 arch/arm/Makefile                      |    1 -
 arch/arm/configs/axm55xx_defconfig     |    2 -
 arch/arm/include/asm/arch_gicv3.h      |  114 --
 arch/arm/include/asm/kvm_arm.h         |  239 ----
 arch/arm/include/asm/kvm_asm.h         |   77 --
 arch/arm/include/asm/kvm_coproc.h      |   36 -
 arch/arm/include/asm/kvm_emulate.h     |  372 ------
 arch/arm/include/asm/kvm_host.h        |  457 --------
 arch/arm/include/asm/kvm_hyp.h         |  127 ---
 arch/arm/include/asm/kvm_mmu.h         |  435 -------
 arch/arm/include/asm/kvm_ras.h         |   14 -
 arch/arm/include/asm/pgtable-3level.h  |   20 -
 arch/arm/include/asm/pgtable.h         |    9 -
 arch/arm/include/asm/sections.h        |    6 +-
 arch/arm/include/asm/stage2_pgtable.h  |   75 --
 arch/arm/include/asm/virt.h            |   17 -
 arch/arm/include/uapi/asm/kvm.h        |  314 -----
 arch/arm/kernel/asm-offsets.c          |   11 -
 arch/arm/kernel/hyp-stub.S             |   39 +-
 arch/arm/kernel/vmlinux-xip.lds.S      |    8 -
 arch/arm/kernel/vmlinux.lds.S          |    8 -
 arch/arm/kernel/vmlinux.lds.h          |   10 -
 arch/arm/kvm/Kconfig                   |   59 -
 arch/arm/kvm/Makefile                  |   43 -
 arch/arm/kvm/coproc.c                  | 1455 ------------------------
 arch/arm/kvm/coproc.h                  |  130 ---
 arch/arm/kvm/coproc_a15.c              |   39 -
 arch/arm/kvm/coproc_a7.c               |   42 -
 arch/arm/kvm/emulate.c                 |  166 ---
 arch/arm/kvm/guest.c                   |  387 -------
 arch/arm/kvm/handle_exit.c             |  175 ---
 arch/arm/kvm/hyp/Makefile              |   34 -
 arch/arm/kvm/hyp/banked-sr.c           |   70 --
 arch/arm/kvm/hyp/cp15-sr.c             |   72 --
 arch/arm/kvm/hyp/entry.S               |  121 --
 arch/arm/kvm/hyp/hyp-entry.S           |  295 -----
 arch/arm/kvm/hyp/s2-setup.c            |   22 -
 arch/arm/kvm/hyp/switch.c              |  242 ----
 arch/arm/kvm/hyp/tlb.c                 |   68 --
 arch/arm/kvm/hyp/vfp.S                 |   57 -
 arch/arm/kvm/init.S                    |  157 ---
 arch/arm/kvm/interrupts.S              |   36 -
 arch/arm/kvm/irq.h                     |   16 -
 arch/arm/kvm/reset.c                   |   86 --
 arch/arm/kvm/trace.h                   |   86 --
 arch/arm/kvm/vgic-v3-coproc.c          |   27 -
 arch/arm/mach-exynos/Kconfig           |    2 +-
 arch/arm/mm/mmu.c                      |   26 -
 51 files changed, 16 insertions(+), 6300 deletions(-)
 delete mode 100644 arch/arm/include/asm/kvm_arm.h
 delete mode 100644 arch/arm/include/asm/kvm_asm.h
 delete mode 100644 arch/arm/include/asm/kvm_coproc.h
 delete mode 100644 arch/arm/include/asm/kvm_emulate.h
 delete mode 100644 arch/arm/include/asm/kvm_host.h
 delete mode 100644 arch/arm/include/asm/kvm_hyp.h
 delete mode 100644 arch/arm/include/asm/kvm_mmu.h
 delete mode 100644 arch/arm/include/asm/kvm_ras.h
 delete mode 100644 arch/arm/include/asm/stage2_pgtable.h
 delete mode 100644 arch/arm/include/uapi/asm/kvm.h
 delete mode 100644 arch/arm/kvm/Kconfig
 delete mode 100644 arch/arm/kvm/Makefile
 delete mode 100644 arch/arm/kvm/coproc.c
 delete mode 100644 arch/arm/kvm/coproc.h
 delete mode 100644 arch/arm/kvm/coproc_a15.c
 delete mode 100644 arch/arm/kvm/coproc_a7.c
 delete mode 100644 arch/arm/kvm/emulate.c
 delete mode 100644 arch/arm/kvm/guest.c
 delete mode 100644 arch/arm/kvm/handle_exit.c
 delete mode 100644 arch/arm/kvm/hyp/Makefile
 delete mode 100644 arch/arm/kvm/hyp/banked-sr.c
 delete mode 100644 arch/arm/kvm/hyp/cp15-sr.c
 delete mode 100644 arch/arm/kvm/hyp/entry.S
 delete mode 100644 arch/arm/kvm/hyp/hyp-entry.S
 delete mode 100644 arch/arm/kvm/hyp/s2-setup.c
 delete mode 100644 arch/arm/kvm/hyp/switch.c
 delete mode 100644 arch/arm/kvm/hyp/tlb.c
 delete mode 100644 arch/arm/kvm/hyp/vfp.S
 delete mode 100644 arch/arm/kvm/init.S
 delete mode 100644 arch/arm/kvm/interrupts.S
 delete mode 100644 arch/arm/kvm/irq.h
 delete mode 100644 arch/arm/kvm/reset.c
 delete mode 100644 arch/arm/kvm/trace.h
 delete mode 100644 arch/arm/kvm/vgic-v3-coproc.c

-- 
2.25.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
