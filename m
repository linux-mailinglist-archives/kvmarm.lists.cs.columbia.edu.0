Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D624047A782
	for <lists+kvmarm@lfdr.de>; Mon, 20 Dec 2021 10:56:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 338064B416;
	Mon, 20 Dec 2021 04:56:57 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6SulQyFWGToh; Mon, 20 Dec 2021 04:56:57 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9F7AD4B417;
	Mon, 20 Dec 2021 04:56:55 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D4AE44B410
 for <kvmarm@lists.cs.columbia.edu>; Mon, 20 Dec 2021 04:56:53 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id devepOPplBRb for <kvmarm@lists.cs.columbia.edu>;
 Mon, 20 Dec 2021 04:56:52 -0500 (EST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 7624D4B40F
 for <kvmarm@lists.cs.columbia.edu>; Mon, 20 Dec 2021 04:56:52 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id EDEB0B80E32;
 Mon, 20 Dec 2021 09:56:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89F1AC36AE2;
 Mon, 20 Dec 2021 09:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1639994209;
 bh=hNW52/cQomk8153Nvkt2bQvw/2+OxIdj20bpV1noL10=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=jS0bsY6aPAA4f8eldPtDtGfWe3yOn2aZtt3Gukc2G1PCSpmuxa2sD1vMq0SOWhOYy
 yZiKURf4Q0PMvw3I4Nh+X5opPtGABD4qe3feS2/Q/94xWXwbJ3/q8kYfMp9AnjRpIN
 SCI2RXTgdE55NbGGALq2q4FOYCN9vgkv63bpG3hh0mKnU2V1Qkj8VYR7m2n1cT9JgE
 daB81batBEDjX+W3WamQ+WCYEVklOZDv5DE/kU6V6X8zz0gJYtXetS36fa75akOd2y
 fuOF5yUHWClX4qABN9MZilT1ZWuOEjp6VeuW5g0Hk+Q1Ekw/mw8GAunfId7L3PTN+J
 MxdtfBHsA11Lg==
Received: from cfbb000407.r.cam.camfibre.uk ([185.219.108.64]
 helo=why.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1mzFPT-00DFm0-Cu; Mon, 20 Dec 2021 09:56:47 +0000
Date: Mon, 20 Dec 2021 09:56:46 +0000
Message-ID: <87h7b3wqe9.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
Subject: Re: [PATCH v5 36/69] KVM: arm64: nv: Filter out unsupported features
 from ID regs
In-Reply-To: <e850857c-9cab-8e16-0568-acb513514ae8@os.amperecomputing.com>
References: <20211129200150.351436-1-maz@kernel.org>
 <20211129200150.351436-37-maz@kernel.org>
 <e850857c-9cab-8e16-0568-acb513514ae8@os.amperecomputing.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: gankulkarni@os.amperecomputing.com,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org, andre.przywara@arm.com, christoffer.dall@arm.com,
 jintack@cs.columbia.edu, haibo.xu@linaro.org, james.morse@arm.com,
 suzuki.poulose@arm.com, alexandru.elisei@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, kvm@vger.kernel.org,
 Andre Przywara <andre.przywara@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, kvmarm@lists.cs.columbia.edu,
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

On Mon, 20 Dec 2021 07:26:50 +0000,
Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com> wrote:
> 
> 
> Hi Marc,
> 
> On 30-11-2021 01:31 am, Marc Zyngier wrote:
> > As there is a number of features that we either can't support,
> > or don't want to support right away with NV, let's add some
> > basic filtering so that we don't advertize silly things to the
> > EL2 guest.
> > 
> > Whilst we are at it, avertize ARMv8.4-TTL as well as ARMv8.5-GTG.
> > 
> > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > ---
> >   arch/arm64/include/asm/kvm_nested.h |   6 ++
> >   arch/arm64/kvm/nested.c             | 152 ++++++++++++++++++++++++++++
> >   arch/arm64/kvm/sys_regs.c           |   4 +-
> >   arch/arm64/kvm/sys_regs.h           |   2 +
> >   4 files changed, 163 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/include/asm/kvm_nested.h b/arch/arm64/include/asm/kvm_nested.h
> > index 07c15f51cf86..026ddaad972c 100644
> > --- a/arch/arm64/include/asm/kvm_nested.h
> > +++ b/arch/arm64/include/asm/kvm_nested.h
> > @@ -67,4 +67,10 @@ extern bool __forward_traps(struct kvm_vcpu *vcpu, unsigned int reg,
> >   extern bool forward_traps(struct kvm_vcpu *vcpu, u64 control_bit);
> >   extern bool forward_nv_traps(struct kvm_vcpu *vcpu);
> >   +struct sys_reg_params;
> > +struct sys_reg_desc;
> > +
> > +void access_nested_id_reg(struct kvm_vcpu *v, struct sys_reg_params *p,
> > +			  const struct sys_reg_desc *r);
> > +
> >   #endif /* __ARM64_KVM_NESTED_H */
> > diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
> > index 42a96c8d2adc..19b674983e13 100644
> > --- a/arch/arm64/kvm/nested.c
> > +++ b/arch/arm64/kvm/nested.c
> > @@ -20,6 +20,10 @@
> >   #include <linux/kvm_host.h>
> >     #include <asm/kvm_emulate.h>
> > +#include <asm/kvm_nested.h>
> > +#include <asm/sysreg.h>
> > +
> > +#include "sys_regs.h"
> >     /*
> >    * Inject wfx to the virtual EL2 if this is not from the virtual EL2 and
> > @@ -38,3 +42,151 @@ int handle_wfx_nested(struct kvm_vcpu *vcpu, bool is_wfe)
> >     	return -EINVAL;
> >   }
> > +
> > +/*
> > + * Our emulated CPU doesn't support all the possible features. For the
> > + * sake of simplicity (and probably mental sanity), wipe out a number
> > + * of feature bits we don't intend to support for the time being.
> > + * This list should get updated as new features get added to the NV
> > + * support, and new extension to the architecture.
> > + */
> > +void access_nested_id_reg(struct kvm_vcpu *v, struct sys_reg_params *p,
> > +			  const struct sys_reg_desc *r)
> > +{
> > +	u32 id = sys_reg((u32)r->Op0, (u32)r->Op1,
> > +			 (u32)r->CRn, (u32)r->CRm, (u32)r->Op2);
> > +	u64 val, tmp;
> > +
> > +	if (!nested_virt_in_use(v))
> > +		return;
> > +
> > +	val = p->regval;
> > +
> > +	switch (id) {
> > +	case SYS_ID_AA64ISAR0_EL1:
> > +		/* Support everything but O.S. and Range TLBIs */
> > +		val &= ~(FEATURE(ID_AA64ISAR0_TLB)	|
> > +			 GENMASK_ULL(27, 24)		|
> > +			 GENMASK_ULL(3, 0));
> > +		break;
> > +
> > +	case SYS_ID_AA64ISAR1_EL1:
> > +		/* Support everything but PtrAuth and Spec Invalidation */
> > +		val &= ~(GENMASK_ULL(63, 56)		|
> > +			 FEATURE(ID_AA64ISAR1_SPECRES)	|
> > +			 FEATURE(ID_AA64ISAR1_GPI)	|
> > +			 FEATURE(ID_AA64ISAR1_GPA)	|
> > +			 FEATURE(ID_AA64ISAR1_API)	|
> > +			 FEATURE(ID_AA64ISAR1_APA));
> > +		break;
> > +
> > +	case SYS_ID_AA64PFR0_EL1:
> > +		/* No AMU, MPAM, S-EL2, RAS or SVE */
> > +		val &= ~(GENMASK_ULL(55, 52)		|
> > +			 FEATURE(ID_AA64PFR0_AMU)	|
> > +			 FEATURE(ID_AA64PFR0_MPAM)	|
> > +			 FEATURE(ID_AA64PFR0_SEL2)	|
> > +			 FEATURE(ID_AA64PFR0_RAS)	|
> > +			 FEATURE(ID_AA64PFR0_SVE)	|
> > +			 FEATURE(ID_AA64PFR0_EL3)	|
> > +			 FEATURE(ID_AA64PFR0_EL2));
> > +		/* 64bit EL2/EL3 only */
> > +		val |= FIELD_PREP(FEATURE(ID_AA64PFR0_EL2), 0b0001);
> > +		val |= FIELD_PREP(FEATURE(ID_AA64PFR0_EL3), 0b0001);
> > +		break;
> > +
> > +	case SYS_ID_AA64PFR1_EL1:
> > +		/* Only support SSBS */
> > +		val &= FEATURE(ID_AA64PFR1_SSBS);
> > +		break;
> > +
> > +	case SYS_ID_AA64MMFR0_EL1:
> > +		/* Hide ECV, FGT, ExS, Secure Memory */
> > +		val &= ~(GENMASK_ULL(63, 43)			|
> > +			 FEATURE(ID_AA64MMFR0_TGRAN4_2)		|
> > +			 FEATURE(ID_AA64MMFR0_TGRAN16_2)	|
> > +			 FEATURE(ID_AA64MMFR0_TGRAN64_2)	|
> > +			 FEATURE(ID_AA64MMFR0_SNSMEM));
> > +
> > +		/* Disallow unsupported S2 page sizes */
> > +		switch (PAGE_SIZE) {
> > +		case SZ_64K:
> > +			val |= FIELD_PREP(FEATURE(ID_AA64MMFR0_TGRAN16_2), 0b0001);
> > +			fallthrough;
> > +		case SZ_16K:
> > +			val |= FIELD_PREP(FEATURE(ID_AA64MMFR0_TGRAN4_2), 0b0001);
> > +			fallthrough;
> > +		case SZ_4K:
> > +			/* Support everything */
> > +			break;
> > +		}
> 
> It seems to me that Host hypervisor(L0) has to boot with 4KB page size
> to support all (4, 16 and 64KB) page sizes at L1, any specific reason
> for this restriction?

Well, yes.

If you have a L0 that has booted with (let's say) 64kB page size, how
do you provide S2 mappings with 4kB granularity so that you can
implement the permissions that a L1 guest hypervisor can impose on its
own guest, given that KVM currently mandates S1 and S2 to use the same
page sizes?

You can't. That's why we tell the guest hypervisor how much we
support, and the guest hypervisor can decide to go ahead or not
depending on what it does.

If one day we can support S2 mappings that are smaller than the host
page sizes, then we'll be able to allow to advertise all page sizes.
But I wouldn't hold my breath for this to happen.

> 
> > +		/* Advertize supported S2 page sizes */
> > +		switch (PAGE_SIZE) {
> > +		case SZ_4K:
> > +			val |= FIELD_PREP(FEATURE(ID_AA64MMFR0_TGRAN4_2), 0b0010);
> > +			fallthrough;
> > +		case SZ_16K:
> > +			val |= FIELD_PREP(FEATURE(ID_AA64MMFR0_TGRAN16_2), 0b0010);
> > +			fallthrough;
> > +		case SZ_64K:
> > +			val |= FIELD_PREP(FEATURE(ID_AA64MMFR0_TGRAN64_2), 0b0010);
> > +			break;
> > +		}
> > +		/* Cap PARange to 40bits */
> 
> Any specific reasons for the 40 bit cap?

The only platform this currently runs on is a model, and 1TB of
address space is what it supports. At some point, this will require
userspace involvement to set it up, but we're not quite ready for that
either. And given that there is no HW, the urge for changing this is
extremely limited.

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
