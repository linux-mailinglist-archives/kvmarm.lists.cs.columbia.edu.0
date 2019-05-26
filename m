Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 87F9E2AAAA
	for <lists+kvmarm@lfdr.de>; Sun, 26 May 2019 18:10:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3630D4A4EC;
	Sun, 26 May 2019 12:10:43 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.202
X-Spam-Level: 
X-Spam-Status: No, score=-4.202 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5, SPF_HELO_PASS=-0.001]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jnZrx9zmInDa; Sun, 26 May 2019 12:10:41 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BD28F4A4F6;
	Sun, 26 May 2019 12:10:41 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 382584A49F
 for <kvmarm@lists.cs.columbia.edu>; Sun, 26 May 2019 12:10:40 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IQb8q5Lc+WIA for <kvmarm@lists.cs.columbia.edu>;
 Sun, 26 May 2019 12:10:39 -0400 (EDT)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 3A13E4A4FF
 for <kvmarm@lists.cs.columbia.edu>; Sun, 26 May 2019 12:10:36 -0400 (EDT)
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 74CFF81F2F;
 Sun, 26 May 2019 16:10:35 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-67.ams2.redhat.com [10.36.116.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A1BA24FA39;
 Sun, 26 May 2019 16:10:25 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
 alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
 yi.l.liu@intel.com, jean-philippe.brucker@arm.com, will.deacon@arm.com,
 robin.murphy@arm.com
Subject: [PATCH v8 03/29] iommu: Introduce device fault report API
Date: Sun, 26 May 2019 18:09:38 +0200
Message-Id: <20190526161004.25232-4-eric.auger@redhat.com>
In-Reply-To: <20190526161004.25232-1-eric.auger@redhat.com>
References: <20190526161004.25232-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Sun, 26 May 2019 16:10:35 +0000 (UTC)
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

From: Jacob Pan <jacob.jun.pan@linux.intel.com>

Traditionally, device specific faults are detected and handled within
their own device drivers. When IOMMU is enabled, faults such as DMA
related transactions are detected by IOMMU. There is no generic
reporting mechanism to report faults back to the in-kernel device
driver or the guest OS in case of assigned devices.

This patch introduces a registration API for device specific fault
handlers. This differs from the existing iommu_set_fault_handler/
report_iommu_fault infrastructures in several ways:
- it allows to report more sophisticated fault events (both
  unrecoverable faults and page request faults) due to the nature
  of the iommu_fault struct
- it is device specific and not domain specific.

The current iommu_report_device_fault() implementation only handles
the "shoot and forget" unrecoverable fault case. Handling of page
request faults or stalled faults will come later.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 drivers/iommu/iommu.c | 127 +++++++++++++++++++++++++++++++++++++++++-
 include/linux/iommu.h |  33 ++++++++++-
 2 files changed, 157 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 67ee6623f9b2..795518445a3a 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -644,6 +644,13 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 		goto err_free_name;
 	}
 
+	dev->iommu_param = kzalloc(sizeof(*dev->iommu_param), GFP_KERNEL);
+	if (!dev->iommu_param) {
+		ret = -ENOMEM;
+		goto err_free_name;
+	}
+	mutex_init(&dev->iommu_param->lock);
+
 	kobject_get(group->devices_kobj);
 
 	dev->iommu_group = group;
@@ -674,6 +681,7 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 	mutex_unlock(&group->mutex);
 	dev->iommu_group = NULL;
 	kobject_put(group->devices_kobj);
+	kfree(dev->iommu_param);
 err_free_name:
 	kfree(device->name);
 err_remove_link:
@@ -720,7 +728,7 @@ void iommu_group_remove_device(struct device *dev)
 	sysfs_remove_link(&dev->kobj, "iommu_group");
 
 	trace_remove_device_from_group(group->id, dev);
-
+	kfree(dev->iommu_param);
 	kfree(device->name);
 	kfree(device);
 	dev->iommu_group = NULL;
@@ -854,6 +862,123 @@ int iommu_group_unregister_notifier(struct iommu_group *group,
 }
 EXPORT_SYMBOL_GPL(iommu_group_unregister_notifier);
 
