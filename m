Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 96E15173EA2
	for <lists+kvmarm@lfdr.de>; Fri, 28 Feb 2020 18:35:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 158374AFF5;
	Fri, 28 Feb 2020 12:35:59 -0500 (EST)
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
	with ESMTP id w4dCpo75YEUE; Fri, 28 Feb 2020 12:35:58 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D60CC4AFE0;
	Fri, 28 Feb 2020 12:35:57 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9CF714AFE0
 for <kvmarm@lists.cs.columbia.edu>; Fri, 28 Feb 2020 12:35:56 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hLXrrxgR9a-M for <kvmarm@lists.cs.columbia.edu>;
 Fri, 28 Feb 2020 12:35:55 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9292B4AFDB
 for <kvmarm@lists.cs.columbia.edu>; Fri, 28 Feb 2020 12:35:55 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4BD512051A;
 Fri, 28 Feb 2020 17:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1582911354;
 bh=VKhozoDerPi8gC4TBNvSd+KP8dQLu3JJCi2pZhPZpoI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=CtX6NHqGoWLf8H/hN0qy3HV3OSTq4MlkeiMi0d98W2EYtv5RCxma+mb+ePaWSiaAa
 KBtPs973mpzxuEvGpfzGD/uZ73FOneRL0Uq6GLb8DY93TOVvoFmyIkOqRxDYa1N2tY
 vYN7NKPJZMWyWfONKaIz0+SBMP6wv/1VXBL99rwc=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1j7jYG-008obq-Hk; Fri, 28 Feb 2020 17:35:52 +0000
MIME-Version: 1.0
Date: Fri, 28 Feb 2020 17:35:52 +0000
From: Marc Zyngier <maz@kernel.org>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 13/18] arm64: kvm: Annotate assembly using modern
 annoations
In-Reply-To: <20200218195842.34156-14-broonie@kernel.org>
References: <20200218195842.34156-1-broonie@kernel.org>
 <20200218195842.34156-14-broonie@kernel.org>
Message-ID: <af4e6c640321dfa9e320ad1079aad603@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: broonie@kernel.org, herbert@gondor.apana.org.au,
 davem@davemloft.net, catalin.marinas@arm.com, will@kernel.org,
 james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 linux-crypto@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
 Catalin Marinas <catalin.marinas@arm.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org
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

On 2020-02-18 19:58, Mark Brown wrote:
> In an effort to clarify and simplify the annotation of assembly 
> functions
> in the kernel new macros have been introduced. These replace ENTRY and
> ENDPROC with separate annotations for standard C callable functions,
> data and code with different calling conventions.  Update the more
> straightforward annotations in the kvm code to the new macros.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/kvm/hyp-init.S      |  8 ++++----
>  arch/arm64/kvm/hyp.S           |  4 ++--
>  arch/arm64/kvm/hyp/fpsimd.S    |  8 ++++----
>  arch/arm64/kvm/hyp/hyp-entry.S | 15 ++++++++-------
>  4 files changed, 18 insertions(+), 17 deletions(-)

For the three KVM/arm patches:

Acked-by: Marc Zyngier <maz@kernel.org>

I'd expect this to go as a whole via the arm64 tree, but I can also
cherry-pick them if necessary.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
