Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id DDEF83406F2
	for <lists+kvmarm@lfdr.de>; Thu, 18 Mar 2021 14:34:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5B5C24B748;
	Thu, 18 Mar 2021 09:34:36 -0400 (EDT)
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
	with ESMTP id X1OEIVemT1mw; Thu, 18 Mar 2021 09:34:36 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 159F24B747;
	Thu, 18 Mar 2021 09:34:35 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 44DF84B743
 for <kvmarm@lists.cs.columbia.edu>; Thu, 18 Mar 2021 09:34:34 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v+d79diJsPRt for <kvmarm@lists.cs.columbia.edu>;
 Thu, 18 Mar 2021 09:34:33 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 22D614B731
 for <kvmarm@lists.cs.columbia.edu>; Thu, 18 Mar 2021 09:34:33 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2A72864E27;
 Thu, 18 Mar 2021 13:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616074470;
 bh=d+aUNfWPxN/xxjxc8yYGr+7tZ50qw5UZwCakX/qmEk0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AMKitB5VW/7PXIefSVUCNlKk3uz9eZlkxq3nB8HKwt24c/rwDd6rUUQU+6lNyau9X
 NMgBtb3f7NZsoJO9zV63kPQdB7x2LVb+96uwHd40xQhQh7zAEJ8wAJIZRoIIQ1+sbE
 96R8JHHuIp5xr4pxwJtqHMJrF4WjB1kLDC/uIq6vxxjb4Avc04NiEF2VLR0wqix0i3
 EZKOs6l3XRfLLGuYcsafB3MFGzwm9qwRQBk236hbyE4SlgfqhnPPXCfj0ni8oR8PdP
 Tf6aOHl7UnVgKSahhp0sBFHtFXgDLFXSziVTZIQuRfESWZqRaJUc6xvn+aP4G8Sc3w
 t+WQ6ajjAzMQQ==
Date: Thu, 18 Mar 2021 13:34:25 +0000
From: Will Deacon <will@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2 06/11] KVM: arm64: Rework SVE host-save/guest-restore
Message-ID: <20210318133424.GC7055@willie-the-truck>
References: <20210318122532.505263-1-maz@kernel.org>
 <20210318122532.505263-7-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210318122532.505263-7-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 kvmarm@lists.cs.columbia.edu, broonie@kernel.org, kernel-team@android.com,
 dave.martin@arm.com, linux-arm-kernel@lists.infradead.org, daniel.kiss@arm.com
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

On Thu, Mar 18, 2021 at 12:25:27PM +0000, Marc Zyngier wrote:
> In order to keep the code readable, move the host-save/guest-restore
> sequences in their own functions, with the following changes:
> - the hypervisor ZCR is now set from C code
> - ZCR_EL2 is always used as the EL2 accessor
> 
> This results in some minor assembler macro rework.
> No functional change intended.
> 
> Acked-by: Will Deacon <will@kernel.org>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/include/asm/fpsimdmacros.h   |  8 +++--
>  arch/arm64/include/asm/kvm_hyp.h        |  2 +-
>  arch/arm64/kvm/hyp/fpsimd.S             |  2 +-
>  arch/arm64/kvm/hyp/include/hyp/switch.h | 40 +++++++++++++++----------
>  4 files changed, 32 insertions(+), 20 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
