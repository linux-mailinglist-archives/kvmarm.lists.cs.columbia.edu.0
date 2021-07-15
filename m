Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id ED7C83C9E05
	for <lists+kvmarm@lfdr.de>; Thu, 15 Jul 2021 13:52:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 778754B099;
	Thu, 15 Jul 2021 07:52:00 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a1EjeHRQMc0H; Thu, 15 Jul 2021 07:52:00 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 268E84A522;
	Thu, 15 Jul 2021 07:51:59 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 92F354A17F
 for <kvmarm@lists.cs.columbia.edu>; Thu, 15 Jul 2021 07:51:57 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tx4EeT3wZ1S4 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 15 Jul 2021 07:51:56 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 488714A003
 for <kvmarm@lists.cs.columbia.edu>; Thu, 15 Jul 2021 07:51:56 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B6FD31B;
 Thu, 15 Jul 2021 04:51:55 -0700 (PDT)
Received: from [10.57.36.240] (unknown [10.57.36.240])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 419113F694;
 Thu, 15 Jul 2021 04:51:54 -0700 (PDT)
Subject: Re: [PATCH 1/3] KVM: arm64: Narrow PMU sysreg reset values to
 architectural requirements
To: Marc Zyngier <maz@kernel.org>, Alexandru Elisei <alexandru.elisei@arm.com>
References: <20210713135900.1473057-1-maz@kernel.org>
 <20210713135900.1473057-2-maz@kernel.org>
 <ae510501-0410-47b1-77f3-cb83d3b1fa9e@arm.com> <87mtqnkf1w.wl-maz@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <daf4c8a9-8873-276d-ff15-b2812ed7f1e1@arm.com>
Date: Thu, 15 Jul 2021 12:51:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87mtqnkf1w.wl-maz@kernel.org>
Content-Language: en-GB
Cc: kvm@vger.kernel.org, kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
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

On 2021-07-15 12:11, Marc Zyngier wrote:
> Hi Alex,
> 
> On Wed, 14 Jul 2021 16:48:07 +0100,
> Alexandru Elisei <alexandru.elisei@arm.com> wrote:
>>
>> Hi Marc,
>>
>> On 7/13/21 2:58 PM, Marc Zyngier wrote:
>>> A number of the PMU sysregs expose reset values that are not in
>>> compliant with the architecture (set bits in the RES0 ranges,
>>> for example).
>>>
>>> This in turn has the effect that we need to pointlessly mask
>>> some register when using them.
>>>
>>> Let's start by making sure we don't have illegal values in the
>>> shadow registers at reset time. This affects all the registers
>>> that dedicate one bit per counter, the counters themselves,
>>> PMEVTYPERn_EL0 and PMSELR_EL0.
>>>
>>> Reported-by: Alexandre Chartre <alexandre.chartre@oracle.com>
>>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>>> ---
>>>   arch/arm64/kvm/sys_regs.c | 46 ++++++++++++++++++++++++++++++++++++---
>>>   1 file changed, 43 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>>> index f6f126eb6ac1..95ccb8f45409 100644
>>> --- a/arch/arm64/kvm/sys_regs.c
>>> +++ b/arch/arm64/kvm/sys_regs.c
>>> @@ -603,6 +603,44 @@ static unsigned int pmu_visibility(const struct kvm_vcpu *vcpu,
>>>   	return REG_HIDDEN;
>>>   }
>>>   
>>> +static void reset_pmu_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
>>> +{
>>> +	u64 n, mask;
>>> +
>>> +	/* No PMU available, any PMU reg may UNDEF... */
>>> +	if (!kvm_arm_support_pmu_v3())
>>> +		return;
>>> +
>>> +	n = read_sysreg(pmcr_el0) >> ARMV8_PMU_PMCR_N_SHIFT;
>>
>> Isn't this going to cause a lot of unnecessary traps with NV? Is
>> that going to be a problem?
> 
> We'll get a new traps at L2 VM creation if we expose a PMU to the L1
> guest, and if L2 gets one too. I don't think that's a real problem, as
> the performance of an L2 PMU is bound to be hilarious, and if we are
> really worried about that, we can always cache it locally. Which is
> likely the best thing to do if you think of big-little.
> 
> Let's not think of big-little.
> 
> Another thing is that we could perfectly ignore the number of counter
> on the host and always expose the architectural maximum, given that
> the PMU is completely emulated. With that, no trap.

Although that would deliberately exacerbate the existing problem of 
guest counters mysteriously under-reporting due to the host event 
getting multiplexed, thus arguably make the L2 PMU even less useful.

But then trying to analyse application performance under NV at all seems 
to stand a high chance of being akin to shovelling fog, so...

Robin.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
