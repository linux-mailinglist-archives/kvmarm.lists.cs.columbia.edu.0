Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id CD36241C857
	for <lists+kvmarm@lfdr.de>; Wed, 29 Sep 2021 17:27:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3690C4A7FD;
	Wed, 29 Sep 2021 11:27:38 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ubxxTZhULcbW; Wed, 29 Sep 2021 11:27:38 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0E9454B103;
	Wed, 29 Sep 2021 11:27:37 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id AF5CE4B0A3
 for <kvmarm@lists.cs.columbia.edu>; Wed, 29 Sep 2021 11:27:35 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0JeQdZzbRuNu for <kvmarm@lists.cs.columbia.edu>;
 Wed, 29 Sep 2021 11:27:34 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4B4394A7FD
 for <kvmarm@lists.cs.columbia.edu>; Wed, 29 Sep 2021 11:27:34 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1571101E;
 Wed, 29 Sep 2021 08:27:33 -0700 (PDT)
Received: from [192.168.0.110] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 47C923F793;
 Wed, 29 Sep 2021 08:27:32 -0700 (PDT)
Message-ID: <7fe293a6-16af-929f-33b1-aa89675197b0@arm.com>
Date: Wed, 29 Sep 2021 16:29:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH 1/5] KVM: arm64: Force ID_AA64PFR0_EL1.GIC=1 when exposing
 a virtual GICv3
Content-Language: en-US
To: Marc Zyngier <maz@kernel.org>, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20210924082542.2766170-1-maz@kernel.org>
 <20210924082542.2766170-2-maz@kernel.org>
From: Alexandru Elisei <alexandru.elisei@arm.com>
In-Reply-To: <20210924082542.2766170-2-maz@kernel.org>
Cc: kernel-team@android.com
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

On 9/24/21 09:25, Marc Zyngier wrote:
> Until now, we always let ID_AA64PFR0_EL1.GIC reflect the value
> visible on the host, even if we were running a GICv2-enabled VM
> on a GICv3+compat host.
>
> That's fine, but we also now have the case of a host that does not
> expose ID_AA64PFR0_EL1.GIC==1 despite having a vGIC. Yes, this is
> confusing. Thank you M1.
>
> Let's go back to first principles and expose ID_AA64PFR0_EL1.GIC=1
> when a GICv3 is exposed to the guest. This also hides a GICv4.1
> CPU interface from the guest which has no business knowing about
> the v4.1 extension.

Had a look at the gic-v3 driver, and as far as I can tell it does not check that a
GICv3 is advertised in ID_AA64PFR0_EL1. If I didn't get this wrong, then this
patch is to ensure architectural compliance for a guest even if the hardware is
not necessarily compliant, right?

GICv4.1 is an extension to GICv4 (which itself was an extension to GICv3) to add
support for virtualization features (virtual SGIs), so I don't see any harm in
hiding it from the guest, since the guest cannot virtual SGIs.

Thanks,

Alex

>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/kvm/sys_regs.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 1d46e185f31e..0e8fc29df19c 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -1075,6 +1075,11 @@ static u64 read_id_reg(const struct kvm_vcpu *vcpu,
>  		val |= FIELD_PREP(ARM64_FEATURE_MASK(ID_AA64PFR0_CSV2), (u64)vcpu->kvm->arch.pfr0_csv2);
>  		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR0_CSV3);
>  		val |= FIELD_PREP(ARM64_FEATURE_MASK(ID_AA64PFR0_CSV3), (u64)vcpu->kvm->arch.pfr0_csv3);
> +		if (irqchip_in_kernel(vcpu->kvm) &&
> +		    vcpu->kvm->arch.vgic.vgic_model == KVM_DEV_TYPE_ARM_VGIC_V3) {
> +			val &= ~ARM64_FEATURE_MASK(ID_AA64PFR0_GIC);
> +			val |= FIELD_PREP(ARM64_FEATURE_MASK(ID_AA64PFR0_GIC), 1);
> +		}
>  		break;
>  	case SYS_ID_AA64PFR1_EL1:
>  		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_MTE);
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
