Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A04441AAC4E
	for <lists+kvmarm@lfdr.de>; Wed, 15 Apr 2020 17:53:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0F8424B21F;
	Wed, 15 Apr 2020 11:53:19 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8tW8VnPMSnJ8; Wed, 15 Apr 2020 11:53:18 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 91DE94B15D;
	Wed, 15 Apr 2020 11:53:17 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A62054B12B
 for <kvmarm@lists.cs.columbia.edu>; Wed, 15 Apr 2020 11:53:16 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p4dXhI1eO3Ba for <kvmarm@lists.cs.columbia.edu>;
 Wed, 15 Apr 2020 11:53:15 -0400 (EDT)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id B1D374B0FF
 for <kvmarm@lists.cs.columbia.edu>; Wed, 15 Apr 2020 11:53:14 -0400 (EDT)
IronPort-SDR: PIz240srWy8/ur49JG9eDftPdQEURD+fMRqfEmkLL5k/y8kPvf8Tvk/Jcoth3vsQPfS6/f/R4p
 7AuEJ7dS0aRA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2020 08:53:13 -0700
IronPort-SDR: F6uUaqyd6cceLSV0Kq4PASCZhpm64sTmBxjVMAAcmV6plfo2xf/+A5Rr/5MG5sM7lvlIP+oEsC
 oMslcndCbN5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,387,1580803200"; d="scan'208";a="253561163"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga003.jf.intel.com with ESMTP; 15 Apr 2020 08:53:13 -0700
Date: Wed, 15 Apr 2020 08:59:08 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v11 01/13] iommu: Introduce attach/detach_pasid_table API
Message-ID: <20200415085908.0e1803b7@jacob-builder>
In-Reply-To: <c781ce8d-7fe4-0fee-ba95-a1e493e003f5@redhat.com>
References: <20200414150607.28488-1-eric.auger@redhat.com>
 <20200414150607.28488-2-eric.auger@redhat.com>
 <20200414151548.658a0401@jacob-builder>
 <c781ce8d-7fe4-0fee-ba95-a1e493e003f5@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: jean-philippe@linaro.org, yi.l.liu@intel.com, alex.williamson@redhat.com,
 kvm@vger.kernel.org, maz@kernel.org, joro@8bytes.org, zhangfei.gao@foxmail.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jacob.jun.pan@linux.intel.com, zhangfei.gao@linaro.org, robin.murphy@arm.com,
 bbhushan2@marvell.com, will@kernel.org, kvmarm@lists.cs.columbia.edu,
 eric.auger.pro@gmail.com
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

On Wed, 15 Apr 2020 16:52:10 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Jacob,
> On 4/15/20 12:15 AM, Jacob Pan wrote:
> > Hi Eric,
> > 
> > There are some discussions about how to size the uAPI data.
> > https://lkml.org/lkml/2020/4/14/939
> > 
> > I think the problem with the current scheme is that when uAPI data
> > gets extended, if VFIO continue to use:
> > 
> > minsz = offsetofend(struct vfio_iommu_type1_set_pasid_table,
> > config); if (copy_from_user(&spt, (void __user *)arg, minsz))
> > 
> > It may copy more data from user than what was setup by the user.
> > 
> > So, as suggested by Alex, we could add argsz to the IOMMU uAPI
> > struct. So if argsz > minsz, then fail the attach_table since
> > kernel might be old, doesn't know about the extra data.
> > If argsz <= minsz, kernel can support the attach_table but must
> > process the data based on flags or config.  
> 
> So I guess we would need both an argsz _u32 + a new flag _u32 right?
> 
Yes.
> I am ok with that idea. Besides how will you manage for existing IOMMU
> UAPIs?
I plan to add argsz and flags (if not already have one)

> At some point you envisionned to have a getter at iommu api
> level to retrieve the size of a structure for a given version, right?
> 
This idea is shot down. There is no version-size lookup.
So the current plan is for user to fill out argsz in each IOMMU uAPI
struct. VFIO does the copy_from_user() based on argsz (sanitized
against the size of current kernel struct).

IOMMU vendor driver process the data based on flags which indicates
new capability/extensions.

