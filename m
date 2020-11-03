Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B13AD2A4EDE
	for <lists+kvmarm@lfdr.de>; Tue,  3 Nov 2020 19:29:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 521C44B2E5;
	Tue,  3 Nov 2020 13:29:36 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KpYLfepWJ-RI; Tue,  3 Nov 2020 13:29:36 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CB5924B5C0;
	Tue,  3 Nov 2020 13:29:34 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A8A304B5AA
 for <kvmarm@lists.cs.columbia.edu>; Tue,  3 Nov 2020 13:29:33 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hbSfWTcWGFZu for <kvmarm@lists.cs.columbia.edu>;
 Tue,  3 Nov 2020 13:29:32 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BCCE54B2F7
 for <kvmarm@lists.cs.columbia.edu>; Tue,  3 Nov 2020 13:29:32 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7272E147A;
 Tue,  3 Nov 2020 10:29:32 -0800 (PST)
Received: from [172.16.1.113] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 619763F718;
 Tue,  3 Nov 2020 10:29:31 -0800 (PST)
Subject: Re: [PATCH 1/8] KVM: arm64: Move AArch32 exceptions over to AArch64
 sysregs
To: Marc Zyngier <maz@kernel.org>
References: <20201102191609.265711-1-maz@kernel.org>
 <20201102191609.265711-2-maz@kernel.org>
From: James Morse <james.morse@arm.com>
Message-ID: <58942c6b-9cf2-a0d7-3ba5-2fc42aeef779@arm.com>
Date: Tue, 3 Nov 2020 18:29:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201102191609.265711-2-maz@kernel.org>
Content-Language: en-GB
Cc: kvm@vger.kernel.org, kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
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

On 02/11/2020 19:16, Marc Zyngier wrote:
> The use of the AArch32-specific accessors have always been a bit
> annoying on 64bit, and it is time for a change.
> 
> Let's move the AArch32 exception injection over to the AArch64 encoding,
> which requires us to split the two halves of FAR_EL1 into DFAR and IFAR.
> This enables us to drop the preempt_disable() games on VHE, and to kill
> the last user of the vcpu_cp15() macro.

Hurrah!


> diff --git a/arch/arm64/kvm/inject_fault.c b/arch/arm64/kvm/inject_fault.c
> index e2a2e48ca371..975f65ba6a8b 100644
> --- a/arch/arm64/kvm/inject_fault.c
> +++ b/arch/arm64/kvm/inject_fault.c
> @@ -100,39 +81,36 @@ static void inject_undef32(struct kvm_vcpu *vcpu)
>   * Modelled after TakeDataAbortException() and TakePrefetchAbortException
>   * pseudocode.
>   */
> -static void inject_abt32(struct kvm_vcpu *vcpu, bool is_pabt,
> -			 unsigned long addr)
> +static void inject_abt32(struct kvm_vcpu *vcpu, bool is_pabt, u32 addr)
>  {
> -	u32 *far, *fsr;
> -	bool is_lpae;
> -	bool loaded;
> +	u64 far;
> +	u32 fsr;


> +	/* Give the guest an IMPLEMENTATION DEFINED exception */
> +	if (__vcpu_sys_reg(vcpu, TCR_EL1) & TTBCR_EAE) {

With VHE, won't __vcpu_sys_reg() read the potentially stale copy in the sys_reg array?

vcpu_read_sys_reg()?


> +		fsr = DFSR_LPAE | DFSR_FSC_EXTABT_LPAE;
> +	} else {
> +		/* no need to shuffle FS[4] into DFSR[10] as its 0 */
> +		fsr = DFSR_FSC_EXTABT_nLPAE;
> +	}
>  
> -	loaded = pre_fault_synchronize(vcpu);
> +	far = vcpu_read_sys_reg(vcpu, FAR_EL1);


Thanks,

James
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
