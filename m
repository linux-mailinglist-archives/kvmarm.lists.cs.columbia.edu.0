Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0569018CA2E
	for <lists+kvmarm@lfdr.de>; Fri, 20 Mar 2020 10:24:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AC21F4B09A;
	Fri, 20 Mar 2020 05:24:57 -0400 (EDT)
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
	with ESMTP id 49C+AvxE8yno; Fri, 20 Mar 2020 05:24:57 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9010D4B08C;
	Fri, 20 Mar 2020 05:24:56 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3F20A4B08C
 for <kvmarm@lists.cs.columbia.edu>; Fri, 20 Mar 2020 05:24:55 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kMdzJmAITu7m for <kvmarm@lists.cs.columbia.edu>;
 Fri, 20 Mar 2020 05:24:54 -0400 (EDT)
Received: from us-smtp-delivery-74.mimecast.com
 (us-smtp-delivery-74.mimecast.com [63.128.21.74])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4B1084A5A0
 for <kvmarm@lists.cs.columbia.edu>; Fri, 20 Mar 2020 05:24:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584696294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jUPGPmIvaDDGzVaAE49y1ve21avwQxlD6sBJrt5aqiw=;
 b=YkZnqUROJXa6QMWLvuVu3JWIzN6xrCjFJdrHZXoYFoXf6Yf+Kn9cwDV7BPe0RSC7zzqdcE
 r9wgx5bKSQsBQq40CJnq3iDrPdu357PtXwZr6QHAkIQ9ijUGI4BpAwKaIfRf+O7+G9i9ny
 HDAGXaNaLqWOiY8Vbsh7XzA5zCu/Jww=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-OsWFrT5gNDeelXWk7ftxug-1; Fri, 20 Mar 2020 05:24:50 -0400
X-MC-Unique: OsWFrT5gNDeelXWk7ftxug-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F4311005514;
 Fri, 20 Mar 2020 09:24:49 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-113-142.ams2.redhat.com [10.36.113.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 240475C1D8;
 Fri, 20 Mar 2020 09:24:45 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, maz@kernel.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Subject: [kvm-unit-tests PATCH v7 02/13] page_alloc: Introduce get_order()
Date: Fri, 20 Mar 2020 10:24:17 +0100
Message-Id: <20200320092428.20880-3-eric.auger@redhat.com>
In-Reply-To: <20200320092428.20880-1-eric.auger@redhat.com>
References: <20200320092428.20880-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

Compute the power of 2 order of a size. Use it in
page_memalign. Other users are looming.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 lib/alloc_page.c | 7 ++++++-
 lib/alloc_page.h | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/alloc_page.c b/lib/alloc_page.c
index ed23638..7c8461a 100644
--- a/lib/alloc_page.c
+++ b/lib/alloc_page.c
@@ -155,7 +155,7 @@ static void *page_memalign(size_t alignment, size_t size)
 	if (!size)
 		return NULL;
 
-	order = is_power_of_2(n) ? fls(n) : fls(n) + 1;
+	order = get_order(n);
 
 	return alloc_pages(order);
 }
@@ -175,3 +175,8 @@ void page_alloc_ops_enable(void)
 {
 	alloc_ops = &page_alloc_ops;
 }
+
+int get_order(size_t size)
+{
+	return is_power_of_2(size) ? fls(size) : fls(size) + 1;
+}
diff --git a/lib/alloc_page.h b/lib/alloc_page.h
index 739a91d..e6a51d2 100644
--- a/lib/alloc_page.h
+++ b/lib/alloc_page.h
@@ -15,5 +15,6 @@ void *alloc_pages(unsigned long order);
 void free_page(void *page);
 void free_pages(void *mem, unsigned long size);
 void free_pages_by_order(void *mem, unsigned long order);
+int get_order(size_t size);
 
 #endif
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
