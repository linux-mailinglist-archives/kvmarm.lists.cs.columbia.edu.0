Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 329D32CBE78
	for <lists+kvmarm@lfdr.de>; Wed,  2 Dec 2020 14:40:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9E51B4B36F;
	Wed,  2 Dec 2020 08:40:04 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pztr1SJChjwH; Wed,  2 Dec 2020 08:40:04 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6AFA54B343;
	Wed,  2 Dec 2020 08:40:01 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 526E04B340
 for <kvmarm@lists.cs.columbia.edu>; Wed,  2 Dec 2020 08:00:27 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V60wHDgr8hyh for <kvmarm@lists.cs.columbia.edu>;
 Wed,  2 Dec 2020 08:00:21 -0500 (EST)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 493DC4B33E
 for <kvmarm@lists.cs.columbia.edu>; Wed,  2 Dec 2020 08:00:21 -0500 (EST)
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CmJw55c63zhlpC;
 Wed,  2 Dec 2020 20:59:49 +0800 (CST)
Received: from [10.174.185.226] (10.174.185.226) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Wed, 2 Dec 2020 21:00:01 +0800
To: Auger Eric <eric.auger@redhat.com>
References: <20201118112151.25412-8-eric.auger@redhat.com>
 <1606829590-25924-1-git-send-email-wangxingang5@huawei.com>
 <2e69adf5-8207-64f7-fa8e-9f2bd3a3c4e3@redhat.com>
From: Wang Xingang <wangxingang5@huawei.com>
Subject: Re: [PATCH v13 07/15] iommu/smmuv3: Allow stage 1 invalidation with
 unmanaged ASIDs
Message-ID: <8cf8fa21-41e3-f3f9-81e4-90f0bfc26fc0@huawei.com>
Date: Wed, 2 Dec 2020 20:59:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <2e69adf5-8207-64f7-fa8e-9f2bd3a3c4e3@redhat.com>
Content-Language: en-US
X-Originating-IP: [10.174.185.226]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Wed, 02 Dec 2020 08:40:00 -0500
Cc: xieyingtai@huawei.com, jean-philippe@linaro.org, kvm@vger.kernel.org,
 maz@kernel.org, joro@8bytes.org, will@kernel.org,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 vivek.gautam@arm.com, alex.williamson@redhat.com, zhangfei.gao@linaro.org,
 robin.murphy@arm.com, kvmarm@lists.cs.columbia.edu, eric.auger.pro@gmail.com
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

Thanks for your reply. We are testing vSVA, and will let you know if
other problems are found.

On 2020/12/1 21:58, Auger Eric wrote:
> Hi Xingang,
> 
> On 12/1/20 2:33 PM, Xingang Wang wrote:
>> Hi Eric
>>
>> On  Wed, 18 Nov 2020 12:21:43, Eric Auger wrote:
>>> @@ -1710,7 +1710,11 @@ static void arm_smmu_tlb_inv_context(void *cookie)
>>> 	 * insertion to guarantee those are observed before the TLBI. Do be
>>> 	 * careful, 007.
>>> 	 */
>>> -	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
>>> +	if (ext_asid >= 0) { /* guest stage 1 invalidation */
>>> +		cmd.opcode	= CMDQ_OP_TLBI_NH_ASID;
>>> +		cmd.tlbi.asid	= ext_asid;
>>> +		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
>>> +	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
>>
>> Found a problem here, the cmd for guest stage 1 invalidation is built,
>> but it is not delivered to smmu.
>>
> 
> Thank you for the report. I will fix that soon. With that fixed, have
> you been able to run vSVA on top of the series. Do you need other stuff
> to be fixed at SMMU level? As I am going to respin soon, please let me
> know what is the best branch to rebase to alleviate your integration.
> 
> Best Regards
> 
> Eric
> 
> .
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
