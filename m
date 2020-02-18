Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BB2581626F7
	for <lists+kvmarm@lfdr.de>; Tue, 18 Feb 2020 14:14:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3DBEF4AF3A;
	Tue, 18 Feb 2020 08:14:46 -0500 (EST)
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
	with ESMTP id U9jqS2HJ4szq; Tue, 18 Feb 2020 08:14:46 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 218CA4AF35;
	Tue, 18 Feb 2020 08:14:45 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 899E64AF22
 for <kvmarm@lists.cs.columbia.edu>; Tue, 18 Feb 2020 08:14:43 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f98KHitGCNLN for <kvmarm@lists.cs.columbia.edu>;
 Tue, 18 Feb 2020 08:14:42 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9835B4AED8
 for <kvmarm@lists.cs.columbia.edu>; Tue, 18 Feb 2020 08:14:42 -0500 (EST)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3C40F206F4;
 Tue, 18 Feb 2020 13:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1582031681;
 bh=PufLgnMmtc95imMPo617VKEAXQH6WY7d+vE4cAOx5oM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ttpQuFgdkJjTk50ik+oXJzo+09NEl1TGu/xzBDYtq21IRMRkM7NZMfb2+HryLxxvD
 YhTlZfETXpKUnljeFFBcPgNMjQA37WMySRYCOdOKKssEzxlEHGCVOnH1h49usUQ6bR
 lnqFxVwPNbwGhKRqgwLlRiSaqPKLUDvR+NKrnJ34=
Date: Tue, 18 Feb 2020 13:14:37 +0000
From: Will Deacon <will@kernel.org>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] arm64: kvm: Modernize annotation for __bp_harden_hyp_vecs
Message-ID: <20200218131436.GE20212@willie-the-truck>
References: <20200218124456.10615-1-broonie@kernel.org>
 <49f7de5f1d86e7edcc34edb55d5011be@kernel.org>
 <20200218130619.GE4232@sirena.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200218130619.GE4232@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Marc Zyngier <maz@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
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

On Tue, Feb 18, 2020 at 01:06:19PM +0000, Mark Brown wrote:
> On Tue, Feb 18, 2020 at 12:56:52PM +0000, Marc Zyngier wrote:
> 
> > I'd really appreciate it if you could send these as a series, instead of
> > an isolated patch every other day.
> 
> OK, I can do that for the KVM stuff - I've been actively trying to keep
> the patches separate where there's no dependencies between them as it
> avoids things getting caught up in review for more complicated stuff or
> cases where someone decides they want extra cleanup while we're at it
> which is especially useful when only some of the series is needed for
> building on top of as is the case here.

I get what you're saying, but I still it find it much easier to get a
series of independent but functionally-related patches with a cover letter.
I usually end up cherry-picking the ones that are ready to go, so then
there's no need to respin those.

Obviously, individual patches are still fine, I'm just worried I'll end
up missing something because they're harder to keep track of.

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
