Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C1E59517CE7
	for <lists+kvmarm@lfdr.de>; Tue,  3 May 2022 08:02:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DA9724B1C9;
	Tue,  3 May 2022 02:02:12 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.788
X-Spam-Level: 
X-Spam-Status: No, score=-1.788 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CjKMTZ2rmXjO; Tue,  3 May 2022 02:02:12 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A65C64B1BD;
	Tue,  3 May 2022 02:02:11 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 37CF24B17B
 for <kvmarm@lists.cs.columbia.edu>; Tue,  3 May 2022 02:02:11 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BGEMAPkLD-je for <kvmarm@lists.cs.columbia.edu>;
 Tue,  3 May 2022 02:02:10 -0400 (EDT)
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com
 [209.85.210.201])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D31844B11E
 for <kvmarm@lists.cs.columbia.edu>; Tue,  3 May 2022 02:02:09 -0400 (EDT)
Received: by mail-pf1-f201.google.com with SMTP id
 x16-20020aa793b0000000b0050d3d5c4f4eso9016603pff.6
 for <kvmarm@lists.cs.columbia.edu>; Mon, 02 May 2022 23:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=kTAg03mTTCXeCcuJ04g4+/5QXg1dJs7XUUQ18YoBJb4=;
 b=rYqaf7w+n9R8fMyETNl8zks1oz19oMgwwIZFfSNhYFA2UP8u5AzxkwgHYcSPkBooid
 p+G9GcN5huLi7FPuX4EGni+svFvcJv16TOswggp82WXCVi9Eq/Ldj9PhDQxyIFba+VAF
 1cPMhaUJZ1KNjVL1I0dJQamZV5GPFbe9gHtBUloFbWxpJGKBsP9tjFzDKI8pYho5i1bP
 bLvoa5N6qESOumCtzSx2A3GHpXLNQ8uD2Hjx1yGC2LUWMosQW/bjTcStClrRuu1u7YeH
 952Svo9e0nL45s/DKWKHkm8/KzZj/+7M/RXUnSqcy080vsTzroFDfMi+Az3NuzVBU8Jv
 l7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=kTAg03mTTCXeCcuJ04g4+/5QXg1dJs7XUUQ18YoBJb4=;
 b=f6j/ItiwKlsF7KuIt5Twh3zsKyAkk1yI1bHIQTOAORrB9+NZlK9w6VC9H6FVaCh1+F
 n+0+O05gjyfqPKQY8Kb+TWLdissuKq9/nbko29evDvoja6BLTz8cOaDjGtFByxcKP7lk
 pfDOS1CWa/f90Fu/sRE/BimqMuXlL1v0CTHh6R5gBiKW/yK+XfmeWjADrv9n9l6tSnvt
 XtB/eB78Vn9UQuFvdB9hGnmGszNybOf6hIlvkQYSe/CbMJMyWPef+HuP+kwTkTZgTJwu
 VtqWueqnbdLlzrib3UXp7mTTlI5ifcMJfpVOKQoTKS3xoexO7C6OW9ZmPaMveqzbf7Z3
 hHgw==
X-Gm-Message-State: AOAM5307JTTglDg7r1JvHZsWI9KCUUJ+7HCGA/yn/+hphCm0lbemj7Zy
 YVre1ijsatAPaL9hecYDmcOskWcMJCgyLBcmsb+3SYvX0mhLTGU4plURgmYR0e61GhrhN2BbSN8
 VKmjEHzWrDFVPPUKnE4BbbXaP3DSzaY2HAY0jjyLzVyLhxYBYKbzfrCXS94hM9hbItKNgMA==
X-Google-Smtp-Source: ABdhPJzUW8Zgn8Un8J9KldDH91O2q0lgCYaxF4H1EN1LSeVf5TqYyQZd5GZhdrxDdg37sAXbWxGDWZSODGs=
X-Received: from oupton3.c.googlers.com
 ([fda3:e722:ac3:cc00:24:72f4:c0a8:21eb])
 (user=oupton job=sendgmr) by 2002:aa7:91c8:0:b0:50c:d1d5:3525 with SMTP id
 z8-20020aa791c8000000b0050cd1d53525mr14936138pfa.50.1651557728500; Mon, 02
 May 2022 23:02:08 -0700 (PDT)
Date: Tue,  3 May 2022 06:01:58 +0000
Message-Id: <20220503060205.2823727-1-oupton@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v4 0/7] KVM: arm64: Limit feature register reads from AArch32
From: Oliver Upton <oupton@google.com>
To: kvmarm@lists.cs.columbia.edu
Cc: kvm@vger.kernel.org, maz@kernel.org, linux-kernel@vger.kernel.org,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

