Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 21FAE39BAAE
	for <lists+kvmarm@lfdr.de>; Fri,  4 Jun 2021 16:09:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A6D6C4B0F6;
	Fri,  4 Jun 2021 10:09:27 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2hcPr62W3IwB; Fri,  4 Jun 2021 10:09:27 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C13FE4B0F8;
	Fri,  4 Jun 2021 10:09:22 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9F0A24B0EB
 for <kvmarm@lists.cs.columbia.edu>; Fri,  4 Jun 2021 10:09:21 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nFvSd6xnC3oT for <kvmarm@lists.cs.columbia.edu>;
 Fri,  4 Jun 2021 10:09:16 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 53AF54B09E
 for <kvmarm@lists.cs.columbia.edu>; Fri,  4 Jun 2021 10:09:16 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6678B2B;
 Fri,  4 Jun 2021 07:09:15 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.6.137])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CE513F774;
 Fri,  4 Jun 2021 07:09:12 -0700 (PDT)
Date: Fri, 4 Jun 2021 15:09:09 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH 2/4] KVM: arm64: Extend comment in has_vhe()
Message-ID: <20210604140909.GB69333@C02TD0UTHF1T.local>
References: <20210603183347.1695-1-will@kernel.org>
 <20210603183347.1695-3-will@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210603183347.1695-3-will@kernel.org>
Cc: kvm@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvmarm@lists.cs.columbia.edu
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

On Thu, Jun 03, 2021 at 07:33:45PM +0100, Will Deacon wrote:
> has_vhe() expands to a compile-time constant when evaluated from the VHE
> or nVHE code, alternatively checking a static key when called from
> elsewhere in the kernel. On face value, this looks like a case of
> premature optimization, but in fact this allows symbol references on
> VHE-specific code paths to be dropped from the nVHE object.
> 
> Expand the comment in has_vhe() to make this clearer, hopefully
> discouraging anybody from simplifying the code.
> 
> Cc: David Brazdil <dbrazdil@google.com>
> Signed-off-by: Will Deacon <will@kernel.org>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/include/asm/virt.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
> index 7379f35ae2c6..3218ca17f819 100644
> --- a/arch/arm64/include/asm/virt.h
> +++ b/arch/arm64/include/asm/virt.h
> @@ -111,6 +111,9 @@ static __always_inline bool has_vhe(void)
>  	/*
>  	 * Code only run in VHE/NVHE hyp context can assume VHE is present or
>  	 * absent. Otherwise fall back to caps.
> +	 * This allows the compiler to discard VHE-specific code from the
> +	 * nVHE object, reducing the number of external symbol references
> +	 * needed to link.
>  	 */
>  	if (is_vhe_hyp_code())
>  		return true;
> -- 
> 2.32.0.rc0.204.g9fa02ecfa5-goog
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
