Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2B829C0B8
	for <lists+kvmarm@lfdr.de>; Tue, 27 Oct 2020 18:19:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3CBAC4B399;
	Tue, 27 Oct 2020 13:19:02 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qajPO6U2jG06; Tue, 27 Oct 2020 13:19:02 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0C5CB4B4A4;
	Tue, 27 Oct 2020 13:19:01 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0CD014B39B
 for <kvmarm@lists.cs.columbia.edu>; Tue, 27 Oct 2020 13:19:00 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vcE6VM18wPRy for <kvmarm@lists.cs.columbia.edu>;
 Tue, 27 Oct 2020 13:18:58 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2DF164B399
 for <kvmarm@lists.cs.columbia.edu>; Tue, 27 Oct 2020 13:18:58 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A80C150C;
 Tue, 27 Oct 2020 10:18:57 -0700 (PDT)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C3D4A3F719;
 Tue, 27 Oct 2020 10:18:54 -0700 (PDT)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: kvm@vger.kernel.org,
	kvmarm@lists.cs.columbia.edu
Subject: [kvm-unit-tests RFC PATCH v2 2/5] lib/{bitops,
 alloc_page}.h: Add missing headers
Date: Tue, 27 Oct 2020 17:19:41 +0000
Message-Id: <20201027171944.13933-3-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201027171944.13933-1-alexandru.elisei@arm.com>
References: <20201027171944.13933-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
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

bitops.h uses the 'bool' and 'size_t' types, but doesn't include the
stddef.h and stdbool.h headers, where the types are defined. This can cause
the following error when compiling:

In file included from arm/new-test.c:9:
/path/to/kvm-unit-tests/lib/bitops.h:77:15: error: unknown type name 'bool'
   77 | static inline bool is_power_of_2(unsigned long n)
      |               ^~~~
/path/to/kvm-unit-tests/lib/bitops.h:82:38: error: unknown type name 'size_t'
   82 | static inline unsigned int get_order(size_t size)
      |                                      ^~~~~~
/path/to/kvm-unit-tests/lib/bitops.h:24:1: note: 'size_t' is defined in header '<stddef.h>'; did you forget to '#include <stddef.h>'?
   23 | #include <asm/bitops.h>
  +++ |+#include <stddef.h>
   24 |
make: *** [<builtin>: arm/new-test.o] Error 1

The same errors were observed when including alloc_page.h. Fix both files
by including stddef.h and stdbool.h.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 lib/alloc_page.h | 2 ++
 lib/bitops.h     | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/lib/alloc_page.h b/lib/alloc_page.h
index 88540d1def06..182862c43363 100644
--- a/lib/alloc_page.h
+++ b/lib/alloc_page.h
@@ -4,6 +4,8 @@
  * This is a simple allocator that provides contiguous physical addresses
  * with byte granularity.
  */
+#include <stdbool.h>
+#include <stddef.h>
 
 #ifndef ALLOC_PAGE_H
 #define ALLOC_PAGE_H 1
diff --git a/lib/bitops.h b/lib/bitops.h
index 308aa86514a8..5aeea0b998b1 100644
--- a/lib/bitops.h
+++ b/lib/bitops.h
@@ -1,5 +1,7 @@
 #ifndef _BITOPS_H_
 #define _BITOPS_H_
+#include <stdbool.h>
+#include <stddef.h>
 
 /*
  * Adapted from
-- 
2.29.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
