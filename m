Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0156D3A1777
	for <lists+kvmarm@lfdr.de>; Wed,  9 Jun 2021 16:37:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 64077407F4;
	Wed,  9 Jun 2021 10:37:40 -0400 (EDT)
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
	with ESMTP id Xt75Za-0wQ5v; Wed,  9 Jun 2021 10:37:40 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 635224048B;
	Wed,  9 Jun 2021 10:37:39 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EE1E349DE3
 for <kvmarm@lists.cs.columbia.edu>; Wed,  9 Jun 2021 10:37:38 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QJtf8LEGl7e4 for <kvmarm@lists.cs.columbia.edu>;
 Wed,  9 Jun 2021 10:37:38 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1D0E9407F4
 for <kvmarm@lists.cs.columbia.edu>; Wed,  9 Jun 2021 10:37:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623249458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/K++/bcdvbwlQu0OSohcPBViudVd7DNw3ieioYAfUZE=;
 b=F8CtkCjoTMvAf7dHGbAuPDPI/KZBQ7mBojNspHTncN2rpqe/UhYK95tkDjnKhMDP86+A2f
 x73s3QCqAFY0ERumdZJG9TZica5XkSbBjwtklvejBuuhFak6TLkfWkaLw25muqXldBEwt9
 hvKwuBI6HkYhIlS7ERQGB6eXi+QCqGE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-M74py1JfNvuB42-ehWRqig-1; Wed, 09 Jun 2021 10:37:36 -0400
X-MC-Unique: M74py1JfNvuB42-ehWRqig-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7CC26801B12;
 Wed,  9 Jun 2021 14:37:34 +0000 (UTC)
Received: from gondolin.fritz.box (ovpn-113-134.ams2.redhat.com
 [10.36.113.134])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 26C0219C46;
 Wed,  9 Jun 2021 14:37:31 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Andrew Jones <drjones@redhat.com>
Subject: [kvm-unit-tests PATCH v2 5/7] powerpc: unify header guards
Date: Wed,  9 Jun 2021 16:37:10 +0200
Message-Id: <20210609143712.60933-6-cohuck@redhat.com>
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

Only spapr.h needed a tweak.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 powerpc/spapr.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/powerpc/spapr.h b/powerpc/spapr.h
index b41aece07968..3a29598be44f 100644
--- a/powerpc/spapr.h
+++ b/powerpc/spapr.h
@@ -1,6 +1,6 @@
-#ifndef _ASMPOWERPC_SPAPR_H_
-#define _ASMPOWERPC_SPAPR_H_
+#ifndef POWERPC_SPAPR_H
+#define POWERPC_SPAPR_H
 
 #define SPAPR_KERNEL_LOAD_ADDR 0x400000
 
-#endif /* _ASMPOWERPC_SPAPR_H_ */
+#endif /* POWERPC_SPAPR_H */
-- 
2.31.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
