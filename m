Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A6DAC19A930
	for <lists+kvmarm@lfdr.de>; Wed,  1 Apr 2020 12:09:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5C0274B0D9;
	Wed,  1 Apr 2020 06:09:20 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wI1ADEy5tGo9; Wed,  1 Apr 2020 06:09:20 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3EF7B4B0D7;
	Wed,  1 Apr 2020 06:09:19 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 009854B0CE
 for <kvmarm@lists.cs.columbia.edu>; Wed,  1 Apr 2020 06:09:18 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rf2VyxqkJiKZ for <kvmarm@lists.cs.columbia.edu>;
 Wed,  1 Apr 2020 06:09:17 -0400 (EDT)
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id C57F84A418
 for <kvmarm@lists.cs.columbia.edu>; Wed,  1 Apr 2020 06:09:00 -0400 (EDT)
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 89E3E897F185FC9B8DBD;
 Wed,  1 Apr 2020 18:08:35 +0800 (CST)
Received: from DESKTOP-FPN2511.china.huawei.com (10.173.222.58) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Wed, 1 Apr 2020 18:08:28 +0800
From: Jingyi Wang <wangjingyi11@huawei.com>
To: <drjones@redhat.com>, <kvm@vger.kernel.org>, <kvmarm@lists.cs.columbia.edu>
Subject: [kvm-unit-tests PATCH 1/2] arm/arm64: gic: Add IPI latency test
Date: Wed, 1 Apr 2020 18:08:11 +0800
Message-ID: <20200401100812.27616-2-wangjingyi11@huawei.com>
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

This patch add a test to measure the latency of IPI injection.

Signed-off-by: Jingyi Wang <wangjingyi11@huawei.com>
---
 arm/gic.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arm/gic.c b/arm/gic.c
index fcf4c1f..f5e830e 100644
--- a/arm/gic.c
+++ b/arm/gic.c
@@ -27,6 +27,9 @@ struct gic {
 	struct {
 		void (*send_self)(void);
 		void (*send_broadcast)(void);
+		u64 ipi_inject_time;
+		u64 ipi_receive_time[NR_CPUS];
+		int nr_records;
 	} ipi;
 };
 
@@ -142,6 +145,7 @@ static void check_irqnr(u32 irqnr)
 
 static void ipi_handler(struct pt_regs *regs __unused)
 {
+	gic->ipi.ipi_receive_time[gic->ipi.nr_records++] = get_cntvct();
 	u32 irqstat = gic_read_iar();
 	u32 irqnr = gic_iar_irqnr(irqstat);
 
@@ -187,9 +191,16 @@ static void ipi_test_self(void)
 	stats_reset();
 	cpumask_clear(&mask);
 	cpumask_set_cpu(smp_processor_id(), &mask);
+
+	gic->ipi.nr_records = 0;
+	gic->ipi.ipi_inject_time = get_cntvct();
 	gic->ipi.send_self();
+
 	check_acked("IPI: self", &mask);
 	report_prefix_pop();
+
+	report_info("The latency of ipi_test_self: %ld cycles",
+			gic->ipi.ipi_receive_time[0] - gic->ipi.ipi_inject_time);
 }
 
 static void ipi_test_smp(void)
@@ -202,17 +213,33 @@ static void ipi_test_smp(void)
 	cpumask_copy(&mask, &cpu_present_mask);
 	for (i = smp_processor_id() & 1; i < nr_cpus; i += 2)
 		cpumask_clear_cpu(i, &mask);
+
+	gic->ipi.nr_records = 0;
+	gic->ipi.ipi_inject_time = get_cntvct();
 	gic_ipi_send_mask(IPI_IRQ, &mask);
+
 	check_acked("IPI: directed", &mask);
 	report_prefix_pop();
 
+	for (i = 0; i < gic->ipi.nr_records; i++)
+		report_info("The latency of ipi_test_smp(directed): %ld cycles",
+			gic->ipi.ipi_receive_time[i] - gic->ipi.ipi_inject_time);
+
 	report_prefix_push("broadcast");
 	stats_reset();
 	cpumask_copy(&mask, &cpu_present_mask);
 	cpumask_clear_cpu(smp_processor_id(), &mask);
+
+	gic->ipi.nr_records = 0;
+	gic->ipi.ipi_inject_time = get_cntvct();
 	gic->ipi.send_broadcast();
+
 	check_acked("IPI: broadcast", &mask);
 	report_prefix_pop();
+
+	for (i = 0; i < gic->ipi.nr_records; i++)
+		report_info("The latency of ipi_test_smp(broadcast): %ld cycles",
+			gic->ipi.ipi_receive_time[i] - gic->ipi.ipi_inject_time);
 }
 
 static void ipi_enable(void)
-- 
2.19.1


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