> Thanks
> 
> Eric
> > 
> > Does it make sense to you?
> > 
> > 
> > On Tue, 14 Apr 2020 17:05:55 +0200
> > Eric Auger <eric.auger@redhat.com> wrote:
> >   
> >> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> >>
> >> In virtualization use case, when a guest is assigned
> >> a PCI host device, protected by a virtual IOMMU on the guest,
> >> the physical IOMMU must be programmed to be consistent with
> >> the guest mappings. If the physical IOMMU supports two
> >> translation stages it makes sense to program guest mappings
> >> onto the first stage/level (ARM/Intel terminology) while the host
> >> owns the stage/level 2.
> >>
> >> In that case, it is mandated to trap on guest configuration
> >> settings and pass those to the physical iommu driver.
> >>
> >> This patch adds a new API to the iommu subsystem that allows
> >> to set/unset the pasid table information.
> >>
> >> A generic iommu_pasid_table_config struct is introduced in
> >> a new iommu.h uapi header. This is going to be used by the VFIO
> >> user API.
> >>
> >> Signed-off-by: Jean-Philippe Brucker
> >> <jean-philippe.brucker@arm.com> Signed-off-by: Liu, Yi L
> >> <yi.l.liu@linux.intel.com> Signed-off-by: Ashok Raj
> >> <ashok.raj@intel.com> Signed-off-by: Jacob Pan
> >> <jacob.jun.pan@linux.intel.com> Signed-off-by: Eric Auger
> >> <eric.auger@redhat.com> Reviewed-by: Jean-Philippe Brucker
> >> <jean-philippe.brucker@arm.com> ---
> >>  drivers/iommu/iommu.c      | 19 ++++++++++++++
> >>  include/linux/iommu.h      | 18 ++++++++++++++
> >>  include/uapi/linux/iommu.h | 51
> >> ++++++++++++++++++++++++++++++++++++++ 3 files changed, 88
> >> insertions(+)
> >>
> >> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> >> index 2b471419e26c..b71ad56f8c99 100644
> >> --- a/drivers/iommu/iommu.c
> >> +++ b/drivers/iommu/iommu.c
> >> @@ -1723,6 +1723,25 @@ int iommu_sva_unbind_gpasid(struct
> >> iommu_domain *domain, struct device *dev, }
> >>  EXPORT_SYMBOL_GPL(iommu_sva_unbind_gpasid);
> >>  
> >> +int iommu_attach_pasid_table(struct iommu_domain *domain,
> >> +			     struct iommu_pasid_table_config *cfg)
> >> +{
> >> +	if (unlikely(!domain->ops->attach_pasid_table))
> >> +		return -ENODEV;
> >> +
> >> +	return domain->ops->attach_pasid_table(domain, cfg);
> >> +}
> >> +EXPORT_SYMBOL_GPL(iommu_attach_pasid_table);
> >> +
> >> +void iommu_detach_pasid_table(struct iommu_domain *domain)
> >> +{
> >> +	if (unlikely(!domain->ops->detach_pasid_table))
> >> +		return;
> >> +
> >> +	domain->ops->detach_pasid_table(domain);
> >> +}
> >> +EXPORT_SYMBOL_GPL(iommu_detach_pasid_table);
> >> +
> >>  static void __iommu_detach_device(struct iommu_domain *domain,
> >>  				  struct device *dev)
> >>  {
> >> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> >> index 7ef8b0bda695..3e1057c3585a 100644
> >> --- a/include/linux/iommu.h
> >> +++ b/include/linux/iommu.h
> >> @@ -248,6 +248,8 @@ struct iommu_iotlb_gather {
> >>   * @cache_invalidate: invalidate translation caches
> >>   * @sva_bind_gpasid: bind guest pasid and mm
> >>   * @sva_unbind_gpasid: unbind guest pasid and mm
> >> + * @attach_pasid_table: attach a pasid table
> >> + * @detach_pasid_table: detach the pasid table
> >>   * @pgsize_bitmap: bitmap of all possible supported page sizes
> >>   * @owner: Driver module providing these ops
> >>   */
> >> @@ -307,6 +309,9 @@ struct iommu_ops {
> >>  				      void *drvdata);
> >>  	void (*sva_unbind)(struct iommu_sva *handle);
> >>  	int (*sva_get_pasid)(struct iommu_sva *handle);
> >> +	int (*attach_pasid_table)(struct iommu_domain *domain,
> >> +				  struct iommu_pasid_table_config
> >> *cfg);
> >> +	void (*detach_pasid_table)(struct iommu_domain *domain);
> >>  
> >>  	int (*page_response)(struct device *dev,
> >>  			     struct iommu_fault_event *evt,
> >> @@ -446,6 +451,9 @@ extern int iommu_sva_bind_gpasid(struct
> >> iommu_domain *domain, struct device *dev, struct
> >> iommu_gpasid_bind_data *data); extern int
> >> iommu_sva_unbind_gpasid(struct iommu_domain *domain, struct device
> >> *dev, ioasid_t pasid); +extern int iommu_attach_pasid_table(struct
> >> iommu_domain *domain,
> >> +				    struct
> >> iommu_pasid_table_config *cfg); +extern void
> >> iommu_detach_pasid_table(struct iommu_domain *domain); extern
> >> struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
> >> extern struct iommu_domain *iommu_get_dma_domain(struct device
> >> *dev); extern int iommu_map(struct iommu_domain *domain, unsigned
> >> long iova, @@ -1048,6 +1056,16 @@ iommu_aux_get_pasid(struct
> >> iommu_domain *domain, struct device *dev) return -ENODEV; }
> >>  
> >> +static inline
> >> +int iommu_attach_pasid_table(struct iommu_domain *domain,
> >> +			     struct iommu_pasid_table_config *cfg)
> >> +{
> >> +	return -ENODEV;
> >> +}
> >> +
> >> +static inline
> >> +void iommu_detach_pasid_table(struct iommu_domain *domain) {}
> >> +
> >>  static inline struct iommu_sva *
> >>  iommu_sva_bind_device(struct device *dev, struct mm_struct *mm,
> >> void *drvdata) {
> >> diff --git a/include/uapi/linux/iommu.h
> >> b/include/uapi/linux/iommu.h index 4ad3496e5c43..8d00be10dc6d
> >> 100644 --- a/include/uapi/linux/iommu.h
> >> +++ b/include/uapi/linux/iommu.h
> >> @@ -321,4 +321,55 @@ struct iommu_gpasid_bind_data {
> >>  	};
> >>  };
> >>  
> >> +/**
> >> + * struct iommu_pasid_smmuv3 - ARM SMMUv3 Stream Table Entry
> >> stage 1 related
> >> + *     information
> >> + * @version: API version of this structure
> >> + * @s1fmt: STE s1fmt (format of the CD table: single CD, linear
> >> table
> >> + *         or 2-level table)
> >> + * @s1dss: STE s1dss (specifies the behavior when @pasid_bits != 0
> >> + *         and no PASID is passed along with the incoming
> >> transaction)
> >> + * @padding: reserved for future use (should be zero)
> >> + *
> >> + * The PASID table is referred to as the Context Descriptor (CD)
> >> table on ARM
> >> + * SMMUv3. Please refer to the ARM SMMU 3.x spec (ARM IHI 0070A)
> >> for full
> >> + * details.
> >> + */
> >> +struct iommu_pasid_smmuv3 {
> >> +#define PASID_TABLE_SMMUV3_CFG_VERSION_1 1
> >> +	__u32	version;
> >> +	__u8	s1fmt;
> >> +	__u8	s1dss;
> >> +	__u8	padding[2];
> >> +};
> >> +
> >> +/**
> >> + * struct iommu_pasid_table_config - PASID table data used to bind
> >> guest PASID
> >> + *     table to the host IOMMU
> >> + * @version: API version to prepare for future extensions
> >> + * @format: format of the PASID table
> >> + * @base_ptr: guest physical address of the PASID table
> >> + * @pasid_bits: number of PASID bits used in the PASID table
> >> + * @config: indicates whether the guest translation stage must
> >> + *          be translated, bypassed or aborted.
> >> + * @padding: reserved for future use (should be zero)
> >> + * @smmuv3: table information when @format is
> >> %IOMMU_PASID_FORMAT_SMMUV3
> >> + */
> >> +struct iommu_pasid_table_config {
> >> +#define PASID_TABLE_CFG_VERSION_1 1
> >> +	__u32	version;
> >> +#define IOMMU_PASID_FORMAT_SMMUV3	1
> >> +	__u32	format;
> >> +	__u64	base_ptr;
> >> +	__u8	pasid_bits;
> >> +#define IOMMU_PASID_CONFIG_TRANSLATE	1
> >> +#define IOMMU_PASID_CONFIG_BYPASS	2
> >> +#define IOMMU_PASID_CONFIG_ABORT	3
> >> +	__u8	config;
> >> +	__u8    padding[6];
> >> +	union {
> >> +		struct iommu_pasid_smmuv3 smmuv3;
> >> +	};
> >> +};
> >> +
> >>  #endif /* _UAPI_IOMMU_H */  
> > 
> > [Jacob Pan]
> >   
> 

[Jacob Pan]
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
