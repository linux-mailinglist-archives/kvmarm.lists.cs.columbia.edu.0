Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E9F474EA9B9
	for <lists+kvmarm@lfdr.de>; Tue, 29 Mar 2022 10:51:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7FFD649EF2;
	Tue, 29 Mar 2022 04:51:39 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.788
X-Spam-Level: 
X-Spam-Status: No, score=-1.788 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lV9cC8alHsJH; Tue, 29 Mar 2022 04:51:39 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 315F249F31;
	Tue, 29 Mar 2022 04:51:38 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2BCB449DED
 for <kvmarm@lists.cs.columbia.edu>; Tue, 29 Mar 2022 04:51:37 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6-fIhVIgP7xq for <kvmarm@lists.cs.columbia.edu>;
 Tue, 29 Mar 2022 04:51:32 -0400 (EDT)
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com
 [209.85.160.48])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 0012949F09
 for <kvmarm@lists.cs.columbia.edu>; Tue, 29 Mar 2022 04:51:31 -0400 (EDT)
Received: by mail-oa1-f48.google.com with SMTP id
 586e51a60fabf-dee0378ce7so7635094fac.4
 for <kvmarm@lists.cs.columbia.edu>; Tue, 29 Mar 2022 01:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=v92MqDPBYDwANc3F4SbF1tQPOF36QyirPCIIm1tn6Qs=;
 b=lo6WMi0AVulXr76fhyWbskZVllHpC1Ed20rxieyGeeyrF5fNa+FJgqm47ZA2rUFUkV
 nfDrMLE2PThqUBi4a+oAkuEUGFDrGvmit4gVnay3PoJN68WkXz/dRajFPOtqeMY99BsE
 Ql3irjvWqXj5wangChYEdCI/aiUumip7ogd9U5TxSdchuPimEQSSTEZl68HrdA2gscKy
 pzDuHk3G4UMF2V4s9WaWxwLR0tw25n6Zi5FcEh9Y/sm0kkzJ2MJbfTnjSxl1BfyvNbKm
 mdvVMD1ztrcbKW32DfAJyqOfLEwu8PkbMKeIYvBsYQjMq/HY0uA8Wvqmr1wU3mmGP8a6
 QnTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=v92MqDPBYDwANc3F4SbF1tQPOF36QyirPCIIm1tn6Qs=;
 b=2TF3K31mEr9JN/T88EzcFhD6W/VR8QZ2MYbl14sD6L5RncUsKHh9/vB3B23C+cHuGP
 bxwIXmROpYNxzw62oZWa0Tm5wLZhTkyguesu0SU0eyDI8EyKhyehreucfWdykO2rJvPo
 zlLB7DHNTVxxr/YVRVlHDFC2VQrxnQRq9PqwGDCzd8XYsrrhISlL8yZ3AKadcgdf2Sp2
 Sr0bStQkBepbYQNDgiky4pWxasxfoEF1rmdqShSWg0FaaLqv+zr089OdQ6qXxXEKBgZ3
 O8L5/caslEt3F1EwoPv/8gOUd8JXn6mBLEe63+1ZjgbO+Mi+qzUfC5pvFcoBCcnCsngc
 X19w==
X-Gm-Message-State: AOAM5310WlHXYiSdCYC933He9ddlZMAmgcfD3/5FYDd2G2VL1ExjJRG3
 mbUsN9Iyqiz5yO33kmydpz99HilxD7fZFJSd6FjEGQ==
X-Google-Smtp-Source: ABdhPJzb75iOGUqiRE3lX+Y5Iv9cgHPZ/aNSB8XDKppIX7DA36M08ai8ctLU2/GinTOQ6HIugwftfOmIe8YtUeBcRKw=
X-Received: by 2002:a05:6870:700f:b0:dd:9f77:9a97 with SMTP id
 u15-20020a056870700f00b000dd9f779a97mr1639047oae.146.1648543891278; Tue, 29
 Mar 2022 01:51:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220314200148.2695206-1-kaleshsingh@google.com>
 <20220314200148.2695206-4-kaleshsingh@google.com>
In-Reply-To: <20220314200148.2695206-4-kaleshsingh@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Tue, 29 Mar 2022 09:50:55 +0100
Message-ID: <CA+EHjTzU=LG7bV9520yJNH0jRgcZa=C3JZNr6LHSmHq28Kjeqw@mail.gmail.com>
Subject: Re: [PATCH v6 3/8] KVM: arm64: Add guard pages for KVM nVHE
 hypervisor stack
To: Kalesh Singh <kaleshsingh@google.com>
Cc: kernel-team@android.com, Andrew Walbran <qwandor@google.com>,
 will@kernel.org, Peter Collingbourne <pcc@google.com>, maz@kernel.org,
 linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
 "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
 Mark Brown <broonie@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, surenb@google.com,
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

