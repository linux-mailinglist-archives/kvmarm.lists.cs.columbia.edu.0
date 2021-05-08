Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id AFDF53770D4
	for <lists+kvmarm@lfdr.de>; Sat,  8 May 2021 11:18:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 470C14B802;
	Sat,  8 May 2021 05:18:17 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ML9VG89aFGAG; Sat,  8 May 2021 05:18:17 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 38C244B813;
	Sat,  8 May 2021 05:18:14 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7375F4B81A
 for <kvmarm@lists.cs.columbia.edu>; Sat,  8 May 2021 03:17:52 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1ZxrXGHvrFcT for <kvmarm@lists.cs.columbia.edu>;
 Sat,  8 May 2021 03:17:51 -0400 (EDT)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id BD16F4B30C
 for <kvmarm@lists.cs.columbia.edu>; Sat,  8 May 2021 03:17:50 -0400 (EDT)
IronPort-SDR: cdwYiZyvVYU4oS9Jhw05efvdAVx/TuvWXjG9KIc+HY3gBm3e6zz4beMF3L3a3BLSTszr6isnra
 K0eM1SU0NJJA==
X-IronPort-AV: E=McAfee;i="6200,9189,9977"; a="219793800"
X-IronPort-AV: E=Sophos;i="5.82,283,1613462400"; d="scan'208";a="219793800"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2021 00:17:48 -0700
IronPort-SDR: tsgzUZs8tvIizuU72JMmEcN+UYuWGP/CHbcmGM8z+23NbbZK5biOyHJbY9Jc5+K3XprAjh2AvC
 lg6GkNlVctWg==
X-IronPort-AV: E=Sophos;i="5.82,283,1613462400"; d="scan'208";a="435267317"
Received: from unknown (HELO localhost.localdomain.bj.intel.com)
 ([10.240.193.73])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2021 00:17:45 -0700
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: jasowang@redhat.com, mst@redhat.com, maz@kernel.org,
 alex.williamson@redhat.com
Subject: [PATCH] Revert "irqbypass: do not start cons/prod when failed connect"
Date: Sat,  8 May 2021 15:11:52 +0800
Message-Id: <20210508071152.722425-1-lingshan.zhu@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Mailman-Approved-At: Sat, 08 May 2021 05:18:12 -0400
Cc: kvm@vger.kernel.org, cohuck@redhat.com, stable@vger.kernel.org,
 Zhu Lingshan <lingshan.zhu@intel.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
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

This reverts commit a979a6aa009f3c99689432e0cdb5402a4463fb88.

The reverted commit may cause VM freeze on arm64 platform.
Because on arm64 platform, stop a consumer will suspend the VM,
the VM will freeze without a start consumer

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
---
 virt/lib/irqbypass.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/virt/lib/irqbypass.c b/virt/lib/irqbypass.c
index c9bb3957f58a..28fda42e471b 100644
--- a/virt/lib/irqbypass.c
+++ b/virt/lib/irqbypass.c
@@ -40,21 +40,17 @@ static int __connect(struct irq_bypass_producer *prod,
 	if (prod->add_consumer)
 		ret = prod->add_consumer(prod, cons);
 
-	if (ret)
-		goto err_add_consumer;
-
-	ret = cons->add_producer(cons, prod);
-	if (ret)
-		goto err_add_producer;
+	if (!ret) {
+		ret = cons->add_producer(cons, prod);
+		if (ret && prod->del_consumer)
+			prod->del_consumer(prod, cons);
+	}
 
 	if (cons->start)
 		cons->start(cons);
 	if (prod->start)
 		prod->start(prod);
-err_add_producer:
-	if (prod->del_consumer)
-		prod->del_consumer(prod, cons);
-err_add_consumer:
+
 	return ret;
 }
 
-- 
2.27.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
