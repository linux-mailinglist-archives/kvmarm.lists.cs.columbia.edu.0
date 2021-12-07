Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 736CC46BFBF
	for <lists+kvmarm@lfdr.de>; Tue,  7 Dec 2021 16:47:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 111954B0BF;
	Tue,  7 Dec 2021 10:47:03 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mm9J2jntwfYF; Tue,  7 Dec 2021 10:47:00 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0E6EE4B11E;
	Tue,  7 Dec 2021 10:46:59 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7DB6C49DE3
 for <kvmarm@lists.cs.columbia.edu>; Tue,  7 Dec 2021 10:46:57 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RnKaYbFAZGBi for <kvmarm@lists.cs.columbia.edu>;
 Tue,  7 Dec 2021 10:46:55 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7B17C4B0BE
 for <kvmarm@lists.cs.columbia.edu>; Tue,  7 Dec 2021 10:46:55 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3422D13A1;
 Tue,  7 Dec 2021 07:46:55 -0800 (PST)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 717773F5A1;
 Tue,  7 Dec 2021 07:46:54 -0800 (PST)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: drjones@redhat.com,
	kvm@vger.kernel.org,
	kvmarm@lists.cs.columbia.edu
Subject: [kvm-unit-tests PATCH 1/4] arm: timer: Fix TVAL comparison for timer
 condition met
Date: Tue,  7 Dec 2021 15:46:38 +0000
Message-Id: <20211207154641.87740-2-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211207154641.87740-1-alexandru.elisei@arm.com>
References: <20211207154641.87740-1-alexandru.elisei@arm.com>
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

ARM DDI 0487G.a states on page D13-4180 that, when the virtual timer is
enabled, the timer condition is met when CNTVCT_EL0 - CNTV_CVAL_EL0 >= 0.
Multiplying both sides of the inequality by -1, we get the equivalent
condition CNTV_CVAL_EL0 - CNTVCT_EL0 <= 0 for when the timer should fire.

On the same page, it states that a read of the CNTV_TVAL_EL0 register
returns CNTV_CVAL_EL0 - CNTVCT_EL0 if the virtual timer is enabled.
Putting the two together, the timer condition is met when the value of the
TVAL register is less than or *equal* to 0.

Same rules apply for the physical timer.

Fix the check for the timer expiring by treating a TVAL value equal to zero
as a valid condition for the timer to fire.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arm/timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arm/timer.c b/arm/timer.c
index 09e3f8f6bd7d..2a6687f22874 100644
--- a/arm/timer.c
+++ b/arm/timer.c
@@ -277,7 +277,7 @@ static void test_timer(struct timer_info *info)
 	local_irq_enable();
 	left = info->read_tval();
 	report(info->irq_received, "interrupt received after TVAL/WFI");
-	report(left < 0, "timer has expired");
+	report(left <= 0, "timer has expired");
 	report_info("TVAL is %d ticks", left);
 }
 
-- 
2.34.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
