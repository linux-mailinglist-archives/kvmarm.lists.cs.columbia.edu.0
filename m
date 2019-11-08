Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0C704F4E87
	for <lists+kvmarm@lfdr.de>; Fri,  8 Nov 2019 15:43:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A43FE4AEF9;
	Fri,  8 Nov 2019 09:43:16 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WIHHulNSgaND; Fri,  8 Nov 2019 09:43:16 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4927B4AF13;
	Fri,  8 Nov 2019 09:43:15 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DB63E4AF17
 for <kvmarm@lists.cs.columbia.edu>; Fri,  8 Nov 2019 09:43:13 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sU96p1dATO8D for <kvmarm@lists.cs.columbia.edu>;
 Fri,  8 Nov 2019 09:43:13 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id F11344AEE3
 for <kvmarm@lists.cs.columbia.edu>; Fri,  8 Nov 2019 09:43:10 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B9147A7;
 Fri,  8 Nov 2019 06:43:10 -0800 (PST)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.197.44])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D3A13F719;
 Fri,  8 Nov 2019 06:43:09 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Andrew Jones <drjones@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [kvm-unit-tests PATCH 15/17] arm: gic: Provide FIQ handler
Date: Fri,  8 Nov 2019 14:42:38 +0000
Message-Id: <20191108144240.204202-16-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191108144240.204202-1-andre.przywara@arm.com>
References: <20191108144240.204202-1-andre.przywara@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

When configuring an interrupt as Group 0, we can ask the GIC to deliver
them as a FIQ. For this we need a separate exception handler.

Provide this to be used later.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arm/gic.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arm/gic.c b/arm/gic.c
index c68b5b5..6756850 100644
--- a/arm/gic.c
+++ b/arm/gic.c
@@ -178,6 +178,30 @@ static void irq_handler(struct pt_regs *regs __unused)
 	smp_wmb(); /* pairs with rmb in check_acked */
 }
 
+static inline void fiq_handler(struct pt_regs *regs __unused)
+{
+	u32 irqstat = gic_read_iar(0);
+	u32 irqnr = gic_iar_irqnr(irqstat);
+
+	if (irqnr == GICC_INT_SPURIOUS) {
+		++spurious[smp_processor_id()];
+		smp_wmb();
+		return;
+	}
+
+	gic_write_eoir(irqstat, 0);
+
+	smp_rmb(); /* pairs with wmb in stats_reset */
+	++acked[smp_processor_id()];
+	if (irqnr < GIC_NR_PRIVATE_IRQS) {
+		check_ipi_sender(irqstat);
+		check_irqnr(irqnr, IPI_IRQ);
+	} else {
+		check_irqnr(irqnr, SPI_IRQ);
+	}
+	smp_wmb(); /* pairs with rmb in check_acked */
+}
+
 static void gicv2_ipi_send_self(void)
 {
 	writel(2 << 24 | IPI_IRQ, gicv2_dist_base() + GICD_SGIR);
-- 
2.17.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
