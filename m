Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E95EE1F303
	for <lists+kvmarm@lfdr.de>; Wed, 15 May 2019 14:10:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5F4014A4DD;
	Wed, 15 May 2019 08:10:18 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Tzcr1rp8gRLm; Wed, 15 May 2019 08:10:18 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 200F54A4E3;
	Wed, 15 May 2019 08:10:17 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 113584A4D7
 for <kvmarm@lists.cs.columbia.edu>; Wed, 15 May 2019 08:10:16 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x9hIcDUo0DZd for <kvmarm@lists.cs.columbia.edu>;
 Wed, 15 May 2019 08:10:14 -0400 (EDT)
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C4B824A36B
 for <kvmarm@lists.cs.columbia.edu>; Wed, 15 May 2019 08:10:14 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 178DA80D;
 Wed, 15 May 2019 05:10:14 -0700 (PDT)
Received: from [10.1.196.129] (ostrya.cambridge.arm.com [10.1.196.129])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3CD2A3F71E;
 Wed, 15 May 2019 05:10:11 -0700 (PDT)
Subject: Re: [PATCH v7 04/23] iommu: Introduce attach/detach_pasid_table API
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
 alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
 yi.l.liu@intel.com, will.deacon@arm.com, robin.murphy@arm.com
References: <20190408121911.24103-1-eric.auger@redhat.com>
 <20190408121911.24103-5-eric.auger@redhat.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <21bfdab4-846c-1dc7-6dff-62a46cc9c829@arm.com>
Date: Wed, 15 May 2019 13:09:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190408121911.24103-5-eric.auger@redhat.com>
Content-Language: en-US
Cc: kevin.tian@intel.com, vincent.stehle@arm.com, ashok.raj@intel.com,
 marc.zyngier@arm.com
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

On 08/04/2019 13:18, Eric Auger wrote:
> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> index edcc0dda7993..532a64075f23 100644
> --- a/include/uapi/linux/iommu.h
> +++ b/include/uapi/linux/iommu.h
> @@ -112,4 +112,51 @@ struct iommu_fault {
>  		struct iommu_fault_page_request prm;
>  	};
>  };
> +
> +/**
> + * SMMUv3 Stream Table Entry stage 1 related information
> + * The PASID table is referred to as the context descriptor (CD) table.
> + *
> + * @s1fmt: STE s1fmt (format of the CD table: single CD, linear table
> +   or 2-level table)

Running "scripts/kernel-doc -v -none" on this header produces some
warnings. Not sure if we want to get rid of all of them, but we should
at least fix the coding style for this comment (line must start with
" * "). I'm fixing it up on my sva/api branch

Thanks,
Jean

> + * @s1dss: STE s1dss (specifies the behavior when pasid_bits != 0
> +   and no pasid is passed along with the incoming transaction)
> + * Please refer to the smmu 3.x spec (ARM IHI 0070A) for full details
> + */
> +struct iommu_pasid_smmuv3 {
> +#define PASID_TABLE_SMMUV3_CFG_VERSION_1 1
> +	__u32	version;
> +	__u8 s1fmt;
> +	__u8 s1dss;
> +	__u8 padding[2];
> +};
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
