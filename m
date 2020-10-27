Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8B129C0B9
	for <lists+kvmarm@lfdr.de>; Tue, 27 Oct 2020 18:19:06 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C229B4B39B;
	Tue, 27 Oct 2020 13:19:05 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9ZRkS9No3jTj; Tue, 27 Oct 2020 13:19:04 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2F5324B4B3;
	Tue, 27 Oct 2020 13:19:04 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8811C4B257
 for <kvmarm@lists.cs.columbia.edu>; Tue, 27 Oct 2020 13:19:03 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vqWvlbIZ2i2O for <kvmarm@lists.cs.columbia.edu>;
 Tue, 27 Oct 2020 13:19:02 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1D3D44B4B7
 for <kvmarm@lists.cs.columbia.edu>; Tue, 27 Oct 2020 13:19:02 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE6C8139F;
 Tue, 27 Oct 2020 10:19:00 -0700 (PDT)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9DB1C3F719;
 Tue, 27 Oct 2020 10:18:57 -0700 (PDT)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: kvm@vger.kernel.org,
	kvmarm@lists.cs.columbia.edu
Subject: [kvm-unit-tests RFC PATCH v2 3/5] arm64: spe: Add introspection test
Date: Tue, 27 Oct 2020 17:19:42 +0000
Message-Id: <20201027171944.13933-4-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201027171944.13933-1-alexandru.elisei@arm.com>
References: <20201027171944.13933-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
Cc: pbonzini@redhat.com
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

Probe the DTB and the ID registers to get information about SPE, then
compare the register fields with the valid values as defined by ARM DDI
0487F.b.

SPE is supported only on AArch64, so make the test exclusive to the
arm64 architecture.

[ Alexandru E: Removed aarch32 compilation support, added DTB probing,
	reworded commit, mostly cosmetic changes to the code ]

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arm/Makefile.arm64 |   1 +
 lib/libcflat.h     |   1 +
 arm/spe.c          | 172 +++++++++++++++++++++++++++++++++++++++++++++
 arm/unittests.cfg  |   7 ++
 4 files changed, 181 insertions(+)
 create mode 100644 arm/spe.c

diff --git a/arm/Makefile.arm64 b/arm/Makefile.arm64
index dbc7524d3070..94b9c63f0b05 100644
--- a/arm/Makefile.arm64
+++ b/arm/Makefile.arm64
@@ -30,6 +30,7 @@ OBJDIRS += lib/arm64
 tests = $(TEST_DIR)/timer.flat
 tests += $(TEST_DIR)/micro-bench.flat
 tests += $(TEST_DIR)/cache.flat
+tests += $(TEST_DIR)/spe.flat
 
 include $(SRCDIR)/$(TEST_DIR)/Makefile.common
 
diff --git a/lib/libcflat.h b/lib/libcflat.h
index ec0f58b05701..37550c99ffb6 100644
--- a/lib/libcflat.h
+++ b/lib/libcflat.h
@@ -37,6 +37,7 @@
 #define IS_ALIGNED(x, a)	(((x) & ((typeof(x))(a) - 1)) == 0)
 
 #define SZ_256			(1 << 8)
+#define SZ_2K			(1 << 11)
 #define SZ_4K			(1 << 12)
 #define SZ_8K			(1 << 13)
 #define SZ_16K			(1 << 14)
