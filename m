Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2541C1E3981
	for <lists+kvmarm@lfdr.de>; Wed, 27 May 2020 08:45:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AE9504B1DD;
	Wed, 27 May 2020 02:45:41 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i-BAzBk9282U; Wed, 27 May 2020 02:45:41 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7CC2F4B1C6;
	Wed, 27 May 2020 02:45:40 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 25A8B4B1BE
 for <kvmarm@lists.cs.columbia.edu>; Wed, 27 May 2020 02:45:39 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QsnHqbl6FEDn for <kvmarm@lists.cs.columbia.edu>;
 Wed, 27 May 2020 02:45:37 -0400 (EDT)
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 604C94B1BD
 for <kvmarm@lists.cs.columbia.edu>; Wed, 27 May 2020 02:45:37 -0400 (EDT)
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id EB9C06C080604E208CCE;
 Wed, 27 May 2020 14:45:33 +0800 (CST)
Received: from [127.0.0.1] (10.173.221.213) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0;
 Wed, 27 May 2020 14:45:26 +0800
Subject: Re: [RFC] Use SMMU HTTU for DMA dirty page tracking
To: "Tian, Kevin" <kevin.tian@intel.com>, Jean-Philippe Brucker
 <jean-philippe@linaro.org>
References: <b926ec0b-fe87-0792-c41d-acad56c656a4@huawei.com>
 <20200522171452.GC3453945@myrica>
 <e68c1158-8573-a477-42ce-48cee510c3ce@huawei.com>
 <MWHPR11MB16454475DA1FF417CEF5A32B8CB10@MWHPR11MB1645.namprd11.prod.outlook.com>
From: Xiang Zheng <zhengxiang9@huawei.com>
Message-ID: <897a84ac-0a71-ace7-e05b-3cc9f0b05c28@huawei.com>
Date: Wed, 27 May 2020 14:45:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <MWHPR11MB16454475DA1FF417CEF5A32B8CB10@MWHPR11MB1645.namprd11.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [10.173.221.213]
X-CFilter-Loop: Reflected
Cc: "Zhao, Yan Y" <yan.y.zhao@intel.com>, "maz@kernel.org" <maz@kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "prime.zeng@hisilicon.com" <prime.zeng@hisilicon.com>, Will
 Deacon <will@kernel.org>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>
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


On 2020/5/27 11:27, Tian, Kevin wrote:
>> From: Xiang Zheng
>> Sent: Monday, May 25, 2020 7:34 PM
>>
>> [+cc Kirti, Yan, Alex]
>>
>> On 2020/5/23 1:14, Jean-Philippe Brucker wrote:
>>> Hi,
>>>
>>> On Tue, May 19, 2020 at 05:42:55PM +0800, Xiang Zheng wrote:
>>>> Hi all,
>>>>
>>>> Is there any plan for enabling SMMU HTTU?
>>>
>>> Not outside of SVA, as far as I know.
>>>
>>
>>>> I have seen the patch locates in the SVA series patch, which adds
>>>> support for HTTU:
>>>>     https://www.spinics.net/lists/arm-kernel/msg798694.html
>>>>
>>>> HTTU reduces the number of access faults on SMMU fault queue
>>>> (permission faults also benifit from it).
>>>>
>>>> Besides reducing the faults, HTTU also helps to track dirty pages for
>>>> device DMA. Is it feasible to utilize HTTU to get dirty pages on device
>>>> DMA during VFIO live migration?
>>>
>>> As you know there is a VFIO interface for this under discussion:
>>> https://lore.kernel.org/kvm/1589781397-28368-1-git-send-email-
>> kwankhede@nvidia.com/
>>> It doesn't implement an internal API to communicate with the IOMMU
>> driver
>>> about dirty pages.
> 
> We plan to add such API later, e.g. to utilize A/D bit in VT-d 2nd-level 
> page tables (Rev 3.0). 
> 

Thank you, Kevin.

When will you send this series patches? Maybe(Hope) we can also support
hardware-based dirty pages tracking via common APIs based on your patches. :)

>>
>>>
>>>> If SMMU can track dirty pages, devices are not required to implement
>>>> additional dirty pages tracking to support VFIO live migration.
>>>
>>> It seems feasible, though tracking it in the device might be more
>>> efficient. I might have misunderstood but I think for live migration of
>>> the Intel NIC they trap guest accesses to the device and introspect its
>>> state to figure out which pages it is accessing.
> 
> Does HTTU implement A/D-like mechanism in SMMU page tables, or just
> report dirty pages in a log buffer? Either way tracking dirty pages in IOMMU
> side is generic thus doesn't require device-specific tweak like in Intel NIC.
> 

Currently HTTU just implement A/D-like mechanism in SMMU page tables. We certainly
expect SMMU can also implement PML-like feature so that we can avoid walking the
whole page table to get the dirty pages.

By the way, I'm not sure whether HTTU or SLAD can help for mediated deivce.

-- 
Thanks,
Xiang

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
