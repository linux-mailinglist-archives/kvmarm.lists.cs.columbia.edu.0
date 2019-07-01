Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD072AAAC
	for <lists+kvmarm@lfdr.de>; Sun, 26 May 2019 18:10:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DD0124A4AA;
	Sun, 26 May 2019 12:10:44 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.202
X-Spam-Level: 
X-Spam-Status: No, score=-4.202 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5, SPF_HELO_PASS=-0.001]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ari5LBkUuA5W; Sun, 26 May 2019 12:10:44 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DE1B74A50C;
	Sun, 26 May 2019 12:10:42 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4EA764A4E9
 for <kvmarm@lists.cs.columbia.edu>; Sun, 26 May 2019 12:10:42 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hMzCdytS99GT for <kvmarm@lists.cs.columbia.edu>;
 Sun, 26 May 2019 12:10:40 -0400 (EDT)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 59FE04A380
 for <kvmarm@lists.cs.columbia.edu>; Sun, 26 May 2019 12:10:40 -0400 (EDT)
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B1CC03086209;
 Sun, 26 May 2019 16:10:39 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-67.ams2.redhat.com [10.36.116.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CA72D5DD81;
 Sun, 26 May 2019 16:10:35 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
 alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
 yi.l.liu@intel.com, jean-philippe.brucker@arm.com, will.deacon@arm.com,
 robin.murphy@arm.com
Subject: [PATCH v8 04/29] iommu: Add recoverable fault reporting
Date: Sun, 26 May 2019 18:09:39 +0200
Message-Id: <20190526161004.25232-5-eric.auger@redhat.com>
In-Reply-To: <20190526161004.25232-1-eric.auger@redhat.com>
References: <20190526161004.25232-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Sun, 26 May 2019 16:10:39 +0000 (UTC)
Cc: marc.zyngier@arm.com, kevin.tian@intel.com, vincent.stehle@arm.com,
 ashok.raj@intel.com
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

From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

Some IOMMU hardware features, for example PCI's PRI and Arm SMMU's Stall,
enable recoverable I/O page faults. Allow IOMMU drivers to report PRI Page
Requests and Stall events through the new fault reporting API. The
consumer of the fault can be either an I/O page fault handler in the host,
or a guest OS.

Once handled, the fault must be completed by sending a page response back
to the IOMMU. Add an iommu_page_response() function to complete a page
fault.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/iommu.c | 77 ++++++++++++++++++++++++++++++++++++++++++-
 include/linux/iommu.h | 51 ++++++++++++++++++++++++++++
 2 files changed, 127 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 795518445a3a..13b301cfb10f 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -869,7 +869,14 @@ EXPORT_SYMBOL_GPL(iommu_group_unregister_notifier);
  * @data: private data passed as argument to the handler
  *
  * When an IOMMU fault event is received, this handler gets called with the
- * fault event and data as argument.
+ * fault event and data as argument. The handler should return 0 on success. If
+ * the fault is recoverable (IOMMU_FAULT_PAGE_REQ), the handler should also
+ * complete the fault by calling iommu_page_response() with one of the following
+ * response code:
+ * - IOMMU_PAGE_RESP_SUCCESS: retry the translation
+ * - IOMMU_PAGE_RESP_INVALID: terminate the fault
+ * - IOMMU_PAGE_RESP_FAILURE: terminate the fault and stop reporting
+ *   page faults if possible.
  *
  * Return 0 if the fault handler was installed successfully, or an error.
  */
@@ -904,6 +911,8 @@ int iommu_register_device_fault_handler(struct device *dev,
 	}
 	param->fault_param->handler = handler;
 	param->fault_param->data = data;
+	mutex_init(&param->fault_param->lock);
+	INIT_LIST_HEAD(&param->fault_param->faults);
 
 done_unlock:
 	mutex_unlock(&param->lock);
@@ -934,6 +943,12 @@ int iommu_unregister_device_fault_handler(struct device *dev)
 	if (!param->fault_param)
 		goto unlock;
 
+	/* we cannot unregister handler if there are pending faults */
+	if (!list_empty(&param->fault_param->faults)) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+
 	kfree(param->fault_param);
 	param->fault_param = NULL;
 	put_device(dev);
@@ -958,6 +973,7 @@ EXPORT_SYMBOL_GPL(iommu_unregister_device_fault_handler);
 int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt)
 {
 	struct iommu_param *param = dev->iommu_param;
+	struct iommu_fault_event *evt_pending;
 	struct iommu_fault_param *fparam;
 	int ret = 0;
 
@@ -972,6 +988,20 @@ int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt)
 		ret = -EINVAL;
 		goto done_unlock;
 	}
+
+	if (evt->fault.type == IOMMU_FAULT_PAGE_REQ &&
+	    (evt->fault.prm.flags & IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE)) {
+		evt_pending = kmemdup(evt, sizeof(struct iommu_fault_event),
+				      GFP_KERNEL);
+		if (!evt_pending) {
+			ret = -ENOMEM;
+			goto done_unlock;
+		}
+		mutex_lock(&fparam->lock);
+		list_add_tail(&evt_pending->list, &fparam->faults);
+		mutex_unlock(&fparam->lock);
+	}
+
 	ret = fparam->handler(evt, fparam->data);
 done_unlock:
 	mutex_unlock(&param->lock);
@@ -1513,6 +1543,51 @@ int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
 }
 EXPORT_SYMBOL_GPL(iommu_attach_device);
 
