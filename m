Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0724535B39E
	for <lists+kvmarm@lfdr.de>; Sun, 11 Apr 2021 13:47:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8619B4B92F;
	Sun, 11 Apr 2021 07:47:33 -0400 (EDT)
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
	with ESMTP id VURTm3-oKiz3; Sun, 11 Apr 2021 07:47:33 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 57B1B4B92B;
	Sun, 11 Apr 2021 07:47:32 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6B6EB4B922
 for <kvmarm@lists.cs.columbia.edu>; Sun, 11 Apr 2021 07:47:30 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3RxQTcgcJm4z for <kvmarm@lists.cs.columbia.edu>;
 Sun, 11 Apr 2021 07:47:27 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B09C24B68F
 for <kvmarm@lists.cs.columbia.edu>; Sun, 11 Apr 2021 07:47:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618141647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=i/Qya5gYlpQU+h8vw6iTmP2eW8gYE13bTztPj4lYMq4=;
 b=EnsudmBe4W6V79c3+XuqGJ/6M8dlAOuQwYfvFAVsJPaiONhzAZlwhhSuVltVBAj5Z8ehLE
 qsBi/e2LZSQZRSAa25xAhnEz8FClc4rBm8iDpkvvhPGb+1G5wlgbHE8QJSBQ98faQvWwCd
 1fauKKHAQIfrWhtvzqs1Ita4Ond7Hf0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-26xNIX_tNuykPaTM3aRqmQ-1; Sun, 11 Apr 2021 07:47:23 -0400
X-MC-Unique: 26xNIX_tNuykPaTM3aRqmQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 721E71006701;
 Sun, 11 Apr 2021 11:47:20 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-112-22.ams2.redhat.com [10.36.112.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7A66B5C22A;
 Sun, 11 Apr 2021 11:47:02 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, will@kernel.org,
 maz@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
 alex.williamson@redhat.com, tn@semihalf.com, zhukeqian1@huawei.com
Subject: [PATCH v13 00/13] SMMUv3 Nested Stage Setup (VFIO part)
Date: Sun, 11 Apr 2021 13:46:46 +0200
Message-Id: <20210411114659.15051-1-eric.auger@redhat.com>
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

This series brings the VFIO part of HW nested paging support
in the SMMUv3.

The series depends on:
[PATCH v15 00/13] SMMUv3 Nested Stage Setup (IOMMU part)

3 new IOCTLs are introduced that allow the userspace to
1) pass the guest stage 1 configuration
2) pass stage 1 MSI bindings
3) invalidate stage 1 related caches

They map onto the related new IOMMU API functions.

We introduce the capability to register specific interrupt
indexes (see [1]). A new DMA_FAULT interrupt index allows to register
an eventfd to be signaled whenever a stage 1 related fault
is detected at physical level. Also two specific regions allow to
- expose the fault records to the user space and
- inject page responses.

This latter functionality is not exercised in this series
but is provided as a POC for further vSVA activities (Shameer's input).

Best Regards

Eric

This series can be found at:
https://github.com/eauger/linux/tree/v5.12-rc6-jean-iopf-14-2stage-v15

The series series includes Tina's patch steming from
[1] "[RFC PATCH v2 1/3] vfio: Use capability chains to handle device
specific irq" plus patches originally contributed by Yi.

History:

v12 -> v13:
- Comment fix for VFIO_IOMMU_SET_PASID_TABLE (Zenghui)

v11 -> v12:
- numerous fixes following feedbacks. Many thanks to all of you
- See individual history log.

v10 -> v11:
- rebase on top of v5.10-rc4
- adapt to changes on the IOMMU API (compliant with the doc
  written by Jacob/Yi)
- addition of the page response region
- Took into account Zenghui's comments
- In this version I have kept the ioctl separate. Since
  Yi's series [2] is currently stalled, I've just rebased here.

[2] [PATCH v7 00/16] vfio: expose virtual Shared Virtual Addressing
to VMs

v9 -> v10
- rebase on top of 5.6.0-rc3 (no change versus v9)

Eric Auger (10):
  vfio: VFIO_IOMMU_SET_MSI_BINDING
  vfio/pci: Add VFIO_REGION_TYPE_NESTED region type
  vfio/pci: Register an iommu fault handler
  vfio/pci: Allow to mmap the fault queue
  vfio/pci: Add framework for custom interrupt indices
  vfio: Add new IRQ for DMA fault reporting
  vfio/pci: Register and allow DMA FAULT IRQ signaling
  vfio: Document nested stage control
  vfio/pci: Register a DMA fault response region
  vfio/pci: Inject page response upon response region fill

Liu, Yi L (2):
  vfio: VFIO_IOMMU_SET_PASID_TABLE
  vfio: VFIO_IOMMU_CACHE_INVALIDATE

Tina Zhang (1):
  vfio: Use capability chains to handle device specific irq

 Documentation/driver-api/vfio.rst   |  77 +++++
 drivers/vfio/pci/vfio_pci.c         | 447 ++++++++++++++++++++++++++--
 drivers/vfio/pci/vfio_pci_intrs.c   |  62 ++++
 drivers/vfio/pci/vfio_pci_private.h |  33 ++
 drivers/vfio/pci/vfio_pci_rdwr.c    |  84 ++++++
 drivers/vfio/vfio_iommu_type1.c     | 178 +++++++++++
 include/uapi/linux/vfio.h           | 142 ++++++++-
 7 files changed, 1003 insertions(+), 20 deletions(-)

-- 
2.26.3

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
