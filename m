Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 463B9C2326
	for <lists+kvmarm@lfdr.de>; Mon, 30 Sep 2019 16:25:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EFF0B4A7E1;
	Mon, 30 Sep 2019 10:25:23 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uunErV6Puav3; Mon, 30 Sep 2019 10:25:22 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C4C834A7F1;
	Mon, 30 Sep 2019 10:25:21 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D7DE24A7ED
 for <kvmarm@lists.cs.columbia.edu>; Mon, 30 Sep 2019 10:25:20 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kXmrGxF7UnL6 for <kvmarm@lists.cs.columbia.edu>;
 Mon, 30 Sep 2019 10:25:19 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 713684A703
 for <kvmarm@lists.cs.columbia.edu>; Mon, 30 Sep 2019 10:25:19 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 304AD15A2;
 Mon, 30 Sep 2019 07:25:19 -0700 (PDT)
Received: from e123195-lin.cambridge.arm.com (e123195-lin.cambridge.arm.com
 [10.1.196.63])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2AFAE3F706;
 Mon, 30 Sep 2019 07:25:18 -0700 (PDT)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: kvm@vger.kernel.org,
	kvmarm@lists.cs.columbia.edu
Subject: [kvm-unit-tests PATCH 3/3] arm64: Add cache code generation test
Date: Mon, 30 Sep 2019 15:25:08 +0100
Message-Id: <20190930142508.25102-4-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190930142508.25102-1-alexandru.elisei@arm.com>
References: <20190930142508.25102-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
Cc: pbonzini@redhat.com, andre.przywara@arm.com, maz@kernel.org
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

Caches are a misterious creature on arm64, requiring a more hands-on
approach from the programmer than on x86. When generating code, two cache
maintenance operations are generally required: an invalidation for the
stale instruction and a clean to the PoU (Point of Unification) for the new
instruction. Fortunately, the ARM architecture has features to alleviate
some of this overhead, which are advertised via the IDC and DIC bits in
CTR_EL0: if IDC is 1, then the dcache clean is not required, and if DIC is
1, the icache invalidation can be absent. KVM exposes these bits to the
guest.

Until Linux v4.16.1, KVM performed an icache invalidation each time a stage
2 page was mapped. This was then optimized so that the icache invalidation
was performed when the guest tried to execute code from the page for the
first time. And that was optimized again when support for the DIC bit was
added to KVM.

The interactions between a guest that is generating code, the stage 2
tables and the IDC and DIC bits can be subtle, especially when KVM
optimizations come into play. Let's add a test that generates a few
instructions and checks that KVM indeed honors those bits.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arm/Makefile.arm64 |   1 +
 arm/cache.c        | 122 +++++++++++++++++++++++++++++++++++++++++++++
 arm/unittests.cfg  |   6 +++
 3 files changed, 129 insertions(+)
 create mode 100644 arm/cache.c

diff --git a/arm/Makefile.arm64 b/arm/Makefile.arm64
index 35de5ea333b4..6d3dc2c4a464 100644
--- a/arm/Makefile.arm64
+++ b/arm/Makefile.arm64
@@ -25,6 +25,7 @@ OBJDIRS += lib/arm64
 # arm64 specific tests
 tests = $(TEST_DIR)/timer.flat
 tests += $(TEST_DIR)/micro-bench.flat
+tests += $(TEST_DIR)/cache.flat
 
 include $(SRCDIR)/$(TEST_DIR)/Makefile.common
 