KVM/arm64 does not restrict the guest's view of the AArch32 feature
registers when read from AArch32. HCR_EL2.TID3 is cleared for AArch32
guests, meaning that register reads come straight from hardware. This is
problematic as KVM relies on read_sanitised_ftr_reg() to expose a set of
features consistent for a particular system.

Appropriate handlers must first be put in place for CP10 and CP15 ID
register accesses before setting TID3. Rather than exhaustively
enumerating each of the encodings for CP10 and CP15 registers, take the
lazy route and aim the register accesses at the AArch64 system register
table.

Patches 1-2 are small cleanups to how we handle register emulation
failure. No functional change for current KVM, but required to do
register emulation correctly in this series.

Patch 3 reroutes the CP15 registers into the AArch64 table, taking care
to immediately RAZ undefined ranges of registers. This is done to avoid
possibly conflicting with encodings for future AArch64 registers.

Patch 4 installs an exit handler for the CP10 ID registers and also
relies on the general AArch64 register handler to implement reads.

Patch 5 actually sets TID3 for AArch32 guests, providing known-safe
values for feature register accesses.

Patch 6 makes KVM UNDEF the guest on an unsupported PMU reg access.
Finally, patch 7 drops the intermediate fix of returning early from
register accesses if the PMU is disabled.

There is an argument that the series is in fact a bug fix for running
AArch32 VMs on heterogeneous systems. To that end, it could be
blamed/backported to when we first knew better:

  93390c0a1b20 ("arm64: KVM: Hide unsupported AArch64 CPU features from
  guests")

But I left that tag off as in the aforementioned change skipping
AArch32 was intentional. Up to you, Marc, if you want to call it a
bugfix ;-)

Applies cleanly to 5.18-rc5.

Tested with AArch32 kvm-unit-tests and booting an AArch32 debian guest
on a Raspberry Pi 4. Additionally, I tested AArch32 kvm-unit-tests w/
pmu={on,off} and saw no splat, as Alex had discovered [1]. The test
correctly skips with the PMU feature bit disabled now.

Furthermore, I hacked up the test even more to ignore ID_DFR0.PerfMon to
verify that the guest UNDEFs when the PMU is disabled (and doesn't blow
up the host kernel).

[1]: https://lore.kernel.org/r/20220425145530.723858-1-alexandru.elisei@arm.com

v1: https://lore.kernel.org/kvmarm/20220329011301.1166265-1-oupton@google.com/
v2: https://lore.kernel.org/r/20220401010832.3425787-1-oupton@google.com
v3: https://lore.kernel.org/kvmarm/20220425235342.3210912-1-oupton@google.com

v3 -> v4:
  - Grab Alex's patch for using pmu_visibility() to hide PMU regs
  - Revert Alex's intermediate fix of silently sinking PMU reg
    read/writes

v2 -> v3:
  - Collect R-b from Reiji (thanks!)
  - Adopt Marc's suggestion for CP15 register handling
  - Avoid writing to Rt when emulation fails (Marc)
  - Print some debug info on an unexpected CP10 register access (Reiji)

v1 -> v2:
  - Actually set TID3! Oops.
  - Refactor kvm_emulate_cp15_id_reg() to check preconditions before
    proceeding to emulation (Reiji)
  - Tighten up comment on kvm_is_cp15_id_reg() to indicate that the only
    other trapped ID register (CTR) is already handled in the cp15

Alexandru Elisei (1):
  KVM/arm64: Hide AArch32 PMU registers when not available

Oliver Upton (6):
  KVM: arm64: Return a bool from emulate_cp()
  KVM: arm64: Don't write to Rt unless sys_reg emulation succeeds
  KVM: arm64: Wire up CP15 feature registers to their AArch64
    equivalents
  KVM: arm64: Plumb cp10 ID traps through the AArch64 sysreg handler
  KVM: arm64: Start trapping ID registers for 32 bit guests
  Revert "KVM/arm64: Don't emulate a PMU for 32-bit guests if feature
    not set"

 arch/arm64/include/asm/kvm_arm.h     |   3 +-
 arch/arm64/include/asm/kvm_emulate.h |   7 -
 arch/arm64/include/asm/kvm_host.h    |   1 +
 arch/arm64/kvm/handle_exit.c         |   1 +
 arch/arm64/kvm/pmu-emul.c            |  23 +--
 arch/arm64/kvm/sys_regs.c            | 257 +++++++++++++++++++++------
 arch/arm64/kvm/sys_regs.h            |   9 +-
 7 files changed, 211 insertions(+), 90 deletions(-)

-- 
2.36.0.464.gb9c8b46e94-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
