Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C97052FEF5D
	for <lists+kvmarm@lfdr.de>; Thu, 21 Jan 2021 16:47:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EC1E14B150;
	Thu, 21 Jan 2021 10:47:30 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JCtyHlokvPES; Thu, 21 Jan 2021 10:47:30 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B80204B12B;
	Thu, 21 Jan 2021 10:47:29 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7F16C4B140
 for <kvmarm@lists.cs.columbia.edu>; Thu, 21 Jan 2021 10:47:28 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZBu1eZBoJpum for <kvmarm@lists.cs.columbia.edu>;
 Thu, 21 Jan 2021 10:47:27 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 850684B0D2
 for <kvmarm@lists.cs.columbia.edu>; Thu, 21 Jan 2021 10:47:27 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3963722C7B;
 Thu, 21 Jan 2021 15:47:26 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1l2cB9-009E2f-Vg; Thu, 21 Jan 2021 15:47:24 +0000
From: Marc Zyngier <maz@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: [GIT PULL] KVM/arm64 fixes for 5.11, take #2
Date: Thu, 21 Jan 2021 15:46:53 +0000
Message-Id: <20210121154653.2907836-1-maz@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: pbonzini@redhat.com, alexandru.elisei@arm.com,
 catalin.marinas@arm.com, dbrazdil@google.com, rick.p.edgecombe@intel.com,
 steven.price@arm.com, james.morse@arm.com, julien.thierry.kdev@gmail.com,
 suzuki.poulose@arm.com, kernel-team@android.com,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>, kvm@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, Steven Price <steven.price@arm.com>,
 linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
 kvmarm@lists.cs.columbia.edu
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

This is the second batch of fixes for 5.11. Mostly PMU fixes,
but also a couple of memory tagging fixes as well as a PSCI
firmware workaround.

Please pull,

	M.

The following changes since commit 45ba7b195a369f35cb39094fdb32efe5908b34ad:

  arm64: cpufeature: remove non-exist CONFIG_KVM_ARM_HOST (2021-01-05 13:22:07 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kvmarm-fixes-5.11-2

for you to fetch changes up to 139bc8a6146d92822c866cf2fd410159c56b3648:

  KVM: Forbid the use of tagged userspace addresses for memslots (2021-01-21 14:17:36 +0000)

----------------------------------------------------------------
KVM/arm64 fixes for 5.11, take #2

- Don't allow tagged pointers to point to memslots
- Filter out ARMv8.1+ PMU events on v8.0 hardware
- Hide PMU registers from userspace when no PMU is configured
- More PMU cleanups
- Don't try to handle broken PSCI firmware
- More sys_reg() to reg_to_encoding() conversions

----------------------------------------------------------------
Alexandru Elisei (1):
      KVM: arm64: Use the reg_to_encoding() macro instead of sys_reg()

David Brazdil (1):
      KVM: arm64: Allow PSCI SYSTEM_OFF/RESET to return

Marc Zyngier (4):
      KVM: arm64: Hide PMU registers from userspace when not available
      KVM: arm64: Simplify handling of absent PMU system registers
      KVM: arm64: Filter out v8.1+ events on v8.0 HW
      KVM: Forbid the use of tagged userspace addresses for memslots

Steven Price (1):
      KVM: arm64: Compute TPIDR_EL2 ignoring MTE tag

 Documentation/virt/kvm/api.rst       |  3 ++
 arch/arm64/kvm/arm.c                 |  3 +-
 arch/arm64/kvm/hyp/nvhe/psci-relay.c | 13 ++---
 arch/arm64/kvm/pmu-emul.c            | 10 ++--
 arch/arm64/kvm/sys_regs.c            | 93 ++++++++++++++++++++++--------------
 virt/kvm/kvm_main.c                  |  1 +
 6 files changed, 74 insertions(+), 49 deletions(-)
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
