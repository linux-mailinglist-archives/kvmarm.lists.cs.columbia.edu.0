Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA883591F
	for <lists+kvmarm@lfdr.de>; Wed,  5 Jun 2019 10:59:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1F13F4A4A3;
	Wed,  5 Jun 2019 04:59:08 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c8uAmrTZBkZE; Wed,  5 Jun 2019 04:59:08 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B1C314A409;
	Wed,  5 Jun 2019 04:59:06 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EBE3E4A3B4
 for <kvmarm@lists.cs.columbia.edu>; Wed,  5 Jun 2019 04:59:05 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rS0-nONXXL25 for <kvmarm@lists.cs.columbia.edu>;
 Wed,  5 Jun 2019 04:59:04 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9B3224A389
 for <kvmarm@lists.cs.columbia.edu>; Wed,  5 Jun 2019 04:59:04 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63AAFA78;
 Wed,  5 Jun 2019 01:59:03 -0700 (PDT)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E3ED3F690;
 Wed,  5 Jun 2019 01:59:02 -0700 (PDT)
Subject: Re: [PATCH v1 1/6] KVM: arm64: Abstract the size of the HYP vectors
 pre-amble
To: James Morse <james.morse@arm.com>, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu
References: <20190604144551.188107-1-james.morse@arm.com>
 <20190604144551.188107-2-james.morse@arm.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <34170392-528f-b57c-e50c-16eac02a5043@arm.com>
Date: Wed, 5 Jun 2019 09:58:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190604144551.188107-2-james.morse@arm.com>
Content-Language: en-US
Cc: Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
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

Hi James,

On 04/06/2019 15:45, James Morse wrote:
> The EL2 vector hardening feature causes KVM to generate vectors for
> each type of CPU present in the system. The generated sequences already
> do some of the early guest-exit work (i.e. saving registers). To avoid
> duplication the generated vectors branch to the original vector just
> after the preamble. This size is hard coded.
> 
> Adding new instructions to the HYP vector causes strange side effects,
> which are difficult to debug as the affected code is patched in at
> runtime.
> 
> Add KVM_VECTOR_PREAMBLE to tell kvm_patch_vector_branch() how big
> the preamble is. The valid_vect macro can then validate this at
> build time.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/arm64/include/asm/kvm_asm.h |  6 ++++++
>  arch/arm64/kvm/hyp/hyp-entry.S   | 10 +++++++++-
>  arch/arm64/kvm/va_layout.c       |  7 +++----
>  3 files changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> index ff73f5462aca..9170c43b332f 100644
> --- a/arch/arm64/include/asm/kvm_asm.h
> +++ b/arch/arm64/include/asm/kvm_asm.h
> @@ -41,6 +41,12 @@
>  	{ARM_EXCEPTION_TRAP, 		"TRAP"		},	\
>  	{ARM_EXCEPTION_HYP_GONE,	"HYP_GONE"	}
>  
> +/*
> + * Size of the HYP vectors preamble. kvm_patch_vector_branch() generates code
> + * that jumps over this.
> + */
> +#define KVM_VECTOR_PREAMBLE	4

Nit: I would use AARCH64_INSN_SIZE instead of 4 for the value if
possible. Makes it clear what the value of the vectore preamble
represent (and if we ad instruction we just multiply).

Otherwise the patch seems a good improvement.

Reviewed-by: Julien Thierry <julien.thierry@arm.com>

Thanks,

-- 
Julien Thierry
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
