Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C024423405B
	for <lists+kvmarm@lfdr.de>; Fri, 31 Jul 2020 09:44:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 752754B517;
	Fri, 31 Jul 2020 03:44:36 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BCB4RwRNl39W; Fri, 31 Jul 2020 03:44:36 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2F7F64B362;
	Fri, 31 Jul 2020 03:44:35 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 80D2F4B32B
 for <kvmarm@lists.cs.columbia.edu>; Fri, 31 Jul 2020 03:44:33 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DulrfFJ7KeWP for <kvmarm@lists.cs.columbia.edu>;
 Fri, 31 Jul 2020 03:44:32 -0400 (EDT)
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 4016A4B157
 for <kvmarm@lists.cs.columbia.edu>; Fri, 31 Jul 2020 03:44:32 -0400 (EDT)
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id CA99D1B48DADD2BC9804;
 Fri, 31 Jul 2020 15:43:36 +0800 (CST)
Received: from DESKTOP-FPN2511.china.huawei.com (10.174.187.42) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Fri, 31 Jul 2020 15:43:27 +0800
From: Jingyi Wang <wangjingyi11@huawei.com>
To: <drjones@redhat.com>, <kvm@vger.kernel.org>, <kvmarm@lists.cs.columbia.edu>
Subject: [kvm-unit-tests PATCH v3 07/10] arm64: microbench: Add time limit for
 each individual test
Date: Fri, 31 Jul 2020 15:42:41 +0800
Message-ID: <20200731074244.20432-8-wangjingyi11@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20200731074244.20432-1-wangjingyi11@huawei.com>
References: <20200731074244.20432-1-wangjingyi11@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.187.42]
X-CFilter-Loop: Reflected
Cc: maz@kernel.org, prime.zeng@hisilicon.com
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

Besides using separate running times parameter, we add time limit
for loop_test to make sure each test should be done in a certain
time(5 sec here).

Signed-off-by: Jingyi Wang <wangjingyi11@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 arm/micro-bench.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/arm/micro-bench.c b/arm/micro-bench.c
index 93bd855..09d9d53 100644
--- a/arm/micro-bench.c
+++ b/arm/micro-bench.c
@@ -22,6 +22,7 @@
 #include <asm/gic.h>
 #include <asm/gic-v3-its.h>
 
+#define NS_5_SECONDS (5 * 1000 * 1000 * 1000UL)
 static u32 cntfrq;
 
 static volatile bool irq_ready, irq_received;
@@ -267,23 +268,26 @@ static void loop_test(struct exit_test *test)
 	uint64_t start, end, total_ticks, ntimes = 0;
 	struct ns_time total_ns, avg_ns;
 
+	total_ticks = 0;
 	if (test->prep) {
 		if(!test->prep()) {
 			printf("%s test skipped\n", test->name);
 			return;
 		}
 	}
-	isb();
-	start = read_sysreg(cntpct_el0);
-	while (ntimes < test->times) {
+
+	while (ntimes < test->times && total_ns.ns < NS_5_SECONDS) {
+		isb();
+		start = read_sysreg(cntpct_el0);
 		test->exec();
+		isb();
+		end = read_sysreg(cntpct_el0);
+
 		ntimes++;
+		total_ticks += (end - start);
+		ticks_to_ns_time(total_ticks, &total_ns);
 	}
-	isb();
-	end = read_sysreg(cntpct_el0);
 
-	total_ticks = end - start;
-	ticks_to_ns_time(total_ticks, &total_ns);
 	avg_ns.ns = total_ns.ns / ntimes;
 	avg_ns.ns_frac = total_ns.ns_frac / ntimes;
 
-- 
2.19.1


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
