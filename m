Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 253E12B415E
	for <lists+kvmarm@lfdr.de>; Mon, 16 Nov 2020 11:44:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CF7E94C14C;
	Mon, 16 Nov 2020 05:44:29 -0500 (EST)
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
	with ESMTP id HeDJT+er7JGg; Mon, 16 Nov 2020 05:44:29 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B3E324C14E;
	Mon, 16 Nov 2020 05:44:28 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2CDCB4C070
 for <kvmarm@lists.cs.columbia.edu>; Mon, 16 Nov 2020 05:44:27 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RcVVdctKQolM for <kvmarm@lists.cs.columbia.edu>;
 Mon, 16 Nov 2020 05:44:26 -0500 (EST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 459C84B822
 for <kvmarm@lists.cs.columbia.edu>; Mon, 16 Nov 2020 05:44:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605523466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LxvNRDy9SuWnb+59b3eyzpbcV50DXwqGzvQKc9IpdYI=;
 b=HQdd7/X7sWoojT2ms/n1TRFD0lZklGzgG8nVI5JGYuYtOWJ3EbAaathXptlU2dHrujkygE
 mihFzHJ0UnWcpftJtYVEGE46JVCd4QW6JhU4mP6gVHubxmppu0DrVI4G/+DMIv+w5VLp2M
 Sp25ZUUa0uagolXTw7Ok62jaTlILjPg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-qEHzefDeMhe_mBDcSDL2gw-1; Mon, 16 Nov 2020 05:44:22 -0500
X-MC-Unique: qEHzefDeMhe_mBDcSDL2gw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 809D5186841F;
 Mon, 16 Nov 2020 10:44:19 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-113-230.ams2.redhat.com [10.36.113.230])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 407E35C5FE;
 Mon, 16 Nov 2020 10:44:15 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, will@kernel.org,
 joro@8bytes.org, maz@kernel.org, robin.murphy@arm.com
Subject: [PATCH v12 08/15] iommu/smmuv3: Implement cache_invalidate
Date: Mon, 16 Nov 2020 11:43:09 +0100
Message-Id: <20201116104316.31816-9-eric.auger@redhat.com>
In-Reply-To: <20201116104316.31816-1-eric.auger@redhat.com>
References: <20201116104316.31816-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: jean-philippe@linaro.org, jacob.jun.pan@linux.intel.com,
 nicoleotsuka@gmail.com, vivek.gautam@arm.com, alex.williamson@redhat.com,
 yi.l.liu@intel.com, zhangfei.gao@linaro.org
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

Implement domain-selective and page-selective IOTLB invalidations.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
v7 -> v8:
- ASID based invalidation using iommu_inv_pasid_info
- check ARCHID/PASID flags in addr based invalidation
- use __arm_smmu_tlb_inv_context and __arm_smmu_tlb_inv_range_nosync

v6 -> v7
- check the uapi version

v3 -> v4:
- adapt to changes in the uapi
- add support for leaf parameter
- do not use arm_smmu_tlb_inv_range_nosync or arm_smmu_tlb_inv_context
  anymore

v2 -> v3:
- replace __arm_smmu_tlb_sync by arm_smmu_cmdq_issue_sync

v1 -> v2:
- properly pass the asid
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 53 +++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 73f7a56101dd..4b796693d697 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2774,6 +2774,58 @@ static void arm_smmu_detach_pasid_table(struct iommu_domain *domain)
 	mutex_unlock(&smmu_domain->init_mutex);
 }
 
+static int
+arm_smmu_cache_invalidate(struct iommu_domain *domain, struct device *dev,
+			  struct iommu_cache_invalidate_info *inv_info)
+{
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+
+	if (smmu_domain->stage != ARM_SMMU_DOMAIN_NESTED)
+		return -EINVAL;
+
+	if (!smmu)
+		return -EINVAL;
+
+	if (inv_info->version != IOMMU_CACHE_INVALIDATE_INFO_VERSION_1)
+		return -EINVAL;
+
+	if (inv_info->cache & IOMMU_CACHE_INV_TYPE_IOTLB) {
+		if (inv_info->granularity == IOMMU_INV_GRANU_PASID) {
+			struct iommu_inv_pasid_info *info =
+				&inv_info->granu.pasid_info;
+
+			if (!(info->flags & IOMMU_INV_PASID_FLAGS_ARCHID) ||
+			     (info->flags & IOMMU_INV_PASID_FLAGS_PASID))
+				return -EINVAL;
+
+			__arm_smmu_tlb_inv_context(smmu_domain, info->archid);
+
+		} else if (inv_info->granularity == IOMMU_INV_GRANU_ADDR) {
+			struct iommu_inv_addr_info *info = &inv_info->granu.addr_info;
+			size_t size = info->nb_granules * info->granule_size;
+			bool leaf = info->flags & IOMMU_INV_ADDR_FLAGS_LEAF;
+
+			if (!(info->flags & IOMMU_INV_ADDR_FLAGS_ARCHID) ||
+			     (info->flags & IOMMU_INV_ADDR_FLAGS_PASID))
+				return -EINVAL;
+
+			__arm_smmu_tlb_inv_range(info->addr, size,
+						 info->granule_size, leaf,
+						  smmu_domain, info->archid);
+
+			arm_smmu_cmdq_issue_sync(smmu);
+		} else {
+			return -EINVAL;
+		}
+	}
+	if (inv_info->cache & IOMMU_CACHE_INV_TYPE_PASID ||
+	    inv_info->cache & IOMMU_CACHE_INV_TYPE_DEV_IOTLB) {
+		return -ENOENT;
+	}
+	return 0;
+}
+
 static bool arm_smmu_dev_has_feature(struct device *dev,
 				     enum iommu_dev_features feat)
 {
@@ -2857,6 +2909,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.put_resv_regions	= generic_iommu_put_resv_regions,
 	.attach_pasid_table	= arm_smmu_attach_pasid_table,
 	.detach_pasid_table	= arm_smmu_detach_pasid_table,
+	.cache_invalidate	= arm_smmu_cache_invalidate,
 	.dev_has_feat		= arm_smmu_dev_has_feature,
 	.dev_feat_enabled	= arm_smmu_dev_feature_enabled,
 	.dev_enable_feat	= arm_smmu_dev_enable_feature,
-- 
2.21.3

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
