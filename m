Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9070F3408BD
	for <lists+kvmarm@lfdr.de>; Thu, 18 Mar 2021 16:25:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 251104B759;
	Thu, 18 Mar 2021 11:25:45 -0400 (EDT)
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
	with ESMTP id bs-NJnryPhgk; Thu, 18 Mar 2021 11:25:45 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0BF2D4B750;
	Thu, 18 Mar 2021 11:25:44 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 89DCB4B73C
 for <kvmarm@lists.cs.columbia.edu>; Thu, 18 Mar 2021 11:25:42 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DI8BxS2u8glu for <kvmarm@lists.cs.columbia.edu>;
 Thu, 18 Mar 2021 11:25:41 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 80D994B72B
 for <kvmarm@lists.cs.columbia.edu>; Thu, 18 Mar 2021 11:25:41 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id EF46C64EE2;
 Thu, 18 Mar 2021 15:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616081140;
 bh=mdAEzCr6Hjx+GACZUf/XfONltUfhE40Pubfi/ZKrbMI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KoKq3gUK3U7hVHOoTlayHnwRUE3EHGZa0L92IDwmixG0WJUKqKaYbYXoZCQdC0v7F
 XC1Y3TZ78CGXhVT9uLHvlOX7JG1hlR+L1+hgFBDtYYfwUtCK1Wuw/nKVd9Oq5JvreQ
 HCAR/1Dqpd/0FNdOVmVu24+o3BKtIm0Dhz5IOPg68a09EcEDtKLtFCxPHAMe/0dbvJ
 R7clWZ3YTn6jyyHHaYOPXGpxQdhjPsHd6W2OzgJ3IHXg5X/+CR9ZYLkLwHj28QvuBE
 Z5tBReOjaH8FDwD+/L/qp2qQxffomfX7sle3o4fJCb1YpsMdRGyBjgZce8Ws2j1Ulc
 dBEwUQk9gxknQ==
Date: Thu, 18 Mar 2021 15:25:34 +0000
From: Will Deacon <will@kernel.org>
To: Andrew Scull <ascull@google.com>
Subject: Re: [PATCH v3 4/5] KVM: arm64: Use BUG and BUG_ON in nVHE hyp
Message-ID: <20210318152534.GD7531@willie-the-truck>
References: <20210318143311.839894-1-ascull@google.com>
 <20210318143311.839894-5-ascull@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210318143311.839894-5-ascull@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: catalin.marinas@arm.com, maz@kernel.org, kernel-team@android.com,
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

On Thu, Mar 18, 2021 at 02:33:10PM +0000, Andrew Scull wrote:
> hyp_panic() reports the address of the panic by using ELR_EL2, but this
> isn't a useful address when hyp_panic() is called directly. Replace such
> direct calls with BUG() and BUG_ON() which use BRK to trigger an
> exception that then goes to hyp_panic() with the correct address. Also
> remove the hyp_panic() declaration from the header file to avoid
> accidental misuse.
> 
> Signed-off-by: Andrew Scull <ascull@google.com>
> ---
>  arch/arm64/include/asm/kvm_hyp.h   | 1 -
>  arch/arm64/kvm/hyp/nvhe/hyp-main.c | 2 +-
>  arch/arm64/kvm/hyp/nvhe/hyp-smp.c  | 6 ++----
>  3 files changed, 3 insertions(+), 6 deletions(-)

Makes sense to me:

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
