Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 384D412A0C6
	for <lists+kvmarm@lfdr.de>; Tue, 24 Dec 2019 12:43:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D9E0D4AF3B;
	Tue, 24 Dec 2019 06:43:02 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4I9vWTzdpSwf; Tue, 24 Dec 2019 06:43:02 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C70394AF61;
	Tue, 24 Dec 2019 06:43:01 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D82F24AF1F
 for <kvmarm@lists.cs.columbia.edu>; Tue, 24 Dec 2019 06:43:00 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2703462YKcFc for <kvmarm@lists.cs.columbia.edu>;
 Tue, 24 Dec 2019 06:43:00 -0500 (EST)
Received: from inca-roads.misterjones.org (inca-roads.misterjones.org
 [213.251.177.50])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 01E2D4AF28
 for <kvmarm@lists.cs.columbia.edu>; Tue, 24 Dec 2019 06:43:00 -0500 (EST)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by cheepnis.misterjones.org with esmtpsa
 (TLSv1.2:DHE-RSA-AES128-GCM-SHA256:128) (Exim 4.80)
 (envelope-from <maz@kernel.org>)
 id 1iji5y-000169-H6; Tue, 24 Dec 2019 12:11:22 +0100
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.cs.columbia.edu,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 14/32] irqchip/gic-v4.1: Suppress per-VLPI doorbell
Date: Tue, 24 Dec 2019 11:10:37 +0000
Message-Id: <20191224111055.11836-15-maz@kernel.org>
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

Since GICv4.1 gives us a per-VPE doorbell, avoid programming anything
else on VMOVI/VMAPI/VMAPTI and on any other action that would have
otherwise resulted in a per-VLPI doorbell to be programmed.

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 403f5753e1ed..f00c8ddd3798 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -719,7 +719,7 @@ static struct its_vpe *its_build_vmapti_cmd(struct its_node *its,
 {
 	u32 db;
 
-	if (desc->its_vmapti_cmd.db_enabled)
+	if (!is_v4_1(its) && desc->its_vmapti_cmd.db_enabled)
 		db = desc->its_vmapti_cmd.vpe->vpe_db_lpi;
 	else
 		db = 1023;
@@ -742,7 +742,7 @@ static struct its_vpe *its_build_vmovi_cmd(struct its_node *its,
 {
 	u32 db;
 
-	if (desc->its_vmovi_cmd.db_enabled)
+	if (!is_v4_1(its) && desc->its_vmovi_cmd.db_enabled)
 		db = desc->its_vmovi_cmd.vpe->vpe_db_lpi;
 	else
 		db = 1023;
@@ -1353,6 +1353,13 @@ static void its_vlpi_set_doorbell(struct irq_data *d, bool enable)
 	u32 event = its_get_event_id(d);
 	struct its_vlpi_map *map;
 
+	/*
+	 * GICv4.1 does away with the per-LPI nonsense, nothing to do
+	 * here.
+	 */
+	if (is_v4_1(its_dev->its))
+		return;
+
 	map = dev_event_to_vlpi_map(its_dev, event);
 
 	if (map->db_enabled == enable)
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
