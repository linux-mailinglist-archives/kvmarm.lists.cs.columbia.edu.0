Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAC12F66F8
	for <lists+kvmarm@lfdr.de>; Thu, 14 Jan 2021 18:15:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F035D4B17D;
	Thu, 14 Jan 2021 12:15:20 -0500 (EST)
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
	with ESMTP id Twef05UJrAOZ; Thu, 14 Jan 2021 12:15:20 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 57DC14B22F;
	Thu, 14 Jan 2021 12:15:19 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2D1FC4B226
 for <kvmarm@lists.cs.columbia.edu>; Thu, 14 Jan 2021 12:15:18 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ipd7kp0v0hUQ for <kvmarm@lists.cs.columbia.edu>;
 Thu, 14 Jan 2021 12:15:16 -0500 (EST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B083B4B1C5
 for <kvmarm@lists.cs.columbia.edu>; Thu, 14 Jan 2021 12:15:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1610644516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LSC4zFnkeq1rThuWrBByrEOp1GiQiNltgnc3zxIk00o=;
 b=XZfuOCt1TcpH1WZXtoIJUs1h/2s8RE2BSl/b2GZG6GmW4lzH31uqibHgqPxvguoe3R25hm
 a76avt8L7hBwbW0b0ETMIlRaNfKZQNk164P3/epLFnVdHvEa6r94IRWayHH6cL+E2yJRNb
 OMvwUmdnW4TBaQiy5yVv5V3MDK3WNrA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-NtU3Br2qMACdlQVW7b7Vfg-1; Thu, 14 Jan 2021 12:15:12 -0500
X-MC-Unique: NtU3Br2qMACdlQVW7b7Vfg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9C39107B46A;
 Thu, 14 Jan 2021 17:14:36 +0000 (UTC)
Received: from omen.home.shazbot.org (ovpn-112-255.phx2.redhat.com
 [10.3.112.255])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BF4FA60657;
 Thu, 14 Jan 2021 17:14:34 +0000 (UTC)
Date: Thu, 14 Jan 2021 10:14:34 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH 1/5] vfio/iommu_type1: Fixes vfio_dma_populate_bitmap to
 avoid dirty lose
Message-ID: <20210114101434.6092e43a@omen.home.shazbot.org>
In-Reply-To: <8bf8a12c-f3ae-dc52-c963-f9eb447f973b@huawei.com>
References: <20210107092901.19712-1-zhukeqian1@huawei.com>
 <20210107092901.19712-2-zhukeqian1@huawei.com>
 <20210112142059.074c1b0f@omen.home.shazbot.org>
 <8bf8a12c-f3ae-dc52-c963-f9eb447f973b@huawei.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu, Marc Zyngier <maz@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Alexios Zavras <alexios.zavras@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>,
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

On Thu, 14 Jan 2021 21:05:23 +0800
Keqian Zhu <zhukeqian1@huawei.com> wrote:

> Hi Alex,
> 
> On 2021/1/13 5:20, Alex Williamson wrote:
> > On Thu, 7 Jan 2021 17:28:57 +0800
> > Keqian Zhu <zhukeqian1@huawei.com> wrote:
> >   
> >> Defer checking whether vfio_dma is of fully-dirty in update_user_bitmap
> >> is easy to lose dirty log. For example, after promoting pinned_scope of
> >> vfio_iommu, vfio_dma is not considered as fully-dirty, then we may lose
> >> dirty log that occurs before vfio_iommu is promoted.
> >>
> >> The key point is that pinned-dirty is not a real dirty tracking way, it
> >> can't continuously track dirty pages, but just restrict dirty scope. It
> >> is essentially the same as fully-dirty. Fully-dirty is of full-scope and
> >> pinned-dirty is of pinned-scope.
> >>
> >> So we must mark pinned-dirty or fully-dirty after we start dirty tracking
> >> or clear dirty bitmap, to ensure that dirty log is marked right away.  
> > 
> > I was initially convinced by these first three patches, but upon
> > further review, I think the premise is wrong.  AIUI, the concern across
> > these patches is that our dirty bitmap is only populated with pages
> > dirtied by pinning and we only take into account the pinned page dirty
> > scope at the time the bitmap is retrieved by the user.  You suppose
> > this presents a gap where if a vendor driver has not yet identified
> > with a page pinning scope that the entire bitmap should be considered
> > dirty regardless of whether that driver later pins pages prior to the
> > user retrieving the dirty bitmap.  
> Yes, this is my concern. And there are some other scenarios.
> 
> 1. If a non-pinned iommu-backed domain is detached between starting
> dirty log and retrieving dirty bitmap, then the dirty log is missed
> (As you said in the last paragraph).
> 
> 2. If all vendor drivers pinned (means iommu pinned_scope is true),
> and an vendor driver do pin/unpin pair between starting dirty log and
> retrieving dirty bitmap, then the dirty log of these unpinned pages
> are missed.

