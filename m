Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E28A933B12A
	for <lists+kvmarm@lfdr.de>; Mon, 15 Mar 2021 12:30:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6ECB44B591;
	Mon, 15 Mar 2021 07:30:38 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@linuxfoundation.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QS4zlQmmHAuR; Mon, 15 Mar 2021 07:30:38 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 29DAF4B51F;
	Mon, 15 Mar 2021 07:30:37 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 57DB44B48E
 for <kvmarm@lists.cs.columbia.edu>; Mon, 15 Mar 2021 07:30:36 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HCgKsWHYrHSM for <kvmarm@lists.cs.columbia.edu>;
 Mon, 15 Mar 2021 07:30:35 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 361544B462
 for <kvmarm@lists.cs.columbia.edu>; Mon, 15 Mar 2021 07:30:35 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 836AB64E20;
 Mon, 15 Mar 2021 11:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1615807834;
 bh=+Vh47VzzAQ8Y4lYeLFe/YRi9yK/q8CBm43+kjOVO1oQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=O+XAjXZbwbH1sy7ZxvsEZXXP3r8S7RXFTo90Xin/1o2pE1np7AY1LOUyAbwIX52bt
 04hRCTwzTond2tfpAOO9XE0PPUJAbEBCa7nAyqwUkER3LaLeqMowG88HfjvdEqa8ZG
 Ht0Cu9kkCEpV/XgSTaWtptx/bwjGiELAUHhlT4E0=
Date: Mon, 15 Mar 2021 12:30:31 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH][stable-4.{4,9,14,19}] KVM: arm64: Fix exclusive limit
 for IPA size
Message-ID: <YE9FVw1PE9kClrdi@kroah.com>
References: <20210315110833.4135927-1-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210315110833.4135927-1-maz@kernel.org>
Cc: kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
 stable@vger.kernel.org
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

On Mon, Mar 15, 2021 at 11:08:33AM +0000, Marc Zyngier wrote:
> Commit 262b003d059c6671601a19057e9fe1a5e7f23722 upstream.
> 
> When registering a memslot, we check the size and location of that
> memslot against the IPA size to ensure that we can provide guest
> access to the whole of the memory.
> 
> Unfortunately, this check rejects memslot that end-up at the exact
> limit of the addressing capability for a given IPA size. For example,
> it refuses the creation of a 2GB memslot at 0x8000000 with a 32bit
> IPA space.
> 
> Fix it by relaxing the check to accept a memslot reaching the
> limit of the IPA space.
> 
> Fixes: c3058d5da222 ("arm/arm64: KVM: Ensure memslots are within KVM_PHYS_SIZE")
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: stable@vger.kernel.org # 4.4, 4.9, 4.14, 4.19
> Reviewed-by: Andrew Jones <drjones@redhat.com>
> Link: https://lore.kernel.org/r/20210311100016.3830038-3-maz@kernel.org
> ---
>  virt/kvm/arm/mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This file does not exist in 4.4.y or 4.9.y, so I can't apply it there :(

Queued up everywhere else, and also the other backports you sent,
thanks.

gre gk-h
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
