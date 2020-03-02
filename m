Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B799517624A
	for <lists+kvmarm@lfdr.de>; Mon,  2 Mar 2020 19:18:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 07AAA4AF82;
	Mon,  2 Mar 2020 13:18:02 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iGOQ22+VtVTr; Mon,  2 Mar 2020 13:18:01 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id ED3694AF21;
	Mon,  2 Mar 2020 13:18:00 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C46624AF04
 for <kvmarm@lists.cs.columbia.edu>; Mon,  2 Mar 2020 13:17:59 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CTcM9BNseBqi for <kvmarm@lists.cs.columbia.edu>;
 Mon,  2 Mar 2020 13:17:58 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 80C1D4AED5
 for <kvmarm@lists.cs.columbia.edu>; Mon,  2 Mar 2020 13:17:58 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4B4C2F;
 Mon,  2 Mar 2020 10:17:57 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E6D163F6C4;
 Mon,  2 Mar 2020 10:17:56 -0800 (PST)
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCHv6 0/3] arm64: perf: Add support for ARMv8.5-PMU 64-bit counters
Date: Mon,  2 Mar 2020 18:17:49 +0000
Message-Id: <20200302181752.14251-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Cc: catalin.marinas@arm.com, will@kernel.org, kvmarm@lists.cs.columbia.edu,
 maz@kernel.org
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

This is a respin of Andrew Murray's series to enable support for 64-bit
counters as introduced in ARMv8.5.

I've given this a spin on (ARMv8.2) hardware, to test that there are no
regressions, but I have not had the chance to test in an ARMv8.5 model (which I
beleive Andrew had previously tested).

Since v5 [1]:
* Don't treat perfmon ID fields as signed
* Fix up ID field names
* Explicitly compare ARMV8.5 PMU value

[1] https://lkml.kernel.org/r/1580125469-23887-1-git-send-email-andrew.murray@arm.com

Thanks,
Mark.

Andrew Murray (3):
  arm64: cpufeature: Extract capped perfmon fields
  KVM: arm64: limit PMU version to PMUv3 for ARMv8.1
  arm64: perf: Add support for ARMv8.5-PMU 64-bit counters

 arch/arm64/include/asm/cpufeature.h | 23 ++++++++++
 arch/arm64/include/asm/perf_event.h |  3 +-
 arch/arm64/include/asm/sysreg.h     | 10 +++++
 arch/arm64/kernel/perf_event.c      | 86 +++++++++++++++++++++++++++++--------
 arch/arm64/kvm/sys_regs.c           | 10 +++++
 include/linux/perf/arm_pmu.h        |  1 +
 6 files changed, 115 insertions(+), 18 deletions(-)

-- 
2.11.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
