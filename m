Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0357CA98
	for <lists+kvmarm@lfdr.de>; Wed, 31 Jul 2019 19:37:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6C7064A511;
	Wed, 31 Jul 2019 13:37:04 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ATsJGh6EaXh6; Wed, 31 Jul 2019 13:37:04 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2302E4A555;
	Wed, 31 Jul 2019 13:37:03 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 372674A511
 for <kvmarm@lists.cs.columbia.edu>; Wed, 31 Jul 2019 13:37:01 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EnRLQBz-hybx for <kvmarm@lists.cs.columbia.edu>;
 Wed, 31 Jul 2019 13:37:00 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1AADC4A4FA
 for <kvmarm@lists.cs.columbia.edu>; Wed, 31 Jul 2019 13:37:00 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70839337;
 Wed, 31 Jul 2019 10:36:59 -0700 (PDT)
Received: from big-swifty.lan (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD8053F71F;
 Wed, 31 Jul 2019 10:36:56 -0700 (PDT)
From: Marc Zyngier <maz@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [GIT PULL] KVM/arm updates for 5.3-rc3
Date: Wed, 31 Jul 2019 18:36:45 +0100
Message-Id: <20190731173650.12627-1-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: Anders Roxell <anders.roxell@linaro.org>, kvm@vger.kernel.org,
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

Paolo, Radim,

Here's a handful of patches for 5.3-rc3: Two actual fixes (missing
break; in the 32bit register mapping, PMU reset being broken after the
chained counter update). The rest is either cosmetic (exception
classes in debug/tracing) or silence warnings (the fall-through
explosion).

Please pull.

	M.

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kvmarm-fixes-for-5.3

for you to fetch changes up to cdb2d3ee0436d74fa9092f2df46aaa6f9e03c969:

  arm64: KVM: hyp: debug-sr: Mark expected switch fall-through (2019-07-29 11:01:37 +0100)

----------------------------------------------------------------
KVM/arm fixes for 5.3

- A bunch of switch/case fall-through annotation, fixing one actual bug
- Fix PMU reset bug
- Add missing exception class debug strings

----------------------------------------------------------------
Anders Roxell (3):
      arm64: KVM: regmap: Fix unexpected switch fall-through
      KVM: arm: vgic-v3: Mark expected switch fall-through
      arm64: KVM: hyp: debug-sr: Mark expected switch fall-through

Zenghui Yu (2):
      KVM: arm/arm64: Introduce kvm_pmu_vcpu_init() to setup PMU counter index
      KVM: arm64: Update kvm_arm_exception_class and esr_class_str for new EC

 arch/arm64/include/asm/kvm_arm.h |  7 ++++---
 arch/arm64/kernel/traps.c        |  1 +
 arch/arm64/kvm/hyp/debug-sr.c    | 30 ++++++++++++++++++++++++++++++
 arch/arm64/kvm/regmap.c          |  5 +++++
 include/kvm/arm_pmu.h            |  2 ++
 virt/kvm/arm/arm.c               |  2 ++
 virt/kvm/arm/hyp/vgic-v3-sr.c    |  8 ++++++++
 virt/kvm/arm/pmu.c               | 18 +++++++++++++++---
 8 files changed, 67 insertions(+), 6 deletions(-)
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
