Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BB6721F9868
	for <lists+kvmarm@lfdr.de>; Mon, 15 Jun 2020 15:27:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4E1E24B0D4;
	Mon, 15 Jun 2020 09:27:42 -0400 (EDT)
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
	with ESMTP id SGrE+Z8zwAvR; Mon, 15 Jun 2020 09:27:42 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 252284B0CE;
	Mon, 15 Jun 2020 09:27:41 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 616704B0C5
 for <kvmarm@lists.cs.columbia.edu>; Mon, 15 Jun 2020 09:27:39 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YmhG-d4SooGY for <kvmarm@lists.cs.columbia.edu>;
 Mon, 15 Jun 2020 09:27:38 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 157824B0C4
 for <kvmarm@lists.cs.columbia.edu>; Mon, 15 Jun 2020 09:27:38 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F406C2076A;
 Mon, 15 Jun 2020 13:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592227657;
 bh=9rXX3St0gyy0cTMyqFQv3mfQFAVGLbJH7AnbHDQvyWY=;
 h=From:To:Cc:Subject:Date:From;
 b=wlUidK9j/8zdhOhocC7y990TOqgjNJDafCwh15HYlHvOMQ/7KwvNsNsKnpvefTn16
 1LyYNckt6R7ooyW0JWEO0Ahn5NyZ3CJA/QQoY8BkemQiDvHQNtExFA7kNxE4+61cVp
 s3w9YgzCShjsPPqn36Hj5XcMpZem07p+M2cJEzxE=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jkp9D-0036w9-Eo; Mon, 15 Jun 2020 14:27:35 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: [PATCH v2 00/17] KVM: arm64: Preliminary NV patches
Date: Mon, 15 Jun 2020 14:27:02 +0100
Message-Id: <20200615132719.1932408-1-maz@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, andre.przywara@arm.com,
 christoffer.dall@arm.com, Dave.Martin@arm.com, jintack@cs.columbia.edu,
 alexandru.elisei@arm.com, gcherian@marvell.com, prime.zeng@hisilicon.com,
 ascull@google.com, will@kernel.org, catalin.marinas@arm.com,
 mark.rutland@arm.com, james.morse@arm.com, julien.thierry.kdev@gmail.com,
 suzuki.poulose@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, Will Deacon <will@kernel.org>,
 Andre Przywara <andre.przywara@arm.com>, Dave Martin <Dave.Martin@arm.com>,
 George Cherian <gcherian@marvell.com>,
 "Zengtao \(B\)" <prime.zeng@hisilicon.com>,
 Catalin Marinas <catalin.marinas@arm.com>
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

Hi all,

In order not to repeat the 90+ patch series that resulted in a
deafening silence last time, I've extracted a smaller set of patches
that form the required dependencies that allow the rest of the 65 NV
patches to be added on top. Yes, it is that bad.

The one real feature here is support for the ARMv8.4-TTL extension at
Stage-2 only. The reason to support it is that it helps the hypervisor
a lot when it comes to finding out how much to invalidate. It is thus
always "supported" with NV.

The rest doesn't contain any functionality change. Most of it reworks
existing data structures and adds new accessors for the things that
get moved around. The reason for this is that:

- With NV, we end-up with multiple Stage-2 MMU contexts per VM instead
  of a single one. This requires we divorce struct kvm from the S2 MMU
  configuration. Of course, we stick with a single MMU context for now.

- With ARMv8.4-NV, a number of system register accesses are turned
  into memory accesses into the so-called VNCR page. It is thus
  convenient to make this VNCR page part of the vcpu context and avoid
  copying data back and forth. For this to work, we need to make sure
  that all the VNCR-aware sysregs are moved into our per-vcpu sys_regs
  array instead of leaving in other data structures (the timers, for
  example). The VNCR page itself isn't introduced with these patches.

- As some of these data structures change, we need a way to isolate
  the userspace ABI from such change.

