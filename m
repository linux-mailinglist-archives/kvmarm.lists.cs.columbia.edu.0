Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB1223404A
	for <lists+kvmarm@lfdr.de>; Fri, 31 Jul 2020 09:43:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B4E5A4B318;
	Fri, 31 Jul 2020 03:43:46 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w0XWUqGbzUyo; Fri, 31 Jul 2020 03:43:46 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8281F4B30A;
	Fri, 31 Jul 2020 03:43:45 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 884EC4B4FF
 for <kvmarm@lists.cs.columbia.edu>; Fri, 31 Jul 2020 03:43:43 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OjcBM5XCGX6j for <kvmarm@lists.cs.columbia.edu>;
 Fri, 31 Jul 2020 03:43:42 -0400 (EDT)
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id EF6774B32B
 for <kvmarm@lists.cs.columbia.edu>; Fri, 31 Jul 2020 03:43:41 -0400 (EDT)
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id D6EE2BF785157088A94E;
 Fri, 31 Jul 2020 15:43:31 +0800 (CST)
Received: from DESKTOP-FPN2511.china.huawei.com (10.174.187.42) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Fri, 31 Jul 2020 15:43:24 +0800
From: Jingyi Wang <wangjingyi11@huawei.com>
To: <drjones@redhat.com>, <kvm@vger.kernel.org>, <kvmarm@lists.cs.columbia.edu>
Subject: [kvm-unit-tests PATCH v3 02/10] arm64: microbench: Generalize ipi
 test names
Date: Fri, 31 Jul 2020 15:42:36 +0800
Message-ID: <20200731074244.20432-3-wangjingyi11@huawei.com>
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

Later patches will use these functions for gic(ipi/lpi/timer) tests.

Signed-off-by: Jingyi Wang <wangjingyi11@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 arm/micro-bench.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/arm/micro-bench.c b/arm/micro-bench.c
index 794dfac..fc4d356 100644
--- a/arm/micro-bench.c
+++ b/arm/micro-bench.c
@@ -25,24 +25,24 @@
 
 static u32 cntfrq;
 
-static volatile bool ipi_ready, ipi_received;
+static volatile bool irq_ready, irq_received;
 static void *vgic_dist_base;
 static void (*write_eoir)(u32 irqstat);
 
-static void ipi_irq_handler(struct pt_regs *regs)
+static void gic_irq_handler(struct pt_regs *regs)
 {
-	ipi_ready = false;
-	ipi_received = true;
+	irq_ready = false;
+	irq_received = true;
 	gic_write_eoir(gic_read_iar());
-	ipi_ready = true;
+	irq_ready = true;
 }
 
-static void ipi_secondary_entry(void *data)
+static void gic_secondary_entry(void *data)
 {
-	install_irq_handler(EL1H_IRQ, ipi_irq_handler);
+	install_irq_handler(EL1H_IRQ, gic_irq_handler);
 	gic_enable_defaults();
 	local_irq_enable();
-	ipi_ready = true;
+	irq_ready = true;
 	while (true)
 		cpu_relax();
 }
@@ -72,9 +72,9 @@ static bool test_init(void)
 		break;
 	}
 
-	ipi_ready = false;
+	irq_ready = false;
 	gic_enable_defaults();
-	on_cpu_async(1, ipi_secondary_entry, NULL);
+	on_cpu_async(1, gic_secondary_entry, NULL);
 
 	cntfrq = get_cntfrq();
 	printf("Timer Frequency %d Hz (Output in microseconds)\n", cntfrq);
@@ -82,13 +82,18 @@ static bool test_init(void)
 	return true;
 }
 
-static void ipi_prep(void)
+static void gic_prep_common(void)
 {
 	unsigned tries = 1 << 28;
 
-	while (!ipi_ready && tries--)
+	while (!irq_ready && tries--)
 		cpu_relax();
-	assert(ipi_ready);
+	assert(irq_ready);
+}
+
+static void ipi_prep(void)
+{
+	gic_prep_common();
 }
 
 static void ipi_exec(void)
@@ -96,17 +101,17 @@ static void ipi_exec(void)
 	unsigned tries = 1 << 28;
 	static int received = 0;
 
-	ipi_received = false;
+	irq_received = false;
 
 	gic_ipi_send_single(1, 1);
 
-	while (!ipi_received && tries--)
+	while (!irq_received && tries--)
 		cpu_relax();
 
-	if (ipi_received)
+	if (irq_received)
 		++received;
 
-	assert_msg(ipi_received, "failed to receive IPI in time, but received %d successfully\n", received);
+	assert_msg(irq_received, "failed to receive IPI in time, but received %d successfully\n", received);
 }
 
 static void hvc_exec(void)
-- 
2.19.1


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
