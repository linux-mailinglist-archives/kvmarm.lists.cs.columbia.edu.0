Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C132C655FA
	for <lists+kvmarm@lfdr.de>; Thu, 11 Jul 2019 13:50:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6DF564A53D;
	Thu, 11 Jul 2019 07:50:34 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.202
X-Spam-Level: 
X-Spam-Status: No, score=-4.202 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5, SPF_HELO_PASS=-0.001]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g6ux8X9C5Mk1; Thu, 11 Jul 2019 07:50:34 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 27BFE4A516;
	Thu, 11 Jul 2019 07:50:33 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 20A4F4A4E8
 for <kvmarm@lists.cs.columbia.edu>; Thu, 11 Jul 2019 07:50:31 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VjqRgTH3+SaM for <kvmarm@lists.cs.columbia.edu>;
 Thu, 11 Jul 2019 07:50:29 -0400 (EDT)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 311E84A4CD
 for <kvmarm@lists.cs.columbia.edu>; Thu, 11 Jul 2019 07:50:29 -0400 (EDT)
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 94BDC308FF23;
 Thu, 11 Jul 2019 11:50:28 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-46.ams2.redhat.com [10.36.116.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 652CC600CD;
 Thu, 11 Jul 2019 11:50:22 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
 alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
 yi.l.liu@intel.com, jean-philippe.brucker@arm.com, will.deacon@arm.com,
 robin.murphy@arm.com
Subject: [PATCH v9 03/14] iommu: Introduce bind/unbind_guest_msi
Date: Thu, 11 Jul 2019 13:49:48 +0200
Message-Id: <20190711114959.15675-4-eric.auger@redhat.com>
In-Reply-To: <20190711114959.15675-1-eric.auger@redhat.com>
References: <20190711114959.15675-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 11 Jul 2019 11:50:28 +0000 (UTC)
Cc: kevin.tian@intel.com, vincent.stehle@arm.com, ashok.raj@intel.com,
 marc.zyngier@arm.com
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

On ARM, MSI are translated by the SMMU. An IOVA is allocated
for each MSI doorbell. If both the host and the guest are exposed
with SMMUs, we end up with 2 different IOVAs allocated by each.
guest allocates an IOVA (gIOVA) to map onto the guest MSI
doorbell (gDB). The Host allocates another IOVA (hIOVA) to map
onto the physical doorbell (hDB).

So we end up with 2 untied mappings:
         S1            S2
gIOVA    ->    gDB
              hIOVA    ->    hDB

Currently the PCI device is programmed by the host with hIOVA
as MSI doorbell. So this does not work.

This patch introduces an API to pass gIOVA/gDB to the host so
that gIOVA can be reused by the host instead of re-allocating
a new IOVA. So the goal is to create the following nested mapping:

         S1            S2
gIOVA    ->    gDB     ->    hDB

and program the PCI device with gIOVA MSI doorbell.

In case we have several devices attached to this nested domain
(devices belonging to the same group), they cannot be isolated
on guest side either. So they should also end up in the same domain
on guest side. We will enforce that all the devices attached to
the host iommu domain use the same physical doorbell and similarly
a single virtual doorbell mapping gets registered (1 single
virtual doorbell is used on guest as well).

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
v7 -> v8:
- dummy iommu_unbind_guest_msi turned into a void function

v6 -> v7:
- remove the device handle parameter.
- Add comments saying there can only be a single MSI binding
  registered per iommu_domain
v5 -> v6:
-fix compile issue when IOMMU_API is not set

v3 -> v4:
- add unbind

v2 -> v3:
- add a struct device handle
---
 drivers/iommu/iommu.c | 37 +++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h | 20 ++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0ec72ffb8efa..ad968f579baa 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1653,6 +1653,43 @@ static void __iommu_detach_device(struct iommu_domain *domain,
 	trace_detach_device_from_domain(dev);
 }
 
+/**
+ * iommu_bind_guest_msi - Passes the stage1 GIOVA/GPA mapping of a
+ * virtual doorbell
+ *
+ * @domain: iommu domain the stage 1 mapping will be attached to
+ * @iova: iova allocated by the guest
+ * @gpa: guest physical address of the virtual doorbell
+ * @size: granule size used for the mapping
+ *
+ * The associated IOVA can be reused by the host to create a nested
+ * stage2 binding mapping translating into the physical doorbell used
+ * by the devices attached to the domain.
+ *
+ * All devices within the domain must share the same physical doorbell.
+ * A single MSI GIOVA/GPA mapping can be attached to an iommu_domain.
+ */
+
+int iommu_bind_guest_msi(struct iommu_domain *domain,
+			 dma_addr_t giova, phys_addr_t gpa, size_t size)
+{
+	if (unlikely(!domain->ops->bind_guest_msi))
+		return -ENODEV;
+
+	return domain->ops->bind_guest_msi(domain, giova, gpa, size);
+}
+EXPORT_SYMBOL_GPL(iommu_bind_guest_msi);
+
+void iommu_unbind_guest_msi(struct iommu_domain *domain,
+			    dma_addr_t iova)
+{
+	if (unlikely(!domain->ops->unbind_guest_msi))
+		return;
+
+	domain->ops->unbind_guest_msi(domain, iova);
+}
+EXPORT_SYMBOL_GPL(iommu_unbind_guest_msi);
+
 void iommu_detach_device(struct iommu_domain *domain, struct device *dev)
 {
 	struct iommu_group *group;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 0314d152df08..6d7cc326e299 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -231,6 +231,8 @@ struct iommu_sva_ops {
  * @attach_pasid_table: attach a pasid table
  * @detach_pasid_table: detach the pasid table
  * @cache_invalidate: invalidate translation caches
+ * @bind_guest_msi: provides a stage1 giova/gpa MSI doorbell mapping
+ * @unbind_guest_msi: withdraw a stage1 giova/gpa MSI doorbell mapping
  * @pgsize_bitmap: bitmap of all possible supported page sizes
  */
 struct iommu_ops {
@@ -300,6 +302,10 @@ struct iommu_ops {
 	int (*cache_invalidate)(struct iommu_domain *domain, struct device *dev,
 				struct iommu_cache_invalidate_info *inv_info);
 
+	int (*bind_guest_msi)(struct iommu_domain *domain,
+			      dma_addr_t giova, phys_addr_t gpa, size_t size);
+	void (*unbind_guest_msi)(struct iommu_domain *domain, dma_addr_t giova);
+
 	unsigned long pgsize_bitmap;
 };
 
@@ -409,6 +415,11 @@ extern void iommu_detach_pasid_table(struct iommu_domain *domain);
 extern int iommu_cache_invalidate(struct iommu_domain *domain,
 				  struct device *dev,
 				  struct iommu_cache_invalidate_info *inv_info);
+extern int iommu_bind_guest_msi(struct iommu_domain *domain,
+				dma_addr_t giova, phys_addr_t gpa, size_t size);
+extern void iommu_unbind_guest_msi(struct iommu_domain *domain,
+				   dma_addr_t giova);
+
 extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
 extern struct iommu_domain *iommu_get_dma_domain(struct device *dev);
 extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
@@ -969,6 +980,15 @@ iommu_cache_invalidate(struct iommu_domain *domain,
 	return -ENODEV;
 }
 
+static inline
+int iommu_bind_guest_msi(struct iommu_domain *domain,
+			 dma_addr_t giova, phys_addr_t gpa, size_t size)
+{
+	return -ENODEV;
+}
+static inline
+void iommu_unbind_guest_msi(struct iommu_domain *domain, dma_addr_t giova) {}
+
 #endif /* CONFIG_IOMMU_API */
 
 #ifdef CONFIG_IOMMU_DEBUGFS
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
