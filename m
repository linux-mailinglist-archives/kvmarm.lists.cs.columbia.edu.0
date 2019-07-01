Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1292718D00
	for <lists+kvmarm@lfdr.de>; Thu,  9 May 2019 17:32:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B3E7E4A47A;
	Thu,  9 May 2019 11:32:30 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qODEEQbn9G1k; Thu,  9 May 2019 11:32:30 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E2B8C4A4EE;
	Thu,  9 May 2019 11:32:28 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 37FA64A4CE
 for <kvmarm@lists.cs.columbia.edu>; Thu,  9 May 2019 11:32:28 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pIz+9+X+syUD for <kvmarm@lists.cs.columbia.edu>;
 Thu,  9 May 2019 11:32:27 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4828D4A4BF
 for <kvmarm@lists.cs.columbia.edu>; Thu,  9 May 2019 11:32:27 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D130F374;
 Thu,  9 May 2019 08:32:26 -0700 (PDT)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.20])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 401E73F6C4;
 Thu,  9 May 2019 08:32:25 -0700 (PDT)
From: Andrew Murray <andrew.murray@arm.com>
To: Christoffer Dall <christoffer.dall@arm.com>,
 Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH v6 4/5] arm64: perf: extract chain helper into header
Date: Thu,  9 May 2019 16:32:11 +0100
Message-Id: <20190509153212.24187-5-andrew.murray@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509153212.24187-1-andrew.murray@arm.com>
References: <20190509153212.24187-1-andrew.murray@arm.com>
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

The ARMv8 Performance Monitors Extension includes an architectural
event type named CHAIN which allows for chaining counters together.

Let's extract the test for this event into a header file such that
other users, such as KVM (for PMU emulation) can make use of.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 arch/arm64/include/asm/perf_event.h | 5 +++++
 arch/arm64/kernel/perf_event.c      | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/perf_event.h b/arch/arm64/include/asm/perf_event.h
index c593761ba61c..cd13f3fd1055 100644
--- a/arch/arm64/include/asm/perf_event.h
+++ b/arch/arm64/include/asm/perf_event.h
@@ -219,6 +219,11 @@
 #define ARMV8_PMU_USERENR_CR	(1 << 2) /* Cycle counter can be read at EL0 */
 #define ARMV8_PMU_USERENR_ER	(1 << 3) /* Event counter can be read at EL0 */
 
+static inline bool armv8pmu_evtype_is_chain(u64 evtype)
+{
+	return (evtype == ARMV8_PMUV3_PERFCTR_CHAIN);
+}
+
 #ifdef CONFIG_PERF_EVENTS
 struct pt_regs;
 extern unsigned long perf_instruction_pointer(struct pt_regs *regs);
diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 314b1adedf06..265bd835a724 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -879,7 +879,7 @@ static int armv8pmu_set_event_filter(struct hw_perf_event *event,
 static int armv8pmu_filter_match(struct perf_event *event)
 {
 	unsigned long evtype = event->hw.config_base & ARMV8_PMU_EVTYPE_EVENT;
-	return evtype != ARMV8_PMUV3_PERFCTR_CHAIN;
+	return !armv8pmu_evtype_is_chain(evtype);
 }
 
 static void armv8pmu_reset(void *info)
-- 
2.21.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
