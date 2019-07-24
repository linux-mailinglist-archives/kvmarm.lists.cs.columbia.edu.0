Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBDD733BD
	for <lists+kvmarm@lfdr.de>; Wed, 24 Jul 2019 18:26:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4439A4A5D0;
	Wed, 24 Jul 2019 12:26:03 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wf7D9ReRSzux; Wed, 24 Jul 2019 12:26:02 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2DE2B4A5C1;
	Wed, 24 Jul 2019 12:26:02 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 786A14A5CD
 for <kvmarm@lists.cs.columbia.edu>; Wed, 24 Jul 2019 12:26:00 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BieDByekLClm for <kvmarm@lists.cs.columbia.edu>;
 Wed, 24 Jul 2019 12:25:59 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 58DBD4A5C6
 for <kvmarm@lists.cs.columbia.edu>; Wed, 24 Jul 2019 12:25:58 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 198EF15A1;
 Wed, 24 Jul 2019 09:25:58 -0700 (PDT)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com
 [10.1.196.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA34C3F71F;
 Wed, 24 Jul 2019 09:25:56 -0700 (PDT)
From: Julien Grall <julien.grall@arm.com>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu
Subject: [PATCH v3 07/15] arm64/mm: Introduce NUM_ASIDS
Date: Wed, 24 Jul 2019 17:25:26 +0100
Message-Id: <20190724162534.7390-8-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190724162534.7390-1-julien.grall@arm.com>
References: <20190724162534.7390-1-julien.grall@arm.com>
Cc: marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
 Julien Grall <julien.grall@arm.com>
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

At the moment ASID_FIRST_VERSION is used to know the number of ASIDs
supported. As we are going to move the ASID allocator in a separate, it
would be better to use a different name for external users.

This patch adds NUM_ASIDS and implements ASID_FIRST_VERSION using it.

Signed-off-by: Julien Grall <julien.grall@arm.com>
---
 arch/arm64/mm/context.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index 2e1e495cd1d8..3b40ac4a2541 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -37,7 +37,9 @@ static DEFINE_PER_CPU(atomic64_t, active_asids);
 static DEFINE_PER_CPU(u64, reserved_asids);
 
 #define ASID_MASK(info)			(~GENMASK((info)->bits - 1, 0))
-#define ASID_FIRST_VERSION(info)	(1UL << ((info)->bits))
+#define NUM_ASIDS(info)			(1UL << ((info)->bits))
+
+#define ASID_FIRST_VERSION(info)	NUM_ASIDS(info)
 
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
 #define ASID_PER_CONTEXT		2
@@ -45,7 +47,7 @@ static DEFINE_PER_CPU(u64, reserved_asids);
 #define ASID_PER_CONTEXT		1
 #endif
 
-#define NUM_CTXT_ASIDS(info)		(ASID_FIRST_VERSION(info) >> (info)->ctxt_shift)
+#define NUM_CTXT_ASIDS(info)		(NUM_ASIDS(info) >> (info)->ctxt_shift)
 #define asid2idx(info, asid)		(((asid) & ~ASID_MASK(info)) >> (info)->ctxt_shift)
 #define idx2asid(info, idx)		(((idx) << (info)->ctxt_shift) & ~ASID_MASK(info))
 
-- 
2.11.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
