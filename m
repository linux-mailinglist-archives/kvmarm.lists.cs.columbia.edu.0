Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7885A2C4460
	for <lists+kvmarm@lfdr.de>; Wed, 25 Nov 2020 16:50:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 280C34B9DB;
	Wed, 25 Nov 2020 10:50:12 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0wexu72EDo9z; Wed, 25 Nov 2020 10:50:11 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B239F4B9F7;
	Wed, 25 Nov 2020 10:50:09 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4FC7F4B9C4
 for <kvmarm@lists.cs.columbia.edu>; Wed, 25 Nov 2020 10:50:07 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5a0KIV0EsEKQ for <kvmarm@lists.cs.columbia.edu>;
 Wed, 25 Nov 2020 10:50:06 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3ACED4B9C5
 for <kvmarm@lists.cs.columbia.edu>; Wed, 25 Nov 2020 10:50:06 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E482A11D4;
 Wed, 25 Nov 2020 07:50:05 -0800 (PST)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F7E63F7BB;
 Wed, 25 Nov 2020 07:50:05 -0800 (PST)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: kvm@vger.kernel.org,
	kvmarm@lists.cs.columbia.edu,
	drjones@redhat.com
Subject: [kvm-unit-tests PATCH 03/10] arm/arm64: gic: Remove memory
 synchronization from ipi_clear_active_handler()
Date: Wed, 25 Nov 2020 15:51:06 +0000
Message-Id: <20201125155113.192079-4-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201125155113.192079-1-alexandru.elisei@arm.com>
References: <20201125155113.192079-1-alexandru.elisei@arm.com>
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

The arrays are modified asynchronously (in the interrupt handler) and it is
possible for the compiler to infer that they won't be changed during normal
program flow and try to perform harmful optimizations (like stashing a
previous read in a register and reusing it). To prevent this, for GICv2,
the smp_wmb() in gicv2_ipi_send_self() is replaced with a compiler barrier.
For GICv3, the wmb() barrier in gic_ipi_send_single() already implies a
compiler barrier.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arm/gic.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arm/gic.c b/arm/gic.c
index 401ffafe4299..4e947e8516a2 100644
--- a/arm/gic.c
+++ b/arm/gic.c
@@ -12,6 +12,7 @@
  * This work is licensed under the terms of the GNU LGPL, version 2.
  */
 #include <libcflat.h>
+#include <linux/compiler.h>
 #include <errata.h>
 #include <asm/setup.h>
 #include <asm/processor.h>
@@ -260,7 +261,8 @@ static void check_lpi_hits(int *expected, const char *msg)
 
 static void gicv2_ipi_send_self(void)
 {
-	smp_wmb();
+	/* Prevent the compiler from optimizing memory accesses */
+	barrier();
 	writel(2 << 24 | IPI_IRQ, gicv2_dist_base() + GICD_SGIR);
 }
 
@@ -359,6 +361,7 @@ static struct gic gicv3 = {
 	},
 };
 
+/* Runs on the same CPU as the sender, no need for memory synchronization */
 static void ipi_clear_active_handler(struct pt_regs *regs __unused)
 {
 	u32 irqstat = gic_read_iar();
@@ -375,13 +378,10 @@ static void ipi_clear_active_handler(struct pt_regs *regs __unused)
 
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
