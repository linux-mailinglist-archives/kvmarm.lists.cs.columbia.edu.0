Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B926A3232DA
	for <lists+kvmarm@lfdr.de>; Tue, 23 Feb 2021 22:07:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F3AF74B1F2;
	Tue, 23 Feb 2021 16:07:19 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.209
X-Spam-Level: 
X-Spam-Status: No, score=0.209 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_LOW=-0.7,
	T_DKIM_INVALID=0.01] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AaY0QBSqVsIL; Tue, 23 Feb 2021 16:07:18 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7D8354B25B;
	Tue, 23 Feb 2021 16:07:17 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C02E24B196
 for <kvmarm@lists.cs.columbia.edu>; Tue, 23 Feb 2021 16:07:16 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OAyPmzKtTo8D for <kvmarm@lists.cs.columbia.edu>;
 Tue, 23 Feb 2021 16:07:15 -0500 (EST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C880F4B1B3
 for <kvmarm@lists.cs.columbia.edu>; Tue, 23 Feb 2021 16:07:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614114435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CnOB9upSv3gmXiLbJB7XG4Tyob3YoikXOx0RnJ+CFUM=;
 b=E4wu4XcAV/q3e62OBoWM5gtvWekrsT6GvVKg7LamE7E/nzdgoQ+NTDS+s8AVXeOWasxkOP
 MnvpRiqg95D6EVwj4vDgxLu0XD5jn0judMVekBOLY0CYvxkFyFcc/GZfwDePX8fSO0GIFZ
 Uk7CqKn2/d/0JWuMQ5+oH7jKaqjJ9GI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-q7OeracxNimw3F203Asihg-1; Tue, 23 Feb 2021 16:06:42 -0500
X-MC-Unique: q7OeracxNimw3F203Asihg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 788208030CC;
 Tue, 23 Feb 2021 21:06:39 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-114-34.ams2.redhat.com [10.36.114.34])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0F23E5D9D0;
 Tue, 23 Feb 2021 21:06:33 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, will@kernel.org,
 maz@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
 alex.williamson@redhat.com, tn@semihalf.com, zhukeqian1@huawei.com
Subject: [PATCH v12 01/13] vfio: VFIO_IOMMU_SET_PASID_TABLE
Date: Tue, 23 Feb 2021 22:06:13 +0100
Message-Id: <20210223210625.604517-2-eric.auger@redhat.com>
In-Reply-To: <20210223210625.604517-1-eric.auger@redhat.com>
References: <20210223210625.604517-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: jean-philippe@linaro.org, jacob.jun.pan@linux.intel.com,
 wangxingang5@huawei.com, lushenming@huawei.com, nicoleotsuka@gmail.com,
 vivek.gautam@arm.com, yi.l.liu@intel.com, vsethi@nvidia.com,
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

From: "Liu, Yi L" <yi.l.liu@linux.intel.com>

This patch adds an VFIO_IOMMU_SET_PASID_TABLE ioctl
which aims to pass the virtual iommu guest configuration
to the host. This latter takes the form of the so-called
PASID table.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
v11 -> v12:
- use iommu_uapi_set_pasid_table
- Rework the flags checks [Zenghui, Alex]
- use VFIO_BASE + 19 [Alex]
- rework the unwind in vfio_attach_pasid_table() [Alex]

v8 -> v9:
- Merge VFIO_IOMMU_ATTACH/DETACH_PASID_TABLE into a single
  VFIO_IOMMU_SET_PASID_TABLE ioctl.

v6 -> v7:
- add a comment related to VFIO_IOMMU_DETACH_PASID_TABLE

v3 -> v4:
- restore ATTACH/DETACH
- add unwind on failure

v2 -> v3:
- s/BIND_PASID_TABLE/SET_PASID_TABLE

v1 -> v2:
- s/BIND_GUEST_STAGE/BIND_PASID_TABLE
- remove the struct device arg
---
 drivers/vfio/vfio_iommu_type1.c | 58 +++++++++++++++++++++++++++++++++
 include/uapi/linux/vfio.h       | 19 +++++++++++
 2 files changed, 77 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 0b4dedaa9128..50c4f8ae5b03 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -2587,6 +2587,39 @@ static int vfio_iommu_iova_build_caps(struct vfio_iommu *iommu,
 	return ret;
 }
 
