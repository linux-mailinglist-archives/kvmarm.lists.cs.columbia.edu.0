Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9CA45DEF
	for <lists+kvmarm@lfdr.de>; Fri, 14 Jun 2019 15:18:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 81DE94A51C;
	Fri, 14 Jun 2019 09:18:01 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.202
X-Spam-Level: 
X-Spam-Status: No, score=-4.202 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5, SPF_HELO_PASS=-0.001]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lonp88Ngi2yX; Fri, 14 Jun 2019 09:18:01 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 46B124A512;
	Fri, 14 Jun 2019 09:18:00 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E366E4A4F3
 for <kvmarm@lists.cs.columbia.edu>; Fri, 14 Jun 2019 09:17:58 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0EijnYjWMOn5 for <kvmarm@lists.cs.columbia.edu>;
 Fri, 14 Jun 2019 09:17:57 -0400 (EDT)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 7234F4A369
 for <kvmarm@lists.cs.columbia.edu>; Fri, 14 Jun 2019 09:17:57 -0400 (EDT)
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6B8B3356EA;
 Fri, 14 Jun 2019 13:17:40 +0000 (UTC)
Received: from [10.36.116.67] (ovpn-116-67.ams2.redhat.com [10.36.116.67])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7366A54696;
 Fri, 14 Jun 2019 13:17:28 +0000 (UTC)
Subject: Re: [PATCH v8 23/29] vfio: VFIO_IOMMU_CACHE_INVALIDATE
To: "Liu, Yi L" <yi.l.liu@intel.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
 "jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
References: <20190526161004.25232-1-eric.auger@redhat.com>
 <20190526161004.25232-24-eric.auger@redhat.com>
 <A2975661238FB949B60364EF0F2C257439EFB432@SHSMSX104.ccr.corp.intel.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <8d36cf34-a89b-6587-08e9-99242e2f34dc@redhat.com>
Date: Fri, 14 Jun 2019 15:17:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <A2975661238FB949B60364EF0F2C257439EFB432@SHSMSX104.ccr.corp.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Fri, 14 Jun 2019 13:17:51 +0000 (UTC)
Cc: "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "Tian,
 Kevin" <kevin.tian@intel.com>,
 "vincent.stehle@arm.com" <vincent.stehle@arm.com>, "Raj,
 Ashok" <ashok.raj@intel.com>
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

Hi Liu,

