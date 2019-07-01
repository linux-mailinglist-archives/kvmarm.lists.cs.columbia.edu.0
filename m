Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 523BE4CCCA
	for <lists+kvmarm@lfdr.de>; Thu, 20 Jun 2019 13:23:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 454664A4F7;
	Thu, 20 Jun 2019 07:23:15 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 35krjt-cQzjr; Thu, 20 Jun 2019 07:23:15 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0A8C44A4C1;
	Thu, 20 Jun 2019 07:23:14 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 219E94A389
 for <kvmarm@lists.cs.columbia.edu>; Thu, 20 Jun 2019 07:23:13 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GPQV8rswpbPl for <kvmarm@lists.cs.columbia.edu>;
 Thu, 20 Jun 2019 07:23:11 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B28E14A379
 for <kvmarm@lists.cs.columbia.edu>; Thu, 20 Jun 2019 07:23:11 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26A53360;
 Thu, 20 Jun 2019 04:23:11 -0700 (PDT)
Received: from filthy-habits.cambridge.arm.com
 (filthy-habits.cambridge.arm.com [10.1.197.61])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A77BC3F718;
 Thu, 20 Jun 2019 04:23:09 -0700 (PDT)
From: Marc Zyngier <marc.zyngier@arm.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [GIT PULL] KVM/arm fixes for 5.2-rc6
Date: Thu, 20 Jun 2019 12:22:57 +0100
Message-Id: <20190620112301.138137-1-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
 kvmarm@lists.cs.columbia.edu, Dave Martin <Dave.Martin@arm.com>,
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

Paolo, Radim,

Here's the second (and hopefully last) set of fixes for v5.2. We have
our usual timer fix (we obviously will never get it right), a memory
leak plug, a sysreg reporting fix, and an small SVE cleanup.

Please pull.

	M.

The following changes since commit 623e1528d4090bd1abaf93ec46f047dee9a6fb32:

  KVM: arm/arm64: Move cc/it checks under hyp's Makefile to avoid instrumentation (2019-05-24 14:53:20 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kvmarm-fixes-for-5.2-2

for you to fetch changes up to e4e5a865e9a9e8e47ac1959b629e9f3ae3b062f2:

  KVM: arm/arm64: Fix emulated ptimer irq injection (2019-06-19 15:47:52 +0100)

----------------------------------------------------------------
KVM/arm fixes for 5.2, take #2

- SVE cleanup killing a warning with ancient GCC versions
- Don't report non-existent system registers to userspace
- Fix memory leak when freeing the vgic ITS
- Properly lower the interrupt on the emulated physical timer

----------------------------------------------------------------
Andrew Jones (1):
      KVM: arm/arm64: Fix emulated ptimer irq injection

Dave Martin (2):
      KVM: arm64: Filter out invalid core register IDs in KVM_GET_REG_LIST
      KVM: arm/arm64: vgic: Fix kvm_device leak in vgic_its_destroy

Viresh Kumar (1):
      KVM: arm64: Implement vq_present() as a macro

 arch/arm64/kvm/guest.c       | 65 +++++++++++++++++++++++++++++---------------
 virt/kvm/arm/arch_timer.c    |  5 ++--
 virt/kvm/arm/vgic/vgic-its.c |  1 +
 3 files changed, 47 insertions(+), 24 deletions(-)
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
