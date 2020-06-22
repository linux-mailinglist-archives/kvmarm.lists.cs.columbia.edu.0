Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 797592032D0
	for <lists+kvmarm@lfdr.de>; Mon, 22 Jun 2020 11:05:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E90464B0CA;
	Mon, 22 Jun 2020 05:05:12 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AT9+SQP4oith; Mon, 22 Jun 2020 05:05:12 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A96674B0C1;
	Mon, 22 Jun 2020 05:05:11 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 451CC4B0BD
 for <kvmarm@lists.cs.columbia.edu>; Mon, 22 Jun 2020 05:05:10 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1kEtqAdNrWfh for <kvmarm@lists.cs.columbia.edu>;
 Mon, 22 Jun 2020 05:05:09 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1D1794A4E1
 for <kvmarm@lists.cs.columbia.edu>; Mon, 22 Jun 2020 05:05:09 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E1311FB;
 Mon, 22 Jun 2020 02:05:08 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.15.132])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 70AF23F6CF;
 Mon, 22 Jun 2020 02:05:06 -0700 (PDT)
Date: Mon, 22 Jun 2020 10:04:59 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2 1/5] KVM: arm64: Enable Address Authentication at EL2
 if available
Message-ID: <20200622090459.GA88608@C02TD0UTHF1T.local>
References: <20200622080643.171651-1-maz@kernel.org>
 <20200622080643.171651-2-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200622080643.171651-2-maz@kernel.org>
Cc: kvm@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>,
 linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
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

On Mon, Jun 22, 2020 at 09:06:39AM +0100, Marc Zyngier wrote:
> While initializing EL2, enable Address Authentication if detected
> from EL1. We still use the EL1-provided keys though.
> 
> Acked-by: Andrew Scull <ascull@google.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/kvm/hyp-init.S | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/kvm/hyp-init.S b/arch/arm64/kvm/hyp-init.S
> index 6e6ed5581eed..1587d146726a 100644
> --- a/arch/arm64/kvm/hyp-init.S
> +++ b/arch/arm64/kvm/hyp-init.S
> @@ -104,6 +104,11 @@ alternative_else_nop_endif
>  	 */
>  	mov_q	x4, (SCTLR_EL2_RES1 | (SCTLR_ELx_FLAGS & ~SCTLR_ELx_A))
>  CPU_BE(	orr	x4, x4, #SCTLR_ELx_EE)
> +alternative_if ARM64_HAS_ADDRESS_AUTH
> +	mov_q	x5, (SCTLR_ELx_ENIA | SCTLR_ELx_ENIB | \
> +		     SCTLR_ELx_ENDA | SCTLR_ELx_ENDB)
> +	orr	x4, x4, x5
> +alternative_else_nop_endif
>  	msr	sctlr_el2, x4
>  	isb
>  
> -- 
> 2.27.0
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
