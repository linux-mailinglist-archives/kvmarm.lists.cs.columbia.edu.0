Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFB6308A61
	for <lists+kvmarm@lfdr.de>; Fri, 29 Jan 2021 17:37:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 02E984B0E5;
	Fri, 29 Jan 2021 11:37:30 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8E8FpzyirrmC; Fri, 29 Jan 2021 11:37:29 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9E1E84B343;
	Fri, 29 Jan 2021 11:37:26 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B2D964B2B9
 for <kvmarm@lists.cs.columbia.edu>; Fri, 29 Jan 2021 11:37:24 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1CZkMwGBOruO for <kvmarm@lists.cs.columbia.edu>;
 Fri, 29 Jan 2021 11:37:23 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C8E374B346
 for <kvmarm@lists.cs.columbia.edu>; Fri, 29 Jan 2021 11:37:20 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D7AA15BE;
 Fri, 29 Jan 2021 08:37:20 -0800 (PST)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 628E43F71B;
 Fri, 29 Jan 2021 08:37:19 -0800 (PST)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: drjones@redhat.com,
	kvm@vger.kernel.org,
	kvmarm@lists.cs.columbia.edu
Subject: [kvm-unit-tests PATCH v3 10/11] arm64: gic: its-trigger: Don't
 trigger the LPI while it is pending
Date: Fri, 29 Jan 2021 16:36:46 +0000
Message-Id: <20210129163647.91564-11-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210129163647.91564-1-alexandru.elisei@arm.com>
References: <20210129163647.91564-1-alexandru.elisei@arm.com>
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

The its-trigger test checks that LPI 8195 is not delivered to the CPU while
it is disabled at the ITS level. After that it is re-enabled and the test
checks that the interrupt is properly asserted. After it's re-enabled and
before the stats are examined, the test triggers the interrupt again, which
can lead to the same interrupt being delivered twice: once after the
configuration invalidation and before the INT command, and once after the
INT command.

Add an explicit check that the interrupt has fired after the invalidation.
Leave the check after the INT command to make sure the INT command still
works for the now re-enabled LPI.

CC: Auger Eric <eric.auger@redhat.com>
Suggested-by: Zenghui Yu <yuzenghui@huawei.com>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arm/gic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arm/gic.c b/arm/gic.c
index af2c112336e7..8bc2a35908f2 100644
--- a/arm/gic.c
+++ b/arm/gic.c
@@ -802,6 +802,9 @@ static void test_its_trigger(void)
 
 	/* Now call the invall and check the LPI hits */
 	its_send_invall(col3);
+	lpi_stats_expect(3, 8195);
+	check_lpi_stats("dev2/eventid=20 pending LPI is received");
+
 	lpi_stats_expect(3, 8195);
 	its_send_int(dev2, 20);
 	check_lpi_stats("dev2/eventid=20 now triggers an LPI");
-- 
2.30.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
