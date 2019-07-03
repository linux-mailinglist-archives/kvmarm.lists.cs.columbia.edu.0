Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 865BE5E90A
	for <lists+kvmarm@lfdr.de>; Wed,  3 Jul 2019 18:31:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 140E24A522;
	Wed,  3 Jul 2019 12:31:19 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5zNPnEXpxmJa; Wed,  3 Jul 2019 12:31:18 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 96BEC4A51B;
	Wed,  3 Jul 2019 12:31:17 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 233D74A4FF
 for <kvmarm@lists.cs.columbia.edu>; Wed,  3 Jul 2019 12:31:16 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h2yVHl3mMGwQ for <kvmarm@lists.cs.columbia.edu>;
 Wed,  3 Jul 2019 12:31:14 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 818444A4EB
 for <kvmarm@lists.cs.columbia.edu>; Wed,  3 Jul 2019 12:31:14 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2531E344;
 Wed,  3 Jul 2019 09:31:14 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 56F7D3F718;
 Wed,  3 Jul 2019 09:31:13 -0700 (PDT)
Date: Wed, 3 Jul 2019 17:31:11 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH 07/59] KVM: arm64: nv: Add EL2 system registers to vcpu
 context
Message-ID: <20190703163111.GW2790@e103592.cambridge.arm.com>
References: <20190621093843.220980-1-marc.zyngier@arm.com>
 <20190621093843.220980-8-marc.zyngier@arm.com>
 <20190624125416.GQ2790@e103592.cambridge.arm.com>
 <bf624c54-41f6-85d0-e8c1-7943e065ec98@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bf624c54-41f6-85d0-e8c1-7943e065ec98@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: linux-arm-kernel@lists.infradead.org,
 Andre Przywara <andre.przywara@arm.com>, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
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

