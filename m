Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id EA5952EC981
	for <lists+kvmarm@lfdr.de>; Thu,  7 Jan 2021 05:44:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A10564B374;
	Wed,  6 Jan 2021 23:44:46 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q6wKc9a3bDiG; Wed,  6 Jan 2021 23:44:45 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 96FA64B388;
	Wed,  6 Jan 2021 23:44:42 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DD17C4B1ED
 for <kvmarm@lists.cs.columbia.edu>; Wed,  6 Jan 2021 23:44:41 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CICUy5xAg648 for <kvmarm@lists.cs.columbia.edu>;
 Wed,  6 Jan 2021 23:44:41 -0500 (EST)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id C6EB14B364
 for <kvmarm@lists.cs.columbia.edu>; Wed,  6 Jan 2021 23:44:40 -0500 (EST)
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DBDCG08Qdzj31g;
 Thu,  7 Jan 2021 12:43:54 +0800 (CST)
Received: from DESKTOP-5IS4806.china.huawei.com (10.174.184.42) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Thu, 7 Jan 2021 12:44:29 +0800
From: Keqian Zhu <zhukeqian1@huawei.com>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <iommu@lists.linux-foundation.org>, <kvm@vger.kernel.org>,
 <kvmarm@lists.cs.columbia.edu>, Alex Williamson <alex.williamson@redhat.com>, 
 Cornelia Huck <cohuck@redhat.com>, Will Deacon <will@kernel.org>, "Marc
 Zyngier" <maz@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4/6] vfio/iommu_type1: Drop parameter "pgsize" of
 vfio_dma_bitmap_alloc_all
Date: Thu, 7 Jan 2021 12:43:59 +0800
Message-ID: <20210107044401.19828-5-zhukeqian1@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
In-Reply-To: <20210107044401.19828-1-zhukeqian1@huawei.com>
References: <20210107044401.19828-1-zhukeqian1@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.184.42]
X-CFilter-Loop: Reflected
Cc: Joerg Roedel <joro@8bytes.org>, Daniel
 Lezcano <daniel.lezcano@linaro.org>, Alexios Zavras <alexios.zavras@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Robin Murphy <robin.murphy@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>
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

We always use the smallest supported page size of vfio_iommu as
pgsize. Remove parameter "pgsize" of vfio_dma_bitmap_alloc_all.

Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
---
 drivers/vfio/vfio_iommu_type1.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index b596c482487b..080c05b129ee 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -236,9 +236,10 @@ static void vfio_dma_populate_bitmap(struct vfio_dma *dma, size_t pgsize)
 	}
 }
 
-static int vfio_dma_bitmap_alloc_all(struct vfio_iommu *iommu, size_t pgsize)
+static int vfio_dma_bitmap_alloc_all(struct vfio_iommu *iommu)
 {
 	struct rb_node *n;
+	size_t pgsize = (size_t)1 << __ffs(iommu->pgsize_bitmap);
 
 	for (n = rb_first(&iommu->dma_list); n; n = rb_next(n)) {
 		struct vfio_dma *dma = rb_entry(n, struct vfio_dma, node);
@@ -2761,12 +2762,9 @@ static int vfio_iommu_type1_dirty_pages(struct vfio_iommu *iommu,
 		return -EINVAL;
 
 	if (dirty.flags & VFIO_IOMMU_DIRTY_PAGES_FLAG_START) {
-		size_t pgsize;
-
 		mutex_lock(&iommu->lock);
-		pgsize = 1 << __ffs(iommu->pgsize_bitmap);
 		if (!iommu->dirty_page_tracking) {
-			ret = vfio_dma_bitmap_alloc_all(iommu, pgsize);
+			ret = vfio_dma_bitmap_alloc_all(iommu);
 			if (!ret)
 				iommu->dirty_page_tracking = true;
 		}
-- 
2.19.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
