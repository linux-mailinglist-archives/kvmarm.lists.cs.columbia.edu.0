Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A8ABC65853
	for <lists+kvmarm@lfdr.de>; Thu, 11 Jul 2019 15:59:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 56E624A54A;
	Thu, 11 Jul 2019 09:59:13 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.202
X-Spam-Level: 
X-Spam-Status: No, score=-4.202 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5, SPF_HELO_PASS=-0.001]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uwbRxYtPMvmk; Thu, 11 Jul 2019 09:59:13 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 265344A53F;
	Thu, 11 Jul 2019 09:59:12 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D3ABE4A502
 for <kvmarm@lists.cs.columbia.edu>; Thu, 11 Jul 2019 09:59:10 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XxgOt0hCII2z for <kvmarm@lists.cs.columbia.edu>;
 Thu, 11 Jul 2019 09:59:10 -0400 (EDT)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id E5FFF4A4EA
 for <kvmarm@lists.cs.columbia.edu>; Thu, 11 Jul 2019 09:59:09 -0400 (EDT)
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 47B5A44BC4;
 Thu, 11 Jul 2019 13:59:09 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-46.ams2.redhat.com [10.36.116.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9440160928;
 Thu, 11 Jul 2019 13:59:04 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
 alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
 yi.l.liu@intel.com, jean-philippe.brucker@arm.com, will.deacon@arm.com,
 robin.murphy@arm.com
Subject: [PATCH v9 10/11] vfio/pci: Register and allow DMA FAULT IRQ signaling
Date: Thu, 11 Jul 2019 15:56:24 +0200
Message-Id: <20190711135625.20684-11-eric.auger@redhat.com>
In-Reply-To: <20190711135625.20684-1-eric.auger@redhat.com>
References: <20190711135625.20684-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Thu, 11 Jul 2019 13:59:09 +0000 (UTC)
Cc: kevin.tian@intel.com, vincent.stehle@arm.com, ashok.raj@intel.com,
 marc.zyngier@arm.com, tina.zhang@intel.com
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

Register the VFIO_IRQ_TYPE_NESTED/VFIO_IRQ_SUBTYPE_DMA_FAULT
IRQ that allows to signal a nested mode DMA fault.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 drivers/vfio/pci/vfio_pci.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index dcc246202094..a9df964e40c6 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -344,7 +344,7 @@ int vfio_pci_iommu_dev_fault_handler(struct iommu_fault *fault, void *data)
 	struct iommu_fault *new =
 		(struct iommu_fault *)(vdev->fault_pages + reg->offset +
 			reg->head * reg->entry_size);
-	int head, tail, size;
+	int head, tail, size, ext_irq_index;
 	int ret = 0;
 
 	if (fault->type != IOMMU_FAULT_DMA_UNRECOV)
@@ -365,7 +365,19 @@ int vfio_pci_iommu_dev_fault_handler(struct iommu_fault *fault, void *data)
 	reg->head = (head + 1) % size;
 unlock:
 	mutex_unlock(&vdev->fault_queue_lock);
-	return ret;
+	if (ret)
+		return ret;
+
+	ext_irq_index = vfio_pci_get_ext_irq_index(vdev, VFIO_IRQ_TYPE_NESTED,
+						   VFIO_IRQ_SUBTYPE_DMA_FAULT);
+	if (ext_irq_index < 0)
+		return -EINVAL;
+
+	mutex_lock(&vdev->igate);
+	if (vdev->ext_irqs[ext_irq_index].trigger)
+		eventfd_signal(vdev->ext_irqs[ext_irq_index].trigger, 1);
+	mutex_unlock(&vdev->igate);
+	return 0;
 }
 
 #define DMA_FAULT_RING_LENGTH 512
@@ -518,6 +530,12 @@ static int vfio_pci_enable(struct vfio_pci_device *vdev)
 	if (ret)
 		goto disable_exit;
 
+	ret = vfio_pci_register_irq(vdev, VFIO_IRQ_TYPE_NESTED,
+				    VFIO_IRQ_SUBTYPE_DMA_FAULT,
+				    VFIO_IRQ_INFO_EVENTFD);
+	if (ret)
+		goto disable_exit;
+
 	vfio_pci_probe_mmaps(vdev);
 
 	return 0;
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
