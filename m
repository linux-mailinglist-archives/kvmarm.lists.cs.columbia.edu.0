Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 20CEB3062B0
	for <lists+kvmarm@lfdr.de>; Wed, 27 Jan 2021 18:53:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9FE414B378;
	Wed, 27 Jan 2021 12:53:36 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MSe9OxOh+Q60; Wed, 27 Jan 2021 12:53:36 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 633144B37A;
	Wed, 27 Jan 2021 12:53:35 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C3D394B375
 for <kvmarm@lists.cs.columbia.edu>; Wed, 27 Jan 2021 12:53:34 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9Maa3RsUPv9W for <kvmarm@lists.cs.columbia.edu>;
 Wed, 27 Jan 2021 12:53:33 -0500 (EST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D7EA94B2EC
 for <kvmarm@lists.cs.columbia.edu>; Wed, 27 Jan 2021 12:53:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611770013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gs9byxXxo31pA4w9DE/K2vaqzS8xJ0Ib6K2RN5jnLMA=;
 b=a50hDi04xAIz3Xn3RFJ7XHPgS+U8mrrJ34o3/rigsVr2ZgYRhUsyEz02eB8ZxFu+lC4yrH
 4Vy+vl7pvOwBjB+Ac1Sq+A5rRXELCS8StUITwg5Krp+wVx9uKsjroX+5YGNeI3QgsOOY1T
 bsdOKlQwO7f38XxS/nqzgcmbOeGLZMg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-SIok_f7_N8iL113M3FlO1w-1; Wed, 27 Jan 2021 12:53:31 -0500
X-MC-Unique: SIok_f7_N8iL113M3FlO1w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2FE4C190A7A2;
 Wed, 27 Jan 2021 17:53:29 +0000 (UTC)
Received: from [10.36.113.217] (ovpn-113-217.ams2.redhat.com [10.36.113.217])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CDFD06F940;
 Wed, 27 Jan 2021 17:53:25 +0000 (UTC)
Subject: Re: [PATCH v2 6/7] KVM: arm64: Upgrade PMU support to ARMv8.4
To: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org
References: <20210125122638.2947058-1-maz@kernel.org>
 <20210125122638.2947058-7-maz@kernel.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <56041147-0bd8-dbb2-d1ca-550f3db7f05d@redhat.com>
Date: Wed, 27 Jan 2021 18:53:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20210125122638.2947058-7-maz@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

On 1/25/21 1:26 PM, Marc Zyngier wrote:
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
what about the STALL_SLOT_BACKEND and FRONTEND events then?
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
"KVM: arm64: Hide PMU registers from userspace when not available"
changed the above, doesn't it?
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
> 
Thanks

Eric

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