+static void
+vfio_detach_pasid_table(struct vfio_iommu *iommu)
+{
+	struct vfio_domain *d;
+
+	mutex_lock(&iommu->lock);
+	list_for_each_entry(d, &iommu->domain_list, next)
+		iommu_detach_pasid_table(d->domain);
+
+	mutex_unlock(&iommu->lock);
+}
+
+static int
+vfio_attach_pasid_table(struct vfio_iommu *iommu, unsigned long arg)
+{
+	struct vfio_domain *d;
+	int ret = 0;
+
+	mutex_lock(&iommu->lock);
+
+	list_for_each_entry(d, &iommu->domain_list, next) {
+		ret = iommu_uapi_attach_pasid_table(d->domain, (void __user *)arg);
+		if (ret) {
+			list_for_each_entry_continue_reverse(d, &iommu->domain_list, next)
+				iommu_detach_pasid_table(d->domain);
+			break;
+		}
+	}
+
+	mutex_unlock(&iommu->lock);
+	return ret;
+}
+
 static int vfio_iommu_migration_build_caps(struct vfio_iommu *iommu,
 					   struct vfio_info_cap *caps)
 {
@@ -2747,6 +2780,29 @@ static int vfio_iommu_type1_unmap_dma(struct vfio_iommu *iommu,
 			-EFAULT : 0;
 }
 
+static int vfio_iommu_type1_set_pasid_table(struct vfio_iommu *iommu,
+					    unsigned long arg)
+{
+	struct vfio_iommu_type1_set_pasid_table spt;
+	unsigned long minsz;
+
+	minsz = offsetofend(struct vfio_iommu_type1_set_pasid_table, flags);
+
+	if (copy_from_user(&spt, (void __user *)arg, minsz))
+		return -EFAULT;
+
+	if (spt.argsz < minsz)
+		return -EINVAL;
+
+	if (spt.flags == VFIO_PASID_TABLE_FLAG_SET) {
+		return vfio_attach_pasid_table(iommu, arg + minsz);
+	} else if (spt.flags == VFIO_PASID_TABLE_FLAG_UNSET) {
+		vfio_detach_pasid_table(iommu);
+		return 0;
+	}
+	return -EINVAL;
+}
+
 static int vfio_iommu_type1_dirty_pages(struct vfio_iommu *iommu,
 					unsigned long arg)
 {
@@ -2867,6 +2923,8 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
 		return vfio_iommu_type1_unmap_dma(iommu, arg);
 	case VFIO_IOMMU_DIRTY_PAGES:
 		return vfio_iommu_type1_dirty_pages(iommu, arg);
+	case VFIO_IOMMU_SET_PASID_TABLE:
+		return vfio_iommu_type1_set_pasid_table(iommu, arg);
 	default:
 		return -ENOTTY;
 	}
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index d1812777139f..6d77779c941d 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -14,6 +14,7 @@
 
 #include <linux/types.h>
 #include <linux/ioctl.h>
+#include <linux/iommu.h>
 
 #define VFIO_API_VERSION	0
 
@@ -1181,6 +1182,24 @@ struct vfio_iommu_type1_dirty_bitmap_get {
 
 #define VFIO_IOMMU_DIRTY_PAGES             _IO(VFIO_TYPE, VFIO_BASE + 17)
 
+/*
+ * VFIO_IOMMU_SET_PASID_TABLE - _IOWR(VFIO_TYPE, VFIO_BASE + 18,
+ *			struct vfio_iommu_type1_set_pasid_table)
+ *
+ * The SET operation passes a PASID table to the host while the
+ * UNSET operation detaches the one currently programmed. Setting
+ * a table while another is already programmed replaces the old table.
+ */
+struct vfio_iommu_type1_set_pasid_table {
+	__u32	argsz;
+	__u32	flags;
+#define VFIO_PASID_TABLE_FLAG_SET	(1 << 0)
+#define VFIO_PASID_TABLE_FLAG_UNSET	(1 << 1)
+	struct iommu_pasid_table_config config; /* used on SET */
+};
+
+#define VFIO_IOMMU_SET_PASID_TABLE	_IO(VFIO_TYPE, VFIO_BASE + 18)
+
 /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU -------- */
 
 /*
-- 
2.26.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
