Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 671371BA928
	for <lists+kvmarm@lfdr.de>; Mon, 27 Apr 2020 17:50:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F094A4B0B6;
	Mon, 27 Apr 2020 11:50:16 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lD+08iBBOPXx; Mon, 27 Apr 2020 11:50:16 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AD62F4B155;
	Mon, 27 Apr 2020 11:50:15 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5E06E4B133
 for <kvmarm@lists.cs.columbia.edu>; Mon, 27 Apr 2020 11:50:14 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ALBEr1shMsFd for <kvmarm@lists.cs.columbia.edu>;
 Mon, 27 Apr 2020 11:50:13 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 072184B0B6
 for <kvmarm@lists.cs.columbia.edu>; Mon, 27 Apr 2020 11:50:13 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 927BC31B;
 Mon, 27 Apr 2020 08:50:12 -0700 (PDT)
Received: from [10.37.12.144] (unknown [10.37.12.144])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5DB53F68F;
 Mon, 27 Apr 2020 08:50:08 -0700 (PDT)
Subject: Re: [PATCH 04/26] arm64: Detect the ARMv8.4 TTL feature
To: maz@kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org
References: <20200422120050.3693593-1-maz@kernel.org>
 <20200422120050.3693593-5-maz@kernel.org>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <d6032191-ba0e-82a4-4dde-11beef369a11@arm.com>
Date: Mon, 27 Apr 2020 16:55:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200422120050.3693593-5-maz@kernel.org>
Content-Language: en-US
Cc: will@kernel.org, andre.przywara@arm.com, dave.martin@arm.com,
 gcherian@marvell.com, prime.zeng@hisilicon.com, catalin.marinas@arm.com
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

On 04/22/2020 01:00 PM, Marc Zyngier wrote:
> In order to reduce the cost of TLB invalidation, the ARMv8.4 TTL
> feature allows TLBs to be issued with a level allowing for quicker
> invalidation.
> 
> Let's detect the feature for now. Further patches will implement
> its actual usage.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---


>   arch/arm64/include/asm/cpucaps.h |  3 ++-
>   arch/arm64/include/asm/sysreg.h  |  1 +
>   arch/arm64/kernel/cpufeature.c   | 11 +++++++++++
>   3 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
> index 8eb5a088ae658..cabb0c49a1d11 100644
> --- a/arch/arm64/include/asm/cpucaps.h
> +++ b/arch/arm64/include/asm/cpucaps.h
> @@ -61,7 +61,8 @@
>   #define ARM64_HAS_AMU_EXTN			51
>   #define ARM64_HAS_ADDRESS_AUTH			52
>   #define ARM64_HAS_GENERIC_AUTH			53
> +#define ARM64_HAS_ARMv8_4_TTL			54
>   
> -#define ARM64_NCAPS				54
> +#define ARM64_NCAPS				55
>   
>   #endif /* __ASM_CPUCAPS_H */
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 5d10c9148e844..79cf186b7e471 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -726,6 +726,7 @@
>   
>   /* id_aa64mmfr2 */
>   #define ID_AA64MMFR2_E0PD_SHIFT		60
> +#define ID_AA64MMFR2_TTL_SHIFT		48
>   #define ID_AA64MMFR2_FWB_SHIFT		40
>   #define ID_AA64MMFR2_AT_SHIFT		32
>   #define ID_AA64MMFR2_LVA_SHIFT		16
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 9892a845d06c9..d8ab4f1e93bee 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -252,6 +252,7 @@ static const struct arm64_ftr_bits ftr_id_aa64mmfr1[] = {
>   
>   static const struct arm64_ftr_bits ftr_id_aa64mmfr2[] = {
>   	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_E0PD_SHIFT, 4, 0),
> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_TTL_SHIFT, 4, 0),
>   	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_FWB_SHIFT, 4, 0),
>   	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_AT_SHIFT, 4, 0),
>   	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_LVA_SHIFT, 4, 0),
> @@ -1630,6 +1631,16 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>   		.matches = has_cpuid_feature,
>   		.cpu_enable = cpu_has_fwb,
>   	},
> +	{
> +		.desc = "ARMv8.4 Translation Table Level",
> +		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
> +		.capability = ARM64_HAS_ARMv8_4_TTL,
> +		.sys_reg = SYS_ID_AA64MMFR2_EL1,
> +		.sign = FTR_UNSIGNED,
> +		.field_pos = ID_AA64MMFR2_TTL_SHIFT,
> +		.min_field_value = 1,
> +		.matches = has_cpuid_feature,
> +	},

Reviewed-by : Suzuki K Polose <suzuki.poulose@arm.com>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
