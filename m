Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 17BC1BBB5D
	for <lists+kvmarm@lfdr.de>; Mon, 23 Sep 2019 20:27:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BF3954A693;
	Mon, 23 Sep 2019 14:27:09 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VxY+vMt-41mH; Mon, 23 Sep 2019 14:27:09 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E2A664A683;
	Mon, 23 Sep 2019 14:27:07 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 79CCC4A5A6
 for <kvmarm@lists.cs.columbia.edu>; Mon, 23 Sep 2019 14:27:06 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WgKaVvh+7XKK for <kvmarm@lists.cs.columbia.edu>;
 Mon, 23 Sep 2019 14:27:04 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A7C1E4A53F
 for <kvmarm@lists.cs.columbia.edu>; Mon, 23 Sep 2019 14:27:04 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 653B41713;
 Mon, 23 Sep 2019 11:27:04 -0700 (PDT)
Received: from big-swifty.lan (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C40D3F694;
 Mon, 23 Sep 2019 11:27:01 -0700 (PDT)
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.cs.columbia.edu,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/35] irqchip/gic-v4.1: VPE table (aka GICR_VPROPBASER)
 allocation
Date: Mon, 23 Sep 2019 19:25:41 +0100
Message-Id: <20190923182606.32100-11-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190923182606.32100-1-maz@kernel.org>
References: <20190923182606.32100-1-maz@kernel.org>
MIME-Version: 1.0
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>
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

GICv4.1 defines a new VPE table that is potentially shared between
both the ITSs and the redistributors, following complicated affinity
rules.

To make things more confusing, the programming of this table at
the redistributor level is reusing the GICv4.0 GICR_VPROPBASER register
for something completely different.

The code flow is somewhat complexified by the need to respect the
affinities required by the HW, meaning that tables can either be
inherited from a previously discovered ITS or redistributor.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm/include/asm/arch_gicv3.h   |   2 +
 arch/arm64/include/asm/arch_gicv3.h |   1 +
 drivers/irqchip/irq-gic-v3-its.c    | 301 +++++++++++++++++++++++++++-
 include/linux/irqchip/arm-gic-v3.h  |  33 ++-
 4 files changed, 330 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/arch_gicv3.h b/arch/arm/include/asm/arch_gicv3.h
index 0555f14cc8be..20bacab1d791 100644
--- a/arch/arm/include/asm/arch_gicv3.h
+++ b/arch/arm/include/asm/arch_gicv3.h
@@ -10,6 +10,7 @@
 #ifndef __ASSEMBLY__
 
 #include <linux/io.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 #include <asm/barrier.h>
 #include <asm/cacheflush.h>
 #include <asm/cp15.h>
@@ -327,6 +328,7 @@ static inline u64 __gic_readq_nonatomic(const volatile void __iomem *addr)
 /*
  * GITS_VPROPBASER - hi and lo bits may be accessed independently.
  */
