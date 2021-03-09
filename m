Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id DD66D332715
	for <lists+kvmarm@lfdr.de>; Tue,  9 Mar 2021 14:27:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6053B4B46B;
	Tue,  9 Mar 2021 08:27:03 -0500 (EST)
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
	with ESMTP id lqGgchYLJ9m6; Tue,  9 Mar 2021 08:27:03 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 350634B462;
	Tue,  9 Mar 2021 08:26:59 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EC5384B409
 for <kvmarm@lists.cs.columbia.edu>; Tue,  9 Mar 2021 08:26:57 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 345pMnLIJMNV for <kvmarm@lists.cs.columbia.edu>;
 Tue,  9 Mar 2021 08:26:53 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id E25E84B1BA
 for <kvmarm@lists.cs.columbia.edu>; Tue,  9 Mar 2021 08:26:52 -0500 (EST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC30064D8F;
 Tue,  9 Mar 2021 13:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615296411;
 bh=GW/0WIVybU+FKZci+pHzO6MpN/bNiJDrh5DoiKRhFGo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZgLBDtYY4aIDeUHdlKwtssqYTc3uPuKrCzBJUYdtFYSrE1mQA2FiUxsEh6PX+DCf4
 SQrAAhLsr6Pp5qvvgoyWI5P4OLszI7f7dBuIkSx/g4+tIbeXcBEwybscpR3BJXjbQe
 uuLsBFErYny4EmsPbJkucFL+VYcY/CxXovHyidKU0C44zYl+siFpQp82qsoH1JfME3
 yLXglUMvBgDqhZde+oRzWHYWnMxUf700y8JIvPreQMpqzla1Pp6NDw1vvrqyb/+EKM
 RwbBN2UTIbmuxxZY2DTuX2F2tDTOh+5TY1tNK5oBp6Ot7+E4FgCnmeuhOulkcfjyBS
 +ndJVCHjsd5/A==
Date: Tue, 9 Mar 2021 13:26:46 +0000
From: Will Deacon <will@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] KVM: arm64: Ensure I-cache isolation between vcpus of a
 same VM
Message-ID: <20210309132645.GA28297@willie-the-truck>
References: <20210303164505.68492-1-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210303164505.68492-1-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
 kvmarm@lists.cs.columbia.edu
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

On Wed, Mar 03, 2021 at 04:45:05PM +0000, Marc Zyngier wrote:
> It recently became apparent that the ARMv8 architecture has interesting
> rules regarding attributes being used when fetching instructions
> if the MMU is off at Stage-1.
> 
> In this situation, the CPU is allowed to fetch from the PoC and
> allocate into the I-cache (unless the memory is mapped with
> the XN attribute at Stage-2).
> 
> If we transpose this to vcpus sharing a single physical CPU,
> it is possible for a vcpu running with its MMU off to influence
> another vcpu running with its MMU on, as the latter is expected to
> fetch from the PoU (and self-patching code doesn't flush below that
> level).
> 
> In order to solve this, reuse the vcpu-private TLB invalidation
> code to apply the same policy to the I-cache, nuking it every time
> the vcpu runs on a physical CPU that ran another vcpu of the same
> VM in the past.
> 
> This involve renaming __kvm_tlb_flush_local_vmid() to
> __kvm_flush_cpu_context(), and inserting a local i-cache invalidation
> there.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/include/asm/kvm_asm.h   | 4 ++--
>  arch/arm64/kvm/arm.c               | 7 ++++++-
>  arch/arm64/kvm/hyp/nvhe/hyp-main.c | 6 +++---
>  arch/arm64/kvm/hyp/nvhe/tlb.c      | 3 ++-
>  arch/arm64/kvm/hyp/vhe/tlb.c       | 3 ++-
>  5 files changed, 15 insertions(+), 8 deletions(-)

Since the FWB discussion doesn't affect the correctness of this patch:

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
