Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id ED0FDE631D
	for <lists+kvmarm@lfdr.de>; Sun, 27 Oct 2019 15:43:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9BED34AC8C;
	Sun, 27 Oct 2019 10:43:14 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uRwqR6L1DH6g; Sun, 27 Oct 2019 10:43:14 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9662B4AC70;
	Sun, 27 Oct 2019 10:43:13 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9F20C4AC68
 for <kvmarm@lists.cs.columbia.edu>; Sun, 27 Oct 2019 10:43:11 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ctno6urvey-q for <kvmarm@lists.cs.columbia.edu>;
 Sun, 27 Oct 2019 10:43:10 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A1D694AC67
 for <kvmarm@lists.cs.columbia.edu>; Sun, 27 Oct 2019 10:43:10 -0400 (EDT)
Received: from localhost.localdomain (82-132-239-15.dab.02.net [82.132.239.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3C51D21D7F;
 Sun, 27 Oct 2019 14:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1572187389;
 bh=XbLNgU9kPdlH8Fi9JQlXClvf4wOZdwwOaVg4Lg0NAEY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=zVuATdU0L3w5v+50DmfHU6/yACp0SXjxRlSqpQFjHgh+gp2PZwLS+VMN+vYyGYxD2
 NfKEM6jLPx1PxiouSbACXLQmrwTE1ObOZcILq3nJskOLEaEFFk9VJc9s11CxRRjXyV
 Zfhvc4keMk1Qp/8ZJFiA0XdiL/yS1BOxJX5+fVQQ=
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.cs.columbia.edu,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/36] irqchip/gic-v3-its: Factor out wait_for_syncr
 primitive
Date: Sun, 27 Oct 2019 14:42:00 +0000
Message-Id: <20191027144234.8395-3-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191027144234.8395-1-maz@kernel.org>
References: <20191027144234.8395-1-maz@kernel.org>
MIME-Version: 1.0
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Jason Cooper <jason@lakedaemon.net>, Robert Richter <rrichter@marvell.com>,
 Jayachandran C <jnair@marvell.com>, Thomas Gleixner <tglx@linutronix.de>
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

Waiting for a redistributor to have performed an operation is a
common thing to do, and the idiom is already spread around.
As we're going to make even more use of this, let's have a primitive
that does just that.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 62e54f1a248b..58cb233cf138 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1075,6 +1075,12 @@ static void lpi_write_config(struct irq_data *d, u8 clr, u8 set)
 		dsb(ishst);
 }
 
+static void wait_for_syncr(void __iomem *rdbase)
+{
+	while (gic_read_lpir(rdbase + GICR_SYNCR) & 1)
+		cpu_relax();
+}
+
 static void lpi_update_config(struct irq_data *d, u8 clr, u8 set)
 {
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
@@ -2757,8 +2763,7 @@ static void its_vpe_db_proxy_move(struct its_vpe *vpe, int from, int to)
 
 		rdbase = per_cpu_ptr(gic_rdists->rdist, from)->rd_base;
 		gic_write_lpir(vpe->vpe_db_lpi, rdbase + GICR_CLRLPIR);
-		while (gic_read_lpir(rdbase + GICR_SYNCR) & 1)
-			cpu_relax();
+		wait_for_syncr(rdbase);
 
 		return;
 	}
@@ -2914,8 +2919,7 @@ static void its_vpe_send_inv(struct irq_data *d)
 
 		rdbase = per_cpu_ptr(gic_rdists->rdist, vpe->col_idx)->rd_base;
 		gic_write_lpir(vpe->vpe_db_lpi, rdbase + GICR_INVLPIR);
-		while (gic_read_lpir(rdbase + GICR_SYNCR) & 1)
-			cpu_relax();
+		wait_for_syncr(rdbase);
 	} else {
 		its_vpe_send_cmd(vpe, its_send_inv);
 	}
@@ -2957,8 +2961,7 @@ static int its_vpe_set_irqchip_state(struct irq_data *d,
 			gic_write_lpir(vpe->vpe_db_lpi, rdbase + GICR_SETLPIR);
 		} else {
 			gic_write_lpir(vpe->vpe_db_lpi, rdbase + GICR_CLRLPIR);
-			while (gic_read_lpir(rdbase + GICR_SYNCR) & 1)
-				cpu_relax();
+			wait_for_syncr(rdbase);
 		}
 	} else {
 		if (state)
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
