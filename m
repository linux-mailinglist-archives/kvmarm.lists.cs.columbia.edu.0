Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A9539504EA6
	for <lists+kvmarm@lfdr.de>; Mon, 18 Apr 2022 12:09:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 096374B1BD;
	Mon, 18 Apr 2022 06:09:29 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.788
X-Spam-Level: 
X-Spam-Status: No, score=-1.788 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, RCVD_IN_DNSWL_BLOCKED=0.001, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G0xsoKtwItuP; Mon, 18 Apr 2022 06:09:28 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AD1C849AF7;
	Mon, 18 Apr 2022 06:09:27 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8510E410F3
 for <kvmarm@lists.cs.columbia.edu>; Mon, 18 Apr 2022 06:09:26 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IC6TAY6iqz4I for <kvmarm@lists.cs.columbia.edu>;
 Mon, 18 Apr 2022 06:09:25 -0400 (EDT)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 1AFFE41049
 for <kvmarm@lists.cs.columbia.edu>; Mon, 18 Apr 2022 06:09:25 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id C9D51B80E66;
 Mon, 18 Apr 2022 10:09:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8577FC385A7;
 Mon, 18 Apr 2022 10:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650276562;
 bh=TwWZh5ydoGNDbA/2K1N4I1qvcZf/L/ndLI81g5OpeGM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=kBqdAvO+Hss1W1O7ibP08osJiUufMkPO80GVoafqBf72T1J7BpCQFgCOT8V+gH6Fv
 /eMmtOuiJ+5iThWiwvV8b6WY4hfARSSbYEHJhCjgTWwX2FzpBiBlUHOZ+BUQ6MCEPZ
 FX9xFRkxgkiIqpHQhym5H0hHYUWPOHKfqEjdWwl5ImEF1juFc4pbh5xPZ/jDnIGGdl
 3zL9t7cNqSQNmdGlBOOms+vWIdNpmQD8/iLOSxQebSqYo79pa0fkWPHr+Rw1QuznUh
 +e5SULzRU1cZP/0ZL1MZlbaToB5Gc4NW0+ddQgdbokXk9q2xouCwhikrZ3Vda0HOYL
 DeZYoPNvavShg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1ngOJs-004yh4-1V; Mon, 18 Apr 2022 11:09:20 +0100
Date: Mon, 18 Apr 2022 11:09:19 +0100
Message-ID: <87v8v6aek0.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Kalesh Singh <kaleshsingh@google.com>
Subject: Re: [PATCH v7 5/6] KVM: arm64: Detect and handle hypervisor stack
 overflows
In-Reply-To: <20220408200349.1529080-6-kaleshsingh@google.com>
References: <20220408200349.1529080-1-kaleshsingh@google.com>
 <20220408200349.1529080-6-kaleshsingh@google.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kaleshsingh@google.com, will@kernel.org, qperret@google.com,
 tabba@google.com, surenb@google.com, kernel-team@android.com,
 james.morse@arm.com, alexandru.elisei@arm.com, suzuki.poulose@arm.com,
 catalin.marinas@arm.com, qwandor@google.com, mark.rutland@arm.com,
 ardb@kernel.org, yuzenghui@huawei.com, drjones@redhat.com, nathan@kernel.org,
 masahiroy@kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Andrew Walbran <qwandor@google.com>, will@kernel.org,
 kernel-team@android.com, Masahiro Yamada <masahiroy@kernel.org>,
 linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
 Nathan Chancellor <nathan@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, surenb@google.com
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

