Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 138DB18D6D5
	for <lists+kvmarm@lfdr.de>; Fri, 20 Mar 2020 19:24:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A2B254B0B6;
	Fri, 20 Mar 2020 14:24:51 -0400 (EDT)
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
	with ESMTP id Np0EqDYCcSP7; Fri, 20 Mar 2020 14:24:50 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B654D4B0D9;
	Fri, 20 Mar 2020 14:24:46 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EF03D4A5A0
 for <kvmarm@lists.cs.columbia.edu>; Fri, 20 Mar 2020 14:24:45 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Iltl1mKzkO4F for <kvmarm@lists.cs.columbia.edu>;
 Fri, 20 Mar 2020 14:24:44 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9047F4B0AD
 for <kvmarm@lists.cs.columbia.edu>; Fri, 20 Mar 2020 14:24:42 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BE82920767;
 Fri, 20 Mar 2020 18:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1584728681;
 bh=bOuSKY/Un87L7jbBl7lG3oC9zrsTgMCbj+0ahyzrJ2Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oYAGqhtOvNct9jIqYqPf742Ps2bsNdnzZvdn42W6goRMQ4AvqTBeaA2sZAE3nm8t/
 atrw/DN49h6ozWryI1dDvaXcJ84Fyszp/GFeDT297LWl3HSjqdVrWQ7H7A94UJ7Nd4
 TKhGlYWveadZ3UIcB8wywqxblikj0W7q46+JAg3Q=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jFMK0-00EKAx-1r; Fri, 20 Mar 2020 18:24:40 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 09/23] irqchip/gic-v4.1: Add initial SGI configuration
Date: Fri, 20 Mar 2020 18:23:52 +0000
Message-Id: <20200320182406.23465-10-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200320182406.23465-1-maz@kernel.org>
References: <20200320182406.23465-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com, jason@lakedaemon.net,
 tglx@linutronix.de, yuzenghui@huawei.com, eric.auger@redhat.com,
 james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
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

The GICv4.1 ITS has yet another new command (VSGI) which allows
a VPE-targeted SGI to be configured (or have its pending state
cleared). Add support for this command and plumb it into the
activate irqdomain callback so that it is ready to be used.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Link: https://lore.kernel.org/r/20200304203330.4967-10-maz@kernel.org
---
 drivers/irqchip/irq-gic-v3-its.c   | 92 +++++++++++++++++++++++++++++-
 include/linux/irqchip/arm-gic-v3.h |  3 +-
 2 files changed, 93 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 8313c3a871a9..c6aa4b4147ac 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -380,6 +380,15 @@ struct its_cmd_desc {
 		struct {
 			struct its_vpe *vpe;
 		} its_invdb_cmd;
+
+		struct {
+			struct its_vpe *vpe;
+			u8 sgi;
+			u8 priority;
+			bool enable;
+			bool group;
+			bool clear;
+		} its_vsgi_cmd;
 	};
 };
 
@@ -528,6 +537,31 @@ static void its_encode_db(struct its_cmd_block *cmd, bool db)
 	its_mask_encode(&cmd->raw_cmd[2], db, 63, 63);
 }
 
