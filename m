Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 127EB504EA0
	for <lists+kvmarm@lfdr.de>; Mon, 18 Apr 2022 12:01:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E01A34B1D3;
	Mon, 18 Apr 2022 06:01:27 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -6.789
X-Spam-Level: 
X-Spam-Status: No, score=-6.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, RCVD_IN_DNSWL_HI=-5, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=ham
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jyFw7JMamqbQ; Mon, 18 Apr 2022 06:01:26 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 85CFE4086F;
	Mon, 18 Apr 2022 06:01:26 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 268534B103
 for <kvmarm@lists.cs.columbia.edu>; Mon, 18 Apr 2022 06:01:25 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9NT2EGG+CSZX for <kvmarm@lists.cs.columbia.edu>;
 Mon, 18 Apr 2022 06:01:23 -0400 (EDT)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id CFC1A4B0F7
 for <kvmarm@lists.cs.columbia.edu>; Mon, 18 Apr 2022 06:01:23 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id BCCC36119B;
 Mon, 18 Apr 2022 10:01:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D942C385A7;
 Mon, 18 Apr 2022 10:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650276082;
 bh=58hSBSLrjx6v6M4mAOKijWKEjXw1WVtJOTUJiGLqYoc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=HfrYEnwCeJhwwbhSTvoXJTwEp3Dg8c+SqBTmtNinSWEBp8cGMW48I80tbwqY9f9lM
 7YPudmc/pTNsvltW3sKPN1UBkYtgphSMU5TeKcx6ggvhn9xOFMgvTIpcv5TQR6X397
 DoYRylfBlOb8Y4/nwdMSwrD+hiU08Stttn6I88o2rKNFZJXlabBYG1Yrgqs43pczqH
 ish42gHLrxtkszBVSl+jwSOG06mNf3PCwnappv8HHiyBXXVqszrsPu+mVGQK+KOS1v
 9aAE/HATd96G18T+3RyyCMQA92NQ1y4P70c6fU4HYptdEidxU6h63fBiBtMcPXn8Fe
 rztTQD654P5wA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1ngOC7-004ycO-LZ; Mon, 18 Apr 2022 11:01:19 +0100
Date: Mon, 18 Apr 2022 11:01:19 +0100
Message-ID: <87wnfmaexc.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Kalesh Singh <kaleshsingh@google.com>
Subject: Re: [PATCH v7 3/6] KVM: arm64: Add guard pages for KVM nVHE
 hypervisor stack
In-Reply-To: <20220408200349.1529080-4-kaleshsingh@google.com>
References: <20220408200349.1529080-1-kaleshsingh@google.com>
 <20220408200349.1529080-4-kaleshsingh@google.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kaleshsingh@google.com, will@kernel.org, qperret@google.com,
 tabba@google.com, surenb@google.com, kernel-team@android.com,
 james.morse@arm.com, alexandru.elisei@arm.com, suzuki.poulose@arm.com,
 catalin.marinas@arm.com, mark.rutland@arm.com, drjones@redhat.com,
 ndesaulniers@google.com, masahiroy@kernel.org, changbin.du@intel.com,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Nick Desaulniers <ndesaulniers@google.com>, will@kernel.org,
 kernel-team@android.com, Masahiro Yamada <masahiroy@kernel.org>,
 linux-kernel@vger.kernel.org, Changbin Du <changbin.du@intel.com>,
 linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, surenb@google.com,
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

