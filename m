Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 51E6C1A9A82
	for <lists+kvmarm@lfdr.de>; Wed, 15 Apr 2020 12:32:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CA5264B267;
	Wed, 15 Apr 2020 06:32:04 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z6NPmo2EkvR4; Wed, 15 Apr 2020 06:32:04 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 976E04B230;
	Wed, 15 Apr 2020 06:32:03 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 05DCE4B1FB
 for <kvmarm@lists.cs.columbia.edu>; Wed, 15 Apr 2020 06:32:02 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1-QQU1hW8b+m for <kvmarm@lists.cs.columbia.edu>;
 Wed, 15 Apr 2020 06:32:00 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DDC944B18D
 for <kvmarm@lists.cs.columbia.edu>; Wed, 15 Apr 2020 06:32:00 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D90B1063;
 Wed, 15 Apr 2020 03:32:00 -0700 (PDT)
Received: from [10.37.12.1] (unknown [10.37.12.1])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A70563F68F;
 Wed, 15 Apr 2020 03:31:58 -0700 (PDT)
Subject: Re: [PATCH 5/8] arm64: cpufeature: Factor out checking of AArch32
 features
To: will@kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu
References: <20200414213114.2378-1-will@kernel.org>
 <20200414213114.2378-6-will@kernel.org>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <95817087-122e-0392-9474-c17ad1f926d2@arm.com>
Date: Wed, 15 Apr 2020 11:36:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200414213114.2378-6-will@kernel.org>
Content-Language: en-US
Cc: saiprakash.ranjan@codeaurora.org, anshuman.khandual@arm.com, maz@kernel.org,
 linux-kernel@vger.kernel.org, dianders@chromium.org, catalin.marinas@arm.com,
 kernel-team@android.com
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

On 04/14/2020 10:31 PM, Will Deacon wrote:
> update_cpu_features() is pretty large, so split out the checking of the
> AArch32 features into a separate function and call it after checking the
> AArch64 features.
> 
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>   arch/arm64/kernel/cpufeature.c | 108 +++++++++++++++++++--------------
>   1 file changed, 61 insertions(+), 47 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 7dfcdd9e75c1..32828a77acc3 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -715,6 +715,65 @@ static int check_update_ftr_reg(u32 sys_id, int cpu, u64 val, u64 boot)
>   	return 1;
>   }
>   
> +static int update_32bit_cpu_features(int cpu, struct cpuinfo_arm64 *info,
> +				     struct cpuinfo_arm64 *boot)
> +{

...

> -
>   	if (id_aa64pfr0_sve(info->reg_id_aa64pfr0)) {
>   		taint |= check_update_ftr_reg(SYS_ZCR_EL1, cpu,
>   					info->reg_zcr, boot->reg_zcr);
> @@ -845,6 +857,8 @@ void update_cpu_features(int cpu,
>   			sve_update_vq_map();
>   	}
>   
> +	taint |= update_32bit_cpu_features(cpu, info, boot);
> +

This relies on the assumption that the id_aa64pfr0 has been sanitised. 
It may be worth adding a comment to make sure people (hacking the
kernel) don't move this around and break that dependency.

Either ways:

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
