Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2F76219E5A5
	for <lists+kvmarm@lfdr.de>; Sat,  4 Apr 2020 16:38:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D528B4B207;
	Sat,  4 Apr 2020 10:38:05 -0400 (EDT)
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
	with ESMTP id UP9pxEL+fa+Q; Sat,  4 Apr 2020 10:38:05 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4BE584B223;
	Sat,  4 Apr 2020 10:38:04 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3BC934B208
 for <kvmarm@lists.cs.columbia.edu>; Sat,  4 Apr 2020 10:38:03 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E9icYoAusK2Z for <kvmarm@lists.cs.columbia.edu>;
 Sat,  4 Apr 2020 10:38:02 -0400 (EDT)
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [205.139.110.61])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 286084B1EA
 for <kvmarm@lists.cs.columbia.edu>; Sat,  4 Apr 2020 10:37:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586011079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dKH8kqeRHPgwOpfK642cVQ9Bs8jNBiXwoN4mILH3dyQ=;
 b=G9OMcbSBojgp2LmQ/tex5A3w8isKAhHBHcGeEluKddNrMg1lWQ5UKjn7hLJ/yVhGlzndnn
 WYOgA2IblUSIaBfD2ekJX2UNfiafg6OKxuyG53pq7p5+8BteLUJFD1+/X3ZusMlOw0+qcf
 xXHCGAu1gtcymV3cmBSbdmSSLG0TWvI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30--RQ6u3H-Nea8gZAmXtbi-Q-1; Sat, 04 Apr 2020 10:37:56 -0400
X-MC-Unique: -RQ6u3H-Nea8gZAmXtbi-Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CDD9418AB2C2;
 Sat,  4 Apr 2020 14:37:55 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 16CFB9B912;
 Sat,  4 Apr 2020 14:37:53 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: pbonzini@redhat.com
Subject: [PULL kvm-unit-tests 07/39] arm64: timer: Wait for the GIC to sample
 timer interrupt state
Date: Sat,  4 Apr 2020 16:36:59 +0200
Message-Id: <20200404143731.208138-8-drjones@redhat.com>
In-Reply-To: <20200404143731.208138-1-drjones@redhat.com>
References: <20200404143731.208138-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org
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

From: Alexandru Elisei <alexandru.elisei@arm.com>

There is a delay between the timer asserting the interrupt and the GIC
sampling the interrupt state. Let's take that into account when we are
checking if the timer interrupt is pending (or not) at the GIC level.

An interrupt can be pending or active and pending [1,2]. Let's be precise
and check that the interrupt is actually pending, not active and pending.

[1] ARM IHI 0048B.b, section 1.4.1
[2] ARM IHI 0069E, section 1.2.2

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 arm/timer.c       | 43 ++++++++++++++++++++++++++++++++++++++-----
 arm/unittests.cfg |  2 +-
 2 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/arm/timer.c b/arm/timer.c
index b6f9dd10162d..ba7e8c6a90ed 100644
--- a/arm/timer.c
+++ b/arm/timer.c
@@ -8,6 +8,7 @@
 #include <libcflat.h>
 #include <devicetree.h>
 #include <errata.h>
+#include <asm/delay.h>
 #include <asm/processor.h>
 #include <asm/gic.h>
 #include <asm/io.h>
@@ -16,6 +17,14 @@
 #define ARCH_TIMER_CTL_IMASK   (1 << 1)
 #define ARCH_TIMER_CTL_ISTATUS (1 << 2)
 
+enum gic_state {
+	GIC_STATE_INACTIVE,
+	GIC_STATE_PENDING,
+	GIC_STATE_ACTIVE,
+	GIC_STATE_ACTIVE_PENDING,
+};
+
+static void *gic_isactiver;
 static void *gic_ispendr;
 static void *gic_isenabler;
 static void *gic_icenabler;
@@ -174,9 +183,28 @@ static void irq_handler(struct pt_regs *regs)
 	info->irq_received = true;
 }
 
-static bool gic_timer_pending(struct timer_info *info)
+static enum gic_state gic_timer_state(struct timer_info *info)
 {
-	return readl(gic_ispendr) & (1 << PPI(info->irq));
+	enum gic_state state = GIC_STATE_INACTIVE;
+	int i;
+	bool pending, active;
+
+	/* Wait for up to 1s for the GIC to sample the interrupt. */
+	for (i = 0; i < 10; i++) {
+		pending = readl(gic_ispendr) & (1 << PPI(info->irq));
+		active = readl(gic_isactiver) & (1 << PPI(info->irq));
+		if (!active && !pending)
+			state = GIC_STATE_INACTIVE;
+		if (pending)
+			state = GIC_STATE_PENDING;
+		if (active)
+			state = GIC_STATE_ACTIVE;
+		if (active && pending)
+			state = GIC_STATE_ACTIVE_PENDING;
+		mdelay(100);
+	}
+
+	return state;
 }
 
 static bool test_cval_10msec(struct timer_info *info)
@@ -225,15 +253,18 @@ static void test_timer(struct timer_info *info)
 	/* Enable the timer, but schedule it for much later */
 	info->write_cval(later);
 	info->write_ctl(ARCH_TIMER_CTL_ENABLE);
-	report(!gic_timer_pending(info), "not pending before");
+	report(gic_timer_state(info) == GIC_STATE_INACTIVE,
+			"not pending before");
 
 	info->write_cval(now - 1);
-	report(gic_timer_pending(info), "interrupt signal pending");
+	report(gic_timer_state(info) == GIC_STATE_PENDING,
+			"interrupt signal pending");
 
 	/* Disable the timer again and prepare to take interrupts */
 	info->write_ctl(0);
 	set_timer_irq_enabled(info, true);
-	report(!gic_timer_pending(info), "interrupt signal no longer pending");
+	report(gic_timer_state(info) == GIC_STATE_INACTIVE,
+			"interrupt signal no longer pending");
 
 	report(test_cval_10msec(info), "latency within 10 ms");
 	report(info->irq_received, "interrupt received");
@@ -307,11 +338,13 @@ static void test_init(void)
 
 	switch (gic_version()) {
 	case 2:
+		gic_isactiver = gicv2_dist_base() + GICD_ISACTIVER;
 		gic_ispendr = gicv2_dist_base() + GICD_ISPENDR;
 		gic_isenabler = gicv2_dist_base() + GICD_ISENABLER;
 		gic_icenabler = gicv2_dist_base() + GICD_ICENABLER;
 		break;
 	case 3:
+		gic_isactiver = gicv3_sgi_base() + GICD_ISACTIVER;
 		gic_ispendr = gicv3_sgi_base() + GICD_ISPENDR;
 		gic_isenabler = gicv3_sgi_base() + GICR_ISENABLER0;
 		gic_icenabler = gicv3_sgi_base() + GICR_ICENABLER0;
diff --git a/arm/unittests.cfg b/arm/unittests.cfg
index daeb5a09ad39..1f1bb24d9d13 100644
--- a/arm/unittests.cfg
+++ b/arm/unittests.cfg
@@ -132,7 +132,7 @@ groups = psci
 [timer]
 file = timer.flat
 groups = timer
-timeout = 2s
+timeout = 8s
 arch = arm64
 
 # Exit tests
-- 
2.25.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
