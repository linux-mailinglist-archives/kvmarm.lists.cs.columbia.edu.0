Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D8C212DA482
	for <lists+kvmarm@lfdr.de>; Tue, 15 Dec 2020 01:05:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4DA914B687;
	Mon, 14 Dec 2020 19:05:12 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k-mYwb+tva0Y; Mon, 14 Dec 2020 19:05:12 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 389884B697;
	Mon, 14 Dec 2020 19:05:11 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A15104B681
 for <kvmarm@lists.cs.columbia.edu>; Mon, 14 Dec 2020 19:05:10 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hhdvK8iUxNHq for <kvmarm@lists.cs.columbia.edu>;
 Mon, 14 Dec 2020 19:05:09 -0500 (EST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 76DE24B67C
 for <kvmarm@lists.cs.columbia.edu>; Mon, 14 Dec 2020 19:05:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607990709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6g3IZkefy8eigv1Fk+b3mkHNOWy4CEh/CsuZ+osvTpg=;
 b=fAd4ojfk+K+BE0ipl5Tiav+YiAwJwtnXuGlsRVtddeooTaDs5pKfOAVbot5GybQzgT9TZj
 3GBzH5UICeWFoUtoQ5yo0y6Yocr9SwS9FwYXMTzaXwMNsA1j1OsnHAjeMfvEyLE/8Ww79A
 EHKmU2p4YytPzqO9fatgyG5qAzLnph4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-SlUMOcjYPhqQzRsC2yXrMQ-1; Mon, 14 Dec 2020 19:05:04 -0500
X-MC-Unique: SlUMOcjYPhqQzRsC2yXrMQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7820C59;
 Tue, 15 Dec 2020 00:05:01 +0000 (UTC)
Received: from omen.home (ovpn-112-193.phx2.redhat.com [10.3.112.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A28DC5D9DC;
 Tue, 15 Dec 2020 00:04:59 +0000 (UTC)
Date: Mon, 14 Dec 2020 17:04:59 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH 4/7] vfio: iommu_type1: Fix missing dirty page when
 promote pinned_scope
Message-ID: <20201214170459.50cb8729@omen.home>
In-Reply-To: <20201210073425.25960-5-zhukeqian1@huawei.com>
References: <20201210073425.25960-1-zhukeqian1@huawei.com>
 <20201210073425.25960-5-zhukeqian1@huawei.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: Andrew Morton <akpm@linux-foundation.org>, kvm@vger.kernel.org,
 Marc Zyngier <maz@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Sean Christopherson <sean.j.christopherson@intel.com>,
 Alexios Zavras <alexios.zavras@intel.com>, iommu@lists.linux-foundation.org,
 Mark Brown <broonie@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 Robin Murphy <robin.murphy@arm.com>
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

On Thu, 10 Dec 2020 15:34:22 +0800
Keqian Zhu <zhukeqian1@huawei.com> wrote:

> When we pin or detach a group which is not dirty tracking capable,
> we will try to promote pinned_scope of vfio_iommu.
> 
> If we succeed to do so, vfio only report pinned_scope as dirty to
> userspace next time, but these memory written before pin or detach
> is missed.
> 
> The solution is that we must populate all dma range as dirty before
> promoting pinned_scope of vfio_iommu.

Please don't bury fixes patches into a series with other optimizations
and semantic changes.  Send it separately.

> 
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index bd9a94590ebc..00684597b098 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -1633,6 +1633,20 @@ static struct vfio_group *vfio_iommu_find_iommu_group(struct vfio_iommu *iommu,
>  	return group;
>  }
>  
> +static void vfio_populate_bitmap_all(struct vfio_iommu *iommu)
> +{
> +	struct rb_node *n;
> +	unsigned long pgshift = __ffs(iommu->pgsize_bitmap);
> +
> +	for (n = rb_first(&iommu->dma_list); n; n = rb_next(n)) {
> +		struct vfio_dma *dma = rb_entry(n, struct vfio_dma, node);
> +		unsigned long nbits = dma->size >> pgshift;
> +
> +		if (dma->iommu_mapped)
> +			bitmap_set(dma->bitmap, 0, nbits);
> +	}
> +}


If we detach a group which results in only non-IOMMU backed mdevs,
don't we also clear dma->iommu_mapped as part of vfio_unmap_unpin()
such that this test is invalid?  Thanks,

Alex

> +
>  static void promote_pinned_page_dirty_scope(struct vfio_iommu *iommu)
>  {
>  	struct vfio_domain *domain;
> @@ -1657,6 +1671,10 @@ static void promote_pinned_page_dirty_scope(struct vfio_iommu *iommu)
>  	}
>  
>  	iommu->pinned_page_dirty_scope = true;
> +
> +	/* Set all bitmap to avoid missing dirty page */
> +	if (iommu->dirty_page_tracking)
> +		vfio_populate_bitmap_all(iommu);
>  }
>  
>  static bool vfio_iommu_has_sw_msi(struct list_head *group_resv_regions,

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
