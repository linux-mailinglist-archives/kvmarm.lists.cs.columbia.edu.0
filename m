Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2233C8225
	for <lists+kvmarm@lfdr.de>; Wed, 14 Jul 2021 11:55:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BB6854A98B;
	Wed, 14 Jul 2021 05:55:11 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g27QbAiv1yEj; Wed, 14 Jul 2021 05:55:11 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7A30B4AEE2;
	Wed, 14 Jul 2021 05:55:10 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 147ED4A5A0
 for <kvmarm@lists.cs.columbia.edu>; Wed, 14 Jul 2021 05:55:09 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P2e65QouwX9A for <kvmarm@lists.cs.columbia.edu>;
 Wed, 14 Jul 2021 05:55:07 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DA021407F1
 for <kvmarm@lists.cs.columbia.edu>; Wed, 14 Jul 2021 05:55:07 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA0851FB;
 Wed, 14 Jul 2021 02:55:06 -0700 (PDT)
Received: from monolith.cable.virginm.net (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE0DC3F774;
 Wed, 14 Jul 2021 02:55:05 -0700 (PDT)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: maz@kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu
Subject: [PATCH 0/5] KVM: arm64: Cleanups and one optimization
Date: Wed, 14 Jul 2021 10:55:56 +0100
Message-Id: <20210714095601.184854-1-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
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

The first four patches are cosmetic and aim to remove the inconsistencies I
noticed around ctxt_sys_reg/vcpu_sys_reg and how feature bits are checked.

The last patch is a minor optimization to the way KVM disables profiling
when running with VHE disabled.

Based on v5.14-rc1. The changes touch quite a lot of code, I'm happy to
rebase on another branch if necessary.

Boot tested on an odroid c4 with 4k, 16k and 64k guests running on 4k, 16k
and 64k hosts (so 3 x 3 tests in total).

Alexandru Elisei (5):
  KVM: arm64: Move vcpu_has_feature() to asm/kvm_host.h
  KVM: arm64: Use vcpu_has_feature() to check the feature bits
  KVM: arm64: Rename __vcpu_sys_reg -> vcpu_sys_reg
  KVM: arm64: Add __vcpu_sys_reg()
  KVM: arm64: nVHE: Remove unneeded isb() when modifying PMSCR_EL1

 arch/arm64/include/asm/kvm_emulate.h       |  7 +--
 arch/arm64/include/asm/kvm_host.h          | 13 +++--
 arch/arm64/kvm/arch_timer.c                | 20 ++++----
 arch/arm64/kvm/arm.c                       |  5 +-
 arch/arm64/kvm/fpsimd.c                    |  2 +-
 arch/arm64/kvm/guest.c                     |  6 +--
 arch/arm64/kvm/hyp/exception.c             |  4 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h    |  6 +--
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h | 12 ++---
 arch/arm64/kvm/hyp/nvhe/debug-sr.c         |  1 -
 arch/arm64/kvm/pmu-emul.c                  | 58 +++++++++++-----------
 arch/arm64/kvm/psci.c                      |  2 +-
 arch/arm64/kvm/reset.c                     | 12 ++---
 arch/arm64/kvm/sys_regs.c                  | 54 ++++++++++----------
 arch/arm64/kvm/sys_regs.h                  |  4 +-
 include/kvm/arm_psci.h                     |  2 +-
 16 files changed, 103 insertions(+), 105 deletions(-)

-- 
2.32.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
