Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A346429B384
	for <lists+kvmarm@lfdr.de>; Tue, 27 Oct 2020 15:56:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1D2BA4B4FA;
	Tue, 27 Oct 2020 10:56:17 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YRUytbtgzpGg; Tue, 27 Oct 2020 10:56:17 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DD39D4B4EA;
	Tue, 27 Oct 2020 10:56:15 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 490A24B49C
 for <kvmarm@lists.cs.columbia.edu>; Tue, 27 Oct 2020 10:56:15 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0bLmEfbz5iR2 for <kvmarm@lists.cs.columbia.edu>;
 Tue, 27 Oct 2020 10:56:14 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1C6084B3EB
 for <kvmarm@lists.cs.columbia.edu>; Tue, 27 Oct 2020 10:56:13 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22AE913D5;
 Tue, 27 Oct 2020 07:56:13 -0700 (PDT)
Received: from [172.16.1.113] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 91B7D3F719;
 Tue, 27 Oct 2020 07:56:11 -0700 (PDT)
Subject: Re: [PATCH 04/11] KVM: arm64: Move PC rollback on SError to HYP
To: Marc Zyngier <maz@kernel.org>
References: <20201026133450.73304-1-maz@kernel.org>
 <20201026133450.73304-5-maz@kernel.org>
From: James Morse <james.morse@arm.com>
Message-ID: <e2487f06-3f2f-1a0b-49d8-a72ea9288bb2@arm.com>
Date: Tue, 27 Oct 2020 14:56:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201026133450.73304-5-maz@kernel.org>
Content-Language: en-GB
Cc: linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
 kernel-team@android.com, Will Deacon <will@kernel.org>,
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

Hi Marc,

On 26/10/2020 13:34, Marc Zyngier wrote:
> Instead of handling the "PC rollback on SError during HVC" at EL1 (which
> requires disclosing PC to a potentially untrusted kernel), let's move
> this fixup to ... fixup_guest_exit(), which is where we do all fixups.

> diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
> index d687e574cde5..668f02c7b0b3 100644
> --- a/arch/arm64/kvm/hyp/include/hyp/switch.h
> +++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
> @@ -411,6 +411,21 @@ static inline bool fixup_guest_exit(struct kvm_vcpu *vcpu, u64 *exit_code)
>  	if (ARM_EXCEPTION_CODE(*exit_code) != ARM_EXCEPTION_IRQ)
>  		vcpu->arch.fault.esr_el2 = read_sysreg_el2(SYS_ESR);
>  
> +	if (ARM_SERROR_PENDING(*exit_code)) {
> +		u8 esr_ec = kvm_vcpu_trap_get_class(vcpu);
> +
> +		/*
> +		 * HVC already have an adjusted PC, which we need to
> +		 * correct in order to return to after having injected
> +		 * the SError.
> +		 *
> +		 * SMC, on the other hand, is *trapped*, meaning its
> +		 * preferred return address is the SMC itself.
> +		 */
> +		if (esr_ec == ESR_ELx_EC_HVC32 || esr_ec == ESR_ELx_EC_HVC64)
> +			*vcpu_pc(vcpu) -= 4;

Isn't *vcpu_pc(vcpu) the PC of the previous entry for this vcpu?.... its not the PC of the
exit until __sysreg_save_el2_return_state() saves it, which happens just after
fixup_guest_exit().

Mess with ELR_EL2 directly?


Thanks,

James

> +	}
> +
>  	/*
>  	 * We're using the raw exception code in order to only process
>  	 * the trap if no SError is pending. We will come back to the
> 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
