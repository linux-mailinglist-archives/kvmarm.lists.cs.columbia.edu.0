Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2C51A121B15
	for <lists+kvmarm@lfdr.de>; Mon, 16 Dec 2019 21:48:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D48AB4A982;
	Mon, 16 Dec 2019 15:48:25 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.391
X-Spam-Level: 
X-Spam-Status: No, score=-1.391 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AX19z0d7IIcG; Mon, 16 Dec 2019 15:48:25 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D8D534A94D;
	Mon, 16 Dec 2019 15:48:24 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8418F4A5A6
 for <kvmarm@lists.cs.columbia.edu>; Mon, 16 Dec 2019 15:48:23 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rwiH-gFRYmir for <kvmarm@lists.cs.columbia.edu>;
 Mon, 16 Dec 2019 15:48:22 -0500 (EST)
Received: from us-smtp-1.mimecast.com (us-smtp-1.mimecast.com [207.211.31.81])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8AAB54A95B
 for <kvmarm@lists.cs.columbia.edu>; Mon, 16 Dec 2019 15:48:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576529302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dznikfzn+n4WX4926tiKNygB6iX1YlaEs/0YdUiJxdA=;
 b=FzPSZZR3GUMf2K+z7Zw2QA5KFlhZJiyH/IcqTvVNehhY9SmFu61xIaVkaBlz9BGZi4VQOS
 RO6BNVdTvkn4RcVTPcTnsMb5IEjMGRVpD53OqjHJaV3023SCSb8qG4NgHASfusH6BOI+pR
 YfSGTATomzPNvOat6DcdIj4NRxJukRc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-ZsCK1exoNFqIWFgq7Whmzw-1; Mon, 16 Dec 2019 15:48:20 -0500
X-MC-Unique: ZsCK1exoNFqIWFgq7Whmzw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D5B28E10CF;
 Mon, 16 Dec 2019 20:48:18 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-117.ams2.redhat.com [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B9BA65D9C9;
 Mon, 16 Dec 2019 20:48:15 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, maz@kernel.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Subject: [kvm-unit-tests PATCH 03/10] arm: pmu: Add a pmu struct
Date: Mon, 16 Dec 2019 21:47:50 +0100
Message-Id: <20191216204757.4020-4-eric.auger@redhat.com>
In-Reply-To: <20191216204757.4020-1-eric.auger@redhat.com>
References: <20191216204757.4020-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

This struct aims at storing information potentially used by
all tests such as the pmu version, the read-only part of the
PMCR, the number of implemented event counters, ...

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 arm/pmu.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/arm/pmu.c b/arm/pmu.c
index e5e012d..d24857e 100644
--- a/arm/pmu.c
+++ b/arm/pmu.c
@@ -33,7 +33,14 @@
 
 #define NR_SAMPLES 10
 
-static unsigned int pmu_version;
+struct pmu {
+	unsigned int version;
+	unsigned int nb_implemented_counters;
+	uint32_t pmcr_ro;
+};
+
+static struct pmu pmu;
+
 #if defined(__arm__)
 #define ID_DFR0_PERFMON_SHIFT 24
 #define ID_DFR0_PERFMON_MASK  0xf
@@ -265,7 +272,7 @@ static bool check_cpi(int cpi)
 static void pmccntr64_test(void)
 {
 #ifdef __arm__
-	if (pmu_version == 0x3) {
+	if (pmu.version == 0x3) {
 		if (ERRATA(9e3f7a296940)) {
 			write_sysreg(0xdead, PMCCNTR64);
 			report(read_sysreg(PMCCNTR64) == 0xdead, "pmccntr64");
@@ -278,9 +285,22 @@ static void pmccntr64_test(void)
 /* Return FALSE if no PMU found, otherwise return TRUE */
 static bool pmu_probe(void)
 {
-	pmu_version = get_pmu_version();
-	report_info("PMU version: %d", pmu_version);
-	return pmu_version != 0 && pmu_version != 0xf;
+	uint32_t pmcr;
+
+	pmu.version = get_pmu_version();
+	report_info("PMU version: %d", pmu.version);
+
+	if (pmu.version == 0 || pmu.version == 0xF)
+		return false;
+
+	pmcr = get_pmcr();
+	pmu.pmcr_ro = pmcr & 0xFFFFFF80;
+	pmu.nb_implemented_counters =
+		(pmcr >> PMU_PMCR_N_SHIFT) & PMU_PMCR_N_MASK;
+	report_info("Implements %d event counters",
+		    pmu.nb_implemented_counters);
+
+	return true;
 }
 
 int main(int argc, char *argv[])
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
