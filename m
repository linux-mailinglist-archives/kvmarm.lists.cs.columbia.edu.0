Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id EA2DF15BBBE
	for <lists+kvmarm@lfdr.de>; Thu, 13 Feb 2020 10:33:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 84CC74A968;
	Thu, 13 Feb 2020 04:33:10 -0500 (EST)
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
	with ESMTP id 7D29c05i3eA5; Thu, 13 Feb 2020 04:33:10 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 498F24A7D9;
	Thu, 13 Feb 2020 04:33:09 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8DEF84A50F
 for <kvmarm@lists.cs.columbia.edu>; Thu, 13 Feb 2020 04:33:07 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pNxz5+hrl0u6 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 13 Feb 2020 04:33:06 -0500 (EST)
Received: from us-smtp-delivery-1.mimecast.com
 (us-smtp-delivery-1.mimecast.com [207.211.31.120])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 830704A4FC
 for <kvmarm@lists.cs.columbia.edu>; Thu, 13 Feb 2020 04:33:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581586386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=O8Z9Thp+VSDpsbJ/c3/SKEh6FPSKloGY5r0r2a4bGnM=;
 b=aHj3KeHPEj9T3117DwX/utfX4lMJWiuX+qTCB1a3WZzx6KTTQ3FekeLZt70fglY5Q60TIO
 t8Nsn2RQ2xl6IYzxEdjubMkgk20zF/GqiS9OL02sP7ETRD9oJ9DAsMqOqEEqXZDIZ8e+IC
 leYJCnvieMv54XXBFxMIHFgNQlHoie4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-yZJ42JDsPGWE0H5Gm83c3A-1; Thu, 13 Feb 2020 04:33:04 -0500
X-MC-Unique: yZJ42JDsPGWE0H5Gm83c3A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26D68107ACCA;
 Thu, 13 Feb 2020 09:33:03 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EA80B5C13F;
 Thu, 13 Feb 2020 09:32:58 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: kvm@vger.kernel.org,
	kvmarm@lists.cs.columbia.edu
Subject: [PATCH kvm-unit-tests v3] arm64: timer: Speed up gic-timer-state check
Date: Thu, 13 Feb 2020 10:32:57 +0100
Message-Id: <20200213093257.23367-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

Let's bail out of the wait loop if we see the expected state
to save over six seconds of run time. Make sure we wait a bit
before reading the registers and double check again after,
though, to somewhat mitigate the chance of seeing the expected
state by accident.

We also take this opportunity to push more IRQ state code to
the library.

Cc: Zenghui Yu <yuzenghui@huawei.com>
Reviewed-by: Alexandru Elisei <alexandru.elisei@arm.com>
Signed-off-by: Andrew Jones <drjones@redhat.com>
---
v3:
 - make gic_irq_state general for all irqs < 1020 [Zenghui Yu]
 - remove unused gic offsets from arm/timer.c [Alexandru Elisei]
v2:
 - check timer irq state twice [Alexandru Elisei]

 arm/timer.c       | 36 ++++++++++++------------------------
 lib/arm/asm/gic.h | 11 ++++++-----
 lib/arm/gic.c     | 45 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+), 29 deletions(-)

diff --git a/arm/timer.c b/arm/timer.c
index f5cf775ce50f..44621b4f2967 100644
--- a/arm/timer.c
+++ b/arm/timer.c
@@ -17,8 +17,6 @@
 #define ARCH_TIMER_CTL_IMASK   (1 << 1)
 #define ARCH_TIMER_CTL_ISTATUS (1 << 2)
 
-static void *gic_isactiver;
-static void *gic_ispendr;
 static void *gic_isenabler;
 static void *gic_icenabler;
 
@@ -183,28 +181,22 @@ static bool timer_pending(struct timer_info *info)
 		(info->read_ctl() & ARCH_TIMER_CTL_ISTATUS);
 }
 
-static enum gic_state gic_timer_state(struct timer_info *info)
+static bool gic_timer_check_state(struct timer_info *info,
+				  enum gic_irq_state expected_state)
 {
-	enum gic_state state = GIC_STATE_INACTIVE;
 	int i;
-	bool pending, active;
 
 	/* Wait for up to 1s for the GIC to sample the interrupt. */
 	for (i = 0; i < 10; i++) {
-		pending = readl(gic_ispendr) & (1 << PPI(info->irq));
-		active = readl(gic_isactiver) & (1 << PPI(info->irq));
-		if (!active && !pending)
-			state = GIC_STATE_INACTIVE;
-		if (pending)
-			state = GIC_STATE_PENDING;
-		if (active)
-			state = GIC_STATE_ACTIVE;
-		if (active && pending)
-			state = GIC_STATE_ACTIVE_PENDING;
 		mdelay(100);
+		if (gic_irq_state(PPI(info->irq)) == expected_state) {
+			mdelay(100);
+			if (gic_irq_state(PPI(info->irq)) == expected_state)
+				return true;
+		}
 	}
 
-	return state;
+	return false;
 }
 
 static bool test_cval_10msec(struct timer_info *info)
@@ -253,11 +245,11 @@ static void test_timer(struct timer_info *info)
 	/* Enable the timer, but schedule it for much later */
 	info->write_cval(later);
 	info->write_ctl(ARCH_TIMER_CTL_ENABLE);
