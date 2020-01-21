Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E52CF143BF3
	for <lists+kvmarm@lfdr.de>; Tue, 21 Jan 2020 12:25:06 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 67B6E4AFD0;
	Tue, 21 Jan 2020 06:25:06 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.099
X-Spam-Level: 
X-Spam-Status: No, score=0.099 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_LOW=-0.7]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c+F0vGikkyKn; Tue, 21 Jan 2020 06:25:06 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D576A4AFD9;
	Tue, 21 Jan 2020 06:25:01 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9CB094ACD6
 for <kvmarm@lists.cs.columbia.edu>; Tue, 21 Jan 2020 06:25:00 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D5ao-by4a6Af for <kvmarm@lists.cs.columbia.edu>;
 Tue, 21 Jan 2020 06:24:55 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4B2D84AFEC
 for <kvmarm@lists.cs.columbia.edu>; Tue, 21 Jan 2020 06:24:55 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9EB61FB;
 Tue, 21 Jan 2020 03:24:54 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E0E13F6C4;
 Tue, 21 Jan 2020 03:24:54 -0800 (PST)
Date: Tue, 21 Jan 2020 11:24:52 +0000
From: Andrew Murray <andrew.murray@arm.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v3 2/3] KVM: arm64: limit PMU version to ARMv8.4
Message-ID: <20200121112452.GB5109@e119886-lin.cambridge.arm.com>
References: <20200102123905.29360-1-andrew.murray@arm.com>
 <20200102123905.29360-3-andrew.murray@arm.com>
 <336acb6b88c2df5e6114e6f8811687e4@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <336acb6b88c2df5e6114e6f8811687e4@kernel.org>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
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

On Mon, Jan 20, 2020 at 05:55:17PM +0000, Marc Zyngier wrote:
> On 2020-01-02 12:39, Andrew Murray wrote:
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
> > 
> > diff --git a/arch/arm64/include/asm/sysreg.h
> > b/arch/arm64/include/asm/sysreg.h
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
> > @@ -668,6 +668,37 @@ static bool
> > pmu_access_event_counter_el0_disabled(struct kvm_vcpu *vcpu)
> >  	return check_pmu_access_disabled(vcpu, ARMV8_PMU_USERENR_ER |
> > ARMV8_PMU_USERENR_EN);
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
> > +
> > +	return p->regval;
> 
> If feels very odd to return the register value in place of a something
> that actually indicates whether we should update the PC or not. I have
> no idea what is happening here in this case.

This should have returned true. I have no idea why I did this.


> 
> > +}
> > +
> > +static bool access_id_dfr0_el1(struct kvm_vcpu *vcpu, struct
> > sys_reg_params *p,
> > +			       const struct sys_reg_desc *rd)
> > +{
> > +	if (p->is_write)
> > +		return write_to_read_only(vcpu, p, rd);
> > +
> > +	/* Limit guests to PMUv3 for ARMv8.4 */
> > +	p->regval = read_sanitised_ftr_reg(SYS_ID_DFR0_EL1);
> > +	p->regval = cpuid_feature_cap_signed_field_width(p->regval,
> > +						ID_DFR0_PERFMON_SHIFT,
> > +						4, ID_DFR0_EL1_PMUVER_8_4);
> > +
> > +	return p->regval;
> 
> Same here.
> 
> > +}
> > +
> >  static bool access_pmcr(struct kvm_vcpu *vcpu, struct sys_reg_params
> > *p,
> >  			const struct sys_reg_desc *r)
> >  {
> > @@ -1409,7 +1440,8 @@ static const struct sys_reg_desc sys_reg_descs[] =
> > {
> >  	/* CRm=1 */
> >  	ID_SANITISED(ID_PFR0_EL1),
> >  	ID_SANITISED(ID_PFR1_EL1),
> > -	ID_SANITISED(ID_DFR0_EL1),
> > +	{ SYS_DESC(SYS_ID_DFR0_EL1), access_id_dfr0_el1 },
> 
> How about the .get_user and .set_user accessors that were provided by
> ID_SANITISED and that are now dropped? You should probably define a
> new wrapper that allows you to override the .access method.

Yes I can do that, thus ensuring we continue to return sanitised values
rather than the current vcpu value.

However should I also update read_id_reg - thus ensuring the host sees
the same value that the guest sees? (I see this already does something
similar with AA64PFR0 and AA64ISAR1).

Thanks,

Andrew Murray

> 
> > +
> >  	ID_HIDDEN(ID_AFR0_EL1),
> >  	ID_SANITISED(ID_MMFR0_EL1),
> >  	ID_SANITISED(ID_MMFR1_EL1),
> > @@ -1448,7 +1480,7 @@ static const struct sys_reg_desc sys_reg_descs[] =
> > {
> >  	ID_UNALLOCATED(4,7),
> > 
> >  	/* CRm=5 */
> > -	ID_SANITISED(ID_AA64DFR0_EL1),
> > +	{ SYS_DESC(SYS_ID_AA64DFR0_EL1), access_id_aa64dfr0_el1 },
> >  	ID_SANITISED(ID_AA64DFR1_EL1),
> >  	ID_UNALLOCATED(5,2),
> >  	ID_UNALLOCATED(5,3),
> 
> Thanks,
> 
>         M.
> -- 
> Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
