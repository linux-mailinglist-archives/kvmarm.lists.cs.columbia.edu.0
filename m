Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4983765C032
	for <lists+kvmarm@lfdr.de>; Tue,  3 Jan 2023 13:51:24 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B56424BB56;
	Tue,  3 Jan 2023 07:51:23 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -6.789
X-Spam-Level: 
X-Spam-Status: No, score=-6.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, RCVD_IN_DNSWL_HI=-5, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LXH-Gd8NfklS; Tue,  3 Jan 2023 07:51:23 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8002A4BB4D;
	Tue,  3 Jan 2023 07:51:22 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A5C1C4BA5F
 for <kvmarm@lists.cs.columbia.edu>; Tue,  3 Jan 2023 07:51:20 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xLFMM9xNayKc for <kvmarm@lists.cs.columbia.edu>;
 Tue,  3 Jan 2023 07:51:19 -0500 (EST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 810444BA86
 for <kvmarm@lists.cs.columbia.edu>; Tue,  3 Jan 2023 07:51:19 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 44E1CB80E46;
 Tue,  3 Jan 2023 12:51:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE7D5C433D2;
 Tue,  3 Jan 2023 12:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1672750276;
 bh=yylplQts2y18J8xk5cDZcT8BHCiafGumWS1q6Crly/I=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=uuAkyIGt0sjypKzsAtTvuGdpByVI2/Svszt4UDsWvaR5apFrq9AhX4zgE2OGVPzTg
 TAEdKtO4Z9ElXpTFO3V1B2DKkpBGk2jr0dWib1b7FQD+oy/Wj0jqhd1Y8i+ilA3ufj
 Qw1cu1pwN/HSIl3FRSAm8Db2SG6AibjZg9JBlDQkwhwkrKdLPIoj7GmrW2TEyb3Ai5
 m9Xt6CBE7/qpf6hBTyxzgI82qIVyba6+qa4NUol+FdWSuNYycy5lwEM4GnoSIDI0XJ
 QnCa6EEyoSwWeGIvLnXbCMolDMw0GazzyNml+nXCl9pKc5sgViBnXp6VT5BjDFCUbd
 qil2n61YvwuCw==
Received: from sofa.misterjones.org ([185.219.108.64]
 helo=goblin-girl.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <maz@kernel.org>) id 1pCgl8-00GVbY-Mu;
 Tue, 03 Jan 2023 12:51:14 +0000
Date: Tue, 03 Jan 2023 12:51:14 +0000
Message-ID: <86wn637pdp.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Subject: Re: [PATCH] MAINTAINERS: Remove myself as a KVM/arm64 reviewer
In-Reply-To: <20230103120736.116523-1-alexandru.elisei@arm.com>
References: <20230103120736.116523-1-alexandru.elisei@arm.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/28.2
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: alexandru.elisei@arm.com, james.morse@arm.com,
 suzuki.poulose@arm.com, oliver.upton@linux.dev,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 kvmarm@lists.cs.columbia.edu
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvmarm@lists.linux.dev, kvmarm <kvmarm@lists.cs.columbia.edu>,
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

On Tue, 03 Jan 2023 12:07:36 +0000,
Alexandru Elisei <alexandru.elisei@arm.com> wrote:
> 
> Haven't done any meaningful reviews for more than a year, and it doesn't
> look like I'll be able to do so in the future. Make it official and remove
> myself from the KVM/arm64 "Reviewers" list.
> 
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7f86d02cb427..813673637500 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11356,7 +11356,6 @@ F:	virt/kvm/*
>  KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)
>  M:	Marc Zyngier <maz@kernel.org>
>  R:	James Morse <james.morse@arm.com>
> -R:	Alexandru Elisei <alexandru.elisei@arm.com>
>  R:	Suzuki K Poulose <suzuki.poulose@arm.com>
>  R:	Oliver Upton <oliver.upton@linux.dev>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)

[+ the old kvmarm list, as the new one isn't archived yet]

I'm sad to see you go, but hopefully we'll still count you as a
contributor. Thanks again for all your work along the years.

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
