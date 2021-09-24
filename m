Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D48FD416E19
	for <lists+kvmarm@lfdr.de>; Fri, 24 Sep 2021 10:38:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4D9834B0AC;
	Fri, 24 Sep 2021 04:38:55 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ICP7fA1G36Kk; Fri, 24 Sep 2021 04:38:55 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 118F74B110;
	Fri, 24 Sep 2021 04:38:54 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8B0E44B10B
 for <kvmarm@lists.cs.columbia.edu>; Fri, 24 Sep 2021 04:38:52 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PobGyLgggWc1 for <kvmarm@lists.cs.columbia.edu>;
 Fri, 24 Sep 2021 04:38:50 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id ACE904B10A
 for <kvmarm@lists.cs.columbia.edu>; Fri, 24 Sep 2021 04:38:50 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AB31B61211;
 Fri, 24 Sep 2021 08:38:49 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1mTgjH-00Ci2m-O5; Fri, 24 Sep 2021 09:38:47 +0100
From: Marc Zyngier <maz@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: [GIT PULL] KVM/arm64 fixes for 5.15, take #1
Date: Fri, 24 Sep 2021 09:38:29 +0100
Message-Id: <20210924083829.2766529-1-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: pbonzini@redhat.com, dbrazdil@google.com,
 masahiroy@kernel.org, rmk+kernel@armlinux.org.uk, yuzenghui@huawei.com,
 will@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
 alexandru.elisei@arm.com, kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, kvm@vger.kernel.org,
 Masahiro Yamada <masahiroy@kernel.org>,
 Russell King <rmk+kernel@armlinux.org.uk>, Will Deacon <will@kernel.org>,
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

Hi Paolo,

Only two fixes so far for KVM/arm64: one patch squashing a Kbuild
warning, and a fix for a regression when probing the availability of a
PMU.

Please pull,

	M.

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kvmarm-fixes-5.15-1

for you to fetch changes up to e840f42a49925707fca90e6c7a4095118fdb8c4d:

  KVM: arm64: Fix PMU probe ordering (2021-09-20 12:43:34 +0100)

----------------------------------------------------------------
KVM/arm64 fixes for 5.15, take #1

- Add missing FORCE target when building the EL2 object
- Fix a PMU probe regression on some platforms

----------------------------------------------------------------
Marc Zyngier (1):
      KVM: arm64: Fix PMU probe ordering

Zenghui Yu (1):
      KVM: arm64: nvhe: Fix missing FORCE for hyp-reloc.S build rule

 arch/arm64/kvm/hyp/nvhe/Makefile | 2 +-
 arch/arm64/kvm/perf.c            | 3 ---
 arch/arm64/kvm/pmu-emul.c        | 9 ++++++++-
 drivers/perf/arm_pmu.c           | 2 ++
 include/kvm/arm_pmu.h            | 3 ---
 include/linux/perf/arm_pmu.h     | 6 ++++++
 6 files changed, 17 insertions(+), 8 deletions(-)
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
