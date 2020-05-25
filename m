Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 285B91E0D5D
	for <lists+kvmarm@lfdr.de>; Mon, 25 May 2020 13:34:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B40A94B1D1;
	Mon, 25 May 2020 07:34:33 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qGe4x8qwoJ32; Mon, 25 May 2020 07:34:33 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 86C8B4B17A;
	Mon, 25 May 2020 07:34:32 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E2CD64B162
 for <kvmarm@lists.cs.columbia.edu>; Mon, 25 May 2020 07:34:31 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sM7ndql8m3+C for <kvmarm@lists.cs.columbia.edu>;
 Mon, 25 May 2020 07:34:30 -0400 (EDT)
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A9AB44B15F
 for <kvmarm@lists.cs.columbia.edu>; Mon, 25 May 2020 07:34:30 -0400 (EDT)
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 70F0B3DFEED4FB33AF0C;
 Mon, 25 May 2020 19:34:27 +0800 (CST)
Received: from [127.0.0.1] (10.173.221.213) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0;
 Mon, 25 May 2020 19:34:19 +0800
Subject: Re: [RFC] Use SMMU HTTU for DMA dirty page tracking
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <b926ec0b-fe87-0792-c41d-acad56c656a4@huawei.com>
 <20200522171452.GC3453945@myrica>
From: Xiang Zheng <zhengxiang9@huawei.com>
Message-ID: <e68c1158-8573-a477-42ce-48cee510c3ce@huawei.com>
Date: Mon, 25 May 2020 19:34:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20200522171452.GC3453945@myrica>
Content-Language: en-US
X-Originating-IP: [10.173.221.213]
X-CFilter-Loop: Reflected
Cc: alex.williamson@redhat.com, Yan Zhao <yan.y.zhao@intel.com>, maz@kernel.org,
 iommu@lists.linux-foundation.org, Kirti Wankhede <kwankhede@nvidia.com>,
 wangzhou1@hisilicon.com, prime.zeng@hisilicon.com,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

[+cc Kirti, Yan, Alex]

On 2020/5/23 1:14, Jean-Philippe Brucker wrote:
> Hi,
> 
> On Tue, May 19, 2020 at 05:42:55PM +0800, Xiang Zheng wrote:
>> Hi all,
>>
>> Is there any plan for enabling SMMU HTTU?
> 
> Not outside of SVA, as far as I know.
> 

>> I have seen the patch locates in the SVA series patch, which adds
>> support for HTTU:
>>     https://www.spinics.net/lists/arm-kernel/msg798694.html
>>
>> HTTU reduces the number of access faults on SMMU fault queue
>> (permission faults also benifit from it).
>>
>> Besides reducing the faults, HTTU also helps to track dirty pages for
>> device DMA. Is it feasible to utilize HTTU to get dirty pages on device
>> DMA during VFIO live migration?
> 
> As you know there is a VFIO interface for this under discussion:
> https://lore.kernel.org/kvm/1589781397-28368-1-git-send-email-kwankhede@nvidia.com/
> It doesn't implement an internal API to communicate with the IOMMU driver
> about dirty pages.

> 
>> If SMMU can track dirty pages, devices are not required to implement
>> additional dirty pages tracking to support VFIO live migration.
> 
> It seems feasible, though tracking it in the device might be more
> efficient. I might have misunderstood but I think for live migration of
> the Intel NIC they trap guest accesses to the device and introspect its
> state to figure out which pages it is accessing.
> 
> With HTTU I suppose (without much knowledge about live migration) that
> you'd need several new interfaces to the IOMMU drivers:
> 
> * A way for VFIO to query HTTU support in the SMMU. There are some
>   discussions about communicating more IOMMU capabilities through VFIO but
>   no implementation yet. When HTTU isn't supported the DIRTY_PAGES bitmap
>   would report all pages as they do now.
> 
> * VFIO_IOMMU_DIRTY_PAGES_FLAG_START/STOP would clear the dirty bit
>   for all VFIO mappings (which is going to take some time). There is a
>   walker in io-pgtable for iova_to_phys() which could be extended. I
>   suppose it's also possible to atomically switch the HA and HD bits in
>   context descriptors.

Maybe we need not switch HA and HD bits, just turn on them all the time?

> 
> * VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP would query the dirty bit for all
>   VFIO mappings.
> 

I think we need to consider the case of IOMMU dirty pages logging. We want
to test Kirti's VFIO migration patches combined with SMMU HTTU, any suggestions?

-- 
Thanks,
Xiang

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
