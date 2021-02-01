Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id ED61730A6E1
	for <lists+kvmarm@lfdr.de>; Mon,  1 Feb 2021 12:53:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4FD3B4B405;
	Mon,  1 Feb 2021 06:53:00 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JL-oDSNqvQHZ; Mon,  1 Feb 2021 06:53:00 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 332844B3EA;
	Mon,  1 Feb 2021 06:52:59 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E399B4B3B3
 for <kvmarm@lists.cs.columbia.edu>; Mon,  1 Feb 2021 06:52:57 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id okOKFbkjxXXt for <kvmarm@lists.cs.columbia.edu>;
 Mon,  1 Feb 2021 06:52:55 -0500 (EST)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 4AB7D4B342
 for <kvmarm@lists.cs.columbia.edu>; Mon,  1 Feb 2021 06:52:55 -0500 (EST)
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DTmWC0lfWzjHP0;
 Mon,  1 Feb 2021 19:51:35 +0800 (CST)
Received: from [10.174.184.42] (10.174.184.42) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Mon, 1 Feb 2021 19:52:45 +0800
Subject: Re: [PATCH v13 02/15] iommu: Introduce bind/unbind_guest_msi
To: Eric Auger <eric.auger@redhat.com>, <eric.auger.pro@gmail.com>,
 <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
 <kvm@vger.kernel.org>, <kvmarm@lists.cs.columbia.edu>, <will@kernel.org>,
 <joro@8bytes.org>, <maz@kernel.org>, <robin.murphy@arm.com>,
 <alex.williamson@redhat.com>
References: <20201118112151.25412-1-eric.auger@redhat.com>
 <20201118112151.25412-3-eric.auger@redhat.com>
From: Keqian Zhu <zhukeqian1@huawei.com>
Message-ID: <6a70d93d-329f-4129-bd90-03f8589c5de4@huawei.com>
Date: Mon, 1 Feb 2021 19:52:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20201118112151.25412-3-eric.auger@redhat.com>
X-Originating-IP: [10.174.184.42]
X-CFilter-Loop: Reflected
Cc: jean-philippe@linaro.org, jacob.jun.pan@linux.intel.com,
 nicoleotsuka@gmail.com, vivek.gautam@arm.com, yi.l.liu@intel.com,
 zhangfei.gao@linaro.org
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

Hi Eric,

On 2020/11/18 19:21, Eric Auger wrote:
> On ARM, MSI are translated by the SMMU. An IOVA is allocated
> for each MSI doorbell. If both the host and the guest are exposed
> with SMMUs, we end up with 2 different IOVAs allocated by each.
> guest allocates an IOVA (gIOVA) to map onto the guest MSI
> doorbell (gDB). The Host allocates another IOVA (hIOVA) to map
> onto the physical doorbell (hDB).
> 
> So we end up with 2 untied mappings:
>          S1            S2
> gIOVA    ->    gDB
>               hIOVA    ->    hDB
> 
> Currently the PCI device is programmed by the host with hIOVA
> as MSI doorbell. So this does not work.
> 
> This patch introduces an API to pass gIOVA/gDB to the host so
> that gIOVA can be reused by the host instead of re-allocating
> a new IOVA. So the goal is to create the following nested mapping:
Does the gDB can be reused under non-nested mode?

> 
>          S1            S2
> gIOVA    ->    gDB     ->    hDB
> 
> and program the PCI device with gIOVA MSI doorbell.
> 
> In case we have several devices attached to this nested domain
> (devices belonging to the same group), they cannot be isolated
> on guest side either. So they should also end up in the same domain
> on guest side. We will enforce that all the devices attached to
> the host iommu domain use the same physical doorbell and similarly
> a single virtual doorbell mapping gets registered (1 single
> virtual doorbell is used on guest as well).
> 
[...]

> + *
> + * The associated IOVA can be reused by the host to create a nested
> + * stage2 binding mapping translating into the physical doorbell used
> + * by the devices attached to the domain.
> + *
> + * All devices within the domain must share the same physical doorbell.
> + * A single MSI GIOVA/GPA mapping can be attached to an iommu_domain.
> + */
> +
> +int iommu_bind_guest_msi(struct iommu_domain *domain,
> +			 dma_addr_t giova, phys_addr_t gpa, size_t size)
> +{
> +	if (unlikely(!domain->ops->bind_guest_msi))
> +		return -ENODEV;
> +
> +	return domain->ops->bind_guest_msi(domain, giova, gpa, size);
> +}
> +EXPORT_SYMBOL_GPL(iommu_bind_guest_msi);
> +
> +void iommu_unbind_guest_msi(struct iommu_domain *domain,
> +			    dma_addr_t iova)
nit: s/iova/giova

> +{
> +	if (unlikely(!domain->ops->unbind_guest_msi))
> +		return;
> +
> +	domain->ops->unbind_guest_msi(domain, iova);
> +}
> +EXPORT_SYMBOL_GPL(iommu_unbind_guest_msi);
> +
[...]

Thanks,
Keqian

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
