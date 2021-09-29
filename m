Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 069E841C2B5
	for <lists+kvmarm@lfdr.de>; Wed, 29 Sep 2021 12:28:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2F6A44B137;
	Wed, 29 Sep 2021 06:28:44 -0400 (EDT)
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
	with ESMTP id ZBhPTf1I58CV; Wed, 29 Sep 2021 06:28:44 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 01D0F4B134;
	Wed, 29 Sep 2021 06:28:43 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D90ED4B12E
 for <kvmarm@lists.cs.columbia.edu>; Wed, 29 Sep 2021 06:28:41 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 53wj6cEtBnu6 for <kvmarm@lists.cs.columbia.edu>;
 Wed, 29 Sep 2021 06:28:39 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 21A154B126
 for <kvmarm@lists.cs.columbia.edu>; Wed, 29 Sep 2021 06:28:39 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6DE04613A5;
 Wed, 29 Sep 2021 10:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632911318;
 bh=38W4+E7XmZj6LdI0NjZ184grtf29Qd/YWJcOFsY7XlU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=s3oPKMoutgasFHaIKQPk4Npg6PF2e4bD+Bc2eWht+hP3eyeMfCb7jpgyRR/gaGQ95
 vUfnBx+fRhNFoIXgxRgvwuTxnkZlFa34a9R81ir/MQi5iy5ZDFiPJlOpiQWBQZvP2B
 36EVVBvobQt6g0Xj/wgk5VqUgZ+bFJjXIfIpWe7wJVvVGwHFmYQFZ7Q16JjWO5GS4D
 88fTfgsMuxiJci6e4Vq0Q9s8tzFoHjvxi2zHa3EpzdokMUJ8DhzSLZWSnZD9nKsojL
 BvvAINMsHcfmxvxt0dLpk5zGsl7Z5OMLFcAh8d+P2bY3GOPdoLZQS7/cipIrnIZDTM
 Afla3FdpKjAWg==
Date: Wed, 29 Sep 2021 11:28:33 +0100
From: Will Deacon <will@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] KVM: arm64: Allow KVM to be disabled from the command line
Message-ID: <20210929102832.GD21057@willie-the-truck>
References: <20210903091652.985836-1-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210903091652.985836-1-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kvm@vger.kernel.org, kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
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

On Fri, Sep 03, 2021 at 10:16:52AM +0100, Marc Zyngier wrote:
> Although KVM can be compiled out of the kernel, it cannot be disabled
> at runtime. Allow this possibility by introducing a new mode that
> will prevent KVM from initialising.
> 
> This is useful in the (limited) circumstances where you don't want
> KVM to be available (what is wrong with you?), or when you want
> to install another hypervisor instead (good luck with that).
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  3 +++
>  arch/arm64/include/asm/kvm_host.h               |  1 +
>  arch/arm64/kernel/idreg-override.c              |  1 +
>  arch/arm64/kvm/arm.c                            | 14 +++++++++++++-
>  4 files changed, 18 insertions(+), 1 deletion(-)

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
