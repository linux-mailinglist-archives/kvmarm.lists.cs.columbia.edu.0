Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id AB32830BDB8
	for <lists+kvmarm@lfdr.de>; Tue,  2 Feb 2021 13:08:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DE4B94B13C;
	Tue,  2 Feb 2021 07:08:54 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JfqILC1zHT5k; Tue,  2 Feb 2021 07:08:54 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BCD904B198;
	Tue,  2 Feb 2021 07:08:53 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4DF374B14A
 for <kvmarm@lists.cs.columbia.edu>; Tue,  2 Feb 2021 07:08:52 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TDSq95IIzZ9F for <kvmarm@lists.cs.columbia.edu>;
 Tue,  2 Feb 2021 07:08:50 -0500 (EST)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 6CA914B13C
 for <kvmarm@lists.cs.columbia.edu>; Tue,  2 Feb 2021 07:08:50 -0500 (EST)
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DVNq54Kjjz7YvC;
 Tue,  2 Feb 2021 20:07:29 +0800 (CST)
Received: from [10.174.184.42] (10.174.184.42) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Tue, 2 Feb 2021 20:08:46 +0800
Subject: Re: [PATCH v11 03/13] vfio: VFIO_IOMMU_SET_MSI_BINDING
To: Eric Auger <eric.auger@redhat.com>, <eric.auger.pro@gmail.com>,
 <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
 <kvm@vger.kernel.org>, <kvmarm@lists.cs.columbia.edu>, <will@kernel.org>,
 <joro@8bytes.org>, <maz@kernel.org>, <robin.murphy@arm.com>,
 <alex.williamson@redhat.com>
References: <20201116110030.32335-1-eric.auger@redhat.com>
 <20201116110030.32335-4-eric.auger@redhat.com>
From: Keqian Zhu <zhukeqian1@huawei.com>
Message-ID: <635db234-33ff-c079-40cb-2de00c089e7c@huawei.com>
Date: Tue, 2 Feb 2021 20:08:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20201116110030.32335-4-eric.auger@redhat.com>
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

On 2020/11/16 19:00, Eric Auger wrote:
> This patch adds the VFIO_IOMMU_SET_MSI_BINDING ioctl which aim
> to (un)register the guest MSI binding to the host. This latter
> then can use those stage 1 bindings to build a nested stage
> binding targeting the physical MSIs.
[...]

> +static int vfio_iommu_type1_set_msi_binding(struct vfio_iommu *iommu,
> +					    unsigned long arg)
> +{
> +	struct vfio_iommu_type1_set_msi_binding msi_binding;
> +	unsigned long minsz;
> +	int ret = -EINVAL;
> +
> +	minsz = offsetofend(struct vfio_iommu_type1_set_msi_binding,
> +			    size);
> +
> +	if (copy_from_user(&msi_binding, (void __user *)arg, minsz))
> +		return -EFAULT;
> +
> +	if (msi_binding.argsz < minsz)
> +		return -EINVAL;
We can check BIND and UNBIND are not set simultaneously, just like VFIO_IOMMU_SET_PASID_TABLE.

> +
> +	if (msi_binding.flags == VFIO_IOMMU_UNBIND_MSI) {
> +		vfio_unbind_msi(iommu, msi_binding.iova);
> +		ret = 0;
> +	} else if (msi_binding.flags == VFIO_IOMMU_BIND_MSI) {
> +		ret = vfio_bind_msi(iommu, msi_binding.iova,
> +				    msi_binding.gpa, msi_binding.size);
> +	}
> +	return ret;
> +}
> +

Thanks,
Keqian
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
