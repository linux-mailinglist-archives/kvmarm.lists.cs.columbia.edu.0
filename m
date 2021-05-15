Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6D438176B
	for <lists+kvmarm@lfdr.de>; Sat, 15 May 2021 11:59:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C17F34B7FE;
	Sat, 15 May 2021 05:59:31 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PRXE6Oqw6gEv; Sat, 15 May 2021 05:59:31 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8C1574B7CF;
	Sat, 15 May 2021 05:59:30 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6977A4B50C
 for <kvmarm@lists.cs.columbia.edu>; Sat, 15 May 2021 05:59:29 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0U8aoq4IQiNf for <kvmarm@lists.cs.columbia.edu>;
 Sat, 15 May 2021 05:59:26 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 8CAFE4B4E6
 for <kvmarm@lists.cs.columbia.edu>; Sat, 15 May 2021 05:59:26 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 72A2D61155;
 Sat, 15 May 2021 09:59:25 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1lhr4t-001X9Q-CQ; Sat, 15 May 2021 10:59:23 +0100
From: Marc Zyngier <maz@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: [GIT PULL] KVM/arm64 fixes for 5.13, take #1
Date: Sat, 15 May 2021 10:59:19 +0100
Message-Id: <20210515095919.6711-1-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: pbonzini@redhat.com, alexandru.elisei@arm.com,
 eric.auger@redhat.com, jasowang@redhat.com, mst@redhat.com, qperret@google.com,
 ricarkol@google.com, seanjc@google.com, zhangshaokun@hisilicon.com,
 yuzenghui@huawei.com, lingshan.zhu@intel.com, james.morse@arm.com,
 suzuki.poulose@arm.com, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, kvm@vger.kernel.org,
 Sean Christopherson <seanjc@google.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Shaokun Zhang <zhangshaokun@hisilicon.com>,
 linux-arm-kernel@lists.infradead.org, Zhu Lingshan <lingshan.zhu@intel.com>,
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

Here's the first batch of KVM/arm64 fixes for 5.13. we have three
regression fixes (irqbypass, debug and exception state), all that will
require some backporting into stable.

The rest is a pretty mundane set of cleanups after the last merge
window, including one from "kernel test robot", a first for KVM/arm64.

Please pull,

	M.

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kvmarm-fixes-5.13-1

for you to fetch changes up to cb853ded1d25e5b026ce115dbcde69e3d7e2e831:

  KVM: arm64: Fix debug register indexing (2021-05-15 10:27:59 +0100)

----------------------------------------------------------------
KVM/arm64 fixes for 5.13, take #1

- Fix regression with irqbypass not restarting the guest on failed connect
- Fix regression with debug register decoding resulting in overlapping access
- Commit exception state on exit to usrspace
- Fix the MMU notifier return values
- Add missing 'static' qualifiers in the new host stage-2 code

----------------------------------------------------------------
Marc Zyngier (3):
      KVM: arm64: Move __adjust_pc out of line
      KVM: arm64: Commit pending PC adjustemnts before returning to userspace
      KVM: arm64: Fix debug register indexing

Quentin Perret (2):
      KVM: arm64: Mark pkvm_pgtable_mm_ops static
      KVM: arm64: Mark the host stage-2 memory pools static

Zhu Lingshan (1):
      Revert "irqbypass: do not start cons/prod when failed connect"

kernel test robot (1):
      KVM: arm64: Fix boolreturn.cocci warnings

 arch/arm64/include/asm/kvm_asm.h           |  3 +++
 arch/arm64/kvm/arm.c                       | 11 ++++++++
 arch/arm64/kvm/hyp/exception.c             | 18 ++++++++++++-
 arch/arm64/kvm/hyp/include/hyp/adjust_pc.h | 18 -------------
 arch/arm64/kvm/hyp/nvhe/hyp-main.c         |  8 ++++++
 arch/arm64/kvm/hyp/nvhe/mem_protect.c      |  4 +--
 arch/arm64/kvm/hyp/nvhe/setup.c            |  2 +-
 arch/arm64/kvm/hyp/nvhe/switch.c           |  3 +--
 arch/arm64/kvm/hyp/vhe/switch.c            |  3 +--
 arch/arm64/kvm/mmu.c                       | 12 ++++-----
 arch/arm64/kvm/sys_regs.c                  | 42 +++++++++++++++---------------
 virt/lib/irqbypass.c                       | 16 +++++-------
 12 files changed, 77 insertions(+), 63 deletions(-)
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
