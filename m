Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id EFB4DE6333
	for <lists+kvmarm@lfdr.de>; Sun, 27 Oct 2019 15:44:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A36B84A800;
	Sun, 27 Oct 2019 10:44:00 -0400 (EDT)
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
	with ESMTP id 2Kw+U+j35OTE; Sun, 27 Oct 2019 10:44:00 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 836E84A7F1;
	Sun, 27 Oct 2019 10:43:59 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B63014A521
 for <kvmarm@lists.cs.columbia.edu>; Sun, 27 Oct 2019 10:43:57 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f-+hSSu2M1Tx for <kvmarm@lists.cs.columbia.edu>;
 Sun, 27 Oct 2019 10:43:56 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 916E24A7FD
 for <kvmarm@lists.cs.columbia.edu>; Sun, 27 Oct 2019 10:43:56 -0400 (EDT)
Received: from localhost.localdomain (82-132-239-15.dab.02.net [82.132.239.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2B2F7214AF;
 Sun, 27 Oct 2019 14:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1572187435;
 bh=CA+V3kafszvCceUU78xM+0W20S+ptHDqrXrmDcJtEwY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VPW71MfwQJvuMjNgpQR+ACqb6XGn2ae4zV+y4YRW5iiAi5NX8kgmg4DYzwwTvZTx1
 1bW89oezeoNk0kPywF5wV8svGegI48vOyPU4LaGG+Mv3vbFrULE63CZdiO5EqQTFnt
 bSHTYSa8dy8DDhcl+pHDn6c9SiIjDYOgkZ0QFXYo=
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.cs.columbia.edu,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/36] irqchip/gic-v3: Detect GICv4.1 supporting RVPEID
Date: Sun, 27 Oct 2019 14:42:06 +0000
Message-Id: <20191027144234.8395-9-maz@kernel.org>
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

GICv4.1 supports the RVPEID ("Residency per vPE ID"), which allows for
a much efficient way of making virtual CPUs resident (to allow direct
injection of interrupts).

The functionnality needs to be discovered on each and every redistributor
in the system, and disabled if the settings are inconsistent.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3.c       | 21 ++++++++++++++++++---
 include/linux/irqchip/arm-gic-v3.h |  2 ++
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 1edc99335a94..4f20caf9bc88 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -849,8 +849,21 @@ static int __gic_update_rdist_properties(struct redist_region *region,
 					 void __iomem *ptr)
 {
 	u64 typer = gic_read_typer(ptr + GICR_TYPER);
+
 	gic_data.rdists.has_vlpis &= !!(typer & GICR_TYPER_VLPIS);
-	gic_data.rdists.has_direct_lpi &= !!(typer & GICR_TYPER_DirectLPIS);
+
+	/* RVPEID implies some form of DirectLPI, no matter what the doc says... :-/ */
+	gic_data.rdists.has_rvpeid &= !!(typer & GICR_TYPER_RVPEID);
+	gic_data.rdists.has_direct_lpi &= (!!(typer & GICR_TYPER_DirectLPIS) |
+					   gic_data.rdists.has_rvpeid);
+
+	/* Detect non-sensical configurations */
+	if (WARN_ON_ONCE(gic_data.rdists.has_rvpeid && !gic_data.rdists.has_vlpis)) {
+		gic_data.rdists.has_direct_lpi = false;
+		gic_data.rdists.has_vlpis = false;
+		gic_data.rdists.has_rvpeid = false;
+	}
+
 	gic_data.ppi_nr = min(GICR_TYPER_NR_PPIS(typer), gic_data.ppi_nr);
 
 	return 1;
@@ -863,9 +876,10 @@ static void gic_update_rdist_properties(void)
 	if (WARN_ON(gic_data.ppi_nr == UINT_MAX))
 		gic_data.ppi_nr = 0;
 	pr_info("%d PPIs implemented\n", gic_data.ppi_nr);
-	pr_info("%sVLPI support, %sdirect LPI support\n",
+	pr_info("%sVLPI support, %sdirect LPI support, %sRVPEID support\n",
 		!gic_data.rdists.has_vlpis ? "no " : "",
-		!gic_data.rdists.has_direct_lpi ? "no " : "");
+		!gic_data.rdists.has_direct_lpi ? "no " : "",
+		!gic_data.rdists.has_rvpeid ? "no " : "");
 }
 
 /* Check whether it's single security state view */
@@ -1546,6 +1560,7 @@ static int __init gic_init_bases(void __iomem *dist_base,
 						 &gic_data);
 	irq_domain_update_bus_token(gic_data.domain, DOMAIN_BUS_WIRED);
 	gic_data.rdists.rdist = alloc_percpu(typeof(*gic_data.rdists.rdist));
+	gic_data.rdists.has_rvpeid = true;
 	gic_data.rdists.has_vlpis = true;
 	gic_data.rdists.has_direct_lpi = true;
 
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index b6514e8893bf..c98f34296599 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -234,6 +234,7 @@
 #define GICR_TYPER_VLPIS		(1U << 1)
 #define GICR_TYPER_DirectLPIS		(1U << 3)
 #define GICR_TYPER_LAST			(1U << 4)
+#define GICR_TYPER_RVPEID		(1U << 7)
 
 #define GIC_V3_REDIST_SIZE		0x20000
 
@@ -613,6 +614,7 @@ struct rdists {
 	u64			flags;
 	u32			gicd_typer;
 	bool			has_vlpis;
+	bool			has_rvpeid;
 	bool			has_direct_lpi;
 };
 
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