There is also a number of cleanups that were in the full fat series
that I decided to move early to get them out of the way.

The whole this is a bit of a mix of vaguely unrelated "stuff", but it
all comes together if you look at the final series[1]. This applies on
top of v5.8-rc1.

I plan on taking this early into v5.9, and I really mean it this time!

[1] https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=kvm-arm64/nv-5.8-rc1-WIP

* From v1:
  - A bunch of patches have been merged. These are the current leftovers.
  - Rebased on top of v5.8-rc1, and it wasn't fun.

Christoffer Dall (1):
  KVM: arm64: Factor out stage 2 page table data from struct kvm

Marc Zyngier (16):
  arm64: Detect the ARMv8.4 TTL feature
  arm64: Document SW reserved PTE/PMD bits in Stage-2 descriptors
  arm64: Add level-hinted TLB invalidation helper
  KVM: arm64: Use TTL hint in when invalidating stage-2 translations
  KVM: arm64: Introduce accessor for ctxt->sys_reg
  KVM: arm64: hyp: Use ctxt_sys_reg/__vcpu_sys_reg instead of raw
    sys_regs access
  KVM: arm64: sve: Use __vcpu_sys_reg() instead of raw sys_regs access
  KVM: arm64: pauth: Use ctxt_sys_reg() instead of raw sys_regs access
  KVM: arm64: debug: Use ctxt_sys_reg() instead of raw sys_regs access
  KVM: arm64: Make struct kvm_regs userspace-only
  KVM: arm64: Move ELR_EL1 to the system register array
  KVM: arm64: Move SP_EL1 to the system register array
  KVM: arm64: Disintegrate SPSR array
  KVM: arm64: Move SPSR_EL1 to the system register array
  KVM: arm64: timers: Rename kvm_timer_sync_hwstate to
    kvm_timer_sync_user
  KVM: arm64: timers: Move timer registers to the sys_regs file

 arch/arm64/include/asm/cpucaps.h        |   3 +-
 arch/arm64/include/asm/kvm_asm.h        |   8 +-
 arch/arm64/include/asm/kvm_emulate.h    |  37 +---
 arch/arm64/include/asm/kvm_host.h       |  71 ++++--
 arch/arm64/include/asm/kvm_mmu.h        |  16 +-
 arch/arm64/include/asm/pgtable-hwdef.h  |   2 +
 arch/arm64/include/asm/stage2_pgtable.h |   9 +
 arch/arm64/include/asm/sysreg.h         |   1 +
 arch/arm64/include/asm/tlbflush.h       |  45 ++++
 arch/arm64/kernel/asm-offsets.c         |   3 +-
 arch/arm64/kernel/cpufeature.c          |  11 +
 arch/arm64/kvm/arch_timer.c             | 157 ++++++++++---
 arch/arm64/kvm/arm.c                    |  40 ++--
 arch/arm64/kvm/fpsimd.c                 |   6 +-
 arch/arm64/kvm/guest.c                  |  79 +++++--
 arch/arm64/kvm/hyp/debug-sr.c           |  18 +-
 arch/arm64/kvm/hyp/entry.S              |   3 +-
 arch/arm64/kvm/hyp/switch.c             |  46 ++--
 arch/arm64/kvm/hyp/sysreg-sr.c          | 152 ++++++-------
 arch/arm64/kvm/hyp/tlb.c                |  55 +++--
 arch/arm64/kvm/inject_fault.c           |   2 +-
 arch/arm64/kvm/mmu.c                    | 279 ++++++++++++++----------
 arch/arm64/kvm/regmap.c                 |  37 +++-
 arch/arm64/kvm/reset.c                  |   2 +-
 arch/arm64/kvm/sys_regs.c               |   2 +
 arch/arm64/kvm/trace_arm.h              |   8 +-
 include/kvm/arm_arch_timer.h            |  13 +-
 27 files changed, 685 insertions(+), 420 deletions(-)

-- 
2.27.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