diff --git a/arm/spe.c b/arm/spe.c
new file mode 100644
index 000000000000..c199cd239194
--- /dev/null
+++ b/arm/spe.c
@@ -0,0 +1,172 @@
+/*
+ * Copyright (C) 2020, Red Hat Inc, Eric Auger <eric.auger@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU Lesser General Public License version 2.1 and
+ * only version 2.1 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License
+ * for more details.
+ */
+#include <stdint.h>
+
+#include <bitops.h>
+#include <devicetree.h>
+#include <libcflat.h>
+
+#include <asm/gic.h>
+#include <asm/processor.h>
+#include <asm/sysreg.h>
+
+#define ID_AA64DFR0_PMSVER_SHIFT	32
+#define ID_AA64DFR0_PMSVER_MASK		0xf
+
+#define SYS_PMBIDR_EL1			sys_reg(3, 0, 9, 10, 7)
+#define SYS_PMBIDR_EL1_F_SHIFT		5
+#define SYS_PMBIDR_EL1_P_SHIFT		4
+#define SYS_PMBIDR_EL1_ALIGN_MASK	0xfUL
+#define SYS_PMBIDR_EL1_ALIGN_SHIFT	0
+
+#define SYS_PMSIDR_EL1			sys_reg(3, 0, 9, 9, 7)
+#define SYS_PMSIDR_EL1_FE_SHIFT		0
+#define SYS_PMSIDR_EL1_FT_SHIFT		1
+#define SYS_PMSIDR_EL1_FL_SHIFT		2
+#define SYS_PMSIDR_EL1_INTERVAL_SHIFT	8
+#define SYS_PMSIDR_EL1_INTERVAL_MASK	0xfUL
+#define SYS_PMSIDR_EL1_MAXSIZE_SHIFT	12
+#define SYS_PMSIDR_EL1_MAXSIZE_MASK	0xfUL
+#define SYS_PMSIDR_EL1_MAXSIZE_MASK	0xfUL
+#define SYS_PMSIDR_EL1_COUNTSIZE_SHIFT	16
+#define SYS_PMSIDR_EL1_COUNTSIZE_MASK	0xfUL
+
+struct spe {
+	uint32_t intid;
+	int min_interval;
+	int max_record_size;
+	int countsize;
+	bool fl_cap;
+	bool ft_cap;
+	bool fe_cap;
+	int align;
+};
+static struct spe spe;
+
+static int spe_min_interval(uint8_t interval)
+{
+	switch (interval) {
+	case 0x0:
+		return 256;
+	case 0x2:
+		return 512;
+	case 0x3:
+		return 768;
+	case 0x4:
+		return 1024;
+	case 0x5:
+		return 1536;
+	case 0x6:
+		return 2048;
+	case 0x7:
+		return 3072;
+	case 0x8:
+		return 4096;
+	default:
+		return 0;
+	}
+}
+
+static bool spe_probe(void)
+{
+	const struct fdt_property *prop;
+	const void *fdt = dt_fdt();
+	int node, len;
+	uint32_t *data;
+	uint64_t pmbidr, pmsidr;
+	uint64_t aa64dfr0 = get_id_aa64dfr0();
+	uint8_t pmsver, interval;
+
+	node = fdt_node_offset_by_compatible(fdt, -1, "arm,statistical-profiling-extension-v1");
+	assert(node >= 0);
+	prop = fdt_get_property(fdt, node, "interrupts", &len);
+	assert(prop && len == 3 * sizeof(u32));
+
+	data = (u32 *)prop->data;
+	/* SPE interrupt is required to be a PPI. */
+	assert(fdt32_to_cpu(data[0]) == 1);
+	spe.intid = fdt32_to_cpu(data[1]);
+
+	pmsver = (aa64dfr0 >> ID_AA64DFR0_PMSVER_SHIFT) & ID_AA64DFR0_PMSVER_MASK;
+	if (!pmsver || pmsver > 2) {
+		report_info("Unknown SPE version: 0x%x", pmsver);
+		return false;
+	}
+
+	pmbidr = read_sysreg_s(SYS_PMBIDR_EL1);
+	if (pmbidr & BIT(SYS_PMBIDR_EL1_P_SHIFT)) {
+		report_info("Profiling buffer owned by higher exception level");
+		return false;
+	}
+
+	spe.align = (pmbidr >> SYS_PMBIDR_EL1_ALIGN_SHIFT) & SYS_PMBIDR_EL1_ALIGN_MASK;
+	spe.align = 1 << spe.align;
+
+	pmsidr = read_sysreg_s(SYS_PMSIDR_EL1);
+
+	interval = (pmsidr >> SYS_PMSIDR_EL1_INTERVAL_SHIFT) & SYS_PMSIDR_EL1_INTERVAL_MASK;
+	spe.min_interval = spe_min_interval(interval);
+
+	spe.max_record_size = (pmsidr >> SYS_PMSIDR_EL1_MAXSIZE_SHIFT) & \
+		      SYS_PMSIDR_EL1_MAXSIZE_MASK;
+	spe.max_record_size = 1 << spe.max_record_size;
+
+	spe.countsize = (pmsidr >> SYS_PMSIDR_EL1_COUNTSIZE_SHIFT) & \
+			SYS_PMSIDR_EL1_COUNTSIZE_MASK;
+
+	spe.fl_cap = pmsidr & BIT(SYS_PMSIDR_EL1_FL_SHIFT);
+	spe.ft_cap = pmsidr & BIT(SYS_PMSIDR_EL1_FT_SHIFT);
+	spe.fe_cap = pmsidr & BIT(SYS_PMSIDR_EL1_FE_SHIFT);
+
+	return true;
+}
+
+static void spe_test_introspection(void)
+{
+	report_prefix_push("spe-introspection");
+
+	report(spe.align <= SZ_2K, "PMBIDR_E1.Align");
+	report(spe.countsize == 0x2, "PMSIDR_EL1.CountSize");
+	report(spe.max_record_size >= 16 && spe.max_record_size <= 2048,
+			"PMSIDR_EL1 maximum record size");
+	report(spe.min_interval >= 256 && spe.min_interval <= 4096,
+			"PMSIDR_EL1 minimum sampling interval");
+	report(spe.fl_cap && spe.ft_cap && spe.fe_cap, "PMSIDR_EL1 sampling filters");
+
+	report_prefix_pop();
+}
+
+int main(int argc, char *argv[])
+{
+	if (!spe_probe()) {
+		report_skip("SPE not supported");
+		return report_summary();
+	}
+
+	printf("intid:           %u\n", PPI(spe.intid));
+	printf("align: 	         %d\n", spe.align);
+	printf("min_interval:    %d\n", spe.min_interval);
+	printf("max_record_size: %d\n", spe.max_record_size);
+
+	if (argc < 2)
+		report_abort("no test specified");
+
+	report_prefix_push("spe");
+
+	if (strcmp(argv[1], "spe-introspection") == 0)
+		spe_test_introspection();
+	else
+		report_abort("Unknown subtest '%s'", argv[1]);
+
+	return report_summary();
+}
diff --git a/arm/unittests.cfg b/arm/unittests.cfg
index f776b66ef96d..ad10be123774 100644
--- a/arm/unittests.cfg
+++ b/arm/unittests.cfg
@@ -134,6 +134,13 @@ extra_params = -append 'pmu-overflow-interrupt'
 #groups = pmu
 #accel = tcg
 
+[spe-introspection]
+file = spe.flat
+groups = spe
+arch = arm64
+accel = kvm
+extra_params = -append 'spe-introspection'
+
 # Test GIC emulation
 [gicv2-ipi]
 file = gic.flat
-- 
2.29.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
