Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAA1E635F
	for <lists+kvmarm@lfdr.de>; Sun, 27 Oct 2019 15:45:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3B6004A588;
	Sun, 27 Oct 2019 10:45:54 -0400 (EDT)
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
	with ESMTP id XVWJtpFMP07m; Sun, 27 Oct 2019 10:45:54 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 207434AC9D;
	Sun, 27 Oct 2019 10:45:53 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 96DC14A51D
 for <kvmarm@lists.cs.columbia.edu>; Sun, 27 Oct 2019 10:45:51 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YroAKRuSHH35 for <kvmarm@lists.cs.columbia.edu>;
 Sun, 27 Oct 2019 10:45:50 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id AD43E4A4DF
 for <kvmarm@lists.cs.columbia.edu>; Sun, 27 Oct 2019 10:45:50 -0400 (EDT)
Received: from localhost.localdomain (82-132-239-15.dab.02.net [82.132.239.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C034621E6F;
 Sun, 27 Oct 2019 14:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1572187549;
 bh=+d7xftlu27DKC9efu3TAF3L70PpcGl2ppDdh987PmKY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XPxhgaada0GtxwxmuB4K16VMgxJm9poJTw5UygAeRcwy1uAFne6Yut2TC1nBggXk2
 v1NGrHB6DPvQZS1n5kvuducEJwyXhr7geC2SbNJ5QU9LAeJV5J29XPpWhEDyqeMDWZ
 Zxi2kVmpn7VFujoGB0sdrmV2voSFbn4JLm2NBDl8=
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.cs.columbia.edu,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 26/36] irqchip/gic-v4.1: Plumb mask/unmask SGI callbacks
Date: Sun, 27 Oct 2019 14:42:24 +0000
Message-Id: <20191027144234.8395-27-maz@kernel.org>
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

Implement mask/unmask for virtual SGIs by calling into the
configuration helper.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index ef5988724aa3..b9cef419f006 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3667,6 +3667,22 @@ static void its_configure_sgi(struct irq_data *d, bool clear)
 	its_send_single_vcommand(find_4_1_its(), its_build_vsgi_cmd, &desc);
 }
 
+static void its_sgi_mask_irq(struct irq_data *d)
+{
+	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
+
+	vpe->sgi_config[d->hwirq].enabled = false;
+	its_configure_sgi(d, false);
+}
+
+static void its_sgi_unmask_irq(struct irq_data *d)
+{
+	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
+
+	vpe->sgi_config[d->hwirq].enabled = true;
+	its_configure_sgi(d, false);
+}
+
 static int its_sgi_set_affinity(struct irq_data *d,
 				const struct cpumask *mask_val,
 				bool force)
@@ -3676,6 +3692,8 @@ static int its_sgi_set_affinity(struct irq_data *d,
 
 static struct irq_chip its_sgi_irq_chip = {
 	.name			= "GICv4.1-sgi",
+	.irq_mask		= its_sgi_mask_irq,
+	.irq_unmask		= its_sgi_unmask_irq,
 	.irq_set_affinity	= its_sgi_set_affinity,
 };
 
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
