Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5384F1F948B
	for <lists+kvmarm@lfdr.de>; Mon, 15 Jun 2020 12:25:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D206B4B0D9;
	Mon, 15 Jun 2020 06:25:37 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4wNjyIP+Ohkr; Mon, 15 Jun 2020 06:25:37 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id ADAF64B0BB;
	Mon, 15 Jun 2020 06:25:36 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9A2E14B0A0
 for <kvmarm@lists.cs.columbia.edu>; Mon, 15 Jun 2020 06:25:34 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F-dxBjj2nR95 for <kvmarm@lists.cs.columbia.edu>;
 Mon, 15 Jun 2020 06:25:33 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 67BEA4B097
 for <kvmarm@lists.cs.columbia.edu>; Mon, 15 Jun 2020 06:25:33 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 092D81F1;
 Mon, 15 Jun 2020 03:25:33 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.7.221])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 15F323F71F;
 Mon, 15 Jun 2020 03:25:31 -0700 (PDT)
Date: Mon, 15 Jun 2020 11:25:29 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 4/4] KVM: arm64: Check HCR_EL2 instead of shadow copy to
 swap PtrAuth registers
Message-ID: <20200615102529.GD773@C02TD0UTHF1T.local>
References: <20200615081954.6233-1-maz@kernel.org>
 <20200615081954.6233-5-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200615081954.6233-5-maz@kernel.org>
Cc: kernel-team@android.com, linux-arm-kernel@lists.infradead.org,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu
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

On Mon, Jun 15, 2020 at 09:19:54AM +0100, Marc Zyngier wrote:
> When save/restoring PtrAuth registers between host and guest, it is
> pretty useless to fetch the in-memory state, while we have the right
> state in the HCR_EL2 system register. Use that instead.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>

It took me a while to spot that we switched the guest/host hcr_el2 value
in the __activate_traps() and __deactivate_traps() paths, but given that
this is only called in the __kvm_vcpu_run_*() paths called between
those, I agree this is sound. Given that:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/include/asm/kvm_ptrauth.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_ptrauth.h b/arch/arm64/include/asm/kvm_ptrauth.h
> index 6301813dcace..f1830173fa9e 100644
> --- a/arch/arm64/include/asm/kvm_ptrauth.h
> +++ b/arch/arm64/include/asm/kvm_ptrauth.h
> @@ -74,7 +74,7 @@ alternative_if_not ARM64_HAS_ADDRESS_AUTH_IMP_DEF
>  	b	1001f
>  alternative_else_nop_endif
>  1000:
> -	ldr	\reg1, [\g_ctxt, #(VCPU_HCR_EL2 - VCPU_CONTEXT)]
> +	mrs	\reg1, hcr_el2
>  	and	\reg1, \reg1, #(HCR_API | HCR_APK)
>  	cbz	\reg1, 1001f
>  	add	\reg1, \g_ctxt, #CPU_APIAKEYLO_EL1
> @@ -90,7 +90,7 @@ alternative_if_not ARM64_HAS_ADDRESS_AUTH_IMP_DEF
>  	b	2001f
>  alternative_else_nop_endif
>  2000:
> -	ldr	\reg1, [\g_ctxt, #(VCPU_HCR_EL2 - VCPU_CONTEXT)]
> +	mrs	\reg1, hcr_el2
>  	and	\reg1, \reg1, #(HCR_API | HCR_APK)
>  	cbz	\reg1, 2001f
>  	add	\reg1, \g_ctxt, #CPU_APIAKEYLO_EL1
> -- 
> 2.27.0
> 
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
