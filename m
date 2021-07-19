Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 40B2E3CD4E2
	for <lists+kvmarm@lfdr.de>; Mon, 19 Jul 2021 14:39:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C35FE4B08A;
	Mon, 19 Jul 2021 08:39:44 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T6YN3rKxHfeK; Mon, 19 Jul 2021 08:39:43 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 488574A4CD;
	Mon, 19 Jul 2021 08:39:43 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8F7614A500
 for <kvmarm@lists.cs.columbia.edu>; Mon, 19 Jul 2021 08:39:42 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wIDEONnnpizn for <kvmarm@lists.cs.columbia.edu>;
 Mon, 19 Jul 2021 08:39:41 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 77A51406E7
 for <kvmarm@lists.cs.columbia.edu>; Mon, 19 Jul 2021 08:39:41 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 862716113E;
 Mon, 19 Jul 2021 12:39:40 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1m5SYc-00ED65-FZ; Mon, 19 Jul 2021 13:39:38 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu
Subject: [PATCH v2 0/4] kvm-arm64: Fix PMU reset values (and more)
Date: Mon, 19 Jul 2021 13:38:58 +0100
Message-Id: <20210719123902.1493805-1-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, james.morse@arm.com, suzuki.poulose@arm.com,
 alexandru.elisei@arm.com, alexandre.chartre@oracle.com, robin.murphy@arm.com,
 drjones@redhat.com, linux@arm.linux.org.uk, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, Robin Murphy <robin.murphy@arm.com>,
 Russell King <linux@arm.linux.org.uk>
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

This is the second version of the series initially posted at [1].

* From v1:
  - Simplified masking in patch #1
  - Added a patch dropping PMSWINC_EL0 as a shadow register, though it
    is still advertised to userspace for the purpose of backward
    compatibility of VM save/restore
  - Collected ABs/RBs, with thanks

[1] https://lore.kernel.org/r/20210713135900.1473057-1-maz@kernel.org

Alexandre Chartre (1):
  KVM: arm64: Disabling disabled PMU counters wastes a lot of time

Marc Zyngier (3):
  KVM: arm64: Narrow PMU sysreg reset values to architectural
    requirements
  KVM: arm64: Drop unnecessary masking of PMU registers
  KVM: arm64: Remove PMSWINC_EL0 shadow register

 arch/arm64/include/asm/kvm_host.h |  1 -
 arch/arm64/kvm/pmu-emul.c         |  8 ++--
 arch/arm64/kvm/sys_regs.c         | 70 +++++++++++++++++++++++++++----
 3 files changed, 67 insertions(+), 12 deletions(-)

-- 
2.30.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
