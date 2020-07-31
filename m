Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1782B23405C
	for <lists+kvmarm@lfdr.de>; Fri, 31 Jul 2020 09:45:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A96364B4CB;
	Fri, 31 Jul 2020 03:45:21 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fN0FoXAeaRGa; Fri, 31 Jul 2020 03:45:21 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7CDDF4B435;
	Fri, 31 Jul 2020 03:45:20 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3F8354B378
 for <kvmarm@lists.cs.columbia.edu>; Fri, 31 Jul 2020 03:45:19 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AoWx1ydQhDDT for <kvmarm@lists.cs.columbia.edu>;
 Fri, 31 Jul 2020 03:45:18 -0400 (EDT)
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 841E84B157
 for <kvmarm@lists.cs.columbia.edu>; Fri, 31 Jul 2020 03:45:15 -0400 (EDT)
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id B4BA015B9C2EA815E558;
 Fri, 31 Jul 2020 15:43:36 +0800 (CST)
Received: from DESKTOP-FPN2511.china.huawei.com (10.174.187.42) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Fri, 31 Jul 2020 15:43:29 +0800
From: Jingyi Wang <wangjingyi11@huawei.com>
To: <drjones@redhat.com>, <kvm@vger.kernel.org>, <kvmarm@lists.cs.columbia.edu>
Subject: [kvm-unit-tests PATCH v3 10/10] arm64: microbench: Add timer_post()
 to get actual PPI latency
Date: Fri, 31 Jul 2020 15:42:44 +0800
Message-ID: <20200731074244.20432-11-wangjingyi11@huawei.com>
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

For we get the time duration of (10msec timer + injection latency)
in timer_exec(), we substract the value of 10msec in timer_post()
to get the actual latency.

Signed-off-by: Jingyi Wang <wangjingyi11@huawei.com>
---
 arm/micro-bench.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arm/micro-bench.c b/arm/micro-bench.c
index 4680ba4..315fc7c 100644
--- a/arm/micro-bench.c
+++ b/arm/micro-bench.c
@@ -254,6 +254,18 @@ static void timer_exec(void)
 	assert_msg(irq_received, "failed to receive PPI in time, but received %d successfully\n", received);
 }
 
+static void timer_post(uint64_t total_ticks, uint64_t ntimes, struct ns_time *total_ns)
+{
+	/*
+	 * We use a 10msec timer to test the latency of PPI,
+	 * so we substract the ticks of 10msec to get the
+	 * actual latency
+	 */
+
+	total_ticks -= ntimes * (cntfrq / 100);
+	ticks_to_ns_time(total_ticks, total_ns);
+}
+
 static void hvc_exec(void)
 {
 	asm volatile("mov w0, #0x4b000000; hvc #0" ::: "w0");
@@ -302,7 +314,7 @@ static struct exit_test tests[] = {
 	{"ipi",			ipi_prep,	ipi_exec,		NULL,		65536,		true},
 	{"ipi_hw",		ipi_hw_prep,	ipi_exec,		NULL,		65536,		true},
 	{"lpi",			lpi_prep,	lpi_exec,		NULL,		65536,		true},
-	{"timer_10ms",		timer_prep,	timer_exec,		NULL,		256,		true},
+	{"timer_10ms",		timer_prep,	timer_exec,		timer_post,	256,		true},
 };
 
 #define PS_PER_SEC (1000 * 1000 * 1000 * 1000UL)
-- 
2.19.1


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
