Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6A41119E5A1
	for <lists+kvmarm@lfdr.de>; Sat,  4 Apr 2020 16:38:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4D3284B1EA;
	Sat,  4 Apr 2020 10:38:03 -0400 (EDT)
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
	with ESMTP id WxO-Xo9WLmy4; Sat,  4 Apr 2020 10:38:03 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0F1244B1EE;
	Sat,  4 Apr 2020 10:38:01 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E43974B18D
 for <kvmarm@lists.cs.columbia.edu>; Sat,  4 Apr 2020 10:37:57 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uP8UHQqvcmbz for <kvmarm@lists.cs.columbia.edu>;
 Sat,  4 Apr 2020 10:37:57 -0400 (EDT)
Received: from us-smtp-delivery-1.mimecast.com
 (us-smtp-delivery-1.mimecast.com [207.211.31.120])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0AD304B191
 for <kvmarm@lists.cs.columbia.edu>; Sat,  4 Apr 2020 10:37:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586011076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tlCWhqWlWCHWkziqDK8HtBNiS2KEZarZ4cSvHaSV7Js=;
 b=G1mVHwVunbNPgvi57mo7cFVLfYl+oszILfWI7/onqLfZUz3KpECCI0GBRFeZ8WZrN/eZGY
 vY8KA45KGfonQVamdW0/NNF5sdx3XGa8AEHRD5FMYdTvfANrfzngzH951Zoi6tkCBaOlAf
 1WKVu1ppnV1gmmX/u8YactKTz/jesDs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-cb8AfRe9PEyLucJRgo82ZA-1; Sat, 04 Apr 2020 10:37:54 -0400
X-MC-Unique: cb8AfRe9PEyLucJRgo82ZA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94719801F9D;
 Sat,  4 Apr 2020 14:37:53 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AE8A81147DA;
 Sat,  4 Apr 2020 14:37:51 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: pbonzini@redhat.com
Subject: [PULL kvm-unit-tests 06/39] arm64: timer: EOIR the interrupt after
 masking the timer
Date: Sat,  4 Apr 2020 16:36:58 +0200
Message-Id: <20200404143731.208138-7-drjones@redhat.com>
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

Writing to the EOIR register before masking the HW mapped timer
interrupt can cause taking another timer interrupt immediately after
exception return. This doesn't happen all the time, because KVM
reevaluates the state of pending HW mapped level sensitive interrupts on
each guest exit. If the second interrupt is pending and a guest exit
occurs after masking the timer interrupt and before the ERET (which
restores PSTATE.I), then KVM removes it.

Move the write after the IMASK bit has been set to prevent this from
happening.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 arm/timer.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arm/timer.c b/arm/timer.c
index 82f891147b35..b6f9dd10162d 100644
--- a/arm/timer.c
+++ b/arm/timer.c
@@ -157,19 +157,20 @@ static void irq_handler(struct pt_regs *regs)
 	u32 irqstat = gic_read_iar();
 	u32 irqnr = gic_iar_irqnr(irqstat);
 
-	if (irqnr != GICC_INT_SPURIOUS)
-		gic_write_eoir(irqstat);
-
 	if (irqnr == PPI(vtimer_info.irq)) {
 		info = &vtimer_info;
 	} else if (irqnr == PPI(ptimer_info.irq)) {
 		info = &ptimer_info;
 	} else {
+		if (irqnr != GICC_INT_SPURIOUS)
+			gic_write_eoir(irqstat);
 		report_info("Unexpected interrupt: %d\n", irqnr);
 		return;
 	}
 
 	info->write_ctl(ARCH_TIMER_CTL_IMASK | ARCH_TIMER_CTL_ENABLE);
+	gic_write_eoir(irqstat);
+
 	info->irq_received = true;
 }
 
-- 
2.25.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