Can you identity where this happen?  I believe this assertion is
incorrect.  When dirty logging is enabled vfio_dma_populate_bitmap()
marks all existing pinned pages as dirty.  In the scenario you
describe, the iommu pinned page dirty scope is irrelevant.  We only
track pinned or external DMA access pages for exactly this reason.
Unpinning a page never clears the dirty bitmap, only the user
retrieving the bitmap or disabling dirty logging clears the bitmap.  A
page that has been unpinned is transiently dirty, it is not repopulated
in the bitmap after the user has retrieved the bitmap because the
device no longer has access to it to consider it perpetually dirty.

> > I don't think this is how we intended the cooperation between the
> > iommu driver and vendor driver to work.  By pinning pages a vendor
> > driver is not declaring that only their future dirty page scope is
> > limited to pinned pages, instead they're declaring themselves as a
> > participant in dirty page tracking and take responsibility for
> > pinning any necessary pages.  For example we might extend
> > VFIO_IOMMU_DIRTY_PAGES_FLAG_START to trigger a blocking
> > notification to groups to not only begin dirty tracking, but also
> > to synchronously register their current device DMA footprint.  This
> > patch would require a vendor driver to possibly perform a
> > gratuitous page pinning in order to set the scope prior to dirty
> > logging being enabled, or else the initial bitmap will be fully
> > dirty.  
> I get what you mean ;-). You said that there is time gap between we
> attach a device and this device declares itself is dirty traceable.
> 
> However, this makes it difficult to management dirty log tracking (I
> list two bugs). If the vfio devices can declare themselves dirty
> traceable when attach to container, then the logic of dirty tracking
> is much more clear ;-) .

There's only one bug above afaict, which should be easily fixed.  I
think if you actually dig into the problem of a device declaring
themselves as dirty tracking capable, when the IOMMU backend works on
group, not devices, and it's groups that are attached to containers,
you might see that the logic is not so clear.  I also don't see this as
a significant issue, you're focusing on a niche scenario where a device
is hot-added to a VM, which is immediately migrated before the device
identifies itself by pinning pages.  In that scenario the iommu dirty
scope would be overly broad and we'd indicate all pages are dirty.
This errors on the side of reporting too much is dirty, which still
provides a correct result to the user.  The more common scenario would
be migration of a "long" running, stable VM, where drivers are active
and devices have already pinned pages if they intend to.

> > Therefore, I don't see that this series is necessary or correct.
> > Kirti, does this match your thinking?
> > 
> > Thinking about these semantics, it seems there might still be an
> > issue if a group with non-pinned-page dirty scope is detached with
> > dirty logging enabled.  It seems this should in fact fully populate
> > the dirty bitmaps at the time it's removed since we don't know the
> > extent of its previous DMA, nor will the group be present to
> > trigger the full bitmap when the user retrieves the dirty bitmap.
> > Creating fully populated bitmaps at the time tracking is enabled
> > negates our ability to take advantage of later enlightenment
> > though.  Thanks, 
> Since that you want to allow the time gap between we attach device
> and the device declare itself dirty traceable, I am going to fix
> these two bugs in patch v2. Do you agree?

I would consider a patch that fully populates the dirty bitmap if a
non-pinned page scope group is removed from the container while dirty
logging is enabled.  Thanks,

Alex

