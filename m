Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C55532E9509
	for <lists+kvmarm@lfdr.de>; Mon,  4 Jan 2021 13:40:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3A74A4B267;
	Mon,  4 Jan 2021 07:40:54 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vCnX5hYySKQT; Mon,  4 Jan 2021 07:40:54 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1C2A64B254;
	Mon,  4 Jan 2021 07:40:53 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0DC394B24D
 for <kvmarm@lists.cs.columbia.edu>; Mon,  4 Jan 2021 07:40:51 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZNGEbvwzjm9x for <kvmarm@lists.cs.columbia.edu>;
 Mon,  4 Jan 2021 07:40:50 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 1F0DC4B240
 for <kvmarm@lists.cs.columbia.edu>; Mon,  4 Jan 2021 07:40:50 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EDB2220770;
 Mon,  4 Jan 2021 12:40:48 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1kwPAE-005DAh-U0; Mon, 04 Jan 2021 12:40:47 +0000
MIME-Version: 1.0
Date: Mon, 04 Jan 2021 12:40:46 +0000
From: Marc Zyngier <maz@kernel.org>
To: Shannon Zhao <shannon.zhao@linux.alibaba.com>
Subject: Re: [PATCH] arm64: cpufeature: remove non-exist CONFIG_KVM_ARM_HOST
In-Reply-To: <1609760324-92271-1-git-send-email-shannon.zhao@linux.alibaba.com>
References: <1609760324-92271-1-git-send-email-shannon.zhao@linux.alibaba.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <53c52d0729cfc300b2cead400e2b846b@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: shannon.zhao@linux.alibaba.com, kvmarm@lists.cs.columbia.edu,
 will@kernel.org, anshuman.khandual@arm.com, suzuki.poulose@arm.com,
 linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: will@kernel.org, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, anshuman.khandual@arm.com
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

On 2021-01-04 11:38, Shannon Zhao wrote:
> Commit d82755b2e781 ("KVM: arm64: Kill off CONFIG_KVM_ARM_HOST") 
> deletes
> CONFIG_KVM_ARM_HOST option, it should use CONFIG_KVM instead.
> 
> Just remove CONFIG_KVM_ARM_HOST here.
> 
> Signed-off-by: Shannon Zhao <shannon.zhao@linux.alibaba.com>
> ---
>  arch/arm64/kernel/cpufeature.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c 
> b/arch/arm64/kernel/cpufeature.c
> index 7ffb5f1..e99edde 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -2568,7 +2568,7 @@ static void verify_hyp_capabilities(void)
>  	int parange, ipa_max;
>  	unsigned int safe_vmid_bits, vmid_bits;
> 
> -	if (!IS_ENABLED(CONFIG_KVM) || !IS_ENABLED(CONFIG_KVM_ARM_HOST))
> +	if (!IS_ENABLED(CONFIG_KVM))
>  		return;
> 
>  	safe_mmfr1 = read_sanitised_ftr_reg(SYS_ID_AA64MMFR1_EL1);

Well spotted. It means this function has never run since v5.8.
It only performs a sanity check, but still...

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
