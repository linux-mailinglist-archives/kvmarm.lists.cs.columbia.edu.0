Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 203C92A2FC9
	for <lists+kvmarm@lfdr.de>; Mon,  2 Nov 2020 17:27:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AE3F54B3F6;
	Mon,  2 Nov 2020 11:27:34 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IrCrguM0qLTr; Mon,  2 Nov 2020 11:27:34 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 73DD64B3F5;
	Mon,  2 Nov 2020 11:27:33 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CF5AC4B3EF
 for <kvmarm@lists.cs.columbia.edu>; Mon,  2 Nov 2020 11:27:31 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BNUwIZZJCcOm for <kvmarm@lists.cs.columbia.edu>;
 Mon,  2 Nov 2020 11:27:30 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9E5314B3ED
 for <kvmarm@lists.cs.columbia.edu>; Mon,  2 Nov 2020 11:27:30 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54BC931B;
 Mon,  2 Nov 2020 08:27:30 -0800 (PST)
Received: from [192.168.0.110] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 802183F719;
 Mon,  2 Nov 2020 08:27:29 -0800 (PST)
Subject: Re: [PATCH 8/8] KVM: arm64: Avoid repetitive stack access on host EL1
 to EL2 exception
To: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org
References: <20201026095116.72051-1-maz@kernel.org>
 <20201026095116.72051-9-maz@kernel.org>
From: Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <e4fa81b4-1071-e41c-7cc2-62c8116e28ba@arm.com>
Date: Mon, 2 Nov 2020 16:28:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201026095116.72051-9-maz@kernel.org>
Content-Language: en-US
Cc: Will Deacon <will@kernel.org>, kernel-team@android.com
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

On 10/26/20 9:51 AM, Marc Zyngier wrote:
> Registers x0/x1 get repeateadly pushed and poped during a host
> HVC call. Instead, leave the registers on the stack, saving
> a store instruction on the fast path for an add on the slow path.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/kvm/hyp/nvhe/host.S | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/kvm/hyp/nvhe/host.S b/arch/arm64/kvm/hyp/nvhe/host.S
> index e2d316d13180..7b69f9ff8da0 100644
> --- a/arch/arm64/kvm/hyp/nvhe/host.S
> +++ b/arch/arm64/kvm/hyp/nvhe/host.S
> @@ -13,8 +13,6 @@
>  	.text
>  
>  SYM_FUNC_START(__host_exit)
> -	stp	x0, x1, [sp, #-16]!
> -
>  	get_host_ctxt	x0, x1
>  
>  	/* Store the host regs x2 and x3 */
> @@ -99,13 +97,14 @@ SYM_FUNC_END(__hyp_do_panic)
>  	mrs	x0, esr_el2
>  	lsr	x0, x0, #ESR_ELx_EC_SHIFT
>  	cmp	x0, #ESR_ELx_EC_HVC64
> -	ldp	x0, x1, [sp], #16
> +	ldp	x0, x1, [sp]		// Don't fixup the stack yet

If I understand get_host_ctxt correctly, it will clobber x0 and x1, and this is
the first thing that __host_exit does. I think that the values of x0 and x1 are
only needed in host_el1_sync_vect: x0 to compare with HVC_STUB_HCALL_NR below, and
x1 for the call to __kvm_handle_stub_hvc. I was thinking that we can restore x0
just before the comparison with HVC_STUB_HCALL_NR, after the first branch to
__host_exit, to make it clear that it is not used by __host_exit. Not really
important, but it might make the code a bit easier to understand (it looks a bit
weird to me to have x0, x1 clobbered immediately after we restore them from the
stack).

Either way you prefer, the code looks correct to me: __host_exit assumes that x0
and x1 are at the top of the stack when it saves them, and the ADD in
host_el1_sync_vect (when the code doesn't branch to __host_exit) makes sure the
stack pointer is as expected:

Reviewed-by: Alexandru Elisei <alexandru.elisei@arm.com>

Thanks,

Alex

>  	b.ne	__host_exit
>  
>  	/* Check for a stub HVC call */
>  	cmp	x0, #HVC_STUB_HCALL_NR
>  	b.hs	__host_exit
>  
> +	add	sp, sp, #16
>  	/*
>  	 * Compute the idmap address of __kvm_handle_stub_hvc and
>  	 * jump there. Since we use kimage_voffset, do not use the
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
