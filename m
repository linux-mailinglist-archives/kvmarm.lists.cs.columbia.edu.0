Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A68C5144E0D
	for <lists+kvmarm@lfdr.de>; Wed, 22 Jan 2020 09:56:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2CB584ACBE;
	Wed, 22 Jan 2020 03:56:51 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id teJO8Y6LPx2A; Wed, 22 Jan 2020 03:56:51 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0FC8B4A982;
	Wed, 22 Jan 2020 03:56:50 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8942C4A830
 for <kvmarm@lists.cs.columbia.edu>; Wed, 22 Jan 2020 03:56:49 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jbUO8uyn7a7R for <kvmarm@lists.cs.columbia.edu>;
 Wed, 22 Jan 2020 03:56:48 -0500 (EST)
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A98984A7FE
 for <kvmarm@lists.cs.columbia.edu>; Wed, 22 Jan 2020 03:56:47 -0500 (EST)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 5AA0BFA352067B42F98D;
 Wed, 22 Jan 2020 16:56:44 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.173.222.27) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Wed, 22 Jan 2020 16:56:35 +0800
From: Zenghui Yu <yuzenghui@huawei.com>
To: <maz@kernel.org>
Subject: [PATCH] irqchip/gic-v3-its: Don't confuse get_vlpi_map() by writing
 DB config
Date: Wed, 22 Jan 2020 16:56:09 +0800
Message-ID: <20200122085609.658-1-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Cc: jason@lakedaemon.net, linux-kernel@vger.kernel.org, tglx@linutronix.de,
 kvmarm@lists.cs.columbia.edu
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

When we're writing config for the doorbell interrupt, get_vlpi_map() will
get confused by doorbell's d->parent_data hack and find the wrong its_dev
as chip data and the wrong event.

Fix this issue by making sure no doorbells will be involved before invoking
get_vlpi_map(), which restore some of the logic in lpi_write_config().

Fixes: c1d4d5cd203c ("irqchip/gic-v3-its: Add its_vlpi_map helpers")
Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---

This is based on mainline and can't be directly applied to the current
irqchip-next.

 drivers/irqchip/irq-gic-v3-its.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index e05673bcd52b..cc8a4fcbd6d6 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1181,12 +1181,13 @@ static struct its_vlpi_map *get_vlpi_map(struct irq_data *d)
 
 static void lpi_write_config(struct irq_data *d, u8 clr, u8 set)
 {
-	struct its_vlpi_map *map = get_vlpi_map(d);
 	irq_hw_number_t hwirq;
 	void *va;
 	u8 *cfg;
 
-	if (map) {
+	if (irqd_is_forwarded_to_vcpu(d)) {
+		struct its_vlpi_map *map = get_vlpi_map(d);
+
 		va = page_address(map->vm->vprop_page);
 		hwirq = map->vintid;
 
-- 
2.19.1


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
