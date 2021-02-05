Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2378D310774
	for <lists+kvmarm@lfdr.de>; Fri,  5 Feb 2021 10:14:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A799B4B366;
	Fri,  5 Feb 2021 04:14:07 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CxciY7d7ejRK; Fri,  5 Feb 2021 04:14:07 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6F6C64B38D;
	Fri,  5 Feb 2021 04:14:06 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9C8614B384
 for <kvmarm@lists.cs.columbia.edu>; Fri,  5 Feb 2021 04:14:05 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id narRwG8ExkuZ for <kvmarm@lists.cs.columbia.edu>;
 Fri,  5 Feb 2021 04:14:02 -0500 (EST)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 137354B366
 for <kvmarm@lists.cs.columbia.edu>; Fri,  5 Feb 2021 04:14:02 -0500 (EST)
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DX8nY3fJxzlGg7;
 Fri,  5 Feb 2021 17:12:17 +0800 (CST)
Received: from [10.174.184.42] (10.174.184.42) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Fri, 5 Feb 2021 17:13:51 +0800
Subject: Re: [RFC PATCH 01/11] iommu/arm-smmu-v3: Add feature detection for
 HTTU
To: Robin Murphy <robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <kvm@vger.kernel.org>,
 <kvmarm@lists.cs.columbia.edu>, <iommu@lists.linux-foundation.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20210128151742.18840-1-zhukeqian1@huawei.com>
 <20210128151742.18840-2-zhukeqian1@huawei.com>
 <f8be5718-d4d9-0565-eaf0-b5a128897d15@arm.com>
From: Keqian Zhu <zhukeqian1@huawei.com>
Message-ID: <df1b8fb2-b853-e797-0072-9dbdffc4ff67@huawei.com>
Date: Fri, 5 Feb 2021 17:13:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <f8be5718-d4d9-0565-eaf0-b5a128897d15@arm.com>
X-Originating-IP: [10.174.184.42]
X-CFilter-Loop: Reflected
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Cornelia Huck <cohuck@redhat.com>,
 Marc Zyngier <maz@kernel.org>, Kirti Wankhede <kwankhede@nvidia.com>,
 lushenming@huawei.com, Alex Williamson <alex.williamson@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
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

Hi Robin and Jean,

On 2021/2/5 3:50, Robin Murphy wrote:
> On 2021-01-28 15:17, Keqian Zhu wrote:
>> From: jiangkunkun <jiangkunkun@huawei.com>
>>
>> The SMMU which supports HTTU (Hardware Translation Table Update) can
>> update the access flag and the dirty state of TTD by hardware. It is
>> essential to track dirty pages of DMA.
>>
>> This adds feature detection, none functional change.
>>
>> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
>> Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
>> ---
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 16 ++++++++++++++++
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  8 ++++++++
>>   include/linux/io-pgtable.h                  |  1 +
>>   3 files changed, 25 insertions(+)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index 8ca7415d785d..0f0fe71cc10d 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -1987,6 +1987,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
>>           .pgsize_bitmap    = smmu->pgsize_bitmap,
>>           .ias        = ias,
>>           .oas        = oas,
>> +        .httu_hd    = smmu->features & ARM_SMMU_FEAT_HTTU_HD,
>>           .coherent_walk    = smmu->features & ARM_SMMU_FEAT_COHERENCY,
>>           .tlb        = &arm_smmu_flush_ops,
>>           .iommu_dev    = smmu->dev,
>> @@ -3224,6 +3225,21 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>>       if (reg & IDR0_HYP)
>>           smmu->features |= ARM_SMMU_FEAT_HYP;
>>   +    switch (FIELD_GET(IDR0_HTTU, reg)) {
> 
> We need to accommodate the firmware override as well if we need this to be meaningful. Jean-Philippe is already carrying a suitable patch in the SVA stack[1].
Robin, Thanks for pointing it out.

Jean, I see that the IORT HTTU flag overrides the hardware register info unconditionally. I have some concern about it:

If the override flag has HTTU but hardware doesn't support it, then driver will use this feature but receive access fault or permission fault from SMMU unexpectedly.
1) If IOPF is not supported, then kernel can not work normally.
2) If IOPF is supported, kernel will perform useless actions, such as HTTU based dma dirty tracking (this series).