Hi Kalesh,

On Mon, Mar 14, 2022 at 8:03 PM Kalesh Singh <kaleshsingh@google.com> wrote:
>
> Map the stack pages in the flexible private VA range and allocate
> guard pages below the stack as unbacked VA space. The stack is aligned
> so that any valid stack address has PAGE_SHIFT bit as 1 - this is used
> for overflow detection (implemented in a subsequent patch in the series).
>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>

Tested-by: Fuad Tabba <tabba@google.com>
Reviewed-by: Fuad Tabba <tabba@google.com>

Thanks,
/fuad


> ---
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
>         unsigned long tcr_el2;
>         unsigned long tpidr_el2;
>         unsigned long stack_hyp_va;
> +       unsigned long stack_pa;
>         phys_addr_t pgd_pa;
>         unsigned long hcr_el2;
>         unsigned long vttbr;
> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
> index 3cc9aa25f510..967a9ea9a47b 100644
> --- a/arch/arm64/include/asm/kvm_mmu.h
> +++ b/arch/arm64/include/asm/kvm_mmu.h
> @@ -116,6 +116,9 @@ alternative_cb_end
>  #include <asm/cacheflush.h>
>  #include <asm/mmu_context.h>
>
> +extern struct kvm_pgtable *hyp_pgtable;
> +extern struct mutex kvm_hyp_pgd_mutex;
> +
>  void kvm_update_va_mask(struct alt_instr *alt,
>                         __le32 *origptr, __le32 *updptr, int nr_inst);
>  void kvm_compute_layout(void);
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 4dca6ffd03d4..72be7e695d8d 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -1538,7 +1538,6 @@ static void cpu_prepare_hyp_mode(int cpu)
>         tcr |= (idmap_t0sz & GENMASK(TCR_TxSZ_WIDTH - 1, 0)) << TCR_T0SZ_OFFSET;
>         params->tcr_el2 = tcr;
>
> -       params->stack_hyp_va = kern_hyp_va(per_cpu(kvm_arm_hyp_stack_page, cpu) + PAGE_SIZE);
>         params->pgd_pa = kvm_mmu_get_httbr();
>         if (is_protected_kvm_enabled())
>                 params->hcr_el2 = HCR_HOST_NVHE_PROTECTED_FLAGS;
> @@ -1987,14 +1986,48 @@ static int init_hyp_mode(void)
>          * Map the Hyp stack pages
>          */
>         for_each_possible_cpu(cpu) {
> +               struct kvm_nvhe_init_params *params = per_cpu_ptr_nvhe_sym(kvm_init_params, cpu);
>                 char *stack_page = (char *)per_cpu(kvm_arm_hyp_stack_page, cpu);
> -               err = create_hyp_mappings(stack_page, stack_page + PAGE_SIZE,
> -                                         PAGE_HYP);
> +               unsigned long hyp_addr;
>
> +               /*
> +                * Allocate a contiguous HYP private VA range for the stack
> +                * and guard page. The allocation is also aligned based on
> +                * the order of its size.
> +                */
> +               err = hyp_alloc_private_va_range(PAGE_SIZE * 2, &hyp_addr);
> +               if (err) {
> +                       kvm_err("Cannot allocate hyp stack guard page\n");
> +                       goto out_err;
> +               }
> +
> +               /*
> +                * Since the stack grows downwards, map the stack to the page
> +                * at the higher address and leave the lower guard page
> +                * unbacked.
> +                *
> +                * Any valid stack address now has the PAGE_SHIFT bit as 1
> +                * and addresses corresponding to the guard page have the
> +                * PAGE_SHIFT bit as 0 - this is used for overflow detection.
> +                */
> +               mutex_lock(&kvm_hyp_pgd_mutex);
> +               err = kvm_pgtable_hyp_map(hyp_pgtable, hyp_addr + PAGE_SIZE,
> +                                       PAGE_SIZE, __pa(stack_page), PAGE_HYP);
> +               mutex_unlock(&kvm_hyp_pgd_mutex);
>                 if (err) {
>                         kvm_err("Cannot map hyp stack\n");
>                         goto out_err;
>                 }
> +
> +               /*
> +                * Save the stack PA in nvhe_init_params. This will be needed
> +                * to recreate the stack mapping in protected nVHE mode.
> +                * __hyp_pa() won't do the right thing there, since the stack
> +                * has been mapped in the flexible private VA space.
> +                */
> +               params->stack_pa = __pa(stack_page);
> +
> +               params->stack_hyp_va = hyp_addr + (2 * PAGE_SIZE);
>         }
>
>         for_each_possible_cpu(cpu) {
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 7326d683c500..9bfc6d8f3c49 100644
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
> --
> 2.35.1.723.g4982287a31-goog
>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
