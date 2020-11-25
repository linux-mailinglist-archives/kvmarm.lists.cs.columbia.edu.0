Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B2DD72C446A
	for <lists+kvmarm@lfdr.de>; Wed, 25 Nov 2020 16:50:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 687EC4BA0C;
	Wed, 25 Nov 2020 10:50:16 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1-vK0dJ6Z2QI; Wed, 25 Nov 2020 10:50:16 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3537F4BA29;
	Wed, 25 Nov 2020 10:50:15 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id AF5024B9C6
 for <kvmarm@lists.cs.columbia.edu>; Wed, 25 Nov 2020 10:50:13 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kXKsCktwxVdF for <kvmarm@lists.cs.columbia.edu>;
 Wed, 25 Nov 2020 10:50:12 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 56E1D4B9DA
 for <kvmarm@lists.cs.columbia.edu>; Wed, 25 Nov 2020 10:50:10 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02FB0106F;
 Wed, 25 Nov 2020 07:50:10 -0800 (PST)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 329183F7BB;
 Wed, 25 Nov 2020 07:50:09 -0800 (PST)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: kvm@vger.kernel.org,
	kvmarm@lists.cs.columbia.edu,
	drjones@redhat.com
Subject: [kvm-unit-tests PATCH 07/10] arm/arm64: gic: Wait for writes to acked
 or spurious to complete
Date: Wed, 25 Nov 2020 15:51:10 +0000
Message-Id: <20201125155113.192079-8-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201125155113.192079-1-alexandru.elisei@arm.com>
References: <20201125155113.192079-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
Cc: andre.przywara@arm.com
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

The IPI test has two parts: in the first part, it tests that the sender CPU
can send an IPI to itself (ipi_test_self()), and in the second part it
sends interrupts to even-numbered CPUs (ipi_test_smp()). When acknowledging
an interrupt, if we read back a spurious interrupt ID (1023), the handler
increments the index in the static array spurious corresponding to the CPU
ID that the handler is running on; if we get the expected interrupt ID, we
increment the same index in the acked array.

Reads of the spurious and acked arrays are synchronized with writes
performed before sending the IPI. The synchronization is done either in the
IPI sender function (GICv3), either by creating a data dependency (GICv2).

At the end of the test, the sender CPU reads from the acked and spurious
arrays to check against the expected behaviour. We need to make sure the
that writes in ipi_handler() are observable by the sender CPU. Use a DSB
ISHST to make sure that the writes have completed.

One might rightfully argue that there are no guarantees regarding when the
DSB instruction completes, just like there are no guarantees regarding when
the value is observed by the other CPUs. However, let's do our best and
instruct the CPU to complete the memory access when we know that it will be
needed.

We still need to follow the message passing pattern for the acked,
respectively bad_irq and bad_sender, because DSB guarantees that all memory
accesses that come before the barrier have completed, not that they have
completed in program order.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arm/gic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arm/gic.c b/arm/gic.c
index 5727d72a0ef3..544c283f5f47 100644
--- a/arm/gic.c
+++ b/arm/gic.c
@@ -161,8 +161,10 @@ static void ipi_handler(struct pt_regs *regs __unused)
 		++acked[smp_processor_id()];
 	} else {
 		++spurious[smp_processor_id()];
-		smp_wmb();
 	}
+
+	/* Wait for writes to acked/spurious to complete */
+	dsb(ishst);
 }
 
 static void setup_irq(irq_handler_fn handler)
-- 
2.29.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
