Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3E028173F72
	for <lists+kvmarm@lfdr.de>; Fri, 28 Feb 2020 19:22:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7F48D4AFFF;
	Fri, 28 Feb 2020 13:22:45 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FoKzUIk+-tWp; Fri, 28 Feb 2020 13:22:45 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 33ECA4AFEF;
	Fri, 28 Feb 2020 13:22:44 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 659CB4AFC3
 for <kvmarm@lists.cs.columbia.edu>; Fri, 28 Feb 2020 13:22:43 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ohV1n9s3qttC for <kvmarm@lists.cs.columbia.edu>;
 Fri, 28 Feb 2020 13:22:42 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 07EB54AFB7
 for <kvmarm@lists.cs.columbia.edu>; Fri, 28 Feb 2020 13:22:42 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AB1A31B;
 Fri, 28 Feb 2020 10:22:41 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 853F43F7B4;
 Fri, 28 Feb 2020 10:22:40 -0800 (PST)
Date: Fri, 28 Feb 2020 18:22:38 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Andrew Murray <andrew.murray@arm.com>
Subject: Re: [PATCH v5 2/3] KVM: arm64: limit PMU version to PMUv3 for ARMv8.1
Message-ID: <20200228182237.GM36089@lakrids.cambridge.arm.com>
References: <1580125469-23887-1-git-send-email-andrew.murray@arm.com>
 <1580125469-23887-3-git-send-email-andrew.murray@arm.com>
 <20200228165122.GL36089@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200228165122.GL36089@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 Marc Zyngier <maz@kernel.org>
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

On Fri, Feb 28, 2020 at 04:51:22PM +0000, Mark Rutland wrote:
> On Mon, Jan 27, 2020 at 11:44:28AM +0000, Andrew Murray wrote:
> > We currently expose the PMU version of the host to the guest via
> > emulation of the DFR0_EL1 and AA64DFR0_EL1 debug feature registers.
> > However many of the features offered beyond PMUv3 for 8.1 are not
> > supported in KVM. Examples of this include support for the PMMIR
> > registers (added in PMUv3 for ARMv8.4) and 64-bit event counters
> > added in (PMUv3 for ARMv8.5).
> > 
> > Let's trap the Debug Feature Registers in order to limit
> > PMUVer/PerfMon in the Debug Feature Registers to PMUv3 for ARMv8.1
> > to avoid unexpected behaviour.
> > 
> > Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> > ---
> >  arch/arm64/include/asm/sysreg.h |  5 +++++
> >  arch/arm64/kvm/sys_regs.c       | 11 +++++++++++
> >  2 files changed, 16 insertions(+)
> > 
> > diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> > index 6e919fa..1009878 100644
> > --- a/arch/arm64/include/asm/sysreg.h
> > +++ b/arch/arm64/include/asm/sysreg.h
> > @@ -672,6 +672,11 @@
> >  #define ID_AA64DFR0_TRACEVER_SHIFT	4
> >  #define ID_AA64DFR0_DEBUGVER_SHIFT	0
> >  
> > +#define ID_DFR0_PERFMON_SHIFT		24
> > +
> > +#define ID_DFR0_EL1_PMUVER_8_1		4
> > +#define ID_AA64DFR0_EL1_PMUVER_8_1	4
> > +
> >  #define ID_ISAR5_RDM_SHIFT		24
> >  #define ID_ISAR5_CRC32_SHIFT		16
> >  #define ID_ISAR5_SHA2_SHIFT		12
> > diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> > index 9f21659..3f0f3cc 100644
> > --- a/arch/arm64/kvm/sys_regs.c
> > +++ b/arch/arm64/kvm/sys_regs.c
> > @@ -1085,6 +1085,17 @@ static u64 read_id_reg(const struct kvm_vcpu *vcpu,
> >  			 (0xfUL << ID_AA64ISAR1_API_SHIFT) |
> >  			 (0xfUL << ID_AA64ISAR1_GPA_SHIFT) |
> >  			 (0xfUL << ID_AA64ISAR1_GPI_SHIFT));
> > +	} else if (id == SYS_ID_AA64DFR0_EL1) {
> > +		/* Limit guests to PMUv3 for ARMv8.1 */
> > +		val = cpuid_feature_cap_signed_field_width(val,
> > +						ID_AA64DFR0_PMUVER_SHIFT,
> > +						4, ID_AA64DFR0_EL1_PMUVER_8_1);
> > +	} else if (id == SYS_ID_DFR0_EL1) {
> > +		/* Limit guests to PMUv3 for ARMv8.1 */
> > +		val = cpuid_feature_cap_signed_field_width(val,
> > +						ID_DFR0_PERFMON_SHIFT,
> > +						4, ID_DFR0_EL1_PMUVER_8_1);
> > +
> 
> Unfortunately, ID_AA64DFR0_EL1.PMUVer and ID_DFR0_EL1.PerfMon don't
> follow the usual ID scheme, and cannot be treated as signed fields.
> 
> Per ARM DDI 0487E.a, page D13-2825, they follow an alternative scheme
> that is treated as unsigned, with 0xF additionally being treated as an
> architected PMU version not being implemented. For KVM we'll want to
> convert 0xF to 0x0.
> 
> I'll respin these patches accordingly.

I've pushed an updated series to:

https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64/pmu-8.5

Hopefully I'll get the chance to give that a go on ARMv8.{0,1} hardware
on Monday. I'm not sure how useful the PMU in FVPs is these days, so I'm
not sure how far I can test the ARMv8.5+ bits.

Thanks,
Mark.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
