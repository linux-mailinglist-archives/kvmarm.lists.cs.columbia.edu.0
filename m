Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BCAB91AD0D
	for <lists+kvmarm@lfdr.de>; Sun, 12 May 2019 18:32:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B4A7B4A4E1;
	Sun, 12 May 2019 12:32:07 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vKUEzTqx78cO; Sun, 12 May 2019 12:32:07 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8F06A4A4D3;
	Sun, 12 May 2019 12:32:06 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E0EB14A4AA
 for <kvmarm@lists.cs.columbia.edu>; Sun, 12 May 2019 12:32:04 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ny8bOGUPGcRU for <kvmarm@lists.cs.columbia.edu>;
 Sun, 12 May 2019 12:32:03 -0400 (EDT)
Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com
 [209.85.160.194])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 90C254A36B
 for <kvmarm@lists.cs.columbia.edu>; Sun, 12 May 2019 12:32:03 -0400 (EDT)
Received: by mail-qt1-f194.google.com with SMTP id h1so4367360qtp.1
 for <kvmarm@lists.cs.columbia.edu>; Sun, 12 May 2019 09:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=gWQWmUQnTtpdS1fW9lGpRk2GMG2DyCbjfZMrbY3ehBg=;
 b=lUDKo7iDWkDxPHZjCKmrnytJ0hNcN2Jf2SjFwHinjfPdxjiaQLKN+nHJDpCmfuJeLi
 vBZBPV9YQd2zAp1LPW+lhgBBsmNUQrCLVuN6RFygph8ttUdX/dt611IUNs77QPTOhVXE
 Gic2MbJfnH6ikiffyrLldC739LaaJ2Csv/6t14ABcKWQgEmNR1TlVewRlWHGD8bEPeEt
 b/8SYnDrpPETI9j6oF1pa2P3n/s+hoDGnRNYj8cN7UuqsB4Sg+GnBkXskmP6yRVkayIv
 NQUEv4JYdRujIoif19j4uOnCMLX3i+M0OvUeUjhkfrHlY+YAhUM9c6LZVLaAj1NPXjnU
 zv9A==
X-Gm-Message-State: APjAAAWkI/dpZ23g+yHJDHjukXkvKHxUp8Bz4B2Mghf2wE/u/uWwrk5d
 SuJ/mrrO9FgGF8bO3fpa+uSe3g==
X-Google-Smtp-Source: APXvYqzhmWo+UkRgVkqDTpvr2NwI5n1SCQUPFdJ0CANhQ8AuAx0/rktx5J0cdUejuh99dU3DdW4fsQ==
X-Received: by 2002:aed:3fd8:: with SMTP id w24mr20147558qth.64.1557678723231; 
 Sun, 12 May 2019 09:32:03 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net.
 [173.76.105.71])
 by smtp.gmail.com with ESMTPSA id h62sm5582800qkd.92.2019.05.12.09.32.01
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 12 May 2019 09:32:02 -0700 (PDT)
Date: Sun, 12 May 2019 12:31:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v7 0/7] Add virtio-iommu driver
Message-ID: <20190512123022-mutt-send-email-mst@kernel.org>
References: <20190115121959.23763-1-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190115121959.23763-1-jean-philippe.brucker@arm.com>
Cc: virtio-dev@lists.oasis-open.org, kevin.tian@intel.com,
 lorenzo.pieralisi@arm.com, tnowicki@caviumnetworks.com,
 devicetree@vger.kernel.org, marc.zyngier@arm.com, linux-pci@vger.kernel.org,
 joro@8bytes.org, will.deacon@arm.com, robin.murphy@arm.com,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, kvmarm@lists.cs.columbia.edu, bhelgaas@google.com,
 frowand.list@gmail.com, jasowang@redhat.com
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

On Tue, Jan 15, 2019 at 12:19:52PM +0000, Jean-Philippe Brucker wrote:
> Implement the virtio-iommu driver, following specification v0.9 [1].
> 
> This is a simple rebase onto Linux v5.0-rc2. We now use the
> dev_iommu_fwspec_get() helper introduced in v5.0 instead of accessing
> dev->iommu_fwspec, but there aren't any functional change from v6 [2].
> 
> Our current goal for virtio-iommu is to get a paravirtual IOMMU working
> on Arm, and enable device assignment to guest userspace. In this
> use-case the mappings are static, and don't require optimal performance,
> so this series tries to keep things simple. However there is plenty more
> to do for features and optimizations, and having this base in v5.1 would
> be good. Given that most of the changes are to drivers/iommu, I believe
> the driver and future changes should go via the IOMMU tree.
> 
> You can find Linux driver and kvmtool device on v0.9.2 branches [3],
> module and x86 support on virtio-iommu/devel. Also tested with Eric's
> QEMU device [4]. Please note that the series depends on Robin's
> probe-deferral fix [5], which will hopefully land in v5.0.
> 
> [1] Virtio-iommu specification v0.9, sources and pdf
>     git://linux-arm.org/virtio-iommu.git virtio-iommu/v0.9
>     http://jpbrucker.net/virtio-iommu/spec/v0.9/virtio-iommu-v0.9.pdf
> 
> [2] [PATCH v6 0/7] Add virtio-iommu driver
>     https://lists.linuxfoundation.org/pipermail/iommu/2018-December/032127.html
> 
> [3] git://linux-arm.org/linux-jpb.git virtio-iommu/v0.9.2
>     git://linux-arm.org/kvmtool-jpb.git virtio-iommu/v0.9.2
> 
> [4] [RFC v9 00/17] VIRTIO-IOMMU device
>     https://www.mail-archive.com/qemu-devel@nongnu.org/msg575578.html
> 
> [5] [PATCH] iommu/of: Fix probe-deferral
>     https://www.spinics.net/lists/arm-kernel/msg698371.html


OK this has been in next for a while.

Last time IOMMU maintainers objected. Are objections
still in force?

If not could we get acks please?


> Jean-Philippe Brucker (7):
>   dt-bindings: virtio-mmio: Add IOMMU description
>   dt-bindings: virtio: Add virtio-pci-iommu node
>   of: Allow the iommu-map property to omit untranslated devices
>   PCI: OF: Initialize dev->fwnode appropriately
>   iommu: Add virtio-iommu driver
>   iommu/virtio: Add probe request
>   iommu/virtio: Add event queue
> 
>  .../devicetree/bindings/virtio/iommu.txt      |   66 +
>  .../devicetree/bindings/virtio/mmio.txt       |   30 +
>  MAINTAINERS                                   |    7 +
>  drivers/iommu/Kconfig                         |   11 +
>  drivers/iommu/Makefile                        |    1 +
>  drivers/iommu/virtio-iommu.c                  | 1158 +++++++++++++++++
>  drivers/of/base.c                             |   10 +-
>  drivers/pci/of.c                              |    7 +
>  include/uapi/linux/virtio_ids.h               |    1 +
>  include/uapi/linux/virtio_iommu.h             |  161 +++
>  10 files changed, 1449 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/virtio/iommu.txt
>  create mode 100644 drivers/iommu/virtio-iommu.c
>  create mode 100644 include/uapi/linux/virtio_iommu.h
> 
> -- 
> 2.19.1
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
