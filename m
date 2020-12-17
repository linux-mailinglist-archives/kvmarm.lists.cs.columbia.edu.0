Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D92CA2DD2AB
	for <lists+kvmarm@lfdr.de>; Thu, 17 Dec 2020 15:14:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8BE0D4B225;
	Thu, 17 Dec 2020 09:14:20 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RpOSmFM7bxe8; Thu, 17 Dec 2020 09:14:20 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 51E004B232;
	Thu, 17 Dec 2020 09:14:19 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 38D5D4B200
 for <kvmarm@lists.cs.columbia.edu>; Thu, 17 Dec 2020 09:14:18 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RTls5JLUpMr2 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 17 Dec 2020 09:14:17 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 748314B1D2
 for <kvmarm@lists.cs.columbia.edu>; Thu, 17 Dec 2020 09:14:16 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A17312FC;
 Thu, 17 Dec 2020 06:14:16 -0800 (PST)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B5E93F66B;
 Thu, 17 Dec 2020 06:14:15 -0800 (PST)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: drjones@redhat.com,
	kvm@vger.kernel.org,
	kvmarm@lists.cs.columbia.edu
Subject: [kvm-unit-tests PATCH v2 06/12] arm/arm64: gic: Check spurious and
 bad_sender in the active test
Date: Thu, 17 Dec 2020 14:13:54 +0000
Message-Id: <20201217141400.106137-7-alexandru.elisei@arm.com>
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
checks that the interrupt has been received as expected. The
ipi_clear_active_handler() clears the active state of the interrupt with a
write to the GICD_ICACTIVER register instead of writing the to EOI
register.

When acknowledging the interrupt it is possible to get back an spurious
interrupt ID (ID 1023), and the interrupt handler increments the number of
spurious interrupts received on the current processor. However, this is not
checked at the end of the test. Let's also check for spurious interrupts,
like the IPI test does.

For IPIs on GICv2, the value returned by a read of the GICC_IAR register
performed when acknowledging the interrupt also contains the sender CPU
ID. Add a check for that too.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arm/gic.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arm/gic.c b/arm/gic.c
index 34643a73bd04..a42b5afdba65 100644
--- a/arm/gic.c
+++ b/arm/gic.c
@@ -126,12 +126,12 @@ static void check_spurious(void)
 	}
 }
 
-static void check_ipi_sender(u32 irqstat)
+static void check_ipi_sender(u32 irqstat, int sender)
 {
 	if (gic_version() == 2) {
 		int src = (irqstat >> 10) & 7;
 
-		if (src != IPI_SENDER)
+		if (src != sender)
 			bad_sender[smp_processor_id()] = src;
 	}
 }
@@ -156,7 +156,7 @@ static void ipi_handler(struct pt_regs *regs __unused)
 		 */
 		if (gic_version() == 2)
 			smp_rmb();
-		check_ipi_sender(irqstat);
+		check_ipi_sender(irqstat, IPI_SENDER);
 		check_irqnr(irqnr);
 		smp_wmb(); /* pairs with smp_rmb in check_acked */
 		++acked[smp_processor_id()];
@@ -386,6 +386,7 @@ static void ipi_clear_active_handler(struct pt_regs *regs __unused)
 
 		writel(val, base + GICD_ICACTIVER);
 
+		check_ipi_sender(irqstat, smp_processor_id());
 		check_irqnr(irqnr);
 		++acked[smp_processor_id()];
 	} else {
@@ -398,6 +399,7 @@ static void run_active_clear_test(void)
 	report_prefix_push("active");
 	setup_irq(ipi_clear_active_handler);
 	ipi_test_self();
+	check_spurious();
 	report_prefix_pop();
 }
 
-- 
2.29.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
