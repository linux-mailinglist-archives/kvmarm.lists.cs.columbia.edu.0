Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 673CD137018
	for <lists+kvmarm@lfdr.de>; Fri, 10 Jan 2020 15:54:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 177D94B19B;
	Fri, 10 Jan 2020 09:54:41 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Hj5seaZ9YyDF; Fri, 10 Jan 2020 09:54:40 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CF3644B190;
	Fri, 10 Jan 2020 09:54:39 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E45AE4B17F
 for <kvmarm@lists.cs.columbia.edu>; Fri, 10 Jan 2020 09:54:38 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C89CjzD3uMM7 for <kvmarm@lists.cs.columbia.edu>;
 Fri, 10 Jan 2020 09:54:37 -0500 (EST)
Received: from us-smtp-1.mimecast.com (us-smtp-1.mimecast.com [205.139.110.61])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DA0094AEFF
 for <kvmarm@lists.cs.columbia.edu>; Fri, 10 Jan 2020 09:54:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578668077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hksWhfx/qjqLBl2kwSG6HIa1DnV2Yh8CnWY4dayzAHc=;
 b=TWwPaLqNjuisTNHbR4U+BXIxgzDnwYdd94Z3tY8iFkJZL8ACl5RLakr91MVo9f6F5ofi3V
 xXVmTPtLfmq4D+6epSFQOtxIF/zoQlxzoqxH3rYzIfDMh9qi41OqvQCq/SYmuPbpgexSl6
 uPMoxWX2pl9TbEsdT2/z6VPN1umEDwI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-sLHCnH1HO6O3PHQlEJkQ_A-1; Fri, 10 Jan 2020 09:54:33 -0500
X-MC-Unique: sLHCnH1HO6O3PHQlEJkQ_A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 328261AEEF5;
 Fri, 10 Jan 2020 14:54:32 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-117-108.ams2.redhat.com [10.36.117.108])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D26397C407;
 Fri, 10 Jan 2020 14:54:25 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, maz@kernel.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Subject: [kvm-unit-tests PATCH v2 02/16] arm: gic: Provide per-IRQ helper
 functions
Date: Fri, 10 Jan 2020 15:53:58 +0100
Message-Id: <20200110145412.14937-3-eric.auger@redhat.com>
In-Reply-To: <20200110145412.14937-1-eric.auger@redhat.com>
References: <20200110145412.14937-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: andre.przywara@arm.com, thuth@redhat.com
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

From: Andre Przywara <andre.przywara@arm.com>

A common theme when accessing per-IRQ parameters in the GIC distributor
is to set fields of a certain bit width in a range of MMIO registers.
Examples are the enabled status (one bit per IRQ), the level/edge
configuration (2 bits per IRQ) or the priority (8 bits per IRQ).

Add a generic helper function which is able to mask and set the
respective number of bits, given the IRQ number and the MMIO offset.
Provide wrappers using this function to easily allow configuring an IRQ.

For now assume that private IRQ numbers always refer to the current CPU.
In a GICv2 accessing the "other" private IRQs is not easily doable (the
registers are banked per CPU on the same MMIO address), so we impose the
same limitation on GICv3, even though those registers are not banked
there anymore.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>

---

initialize reg
---
 lib/arm/asm/gic-v3.h |  2 +
 lib/arm/asm/gic.h    |  8 ++++
 lib/arm/gic.c        | 90 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 100 insertions(+)

diff --git a/lib/arm/asm/gic-v3.h b/lib/arm/asm/gic-v3.h
index 0dc838b..6beeab6 100644
--- a/lib/arm/asm/gic-v3.h
+++ b/lib/arm/asm/gic-v3.h
@@ -23,6 +23,8 @@
 #define GICD_CTLR_ENABLE_G1A		(1U << 1)
 #define GICD_CTLR_ENABLE_G1		(1U << 0)
 
+#define GICD_IROUTER			0x6000
+
 /* Re-Distributor registers, offsets from RD_base */
 #define GICR_TYPER			0x0008
 
