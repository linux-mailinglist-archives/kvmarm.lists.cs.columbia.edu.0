Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0FB307D7B
	for <lists+kvmarm@lfdr.de>; Thu, 28 Jan 2021 19:12:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8E00F4B14D;
	Thu, 28 Jan 2021 13:11:59 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NorMyREh7gwp; Thu, 28 Jan 2021 13:11:59 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 670404B11E;
	Thu, 28 Jan 2021 13:11:58 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4C2504B11E
 for <kvmarm@lists.cs.columbia.edu>; Thu, 28 Jan 2021 13:11:56 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8iPhxaZ6aDxk for <kvmarm@lists.cs.columbia.edu>;
 Thu, 28 Jan 2021 13:11:55 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 4A76E4B112
 for <kvmarm@lists.cs.columbia.edu>; Thu, 28 Jan 2021 13:11:55 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2BA7F64E1D;
 Thu, 28 Jan 2021 18:11:54 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1l5Blo-00Affv-6K; Thu, 28 Jan 2021 18:11:52 +0000
MIME-Version: 1.0
Date: Thu, 28 Jan 2021 18:11:52 +0000
From: Marc Zyngier <maz@kernel.org>
To: Quentin Perret <qperret@google.com>
Subject: Re: [PATCH] KVM: arm64: Move __hyp_set_vectors out of .hyp.text
In-Reply-To: <20210128173850.2478161-1-qperret@google.com>
References: <20210128173850.2478161-1-qperret@google.com>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <d64f85c885701719d5f607c3d2f12600@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: qperret@google.com, catalin.marinas@arm.com, will@kernel.org,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: catalin.marinas@arm.com, kernel-team@android.com, will@kernel.org,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

On 2021-01-28 17:38, Quentin Perret wrote:
> The .hyp.text section is supposed to be reserved for the nVHE EL2 code.
> However, there is currently one occurrence of EL1 executing code 
> located
> in .hyp.text when calling __hyp_{re}set_vectors(), which happen to sit
> next to the EL2 stub vectors. While not a problem yet, such patterns
> will cause issues when removing the host kernel from the TCB, so a
> cleaner split would be preferable.
> 
> Fix this by delimiting the end of the .hyp.text section in hyp-stub.S.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/kernel/hyp-stub.S | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/kernel/hyp-stub.S 
> b/arch/arm64/kernel/hyp-stub.S
> index 160f5881a0b7..8a60f9c586bb 100644
> --- a/arch/arm64/kernel/hyp-stub.S
> +++ b/arch/arm64/kernel/hyp-stub.S
> @@ -85,6 +85,8 @@ SYM_CODE_END(\label)
>  	invalid_vector	el1_fiq_invalid
>  	invalid_vector	el1_error_invalid
> 
> +	.popsection
> +
>  /*
>   * __hyp_set_vectors: Call this after boot to set the initial 
> hypervisor
>   * vectors as part of hypervisor installation.  On an SMP system, this 
> should

Thanks for tracking this one down, Quentin.

Catalin, Will: should you want to take this one via the arm64 tree,
please add my

Acked-by: Marc Zyngier <maz:kernel.org>

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