+#define gits_read_vpropbaser(c)		__gic_readq_nonatomic(c)
 #define gits_write_vpropbaser(v, c)	__gic_writeq_nonatomic(v, c)
 
 /*
diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arch_gicv3.h
index 89e4c8b79349..4750fc8030c3 100644
--- a/arch/arm64/include/asm/arch_gicv3.h
+++ b/arch/arm64/include/asm/arch_gicv3.h
@@ -141,6 +141,7 @@ static inline u32 gic_read_rpr(void)
 #define gicr_read_pendbaser(c)		readq_relaxed(c)
 
 #define gits_write_vpropbaser(v, c)	writeq_relaxed(v, c)
+#define gits_read_vpropbaser(c)		readq_relaxed(c)
 
 #define gits_write_vpendbaser(v, c)	writeq_relaxed(v, c)
 #define gits_read_vpendbaser(c)		readq_relaxed(c)
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 9bad3887f6ce..58c7c40f5ad7 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -45,6 +45,7 @@
 
 #define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING	(1 << 0)
 #define RDIST_FLAGS_RD_TABLES_PREALLOCATED	(1 << 1)
+#define RDIST_FLAGS_VPE_INDIRECT		(1 << 2)
 
 static u32 lpi_id_bits;
 
@@ -106,6 +107,7 @@ struct its_node {
 	u64			typer;
 	u64			cbaser_save;
 	u32			ctlr_save;
+	u32			mpidr;
 	struct list_head	its_device_list;
 	u64			flags;
 	unsigned long		list_nr;
@@ -116,6 +118,7 @@ struct its_node {
 };
 
 #define is_v4(its)		(!!((its)->typer & GITS_TYPER_VLPIS))
+#define is_v4_1(its)		(!!((its)->typer & GITS_TYPER_VMAPP))
 #define device_ids(its)		(FIELD_GET(GITS_TYPER_DEVBITS, (its)->typer) + 1)
 
 #define ITS_ITT_ALIGN		SZ_256
@@ -1962,6 +1965,65 @@ static bool its_parse_indirect_baser(struct its_node *its,
 	return indirect;
 }
 
+static u32 compute_common_aff(u64 val)
+{
+	u32 aff, clpiaff;
+
+	aff = FIELD_GET(GICR_TYPER_AFFINITY, val);
+	clpiaff = FIELD_GET(GICR_TYPER_COMMON_LPI_AFF, val);
+
+	return aff & ~(GENMASK(31, 0) >> (clpiaff * 8));
+}
+
+static u32 compute_its_aff(struct its_node *its)
+{
+	u64 val;
+	u32 svpet;
+
+	/*
+	 * Reencode the ITS SVPET and MPIDR as a GICR_TYPER, and compute
+	 * the resulting affinity. We then use that to see if this match
+	 * our own affinity.
+	 */
+	svpet = FIELD_GET(GITS_TYPER_SVPET, its->typer);
+	val  = FIELD_PREP(GICR_TYPER_COMMON_LPI_AFF, svpet);
+	val |= FIELD_PREP(GICR_TYPER_AFFINITY, its->mpidr);
+	return compute_common_aff(val);
+}
+
+static struct its_node *find_sibbling_its(struct its_node *cur_its)
+{
+	struct its_node *its;
+	u32 aff;
+
+	if (!FIELD_GET(GITS_TYPER_SVPET, cur_its->typer))
+		return NULL;
+
+	aff = compute_its_aff(cur_its);
+
+	list_for_each_entry(its, &its_nodes, entry) {
+		u64 baser;
+
+		if (!is_v4_1(its) || its == cur_its)
+			continue;
+
+		if (!FIELD_GET(GITS_TYPER_SVPET, its->typer))
+			continue;
+
+		if (aff != compute_its_aff(its))
+			continue;
+
+		/* GICv4.1 guarantees that the vPE table is GITS_BASER2 */
+		baser = its->tables[2].val;
+		if (!(baser & GITS_BASER_VALID))
+			continue;
+
+		return its;
+	}
+
+	return NULL;
+}
+
 static void its_free_tables(struct its_node *its)
 {
 	int i;
@@ -2004,6 +2066,15 @@ static int its_alloc_tables(struct its_node *its)
 			break;
 
 		case GITS_BASER_TYPE_VCPU:
+			if (is_v4_1(its)) {
+				struct its_node *sibbling;
+
+				if ((sibbling = find_sibbling_its(its))) {
+					its->tables[2] = sibbling->tables[2];
+					continue;
+				}
+			}
+
 			indirect = its_parse_indirect_baser(its, baser,
 							    psz, &order,
 							    ITS_MAX_VPEID_BITS);
@@ -2025,6 +2096,212 @@ static int its_alloc_tables(struct its_node *its)
 	return 0;
 }
 
