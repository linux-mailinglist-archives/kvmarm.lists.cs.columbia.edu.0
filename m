Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A49B034AC0
	for <lists+kvmarm@lfdr.de>; Tue,  4 Jun 2019 16:46:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 57E644A50C;
	Tue,  4 Jun 2019 10:46:39 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sauR1ZTm0dQO; Tue,  4 Jun 2019 10:46:38 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DF0F54A533;
	Tue,  4 Jun 2019 10:46:37 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0CB164A51B
 for <kvmarm@lists.cs.columbia.edu>; Tue,  4 Jun 2019 10:46:37 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m9F9POhx2QaV for <kvmarm@lists.cs.columbia.edu>;
 Tue,  4 Jun 2019 10:46:35 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 822C44A523
 for <kvmarm@lists.cs.columbia.edu>; Tue,  4 Jun 2019 10:46:35 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04E4B341;
 Tue,  4 Jun 2019 07:46:35 -0700 (PDT)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7EDDE3F690;
 Tue,  4 Jun 2019 07:46:33 -0700 (PDT)
From: James Morse <james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.cs.columbia.edu
Subject: [PATCH v1 5/6] KVM: arm64: nop out dsb in __guest_enter() unless we
 have v8.2 RAS
Date: Tue,  4 Jun 2019 15:45:50 +0100
Message-Id: <20190604144551.188107-6-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190604144551.188107-1-james.morse@arm.com>
References: <20190604144551.188107-1-james.morse@arm.com>
MIME-Version: 1.0
Cc: Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
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

Previously we added a dsb before reading isr_el1 to ensure that the
hosts write's have finished, before we read isr_el1 to see if any of
them caused an SError.

This only really matters if we have the v8.2 RAS extensions with its
poison tracking and containment reporting via SError's ESR value.
Before v8.2 it is very unlikely these systems will detect and report
errors in a way that we can handle.

Use alternatives to remove this barrier on systems without v8.2 RAS.

Signed-off-by: James Morse <james.morse@arm.com>
---
Tested on A57 with v5.2-rc1, do_hvc from [0]
v5.2-rc1            mean:4339 stddev:33
v5.2-rc1+patches1-5 mean:4405 stddev:31
with series 1.53% slower
[0]https://git.kernel.org/pub/scm/linux/kernel/git/maz/kvm-ws-tests.git/

 arch/arm64/kvm/hyp/entry.S | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/entry.S b/arch/arm64/kvm/hyp/entry.S
index fa39899fe3d0..a5a4254314a1 100644
--- a/arch/arm64/kvm/hyp/entry.S
+++ b/arch/arm64/kvm/hyp/entry.S
@@ -17,6 +17,7 @@
 
 #include <linux/linkage.h>
 
+#include <asm/alternative.h>
 #include <asm/asm-offsets.h>
 #include <asm/assembler.h>
 #include <asm/fpsimdmacros.h>
@@ -65,8 +66,11 @@ ENTRY(__guest_enter)
 
 	// Now the host state is stored if we have a pending RAS SError it must
 	// affect the host. If any asyncronous exception is pending we defer
-	// the guest entry.
+	// the guest entry. The DSB isn't necessary before v8.2 as any SError
+	// would be fatal.
+alternative_if ARM64_HAS_RAS_EXTN
 	dsb	nshst
+alternative_else_nop_endif
 	mrs	x1, isr_el1
 	cbz	x1,  1f
 	mov	x0, #ARM_EXCEPTION_IRQ
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