On Fri, 08 Apr 2022 21:03:26 +0100,
Kalesh Singh <kaleshsingh@google.com> wrote:
> 
> Map the stack pages in the flexible private VA range and allocate
> guard pages below the stack as unbacked VA space. The stack is aligned
> so that any valid stack address has PAGE_SHIFT bit as 1 - this is used
> for overflow detection (implemented in a subsequent patch in the series).
> 
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> Tested-by: Fuad Tabba <tabba@google.com>
> Reviewed-by: Fuad Tabba <tabba@google.com>
> ---
> 
> Changes in v7:
>   - Add Fuad's Reviewed-by and Tested-by tags.
> 
> Changes in v6:
>   - Update call to hyp_alloc_private_va_range() (return val and params)
> 
> Changes in v5:
>   - Use a single allocation for stack and guard pages to ensure they
>     are contiguous, per Marc
> 
> Changes in v4:
>   - Replace IS_ERR_OR_NULL check with IS_ERR check now that
>     hyp_alloc_private_va_range() returns an error for null
>     pointer, per Fuad
>   - Format comments to < 80 cols, per Fuad
> 
> Changes in v3:
>   - Handle null ptr in IS_ERR_OR_NULL checks, per Mark
> 
> 
>  arch/arm64/include/asm/kvm_asm.h |  1 +
>  arch/arm64/include/asm/kvm_mmu.h |  3 +++
>  arch/arm64/kvm/arm.c             | 39 +++++++++++++++++++++++++++++---
>  arch/arm64/kvm/mmu.c             |  4 ++--
>  4 files changed, 42 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> index d5b0386ef765..2e277f2ed671 100644
> --- a/arch/arm64/include/asm/kvm_asm.h
> +++ b/arch/arm64/include/asm/kvm_asm.h
> @@ -169,6 +169,7 @@ struct kvm_nvhe_init_params {
>  	unsigned long tcr_el2;
>  	unsigned long tpidr_el2;
>  	unsigned long stack_hyp_va;
> +	unsigned long stack_pa;
>  	phys_addr_t pgd_pa;
>  	unsigned long hcr_el2;
>  	unsigned long vttbr;
> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
> index a50cbb5ba402..b805316c4866 100644
> --- a/arch/arm64/include/asm/kvm_mmu.h
> +++ b/arch/arm64/include/asm/kvm_mmu.h
> @@ -117,6 +117,9 @@ alternative_cb_end
>  #include <asm/mmu_context.h>
>  #include <asm/kvm_host.h>
>  
> +extern struct kvm_pgtable *hyp_pgtable;
> +extern struct mutex kvm_hyp_pgd_mutex;

I'd rather you don't expose this at all.

> +
>  void kvm_update_va_mask(struct alt_instr *alt,
>  			__le32 *origptr, __le32 *updptr, int nr_inst);
>  void kvm_compute_layout(void);
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 523bc934fe2f..5687c0175151 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -1483,7 +1483,6 @@ static void cpu_prepare_hyp_mode(int cpu)
>  	tcr |= (idmap_t0sz & GENMASK(TCR_TxSZ_WIDTH - 1, 0)) << TCR_T0SZ_OFFSET;
>  	params->tcr_el2 = tcr;
>  
> -	params->stack_hyp_va = kern_hyp_va(per_cpu(kvm_arm_hyp_stack_page, cpu) + PAGE_SIZE);
>  	params->pgd_pa = kvm_mmu_get_httbr();
>  	if (is_protected_kvm_enabled())
>  		params->hcr_el2 = HCR_HOST_NVHE_PROTECTED_FLAGS;
> @@ -1933,14 +1932,48 @@ static int init_hyp_mode(void)
>  	 * Map the Hyp stack pages
>  	 */
>  	for_each_possible_cpu(cpu) {
> +		struct kvm_nvhe_init_params *params = per_cpu_ptr_nvhe_sym(kvm_init_params, cpu);
>  		char *stack_page = (char *)per_cpu(kvm_arm_hyp_stack_page, cpu);
> -		err = create_hyp_mappings(stack_page, stack_page + PAGE_SIZE,
> -					  PAGE_HYP);
> +		unsigned long hyp_addr;
>  
> +		/*
> +		 * Allocate a contiguous HYP private VA range for the stack
> +		 * and guard page. The allocation is also aligned based on
> +		 * the order of its size.
> +		 */
> +		err = hyp_alloc_private_va_range(PAGE_SIZE * 2, &hyp_addr);
> +		if (err) {
> +			kvm_err("Cannot allocate hyp stack guard page\n");
> +			goto out_err;
> +		}
> +
> +		/*
> +		 * Since the stack grows downwards, map the stack to the page
> +		 * at the higher address and leave the lower guard page
> +		 * unbacked.
> +		 *
> +		 * Any valid stack address now has the PAGE_SHIFT bit as 1
> +		 * and addresses corresponding to the guard page have the
> +		 * PAGE_SHIFT bit as 0 - this is used for overflow detection.
> +		 */
> +		mutex_lock(&kvm_hyp_pgd_mutex);
> +		err = kvm_pgtable_hyp_map(hyp_pgtable, hyp_addr + PAGE_SIZE,
> +					PAGE_SIZE, __pa(stack_page), PAGE_HYP);
> +		mutex_unlock(&kvm_hyp_pgd_mutex);

The mutex (and the HYP page table structure) really should stay
private to the MMU code. Just add a new helper that will take the lock
and use hyp_pgtable.

>  		if (err) {
>  			kvm_err("Cannot map hyp stack\n");
>  			goto out_err;
>  		}
> +
> +		/*
> +		 * Save the stack PA in nvhe_init_params. This will be needed
> +		 * to recreate the stack mapping in protected nVHE mode.
> +		 * __hyp_pa() won't do the right thing there, since the stack
> +		 * has been mapped in the flexible private VA space.
> +		 */
> +		params->stack_pa = __pa(stack_page);
> +
> +		params->stack_hyp_va = hyp_addr + (2 * PAGE_SIZE);
>  	}
>  
>  	for_each_possible_cpu(cpu) {
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 3d3efea4e991..a54f00bd06cc 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -22,8 +22,8 @@
>  
>  #include "trace.h"
>  
> -static struct kvm_pgtable *hyp_pgtable;
> -static DEFINE_MUTEX(kvm_hyp_pgd_mutex);
> +struct kvm_pgtable *hyp_pgtable;
> +DEFINE_MUTEX(kvm_hyp_pgd_mutex);
>  
>  static unsigned long hyp_idmap_start;
>  static unsigned long hyp_idmap_end;

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
