Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC423533C6
	for <lists+kvmarm@lfdr.de>; Sat,  3 Apr 2021 13:30:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DF9A44B594;
	Sat,  3 Apr 2021 07:30:07 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wJp9lWFACmNW; Sat,  3 Apr 2021 07:30:06 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5E7524B5A6;
	Sat,  3 Apr 2021 07:30:03 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A36EE4B57B
 for <kvmarm@lists.cs.columbia.edu>; Sat,  3 Apr 2021 07:30:01 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AX12snnWiJkk for <kvmarm@lists.cs.columbia.edu>;
 Sat,  3 Apr 2021 07:30:00 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id DBD864B571
 for <kvmarm@lists.cs.columbia.edu>; Sat,  3 Apr 2021 07:29:56 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2532461246;
 Sat,  3 Apr 2021 11:29:56 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1lSeTS-005R95-Go; Sat, 03 Apr 2021 12:29:54 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu
Subject: [PATCH v2 9/9] irqchip/apple-aic: Advertise some level of vGICv3
 compatibility
Date: Sat,  3 Apr 2021 12:29:31 +0100
Message-Id: <20210403112931.1043452-10-maz@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210403112931.1043452-1-maz@kernel.org>
References: <20210403112931.1043452-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, james.morse@arm.com, suzuki.poulose@arm.com,
 alexandru.elisei@arm.com, eric.auger@redhat.com, marcan@marcan.st,
 mark.rutland@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, Hector Martin <marcan@marcan.st>
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

The CPUs in the Apple M1 SoC partially implement a virtual GICv3
CPU interface, although one that is incapable of HW deactivation
of interrupts.

Advertise the support to KVM.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-apple-aic.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index ed16b6cc00d7..65067b2c746b 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -50,6 +50,7 @@
 #include <linux/cpuhotplug.h>
 #include <linux/io.h>
 #include <linux/irqchip.h>
+#include <linux/irqchip/arm-vgic-info.h>
 #include <linux/irqdomain.h>
 #include <linux/limits.h>
 #include <linux/of_address.h>
@@ -772,6 +773,11 @@ static int aic_init_cpu(unsigned int cpu)
 	return 0;
 }
 
+static struct gic_kvm_info vgic_info __initdata = {
+	.type			= GIC_V3,
+	.no_hw_deactivation	= true,
+};
+
 static int __init aic_of_ic_init(struct device_node *node, struct device_node *parent)
 {
 	int i;
@@ -828,6 +834,8 @@ static int __init aic_of_ic_init(struct device_node *node, struct device_node *p
 			  "irqchip/apple-aic/ipi:starting",
 			  aic_init_cpu, NULL);
 
+	vgic_set_kvm_info(&vgic_info);
+
 	pr_info("Initialized with %d IRQs, %d FIQs, %d vIPIs\n",
 		irqc->nr_hw, AIC_NR_FIQ, AIC_NR_SWIPI);
 
-- 
2.29.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
