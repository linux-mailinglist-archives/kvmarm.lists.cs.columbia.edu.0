Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A942B16272F
	for <lists+kvmarm@lfdr.de>; Tue, 18 Feb 2020 14:35:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 402774AF46;
	Tue, 18 Feb 2020 08:35:43 -0500 (EST)
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
	with ESMTP id 1eRgF3e0Y4qF; Tue, 18 Feb 2020 08:35:43 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0343F4AF41;
	Tue, 18 Feb 2020 08:35:42 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BAD804AF2D
 for <kvmarm@lists.cs.columbia.edu>; Tue, 18 Feb 2020 08:35:40 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I1hPt9uwYKF7 for <kvmarm@lists.cs.columbia.edu>;
 Tue, 18 Feb 2020 08:35:39 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id BED264AF25
 for <kvmarm@lists.cs.columbia.edu>; Tue, 18 Feb 2020 08:35:39 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A997620722;
 Tue, 18 Feb 2020 13:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1582032938;
 bh=w4ji1nmcF42SkVdUE5dyIJMGkQbp3MsktM60Liks4NI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=BFgdAtlHvZD/pEWVy2TbUrsm4mv1D46TjlPhIvRbN+sE6BaO22lSq7IulKGtsMXgb
 x76+vEUBqssNsc3UaAdqZfieG8flIRuq4FJ4bzjm12vaMfONLE9EOup9rolUyqUDoW
 g1pKx31Y7O0bBLHfL7+uQv3EaehnDGeku/puobhA=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1j432H-006E8H-0w; Tue, 18 Feb 2020 13:35:37 +0000
MIME-Version: 1.0
Date: Tue, 18 Feb 2020 13:35:36 +0000
From: Marc Zyngier <maz@kernel.org>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] arm64: kvm: Modernize annotation for __bp_harden_hyp_vecs
In-Reply-To: <20200218132946.GF4232@sirena.org.uk>
References: <20200218124456.10615-1-broonie@kernel.org>
 <49f7de5f1d86e7edcc34edb55d5011be@kernel.org>
 <20200218130953.GD20212@willie-the-truck>
 <20200218132946.GF4232@sirena.org.uk>
Message-ID: <e872e1cfb95b4c98cceab371a1a54107@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: broonie@kernel.org, will@kernel.org, james.morse@arm.com,
 julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, catalin.marinas@arm.com,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
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

On 2020-02-18 13:29, Mark Brown wrote:
> On Tue, Feb 18, 2020 at 01:09:53PM +0000, Will Deacon wrote:
>> On Tue, Feb 18, 2020 at 12:56:52PM +0000, Marc Zyngier wrote:
>> > I'd really appreciate it if you could send these as a series, instead of
>> > an isolated patch every other day.
> 
>> Same for the non-KVM parts, please :)
> 
> Ugh, right.  As one series or as different serieses for the different
> trees that apply things (eg, KVM and crypto)?  The multi tree stuff
> worries me.

Up to you. I personally think it is useful to see the whole thing for 
arm64
as a single series, and we can then decide who picks what between 
ourselves
(or shove the whole thing via a single tree).

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
