Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0191D19E5C8
	for <lists+kvmarm@lfdr.de>; Sat,  4 Apr 2020 16:38:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A598B4B192;
	Sat,  4 Apr 2020 10:38:48 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VNeaPpt1KmAo; Sat,  4 Apr 2020 10:38:47 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9C8CB4B107;
	Sat,  4 Apr 2020 10:38:47 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 843E64B1F1
 for <kvmarm@lists.cs.columbia.edu>; Sat,  4 Apr 2020 10:38:46 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XIzYGgk6rHcv for <kvmarm@lists.cs.columbia.edu>;
 Sat,  4 Apr 2020 10:38:45 -0400 (EDT)
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [205.139.110.61])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BCEB94B230
 for <kvmarm@lists.cs.columbia.edu>; Sat,  4 Apr 2020 10:38:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586011124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1LCVI6Q4/Ny0Rm6fGm4deZaX1vxgVnpBC6xTC+/9SMI=;
 b=E7UDU0aXO7PC8iQxb8nnWLg/j2NRgex0QZt4yW/6/05E8xzV21S/4JLFsePeNvx2DMdA0k
 IXQCEGxCQMetD3lkPQCYTEy9Uibyf0o+2nw1kn1juJUkNvrToObZv/4wFCewvB2v0qY68Q
 KXatm4XmH+8hiyttY3Vx7Zfe1ujDNJ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-ps8eJ8gOO--NCAUGHPGUAA-1; Sat, 04 Apr 2020 10:38:42 -0400
X-MC-Unique: ps8eJ8gOO--NCAUGHPGUAA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6187E1005513;
 Sat,  4 Apr 2020 14:38:41 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9C2D79B912;
 Sat,  4 Apr 2020 14:38:39 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: pbonzini@redhat.com
Subject: [PULL kvm-unit-tests 25/39] arm: gic: Introduce
 gic_irq_set_clr_enable() helper
Date: Sat,  4 Apr 2020 16:37:17 +0200
Message-Id: <20200404143731.208138-26-drjones@redhat.com>
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

From: Eric Auger <eric.auger@redhat.com>

Allows to set or clear the enable state of a PPI/SGI/SPI.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 lib/arm/asm/gic.h |  4 ++++
 lib/arm/gic.c     | 31 +++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/lib/arm/asm/gic.h b/lib/arm/asm/gic.h
index 922cbe95750c..afb33096078d 100644
--- a/lib/arm/asm/gic.h
+++ b/lib/arm/asm/gic.h
@@ -82,5 +82,9 @@ extern void gic_ipi_send_single(int irq, int cpu);
 extern void gic_ipi_send_mask(int irq, const cpumask_t *dest);
 extern enum gic_irq_state gic_irq_state(int irq);
 
+void gic_irq_set_clr_enable(int irq, bool enable);
+#define gic_enable_irq(irq) gic_irq_set_clr_enable(irq, true)
+#define gic_disable_irq(irq) gic_irq_set_clr_enable(irq, false)
+
 #endif /* !__ASSEMBLY__ */
 #endif /* _ASMARM_GIC_H_ */
diff --git a/lib/arm/gic.c b/lib/arm/gic.c
index c3c5f6bc5b0e..8a1a8c84bf29 100644
--- a/lib/arm/gic.c
+++ b/lib/arm/gic.c
@@ -147,6 +147,36 @@ void gic_ipi_send_mask(int irq, const cpumask_t *dest)
 	gic_common_ops->ipi_send_mask(irq, dest);
 }
 
+void gic_irq_set_clr_enable(int irq, bool enable)
+{
+	u32 offset, split = 32, shift = (irq % 32);
+	u32 reg, mask = BIT(shift);
+	void *base;
+
+	assert(irq < 1020);
+
+	switch (gic_version()) {
+	case 2:
+		offset = enable ? GICD_ISENABLER : GICD_ICENABLER;
+		base = gicv2_dist_base();
+		break;
+	case 3:
+		if (irq < 32) {
+			offset = enable ? GICR_ISENABLER0 : GICR_ICENABLER0;
+			base = gicv3_sgi_base();
+		} else {
+			offset = enable ? GICD_ISENABLER : GICD_ICENABLER;
+			base = gicv3_dist_base();
+		}
+		break;
+	default:
+		assert(0);
+	}
+	base += offset + (irq / split) * 4;
+	reg = readl(base);
+	writel(reg | mask, base);
+}
+
 enum gic_irq_state gic_irq_state(int irq)
 {
 	enum gic_irq_state state;
@@ -191,3 +221,4 @@ enum gic_irq_state gic_irq_state(int irq)
 
 	return state;
 }
+
-- 
2.25.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
