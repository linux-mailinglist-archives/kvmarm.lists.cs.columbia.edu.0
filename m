Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id CDD0C1C5439
	for <lists+kvmarm@lfdr.de>; Tue,  5 May 2020 13:16:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 610444B31A;
	Tue,  5 May 2020 07:16:34 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 43vpKNi0Qz-j; Tue,  5 May 2020 07:16:34 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1F0AE4B31C;
	Tue,  5 May 2020 07:16:33 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 189944B318
 for <kvmarm@lists.cs.columbia.edu>; Tue,  5 May 2020 07:16:32 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DyCfMao-WN3E for <kvmarm@lists.cs.columbia.edu>;
 Tue,  5 May 2020 07:16:30 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C72F64B315
 for <kvmarm@lists.cs.columbia.edu>; Tue,  5 May 2020 07:16:30 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3BD6530E;
 Tue,  5 May 2020 04:16:30 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.25.241])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 11C4A3F305;
 Tue,  5 May 2020 04:16:27 -0700 (PDT)
Date: Tue, 5 May 2020 12:16:07 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH V3 04/16] arm64/cpufeature: Introduce ID_PFR2 CPU register
Message-ID: <20200505111607.GA82823@C02TD0UTHF1T.local>
References: <1588426445-24344-1-git-send-email-anshuman.khandual@arm.com>
 <1588426445-24344-5-git-send-email-anshuman.khandual@arm.com>
 <20200505111241.GF19710@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200505111241.GF19710@willie-the-truck>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, linux-kernel@vger.kernel.org,
 Marc Zyngier <maz@kernel.org>, kvmarm@lists.cs.columbia.edu,
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

On Tue, May 05, 2020 at 12:12:41PM +0100, Will Deacon wrote:
> On Sat, May 02, 2020 at 07:03:53PM +0530, Anshuman Khandual wrote:
> > This adds basic building blocks required for ID_PFR2 CPU register which
> > provides information about the AArch32 programmers model which must be
> > interpreted along with ID_PFR0 and ID_PFR1 CPU registers. This is added
> > per ARM DDI 0487F.a specification.
> > 
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: James Morse <james.morse@arm.com>
> > Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> > Cc: kvmarm@lists.cs.columbia.edu
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > 
> > Suggested-by: Mark Rutland <mark.rutland@arm.com>
> > Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > ---
> >  arch/arm64/include/asm/cpu.h    |  1 +
> >  arch/arm64/include/asm/sysreg.h |  4 ++++
> >  arch/arm64/kernel/cpufeature.c  | 11 +++++++++++
> >  arch/arm64/kernel/cpuinfo.c     |  1 +
> >  arch/arm64/kvm/sys_regs.c       |  2 +-
> >  5 files changed, 18 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
> > index b4a40535a3d8..464e828a994d 100644
> > --- a/arch/arm64/include/asm/cpu.h
> > +++ b/arch/arm64/include/asm/cpu.h
> > @@ -46,6 +46,7 @@ struct cpuinfo_arm64 {
> >  	u32		reg_id_mmfr3;
> >  	u32		reg_id_pfr0;
> >  	u32		reg_id_pfr1;
> > +	u32		reg_id_pfr2;
> >  
> >  	u32		reg_mvfr0;
> >  	u32		reg_mvfr1;
> > diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> > index e5317a6367b6..c977449e02db 100644
> > --- a/arch/arm64/include/asm/sysreg.h
> > +++ b/arch/arm64/include/asm/sysreg.h
> > @@ -153,6 +153,7 @@
> >  #define SYS_MVFR0_EL1			sys_reg(3, 0, 0, 3, 0)
> >  #define SYS_MVFR1_EL1			sys_reg(3, 0, 0, 3, 1)
> >  #define SYS_MVFR2_EL1			sys_reg(3, 0, 0, 3, 2)
> > +#define SYS_ID_PFR2_EL1			sys_reg(3, 0, 0, 3, 4)
> 
> nit: but please group these defines by name rather than encoding.

So far we've *always* grouped these by encoding in this file, so can we
keep things that way for now? Otherwise we're inconsistent with both
schemes.

Mark.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
