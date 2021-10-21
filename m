Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E060C436544
	for <lists+kvmarm@lfdr.de>; Thu, 21 Oct 2021 17:11:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 842334B199;
	Thu, 21 Oct 2021 11:11:39 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=ham
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EQI4+F9rvuSH; Thu, 21 Oct 2021 11:11:38 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 10C094B1B2;
	Thu, 21 Oct 2021 11:11:38 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1FF214B161
 for <kvmarm@lists.cs.columbia.edu>; Thu, 21 Oct 2021 11:11:36 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Qkdc7lkTCLlY for <kvmarm@lists.cs.columbia.edu>;
 Thu, 21 Oct 2021 11:11:34 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D79F14B119
 for <kvmarm@lists.cs.columbia.edu>; Thu, 21 Oct 2021 11:11:34 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5916A611C7;
 Thu, 21 Oct 2021 15:11:32 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1mdZj8-000jKD-64; Thu, 21 Oct 2021 16:11:30 +0100
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/4] KVM: arm64: Stop mapping current thread_info at EL2
Date: Thu, 21 Oct 2021 16:11:20 +0100
Message-Id: <20211021151124.3098113-1-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, james.morse@arm.com,
 suzuki.poulose@arm.com, alexandru.elisei@arm.com, qperret@google.com,
 will@kernel.org, broonie@kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, Will Deacon <will@kernel.org>, broonie@kernel.org
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

It recently became apparent that we are mapping each vcpu thread's
thread_info structure at EL2 for the sole purpose of checking on the
TIF_FOREIGN_FPSTATE flag.

Given that this looks like a slightly over-engineered way of sharing a
single bit of information, let's move to a slightly more obvious
implementation by maintaining a vcpu-private shadow flag that
represents the same state.

I also take this opportunity to add what looks like a missing, and
nonetheless crucial piece of information to the FPSIMD code regarding
the way KVM (ab)uses the TIF_FOREIGN_FPSTATE.

Lightly tested on an A53 box with a bunch of paranoia instances
running in both host and guests.

Marc Zyngier (4):
  KVM: arm64: Reorder vcpu flag definitions
  KVM: arm64: Introduce flag shadowing TIF_FOREIGN_FPSTATE
  KVM: arm64: Stop mapping current thread_info at EL2
  arm64/fpsimd: Document the use of TIF_FOREIGN_FPSTATE by KVM

 arch/arm64/include/asm/kvm_host.h       | 28 ++++++++++++-------------
 arch/arm64/kernel/fpsimd.c              |  5 ++++-
 arch/arm64/kvm/arm.c                    |  1 +
 arch/arm64/kvm/fpsimd.c                 | 20 ++++++++----------
 arch/arm64/kvm/hyp/include/hyp/switch.h |  3 +--
 arch/arm64/kvm/hyp/nvhe/switch.c        |  1 -
 arch/arm64/kvm/hyp/vhe/switch.c         |  1 -
 7 files changed, 29 insertions(+), 30 deletions(-)

-- 
2.30.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
