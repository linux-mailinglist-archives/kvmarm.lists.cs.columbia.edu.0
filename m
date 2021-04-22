Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6E875367E5E
	for <lists+kvmarm@lfdr.de>; Thu, 22 Apr 2021 12:12:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C50254B4D3;
	Thu, 22 Apr 2021 06:12:47 -0400 (EDT)
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
	with ESMTP id gTjLuK7HrtXl; Thu, 22 Apr 2021 06:12:47 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AA78E4B4FC;
	Thu, 22 Apr 2021 06:12:46 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 390334B4D3
 for <kvmarm@lists.cs.columbia.edu>; Thu, 22 Apr 2021 06:12:45 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lmzh7pVUtbTq for <kvmarm@lists.cs.columbia.edu>;
 Thu, 22 Apr 2021 06:12:44 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 3E5B04B4EE
 for <kvmarm@lists.cs.columbia.edu>; Thu, 22 Apr 2021 06:12:44 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 774D36143B;
 Thu, 22 Apr 2021 10:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1619086363;
 bh=xHKPEQ4rcxCoaoX7HHU+f4xF6ZurqSwjiO2kgl0XZEM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nmD0vSGiage1GdxJRvwvfMgbsweu+fvjzpGgnfBeZ/qVftWHsKa9wke+gTlCUot7K
 v7XGRPs7rBQYnbPPw5ieWm1HjPTgaSCNX/5I0IGtXFfGIVWwr05s2XBJ/7jtHTxSD+
 bKD3QEbhHJLoKrUxpEwSfjpkLU/tybGDO66L+4fl22k+sZSnMHbp+NRNPEs3P1noZe
 Eq3C+ZA+8XObEa+GKzwK/jARmOcp+RAm6teSB92lraAcrG2kOPwYnRlPgdEX31fc9O
 r0urkIQXyPphlxPoEvSsjmH/aG5H7MjTso5pMZ1v88fB4RMJlAljKXDSo8AcSV77s0
 pE2cBelCj/uVA==
Date: Thu, 22 Apr 2021 11:12:37 +0100
From: Will Deacon <will@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] KVM: arm64: build perf support only when enabled
Message-ID: <20210422101236.GB1039@willie-the-truck>
References: <20210421134922.3309033-1-arnd@kernel.org>
 <87y2dbpwqn.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87y2dbpwqn.wl-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu
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

On Wed, Apr 21, 2021 at 02:56:16PM +0100, Marc Zyngier wrote:
> On Wed, 21 Apr 2021 14:49:01 +0100,
> Arnd Bergmann <arnd@kernel.org> wrote:
> > 
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > The perf_num_counters() function is only defined when CONFIG_PERF_EVENTS
> > is enabled:
> > 
> > arch/arm64/kvm/perf.c: In function 'kvm_perf_init':
> > arch/arm64/kvm/perf.c:58:43: error: implicit declaration of function 'perf_num_counters'; did you mean 'dec_mm_counter'? [-Werror=implicit-function-declaration]
> >    58 |         if (IS_ENABLED(CONFIG_ARM_PMU) && perf_num_counters() > 0
> >       |                                           ^~~~~~~~~~~~~~~~~
> > 
> > Use conditional compilation to disable this feature entirely when
> > CONFIG_PERF_EVENTS is disabled in the host.
> > 
> > Fixes: 6b5b368fccd7 ("KVM: arm64: Turn kvm_arm_support_pmu_v3() into a static key")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > Not sure if this is the correct symbol to check for, but this is
> > one way to avoid the build failure.
> 
> I think a better way is to get rid of perf_num_counters() entirely,
> see [1]. If someone acks the second and last patches, I'll even take
> the whole series in (nudge nudge...).

Sorry, behind at the moment! Will get to it today.

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
