Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 70918494D6C
	for <lists+kvmarm@lfdr.de>; Thu, 20 Jan 2022 12:51:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 852C249E34;
	Thu, 20 Jan 2022 06:51:58 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.801
X-Spam-Level: 
X-Spam-Status: No, score=0.801 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_BLOCKED=0.001,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uxDXjkG-ax2T; Thu, 20 Jan 2022 06:51:58 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EF57A49B07;
	Thu, 20 Jan 2022 06:51:56 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DDC0F43C96
 for <kvmarm@lists.cs.columbia.edu>; Thu, 20 Jan 2022 06:51:55 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I7zgyhkydVlO for <kvmarm@lists.cs.columbia.edu>;
 Thu, 20 Jan 2022 06:51:54 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6F786411D2
 for <kvmarm@lists.cs.columbia.edu>; Thu, 20 Jan 2022 06:51:54 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4741ED1;
 Thu, 20 Jan 2022 03:51:53 -0800 (PST)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA9583F774;
 Thu, 20 Jan 2022 03:51:51 -0800 (PST)
Date: Thu, 20 Jan 2022 11:52:00 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v5 17/69] KVM: arm64: nv: Add non-VHE-EL2->EL1
 translation helpers
Message-ID: <YelM4PNEjbxYkpZ3@monolith.localdoman>
References: <20211129200150.351436-1-maz@kernel.org>
 <20211129200150.351436-18-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211129200150.351436-18-maz@kernel.org>
Cc: kvm@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, kvmarm@lists.cs.columbia.edu,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 kernel-team@android.com, linux-arm-kernel@lists.infradead.org
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

On Mon, Nov 29, 2021 at 08:00:58PM +0000, Marc Zyngier wrote:
> Some EL2 system registers immediately affect the current execution
> of the system, so we need to use their respective EL1 counterparts.
> For this we need to define a mapping between the two. In general,
> this only affects non-VHE guest hypervisors, as VHE system registers
> are compatible with the EL1 counterparts.
> 
> These helpers will get used in subsequent patches.
> 
> Co-developed-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/include/asm/kvm_nested.h | 50 +++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/kvm_nested.h b/arch/arm64/include/asm/kvm_nested.h
> index 1028ac65a897..67a2c0d05233 100644
> --- a/arch/arm64/include/asm/kvm_nested.h
> +++ b/arch/arm64/include/asm/kvm_nested.h
> @@ -2,6 +2,7 @@
>  #ifndef __ARM64_KVM_NESTED_H
>  #define __ARM64_KVM_NESTED_H
>  
> +#include <linux/bitfield.h>
>  #include <linux/kvm_host.h>
>  
>  static inline bool nested_virt_in_use(const struct kvm_vcpu *vcpu)
> @@ -11,4 +12,53 @@ static inline bool nested_virt_in_use(const struct kvm_vcpu *vcpu)
>  		test_bit(KVM_ARM_VCPU_HAS_EL2, vcpu->arch.features));
>  }
>  
> +/* Translation helpers from non-VHE EL2 to EL1 */
> +static inline u64 tcr_el2_ips_to_tcr_el1_ps(u64 tcr_el2)

When E2H = 0, there is no IPS field in TCR_EL2, but there is a PS field.
And for TCR_EL1, there is no PS field, but there is an IPS field. Maybe
tcr_el2_ps_to_tcr_el1_ips() would be more precise, and would also match the
field defines used by the function?

