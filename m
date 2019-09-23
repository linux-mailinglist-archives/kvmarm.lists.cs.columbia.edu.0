Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C613BBBB5F
	for <lists+kvmarm@lfdr.de>; Mon, 23 Sep 2019 20:27:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 74AB04A687;
	Mon, 23 Sep 2019 14:27:15 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eBczYKk7ceW9; Mon, 23 Sep 2019 14:27:15 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 33A7C4A677;
	Mon, 23 Sep 2019 14:27:14 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 802564A51F
 for <kvmarm@lists.cs.columbia.edu>; Mon, 23 Sep 2019 14:27:12 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Qw4-DEgDmm8l for <kvmarm@lists.cs.columbia.edu>;
 Mon, 23 Sep 2019 14:27:11 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 504154A64E
 for <kvmarm@lists.cs.columbia.edu>; Mon, 23 Sep 2019 14:27:11 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11EAB1993;
 Mon, 23 Sep 2019 11:27:11 -0700 (PDT)
Received: from big-swifty.lan (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D992B3F694;
 Mon, 23 Sep 2019 11:27:07 -0700 (PDT)
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.cs.columbia.edu,
	linux-kernel@vger.kernel.org
Subject: [PATCH 12/35] irqchip/gic-v4.1: Don't use the VPE proxy if RVPEID is
 set
Date: Mon, 23 Sep 2019 19:25:43 +0100
Message-Id: <20190923182606.32100-13-maz@kernel.org>
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

The infamous VPE proxy device isn't used with GICv4.1 because:
- we can invalidate any LPI from the DirectLPI MMIO interface
- the ITS and redistributors understand the life cycle of
  the doorbell, so we don't need to enable/disable it all
  the time

So let's escape early from the proxy related functions.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 8d6deb75b973..a9976bc81d9a 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3065,7 +3065,7 @@ static const struct irq_domain_ops its_domain_ops = {
 /*
  * This is insane.
  *
- * If a GICv4 doesn't implement Direct LPIs (which is extremely
+ * If a GICv4.0 doesn't implement Direct LPIs (which is extremely
  * likely), the only way to perform an invalidate is to use a fake
  * device to issue an INV command, implying that the LPI has first
  * been mapped to some event on that device. Since this is not exactly
@@ -3073,9 +3073,18 @@ static const struct irq_domain_ops its_domain_ops = {
  * only issue an UNMAP if we're short on available slots.
  *
  * Broken by design(tm).
+ *
+ * GICv4.1 actually mandates that we're able to invalidate by writing to a
+ * MMIO register. It doesn't implement the whole of DirectLPI, but that's
+ * good enough. And most of the time, we don't even have to invalidate
+ * anything, so that's actually pretty good!
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
@@ -3098,6 +3107,10 @@ static void its_vpe_db_proxy_unmap_locked(struct its_vpe *vpe)
 
 static void its_vpe_db_proxy_unmap(struct its_vpe *vpe)
 {
+	/* GICv4.1 doesn't use a proxy, so nothing to do here */
+	if (gic_rdists->has_rvpeid)
+		return;
+
 	if (!gic_rdists->has_direct_lpi) {
 		unsigned long flags;
 
@@ -3109,6 +3122,10 @@ static void its_vpe_db_proxy_unmap(struct its_vpe *vpe)
 
 static void its_vpe_db_proxy_map_locked(struct its_vpe *vpe)
 {
+	/* GICv4.1 doesn't use a proxy, so nothing to do here */
+	if (gic_rdists->has_rvpeid)
+		return;
+
 	/* Already mapped? */
 	if (vpe->vpe_proxy_event != -1)
 		return;
@@ -3131,6 +3148,10 @@ static void its_vpe_db_proxy_move(struct its_vpe *vpe, int from, int to)
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