+int iommu_page_response(struct device *dev,
+			struct page_response_msg *msg)
+{
+	struct iommu_param *param = dev->iommu_param;
+	int ret = -EINVAL;
+	struct iommu_fault_event *evt;
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+
+	if (!domain || !domain->ops->page_response)
+		return -ENODEV;
+
+	/*
+	 * Device iommu_param should have been allocated when device is
+	 * added to its iommu_group.
+	 */
+	if (!param || !param->fault_param)
+		return -EINVAL;
+
+	/* Only send response if there is a fault report pending */
+	mutex_lock(&param->fault_param->lock);
+	if (list_empty(&param->fault_param->faults)) {
+		pr_warn("no pending PRQ, drop response\n");
+		goto done_unlock;
+	}
+	/*
+	 * Check if we have a matching page request pending to respond,
+	 * otherwise return -EINVAL
+	 */
+	list_for_each_entry(evt, &param->fault_param->faults, list) {
+		if (evt->fault.prm.pasid == msg->pasid &&
+		    evt->fault.prm.grpid == msg->grpid) {
+			msg->iommu_data = evt->iommu_private;
+			ret = domain->ops->page_response(dev, msg);
+			list_del(&evt->list);
+			kfree(evt);
+			break;
+		}
+	}
+
+done_unlock:
+	mutex_unlock(&param->fault_param->lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_page_response);
+
 static void __iommu_detach_device(struct iommu_domain *domain,
 				  struct device *dev)
 {
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index b87b74c63cf9..950347be47f9 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -191,6 +191,42 @@ struct iommu_sva_ops {
 
 #ifdef CONFIG_IOMMU_API
 
+/**
+ * enum page_response_code - Return status of fault handlers, telling the IOMMU
+ * driver how to proceed with the fault.
+ *
+ * @IOMMU_PAGE_RESP_SUCCESS: Fault has been handled and the page tables
+ *	populated, retry the access. This is "Success" in PCI PRI.
+ * @IOMMU_PAGE_RESP_FAILURE: General error. Drop all subsequent faults from
+ *	this device if possible. This is "Response Failure" in PCI PRI.
+ * @IOMMU_PAGE_RESP_INVALID: Could not handle this fault, don't retry the
+ *	access. This is "Invalid Request" in PCI PRI.
+ */
+enum page_response_code {
+	IOMMU_PAGE_RESP_SUCCESS = 0,
+	IOMMU_PAGE_RESP_INVALID,
+	IOMMU_PAGE_RESP_FAILURE,
+};
+
+/**
+ * struct page_response_msg - Generic page response information based on PCI ATS
+ *                            and PASID spec
+ * @addr: servicing page address
+ * @pasid: contains process address space ID
+ * @pasid_present: the @pasid field is valid
+ * @resp_code: response code
+ * @grpid: page request group index
+ * @iommu_data: data private to the IOMMU
+ */
+struct page_response_msg {
+	u64 addr;
+	u32 pasid;
+	u32 pasid_present:1;
+	enum page_response_code resp_code;
+	u32 grpid;
+	u64 iommu_data;
+};
+
 /**
  * struct iommu_ops - iommu ops and capabilities
  * @capable: check capability
@@ -227,6 +263,7 @@ struct iommu_sva_ops {
  * @sva_bind: Bind process address space to device
  * @sva_unbind: Unbind process address space from device
  * @sva_get_pasid: Get PASID associated to a SVA handle
+ * @page_response: handle page request response
  * @pgsize_bitmap: bitmap of all possible supported page sizes
  */
 struct iommu_ops {
@@ -287,6 +324,8 @@ struct iommu_ops {
 	void (*sva_unbind)(struct iommu_sva *handle);
 	int (*sva_get_pasid)(struct iommu_sva *handle);
 
+	int (*page_response)(struct device *dev, struct page_response_msg *msg);
+
 	unsigned long pgsize_bitmap;
 };
 
@@ -311,11 +350,13 @@ struct iommu_device {
  * unrecoverable faults such as DMA or IRQ remapping faults.
  *
  * @fault: fault descriptor
+ * @list: pending fault event list, used for tracking responses
  * @iommu_private: used by the IOMMU driver for storing fault-specific
  *                 data. Users should not modify this field before
  *                 sending the fault response.
  */
 struct iommu_fault_event {
+	struct list_head list;
 	struct iommu_fault fault;
 	u64 iommu_private;
 };
@@ -325,10 +366,14 @@ struct iommu_fault_event {
  *
  * @handler: Callback function to handle IOMMU faults at device level
  * @data: handler private data
+ * @faults: holds the pending faults which needs response, e.g. page response.
+ * @lock: protect pending faults list
  */
 struct iommu_fault_param {
 	iommu_dev_fault_handler_t handler;
 	void *data;
+	struct list_head faults;
+	struct mutex lock;
 };
 
 /**
@@ -443,6 +488,7 @@ extern int iommu_unregister_device_fault_handler(struct device *dev);
 extern int iommu_report_device_fault(struct device *dev,
 				     struct iommu_fault_event *evt);
 
+extern int iommu_page_response(struct device *dev, struct page_response_msg *msg);
 extern int iommu_group_id(struct iommu_group *group);
 extern struct iommu_group *iommu_group_get_for_dev(struct device *dev);
 extern struct iommu_domain *iommu_group_default_domain(struct iommu_group *);
@@ -770,6 +816,11 @@ int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt)
 	return -ENODEV;
 }
 
+static inline int iommu_page_response(struct device *dev, struct page_response_msg *msg)
+{
+	return -ENODEV;
+}
+
 static inline int iommu_group_id(struct iommu_group *group)
 {
 	return -ENODEV;
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
