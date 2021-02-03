Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id F079030E4C5
	for <lists+kvmarm@lfdr.de>; Wed,  3 Feb 2021 22:13:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4D1CB4B336;
	Wed,  3 Feb 2021 16:13:31 -0500 (EST)
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
	with ESMTP id J1zDz3FoOCZj; Wed,  3 Feb 2021 16:13:31 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1F1164B2D2;
	Wed,  3 Feb 2021 16:13:30 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5D30B4B309
 for <kvmarm@lists.cs.columbia.edu>; Wed,  3 Feb 2021 16:13:28 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KP6IofJwNRsv for <kvmarm@lists.cs.columbia.edu>;
 Wed,  3 Feb 2021 16:13:27 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 32A3C4B31E
 for <kvmarm@lists.cs.columbia.edu>; Wed,  3 Feb 2021 16:13:27 -0500 (EST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E67C64F5F;
 Wed,  3 Feb 2021 21:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612386806;
 bh=VS8yGGa3Q4OSZtI8MdKl0s1r50NHskoTYCo1kYP5p3U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hrMa8Jay8pHUd7P774ypjFN+qs8pzMW+5LMIunYpx8GhSTh22IlURyZWABK4NPWPH
 XZbp7u8J0nYW9OJQR86rxEaoASK4n/w9dSSl/eP6q4DdGRbT83z3UzlunEdodcDxtn
 Yf8RgMT5ZJERTnkAtaWBAk4BUwdAFq0hEFf8r1aEb/hUbIULBZf2FTdmcoN7bWVwxL
 ZPaHTc+AJqa9FjEEUq/px1svUn0Gyiwr4saTl4ymC3wqSqzVl5hdtr4SkXCteL1AFZ
 WlEg6q6aANTkVXmj/l0fesDklhPJd9V8OqZczp+l2PsCzHbu2AWmWVsBlRqrYXB/1A
 sVUPmvKCX7T7A==
Date: Wed, 3 Feb 2021 21:13:19 +0000
From: Will Deacon <will@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v6 06/21] arm64: Move VHE-specific SPE setup to
 mutate_to_vhe()
Message-ID: <20210203211319.GA19694@willie-the-truck>
References: <20210201115637.3123740-1-maz@kernel.org>
 <20210201115637.3123740-7-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210201115637.3123740-7-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Prasad Sodagudi <psodagud@codeaurora.org>,
 Srinivas Ramana <sramana@codeaurora.org>,
 Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org,
 Ard Biesheuvel <ardb@kernel.org>, Ajay Patil <pajay@qti.qualcomm.com>,
 kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
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

Hi Marc,

On Mon, Feb 01, 2021 at 11:56:22AM +0000, Marc Zyngier wrote:
> There isn't much that a VHE kernel needs on top of whatever has
> been done for nVHE, so let's move the little we need to the
> VHE stub (the SPE setup), and drop the init_el2_state macro.
> 
> No expected functional change.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Acked-by: David Brazdil <dbrazdil@google.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm64/kernel/hyp-stub.S | 28 +++++++++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
> index 373ed2213e1d..6b5c73cf9d52 100644
> --- a/arch/arm64/kernel/hyp-stub.S
> +++ b/arch/arm64/kernel/hyp-stub.S
> @@ -92,9 +92,6 @@ SYM_CODE_START_LOCAL(mutate_to_vhe)
>  	msr	hcr_el2, x0
>  	isb
>  
> -	// Doesn't do much on VHE, but still, worth a shot
> -	init_el2_state vhe
> -
>  	// Use the EL1 allocated stack, per-cpu offset
>  	mrs	x0, sp_el1
>  	mov	sp, x0
> @@ -107,6 +104,31 @@ SYM_CODE_START_LOCAL(mutate_to_vhe)
>  	mrs_s	x0, SYS_VBAR_EL12
>  	msr	vbar_el1, x0
>  
> +	// Fixup SPE configuration, if supported...
> +	mrs	x1, id_aa64dfr0_el1
> +	ubfx	x1, x1, #ID_AA64DFR0_PMSVER_SHIFT, #4
> +	mov	x2, xzr
> +	cbz	x1, skip_spe
> +
> +	// ... and not owned by EL3
> +	mrs_s	x0, SYS_PMBIDR_EL1
> +	and	x0, x0, #(1 << SYS_PMBIDR_EL1_P_SHIFT)
> +	cbnz	x0, skip_spe
> +
> +	// Let the SPE driver in control of the sampling
> +	mrs_s	x0, SYS_PMSCR_EL1
> +	bic	x0, x0, #(1 << SYS_PMSCR_EL2_PCT_SHIFT)
> +	bic	x0, x0, #(1 << SYS_PMSCR_EL2_PA_SHIFT)
> +	msr_s	SYS_PMSCR_EL1, x0

Why do we need to touch pmscr_el1 at all? The SPE driver should take care of
that, no? If you drop the pmscr_el1 accesses, I think you can drop the
pmbidr_el1 check as well. And actually, then why even check dfr0? Doing the
bic for the mdcr_el1.e2pb bits is harmless.

> +	mov	x2, #MDCR_EL2_TPMS
> +
> +skip_spe:
> +	// For VHE, use EL2 translation and disable access from EL1
> +	mrs	x0, mdcr_el2
> +	bic	x0, x0, #(MDCR_EL2_E2PB_MASK << MDCR_EL2_E2PB_SHIFT)
> +	orr	x0, x0, x2
> +	msr	mdcr_el2, x0

Doesn't this undo the setting of mdcr_el2.hpmn if SPE is not present or
unavailable? (This wouldn't be an issue if we removed the skip_spe paths
altogether).

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
