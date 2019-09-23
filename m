Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id AA0A0BBB60
	for <lists+kvmarm@lfdr.de>; Mon, 23 Sep 2019 20:27:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 582B54A588;
	Mon, 23 Sep 2019 14:27:18 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wvwRt-Mit1TC; Mon, 23 Sep 2019 14:27:17 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4B4B84A685;
	Mon, 23 Sep 2019 14:27:17 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4962F4A650
 for <kvmarm@lists.cs.columbia.edu>; Mon, 23 Sep 2019 14:27:16 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AtvlqLr0SVUd for <kvmarm@lists.cs.columbia.edu>;
 Mon, 23 Sep 2019 14:27:15 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 552674A588
 for <kvmarm@lists.cs.columbia.edu>; Mon, 23 Sep 2019 14:27:15 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28BF619BF;
 Mon, 23 Sep 2019 11:27:15 -0700 (PDT)
Received: from big-swifty.lan (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7400A3F694;
 Mon, 23 Sep 2019 11:27:11 -0700 (PDT)
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.cs.columbia.edu,
	linux-kernel@vger.kernel.org
Subject: [PATCH 13/35] irqchip/gic-v4.1: Implement the v4.1 flavour of VMOVP
Date: Mon, 23 Sep 2019 19:25:44 +0100
Message-Id: <20190923182606.32100-14-maz@kernel.org>
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

With GICv4.1, VMOVP is extended to allow a default doorbell to be
specified, as well as a validity bit for this doorbell. As an added
bonus, VMOPVP isn't required anymore of moving a VPE between
redistributors that share the same affinity.

Let's add this support to the VMOVP builder, and make sure we don't
issuer the command if we don't really need to.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 40 ++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index a9976bc81d9a..c71aa0046bf0 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -443,6 +443,17 @@ static void its_encode_vmapp_default_db(struct its_cmd_block *cmd,
 	its_mask_encode(&cmd->raw_cmd[1], vpe_db_lpi, 31, 0);
 }
 
+static void its_encode_vmovp_default_db(struct its_cmd_block *cmd,
+					u32 vpe_db_lpi)
+{
+	its_mask_encode(&cmd->raw_cmd[3], vpe_db_lpi, 31, 0);
+}
+
+static void its_encode_db(struct its_cmd_block *cmd, bool db)
+{
+	its_mask_encode(&cmd->raw_cmd[2], db, 63, 63);
+}
+
 static inline void its_fixup_cmd(struct its_cmd_block *cmd)
 {
 	/* Let's fixup BE commands */
@@ -729,6 +740,11 @@ static struct its_vpe *its_build_vmovp_cmd(struct its_node *its,
 	its_encode_vpeid(cmd, desc->its_vmovp_cmd.vpe->vpe_id);
 	its_encode_target(cmd, target);
 
+	if (is_v4_1(its)) {
+		its_encode_db(cmd, true);
+		its_encode_vmovp_default_db(cmd, desc->its_vmovp_cmd.vpe->vpe_db_lpi);
+	}
+
 	its_fixup_cmd(cmd);
 
 	return valid_vpe(its, desc->its_vmovp_cmd.vpe);
@@ -3178,7 +3194,7 @@ static int its_vpe_set_affinity(struct irq_data *d,
 				bool force)
 {
 	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
-	int cpu = cpumask_first(mask_val);
+	int from, cpu = cpumask_first(mask_val);
 
 	/*
 	 * Changing affinity is mega expensive, so let's be as lazy as
@@ -3186,14 +3202,24 @@ static int its_vpe_set_affinity(struct irq_data *d,
 	 * into the proxy device, we need to move the doorbell
 	 * interrupt to its new location.
 	 */
-	if (vpe->col_idx != cpu) {
-		int from = vpe->col_idx;
+	if (vpe->col_idx == cpu)
+		goto out;
 
-		vpe->col_idx = cpu;
-		its_send_vmovp(vpe);
-		its_vpe_db_proxy_move(vpe, from, cpu);
-	}
+	from = vpe->col_idx;
+	vpe->col_idx = cpu;
+
+	/*
+	 * GICv4.1 allows us to skip VMOVP if moving to a cpu whose RD
+	 * is sharing its VPE table with the current one.
+	 */
+	if (gic_data_rdist_cpu(cpu)->vpe_table_mask &&
+	    cpumask_test_cpu(from, gic_data_rdist_cpu(cpu)->vpe_table_mask))
+		goto out;
 
+	its_send_vmovp(vpe);
+	its_vpe_db_proxy_move(vpe, from, cpu);
+
+out:
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
 
 	return IRQ_SET_MASK_OK_DONE;
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
