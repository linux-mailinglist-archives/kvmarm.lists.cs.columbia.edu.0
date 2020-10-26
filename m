Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A75F6298E74
	for <lists+kvmarm@lfdr.de>; Mon, 26 Oct 2020 14:49:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5C3074B4DF;
	Mon, 26 Oct 2020 09:49:47 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g8ihAmLgRRef; Mon, 26 Oct 2020 09:49:47 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DF1D14B500;
	Mon, 26 Oct 2020 09:49:45 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B37164B250
 for <kvmarm@lists.cs.columbia.edu>; Mon, 26 Oct 2020 09:49:44 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ke+BkYLaZ8ac for <kvmarm@lists.cs.columbia.edu>;
 Mon, 26 Oct 2020 09:49:43 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 125F44B500
 for <kvmarm@lists.cs.columbia.edu>; Mon, 26 Oct 2020 09:49:43 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBA1F1042;
 Mon, 26 Oct 2020 06:49:42 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D6B573F68F;
 Mon, 26 Oct 2020 06:49:41 -0700 (PDT)
From: Mark Rutland <mark.rutland@arm.com>
To: kvmarm@lists.cs.columbia.edu,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCHv2 2/3] arm64: cpufeature: reorder cpus_have_{const,
 final}_cap()
Date: Mon, 26 Oct 2020 13:49:30 +0000
Message-Id: <20201026134931.28246-3-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201026134931.28246-1-mark.rutland@arm.com>
References: <20201026134931.28246-1-mark.rutland@arm.com>
Cc: maz@kernel.org, will@kernel.org
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

In a subsequent patch we'll modify cpus_have_const_cap() to call
cpus_have_final_cap(), and hence we need to define cpus_have_final_cap()
first.

To make subsequent changes easier to follow, this patch reorders the two
without making any other changes.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: David Brazdil <dbrazdil@google.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/cpufeature.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index f7e7144af174c..5d18c54507e6a 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -428,35 +428,35 @@ static __always_inline bool __cpus_have_const_cap(int num)
 }
 
 /*
- * Test for a capability, possibly with a runtime check.
+ * Test for a capability without a runtime check.
  *
- * Before capabilities are finalized, this behaves as cpus_have_cap().
+ * Before capabilities are finalized, this will BUG().
  * After capabilities are finalized, this is patched to avoid a runtime check.
  *
  * @num must be a compile-time constant.
  */
-static __always_inline bool cpus_have_const_cap(int num)
+static __always_inline bool cpus_have_final_cap(int num)
 {
 	if (system_capabilities_finalized())
 		return __cpus_have_const_cap(num);
 	else
-		return cpus_have_cap(num);
+		BUG();
 }
 
 /*
- * Test for a capability without a runtime check.
+ * Test for a capability, possibly with a runtime check.
  *
- * Before capabilities are finalized, this will BUG().
+ * Before capabilities are finalized, this behaves as cpus_have_cap().
  * After capabilities are finalized, this is patched to avoid a runtime check.
  *
  * @num must be a compile-time constant.
  */
-static __always_inline bool cpus_have_final_cap(int num)
+static __always_inline bool cpus_have_const_cap(int num)
 {
 	if (system_capabilities_finalized())
 		return __cpus_have_const_cap(num);
 	else
-		BUG();
+		return cpus_have_cap(num);
 }
 
 static inline void cpus_set_cap(unsigned int num)
-- 
2.11.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
