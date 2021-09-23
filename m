Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 83066415F0E
	for <lists+kvmarm@lfdr.de>; Thu, 23 Sep 2021 14:58:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0E4F04B161;
	Thu, 23 Sep 2021 08:58:44 -0400 (EDT)
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
	with ESMTP id Y1B3T6n2y7jx; Thu, 23 Sep 2021 08:58:43 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B1BF04B15C;
	Thu, 23 Sep 2021 08:58:42 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A57BA4B0F2
 for <kvmarm@lists.cs.columbia.edu>; Thu, 23 Sep 2021 08:58:41 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j+0BK+b7kU5t for <kvmarm@lists.cs.columbia.edu>;
 Thu, 23 Sep 2021 08:58:40 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 65BBE4B0F1
 for <kvmarm@lists.cs.columbia.edu>; Thu, 23 Sep 2021 08:58:40 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 10DB660F43;
 Thu, 23 Sep 2021 12:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632401919;
 bh=BEIXGCH5BckmtiISCaPM5m33QFlER0ukVLbDKFBYkrs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qG6P7kDfsh6uKtn48XozMnjmUKYMUP0z70teirWUd+FFJ+nMk2J+zG4lIbZX6C4Ba
 y6fhGdafrhTfJAq0Y2+Xz214DepC2NiZR83fTbe9dvdPcnsTi33+r3fn6D44GBOYAM
 nJVN+pQLpwW8crA0Zgu3hvKgirv1sGPqJKSwd4sf1ntEkE/diKNzcw5CB5JmLQM6jx
 OSF2WZ2u6c/OiDrIWXRCBIS0xSvUfZ3xeEY/ZYf0bhs0RryWTjNWlps1DVEEuM/GkL
 0Hxn5LjRPWkYBxpKja9b3G8ZcTIYfLUcXX+OQL2AtboGH1R2LJxKS5s0Crx20vTQEq
 epe2Cxz5jcymw==
Date: Thu, 23 Sep 2021 13:58:34 +0100
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 5/5] KVM: arm64: Disable privileged hypercalls after pKVM
 finalisation
Message-ID: <20210923125834.GA15934@willie-the-truck>
References: <20210923112256.15767-1-will@kernel.org>
 <20210923112256.15767-6-will@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210923112256.15767-6-will@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Marc Zyngier <maz@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
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

On Thu, Sep 23, 2021 at 12:22:56PM +0100, Will Deacon wrote:
> After pKVM has been 'finalised' using the __pkvm_prot_finalize hypercall,
> the calling CPU will have a Stage-2 translation enabled to prevent access
> to memory pages owned by EL2.
> 
> Although this forms a significant part of the process to deprivilege the
> host kernel, we also need to ensure that the hypercall interface is
> reduced so that the EL2 code cannot, for example, be re-initialised using
> a new set of vectors.
> 
> Re-order the hypercalls so that only a suffix remains available after
> finalisation of pKVM.
> 
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Quentin Perret <qperret@google.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  arch/arm64/include/asm/kvm_asm.h   | 43 ++++++++++++++++--------------
>  arch/arm64/kvm/hyp/nvhe/hyp-main.c | 26 +++++++++++-------
>  2 files changed, 39 insertions(+), 30 deletions(-)

[...]

> diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> index 2da6aa8da868..4120e34288e1 100644
> --- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> +++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> @@ -165,36 +165,42 @@ typedef void (*hcall_t)(struct kvm_cpu_context *);
>  #define HANDLE_FUNC(x)	[__KVM_HOST_SMCCC_FUNC_##x] = (hcall_t)handle_##x
>  
>  static const hcall_t host_hcall[] = {
> -	HANDLE_FUNC(__kvm_vcpu_run),
> +	/* ___kvm_hyp_init */
> +	HANDLE_FUNC(__kvm_get_mdcr_el2),
> +	HANDLE_FUNC(__pkvm_init),
> +	HANDLE_FUNC(__pkvm_create_private_mapping),
> +	HANDLE_FUNC(__pkvm_cpu_set_vector),
> +	HANDLE_FUNC(__kvm_enable_ssbs),
> +	HANDLE_FUNC(__vgic_v3_init_lrs),
> +	HANDLE_FUNC(__pkvm_prot_finalize),
> +
> +	HANDLE_FUNC(__pkvm_host_share_hyp),
>  	HANDLE_FUNC(__kvm_adjust_pc),
> +	HANDLE_FUNC(__kvm_vcpu_run),
>  	HANDLE_FUNC(__kvm_flush_vm_context),
>  	HANDLE_FUNC(__kvm_tlb_flush_vmid_ipa),
>  	HANDLE_FUNC(__kvm_tlb_flush_vmid),
>  	HANDLE_FUNC(__kvm_flush_cpu_context),
>  	HANDLE_FUNC(__kvm_timer_set_cntvoff),
> -	HANDLE_FUNC(__kvm_enable_ssbs),
>  	HANDLE_FUNC(__vgic_v3_get_gic_config),
>  	HANDLE_FUNC(__vgic_v3_read_vmcr),
>  	HANDLE_FUNC(__vgic_v3_write_vmcr),
> -	HANDLE_FUNC(__vgic_v3_init_lrs),
> -	HANDLE_FUNC(__kvm_get_mdcr_el2),
>  	HANDLE_FUNC(__vgic_v3_save_aprs),
>  	HANDLE_FUNC(__vgic_v3_restore_aprs),
> -	HANDLE_FUNC(__pkvm_init),
> -	HANDLE_FUNC(__pkvm_cpu_set_vector),
> -	HANDLE_FUNC(__pkvm_host_share_hyp),
> -	HANDLE_FUNC(__pkvm_create_private_mapping),
> -	HANDLE_FUNC(__pkvm_prot_finalize),

Not that it makes any functional difference, but I was trying to keep this
in numerical order and evidently didn't manage it after renumbering
__vgic_v3_get_gic_config. Will fix for v2.

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