> >> Fixes: d6a4c185660c ("vfio iommu: Implementation of ioctl for
> >> dirty pages tracking") Signed-off-by: Keqian Zhu
> >> <zhukeqian1@huawei.com> ---
> >>  drivers/vfio/vfio_iommu_type1.c | 33
> >> ++++++++++++++++++++++----------- 1 file changed, 22
> >> insertions(+), 11 deletions(-)
> >>
> >> diff --git a/drivers/vfio/vfio_iommu_type1.c
> >> b/drivers/vfio/vfio_iommu_type1.c index bceda5e8baaa..b0a26e8e0adf
> >> 100644 --- a/drivers/vfio/vfio_iommu_type1.c
> >> +++ b/drivers/vfio/vfio_iommu_type1.c
> >> @@ -224,7 +224,7 @@ static void vfio_dma_bitmap_free(struct
> >> vfio_dma *dma) dma->bitmap = NULL;
> >>  }
> >>  
> >> -static void vfio_dma_populate_bitmap(struct vfio_dma *dma, size_t
> >> pgsize) +static void vfio_dma_populate_bitmap_pinned(struct
> >> vfio_dma *dma, size_t pgsize) {
> >>  	struct rb_node *p;
> >>  	unsigned long pgshift = __ffs(pgsize);
> >> @@ -236,6 +236,25 @@ static void vfio_dma_populate_bitmap(struct
> >> vfio_dma *dma, size_t pgsize) }
> >>  }
> >>  
> >> +static void vfio_dma_populate_bitmap_full(struct vfio_dma *dma,
> >> size_t pgsize) +{
> >> +	unsigned long pgshift = __ffs(pgsize);
> >> +	unsigned long nbits = dma->size >> pgshift;
> >> +
> >> +	bitmap_set(dma->bitmap, 0, nbits);
> >> +}
> >> +
> >> +static void vfio_dma_populate_bitmap(struct vfio_iommu *iommu,
> >> +				     struct vfio_dma *dma)
> >> +{
> >> +	size_t pgsize = (size_t)1 << __ffs(iommu->pgsize_bitmap);
> >> +
> >> +	if (iommu->pinned_page_dirty_scope)
> >> +		vfio_dma_populate_bitmap_pinned(dma, pgsize);
> >> +	else if (dma->iommu_mapped)
> >> +		vfio_dma_populate_bitmap_full(dma, pgsize);
> >> +}
> >> +
> >>  static int vfio_dma_bitmap_alloc_all(struct vfio_iommu *iommu)
> >>  {
> >>  	struct rb_node *n;
> >> @@ -257,7 +276,7 @@ static int vfio_dma_bitmap_alloc_all(struct
> >> vfio_iommu *iommu) }
> >>  			return ret;
> >>  		}
> >> -		vfio_dma_populate_bitmap(dma, pgsize);
> >> +		vfio_dma_populate_bitmap(iommu, dma);
> >>  	}
> >>  	return 0;
> >>  }
> >> @@ -987,13 +1006,6 @@ static int update_user_bitmap(u64 __user
> >> *bitmap, struct vfio_iommu *iommu, unsigned long shift =
> >> bit_offset % BITS_PER_LONG; unsigned long leftover;
> >>  
> >> -	/*
> >> -	 * mark all pages dirty if any IOMMU capable device is
> >> not able
> >> -	 * to report dirty pages and all pages are pinned and
> >> mapped.
> >> -	 */
> >> -	if (!iommu->pinned_page_dirty_scope && dma->iommu_mapped)
> >> -		bitmap_set(dma->bitmap, 0, nbits);
> >> -
> >>  	if (shift) {
> >>  		bitmap_shift_left(dma->bitmap, dma->bitmap, shift,
> >>  				  nbits + shift);
> >> @@ -1019,7 +1031,6 @@ static int vfio_iova_dirty_bitmap(u64 __user
> >> *bitmap, struct vfio_iommu *iommu, struct vfio_dma *dma;
> >>  	struct rb_node *n;
> >>  	unsigned long pgshift = __ffs(iommu->pgsize_bitmap);
> >> -	size_t pgsize = (size_t)1 << pgshift;
> >>  	int ret;
> >>  
> >>  	/*
> >> @@ -1055,7 +1066,7 @@ static int vfio_iova_dirty_bitmap(u64 __user
> >> *bitmap, struct vfio_iommu *iommu,
> >>  		 * pages which are marked dirty by vfio_dma_rw()
> >>  		 */
> >>  		bitmap_clear(dma->bitmap, 0, dma->size >>
> >> pgshift);
> >> -		vfio_dma_populate_bitmap(dma, pgsize);
> >> +		vfio_dma_populate_bitmap(iommu, dma);
> >>  	}
> >>  	return 0;
> >>  }  
> > 
> > .
> >   
> 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
