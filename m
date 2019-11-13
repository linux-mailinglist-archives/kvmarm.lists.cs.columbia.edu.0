Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 20DE1FB27C
	for <lists+kvmarm@lfdr.de>; Wed, 13 Nov 2019 15:24:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B08744B150;
	Wed, 13 Nov 2019 09:24:18 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pC0gkqnx2MtE; Wed, 13 Nov 2019 09:24:18 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9728E4B13B;
	Wed, 13 Nov 2019 09:24:17 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0E38A4B0E0
 for <kvmarm@lists.cs.columbia.edu>; Wed, 13 Nov 2019 09:24:17 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CML15ZqTOQl9 for <kvmarm@lists.cs.columbia.edu>;
 Wed, 13 Nov 2019 09:24:16 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 067DE4B06F
 for <kvmarm@lists.cs.columbia.edu>; Wed, 13 Nov 2019 09:24:16 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84C5D7A7;
 Wed, 13 Nov 2019 06:24:15 -0800 (PST)
Received: from [10.1.194.43] (e112269-lin.cambridge.arm.com [10.1.194.43])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A14F3F6C4;
 Wed, 13 Nov 2019 06:24:14 -0800 (PST)
From: Steven Price <steven.price@arm.com>
Subject: Re: [PATCH -next] KVM: arm: remove duplicate include
To: YueHaibing <yuehaibing@huawei.com>, maz@kernel.org, james.morse@arm.com,
 julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com
References: <20191113014045.15276-1-yuehaibing@huawei.com>
Message-ID: <daa269a8-17d2-b568-8287-7606ccd9e200@arm.com>
Date: Wed, 13 Nov 2019 14:24:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191113014045.15276-1-yuehaibing@huawei.com>
Content-Language: en-GB
Cc: kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
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

On 13/11/2019 01:40, YueHaibing wrote:
> Remove duplicate header which is included twice.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Steven Price <steven.price@arm.com>

Thanks for spotting - I'm not sure how that happened! This
Fixes: 8564d6372a7d ("KVM: arm64: Support stolen time reporting via shared structure")
although I don't think it causes any actual harm.

Steve

> ---
>  virt/kvm/arm/arm.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
> index 12e0280..d910a03 100644
> --- a/virt/kvm/arm/arm.c
> +++ b/virt/kvm/arm/arm.c
> @@ -20,8 +20,6 @@
>  #include <linux/irqbypass.h>
>  #include <linux/sched/stat.h>
>  #include <trace/events/kvm.h>
> -#include <kvm/arm_pmu.h>
> -#include <kvm/arm_psci.h>
>  
>  #define CREATE_TRACE_POINTS
>  #include "trace.h"
> 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
