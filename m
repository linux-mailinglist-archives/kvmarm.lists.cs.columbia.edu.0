Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 25DD235B3A3
	for <lists+kvmarm@lfdr.de>; Sun, 11 Apr 2021 13:47:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CCD634B922;
	Sun, 11 Apr 2021 07:47:52 -0400 (EDT)
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
	with ESMTP id GUdD9Mc3a7k9; Sun, 11 Apr 2021 07:47:52 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A5CFB4B94B;
	Sun, 11 Apr 2021 07:47:51 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CD2AA4B928
 for <kvmarm@lists.cs.columbia.edu>; Sun, 11 Apr 2021 07:47:50 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gesGPdKjCpF4 for <kvmarm@lists.cs.columbia.edu>;
 Sun, 11 Apr 2021 07:47:49 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C57FE4B922
 for <kvmarm@lists.cs.columbia.edu>; Sun, 11 Apr 2021 07:47:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618141669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GWBn2pGGSnHdG7o5YvDEJyTOBfnDH25v4QYLcfP4dMs=;
 b=iMw9YSTxN1++KjIh1uVbxw2gbE/YGfVeVnJnqEBVw0aY5RQRbEHYzjtVgcYsFyfLRAb354
 MUUWStQ2dFtwa8P1hgZ9rDGBkSVe5NAcmgRuJN6JT/I0InyqNI+eps0qyHk2iP1ZI1gq5j
 V35vaP47zdPUil6jy5q/RzymFjEO2x8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-3AcOUmryMnyh-9Oelzdzvg-1; Sun, 11 Apr 2021 07:47:46 -0400
