Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5407F415CC0
	for <lists+kvmarm@lfdr.de>; Thu, 23 Sep 2021 13:23:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AC4E44A19A;
	Thu, 23 Sep 2021 07:23:06 -0400 (EDT)
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
	with ESMTP id dcl99W2K1qnG; Thu, 23 Sep 2021 07:23:06 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AA7624B107;
	Thu, 23 Sep 2021 07:23:05 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C06CB4A19A
 for <kvmarm@lists.cs.columbia.edu>; Thu, 23 Sep 2021 07:23:04 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l9P6R86-KmeZ for <kvmarm@lists.cs.columbia.edu>;
 Thu, 23 Sep 2021 07:23:03 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id C399F4079A
 for <kvmarm@lists.cs.columbia.edu>; Thu, 23 Sep 2021 07:23:03 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 33FF860EC0;
 Thu, 23 Sep 2021 11:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632396182;
 bh=Lf3j0RI6dBAAadEUBstWTKcsG6r3BLFrYbLMIIdq9rI=;
 h=From:To:Cc:Subject:Date:From;
 b=nX69TkQH8ABpT3mauT5UkvOP0zX03qI6KiAt1zfmGl2dsK10sAfCojDPznQwCx0Y8
 nv+kBGyFQGzlfJQhPCEYLw7WRHhHNEZ669mpf4DvLA0BYw2YRYWRH1FRtdeQ9QLP8H
 py84L6nM+XyN6orHFTyWxaf1tL9A+8AvK0MFizcX3VpEnXgVSyf1TvATTPnUHMUXRL
 W3DeXBS+jD/jlDJFQEyCmx2Ge9U/jsw+Da8OV7oDTWfo/ots072ukRZpjl/ZbxKwd+
 kt8QmM5H2iOCRhACtfQ1s+KoLJ4ngLbd8FpDNyB01FX4m3za/guuqFCcWdcPAa7bZF
 yhqd1oNjQDwHg==
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/5] KVM: arm64: Restrict host hypercalls when pKVM is enabled
Date: Thu, 23 Sep 2021 12:22:51 +0100
Message-Id: <20210923112256.15767-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: Marc Zyngier <maz@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu
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

Hi folks,

This series restricts the hypercalls available to the KVM host on arm64
when pKVM is enabled so that it is not possible for the host to use them
to replace the EL2 component with something else.

This occurs in two stages: when switching to the pKVM vectors, the stub
hypercalls are removed and then later when pKVM is finalised, the pKVM
init hypercalls are removed.

There are still a few dubious calls remaining in terms of protecting the
guest (e.g. __kvm_adjust_pc) but these will be dealt with later when we
have more VM state at EL2 to play with.

Patches based on -rc2. Feedback welcome.

Cheers,

Will

Cc: Marc Zyngier <maz@kernel.org>
Cc: Quentin Perret <qperret@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvmarm@lists.cs.columbia.edu

--->8

Will Deacon (5):
  arm64: Prevent kexec and hibernation if is_protected_kvm_enabled()
  KVM: arm64: Reject stub hypercalls after pKVM has been initialised
  KVM: arm64: Propagate errors from __pkvm_prot_finalize hypercall
  KVM: arm64: Prevent re-finalisation of pKVM for a given CPU
  KVM: arm64: Disable privileged hypercalls after pKVM finalisation

 arch/arm64/include/asm/kvm_asm.h      | 43 ++++++++++---------
 arch/arm64/kernel/smp.c               |  3 +-
 arch/arm64/kvm/arm.c                  | 61 ++++++++++++++++++---------
 arch/arm64/kvm/hyp/nvhe/host.S        | 26 ++++++++----
 arch/arm64/kvm/hyp/nvhe/hyp-main.c    | 26 +++++++-----
 arch/arm64/kvm/hyp/nvhe/mem_protect.c |  3 ++
 6 files changed, 103 insertions(+), 59 deletions(-)

-- 
2.33.0.464.g1972c5931b-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
