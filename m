Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 037A329FF8F
	for <lists+kvmarm@lfdr.de>; Fri, 30 Oct 2020 09:21:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 95DA54B36F;
	Fri, 30 Oct 2020 04:21:40 -0400 (EDT)
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
	with ESMTP id ZONINV7qDwj3; Fri, 30 Oct 2020 04:21:40 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 57CE84B388;
	Fri, 30 Oct 2020 04:21:39 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 33D5C4B36A
 for <kvmarm@lists.cs.columbia.edu>; Fri, 30 Oct 2020 04:21:38 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7pdxf2OyEphx for <kvmarm@lists.cs.columbia.edu>;
 Fri, 30 Oct 2020 04:21:37 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 4BA674B312
 for <kvmarm@lists.cs.columbia.edu>; Fri, 30 Oct 2020 04:21:37 -0400 (EDT)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0333F22210;
 Fri, 30 Oct 2020 08:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604046096;
 bh=vTuGeGZJUxdjTB3D4vGKVLQh+MqVwUCovWGhymUZ4iA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Dotq/eMChvpMm2UK4sbAp1QhXbsHaSir8RzSdQjt20we+fZ8Sd48D1qzjNRPeVSis
 g9teyz3YAgQjHlwPRSrRwW87lialPl5wEwIeJuXlXR6IGcj5GVhBl4umAunX7tjDh5
 0NkgZdZXoN3j3DJtElN8UHaNnPjTdfzPlrsOZtQ8=
Date: Fri, 30 Oct 2020 08:21:31 +0000
From: Will Deacon <will@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCHv2 1/3] arm64: kvm: factor out is_{vhe,nvhe}_hyp_code()
Message-ID: <20201030082131.GA32163@willie-the-truck>
References: <20201026134931.28246-1-mark.rutland@arm.com>
 <20201026134931.28246-2-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201026134931.28246-2-mark.rutland@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: maz@kernel.org, kvmarm@lists.cs.columbia.edu,
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

On Mon, Oct 26, 2020 at 01:49:29PM +0000, Mark Rutland wrote:
> Currently has_vhe() detects whether it is being compiled for VHE/NVHE
> hyp code based on preprocessor definitions, and uses this knowledge to
> avoid redundant runtime checks.
> 
> There are other cases where we'd like to use this knowledge, so let's
> factor the preprocessor checks out into separate helpers.
> 
> There should be no functional change as a result of this patch.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: David Brazdil <dbrazdil@google.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> ---
>  arch/arm64/include/asm/virt.h | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
