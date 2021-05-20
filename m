Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 94F8D38B006
	for <lists+kvmarm@lfdr.de>; Thu, 20 May 2021 15:32:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2068C4B49E;
	Thu, 20 May 2021 09:32:28 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0TL81MVK8Y7d; Thu, 20 May 2021 09:32:28 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EFB6B4B440;
	Thu, 20 May 2021 09:32:26 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 862E54B323
 for <kvmarm@lists.cs.columbia.edu>; Thu, 20 May 2021 09:32:25 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1vuvjh7ef12h for <kvmarm@lists.cs.columbia.edu>;
 Thu, 20 May 2021 09:32:23 -0400 (EDT)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 8820E4B312
 for <kvmarm@lists.cs.columbia.edu>; Thu, 20 May 2021 09:32:23 -0400 (EDT)
Received: from dggems701-chm.china.huawei.com (unknown [172.30.72.60])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Fm9Zy1rlJzmXDj;
 Thu, 20 May 2021 21:30:02 +0800 (CST)
Received: from dggema764-chm.china.huawei.com (10.1.198.206) by
 dggems701-chm.china.huawei.com (10.3.19.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 21:32:19 +0800
Received: from [10.174.185.179] (10.174.185.179) by
 dggema764-chm.china.huawei.com (10.1.198.206) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 20 May 2021 21:32:18 +0800
Subject: Re: [PATCH v4 01/66] arm64: Add ARM64_HAS_NESTED_VIRT cpufeature
To: Marc Zyngier <maz@kernel.org>
References: <20210510165920.1913477-1-maz@kernel.org>
 <20210510165920.1913477-2-maz@kernel.org>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <e20813df-cb19-9856-b80d-16b3bffc2f7d@huawei.com>
Date: Thu, 20 May 2021 21:32:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20210510165920.1913477-2-maz@kernel.org>
Content-Language: en-US
X-Originating-IP: [10.174.185.179]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema764-chm.china.huawei.com (10.1.198.206)
X-CFilter-Loop: Reflected
Cc: kernel-team@android.com, kvm@vger.kernel.org,
 Andre Przywara <andre.przywara@arm.com>, kvmarm@lists.cs.columbia.edu,
 Jintack Lim <jintack.lim@linaro.org>, linux-arm-kernel@lists.infradead.org
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

On 2021/5/11 0:58, Marc Zyngier wrote:
> From: Jintack Lim <jintack.lim@linaro.org>
> 
> Add a new ARM64_HAS_NESTED_VIRT feature to indicate that the
> CPU has the ARMv8.3 nested virtualization capability.
> 
> This will be used to support nested virtualization in KVM.
> 
> Signed-off-by: Jintack Lim <jintack.lim@linaro.org>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  .../admin-guide/kernel-parameters.txt         |  4 +++
>  arch/arm64/include/asm/cpucaps.h              |  1 +
>  arch/arm64/kernel/cpufeature.c                | 25 +++++++++++++++++++
>  3 files changed, 30 insertions(+)

[...]

> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index efed2830d141..056de86d7f6f 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1645,6 +1645,21 @@ static void cpu_copy_el2regs(const struct arm64_cpu_capabilities *__unused)
>  		write_sysreg(read_sysreg(tpidr_el1), tpidr_el2);
>  }
>  
> +static bool nested_param;
> +static bool has_nested_virt_support(const struct arm64_cpu_capabilities *cap,
> +				    int scope)
> +{
> +	return has_cpuid_feature(cap, scope) &&
> +		nested_param;
> +}

Nitpick:

How about putting them into a single line (they still perfectly
fit within the 80-colume limit)?

Zenghui
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
