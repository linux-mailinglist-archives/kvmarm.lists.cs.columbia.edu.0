Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id DFB24226062
	for <lists+kvmarm@lfdr.de>; Mon, 20 Jul 2020 15:04:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0FA3E4B15F;
	Mon, 20 Jul 2020 09:04:06 -0400 (EDT)
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
	with ESMTP id SQjLtgcryBmU; Mon, 20 Jul 2020 09:04:05 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E26334B16B;
	Mon, 20 Jul 2020 09:04:04 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2E4B14B198
 for <kvmarm@lists.cs.columbia.edu>; Mon, 20 Jul 2020 09:04:03 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZoT4uMqnDY8t for <kvmarm@lists.cs.columbia.edu>;
 Mon, 20 Jul 2020 09:04:02 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 331994B09F
 for <kvmarm@lists.cs.columbia.edu>; Mon, 20 Jul 2020 09:04:02 -0400 (EDT)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7D53C207FC;
 Mon, 20 Jul 2020 13:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595250241;
 bh=IrHumJNNwPA5DDR5b4RIKODfqPUkFXljRiSqzAuKtGw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tNkIcLz0gZ/B1LVcyqZLazYMATcvmu5gT0QMb0tiDqsxFc4v6SZXGw1VlZaqhQy9n
 twMPX7AlSdky7q3P0paxzBfuPK9vj4P/udpzlSxrjfk0Yavud541HD/KKlapC5JXp5
 XA9a3VYcWoV7x9fzL87yw3Qbsh0i6d+an7eaxAe0=
Date: Mon, 20 Jul 2020 15:04:11 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH stable v4.9 v2] arm64: entry: Place an SB sequence
 following an ERET instruction
Message-ID: <20200720130411.GB494210@kroah.com>
References: <20200709195034.15185-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200709195034.15185-1-f.fainelli@gmail.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>,
 Fangrui Song <maskray@google.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, open list <linux-kernel@vger.kernel.org>,
 stable@vger.kernel.org,
 "open list:KERNEL VIRTUAL MACHINE FOR ARM64 \(KVM/arm64\)"
 <kvmarm@lists.cs.columbia.edu>, Mark Brown <broonie@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Marc Zyngier <maz@kernel.org>,
 Kristina Martsenko <kristina.martsenko@arm.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, linux-arm-kernel@lists.infradead.org
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

On Thu, Jul 09, 2020 at 12:50:23PM -0700, Florian Fainelli wrote:
> From: Will Deacon <will.deacon@arm.com>
> 
> commit 679db70801da9fda91d26caf13bf5b5ccc74e8e8 upstream
> 
> Some CPUs can speculate past an ERET instruction and potentially perform
> speculative accesses to memory before processing the exception return.
> Since the register state is often controlled by a lower privilege level
> at the point of an ERET, this could potentially be used as part of a
> side-channel attack.
> 
> This patch emits an SB sequence after each ERET so that speculation is
> held up on exception return.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> [florian: Adjust hyp-entry.S to account for the label
>  added change to hyp/entry.S]
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
> Changes in v2:
> 
> - added missing hunk in hyp/entry.S per Will's feedback

What about 4.19.y and 4.14.y trees?  I can't take something for 4.9.y
and then have a regression if someone moves to a newer release, right?

thanks,

greg k-h
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
