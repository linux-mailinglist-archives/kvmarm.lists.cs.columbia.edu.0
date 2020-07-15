Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 87499220DD4
	for <lists+kvmarm@lfdr.de>; Wed, 15 Jul 2020 15:16:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C97794B33F;
	Wed, 15 Jul 2020 09:16:40 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2TozJM7jaD8k; Wed, 15 Jul 2020 09:16:40 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9575E4B33A;
	Wed, 15 Jul 2020 09:16:39 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 502B94B308
 for <kvmarm@lists.cs.columbia.edu>; Wed, 15 Jul 2020 09:16:38 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1EtxhOCOkge5 for <kvmarm@lists.cs.columbia.edu>;
 Wed, 15 Jul 2020 09:16:37 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 227D04B304
 for <kvmarm@lists.cs.columbia.edu>; Wed, 15 Jul 2020 09:16:37 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 961BD31B;
 Wed, 15 Jul 2020 06:16:36 -0700 (PDT)
Received: from [192.168.0.57] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C3BBB3F66E;
 Wed, 15 Jul 2020 06:16:35 -0700 (PDT)
Subject: Re: [PATCH] KVM: arm64: Avoid rewinding the PC for trapped SMCs
To: Andrew Scull <ascull@google.com>, maz@kernel.org
References: <20200714094520.3313396-1-ascull@google.com>
From: James Morse <james.morse@arm.com>
Message-ID: <1c4cbd53-e035-1b7b-e062-80d594b8bd08@arm.com>
Date: Wed, 15 Jul 2020 14:16:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200714094520.3313396-1-ascull@google.com>
Content-Language: en-GB
Cc: kernel-team@android.com, kvmarm@lists.cs.columbia.edu
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

Hi Andrew,

On 14/07/2020 10:45, Andrew Scull wrote:
> When handling a guest's SError that was identified in __guest_exit, it
> is injected back into the guest at the instruction that caused the
> switch into hyp. A trapped SMC does not advance the PC so no adjustment
> needs to be made to the PC.

Oops!

Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James


> Fixes: ddb3d07cfe90 ("arm64: KVM: Inject a Virtual SError if it was pending")
> Signed-off-by: Andrew Scull <ascull@google.com>
> ---
>  arch/arm64/kvm/handle_exit.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
> index 98ab33139982..7d9e198ebdf2 100644
> --- a/arch/arm64/kvm/handle_exit.c
> +++ b/arch/arm64/kvm/handle_exit.c
> @@ -244,12 +244,11 @@ int handle_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
>  		u8 esr_ec = ESR_ELx_EC(kvm_vcpu_get_esr(vcpu));
>  
>  		/*
> -		 * HVC/SMC already have an adjusted PC, which we need
> +		 * HVC already has an adjusted PC, which we need
>  		 * to correct in order to return to after having
>  		 * injected the SError.
>  		 */
> -		if (esr_ec == ESR_ELx_EC_HVC32 || esr_ec == ESR_ELx_EC_HVC64 ||
> -		    esr_ec == ESR_ELx_EC_SMC32 || esr_ec == ESR_ELx_EC_SMC64) {
> +		if (esr_ec == ESR_ELx_EC_HVC32 || esr_ec == ESR_ELx_EC_HVC64) {
>  			u32 adj =  kvm_vcpu_trap_il_is32bit(vcpu) ? 4 : 2;
>  			*vcpu_pc(vcpu) -= adj;
>  		}
> 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
