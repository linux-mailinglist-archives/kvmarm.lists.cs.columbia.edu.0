Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 24F3B18353C
	for <lists+kvmarm@lfdr.de>; Thu, 12 Mar 2020 16:44:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CC2144AEEC;
	Thu, 12 Mar 2020 11:44:18 -0400 (EDT)
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
	with ESMTP id IXBkhNuZ9tZu; Thu, 12 Mar 2020 11:44:18 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8D8F14AEDF;
	Thu, 12 Mar 2020 11:44:17 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B74AE4A50F
 for <kvmarm@lists.cs.columbia.edu>; Thu, 12 Mar 2020 11:44:16 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gf8v+W+RdtCW for <kvmarm@lists.cs.columbia.edu>;
 Thu, 12 Mar 2020 11:44:15 -0400 (EDT)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BAED04A578
 for <kvmarm@lists.cs.columbia.edu>; Thu, 12 Mar 2020 11:44:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584027855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cuxQzZymJ+j/hsy41QQY4o/LcnKvlePF7LiNjbaBNOQ=;
 b=RIRiZ34yCqonrcx9EDEdHKKZEan5DKrDVPewIEProO1cnWdqDZDjogBbeRW84UCUMVZskY
 YA1U5X8wIRDUp2+RGw4JXGiJezxixHGLBLYo4Cv10pCLbWzjSTCsDZCDmJRhw4hPtpIWld
 kj4r6Avy+qSSQkAJiGvML8zc8hxbbkY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-AJPpjciKMoi2g3raFBCVRw-1; Thu, 12 Mar 2020 11:44:12 -0400
X-MC-Unique: AJPpjciKMoi2g3raFBCVRw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45DBE8A20D0;
 Thu, 12 Mar 2020 15:44:10 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.36.118.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 953935C1D8;
 Thu, 12 Mar 2020 15:43:59 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, maz@kernel.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Subject: [kvm-unit-tests PATCH v3 06/12] arm: pmu: Check Required Event Support
Date: Thu, 12 Mar 2020 16:42:55 +0100
Message-Id: <20200312154301.9130-7-eric.auger@redhat.com>
In-Reply-To: <20200312154301.9130-1-eric.auger@redhat.com>
References: <20200312154301.9130-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: andrew.murray@arm.com, andre.przywara@arm.com
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

If event counters are implemented check the common events
required by the PMUv3 are implemented.

Some are unconditionally required (SW_INCR, CPU_CYCLES,
either INST_RETIRED or INST_SPEC). Some others only are
required if the implementation implements some other features.

Check those wich are unconditionally required.

This test currently fails on TCG as neither INST_RETIRED
or INST_SPEC are supported.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v2 -> v3:
- use 0x%x instead %d in trace
- pmu.version >= ID_DFR0_PMU_v3_8_1
- added prefix pop
- assert instead of abort, inverse assert and test
- add defines for used events and common events
- given the changes I did not apply Andre's R-b
- introduce and use upper_32_bits()/lower_32_bits()
- added pmu prefix to the test name

v1 -> v2:
- fix is_event_supported()
- fix boolean condition for PMU v4
- fix PMCEID0 definition

RFC ->v1:
- add a comment to explain the PMCEID0/1 splits
---
 arm/pmu.c         | 77 +++++++++++++++++++++++++++++++++++++++++++++++
 arm/unittests.cfg |  6 ++++
 lib/bitops.h      |  3 ++
 3 files changed, 86 insertions(+)

diff --git a/arm/pmu.c b/arm/pmu.c
index a04588a..8c49e50 100644
--- a/arm/pmu.c
+++ b/arm/pmu.c
@@ -18,6 +18,7 @@
 #include "asm/barrier.h"
 #include "asm/sysreg.h"
 #include "asm/processor.h"
+#include <bitops.h>
 
 #define PMU_PMCR_E         (1 << 0)
 #define PMU_PMCR_C         (1 << 2)
@@ -33,6 +34,19 @@
 
 #define NR_SAMPLES 10
 
+/* Some PMU events */
+#define SW_INCR			0x0
+#define INST_RETIRED		0x8
+#define CPU_CYCLES		0x11
+#define INST_PREC		0x1B
+#define STALL_FRONTEND		0x23
+#define STALL_BACKEND		0x24
+
+#define COMMON_EVENTS_LOW	0x0
+#define COMMON_EVENTS_HIGH	0x3F
+#define EXT_COMMON_EVENTS_LOW	0x4000
+#define EXT_COMMON_EVENTS_HIGH	0x403F
+
 struct pmu {
 	unsigned int version;
 	unsigned int nb_implemented_counters;
@@ -110,6 +124,10 @@ static inline void precise_instrs_loop(int loop, uint32_t pmcr)
 	: [pmcr] "r" (pmcr), [z] "r" (0)
 	: "cc");
 }
