Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 82C943E5B12
	for <lists+kvmarm@lfdr.de>; Tue, 10 Aug 2021 15:21:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0EC854A500;
	Tue, 10 Aug 2021 09:21:38 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GYgWwoWpRoal; Tue, 10 Aug 2021 09:21:37 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E301B4A4CD;
	Tue, 10 Aug 2021 09:21:33 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 03D474A3A3
 for <kvmarm@lists.cs.columbia.edu>; Tue, 10 Aug 2021 09:21:32 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h6vIpnCpy0Ot for <kvmarm@lists.cs.columbia.edu>;
 Tue, 10 Aug 2021 09:21:31 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 2002C4A19F
 for <kvmarm@lists.cs.columbia.edu>; Tue, 10 Aug 2021 09:21:31 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 57CE260F38;
 Tue, 10 Aug 2021 13:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628601690;
 bh=jqyHZ175J/Gvvs023uqRUmo52RsbbfMGvn++lpbF66s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=I+a4GHR4h1dHtT1sJaTfvsu8J2/xAVbb8xQvxOWtAZkgpn26IlUZ/GFV/gaQYEbGV
 lPxKHhT2GkVeHO6Xwvno6jh1lBza6SRE8pvMIqH/Rh3wl/+LCzNUK1nQLQxcfO7Bba
 OId6prpx1+pskLJVHqM3W0VaZjMdN8WDujnwOd3kKK1QTuEpqYAuV6pbX9s1+MQicX
 6re4qQcHFaRDpWO4wq6WRcP7bMmn/hi7L5k3sc+yZ107nm1nFUWIC4C12AEM3i4um6
 q3JD/05M7BgrMyMwt5l72dUcXFqH1rrruzEzn0A08IFety7rDlp8ODT2jTXG7z6MLr
 PoAnqpxa3E6pw==
Date: Tue, 10 Aug 2021 14:21:24 +0100
From: Will Deacon <will@kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH 2/5] KVM: arm64: Drop init_common_resources()
Message-ID: <20210810132123.GB2946@willie-the-truck>
References: <1628578961-29097-1-git-send-email-anshuman.khandual@arm.com>
 <1628578961-29097-3-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1628578961-29097-3-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, kvmarm@lists.cs.columbia.edu,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On Tue, Aug 10, 2021 at 12:32:38PM +0530, Anshuman Khandual wrote:
> Could do without this additional indirection via init_common_resources() by
> just calling kvm_set_ipa_limit() directly instead. This change saves memory
> and cycles.

Does it? Really?

Will

> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index e9a2b8f27792..19560e457c11 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -1696,11 +1696,6 @@ static bool init_psci_relay(void)
>  	return true;
>  }
>  
> -static int init_common_resources(void)
> -{
> -	return kvm_set_ipa_limit();
> -}
> -
>  static int init_subsystems(void)
>  {
>  	int err = 0;
> @@ -2102,7 +2097,7 @@ int kvm_arch_init(void *opaque)
>  		}
>  	}
>  
> -	err = init_common_resources();
> +	err = kvm_set_ipa_limit();
>  	if (err)
>  		return err;
>  
> -- 
> 2.20.1
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
