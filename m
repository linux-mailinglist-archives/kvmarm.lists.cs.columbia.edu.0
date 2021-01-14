Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD3C2F60C8
	for <lists+kvmarm@lfdr.de>; Thu, 14 Jan 2021 13:11:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 02A784B1CE;
	Thu, 14 Jan 2021 07:11:30 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IE71ovd04nfU; Thu, 14 Jan 2021 07:11:29 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A055B4B1BF;
	Thu, 14 Jan 2021 07:11:28 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 36A864B1A1
 for <kvmarm@lists.cs.columbia.edu>; Thu, 14 Jan 2021 07:11:27 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jN7ZdiG067PY for <kvmarm@lists.cs.columbia.edu>;
 Thu, 14 Jan 2021 07:11:25 -0500 (EST)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 7E3EC4B1B4
 for <kvmarm@lists.cs.columbia.edu>; Thu, 14 Jan 2021 07:11:24 -0500 (EST)
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DGjmm3wbLzMKPF;
 Thu, 14 Jan 2021 20:10:00 +0800 (CST)
Received: from [10.174.184.42] (10.174.184.42) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Thu, 14 Jan 2021 20:11:09 +0800
Subject: Re: [PATCH 4/5] vfio/iommu_type1: Carefully use unmap_unpin_all
 during dirty tracking
To: Alex Williamson <alex.williamson@redhat.com>
References: <20210107092901.19712-1-zhukeqian1@huawei.com>
 <20210107092901.19712-5-zhukeqian1@huawei.com>
 <20210111144913.3092b1b1@omen.home.shazbot.org>
 <198f0afd-343a-9fbc-9556-95670ca76a2c@huawei.com>
 <20210112125331.789f47a5@omen.home.shazbot.org>
From: Keqian Zhu <zhukeqian1@huawei.com>
Message-ID: <14ee2346-ea9e-ab24-40d7-45a3bd16510d@huawei.com>
Date: Thu, 14 Jan 2021 20:11:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20210112125331.789f47a5@omen.home.shazbot.org>
X-Originating-IP: [10.174.184.42]
X-CFilter-Loop: Reflected
Cc: kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu, Marc
 Zyngier <maz@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
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



On 2021/1/13 3:53, Alex Williamson wrote:
> On Tue, 12 Jan 2021 20:04:38 +0800
> Keqian Zhu <zhukeqian1@huawei.com> wrote:
> 
>> On 2021/1/12 5:49, Alex Williamson wrote:
>>> On Thu, 7 Jan 2021 17:29:00 +0800
>>> Keqian Zhu <zhukeqian1@huawei.com> wrote:
>>>   
>>>> If we detach group during dirty page tracking, we shouldn't remove
>>>> vfio_dma, because dirty log will lose.
>>>>
>>>> But we don't prevent unmap_unpin_all in vfio_iommu_release, because
>>>> under normal procedure, dirty tracking has been stopped.  
>>>
>>> This looks like it's creating a larger problem than it's fixing, it's
>>> not our job to maintain the dirty bitmap regardless of what the user
>>> does.  If the user detaches the last group in a container causing the
>>> mappings within that container to be deconstructed before the user has
>>> collected dirty pages, that sounds like a user error.  A container with
>>> no groups is de-privileged and therefore loses all state.  Thanks,
>>>
>>> Alex  
>>
>> Hi Alex,
>>
>> This looks good to me ;-). That's a reasonable constraint for user behavior.
>>
>> What about replacing this patch with an addition to the uapi document of
>> VFIO_GROUP_UNSET_CONTAINER? User should pay attention to this when call this
>> ioctl during dirty tracking.
> 
> Here's the current uapi comment:
> 
> /**
>  * VFIO_GROUP_UNSET_CONTAINER - _IO(VFIO_TYPE, VFIO_BASE + 5)
>  *
>  * Remove the group from the attached container.  This is the
>  * opposite of the SET_CONTAINER call and returns the group to
>  * an initial state.  All device file descriptors must be released
>  * prior to calling this interface.  When removing the last group
>  * from a container, the IOMMU will be disabled and all state lost,
>  * effectively also returning the VFIO file descriptor to an initial
>  * state.
>  * Return: 0 on success, -errno on failure.
>  * Availability: When attached to container
>  */
> 
> So we already indicate that "all state" of the container is lost when
> removing the last group, I don't see that it's necessarily to
> explicitly include dirty bitmap state beyond that statement.  Without
> mappings there can be no dirty bitmap to track.
OK :-) .

> 
>  > And any comments on other patches? thanks.
> 
> I had a difficult time mapping the commit log to the actual code
> change, I'll likely have some wording suggestions.  Is patch 5/5 still
> necessary if this patch is dropped?  Thanks,
> 
I think the 5th patch is still necessary. vfio_sanity_check_pfn_list() is used to check
whether pfn_list of vfio_dma is empty. but we apply this check just for external domain.
If the iommu backed domain also pin some pages, then this check fails. So I think we should
use this check only when all domains are about to be removed.

Besides, this patch should extract the "WARN_ON(iommu->notifier.head);" just for external domain.

Thanks,
Keqian

> Alex
> 
>>>> Fixes: d6a4c185660c ("vfio iommu: Implementation of ioctl for dirty pages tracking")
>>>> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
>>>> ---
>>>>  drivers/vfio/vfio_iommu_type1.c | 14 ++++++++++++--
>>>>  1 file changed, 12 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
>>>> index 26b7eb2a5cfc..9776a059904d 100644
>>>> --- a/drivers/vfio/vfio_iommu_type1.c
>>>> +++ b/drivers/vfio/vfio_iommu_type1.c
>>>> @@ -2373,7 +2373,12 @@ static void vfio_iommu_type1_detach_group(void *iommu_data,
>>>>  			if (list_empty(&iommu->external_domain->group_list)) {
>>>>  				vfio_sanity_check_pfn_list(iommu);
>>>>  
>>>> -				if (!IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu))
>>>> +				/*
>>>> +				 * During dirty page tracking, we can't remove
>>>> +				 * vfio_dma because dirty log will lose.
>>>> +				 */
>>>> +				if (!IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu) &&
>>>> +				    !iommu->dirty_page_tracking)
>>>>  					vfio_iommu_unmap_unpin_all(iommu);
>>>>  
>>>>  				kfree(iommu->external_domain);
>>>> @@ -2406,10 +2411,15 @@ static void vfio_iommu_type1_detach_group(void *iommu_data,
>>>>  		 * iommu and external domain doesn't exist, then all the
>>>>  		 * mappings go away too. If it's the last domain with iommu and
>>>>  		 * external domain exist, update accounting
>>>> +		 *
>>>> +		 * Note: During dirty page tracking, we can't remove vfio_dma
>>>> +		 * because dirty log will lose. Just update accounting is a good
>>>> +		 * choice.
>>>>  		 */
>>>>  		if (list_empty(&domain->group_list)) {
>>>>  			if (list_is_singular(&iommu->domain_list)) {
>>>> -				if (!iommu->external_domain)
>>>> +				if (!iommu->external_domain &&
>>>> +				    !iommu->dirty_page_tracking)
>>>>  					vfio_iommu_unmap_unpin_all(iommu);
>>>>  				else
>>>>  					vfio_iommu_unmap_unpin_reaccount(iommu);  
>>>
>>> .
>>>   
>>
> 
> .
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
