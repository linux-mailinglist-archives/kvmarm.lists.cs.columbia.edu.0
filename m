Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2646A1680BE
	for <lists+kvmarm@lfdr.de>; Fri, 21 Feb 2020 15:50:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7FCBD4AF19;
	Fri, 21 Feb 2020 09:50:34 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e9T1NWdBo4Fq; Fri, 21 Feb 2020 09:50:34 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5BF844AF03;
	Fri, 21 Feb 2020 09:50:33 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EE0B44ACEE
 for <kvmarm@lists.cs.columbia.edu>; Fri, 21 Feb 2020 09:50:31 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EtPSSAqCA2mS for <kvmarm@lists.cs.columbia.edu>;
 Fri, 21 Feb 2020 09:50:30 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id AD4294ACD5
 for <kvmarm@lists.cs.columbia.edu>; Fri, 21 Feb 2020 09:50:30 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 200A11FB;
 Fri, 21 Feb 2020 06:50:30 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DE9FE3F703;
 Fri, 21 Feb 2020 06:50:28 -0800 (PST)
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCHv2 0/2] arm64: add finalized cap helper
Date: Fri, 21 Feb 2020 14:50:20 +0000
Message-Id: <20200221145022.27217-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Cc: catalin.marinas@arm.com, maz@kernel.org, will@kernel.org,
 kvmarm@lists.cs.columbia.edu
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

Across arm64 we use cpus_have_const_cap() to check for a capability
without a runtime check. Prior to capabilities being finalized
cpus_have_const_cap() falls back to a runtime check of the cpu_hwcaps
array. In some cases we know that code is never invoked prior to the
capabilities being finalized, and the fallback code is redundant (and
unsound if ever executed in hyp context).

So that we can avoid the redundant code and detect when the caps are
unexpectedly checked too early, this series adds a new
cpus_have_final_cap() helper, and migrates the KVM hyp code over to it.

I'm hoping to use this as part of the entry.S -> entry-common.c
conversion, and there are other places in arm64 that could potentially
use this today.

Since v1 [1]
* Use system_capabilities_finalized() per Suzuki's comments
* Remove extraneous whitespace
* Add R-b tags from Marc and Suzuki

[1] https://lore.kernel.org/linux-arm-kernel/20200210122708.38826-1-mark.rutland@arm.com/

Thanks,
Mark.

Mark Rutland (2):
  arm64: cpufeature: add cpus_have_final_cap()
  arm64: kvm: hyp: use cpus_have_final_cap()

 arch/arm64/include/asm/cpufeature.h | 58 ++++++++++++++++++++++++++++++-------
 arch/arm64/kvm/hyp/switch.c         | 14 ++++-----
 arch/arm64/kvm/hyp/sysreg-sr.c      |  8 ++---
 arch/arm64/kvm/hyp/tlb.c            |  8 ++---
 4 files changed, 62 insertions(+), 26 deletions(-)

-- 
2.11.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
