Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id F05B833B5A
	for <lists+kvmarm@lfdr.de>; Tue,  4 Jun 2019 00:32:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9D0F54A4E9;
	Mon,  3 Jun 2019 18:32:19 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.202
X-Spam-Level: 
X-Spam-Status: No, score=-4.202 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5, SPF_HELO_PASS=-0.001]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iAN88Pm9sWNv; Mon,  3 Jun 2019 18:32:19 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4FBE84A4CA;
	Mon,  3 Jun 2019 18:32:18 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9DFE24A3B4
 for <kvmarm@lists.cs.columbia.edu>; Mon,  3 Jun 2019 18:32:17 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Em0B4XxSnVxa for <kvmarm@lists.cs.columbia.edu>;
 Mon,  3 Jun 2019 18:32:16 -0400 (EDT)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 783E94A369
 for <kvmarm@lists.cs.columbia.edu>; Mon,  3 Jun 2019 18:32:16 -0400 (EDT)
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CC2D530C0DED;
 Mon,  3 Jun 2019 22:32:15 +0000 (UTC)
Received: from x1.home (ovpn-116-22.phx2.redhat.com [10.3.116.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C188E1001DE0;
 Mon,  3 Jun 2019 22:32:14 +0000 (UTC)
Date: Mon, 3 Jun 2019 16:32:14 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v8 05/29] iommu: Add a timeout parameter for PRQ response
Message-ID: <20190603163214.483884a7@x1.home>
In-Reply-To: <20190526161004.25232-6-eric.auger@redhat.com>
References: <20190526161004.25232-1-eric.auger@redhat.com>
 <20190526161004.25232-6-eric.auger@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Mon, 03 Jun 2019 22:32:16 +0000 (UTC)
Cc: kevin.tian@intel.com, jacob.jun.pan@linux.intel.com, ashok.raj@intel.com,
 kvm@vger.kernel.org, joro@8bytes.org, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, marc.zyngier@arm.com,
 iommu@lists.linux-foundation.org, yi.l.liu@intel.com, vincent.stehle@arm.com,
 robin.murphy@arm.com, kvmarm@lists.cs.columbia.edu, eric.auger.pro@gmail.com
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

On Sun, 26 May 2019 18:09:40 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> 
> When an IO page request is processed outside IOMMU subsystem, response
> can be delayed or lost. Add a tunable setup parameter such that user can
> choose the timeout for IOMMU to track pending page requests.
> 
> This timeout mechanism is a basic safety net which can be implemented in
> conjunction with credit based or device level page response exception
> handling.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  8 +++++
>  drivers/iommu/iommu.c                         | 29 +++++++++++++++++++
>  2 files changed, 37 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 138f6664b2e2..b43f0893d252 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1813,6 +1813,14 @@
>  			1 - Bypass the IOMMU for DMA.
>  			unset - Use value of CONFIG_IOMMU_DEFAULT_PASSTHROUGH.
>  
> +	iommu.prq_timeout=
> +			Timeout in seconds to wait for page response
> +			of a pending page request.
> +			Format: <integer>
> +			Default: 10
> +			0 - no timeout tracking
> +			1 to 100 - allowed range
> +
>  	io7=		[HW] IO7 for Marvel based alpha systems
>  			See comment before marvel_specify_io7 in
>  			arch/alpha/kernel/core_marvel.c.
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 13b301cfb10f..64e87d56f471 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -45,6 +45,19 @@ static unsigned int iommu_def_domain_type = IOMMU_DOMAIN_DMA;
>  #endif
>  static bool iommu_dma_strict __read_mostly = true;
>  
> +/*
> + * Timeout to wait for page response of a pending page request. This is
> + * intended as a basic safty net in case a pending page request is not
> + * responded for an exceptionally long time. Device may also implement
> + * its own protection mechanism against this exception.
> + * Units are in jiffies with a range between 1 - 100 seconds equivalent.
> + * Default to 10 seconds.
> + * Setting 0 means no timeout tracking.
> + */
> +#define IOMMU_PAGE_RESPONSE_MAX_TIMEOUT (HZ * 100)
> +#define IOMMU_PAGE_RESPONSE_DEF_TIMEOUT (HZ * 10)
> +static unsigned long prq_timeout = IOMMU_PAGE_RESPONSE_DEF_TIMEOUT;
> +
>  struct iommu_group {
>  	struct kobject kobj;
>  	struct kobject *devices_kobj;
> @@ -157,6 +170,22 @@ static int __init iommu_dma_setup(char *str)
>  }
>  early_param("iommu.strict", iommu_dma_setup);
>  
> +static int __init iommu_set_prq_timeout(char *str)
> +{
> +	unsigned long timeout;
> +
> +	if (!str)
> +		return -EINVAL;
> +	timeout = simple_strtoul(str, NULL, 0);
> +	timeout = timeout * HZ;
> +	if (timeout > IOMMU_PAGE_RESPONSE_MAX_TIMEOUT)
> +		return -EINVAL;
> +	prq_timeout = timeout;
> +
> +	return 0;
> +}
> +early_param("iommu.prq_timeout", iommu_set_prq_timeout);
> +
>  static ssize_t iommu_group_attr_show(struct kobject *kobj,
>  				     struct attribute *__attr, char *buf)
>  {

It doesn't seem to make much sense to include this patch without also
including "iommu: handle page response timeout".  Was that one lost?
Dropped?  Lives elsewhere?  Thanks,

Alex
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
