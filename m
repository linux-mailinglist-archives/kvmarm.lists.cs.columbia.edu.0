Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4E84B11567C
	for <lists+kvmarm@lfdr.de>; Fri,  6 Dec 2019 18:28:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F251C4AF5C;
	Fri,  6 Dec 2019 12:28:18 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.391
X-Spam-Level: 
X-Spam-Status: No, score=-1.391 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id szYZhzmpBVx2; Fri,  6 Dec 2019 12:28:18 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C0CC34AF45;
	Fri,  6 Dec 2019 12:28:17 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CA4184AECE
 for <kvmarm@lists.cs.columbia.edu>; Fri,  6 Dec 2019 12:28:16 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mZdqZ4-w9Tfc for <kvmarm@lists.cs.columbia.edu>;
 Fri,  6 Dec 2019 12:28:15 -0500 (EST)
Received: from us-smtp-1.mimecast.com (us-smtp-2.mimecast.com [207.211.31.81])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3B8484AF00
 for <kvmarm@lists.cs.columbia.edu>; Fri,  6 Dec 2019 12:28:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575653295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=19yQ4vp56OlBsL/0IrWKby5/zs2yahEC4NVwVl09/bk=;
 b=G3UfLBzYqlCXsU0y1w7G3tsyPap1TergDLakD7weNcp8zgYg1Do9nWfUNWWeOQtugi1xD1
 w4/Os6hTZ4+WF/9uLYo0DlTrQSeZ4AT43qyS86KAOTua0CTpetsFGOECA9RzSejZW488nn
 kgLdSQugQ6zs28CdteQv+C/zn85jjI8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-K79uiRAXONuXvi2zOw0w7Q-1; Fri, 06 Dec 2019 12:28:14 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B301B1005502;
 Fri,  6 Dec 2019 17:28:11 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-117.ams2.redhat.com [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A0C1E60BF4;
 Fri,  6 Dec 2019 17:28:06 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, maz@kernel.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Subject: [kvm-unit-tests RFC 09/10] arm/arm64: gic: Introduce setup_irq()
 helper
Date: Fri,  6 Dec 2019 18:27:23 +0100
Message-Id: <20191206172724.947-10-eric.auger@redhat.com>
In-Reply-To: <20191206172724.947-1-eric.auger@redhat.com>
References: <20191206172724.947-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: K79uiRAXONuXvi2zOw0w7Q-1
X-Mimecast-Spam-Score: 0
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

ipi_enable() code would be reusable for other interrupts
than IPI. Let's rename it setup_irq() and pass an interrupt
handler pointer. We also export it to use it in other tests
such as the PMU's one.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 arm/gic.c         | 24 +++---------------------
 lib/arm/asm/gic.h |  3 +++
 lib/arm/gic.c     | 11 +++++++++++
 3 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/arm/gic.c b/arm/gic.c
index adb6aa4..04919ae 100644
--- a/arm/gic.c
+++ b/arm/gic.c
@@ -215,20 +215,9 @@ static void ipi_test_smp(void)
 	report_prefix_pop();
 }
 
-static void ipi_enable(void)
-{
-	gic_enable_defaults();
-#ifdef __arm__
-	install_exception_handler(EXCPTN_IRQ, ipi_handler);
-#else
-	install_irq_handler(EL1H_IRQ, ipi_handler);
-#endif
-	local_irq_enable();
-}
-
 static void ipi_send(void)
 {
-	ipi_enable();
+	setup_irq(ipi_handler);
 	wait_on_ready();
 	ipi_test_self();
 	ipi_test_smp();
@@ -238,7 +227,7 @@ static void ipi_send(void)
 
 static void ipi_recv(void)
 {
-	ipi_enable();
+	setup_irq(ipi_handler);
 	cpumask_set_cpu(smp_processor_id(), &ready);
 	while (1)
 		wfi();
@@ -295,14 +284,7 @@ static void ipi_clear_active_handler(struct pt_regs *regs __unused)
 static void run_active_clear_test(void)
 {
 	report_prefix_push("active");
-	gic_enable_defaults();
-#ifdef __arm__
-	install_exception_handler(EXCPTN_IRQ, ipi_clear_active_handler);
-#else
-	install_irq_handler(EL1H_IRQ, ipi_clear_active_handler);
-#endif
-	local_irq_enable();
-
+	setup_irq(ipi_clear_active_handler);
 	ipi_test_self();
 	report_prefix_pop();
 }
diff --git a/lib/arm/asm/gic.h b/lib/arm/asm/gic.h
index 21cdb58..55dd84b 100644
--- a/lib/arm/asm/gic.h
+++ b/lib/arm/asm/gic.h
@@ -82,5 +82,8 @@ void gic_set_irq_target(int irq, int cpu);
 void gic_set_irq_group(int irq, int group);
 int gic_get_irq_group(int irq);
 
+typedef void (*handler_t)(struct pt_regs *regs __unused);
+extern void setup_irq(handler_t handler);
+
 #endif /* !__ASSEMBLY__ */
 #endif /* _ASMARM_GIC_H_ */
diff --git a/lib/arm/gic.c b/lib/arm/gic.c
index aa9cb86..0c5511f 100644
--- a/lib/arm/gic.c
+++ b/lib/arm/gic.c
@@ -236,3 +236,14 @@ int gic_get_irq_group(int irq)
 {
 	return gic_masked_irq_bits(irq, GICD_IGROUPR, 1, 0, ACCESS_READ);
 }
+
+void setup_irq(handler_t handler)
+{
+        gic_enable_defaults();
+#ifdef __arm__
+        install_exception_handler(EXCPTN_IRQ, handler);
+#else
+        install_irq_handler(EL1H_IRQ, handler);
+#endif
+        local_irq_enable();
+}
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
