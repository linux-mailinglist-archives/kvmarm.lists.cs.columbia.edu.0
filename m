Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 106AB2C445F
	for <lists+kvmarm@lfdr.de>; Wed, 25 Nov 2020 16:50:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BA4C14B9C1;
	Wed, 25 Nov 2020 10:50:10 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RSsSezFC+LjW; Wed, 25 Nov 2020 10:50:09 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 945A04B9C6;
	Wed, 25 Nov 2020 10:50:09 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 993014B9C4
 for <kvmarm@lists.cs.columbia.edu>; Wed, 25 Nov 2020 10:50:06 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bYAQonVbBJQF for <kvmarm@lists.cs.columbia.edu>;
 Wed, 25 Nov 2020 10:50:05 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 83C6F4B9C1
 for <kvmarm@lists.cs.columbia.edu>; Wed, 25 Nov 2020 10:50:05 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF3B9106F;
 Wed, 25 Nov 2020 07:50:04 -0800 (PST)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1ABE13F7BB;
 Wed, 25 Nov 2020 07:50:03 -0800 (PST)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: kvm@vger.kernel.org,
	kvmarm@lists.cs.columbia.edu,
	drjones@redhat.com
Subject: [kvm-unit-tests PATCH 02/10] lib: arm/arm64: gicv2: Add missing
 barrier when sending IPIs
Date: Wed, 25 Nov 2020 15:51:05 +0000
Message-Id: <20201125155113.192079-3-alexandru.elisei@arm.com>
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

GICv2 generates IPIs with a MMIO write to the GICD_SGIR register. A common
pattern for IPI usage is for the IPI receiver to read data written to
memory by the sender. The armv7 and armv8 architectures implement a
weakly-ordered memory model, which means that barriers are required to make
sure that the expected values are observed.

It turns out that because the receiver CPU must observe the write to memory
that generated the IPI when reading the GICC_IAR MMIO register, we only
need to ensure ordering of memory accesses, and not completion. Use a
smp_wmb (DMB ISHST) barrier before sending the IPI.

This also matches what the Linux GICv2 irqchip driver does (more details
in commit 8adbf57fc429 ("irqchip: gic: use dmb ishst instead of dsb when
raising a softirq")).

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 lib/arm/gic-v2.c | 4 ++++
 arm/gic.c        | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/lib/arm/gic-v2.c b/lib/arm/gic-v2.c
index dc6a97c600ec..da244c82de34 100644
--- a/lib/arm/gic-v2.c
+++ b/lib/arm/gic-v2.c
@@ -45,6 +45,8 @@ void gicv2_ipi_send_single(int irq, int cpu)
 {
 	assert(cpu < 8);
 	assert(irq < 16);
+
+	smp_wmb();
 	writel(1 << (cpu + 16) | irq, gicv2_dist_base() + GICD_SGIR);
 }
 
@@ -53,5 +55,7 @@ void gicv2_ipi_send_mask(int irq, const cpumask_t *dest)
 	u8 tlist = (u8)cpumask_bits(dest)[0];
 
 	assert(irq < 16);
+
+	smp_wmb();
 	writel(tlist << 16 | irq, gicv2_dist_base() + GICD_SGIR);
 }
diff --git a/arm/gic.c b/arm/gic.c
index 512c83636a2e..401ffafe4299 100644
--- a/arm/gic.c
+++ b/arm/gic.c
@@ -260,11 +260,13 @@ static void check_lpi_hits(int *expected, const char *msg)
 
 static void gicv2_ipi_send_self(void)
 {
+	smp_wmb();
 	writel(2 << 24 | IPI_IRQ, gicv2_dist_base() + GICD_SGIR);
 }
 
 static void gicv2_ipi_send_broadcast(void)
 {
+	smp_wmb();
 	writel(1 << 24 | IPI_IRQ, gicv2_dist_base() + GICD_SGIR);
 }
 
-- 
2.29.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
