Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 283CE3F0468
	for <lists+kvmarm@lfdr.de>; Wed, 18 Aug 2021 15:14:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8A9EF4A1FA;
	Wed, 18 Aug 2021 09:14:04 -0400 (EDT)
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
	with ESMTP id 6fOiwFqkUeuc; Wed, 18 Aug 2021 09:14:04 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8D5714B0B7;
	Wed, 18 Aug 2021 09:14:00 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8888B4A2E5
 for <kvmarm@lists.cs.columbia.edu>; Wed, 18 Aug 2021 09:13:59 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jo2Zy1GdaNzE for <kvmarm@lists.cs.columbia.edu>;
 Wed, 18 Aug 2021 09:13:58 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 614214A1FA
 for <kvmarm@lists.cs.columbia.edu>; Wed, 18 Aug 2021 09:13:58 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id E2B9D61058;
 Wed, 18 Aug 2021 13:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629292437;
 bh=XrGwHD7gR8ZU9Zj08YSzBcYnSOA2sKeMDeoS+YJBYY8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=s9TgU/8ZXWNKvSgj510XMYezkHGqg+JgIrl8djn/mWFR2XMlQhrOMGTK2+oyffdxh
 yEeNAhxAzkxT295o+GZk8d4JDxk+ATfCn3q37I2+jhg6OP0rcD9i0fzsk+m6N9eYjm
 HoFJw2hHCe2VRpvUVbQRBDd5aDR23P9iw52hS+dqbVjvJKITB9/42wzpMCncL31+7D
 yz7689/pdf+eW/6Vx9rTQhCwrs1HTGz8+dfbQ89kFj1IbJPrAAAKWPiP58ExXDXl+M
 dgaU5kdBtpzSnIhLLIQq8nqNwgtf4nkkMhStxiN4KohlQ9p2F33ETs12hSHaeytbty
 Ey9Gtvx9X5sdg==
Date: Wed, 18 Aug 2021 14:13:51 +0100
From: Will Deacon <will@kernel.org>
To: Fuad Tabba <tabba@google.com>
Subject: Re: [PATCH v4 06/15] KVM: arm64: Restore mdcr_el2 from vcpu
Message-ID: <20210818131350.GD14107@willie-the-truck>
References: <20210817081134.2918285-1-tabba@google.com>
 <20210817081134.2918285-7-tabba@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210817081134.2918285-7-tabba@google.com>
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

On Tue, Aug 17, 2021 at 09:11:25AM +0100, Fuad Tabba wrote:
> On deactivating traps, restore the value of mdcr_el2 from the
> newly created and preserved host value vcpu context, rather than
> directly reading the hardware register.
> 
> Up until and including this patch the two values are the same,
> i.e., the hardware register and the vcpu one. A future patch will
> be changing the value of mdcr_el2 on activating traps, and this
> ensures that its value will be restored.
> 
> No functional change intended.
> 
> Signed-off-by: Fuad Tabba <tabba@google.com>
> ---
>  arch/arm64/include/asm/kvm_host.h       |  5 ++++-
>  arch/arm64/include/asm/kvm_hyp.h        |  2 +-
>  arch/arm64/kvm/hyp/include/hyp/switch.h |  6 +++++-
>  arch/arm64/kvm/hyp/nvhe/switch.c        | 13 +++++--------
>  arch/arm64/kvm/hyp/vhe/switch.c         | 14 +++++---------
>  arch/arm64/kvm/hyp/vhe/sysreg-sr.c      |  2 +-
>  6 files changed, 21 insertions(+), 21 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