diff --git a/lib/arm/asm/gic.h b/lib/arm/asm/gic.h
index 09826fd..21cdb58 100644
--- a/lib/arm/asm/gic.h
+++ b/lib/arm/asm/gic.h
@@ -74,5 +74,13 @@ extern void gic_write_eoir(u32 irqstat);
 extern void gic_ipi_send_single(int irq, int cpu);
 extern void gic_ipi_send_mask(int irq, const cpumask_t *dest);
 
+void gic_set_irq_bit(int irq, int offset);
+void gic_enable_irq(int irq);
+void gic_disable_irq(int irq);
+void gic_set_irq_priority(int irq, u8 prio);
+void gic_set_irq_target(int irq, int cpu);
+void gic_set_irq_group(int irq, int group);
+int gic_get_irq_group(int irq);
+
 #endif /* !__ASSEMBLY__ */
 #endif /* _ASMARM_GIC_H_ */
diff --git a/lib/arm/gic.c b/lib/arm/gic.c
index 9430116..aa9cb86 100644
--- a/lib/arm/gic.c
+++ b/lib/arm/gic.c
@@ -146,3 +146,93 @@ void gic_ipi_send_mask(int irq, const cpumask_t *dest)
 	assert(gic_common_ops && gic_common_ops->ipi_send_mask);
 	gic_common_ops->ipi_send_mask(irq, dest);
 }
+
+enum gic_bit_access {
+	ACCESS_READ,
+	ACCESS_SET,
+	ACCESS_RMW
+};
+
+static u8 gic_masked_irq_bits(int irq, int offset, int bits, u8 value,
+			      enum gic_bit_access access)
+{
+	void *base;
+	int split = 32 / bits;
+	int shift = (irq % split) * bits;
+	u32 reg = 0, mask = ((1U << bits) - 1) << shift;
+
+	switch (gic_version()) {
+	case 2:
+		base = gicv2_dist_base();
+		break;
+	case 3:
+		if (irq < 32)
+			base = gicv3_sgi_base();
+		else
+			base = gicv3_dist_base();
+		break;
+	default:
+		return 0;
+	}
+	base += offset + (irq / split) * 4;
+
+	switch (access) {
+	case ACCESS_READ:
+		return (readl(base) & mask) >> shift;
+	case ACCESS_SET:
+		reg = 0;
+		break;
+	case ACCESS_RMW:
+		reg = readl(base) & ~mask;
+		break;
+	}
+
+	writel(reg | ((u32)value << shift), base);
+
+	return 0;
+}
+
+void gic_set_irq_bit(int irq, int offset)
+{
+	gic_masked_irq_bits(irq, offset, 1, 1, ACCESS_SET);
+}
+
+void gic_enable_irq(int irq)
+{
+	gic_set_irq_bit(irq, GICD_ISENABLER);
+}
+
+void gic_disable_irq(int irq)
+{
+	gic_set_irq_bit(irq, GICD_ICENABLER);
+}
+
+void gic_set_irq_priority(int irq, u8 prio)
+{
+	gic_masked_irq_bits(irq, GICD_IPRIORITYR, 8, prio, ACCESS_RMW);
+}
+
+void gic_set_irq_target(int irq, int cpu)
+{
+	if (irq < 32)
+		return;
+
+	if (gic_version() == 2) {
+		gic_masked_irq_bits(irq, GICD_ITARGETSR, 8, 1U << cpu,
+				    ACCESS_RMW);
+
+		return;
+	}
+
+	writeq(cpus[cpu], gicv3_dist_base() + GICD_IROUTER + irq * 8);
+}
+
+void gic_set_irq_group(int irq, int group)
+{
+	gic_masked_irq_bits(irq, GICD_IGROUPR, 1, group, ACCESS_RMW);
+}
+
+int gic_get_irq_group(int irq)
+{
+	return gic_masked_irq_bits(irq, GICD_IGROUPR, 1, 0, ACCESS_READ);
+}
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
