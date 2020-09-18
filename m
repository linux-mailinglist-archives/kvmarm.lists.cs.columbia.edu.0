Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BD88B26F926
	for <lists+kvmarm@lfdr.de>; Fri, 18 Sep 2020 11:24:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4B0DF4B448;
	Fri, 18 Sep 2020 05:24:11 -0400 (EDT)
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
	with ESMTP id ry6O7w9TYuZF; Fri, 18 Sep 2020 05:24:11 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 14A464B406;
	Fri, 18 Sep 2020 05:24:10 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B8C494B3FD
 for <kvmarm@lists.cs.columbia.edu>; Fri, 18 Sep 2020 05:24:08 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pdHKikI+W1wy for <kvmarm@lists.cs.columbia.edu>;
 Fri, 18 Sep 2020 05:24:07 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9053B4B3FC
 for <kvmarm@lists.cs.columbia.edu>; Fri, 18 Sep 2020 05:24:07 -0400 (EDT)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 238A120DD4;
 Fri, 18 Sep 2020 09:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600421046;
 bh=5BPFCutNa5VNQMibpDHHB+qvvOTgQcOE09RubxpF1GI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=xU5lzR1Ga0PcfhABCdoUUHXJd6dN4fDFAU+RJC4XjY97A6xGaeDusE+AIxQe09UUe
 cjDXcplObHW/R0vJ/QWHVnEYHNiAmMG2eH98/7f5xG9jUnkaKa5fMSVYDlcCKKQY1K
 3J3oarxI8eW8I9yOa/ZZSSr5YNbR3x/6bNNhLGVY=
Date: Fri, 18 Sep 2020 10:24:01 +0100
From: Will Deacon <will@kernel.org>
To: David Brazdil <dbrazdil@google.com>
Subject: Re: [PATCH v3 06/11] kvm: arm64: Add helpers for accessing nVHE hyp
 per-cpu vars
Message-ID: <20200918092400.GF30834@willie-the-truck>
References: <20200916173439.32265-1-dbrazdil@google.com>
 <20200916173439.32265-7-dbrazdil@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200916173439.32265-7-dbrazdil@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Marc Zyngier <maz@kernel.org>,
 Tejun Heo <tj@kernel.org>, Dennis Zhou <dennis@kernel.org>,
 Christoph Lameter <cl@linux.com>, kernel-team@android.com,
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

On Wed, Sep 16, 2020 at 06:34:34PM +0100, David Brazdil wrote:
> Defining a per-CPU variable in hyp/nvhe will result in its name being
> prefixed with __kvm_nvhe_. Add helpers for declaring these variables
> in kernel proper and accessing them with this_cpu_ptr and per_cpu_ptr.
> 
> Signed-off-by: David Brazdil <dbrazdil@google.com>
> ---
>  arch/arm64/include/asm/kvm_asm.h | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> index cf9456663289..abc03f386b40 100644
> --- a/arch/arm64/include/asm/kvm_asm.h
> +++ b/arch/arm64/include/asm/kvm_asm.h
> @@ -54,9 +54,21 @@
>  	DECLARE_KVM_VHE_SYM(sym);		\
>  	DECLARE_KVM_NVHE_SYM(sym)
>  
> +#define DECLARE_KVM_VHE_PER_CPU(type, sym)	\
> +	DECLARE_PER_CPU(type, sym)
> +#define DECLARE_KVM_NVHE_PER_CPU(type, sym)	\
> +	DECLARE_PER_CPU(type, kvm_nvhe_sym(sym))
> +
> +#define DECLARE_KVM_HYP_PER_CPU(type, sym)	\
> +	DECLARE_KVM_VHE_PER_CPU(type, sym);	\
> +	DECLARE_KVM_NVHE_PER_CPU(type, sym)
> +
>  #define CHOOSE_VHE_SYM(sym)	sym
>  #define CHOOSE_NVHE_SYM(sym)	kvm_nvhe_sym(sym)
>  
> +#define this_cpu_ptr_nvhe(sym)		this_cpu_ptr(&kvm_nvhe_sym(sym))
> +#define per_cpu_ptr_nvhe(sym, cpu)	per_cpu_ptr(&kvm_nvhe_sym(sym), cpu)

nit: I'd probably stick a _sym suffix on these macros, to make it clear
that they're just munging the symbol name rather than doing some completely
different pcpu implementation.

THat said, do you expect these to be used outside of the pcpu
implementation? If not, I suggest some underscores as a prefix as well.

>  #ifndef __KVM_NVHE_HYPERVISOR__
>  /*
>   * BIG FAT WARNINGS:
> @@ -69,12 +81,21 @@
>   * - Don't let the nVHE hypervisor have access to this, as it will
>   *   pick the *wrong* symbol (yes, it runs at EL2...).
>   */
> -#define CHOOSE_HYP_SYM(sym)	(is_kernel_in_hyp_mode() ? CHOOSE_VHE_SYM(sym) \
> +#define CHOOSE_HYP_SYM(sym)		(is_kernel_in_hyp_mode()	\
> +					   ? CHOOSE_VHE_SYM(sym)	\
>  					   : CHOOSE_NVHE_SYM(sym))
> +#define this_cpu_ptr_hyp(sym)		(is_kernel_in_hyp_mode()	\
> +					   ? this_cpu_ptr(&sym)		\
> +					   : this_cpu_ptr_nvhe(sym))
> +#define per_cpu_ptr_hyp(sym, cpu)	(is_kernel_in_hyp_mode()	\
> +					   ? per_cpu_ptr(&sym, cpu)	\
> +					   : per_cpu_ptr_nvhe(sym, cpu))

is_kernel_in_hyp_mode() reads a system register to determine the current
exception level, so this doesn't seem like something we should be doing
everytime here. Perhaps is_kernel_in_hyp_mode() should avoid read_sysreg()
and instead use a non-volatile asm to allow the result to be cached by
the compiler. Hmm.

But I think that can be tackled as a future patch, so with the naming nits
resolved:

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
