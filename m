Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B5C3A35B35F
	for <lists+kvmarm@lfdr.de>; Sun, 11 Apr 2021 13:14:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6475B4B92B;
	Sun, 11 Apr 2021 07:14:11 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.209
X-Spam-Level: 
X-Spam-Status: No, score=0.209 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_LOW=-0.7,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EHx9PyLPtJNB; Sun, 11 Apr 2021 07:14:11 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3CC1F4B64A;
	Sun, 11 Apr 2021 07:14:10 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 414874B4AD
 for <kvmarm@lists.cs.columbia.edu>; Sun, 11 Apr 2021 07:14:09 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CmA6yNyZnT9H for <kvmarm@lists.cs.columbia.edu>;
 Sun, 11 Apr 2021 07:14:08 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 34E2C4B916
 for <kvmarm@lists.cs.columbia.edu>; Sun, 11 Apr 2021 07:14:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618139647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4cFlj/1AeQfl9sLv9z3wLrqxiFp8jmwkjiJsT07pmm8=;
 b=gSekCUcp1voc9PkfYiI0avHCpC4VihfXvt9y5/+Wpq9Kdq/uDn7LOM8wyfAppu3qYuVbPv
 u31dWONUcibjj4uxDkTEuerv+QIYbvpHxw1c+JpdRz+GlwH92eWOye9fMIGpx4fFWXIMpK
 1b9bBQoWcV28EBhRszPuNYb+kvUVj4Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318---LZYghMOO-qmosDt4pXtg-1; Sun, 11 Apr 2021 07:14:04 -0400
X-MC-Unique: --LZYghMOO-qmosDt4pXtg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9CDED80D6A8;
 Sun, 11 Apr 2021 11:14:01 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-112-22.ams2.redhat.com [10.36.112.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4E76B100164A;
 Sun, 11 Apr 2021 11:13:54 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, will@kernel.org,
 maz@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
 alex.williamson@redhat.com, tn@semihalf.com, zhukeqian1@huawei.com
Subject: [PATCH v15 07/12] iommu/smmuv3: Implement cache_invalidate
Date: Sun, 11 Apr 2021 13:12:23 +0200
Message-Id: <20210411111228.14386-8-eric.auger@redhat.com>
In-Reply-To: <20210411111228.14386-1-eric.auger@redhat.com>
References: <20210411111228.14386-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: jean-philippe@linaro.org, jacob.jun.pan@linux.intel.com,
 wangxingang5@huawei.com, lushenming@huawei.com, chenxiang66@hisilicon.com,
 nicoleotsuka@gmail.com, vivek.gautam@arm.com, vdumpa@nvidia.com,
 yi.l.liu@intel.com, vsethi@nvidia.com, zhangfei.gao@linaro.org
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

Implement domain-selective, pasid selective and page-selective
IOTLB invalidations.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
v4 -> v15:
- remove the redundant arm_smmu_cmdq_issue_sync(smmu)
  in IOMMU_INV_GRANU_ADDR case (Zenghui)
- if RIL is not supported by the host, make sure the granule_size
  that is passed by the userspace is supported or fix it
  (Chenxiang)

v13 -> v14:
- Add domain invalidation
- do global inval when asid is not provided with addr
  granularity

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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 89 +++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 56a301fbe75a..bfc112cc0d38 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2961,6 +2961,94 @@ static void arm_smmu_detach_pasid_table(struct iommu_domain *domain)
 	mutex_unlock(&smmu_domain->init_mutex);
 }
 
+static int
+arm_smmu_cache_invalidate(struct iommu_domain *domain, struct device *dev,
+			  struct iommu_cache_invalidate_info *inv_info)
+{
+	struct arm_smmu_cmdq_ent cmd = {.opcode = CMDQ_OP_TLBI_NSNH_ALL};
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
+	if (inv_info->cache & IOMMU_CACHE_INV_TYPE_PASID ||
+	    inv_info->cache & IOMMU_CACHE_INV_TYPE_DEV_IOTLB) {
+		return -ENOENT;
+	}
+
+	if (!(inv_info->cache & IOMMU_CACHE_INV_TYPE_IOTLB))
+		return -EINVAL;
+
+	/* IOTLB invalidation */
+
+	switch (inv_info->granularity) {
+	case IOMMU_INV_GRANU_PASID:
+	{
+		struct iommu_inv_pasid_info *info =
+			&inv_info->granu.pasid_info;
+
+		if (info->flags & IOMMU_INV_ADDR_FLAGS_PASID)
+			return -ENOENT;
+		if (!(info->flags & IOMMU_INV_PASID_FLAGS_ARCHID))
+			return -EINVAL;
+
+		__arm_smmu_tlb_inv_context(smmu_domain, info->archid);
+		return 0;
+	}
+	case IOMMU_INV_GRANU_ADDR:
+	{
+		struct iommu_inv_addr_info *info = &inv_info->granu.addr_info;
+		size_t granule_size  = info->granule_size;
+		size_t size = info->nb_granules * info->granule_size;
+		bool leaf = info->flags & IOMMU_INV_ADDR_FLAGS_LEAF;
+		int tg;
+
+		if (info->flags & IOMMU_INV_ADDR_FLAGS_PASID)
+			return -ENOENT;
+
+		if (!(info->flags & IOMMU_INV_ADDR_FLAGS_ARCHID))
+			break;
+
+		tg = __ffs(granule_size);
+		if (granule_size & ~(1 << tg))
+			return -EINVAL;
+		/*
+		 * When RIL is not supported, make sure the granule size that is
+		 * passed is supported. In RIL mode, this is enforced in
+		 * __arm_smmu_tlb_inv_range()
+		 */
+		if (!(smmu->features & ARM_SMMU_FEAT_RANGE_INV) &&
+		    !(granule_size & smmu_domain->domain.pgsize_bitmap)) {
+			tg = __ffs(smmu_domain->domain.pgsize_bitmap);
+			granule_size = 1 << tg;
+			size = size >> tg;
+		}
+
+		arm_smmu_tlb_inv_range_domain(info->addr, size,
+					      granule_size, leaf,
+					      info->archid, smmu_domain);
+		return 0;
+	}
+	case IOMMU_INV_GRANU_DOMAIN:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Global S1 invalidation */
+	cmd.tlbi.vmid   = smmu_domain->s2_cfg.vmid;
+	arm_smmu_cmdq_issue_cmd(smmu, &cmd);
+	arm_smmu_cmdq_issue_sync(smmu);
+	return 0;
+}
+
 static bool arm_smmu_dev_has_feature(struct device *dev,
 				     enum iommu_dev_features feat)
 {
@@ -3060,6 +3148,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.put_resv_regions	= generic_iommu_put_resv_regions,
 	.attach_pasid_table	= arm_smmu_attach_pasid_table,
 	.detach_pasid_table	= arm_smmu_detach_pasid_table,
+	.cache_invalidate	= arm_smmu_cache_invalidate,
 	.dev_has_feat		= arm_smmu_dev_has_feature,
 	.dev_feat_enabled	= arm_smmu_dev_feature_enabled,
 	.dev_enable_feat	= arm_smmu_dev_enable_feature,
-- 
2.26.3

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
