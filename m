Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 73E4214B2AF
	for <lists+kvmarm@lfdr.de>; Tue, 28 Jan 2020 11:35:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 264A74ACBA;
	Tue, 28 Jan 2020 05:35:27 -0500 (EST)
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
	with ESMTP id 9sjxEFUdzyQL; Tue, 28 Jan 2020 05:35:27 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 21CE64AC77;
	Tue, 28 Jan 2020 05:35:26 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id F1BB34AC07
 for <kvmarm@lists.cs.columbia.edu>; Tue, 28 Jan 2020 05:35:24 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e-ZNsomDW9tA for <kvmarm@lists.cs.columbia.edu>;
 Tue, 28 Jan 2020 05:35:24 -0500 (EST)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 502254A98A
 for <kvmarm@lists.cs.columbia.edu>; Tue, 28 Jan 2020 05:35:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580207723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g1Y7SAIkQ6YKL70iv+PevVOHVnPkk+5bW/+E3fVVoME=;
 b=bTES5eM4ZDs/H4FlL6/8EbilLibPMAwILVz6KypInu7HOLMlxQYYRr9GlwQTQbC3SLK7FN
 w8KX8neRwzKrC5eqSKoc9ZfvWuQboyKEFmGqErp/77RxHniniB2P+uUdyCFffdXcY8Rgpf
 quBLuVnDhsT7R+0BhkK63Zh+T5WMg40=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-60MnbJ6RNh6DWtQjzWJD4g-1; Tue, 28 Jan 2020 05:35:17 -0500
X-MC-Unique: 60MnbJ6RNh6DWtQjzWJD4g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47B7B1005510;
 Tue, 28 Jan 2020 10:35:16 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E70F91001B30;
 Tue, 28 Jan 2020 10:35:10 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, maz@kernel.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Subject: [kvm-unit-tests PATCH v3 01/14] libcflat: Add other size defines
Date: Tue, 28 Jan 2020 11:34:46 +0100
Message-Id: <20200128103459.19413-2-eric.auger@redhat.com>
In-Reply-To: <20200128103459.19413-1-eric.auger@redhat.com>
References: <20200128103459.19413-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

Introduce additional SZ_256, SZ_8K, SZ_16K macros that will
be used by ITS tests.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 lib/libcflat.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/libcflat.h b/lib/libcflat.h
index ea19f61..7092af2 100644
--- a/lib/libcflat.h
+++ b/lib/libcflat.h
@@ -36,7 +36,10 @@
 #define ALIGN(x, a)		__ALIGN((x), (a))
 #define IS_ALIGNED(x, a)	(((x) & ((typeof(x))(a) - 1)) == 0)
 
+#define SZ_256			(1 << 8)
 #define SZ_4K			(1 << 12)
+#define SZ_8K			(1 << 13)
+#define SZ_16K			(1 << 14)
 #define SZ_64K			(1 << 16)
 #define SZ_2M			(1 << 21)
 #define SZ_1G			(1 << 30)
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
