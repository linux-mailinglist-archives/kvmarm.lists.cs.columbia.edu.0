Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E958F30B7EA
	for <lists+kvmarm@lfdr.de>; Tue,  2 Feb 2021 07:40:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6286D4B0C8;
	Tue,  2 Feb 2021 01:40:11 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YUVOthQuPzXh; Tue,  2 Feb 2021 01:40:11 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 563F94B17A;
	Tue,  2 Feb 2021 01:40:10 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1064B4B159
 for <kvmarm@lists.cs.columbia.edu>; Tue,  2 Feb 2021 01:40:09 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oh2snmwdzjqm for <kvmarm@lists.cs.columbia.edu>;
 Tue,  2 Feb 2021 01:40:07 -0500 (EST)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id BF98A4B0C8
 for <kvmarm@lists.cs.columbia.edu>; Tue,  2 Feb 2021 01:40:06 -0500 (EST)
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DVFWK6sbBzlFB2;
 Tue,  2 Feb 2021 14:38:21 +0800 (CST)
Received: from [10.174.184.42] (10.174.184.42) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Tue, 2 Feb 2021 14:39:54 +0800
Subject: Re: [PATCH v13 03/15] iommu/arm-smmu-v3: Maintain a SID->device
 structure
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, Eric Auger
 <eric.auger@redhat.com>
References: <20201118112151.25412-1-eric.auger@redhat.com>
 <20201118112151.25412-4-eric.auger@redhat.com>
 <a5cc1635-b69b-50a6-404a-5bf667296669@huawei.com> <YBgbESEyReLV124Z@myrica>
From: Keqian Zhu <zhukeqian1@huawei.com>
Message-ID: <e579b8d7-1e8e-965f-965c-00efdf604eef@huawei.com>
Date: Tue, 2 Feb 2021 14:39:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <YBgbESEyReLV124Z@myrica>
X-Originating-IP: [10.174.184.42]
X-CFilter-Loop: Reflected
Cc: jacob.jun.pan@linux.intel.com, alex.williamson@redhat.com,
 kvm@vger.kernel.org, maz@kernel.org, joro@8bytes.org,
 linux-kernel@vger.kernel.org, nicoleotsuka@gmail.com, vivek.gautam@arm.com,
 iommu@lists.linux-foundation.org, yi.l.liu@intel.com, zhangfei.gao@linaro.org,
 robin.murphy@arm.com, will@kernel.org, kvmarm@lists.cs.columbia.edu,
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

Hi Jean,

On 2021/2/1 23:15, Jean-Philippe Brucker wrote:
> On Mon, Feb 01, 2021 at 08:26:41PM +0800, Keqian Zhu wrote:
>>> +static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
>>> +				  struct arm_smmu_master *master)
>>> +{
>>> +	int i;
>>> +	int ret = 0;
>>> +	struct arm_smmu_stream *new_stream, *cur_stream;
>>> +	struct rb_node **new_node, *parent_node = NULL;
>>> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
>>> +
>>> +	master->streams = kcalloc(fwspec->num_ids,
>>> +				  sizeof(struct arm_smmu_stream), GFP_KERNEL);
>>> +	if (!master->streams)
>>> +		return -ENOMEM;
>>> +	master->num_streams = fwspec->num_ids;
>> This is not roll-backed when fail.
> 
> No need, the caller frees master
OK.

> 
>>> +
>>> +	mutex_lock(&smmu->streams_mutex);
>>> +	for (i = 0; i < fwspec->num_ids && !ret; i++) {
>> Check ret at here, makes it hard to decide the start index of rollback.
>>
>> If we fail at here, then start index is (i-2).
>> If we fail in the loop, then start index is (i-1).
>>
> [...]
>>> +	if (ret) {
>>> +		for (; i > 0; i--)
>> should be (i >= 0)?
>> And the start index seems not correct.
> 
> Indeed, this whole bit is wrong. I'll fix it while resending the IOPF
> series.
> 
> Thanks,
> Jean
OK, I am glad it helps.

Thanks,
Keqian
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
