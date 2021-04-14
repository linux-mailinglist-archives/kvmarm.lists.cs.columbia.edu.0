Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3D94235F512
	for <lists+kvmarm@lfdr.de>; Wed, 14 Apr 2021 15:44:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E52EE4B699;
	Wed, 14 Apr 2021 09:44:34 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5RlNfWsf4b1M; Wed, 14 Apr 2021 09:44:33 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F08F64B723;
	Wed, 14 Apr 2021 09:44:30 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 022AF4B666
 for <kvmarm@lists.cs.columbia.edu>; Wed, 14 Apr 2021 09:44:28 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AFn6TM0k2Afc for <kvmarm@lists.cs.columbia.edu>;
 Wed, 14 Apr 2021 09:44:27 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 17ECA4B5E8
 for <kvmarm@lists.cs.columbia.edu>; Wed, 14 Apr 2021 09:44:27 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6BC26611B0;
 Wed, 14 Apr 2021 13:44:26 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1lWfoe-007RSZ-OI; Wed, 14 Apr 2021 14:44:24 +0100
From: Marc Zyngier <maz@kernel.org>
To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org
Subject: [PATCH 4/5] sh: Get rid of oprofile leftovers
Date: Wed, 14 Apr 2021 14:44:08 +0100
Message-Id: <20210414134409.1266357-5-maz@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210414134409.1266357-1-maz@kernel.org>
References: <20210414134409.1266357-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, mark.rutland@arm.com,
 will@kernel.org, dalias@libc.org, ysato@users.sourceforge.jp,
 peterz@infradead.org, acme@kernel.org, borntraeger@de.ibm.com,
 hca@linux.ibm.com, nathan@kernel.org, viresh.kumar@linaro.org,
 james.morse@arm.com, suzuki.poulose@arm.com, alexandru.elisei@arm.com,
 kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Peter Zijlstra <peterz@infradead.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Heiko Carstens <hca@linux.ibm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 nathan@kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>,
 kernel-team@android.com, Will Deacon <will@kernel.org>
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

perf_pmu_name() and perf_num_counters() are unused. Drop them.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/sh/kernel/perf_event.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/arch/sh/kernel/perf_event.c b/arch/sh/kernel/perf_event.c
index 445e3ece4c23..1d2507f22437 100644
--- a/arch/sh/kernel/perf_event.c
+++ b/arch/sh/kernel/perf_event.c
@@ -57,24 +57,6 @@ static inline int sh_pmu_initialized(void)
 	return !!sh_pmu;
 }
 
-const char *perf_pmu_name(void)
-{
-	if (!sh_pmu)
-		return NULL;
-
-	return sh_pmu->name;
-}
-EXPORT_SYMBOL_GPL(perf_pmu_name);
-
-int perf_num_counters(void)
-{
-	if (!sh_pmu)
-		return 0;
-
-	return sh_pmu->num_events;
-}
-EXPORT_SYMBOL_GPL(perf_num_counters);
-
 /*
  * Release the PMU if this is the last perf_event.
  */
-- 
2.29.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
