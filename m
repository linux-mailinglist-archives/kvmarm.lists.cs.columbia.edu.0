Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 07A26568F62
	for <lists+kvmarm@lfdr.de>; Wed,  6 Jul 2022 18:43:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9262D4BEB4;
	Wed,  6 Jul 2022 12:43:26 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.788
X-Spam-Level: 
X-Spam-Status: No, score=-1.788 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, RCVD_IN_DNSWL_BLOCKED=0.001, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S1C7sAsLEW+r; Wed,  6 Jul 2022 12:43:25 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C06384BF0C;
	Wed,  6 Jul 2022 12:43:19 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0FC334BEB9
 for <kvmarm@lists.cs.columbia.edu>; Wed,  6 Jul 2022 12:43:18 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MrLGohhNEC0g for <kvmarm@lists.cs.columbia.edu>;
 Wed,  6 Jul 2022 12:43:15 -0400 (EDT)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A660F4BE94
 for <kvmarm@lists.cs.columbia.edu>; Wed,  6 Jul 2022 12:43:15 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 076C2B81E29;
 Wed,  6 Jul 2022 16:43:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C164FC341C8;
 Wed,  6 Jul 2022 16:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1657125792;
 bh=aX01CebmN3HM3t7ulXW++1CUVElRHCgj3gCrqaBqMM4=;
 h=From:To:Cc:Subject:Date:From;
 b=LRgAQHoc8Nsw0X9L5hC/kqK2pet/aEZYVE3bIOjYUf5jcRxvHTlHSEwf79LgcvQm/
 33I1Y9T9es18x9W6Vc+qLAwwEmwABLjFGQYK8mPyEFjxphYHeJiQB6IUaXh4xHzfkP
 x7FYr+7W2H8m53bHClpu55+CQFofYE8j5wCtz5DqmTLvNXvTrvUZLg3H3WPiRHPdOz
 a++jYNsgUN2pvEd7OXJYhWZnJKriSYUzA0vWRt7oWOdE9rVkYNjEYn1YK4wOX5Bx9X
 aExRG9+REjd4lYGEOnkzjS6lLJLLQvW0UwXme3MZ/Z5HzesitokwH4K8Ia1FHlZIaX
 /b0TSxnpttH3w==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <maz@kernel.org>) id 1o987K-005h9i-Ec;
 Wed, 06 Jul 2022 17:43:10 +0100
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH 00/19] KVM: arm64: vgic-v3 userspace access consolidation (and
 other goodies)
Date: Wed,  6 Jul 2022 17:42:45 +0100
Message-Id: <20220706164304.1582687-1-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, james.morse@arm.com,
 suzuki.poulose@arm.com, alexandru.elisei@arm.com, oliver.upton@linux.dev,
 schspa@gmail.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Schspa Shi <schspa@gmail.com>, kernel-team@android.com,
 Oliver Upton <oliver.upton@linux.dev>
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

Schspa Shi recently reported[1] that some of the vgic code interacting
with userspace was reading uninitialised stack memory, and although
that read wasn't used any further, it prompted me to revisit this part
of the code.

Needless to say, this area of the kernel is pretty crufty, and shows a
bunch of issues in other parts of the KVM/arm64 infrastructure. This
series tries to remedy a bunch of them:

- Sanitise the way we deal with sysregs from userspace: at the moment,
  each and every .set_user/.get_user callback has to implement its own
  userspace accesses (directly or indirectly). It'd be much better if
  that was centralised so that we can reason about it.

- Enforce that all AArch64 sysregs are 64bit. Always. This was sort of
  implied by the code, but it took some effort to convince myself that
  this was actually the case.

- Move the vgic-v3 sysreg userspace accessors to the userspace
  callbacks instead of hijacking the vcpu trap callback. This allows
  us to reuse the sysreg infrastructure.

- Consolidate userspace accesses for both GICv2, GICv3 and common code
  as much as possible.

- Cleanup a bunch of not-very-useful helpers, tidy up some of the code
  as we touch it.

Overall, this is essentially a cosmetic exercise, as there is no new
feature here. But I have the feeling that the result is somehow more
maintainable. This has been (lightly) tested on my Synquacer, and
nothing exploded. Yet. YMMV.

[1] https://lore.kernel.org/r/m2h740zz1i.fsf@gmail.com

Marc Zyngier (19):
  KVM: arm64: Add get_reg_by_id() as a sys_reg_desc retrieving helper
  KVM: arm64: Reorder handling of invariant sysregs from userspace
  KVM: arm64: Introduce generic get_user/set_user helpers for system
    registers
  KVM: arm64: Push checks for 64bit registers into the low-level
    accessors
  KVM: arm64: Consolidate sysreg userspace accesses
  KVM: arm64: Get rid of reg_from/to_user()
  KVM: arm64: vgic-v3: Simplify vgic_v3_has_cpu_sysregs_attr()
  KVM: arm64: vgic-v3: Push user access into
    vgic_v3_cpu_sysregs_uaccess()
  KVM: arm64: vgic-v3: Make the userspace accessors use sysreg API
  KVM: arm64: vgic-v3: Convert userspace accessors over to
    FIELD_GET/FIELD_PREP
  KVM: arm64: vgic-v3: Use u32 to manage the line level from userspace
  KVM: arm64: vgic-v3: Consolidate userspace access for MMIO registers
  KVM: arm64: vgic-v2: Consolidate userspace access for MMIO registers
  KVM: arm64: vgic: Use {get,put}_user() instead of copy_{from.to}_user
  KVM: arm64: vgic-v2: Add helper for legacy dist/cpuif base address
    setting
  KVM: arm64: vgic: Consolidate userspace access for base address
    setting
  KVM: arm64: Get rid of find_reg_by_id()
  KVM: arm64: Descope kvm_arm_sys_reg_{get,set}_reg()
  KVM: arm64: Get rid or outdated comments

 arch/arm64/include/asm/kvm_host.h     |   2 -
 arch/arm64/kvm/arm.c                  |  11 +-
 arch/arm64/kvm/sys_regs.c             | 291 +++++++---------
 arch/arm64/kvm/sys_regs.h             |  18 +-
 arch/arm64/kvm/vgic-sys-reg-v3.c      | 461 +++++++++++++++-----------
 arch/arm64/kvm/vgic/vgic-kvm-device.c | 269 +++++++--------
 arch/arm64/kvm/vgic/vgic-mmio-v3.c    |  10 +-
 arch/arm64/kvm/vgic/vgic-mmio.c       |   6 +-
 arch/arm64/kvm/vgic/vgic-mmio.h       |   4 +-
 arch/arm64/kvm/vgic/vgic.h            |   9 +-
 include/kvm/arm_vgic.h                |   2 +-
 11 files changed, 535 insertions(+), 548 deletions(-)

-- 
2.34.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
