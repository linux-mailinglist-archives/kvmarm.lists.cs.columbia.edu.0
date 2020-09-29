Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B0B6027D496
	for <lists+kvmarm@lfdr.de>; Tue, 29 Sep 2020 19:37:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 441CE4B1E5;
	Tue, 29 Sep 2020 13:37:42 -0400 (EDT)
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
	with ESMTP id m0YdgTiFEXcj; Tue, 29 Sep 2020 13:37:42 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2BE6E4B1E7;
	Tue, 29 Sep 2020 13:37:41 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5F8494B1D4
 for <kvmarm@lists.cs.columbia.edu>; Tue, 29 Sep 2020 13:37:40 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HqyIytftCeOP for <kvmarm@lists.cs.columbia.edu>;
 Tue, 29 Sep 2020 13:37:35 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 8F07F4B1B2
 for <kvmarm@lists.cs.columbia.edu>; Tue, 29 Sep 2020 13:37:35 -0400 (EDT)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F104B2076A;
 Tue, 29 Sep 2020 17:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601401054;
 bh=UvE53L1sg8GJvFFhgRjsqC9XadWv4tH7FwQa5T0OhUw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=vZKRt8BvGxP8BhKW+TX+EPD0sF8tIwU68IIJ5O0yeTLJykidd8yXBaRh2X9NlG4be
 cdqMJ7rEFbnk2lZDKK73WldEsTLqguaSKm0zeRVkLaJP33bwr9N/9y8IAu+/9D7vKi
 IGHQdUni92YI8Z3vgo2aB+88b/opTUQ4bfRvaYIQ=
Date: Tue, 29 Sep 2020 18:37:28 +0100
From: Will Deacon <will@kernel.org>
To: David Brazdil <dbrazdil@google.com>
Subject: Re: [PATCH v4 07/10] kvm: arm64: Duplicate
 arm64_ssbd_callback_required for nVHE hyp
Message-ID: <20200929173728.GD14317@willie-the-truck>
References: <20200922204910.7265-1-dbrazdil@google.com>
 <20200922204910.7265-8-dbrazdil@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200922204910.7265-8-dbrazdil@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Marc Zyngier <maz@kernel.org>,
 Tejun Heo <tj@kernel.org>, Dennis Zhou <dennis@kernel.org>,
 Christoph Lameter <cl@linux.com>, kernel-team@android.com,
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

On Tue, Sep 22, 2020 at 09:49:07PM +0100, David Brazdil wrote:
> Hyp keeps track of which cores require SSBD callback by accessing a
> kernel-proper global variable. Create an nVHE symbol of the same name
> and copy the value from kernel proper to nVHE as KVM is being enabled
> on a core.
> 
> Done in preparation for separating percpu memory owned by kernel
> proper and nVHE.
> 
> Signed-off-by: David Brazdil <dbrazdil@google.com>
> ---
>  arch/arm64/include/asm/kvm_mmu.h | 14 +++++++++++++-
>  arch/arm64/kernel/image-vars.h   |  1 -
>  arch/arm64/kvm/arm.c             |  3 +++
>  arch/arm64/kvm/hyp/nvhe/switch.c |  3 +++
>  4 files changed, 19 insertions(+), 2 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Marc: please take a look at for-next/ghostbusters on the arm64 tree, as
that has the patches which remove this stuff entirely. I had to rebase
the branch today because I screwed up some of the SoBs but the HEAD is
now stable at 780c083a8f84.

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
