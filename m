Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 40392211A6C
	for <lists+kvmarm@lfdr.de>; Thu,  2 Jul 2020 05:02:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E7DC44B569;
	Wed,  1 Jul 2020 23:02:39 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W8lK3COBcFpG; Wed,  1 Jul 2020 23:02:38 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CCFFD4B580;
	Wed,  1 Jul 2020 23:02:37 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 38A674B572
 for <kvmarm@lists.cs.columbia.edu>; Wed,  1 Jul 2020 23:02:36 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jyOZ9Z7S60Mm for <kvmarm@lists.cs.columbia.edu>;
 Wed,  1 Jul 2020 23:02:35 -0400 (EDT)
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id BC7D74B569
 for <kvmarm@lists.cs.columbia.edu>; Wed,  1 Jul 2020 23:02:34 -0400 (EDT)
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 6708DC55B26981E027C7;
 Thu,  2 Jul 2020 11:02:30 +0800 (CST)
Received: from DESKTOP-FPN2511.china.huawei.com (10.174.187.42) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Thu, 2 Jul 2020 11:02:23 +0800
From: Jingyi Wang <wangjingyi11@huawei.com>
To: <drjones@redhat.com>, <kvm@vger.kernel.org>, <kvmarm@lists.cs.columbia.edu>
Subject: [kvm-unit-tests PATCH v2 6/8] arm64: microbench: Allow each test to
 specify its running times
Date: Thu, 2 Jul 2020 11:01:30 +0800
Message-ID: <20200702030132.20252-7-wangjingyi11@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20200702030132.20252-1-wangjingyi11@huawei.com>
References: <20200702030132.20252-1-wangjingyi11@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.187.42]
X-CFilter-Loop: Reflected
Cc: maz@kernel.org
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

For some test in micro-bench can be time consuming, we add a
micro-bench test parameter to allow each individual test to specify
its running times.

Signed-off-by: Jingyi Wang <wangjingyi11@huawei.com>
---
 arm/micro-bench.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/arm/micro-bench.c b/arm/micro-bench.c
index aeb60a7..506d2f9 100644
--- a/arm/micro-bench.c
+++ b/arm/micro-bench.c
@@ -223,17 +223,18 @@ struct exit_test {
 	const char *name;
 	bool (*prep)(void);
 	void (*exec)(void);
+	u32 times;
 	bool run;
 };
 
 static struct exit_test tests[] = {
-	{"hvc",			NULL,		hvc_exec,		true},
-	{"mmio_read_user",	NULL,		mmio_read_user_exec,	true},
-	{"mmio_read_vgic",	NULL,		mmio_read_vgic_exec,	true},
-	{"eoi",			NULL,		eoi_exec,		true},
-	{"ipi",			ipi_prep,	ipi_exec,		true},
-	{"ipi_hw",		ipi_hw_prep,	ipi_exec,		true},
-	{"lpi",			lpi_prep,	lpi_exec,		true},
+	{"hvc",			NULL,		hvc_exec,		NTIMES,		true},
+	{"mmio_read_user",	NULL,		mmio_read_user_exec,	NTIMES,		true},
+	{"mmio_read_vgic",	NULL,		mmio_read_vgic_exec,	NTIMES,		true},
+	{"eoi",			NULL,		eoi_exec,		NTIMES,		true},
+	{"ipi",			ipi_prep,	ipi_exec,		NTIMES,		true},
+	{"ipi_hw",		ipi_hw_prep,	ipi_exec,		NTIMES,		true},
+	{"lpi",			lpi_prep,	lpi_exec,		NTIMES,		true},
 };
 
 struct ns_time {
@@ -254,7 +255,7 @@ static void ticks_to_ns_time(uint64_t ticks, struct ns_time *ns_time)
 
 static void loop_test(struct exit_test *test)
 {
-	uint64_t start, end, total_ticks, ntimes = NTIMES;
+	uint64_t start, end, total_ticks, ntimes = 0;
 	struct ns_time total_ns, avg_ns;
 
 	if (test->prep) {
@@ -265,15 +266,17 @@ static void loop_test(struct exit_test *test)
 	}
 	isb();
 	start = read_sysreg(cntpct_el0);
-	while (ntimes--)
+	while (ntimes < test->times) {
 		test->exec();
+		ntimes++;
+	}
 	isb();
 	end = read_sysreg(cntpct_el0);
 
 	total_ticks = end - start;
 	ticks_to_ns_time(total_ticks, &total_ns);
-	avg_ns.ns = total_ns.ns / NTIMES;
-	avg_ns.ns_frac = total_ns.ns_frac / NTIMES;
+	avg_ns.ns = total_ns.ns / ntimes;
+	avg_ns.ns_frac = total_ns.ns_frac / ntimes;
 
 	printf("%-30s%15" PRId64 ".%-15" PRId64 "%15" PRId64 ".%-15" PRId64 "\n",
 		test->name, total_ns.ns, total_ns.ns_frac, avg_ns.ns, avg_ns.ns_frac);
-- 
2.19.1


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
