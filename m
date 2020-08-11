Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B199A2419AD
	for <lists+kvmarm@lfdr.de>; Tue, 11 Aug 2020 12:27:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 342B24B4E1;
	Tue, 11 Aug 2020 06:27:36 -0400 (EDT)
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
	with ESMTP id xz3mqFNJQ-Hw; Tue, 11 Aug 2020 06:27:36 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1B1374B4A3;
	Tue, 11 Aug 2020 06:27:35 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D73CD4B49F
 for <kvmarm@lists.cs.columbia.edu>; Tue, 11 Aug 2020 06:27:33 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3Nhr12VKq-6G for <kvmarm@lists.cs.columbia.edu>;
 Tue, 11 Aug 2020 06:27:32 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id B3E7E4B475
 for <kvmarm@lists.cs.columbia.edu>; Tue, 11 Aug 2020 06:27:32 -0400 (EDT)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A195F20656;
 Tue, 11 Aug 2020 10:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597141651;
 bh=KrsjJEn9/AAscGALbBQiNYwkr+CsOr9idxLrWL4e3TE=;
 h=From:To:Cc:Subject:Date:From;
 b=PIKF5mZGoH+YEC5q1fL4nAJGN7PAFK+DseTN0XF1YN5njXxltvV+cT5aht3Kp8pGf
 TXYgvj9cDwRixGojJZO7lIXkdb3f4GLCxSFLcy+GZKd+x5wgMr1ll3l8xV4kzh3vd4
 7yJCn5KKWmuA405P8Fb/MnoX1F8fILd5+A1QL5VE=
From: Will Deacon <will@kernel.org>
To: kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
Subject: [PATCH 0/2] KVM: arm64: Fix sleeping while atomic BUG() on OOM
Date: Tue, 11 Aug 2020 11:27:23 +0100
Message-Id: <20200811102725.7121-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Marc Zyngier <maz@kernel.org>,
 Sean Christopherson <sean.j.christopherson@intel.com>,
 Paul Mackerras <paulus@ozlabs.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Will Deacon <will@kernel.org>
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

While stress-testing my arm64 stage-2 page-table rewrite [1], I ran into
a sleeping while atomic BUG() during OOM that I can reproduce with
mainline.

The problem is that the arm64 page-table code periodically calls
cond_resched_lock() when unmapping the stage-2 page-tables, but in the
case of OOM, this occurs in atomic context.

These couple of patches (based on 5.8) propagate the flags from the MMU
notifier range structure, which in turn indicate whether or not blocking
is permitted.

Cheers,

Will

[1] https://android-kvm.googlesource.com/linux/+/refs/heads/topic/pgtable

Cc: Marc Zyngier <maz@kernel.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Mackerras <paulus@ozlabs.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>

--->8

Will Deacon (2):
  KVM: Pass MMU notifier range flags to kvm_unmap_hva_range()
  KVM: arm64: Only reschedule if MMU_NOTIFIER_RANGE_BLOCKABLE is not set

 arch/arm64/include/asm/kvm_host.h   |  2 +-
 arch/arm64/kvm/mmu.c                | 19 ++++++++++++++-----
 arch/mips/include/asm/kvm_host.h    |  2 +-
 arch/mips/kvm/mmu.c                 |  3 ++-
 arch/powerpc/include/asm/kvm_host.h |  3 ++-
 arch/powerpc/kvm/book3s.c           |  3 ++-
 arch/powerpc/kvm/e500_mmu_host.c    |  3 ++-
 arch/x86/include/asm/kvm_host.h     |  3 ++-
 arch/x86/kvm/mmu/mmu.c              |  3 ++-
 virt/kvm/kvm_main.c                 |  3 ++-
 10 files changed, 30 insertions(+), 14 deletions(-)

-- 
2.28.0.236.gb10cc79966-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