X-MC-Unique: 3AcOUmryMnyh-9Oelzdzvg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A98421006701;
 Sun, 11 Apr 2021 11:47:43 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-112-22.ams2.redhat.com [10.36.112.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EABDE5C266;
 Sun, 11 Apr 2021 11:47:29 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, will@kernel.org,
 maz@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
 alex.williamson@redhat.com, tn@semihalf.com, zhukeqian1@huawei.com
Subject: [PATCH v13 02/13] vfio: VFIO_IOMMU_CACHE_INVALIDATE
Date: Sun, 11 Apr 2021 13:46:48 +0200
Message-Id: <20210411114659.15051-3-eric.auger@redhat.com>
In-Reply-To: <20210411114659.15051-1-eric.auger@redhat.com>
References: <20210411114659.15051-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

From: "Liu, Yi L" <yi.l.liu@linux.intel.com>

When the guest "owns" the stage 1 translation structures,  the host
IOMMU driver has no knowledge of caching structure updates unless
the guest invalidation requests are trapped and passed down to the
host.

This patch adds the VFIO_IOMMU_CACHE_INVALIDATE ioctl with aims
at propagating guest stage1 IOMMU cache invalidations to the host.

Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v12 -> v13:
- resolve minor conflict due to
  898b9eaeb3fe ("vfio/type1: block on invalid vaddr")
v11 -> v12:
- share VFIO_BASE + 19 with VFIO_IOMMU_SPAPR_TCE_CREATE

v10 -> v11:
- renamed ustruct into cache_inv

v8 -> v9:
- change the ioctl ID

v6 -> v7:
- Use iommu_capsule struct
- renamed vfio_iommu_for_each_dev into vfio_iommu_lookup_dev
  due to checkpatch error related to for_each_dev suffix

v2 -> v3:
- introduce vfio_iommu_for_each_dev back in this patch

v1 -> v2:
- s/TLB/CACHE
- remove vfio_iommu_task usage
- commit message rewording
---
 drivers/vfio/vfio_iommu_type1.c | 58 +++++++++++++++++++++++++++++++++
 include/uapi/linux/vfio.h       | 13 ++++++++
 2 files changed, 71 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index e575ef5dd6c6..34f8dca36ebe 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -159,6 +159,34 @@ struct vfio_regions {
 
 #define WAITED 1
 
+struct domain_capsule {
+	struct iommu_domain *domain;
+	void *data;
+};
+
+/* iommu->lock must be held */
+static int
+vfio_iommu_lookup_dev(struct vfio_iommu *iommu,
+		      int (*fn)(struct device *dev, void *data),
+		      unsigned long arg)
+{
+	struct domain_capsule dc = {.data = &arg};
+	struct vfio_domain *d;
+	struct vfio_group *g;
+	int ret = 0;
+
+	list_for_each_entry(d, &iommu->domain_list, next) {
+		dc.domain = d->domain;
+		list_for_each_entry(g, &d->group_list, next) {
+			ret = iommu_group_for_each_dev(g->iommu_group,
+						       &dc, fn);
+			if (ret)
+				break;
+		}
+	}
+	return ret;
+}
+
 static int put_pfn(unsigned long pfn, int prot);
 
 static struct vfio_group *vfio_iommu_find_iommu_group(struct vfio_iommu *iommu,
@@ -2866,6 +2894,13 @@ vfio_attach_pasid_table(struct vfio_iommu *iommu, unsigned long arg)
 	mutex_unlock(&iommu->lock);
 	return ret;
 }
+static int vfio_cache_inv_fn(struct device *dev, void *data)
+{
+	struct domain_capsule *dc = (struct domain_capsule *)data;
+	unsigned long arg = *(unsigned long *)dc->data;
+
+	return iommu_uapi_cache_invalidate(dc->domain, dev, (void __user *)arg);
+}
 
 static int vfio_iommu_migration_build_caps(struct vfio_iommu *iommu,
 					   struct vfio_info_cap *caps)
@@ -3058,6 +3093,27 @@ static int vfio_iommu_type1_set_pasid_table(struct vfio_iommu *iommu,
 	return -EINVAL;
 }
 
+static int vfio_iommu_type1_cache_invalidate(struct vfio_iommu *iommu,
+					    unsigned long arg)
+{
+	struct vfio_iommu_type1_cache_invalidate cache_inv;
+	unsigned long minsz;
+	int ret;
+
+	minsz = offsetofend(struct vfio_iommu_type1_cache_invalidate, flags);
+
+	if (copy_from_user(&cache_inv, (void __user *)arg, minsz))
+		return -EFAULT;
+
+	if (cache_inv.argsz < minsz || cache_inv.flags)
+		return -EINVAL;
+
+	mutex_lock(&iommu->lock);
+	ret = vfio_iommu_lookup_dev(iommu, vfio_cache_inv_fn, arg + minsz);
+	mutex_unlock(&iommu->lock);
+	return ret;
+}
+
 static int vfio_iommu_type1_dirty_pages(struct vfio_iommu *iommu,
 					unsigned long arg)
 {
@@ -3180,6 +3236,8 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
 		return vfio_iommu_type1_dirty_pages(iommu, arg);
 	case VFIO_IOMMU_SET_PASID_TABLE:
 		return vfio_iommu_type1_set_pasid_table(iommu, arg);
+	case VFIO_IOMMU_CACHE_INVALIDATE:
+		return vfio_iommu_type1_cache_invalidate(iommu, arg);
 	default:
 		return -ENOTTY;
 	}
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index c86b7b4a5064..ada42121827a 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1228,6 +1228,19 @@ struct vfio_iommu_type1_set_pasid_table {
 
 #define VFIO_IOMMU_SET_PASID_TABLE	_IO(VFIO_TYPE, VFIO_BASE + 18)
 
+/**
+ * VFIO_IOMMU_CACHE_INVALIDATE - _IOWR(VFIO_TYPE, VFIO_BASE + 19,
+ *			struct vfio_iommu_type1_cache_invalidate)
+ *
+ * Propagate guest IOMMU cache invalidation to the host.
+ */
+struct vfio_iommu_type1_cache_invalidate {
+	__u32   argsz;
+	__u32   flags;
+	struct iommu_cache_invalidate_info info;
+};
+#define VFIO_IOMMU_CACHE_INVALIDATE      _IO(VFIO_TYPE, VFIO_BASE + 19)
+
 /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU -------- */
 
 /*
-- 
2.26.3

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
