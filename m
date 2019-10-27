Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2B54CE634C
	for <lists+kvmarm@lfdr.de>; Sun, 27 Oct 2019 15:44:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D349C4A4CD;
	Sun, 27 Oct 2019 10:44:52 -0400 (EDT)
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
	with ESMTP id MtVcXBYjtkMe; Sun, 27 Oct 2019 10:44:52 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AF10B4AC7F;
	Sun, 27 Oct 2019 10:44:51 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CCF094A50F
 for <kvmarm@lists.cs.columbia.edu>; Sun, 27 Oct 2019 10:44:50 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y5lbZra8sxXD for <kvmarm@lists.cs.columbia.edu>;
 Sun, 27 Oct 2019 10:44:49 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9977F4A4CD
 for <kvmarm@lists.cs.columbia.edu>; Sun, 27 Oct 2019 10:44:49 -0400 (EDT)
Received: from localhost.localdomain (82-132-239-15.dab.02.net [82.132.239.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3C97B21850;
 Sun, 27 Oct 2019 14:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1572187488;
 bh=OvqA2+Qm/Jp/XJTuxqpzYBqEAklKjunLQcAiKcV82iA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Iwe06Yy8h5nIeS0Kgy2BTdz2+WzuLmgDQnQq8rOE90H5Wif5tVwz3d1gzkneKOV4P
 jJl9K2ef1H+Z1Mjmzq1ZNlWaG4B5KXbQhUR8l8nplZ+7Mr/DIAGlqAULvyH1TuK/m3
 UtYtyCCSYb4ofxt5uXzdDCzNZfjhQMIOelbxVon4=
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.cs.columbia.edu,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 16/36] irqchip/gic-v4.1: Add mask/unmask doorbell callbacks
Date: Sun, 27 Oct 2019 14:42:14 +0000
Message-Id: <20191027144234.8395-17-maz@kernel.org>
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

masking/unmasking doorbells on GICv4.1 relies on a new INVDB command,
which broadcasts the invalidation to all RDs.

Implement the new command as well as the masking callbacks, and plug
the whole thing into the v4.1 VPE irqchip.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c   | 60 ++++++++++++++++++++++++++++++
 include/linux/irqchip/arm-gic-v3.h |  3 +-
 2 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index dcc7227af5f1..3c34bef70bdd 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -309,6 +309,10 @@ struct its_cmd_desc {
 			u16 seq_num;
 			u16 its_list;
 		} its_vmovp_cmd;
+
+		struct {
+			struct its_vpe *vpe;
+		} its_invdb_cmd;
 	};
 };
 
@@ -750,6 +754,21 @@ static struct its_vpe *its_build_vmovp_cmd(struct its_node *its,
 	return valid_vpe(its, desc->its_vmovp_cmd.vpe);
 }
 
+static struct its_vpe *its_build_invdb_cmd(struct its_node *its,
+					   struct its_cmd_block *cmd,
+					   struct its_cmd_desc *desc)
+{
+	if (WARN_ON(!is_v4_1(its)))
+		return NULL;
+
+	its_encode_cmd(cmd, GITS_CMD_INVDB);
+	its_encode_vpeid(cmd, desc->its_invdb_cmd.vpe->vpe_id);
+
+	its_fixup_cmd(cmd);
+
+	return valid_vpe(its, desc->its_invdb_cmd.vpe);
+}
+
 static u64 its_cmd_ptr_to_offset(struct its_node *its,
 				 struct its_cmd_block *ptr)
 {
@@ -1117,6 +1136,14 @@ static void its_send_vinvall(struct its_node *its, struct its_vpe *vpe)
 	its_send_single_vcommand(its, its_build_vinvall_cmd, &desc);
 }
 
+static void its_send_invdb(struct its_node *its, struct its_vpe *vpe)
+{
+	struct its_cmd_desc desc;
+
+	desc.its_invdb_cmd.vpe = vpe;
+	its_send_single_vcommand(its, its_build_invdb_cmd, &desc);
+}
+
 /*
  * irqchip functions - assumes MSI, mostly.
  */
@@ -3408,6 +3435,37 @@ static struct irq_chip its_vpe_irq_chip = {
 	.irq_set_vcpu_affinity	= its_vpe_set_vcpu_affinity,
 };
 
+static void its_vpe_4_1_send_inv(struct irq_data *d)
+{
+	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
+	struct its_node *its;
+
+	/*
+	 * GICv4.1 wants doorbells to be invalidated using the
+	 * INVDB command in order to be broadcast to all RDs. Send
+	 * it to the first valid ITS, and let the HW do its magic.
+	 */
+	list_for_each_entry(its, &its_nodes, entry) {
+		if (!is_v4_1(its))
+			continue;
+
+		its_send_invdb(its, vpe);
+		break;
+	}
+}
+
+static void its_vpe_4_1_mask_irq(struct irq_data *d)
+{
+	lpi_write_config(d->parent_data, LPI_PROP_ENABLED, 0);
+	its_vpe_4_1_send_inv(d);
+}
+
+static void its_vpe_4_1_unmask_irq(struct irq_data *d)
+{
+	lpi_write_config(d->parent_data, 0, LPI_PROP_ENABLED);
+	its_vpe_4_1_send_inv(d);
+}
+
 static int its_vpe_4_1_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
 {
 	struct its_cmd_info *info = vcpu_info;
@@ -3429,6 +3487,8 @@ static int its_vpe_4_1_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
 
 static struct irq_chip its_vpe_4_1_irq_chip = {
 	.name			= "GICv4.1-vpe",
+	.irq_mask		= its_vpe_4_1_mask_irq,
+	.irq_unmask		= its_vpe_4_1_unmask_irq,
 	.irq_eoi		= irq_chip_eoi_parent,
 	.irq_set_affinity	= its_vpe_set_affinity,
 	.irq_set_vcpu_affinity	= its_vpe_4_1_set_vcpu_affinity,
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index f1d6de53e09b..8157737053e4 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -484,8 +484,9 @@
 #define GITS_CMD_VMAPTI			GITS_CMD_GICv4(GITS_CMD_MAPTI)
 #define GITS_CMD_VMOVI			GITS_CMD_GICv4(GITS_CMD_MOVI)
 #define GITS_CMD_VSYNC			GITS_CMD_GICv4(GITS_CMD_SYNC)
-/* VMOVP is the odd one, as it doesn't have a physical counterpart */
+/* VMOVP and INVDB are the odd ones, as they dont have a physical counterpart */
 #define GITS_CMD_VMOVP			GITS_CMD_GICv4(2)
+#define GITS_CMD_INVDB			GITS_CMD_GICv4(0xe)
 
 /*
  * ITS error numbers
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
