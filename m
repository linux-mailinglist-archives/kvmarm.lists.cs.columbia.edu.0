Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 124A110CC38
	for <lists+kvmarm@lfdr.de>; Thu, 28 Nov 2019 16:55:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 92D9B4ACBE;
	Thu, 28 Nov 2019 10:55:26 -0500 (EST)
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
	with ESMTP id oHMc-2VMWkif; Thu, 28 Nov 2019 10:55:26 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7CCC54ACBA;
	Thu, 28 Nov 2019 10:55:25 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1040D4AC6C
 for <kvmarm@lists.cs.columbia.edu>; Thu, 28 Nov 2019 10:55:25 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZMFZOm670Iwi for <kvmarm@lists.cs.columbia.edu>;
 Thu, 28 Nov 2019 10:55:24 -0500 (EST)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 321D24A51D
 for <kvmarm@lists.cs.columbia.edu>; Thu, 28 Nov 2019 10:55:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574956524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LNRtx2eKuvnZpDiZLFUivmjg1FNYd4r9ipgtCcuMY/A=;
 b=Pv9gjPuXXngYwgIGRltKZu8JvdlgS7F8GIW+x/L2EvJ4/LfNC43T2LTaC9OFVYuGaDiAaa
 GXO63lseSbORu9HUF+/b2YOpjISkifqktuWIgf3KDwnllMZDkk2jecmsSVFQrq9PpgdSz/
 mQzI3j//HN44EzVnVkEfoMSjZxlRDx0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-iyWJQaPYPIOma8rkjdpifw-1; Thu, 28 Nov 2019 10:55:19 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06D86100A162;
 Thu, 28 Nov 2019 15:55:18 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C85925C1B0;
 Thu, 28 Nov 2019 15:55:16 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: kvm@vger.kernel.org,
	kvmarm@lists.cs.columbia.edu
Subject: [PATCH kvm-unit-tests] arm/arm64: PL031: Fix check_rtc_irq
Date: Thu, 28 Nov 2019 16:55:15 +0100
Message-Id: <20191128155515.19013-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: iyWJQaPYPIOma8rkjdpifw-1
X-Mimecast-Spam-Score: 0
Cc: pbonzini@redhat.com
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

Since QEMU commit 83ad95957c7e ("pl031: Expose RTCICR as proper WC
register") the PL031 test gets into an infinite loop. Now we must
write bit zero of RTCICR to clear the IRQ status. Before, writing
anything to RTCICR would work. As '1' is a member of 'anything'
writing it should work for old QEMU as well.

Cc: Alexander Graf <graf@amazon.com>
Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 arm/pl031.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arm/pl031.c b/arm/pl031.c
index 1f63ef13994f..3b75fd653e96 100644
--- a/arm/pl031.c
+++ b/arm/pl031.c
@@ -143,8 +143,8 @@ static void irq_handler(struct pt_regs *regs)
 		report(readl(&pl031->ris) == 1, "  RTC RIS == 1");
 		report(readl(&pl031->mis) == 1, "  RTC MIS == 1");
 
-		/* Writing any value should clear IRQ status */
-		writel(0x80000000ULL, &pl031->icr);
+		/* Writing one to bit zero should clear IRQ status */
+		writel(1, &pl031->icr);
 
 		report(readl(&pl031->ris) == 0, "  RTC RIS == 0");
 		report(readl(&pl031->mis) == 0, "  RTC MIS == 0");
-- 
2.21.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
