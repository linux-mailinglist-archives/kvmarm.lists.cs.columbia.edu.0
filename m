Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 660B71207FE
	for <lists+kvmarm@lfdr.de>; Mon, 16 Dec 2019 15:04:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 181644A5A6;
	Mon, 16 Dec 2019 09:04:37 -0500 (EST)
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
	with ESMTP id 0ViukredCFjq; Mon, 16 Dec 2019 09:04:37 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BDD664A7F0;
	Mon, 16 Dec 2019 09:04:35 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 025DF4A4F6
 for <kvmarm@lists.cs.columbia.edu>; Mon, 16 Dec 2019 09:04:35 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RhxmFD3k1xS0 for <kvmarm@lists.cs.columbia.edu>;
 Mon, 16 Dec 2019 09:04:33 -0500 (EST)
Received: from us-smtp-1.mimecast.com (us-smtp-2.mimecast.com [207.211.31.81])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EB9D74A5A8
 for <kvmarm@lists.cs.columbia.edu>; Mon, 16 Dec 2019 09:04:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576505073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iaB3mhmOVrr+BW+SeTs3iK+cp3Zt+YUYyPdWpraAu7A=;
 b=iLHS6eDBvxQIX5aglh4w8x7JVCGRYJXQLL9xvgOkq0z+pGy8cbn1luvS4wtap/itV1dRMQ
 YStexdpvVrD3jsP23/rGaTDm3nndMOncrKUKPuvJcja1x0fojPaFBXH0qPtvSHXq/Gt/6l
 BpdBdRyWkR7geMofwfy6BabPLNZTnXE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-jrVVURoXNyO-sGEQ6te3lw-1; Mon, 16 Dec 2019 09:04:31 -0500
X-MC-Unique: jrVVURoXNyO-sGEQ6te3lw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E45C800D50;
 Mon, 16 Dec 2019 14:04:29 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-117.ams2.redhat.com [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 83197675B8;
 Mon, 16 Dec 2019 14:04:26 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, maz@kernel.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Subject: [kvm-unit-tests PATCH 14/16] arm/run: Allow Migration tests
Date: Mon, 16 Dec 2019 15:02:33 +0100
Message-Id: <20191216140235.10751-15-eric.auger@redhat.com>
In-Reply-To: <20191216140235.10751-1-eric.auger@redhat.com>
References: <20191216140235.10751-1-eric.auger@redhat.com>
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

Let's link getchar.o to use puts and getchar from the
tests.

Then allow tests belonging to the migration group to
trigger the migration from the test code by putting
"migrate" into the uart. Then the code can wait for the
migration completion by using getchar().

The __getchar implement is minimalist as it just reads the
data register. It is just meant to read the single character
emitted at the end of the migration by the runner script.

It is not meant to read more data (FIFOs are not enabled).

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 arm/Makefile.common |  2 +-
 arm/run             |  2 +-
 lib/arm/io.c        | 13 +++++++++++++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arm/Makefile.common b/arm/Makefile.common
index 7cc0f04..327f112 100644
--- a/arm/Makefile.common
+++ b/arm/Makefile.common
@@ -32,7 +32,7 @@ CFLAGS += -I $(SRCDIR)/lib -I $(SRCDIR)/lib/libfdt -I lib
 asm-offsets = lib/$(ARCH)/asm-offsets.h
 include $(SRCDIR)/scripts/asm-offsets.mak
 
-cflatobjs += lib/util.o
+cflatobjs += lib/util.o lib/getchar.o
 cflatobjs += lib/alloc_phys.o
 cflatobjs += lib/alloc_page.o
 cflatobjs += lib/vmalloc.o
diff --git a/arm/run b/arm/run
index 277db9b..a390ca5 100755
--- a/arm/run
+++ b/arm/run
@@ -61,6 +61,6 @@ fi
 M+=",accel=$ACCEL"
 command="$qemu -nodefaults $M -cpu $processor $chr_testdev $pci_testdev"
 command+=" -display none -serial stdio -kernel"
-command="$(timeout_cmd) $command"
+command="$(migration_cmd) $(timeout_cmd) $command"
 
 run_qemu $command "$@"
diff --git a/lib/arm/io.c b/lib/arm/io.c
index 99fd315..aa9e1b5 100644
--- a/lib/arm/io.c
+++ b/lib/arm/io.c
@@ -87,6 +87,19 @@ void puts(const char *s)
 	spin_unlock(&uart_lock);
 }
 
+/*
+ * Minimalist implementation for migration completion detection.
+ * Needs to be improved for more advanced Rx cases
+ */
+int __getchar(void)
+{
+	int ret;
+
+	ret =  readb(uart0_base);
+	if (!ret)
+		return -1;
+	return ret;
+}
 
 /*
  * Defining halt to take 'code' as an argument guarantees that it will
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