On Wed, Jul 03, 2019 at 01:20:55PM +0100, Marc Zyngier wrote:
> On 24/06/2019 13:54, Dave Martin wrote:
> > On Fri, Jun 21, 2019 at 10:37:51AM +0100, Marc Zyngier wrote:
> >> From: Jintack Lim <jintack.lim@linaro.org>
> >>
> >> ARM v8.3 introduces a new bit in the HCR_EL2, which is the NV bit. When
> >> this bit is set, accessing EL2 registers in EL1 traps to EL2. In
> >> addition, executing the following instructions in EL1 will trap to EL2:
> >> tlbi, at, eret, and msr/mrs instructions to access SP_EL1. Most of the
> >> instructions that trap to EL2 with the NV bit were undef at EL1 prior to
> >> ARM v8.3. The only instruction that was not undef is eret.
> >>
> >> This patch sets up a handler for EL2 registers and SP_EL1 register
> >> accesses at EL1. The host hypervisor keeps those register values in
> >> memory, and will emulate their behavior.
> >>
> >> This patch doesn't set the NV bit yet. It will be set in a later patch
> >> once nested virtualization support is completed.
> >>
> >> Signed-off-by: Jintack Lim <jintack.lim@linaro.org>
> >> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> >> ---
> >>  arch/arm64/include/asm/kvm_host.h | 37 +++++++++++++++-
> >>  arch/arm64/include/asm/sysreg.h   | 50 ++++++++++++++++++++-
> >>  arch/arm64/kvm/sys_regs.c         | 74 ++++++++++++++++++++++++++++---
> >>  3 files changed, 154 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> >> index 4bcd9c1291d5..2d4290d2513a 100644
> >> --- a/arch/arm64/include/asm/kvm_host.h
> >> +++ b/arch/arm64/include/asm/kvm_host.h
> >> @@ -173,12 +173,47 @@ enum vcpu_sysreg {
> >>  	APGAKEYLO_EL1,
> >>  	APGAKEYHI_EL1,
> >>  
> >> -	/* 32bit specific registers. Keep them at the end of the range */
> >> +	/* 32bit specific registers. */
> > 
> > Out of interest, why did we originally want these to be at the end?
> > Because they're not at the end any more...
> 
> I seem to remember the original assembly switch code used that property.
> This is a long gone requirement, thankfully.

Ah, right.

> >>  	DACR32_EL2,	/* Domain Access Control Register */
> >>  	IFSR32_EL2,	/* Instruction Fault Status Register */
> >>  	FPEXC32_EL2,	/* Floating-Point Exception Control Register */
> >>  	DBGVCR32_EL2,	/* Debug Vector Catch Register */
> >>  
> >> +	/* EL2 registers sorted ascending by Op0, Op1, CRn, CRm, Op2 */
> >> +	FIRST_EL2_SYSREG,
> >> +	VPIDR_EL2 = FIRST_EL2_SYSREG,
> >> +			/* Virtualization Processor ID Register */
> >> +	VMPIDR_EL2,	/* Virtualization Multiprocessor ID Register */
> >> +	SCTLR_EL2,	/* System Control Register (EL2) */
> >> +	ACTLR_EL2,	/* Auxiliary Control Register (EL2) */
> >> +	HCR_EL2,	/* Hypervisor Configuration Register */
> >> +	MDCR_EL2,	/* Monitor Debug Configuration Register (EL2) */
> >> +	CPTR_EL2,	/* Architectural Feature Trap Register (EL2) */
> >> +	HSTR_EL2,	/* Hypervisor System Trap Register */
> >> +	HACR_EL2,	/* Hypervisor Auxiliary Control Register */
> >> +	TTBR0_EL2,	/* Translation Table Base Register 0 (EL2) */
> >> +	TTBR1_EL2,	/* Translation Table Base Register 1 (EL2) */
> >> +	TCR_EL2,	/* Translation Control Register (EL2) */
> >> +	VTTBR_EL2,	/* Virtualization Translation Table Base Register */
> >> +	VTCR_EL2,	/* Virtualization Translation Control Register */
> >> +	SPSR_EL2,	/* EL2 saved program status register */
> >> +	ELR_EL2,	/* EL2 exception link register */
> >> +	AFSR0_EL2,	/* Auxiliary Fault Status Register 0 (EL2) */
> >> +	AFSR1_EL2,	/* Auxiliary Fault Status Register 1 (EL2) */
> >> +	ESR_EL2,	/* Exception Syndrome Register (EL2) */
> >> +	FAR_EL2,	/* Hypervisor IPA Fault Address Register */
> >> +	HPFAR_EL2,	/* Hypervisor IPA Fault Address Register */
> >> +	MAIR_EL2,	/* Memory Attribute Indirection Register (EL2) */
> >> +	AMAIR_EL2,	/* Auxiliary Memory Attribute Indirection Register (EL2) */
> >> +	VBAR_EL2,	/* Vector Base Address Register (EL2) */
> >> +	RVBAR_EL2,	/* Reset Vector Base Address Register */
> >> +	RMR_EL2,	/* Reset Management Register */
> >> +	CONTEXTIDR_EL2,	/* Context ID Register (EL2) */
> >> +	TPIDR_EL2,	/* EL2 Software Thread ID Register */
> >> +	CNTVOFF_EL2,	/* Counter-timer Virtual Offset register */
> >> +	CNTHCTL_EL2,	/* Counter-timer Hypervisor Control register */
> >> +	SP_EL2,		/* EL2 Stack Pointer */
> >> +
> > 
> > I wonder whether we could make these conditionally present somehow.  Not
> > worth worrying about for now to save 200-odd bytes per vcpu though.
> 
> With 8.4-NV, these 200 bytes turn into a whole 8kB (4kB page, plus
> almost 4kB of padding that I need to reduce one way or another). So I'm
> not too worried about this for now.
> 
> I really want the NV code to always be present though, in order to avoid
> configuration related regressions. I'm not sure how to make this better.

Fair enough -- sounds like addressing this would probably be premature
optimisation, then.

I suppose we could have two alternate layouts, but would likely be a
source of overhead, and bugs...

Cheers
---Dave
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
