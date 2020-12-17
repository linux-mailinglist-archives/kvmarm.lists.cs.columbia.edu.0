Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 49AAA2DD0FA
	for <lists+kvmarm@lfdr.de>; Thu, 17 Dec 2020 13:01:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F215C4B28F;
	Thu, 17 Dec 2020 07:01:13 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JhVREy3ytbmA; Thu, 17 Dec 2020 07:01:13 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 656874B240;
	Thu, 17 Dec 2020 07:01:12 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 15C504B201
 for <kvmarm@lists.cs.columbia.edu>; Thu, 17 Dec 2020 07:01:11 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aeFp+LfqYBI9 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 17 Dec 2020 07:01:09 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E45EE4B23B
 for <kvmarm@lists.cs.columbia.edu>; Thu, 17 Dec 2020 07:01:09 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70D84101E;
 Thu, 17 Dec 2020 04:01:09 -0800 (PST)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D539F3F66B;
 Thu, 17 Dec 2020 04:01:08 -0800 (PST)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: drjones@redhat.com,
	kvm@vger.kernel.org,
	kvmarm@lists.cs.columbia.edu
Subject: [kvm-unit-tests PATCH 1/1] arm: pmu: Don't read PMCR if PMU is not
 present
Date: Thu, 17 Dec 2020 12:00:57 +0000
Message-Id: <20201217120057.88562-2-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201217120057.88562-1-alexandru.elisei@arm.com>
References: <20201217120057.88562-1-alexandru.elisei@arm.com>
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

For arm and arm64, the PMU is an optional part of the architecture.
According to ARM DDI 0487F.b, page D13-3683, accessing PMCR_EL0 when the
PMU is not present generates an undefined exception (one would assume that
this is also true for arm).

The pmu_probe() function reads the register before checking that a PMU is
present, so defer accessing PMCR_EL0 until after we know that it is safe.

This hasn't been a problem so far because there's no hardware in the wild
without a PMU and KVM, contrary to the architecture, has treated the PMU
registers as RAZ/WI if the VCPU doesn't have the PMU feature. However,
that's about to change as KVM will start treating the registers as
undefined when the guest doesn't have a PMU.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arm/pmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arm/pmu.c b/arm/pmu.c
index cc959e6a5c76..15c542a230ea 100644
--- a/arm/pmu.c
+++ b/arm/pmu.c
@@ -988,7 +988,7 @@ static void pmccntr64_test(void)
 /* Return FALSE if no PMU found, otherwise return TRUE */
 static bool pmu_probe(void)
 {
-	uint32_t pmcr = get_pmcr();
+	uint32_t pmcr;
 	uint8_t implementer;
 
 	pmu.version = get_pmu_version();
@@ -997,6 +997,7 @@ static bool pmu_probe(void)
 
 	report_info("PMU version: 0x%x", pmu.version);
 
+	pmcr = get_pmcr();
 	implementer = (pmcr >> PMU_PMCR_IMP_SHIFT) & PMU_PMCR_IMP_MASK;
 	report_info("PMU implementer/ID code: %#"PRIx32"(\"%c\")/%#"PRIx32,
 		    (pmcr >> PMU_PMCR_IMP_SHIFT) & PMU_PMCR_IMP_MASK,
-- 
2.29.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
