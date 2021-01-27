Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3A65130624D
	for <lists+kvmarm@lfdr.de>; Wed, 27 Jan 2021 18:42:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 831794B11D;
	Wed, 27 Jan 2021 12:42:24 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RHCMM2mzF96B; Wed, 27 Jan 2021 12:42:24 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 32B944B121;
	Wed, 27 Jan 2021 12:42:23 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A78EC4B10C
 for <kvmarm@lists.cs.columbia.edu>; Wed, 27 Jan 2021 12:42:21 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qt0Li5AUE7fC for <kvmarm@lists.cs.columbia.edu>;
 Wed, 27 Jan 2021 12:42:20 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 60FC94B0DD
 for <kvmarm@lists.cs.columbia.edu>; Wed, 27 Jan 2021 12:42:20 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBBE11FB;
 Wed, 27 Jan 2021 09:42:19 -0800 (PST)
Received: from [192.168.0.110] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA2D63F66E;
 Wed, 27 Jan 2021 09:42:18 -0800 (PST)
Subject: Re: [PATCH v2 6/7] KVM: arm64: Upgrade PMU support to ARMv8.4
To: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org
References: <20210125122638.2947058-1-maz@kernel.org>
 <20210125122638.2947058-7-maz@kernel.org>
From: Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <680c2e4f-cc9f-10c1-1158-7de32057fb0d@arm.com>
Date: Wed, 27 Jan 2021 17:41:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210125122638.2947058-7-maz@kernel.org>
Content-Language: en-US
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

Had another look at the patch, comments below.

On 1/25/21 12:26 PM, Marc Zyngier wrote:
> Upgrading the PMU code from ARMv8.1 to ARMv8.4 turns out to be
> pretty easy. All that is required is support for PMMIR_EL1, which
> is read-only, and for which returning 0 is a valid option as long
> as we don't advertise STALL_SLOT as an implemented event.
>
> Let's just do that and adjust what we return to the guest.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/include/asm/sysreg.h |  3 +++
>  arch/arm64/kvm/pmu-emul.c       |  6 ++++++
>  arch/arm64/kvm/sys_regs.c       | 11 +++++++----
>  3 files changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 8b5e7e5c3cc8..2fb3f386588c 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -846,7 +846,10 @@
>  
>  #define ID_DFR0_PERFMON_SHIFT		24
>  
> +#define ID_DFR0_PERFMON_8_0		0x3
>  #define ID_DFR0_PERFMON_8_1		0x4
> +#define ID_DFR0_PERFMON_8_4		0x5
> +#define ID_DFR0_PERFMON_8_5		0x6
>  
>  #define ID_ISAR4_SWP_FRAC_SHIFT		28
>  #define ID_ISAR4_PSR_M_SHIFT		24
> diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
> index 398f6df1bbe4..72cd704a8368 100644
> --- a/arch/arm64/kvm/pmu-emul.c
> +++ b/arch/arm64/kvm/pmu-emul.c
> @@ -795,6 +795,12 @@ u64 kvm_pmu_get_pmceid(struct kvm_vcpu *vcpu, bool pmceid1)
>  		base = 0;
>  	} else {
>  		val = read_sysreg(pmceid1_el0);
> +		/*
> +		 * Don't advertise STALL_SLOT, as PMMIR_EL0 is handled
> +		 * as RAZ
> +		 */
> +		if (vcpu->kvm->arch.pmuver >= ID_AA64DFR0_PMUVER_8_4)
> +			val &= ~BIT_ULL(ARMV8_PMUV3_PERFCTR_STALL_SLOT - 32);

This is confusing the me. We have kvm->arch.pmuver set to the hardware PMU version
(as set by __armv8pmu_probe_pmu()), but we ignore it when reporting the PMU
version to the guest. Why do we do that? We limit the event number in
kvm_pmu_event_mask() based on the hardware PMU version, so even if we advertise
Armv8.4 PMU, support for all those extra events added by Arm8.1 PMU is missing (I
hope I understood the code correctly).

I looked at commit c854188ea010 ("KVM: arm64: limit PMU version to PMUv3 for
ARMv8.1") which changed read_id_reg() to report PMUv3 for Armv8.1 unconditionally,
and there's no explanation why PMUv3 for Armv8.1 was chosen instead of plain PMUv3
(PMUVer = 0b0100).

Thanks,

Alex

>  		base = 32;
>  	}
>  
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 8f79ec1fffa7..5da536ab738d 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -1051,16 +1051,16 @@ static u64 read_id_reg(const struct kvm_vcpu *vcpu,
>  		/* Limit debug to ARMv8.0 */
>  		val &= ~FEATURE(ID_AA64DFR0_DEBUGVER);
>  		val |= FIELD_PREP(FEATURE(ID_AA64DFR0_DEBUGVER), 6);
> -		/* Limit guests to PMUv3 for ARMv8.1 */
> +		/* Limit guests to PMUv3 for ARMv8.4 */
>  		val = cpuid_feature_cap_perfmon_field(val,
>  						      ID_AA64DFR0_PMUVER_SHIFT,
> -						      kvm_vcpu_has_pmu(vcpu) ? ID_AA64DFR0_PMUVER_8_1 : 0);
> +						      kvm_vcpu_has_pmu(vcpu) ? ID_AA64DFR0_PMUVER_8_4 : 0);
>  		break;
>  	case SYS_ID_DFR0_EL1:
> -		/* Limit guests to PMUv3 for ARMv8.1 */
> +		/* Limit guests to PMUv3 for ARMv8.4 */
>  		val = cpuid_feature_cap_perfmon_field(val,
>  						      ID_DFR0_PERFMON_SHIFT,
> -						      kvm_vcpu_has_pmu(vcpu) ? ID_DFR0_PERFMON_8_1 : 0);
> +						      kvm_vcpu_has_pmu(vcpu) ? ID_DFR0_PERFMON_8_4 : 0);
>  		break;
>  	}
>  
> @@ -1496,6 +1496,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>  
>  	{ SYS_DESC(SYS_PMINTENSET_EL1), access_pminten, reset_unknown, PMINTENSET_EL1 },
>  	{ SYS_DESC(SYS_PMINTENCLR_EL1), access_pminten, reset_unknown, PMINTENSET_EL1 },
> +	{ SYS_DESC(SYS_PMMIR_EL1), trap_raz_wi },
>  
>  	{ SYS_DESC(SYS_MAIR_EL1), access_vm_reg, reset_unknown, MAIR_EL1 },
>  	{ SYS_DESC(SYS_AMAIR_EL1), access_vm_reg, reset_amair_el1, AMAIR_EL1 },
> @@ -1918,6 +1919,8 @@ static const struct sys_reg_desc cp15_regs[] = {
>  	{ Op1( 0), CRn( 9), CRm(14), Op2( 3), access_pmovs },
>  	{ AA32(HI), Op1( 0), CRn( 9), CRm(14), Op2( 4), access_pmceid },
>  	{ AA32(HI), Op1( 0), CRn( 9), CRm(14), Op2( 5), access_pmceid },
> +	/* PMMIR */
> +	{ Op1( 0), CRn( 9), CRm(14), Op2( 6), trap_raz_wi },
>  
>  	/* PRRR/MAIR0 */
>  	{ AA32(LO), Op1( 0), CRn(10), CRm( 2), Op2( 0), access_vm_reg, NULL, MAIR_EL1 },
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
