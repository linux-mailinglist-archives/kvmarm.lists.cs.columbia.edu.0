Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D927A2FA609
	for <lists+kvmarm@lfdr.de>; Mon, 18 Jan 2021 17:26:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0F4524B2D0;
	Mon, 18 Jan 2021 11:26:14 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PtFEHDA26XvV; Mon, 18 Jan 2021 11:26:13 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E690F4B2C9;
	Mon, 18 Jan 2021 11:26:12 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 991404B2A2
 for <kvmarm@lists.cs.columbia.edu>; Mon, 18 Jan 2021 11:26:11 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cCYlqaDaiuMi for <kvmarm@lists.cs.columbia.edu>;
 Mon, 18 Jan 2021 11:26:09 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id BD1A04B2A0
 for <kvmarm@lists.cs.columbia.edu>; Mon, 18 Jan 2021 11:26:09 -0500 (EST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id B7CEE206D8;
 Mon, 18 Jan 2021 16:26:07 +0000 (UTC)
Date: Mon, 18 Jan 2021 16:26:05 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] arm64: Drop workaround for broken 'S' constraint with
 GCC 4.9
Message-ID: <20210118162604.GB4483@gaia>
References: <20210118130129.2875949-1-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210118130129.2875949-1-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kernel-team@android.com, Will Deacon <will@kernel.org>,
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

On Mon, Jan 18, 2021 at 01:01:29PM +0000, Marc Zyngier wrote:
> Since GCC < 5.1 has been shown to be unsuitable for the arm64 kernel,
> let's drop the workaround for the 'S' asm constraint that GCC 4.9
> doesn't always grok.
> 
> This is effectively a revert of 9fd339a45be5 ("arm64: Work around
> broken GCC 4.9 handling of "S" constraint").
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>

It looks like I merged this fix in -rc1. Do you want me to merge the
revert as well or you'll handle it?

-- 
Catalin
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
