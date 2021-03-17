Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 959F133F7A7
	for <lists+kvmarm@lfdr.de>; Wed, 17 Mar 2021 18:57:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2419A4B691;
	Wed, 17 Mar 2021 13:57:45 -0400 (EDT)
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
	with ESMTP id Vlxxy8Ojsx+f; Wed, 17 Mar 2021 13:57:45 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EBEEF4B67B;
	Wed, 17 Mar 2021 13:57:43 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7D9AB4B5A4
 for <kvmarm@lists.cs.columbia.edu>; Wed, 17 Mar 2021 13:57:42 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XXRrxhQO3wTu for <kvmarm@lists.cs.columbia.edu>;
 Wed, 17 Mar 2021 13:57:41 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 8C0554B1FB
 for <kvmarm@lists.cs.columbia.edu>; Wed, 17 Mar 2021 13:57:41 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E07664F0F;
 Wed, 17 Mar 2021 17:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616003860;
 bh=KLrz/zlZvv0deqnTNA4E5YrAwOuKGvg1QIpXtpi+EK0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BY8USoWjrrilAobRONwMs0Nq33hyLtCVksyL4S7NKSyHLT6U/f2Xa3IslxnTdhD07
 cQ6QnOEJlaNLL21vzJ3pgocSZuNvsj0/VKXWFTuJbdUuVVNZcwbDy2KYym4GRIBlfd
 xzMtrcyqT0ww4WtZ8THMiLnJAw2EeMosVV584bglsTQBSZhmiH+VvfwBLw4vLDiTPi
 j7Tws89nEtSJZtqUE6aVbC8hv7gNHKUMJNYECw8+88A7rQr3b260WD1LbSFHT5c9Fq
 rJbLuRDKKRHE78Sv+j2Btar3gYfMyfRuor76510v1pcsX1OUj8+ypsW9OiVlvhjR9N
 PLqFOTfhZhTFQ==
Date: Wed, 17 Mar 2021 17:57:35 +0000
From: Will Deacon <will@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 09/10] KVM: arm64: Save/restore SVE state for nVHE
Message-ID: <20210317175734.GA5713@willie-the-truck>
References: <20210316101312.102925-1-maz@kernel.org>
 <20210316101312.102925-10-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210316101312.102925-10-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 kvmarm@lists.cs.columbia.edu, broonie@kernel.org, kernel-team@android.com,
 dave.martin@arm.com, linux-arm-kernel@lists.infradead.org, daniel.kiss@arm.com
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

On Tue, Mar 16, 2021 at 10:13:11AM +0000, Marc Zyngier wrote:
> Implement the SVE save/restore for nVHE, following a similar
> logic to that of the VHE implementation:
> 
> - the SVE state is switched on trap from EL1 to EL2
> 
> - no further changes to ZCR_EL2 occur as long as the guest isn't
>   preempted or exit to userspace
> 
> - on vcpu_put(), ZCR_EL2 is reset to its default value, and ZCR_EL1
>   restored to the default guest value
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/kvm/fpsimd.c                 | 15 ++++++++--
>  arch/arm64/kvm/hyp/include/hyp/switch.h | 37 +++++++++----------------
>  arch/arm64/kvm/hyp/nvhe/switch.c        |  4 +--
>  3 files changed, 28 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
> index b5f95abd23f5..cc6cdea69596 100644
> --- a/arch/arm64/kvm/fpsimd.c
> +++ b/arch/arm64/kvm/fpsimd.c
> @@ -121,11 +121,22 @@ void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu)
>  	local_irq_save(flags);
>  
>  	if (vcpu->arch.flags & KVM_ARM64_FP_ENABLED) {
> -		if (guest_has_sve)
> +		if (guest_has_sve) {
>  			__vcpu_sys_reg(vcpu, ZCR_EL1) = read_sysreg_el1(SYS_ZCR);
>  
> +			/* Restore the VL that was saved when bound to the CPU */
> +			if (!has_vhe()) {
> +				u64 zcr;
> +
> +				kvm_call_hyp(__kvm_reset_sve_vq);

What would go wrong if we did this unconditionally on return to the host, or
is it just a performance thing to move work off the fast path where we
return back to the same vCPU?

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
