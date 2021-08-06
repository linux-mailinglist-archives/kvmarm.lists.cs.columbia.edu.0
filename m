Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E1DD33E299D
	for <lists+kvmarm@lfdr.de>; Fri,  6 Aug 2021 13:31:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5C9014B0EC;
	Fri,  6 Aug 2021 07:31:26 -0400 (EDT)
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
	with ESMTP id KLZ6J3YIszHq; Fri,  6 Aug 2021 07:31:26 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 383224B0E8;
	Fri,  6 Aug 2021 07:31:25 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5E8374B0E1
 for <kvmarm@lists.cs.columbia.edu>; Fri,  6 Aug 2021 07:31:23 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 77s4MDNCkUoZ for <kvmarm@lists.cs.columbia.edu>;
 Fri,  6 Aug 2021 07:31:22 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 153A14B0E0
 for <kvmarm@lists.cs.columbia.edu>; Fri,  6 Aug 2021 07:31:22 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E1A860F38;
 Fri,  6 Aug 2021 11:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628249481;
 bh=Wve2HPDAh8pk0/x/LBGSqB32H47g9ounsHsBh1cD85Q=;
 h=From:To:Cc:Subject:Date:From;
 b=itbTs6Chs219vUx56bnuoMQodGO4uXYcJwmWzsgssM61sEDB7ZFelV1dnBvkQFn7Y
 IVX2ZYpMk8T2zdk2vGtcS/+/qSIaPoBJZhTyx5JeL8XSqdkj/ZxDYREl3nFmhwWsyC
 ZvsU36kKfmQeMFEtMaMDT0Io54hinjIlXotpHos6Jz1jShYNEO+ev67DGDi1J6ZYX3
 m8W8jzl/fuc67aVhVuIFmEPMswS5BKfGQ/tBQP4fPjSDVEdW5NZKucr23BtMR1tPiw
 ALnTb5U4n7XatGDlV/aZPktQRKBKFUOib4ravqnOtRt+r7lmCIPTm8WbvCyANhzhgm
 Hp9sZNXBJVBWA==
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/4] Fix racing TLBI with ASID/VMID reallocation
Date: Fri,  6 Aug 2021 12:31:03 +0100
Message-Id: <20210806113109.2475-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 kernel-team@android.com, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
 Jade Alglave <jade.alglave@arm.com>
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

While reviewing Shameer's reworked VMID allocator [1] and discussing
with Marc, we spotted a race between TLB invalidation (which typically
takes an ASID or VMID argument) and reallocation of ASID/VMID for the
context being targetted.

The first patch spells out an example with try_to_unmap_one() in a
comment, which Catalin has kindly modelled in TLA+ at [2].

Although I'm posting all this together for ease of review, the intention
is that the first patch will go via arm64 with the latter going via kvm.

Cheers,

Will

[1] https://lore.kernel.org/r/20210729104009.382-1-shameerali.kolothum.thodi@huawei.com
[2] https://git.kernel.org/pub/scm/linux/kernel/git/cmarinas/kernel-tla.git/commit/

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Jade Alglave <jade.alglave@arm.com>
Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: <kvmarm@lists.cs.columbia.edu>
Cc: <linux-arch@vger.kernel.org>

--->8

Marc Zyngier (3):
  KVM: arm64: Move kern_hyp_va() usage in __load_guest_stage2() into the
    callers
  KVM: arm64: Convert the host S2 over to __load_guest_stage2()
  KVM: arm64: Upgrade VMID accesses to {READ,WRITE}_ONCE

Will Deacon (1):
  arm64: mm: Fix TLBI vs ASID rollover

 arch/arm64/include/asm/kvm_mmu.h              | 17 ++++++-----
 arch/arm64/include/asm/mmu.h                  | 29 ++++++++++++++++---
 arch/arm64/include/asm/tlbflush.h             | 11 +++----
 arch/arm64/kvm/arm.c                          |  2 +-
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  2 +-
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         |  6 ++--
 arch/arm64/kvm/hyp/nvhe/switch.c              |  4 ++-
 arch/arm64/kvm/hyp/nvhe/tlb.c                 |  2 +-
 arch/arm64/kvm/hyp/vhe/switch.c               |  2 +-
 arch/arm64/kvm/hyp/vhe/tlb.c                  |  2 +-
 arch/arm64/kvm/mmu.c                          |  2 +-
 11 files changed, 52 insertions(+), 27 deletions(-)

-- 
2.32.0.605.g8dce9f2422-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
