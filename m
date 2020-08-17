Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BEC47246381
	for <lists+kvmarm@lfdr.de>; Mon, 17 Aug 2020 11:39:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5A7E34BD4F;
	Mon, 17 Aug 2020 05:39:10 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 69tFdXy6nUjS; Mon, 17 Aug 2020 05:39:10 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 326A84BC6A;
	Mon, 17 Aug 2020 05:39:09 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BC7AD4BBBC
 for <kvmarm@lists.cs.columbia.edu>; Mon, 17 Aug 2020 05:39:07 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZT2fi76YxaN4 for <kvmarm@lists.cs.columbia.edu>;
 Mon, 17 Aug 2020 05:39:06 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8315B4BC42
 for <kvmarm@lists.cs.columbia.edu>; Mon, 17 Aug 2020 05:39:06 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 247BE31B;
 Mon, 17 Aug 2020 02:39:06 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B62C43F6CF;
 Mon, 17 Aug 2020 02:39:04 -0700 (PDT)
Subject: Re: [PATCH 1/3] KVM: arm64: Some fixes of PV-time interface document
To: Keqian Zhu <zhukeqian1@huawei.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
References: <20200817033729.10848-1-zhukeqian1@huawei.com>
 <20200817033729.10848-2-zhukeqian1@huawei.com>
From: Steven Price <steven.price@arm.com>
Message-ID: <ee7e726a-324f-16d6-7888-508ce7a2e19d@arm.com>
Date: Mon, 17 Aug 2020 10:39:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817033729.10848-2-zhukeqian1@huawei.com>
Content-Language: en-GB
Cc: Marc Zyngier <maz@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>
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

On 17/08/2020 04:37, Keqian Zhu wrote:
> Rename PV_FEATURES tp PV_TIME_FEATURES
                      ^^
Typos are sadly far too easy in documentation...

> 
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>   Documentation/virt/kvm/arm/pvtime.rst | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/virt/kvm/arm/pvtime.rst b/Documentation/virt/kvm/arm/pvtime.rst
> index 687b60d..94bffe2 100644
> --- a/Documentation/virt/kvm/arm/pvtime.rst
> +++ b/Documentation/virt/kvm/arm/pvtime.rst
> @@ -3,7 +3,7 @@
>   Paravirtualized time support for arm64
>   ======================================
>   
> -Arm specification DEN0057/A defines a standard for paravirtualised time
> +Arm specification DEN0057/A defines a standard for paravirtualized time
>   support for AArch64 guests:
>   
>   https://developer.arm.com/docs/den0057/a
> @@ -19,8 +19,8 @@ Two new SMCCC compatible hypercalls are defined:
>   
>   These are only available in the SMC64/HVC64 calling convention as
>   paravirtualized time is not available to 32 bit Arm guests. The existence of
> -the PV_FEATURES hypercall should be probed using the SMCCC 1.1 ARCH_FEATURES
> -mechanism before calling it.
> +the PV_TIME_FEATURES hypercall should be probed using the SMCCC 1.1
> +ARCH_FEATURES mechanism before calling it.
>   
>   PV_TIME_FEATURES
>       ============= ========    ==========
> 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
