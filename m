Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 69F8612E635
	for <lists+kvmarm@lfdr.de>; Thu,  2 Jan 2020 13:39:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9218C4A5A6;
	Thu,  2 Jan 2020 07:39:16 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Muzu-yAXoS63; Thu,  2 Jan 2020 07:39:16 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7001F4A588;
	Thu,  2 Jan 2020 07:39:15 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 396F94A52C
 for <kvmarm@lists.cs.columbia.edu>; Thu,  2 Jan 2020 07:39:14 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K0HVjF3Oe5QX for <kvmarm@lists.cs.columbia.edu>;
 Thu,  2 Jan 2020 07:39:13 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id F1EE64A3A3
 for <kvmarm@lists.cs.columbia.edu>; Thu,  2 Jan 2020 07:39:12 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AF881FB;
 Thu,  2 Jan 2020 04:39:12 -0800 (PST)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.20])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E21D93F703;
 Thu,  2 Jan 2020 04:39:10 -0800 (PST)
From: Andrew Murray <andrew.murray@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v3 0/3] arm64: perf: Add support for ARMv8.5-PMU 64-bit
 counters
Date: Thu,  2 Jan 2020 12:39:02 +0000
Message-Id: <20200102123905.29360-1-andrew.murray@arm.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Cc: kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

At present ARMv8 event counters are limited to 32-bits, though by
using the CHAIN event it's possible to combine adjacent counters to
achieve 64-bits. The perf config1:0 bit can be set to use such a
configuration.

With the introduction of ARMv8.5-PMU support, all event counters can
now be used as 64-bit counters. Let's add support for 64-bit event
counters.

As KVM doesn't yet support 64-bit event counters, we also trap
and emulate the Debug Feature Registers to limit the PMU version a
guest sees to PMUv3 for ARMv8.4.

Tested by running the following perf command on both guest and host
and ensuring that the figures are very similar:

perf stat -e armv8_pmuv3/inst_retired,long=1/ \
          -e armv8_pmuv3/inst_retired,long=0/ -e cycles

Changes since v2:

 - Rebased onto v5.5-rc4
 - Mask 'cap' value to 'width' in cpuid_feature_cap_signed_field_width

Changes since v1:

 - Rebased onto v5.5-rc1


Andrew Murray (3):
  arm64: cpufeature: Extract capped fields
  KVM: arm64: limit PMU version to ARMv8.4
  arm64: perf: Add support for ARMv8.5-PMU 64-bit counters

 arch/arm64/include/asm/cpufeature.h | 16 ++++++
 arch/arm64/include/asm/perf_event.h |  3 +-
 arch/arm64/include/asm/sysreg.h     |  4 ++
 arch/arm64/kernel/perf_event.c      | 86 +++++++++++++++++++++++------
 arch/arm64/kvm/sys_regs.c           | 36 +++++++++++-
 include/linux/perf/arm_pmu.h        |  1 +
 6 files changed, 126 insertions(+), 20 deletions(-)

-- 
2.21.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
