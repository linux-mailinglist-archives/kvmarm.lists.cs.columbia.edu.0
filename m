Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id F247E308A5B
	for <lists+kvmarm@lfdr.de>; Fri, 29 Jan 2021 17:37:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9772A4B33D;
	Fri, 29 Jan 2021 11:37:19 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bpXnWOPniWlg; Fri, 29 Jan 2021 11:37:18 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D2A884B11E;
	Fri, 29 Jan 2021 11:37:16 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 358DA4B33C
 for <kvmarm@lists.cs.columbia.edu>; Fri, 29 Jan 2021 11:37:15 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rcVBtky2PofT for <kvmarm@lists.cs.columbia.edu>;
 Fri, 29 Jan 2021 11:37:13 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DBE434B2F4
 for <kvmarm@lists.cs.columbia.edu>; Fri, 29 Jan 2021 11:37:13 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFE12152B;
 Fri, 29 Jan 2021 08:37:13 -0800 (PST)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F07F03F71B;
 Fri, 29 Jan 2021 08:37:12 -0800 (PST)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: drjones@redhat.com,
	kvm@vger.kernel.org,
	kvmarm@lists.cs.columbia.edu
Subject: [kvm-unit-tests PATCH v3 04/11] arm/arm64: gic: Remove unnecessary
 synchronization with stats_reset()
Date: Fri, 29 Jan 2021 16:36:40 +0000
Message-Id: <20210129163647.91564-5-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210129163647.91564-1-alexandru.elisei@arm.com>
References: <20210129163647.91564-1-alexandru.elisei@arm.com>
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

The GICv3 driver executes a DSB barrier before sending an IPI, which
ensures that memory accesses have completed. This removes the need to
enforce ordering with respect to stats_reset() in the IPI handler.

For GICv2, the same barrier is executed by readl() after the MMIO read.
Together with the wmb() barrier from writel() when triggering the IPI,
this ensures that the expected memory ordering is respected.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arm/gic.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arm/gic.c b/arm/gic.c
index 8bb804abf34d..db1417ae1ca1 100644
--- a/arm/gic.c
+++ b/arm/gic.c
@@ -59,7 +59,6 @@ static void stats_reset(void)
 		bad_sender[i] = -1;
 		bad_irq[i] = -1;
 	}
-	smp_wmb();
 }
 
 static void check_acked(const char *testname, cpumask_t *mask)
@@ -149,7 +148,6 @@ static void ipi_handler(struct pt_regs *regs __unused)
 
 	if (irqnr != GICC_INT_SPURIOUS) {
 		gic_write_eoir(irqstat);
-		smp_rmb(); /* pairs with wmb in stats_reset */
 		++acked[smp_processor_id()];
 		check_ipi_sender(irqstat);
 		check_irqnr(irqnr);
-- 
2.30.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
