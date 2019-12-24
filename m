Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 485F212A051
	for <lists+kvmarm@lfdr.de>; Tue, 24 Dec 2019 12:11:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EE7624AF78;
	Tue, 24 Dec 2019 06:11:25 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XPnWEi3G7LIx; Tue, 24 Dec 2019 06:11:25 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 51D474AF8E;
	Tue, 24 Dec 2019 06:11:23 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3D8594AF49
 for <kvmarm@lists.cs.columbia.edu>; Tue, 24 Dec 2019 06:11:22 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v0h4yrKc4af5 for <kvmarm@lists.cs.columbia.edu>;
 Tue, 24 Dec 2019 06:11:21 -0500 (EST)
Received: from inca-roads.misterjones.org (inca-roads.misterjones.org
 [213.251.177.50])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 084684AF55
 for <kvmarm@lists.cs.columbia.edu>; Tue, 24 Dec 2019 06:11:17 -0500 (EST)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by cheepnis.misterjones.org with esmtpsa
 (TLSv1.2:DHE-RSA-AES128-GCM-SHA256:128) (Exim 4.80)
 (envelope-from <maz@kernel.org>)
 id 1iji5r-000169-Kr; Tue, 24 Dec 2019 12:11:16 +0100
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.cs.columbia.edu,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/32] irqchip/gic-v4.1: Don't use the VPE proxy if RVPEID
 is set
Date: Tue, 24 Dec 2019 11:10:30 +0000
Message-Id: <20191224111055.11836-8-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224111055.11836-1-maz@kernel.org>
References: <20191224111055.11836-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
 eric.auger@redhat.com, james.morse@arm.com, julien.thierry.kdev@gmail.com,
 suzuki.poulose@arm.com, tglx@linutronix.de, jason@lakedaemon.net,
 lorenzo.pieralisi@arm.com, Andrew.Murray@arm.com, yuzenghui@huawei.com,
 rrichter@marvell.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org);
 SAEximRunCond expanded to false
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Jason Cooper <jason@lakedaemon.net>, Robert Richter <rrichter@marvell.com>,
 Thomas Gleixner <tglx@linutronix.de>
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

The infamous VPE proxy device isn't used with GICv4.1 because:
- we can invalidate any LPI from the DirectLPI MMIO interface
- the ITS and redistributors understand the life cycle of
  the doorbell, so we don't need to enable/disable it all
  the time

So let's escape early from the proxy related functions.

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index e3c7d9ae0bdb..86c69b5cc156 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3213,7 +3213,7 @@ static const struct irq_domain_ops its_domain_ops = {
 /*
  * This is insane.
  *
- * If a GICv4 doesn't implement Direct LPIs (which is extremely
+ * If a GICv4.0 doesn't implement Direct LPIs (which is extremely
  * likely), the only way to perform an invalidate is to use a fake
  * device to issue an INV command, implying that the LPI has first
  * been mapped to some event on that device. Since this is not exactly
@@ -3221,9 +3221,20 @@ static const struct irq_domain_ops its_domain_ops = {
  * only issue an UNMAP if we're short on available slots.
  *
  * Broken by design(tm).
+ *
+ * GICv4.1, on the other hand, mandates that we're able to invalidate
+ * by writing to a MMIO register. It doesn't implement the whole of
+ * DirectLPI, but that's good enough. And most of the time, we don't
+ * even have to invalidate anything, as the redistributor can be told
+ * whether to generate a doorbell or not (we thus leave it enabled,
+ * always).
  */
 static void its_vpe_db_proxy_unmap_locked(struct its_vpe *vpe)
 {
+	/* GICv4.1 doesn't use a proxy, so nothing to do here */
+	if (gic_rdists->has_rvpeid)
+		return;
+
 	/* Already unmapped? */
 	if (vpe->vpe_proxy_event == -1)
 		return;
@@ -3246,6 +3257,10 @@ static void its_vpe_db_proxy_unmap_locked(struct its_vpe *vpe)
 
 static void its_vpe_db_proxy_unmap(struct its_vpe *vpe)
 {
+	/* GICv4.1 doesn't use a proxy, so nothing to do here */
+	if (gic_rdists->has_rvpeid)
+		return;
+
 	if (!gic_rdists->has_direct_lpi) {
 		unsigned long flags;
 
@@ -3257,6 +3272,10 @@ static void its_vpe_db_proxy_unmap(struct its_vpe *vpe)
 
 static void its_vpe_db_proxy_map_locked(struct its_vpe *vpe)
 {
+	/* GICv4.1 doesn't use a proxy, so nothing to do here */
+	if (gic_rdists->has_rvpeid)
+		return;
+
 	/* Already mapped? */
 	if (vpe->vpe_proxy_event != -1)
 		return;
@@ -3279,6 +3298,10 @@ static void its_vpe_db_proxy_move(struct its_vpe *vpe, int from, int to)
 	unsigned long flags;
 	struct its_collection *target_col;
 
+	/* GICv4.1 doesn't use a proxy, so nothing to do here */
+	if (gic_rdists->has_rvpeid)
+		return;
+
 	if (gic_rdists->has_direct_lpi) {
 		void __iomem *rdbase;
 
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