+/**
+ * iommu_register_device_fault_handler() - Register a device fault handler
+ * @dev: the device
+ * @handler: the fault handler
+ * @data: private data passed as argument to the handler
+ *
+ * When an IOMMU fault event is received, this handler gets called with the
+ * fault event and data as argument.
+ *
+ * Return 0 if the fault handler was installed successfully, or an error.
+ */
+int iommu_register_device_fault_handler(struct device *dev,
+					iommu_dev_fault_handler_t handler,
+					void *data)
+{
+	struct iommu_param *param = dev->iommu_param;
+	int ret = 0;
+
+	/*
+	 * Device iommu_param should have been allocated when device is
+	 * added to its iommu_group.
+	 */
+	if (!param)
+		return -EINVAL;
+
+	mutex_lock(&param->lock);
+	/* Only allow one fault handler registered for each device */
+	if (param->fault_param) {
+		ret = -EBUSY;
+		goto done_unlock;
+	}
+
+	get_device(dev);
+	param->fault_param =
+		kzalloc(sizeof(struct iommu_fault_param), GFP_KERNEL);
+	if (!param->fault_param) {
+		put_device(dev);
+		ret = -ENOMEM;
+		goto done_unlock;
+	}
+	param->fault_param->handler = handler;
+	param->fault_param->data = data;
+
+done_unlock:
+	mutex_unlock(&param->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_register_device_fault_handler);
+
+/**
+ * iommu_unregister_device_fault_handler() - Unregister the device fault handler
+ * @dev: the device
+ *
+ * Remove the device fault handler installed with
+ * iommu_register_device_fault_handler().
+ *
+ * Return 0 on success, or an error.
+ */
+int iommu_unregister_device_fault_handler(struct device *dev)
+{
+	struct iommu_param *param = dev->iommu_param;
+	int ret = 0;
+
+	if (!param)
+		return -EINVAL;
+
+	mutex_lock(&param->lock);
+
+	if (!param->fault_param)
+		goto unlock;
+
+	kfree(param->fault_param);
+	param->fault_param = NULL;
+	put_device(dev);
+unlock:
+	mutex_unlock(&param->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_unregister_device_fault_handler);
+
+
+/**
+ * iommu_report_device_fault() - Report fault event to device
+ * @dev: the device
+ * @evt: fault event data
+ *
+ * Called by IOMMU drivers when a fault is detected, typically in a threaded IRQ
+ * handler.
+ *
+ * Return 0 on success, or an error.
+ */
+int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt)
+{
+	struct iommu_param *param = dev->iommu_param;
+	struct iommu_fault_param *fparam;
+	int ret = 0;
+
+	/* iommu_param is allocated when device is added to group */
+	if (!param || !evt)
+		return -EINVAL;
+
+	/* we only report device fault if there is a handler registered */
+	mutex_lock(&param->lock);
+	fparam = param->fault_param;
+	if (!fparam || !fparam->handler) {
+		ret = -EINVAL;
+		goto done_unlock;
+	}
+	ret = fparam->handler(evt, fparam->data);
+done_unlock:
+	mutex_unlock(&param->lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_report_device_fault);
+
 /**
  * iommu_group_id - Return ID for a group
  * @group: the group to ID
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 7890a92e496a..b87b74c63cf9 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -322,9 +322,9 @@ struct iommu_fault_event {
 
 /**
  * struct iommu_fault_param - per-device IOMMU fault data
- * @dev_fault_handler: Callback function to handle IOMMU faults at device level
- * @data: handler private data
  *
+ * @handler: Callback function to handle IOMMU faults at device level
+ * @data: handler private data
  */
 struct iommu_fault_param {
 	iommu_dev_fault_handler_t handler;
@@ -341,6 +341,7 @@ struct iommu_fault_param {
  *	struct iommu_fwspec	*iommu_fwspec;
  */
 struct iommu_param {
+	struct mutex lock;
 	struct iommu_fault_param *fault_param;
 };
 
@@ -433,6 +434,15 @@ extern int iommu_group_register_notifier(struct iommu_group *group,
 					 struct notifier_block *nb);
 extern int iommu_group_unregister_notifier(struct iommu_group *group,
 					   struct notifier_block *nb);
+extern int iommu_register_device_fault_handler(struct device *dev,
+					iommu_dev_fault_handler_t handler,
+					void *data);
+
+extern int iommu_unregister_device_fault_handler(struct device *dev);
+
+extern int iommu_report_device_fault(struct device *dev,
+				     struct iommu_fault_event *evt);
+
 extern int iommu_group_id(struct iommu_group *group);
 extern struct iommu_group *iommu_group_get_for_dev(struct device *dev);
 extern struct iommu_domain *iommu_group_default_domain(struct iommu_group *);
@@ -741,6 +751,25 @@ static inline int iommu_group_unregister_notifier(struct iommu_group *group,
 	return 0;
 }
 
+static inline
+int iommu_register_device_fault_handler(struct device *dev,
+					iommu_dev_fault_handler_t handler,
+					void *data)
+{
+	return -ENODEV;
+}
+
+static inline int iommu_unregister_device_fault_handler(struct device *dev)
+{
+	return 0;
+}
+
+static inline
+int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt)
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
