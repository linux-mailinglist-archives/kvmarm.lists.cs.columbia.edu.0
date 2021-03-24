Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 584D7347AE7
	for <lists+kvmarm@lfdr.de>; Wed, 24 Mar 2021 15:39:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 964514B449;
	Wed, 24 Mar 2021 10:39:08 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u0kvQF-XTCRc; Wed, 24 Mar 2021 10:39:08 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 780474B2E9;
	Wed, 24 Mar 2021 10:39:07 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B58794B1D8
 for <kvmarm@lists.cs.columbia.edu>; Wed, 24 Mar 2021 10:39:05 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FA1bulSxXq7f for <kvmarm@lists.cs.columbia.edu>;
 Wed, 24 Mar 2021 10:39:04 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id CE2BB4B15F
 for <kvmarm@lists.cs.columbia.edu>; Wed, 24 Mar 2021 10:39:04 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E825E61A02;
 Wed, 24 Mar 2021 14:39:02 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=hot-poop.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1lP4ey-003XVd-Sy; Wed, 24 Mar 2021 14:39:01 +0000
From: Marc Zyngier <maz@kernel.org>
To: kvm@vger.kernel.org,
	kvmarm@lists.cs.columbia.edu
Subject: [kvm-unit-tests PATCH] arm: pmu: Fix failing PMU test when no PMU is
 available
Date: Wed, 24 Mar 2021 14:38:56 +0000
Message-Id: <20210324143856.2079220-1-maz@kernel.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
 pbonzini@redhat.com, drjones@redhat.com, eric.auger@redhat.com,
 alexandru.elisei@arm.com, qperret@google.com, kernel-team@android.com,
 qwandor@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Andrew Walbran <qwandor@google.com>, kernel-team@android.com,
 Paolo Bonzini <pbonzini@redhat.com>
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

The PMU unit tests fail with an UNDEF exception when no PMU
is available (although KVM hasn't been totally consistent
with that in the past).

This is caused by PMCR_EL0 being read *before* ID_AA64DFR0_EL1
is checked for the PMU version.

Move the PMCR_EL0 access to a reasonable place, which allows the
test to soft-fail gracefully.

Fixes: 784ee933fa5f ("arm: pmu: Introduce defines for PMU versions")
Reported-by: Andrew Walbran <qwandor@google.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arm/pmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arm/pmu.c b/arm/pmu.c
index cc959e6..15c542a 100644
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
2.30.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
