Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C32091B46D0
	for <lists+kvmarm@lfdr.de>; Wed, 22 Apr 2020 16:07:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3CBB14B17A;
	Wed, 22 Apr 2020 10:07:14 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id el+UoJZk3y20; Wed, 22 Apr 2020 10:07:14 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E8D2D4B16D;
	Wed, 22 Apr 2020 10:07:12 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D53544B0E2
 for <kvmarm@lists.cs.columbia.edu>; Wed, 22 Apr 2020 10:07:11 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H8n3-bbhKP7n for <kvmarm@lists.cs.columbia.edu>;
 Wed, 22 Apr 2020 10:07:10 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9FBC84B0C2
 for <kvmarm@lists.cs.columbia.edu>; Wed, 22 Apr 2020 10:07:10 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8AC872077D;
 Wed, 22 Apr 2020 14:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587564429;
 bh=Ydp+HSH/1XyIOqk56Lxy/+GbC3ZFcSR/6FAxFaOb2nE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=EWkwFwctcOsyKFAI4n3DUjoRKEcuGfrIPU1mkoPdOKoq2TumxieGGmxsVfD0oyIqx
 e1r7FYq431lQ0W1VuL/4HzGIyXPrwgvkYs2Z9wzfGIicm/6FDWagx+VP6GyMYxtjUg
 pdqiZH9Zao4SigAhHAe2MXe0HVND6s3Nbo5s8czI=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jRG1r-005WqO-UF; Wed, 22 Apr 2020 15:07:08 +0100
MIME-Version: 1.0
Date: Wed, 22 Apr 2020 15:07:07 +0100
From: Marc Zyngier <maz@kernel.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH 01/26] KVM: arm64: Check advertised Stage-2 page size
 capability
In-Reply-To: <32cc9a60-1b47-f3f7-d18d-d39db397ea55@arm.com>
References: <20200422120050.3693593-1-maz@kernel.org>
 <20200422120050.3693593-2-maz@kernel.org>
 <32cc9a60-1b47-f3f7-d18d-d39db397ea55@arm.com>
Message-ID: <06c3b2c9b23beeeb224d263077299039@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: suzuki.poulose@arm.com, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, andre.przywara@arm.com,
 christoffer.dall@arm.com, dave.martin@arm.com, jintack@cs.columbia.edu,
 alexandru.elisei@arm.com, gcherian@marvell.com, prime.zeng@hisilicon.com,
 will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
 james.morse@arm.com, julien.thierry.kdev@gmail.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, andre.przywara@arm.com, kvmarm@lists.cs.columbia.edu,
 will@kernel.org, gcherian@marvell.com, prime.zeng@hisilicon.com,
 catalin.marinas@arm.com, dave.martin@arm.com,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

Hi Suzuki,

On 2020-04-22 14:40, Suzuki K Poulose wrote:
> Hi Marc,
> 
> On 04/22/2020 01:00 PM, Marc Zyngier wrote:
>> With ARMv8.5-GTG, the hardware (or more likely a hypervisor) can
>> advertise the supported Stage-2 page sizes.
>> 
>> Let's check this at boot time.
>> 
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> ---
>>   arch/arm64/include/asm/kvm_host.h |  2 +-
>>   arch/arm64/include/asm/sysreg.h   |  3 +++
>>   arch/arm64/kernel/cpufeature.c    |  8 +++++++
>>   arch/arm64/kvm/reset.c            | 40 
>> ++++++++++++++++++++++++++++---
>>   virt/kvm/arm/arm.c                |  4 +---
>>   5 files changed, 50 insertions(+), 7 deletions(-)
>> 
>> diff --git a/arch/arm64/include/asm/kvm_host.h 
>> b/arch/arm64/include/asm/kvm_host.h
>> index 32c8a675e5a4a..7dd8fefa6aecd 100644
>> --- a/arch/arm64/include/asm/kvm_host.h
>> +++ b/arch/arm64/include/asm/kvm_host.h
>> @@ -670,7 +670,7 @@ static inline int kvm_arm_have_ssbd(void)
>>   void kvm_vcpu_load_sysregs(struct kvm_vcpu *vcpu);
>>   void kvm_vcpu_put_sysregs(struct kvm_vcpu *vcpu);
>>   -void kvm_set_ipa_limit(void);
>> +int kvm_set_ipa_limit(void);
>>     #define __KVM_HAVE_ARCH_VM_ALLOC
>>   struct kvm *kvm_arch_alloc_vm(void);
>> diff --git a/arch/arm64/include/asm/sysreg.h 
>> b/arch/arm64/include/asm/sysreg.h
>> index ebc6224328318..5d10c9148e844 100644
>> --- a/arch/arm64/include/asm/sysreg.h
>> +++ b/arch/arm64/include/asm/sysreg.h
>> @@ -686,6 +686,9 @@
>>   #define ID_AA64ZFR0_SVEVER_SVE2		0x1
>>     /* id_aa64mmfr0 */
>> +#define ID_AA64MMFR0_TGRAN4_2_SHIFT	40
>> +#define ID_AA64MMFR0_TGRAN64_2_SHIFT	36
>> +#define ID_AA64MMFR0_TGRAN16_2_SHIFT	32
>>   #define ID_AA64MMFR0_TGRAN4_SHIFT	28
>>   #define ID_AA64MMFR0_TGRAN64_SHIFT	24
>>   #define ID_AA64MMFR0_TGRAN16_SHIFT	20
>> diff --git a/arch/arm64/kernel/cpufeature.c 
>> b/arch/arm64/kernel/cpufeature.c
>> index 9fac745aa7bb2..9892a845d06c9 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -208,6 +208,14 @@ static const struct arm64_ftr_bits 
>> ftr_id_aa64zfr0[] = {
>>   };
>>     static const struct arm64_ftr_bits ftr_id_aa64mmfr0[] = {
>> +	/*
>> +	 * Page size not being supported at Stage-2 are not fatal. You
>> +	 * just give up KVM if PAGE_SIZE isn't supported there. Go fix
>> +	 * your favourite nesting hypervisor.
>> +	 */
>> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_EXACT, 
>> ID_AA64MMFR0_TGRAN4_2_SHIFT, 4, 1),
>> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_EXACT, 
>> ID_AA64MMFR0_TGRAN64_2_SHIFT, 4, 1),
>> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_EXACT, 
>> ID_AA64MMFR0_TGRAN16_2_SHIFT, 4, 1),
> 
> One minor issue with this is, if we get a system with cpus having 
> values
> 0 and 2 (both of which indicates the stage-2 support), we might reset
> the value to 1 for the feature indicating, we don't support and block
> KVM. But, we can blame the nesting hypervisor for not emulating this to
> (2). Do we need a comment to make this explicit here ?

Sure. How about something like:

"There is a small corner case where the hypervisor could explicitly 
advertise
  a given granule size at Stage-2 (value 2) on some vCPUs, and use the 
fallback
  to Stage-1 (value 0) for other vCPUs. Although this is not forbidden by 
the
  architecture, it indicates that the hypervisor is being silly (or 
buggy).
  We make no effort to cope with this and pretend that if these fields 
are
  inconsistent across vCPUs, then it isn't worth trying to bring KVM up."

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
