Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id AB436162D49
	for <lists+kvmarm@lfdr.de>; Tue, 18 Feb 2020 18:45:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4725F4AF4A;
	Tue, 18 Feb 2020 12:45:20 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gk+46KSdPgCe; Tue, 18 Feb 2020 12:45:20 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2C1414AF28;
	Tue, 18 Feb 2020 12:45:19 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BAECC4AF17
 for <kvmarm@lists.cs.columbia.edu>; Tue, 18 Feb 2020 12:45:17 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TsTkWN3uQmZd for <kvmarm@lists.cs.columbia.edu>;
 Tue, 18 Feb 2020 12:45:16 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A91544AEE0
 for <kvmarm@lists.cs.columbia.edu>; Tue, 18 Feb 2020 12:45:16 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5BDEF31B;
 Tue, 18 Feb 2020 09:45:16 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7102C3F703;
 Tue, 18 Feb 2020 09:45:15 -0800 (PST)
Subject: Re: [PATCH 4/5] KVM: arm64: Limit the debug architecture to ARMv8.0
To: Marc Zyngier <maz@kernel.org>
References: <20200216185324.32596-1-maz@kernel.org>
 <20200216185324.32596-5-maz@kernel.org>
From: James Morse <james.morse@arm.com>
Message-ID: <37f71ccb-2c3c-5c7c-ef26-0dfdaf4e52a3@arm.com>
Date: Tue, 18 Feb 2020 17:45:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200216185324.32596-5-maz@kernel.org>
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
> Let's not pretend we support anything but ARMv8.0 as far as the
> debug architecture is concerned.

(what happens for features that disappeared?)

For v8.0 the 'OS Double Lock' was mandatory. With v8.2 it became optional, and
not-implemented with v8.3.

The guest can see whether its implemented in ID_AA64DFR0_EL1. (and its 32bit friends)
Previously these values would have at least matched, even though KVM implements it as
RAZ/WI (which is the not-implemented behaviour).


Would anyone care that these are inconsistent?
(I've never had a solid grasp of how these debug 'lock' registers are supposed to be used).


Thanks,

James


> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 06b2d0dc6c73..43087b50a211 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -1094,6 +1094,9 @@ static u64 read_id_reg(const struct kvm_vcpu *vcpu,
>  				 FEATURE(ID_AA64ISAR1_GPI));
>  		break;
>  	case SYS_ID_AA64DFR0_EL1:
> +		/* Limit debug to ARMv8.0 */
> +		val &= ~FEATURE(ID_AA64DFR0_DEBUGVER);
> +		val |= FIELD_PREP(FEATURE(ID_AA64DFR0_DEBUGVER), 6);
>  		/* Limit PMU to ARMv8.1 */
>  		val &= ~FEATURE(ID_AA64DFR0_PMUVER);
>  		val |= FIELD_PREP(FEATURE(ID_AA64DFR0_PMUVER), 4);
> 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
