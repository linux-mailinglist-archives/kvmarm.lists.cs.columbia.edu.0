Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A260C536C82
	for <lists+kvmarm@lfdr.de>; Sat, 28 May 2022 13:38:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 17E9B4B2B5;
	Sat, 28 May 2022 07:38:43 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t+Dg2qEiaVUB; Sat, 28 May 2022 07:38:41 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 00F5E4B2F2;
	Sat, 28 May 2022 07:38:40 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EEC114B2DC
 for <kvmarm@lists.cs.columbia.edu>; Sat, 28 May 2022 07:38:38 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r-HkTI3Z6-VN for <kvmarm@lists.cs.columbia.edu>;
 Sat, 28 May 2022 07:38:37 -0400 (EDT)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 855844B20B
 for <kvmarm@lists.cs.columbia.edu>; Sat, 28 May 2022 07:38:37 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 6B73660E0B;
 Sat, 28 May 2022 11:38:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD711C34100;
 Sat, 28 May 2022 11:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1653737915;
 bh=ilVaGNUY2ZXHsoxp/MAtbHmtD44iJjr2rbSSEdp1W3k=;
 h=From:To:Cc:Subject:Date:From;
 b=hpr+TjUEEquAuRd1JaDDu38Z3bVPRNU+bLoeL9BUsQcFvOsjC2wQjx1CFTE9jH/N4
 6JjO2GwwsUb70DzroJjNoilZg42B5IB5eO/Kx+/h3gMEIa96oyyWyGEg0MSlh2mKZr
 bf9D6iNe/xSw1dVtd8xbBks5dCOYnQBC9lhL6Vj7SlHiAyFgrmHFRGQIGVlq29X1vF
 Hn7zT8UXX6GJ7jyKTeeg/1hsOPAsq0nttoPkfEYdx7EVPhurwmFjAhCeWLsLeNFlzD
 Z/WbcCDdhL1qkznvbSAfTK4TltKNCdXvc72H0r6jAsYPJPJTxRt2tDJHKNromnOdlD
 HeSB/ZriMR6XQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1nuum9-00EEGh-AZ; Sat, 28 May 2022 12:38:33 +0100
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH 00/18] KVM/arm64: Refactoring the vcpu flags
Date: Sat, 28 May 2022 12:38:10 +0100
Message-Id: <20220528113829.1043361-1-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, james.morse@arm.com,
 suzuki.poulose@arm.com, alexandru.elisei@arm.com, oupton@google.com,
 will@kernel.org, tabba@google.com, qperret@google.com, broonie@kernel.org,
 kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, Will Deacon <will@kernel.org>,
 Mark Brown <broonie@kernel.org>
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

While working on pKVM, it slowly became apparent that dealing with the
flags was a pain, as they serve multiple purposes:

- some flags are purely a configuration artefact,

- some are an input from the host kernel to the world switch,

- a bunch of them are bookkeeping information for the kernel itself,

- and finally some form a state machine between the host and the world
  switch.

Given that, it became pretty hard to clearly delineate what needed to
be conveyed between the host view of a vcpu and the shadow copy the
world switch deals with, both on entry and exit. This has led to a
flurry of bad bugs when developing the feature, and it is time to put
some order in this mess.

This series is roughly split in four parts:

- patch 1 addresses an embarrassing bug that would leave SVE enabled
  for host EL0 once the vcpu had the flag set (it was never cleared),
  and patch 2 fix the same bug for SME, as it copied the bad
  behaviour (both patches are fix candidates for -rc1, and the first
  one carries a Cc stable).

- patches 3 and 4 rid us of the FP flags altogether, as they really
  form a state machine that is better represented with an enum instead
  of dubious bit fiddling in both directions.

- patch 5 through to 14 split all the flags into three distinct
  categories: configuration, input to the world switch, and host
  state, using some ugly^Wbeautiful^Wquestionable cpp tricks.

- finally, the last patches add some cheap hardening and size
  optimisation to the new flags.

With that in place, it should be much easier to reason about which
flags need to be synchronised at runtime, and in which direction (for
pKVM, this is only a subset of the input flags, and nothing else).

This has been lightly tested on both VHE and nVHE systems, but not
with pKVM itself (there is a bit of work to rebase it on top of this
infrastructure). Patches on top of kvmarm-4.19 (there is a minor
conflict with Linus' current tree).

Marc Zyngier (18):
  KVM: arm64: Always start with clearing SVE flag on load
  KVM: arm64: Always start with clearing SME flag on load
  KVM: arm64: Drop FP_FOREIGN_STATE from the hypervisor code
  KVM: arm64: Move FP state ownership from flag to a tristate
  KVM: arm64: Add helpers to manipulate vcpu flags among a set
  KVM: arm64: Add three sets of flags to the vcpu state
  KVM: arm64: Move vcpu configuration flags into their own set
  KVM: arm64: Move vcpu PC/Exception flags to the input flag set
  KVM: arm64: Move vcpu debug/SPE/TRBE flags to the input flag set
  KVM: arm64: Move vcpu SVE/SME flags to the state flag set
  KVM: arm64: Move vcpu ON_UNSUPPORTED_CPU flag to the state flag set
  KVM: arm64: Move vcpu WFIT flag to the state flag set
  KVM: arm64: Kill unused vcpu flags field
  KVM: arm64: Convert vcpu sysregs_loaded_on_cpu to a state flag
  KVM: arm64: Warn when PENDING_EXCEPTION and INCREMENT_PC are set
    together
  KVM: arm64: Add build-time sanity checks for flags
  KVM: arm64: Reduce the size of the vcpu flag members
  KVM: arm64: Document why pause cannot be turned into a flag

 arch/arm64/include/asm/kvm_emulate.h       |   3 +-
 arch/arm64/include/asm/kvm_host.h          | 192 +++++++++++++++------
 arch/arm64/kvm/arch_timer.c                |   2 +-
 arch/arm64/kvm/arm.c                       |   6 +-
 arch/arm64/kvm/debug.c                     |  22 +--
 arch/arm64/kvm/fpsimd.c                    |  36 ++--
 arch/arm64/kvm/handle_exit.c               |   2 +-
 arch/arm64/kvm/hyp/exception.c             |  23 ++-
 arch/arm64/kvm/hyp/include/hyp/debug-sr.h  |   6 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h    |  24 +--
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h |   4 +-
 arch/arm64/kvm/hyp/nvhe/debug-sr.c         |   8 +-
 arch/arm64/kvm/hyp/nvhe/switch.c           |   6 +-
 arch/arm64/kvm/hyp/nvhe/sys_regs.c         |   7 +-
 arch/arm64/kvm/hyp/vhe/switch.c            |   4 +-
 arch/arm64/kvm/hyp/vhe/sysreg-sr.c         |   4 +-
 arch/arm64/kvm/inject_fault.c              |  30 ++--
 arch/arm64/kvm/reset.c                     |   6 +-
 arch/arm64/kvm/sys_regs.c                  |  12 +-
 19 files changed, 238 insertions(+), 159 deletions(-)

-- 
2.34.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
