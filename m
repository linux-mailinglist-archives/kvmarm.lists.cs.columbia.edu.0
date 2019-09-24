Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BDE4EBCB35
	for <lists+kvmarm@lfdr.de>; Tue, 24 Sep 2019 17:23:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6A0EA4A6DE;
	Tue, 24 Sep 2019 11:23:40 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MgkcPfaSDzwI; Tue, 24 Sep 2019 11:23:40 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A22814A691;
	Tue, 24 Sep 2019 11:23:35 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3CA114A691
 for <kvmarm@lists.cs.columbia.edu>; Tue, 24 Sep 2019 11:23:34 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TaStOtPe84qg for <kvmarm@lists.cs.columbia.edu>;
 Tue, 24 Sep 2019 11:23:33 -0400 (EDT)
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 14EB64A650
 for <kvmarm@lists.cs.columbia.edu>; Tue, 24 Sep 2019 11:23:33 -0400 (EDT)
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 51FF67C2680FDC283024;
 Tue, 24 Sep 2019 23:23:27 +0800 (CST)
Received: from linux-Bxxcye.huawei.com (10.175.104.222) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Tue, 24 Sep 2019 23:23:18 +0800
From: Heyi Guo <guoheyi@huawei.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>,
 <linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.cs.columbia.edu>
Subject: [RFC PATCH 06/12] core/irq: add qemu_irq_remove_intercept interface
Date: Tue, 24 Sep 2019 23:21:45 +0800
Message-ID: <1569338511-3572-7-git-send-email-guoheyi@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1569338511-3572-1-git-send-email-guoheyi@huawei.com>
References: <1569338511-3572-1-git-send-email-guoheyi@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.175.104.222]
X-CFilter-Loop: Reflected
Cc: Marc Zyngier <marc.zyngier@arm.com>, Heyi Guo <guoheyi@huawei.com>,
 Dave Martin <Dave.Martin@arm.com>
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

We use qemu_irq as the bridge for other qemu modules to switch from
irq injection to SDEI event trigger after VM binds the interrupt to
SDEI event. We use qemu_irq_intercept_in() to override qemu_irq
handler with SDEI event trigger, so we also need a corresponding
interface to restore the handler to default one (i.e. ARM GIC).

qemu_irq_remove_intercept() is the new interface to do the above
job.

Signed-off-by: Heyi Guo <guoheyi@huawei.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Dave Martin <Dave.Martin@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: James Morse <james.morse@arm.com>
---
 hw/core/irq.c    | 11 +++++++++++
 include/hw/irq.h |  8 ++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/hw/core/irq.c b/hw/core/irq.c
index 7cc0295..114bce6 100644
--- a/hw/core/irq.c
+++ b/hw/core/irq.c
@@ -145,6 +145,17 @@ void qemu_irq_intercept_in(qemu_irq *gpio_in, qemu_irq_handler handler, int n)
     }
 }
 
+void qemu_irq_remove_intercept(qemu_irq *gpio_in, int n)
+{
+    int i;
+    qemu_irq *old_irqs = gpio_in[0]->opaque;
+    for (i = 0; i < n; i++) {
+        gpio_in[i]->handler = old_irqs[i]->handler;
+        gpio_in[i]->opaque = old_irqs[i]->opaque;
+    }
+    qemu_free_irqs(old_irqs, n);
+}
+
 static const TypeInfo irq_type_info = {
    .name = TYPE_IRQ,
    .parent = TYPE_OBJECT,
diff --git a/include/hw/irq.h b/include/hw/irq.h
index fe527f6..1af1db9 100644
--- a/include/hw/irq.h
+++ b/include/hw/irq.h
@@ -56,8 +56,12 @@ qemu_irq qemu_irq_split(qemu_irq irq1, qemu_irq irq2);
  */
 qemu_irq *qemu_irq_proxy(qemu_irq **target, int n);
 
-/* For internal use in qtest.  Similar to qemu_irq_split, but operating
-   on an existing vector of qemu_irq.  */
+/*
+ * Similar to qemu_irq_split, but operating on an existing vector of qemu_irq.
+ */
 void qemu_irq_intercept_in(qemu_irq *gpio_in, qemu_irq_handler handler, int n);
 
+/* Restore the irq handler intercepted by qemu_irq_intercept_in() */
+void qemu_irq_remove_intercept(qemu_irq *gpio_in, int n);
+
 #endif
-- 
1.8.3.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
