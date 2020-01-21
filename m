Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEE1143C06
	for <lists+kvmarm@lfdr.de>; Tue, 21 Jan 2020 12:28:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EBC114AFAA;
	Tue, 21 Jan 2020 06:28:33 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.099
X-Spam-Level: 
X-Spam-Status: No, score=0.099 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_LOW=-0.7]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EmUfyw98V4Hj; Tue, 21 Jan 2020 06:28:33 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 98A504AFF5;
	Tue, 21 Jan 2020 06:28:32 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BD8E14AFE7
 for <kvmarm@lists.cs.columbia.edu>; Tue, 21 Jan 2020 06:28:30 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u6CQgRkwf6Hu for <kvmarm@lists.cs.columbia.edu>;
 Tue, 21 Jan 2020 06:28:25 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6A62A4AFD0
 for <kvmarm@lists.cs.columbia.edu>; Tue, 21 Jan 2020 06:28:25 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00AD01FB;
 Tue, 21 Jan 2020 03:28:25 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 684913F6C4;
 Tue, 21 Jan 2020 03:28:24 -0800 (PST)
Date: Tue, 21 Jan 2020 11:28:22 +0000
From: Andrew Murray <andrew.murray@arm.com>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 2/3] KVM: arm64: limit PMU version to ARMv8.4
Message-ID: <20200121112822.GC5109@e119886-lin.cambridge.arm.com>
References: <20200102123905.29360-1-andrew.murray@arm.com>
 <20200102123905.29360-3-andrew.murray@arm.com>
 <20200120174432.GA23090@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200120174432.GA23090@willie-the-truck>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Cc: Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

On Mon, Jan 20, 2020 at 05:44:33PM +0000, Will Deacon wrote:
> On Thu, Jan 02, 2020 at 12:39:04PM +0000, Andrew Murray wrote:
> > ARMv8.5-PMU introduces 64-bit event counters, however KVM doesn't yet
> > support this. Let's trap the Debug Feature Registers in order to limit
> > PMUVer/PerfMon in the Debug Feature Registers to PMUv3 for ARMv8.4.
> > 
> > Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> > Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > ---
> >  arch/arm64/include/asm/sysreg.h |  4 ++++
> >  arch/arm64/kvm/sys_regs.c       | 36 +++++++++++++++++++++++++++++++--
> >  2 files changed, 38 insertions(+), 2 deletions(-)
> 
> I'll need an ack from the kvm side for this.
> 
> > diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> > index 6e919fafb43d..1b74f275a115 100644
> > --- a/arch/arm64/include/asm/sysreg.h
> > +++ b/arch/arm64/include/asm/sysreg.h
> > @@ -672,6 +672,10 @@
> >  #define ID_AA64DFR0_TRACEVER_SHIFT	4
> >  #define ID_AA64DFR0_DEBUGVER_SHIFT	0
> >  
> > +#define ID_DFR0_PERFMON_SHIFT		24
> > +
> > +#define ID_DFR0_EL1_PMUVER_8_4		5
> > +
> >  #define ID_ISAR5_RDM_SHIFT		24
> >  #define ID_ISAR5_CRC32_SHIFT		16
> >  #define ID_ISAR5_SHA2_SHIFT		12
> > diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> > index 9f2165937f7d..61b984d934d1 100644
> > --- a/arch/arm64/kvm/sys_regs.c
> > +++ b/arch/arm64/kvm/sys_regs.c
> > @@ -668,6 +668,37 @@ static bool pmu_access_event_counter_el0_disabled(struct kvm_vcpu *vcpu)
> >  	return check_pmu_access_disabled(vcpu, ARMV8_PMU_USERENR_ER | ARMV8_PMU_USERENR_EN);
> >  }
> >  
> > +static bool access_id_aa64dfr0_el1(struct kvm_vcpu *vcpu,
> > +				   struct sys_reg_params *p,
> > +				   const struct sys_reg_desc *rd)
> > +{
> > +	if (p->is_write)
> > +		return write_to_read_only(vcpu, p, rd);
> > +
> > +	/* Limit guests to PMUv3 for ARMv8.4 */
> > +	p->regval = read_sanitised_ftr_reg(SYS_ID_AA64DFR0_EL1);
> > +	p->regval = cpuid_feature_cap_signed_field_width(p->regval,
> > +						ID_AA64DFR0_PMUVER_SHIFT,
> > +						4, ID_DFR0_EL1_PMUVER_8_4);
> 
> nit: I'd probably have a separate define for the field value of the 64-bit
> register, since there's no guarantee other values will be encoded the same
> way. (i.e. add ID_AA64DFR0_PMUVER_8_4 as well).

Yes that seems reasonable, i'll update it.

> 
> > +
> > +	return p->regval;
> > +}
> > +
> > +static bool access_id_dfr0_el1(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
> > +			       const struct sys_reg_desc *rd)
> > +{
> > +	if (p->is_write)
> > +		return write_to_read_only(vcpu, p, rd);
> > +
> > +	/* Limit guests to PMUv3 for ARMv8.4 */
> > +	p->regval = read_sanitised_ftr_reg(SYS_ID_DFR0_EL1);
> > +	p->regval = cpuid_feature_cap_signed_field_width(p->regval,
> 
> You could just return the result here (same above).

Or perhaps a bool - sigh.

Thanks,

Andrew Murray

> 
> Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