On 6/14/19 2:38 PM, Liu, Yi L wrote:
> Hi Eric,
> 
>> From: Eric Auger [mailto:eric.auger@redhat.com]
>> Sent: Monday, May 27, 2019 12:10 AM
>> Subject: [PATCH v8 23/29] vfio: VFIO_IOMMU_CACHE_INVALIDATE
>>
>> From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
>>
>> When the guest "owns" the stage 1 translation structures,  the host IOMMU driver
>> has no knowledge of caching structure updates unless the guest invalidation
>> requests are trapped and passed down to the host.
>>
>> This patch adds the VFIO_IOMMU_CACHE_INVALIDATE ioctl with aims at
>> propagating guest stage1 IOMMU cache invalidations to the host.
>>
>> Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>> v6 -> v7:
>> - Use iommu_capsule struct
>> - renamed vfio_iommu_for_each_dev into vfio_iommu_lookup_dev
>>   due to checkpatch error related to for_each_dev suffix
>>
>> v2 -> v3:
>> - introduce vfio_iommu_for_each_dev back in this patch
>>
>> v1 -> v2:
>> - s/TLB/CACHE
>> - remove vfio_iommu_task usage
>> - commit message rewording
>> ---
>>  drivers/vfio/vfio_iommu_type1.c | 55 +++++++++++++++++++++++++++++++++
>>  include/uapi/linux/vfio.h       | 13 ++++++++
>>  2 files changed, 68 insertions(+)
>>
>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
>> index b2d609d6fe83..6fda4fbc9bfa 100644
>> --- a/drivers/vfio/vfio_iommu_type1.c
>> +++ b/drivers/vfio/vfio_iommu_type1.c
>> @@ -120,6 +120,34 @@ struct vfio_regions {
>>  #define IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu)	\
>>  					(!list_empty(&iommu->domain_list))
>>
>> +struct domain_capsule {
>> +	struct iommu_domain *domain;
>> +	void *data;
>> +};
>> +
>> +/* iommu->lock must be held */
>> +static int
>> +vfio_iommu_lookup_dev(struct vfio_iommu *iommu,
>> +		      int (*fn)(struct device *dev, void *data),
>> +		      void *data)
>> +{
>> +	struct domain_capsule dc = {.data = data};
>> +	struct vfio_domain *d;
>> +	struct vfio_group *g;
>> +	int ret = 0;
>> +
>> +	list_for_each_entry(d, &iommu->domain_list, next) {
>> +		dc.domain = d->domain;
>> +		list_for_each_entry(g, &d->group_list, next) {
>> +			ret = iommu_group_for_each_dev(g->iommu_group,
>> +						       &dc, fn);
>> +			if (ret)
>> +				break;
>> +		}
>> +	}
>> +	return ret;
>> +}
>> +
>>  static int put_pfn(unsigned long pfn, int prot);
>>
>>  /*
>> @@ -1795,6 +1823,15 @@ vfio_attach_pasid_table(struct vfio_iommu *iommu,
>>  	return ret;
>>  }
>>
>> +static int vfio_cache_inv_fn(struct device *dev, void *data) {
>> +	struct domain_capsule *dc = (struct domain_capsule *)data;
>> +	struct vfio_iommu_type1_cache_invalidate *ustruct =
>> +		(struct vfio_iommu_type1_cache_invalidate *)dc->data;
>> +
>> +	return iommu_cache_invalidate(dc->domain, dev, &ustruct->info); }
>> +
>>  static long vfio_iommu_type1_ioctl(void *iommu_data,
>>  				   unsigned int cmd, unsigned long arg)  { @@ -
>> 1881,6 +1918,24 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
>>  	} else if (cmd == VFIO_IOMMU_DETACH_PASID_TABLE) {
>>  		vfio_detach_pasid_table(iommu);
>>  		return 0;
>> +	} else if (cmd == VFIO_IOMMU_CACHE_INVALIDATE) {
>> +		struct vfio_iommu_type1_cache_invalidate ustruct;
>> +		int ret;
>> +
>> +		minsz = offsetofend(struct vfio_iommu_type1_cache_invalidate,
>> +				    info);
>> +
>> +		if (copy_from_user(&ustruct, (void __user *)arg, minsz))
>> +			return -EFAULT;
>> +
>> +		if (ustruct.argsz < minsz || ustruct.flags)
> 
> May remove the flags field?
> 
>> +			return -EINVAL;
>> +
>> +		mutex_lock(&iommu->lock);
>> +		ret = vfio_iommu_lookup_dev(iommu, vfio_cache_inv_fn,
>> +					    &ustruct);
>> +		mutex_unlock(&iommu->lock);
>> +		return ret;
>>  	}
>>
>>  	return -ENOTTY;
>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h index
>> 4316dd8cb5b5..055aa9b9745a 100644
>> --- a/include/uapi/linux/vfio.h
>> +++ b/include/uapi/linux/vfio.h
>> @@ -785,6 +785,19 @@ struct vfio_iommu_type1_attach_pasid_table {
>>   */
>>  #define VFIO_IOMMU_DETACH_PASID_TABLE	_IO(VFIO_TYPE, VFIO_BASE + 23)
>>
>> +/**
>> + * VFIO_IOMMU_CACHE_INVALIDATE - _IOWR(VFIO_TYPE, VFIO_BASE + 24,
>> + *			struct vfio_iommu_type1_cache_invalidate)
>> + *
>> + * Propagate guest IOMMU cache invalidation to the host.
>> + */
>> +struct vfio_iommu_type1_cache_invalidate {
>> +	__u32   argsz;
>> +	__u32   flags;
> 
> Looks like there is no more usage on "flags". is it?

Agreed. However all the other vfio structs embed it.
vfio_iommu_type1_dma_unmap (VFIO_IOMMU_UNMAP_DMA) or
vfio_iommu_type1_info (VFIO_IOMMU_GET_INFO) also feature it and do not
use it either if I am not wrong.

So I guess flags is a common pattern for the API and somehow allows to
extend the API if needed. So I would be inclined to keep it, no?

Thanks

Eric
> 
> Regards,
> Yi Liu
> 
>> +	struct iommu_cache_invalidate_info info; };
>> +#define VFIO_IOMMU_CACHE_INVALIDATE      _IO(VFIO_TYPE, VFIO_BASE + 24)
>> +
>>  /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU -------- */
>>
>>  /*
>> --
>> 2.20.1
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
