Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 39A6619E5B9
	for <lists+kvmarm@lfdr.de>; Sat,  4 Apr 2020 16:38:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E17CC4B219;
	Sat,  4 Apr 2020 10:38:28 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0aUlrDLyo6ZW; Sat,  4 Apr 2020 10:38:28 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8BC054B22A;
	Sat,  4 Apr 2020 10:38:27 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 610184B222
 for <kvmarm@lists.cs.columbia.edu>; Sat,  4 Apr 2020 10:38:25 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0E5ezNbHI6yM for <kvmarm@lists.cs.columbia.edu>;
 Sat,  4 Apr 2020 10:38:24 -0400 (EDT)
Received: from us-smtp-delivery-1.mimecast.com
 (us-smtp-delivery-1.mimecast.com [205.139.110.120])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7D4E94B223
 for <kvmarm@lists.cs.columbia.edu>; Sat,  4 Apr 2020 10:38:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586011104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QVuFrhT8TJhNSCuR94NxSXlIlj1+1lGH/d1K+jA+epw=;
 b=auP+C6mBQeEdV61AHrMcaSymW5IV9vkCFHf+KfOmMHq37/R6vKP14L0ddm1ERhIJA2XnlP
 kBnVnxgaXvFmaoxH4Vphn3z0diYAkLV9+ZZuEFRUjEBVESYbjJL/qz/b9kcqmIEdxBH/+Q
 E0dm4l3eLka4HYlaoItf/j+PMhWr4t4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-lLBibGidP72HqiBnmG9P-w-1; Sat, 04 Apr 2020 10:38:22 -0400
X-MC-Unique: lLBibGidP72HqiBnmG9P-w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B54318AB2D4;
 Sat,  4 Apr 2020 14:38:21 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 81CE71147D3;
 Sat,  4 Apr 2020 14:38:19 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: pbonzini@redhat.com
Subject: [PULL kvm-unit-tests 17/39] arm: pmu: Don't check PMCR.IMP anymore
Date: Sat,  4 Apr 2020 16:37:09 +0200
Message-Id: <20200404143731.208138-18-drjones@redhat.com>
In-Reply-To: <20200404143731.208138-1-drjones@redhat.com>
References: <20200404143731.208138-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org
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

From: Eric Auger <eric.auger@redhat.com>

check_pmcr() checks the IMP field is different than 0.
However A zero IMP field is permitted by the architecture,
meaning the MIDR_EL1 should be looked at instead. This
causes TCG to fail this test on '-cpu max' because in
that case PMCR.IMP is set equal to MIDR_EL1.Implementer
which is 0.

So let's remove the check_pmcr() test and just print PMCR
info in the pmu_probe() function.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 arm/pmu.c | 39 ++++++++++++++-------------------------
 1 file changed, 14 insertions(+), 25 deletions(-)

diff --git a/arm/pmu.c b/arm/pmu.c
index 0122f0a8a8a9..44f3543cfa49 100644
--- a/arm/pmu.c
+++ b/arm/pmu.c
@@ -134,29 +134,6 @@ static inline void precise_instrs_loop(int loop, uint32_t pmcr)
 }
 #endif
 
-/*
- * As a simple sanity check on the PMCR_EL0, ensure the implementer field isn't
- * null. Also print out a couple other interesting fields for diagnostic
- * purposes. For example, as of fall 2016, QEMU TCG mode doesn't implement
- * event counters and therefore reports zero event counters, but hopefully
- * support for at least the instructions event will be added in the future and
- * the reported number of event counters will become nonzero.
- */
-static bool check_pmcr(void)
-{
-	uint32_t pmcr;
-
-	pmcr = get_pmcr();
-
-	report_info("PMU implementer/ID code/counters: %#x(\"%c\")/%#x/%d",
-		    (pmcr >> PMU_PMCR_IMP_SHIFT) & PMU_PMCR_IMP_MASK,
-		    ((pmcr >> PMU_PMCR_IMP_SHIFT) & PMU_PMCR_IMP_MASK) ? : ' ',
-		    (pmcr >> PMU_PMCR_ID_SHIFT) & PMU_PMCR_ID_MASK,
-		    (pmcr >> PMU_PMCR_N_SHIFT) & PMU_PMCR_N_MASK);
-
-	return ((pmcr >> PMU_PMCR_IMP_SHIFT) & PMU_PMCR_IMP_MASK) != 0;
-}
-
 /*
  * Ensure that the cycle counter progresses between back-to-back reads.
  */
@@ -278,9 +255,22 @@ static void pmccntr64_test(void)
 /* Return FALSE if no PMU found, otherwise return TRUE */
 static bool pmu_probe(void)
 {
+	uint32_t pmcr;
+
 	pmu_version = get_pmu_version();
+	if (pmu_version == 0 || pmu_version == 0xf)
+		return false;
+
 	report_info("PMU version: %d", pmu_version);
-	return pmu_version != 0 && pmu_version != 0xf;
+
+	pmcr = get_pmcr();
+	report_info("PMU implementer/ID code/counters: %#x(\"%c\")/%#x/%d",
+		    (pmcr >> PMU_PMCR_IMP_SHIFT) & PMU_PMCR_IMP_MASK,
+		    ((pmcr >> PMU_PMCR_IMP_SHIFT) & PMU_PMCR_IMP_MASK) ? : ' ',
+		    (pmcr >> PMU_PMCR_ID_SHIFT) & PMU_PMCR_ID_MASK,
+		    (pmcr >> PMU_PMCR_N_SHIFT) & PMU_PMCR_N_MASK);
+
+	return true;
 }
 
 int main(int argc, char *argv[])
@@ -301,7 +291,6 @@ int main(int argc, char *argv[])
 		report_prefix_push(argv[1]);
 		if (argc > 2)
 			cpi = atol(argv[2]);
-		report(check_pmcr(), "Control register");
 		report(check_cycles_increase(),
 		       "Monotonically increasing cycle count");
 		report(check_cpi(cpi), "Cycle/instruction ratio");
-- 
2.25.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