+static u64 inherit_vpe_l1_table_from_its(void)
+{
+	struct its_node *its;
+	u64 val;
+	u32 aff;
+
+	val = gic_read_typer(gic_data_rdist_rd_base() + GICR_TYPER);
+	aff = compute_common_aff(val);
+
+	list_for_each_entry(its, &its_nodes, entry) {
+		u64 baser;
+
+		if (!is_v4_1(its))
+			continue;
+
+		if (!FIELD_GET(GITS_TYPER_SVPET, its->typer))
+			continue;
+
+		if (aff != compute_its_aff(its))
+			continue;
+
+		/* GICv4.1 guarantees that the vPE table is GITS_BASER2 */
+		baser = its->tables[2].val;
+		if (!(baser & GITS_BASER_VALID))
+			continue;
+
+		/* We have a winner! */
+		val  = GICR_VPROPBASER_4_1_VALID;
+		if (baser & GITS_BASER_INDIRECT)
+			val |= GICR_VPROPBASER_4_1_INDIRECT;
+		val |= FIELD_PREP(GICR_VPROPBASER_4_1_PAGE_SIZE,
+				  FIELD_GET(GITS_BASER_PAGE_SIZE_MASK, baser));
+		val |= FIELD_PREP(GICR_VPROPBASER_4_1_ADDR,
+				  GITS_BASER_ADDR_48_to_52(baser) >> 12);
+		val |= FIELD_PREP(GICR_VPROPBASER_SHAREABILITY_MASK,
+				  FIELD_GET(GITS_BASER_SHAREABILITY_MASK, baser));
+		val |= FIELD_PREP(GICR_VPROPBASER_INNER_CACHEABILITY_MASK,
+				  FIELD_GET(GITS_BASER_INNER_CACHEABILITY_MASK, baser));
+		val |= FIELD_PREP(GICR_VPROPBASER_4_1_SIZE, GITS_BASER_NR_PAGES(baser) - 1);
+
+		return val;
+	}
+
+	return 0;
+}
+
+static u64 inherit_vpe_l1_table_from_rd(cpumask_t **mask)
+{
+	u32 aff;
+	u64 val;
+	int cpu;
+
+	val = gic_read_typer(gic_data_rdist_rd_base() + GICR_TYPER);
+	aff = compute_common_aff(val);
+
+	for_each_possible_cpu(cpu) {
+		void __iomem *base = gic_data_rdist_cpu(cpu)->rd_base;
+		u32 tmp;
+
+		if (!base || cpu == smp_processor_id())
+			continue;
+
+		val = gic_read_typer(base + GICR_TYPER);
+		tmp = compute_common_aff(val);
+		if (tmp != aff)
+			continue;
+
+		/*
+		 * At this point, we have a victim. This particular CPU
+		 * has already booted, and has an affinity that matches
+		 * ours wrt CommonLPIAff. Let's use its own VPROPBASER.
+		 * Make sure we don't write the Z bit in that case.
+		 */
+		val = gits_read_vpropbaser(base + SZ_128K + GICR_VPROPBASER);
+		val &= ~GICR_VPROPBASER_4_1_Z;
+
+		*mask = gic_data_rdist_cpu(cpu)->vpe_table_mask;
+
+		return val;
+	}
+
+	return 0;
+}
+
+static int allocate_vpe_l1_table(void)
+{
+	void __iomem *vlpi_base = gic_data_rdist_vlpi_base();
+	u64 val, esz, gpsz, npg, pa;
+	unsigned int psz = SZ_64K;
+	unsigned int np, epp;
+	struct page *page;
+
+	if (!gic_rdists->has_rvpeid)
+		return 0;
+
+	/*
+	 * if VPENDBASER.Valid is set, disable any previously programmed
+	 * VPE by setting PendingLast while clearing Valid. This has the
+	 * effect of making sure no doorbell will be generated and we can
+	 * then safely clear VPROPBASER.Valid.
+	 */
+	if (gits_read_vpendbaser(vlpi_base + GICR_VPENDBASER) & GICR_VPENDBASER_Valid)
+		gits_write_vpendbaser(GICR_VPENDBASER_PendingLast,
+				      vlpi_base + GICR_VPENDBASER);
+
+	/*
+	 * If we can inherit the configuration from another RD, let's do
+	 * so. Otherwise, we have to go through the allocation process. We
+	 * assume that all RDs have the exact same requirements, as
+	 * nothing will work otherwise.
+	 */
+	val = inherit_vpe_l1_table_from_rd(&gic_data_rdist()->vpe_table_mask);
+	if (val & GICR_VPROPBASER_4_1_VALID)
+		goto out;
+
+	gic_data_rdist()->vpe_table_mask = kzalloc(sizeof(cpumask_t), GFP_KERNEL);
+
+	val = inherit_vpe_l1_table_from_its();
+	if (val & GICR_VPROPBASER_4_1_VALID)
+		goto out;
+
+	/* First probe the page size */
+	val = FIELD_PREP(GICR_VPROPBASER_4_1_PAGE_SIZE, GIC_PAGE_SIZE_64K);
+	gits_write_vpropbaser(val, vlpi_base + GICR_VPROPBASER);
+	val = gits_read_vpropbaser(vlpi_base + GICR_VPROPBASER);
+	gpsz = FIELD_GET(GICR_VPROPBASER_4_1_PAGE_SIZE, val);
+
+	switch (gpsz) {
+	default:
+		gpsz = GIC_PAGE_SIZE_4K;
+		/* fall through */
+	case GIC_PAGE_SIZE_4K:
+		psz = SZ_4K;
+		break;
+	case GIC_PAGE_SIZE_16K:
+		psz = SZ_16K;
+		break;
+	case GIC_PAGE_SIZE_64K:
+		psz = SZ_64K;
+		break;
+	}
+
+	/*
+	 * Start populating the register from scratch, including RO fields
+	 * (which we want to print in debug cases...)
+	 */
+	val = 0;
+	val |= FIELD_PREP(GICR_VPROPBASER_4_1_PAGE_SIZE, gpsz);
+	esz = FIELD_GET(GICR_VPROPBASER_4_1_ENTRY_SIZE, val);
+	val |= FIELD_PREP(GICR_VPROPBASER_4_1_ENTRY_SIZE, esz);
+
+	/* How many entries per GIC page? */
+	esz++;
+	epp = psz / (esz * SZ_8);
+
+	/*
+	 * If we need more than just a single L1 page, flag the table
+	 * as indirect and compute the number of required L1 pages.
+	 */
+	if (epp < ITS_MAX_VPEID) {
+		int nl2;
+
+		gic_rdists->flags |= RDIST_FLAGS_VPE_INDIRECT;
+		val |= GICR_VPROPBASER_4_1_INDIRECT;
+
+		/* Number of L2 pages required to cover the VPEID space */
+		nl2 = DIV_ROUND_UP(ITS_MAX_VPEID, epp);
+
+		/* Number of L1 pages to point to the L2 pages */
+		npg = DIV_ROUND_UP(nl2 * SZ_8, psz);
+	} else {
+		npg = 1;
+	}
+
+	val |= FIELD_PREP(GICR_VPROPBASER_4_1_SIZE, npg);
+
+	/* Right, that's the number of CPU pages we need for L1 */
+	np = DIV_ROUND_UP(npg * psz, PAGE_SIZE);
+
+	pr_debug("np = %d, npg = %lld, psz = %d, epp = %d, esz = %lld\n",
+		 np, npg, psz, epp, esz);
+	page = alloc_pages(GFP_KERNEL | __GFP_ZERO, get_order(np * PAGE_SIZE));
+	if (!page)
+		return -ENOMEM;
+
+	gic_data_rdist()->vpe_l1_page = page;
+	pa = virt_to_phys(page_address(page));
+	WARN_ON(!IS_ALIGNED(pa, psz));
+
+	val |= FIELD_PREP(GICR_VPROPBASER_4_1_ADDR, pa >> 12);
+	val |= GICR_VPROPBASER_RaWb;
+	val |= GICR_VPROPBASER_InnerShareable;
+	val |= GICR_VPROPBASER_4_1_Z;
+	val |= GICR_VPROPBASER_4_1_VALID;
+
+out:
+	gits_write_vpropbaser(val, vlpi_base + GICR_VPROPBASER);
+	cpumask_set_cpu(smp_processor_id(), gic_data_rdist()->vpe_table_mask);
+
+	pr_debug("CPU%d: VPROPBASER = %llx %*pbl\n",
+		 smp_processor_id(), val,
+		 cpumask_pr_args(gic_data_rdist()->vpe_table_mask));
+
+	return 0;
+}
+
 static int its_alloc_collections(struct its_node *its)
 {
 	int i;
@@ -2224,7 +2501,7 @@ static void its_cpu_init_lpis(void)
 	val |= GICR_CTLR_ENABLE_LPIS;
 	writel_relaxed(val, rbase + GICR_CTLR);
 
-	if (gic_rdists->has_vlpis) {
+	if (gic_rdists->has_vlpis && !gic_rdists->has_rvpeid) {
 		void __iomem *vlpi_base = gic_data_rdist_vlpi_base();
 
 		/*
@@ -2248,6 +2525,16 @@ static void its_cpu_init_lpis(void)
 		WARN_ON(val & GICR_VPENDBASER_Dirty);
 	}
 
+	if (allocate_vpe_l1_table()) {
+		/*
+		 * If the allocation has failed, we're in massive trouble.
+		 * Disable direct injection, and pray that no VM was
+		 * already running...
+		 */
+		gic_rdists->has_rvpeid = false;
+		gic_rdists->has_vlpis = false;
+	}
+
 	/* Make sure the GIC has seen the above */
 	dsb(sy);
 out:
@@ -3649,6 +3936,14 @@ static int __init its_probe_one(struct resource *res,
 		} else {
 			pr_info("ITS@%pa: Single VMOVP capable\n", &res->start);
 		}
+
+		if (is_v4_1(its)) {
+			u32 svpet = FIELD_GET(GITS_TYPER_SVPET, typer);
+			its->mpidr = readl_relaxed(its_base + GITS_MPIDR);
+
+			pr_info("ITS@%pa: Using GICv4.1 mode %08x %08x\n",
+				&res->start, its->mpidr, svpet);
+		}
 	}
 
 	its->numa_node = numa_node;
@@ -4009,6 +4304,8 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
 	bool has_v4 = false;
 	int err;
 
+	gic_rdists = rdists;
+
 	its_parent = parent_domain;
 	of_node = to_of_node(handle);
 	if (of_node)
@@ -4021,8 +4318,6 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
 		return -ENXIO;
 	}
 