On Fri, 08 Apr 2022 21:03:28 +0100,
Kalesh Singh <kaleshsingh@google.com> wrote:
> 
> The hypervisor stacks (for both nVHE Hyp mode and nVHE protected mode)
> are aligned such  that any valid stack address has PAGE_SHIFT bit as 1.
> This allows us to conveniently check for overflow in the exception entry
> without corrupting any GPRs. We won't recover from a stack overflow so
> panic the hypervisor.
> 
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> Tested-by: Fuad Tabba <tabba@google.com>
> Reviewed-by: Fuad Tabba <tabba@google.com>
> ---
> 
> Changes in v7:
>   - Add Fuad's Reviewed-by and Tested-by tags.
> 
> Changes in v5:
>   - Valid stack addresses now have PAGE_SHIFT bit as 1 instead of 0
> 
> Changes in v3:
>   - Remove test_sp_overflow macro, per Mark
>   - Add asmlinkage attribute for hyp_panic, hyp_panic_bad_stack, per Ard
> 
> 
>  arch/arm64/kvm/hyp/nvhe/host.S   | 24 ++++++++++++++++++++++++
>  arch/arm64/kvm/hyp/nvhe/switch.c |  7 ++++++-
>  2 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/hyp/nvhe/host.S b/arch/arm64/kvm/hyp/nvhe/host.S
> index 3d613e721a75..be6d844279b1 100644
> --- a/arch/arm64/kvm/hyp/nvhe/host.S
> +++ b/arch/arm64/kvm/hyp/nvhe/host.S
> @@ -153,6 +153,18 @@ SYM_FUNC_END(__host_hvc)
>  
>  .macro invalid_host_el2_vect
>  	.align 7
> +
> +	/*
> +	 * Test whether the SP has overflowed, without corrupting a GPR.
> +	 * nVHE hypervisor stacks are aligned so that the PAGE_SHIFT bit
> +	 * of SP should always be 1.
> +	 */
> +	add	sp, sp, x0			// sp' = sp + x0
> +	sub	x0, sp, x0			// x0' = sp' - x0 = (sp + x0) - x0 = sp
> +	tbz	x0, #PAGE_SHIFT, .L__hyp_sp_overflow\@
> +	sub	x0, sp, x0			// x0'' = sp' - x0' = (sp + x0) - sp = x0
> +	sub	sp, sp, x0			// sp'' = sp' - x0 = (sp + x0) - x0 = sp
> +
>  	/* If a guest is loaded, panic out of it. */
>  	stp	x0, x1, [sp, #-16]!
>  	get_loaded_vcpu x0, x1
> @@ -165,6 +177,18 @@ SYM_FUNC_END(__host_hvc)
>  	 * been partially clobbered by __host_enter.
>  	 */
>  	b	hyp_panic
> +
> +.L__hyp_sp_overflow\@:
> +	/*
> +	 * Reset SP to the top of the stack, to allow handling the hyp_panic.
> +	 * This corrupts the stack but is ok, since we won't be attempting
> +	 * any unwinding here.
> +	 */
> +	ldr_this_cpu	x0, kvm_init_params + NVHE_INIT_STACK_HYP_VA, x1
> +	mov	sp, x0
> +
> +	bl	hyp_panic_bad_stack

Why bl? You clearly don't expect to return here, given that you have
an ASM_BUG() right below, and that you are calling a __no_return
function. I think we should be consistent with the rest of the code
and just do a simple branch.

It also gives us a chance to preserve an extra register from the
context.

> +	ASM_BUG()
>  .endm
>  
>  .macro invalid_host_el1_vect
> diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
> index 6410d21d8695..703a5d3f611b 100644
> --- a/arch/arm64/kvm/hyp/nvhe/switch.c
> +++ b/arch/arm64/kvm/hyp/nvhe/switch.c
> @@ -347,7 +347,7 @@ int __kvm_vcpu_run(struct kvm_vcpu *vcpu)
>  	return exit_code;
>  }
>  
> -void __noreturn hyp_panic(void)
> +asmlinkage void __noreturn hyp_panic(void)
>  {
>  	u64 spsr = read_sysreg_el2(SYS_SPSR);
>  	u64 elr = read_sysreg_el2(SYS_ELR);
> @@ -369,6 +369,11 @@ void __noreturn hyp_panic(void)
>  	unreachable();
>  }
>  
> +asmlinkage void __noreturn hyp_panic_bad_stack(void)
> +{
> +	hyp_panic();
> +}
> +
>  asmlinkage void kvm_unexpected_el2_exception(void)
>  {
>  	return __kvm_unexpected_el2_exception();
> -- 
> 2.35.1.1178.g4f1659d476-goog
> 
> 

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
