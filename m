Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 472FC314EA9
	for <lists+kvmarm@lfdr.de>; Tue,  9 Feb 2021 13:09:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CF9754B782;
	Tue,  9 Feb 2021 07:09:02 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gc7r07-cXWJk; Tue,  9 Feb 2021 07:09:02 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9FAEB4B703;
	Tue,  9 Feb 2021 07:09:01 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6A8334B6F6
 for <kvmarm@lists.cs.columbia.edu>; Tue,  9 Feb 2021 07:08:59 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wc8kaDTFYP49 for <kvmarm@lists.cs.columbia.edu>;
 Tue,  9 Feb 2021 07:08:58 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E69804B4BC
 for <kvmarm@lists.cs.columbia.edu>; Tue,  9 Feb 2021 07:08:57 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CC8CED1;
 Tue,  9 Feb 2021 04:08:57 -0800 (PST)
Received: from [10.57.49.26] (unknown [10.57.49.26])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B4693F73B;
 Tue,  9 Feb 2021 04:08:54 -0800 (PST)
Subject: Re: [RFC PATCH 10/11] vfio/iommu_type1: Optimize dirty bitmap
 population based on iommu HWDBM
To: Yi Sun <yi.y.sun@linux.intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
References: <20210128151742.18840-1-zhukeqian1@huawei.com>
 <20210128151742.18840-11-zhukeqian1@huawei.com>
 <20210207095630.GA28580@yi.y.sun>
 <407d28db-1f86-8d4f-ab15-3c3ac56bbe7f@huawei.com>
 <20210209115744.GB28580@yi.y.sun>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <b137db1d-a31b-3a81-08fa-24d7a8c290e9@arm.com>
Date: Tue, 9 Feb 2021 12:08:48 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210209115744.GB28580@yi.y.sun>
Content-Language: en-GB
Cc: kevin.tian@intel.com, Cornelia Huck <cohuck@redhat.com>,
 yan.y.zhao@intel.com, kvm@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 Alex Williamson <alex.williamson@redhat.com>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, lushenming@huawei.com,
 Kirti Wankhede <kwankhede@nvidia.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
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

On 2021-02-09 11:57, Yi Sun wrote:
> On 21-02-07 18:40:36, Keqian Zhu wrote:
>> Hi Yi,
>>
>> On 2021/2/7 17:56, Yi Sun wrote:
>>> Hi,
>>>
>>> On 21-01-28 23:17:41, Keqian Zhu wrote:
>>>
>>> [...]
>>>
>>>> +static void vfio_dma_dirty_log_start(struct vfio_iommu *iommu,
>>>> +				     struct vfio_dma *dma)
>>>> +{
>>>> +	struct vfio_domain *d;
>>>> +
>>>> +	list_for_each_entry(d, &iommu->domain_list, next) {
>>>> +		/* Go through all domain anyway even if we fail */
>>>> +		iommu_split_block(d->domain, dma->iova, dma->size);
>>>> +	}
>>>> +}
>>>
>>> This should be a switch to prepare for dirty log start. Per Intel
>>> Vtd spec, there is SLADE defined in Scalable-Mode PASID Table Entry.
>>> It enables Accessed/Dirty Flags in second-level paging entries.
>>> So, a generic iommu interface here is better. For Intel iommu, it
>>> enables SLADE. For ARM, it splits block.
>> Indeed, a generic interface name is better.
>>
>> The vendor iommu driver plays vendor's specific actions to start dirty log, and Intel iommu and ARM smmu may differ. Besides, we may add more actions in ARM smmu driver in future.
>>
>> One question: Though I am not familiar with Intel iommu, I think it also should split block mapping besides enable SLADE. Right?
>>
> I am not familiar with ARM smmu. :) So I want to clarify if the block
> in smmu is big page, e.g. 2M page? Intel Vtd manages the memory per
> page, 4KB/2MB/1GB.

Indeed, what you call large pages, we call blocks :)

Robin.

> There are two ways to manage dirty pages.
> 1. Keep default granularity. Just set SLADE to enable the dirty track.
> 2. Split big page to 4KB to get finer granularity.
> 
> But question about the second solution is if it can benefit the user
> space, e.g. live migration. If my understanding about smmu block (i.e.
> the big page) is correct, have you collected some performance data to
> prove that the split can improve performance? Thanks!
> 
>> Thanks,
>> Keqian
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
