Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 74B28229D0E
	for <lists+kvmarm@lfdr.de>; Wed, 22 Jul 2020 18:24:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 25CB64B2B7;
	Wed, 22 Jul 2020 12:24:23 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jepVsRlC6E7S; Wed, 22 Jul 2020 12:24:23 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E27B34B2B2;
	Wed, 22 Jul 2020 12:24:21 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E551E4B294
 for <kvmarm@lists.cs.columbia.edu>; Wed, 22 Jul 2020 12:24:20 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9DZrWW30sIVQ for <kvmarm@lists.cs.columbia.edu>;
 Wed, 22 Jul 2020 12:24:19 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A2D004B298
 for <kvmarm@lists.cs.columbia.edu>; Wed, 22 Jul 2020 12:24:19 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5379531B;
 Wed, 22 Jul 2020 09:24:19 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A46C23F66E;
 Wed, 22 Jul 2020 09:24:18 -0700 (PDT)
Date: Wed, 22 Jul 2020 17:24:15 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Andrew Scull <ascull@google.com>
Subject: Re: [PATCH v2 4/4] KVM: arm64: Stop mapping host task thread flags
 to hyp
Message-ID: <20200722162415.GN30452@arm.com>
References: <20200713210505.2959828-1-ascull@google.com>
 <20200713210505.2959828-5-ascull@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200713210505.2959828-5-ascull@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: maz@kernel.org, kernel-team@android.com, kvmarm@lists.cs.columbia.edu
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

On Mon, Jul 13, 2020 at 10:05:05PM +0100, Andrew Scull wrote:

Familiar nits about commit message and Subject line.

> Since hyp now doesn't access the host task's thread flags, there's no
> need to map them up to hyp.
> 
> Signed-off-by: Andrew Scull <ascull@google.com>

With a reworked commit message:

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

> ---
>  arch/arm64/include/asm/kvm_host.h |  2 --
>  arch/arm64/kvm/fpsimd.c           | 11 +----------
>  2 files changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 1a062d44b395..fb0dfffa8be1 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -24,7 +24,6 @@
>  #include <asm/fpsimd.h>
>  #include <asm/kvm.h>
>  #include <asm/kvm_asm.h>
> -#include <asm/thread_info.h>
>  
>  #define __KVM_HAVE_ARCH_INTC_INITIALIZED
>  
> @@ -320,7 +319,6 @@ struct kvm_vcpu_arch {
>  	struct kvm_guest_debug_arch vcpu_debug_state;
>  	struct kvm_guest_debug_arch external_debug_state;
>  
> -	struct thread_info *host_thread_info;	/* hyp VA */
>  	struct user_fpsimd_state *host_fpsimd_state;	/* hyp VA */
>  
>  	struct {
> diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
> index 2779cc11f3dd..08ce264c2f41 100644
> --- a/arch/arm64/kvm/fpsimd.c
> +++ b/arch/arm64/kvm/fpsimd.c
> @@ -27,22 +27,13 @@ int kvm_arch_vcpu_run_map_fp(struct kvm_vcpu *vcpu)
>  {
>  	int ret;
>  
> -	struct thread_info *ti = &current->thread_info;
>  	struct user_fpsimd_state *fpsimd = &current->thread.uw.fpsimd_state;
>  
> -	/*
> -	 * Make sure the host task thread flags and fpsimd state are
> -	 * visible to hyp:
> -	 */
> -	ret = create_hyp_mappings(ti, ti + 1, PAGE_HYP);
> -	if (ret)
> -		goto error;
> -
> +	/* Make sure the host task fpsimd state is visible to hyp: */
>  	ret = create_hyp_mappings(fpsimd, fpsimd + 1, PAGE_HYP);
>  	if (ret)
>  		goto error;
>  
> -	vcpu->arch.host_thread_info = kern_hyp_va(ti);
>  	vcpu->arch.host_fpsimd_state = kern_hyp_va(fpsimd);
>  error:
>  	return ret;
> -- 
> 2.27.0.383.g050319c2ae-goog
> 
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
