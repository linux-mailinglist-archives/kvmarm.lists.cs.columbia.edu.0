Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 57865F4E6F
	for <lists+kvmarm@lfdr.de>; Fri,  8 Nov 2019 15:43:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EC59F4AC70;
	Fri,  8 Nov 2019 09:43:01 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BTam3xRlJIrk; Fri,  8 Nov 2019 09:43:01 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F07E94AEE2;
	Fri,  8 Nov 2019 09:42:57 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 436604AECB
 for <kvmarm@lists.cs.columbia.edu>; Fri,  8 Nov 2019 09:42:57 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OWlO0ARHRrCJ for <kvmarm@lists.cs.columbia.edu>;
 Fri,  8 Nov 2019 09:42:56 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 225934AEC9
 for <kvmarm@lists.cs.columbia.edu>; Fri,  8 Nov 2019 09:42:56 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D844446A;
 Fri,  8 Nov 2019 06:42:55 -0800 (PST)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.197.44])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB2813F719;
 Fri,  8 Nov 2019 06:42:54 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Andrew Jones <drjones@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [kvm-unit-tests PATCH 04/17] arm: gic: Support no IRQs test case
Date: Fri,  8 Nov 2019 14:42:27 +0000
Message-Id: <20191108144240.204202-5-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191108144240.204202-1-andre.przywara@arm.com>
References: <20191108144240.204202-1-andre.przywara@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org
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

For some tests it would be important to check that an IRQ was *not*
triggered, for instance to test certain masking operations.

Extend the check_added() function to recognise an empty cpumask to
detect this situation. The timeout duration is reduced, and the "no IRQs
triggered" case is actually reported as a success in this case.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arm/gic.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arm/gic.c b/arm/gic.c
index a114009..eca9188 100644
--- a/arm/gic.c
+++ b/arm/gic.c
@@ -66,9 +66,10 @@ static void check_acked(const char *testname, cpumask_t *mask)
 	int missing = 0, extra = 0, unexpected = 0;
 	int nr_pass, cpu, i;
 	bool bad = false;
+	bool noirqs = cpumask_empty(mask);
 
 	/* Wait up to 5s for all interrupts to be delivered */
-	for (i = 0; i < 50; ++i) {
+	for (i = 0; i < (noirqs ? 15 : 50); ++i) {
 		mdelay(100);
 		nr_pass = 0;
 		for_each_present_cpu(cpu) {
@@ -88,7 +89,7 @@ static void check_acked(const char *testname, cpumask_t *mask)
 				bad = true;
 			}
 		}
-		if (nr_pass == nr_cpus) {
+		if (!noirqs && nr_pass == nr_cpus) {
 			report("%s", !bad, testname);
 			if (i)
 				report_info("took more than %d ms", i * 100);
@@ -96,6 +97,11 @@ static void check_acked(const char *testname, cpumask_t *mask)
 		}
 	}
 
+	if (noirqs && nr_pass == nr_cpus) {
+		report("%s", !bad, testname);
+		return;
+	}
+
 	for_each_present_cpu(cpu) {
 		if (cpumask_test_cpu(cpu, mask)) {
 			if (!acked[cpu])
-- 
2.17.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