> +{
> +	return (u64)FIELD_GET(TCR_EL2_PS_MASK, tcr_el2) << TCR_IPS_SHIFT;
> +}
> +
> +static inline u64 translate_tcr_el2_to_tcr_el1(u64 tcr)
> +{
> +	return TCR_EPD1_MASK |				/* disable TTBR1_EL1 */
> +	       ((tcr & TCR_EL2_TBI) ? TCR_TBI0 : 0) |
> +	       tcr_el2_ips_to_tcr_el1_ps(tcr) |
> +	       (tcr & TCR_EL2_TG0_MASK) |
> +	       (tcr & TCR_EL2_ORGN0_MASK) |
> +	       (tcr & TCR_EL2_IRGN0_MASK) |
> +	       (tcr & TCR_EL2_T0SZ_MASK);

There are a few fields in TCR_EL2 which have a corresponding field in
TCR_EL1, when E2H = 0: HPD -> HPD0 (hierarchical permissions toggle), HA
and HD (hardware management of dirty bit and access flag), DS (when
FEAT_LPA2), and probably others. Why do we not also translate them? Is it
because we hide the feature they depend on (FEAT_HPDS, FEAT_HAFBDS, etc) in
the guest ID registers? Is it something else?

> +}
> +
> +static inline u64 translate_cptr_el2_to_cpacr_el1(u64 cptr_el2)
> +{
> +	u64 cpacr_el1 = 0;
> +
> +	if (!(cptr_el2 & CPTR_EL2_TFP))
> +		cpacr_el1 |= CPACR_EL1_FPEN;
> +	if (cptr_el2 & CPTR_EL2_TTA)
> +		cpacr_el1 |= CPACR_EL1_TTA;
> +	if (!(cptr_el2 & CPTR_EL2_TZ))
> +		cpacr_el1 |= CPACR_EL1_ZEN;
> +
> +	return cpacr_el1;

Nitpick: it would make comparing against the architecture easier if the
fields were checked in the order they were definied in the architecture. So
first check the TTA bit, then TFP and lastly TZ.

I checked the field definitions for CPTR_EL2 and the above looks correct to
me, as TFP, TTA and TZ were the only fields which affect EL2; I also
checked that the values in CPACR_EL1 are set correctly to mirror the
CPTR_EL2 settings.

> +}
> +
> +static inline u64 translate_sctlr_el2_to_sctlr_el1(u64 sctlr)
> +{
> +	/* Bit 20 is RES1 in SCTLR_EL1, but RES0 in SCTLR_EL2 */
> +	return sctlr | BIT(20);

Bits 8 and 7 in SCTLR_EL2 are RES0 when E2H,TGE != {1,1}, but they are RES1
in SCTLR_EL1 if EL0 is not capable of using AArch32. Shouldn't we also set
them?

Bit 5 in SCTLR_EL2 is RES1 when E2H,TGE != {1,1}, but it is RES0 in
SCTLR_EL1 if EL0 is not capable of using AArch32. Shouldn't we clear it?

> +}
> +
> +static inline u64 translate_ttbr0_el2_to_ttbr0_el1(u64 ttbr0)
> +{
> +	/* Force ASID to 0 (ASID 0 or RES0) */

That got me confused at first, until I realized that the first ASID refers
to the ASID field of the register, and the second ASID to the translation
table property. Might be more helpful if the comment was simply "Clear the
ASID field" or something like that.

> +	return ttbr0 & ~GENMASK_ULL(63, 48);
> +}
> +
> +static inline u64 translate_cnthctl_el2_to_cntkctl_el1(u64 cnthctl)
> +{
> +	return ((FIELD_GET(CNTHCTL_EL1PCTEN | CNTHCTL_EL1PCEN, cnthctl) << 10) |

I don't understand why those two bits are left shifted by 10, the result is
0x3 << 10 and CNTKCTL_EL[16:10] is RES0.

> +		(cnthctl & (CNTHCTL_EVNTI | CNTHCTL_EVNTDIR | CNTHCTL_EVNTEN)));

CNTKCTL_EL1.{EVNTI,EVNTDIR,EVNTEN} refer to CNT*V*CT_EL0,
CNTHCTL_EL2.{EVNTI,EVNTDIR,EVNTEN} refer to CNT*P*CT_EL0. I don't
understand why they are treated as equivalent.

I get the feeling I'm misunderstanding something about this function.

Thanks,
Alex

> +}
> +
>  #endif /* __ARM64_KVM_NESTED_H */
> -- 
> 2.30.2
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
