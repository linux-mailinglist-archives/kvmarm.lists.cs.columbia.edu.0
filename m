Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 529D13A176E
	for <lists+kvmarm@lfdr.de>; Wed,  9 Jun 2021 16:37:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 00E3049E57;
	Wed,  9 Jun 2021 10:37:30 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.209
X-Spam-Level: 
X-Spam-Status: No, score=0.209 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_LOW=-0.7,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1IpGRyjg4ZBF; Wed,  9 Jun 2021 10:37:29 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CB17A409DD;
	Wed,  9 Jun 2021 10:37:28 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A693C40821
 for <kvmarm@lists.cs.columbia.edu>; Wed,  9 Jun 2021 10:37:27 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nIFI90Qmz4nh for <kvmarm@lists.cs.columbia.edu>;
 Wed,  9 Jun 2021 10:37:26 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8545F405A6
 for <kvmarm@lists.cs.columbia.edu>; Wed,  9 Jun 2021 10:37:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623249446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vdBWH0NN5RVcs+Ky8LQUJLLDTKdwavE0wet4jRY+IVY=;
 b=UXqc6Y2zn/dmwzBza1IBV+vK15n+2DUTRq2VFI71jNLX/qfrRp1e8RnEci4zUEmBccQlwY
 iU0CsFcvOThUXKp87wp9GS/BoDeJDvK4XjvsSoktCAGspWbtx1e1OPcibLBkOJ2uD7BYv1
 b8Oh+f3B1SeLw0y+WtRxVLZR92DAv+U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-wCKholfbM6iAwud00jGFyA-1; Wed, 09 Jun 2021 10:37:25 -0400
X-MC-Unique: wCKholfbM6iAwud00jGFyA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1764C73A0;
 Wed,  9 Jun 2021 14:37:23 +0000 (UTC)
Received: from gondolin.fritz.box (ovpn-113-134.ams2.redhat.com
 [10.36.113.134])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5435219C46;
 Wed,  9 Jun 2021 14:37:21 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Andrew Jones <drjones@redhat.com>
Subject: [kvm-unit-tests PATCH v2 1/7] README.md: add guideline for header
 guards format
Date: Wed,  9 Jun 2021 16:37:06 +0200
Message-Id: <20210609143712.60933-2-cohuck@redhat.com>
In-Reply-To: <20210609143712.60933-1-cohuck@redhat.com>
References: <20210609143712.60933-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: Laurent Vivier <lvivier@redhat.com>, linux-s390@vger.kernel.org,
 Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 kvm-ppc@vger.kernel.org, Claudio Imbrenda <imbrenda@linux.ibm.com>,
 kvmarm@lists.cs.columbia.edu
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

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 README.md | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/README.md b/README.md
index 24d4bdaaee0d..687ff50d0af1 100644
--- a/README.md
+++ b/README.md
@@ -156,6 +156,15 @@ Exceptions:
 
   - While the kernel standard requires 80 columns, we allow up to 120.
 
+Header guards:
+
+Please try to adhere to adhere to the following patterns when adding
+"#ifndef <...> #define <...>" header guards:
+    ./lib:             _HEADER_H_
+    ./lib/<ARCH>:      _ARCH_HEADER_H_
+    ./lib/<ARCH>/asm:  _ASMARCH_HEADER_H_
+    ./<ARCH>:          ARCH_HEADER_H
+
 ## Patches
 
 Patches are welcome at the KVM mailing list <kvm@vger.kernel.org>.
-- 
2.31.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