As the IORT spec doesn't give an explicit explanation for HTTU override, can we comprehend it as a mask for HTTU related hardware register?
So the logic becomes: smmu->feature = HTTU override & IDR0_HTTU;

> 
>> +    case IDR0_HTTU_NONE:
>> +        break;
>> +    case IDR0_HTTU_HA:
>> +        smmu->features |= ARM_SMMU_FEAT_HTTU_HA;
>> +        break;
>> +    case IDR0_HTTU_HAD:
>> +        smmu->features |= ARM_SMMU_FEAT_HTTU_HA;
>> +        smmu->features |= ARM_SMMU_FEAT_HTTU_HD;
>> +        break;
>> +    default:
>> +        dev_err(smmu->dev, "unknown/unsupported HTTU!\n");
>> +        return -ENXIO;
>> +    }
>> +
>>       /*
>>        * The coherency feature as set by FW is used in preference to the ID
>>        * register, but warn on mismatch.
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>> index 96c2e9565e00..e91bea44519e 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>> @@ -33,6 +33,10 @@
>>   #define IDR0_ASID16            (1 << 12)
>>   #define IDR0_ATS            (1 << 10)
>>   #define IDR0_HYP            (1 << 9)
>> +#define IDR0_HTTU            GENMASK(7, 6)
>> +#define IDR0_HTTU_NONE            0
>> +#define IDR0_HTTU_HA            1
>> +#define IDR0_HTTU_HAD            2
>>   #define IDR0_COHACC            (1 << 4)
>>   #define IDR0_TTF            GENMASK(3, 2)
>>   #define IDR0_TTF_AARCH64        2
>> @@ -286,6 +290,8 @@
>>   #define CTXDESC_CD_0_TCR_TBI0        (1ULL << 38)
>>     #define CTXDESC_CD_0_AA64        (1UL << 41)
>> +#define CTXDESC_CD_0_HD            (1UL << 42)
>> +#define CTXDESC_CD_0_HA            (1UL << 43)
>>   #define CTXDESC_CD_0_S            (1UL << 44)
>>   #define CTXDESC_CD_0_R            (1UL << 45)
>>   #define CTXDESC_CD_0_A            (1UL << 46)
>> @@ -604,6 +610,8 @@ struct arm_smmu_device {
>>   #define ARM_SMMU_FEAT_RANGE_INV        (1 << 15)
>>   #define ARM_SMMU_FEAT_BTM        (1 << 16)
>>   #define ARM_SMMU_FEAT_SVA        (1 << 17)
>> +#define ARM_SMMU_FEAT_HTTU_HA        (1 << 18)
>> +#define ARM_SMMU_FEAT_HTTU_HD        (1 << 19)
>>       u32                features;
>>     #define ARM_SMMU_OPT_SKIP_PREFETCH    (1 << 0)
>> diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
>> index ea727eb1a1a9..1a00ea8562c7 100644
>> --- a/include/linux/io-pgtable.h
>> +++ b/include/linux/io-pgtable.h
>> @@ -97,6 +97,7 @@ struct io_pgtable_cfg {
>>       unsigned long            pgsize_bitmap;
>>       unsigned int            ias;
>>       unsigned int            oas;
>> +    bool                httu_hd;
> 
> This is very specific to the AArch64 stage 1 format, not a generic capability - I think it should be a quirk flag rather than a common field.
OK, so BBML should be a quirk flag too?

Though the word "quirk" is not suitable for HTTU and BBML, we have no other place to convey smmu feature to io-pgtable.

Maybe we can add another field named "iommu_features"? Anyway, I am OK with putting them into quirk flag. :-)

> 
> Robin.
> 
> [1] https://jpbrucker.net/git/linux/commit/?h=sva/current&id=1ef7d512fb9082450dfe0d22ca4f7e35625a097b
> 
>>       bool                coherent_walk;
>>       const struct iommu_flush_ops    *tlb;
>>       struct device            *iommu_dev;
>>
> .
> 
Thanks,
Keqian
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
