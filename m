Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 520233EA256
	for <lists+kvmarm@lfdr.de>; Thu, 12 Aug 2021 11:46:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E06164A4E5;
	Thu, 12 Aug 2021 05:46:30 -0400 (EDT)
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
	with ESMTP id FijLl7qLGwFd; Thu, 12 Aug 2021 05:46:30 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BABFA4A3A3;
	Thu, 12 Aug 2021 05:46:26 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3231049F8F
 for <kvmarm@lists.cs.columbia.edu>; Thu, 12 Aug 2021 05:46:25 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id duh8Tgf2mEcJ for <kvmarm@lists.cs.columbia.edu>;
 Thu, 12 Aug 2021 05:46:24 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 4082C407F4
 for <kvmarm@lists.cs.columbia.edu>; Thu, 12 Aug 2021 05:46:24 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0472C60FBF;
 Thu, 12 Aug 2021 09:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628761583;
 bh=qhI1ZjlthPN+UipICNKadmY33LTUi/D0cRWvLI4yveM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FMU+AoXpqHItFGbLzQm/dSToRdT76j6LefDOwqSk3jr4I6dSjXvnx8pSbjcxFm9SW
 Ou7Bq22+d01ZKfXnZbkqFI79xAHFqdwPKcjVeC9mKxNT99PBjb7dkTdODEkSivRe/P
 amk5LNKM50WTSx2SDqdGmHx6nVg8+IU5qJCLpYMUYzAcCn+B8MFrvklaLZmJNFpudU
 yBcpicGZigcM5k0T0bh0rqXeCE318Lx01ZU4kOhBDiS73FABB+JI2CRX7Op3qtACJK
 u+cMB1uIEwlQgDAC2PDLljK4LBFkTMztlOlQWOSymw+fUeXbg0oO4Dxyhm4IZO+ruz
 tr53B7+TDzelg==
Date: Thu, 12 Aug 2021 10:46:18 +0100
From: Will Deacon <will@kernel.org>
To: Fuad Tabba <tabba@google.com>
Subject: Re: [PATCH v3 12/15] KVM: arm64: Move sanitized copies of CPU features
Message-ID: <20210812094617.GI5912@willie-the-truck>
References: <20210719160346.609914-1-tabba@google.com>
 <20210719160346.609914-13-tabba@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210719160346.609914-13-tabba@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kernel-team@android.com, kvm@vger.kernel.org, maz@kernel.org,
 pbonzini@redhat.com, kvmarm@lists.cs.columbia.edu,
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

On Mon, Jul 19, 2021 at 05:03:43PM +0100, Fuad Tabba wrote:
> Move the sanitized copies of the CPU feature registers to the
> recently created sys_regs.c. This consolidates all copies in a
> more relevant file.
> 
> No functional change intended.
> 
> Signed-off-by: Fuad Tabba <tabba@google.com>
> ---
>  arch/arm64/kvm/hyp/nvhe/mem_protect.c | 6 ------
>  arch/arm64/kvm/hyp/nvhe/sys_regs.c    | 2 ++
>  2 files changed, 2 insertions(+), 6 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
