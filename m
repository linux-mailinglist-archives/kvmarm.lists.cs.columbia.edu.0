Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B2E3A2340E0
	for <lists+kvmarm@lfdr.de>; Fri, 31 Jul 2020 10:09:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4976C4B3DF;
	Fri, 31 Jul 2020 04:09:39 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EYQM4yewWSrP; Fri, 31 Jul 2020 04:09:39 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4490E4B3F6;
	Fri, 31 Jul 2020 04:09:38 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 21A9B4B3DB
 for <kvmarm@lists.cs.columbia.edu>; Fri, 31 Jul 2020 04:09:37 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mE3jCp30zEry for <kvmarm@lists.cs.columbia.edu>;
 Fri, 31 Jul 2020 04:09:35 -0400 (EDT)
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 3E94C4A588
 for <kvmarm@lists.cs.columbia.edu>; Fri, 31 Jul 2020 04:09:35 -0400 (EDT)
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id C5525B7A01AD3F83687B;
 Fri, 31 Jul 2020 15:43:36 +0800 (CST)
Received: from DESKTOP-FPN2511.china.huawei.com (10.174.187.42) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Fri, 31 Jul 2020 15:43:26 +0800
From: Jingyi Wang <wangjingyi11@huawei.com>
To: <drjones@redhat.com>, <kvm@vger.kernel.org>, <kvmarm@lists.cs.columbia.edu>
Subject: [kvm-unit-tests PATCH v3 05/10] arm64: microbench: its: Add LPI
 latency test
Date: Fri, 31 Jul 2020 15:42:39 +0800
Message-ID: <20200731074244.20432-6-wangjingyi11@huawei.com>
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

Triggers LPIs through the INT command and test the latency.
Mostly inherited form commit 0ef02cd6cbaa(arm/arm64: ITS: INT
functional tests).

Signed-off-by: Jingyi Wang <wangjingyi11@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 arm/micro-bench.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arm/micro-bench.c b/arm/micro-bench.c
index f8314db..82f3c07 100644
--- a/arm/micro-bench.c
+++ b/arm/micro-bench.c
@@ -20,6 +20,7 @@
  */
 #include <libcflat.h>
 #include <asm/gic.h>
+#include <asm/gic-v3-its.h>
 
 #define NTIMES (1U << 16)
 
@@ -156,6 +157,48 @@ static void ipi_exec(void)
 	assert_msg(irq_received, "failed to receive IPI in time, but received %d successfully\n", nr_ipi_received);
 }
 
+static bool lpi_prep(void)
+{
+	struct its_collection *col1;
+	struct its_device *dev2;
+
+	if (!gicv3_its_base())
+		return false;
+
+	its_enable_defaults();
+	dev2 = its_create_device(2 /* dev id */, 8 /* nb_ites */);
+	col1 = its_create_collection(1 /* col id */, 1 /* target PE */);
+	gicv3_lpi_set_config(8199, LPI_PROP_DEFAULT);
+
+	its_send_mapd_nv(dev2, true);
+	its_send_mapc_nv(col1, true);
+	its_send_invall_nv(col1);
+	its_send_mapti_nv(dev2, 8199 /* lpi id */, 20 /* event id */, col1);
+
+	gic_prep_common();
+	return true;
+}
+
+static void lpi_exec(void)
+{
+	struct its_device *dev2;
+	unsigned tries = 1 << 28;
+	static int received = 0;
+
+	irq_received = false;
+
+	dev2 = its_get_device(2);
+	its_send_int_nv(dev2, 20);
+
+	while (!irq_received && tries--)
+		cpu_relax();
+
+	if (irq_received)
+		++received;
+
+	assert_msg(irq_received, "failed to receive LPI in time, but received %d successfully\n", received);
+}
+
 static void hvc_exec(void)
 {
 	asm volatile("mov w0, #0x4b000000; hvc #0" ::: "w0");
@@ -201,6 +244,7 @@ static struct exit_test tests[] = {
 	{"eoi",			NULL,		eoi_exec,		true},
 	{"ipi",			ipi_prep,	ipi_exec,		true},
 	{"ipi_hw",		ipi_hw_prep,	ipi_exec,		true},
+	{"lpi",			lpi_prep,	lpi_exec,		true},
 };
 
 struct ns_time {
-- 
2.19.1


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
