Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BE06D2DD2A9
	for <lists+kvmarm@lfdr.de>; Thu, 17 Dec 2020 15:14:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 586B54B21A;
	Thu, 17 Dec 2020 09:14:17 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id myD7DcM76LRo; Thu, 17 Dec 2020 09:14:17 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0BE1B4B22E;
	Thu, 17 Dec 2020 09:14:16 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0CC6E4B1D2
 for <kvmarm@lists.cs.columbia.edu>; Thu, 17 Dec 2020 09:14:15 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 311g7gSwRmKU for <kvmarm@lists.cs.columbia.edu>;
 Thu, 17 Dec 2020 09:14:14 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0A5FC4B204
 for <kvmarm@lists.cs.columbia.edu>; Thu, 17 Dec 2020 09:14:13 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B42E9106F;
 Thu, 17 Dec 2020 06:14:12 -0800 (PST)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C601F3F66B;
 Thu, 17 Dec 2020 06:14:11 -0800 (PST)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: drjones@redhat.com,
	kvm@vger.kernel.org,
	kvmarm@lists.cs.columbia.edu
Subject: [kvm-unit-tests PATCH v2 03/12] arm/arm64: gic: Remove SMP
 synchronization from ipi_clear_active_handler()
Date: Thu, 17 Dec 2020 14:13:51 +0000
Message-Id: <20201217141400.106137-4-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201217141400.106137-1-alexandru.elisei@arm.com>
References: <20201217141400.106137-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
Cc: andre.przywara@arm.com
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

The gicv{2,3}-active test sends an IPI from the boot CPU to itself, then
checks that the interrupt has been received as expected. There is no need
to use inter-processor memory synchronization primitives on code that runs
on the same CPU, so remove the unneeded memory barriers.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arm/gic.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arm/gic.c b/arm/gic.c
index ca61dba2986c..1c9f4a01b6e4 100644
--- a/arm/gic.c
+++ b/arm/gic.c
@@ -364,6 +364,7 @@ static struct gic gicv3 = {
 	},
 };
 
+/* Runs on the same CPU as the sender, no need for memory synchronization */
 static void ipi_clear_active_handler(struct pt_regs *regs __unused)
 {
 	u32 irqstat = gic_read_iar();
@@ -380,13 +381,10 @@ static void ipi_clear_active_handler(struct pt_regs *regs __unused)
 
 		writel(val, base + GICD_ICACTIVER);
 
-		smp_rmb(); /* pairs with wmb in stats_reset */
 		++acked[smp_processor_id()];
 		check_irqnr(irqnr);
-		smp_wmb(); /* pairs with rmb in check_acked */
 	} else {
 		++spurious[smp_processor_id()];
-		smp_wmb();
 	}
 }
 
-- 
2.29.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
