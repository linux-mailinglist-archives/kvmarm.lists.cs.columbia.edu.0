Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7B62E3B7435
	for <lists+kvmarm@lfdr.de>; Tue, 29 Jun 2021 16:25:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EF6784A1A7;
	Tue, 29 Jun 2021 10:25:21 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AoCRpOtYJXYF; Tue, 29 Jun 2021 10:25:21 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 20AFA4A023;
	Tue, 29 Jun 2021 10:25:19 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CAEA149F92
 for <kvmarm@lists.cs.columbia.edu>; Tue, 29 Jun 2021 10:25:17 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bH4pQ7qryuCi for <kvmarm@lists.cs.columbia.edu>;
 Tue, 29 Jun 2021 10:25:16 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 6E39549DE3
 for <kvmarm@lists.cs.columbia.edu>; Tue, 29 Jun 2021 10:25:16 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5E74F61DB4;
 Tue, 29 Jun 2021 14:25:15 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1lyEfp-00AeMz-EN; Tue, 29 Jun 2021 15:25:13 +0100
MIME-Version: 1.0
Date: Tue, 29 Jun 2021 15:25:13 +0100
From: Marc Zyngier <maz@kernel.org>
To: Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: Re: [PATCH] KVM: arm64: Disabling disabled PMU counters wastes a lot
 of time
In-Reply-To: <abcbd6db-da75-a6ad-01f3-7c614172ebd4@oracle.com>
References: <20210628161925.401343-1-alexandre.chartre@oracle.com>
 <878s2tavks.wl-maz@kernel.org>
 <e3843c2c-e20a-ef58-c795-1ba8f1d91ff6@oracle.com>
 <877dicbx61.wl-maz@kernel.org>
 <abcbd6db-da75-a6ad-01f3-7c614172ebd4@oracle.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <62e6fa4693c87e7233642e7192344562@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: alexandre.chartre@oracle.com, will@kernel.org,
 catalin.marinas@arm.com, alexandru.elisei@arm.com, james.morse@arm.com,
 suzuki.poulose@arm.com, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, konrad.wilk@oracle.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, catalin.marinas@arm.com, konrad.wilk@oracle.com,
 will@kernel.org, kvmarm@lists.cs.columbia.edu,
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

On 2021-06-29 15:17, Alexandre Chartre wrote:
> On 6/29/21 3:47 PM, Marc Zyngier wrote:
>> On Tue, 29 Jun 2021 14:16:55 +0100,
>> Alexandre Chartre <alexandre.chartre@oracle.com> wrote:
>>> 
>>> 
>>> Hi Marc,
>>> 
>>> On 6/29/21 11:06 AM, Marc Zyngier wrote:
>>>> Hi Alexandre,
>> 
>> [...]
>> 
>>>> So the sysreg is the only thing we should consider, and I think we
>>>> should drop the useless masking. There is at least another instance 
>>>> of
>>>> this in the PMU code (kvm_pmu_overflow_status()), and apart from
>>>> kvm_pmu_vcpu_reset(), only the sysreg accessors should care about 
>>>> the
>>>> masking to sanitise accesses.
>>>> 
>>>> What do you think?
>>>> 
>>> 
>>> I think you are right. PMCNTENSET_EL0 is already masked with
>>> kvm_pmu_valid_counter_mask() so there's effectively no need to mask
>>> it again when we use it. I will send an additional patch (on top of
>>> this one) to remove useless masking. Basically, changes would be:
>>> 
>>> diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
>>> index bab4b735a0cf..e0dfd7ce4ba0 100644
>>> --- a/arch/arm64/kvm/pmu-emul.c
>>> +++ b/arch/arm64/kvm/pmu-emul.c
>>> @@ -373,7 +373,6 @@ static u64 kvm_pmu_overflow_status(struct 
>>> kvm_vcpu *vcpu)
>>>                  reg = __vcpu_sys_reg(vcpu, PMOVSSET_EL0);
>>>                  reg &= __vcpu_sys_reg(vcpu, PMCNTENSET_EL0);
>>>                  reg &= __vcpu_sys_reg(vcpu, PMINTENSET_EL1);
>>> -               reg &= kvm_pmu_valid_counter_mask(vcpu);
>>>          }
>>>           return reg;
>>> @@ -564,21 +563,22 @@ void kvm_pmu_software_increment(struct kvm_vcpu 
>>> *vcpu, u64 val)
>>>    */
>>>   void kvm_pmu_handle_pmcr(struct kvm_vcpu *vcpu, u64 val)
>>>   {
>>> -       unsigned long mask = kvm_pmu_valid_counter_mask(vcpu);
>>> +       unsigned long mask;
>>>          int i;
>>>           if (val & ARMV8_PMU_PMCR_E) {
>>>                  kvm_pmu_enable_counter_mask(vcpu,
>>> -                      __vcpu_sys_reg(vcpu, PMCNTENSET_EL0) & mask);
>>> +                      __vcpu_sys_reg(vcpu, PMCNTENSET_EL0));
>>>          } else {
>>>                  kvm_pmu_disable_counter_mask(vcpu,
>>> -                      __vcpu_sys_reg(vcpu, PMCNTENSET_EL0) & mask);
>>> +                      __vcpu_sys_reg(vcpu, PMCNTENSET_EL0));
>>>          }
>>>           if (val & ARMV8_PMU_PMCR_C)
>>>                  kvm_pmu_set_counter_value(vcpu, ARMV8_PMU_CYCLE_IDX, 
>>> 0);
>>>           if (val & ARMV8_PMU_PMCR_P) {
>>> +               mask = kvm_pmu_valid_counter_mask(vcpu);
>> 
>> Careful here, this clashes with a fix from Alexandru that is currently
>> in -next (PMCR_EL0.P shouldn't reset the cycle counter) and aimed at
>> 5.14. And whilst you're at it, consider moving the 'mask' declaration
>> here too.
>> 
>>>                  for_each_set_bit(i, &mask, 32)
>>>                          kvm_pmu_set_counter_value(vcpu, i, 0);
>>>          }
>>> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>>> index 1a7968ad078c..2e406905760e 100644
>>> --- a/arch/arm64/kvm/sys_regs.c
>>> +++ b/arch/arm64/kvm/sys_regs.c
>>> @@ -845,7 +845,7 @@ static bool access_pmcnten(struct kvm_vcpu *vcpu, 
>>> struct sys_reg_params *p,
>>>                          kvm_pmu_disable_counter_mask(vcpu, val);
>>>                  }
>>>          } else {
>>> -               p->regval = __vcpu_sys_reg(vcpu, PMCNTENSET_EL0) & 
>>> mask;
>>> +               p->regval = __vcpu_sys_reg(vcpu, PMCNTENSET_EL0);
>>>          }
>>>           return true;
>> 
>> If you are cleaning up the read-side of sysregs, access_pminten() and
>> access_pmovs() could have some of your attention too.
>> 
> 
> Ok, so for now, I will just resubmit the initial patch with the commit
> comment fixes. Then, look at all the mask cleanup on top of Alexandru
> changes and prepare another patch.

Please send this as a series rather than individual patches. I'm only
queuing critical fixes at the moment (this is the merge window).
If you post the series after -rc1, I'll queue it and let it simmer
in -next.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
