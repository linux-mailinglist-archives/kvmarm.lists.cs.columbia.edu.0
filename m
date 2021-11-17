Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id F0204454A32
	for <lists+kvmarm@lfdr.de>; Wed, 17 Nov 2021 16:42:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 99D4C4B222;
	Wed, 17 Nov 2021 10:42:22 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0eIAgTH304TV; Wed, 17 Nov 2021 10:42:22 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BE24A4B23C;
	Wed, 17 Nov 2021 10:42:19 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 36F614B14C
 for <kvmarm@lists.cs.columbia.edu>; Wed, 17 Nov 2021 10:42:18 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id St1wvUJ78mmQ for <kvmarm@lists.cs.columbia.edu>;
 Wed, 17 Nov 2021 10:42:16 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 993944B1E6
 for <kvmarm@lists.cs.columbia.edu>; Wed, 17 Nov 2021 10:42:16 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5072D1FB;
 Wed, 17 Nov 2021 07:42:16 -0800 (PST)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A8D43F5A1;
 Wed, 17 Nov 2021 07:42:15 -0800 (PST)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: will@kernel.org, julien.thierry.kdev@gmail.com, maz@kernel.org,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Subject: [RFC PATCH v5 kvmtool 3/4] init: Add last_{init, exit} list macros
Date: Wed, 17 Nov 2021 15:43:55 +0000
Message-Id: <20211117154356.303039-4-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211117154356.303039-1-alexandru.elisei@arm.com>
References: <20211117154356.303039-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
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

Add a last_init macro for constructor functions that will be executed last
in the initialization process. Add a symmetrical macro, last_exit, for
destructor functions that will be the last to be executed when kvmtool
exits.

The list priority for the late_{init, exit} macros has been bumped down a
spot, but their relative priority remains unchanged, to keep the same size
for the init_lists and exit_lists.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 include/kvm/util-init.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/kvm/util-init.h b/include/kvm/util-init.h
index 13d4f04df678..e6a0e1696689 100644
--- a/include/kvm/util-init.h
+++ b/include/kvm/util-init.h
@@ -39,7 +39,8 @@ static void __attribute__ ((constructor)) __init__##cb(void)		\
 #define dev_init(cb) __init_list_add(cb, 5)
 #define virtio_dev_init(cb) __init_list_add(cb, 6)
 #define firmware_init(cb) __init_list_add(cb, 7)
-#define late_init(cb) __init_list_add(cb, 9)
+#define late_init(cb) __init_list_add(cb, 8)
+#define last_init(cb) __init_list_add(cb, 9)
 
 #define core_exit(cb) __exit_list_add(cb, 0)
 #define base_exit(cb) __exit_list_add(cb, 2)
@@ -47,5 +48,6 @@ static void __attribute__ ((constructor)) __init__##cb(void)		\
 #define dev_exit(cb) __exit_list_add(cb, 5)
 #define virtio_dev_exit(cb) __exit_list_add(cb, 6)
 #define firmware_exit(cb) __exit_list_add(cb, 7)
-#define late_exit(cb) __exit_list_add(cb, 9)
+#define late_exit(cb) __exit_list_add(cb, 8)
+#define last_exit(cb) __exit_list_add(cb, 9)
 #endif
-- 
2.33.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