diff --git a/arm/cache.c b/arm/cache.c
new file mode 100644
index 000000000000..2939b85a8c9a
--- /dev/null
+++ b/arm/cache.c
@@ -0,0 +1,122 @@
+#include <libcflat.h>
+#include <alloc_page.h>
+#include <asm/mmu.h>
+#include <asm/processor.h>
+
+#define NTIMES			(1 << 16)
+
+#define CTR_DIC			(1UL << 29)
+#define CTR_IDC			(1UL << 28)
+
+#define CLIDR_LOC_SHIFT		24
+#define CLIDR_LOC_MASK		(7UL << CLIDR_LOC_SHIFT)
+#define CLIDR_LOUU_SHIFT	27
+#define CLIDR_LOUU_MASK		(7UL << CLIDR_LOUU_SHIFT)
+#define CLIDR_LOUIS_SHIFT	21
+#define CLIDR_LOUIS_MASK	(7UL << CLIDR_LOUIS_SHIFT)
+
+#define RET			0xd65f03c0
+#define MOV_X0(x)		(0xd2800000 | (((x) & 0xffff) << 5))
+
+#define clean_dcache_pou(addr)			\
+	asm volatile("dc cvau, %0\n" :: "r" (addr) : "memory")
+#define inval_icache_pou(addr)			\
+	asm volatile("ic ivau, %0\n" :: "r" (addr) : "memory")
+
+typedef int (*fn_t)(void);
+
+static inline void prime_icache(u32 *code, u32 insn)
+{
+	*code = insn;
+	/* This is the sequence recommended in ARM DDI 0487E.a, page B2-136. */
+	clean_dcache_pou(code);
+	dsb(ish);
+	inval_icache_pou(code);
+	dsb(ish);
+	isb();
+
+	((fn_t)code)();
+}
+
+static void check_code_generation(bool dcache_clean, bool icache_inval)
+{
+	u32 fn[] = {MOV_X0(0x42), RET};
+	u32 *code = alloc_page();
+	unsigned long sctlr;
+	int i, ret;
+	bool success;
+
+	/* Make sure we can execute from a writable page */
+	mmu_clear_user((unsigned long)code);
+
+	sctlr = read_sysreg(sctlr_el1);
+	if (sctlr & SCTLR_EL1_WXN) {
+		sctlr &= ~SCTLR_EL1_WXN;
+		write_sysreg(sctlr, sctlr_el1);
+		isb();
+		/* SCTLR_EL1.WXN is permitted to be cached in a TLB. */
+		flush_tlb_all();
+	}
+
+	for (i = 0; i < ARRAY_SIZE(fn); i++) {
+		*(code + i) = fn[i];
+		clean_dcache_pou(code + i);
+		dsb(ish);
+		inval_icache_pou(code + i);
+	}
+	dsb(ish);
+	isb();
+
+	/* Sanity check */
+	((fn_t)code)();
+
+	success = true;
+	for (i = 0; i < NTIMES; i++) {
+		prime_icache(code, MOV_X0(0x42));
+		*code = MOV_X0(0x66);
+		if (dcache_clean)
+			clean_dcache_pou(code);
+		if (icache_inval) {
+			if (dcache_clean)
+				dsb(ish);
+			inval_icache_pou(code);
+		}
+		dsb(ish);
+		isb();
+
+		ret = ((fn_t)code)();
+		success &= (ret == 0x66);
+	}
+
+	report("code generation", success);
+}
+
+int main(int argc, char **argv)
+{
+	u64 ctr, clidr;
+	bool dcache_clean, icache_inval;
+
+	report_prefix_push("IDC-DIC");
+
+	ctr = read_sysreg(ctr_el0);
+	dcache_clean = !(ctr & CTR_IDC);
+	icache_inval = !(ctr & CTR_DIC);
+
+	if (dcache_clean) {
+		clidr = read_sysreg(clidr_el1);
+		if ((clidr & CLIDR_LOC_MASK) == 0)
+			dcache_clean = false;
+		if ((clidr & CLIDR_LOUU_MASK) == 0 &&
+		    (clidr & CLIDR_LOUIS_MASK) == 0)
+			dcache_clean = false;
+	}
+
+	if (dcache_clean)
+		report_info("dcache clean to PoU required");
+	if (icache_inval)
+		report_info("icache invalidation to PoU required");
+
+	check_code_generation(dcache_clean, icache_inval);
+
+	return report_summary();
+}
diff --git a/arm/unittests.cfg b/arm/unittests.cfg
index 6d3df92a4e28..37f07788c5f0 100644
--- a/arm/unittests.cfg
+++ b/arm/unittests.cfg
@@ -142,3 +142,9 @@ smp = 2
 groups = nodefault,micro-bench
 accel = kvm
 arch = arm64
+
+# Cache emulation tests
+[cache]
+file = cache.flat
+arch = arm64
+group = cache
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
