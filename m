Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C2002BBB6F
	for <lists+kvmarm@lfdr.de>; Mon, 23 Sep 2019 20:27:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7223E4A654;
	Mon, 23 Sep 2019 14:27:48 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MG1MU48Ik+eb; Mon, 23 Sep 2019 14:27:48 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 48CAC4A677;
	Mon, 23 Sep 2019 14:27:47 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3653C4A51F
 for <kvmarm@lists.cs.columbia.edu>; Mon, 23 Sep 2019 14:27:46 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5-1KaL0wni5f for <kvmarm@lists.cs.columbia.edu>;
 Mon, 23 Sep 2019 14:27:45 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3F5004A5A0
 for <kvmarm@lists.cs.columbia.edu>; Mon, 23 Sep 2019 14:27:45 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBE261C01;
 Mon, 23 Sep 2019 11:27:44 -0700 (PDT)
Received: from big-swifty.lan (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 29A503F694;
 Mon, 23 Sep 2019 11:27:40 -0700 (PDT)
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.cs.columbia.edu,
	linux-kernel@vger.kernel.org
Subject: [PATCH 20/35] irqchip/gic-v4.1: Allow direct invalidation of VLPIs
Date: Mon, 23 Sep 2019 19:25:51 +0100
Message-Id: <20190923182606.32100-21-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190923182606.32100-1-maz@kernel.org>
References: <20190923182606.32100-1-maz@kernel.org>
MIME-Version: 1.0
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>
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

Just like for INVALL, GICv4.1 has grown a VPE-aware INVLPI register.
Let's plumb it in and make use of the DirectLPI code in that case.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c   | 19 +++++++++++++++++--
 include/linux/irqchip/arm-gic-v3.h |  1 +
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index b791c9beddf2..34595a7fcccb 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1200,13 +1200,27 @@ static void wait_for_syncr(void __iomem *rdbase)
 
 static void direct_lpi_inv(struct irq_data *d)
 {
+	struct its_vlpi_map *map = get_vlpi_map(d);
 	struct its_collection *col;
 	void __iomem *rdbase;
+	u64 val;
+
+	if (map) {
+		struct its_device *its_dev = irq_data_get_irq_chip_data(d);
+
+		WARN_ON(!is_v4_1(its_dev->its));
+
+		val  = GICR_INVLPIR_V;
+		val |= FIELD_PREP(GICR_INVLPIR_VPEID, map->vpe->vpe_id);
+		val |= FIELD_PREP(GICR_INVLPIR_INTID, map->vintid);
+	} else {
+		val = d->hwirq;
+	}
 
 	/* Target the redistributor this LPI is currently routed to */
 	col = irq_to_col(d);
 	rdbase = per_cpu_ptr(gic_rdists->rdist, col->col_id)->rd_base;
-	gic_write_lpir(d->hwirq, rdbase + GICR_INVLPIR);
+	gic_write_lpir(val, rdbase + GICR_INVLPIR);
 
 	wait_for_syncr(rdbase);
 }
@@ -1216,7 +1230,8 @@ static void lpi_update_config(struct irq_data *d, u8 clr, u8 set)
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
 
 	lpi_write_config(d, clr, set);
-	if (gic_rdists->has_direct_lpi && !irqd_is_forwarded_to_vcpu(d))
+	if (gic_rdists->has_direct_lpi &&
+	    (is_v4_1(its_dev->its) || !irqd_is_forwarded_to_vcpu(d)))
 		direct_lpi_inv(d);
 	else
 		its_send_inv(its_dev, its_get_event_id(d));
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index b69f60792554..5f3278cbf247 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -247,6 +247,7 @@
 #define GICR_TYPER_COMMON_LPI_AFF	GENMASK_ULL(25, 24)
 #define GICR_TYPER_AFFINITY		GENMASK_ULL(63, 32)
 
+#define GICR_INVLPIR_INTID		GENMASK_ULL(31, 0)
 #define GICR_INVLPIR_VPEID		GENMASK_ULL(47, 32)
 #define GICR_INVLPIR_V			GENMASK_ULL(63, 63)
 
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