-	gic_rdists = rdists;
-
 	err = allocate_lpi_tables();
 	if (err)
 		return err;
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 8c6be56da7e9..f1d6de53e09b 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -102,6 +102,11 @@
 
 #define GIC_V3_DIST_SIZE		0x10000
 
+#define GIC_PAGE_SIZE_4K		0ULL
+#define GIC_PAGE_SIZE_16K		1ULL
+#define GIC_PAGE_SIZE_64K		2ULL
+#define GIC_PAGE_SIZE_MASK		3ULL
+
 /*
  * Re-Distributor registers, offsets from RD_base
  */
@@ -239,6 +244,8 @@
 #define GICR_TYPER_DirectLPIS		(1U << 3)
 #define GICR_TYPER_LAST			(1U << 4)
 #define GICR_TYPER_RVPEID		(1U << 7)
+#define GICR_TYPER_COMMON_LPI_AFF	GENMASK_ULL(25, 24)
+#define GICR_TYPER_AFFINITY		GENMASK_ULL(63, 32)
 
 #define GIC_V3_REDIST_SIZE		0x20000
 
@@ -277,6 +284,18 @@
 #define GICR_VPROPBASER_RaWaWt	GIC_BASER_CACHEABILITY(GICR_VPROPBASER, INNER, RaWaWt)
 #define GICR_VPROPBASER_RaWaWb	GIC_BASER_CACHEABILITY(GICR_VPROPBASER, INNER, RaWaWb)
 
