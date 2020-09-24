Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id F1CC1276C59
	for <lists+kvmarm@lfdr.de>; Thu, 24 Sep 2020 10:50:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 747594B20D;
	Thu, 24 Sep 2020 04:50:11 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tI3xsUTs1Tcb; Thu, 24 Sep 2020 04:50:11 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 38B854B1CD;
	Thu, 24 Sep 2020 04:50:10 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3F09D4B1C0
 for <kvmarm@lists.cs.columbia.edu>; Thu, 24 Sep 2020 04:50:09 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jyYAmoxVcvw0 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 24 Sep 2020 04:50:08 -0400 (EDT)
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A42BD4B1BD
 for <kvmarm@lists.cs.columbia.edu>; Thu, 24 Sep 2020 04:50:05 -0400 (EDT)
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id E1988906A3711F42ACCA;
 Thu, 24 Sep 2020 16:49:59 +0800 (CST)
Received: from [10.174.185.226] (10.174.185.226) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Thu, 24 Sep 2020 16:49:53 +0800
Subject: Re: [PATCH v10 05/11] vfio/pci: Register an iommu fault handler
To: Eric Auger <eric.auger@redhat.com>, <eric.auger.pro@gmail.com>,
 <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
 <kvm@vger.kernel.org>, <kvmarm@lists.cs.columbia.edu>, <joro@8bytes.org>,
 <alex.williamson@redhat.com>, <jacob.jun.pan@linux.intel.com>,
 <yi.l.liu@intel.com>, <robin.murphy@arm.com>
References: <20200320161911.27494-1-eric.auger@redhat.com>
 <20200320161911.27494-6-eric.auger@redhat.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <571978ff-ee8a-6e9f-6755-519d0871646f@huawei.com>
Date: Thu, 24 Sep 2020 16:49:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200320161911.27494-6-eric.auger@redhat.com>
Content-Language: en-US
X-Originating-IP: [10.174.185.226]
X-CFilter-Loop: Reflected
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

Hi Eric,

On 2020/3/21 0:19, Eric Auger wrote:
> Register an IOMMU fault handler which records faults in
> the DMA FAULT region ring buffer. In a subsequent patch, we
> will add the signaling of a specific eventfd to allow the
> userspace to be notified whenever a new fault as shown up.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

[...]

> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index 586b89debed5..69595c240baf 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -27,6 +27,7 @@
>   #include <linux/vfio.h>
>   #include <linux/vgaarb.h>
>   #include <linux/nospec.h>
> +#include <linux/circ_buf.h>
>   
>   #include "vfio_pci_private.h"
>   
> @@ -283,6 +284,38 @@ static const struct vfio_pci_regops vfio_pci_dma_fault_regops = {
>   	.add_capability = vfio_pci_dma_fault_add_capability,
>   };
>   
> +int vfio_pci_iommu_dev_fault_handler(struct iommu_fault *fault, void *data)
> +{
> +	struct vfio_pci_device *vdev = (struct vfio_pci_device *)data;
> +	struct vfio_region_dma_fault *reg =
> +		(struct vfio_region_dma_fault *)vdev->fault_pages;
> +	struct iommu_fault *new =
> +		(struct iommu_fault *)(vdev->fault_pages + reg->offset +
> +			reg->head * reg->entry_size);

Shouldn't 'reg->head' be protected under the fault_queue_lock? Otherwise
things may change behind our backs...

We shouldn't take any assumption about how IOMMU driver would report the
fault (serially or in parallel), I think.

> +	int head, tail, size;
> +	int ret = 0;
> +
> +	if (fault->type != IOMMU_FAULT_DMA_UNRECOV)
> +		return -ENOENT;
> +
> +	mutex_lock(&vdev->fault_queue_lock);
> +
> +	head = reg->head;
> +	tail = reg->tail;
> +	size = reg->nb_entries;
> +
> +	if (CIRC_SPACE(head, tail, size) < 1) {
> +		ret = -ENOSPC;
> +		goto unlock;
> +	}
> +
> +	*new = *fault;
> +	reg->head = (head + 1) % size;
> +unlock:
> +	mutex_unlock(&vdev->fault_queue_lock);
> +	return ret;
> +}
> +
>   #define DMA_FAULT_RING_LENGTH 512
>   
>   static int vfio_pci_init_dma_fault_region(struct vfio_pci_device *vdev)
> @@ -317,6 +350,13 @@ static int vfio_pci_init_dma_fault_region(struct vfio_pci_device *vdev)
>   	header->entry_size = sizeof(struct iommu_fault);
>   	header->nb_entries = DMA_FAULT_RING_LENGTH;
>   	header->offset = sizeof(struct vfio_region_dma_fault);
> +
> +	ret = iommu_register_device_fault_handler(&vdev->pdev->dev,
> +					vfio_pci_iommu_dev_fault_handler,
> +					vdev);
> +	if (ret)
> +		goto out;
> +
>   	return 0;
>   out:
>   	kfree(vdev->fault_pages);


Thanks,
Zenghui
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
