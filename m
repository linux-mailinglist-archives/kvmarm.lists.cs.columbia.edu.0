Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 82EF4A036F
	for <lists+kvmarm@lfdr.de>; Wed, 28 Aug 2019 15:39:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 31C514A581;
	Wed, 28 Aug 2019 09:39:09 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g+2gde0r2hS9; Wed, 28 Aug 2019 09:39:08 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5EBC14A5C6;
	Wed, 28 Aug 2019 09:39:06 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 12B784A599
 for <kvmarm@lists.cs.columbia.edu>; Wed, 28 Aug 2019 09:39:05 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u2m+dDmlMRqX for <kvmarm@lists.cs.columbia.edu>;
 Wed, 28 Aug 2019 09:39:03 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DD4BB4A5B3
 for <kvmarm@lists.cs.columbia.edu>; Wed, 28 Aug 2019 09:39:03 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A408815AB;
 Wed, 28 Aug 2019 06:39:03 -0700 (PDT)
Received: from e121566-lin.cambridge.arm.com (e121566-lin.cambridge.arm.com
 [10.1.196.217])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7CE493F246;
 Wed, 28 Aug 2019 06:39:02 -0700 (PDT)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: kvm@vger.kernel.org,
	kvmarm@lists.cs.columbia.edu
Subject: [kvm-unit-tests RFC PATCH 10/16] lib: Add UL and ULL definitions to
 linux/const.h
Date: Wed, 28 Aug 2019 14:38:25 +0100
Message-Id: <1566999511-24916-11-git-send-email-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566999511-24916-1-git-send-email-alexandru.elisei@arm.com>
References: <1566999511-24916-1-git-send-email-alexandru.elisei@arm.com>
Cc: maz@kernel.org, andre.przywara@arm.com, pbonzini@redhat.com
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

The UL macro was previously defined in lib/arm64/asm/pgtable-hwdef.h. Move
it to lib/linux/const.h so it can be used in other files. To keep things
consistent, also add an ULL macro.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 lib/linux/const.h             | 7 +++++--
 lib/arm64/asm/pgtable-hwdef.h | 2 --
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/linux/const.h b/lib/linux/const.h
index c872bfd25e13..e3c7fec3f4b8 100644
--- a/lib/linux/const.h
+++ b/lib/linux/const.h
@@ -21,7 +21,10 @@
 #define _AT(T,X)	((T)(X))
 #endif
 
-#define _BITUL(x)	(_AC(1,UL) << (x))
-#define _BITULL(x)	(_AC(1,ULL) << (x))
+#define UL(x) 		_AC(x, UL)
+#define ULL(x)		_AC(x, ULL)
+
+#define _BITUL(x)	(UL(1) << (x))
+#define _BITULL(x)	(ULL(1) << (x))
 
 #endif /* !(_LINUX_CONST_H) */
diff --git a/lib/arm64/asm/pgtable-hwdef.h b/lib/arm64/asm/pgtable-hwdef.h
index 045a3ce12645..e6f02fae4075 100644
--- a/lib/arm64/asm/pgtable-hwdef.h
+++ b/lib/arm64/asm/pgtable-hwdef.h
@@ -9,8 +9,6 @@
  * This work is licensed under the terms of the GNU GPL, version 2.
  */
 
-#define UL(x) _AC(x, UL)
-
 #define PTRS_PER_PTE		(1 << (PAGE_SHIFT - 3))
 
 /*
-- 
2.7.4

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
