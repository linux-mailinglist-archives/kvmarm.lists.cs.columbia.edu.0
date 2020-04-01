Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0D61B19A92D
	for <lists+kvmarm@lfdr.de>; Wed,  1 Apr 2020 12:08:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0BDF94B0DB;
	Wed,  1 Apr 2020 06:08:48 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xzdlmWqk4qrj; Wed,  1 Apr 2020 06:08:47 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E9ABE4B0D1;
	Wed,  1 Apr 2020 06:08:46 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C51EE4B0B1
 for <kvmarm@lists.cs.columbia.edu>; Wed,  1 Apr 2020 06:08:45 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ki4bslskUH6h for <kvmarm@lists.cs.columbia.edu>;
 Wed,  1 Apr 2020 06:08:44 -0400 (EDT)
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 656604A418
 for <kvmarm@lists.cs.columbia.edu>; Wed,  1 Apr 2020 06:08:44 -0400 (EDT)
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 81EBF35FAB3AE066FAFF;
 Wed,  1 Apr 2020 18:08:35 +0800 (CST)
Received: from DESKTOP-FPN2511.china.huawei.com (10.173.222.58) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Wed, 1 Apr 2020 18:08:29 +0800
From: Jingyi Wang <wangjingyi11@huawei.com>
To: <drjones@redhat.com>, <kvm@vger.kernel.org>, <kvmarm@lists.cs.columbia.edu>
Subject: [kvm-unit-tests PATCH 2/2] arm/arm64: Add vtimer latency test
Date: Wed, 1 Apr 2020 18:08:12 +0800
Message-ID: <20200401100812.27616-3-wangjingyi11@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20200401100812.27616-1-wangjingyi11@huawei.com>
References: <20200401100812.27616-1-wangjingyi11@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.173.222.58]
X-CFilter-Loop: Reflected
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

This patch add a test to measure the precise vtimer firing time.

Signed-off-by: Jingyi Wang <wangjingyi11@huawei.com>
---
 arm/timer.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arm/timer.c b/arm/timer.c
index f390e8e..1d5b3dc 100644
--- a/arm/timer.c
+++ b/arm/timer.c
@@ -16,6 +16,9 @@
 #define ARCH_TIMER_CTL_IMASK   (1 << 1)
 #define ARCH_TIMER_CTL_ISTATUS (1 << 2)
 
+static u64 inject_time;
+static u64 receive_time;
+
 static void *gic_ispendr;
 static void *gic_isenabler;
 static void *gic_icenabler;
@@ -149,6 +152,8 @@ static void irq_handler(struct pt_regs *regs)
 	u32 irqstat = gic_read_iar();
 	u32 irqnr = gic_iar_irqnr(irqstat);
 
+	receive_time = get_cntvct();
+
 	if (irqnr != GICC_INT_SPURIOUS)
 		gic_write_eoir(irqstat);
 
@@ -163,6 +168,11 @@ static void irq_handler(struct pt_regs *regs)
 
 	info->write_ctl(ARCH_TIMER_CTL_IMASK | ARCH_TIMER_CTL_ENABLE);
 	info->irq_received = true;
+
+	if (inject_time != 0)
+		report_info("vtimer latency: %ld cycles/10ms\n",
+			receive_time - inject_time);
+	inject_time = 0;
 }
 
 static bool gic_timer_pending(struct timer_info *info)
@@ -179,6 +189,7 @@ static bool test_cval_10msec(struct timer_info *info)
 
 	/* Program timer to fire in 10 ms */
 	before_timer = info->read_counter();
+	inject_time = get_cntvct();
 	info->write_cval(before_timer + time_10ms);
 	info->write_ctl(ARCH_TIMER_CTL_ENABLE);
 	isb();
-- 
2.19.1


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
