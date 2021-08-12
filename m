Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2DED13E9DCB
	for <lists+kvmarm@lfdr.de>; Thu, 12 Aug 2021 07:09:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9958F4A1A7;
	Thu, 12 Aug 2021 01:09:28 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JQidLEc7F1Zo; Thu, 12 Aug 2021 01:09:24 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1E54F4A19F;
	Thu, 12 Aug 2021 01:09:20 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1A67340569
 for <kvmarm@lists.cs.columbia.edu>; Thu, 12 Aug 2021 01:09:19 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RhcJMpCImWl0 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 12 Aug 2021 01:09:14 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9B491402C0
 for <kvmarm@lists.cs.columbia.edu>; Thu, 12 Aug 2021 01:09:14 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC32C1042;
 Wed, 11 Aug 2021 22:09:13 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.68.17])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4FF073F40C;
 Wed, 11 Aug 2021 22:09:10 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH V2 0/5] KVM: arm64: General cleanups
Date: Thu, 12 Aug 2021 10:39:49 +0530
Message-Id: <1628744994-16623-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Cc: Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>, linux-kernel@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, kvmarm@lists.cs.columbia.edu
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

This series contains mostly unrelated general cleanups. This series applies
on v5.14-rc5 and has been boot tested with different page sized guests.

Changes in V2:

- Dropped the first patch regarding PAGE_[SHIFT|SIZE] per Marc
- Added remaining ID_AA64MMFR0_PARANGE_ macros and ARM64_MIN_PARANGE_BITS per Marc
- Dropped memory and cycle reference from commit message in [PATCH 3/5]
- Changed return value as u32 in kvm_target_cpu() per Will

Changes in V1:

https://lore.kernel.org/lkml/1628578961-29097-1-git-send-email-anshuman.khandual@arm.com/

Cc: Marc Zyngier <maz@kernel.org>
Cc: James Morse <james.morse@arm.com>
Cc: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: kvmarm@lists.cs.columbia.edu
Cc: linux-kernel@vger.kernel.org

Anshuman Khandual (5):
  arm64/mm: Add remaining ID_AA64MMFR0_PARANGE_ macros
  KVM: arm64: Use ARM64_MIN_PARANGE_BITS as the minimum supported IPA
  KVM: arm64: Drop init_common_resources()
  KVM: arm64: Drop check_kvm_target_cpu() based percpu probe
  KVM: arm64: Drop unused REQUIRES_VIRT

 arch/arm64/include/asm/cpufeature.h | 14 +++++++-------
 arch/arm64/include/asm/kvm_host.h   |  2 +-
 arch/arm64/include/asm/sysreg.h     |  7 +++++++
 arch/arm64/kvm/arm.c                | 27 ++-------------------------
 arch/arm64/kvm/guest.c              |  4 ++--
 arch/arm64/kvm/reset.c              |  2 +-
 6 files changed, 20 insertions(+), 36 deletions(-)

-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
