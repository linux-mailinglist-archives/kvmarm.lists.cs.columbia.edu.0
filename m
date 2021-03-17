Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C3BF633F2AA
	for <lists+kvmarm@lfdr.de>; Wed, 17 Mar 2021 15:32:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6F9FF4B5FF;
	Wed, 17 Mar 2021 10:32:09 -0400 (EDT)
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
	with ESMTP id 7qeVxiVL1SUk; Wed, 17 Mar 2021 10:32:09 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4C2214B654;
	Wed, 17 Mar 2021 10:32:08 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 09DE84B40F
 for <kvmarm@lists.cs.columbia.edu>; Wed, 17 Mar 2021 10:32:07 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z++G1pbwIYGc for <kvmarm@lists.cs.columbia.edu>;
 Wed, 17 Mar 2021 10:32:06 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 0E1B04B3EE
 for <kvmarm@lists.cs.columbia.edu>; Wed, 17 Mar 2021 10:32:06 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0EAD664E13;
 Wed, 17 Mar 2021 14:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615991523;
 bh=9PV7SAdG8UI+hcTymUc6iMtrRcc/ff/6MFt24sMoR4c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jphF1XmayKtQgSAtPuUftY5Qv/YT6yoj383uQjZE9zvLm8jWI0tGF3DKhJvZHyA51
 VnqyWU7ZTXljYlMjbty/RyYjFGXE0grk9sDvV7aa8J5Uvr/IADhNbo5vB3vIhLTqMW
 b7w/nLO7cbrpcFlk1s6mUXORXdd+LGgUmFOcBwSZ4Wei55J8dDDJQwlAlr824DnzuB
 l5rhJxilxB0D0sR1G711IZs0i4BocWJo8eBBZEFnF+2AWPkXIyFOBT8yK3b0zr8L2S
 qKkM4NSqSu5LucgAZEYY/jHlcF8flGsXAnjXOvZQef+nOE2VduRVqOy/asdAIsAXqK
 BwfJLxLH6a8VQ==
Date: Wed, 17 Mar 2021 14:31:57 +0000
From: Will Deacon <will@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 03/10] KVM: arm64: Let vcpu_sve_pffr() handle HYP VAs
Message-ID: <20210317143157.GD5393@willie-the-truck>
References: <20210316101312.102925-1-maz@kernel.org>
 <20210316101312.102925-4-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210316101312.102925-4-maz@kernel.org>
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

On Tue, Mar 16, 2021 at 10:13:05AM +0000, Marc Zyngier wrote:
> The vcpu_sve_pffr() returns a pointer, which can be an interesting
> thing to do on nVHE. Wrap the pointer with kern_hyp_va(), and
> take this opportunity to remove the unnecessary casts (sve_state
> being a void *).
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/include/asm/kvm_host.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 3d10e6527f7d..fb1d78299ba0 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -372,8 +372,8 @@ struct kvm_vcpu_arch {
>  };
>  
>  /* Pointer to the vcpu's SVE FFR for sve_{save,load}_state() */
> -#define vcpu_sve_pffr(vcpu) ((void *)((char *)((vcpu)->arch.sve_state) + \
> -				      sve_ffr_offset((vcpu)->arch.sve_max_vl)))
> +#define vcpu_sve_pffr(vcpu) (kern_hyp_va((vcpu)->arch.sve_state) +	\
> +			     sve_ffr_offset((vcpu)->arch.sve_max_vl))
>  
>  #define vcpu_sve_state_size(vcpu) ({					\
>  	size_t __size_ret;						\

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
