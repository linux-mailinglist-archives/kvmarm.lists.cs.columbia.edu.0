Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id AD441154649
	for <lists+kvmarm@lfdr.de>; Thu,  6 Feb 2020 15:35:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 29BFB4A578;
	Thu,  6 Feb 2020 09:35:21 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oGBFFjmtBJvy; Thu,  6 Feb 2020 09:35:21 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 177CE4A524;
	Thu,  6 Feb 2020 09:35:20 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 760164A4A9
 for <kvmarm@lists.cs.columbia.edu>; Thu,  6 Feb 2020 09:35:18 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w+XxQgHybM9f for <kvmarm@lists.cs.columbia.edu>;
 Thu,  6 Feb 2020 09:35:17 -0500 (EST)
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 14EED4A3B4
 for <kvmarm@lists.cs.columbia.edu>; Thu,  6 Feb 2020 09:35:17 -0500 (EST)
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id D4F307895B7640D4A8E2;
 Thu,  6 Feb 2020 22:35:08 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Thu, 6 Feb 2020
 22:35:02 +0800
Subject: Re: [kvm-unit-tests PATCH v3 04/14] arm/arm64: gicv3: Add some
 re-distributor defines
To: Eric Auger <eric.auger@redhat.com>, <eric.auger.pro@gmail.com>,
 <maz@kernel.org>, <kvmarm@lists.cs.columbia.edu>, <kvm@vger.kernel.org>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
References: <20200128103459.19413-1-eric.auger@redhat.com>
 <20200128103459.19413-5-eric.auger@redhat.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <22a3b0f5-febd-f9e0-4404-7b01643e57b1@huawei.com>
Date: Thu, 6 Feb 2020 22:35:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200128103459.19413-5-eric.auger@redhat.com>
Content-Language: en-US
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Cc: andre.przywara@arm.com, thuth@redhat.com
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

Hi Eric,

On 2020/1/28 18:34, Eric Auger wrote:
> PROPBASER, PENDBASE and GICR_CTRL will be used for LPI management.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>   lib/arm/asm/gic-v3.h | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/lib/arm/asm/gic-v3.h b/lib/arm/asm/gic-v3.h
> index 6beeab6..ffb2e26 100644
> --- a/lib/arm/asm/gic-v3.h
> +++ b/lib/arm/asm/gic-v3.h
> @@ -18,6 +18,7 @@
>    * We expect to be run in Non-secure mode, thus we define the
>    * group1 enable bits with respect to that view.
>    */
> +#define GICD_CTLR			0x0000
>   #define GICD_CTLR_RWP			(1U << 31)
>   #define GICD_CTLR_ARE_NS		(1U << 4)
>   #define GICD_CTLR_ENABLE_G1A		(1U << 1)
> @@ -36,6 +37,11 @@
>   #define GICR_ICENABLER0			GICD_ICENABLER
>   #define GICR_IPRIORITYR0		GICD_IPRIORITYR
>   
> +#define GICR_PROPBASER                  0x0070
> +#define GICR_PENDBASER                  0x0078

nit: we'd better use tab instead of space.

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>

> +#define GICR_CTLR			GICD_CTLR
> +#define GICR_CTLR_ENABLE_LPIS		(1UL << 0)
> +
>   #define ICC_SGI1R_AFFINITY_1_SHIFT	16
>   #define ICC_SGI1R_AFFINITY_2_SHIFT	32
>   #define ICC_SGI1R_AFFINITY_3_SHIFT	48
> 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
