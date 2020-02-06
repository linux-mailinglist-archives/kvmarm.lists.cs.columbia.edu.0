Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBE3153F79
	for <lists+kvmarm@lfdr.de>; Thu,  6 Feb 2020 08:58:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2FA784AC65;
	Thu,  6 Feb 2020 02:58:45 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6j5J+a838LJr; Thu,  6 Feb 2020 02:58:44 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 205B44A95D;
	Thu,  6 Feb 2020 02:58:42 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 77CC74A610
 for <kvmarm@lists.cs.columbia.edu>; Thu,  6 Feb 2020 02:58:40 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OamSUEGjzl-j for <kvmarm@lists.cs.columbia.edu>;
 Thu,  6 Feb 2020 02:58:37 -0500 (EST)
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 34A7D4A49F
 for <kvmarm@lists.cs.columbia.edu>; Thu,  6 Feb 2020 02:58:37 -0500 (EST)
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 123D151719EAA284CA6A;
 Thu,  6 Feb 2020 15:58:33 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.173.222.27) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Thu, 6 Feb 2020 15:58:25 +0800
From: Zenghui Yu <yuzenghui@huawei.com>
To: <linux-kernel@vger.kernel.org>, <maz@kernel.org>
Subject: [PATCH v2 2/6] irqchip/gic-v4.1: Set vpe_l1_base for all
 redistributors
Date: Thu, 6 Feb 2020 15:57:07 +0800
Message-ID: <20200206075711.1275-3-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
In-Reply-To: <20200206075711.1275-1-yuzenghui@huawei.com>
References: <20200206075711.1275-1-yuzenghui@huawei.com>
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

Currently, we will not set vpe_l1_page for the current RD if we can
inherit the vPE configuration table from another RD (or ITS), which
results in an inconsistency between RDs within the same CommonLPIAff
group.

Let's rename it to vpe_l1_base to indicate the base address of the
vPE configuration table of this RD, and set it properly for *all*
v4.1 redistributors.

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 drivers/irqchip/irq-gic-v3-its.c   | 5 ++++-
 include/linux/irqchip/arm-gic-v3.h | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 992bc72cab6f..0f1fe56ce0af 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2376,6 +2376,8 @@ static u64 inherit_vpe_l1_table_from_its(void)
 			continue;
 
 		/* We have a winner! */
+		gic_data_rdist()->vpe_l1_base = its->tables[2].base;
+
 		val  = GICR_VPROPBASER_4_1_VALID;
 		if (baser & GITS_BASER_INDIRECT)
 			val |= GICR_VPROPBASER_4_1_INDIRECT;
@@ -2432,6 +2434,7 @@ static u64 inherit_vpe_l1_table_from_rd(cpumask_t **mask)
 		val = gits_read_vpropbaser(base + SZ_128K + GICR_VPROPBASER);
 		val &= ~GICR_VPROPBASER_4_1_Z;
 
+		gic_data_rdist()->vpe_l1_base = gic_data_rdist_cpu(cpu)->vpe_l1_base;
 		*mask = gic_data_rdist_cpu(cpu)->vpe_table_mask;
 
 		return val;
@@ -2542,7 +2545,7 @@ static int allocate_vpe_l1_table(void)
 	if (!page)
 		return -ENOMEM;
 
-	gic_data_rdist()->vpe_l1_page = page;
+	gic_data_rdist()->vpe_l1_base = page_address(page);
 	pa = virt_to_phys(page_address(page));
 	WARN_ON(!IS_ALIGNED(pa, psz));
 
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index f0b8ca766e7d..83439bfb6c5b 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -652,10 +652,10 @@ struct rdists {
 	struct {
 		void __iomem	*rd_base;
 		struct page	*pend_page;
-		struct page	*vpe_l1_page;
 		phys_addr_t	phys_base;
 		bool		lpi_enabled;
 		cpumask_t	*vpe_table_mask;
+		void		*vpe_l1_base;
 	} __percpu		*rdist;
 	phys_addr_t		prop_table_pa;
 	void			*prop_table_va;
-- 
2.19.1


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
