Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 931C72B7C6D
	for <lists+kvmarm@lfdr.de>; Wed, 18 Nov 2020 12:24:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 418864B84B;
	Wed, 18 Nov 2020 06:24:10 -0500 (EST)
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
	with ESMTP id VszEHSGI+GdE; Wed, 18 Nov 2020 06:24:10 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3429F4B812;
	Wed, 18 Nov 2020 06:24:09 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8FADA4B80C
 for <kvmarm@lists.cs.columbia.edu>; Wed, 18 Nov 2020 06:24:07 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SGXJZ9lpxoLk for <kvmarm@lists.cs.columbia.edu>;
 Wed, 18 Nov 2020 06:24:06 -0500 (EST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BF3454B80B
 for <kvmarm@lists.cs.columbia.edu>; Wed, 18 Nov 2020 06:24:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605698646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=spwbm5vXoHiQvJQpWqgCh2lkcvbGNw23B7J3IRmsnBU=;
 b=c3LdtTUZtolA9KNWFL4TuB9Cq7nw7+aaNfn5mA8/Wokr2E6ze57K8TvaeS1jUAvokd+nOH
 3s27tIyyZRbiEJIHPqkU7GEK8GmZH0OK9pn9j1tYVLZHgZkWOsRyPvbA0ftfHDkjAm+VOT
 gwVtY2JutPxc1aOXuqRKlI2zOZrKSB4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-s9rX9rIWNOun08cCpJpc1w-1; Wed, 18 Nov 2020 06:24:02 -0500
X-MC-Unique: s9rX9rIWNOun08cCpJpc1w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3EF9C1017DC6;
 Wed, 18 Nov 2020 11:24:00 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-115-104.ams2.redhat.com [10.36.115.104])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 84FEC5B4BC;
 Wed, 18 Nov 2020 11:23:55 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, will@kernel.org,
 joro@8bytes.org, maz@kernel.org, robin.murphy@arm.com,
 alex.williamson@redhat.com
Subject: [PATCH v13 15/15] iommu/smmuv3: Add PASID cache invalidation per PASID
Date: Wed, 18 Nov 2020 12:21:51 +0100
Message-Id: <20201118112151.25412-16-eric.auger@redhat.com>
In-Reply-To: <20201118112151.25412-1-eric.auger@redhat.com>
References: <20201118112151.25412-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: jean-philippe@linaro.org, jacob.jun.pan@linux.intel.com,
 nicoleotsuka@gmail.com, vivek.gautam@arm.com, yi.l.liu@intel.com,
 zhangfei.gao@linaro.org
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

In order to cascade guest CFGI_CD, let's add PASID cache invalidation
per PASID.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v12 -> v13:
- Fix !(info->flags & IOMMU_INV_PASID_FLAGS_PASID) check
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index ed64699a4a0d..45adfe4da11b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2999,9 +2999,19 @@ arm_smmu_cache_invalidate(struct iommu_domain *domain, struct device *dev,
 		} else {
 			return -EINVAL;
 		}
-	}
-	if (inv_info->cache & IOMMU_CACHE_INV_TYPE_PASID ||
-	    inv_info->cache & IOMMU_CACHE_INV_TYPE_DEV_IOTLB) {
+	} else if (inv_info->cache & IOMMU_CACHE_INV_TYPE_PASID) {
+		if (inv_info->granularity == IOMMU_INV_GRANU_PASID) {
+			struct iommu_inv_pasid_info *info =
+				&inv_info->granu.pasid_info;
+
+			if (!(info->flags & IOMMU_INV_PASID_FLAGS_PASID))
+				return -EINVAL;
+
+			arm_smmu_sync_cd(smmu_domain, info->pasid, true);
+		} else {
+			return -ENOENT;
+		}
+	} else { /* IOMMU_CACHE_INV_TYPE_DEV_IOTLB */
 		return -ENOENT;
 	}
 	return 0;
-- 
2.21.3

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
