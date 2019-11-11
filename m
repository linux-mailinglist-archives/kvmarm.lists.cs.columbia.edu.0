Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A3A3BF77EA
	for <lists+kvmarm@lfdr.de>; Mon, 11 Nov 2019 16:42:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E80E24B0F4;
	Mon, 11 Nov 2019 10:42:26 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 2.056
X-Spam-Level: **
X-Spam-Status: No, score=2.056 required=6.1 tests=[BAYES_00=-1.9,
	BUG6152_INVALID_DATE_TZ_ABSURD=0.766, DNS_FROM_AHBL_RHSBL=2.699,
	INVALID_DATE_TZ_ABSURD=0.491] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZIQB-4Ghp2-S; Mon, 11 Nov 2019 10:42:26 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C7DCD4B0EB;
	Mon, 11 Nov 2019 10:42:25 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6DE3E4B0E6
 for <kvmarm@lists.cs.columbia.edu>; Mon, 11 Nov 2019 10:42:24 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sOpSLt6ZXy5D for <kvmarm@lists.cs.columbia.edu>;
 Mon, 11 Nov 2019 10:42:23 -0500 (EST)
Received: from inca-roads.misterjones.org (inca-roads.misterjones.org
 [213.251.177.50])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 3E8B64B0AE
 for <kvmarm@lists.cs.columbia.edu>; Mon, 11 Nov 2019 10:42:23 -0500 (EST)
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
 (envelope-from <maz@kernel.org>)
 id 1iUBpc-0004LY-Pn; Mon, 11 Nov 2019 16:42:20 +0100
To: Steven Price <steven.price@arm.com>
Subject: Re: [PATCH 1/2] arm64: Rename =?UTF-8?Q?WORKAROUND=5F=31=31=36=35?=
 =?UTF-8?Q?=35=32=32=20to=20SPECULATIVE=5FAT?=
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Date: Mon, 11 Nov 2019 16:51:41 +0109
From: Marc Zyngier <maz@kernel.org>
In-Reply-To: <20191111141157.55062-2-steven.price@arm.com>
References: <20191111141157.55062-1-steven.price@arm.com>
 <20191111141157.55062-2-steven.price@arm.com>
Message-ID: <160a852027f4481cc63aed72c4f4a409@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: steven.price@arm.com, catalin.marinas@arm.com,
 will@kernel.org, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org);
 SAEximRunCond expanded to false
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
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

Hi Steven,

On 2019-11-11 15:21, Steven Price wrote:
> Cortex-A55 is affected by a similar erratum, so rename the existing
> workaround for errarum 1165522 so it can be used for both errata.

nit: erratum

>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  arch/arm64/Kconfig                |  4 ++++
>  arch/arm64/include/asm/cpucaps.h  |  2 +-
>  arch/arm64/include/asm/kvm_host.h |  2 +-
>  arch/arm64/include/asm/kvm_hyp.h  |  3 +--
>  arch/arm64/kernel/cpu_errata.c    | 17 +++++++++++++----
>  arch/arm64/kvm/hyp/switch.c       |  2 +-
>  arch/arm64/kvm/hyp/tlb.c          |  4 ++--
>  7 files changed, 23 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 3f047afb982c..6cb4eff602c6 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -510,9 +510,13 @@ config ARM64_ERRATUM_1418040
>
>  	  If unsure, say Y.
>
> +config ARM64_WORKAROUND_SPECULATIVE_AT
> +	bool
> +
>  config ARM64_ERRATUM_1165522
>  	bool "Cortex-A76: Speculative AT instruction using out-of-context
> translation regime could cause subsequent request to generate an
> incorrect translation"
>  	default y
> +	select ARM64_WORKAROUND_SPECULATIVE_AT

I'd object that ARM64_ERRATUM_1319367 (and its big brother 1319537)
are also related to speculative AT execution, and yet are not covered
by this configuration symbol.

I can see three solutions to this:

- Either you call it SPECULATIVE_AT_VHE and introduce 
SPECULATIVE_AT_NVHE
   for symmetry

- Or you make SPECULATIVE_AT cover all the speculative AT errata, which
   may or may not work...

- Or even better, you just ammend the documentation to say that 1165522
   also covers the newly found A55 one (just like we have for A57/A72)

What do you think?

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
