Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id AC043298AAD
	for <lists+kvmarm@lfdr.de>; Mon, 26 Oct 2020 11:48:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 38A734B600;
	Mon, 26 Oct 2020 06:48:08 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TZb9hwnmyp+p; Mon, 26 Oct 2020 06:48:08 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CAB674B5B9;
	Mon, 26 Oct 2020 06:48:06 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A65554B516
 for <kvmarm@lists.cs.columbia.edu>; Mon, 26 Oct 2020 06:48:05 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yLld6e7QD9sm for <kvmarm@lists.cs.columbia.edu>;
 Mon, 26 Oct 2020 06:48:04 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2580B4B515
 for <kvmarm@lists.cs.columbia.edu>; Mon, 26 Oct 2020 06:48:04 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70FFB101E;
 Mon, 26 Oct 2020 03:48:03 -0700 (PDT)
Received: from [10.57.20.91] (unknown [10.57.20.91])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7DC93F719;
 Mon, 26 Oct 2020 03:48:01 -0700 (PDT)
Subject: Re: [PATCH 3/8] KVM: arm64: Drop useless PAN setting on host EL1 to
 EL2 transition
To: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org
References: <20201026095116.72051-1-maz@kernel.org>
 <20201026095116.72051-4-maz@kernel.org>
From: Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <8d798f0d-6bf4-ed26-9d40-b9d09bf2954e@arm.com>
Date: Mon, 26 Oct 2020 10:48:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20201026095116.72051-4-maz@kernel.org>
Content-Language: en-US
Cc: Will Deacon <will@kernel.org>, kernel-team@android.com
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

On 10/26/20 9:51 AM, Marc Zyngier wrote:
> Setting PSTATE.PAN when entering EL2 on nVHE doesn't make much
> sense as this bit only means something for translation regimes
> that include EL0. This obviously isn't the case in the nVHE case,
> so let's drop this setting.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/kvm/hyp/nvhe/host.S | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp/nvhe/host.S b/arch/arm64/kvm/hyp/nvhe/host.S
> index ff9a0f547b9f..ed27f06a31ba 100644
> --- a/arch/arm64/kvm/hyp/nvhe/host.S
> +++ b/arch/arm64/kvm/hyp/nvhe/host.S
> @@ -17,8 +17,6 @@ SYM_FUNC_START(__host_exit)
>  
>  	get_host_ctxt	x0, x1
>  
> -	ALTERNATIVE(nop, SET_PSTATE_PAN(1), ARM64_HAS_PAN, CONFIG_ARM64_PAN)
> -
>  	/* Store the host regs x2 and x3 */
>  	stp	x2, x3,   [x0, #CPU_XREG_OFFSET(2)]
>  
> 

It was originally introduced in cb96408da4e1 (arm64: KVM: VHE: reset PSTATE.PAN on entry to EL2)
and indeed only applies to VHE (I even remember some attempts to put in under CONFIG_ARM64_VHE).

So, if it helps:
 
    Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>

Cheers
Vladimir
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