+/*
+ * GICv4.1 VPROPBASER reinvention. A subtle mix between the old
+ * VPROPBASER and ITS_BASER. Just not quite any of the two.
+ */
+#define GICR_VPROPBASER_4_1_VALID	(1ULL << 63)
+#define GICR_VPROPBASER_4_1_ENTRY_SIZE	GENMASK_ULL(61, 59)
+#define GICR_VPROPBASER_4_1_INDIRECT	(1ULL << 55)
+#define GICR_VPROPBASER_4_1_PAGE_SIZE	GENMASK_ULL(54, 53)
+#define GICR_VPROPBASER_4_1_Z		(1ULL << 52)
+#define GICR_VPROPBASER_4_1_ADDR	GENMASK_ULL(51, 12)
+#define GICR_VPROPBASER_4_1_SIZE	GENMASK_ULL(6, 0)
+
 #define GICR_VPENDBASER			0x0078
 
 #define GICR_VPENDBASER_SHAREABILITY_SHIFT		(10)
@@ -314,6 +333,7 @@
 #define GITS_CTLR			0x0000
 #define GITS_IIDR			0x0004
 #define GITS_TYPER			0x0008
+#define GITS_MPIDR			0x0018
 #define GITS_CBASER			0x0080
 #define GITS_CWRITER			0x0088
 #define GITS_CREADR			0x0090
