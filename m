Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4596B162D42
	for <lists+kvmarm@lfdr.de>; Tue, 18 Feb 2020 18:43:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EDF304AF51;
	Tue, 18 Feb 2020 12:43:56 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aKd7Ur3-E5NA; Tue, 18 Feb 2020 12:43:56 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E15084AF22;
	Tue, 18 Feb 2020 12:43:55 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B39374AEE0
 for <kvmarm@lists.cs.columbia.edu>; Tue, 18 Feb 2020 12:43:54 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9QM6Hia-JTLY for <kvmarm@lists.cs.columbia.edu>;
 Tue, 18 Feb 2020 12:43:53 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 91AAD4AF0F
 for <kvmarm@lists.cs.columbia.edu>; Tue, 18 Feb 2020 12:43:53 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09773FEC;
 Tue, 18 Feb 2020 09:43:53 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 24E873F703;
 Tue, 18 Feb 2020 09:43:52 -0800 (PST)
Subject: Re: [PATCH 3/5] kvm: arm64: Limit PMU version to ARMv8.1
To: Marc Zyngier <maz@kernel.org>
References: <20200216185324.32596-1-maz@kernel.org>
 <20200216185324.32596-4-maz@kernel.org>
From: James Morse <james.morse@arm.com>
Message-ID: <eb0294ef-5ad2-9940-2d59-b92220948ffc@arm.com>
Date: Tue, 18 Feb 2020 17:43:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200216185324.32596-4-maz@kernel.org>
Content-Language: en-GB
Cc: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu
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

On 16/02/2020 18:53, Marc Zyngier wrote:
> Our PMU code is only implementing the ARMv8.1 features, so let's
> stick to this when reporting the feature set to the guest.

> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 682fedd7700f..06b2d0dc6c73 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -1093,6 +1093,11 @@ static u64 read_id_reg(const struct kvm_vcpu *vcpu,
>  				 FEATURE(ID_AA64ISAR1_GPA) |
>  				 FEATURE(ID_AA64ISAR1_GPI));
>  		break;
> +	case SYS_ID_AA64DFR0_EL1:
> +		/* Limit PMU to ARMv8.1 */

Not just limit, but upgrade too! (force?)
This looks safe because ARMV8_PMU_EVTYPE_EVENT always includes the extra bits this added,
and the register is always trapped.


The PMU version is also readable via ID_DFR0_EL1.PerfMon, should that be sanitised to be
the same?
(I don't think we've hidden an aarch64 feature that also existed in aarch32 before).


Regardless:
Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James



> +		val &= ~FEATURE(ID_AA64DFR0_PMUVER);
> +		val |= FIELD_PREP(FEATURE(ID_AA64DFR0_PMUVER), 4);
> +		break;
>  	}
>  
>  	return val;
> 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
