Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 48C1465F052
	for <lists+kvmarm@lfdr.de>; Thu,  5 Jan 2023 16:43:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CD4F74B491;
	Thu,  5 Jan 2023 10:43:12 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -6.789
X-Spam-Level: 
X-Spam-Status: No, score=-6.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, RCVD_IN_DNSWL_HI=-5, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QqXT35LYHbrW; Thu,  5 Jan 2023 10:43:12 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 71FFC4B64B;
	Thu,  5 Jan 2023 10:43:11 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2EEE14B64B
 for <kvmarm@lists.cs.columbia.edu>; Thu,  5 Jan 2023 10:43:10 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jqCR7TSKxaN3 for <kvmarm@lists.cs.columbia.edu>;
 Thu,  5 Jan 2023 10:43:08 -0500 (EST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id C89C44B491
 for <kvmarm@lists.cs.columbia.edu>; Thu,  5 Jan 2023 10:43:08 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id B836CB8199B;
 Thu,  5 Jan 2023 15:43:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52CA1C433EF;
 Thu,  5 Jan 2023 15:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1672933386;
 bh=y74N97g+Yx8E7h9CsEgRapP40oMw4aE0lxW2+d1Edec=;
 h=From:To:Cc:Subject:Date:From;
 b=JVfh+umcShNIlXPn6f/oW7BCEb5Au78jLh2dmpxjcnKvdhb9ijocjfIqMbQkkEJIS
 FCjhh8RhqY5mqsrlOwbONUZXkSk3sBqXAVhTc29T3aW+Nt5c1xflqynjD3xbsTvClO
 x9ze2FrzMSpoP2aEP3uXGLchWTAJoHWmaUUHJAIAc5s9vl8ZZI4jioGgX82wONyMzZ
 uC1yZf5Q5GBiyywd/vK2lvSa3oFA22swxtp7Nv+V/WbwQ4hW1miFAXebVA7p5XN/WU
 ZjCcPq+wGYdFHpCNE1iCXGaLKjHsX6qYuJ2bYgo50Tnf5RhNqPU8F1dJ0/BkHn/zY/
 xA88ay6DkrNpg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <maz@kernel.org>) id 1pDSOV-00H25l-VO;
 Thu, 05 Jan 2023 15:43:04 +0000
From: Marc Zyngier <maz@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: [GIT PULL] KVM/arm64 fixes for 6.2, take #1
Date: Thu,  5 Jan 2023 15:42:50 +0000
Message-Id: <20230105154250.660145-1-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: pbonzini@redhat.com, alexandru.elisei@arm.com,
 ardb@kernel.org, james.clark@arm.com, oliver.upton@linux.dev,
 yuzenghui@huawei.com, james.morse@arm.com, suzuki.poulose@arm.com,
 kvmarm@lists.cs.columbia.edu, kvmarm@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, kvmarm@lists.linux.dev,
 James Clark <james.clark@arm.com>, linux-arm-kernel@lists.infradead.org
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

Happy new year!

Here's the first batch of fixes for KVM/arm64 for 6.2. We have two
important fixes this time around, one for the PMU emulation, and the
other for guest page table walks in read-only memslots, something that
EFI has started doing...

The rest is mostly documentation updates, cleanups, and an update to
the list of reviewers (Alexandru stepping down, and Zenghui joining
the fun).

Please pull,

	M.


The following changes since commit 88603b6dc419445847923fcb7fe5080067a30f98:

  Linux 6.2-rc2 (2023-01-01 13:53:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kvmarm-fixes-6.2-1

for you to fetch changes up to de535c0234dd2dbd9c790790f2ca1c4ec8a52d2b:

  Merge branch kvm-arm64/MAINTAINERS into kvmarm-master/fixes (2023-01-05 15:26:53 +0000)

----------------------------------------------------------------
KVM/arm64 fixes for 6.2, take #1

- Fix the PMCR_EL0 reset value after the PMU rework

- Correctly handle S2 fault triggered by a S1 page table walk
  by not always classifying it as a write, as this breaks on
  R/O memslots

- Document why we cannot exit with KVM_EXIT_MMIO when taking
  a write fault from a S1 PTW on a R/O memslot

- Put the Apple M2 on the naughty step for not being able to
  correctly implement the vgic SEIS feature, just liek the M1
  before it

- Reviewer updates: Alex is stepping down, replaced by Zenghui

----------------------------------------------------------------
Alexandru Elisei (1):
      MAINTAINERS: Remove myself as a KVM/arm64 reviewer

James Clark (1):
      KVM: arm64: PMU: Fix PMCR_EL0 reset value

Marc Zyngier (8):
      KVM: arm64: Fix S1PTW handling on RO memslots
      KVM: arm64: Document the behaviour of S1PTW faults on RO memslots
      KVM: arm64: Convert FSC_* over to ESR_ELx_FSC_*
      KVM: arm64: vgic: Add Apple M2 cpus to the list of broken SEIS implementations
      Merge branch kvm-arm64/pmu-fixes-6.2 into kvmarm-master/fixes
      Merge branch kvm-arm64/s1ptw-write-fault into kvmarm-master/fixes
      MAINTAINERS: Add Zenghui Yu as a KVM/arm64 reviewer
      Merge branch kvm-arm64/MAINTAINERS into kvmarm-master/fixes

 Documentation/virt/kvm/api.rst          |  8 +++++++
 MAINTAINERS                             |  2 +-
 arch/arm64/include/asm/cputype.h        |  4 ++++
 arch/arm64/include/asm/esr.h            |  9 +++++++
 arch/arm64/include/asm/kvm_arm.h        | 15 ------------
 arch/arm64/include/asm/kvm_emulate.h    | 42 +++++++++++++++++++++++----------
 arch/arm64/kvm/hyp/include/hyp/fault.h  |  2 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h |  2 +-
 arch/arm64/kvm/mmu.c                    | 21 ++++++++++-------
 arch/arm64/kvm/sys_regs.c               |  2 +-
 arch/arm64/kvm/vgic/vgic-v3.c           |  2 ++
 11 files changed, 69 insertions(+), 40 deletions(-)
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