+
+/* event counter tests only implemented for aarch64 */
+static void test_event_introspection(void) {}
+
 #elif defined(__aarch64__)
 #define ID_AA64DFR0_PERFMON_SHIFT 8
 #define ID_AA64DFR0_PERFMON_MASK  0xf
@@ -155,6 +173,61 @@ static inline void precise_instrs_loop(int loop, uint32_t pmcr)
 	: [pmcr] "r" (pmcr)
 	: "cc");
 }
+
+#define PMCEID1_EL0 sys_reg(3, 3, 9, 12, 7)
+
+static bool is_event_supported(uint32_t n, bool warn)
+{
+	uint64_t pmceid0 = read_sysreg(pmceid0_el0);
+	uint64_t pmceid1 = read_sysreg_s(PMCEID1_EL0);
+	bool supported;
+	uint64_t reg;
+
+	/*
+	 * The low 32-bits of PMCEID0/1 respectively describe
+	 * event support for events 0-31/32-63. Their High
+	 * 32-bits describe support for extended events
+	 * starting at 0x4000, using the same split.
+	 */
+	assert((n >= COMMON_EVENTS_LOW  && n <= COMMON_EVENTS_HIGH) ||
+	       (n >= EXT_COMMON_EVENTS_LOW && n <= EXT_COMMON_EVENTS_HIGH));
+
+	if (n <= COMMON_EVENTS_HIGH)
+		reg = lower_32_bits(pmceid0) | ((u64)lower_32_bits(pmceid1) << 32);
+	else
+		reg = upper_32_bits(pmceid0) | ((u64)upper_32_bits(pmceid1) << 32);
+
+	supported =  reg & (1UL << (n & 0x3F));
+
+	if (!supported && warn)
+		report_info("event 0x%x is not supported", n);
+	return supported;
+}
+
+static void test_event_introspection(void)
+{
+	bool required_events;
+
+	if (!pmu.nb_implemented_counters) {
+		report_skip("No event counter, skip ...");
+		return;
+	}
+
+	/* PMUv3 requires an implementation includes some common events */
+	required_events = is_event_supported(SW_INCR, true) &&
+			  is_event_supported(CPU_CYCLES, true) &&
+			  (is_event_supported(INST_RETIRED, true) ||
+			   is_event_supported(INST_PREC, true));
+
+	if (pmu.version >= ID_DFR0_PMU_V3_8_1) {
+		required_events = required_events &&
+				  is_event_supported(STALL_FRONTEND, true) &&
+				  is_event_supported(STALL_BACKEND, true);
+	}
+
+	report(required_events, "Check required events are implemented");
+}
+
 #endif
 
 /*
@@ -325,6 +398,10 @@ int main(int argc, char *argv[])
 		report(check_cpi(cpi), "Cycle/instruction ratio");
 		pmccntr64_test();
 		report_prefix_pop();
+	} else if (strcmp(argv[1], "pmu-event-introspection") == 0) {
+		report_prefix_push(argv[1]);
+		test_event_introspection();
+		report_prefix_pop();
 	} else {
 		report_abort("Unknown sub-test '%s'", argv[1]);
 	}
diff --git a/arm/unittests.cfg b/arm/unittests.cfg
index fe6515c..f993548 100644
--- a/arm/unittests.cfg
+++ b/arm/unittests.cfg
@@ -66,6 +66,12 @@ file = pmu.flat
 groups = pmu
 extra_params = -append 'cycle-counter 0'
 
+[pmu-event-introspection]
+file = pmu.flat
+groups = pmu
+arch = arm64
+extra_params = -append 'pmu-event-introspection'
+
 # Test PMU support (TCG) with -icount IPC=1
 #[pmu-tcg-icount-1]
 #file = pmu.flat
diff --git a/lib/bitops.h b/lib/bitops.h
index 636064c..b310a22 100644
--- a/lib/bitops.h
+++ b/lib/bitops.h
@@ -33,6 +33,9 @@
 #define GENMASK_ULL(h, l) \
 	(((~0ULL) << (l)) & (~0ULL >> (BITS_PER_LONG_LONG - 1 - (h))))
 
+#define upper_32_bits(n) ((u32)(((n) >> 16) >> 16))
+#define lower_32_bits(n) ((u32)(n))
+
 #ifndef HAVE_BUILTIN_FLS
 static inline unsigned long fls(unsigned long word)
 {
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
