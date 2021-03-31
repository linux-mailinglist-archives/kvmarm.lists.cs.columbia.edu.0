Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3430D34E42A
	for <lists+kvmarm@lfdr.de>; Tue, 30 Mar 2021 11:18:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 338134B2DF;
	Tue, 30 Mar 2021 05:18:17 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PKWJVqItwHYu; Tue, 30 Mar 2021 05:18:17 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1E8D64B2D3;
	Tue, 30 Mar 2021 05:18:16 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 645A44B2CB
 for <kvmarm@lists.cs.columbia.edu>; Tue, 30 Mar 2021 05:18:15 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KpIdudQMcdQM for <kvmarm@lists.cs.columbia.edu>;
 Tue, 30 Mar 2021 05:18:12 -0400 (EDT)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 937CD4B281
 for <kvmarm@lists.cs.columbia.edu>; Tue, 30 Mar 2021 05:18:12 -0400 (EDT)
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F8kMt0wnMzqSNJ;
 Tue, 30 Mar 2021 17:16:26 +0800 (CST)
Received: from [10.174.185.179] (10.174.185.179) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Tue, 30 Mar 2021 17:17:59 +0800
Subject: Re: [PATCH v14 06/13] iommu/smmuv3: Allow stage 1 invalidation with
 unmanaged ASIDs
To: Eric Auger <eric.auger@redhat.com>
References: <20210223205634.604221-1-eric.auger@redhat.com>
 <20210223205634.604221-7-eric.auger@redhat.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <7a270196-2a8d-1b23-ee5f-f977c53d2134@huawei.com>
Date: Tue, 30 Mar 2021 17:17:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20210223205634.604221-7-eric.auger@redhat.com>
Content-Language: en-US
X-Originating-IP: [10.174.185.179]
X-CFilter-Loop: Reflected
Cc: kvm@vger.kernel.org, vivek.gautam@arm.com, kvmarm@lists.cs.columbia.edu,
 eric.auger.pro@gmail.com, jean-philippe@linaro.org, yi.l.liu@intel.com,
 wangxingang5@huawei.com, maz@kernel.org, joro@8bytes.org, vsethi@nvidia.com,
 zhangfei.gao@linaro.org, jacob.jun.pan@linux.intel.com, will@kernel.org,
 nicoleotsuka@gmail.com, alex.williamson@redhat.com,
 linux-kernel@vger.kernel.org, lushenming@huawei.com,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com
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

On 2021/2/24 4:56, Eric Auger wrote:
> @@ -1936,7 +1950,12 @@ static void arm_smmu_tlb_inv_range_domain(unsigned long iova, size_t size,
>   		},
>   	};
>   
> -	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
> +	if (ext_asid >= 0) {  /* guest stage 1 invalidation */
> +		cmd.opcode	= smmu_domain->smmu->features & ARM_SMMU_FEAT_E2H ?
> +				  CMDQ_OP_TLBI_EL2_VA : CMDQ_OP_TLBI_NH_VA;

If I understand it correctly, the true nested mode effectively gives us
a *NS-EL1* StreamWorld. We should therefore use CMDQ_OP_TLBI_NH_VA to
invalidate the stage-1 NS-EL1 entries, no matter E2H is selected or not.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
