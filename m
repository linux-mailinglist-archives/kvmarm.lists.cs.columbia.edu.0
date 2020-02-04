Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 11D3A15176D
	for <lists+kvmarm@lfdr.de>; Tue,  4 Feb 2020 10:11:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AFE6E4A5A3;
	Tue,  4 Feb 2020 04:11:52 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UM2eKv9my-w5; Tue,  4 Feb 2020 04:11:51 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5BC044A982;
	Tue,  4 Feb 2020 04:11:51 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DAC074A4E1
 for <kvmarm@lists.cs.columbia.edu>; Tue,  4 Feb 2020 04:11:49 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jD2qOaomeGXx for <kvmarm@lists.cs.columbia.edu>;
 Tue,  4 Feb 2020 04:11:48 -0500 (EST)
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A62DA4A4AA
 for <kvmarm@lists.cs.columbia.edu>; Tue,  4 Feb 2020 04:11:48 -0500 (EST)
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id D4AA320A607416FCA880;
 Tue,  4 Feb 2020 17:11:43 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.173.222.27) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Tue, 4 Feb 2020 17:11:36 +0800
From: Zenghui Yu <yuzenghui@huawei.com>
To: <linux-kernel@vger.kernel.org>, <maz@kernel.org>
Subject: [PATCH RFC 3/5] irqchip/gic-v4.1: Ensure L2 vPE table is allocated at
 RD level
Date: Tue, 4 Feb 2020 17:09:38 +0800
Message-ID: <20200204090940.1225-4-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
In-Reply-To: <20200204090940.1225-1-yuzenghui@huawei.com>
References: <20200204090940.1225-1-yuzenghui@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Cc: jason@lakedaemon.net, tglx@linutronix.de, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
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

In GICv4, we will ensure that level2 vPE table memory is allocated
for the specified vpe_id on all v4 ITS, in its_alloc_vpe_table().
This still works well for the typical GICv4.1 implementation, where
the new vPE table is shared between the ITSs and the RDs.

To make things explicit, introduce allocate_vpe_l1_table_entry() to
make sure that the L2 tables are allocated on all v4.1 RDs. We're
likely not need to allocate memory in it because the vPE table is
shared and (L2 table is) already allocated at ITS level, except
for the case where the ITS doesn't share anything (say SVPET == 0,
practically unlikely but architecturally allowed).

The implementation of allocate_vpe_l1_table_entry() is mostly
copied from its_alloc_table_entry().

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 68 ++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 0f1fe56ce0af..c1d01454eec8 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2443,6 +2443,64 @@ static u64 inherit_vpe_l1_table_from_rd(cpumask_t **mask)
 	return 0;
 }
 
+static int allocate_vpe_l1_table_entry(int cpu, u32 id)
+{
+	void __iomem *base = gic_data_rdist_cpu(cpu)->rd_base;
+	u64 val, gpsz, npg;
+	unsigned int psz, esz, idx;
+	struct page *page;
+	__le64 *table;
+
+	if (!gic_rdists->has_rvpeid)
+		return true;
+
+	val  = gits_read_vpropbaser(base + SZ_128K + GICR_VPROPBASER);
+
+	esz  = FIELD_GET(GICR_VPROPBASER_4_1_ENTRY_SIZE, val) + 1;
+	gpsz = FIELD_GET(GICR_VPROPBASER_4_1_PAGE_SIZE, val);
+	npg  = FIELD_GET(GICR_VPROPBASER_4_1_SIZE, val) + 1;
+
+	switch (gpsz) {
+	default:
+		WARN_ON(1);
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
+	/* Don't allow vpe_id that exceeds single, flat table limit */
+	if (!(val & GICR_VPROPBASER_4_1_INDIRECT))
+		return (id < (npg * psz / (esz * SZ_8)));
+
+	/* Compute 1st level table index & check if that exceeds table limit */
+	idx = id >> ilog2(psz / (esz * SZ_8));
+	if (idx >= (npg * psz / GITS_LVL1_ENTRY_SIZE))
+		return false;
+
+	table = gic_data_rdist_cpu(cpu)->vpe_l1_base;
+
+	/* Allocate memory for 2nd level table */
+	if (!table[idx]) {
+		page = alloc_pages(GFP_KERNEL | __GFP_ZERO, get_order(psz));
+		if (!page)
+			return false;
+
+		table[idx] = cpu_to_le64(page_to_phys(page) | GITS_BASER_VALID);
+
+		/* Ensure updated table contents are visible to RD hardware */
+		dsb(sy);
+	}
+
+	return true;
+}
+
 static int allocate_vpe_l1_table(void)
 {
 	void __iomem *vlpi_base = gic_data_rdist_vlpi_base();
@@ -2957,6 +3015,7 @@ static bool its_alloc_device_table(struct its_node *its, u32 dev_id)
 static bool its_alloc_vpe_table(u32 vpe_id)
 {
 	struct its_node *its;
+	int cpu;
 
 	/*
 	 * Make sure the L2 tables are allocated on *all* v4 ITSs. We
@@ -2979,6 +3038,15 @@ static bool its_alloc_vpe_table(u32 vpe_id)
 			return false;
 	}
 
+	/*
+	 * Make sure the L2 tables are allocated for all copies of
+	 * the L1 table on *all* v4.1 RDs.
+	 */
+	for_each_possible_cpu(cpu) {
+		if (!allocate_vpe_l1_table_entry(cpu, vpe_id))
+			return false;
+	}
+
 	return true;
 }
 
-- 
2.19.1


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