-	report(!timer_pending(info) && gic_timer_state(info) == GIC_STATE_INACTIVE,
+	report(!timer_pending(info) && gic_timer_check_state(info, GIC_IRQ_STATE_INACTIVE),
 			"not pending before");
 
 	info->write_cval(now - 1);
-	report(timer_pending(info) && gic_timer_state(info) == GIC_STATE_PENDING,
+	report(timer_pending(info) && gic_timer_check_state(info, GIC_IRQ_STATE_PENDING),
 			"interrupt signal pending");
 
 	/* Disable the timer again and prepare to take interrupts */
@@ -265,12 +257,12 @@ static void test_timer(struct timer_info *info)
 	info->irq_received = false;
 	set_timer_irq_enabled(info, true);
 	report(!info->irq_received, "no interrupt when timer is disabled");
-	report(!timer_pending(info) && gic_timer_state(info) == GIC_STATE_INACTIVE,
+	report(!timer_pending(info) && gic_timer_check_state(info, GIC_IRQ_STATE_INACTIVE),
 			"interrupt signal no longer pending");
 
 	info->write_cval(now - 1);
 	info->write_ctl(ARCH_TIMER_CTL_ENABLE | ARCH_TIMER_CTL_IMASK);
-	report(timer_pending(info) && gic_timer_state(info) == GIC_STATE_INACTIVE,
+	report(timer_pending(info) && gic_timer_check_state(info, GIC_IRQ_STATE_INACTIVE),
 			"interrupt signal not pending");
 
 	report(test_cval_10msec(info), "latency within 10 ms");
@@ -345,14 +337,10 @@ static void test_init(void)
 
 	switch (gic_version()) {
 	case 2:
-		gic_isactiver = gicv2_dist_base() + GICD_ISACTIVER;
-		gic_ispendr = gicv2_dist_base() + GICD_ISPENDR;
 		gic_isenabler = gicv2_dist_base() + GICD_ISENABLER;
 		gic_icenabler = gicv2_dist_base() + GICD_ICENABLER;
 		break;
 	case 3:
-		gic_isactiver = gicv3_sgi_base() + GICR_ISACTIVER0;
-		gic_ispendr = gicv3_sgi_base() + GICR_ISPENDR0;
 		gic_isenabler = gicv3_sgi_base() + GICR_ISENABLER0;
 		gic_icenabler = gicv3_sgi_base() + GICR_ICENABLER0;
 		break;
diff --git a/lib/arm/asm/gic.h b/lib/arm/asm/gic.h
index a72e0cde4e9c..922cbe95750c 100644
--- a/lib/arm/asm/gic.h
+++ b/lib/arm/asm/gic.h
@@ -47,11 +47,11 @@
 #ifndef __ASSEMBLY__
 #include <asm/cpumask.h>
 
-enum gic_state {
-	GIC_STATE_INACTIVE,
-	GIC_STATE_PENDING,
-	GIC_STATE_ACTIVE,
-	GIC_STATE_ACTIVE_PENDING,
+enum gic_irq_state {
+	GIC_IRQ_STATE_INACTIVE,
+	GIC_IRQ_STATE_PENDING,
+	GIC_IRQ_STATE_ACTIVE,
+	GIC_IRQ_STATE_ACTIVE_PENDING,
 };
 
 /*
@@ -80,6 +80,7 @@ extern u32 gic_iar_irqnr(u32 iar);
 extern void gic_write_eoir(u32 irqstat);
 extern void gic_ipi_send_single(int irq, int cpu);
 extern void gic_ipi_send_mask(int irq, const cpumask_t *dest);
+extern enum gic_irq_state gic_irq_state(int irq);
 
 #endif /* !__ASSEMBLY__ */
 #endif /* _ASMARM_GIC_H_ */
diff --git a/lib/arm/gic.c b/lib/arm/gic.c
index 94301169215c..c3c5f6bc5b0e 100644
--- a/lib/arm/gic.c
+++ b/lib/arm/gic.c
@@ -146,3 +146,48 @@ void gic_ipi_send_mask(int irq, const cpumask_t *dest)
 	assert(gic_common_ops && gic_common_ops->ipi_send_mask);
 	gic_common_ops->ipi_send_mask(irq, dest);
 }
+
+enum gic_irq_state gic_irq_state(int irq)
+{
+	enum gic_irq_state state;
+	void *ispendr, *isactiver;
+	bool pending, active;
+	int offset, mask;
+
+	assert(gic_common_ops);
+	assert(irq < 1020);
+
+	switch (gic_version()) {
+	case 2:
+		ispendr = gicv2_dist_base() + GICD_ISPENDR;
+		isactiver = gicv2_dist_base() + GICD_ISACTIVER;
+		break;
+	case 3:
+		if (irq < GIC_NR_PRIVATE_IRQS) {
+			ispendr = gicv3_sgi_base() + GICR_ISPENDR0;
+			isactiver = gicv3_sgi_base() + GICR_ISACTIVER0;
+		} else {
+			ispendr = gicv3_dist_base() + GICD_ISPENDR;
+			isactiver = gicv3_dist_base() + GICD_ISACTIVER;
+		}
+		break;
+	default:
+		assert(0);
+	}
+
+	offset = irq / 32 * 4;
+	mask = 1 << (irq % 32);
+	pending = readl(ispendr + offset) & mask;
+	active = readl(isactiver + offset) & mask;
+
+	if (!active && !pending)
+		state = GIC_IRQ_STATE_INACTIVE;
+	if (pending)
+		state = GIC_IRQ_STATE_PENDING;
+	if (active)
+		state = GIC_IRQ_STATE_ACTIVE;
+	if (active && pending)
+		state = GIC_IRQ_STATE_ACTIVE_PENDING;
+
+	return state;
+}
-- 
2.21.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
