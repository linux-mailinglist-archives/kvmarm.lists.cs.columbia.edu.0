Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6C8326CBA
	for <lists+kvmarm@lfdr.de>; Sat, 27 Feb 2021 11:41:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2B8B34B451;
	Sat, 27 Feb 2021 05:41:54 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9OjYgTImWeRw; Sat, 27 Feb 2021 05:41:53 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E66AC4B43F;
	Sat, 27 Feb 2021 05:41:51 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4A1B04B428
 for <kvmarm@lists.cs.columbia.edu>; Sat, 27 Feb 2021 05:41:50 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RTeE5rrK1XVl for <kvmarm@lists.cs.columbia.edu>;
 Sat, 27 Feb 2021 05:41:49 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5DB714B427
 for <kvmarm@lists.cs.columbia.edu>; Sat, 27 Feb 2021 05:41:49 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D085106F;
 Sat, 27 Feb 2021 02:41:49 -0800 (PST)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6AF133F73B;
 Sat, 27 Feb 2021 02:41:48 -0800 (PST)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: drjones@redhat.com,
	kvm@vger.kernel.org,
	kvmarm@lists.cs.columbia.edu
Subject: [kvm-unit-tests PATCH 1/6] arm64: Remove unnecessary ISB when writing
 to SPSel
Date: Sat, 27 Feb 2021 10:41:56 +0000
Message-Id: <20210227104201.14403-2-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210227104201.14403-1-alexandru.elisei@arm.com>
References: <20210227104201.14403-1-alexandru.elisei@arm.com>
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

Software can use the SPSel operand to write directly to PSTATE.SP.
According to ARM DDI 0487F.b, page D1-2332, writes to PSTATE are
self-synchronizing and no ISB is needed:

"Writes to the PSTATE fields have side-effects on various aspects of the PE
operation. All of these side-effects are guaranteed:
- Not to be visible to earlier instructions in the execution stream.
- To be visible to later instructions in the execution stream."

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arm/cstart64.S | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arm/cstart64.S b/arm/cstart64.S
index 0428014aa58a..fc1930bcdb53 100644
--- a/arm/cstart64.S
+++ b/arm/cstart64.S
@@ -54,7 +54,6 @@ start:
 	/* set up stack */
 	mov	x4, #1
 	msr	spsel, x4
-	isb
 	adrp    x4, stackptr
 	add     sp, x4, :lo12:stackptr
 
-- 
2.30.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
