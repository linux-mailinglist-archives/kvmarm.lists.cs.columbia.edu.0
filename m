Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3045C267B3F
	for <lists+kvmarm@lfdr.de>; Sat, 12 Sep 2020 17:36:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D86634B601;
	Sat, 12 Sep 2020 11:36:14 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id psqT8XKJ7Ebr; Sat, 12 Sep 2020 11:36:14 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E05154B68A;
	Sat, 12 Sep 2020 11:36:12 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 54FA74B3B4
 for <kvmarm@lists.cs.columbia.edu>; Sat, 12 Sep 2020 11:36:12 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UgRtfocBZe6U for <kvmarm@lists.cs.columbia.edu>;
 Sat, 12 Sep 2020 11:36:11 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4B8D14B36E
 for <kvmarm@lists.cs.columbia.edu>; Sat, 12 Sep 2020 11:36:11 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D52A511B3;
 Sat, 12 Sep 2020 08:36:10 -0700 (PDT)
Received: from monolith.localdoman (unknown [10.37.8.20])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 758F03F68F;
 Sat, 12 Sep 2020 08:36:09 -0700 (PDT)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu
Subject: [PATCH v3 1/2] irqchip/gicv3: Spell out when pseudo-NMIs are enabled
Date: Sat, 12 Sep 2020 16:37:06 +0100
Message-Id: <20200912153707.667731-2-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200912153707.667731-1-alexandru.elisei@arm.com>
References: <20200912153707.667731-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
Cc: maz@kernel.org, tglx@linutronix.de, will@kernel.org, jason@lakedaemon.net,
 catalin.marinas@arm.com
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

When NMIs cannot be enabled, the driver prints a message stating that
unambiguously. When they are enabled, the only feedback we get is a message
regarding the use of synchronization for ICC_PMR_EL1 writes, which is not
as useful for a user who is not intimately familiar with how NMIs are
implemented.

Let's make it obvious that pseudo-NMIs are enabled. Keep the message about
using a barrier for ICC_PMR_EL1 writes, because it has a non-negligible
impact on performance.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 drivers/irqchip/irq-gic-v3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 850842f27bee..aa9b43d412b2 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1564,8 +1564,8 @@ static void gic_enable_nmi_support(void)
 	if (gic_read_ctlr() & ICC_CTLR_EL1_PMHE_MASK)
 		static_branch_enable(&gic_pmr_sync);
 
-	pr_info("%s ICC_PMR_EL1 synchronisation\n",
-		static_branch_unlikely(&gic_pmr_sync) ? "Forcing" : "Relaxing");
+	pr_info("Pseudo-NMIs enabled using %s ICC_PMR_EL1 synchronisation\n",
+		static_branch_unlikely(&gic_pmr_sync) ? "forced" : "relaxed");
 
 	static_branch_enable(&supports_pseudo_nmis);
 
-- 
2.28.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