@@ -347,6 +367,8 @@
 #define GITS_TYPER_HCC_SHIFT		24
 #define GITS_TYPER_HCC(r)		(((r) >> GITS_TYPER_HCC_SHIFT) & 0xff)
 #define GITS_TYPER_VMOVP		(1ULL << 37)
+#define GITS_TYPER_VMAPP		(1ULL << 40)
+#define GITS_TYPER_SVPET		GENMASK_ULL(42, 41)
 
 #define GITS_IIDR_REV_SHIFT		12
 #define GITS_IIDR_REV_MASK		(0xf << GITS_IIDR_REV_SHIFT)
@@ -417,10 +439,11 @@
 #define GITS_BASER_InnerShareable					\
 	GIC_BASER_SHAREABILITY(GITS_BASER, InnerShareable)
 #define GITS_BASER_PAGE_SIZE_SHIFT	(8)
-#define GITS_BASER_PAGE_SIZE_4K		(0ULL << GITS_BASER_PAGE_SIZE_SHIFT)
-#define GITS_BASER_PAGE_SIZE_16K	(1ULL << GITS_BASER_PAGE_SIZE_SHIFT)
-#define GITS_BASER_PAGE_SIZE_64K	(2ULL << GITS_BASER_PAGE_SIZE_SHIFT)
-#define GITS_BASER_PAGE_SIZE_MASK	(3ULL << GITS_BASER_PAGE_SIZE_SHIFT)
+#define __GITS_BASER_PSZ(sz)		(GIC_PAGE_SIZE_ ## sz << GITS_BASER_PAGE_SIZE_SHIFT)
+#define GITS_BASER_PAGE_SIZE_4K		__GITS_BASER_PSZ(4K)
+#define GITS_BASER_PAGE_SIZE_16K	__GITS_BASER_PSZ(16K)
+#define GITS_BASER_PAGE_SIZE_64K	__GITS_BASER_PSZ(64K)
+#define GITS_BASER_PAGE_SIZE_MASK	__GITS_BASER_PSZ(MASK)
 #define GITS_BASER_PAGES_MAX		256
 #define GITS_BASER_PAGES_SHIFT		(0)
 #define GITS_BASER_NR_PAGES(r)		(((r) & 0xff) + 1)
@@ -610,8 +633,10 @@ struct rdists {
 	struct {
 		void __iomem	*rd_base;
 		struct page	*pend_page;
+		struct page	*vpe_l1_page;
 		phys_addr_t	phys_base;
 		bool		lpi_enabled;
+		cpumask_t	*vpe_table_mask;
 	} __percpu		*rdist;
 	phys_addr_t		prop_table_pa;
 	void			*prop_table_va;
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
