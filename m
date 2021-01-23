Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEE33015C2
	for <lists+kvmarm@lfdr.de>; Sat, 23 Jan 2021 15:20:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D78664B168;
	Sat, 23 Jan 2021 09:20:02 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2c4hLygMOqMq; Sat, 23 Jan 2021 09:20:02 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B1B7B4B15E;
	Sat, 23 Jan 2021 09:20:01 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 867334B14A
 for <kvmarm@lists.cs.columbia.edu>; Sat, 23 Jan 2021 09:20:00 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A4QwqDzvIU8C for <kvmarm@lists.cs.columbia.edu>;
 Sat, 23 Jan 2021 09:19:59 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 8C5DD4B12D
 for <kvmarm@lists.cs.columbia.edu>; Sat, 23 Jan 2021 09:19:59 -0500 (EST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA3F722D5A;
 Sat, 23 Jan 2021 14:19:55 +0000 (UTC)
Date: Sat, 23 Jan 2021 14:19:53 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v4 18/21] arm64: Move "nokaslr" over to the early
 cpufeature infrastructure
Message-ID: <YAwwiRF4QnIoPS20@Catalins-MacBook-Air.local>
References: <20210118094533.2874082-1-maz@kernel.org>
 <20210118094533.2874082-19-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210118094533.2874082-19-maz@kernel.org>
Cc: Prasad Sodagudi <psodagud@codeaurora.org>,
 Srinivas Ramana <sramana@codeaurora.org>, linux-kernel@vger.kernel.org,
 Ard Biesheuvel <ardb@kernel.org>, Ajay Patil <pajay@qti.qualcomm.com>,
 kernel-team@android.com, Will Deacon <will@kernel.org>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On Mon, Jan 18, 2021 at 09:45:30AM +0000, Marc Zyngier wrote:
> Given that the early cpufeature infrastructure has borrowed quite
> a lot of code from the kaslr implementation, let's reimplement
> the matching of the "nokaslr" option with it.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/kernel/idreg-override.c | 17 ++++++++++++++
>  arch/arm64/kernel/kaslr.c          | 37 +++---------------------------
>  2 files changed, 20 insertions(+), 34 deletions(-)
> 
> diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-override.c
> index 1db54878b2c4..143fe7b8e3ce 100644
> --- a/arch/arm64/kernel/idreg-override.c
> +++ b/arch/arm64/kernel/idreg-override.c
> @@ -33,8 +33,24 @@ static const struct reg_desc mmfr1 __initdata = {
>  	},
>  };
>  
> +extern u64 kaslr_feature_val;
> +extern u64 kaslr_feature_mask;
> +
> +static const struct reg_desc kaslr __initdata = {
> +	.name		= "kaslr",

We might as well rename this ftr_override or something more generic as
we no longer describe registers here. Otherwise:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