+static void its_encode_sgi_intid(struct its_cmd_block *cmd, u8 sgi)
+{
+	its_mask_encode(&cmd->raw_cmd[0], sgi, 35, 32);
+}
+
+static void its_encode_sgi_priority(struct its_cmd_block *cmd, u8 prio)
+{
+	its_mask_encode(&cmd->raw_cmd[0], prio >> 4, 23, 20);
+}
+
+static void its_encode_sgi_group(struct its_cmd_block *cmd, bool grp)
+{
+	its_mask_encode(&cmd->raw_cmd[0], grp, 10, 10);
+}
+
+static void its_encode_sgi_clear(struct its_cmd_block *cmd, bool clr)
+{
+	its_mask_encode(&cmd->raw_cmd[0], clr, 9, 9);
+}
+
+static void its_encode_sgi_enable(struct its_cmd_block *cmd, bool en)
+{
+	its_mask_encode(&cmd->raw_cmd[0], en, 8, 8);
+}
+
 static inline void its_fixup_cmd(struct its_cmd_block *cmd)
 {
 	/* Let's fixup BE commands */
@@ -893,6 +927,26 @@ static struct its_vpe *its_build_invdb_cmd(struct its_node *its,
 	return valid_vpe(its, desc->its_invdb_cmd.vpe);
 }
 
+static struct its_vpe *its_build_vsgi_cmd(struct its_node *its,
+					  struct its_cmd_block *cmd,
+					  struct its_cmd_desc *desc)
+{
+	if (WARN_ON(!is_v4_1(its)))
+		return NULL;
+
+	its_encode_cmd(cmd, GITS_CMD_VSGI);
+	its_encode_vpeid(cmd, desc->its_vsgi_cmd.vpe->vpe_id);
+	its_encode_sgi_intid(cmd, desc->its_vsgi_cmd.sgi);
+	its_encode_sgi_priority(cmd, desc->its_vsgi_cmd.priority);
+	its_encode_sgi_group(cmd, desc->its_vsgi_cmd.group);
+	its_encode_sgi_clear(cmd, desc->its_vsgi_cmd.clear);
+	its_encode_sgi_enable(cmd, desc->its_vsgi_cmd.enable);
+
+	its_fixup_cmd(cmd);
+
+	return valid_vpe(its, desc->its_vsgi_cmd.vpe);
+}
+
 static u64 its_cmd_ptr_to_offset(struct its_node *its,
 				 struct its_cmd_block *ptr)
 {
@@ -3870,6 +3924,26 @@ static struct irq_chip its_vpe_4_1_irq_chip = {
 	.irq_set_vcpu_affinity	= its_vpe_4_1_set_vcpu_affinity,
 };
 
+static void its_configure_sgi(struct irq_data *d, bool clear)
+{
+	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
+	struct its_cmd_desc desc;
+
+	desc.its_vsgi_cmd.vpe = vpe;
+	desc.its_vsgi_cmd.sgi = d->hwirq;
+	desc.its_vsgi_cmd.priority = vpe->sgi_config[d->hwirq].priority;
+	desc.its_vsgi_cmd.enable = vpe->sgi_config[d->hwirq].enabled;
+	desc.its_vsgi_cmd.group = vpe->sgi_config[d->hwirq].group;
+	desc.its_vsgi_cmd.clear = clear;
+
+	/*
+	 * GICv4.1 allows us to send VSGI commands to any ITS as long as the
+	 * destination VPE is mapped there. Since we map them eagerly at
+	 * activation time, we're pretty sure the first GICv4.1 ITS will do.
+	 */
+	its_send_single_vcommand(find_4_1_its(), its_build_vsgi_cmd, &desc);
+}
+
 static int its_sgi_set_affinity(struct irq_data *d,
 				const struct cpumask *mask_val,
 				bool force)
@@ -3920,13 +3994,29 @@ static void its_sgi_irq_domain_free(struct irq_domain *domain,
 static int its_sgi_irq_domain_activate(struct irq_domain *domain,
 				       struct irq_data *d, bool reserve)
 {
+	/* Write out the initial SGI configuration */
+	its_configure_sgi(d, false);
 	return 0;
 }
 
 static void its_sgi_irq_domain_deactivate(struct irq_domain *domain,
 					  struct irq_data *d)
 {
-	/* Nothing to do */
+	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
+
+	/*
+	 * The VSGI command is awkward:
+	 *
+	 * - To change the configuration, CLEAR must be set to false,
+	 *   leaving the pending bit unchanged.
+	 * - To clear the pending bit, CLEAR must be set to true, leaving
+	 *   the configuration unchanged.
+	 *
+	 * You just can't do both at once, hence the two commands below.
+	 */
+	vpe->sgi_config[d->hwirq].enabled = false;
+	its_configure_sgi(d, false);
+	its_configure_sgi(d, true);
 }
 
 static const struct irq_domain_ops its_sgi_domain_ops = {
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index b28acfa71f82..fd3be49ac9a5 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -502,8 +502,9 @@
 #define GITS_CMD_VMAPTI			GITS_CMD_GICv4(GITS_CMD_MAPTI)
 #define GITS_CMD_VMOVI			GITS_CMD_GICv4(GITS_CMD_MOVI)
 #define GITS_CMD_VSYNC			GITS_CMD_GICv4(GITS_CMD_SYNC)
-/* VMOVP and INVDB are the odd ones, as they dont have a physical counterpart */
+/* VMOVP, VSGI and INVDB are the odd ones, as they dont have a physical counterpart */
 #define GITS_CMD_VMOVP			GITS_CMD_GICv4(2)
+#define GITS_CMD_VSGI			GITS_CMD_GICv4(3)
 #define GITS_CMD_INVDB			GITS_CMD_GICv4(0xe)
 
 /*
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
